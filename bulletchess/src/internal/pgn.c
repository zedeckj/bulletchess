#include "pgn.h"


#define DEBUG_ON 0
#define debug_print(...) (DEBUG_ON && fprintf(stderr, __VA_ARGS__))
#define untoken(tok,ctx)\
(debug_print("untoken %s at %d in %s\n", tok->string, tok->location->line, tok->location->source_name), untoken(tok,ctx))
char *alloc_err(tok_context_t *ctx, const char *msg, token_t *tok) {
	char loc_str[500];
	char *err;
	if (tok) {
		debug_print("tok\n");
		debug_print("location is %p\n", tok->location); 
		debug_print("location line is %ld\n", tok->location->line);
		write_loc(tok->location, loc_str);
		debug_print("loc written\n");
		err = malloc(strlen(loc_str) + strlen(msg) + 100);
		debug_print("%p err\n", err);
		sprintf(err, "<%s>: Error When Parsing PGN: %s, got `%s`", 
			loc_str, msg, tok->string);
		free_token(tok);
	}
	else {
		debug_print("no tok\n");
		write_loc(&ctx->loc, loc_str);
		err = malloc(strlen(loc_str) + strlen(msg) + 100);
		sprintf(err, "<%s>: Error When Parsing PGN: %s", loc_str, msg);
	}
	debug_print("alloc error made\n");
	return err;
}


void strip_str(char *dst, char *src) {
	size_t len = strlen(src);
	if ((src[0] == '"' && src[len - 1] == '"')) {
		strcpy(dst, src + 1);
		dst[strlen(dst) - 1] = 0;
	}
}

dict_t *make_dst_dict(pgn_tag_section_t *tags, 
		char *fen, char *date, char *res) {
	dict_t *dict = new_dict(20);
	dict_add(dict, "Event", tags->event);
	dict_add(dict, "Site", tags->site);
	dict_add(dict, "Date", date);
	dict_add(dict, "Round", tags->round);
	dict_add(dict, "White", tags->white_player);
	dict_add(dict, "Black", tags->black_player);
	dict_add(dict, "Result", res);
	dict_add(dict, "FEN", fen);
	return dict;
}

// Wraps around ftoken to skip over commentary lines
token_t *pgntoken(FILE *stream, tok_context_t *ctx) {
	token_t *tok = ftoken(stream, ctx);
	if (tok) {
		if (tok->string[0] == ';') {
			size_t line = tok->location->line;	
			free_token(tok);
			for (;;) {
				tok = ftoken(stream, ctx);
				if (!tok) return tok;
				if (tok->location->line > line) {
					return tok;
				}
				free_token(tok);
			}
		}
	}
	return tok;
}

char *add_tag_pair(token_t *name, token_t *val, 
		dict_t *dest_dict, tok_context_t *ctx, dict_t *tok_dict){
	if (val && strlen(val->string) > 254)
		return alloc_err(ctx, 
				"Tag value is too long, must be at most 255 characters", val);
	char *ptr = dict_remove(dest_dict, name->string);
	if (ptr) { // Just ignore unknown tags
	  dict_add(tok_dict, name->string, val);
	  char scratch[255] = {0};
	  strncpy(scratch, val->string + 1, 254);
	  scratch[strlen(scratch) - 1] = 0;
	  strncpy(ptr, scratch, 255);
  }
	free_token(name);
	return 0;
}


char *read_tag_pair(FILE *stream, 
										tok_context_t *ctx, 
										dict_t* dest_dict, token_t *first,
										dict_t* tok_dict) {
		token_t *name = pgntoken(stream, ctx);
		if (name) {
			free_token(first);
			token_t *val = pgntoken(stream, ctx);
			if (!val) return alloc_err(ctx,"Missing value for tag pair", name);
			if (val->string[0] == '"') {
				token_t *last = pgntoken(stream, ctx);
				if (!last) {
					free_token(name);
					return alloc_err(ctx,"Tag pair missing ending ]", val);
				}
				else if (token_is(last, "]")) {
					return add_tag_pair(name, val, dest_dict, ctx, tok_dict); 
				}
				else {
					free_token(name);
					free_token(val);
					return alloc_err(ctx,"Tag pair missing ending ]", last);
				}
			}
			else {
				free_token(name);
				return alloc_err(ctx,"Tag value must be a string", val);
			}
		}
		else {
			return alloc_err(ctx,"No tag name given", first);
		}
}

void dict_free_toks(dict_t *dict) {
	void **values = dict_values(dict);
	for (size_t i = 0; i < dict->length; i++) {
		free_token(values[i]);
	}
	free(values);
}


// Ensures that tags exist by checking that they are no longer
// in the destination dictionary as keys
char *ensure_tags_exists(char **tags, dict_t *dest_dict, 
		tok_context_t *ctx) {
	char *out = 0;
	for (int i = 0; tags[i]; i++) {
		char *tag = tags[i];	
		void *tok = dict_remove(dest_dict, tag);
		if (tok) {
			char err[255];
			sprintf(err, "Missing tag pair for %s", tag);
			out = alloc_err(ctx, err, 0);
			break;
		}
	}
	dict_free(dest_dict);
	return out;
}

/*

// Retrieves tags from the dictionary of tags to tokens,
// checks if they are valid values, and parses into a new data
// type to put into the final pgn_game_t. If the tag value is missing
// or invalid, we use a default value for dates and results. 
// For FEN, an included but invalid FEN raises and error, as 
// using the default starting position is likely to cause a more
// confusing error down the road.
char *transform_tags(dict_t *tok_dict,
										dict_t *dest_dict,
										tok_context_t *ctx,
										pgn_game_t *dst,
										dict_t * res_dict) {
	token_t *fen_tok = dict_remove(tok_dict, "FEN");
	if (fen_tok) {
		char buff[255];
		strip_str(buff, fen_tok->string);
		char *fen_err = parse_fen(buff, 
				dst->starting_board);
		if (fen_err) {
			dict_free_toks(tok_dict);
			return alloc_err(ctx, fen_err, fen_tok);
		}
		free_token(fen_tok);
	}
	else {
		char fen[200];
		strcpy(fen,
			"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1");
		parse_fen(fen, dst->starting_board);
	}
	token_t *res_tok = dict_remove(tok_dict, "Result");
	if (res_tok) {
		u_int8_t *res = dict_lookup(res_dict, res_tok->string);
		if (res){
		 	dst->tags->result = *res;
		}
		else dst->tags->result = UNK_RES;
		free_token(res_tok);
	} 
	else {
		// not strict about inclusion
		dst->tags->result = UNK_RES;
	}	
	token_t *date_tok = dict_remove(tok_dict, "Date");
	if (date_tok) {
		char buf[255];
		strip_str(buf, date_tok->string);
		date_t *date = &dst->tags->date;
		const char *err = parse_date(date, buf, '.');
		if (err) {
			date->known_year = 0;
			date->known_month = 0;
			date->known_day = 0;
		}
		free_token(date_tok);
	}
	else {
		date_t *date = &dst->tags->date;
			date->known_year = 0;
			date->known_month = 0;
			date->known_day = 0;
	}
	char *tags[] = {"Site", "Event", "Round", "White", "Black" , 0};
	return ensure_tags_exists(tags, dest_dict, ctx);
}

char *read_tags_old(FILE *stream,
	 							dict_t *dest_dict, 	
								tok_context_t *ctx,
								pgn_game_t *dst,
								dict_t *res_dict) {
	dict_t *tok_dict = new_dict(20);
	do {
		token_t *first = pgntoken(stream, ctx);
		if (!first){
			break;
		}
		if (token_is(first, "[")) {
			char *err = read_tag_pair(stream, ctx, dest_dict, first, tok_dict);
			if (err) {
				dict_free(dest_dict);
				dict_free_toks(tok_dict);
				return err;
			}
		}
		else if (token_is(first, "1")){
			untoken(first, ctx);	
			break;
		}
		else {
			dict_free(dest_dict);
			dict_free_toks(tok_dict);
			return alloc_err(ctx,"Expected a tag pair or the beginning of a Movetext block", first);
		}
	} while (true);
	
	return transform_tags(tok_dict, dest_dict, ctx, dst, res_dict);	
}

*/

#define VALID_CLEANUP_TAGS(){\
	free_token(lbracket);\
	free_token(name);\
	free_token(rbracket);\
}


#define CLEANUP_TAGS(){\
	free_token(lbracket);\
	free_token(name);\
	free_token(value);\
	free_token(rbracket);\
}

#define TAG_ERR(MSG, TOKEN){\
	debug_print("making tag err " MSG "\n");\
	dict_free_toks(token_dict);\
	dict_free(token_dict);\
	debug_print("about to alloc err \n");\
	return alloc_err(ctx, MSG, TOKEN);\
}

#define TAG_ERR_EOF(EXPECTED)\
	{TAG_ERR("Unexpected enf of file, expected a " EXPECTED, NULL);} 


char *read_tags(FILE *stream, tok_context_t *ctx, dict_t *token_dict) {	
	bool first = true;
	do {
		token_t *lbracket = pgntoken(stream, ctx);
		token_t *name = NULL;
		token_t *value = NULL;
		token_t *rbracket = NULL;
		if (!lbracket) TAG_ERR_EOF("tag pair or the beginning of a Movetext block"); 	
		if (!token_is(lbracket, "[")) {
			if (first){
				TAG_ERR("Expected a tag pair begninning with [", lbracket)				
			}
			else {
				untoken(lbracket, ctx);
				return 0;
			}
		}	
		name = pgntoken(stream, ctx);
		if (!name) TAG_ERR_EOF("name for a tag pair");
		value = pgntoken(stream, ctx);
		// Ignore the spec to be more forgiving
		/*
		if (value->string[0] != '"') 
			return alloc_err(ctx, "value of a tage pair must be a string starting and ending with \"", value);
		*/
		rbracket = pgntoken(stream, ctx);
		if (!rbracket) TAG_ERR_EOF("] to close tag pair, followed by a Movetext block");
		if (!token_is(rbracket, "]")) 	
			return alloc_err(ctx, "Expected a closing ] for tag pair", rbracket);
		first = false;
		// Again, valid error that is not implemented for ease of parsing
		/*
		char *cur;
		if ((cur = dict_lookup(tag_dict, name->string))) {
			char msg[200];
			sprintf(msg, "Duplicate tag pair found, %s is already specified as %s", 
				name->string, cur);
			return alloc_err(ctx, msg, value);	
		}
		*/
		// this function can fail if realloc fails, but we'd rather miss a tag then throw an error right now.
		dict_add(token_dict, name->string, value);
		VALID_CLEANUP_TAGS();
	} while(true);
	return 0;	
}

struct read_num_res {
	char *err;
	bool ret;
};

struct read_num_res read_turn_number(FILE *stream, token_t *num_tok, int num, tok_context_t *ctx) {
	char numstr[10];
	sprintf(numstr, "%d", num);
	if (!num_tok) {
		return (struct read_num_res){.err = 0, .ret = false};
	}
	if (!token_is(num_tok, numstr)){	
		if (atoi(num_tok->string)) {
			char msg[300];
			sprintf(msg, "Expected the move number %s", numstr);
			char *err = alloc_err(ctx, msg, num_tok); 
			return (struct read_num_res){.err = err, .ret = true};
		}
		return (struct read_num_res){.err = 0, .ret = false};
	}	
	do {
		token_t *dot = pgntoken(stream, ctx);
		if (!token_is(dot, ".")) {
			untoken(dot, ctx);
			break;
		}
		else free_token(dot);	
	} 
	while(true);
	return (struct read_num_res){.err = 0, .ret = true};	
}


struct read_move_res {
	char *err;
	bool done;
};



struct read_move_res read_move_tok(token_t *token, 
																	 FILE *stream,
																	 tok_context_t *ctx,
																	 int *move_num, 
																	 bool *white,
																	 dict_t *res_dict,
																	 move_t *moves,
																	 u_int16_t *moves_i,
																	 full_board_t *board) {
	
	if (!token) {
	 	char *err = alloc_err(ctx,"Unexpected end of file after last token", token);
		return (struct read_move_res){.err = err, .done = false};
	}
		
	// skips group comments, alt lines, and NAG
	switch (token->string[0]) {
		case '{': case '(': case '$':
		return (struct read_move_res){.err = 0, .done = false};
	}
	bool is_err;
	san_move_t san = parse_san(token->string, &is_err);
	if (is_err) {
		if (dict_lookup(res_dict, token->string)) {
				return (struct read_move_res){.err = 0, .done = true};
		}
		else {
			struct read_num_res res = read_turn_number(stream, token, *move_num, ctx); 
			if (res.err)
				return (struct read_move_res){.err = res.err, .done = false};
			else if (res.ret) 
				return (struct read_move_res){.err = 0, .done = false};

			char *err = alloc_err(ctx,"Invalid move found", token);
		 	return (struct read_move_res){.err = err, .done = false};	
		}	
	}
	bool is_white = !*white;
	if (is_white) (*move_num)++;
	*white = is_white;
	char err[100];
	move_t move = san_to_move(board, san, err);
	if (move.type == ERROR_MOVE) {
		 	char msg[500];
			char fen[100];
		 	make_fen(board, fen); 
			print_board(board);
			sprintf(msg, "Could not read move for the position %s, %s", 
					fen, err);
			return (struct read_move_res)
			{.err = alloc_err(ctx, msg, token), .done = false};
	}
	apply_move(board, move);
	if (*moves_i == 600) {
		return (struct read_move_res)
		{.err = alloc_err(ctx, "Too many moves in game, can only store 600", token), .done = false};
	}
	moves[(*moves_i)++] = move;
	
	return (struct read_move_res){.err = 0, .done = false};
}



char *read_moves(FILE *stream, full_board_t *starting_board, 
		move_t *moves, u_int16_t *count, tok_context_t *ctx,
		dict_t *res_dict) {
	
	u_int16_t move_i = 0;

	bool is_white = true;
	int turn_num = 1;
	bool done;
	
	position_t pos;
	full_board_t board;	
	board.position = &pos;
	copy_into(&board, starting_board);
	do {
		token_t *tok = pgntoken(stream, ctx);
		struct read_move_res res 
			= read_move_tok(tok, stream, ctx, &turn_num, 
					&is_white, res_dict, moves, &move_i, &board);  	
		if (res.err) return res.err;
		free_token(tok);
		done = res.done;
	} while(!done);
	*count = move_i;
	dict_free(res_dict);
	return 0;
}	

#define GET_TOKEN(DEST, KEY1, KEY2, KEY3){\
	DEST = dict_lookup(token_dict, KEY1);\
	if (KEY2 && !DEST){\
	 	DEST = dict_lookup(token_dict, KEY2);\
		if (KEY3 && !DEST){\
			DEST = dict_lookup(token_dict, KEY3);\
		}\
	}\
}

char *use_token_dict(pgn_game_t *dst, dict_t *token_dict, tok_context_t *ctx, 
		dict_t *res_dict){
	// using as little eager validatation as possible 
	// missing or malformed tags with return None
	
	
	token_t *fen_tok = dict_remove(token_dict, "FEN");
	dict_t *str_dict = new_dict(token_dict->length);
	if (fen_tok) {
		char buff[255];
		strip_str(buff, fen_tok->string);
		char *fen_err = parse_fen(buff, 
				dst->starting_board);
		if (fen_err) {
			dict_free_toks(token_dict);
			dict_free(str_dict);
			return alloc_err(ctx, fen_err, fen_tok);
		}
		dict_add(str_dict, "FEN", fen_tok->string);
		free(fen_tok->location);
		free(fen_tok);
	}
	else {
		char fen[200];
		strcpy(fen,
			"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1");
		parse_fen(fen, dst->starting_board);
	}

	token_t *date_tok;
	GET_TOKEN(date_tok, "Date", "UTCDate", "EventDate")
	date_t date;
	if (!date_tok) date = unknown_date();
	else {
		char date_str[255];
		strip_str(date_str, date_tok->string);
		const char *err = parse_date(&date, date_str); 
		if (err) {
			date = unknown_date(); 
		}
		dst->date = date;
	}
	token_t *result_tok;
	GET_TOKEN(result_tok, "Result", 0, 0);	
	if (!result_tok) dst->result = UNK_RES;
	else {
		u_int8_t *res = dict_lookup(res_dict, result_tok->string);
		if (res) dst->result = *res;
		else dst->result = UNK_RES;
	}
	// need to get the keys and values, better this way
	// than calling both dict_keys and looking up
	for (size_t i = 0; i < token_dict->capacity; i++) {
		if (token_dict->is_occupied[i]) {
			token_t *token = token_dict->entries[i].value;	
			dict_add(str_dict, token_dict->entries[i].key, token->string);
			free(token->location);
			free(token);	
		}
	}	
	dict_free(token_dict);
	dst->raw_tags = str_dict;
	return 0;
}


char *read_pgn_inner(FILE *stream, tok_context_t *ctx, pgn_game_t *dst) {
	u_int8_t res_vals[] = {DRAW_RES, WHITE_RES, BLACK_RES, UNK_RES};
	dict_t *res_dict = new_dict(20);
	dict_add(res_dict, "1/2-1/2", res_vals); 
	dict_add(res_dict, "1-0", res_vals + 1); 
	dict_add(res_dict, "0-1", res_vals + 2); 
	dict_add(res_dict, "*", res_vals + 3); 
	
	dict_add(res_dict, "\"1/2-1/2\"", res_vals); 
	dict_add(res_dict, "\"1-0\"", res_vals + 1); 
	dict_add(res_dict, "\"0-1\"", res_vals + 2); 
	dict_add(res_dict, "\"*\"", res_vals + 3); 
	dict_t *token_dict = new_dict(20);
	char *out = read_tags(stream, ctx, token_dict);	
	if (out) return out; 
	use_token_dict(dst, token_dict, ctx, res_dict);
	out = read_moves(stream, dst->starting_board, 
			dst->moves, &(dst->count), ctx, res_dict);
	return out;	
}

void skip_to_next(pgn_file_t *pf) {
	// tokenizer implementation is annoying for this
	size_t cur_line = pf->ctx->loc.line;
	for (;;) {
		token_t *tok = pgntoken(pf->file, pf->ctx);
		if (!tok) { 
			untoken(tok, pf->ctx);	
			return;
		}
		size_t line = tok->location->line;
		if (tok->string[0] == '[' && line > cur_line + 1) {
			untoken(tok, pf->ctx);
			return;
		}
		cur_line = line;
		free_token(tok);
	} 
}

int next_pgn(pgn_file_t *pf, pgn_game_t *dst, char *err) {
	token_t *tok = pgntoken(pf->file, pf->ctx);
	if (!tok) return 2;
	untoken(tok, pf->ctx);	
	char *tmp = read_pgn_inner(pf->file, pf->ctx, dst);
	if (tmp) {
		strncpy(err, tmp, 500);
		free(tmp);
		// errors are non recoverable from
		//skip_to_next(pf);
		return 1;	
	}
	return 0;
}

/*
bool read_pgn_file(char *filename, pgn_game_t *dst, char *err) {
	FILE *stream = fopen(filename, "r");
	char *tmp = read_pgn(stream, dst);
	fclose(stream);
	if (tmp) {
		strcpy(err, tmp);
		free(tmp);
		return false;	
	}
	return true;
}
*/


pgn_file_t *open_pgn(char *filepath){
	pgn_file_t *pf = malloc(sizeof(pgn_file_t));
	pf->file = fopen(filepath, "rb");
	pf->ctx = start_context(filepath, ";[].*()<>", "\"\"{}", '\\');
	return pf;
}

void close_pgn(pgn_file_t *pf) {
	fclose(pf->file);
	end_context(pf->ctx);
	free(pf);
}

