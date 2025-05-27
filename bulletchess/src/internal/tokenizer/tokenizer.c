#include "tokenizer.h"


bool token_is(token_t *tok, char *string) {
	return tok && string && !strcmp(tok->string, string);
}

tok_context_t *start_def_ctx(char *source_name) {
	return start_context(source_name, 0, 0, 0);
}

tok_context_t *start_op_ctx(char *source_name, char *operators) {
	return start_context(source_name, operators, 0, 0);
}

tok_context_t *start_delim_ctx(char *source_name, char *delims, char escape) {
	return start_context(source_name, 0, delims, escape);
}

tok_context_t *start_context(char *source_name, char *operators, char * delims, char escape) {
	tok_context_t *context = malloc(sizeof(tok_context_t));
	context->loc = (source_loc_t){.source_name = source_name, .line = 1, .col = 1}; 
	context->operators = operators;
	context->delims = delims;
	context->index = 0;
	context->pntr = 0;
	context->escape = escape;
	context->ungot = 0;
	return context;
}
void free_token_list(token_list_t *list){
	if (list) {
		free_token(list->first);
		free_token_list(list->rest);
		free(list);
	}
}

void end_context(tok_context_t *context){
	free_token_list(context->ungot);
	free(context);
}



token_t *pop_token(tok_context_t *context) {
	if (context && context->ungot) {
		token_t *tok = context->ungot->first;
		token_list_t *rest = context->ungot->rest;
		free(context->ungot);
		context->ungot = rest; 
		return tok;
	}
	return 0;
}

void untoken(token_t *tok, tok_context_t *context) {
	token_list_t *u = malloc(sizeof(token_list_t));
	u->first = tok;
	u->rest = context->ungot;
	context->ungot = u;
}

int write_loc(source_loc_t* loc, char *buffer){
	if (!loc || !buffer) return 0;
	return sprintf(buffer, "%s:%ld:%ld", loc->source_name, loc->line, loc->col);
}

token_t *new_token(char *buffer, size_t len, source_loc_t *current_loc) {
	if (len == 0) return 0;
	buffer[len] = 0;
	token_t * tok = malloc(sizeof(token_t));
	tok->string = malloc(len + 1);
	tok->location = current_loc;
	strcpy(tok->string, buffer);
	return tok;
}

void free_token(token_t *token) {
	if (token) {
		free(token->string);
		free(token->location);
		free(token);
	}
}

bool is_oneof(int c, char *set) {
	if (!set) return false;
	for (int i = 0; set[i]; i++) {
		if (c == set[i]) return true; 
	}
	return false;
}

bool use_whitespace(int c, tok_context_t *context) {
		switch (c) {
			case ' ': 
			case '\t':
			context->loc.col++;
			context->index++;
			return true;
			
			case '\v': 
			case '\f':
			context->loc.line++;
			context->index++;
			return true;
			
			case '\n':
			context->loc.line++;
			case '\r':
			context->loc.col = 1;
			context->index++;
			return true;
		}
		return false;
}

void fskip_whitespace(FILE *f, tok_context_t *context) {
	int c;
	do {
		c = getc(f);
		if (!use_whitespace(c, context)) break;
	} while(true);
	ungetc(c, f);
}



void skip_whitespace(char *str, tok_context_t *context) {
	for (size_t i = context->index; str[i]; i++) 
		if (!use_whitespace(str[i], context)) break;
}


source_loc_t *copy_loc(tok_context_t *context) {
	source_loc_t *beginning = malloc(sizeof(source_loc_t));
	memcpy(beginning, &context->loc, sizeof(source_loc_t));
	return beginning;	
}

token_t *process_delim_char(char c, tok_context_t *context, char *out_buffer,
	size_t *tok_i, bool *escaped, source_loc_t *beginning, char end_delim) {
	if (!(*escaped) && c == '\\') {
				*escaped = true;
				context->index++;
				context->loc.col++;
	}
	else {	
			out_buffer[(*tok_i)++] = c;
			if (!use_whitespace(c, context)) {
				context->index++;
				context->loc.col++;
				if (!(*escaped) && c == end_delim) {
					return new_token(out_buffer, *tok_i, beginning);
				}
			}
			*escaped = false;
	}	
	return 0;
}	


token_t *delim_stok(char *str, tok_context_t *context, char end_delim) {
	char delim = str[context->index++];
	char buffer[TOK_MAX_LEN];
	buffer[0] = delim;
	bool escaped = false;
	source_loc_t *beginning = copy_loc(context);
	context->loc.col++;
	size_t tok_i = 1;
	for (size_t i = context->index; str[i]; i++) {
		token_t *tok;
		if ((tok = process_delim_char(str[i], context, buffer, &tok_i, 
						&escaped, beginning, end_delim)))
				return tok;
	}
	return new_token(buffer, tok_i, beginning);
}



token_t *delim_ftok(FILE *file, tok_context_t *context, char end_delim) {
	char delim = getc(file);
	char buffer[TOK_MAX_LEN];
	buffer[0] = delim;
	bool escaped = false;
	source_loc_t *beginning = copy_loc(context);
	context->loc.col++;
	size_t tok_i = 1;
	int c;
	do {
		c = getc(file);
		if (c == '\0' || c == EOF) break;
		token_t *tok;
		if ((tok = process_delim_char(c, context, buffer, &tok_i, 
						&escaped, beginning, end_delim)))
				return tok;
	} while(true);
	return new_token(buffer, tok_i, beginning);
}




token_t *process_char(int c, tok_context_t *context, char 
		*out_buffer, size_t *tok_i, source_loc_t *loc, bool *unget) {
	if (is_oneof(c, context->operators)) {
			if (*tok_i){
				*unget = true;
				goto new_tok;
			}
			else {
				context->index++;
				context->loc.col++;
				out_buffer[0] = c;
				*tok_i = 1;
				goto new_tok;
			}
	}
	else if (isspace(c)){
		*unget = true;
		goto new_tok;
	}
	else {
			context->index++;
			context->loc.col ++;			
			out_buffer[(*tok_i)++] = c;
			return 0;
	}
	new_tok: {
		out_buffer[*tok_i] = 0;
		token_t *out = new_token(out_buffer, *tok_i, loc);
		return out;
	}
}


bool check_ptr(void *ptr, tok_context_t *context) {
	if (!ptr || !context) return false;
	if (context->pntr != ptr) {
		context->pntr = ptr;
		context->index = 0;
	}
	return true;
}


char matching_delim(int c, char *delims) {
	if (!delims) return 0;
	for (int i = 0; delims[i]; i++) {
		if (delims[i] == c && i % 2 == 0) {
			return delims[i+1];
		}
	}
	return 0;
}

token_t *stoken(char *str, tok_context_t *context) {
	token_t *pop = pop_token(context);
	if (pop) return pop;
	if (!check_ptr(str, context) || !strlen(str)) return 0;
	char buffer[TOK_MAX_LEN] = {0};
	size_t tok_i = 0;
	skip_whitespace(str, context);	
	source_loc_t *beginning = copy_loc(context);
	size_t i = context->index;
	char end_delim = matching_delim(str[i], context->delims);
	if (end_delim) {
		return delim_stok(str, context, end_delim);	
	}
	for (; str[i]; i++) {
		token_t *tok;
		bool u;
		if ((tok = process_char(str[i], context, buffer, &tok_i, beginning, &u)))
		 	return tok;
	}
	return new_token(buffer, tok_i, beginning);
}

token_t *ftoken(FILE *file, tok_context_t *context) {
	token_t *pop = pop_token(context);
	if (pop) return pop;
	if (!check_ptr(file, context)) return 0;
	char buffer[TOK_MAX_LEN] = {0};
	size_t tok_i = 0;
	fskip_whitespace(file, context);	
	source_loc_t *beginning = copy_loc(context);
	int c = getc(file);
	ungetc(c, file);
	char end_delim = matching_delim(c, context->delims);
	if (end_delim) {
		return delim_ftok(file, context, end_delim);
	}
	do {
		int c = getc(file);
		if (c == '\0' || c == EOF) {
			ungetc(c, file);
			if (tok_i) return new_token(buffer, tok_i, beginning);		
			else return 0;	
		}	
		token_t *tok;
		bool unget = false;
		if ((tok = process_char(c, context, buffer, &tok_i, beginning, &unget))) {
			if (unget) ungetc(c, file);
			return tok;
		}
	} while (true);
	return 0;	
}

