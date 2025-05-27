#ifndef PIECEHEADER
#define PIECEHEADER 0 
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h> 
#include <ctype.h>
#include "compat.h"

typedef uint8_t piece_type_t;
typedef uint8_t piece_color_t;


#define EMPTY_VAL 0
#define PAWN_VAL 3
#define KNIGHT_VAL 4
#define BISHOP_VAL 5
#define ROOK_VAL 6
#define QUEEN_VAL 7
#define KING_VAL 8
#define ERROR_VAL 9

#define WHITE_VAL 1
#define BLACK_VAL 0

typedef struct {
    piece_color_t color;
    piece_type_t type;
} piece_t;

typedef u_int8_t piece_index_t;

// These are only for interfacing with Python quickly
#define EMPTY_INDEX 0
#define PAWN_INDEX 1
#define KNIGHT_INDEX 2
#define BISHOP_INDEX 3
#define ROOK_INDEX 4
#define QUEEN_INDEX 5
#define KING_INDEX 6
#define BLACK_OFFSET 6


// Checks if the given symbol is a valid serialization of a piece
bool is_piece_symbol(char c);

// Creates a new piece from the given symbol representation. This does not check if the 
// symbol is valid first.
//piece_t make_piece_from_symbol(char c);

// Checks if a piece is of the given type
bool piece_is_type(piece_t piece, piece_type_t type);

// Checks if a piece is of the given color
bool piece_is_color(piece_t piece, piece_color_t color);


// Checks if the given pieces are value equivalent
bool pieces_equal(piece_t piece1, piece_t piece2);

// Creates an int hash for a piece
u_int64_t hash_piece(piece_t piece1);

// Creates an empty piece
piece_t empty_piece();

// Creates a white piece of the given type
piece_t white_piece(piece_type_t type);

// Creates a black piece of the given type
piece_t black_piece(piece_type_t type);

// Returns a preconstructed error type piece
piece_t error_piece();

// Checks if a given piece is empty
bool piece_is_empty(piece_t piece);

// Converts a piece to an index, which can be used quickly for transport to python
piece_index_t piece_to_index(piece_t piece);

// Turns an index back into a piece
piece_t index_to_piece(piece_index_t index);

// Gets the symbol of this piece_type
char piece_type_symbol(piece_type_t piece_type);

// Gets the character representation of a piece
char piece_symbol(piece_t piece);

// Parses the given symbol to a Piece. An error piece
// is returned if the symbol is invalid
piece_t piece_from_symbol(char symbol);

// Parses a piece from a string, asserting that the string is only of length 1
piece_t piece_from_string(char *piece_string);

// Returns a string constant of a piece types name, "Pawn", "Bishop", etc.
const char *get_piece_name(piece_type_t type);

// Writes the given piece types name, (ex. Pawn, Bishop) to the string
// buffer
void write_name(piece_type_t type, char *buffer);



char *piece_unicode(piece_t piece);
#endif
