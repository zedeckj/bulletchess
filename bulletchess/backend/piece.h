#ifndef PIECEHEADER
#define PIECEHEADER 0 
#include <inttypes.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h> 
#include <ctype.h>
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
#define BLACK_VAL 2

typedef struct {
    piece_color_t color;
    piece_type_t type;
} piece_t;





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

piece_t error_piece();

// Checks if a given piece is empty
bool piece_is_empty(piece_t piece);

#endif
