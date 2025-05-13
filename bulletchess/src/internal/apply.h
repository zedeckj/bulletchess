#ifndef APPLYHEADER
#define APPLYHEADER 0
#include "move.h"

// Applies a move to a board, and returns a struct which can be used
// to undo the move
undoable_move_t apply_move(full_board_t *board, move_t move);

//apply move version which fills out a pointer
void apply_move_ext(full_board_t *board, move_t move, undoable_move_t *undoable);

// Undoes the given move
void undo_move(full_board_t * board, undoable_move_t move);	




#endif
