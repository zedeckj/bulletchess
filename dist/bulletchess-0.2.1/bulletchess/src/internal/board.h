#ifndef CHESSHEADER 
#define CHESSHEADER 0
#include "piece.h"
#include "bitboard.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <errno.h> 
#include <ctype.h>
#include <math.h>
#include <string.h>

#define EMPTY_EP 64


typedef u_int8_t move_type_t;


#define ANY_COUNT 0xFF
typedef struct {
    bitboard_t pawns;
    bitboard_t knights;
    bitboard_t bishops;
    bitboard_t rooks;
    bitboard_t queens;
    bitboard_t kings;
    bitboard_t white_oc;
    bitboard_t black_oc;
} position_t;


typedef struct {
    u_int8_t white_pawns;
    u_int8_t white_knights;
    u_int8_t white_bishops;
    u_int8_t white_rooks;
    u_int8_t white_queens;
    u_int8_t black_pawns;
    u_int8_t black_knights;
    u_int8_t black_bishops;
    u_int8_t black_rooks;
    u_int8_t black_queens;
} piece_counts_t;

piece_counts_t count_pieces(position_t *position);


#define COUNT_PATTERN 1
#define BITBOARD_PATTERN 2
typedef struct {
	piece_t piece;
	u_int8_t pattern_type;
	union {
		u_int8_t count;
		bitboard_t bitboard;
	};
} piece_pattern_t;



typedef uint8_t castling_rights_t;

#define NO_CASTLING 0
#define WHITE_KINGSIDE 1
#define WHITE_QUEENSIDE 2
#define BLACK_KINGSIDE 4
#define BLACK_QUEENSIDE 8
#define WHITE_FULL_CASTLING 3
#define BLACK_FULL_CASTLING 12
#define FULL_CASTLING 15
#define ANY_KINGSIDE 5
#define ANY_QUEENSIDE 10

#define PAWNS_STARTING 71776119061282560ull
#define KNIGHTS_STARTING 4755801206503243842ull
#define BISHOPS_STARTING 2594073385365405732ull
#define ROOKS_STARTING 9295429630892703873ull
#define QUEENS_STARTING 576460752303423496ull
#define KINGS_STARTING 1152921504606846992ull
#define WHITE_STARTING 65535ull
#define BLACK_STARTING 18446462598732840960ull

typedef u_int64_t turn_clock_t;


typedef struct {
    position_t *position;
    piece_color_t turn;
    castling_rights_t castling_rights;
    optional_square_t en_passant_square;
    turn_clock_t halfmove_clock;
    turn_clock_t fullmove_number;
} full_board_t;


// fills the given board with the starting position
void starting_board(full_board_t *board);

// Returns true if the specified square index is empty
bool square_empty(position_t * board, square_t square);

// Clears the en passant square by setting the `exists` flag to false,
// and setting the square value to a dummy value
void clear_ep_square(full_board_t * board);

// Sets the en passant square and sets the `exists` flag to true.
void set_ep_square(full_board_t * board, square_t square);

// Deletes whatever piece is currently at the given square in the position.
// Has no effect if the square is already empty.
void delete_piece_at(position_t * position, square_t square);

// Only keeps bitboard values in the board which are the result
// of being &'d with the given mask
void mask_board_with(position_t * board, bitboard_t keep_bb);

// Sets the piece at the given square by updating the relvant bitboard
// and clearing all others 
void set_piece_at(position_t *position, square_t square, piece_t piece);

// Gets the piece at the given square
piece_t get_piece_at(position_t *position, square_t square);

// Makes the given position fully empty  
void clear_board(position_t *position);

// Checks if the given color has king-side castling rights
bool has_kingside_castling_rights(full_board_t* board, piece_color_t color);

// Checks if the given color has queen-side castling rights
bool has_queenside_castling_rights(full_board_t* board, piece_color_t color);


// Checks if the given color has any castling rights
bool has_castling_rights(full_board_t* board, piece_color_t color);

// Clears the given color's castling rights
void clear_castling_rights(full_board_t* board, piece_color_t color);

// Sets all castling rights to allowed
void set_full_castling_rights(full_board_t* board);

// Removes castling rights for a given color if they are illegal 
// in the given board's piece configuation
void update_castling_rights(full_board_t * board, piece_color_t color);


// Removes castling rights both colors if they are illegal 
// in the given board's piece configuation
void update_all_castling_rights(full_board_t * board);

// Returns true if the given positions are identical
bool positions_equal(position_t *pos1, position_t *pos2);

// Returns true if the given boards are equal in all aspects besides
// the halfmove and fullmove clocks, which are ignored
bool boards_legally_equal(full_board_t *board1, full_board_t * board2);

// Returns true if the given boards are equal in all aspects
bool boards_equal(full_board_t *board1, full_board_t * board2);



void str_write_board(full_board_t *board, char *buffer);

// TODO, dont belong here
bool in_check(full_board_t *board);
bool opponent_in_check(full_board_t * board);
u_int8_t get_checkers(full_board_t *board);
square_t fen_index_to_square(u_int8_t index);

// Returns true if the specified color occupies the given square
bool color_occupies(position_t * board, square_t square, piece_color_t color);


// Returns true if white occupies the given square
bool white_occupies(position_t * position, square_t square);


piece_index_t get_index_at(position_t *position, square_t square);


	// Returns true if black occupies the given square
bool black_occupies(position_t * position, square_t square);

// Returns true if the en passant square is the same as the provided
// square. Will always return False if the en passant square does not exist
bool en_passant_is(full_board_t * board, square_t square);

// Gets the piece at the given bitboard (What happens if there are multiple of the
// same piece?)
piece_t get_piece_at_bb(position_t * board, bitboard_t bb);

// Copies the contents of the source board to the dst board
void copy_into(full_board_t * dst, full_board_t * source);


// Counts the number of squares which have the given piece_type
u_int8_t count_piece_type(full_board_t * board, piece_type_t type); 

// Fills out an array reperesetnation of the board's position, with
// each square being an index and the value being an integer representation of
// a piece
void fill_piece_index_array(full_board_t *board, piece_index_t* index_array);

// Counts the number of pieces of a given type, with white counting positively
// and black counting negatively
int8_t net_piece_type(full_board_t * board, piece_type_t type);

// Pretty prints a Board's piece configuration
void print_board(full_board_t * board);

// Fills the given buffer with a string representing the piece configuartion of
// the given board
void fill_board_string(full_board_t * board, char * buffer); 

// Validates some basic aspects about the given board make it legal
// Returns an error string if invalid, or 0 if it is valid
char * validate_board(full_board_t * board);

// Gets a bitboard for the given piece type
bitboard_t get_piece_type_bb(position_t* position, piece_type_t piece_type);


// checks if the given new castling rights are legal
bool valid_castling(full_board_t *board, castling_rights_t new_castling);

bitboard_t get_piece_bb(position_t* position, piece_t piece);


void unicode_write_board(full_board_t *board, char *buffer, 
		u_int8_t text_color,
		u_int8_t light_color,
		u_int8_t dark_color,
		u_int8_t select_color,
		bitboard_t select_bb, 
		bitboard_t target_bb);
#endif

