#include "pgn.h"


char *alloc_err(const char *msg, token_t *tok) {
	char loc_str[100];
	if (tok) {
		write_loc(tok->location, loc_str);
	}
	else {
		fprintf(stderr,"INTERNAL ERROR, CANT MAKE MSG\n");
		exit(1);
	}
	char *err = malloc(strlen(loc_str) + strlen(msg) + 10);
	sprintf(err, "<%s>: Error When Parsing PGN: %s, got %s", 
			loc_str, msg, tok->string);
	free_token(tok);
	return err;
}


bool tag_eq(token_t *tok, char *expect, dict_t *dict) {
	if (!strcmp(tok->string, expect)) {
		dict_add(dict, tok->string, expect);
		return true;
	}
	return false;
}

void copy_tok(char *dest, token_t *tok) {
	strcpy(dest, tok->string);
	free_token(tok);
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

char *add_tag_pair(token_t *name, token_t *val, dict_t *dict){
	printf("adding pair %s %s\n", name->string, val->string);
	char *ptr = dict_remove(dict, name->string);
	printf("added\n");
	if (!ptr) return alloc_err("Unexpected tag name", name);
	char *scratch = val->string;
	scratch++;
	scratch[strlen(scratch) - 1] = 0;
	strcpy(ptr, scratch);
	free_token(val);
	free_token(name);
	printf("copied %p\n", ptr);
	return 0;
}

char *read_tag_pair(FILE *stream, tok_context_t *ctx, dict_t* dict, token_t *first) {
		token_t *name = ftoken(stream, ctx);
		if (name) {
			printf("got name %s\n", name->string);
			free_token(first);
			token_t *val = ftoken(stream, ctx);
			if (!val) return alloc_err("Missing value for tag pair", name);
			printf("got val %s\n", val->string);
			if (val->string[0] == '"') {
				token_t *last = ftoken(stream, ctx);
				if (!last) {
					free_token(name);
					return alloc_err("Tag pair missing ending ]", val);
				}
				else if (token_is(last, "]")) {
					printf("got last %s\n", last->string);
					add_tag_pair(name, val,  dict); 
					return 0;
				}
				else {
					free_token(name);
					free_token(val);
					return alloc_err("Tag pair missing ending ]", last);
				}
			}
			else {
				free_token(name);
				return alloc_err("Tag value must be a string", val);
			}
		}
		else {
			return alloc_err("No tag name given", first);
		}
}


char *read_tagss(FILE *stream, pgn_tag_section_t *tags, tok_context_t *ctx) {
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
			if (err) return err;
		}
		else if (token_is(first, "1")){
			printf("here\n");
			untoken(first, ctx);	
			break;
		}
		else {
			return alloc_err("Expected a tag pair or the beginning of a Movetext block", first);
		}
	} while (true);
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
			char msg[100];
			sprintf(msg, "Expected the move number %s", numstr);
			char *err = alloc_err(msg, num_tok); 
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
																	 token_t *last,
																	 FILE *stream,
																	 tok_context_t *ctx,
																	 int *move_num, 
																	 bool *white,
																	 dict_t *res_dict,
																	 san_move_t *moves,
																	 u_int16_t *moves_i) {
	printf("got a token\n");
	if (!token) {
	 	char * err = alloc_err("Unexpected end of file after last token", last);
		return (struct read_move_res){.err = err, .done = false};
	}
	printf("about to print token\n");
	printf("parsing move thing %s\n", token->string);
	skip_comment(stream, token, ctx);
	printf("before free\n");
	if (last) free_token(last);
	printf("here now\n");
	// skips comments
	if (token->string[0] == '{') {
		return (struct read_move_res){.err = 0, .done = false};
	}
	bool is_err;
	printf("parsing san\n");
	san_move_t san = parse_san(token->string, &is_err);
	if (is_err) {
		if (dict_lookup(res_dict, token->string)) {
				return (struct read_move_res){.err = 0, .done = true};
		}
		else {
			struct read_num_res res = read_turn_number(stream, token, *move_num, ctx); 
			printf("checked for num\n");
			if (res.err) 
				return (struct read_move_res){.err = res.err, .done = false};
			else if (res.ret) 
				return (struct read_move_res){.err = 0, .done = false};

			char *err = alloc_err("Invalid move found", token);
		 	return (struct read_move_res){.err = err, .done = false};	
		}	
	}
	printf("parsed a move\n");
	if (!*white) (*move_num)++;
	*white = !*white;
	moves[(*moves_i)++] = san;
	return (struct read_move_res){.err = 0, .done = false};
}



char *read_moves(FILE *stream, san_move_t *moves, u_int16_t *count,
	 					tok_context_t *ctx) {
	u_int16_t max_count = 500; // arbitrary
	u_int16_t move_i = 0;
	dict_t *res_dict = new_dict(4);
	dict_add(res_dict, "1/2-1/2", ""); 
	dict_add(res_dict, "1-0", ""); 
	dict_add(res_dict, "0-1", ""); 
	dict_add(res_dict, "*", ""); 
	bool is_white = true;
	token_t *last = 0;
	int turn_num = 1;
	for (int i = 0; i < max_count; i++) {
		token_t *tok = ftoken(stream, ctx);
		struct read_move_res res 
			= read_move_tok(tok, last, stream, ctx, &turn_num, 
					&is_white, res_dict, moves, &move_i);  	
		if (res.err) return res.err;
		if (res.done) break;
		
		/*
		if (read_turn_number(stream, num_tok, i, ctx)) {
			token_t *wtok = ftoken(stream, ctx);
			read_turn_number(stream, wtok, i, ctx); 
			struct read_move_res res 
				= read_move_tok(wtok, num_tok, true, res_dict, moves, move_i); 
			if (res.err) return res.err;

			token_t *btok = ftoken(stream, ctx);
			res = read_move_tok(btok, wtok, false, res_dict, moves, move_i); 
			if (res.err) return res.err;
			free_token(btok);
			if (res.done) {
				break;
			}
		}
		else {
			char err[255];
			sprintf(err, "Expected the turn number indicator %s", num);
			return alloc_err(err, num_tok);
		}
		*/
	}
	*count = move_i;
	return 0;
}	

char *read_pgn_inner(FILE *stream, pgn_game_t *dst) {
	
	strcpy(dst->tags.fen, 
			"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1");
	printf("makign ctx\n");
	tok_context_t *ctx = start_context("pgn", ";[].*()<>", "\"\"{}", '\\');
	printf("ctx made\n");
	char *out  = read_tagss(stream, &dst->tags, ctx);
	printf("tagsgs\n");
	if (out) goto cleanup;
	out = read_moves(stream, dst->moves, &(dst->count), ctx);
	cleanup:
	end_context(ctx);
	printf("event `%p`\n", dst->tags.event);
	printf("count %d\n", dst->count);
	return out;	
}

bool next_pgn(FILE *file, pgn_game_t *dst, char *err) {
	printf("NEXT PGN\n\n");
	char * tmp = read_pgn_inner(file, dst);
	if (tmp) {
		strcpy(err, tmp);
		free(tmp);
		return false;	
	}
	return true;
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
	char *fen_err = parse_fen(pgn->tags.fen, board, index_array);
	printf("fen parsed\n");
	if (fen_err){
		printf("fen err\n");
	 	strcpy(err, fen_err);
		return 0;
	}
	for (int i = 0; i < pgn->count; i++) {
		printf("creating move %d\n", i);
		san_move_t san = pgn->moves[i];
		move_t move = san_to_move(board, san);
		if (move.type == ERROR_MOVE) {
			char buf[10];
			write_san(san, buf); 
			sprintf(err, "The move %s is not legal", buf);
			printf("move err: %s\n", err);
			return 0;
		}
		else {
			moves[i] = move;
			apply_move(board, move);
		}
	}
	return pgn->count;	
}


FILE *open_pgn(char *filepath){
	return fopen(filepath, "r");
}

void close_pgn(FILE *pgn_file) {
	fclose(pgn_file);
}

