#ifndef PARSINGH
#define PARSINGH 0
#include "board.h"
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <wchar.h>


// Parses the given FEN into the given board, returns a pointer to an error message,
// or NULL if no error.
char *parse_fen(char * fen, full_board_t * board, piece_index_t * index_array);


// Writes a FEN description of the given board to the provided buffer
// returns the length of the created string
u_int8_t make_fen(full_board_t *board, char *fen_buffer);

void print_board(full_board_t *board);

typedef struct {
    char * position_str;
    char * turn_str;
    char * castling_str;
    char * ep_str;
    char * halfmove_str;
    char * fullmove_str;
    bool has_extra;
} split_fen_t;


#endif
