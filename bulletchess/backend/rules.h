#ifndef RULEHEADER
#define RULEHEADER 0
#include "apply.h"


// Checks if the given board is a possible position in a game
// Some examples of features of impossible positions:
// - 9 White Pawns 
// - 2 Black Kings
// - 3 Black Pawns, 6 Black Queens
char * is_legal(full_board_t * board);

// Generates the legal moves for the given position, filling out the 
// given buffer. Returns the number of moves generated
u_int8_t generate_legal_moves(full_board_t * board, move_t * buffer); 

// Returns a count of how many moves the given player can make.
// If the opponent is in check, a king capture is considered a move
// and is included in the count
u_int8_t count_legal_moves(full_board_t * board);


// Generates legal moves for only the specified piece type
u_int8_t generate_piece_moves(full_board_t *board, piece_type_t piece, move_t *buffer);


// Counts the number of pieces giving check to the side to move
u_int8_t get_checkers(full_board_t *board);


// Returns true if the given position is stalemate
bool is_stalemate(full_board_t *board);

// Returns true if the given position is checkmate
bool is_checkmate(full_board_t *board);

// Returns true if the given position was repeated n - 1 before. This is 
// checked by undoing the given move stack on a scratch board and comparing.
bool is_nfold_repetition(full_board_t *board, undoable_move_t *move_stack, 
								u_int16_t stack_size, u_int8_t n);

// returns true if there is insufficient mating material, a condition for a draw
bool is_insufficient_material(full_board_t * board);

// Returns true if the side to move is in check
bool in_check(full_board_t *board);

move_t san_to_move(full_board_t * board, san_move_t san);
typedef u_int8_t board_status_t;
#define NO_STATUS 0
#define CHECK_STATUS 1
#define MATE_STATUS 2
#define INSUFFICIENT_MATERIAL 4
#define FIFTY_MOVE_TIMEOUT 8
#define SEVENTY_FIVE_MOVE_TIMEOUT 16
#define THREE_FOLD_REPETITION 32
#define FIVE_FOLD_REPETITION 64
#define RESIGNATION 128

// Returns the outcome of the game this board is a part of 
board_status_t get_status(full_board_t * board, 
								undoable_move_t * stack,
								u_int16_t stack_size);


// Returns true if the given status is a draw
bool is_draw(board_status_t status);

#endif

