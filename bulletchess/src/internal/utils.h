#ifndef CHESSUTILHEADER
#define CHESSUTILHEADER
#include "rules.h"

double material(full_board_t *board, double pawn_val, double knight_val, double bishop_val, double rook_val, double queen_val);



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

bitboard_t isolated_pawns(full_board_t *board);

bitboard_t doubled_pawns(full_board_t *board);

#endif 
