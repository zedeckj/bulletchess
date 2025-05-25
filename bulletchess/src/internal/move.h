#ifndef MOVEHEADER
#define MOVEHEADER 0
#include "board.h"
// The move.c file will not only define moves, but their application to boards

// typedef struct {
//     square_t origin;
//     square_t destination;
// } reg_move_t;

// typedef struct {
//     square_t origin;
//     square_t destination;
//     piece_type_t promote_to;
// } promotion_t;

typedef struct {
	bool exists;
	u_int8_t value;
} optional_u_int8_t;

#define SAN_ERR 0
#define SAN_STD 1
#define SAN_PAWN_PUSH 2
#define SAN_PAWN_CAPTURE 3
#define SAN_CASTLING 4

typedef struct {
	piece_type_t moving_piece;
	optional_u_int8_t from_file;
	optional_u_int8_t from_rank;
	bool is_capture;
	square_t destination;
	
} san_std_move_t;

typedef struct {
	optional_u_int8_t from_file;
	optional_u_int8_t from_rank;
	square_t destination;
	piece_type_t promote_to;
} san_pawn_push_t;

typedef struct {
	u_int8_t from_file;
	optional_u_int8_t from_rank;
	square_t destination;
	piece_type_t promote_to;
} san_pawn_capture_t;

#define NO_ANN 0
#define BLUNDER_ANN 1
#define MISTAKE_ANN 2
#define DUBIOUS_ANN 3
#define INTEREST_ANN 4
#define GOOD_ANN 5
#define BRILLIANT_ANN 6 
#define ERROR_ANN 7

#define SAN_NOCHECK 0
#define SAN_CHECK 1
#define SAN_CHECKMATE 2

typedef struct {
	union {
		san_std_move_t std_move;
		san_pawn_push_t pawn_push;
		san_pawn_capture_t pawn_capture;
		bool castling_kingside;
	};
	u_int8_t type;
	u_int8_t ann_type;
	u_int8_t check_status;
} san_move_t;


typedef struct {
    square_t origin;
    square_t destination;
} generic_move_t;

typedef struct {
    generic_move_t body;
    piece_type_t promote_to; 
} promotion_move_t; 

typedef struct {
	generic_move_t body;
	piece_type_t moving_type;
} full_move_t;


typedef struct {
    union {
        generic_move_t generic;
        promotion_move_t promotion;
				//full_move_t full;
		};
    move_type_t type;
} move_t;


#define NULL_MOVE 0
// A Null move signifies a "pass", rather than an error
#define ERROR_MOVE 1
// Signifes an invalid move was parsed
#define GENERIC_MOVE 2
// A move with no information besides that it is not a promotion (UCI limitation)
#define PROMOTION_MOVE 3

// generated only internally, provided extra information that makes
// applying moves faster
#define FULL_MOVE 4

typedef struct {
  move_t move;
	piece_t captured_piece;
  piece_type_t moved_piece; 
	castling_rights_t old_castling_rights;
	castling_rights_t was_castling;
  optional_square_t old_en_passant;
	turn_clock_t old_halfmove;
} undoable_move_t;



// constructors

move_t error_move();

move_t null_move();

generic_move_t move_body(square_t origin, square_t destination);

move_t generic_move(generic_move_t move);

move_t make_move_from_parts(square_t origin, square_t destination, piece_type_t promote_to);

move_t promotion_move(generic_move_t body, piece_type_t promote_to);


// Uniquely hashes a move
u_int64_t hash_move(move_t move);

// Unhashes a move
move_t unhash_move(u_int64_t move_hash);


// Parses a valid move from a given uci str. 
// Returns any allocated generated error messages
char *parse_uci(char * str, move_t *move);

// Allocates an error string if this move is invalid in any way
char * error_from_move(move_t move);


// Writes a Move into a string using Standard Algebraic Notation,
// returns false if there was an error
bool write_san(san_move_t move, char * buffer);

// Writes a Move into a string using UCI notation
// returns false if there was an error
bool write_uci(move_t move, char * buffer);


// Checks if the given string can be parsed as a san-move.
// This does not determine if it is legal for a given board,
// but well formed in general
bool is_san_correct(char *buffer);


// Instantiates all legal moves, returns how many were created
u_int16_t create_all_legal(move_t *moves, u_int64_t *hashes);


castling_rights_t get_castling_type(move_t move, full_board_t *board);

san_move_t error_san();

san_move_t parse_san(char * str, bool *err);

square_t get_origin(move_t move);

square_t get_destination(move_t move);


bool moves_equal(move_t move1, move_t move2);

// Returns the empty piece val for a non promotion move
piece_type_t get_promotes_to(move_t move);

#define US_ORIGIN_INDEX 0
#define US_DEST_INDEX 1
#define US_PROMOTE_TO_INDEX 2
#define US_OLD_CASTLING_RIGHTS_INDEX 3
#define US_WAS_CASTLING_INDEX 4
#define US_OLD_EP_EXISTS_INDEX 5
#define US_OLD_EP_VALUE_INDEX 6
#define US_OLD_HALF_UPPER_INDEX 7
#define US_OLD_HALF_LOWER_INDEX 8
#define US_END_INDEX 9



#endif
