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


square_t fen_index_to_square(u_int8_t index);

// Parses the given FEN into the given board, returns a pointer to an error message,
// or NULL if no error.
char *parse_fen(const char *fen, full_board_t * board);


// Writes a FEN description of the given board to the provided buffer
// returns the length of the created string
u_int8_t make_fen(full_board_t *board, char *fen_buffer);


// Parses the given str into the provided castling rights pointer. 
// Returns 0 on success, or an error message
char *parse_castling(char *str, castling_rights_t *castling_rights);

char *castling_fen(castling_rights_t castling);

void print_board(full_board_t *board);

char *castling_fen(castling_rights_t castling_rights);

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
