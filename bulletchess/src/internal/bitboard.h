#ifndef BITBOARDHEADER
#define BITBOARDHEADER 0
#include "piece.h"
#include <stdbool.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

typedef u_int8_t square_t;
typedef u_int64_t bitboard_t;


typedef struct {
    square_t square;
    bool exists;
} optional_square_t;



// Macros for square_t
#define ABOVE(s) ((s) + 8)
#define BELOW(s) ((s) - 8)
#define LEFT(s) ((s) - 1)
#define RIGHT(s) ((s) + 1)
#define RANKNUM(s) (((s) % 8) + 1)
#define FILENUM(s) (((s) / 8) + 1) // 1 indexed
#define SQUARE_TO_BB(s) (1llu << (s))

#define A1 0
#define B1 1
#define C1 2
#define D1 3
#define E1 4
#define F1 5
#define G1 6
#define H1 7
#define A2 8
#define B2 9
#define C2 10
#define D2 11
#define E2 12
#define F2 13
#define G2 14
#define H2 15
#define A3 16
#define B3 17
#define C3 18
#define D3 19
#define E3 20
#define F3 21
#define G3 22
#define H3 23
#define A4 24
#define B4 25
#define C4 26
#define D4 27
#define E4 28
#define F4 29
#define G4 30
#define H4 31
#define A5 32
#define B5 33
#define C5 34
#define D5 35
#define E5 36
#define F5 37
#define G5 38
#define H5 39
#define A6 40
#define B6 41
#define C6 42
#define D6 43
#define E6 44
#define F6 45
#define G6 46
#define H6 47
#define A7 48
#define B7 49
#define C7 50
#define D7 51
#define E7 52
#define F7 53
#define G7 54
#define H7 55
#define A8 56
#define B8 57
#define C8 58
#define D8 59
#define E8 60
#define F8 61
#define G8 62
#define H8 63
#define ERR_SQ 64


// Macros for bitboard_t
#define LSB(s) ((s) & -(s))
#define forbitboard2(VAR_NAME, REMAINING, VAL)\
for (bitboard_t VAR_NAME, REMAINING = VAL;\
		(VAR_NAME = LSB(REMAINING));\
		REMAINING &= ~VAR_NAME)\



#define forbitboard(VAR_NAME, VAL)\
for (bitboard_t VAR_NAME, _bad_macro_system = VAL;\
		(VAR_NAME = LSB(_bad_macro_system));\
		_bad_macro_system &= ~VAR_NAME)\

/* forbitboard(knight, knights) {
 *	... do something for all knights
 * }
 * ->
 * for (bitboard_t knight, temp = knights;
 * 			knight = LSB(temp);
 * 			temp &= ~knight) {
 *		...
 * 	}  
 */



#define A1_BB (1llu << A1)
#define B1_BB (1llu << B1)
#define C1_BB (1llu << C1)
#define D1_BB (1llu << D1)
#define E1_BB (1llu << E1)
#define F1_BB (1llu << F1)
#define G1_BB (1llu << G1)
#define H1_BB (1llu << H1)


#define E8_BB (1llu << E8)
#define G8_BB (1llu << G8)
#define F8_BB (1llu << F8)
#define C8_BB (1llu << C8)
#define A8_BB (1llu << A8)
#define H8_BB (1llu << H8)
#define D8_BB (1llu << D8)

#define CORNERS_BB (A1_BB | A8_BB | H1_BB | H8_BB)

#define RANK_1 0xffllu
#define RANK_2 (RANK_1 << 8)
#define RANK_3 (RANK_1 << 16)
#define RANK_4 (RANK_1 << 24)
#define RANK_5 (RANK_1 << 32)
#define RANK_6 (RANK_1 << 40)
#define RANK_7 (RANK_1 << 48)
#define RANK_8 (RANK_1 << 56)

#define FULL_BB 0xFFFFFFFFFFFFFFFFllu

#define FILE_A 0x0101010101010101llu
#define FILE_B (FILE_A << 1)
#define FILE_C (FILE_A << 2)
#define FILE_D (FILE_A << 3)
#define FILE_E (FILE_A << 4)
#define FILE_F (FILE_A << 5)
#define FILE_G (FILE_A << 6)
#define FILE_H (FILE_A << 7)

#define LIGHT_SQ_BB 6172840429334713770L 
#define DARK_SQ_BB ~6172840429334713770L

#define ABOVE_BB(bb) ((bb) << 8)
#define BELOW_BB(bb) ((bb) >> 8)

#define SAFE_ABOVE_BB(bb) (((bb) & ~RANK_8) << 8)
#define SAFE_BELOW_BB(bb) (((bb) & ~RANK_1) >> 8)

#define SAFE_TWO_ABOVE_BB(bb) (((bb) & ~RANK_8 & ~RANK_7) << 16)
#define SAFE_TWO_BELOW_BB(bb) (((bb) & ~RANK_1 & ~RANK_2) >> 16)

#define SAFE_LEFT_BB(bb) (((bb) & ~FILE_A) >> 1)
#define SAFE_RIGHT_BB(bb) (((bb) & ~FILE_H) << 1)

#define SAFE_TWO_LEFT_BB(bb) (((bb) & ~FILE_A & ~FILE_B) >> 2)
#define SAFE_TWO_RIGHT_BB(bb) (((bb) & ~FILE_H & ~FILE_G) << 2)

#define SAFE_KNIGHT_MOVE_BB1(bb) SAFE_LEFT_BB(SAFE_TWO_ABOVE_BB(bb))
#define SAFE_KNIGHT_MOVE_BB2(bb) SAFE_RIGHT_BB(SAFE_TWO_ABOVE_BB(bb))

#define SAFE_KNIGHT_MOVE_BB3(bb) SAFE_LEFT_BB(SAFE_TWO_BELOW_BB(bb))
#define SAFE_KNIGHT_MOVE_BB4(bb) SAFE_RIGHT_BB(SAFE_TWO_BELOW_BB(bb))

#define SAFE_KNIGHT_MOVE_BB5(bb) SAFE_TWO_LEFT_BB(SAFE_ABOVE_BB(bb))
#define SAFE_KNIGHT_MOVE_BB6(bb) SAFE_TWO_RIGHT_BB(SAFE_ABOVE_BB(bb))

#define SAFE_KNIGHT_MOVE_BB7(bb) SAFE_TWO_LEFT_BB(SAFE_BELOW_BB(bb))
#define SAFE_KNIGHT_MOVE_BB8(bb) SAFE_TWO_RIGHT_BB(SAFE_BELOW_BB(bb))


#define SAFE_NW_BB(bb) SAFE_ABOVE_BB(SAFE_LEFT_BB(bb)) 
#define SAFE_NE_BB(bb) SAFE_ABOVE_BB(SAFE_RIGHT_BB(bb))
#define SAFE_SW_BB(bb) SAFE_BELOW_BB(SAFE_LEFT_BB(bb))
#define SAFE_SE_BB(bb) SAFE_BELOW_BB(SAFE_RIGHT_BB(bb))

bitboard_t file_bb_of_square(square_t sq);

bitboard_t rank_bb_of_square(square_t sq);

// Counts the number of bits which are 1
u_int8_t count_bits_func(bitboard_t bb);

#ifdef _MSC_VER  
#define count_bits(bb) __builtin_popcountll(bb)
#else
#define count_bits(bb) count_bits_func(bb)
#endif

void str_write_bitboard(bitboard_t board, char *buffer);

// Pretty prints a bitboard as 8 ranks and 8 files of bits
void print_bitboard(bitboard_t board);

// Returns true if the give square's bit is 1 in the given bitboard
bool square_in_bitboard(bitboard_t board, square_t square);

// Parses a string into an optional_square. If the given string is invalid,
// the optional_square exists flag is set to false
// Can parse a string of any length greater than 1. Will ignore characters beyond
// the first two.
optional_square_t parse_square(char * str);

// Serializes the given square into a format like `e2` by writing 
// into the provided buffer. Does not check for validity of square
bool serialize_square(square_t square, char * buffer);

// Assumes that the given rank and file are already verified.
// The file should be a value from 'a' to 'h' or 'A' to 'H', and the rank '1' to '8'. 
square_t make_square(char file, char rank);

// Transforms this bitboard into a square, if there is only a single 1.
optional_square_t bitboard_to_square(bitboard_t bitboard);


// Validates that the file is a value from 'a' to 'h' or 'A' to 'H', 
// and the rank '1' to '8'. 
bool valid_square_chars(char rank, char file);

// Returns the character representing the file of the square. Assumes a valid square
char file_char_of_square(square_t square);

// Returns the character representing the rank of the square, Assumes valid.
char rank_char_of_square(square_t square);

// Writes a square in the format "A1" or "H3"
bool serialize_sqr_caps(square_t square, char *buffer);
	
	// Takes an array of squares, and its length, and fills out a bitboard
bitboard_t from_squares(square_t * square, u_int8_t length);

// Wrapper around the SAFE_ABOVE_BB macro
bitboard_t above_bb(bitboard_t bb);

// Wrapper around the SAFE_BELOW_BB macro
bitboard_t below_bb(bitboard_t bb);

// Wrapper around the SAFE_LEFT_BB macro
bitboard_t left_bb(bitboard_t bb);

// Wrapper around the SAFE_RIGHT_BB macro
bitboard_t right_bb(bitboard_t bb);

// Does not check for validity, assumes there is one valid square
square_t unchecked_bb_to_square(bitboard_t bb);

#endif
