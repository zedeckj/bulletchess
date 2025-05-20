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

u_int8_t count_backwards_pawns(full_board_t *board, piece_color_t color) {
	position_t *position = board->position;
	bitboard_t white_pawns = position->pawns & position->white_oc;
	bitboard_t black_pawns = position->pawns & position->black_oc;
	
	bitboard_t white_non_paired = ~SAFE_BELOW_BB(black_pawns) & white_pawns;
	bitboard_t black_non_paired = ~SAFE_ABOVE_BB(white_pawns) & black_pawns;
		

	bitboard_t white_pawn_attacks = white_pawn_attack_mask(white_pawns, FULL_BB);
	bitboard_t black_pawn_attacks = black_pawn_attack_mask(black_pawns, FULL_BB);

	if (color == WHITE_VAL) {

		bitboard_t white_cant_advance = SAFE_BELOW_BB(black_pawn_attacks) & white_non_paired; 
		bitboard_t white_backwards = ~white_pawn_attacks & white_cant_advance;
		return count_bits(white_backwards);
	}
	else {
		bitboard_t black_cant_advance = SAFE_ABOVE_BB(white_pawn_attacks) & black_non_paired;
		bitboard_t black_backwards = ~black_pawn_attacks & black_cant_advance;
		return count_bits(black_backwards);
	}
}


u_int8_t count_doubled_pawns(full_board_t * board, piece_color_t color) {
	position_t *position = board->position;
	bitboard_t friendly_pawns;
	if (color == WHITE_VAL) friendly_pawns = position->pawns & position->white_oc;
	else friendly_pawns = position->pawns & position->black_oc;
	bitboard_t iter = friendly_pawns;
	bitboard_t one_pawn_bb;
	u_int8_t count = 0;
	while ((one_pawn_bb = LSB(iter))) {
		iter &= ~one_pawn_bb;
		bitboard_t file_bb = vertical_attack_mask(one_pawn_bb, FULL_BB, FULL_BB) | one_pawn_bb; 
		if (file_bb & iter) count += 1;
	}
	return count;
}

u_int8_t count_isolated_pawns(full_board_t * board, piece_color_t color) {
	position_t *position = board->position;
	bitboard_t friendly_pawns;
	if (color == WHITE_VAL) friendly_pawns = position->pawns & position->white_oc;
	else friendly_pawns = position->pawns & position->black_oc;
	bitboard_t iter = friendly_pawns;
	bitboard_t one_pawn_bb;
	u_int8_t count = 0;
	while ((one_pawn_bb = LSB(iter))) {
		bitboard_t file_bb = vertical_attack_mask(one_pawn_bb, FULL_BB, FULL_BB) | one_pawn_bb; 
		if (!(SAFE_LEFT_BB(file_bb) & friendly_pawns 
			  || SAFE_RIGHT_BB(file_bb) & friendly_pawns)) count += 1;
		iter &= ~one_pawn_bb;
	}
	return count;
}

int8_t net_isolated_pawns(full_board_t * board) {
	return count_isolated_pawns(board, WHITE_VAL) - count_isolated_pawns(board, BLACK_VAL);
}

int8_t net_doubled_pawns(full_board_t * board) {
	return count_doubled_pawns(board, WHITE_VAL) - count_doubled_pawns(board, BLACK_VAL);
}

int8_t net_backwards_pawns(full_board_t * board) {
	position_t *position = board->position;
	bitboard_t white_pawns = position->pawns & position->white_oc;
	bitboard_t black_pawns = position->pawns & position->black_oc;
	
	bitboard_t white_non_paired = ~SAFE_BELOW_BB(black_pawns) & white_pawns;
	bitboard_t black_non_paired = ~SAFE_ABOVE_BB(white_pawns) & black_pawns;
		

	bitboard_t white_pawn_attacks = white_pawn_attack_mask(white_pawns, FULL_BB);
	bitboard_t black_pawn_attacks = black_pawn_attack_mask(black_pawns, FULL_BB);
	
	bitboard_t white_cant_advance = SAFE_BELOW_BB(black_pawn_attacks) & white_non_paired; 
	bitboard_t white_backwards = ~white_pawn_attacks & white_cant_advance;
	
	bitboard_t black_cant_advance = SAFE_ABOVE_BB(white_pawn_attacks) & black_non_paired;
	bitboard_t black_backwards = ~black_pawn_attacks & black_cant_advance;
	return count_bits(white_backwards) - count_bits(black_backwards);
}

bitboard_t white_backwards_pawns(full_board_t *board) {
	position_t *position = board->position;
	bitboard_t white_pawns = position->pawns & position->white_oc;
	bitboard_t black_pawns = position->pawns & position->black_oc;

	// only pawns that are not paired up with an opposing pawn
	bitboard_t white_non_paired = ~SAFE_BELOW_BB(black_pawns) & white_pawns;
		
	bitboard_t white_pawn_attacks = white_pawn_attack_mask(white_pawns, FULL_BB);
	bitboard_t black_pawn_attacks = black_pawn_attack_mask(black_pawns, FULL_BB);
		
	// and that would be attacked if they advanced
	bitboard_t white_cant_advance = 
		SAFE_BELOW_BB(black_pawn_attacks) 
		& white_non_paired; 
	
	// and arent protected
	bitboard_t white_candidates= ~white_pawn_attacks & white_cant_advance;
	bitboard_t white_non_back = RANK_1 & white_candidates;

	#define NONE_BELOW(RANK)\
		(RANK & ~SAFE_ABOVE_BB(white_non_back | SAFE_LEFT_BB(white_non_back) | SAFE_RIGHT_BB(white_non_back)))
	
	white_non_back |= NONE_BELOW(RANK_2);
	white_non_back |= NONE_BELOW(RANK_3);
	white_non_back |= NONE_BELOW(RANK_4);
	white_non_back |= NONE_BELOW(RANK_5);
	white_non_back |= NONE_BELOW(RANK_6);
	white_non_back |= NONE_BELOW(RANK_7);
	white_non_back |= NONE_BELOW(RANK_8);

	#undef NONE_BELOW
	// and wouldnt be protected if they advanced
	bitboard_t white_backwards = white_candidates & white_non_back & ~SAFE_BELOW_BB(white_pawn_attacks);	
	return white_backwards;
}


bitboard_t black_backwards_pawns(full_board_t *board) {
	position_t *position = board->position;
	bitboard_t white_pawns = position->pawns & position->white_oc;
	bitboard_t black_pawns = position->pawns & position->black_oc;

	// only pawns that are not paired up with an opposing pawn
	bitboard_t black_non_paired = ~SAFE_ABOVE_BB(white_pawns) & black_pawns;
		
	bitboard_t white_pawn_attacks = white_pawn_attack_mask(white_pawns, FULL_BB);
	bitboard_t black_pawn_attacks = black_pawn_attack_mask(black_pawns, FULL_BB);
		
	bitboard_t black_cant_advance = 
		SAFE_ABOVE_BB(white_pawn_attacks) 
		& black_non_paired;

	// and arent protected
	bitboard_t black_candidates = ~black_pawn_attacks & black_cant_advance;
	bitboard_t black_non_back = RANK_8 & black_candidates;
	
	#define NONE_ABOVE(RANK)\
		(RANK & black_candidates & ~SAFE_BELOW_BB(black_non_back | SAFE_LEFT_BB(black_non_back) | SAFE_RIGHT_BB(black_non_back)))
	black_non_back |= NONE_ABOVE(RANK_7);
	black_non_back |= NONE_ABOVE(RANK_6);
	black_non_back |= NONE_ABOVE(RANK_5);
	black_non_back |= NONE_ABOVE(RANK_4);
	black_non_back |= NONE_ABOVE(RANK_3);
	black_non_back |= NONE_ABOVE(RANK_2);
	black_non_back |= NONE_ABOVE(RANK_1);
	#undef NONE_ABOVE
	// and wouldnt be protected if they advanced
	bitboard_t black_backwards = black_candidates & black_non_back & ~SAFE_ABOVE_BB(black_pawn_attacks);	
	return black_backwards;
}


bitboard_t backwards_pawns(full_board_t *board) {
	position_t *position = board->position;
	bitboard_t white_pawns = position->pawns & position->white_oc;
	bitboard_t black_pawns = position->pawns & position->black_oc;

	// only pawns that are not paired up with an opposing pawn
	bitboard_t white_non_paired = ~SAFE_BELOW_BB(black_pawns) & white_pawns;
	bitboard_t black_non_paired = ~SAFE_ABOVE_BB(white_pawns) & black_pawns;
		
	bitboard_t white_pawn_attacks = white_pawn_attack_mask(white_pawns, FULL_BB);
	bitboard_t black_pawn_attacks = black_pawn_attack_mask(black_pawns, FULL_BB);
		
	// and that would be attacked if they advanced
	bitboard_t white_cant_advance = 
		SAFE_BELOW_BB(black_pawn_attacks) 
		& white_non_paired; 

	bitboard_t black_cant_advance = 
		SAFE_ABOVE_BB(white_pawn_attacks) 
		& black_non_paired;

	// and arent protected
	bitboard_t white_candidates= ~white_pawn_attacks & white_cant_advance;
	
	bitboard_t black_candidates = ~black_pawn_attacks & black_cant_advance;

	bitboard_t white_non_back = RANK_1 & white_candidates;

	#define NONE_BELOW(RANK)\
		(RANK & ~SAFE_ABOVE_BB(white_non_back | SAFE_LEFT_BB(white_non_back) | SAFE_RIGHT_BB(white_non_back)))
	
	white_non_back |= NONE_BELOW(RANK_2);
	white_non_back |= NONE_BELOW(RANK_3);
	white_non_back |= NONE_BELOW(RANK_4);
	white_non_back |= NONE_BELOW(RANK_5);
	white_non_back |= NONE_BELOW(RANK_6);
	white_non_back |= NONE_BELOW(RANK_7);
	white_non_back |= NONE_BELOW(RANK_8);
	bitboard_t black_non_back = RANK_8 & black_candidates;
	
	#define NONE_ABOVE(RANK)\
		(RANK & black_candidates & ~SAFE_BELOW_BB(black_non_back | SAFE_LEFT_BB(black_non_back) | SAFE_RIGHT_BB(black_non_back)))
	black_non_back |= NONE_ABOVE(RANK_7);
	black_non_back |= NONE_ABOVE(RANK_6);
	black_non_back |= NONE_ABOVE(RANK_5);
	black_non_back |= NONE_ABOVE(RANK_4);
	black_non_back |= NONE_ABOVE(RANK_3);
	black_non_back |= NONE_ABOVE(RANK_2);
	black_non_back |= NONE_ABOVE(RANK_1);

	// and wouldnt be protected if they advanced
	bitboard_t white_backwards = white_candidates & white_non_back & ~SAFE_BELOW_BB(white_pawn_attacks);	
	bitboard_t black_backwards = black_candidates & black_non_back & ~SAFE_ABOVE_BB(black_pawn_attacks);	
	return white_backwards | black_backwards;
}


bitboard_t white_isolated_pawns(full_board_t *board) {
	position_t *position = board->position;
	bitboard_t white_pawns = position->pawns & position->white_oc;
	bitboard_t isolated = 0;
	forbitboard(one_pawn_bb, white_pawns) {
		bitboard_t file_bb = vertical_attack_mask(one_pawn_bb, FULL_BB, FULL_BB) | one_pawn_bb; 
		if (!(SAFE_LEFT_BB(file_bb) & white_pawns 
			  || SAFE_RIGHT_BB(file_bb) & white_pawns)) 
			isolated |= one_pawn_bb;
	}
	return isolated;
}


bitboard_t black_isolated_pawns(full_board_t *board) {
	position_t *position = board->position;
	bitboard_t black_pawns = position->pawns & position->black_oc;
	bitboard_t isolated = 0;
	forbitboard(one_pawn_bb, black_pawns) {
		bitboard_t file_bb = vertical_attack_mask(one_pawn_bb, FULL_BB, FULL_BB) | one_pawn_bb; 
		if (!(SAFE_LEFT_BB(file_bb) & black_pawns 
			  || SAFE_RIGHT_BB(file_bb) & black_pawns)) 
			isolated |= one_pawn_bb;
	}
	return isolated;
}

bitboard_t isolated_pawns(full_board_t *board){
	return white_isolated_pawns(board) | black_isolated_pawns(board);
}	



bitboard_t white_doubled_pawns(full_board_t * board) {
	position_t *position = board->position;
	bitboard_t white_pawns = position->pawns & position->white_oc;
	bitboard_t doubled = 0;
	forbitboard(one_pawn_bb, white_pawns) {
		bitboard_t file_bb = vertical_attack_mask(one_pawn_bb, FULL_BB, FULL_BB) | one_pawn_bb; 	
		if (file_bb & white_pawns & ~one_pawn_bb) doubled |= one_pawn_bb;
	}
	return doubled;
}

bitboard_t black_doubled_pawns(full_board_t * board) {
	position_t *position = board->position;
	bitboard_t black_pawns = position->pawns & position->black_oc;
	bitboard_t doubled = 0;
	forbitboard(one_pawn_bb, black_pawns) {
		bitboard_t file_bb = vertical_attack_mask(one_pawn_bb, FULL_BB, FULL_BB) 
			| one_pawn_bb; 	
		if (file_bb & black_pawns & ~one_pawn_bb) doubled |= one_pawn_bb;
	}
	return doubled;
}

bitboard_t doubled_pawns(full_board_t *board) {
	return white_doubled_pawns(board) | black_doubled_pawns(board);
}

#define FILE_PASSED(FL)\
	(((FILE_ ## FL & white_pawns ? FILE_##FL : 0)\
	 ^ (FILE_ ## FL & black_pawns ? FILE_##FL : 0))\
	 & pos->pawns)
	 
// ^ completely wrong


bitboard_t passed_pawns_old(full_board_t *board) {
	position_t *pos = board->position;
	bitboard_t white_pawns = pos->pawns & pos->white_oc;
	bitboard_t black_pawns = pos->pawns & pos->black_oc;
	return FILE_PASSED(A) | FILE_PASSED(B) | FILE_PASSED(C) | FILE_PASSED(D) 
			 | FILE_PASSED(E) | FILE_PASSED(F) | FILE_PASSED(G) | FILE_PASSED(H);
}

	
#define BLACK_BLOCKERS(RANK)\
	SAFE_BELOW_BB(RANK &\
			(black_pawns\
			 | SAFE_LEFT_BB(black_pawns)\
			 | SAFE_RIGHT_BB(black_pawns)))

	
#define WHITE_BLOCKERS(RANK)\
	SAFE_ABOVE_BB(RANK &\
			(white_pawns\
			 | SAFE_LEFT_BB(white_pawns)\
			 | SAFE_RIGHT_BB(white_pawns)))
		
#define CLEAR_FROM_ABOVE(RANK)\
	 (BELOW_BB(RANK &\
				white_cleared &\
				~(black_pawns |\
				 SAFE_LEFT_BB(black_pawns) |\
				 SAFE_RIGHT_BB(black_pawns))))


#define CLEAR_FROM_BELOW(RANK)\
	 (ABOVE_BB(RANK &\
				black_cleared &\
				~(white_pawns |\
				 SAFE_LEFT_BB(white_pawns) |\
				 SAFE_RIGHT_BB(white_pawns))))



bitboard_t white_passed_pawns(full_board_t *board) {
	position_t *pos = board->position;
	bitboard_t white_pawns = pos->pawns & pos->white_oc;
	bitboard_t black_pawns = pos->pawns & pos->black_oc;
	bitboard_t white_cleared  = RANK_8 & ~black_pawns;
	white_cleared |= CLEAR_FROM_ABOVE(RANK_8);
	white_cleared |= CLEAR_FROM_ABOVE(RANK_7);	
	white_cleared |= CLEAR_FROM_ABOVE(RANK_6);
	white_cleared |= CLEAR_FROM_ABOVE(RANK_5);	
	white_cleared |= CLEAR_FROM_ABOVE(RANK_4);
	white_cleared |= CLEAR_FROM_ABOVE(RANK_3);	
	white_cleared |= CLEAR_FROM_ABOVE(RANK_2);
	white_cleared |= CLEAR_FROM_ABOVE(RANK_1);	
	return (white_cleared & white_pawns);
}

bitboard_t black_passed_pawns(full_board_t *board) {
	position_t *pos = board->position;
	bitboard_t white_pawns = pos->pawns & pos->white_oc;
	bitboard_t black_pawns = pos->pawns & pos->black_oc;
	
	bitboard_t black_cleared = RANK_1 & ~white_pawns;	
	black_cleared |= CLEAR_FROM_BELOW(RANK_1);
	black_cleared |= CLEAR_FROM_BELOW(RANK_2);
	black_cleared |= CLEAR_FROM_BELOW(RANK_3);
	black_cleared |= CLEAR_FROM_BELOW(RANK_4);
	black_cleared |= CLEAR_FROM_BELOW(RANK_5);
	black_cleared |= CLEAR_FROM_BELOW(RANK_6);
	black_cleared |= CLEAR_FROM_BELOW(RANK_7);
	return (black_cleared & black_pawns);
}

bitboard_t passed_pawns(full_board_t *board){
	return white_passed_pawns(board) | black_passed_pawns(board);
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

#define MAT_FOR(PIECE)\
	PIECE ## _val * (count_bits(pos->PIECE ## s & pos->white_oc)\
	- count_bits(pos->PIECE ## s & pos->black_oc))

int64_t material(full_board_t *board, int64_t pawn_val, int64_t knight_val, int64_t bishop_val, int64_t rook_val, int64_t queen_val){
	position_t *pos = board->position;
	return MAT_FOR(pawn) + MAT_FOR(knight) + MAT_FOR(bishop) 
		+ MAT_FOR(rook) + MAT_FOR(queen);
}


#define NET_PAWNS(TYPE)\
	(count_bits(white_ ## TYPE ## _pawns(board)) -\
	 count_bits(black_ ## TYPE ##_pawns(board)))

int32_t shannon_evaluation(full_board_t * board, 
		undoable_move_t * stack, u_int8_t stack_size) {
	board_status_t status = get_status(board, stack, stack_size);	
	if (status & CHECK_STATUS && status & MATE_STATUS) {
		return board->turn == WHITE_VAL ? -20000 : 20000; 
	}	
	else if (is_draw(status)){
		return 0;
	}
	else {
		return (int32_t)material(board, 100, 300, 300, 500, 900) +
					-50 * (NET_PAWNS(backwards) 
							+ NET_PAWNS(isolated) 
							+ NET_PAWNS(doubled))
					+ 10 * net_mobility(board); 
	}
}

#define OPEN_FL(FL) FL = (FILE_ ## FL & pos->pawns) ? 0 : FILE_ ## FL 

bitboard_t open_files(full_board_t *board) {
	position_t *pos = board->position;
	bitboard_t OPEN_FL(A);
	bitboard_t OPEN_FL(B);	
	bitboard_t OPEN_FL(C);	
	bitboard_t OPEN_FL(D);	
	bitboard_t OPEN_FL(E);	
	bitboard_t OPEN_FL(F);
	bitboard_t OPEN_FL(G);
	bitboard_t OPEN_FL(H);
	return A | B | C | D | E | F | G | H; 
}

#define WHITE_OPEN_FL(FL)\
	FL = (FILE_ ## FL & pos->white_oc & pos->pawns)\
	? 0 : ((FILE_ ## FL & pos->black_oc & pos->pawns) ? FILE_ ## FL : 0)

#define BLACK_OPEN_FL(FL)\
	FL = (FILE_ ## FL & pos->black_oc & pos->pawns)\
	? 0 : ((FILE_ ## FL & pos->white_oc & pos->pawns) ? FILE_ ## FL : 0)


bitboard_t white_half_open_files(full_board_t *board) {
	position_t *pos = board->position;
	bitboard_t WHITE_OPEN_FL(A);
	bitboard_t WHITE_OPEN_FL(B);	
	bitboard_t WHITE_OPEN_FL(C);	
	bitboard_t WHITE_OPEN_FL(D);	
	bitboard_t WHITE_OPEN_FL(E);	
	bitboard_t WHITE_OPEN_FL(F);
	bitboard_t WHITE_OPEN_FL(G);
	bitboard_t WHITE_OPEN_FL(H);
	return A | B | C | D | E | F | G | H; 
}

bitboard_t black_half_open_files(full_board_t *board){
	position_t *pos = board->position;
	bitboard_t BLACK_OPEN_FL(A);
	bitboard_t BLACK_OPEN_FL(B);
	bitboard_t BLACK_OPEN_FL(C);
	bitboard_t BLACK_OPEN_FL(D);
	bitboard_t BLACK_OPEN_FL(E);
	bitboard_t BLACK_OPEN_FL(F);
	bitboard_t BLACK_OPEN_FL(G);
	bitboard_t BLACK_OPEN_FL(H);
	return A | B | C | D | E | F | G | H; 
}

bitboard_t half_open_files(full_board_t *board, piece_color_t color){
	if (color == WHITE_VAL) return white_half_open_files(board);
	else return black_half_open_files(board);
}

#undef OPEN_FL

move_t random_legal_move(full_board_t *board) {
	move_t buffer[256];
	u_int8_t count = generate_legal_moves(board, buffer);
	if (count == 0){
		return null_move();
	}
	else {
		return buffer[random() % count];	
	}
}

bool is_pinned(full_board_t *board, square_t square){
	bitboard_t sq_bb = SQUARE_TO_BB(square);
	position_t *pos = board->position;
	piece_color_t friendly;
	piece_color_t hostile;
	if (pos->white_oc & sq_bb) {
		friendly = WHITE_VAL;
		hostile = BLACK_VAL;
	}
	else if (pos->black_oc & sq_bb) {
		friendly = BLACK_VAL;
		hostile = WHITE_VAL;
	}
	else return false;
	bitboard_t attack_mask = make_attack_mask(board, hostile);
	bitboard_t mask = make_pinned_mask(board, sq_bb, friendly, attack_mask); 
	if (~mask) {
		check_info_t info = make_check_info(board, friendly, attack_mask);
		return !has_moves(board, friendly, attack_mask, sq_bb, info); 
	}
	return false;
}

