#include "board.h"
#include "apply.h"
#include "dictionary/dict.h"
#include "date-parsing/date.h"
#include "tokenizer/tokenizer.h"
#include "fen.h"
#include "rules.h"
#define ALL_KNOWN 0
#define DAY_UNK 1
#define MONTH_UNK 2
#define YEAR_UNK 4

#define DRAW_RES 0
#define WHITE_RES 1
#define BLACK_RES 2
#define UNK_RES 3

typedef u_int8_t pgn_result_t;


typedef struct {
	char *event;
	char *site;
	date_t date; 
	char *round; 
	char *white_player;
	char *black_player;
	u_int8_t result;
} pgn_tag_section_t;


typedef struct {
	//pgn_tag_section_t *tags;
	dict_t *raw_tags;
	date_t date;
	u_int8_t result;
	move_t *moves;
	full_board_t *starting_board;
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
	const char *err;
	source_loc_t *loc;
} pgn_res_t;

typedef struct {
	FILE *file;
	tok_context_t *ctx;
} pgn_file_t;

/* parsing functions assume pgn has been fully allocated in python */

// Returns true if succesfully parsed a PGN from the given filename
// If false, will write to the err buffer
bool read_pgn_file(char *filename, pgn_game_t *dst, char *err);

/* The following return an error string or 0 if ok*/

int next_pgn(pgn_file_t *pf, pgn_game_t *dst, char *err);


// Attempts to parse a <tag-pair>, Writes <tag-value> into value_dest
// and <tag-name> into name_dest. <tag-value> must be a ".+" (regex), and is stripped
// of quotes when parsed.



