#include "pgn.h"

pgn_res_t make_err(char * str, size_t line) {
	pgn_res_t err = {.err = str, .error_line = line};
	return err;
}

pgn_res_t make_ok() {
	pgn_res_t ok = {.err = 0};
	return ok;
}

char *parse_tag_pair(char *line, char *name_dest, char *value_dest) {
	if (!line) return "Expected a tag pair, got an empty line";
	char *brkt;
	char *sep = " \t";
	char *tok = strtok_r(line, sep, &brkt);	
	if (tok && !strcmp(tok, "[")) {
		char *name_tok = strtok_r(0, sep, &brkt);
		if (name_tok) {
			char *value_tok = strtok_r(0, sep, &brkt);
			if (value_tok) {
				size_t len = strlen(value_tok);
				if (value_tok[0] == '"' && value_tok[len - 1] == '"') {
					value_tok[len - 1] = 0;
					value_tok++;
					strcpy(name_dest, name_tok);
					strcpy(value_dest, value_tok);
					return 0;	
				}
				else return "Invalid tag pair, value must quotes enclosed string";
			} 
			else return "Invalid tag pair, no value provided";
		}	
		else return "Invalid tag pair, [ followed by nothing";
	} else return "Expected an opening [ to start a tag pair";
}


pgn_res_t read_date(pgn_date_t *date, char *str, size_t current_line) {
	char *rest;	
	char *sep = ".";
	char *year = strtok_r(date, sep, &rest);
 	if (!year) return make_err("Missing year from date", current_line);
	if (strlen(year) != 4) return make_err("Year must be exactly 4 digits", current_line);
	int year_int;
	scanf(year, "%d", &year_int);
	if (year_int < 0 || year_int > 9999) 
		return make_err("Year must be between 0000 and 9999", current_line);
	date->year = year_int;

	char *month = strtok_r(0, sep, &rest);
 	if (!month) return make_err("missing moth from date", current_line);
	if (strlen(month) != 2) return make_err("month must be exactly 2 digits", current_line);
	int month_int;
	scanf(month, "%d", &month_int);
	if (month_int < 0 || month_int > 12) 
		return make_err("year must be between 00 and 12", current_line);
	date->month = month_int;
	
	char *day = strtok_r(0, sep, &rest);
 	if (!day) return make_err("Missing day from date", current_line);
	if (strlen(day) != 2) return make_err("Day must be exactly 2 digits", current_line);
	int day_int;
	scanf(day, "%d", &day_int);
	if (year_int < 0 || year_int > 9999) 
		return make_err("Year must be between 0000 and 9999", current_line);
	date->year = year_int;
	
}
pgn_res_t read_result(pgn_result_t *result, char *str);


#define PGN_NEEDED_TAGS 7
pgn_res_t read_tags(FILE *stream, pgn_tag_section_t *tags, size_t *current_line) {
	dict_t *dict = new_dict(100);
	char *err = 0;
	int tag_count = 0;
	while (!err) {
		char line[PGN_LINE];
		char key[PGN_LINE];
		char value[PGN_LINE];
		fgets(line,PGN_LINE, stream);
		bool is_empty = true;
	 	for (int i = 0; i < PGN_LINE && line[i]; i++) {
			if (!isspace(line[i])) {
				is_empty = true;
				break;
			}
		}
		if (is_empty) break;	
		err = parse_tag_pair(line, key, value);	
		if (tag_count++ < PGN_NEEDED_TAGS && err) return make_err(err, *current_line);
		dict_add(dict, key, value);
		(*current_line)++;
	}

	if (dict_remove(dict, "Event")) {
		strcpy(tags->event, dict->retrieved);
	} else return make_err("Missing Event tag", *current_line); 
	if (dict_remove(dict, "Site")) {
		strcpy(tags->site, dict->retrieved);
	} else return make_err("Missing Site tag", *current_line);
	if (dict_remove(dict, "Date")) {
		pgn_res_t res = read_date(&tags->date, dict->retrieved);
		if (res.err) return res;
	} else return make_err("Missing Date tag", *current_line);
	if (dict_remove(dict, "Round")) {
		strcpy(tags->round, dict->retrieved);		
	} else return make_err("Missing Round tag", *current_line);
	if (dict_remove(dict, "White")) {
		strcpy(tags->white_player, dict->retrieved);
	} else return make_err("Missing White tag", *current_line);
	if (dict_remove(dict, "Black")) {
		strcpy(tags->black_player, dict->retrieved);
	}	else return make_err("Missing Black tag", *current_line);
	if (dict_remove(dict, "Result")) {
		pgn_res_t res = read_result(&tags->result, dict->retrieved);
		if (res.err) return res;	
	} else return make_err("Missing Result tag", *current_line);

	// TODO Iterate through optional other tags

	return make_ok();	
}

#define NUM_MODE 0
#define WHITE_MODE 1
#define BLACK_MODE 2
#define RES_MODE 3
pgn_res_t read_moves(FILE * stream, san_move_t *moves, u_int16_t *count, size_t *current_line) {
	u_int16_t max_count = *count;
	char *rest;	
	char *space = " \t";
	char line[PGN_LINE];
	int move_i = 0;
	char mode = 0;
	char *tok = 0;
	while (fgets(line, PGN_LINE, stream)) {
		do {
			tok = strtok_r(tok ? NULL : line, space, &rest);
			switch (mode) {
				case NUM_MODE: {
					char expect[20];
					sprintf(expect, "%d.", move_i + 1);		
					if (strcmp(expect, tok)) {
						return make_err("Invalid turn number", *current_line);
					}
				}
				break;
				case RES_MODE: {
					pgn_result_t res; // unused
					return read_result(&res, tok);
				}
				case BLACK_MODE:
				case WHITE_MODE: {
					bool err;
					san_move_t san = parse_san(tok, &err);
					if (err) {
						return make_err("Invalid move specified", *current_line);
					}
					moves[move_i++] = san;
					if (move_i == max_count) mode = RES_MODE;
					else mode = (mode + 1) % 3;	
				}
				break;
			}
		} while(tok != 0);
		(*current_line)++;
	}
	*count = move_i;
	return make_ok();	
}

pgn_res_t read_pgn(FILE *stream, pgn_game_t *dst, size_t *current_line) {
	pgn_res_t res = read_tags(stream, &dst->tags, current_line);
	if (res.err) return res;
	res = read_moves(stream, dst->moves, &dst->count, current_line);
	return res;
}

pgn_res_t read_file(char * filename, pgn_game_t *dst) {
	size_t current_line = 0;
	FILE *stream = fopen(filename, "r");
	pgn_res_t res = read_pgn(stream, dst, &current_line);
	fclose(stream);
	return res;
}


