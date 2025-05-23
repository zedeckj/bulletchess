#ifndef BULLETHTML
#define BULLETHTML
#include "board.h"
#include "fen.h"

// codegen'd function which fills the buffer with an html
// rep of a board
void board_html(full_board_t *board, char * buffer);

#endif
