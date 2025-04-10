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
    union {
        generic_move_t generic;
        promotion_move_t promotion;
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
// A promotion, resets halfmoves, resets EP (NOTICE PAWN MOVE)
// Following are only from internally generated
#define CASTLING_MOVE 4
// Has all known information that will be generated from finding legal moves
#define FULL_MOVE 5

typedef struct {
  move_t move;
  piece_t captured_piece;
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
// Returns any generated error messages
char *parse_uci(char * str, move_t *move);

// Produces an error string if this move is invalid in any way
char * error_from_move(move_t move);


// Writes a Move into a string using Standard Algebraic Notation,
// returns false if there was an error
bool write_san(san_move_t move, char * buffer);

// Writes a Move into a string using UCI notation
// returns false if there was an error
bool write_uci(move_t move, char * buffer);



castling_rights_t get_castling_type(move_t move, full_board_t *board);

san_move_t error_san();

san_move_t parse_san(char * str, bool * err);

square_t get_origin(move_t move);

square_t get_destination(move_t move);


#endif
