#include "pgn.h"



//#define free_token(tok) (printf("freeing %s on %d. %p, %p, %p\n", tok->string, __LINE__, tok->string, tok->location, tok), free_token(tok))
//#define free(p) (printf("free on line %d %p\n", __LINE__, p), free(p))

#define printf(...) 0

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


void strip_str(char *dst, char *src) {
	strcpy(dst, src + 1);
	dst[strlen(dst) - 1] = 0;
}

dict_t *make_dst_dict(pgn_tag_section_t *tags, char *fen, char *res) {
	dict_t *dict = new_dict(20);
	printf("tags event %p\n", tags->event);
	dict_add(dict, "Event", tags->event);
 	printf("tags lookup %p\n", dict_lookup(dict, "Event"));
	dict_add(dict, "Site", tags->site);
	dict_add(dict, "Date", tags->date);
	dict_add(dict, "Round", tags->round);
	dict_add(dict, "White", tags->white_player);
	dict_add(dict, "Black", tags->black_player);
	dict_add(dict, "Result", res);
	dict_add(dict, "FEN", fen);
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

char *add_tag_pair(token_t *name, token_t *val, 
		dict_t *dict, tok_context_t *ctx, dict_t *tok_dict){
	if (val && strlen(val->string) > 254)
		return alloc_err(ctx, 
				"Tag value is too long, must be at most 255 characters", val);
	printf("adding pair %s %s\n", name->string, val->string);
	char *ptr = dict_remove(dict, name->string);
	printf("added\n");
	if (!ptr) return 0; // Just ignore unknown tags
	dict_add(tok_dict, name->string, val);
	char scratch[255];
	strncpy(scratch, val->string + 1, 255);
	scratch[strlen(scratch) - 1] = 0;
	strncpy(ptr, scratch, 255);
	free_token(name);
	printf("copied %p\n", ptr);
	return 0;
}

char *read_tag_pair(FILE *stream, 
										tok_context_t *ctx, 
										dict_t* dict, token_t *first,
										dict_t* tok_dict) {
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
					return add_tag_pair(name, val, dict, ctx, tok_dict); 
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
		printf("%ld: %p\n", i, values[i]);
		free_token(values[i]);
	}
	free(values);
	printf("out of free\n");
}



char *transform_tags(dict_t *tok_dict,
										tok_context_t *ctx,
										pgn_game_t *dst,
										dict_t * res_dict) {
	token_t *fen_tok = dict_remove(tok_dict, "FEN");
	if (fen_tok) {
		char buff[255];
		strip_str(buff, fen_tok->string);
		fprintf(stderr, "fen is %s\n", buff);
		piece_index_t pieces[128];
		char *fen_err = parse_fen(buff, 
				dst->starting_board, pieces);
		if (fen_err) {
			dict_free_toks(tok_dict);
			return alloc_err(ctx, fen_err, fen_tok);
		}
		printf("freeing fen tok\n");
		free(fen_tok->string);
		free(fen_tok);
	}
	else {
		printf("no fen tok\n");
		char fen[200];
		strcpy(fen,
			"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1");
		printf("fen is %s\n", fen);
		piece_index_t pieces[128];
		printf("pointer is %p\n", dst->starting_board->position);
		parse_fen(fen, dst->starting_board, pieces);
		printf("fuck you\n");
	}
	printf("done\n");
	token_t *res_tok = dict_remove(tok_dict, "Result");
	if (res_tok) {
		fprintf(stdout, "checking tok %s\n in len %ld\n", 
				res_tok->string, res_dict->length);
		
		u_int8_t *res = dict_lookup(res_dict, res_tok->string);
		fprintf(stdout, "got res %p\n", res);
		if (res) dst->tags->result = *res;
		else dst->tags->result = UNK_RES;
	} 
	else {
		// not strict about inclusion
		dst->tags->result = UNK_RES;
	}	


	dict_free_toks(tok_dict);
	return 0;
}

char *read_tagss(FILE *stream,
	 							dict_t *dest_dict, 	
								tok_context_t *ctx,
								pgn_game_t *dst,
								dict_t *res_dict) {
	printf("called tags\n");
	printf("made dict\n");
	dict_t *tok_dict = new_dict(20);
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
			char *err = read_tag_pair(stream, ctx, dest_dict, first, tok_dict);
			if (err) {
				dict_free(dest_dict);
				dict_free_toks(tok_dict);
				return err;
			}
		}
		else if (token_is(first, "1")){
			printf("here\n");
			untoken(first, ctx);	
			break;
		}
		else {
			dict_free(dest_dict);
			dict_free_toks(tok_dict);
			return alloc_err(ctx,"Expected a tag pair or the beginning of a Movetext block", first);
		}
	} while (true);
	
	dict_free(dest_dict);
	return transform_tags(tok_dict, ctx, dst, res_dict);	
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
																	 move_t *moves,
																	 u_int16_t *moves_i,
																	 full_board_t *board) {
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
	char err[100];
	move_t move = san_to_move(board, san, err);
	apply_move(board, move);
	if (move.type == ERROR_MOVE) {
		 	char msg[200];
			char fen[100];
		 	make_fen(board, fen); 
			sprintf(msg, "Could not read move for the position %s, %s", 
					fen, err);
			return (struct read_move_res)
			{.err = alloc_err(ctx, msg, token), .done = false};
	}
	if (*moves_i == 600) {
		return (struct read_move_res)
		{.err = alloc_err(ctx, "Too many moves in game, can only store 600", token), .done = false};
	}
	moves[(*moves_i)++] = move;
	printf("continuing...\n");
	return (struct read_move_res){.err = 0, .done = false};
}



char *read_moves(FILE *stream, full_board_t *starting_board, 
		move_t *moves, u_int16_t *count, tok_context_t *ctx,
		dict_t *res_dict) {
	
	printf("reading moves\n");
	u_int16_t move_i = 0;

	bool is_white = true;
	int turn_num = 1;
	bool done;
	
	position_t pos;
	full_board_t board;	
	board.position = &pos;
	copy_into(&board, starting_board);
	do {
		token_t *tok = ftoken(stream, ctx);
		struct read_move_res res 
			= read_move_tok(tok, stream, ctx, &turn_num, 
					&is_white, res_dict, moves, &move_i, &board);  	
		printf("res: err %s, done %d\n", res.err, res.done);
		if (res.err) return res.err;
		free_token(tok);
		done = res.done;
	} while(!done);
	printf("exiting move loop\n");
	*count = move_i;
	dict_free(res_dict);
	return 0;
}	

char *read_pgn_inner(FILE *stream, tok_context_t *ctx, pgn_game_t *dst) {
	char fen[255];	
	char res[255];	
	dict_t *dict = make_dst_dict(dst->tags, fen, res);
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
	

	char *out = read_tagss(stream, dict, ctx, dst, res_dict);
	if (out) return out; 
	out = read_moves(stream, dst->starting_board, 
			dst->moves, &(dst->count), ctx, res_dict);
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
		strncpy(err, tmp, 300);
		printf("copied .%s.\n", err);
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

