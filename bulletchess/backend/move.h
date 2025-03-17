#ifndef MOVEHEADER
#define MOVEHEADER 0
#include "board.h"
#include "serialization.h"
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


/*
typedef struct move_list {
	undoable_move_t car;
	struct move_list * cdr;
} move_list_t;

// Represents a board with extra state used for move generation
typedef struct {
	full_board_t * board;
	move_list_t * move_list_t;
} stateful_board_t;
	
// Pushes an undoable move to the move stack, growing the stack's 
// capacity if needed, and increasing the length by 1
*/



inline void do_castling(full_board_t * board, square_t king_origin, square_t king_dest, square_t rook_origin, bitboard_t rook_dest);
inline void do_white_kingside(full_board_t *board);
inline void do_white_queenside(full_board_t *board);
inline void do_black_kingside(full_board_t *board);
inline void do_black_quenside(full_board_t *board);
// Aplies a move to the given board


undoable_move_t apply_move(full_board_t *board, move_t move);

move_t undo_move(full_board_t * board, undoable_move_t move);	


//void full_apply_move(stateful_board_t *stateful_board, );




// Parses a UCI formatted string into a move_t, returns an Error move
// if the given string is ill-formatted
move_t parse_uci(char * uci_str);

// Writes the given move's UCI representation to a provided buffer of length 6
// Returns false if given an invalid move.
bool write_uci(move_t move, char * buffer);



u_int8_t generate_legal_moves(full_board_t * board, move_t * buffer);



// // Initializes the global move table if it is not already
// void prepare_move_table();



#endif
