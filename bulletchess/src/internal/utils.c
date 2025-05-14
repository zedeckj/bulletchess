#include "utils.h"
#include "fen.h"
#include "rules.h"

// Naively, a position is considered quiescent if the side to move is not 
// being attacked by any of the opponents pieces. Note that this function
// utilizes make_attack_mask, which "zeroes" out the friendly king. However,
// this doesn't matter here since the result is binary. If more pieces are stated
// to be under attack then there actually are due to zeroing the king, the king
// is still under attack.
bool is_quiescent_old(full_board_t *board) {
		bitboard_t friendly_oc;
		piece_color_t attacker;
		if (board->turn == WHITE_VAL) {
			attacker = BLACK_VAL;
			friendly_oc = board->position->white_oc;
		}
		else {
			attacker = WHITE_VAL;
			friendly_oc = board->position->black_oc;
		}
		bitboard_t attack_mask = make_attack_mask(board, attacker);
		return !(attack_mask & friendly_oc);
}

// this version is flipped, a position is quiet if there are no captures able to be made
bool is_quiescent(full_board_t *board) {
	if (in_check(board)) return false; 
	move_t moves[256];
	int count = generate_legal_moves(board, moves);
	bitboard_t hostile_oc = board->turn == BLACK_VAL ? 
		board->position->white_oc : board->position->black_oc;
	for (int i = 0; i < count; i++) {
		if (SQUARE_TO_BB(get_destination(moves[i])) & hostile_oc) return false;
	}
	return true;
}

bitboard_t backwards_pawns(full_board_t *board) {
	position_t *position = board->position;
	bitboard_t white_pawns = position->pawns & position->white_oc;
	bitboard_t black_pawns = position->pawns & position->black_oc;
	
	bitboard_t white_non_paired = ~SAFE_BELOW_BB(black_pawns) & white_pawns;
	bitboard_t black_non_paired = ~SAFE_ABOVE_BB(white_pawns) & black_pawns;
		

	bitboard_t white_pawn_attacks = white_pawn_attack_mask(white_pawns, FULL_BB);
	bitboard_t black_pawn_attacks = black_pawn_attack_mask(black_pawns, FULL_BB);

	bitboard_t white_cant_advance = SAFE_BELOW_BB(black_pawn_attacks) 
		& white_non_paired; 

	bitboard_t black_cant_advance = SAFE_ABOVE_BB(white_pawn_attacks) 
		& black_non_paired;

	bitboard_t white_backwards = ~white_pawn_attacks & white_cant_advance;
	
	bitboard_t black_backwards = ~black_pawn_attacks & black_cant_advance;
	
	return white_backwards | black_backwards;
}

bitboard_t isolated_pawns(full_board_t *board) {
	position_t *position = board->position;
	bitboard_t white_pawns = position->pawns & position->white_oc;
	bitboard_t black_pawns = position->pawns & position->black_oc;
	bitboard_t isolated = 0;
	forbitboard(one_pawn_bb, white_pawns) {
		bitboard_t file_bb = vertical_attack_mask(one_pawn_bb, FULL_BB, FULL_BB) | one_pawn_bb; 
		if (!(SAFE_LEFT_BB(file_bb) & white_pawns 
			  || SAFE_RIGHT_BB(file_bb) & white_pawns)) isolated |= one_pawn_bb;
	}

	forbitboard(one_pawn_bb, black_pawns) {
		bitboard_t file_bb = vertical_attack_mask(one_pawn_bb, FULL_BB, FULL_BB) | one_pawn_bb; 
		if (!(SAFE_LEFT_BB(file_bb) & black_pawns 
			  || SAFE_RIGHT_BB(file_bb) & black_pawns)) isolated |= one_pawn_bb;
	}
	return isolated;
}


bitboard_t doubled_pawns(full_board_t * board) {
	position_t *position = board->position;
	bitboard_t white_pawns = position->pawns & position->white_oc;
	bitboard_t black_pawns = position->pawns & position->black_oc;
	bitboard_t doubled = 0;
	forbitboard(one_pawn_bb, white_pawns) {
		bitboard_t file_bb = vertical_attack_mask(one_pawn_bb, FULL_BB, FULL_BB) | one_pawn_bb; 	
		if (file_bb & white_pawns & ~one_pawn_bb) doubled |= one_pawn_bb;
	}
	forbitboard(one_pawn_bb, black_pawns) {
		bitboard_t file_bb = vertical_attack_mask(one_pawn_bb, FULL_BB, FULL_BB) 
			| one_pawn_bb; 	
		if (file_bb & black_pawns & ~one_pawn_bb) doubled |= one_pawn_bb;
	}

	return doubled;
}


u_int64_t perft(full_board_t * board, u_int8_t depth) {
    if (depth == 0) {
        return 1;
    }
    else if (depth == 1) {
        return (u_int64_t)count_legal_moves(board);
    }
    else{
        move_t moves[256];
        u_int8_t count = generate_legal_moves(board,moves);
        u_int64_t nodes = 0;
        for (u_int8_t i = 0; i < count; i ++){
            undoable_move_t undo = apply_move(board, moves[i]);
            nodes += perft(board, depth - 1);
        		undo_move(board, undo);
				}
        return nodes;

    }
}


