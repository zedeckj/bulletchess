#ifndef CHESSHEADER 
#define CHESSHEADER 0
#include "piece.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <errno.h> 
#include <ctype.h>
#include <math.h>
#include <string.h>

// from whites perspective
#define ABOVE(s) ((s) + 8)
#define BELOW(s) ((s) - 8)
#define LEFT(s) ((s) - 1)
#define RIGHT(s) ((s) + 1)
#define RANKNUM(s) (((s) % 8) + 1)
#define FILE(s) (((s) / 8) + 1) // 1 indexed
#define LSB(s) ((s) & -(s))

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
#define EMPTY_EP 64

#define SQUARE_TO_BB(s) (1llu << (s))

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

#define RANK_1 0xffllu
#define RANK_2 (0xffllu << 8)
#define RANK_3 (0xffllu << 16)
#define RANK_4 (0xffllu << 24)
#define RANK_5 (0xffllu << 32)
#define RANK_6 (0xffllu << 40)
#define RANK_7 (0xffllu << 48)
#define RANK_8 (0xffllu << 56)

#define FULL_BB 0xFFFFFFFFFFFFFFFFllu
#define FILE_A 0x0101010101010101llu
#define FILE_B (FILE_A << 1)
#define FILE_F (FILE_A << 6)
#define FILE_H (FILE_A << 7)



#define ABOVE_BB(bb) ((bb) << 8)
#define BELOW_BB(bb) ((bb) >> 8)

#define SAFE_ABOVE_BB(bb) (((bb) & ~RANK_8) << 8)
#define SAFE_BELOW_BB(bb) (((bb) & ~RANK_1) >> 8)

#define SAFE_TWO_ABOVE_BB(bb) (((bb) & ~RANK_8 & ~RANK_7) << 16)
#define SAFE_TWO_BELOW_BB(bb) (((bb) & ~RANK_1 & ~RANK_2) >> 16)

#define SAFE_LEFT_BB(bb) (((bb) & ~FILE_A) >> 1)
#define SAFE_RIGHT_BB(bb) (((bb) & ~FILE_H) << 1)

#define SAFE_TWO_LEFT_BB(bb) (((bb) & ~FILE_A & ~FILE_B) >> 2)
#define SAFE_TWO_RIGHT_BB(bb) (((bb) & ~FILE_H & ~FILE_F) << 2)

#define SAFE_KNIGHT_MOVE_BB1(bb) SAFE_LEFT_BB(SAFE_TWO_ABOVE_BB(bb))
#define SAFE_KNIGHT_MOVE_BB2(bb) SAFE_RIGHT_BB(SAFE_TWO_ABOVE_BB(bb))

#define SAFE_KNIGHT_MOVE_BB3(bb) SAFE_LEFT_BB(SAFE_TWO_BELOW_BB(bb))
#define SAFE_KNIGHT_MOVE_BB4(bb) SAFE_RIGHT_BB(SAFE_TWO_BELOW_BB(bb))

#define SAFE_KNIGHT_MOVE_BB5(bb) SAFE_TWO_LEFT_BB(SAFE_ABOVE_BB(bb))
#define SAFE_KNIGHT_MOVE_BB6(bb) SAFE_TWO_RIGHT_BB(SAFE_ABOVE_BB(bb))

#define SAFE_KNIGHT_MOVE_BB7(bb) SAFE_TWO_LEFT_BB(SAFE_BELOW_BB(bb))
#define SAFE_KNIGHT_MOVE_BB8(bb) SAFE_TWO_RIGHT_BB(SAFE_BELOW_BB(bb))


typedef uint8_t square_t;
typedef uint64_t bitboard_t;

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

#define NO_CASTLING
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

typedef uint16_t turn_clock_t;

typedef struct {
    square_t square;
    bool exists;
} optional_square_t;

typedef piece_color_t piece_color8_t __attribute__ ((vector_size(8)));

typedef struct {
    position_t *position;
    piece_color_t turn;
    castling_rights_t castling_rights;
    optional_square_t en_passant_square;
    turn_clock_t halfmove_clock;
    turn_clock_t fullmove_number;
//    move_stack_t *move_stack;
} full_board_t;



u_int8_t count_bits(bitboard_t bb);

bool square_empty(position_t * board, square_t square);
void clear_ep_square(full_board_t * board);
void set_ep_square(full_board_t * board, square_t square);
void delete_piece_at(position_t * position, square_t square);
void mask_board_with(position_t * board, bitboard_t keep_bb);
void set_piece_at(position_t *position, square_t square, piece_t piece);

piece_t get_piece_at(position_t *position, square_t square);
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

square_t fen_index_to_square(u_int8_t index);


bool positions_equal(position_t *pos1, position_t *pos2);


bool in_check(full_board_t *board);
bool opponent_in_check(full_board_t * board);

u_int8_t get_checkers(full_board_t *board);

bool color_occupies(position_t * board, square_t square, piece_color_t color);
bool white_occupies(position_t * position, square_t square);
bool black_occupies(position_t * position, square_t square);

bool en_passant_is(full_board_t * board, square_t square);
piece_t get_piece_at_bb(position_t * board, bitboard_t bb);
void print_bitboard(bitboard_t board);

void copy_into(full_board_t * dst, full_board_t * source);
#endif

