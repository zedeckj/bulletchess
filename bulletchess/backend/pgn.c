#include "pgn.h"

#define strncpy2(s1, s2, n) (printf("%s copied on %d\n", s2, __LINE__), \
		 										strncpy(s1, s2, n))


//#define free_token(tok) (printf("freeing %s on %d. %p, %p, %p\n", tok->string, __LINE__, tok->string, tok->location, tok), free_token(tok))
//#define free(p) (printf("free on line %d %p\n", __LINE__, p), free(p))

char *alloc_err(tok_context_t *ctx, const char *msg, token_t *tok) {
	char loc_str[500];
	char *err;
	if (tok) {
		write_loc(tok->location, loc_str);
		err = malloc(strlen(loc_str) + strlen(msg) + 100);
		sprintf(err, "<%s>: Error When Parsing PGN: %s, got %s", 
			loc_str, msg, tok->string);
		free_token(tok);
	}
	else {
		printf("IN NULL BRANCH %p\n", ctx->loc.source_name);
		write_loc(&ctx->loc, loc_str);
		printf("written\n");
		err = malloc(strlen(loc_str) + strlen(msg) + 100);
		printf("here\n");
		sprintf(err, "<%s>: Error When Parsing PGN: %s", loc_str, msg);
		printf("MADE ERR %s\n", err);
	}
	return err;
}



dict_t *make_dst_dict(pgn_tag_section_t *tags) {
	dict_t *dict = new_dict(20);
	printf("tags event %p\n", tags->event);
	dict_add(dict, "Event", tags->event);
 	printf("tags lookup %p\n", dict_lookup(dict, "Event"));
	dict_add(dict, "Site", tags->site);
	dict_add(dict, "Date", tags->date);
	dict_add(dict, "Round", tags->round);
	dict_add(dict, "White", tags->white_player);
	dict_add(dict, "Black", tags->black_player);
	dict_add(dict, "Result", tags->result);
	dict_add(dict, "FEN", tags->fen);
	return dict;
}

void skip_comment(FILE *stream, token_t *tok, tok_context_t *ctx) {
	if (token_is(tok, ";")) {
		free_token(tok);
		size_t line = tok->location->line;
		do {
			tok = ftoken(stream, ctx);
			if (tok->location->line > line){
				untoken(tok, ctx);
				break;
			}	
			else free_token(tok);
		} while(true);
	}
}

char *add_tag_pair(token_t *name, token_t *val, dict_t *dict, tok_context_t *ctx){
	printf("adding pair %s %s\n", name->string, val->string);
	char *ptr = dict_remove(dict, name->string);
	printf("added\n");
	if (!ptr) return alloc_err(ctx,"Unexpected tag name", name);
	char scratch[255];
	strncpy2(scratch, val->string + 1, 255);
	scratch[strlen(scratch) - 1] = 0;
	strncpy2(ptr, scratch, 255);
	free_token(val);
	free_token(name);
	printf("copied %p\n", ptr);
	return 0;
}

char *read_tag_pair(FILE *stream, 
										tok_context_t *ctx, 
										dict_t* dict, token_t *first) {
		token_t *name = ftoken(stream, ctx);
		if (name) {
			printf("got name %s\n", name->string);
			free_token(first);
			token_t *val = ftoken(stream, ctx);
			if (!val) return alloc_err(ctx,"Missing value for tag pair", name);
			printf("got val %s\n", val->string);
			if (val->string[0] == '"') {
				token_t *last = ftoken(stream, ctx);
				if (!last) {
					free_token(name);
					return alloc_err(ctx,"Tag pair missing ending ]", val);
				}
				else if (token_is(last, "]")) {
					printf("got last %s\n", last->string);
					add_tag_pair(name, val, dict, ctx); 
					return 0;
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


char *read_tagss(FILE *stream, 
								pgn_tag_section_t *tags, 
								tok_context_t *ctx) {
	printf("called tags\n");
	dict_t *dict = make_dst_dict(tags);
	printf("made dict\n");
	do {
		printf("before ftok\n");
		token_t *first = ftoken(stream, ctx);
		printf("after ftok\n");
		if (!first){
		 	printf("no more\n");
			break;
		}
		printf("got first %s\n", first->string);
		if (token_is(first, "[")) {
			char *err = read_tag_pair(stream, ctx, dict, first);
			if (err) {
				dict_free(dict);
				return err;
			}
		}
		else if (token_is(first, "1")){
			printf("here\n");
			untoken(first, ctx);	
			break;
		}
		else {
			dict_free(dict);
			return alloc_err(ctx,"Expected a tag pair or the beginning of a Movetext block", first);
		}
	} while (true);
	
	dict_free(dict);
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
		token_t *dot = ftoken(stream, ctx);
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
																	 san_move_t *moves,
																	 u_int16_t *moves_i) {
	if (!token) {
	 	char *err = alloc_err(ctx,"Unexpected end of file after last token", token);
		printf("err here is %s", err);
		return (struct read_move_res){.err = err, .done = false};
	}
	
	printf("parsing move-thing %s: %d\n", token->string, *moves_i);
	skip_comment(stream, token, ctx);
	// skips comments
	if (token->string[0] == '{') {
		printf("skipping coment\n");
		return (struct read_move_res){.err = 0, .done = false};
	}
	bool is_err;
	san_move_t san = parse_san(token->string, &is_err);
	if (is_err) {
		printf("not a san\n");
		if (dict_lookup(res_dict, token->string)) {
				printf("got a res\n");
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
	moves[(*moves_i)++] = san;
	printf("continuing...\n");
	return (struct read_move_res){.err = 0, .done = false};
}



char *read_moves(FILE *stream, san_move_t *moves, u_int16_t *count,
	 					tok_context_t *ctx) {
	
	printf("reading moves\n");
	u_int16_t move_i = 0;
	dict_t *res_dict = new_dict(4);
	dict_add(res_dict, "1/2-1/2", ""); 
	dict_add(res_dict, "1-0", ""); 
	dict_add(res_dict, "0-1", ""); 
	dict_add(res_dict, "*", ""); 
	bool is_white = true;
	int turn_num = 1;
	bool done;
	do {
		token_t *tok = ftoken(stream, ctx);
		struct read_move_res res 
			= read_move_tok(tok, stream, ctx, &turn_num, 
					&is_white, res_dict, moves, &move_i);  	
		printf("res: err %s, done %d\n", res.err, res.done);
		free_token(tok);
		if (res.err) return res.err;
		done = res.done;
	} while(!done);
	printf("exiting move loop\n");
	*count = move_i;
	dict_free(res_dict);
	return 0;
}	

char *read_pgn_inner(FILE *stream, tok_context_t *ctx, pgn_game_t *dst) {
	strcpy(dst->tags.fen, 
			"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1");
	char *out = read_tagss(stream, &dst->tags, ctx);
	if (out) return out; 
	out = read_moves(stream, dst->moves, &(dst->count), ctx);
	printf("err here in inner %s\n", out);
	printf("count %d\n", dst->count);
	return out;	
}

int next_pgn(pgn_file_t *pf, pgn_game_t *dst, char *err) {
	printf("NEXT PGN\n\n");
	
	token_t *tok = ftoken(pf->file, pf->ctx);
	if (!tok) return 2;
	untoken(tok, pf->ctx);	
	char *tmp = read_pgn_inner(pf->file, pf->ctx, dst);
	printf("got err %s\n", tmp);
	if (tmp) {
		printf("about to copy\n");
		strncpy2(err, tmp, 300);
		printf("copied\n\n");
		free(tmp);
		printf("returned 1 to python\n");
		return 1;	
	}
	printf("returned 0 to python\n");
	return 0;
}

/*
bool read_pgn_file(char *filename, pgn_game_t *dst, char *err) {
	FILE *stream = fopen(filename, "r");
	printf("start\n");
	char *tmp = read_pgn(stream, dst);
	printf("end\n");
	fclose(stream);
	if (tmp) {
		strcpy(err, tmp);
		free(tmp);
		return false;	
	}
	return true;
}
*/


u_int16_t pgn_to_board_and_moves(pgn_game_t *pgn, 
														full_board_t *board, 
														piece_index_t *index_array,
														move_t *moves,
														char *err){
	printf("call\n");
	char fen[100];
	strncpy2(fen,pgn->tags.fen, 100); 
	char *fen_err = parse_fen(fen, board, index_array);
	position_t pos;
	full_board_t copy;
	copy.position = &pos;
	copy_into(&copy, board);
	//parse_fen(fen, &copy, index_array);
	printf("fen parsed\n");
	if (fen_err){
		printf("fen err\n");
	 	strncpy2(err, fen_err, 300);
		return 0;
	}
	for (int i = 0; i < pgn->count; i++) {
		printf("creating move %d\n", i);
		san_move_t san = pgn->moves[i];
		move_t move = san_to_move(&copy, san);
		if (move.type == ERROR_MOVE) {
			char buf[20];
			write_san(san, buf); 
			sprintf(err, "The move %s is not legal", buf);
			printf("move err: %s\n", err);
			return 0;
		}
		else {
			moves[i] = move;
			apply_move(&copy, move);
		}
	}
	return pgn->count;	
}


pgn_file_t *open_pgn(char *filepath){
	pgn_file_t *pf = malloc(sizeof(pgn_file_t));
	pf->file = fopen(filepath, "r");
	pf->ctx = start_context(filepath, ";[].*()<>", "\"\"{}", '\\');
	printf("start ctx %p\n", pf->ctx->loc.source_name);
	return pf;
}

void close_pgn(pgn_file_t *pf) {
	printf("closing pgn\n");
	fclose(pf->file);
	end_context(pf->ctx);
	printf("freeing %p\n", pf);
	free(pf);
}

