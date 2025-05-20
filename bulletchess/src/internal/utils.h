#ifndef CHESSUTILHEADER
#define CHESSUTILHEADER
#include "rules.h"

int64_t material(full_board_t *board, int64_t pawn_val, int64_t knight_val, int64_t bishop_val, int64_t rook_val, int64_t queen_val);


int32_t shannon_evaluation(full_board_t * board, undoable_move_t * stack, u_int8_t stack_size);

u_int64_t perft(full_board_t * board, u_int8_t depth);

// Naively, a position is considered quiescent if the side to move is not 
// being attacked by any of the opponents pieces. Note that this function
// utilizes make_attack_mask, which "zeroes" out the friendly king. However,
// this doesn't matter here since the result is binary. If more pieces are stated
// to be under attack then there actually are due to zeroing the king, the king
// is still under attack.
bool is_quiescent(full_board_t *board);


// A backwards pawn is considered to be a pawn which is not defended by friendly pawns,
// and has any piece (including empty) besides a non enemy pawn in front of it which it cannot advance to or can be captured by an enemy pawn
bitboard_t backwards_pawns(full_board_t *board);
bitboard_t white_backwards_pawns(full_board_t *board);
bitboard_t black_backwards_pawns(full_board_t *board);

bitboard_t isolated_pawns(full_board_t *board);
bitboard_t white_isolated_pawns(full_board_t *board);
bitboard_t black_isolated_pawns(full_board_t *board);

bitboard_t doubled_pawns(full_board_t *board);
bitboard_t white_doubled_pawns(full_board_t *board);
bitboard_t black_doubled_pawns(full_board_t *board);

bitboard_t open_files(full_board_t *board);

bitboard_t half_open_files(full_board_t *board, piece_color_t color);

bitboard_t passed_pawns(full_board_t *board);
bitboard_t white_passed_pawns(full_board_t *board);
bitboard_t black_passed_pawns(full_board_t *board);

move_t random_legal_move(full_board_t *board);

bool is_pinned(full_board_t *board, square_t square);
#endif 
