#include "apply.h"
#include "dictionary/dict.h"


#define ALL_KNOWN 0
#define DAY_UNK 1
#define MONTH_UNK 2
#define YEAR_UNK 4

typedef struct {
	u_int8_t day;
	u_int8_t month;
	u_int16_t year;	
	u_int8_t known_mask;
} pgn_date_t;

#define DRAW_RES 0
#define WHITE_RES 1
#define BLACK_RES 2
#define UNK_RES 3

typedef u_int8_t pgn_result_t;

typedef struct {
	char *tag_name;
	char *value;
} pgn_other_tag_t;

typedef struct {
	char *event;
	char *site;
	pgn_date_t date;
	char *round;
	char *white_player;
	char *black_player;
	pgn_result_t result;
	
	pgn_other_tag_t *other_tags;
	u_int8_t other_tag_count;
} pgn_tag_section_t;


typedef struct {
	pgn_tag_section_t tags;
	san_move_t *moves;
	u_int16_t count;
} pgn_game_t;


/*
https://www.saremba.de/chessgml/standards/pgn/pgn-complete.htm#c18
	 
<PGN-database> ::= <PGN-game> <PGN-database>
                   <empty>

<PGN-game> ::= <tag-section> <movetext-section>

<tag-section> ::= <tag-pair> <tag-section>
                  <empty>

<tag-pair> ::= [ <tag-name> <tag-value> ]

<tag-name> ::= <identifier>

<tag-value> ::= <string>

<movetext-section> ::= <element-sequence> <game-termination>

<element-sequence> ::= <element> <element-sequence>
                       <recursive-variation> <element-sequence>
                       <empty>

<element> ::= <move-number-indication>
              <SAN-move>
              <numeric-annotation-glyph>

<recursive-variation> ::= ( <element-sequence> )

<game-termination> ::= 1-0
                       0-1
                       1/2-1/2
                       *
<empty> ::=
*/

/* all these return 0 if ok, else an error struct pointer*/


#define PGN_LINE 256


typedef struct {
	char *err;
	size_t error_line;
} pgn_res_t;




/* parsing functions assume pgn has been fully allocated in python */

pgn_res_t read_file(char *filename, pgn_game_t *dst);

pgn_res_t read_pgn(FILE *stream, pgn_game_t *dst, size_t *current_line);

pgn_res_t read_tags(FILE *stream, pgn_tag_section_t *tags, size_t *current_line);

pgn_res_t read_moves(FILE *stream, san_move_t *moves, 
										u_int16_t *count, size_t *current_line);


// Attempts to parse a <tag-pair>, Writes <tag-value> into value_dest
// and <tag-name> into name_dest. <tag-value> must be a ".+", and is stripped
// of quotes when parsed.
char read_tag_pair(char * line, char* name_dest, char *value_dest);



