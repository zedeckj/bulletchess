#ifndef PARSINGH
#define PARSINGH 0
#include "board.h"
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include <stdio.h>


// Parses the given FEN into the given board, returns a pointer to an error message,
// or NULL if no error.
char * parse_fen(char * fen, full_board_t * board);


// Writes a FEN description of the given board to the provided buffer
void make_fen(full_board_t *board, char *fen_buffer);

// rank should be lower case, and file 0 indexed
square_t make_square(char rank, char file);

// rank and file should be the literals read from a string
bool valid_square_chars(char rank, char file);

char file_char_of_square(square_t square);

char rank_char_of_square(square_t square);

// Gets the symbol of this piece_type
char piece_type_symbol(piece_type_t piece_type);

// Gets the character representation of a piece
char piece_symbol(piece_t piece);

typedef struct {
    char * position_str;
    char * turn_str;
    char * castling_str;
    char * ep_str;
    char * halfmove_str;
    char * fullmove_str;
} split_fen_t;


#endif