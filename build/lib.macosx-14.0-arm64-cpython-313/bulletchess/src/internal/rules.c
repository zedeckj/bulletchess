#include "rules.h"

void add_from_bitboard_old(square_t origin, 
		bitboard_t destinations, 
		move_t * moves, 
		u_int8_t *move_index) {
		if (destinations) {
        for (square_t square = A1; square <= H8; square++) {
            bitboard_t bb = SQUARE_TO_BB(square);
            if (bb & destinations) {
                moves[(*move_index)++] = generic_move(move_body(origin, square));
            }
        }
    }
}


void add_from_bitboard(square_t origin, 
		bitboard_t destinations, 
		move_t * moves, 
		piece_type_t moving_type,
		u_int8_t *move_index) {
		forbitboard(current, destinations) {
			square_t square = unchecked_bb_to_square(current);
			generic_move_t gen;
			gen.origin = origin;
			gen.destination = square;
			move_t move;
			/*
			move.type = FULL_MOVE;
			move.full.body = gen;
			move.full.moving_type = moving_type;
			*/
			move.type = GENERIC_MOVE;
			move.generic = gen;
			moves[(*move_index)++] = move; 
		}
}

void add_from_bitboard_white_promotes(square_t origin, bitboard_t destinations, move_t * moves, u_int8_t *move_index) {
    if (destinations) {
        for (bitboard_t square = A8; square <= H8; square++) {
            bitboard_t bb = SQUARE_TO_BB(square);
            if (bb & destinations) {
                moves[(*move_index)++] = promotion_move(move_body(origin, square), QUEEN_VAL);
                moves[(*move_index)++] = promotion_move(move_body(origin, square), ROOK_VAL);
                moves[(*move_index)++] = promotion_move(move_body(origin, square), BISHOP_VAL);
                moves[(*move_index)++] = promotion_move(move_body(origin, square), KNIGHT_VAL);
            }
        }
    }
}

void add_from_bitboard_black_promotes(square_t origin, bitboard_t destinations, move_t * moves, u_int8_t *move_index) {
    if (destinations) {
        for (square_t square = A1; square <= H1; square++) {
            bitboard_t bb = SQUARE_TO_BB(square);
            if (bb & destinations) {
                moves[(*move_index)++] = promotion_move(move_body(origin, square), QUEEN_VAL);
                moves[(*move_index)++] = promotion_move(move_body(origin, square), ROOK_VAL);
                moves[(*move_index)++] = promotion_move(move_body(origin, square), BISHOP_VAL);
                moves[(*move_index)++] = promotion_move(move_body(origin, square), KNIGHT_VAL);
            }

        }
    }
}



bitboard_t nw_pawn_attack(bitboard_t bb, bitboard_t enemies_and_ep) {
    bitboard_t above = SAFE_ABOVE_BB(bb);
    bitboard_t attacking = SAFE_RIGHT_BB(above);
    return attacking & enemies_and_ep;
}

bitboard_t sw_pawn_attack(bitboard_t bb, bitboard_t enemies_and_ep) {
    bitboard_t above = SAFE_BELOW_BB(bb);
    bitboard_t attacking = SAFE_RIGHT_BB(above);
    return attacking & enemies_and_ep;
}

bitboard_t ne_pawn_attack(bitboard_t bb, bitboard_t enemies_and_ep) {
    bitboard_t above = SAFE_ABOVE_BB(bb);
    bitboard_t attacking = SAFE_LEFT_BB(above);
    return attacking & enemies_and_ep;
}

bitboard_t se_pawn_attack(bitboard_t bb, bitboard_t enemies_and_ep) {
    bitboard_t above = SAFE_BELOW_BB(bb);
    bitboard_t attacking = SAFE_LEFT_BB(above);
    return attacking & enemies_and_ep;
}

bitboard_t white_pawn_attack_mask(bitboard_t bb, bitboard_t enemies_and_ep) {
    return nw_pawn_attack(bb, enemies_and_ep) | ne_pawn_attack(bb, enemies_and_ep);
}

bitboard_t black_pawn_attack_mask(bitboard_t bb, bitboard_t enemies_and_ep) {
    return sw_pawn_attack(bb, enemies_and_ep) | se_pawn_attack(bb, enemies_and_ep);
}

bitboard_t pawn_attack_mask(bitboard_t bb, piece_color_t color, bitboard_t enemies_and_ep) {
	switch (color) {
		case WHITE_VAL:
			return white_pawn_attack_mask(bb, enemies_and_ep);
		case BLACK_VAL:
			return black_pawn_attack_mask(bb, enemies_and_ep);
		default:
			return 0;
	}
}

bitboard_t white_pawn_push_mask(bitboard_t bb, bitboard_t empty) {
    /*
    Creates a mask of where a white pawn on the given bitboard is allowed to move to.
    */
    bitboard_t push = SAFE_ABOVE_BB(bb) & empty; 
    push |= SAFE_ABOVE_BB(push) & RANK_4 & empty;
    return push;
}

bitboard_t black_pawn_push_mask(bitboard_t bb, bitboard_t empty) {
    /*
    Creates a mask of where a black pawn on the given bitboard is allowed to move to.
    */
    bitboard_t push = SAFE_BELOW_BB(bb) & empty; 
    push |= SAFE_BELOW_BB(push) & RANK_5 & empty;
    return push;
}




bitboard_t knight_attack_mask(bitboard_t bb, bitboard_t non_friendly) {
    bitboard_t attacking;
    attacking = SAFE_KNIGHT_MOVE_BB1(bb);
    attacking |= SAFE_KNIGHT_MOVE_BB2(bb);

    attacking |= SAFE_KNIGHT_MOVE_BB3(bb);
    attacking |= SAFE_KNIGHT_MOVE_BB4(bb);

    attacking |= SAFE_KNIGHT_MOVE_BB5(bb);
    attacking |= SAFE_KNIGHT_MOVE_BB6(bb);

    attacking |= SAFE_KNIGHT_MOVE_BB7(bb);
    attacking |= SAFE_KNIGHT_MOVE_BB8(bb);
	
    return attacking & non_friendly;
}


bitboard_t king_attack_mask(bitboard_t bb, bitboard_t non_friendly) {
    bitboard_t attacking;
    attacking = SAFE_ABOVE_BB(bb);
    attacking |= SAFE_BELOW_BB(bb);
    attacking |= SAFE_LEFT_BB(bb);
    attacking |= SAFE_RIGHT_BB(bb);
    attacking |= SAFE_LEFT_BB(SAFE_ABOVE_BB(bb));
    attacking |= SAFE_LEFT_BB(SAFE_BELOW_BB(bb));
    attacking |= SAFE_RIGHT_BB(SAFE_ABOVE_BB(bb));
    attacking |= SAFE_RIGHT_BB(SAFE_BELOW_BB(bb));
	return attacking & non_friendly;
}

bitboard_t north_sliding_mask(bitboard_t bb, bitboard_t non_friendly, bitboard_t empty) {
    bitboard_t attacking = 0;
    bitboard_t moving_above_bb = bb;
    while (moving_above_bb) {
        moving_above_bb = SAFE_ABOVE_BB(moving_above_bb) & non_friendly;
        attacking |= moving_above_bb;
        moving_above_bb &= empty;
    }
    return attacking;
}

bitboard_t south_sliding_mask(bitboard_t bb, bitboard_t non_friendly, bitboard_t empty) {
    bitboard_t attacking = 0;
    bitboard_t moving_below_bb = bb;
    while (moving_below_bb) {
        moving_below_bb = SAFE_BELOW_BB(moving_below_bb) & non_friendly;
        attacking |= moving_below_bb;
        moving_below_bb &= empty;
    }
    return attacking;
}

bitboard_t west_sliding_mask(bitboard_t bb, bitboard_t non_friendly, bitboard_t empty) {
    bitboard_t attacking = 0;
    bitboard_t moving_left_bb = bb;
    while (moving_left_bb) {
        moving_left_bb = SAFE_LEFT_BB(moving_left_bb) & non_friendly;
        attacking |= moving_left_bb;
        moving_left_bb &= empty;
    }
    return attacking;
}

bitboard_t east_sliding_mask(bitboard_t bb, bitboard_t non_friendly, bitboard_t empty) {
    bitboard_t attacking = 0;
    bitboard_t moving_right_bb = bb;
    while (moving_right_bb) {
        moving_right_bb = SAFE_RIGHT_BB(moving_right_bb) & non_friendly;
        attacking |= moving_right_bb;
        moving_right_bb &= empty;
    }
    return attacking;
}

bitboard_t ne_sliding_mask(bitboard_t bb, bitboard_t non_friendly, bitboard_t empty) {
    bitboard_t attacking = 0;
    bitboard_t moving_bb = bb;
    while (moving_bb) {
        moving_bb = SAFE_ABOVE_BB(SAFE_RIGHT_BB(moving_bb)) & non_friendly;
        attacking |= moving_bb;
        moving_bb &= empty;
    }
    return attacking;
}

bitboard_t nw_sliding_mask(bitboard_t bb, bitboard_t non_friendly, bitboard_t empty) {
    bitboard_t attacking = 0;
    bitboard_t moving_bb = bb;
    while (moving_bb) {
        moving_bb = SAFE_ABOVE_BB(SAFE_LEFT_BB(moving_bb)) & non_friendly;
        attacking |= moving_bb;
        moving_bb &= empty;
    }
    return attacking;
}

bitboard_t se_sliding_mask(bitboard_t bb, bitboard_t non_friendly, bitboard_t empty) {
    bitboard_t attacking = 0;
    bitboard_t moving_bb = bb;
    while (moving_bb) {
        moving_bb = SAFE_BELOW_BB(SAFE_RIGHT_BB(moving_bb)) & non_friendly;
        attacking |= moving_bb;
        moving_bb &= empty;
    }
    return attacking;
}

bitboard_t sw_sliding_mask(bitboard_t bb, bitboard_t non_friendly, bitboard_t empty) {
    bitboard_t attacking = 0;
    bitboard_t moving_bb = bb;
    while (moving_bb) {
        moving_bb = SAFE_BELOW_BB(SAFE_LEFT_BB(moving_bb)) & non_friendly;
        attacking |= moving_bb;
        moving_bb &= empty;
    }
    return attacking;
}

bitboard_t vertical_attack_mask(bitboard_t bb, bitboard_t non_friendly, bitboard_t empty) {
    return north_sliding_mask(bb, non_friendly, empty) | south_sliding_mask(bb, non_friendly, empty);
}

bitboard_t horizontal_attack_mask(bitboard_t bb, bitboard_t non_friendly, bitboard_t empty) {
    return west_sliding_mask(bb, non_friendly, empty) | east_sliding_mask(bb, non_friendly, empty);
}



bitboard_t sliding_attack_mask(bitboard_t bb, bitboard_t non_friendly, bitboard_t empty) {
    bitboard_t attacking = vertical_attack_mask(bb, non_friendly, empty);
    attacking |= horizontal_attack_mask(bb, non_friendly, empty);
    return attacking;
}


bitboard_t ascending_attack_mask(bitboard_t bb, bitboard_t non_friendly, bitboard_t empty) {
    return ne_sliding_mask(bb, non_friendly, empty) | sw_sliding_mask(bb, non_friendly, empty);
}

bitboard_t descending_attack_mask(bitboard_t bb, bitboard_t non_friendly, bitboard_t empty) {
    return nw_sliding_mask(bb, non_friendly, empty) | se_sliding_mask(bb, non_friendly, empty);
}

bitboard_t diagonal_attack_mask(bitboard_t bb, bitboard_t non_friendly, bitboard_t empty) {
    bitboard_t attacking = ascending_attack_mask(bb, non_friendly, empty);
    attacking |= descending_attack_mask(bb, non_friendly, empty);
    return attacking;
}

// A danger mask is a bitboard of a type of enemy piece, The move mask represents the mask of that type of pieces
// move from the perspective of a friendly piece, in only one direction. 
// If the move mask overlaps with both the king and the hostile pieces,
// the piece is pinned to the region of the move.  
bitboard_t pin_mask_from(bitboard_t move_mask, bitboard_t danger_mask, bitboard_t king_mask) {
    if ((move_mask & danger_mask) && (move_mask & king_mask)) {
        return move_mask;
    }
    return FULL_BB;
}

bitboard_t make_ep_bb(optional_square_t ep_square) {
    return ep_square.exists ? SQUARE_TO_BB(ep_square.square) : 0;
}

bitboard_t make_pinned_mask(full_board_t * board, bitboard_t piece_bb, piece_color_t for_color, bitboard_t attack_mask) {
    /*
    A "pinned" piece is one which cannot move or its king would be placed in check. 
    This can be done by seeing if any sliding mask attacks both an enemy piece,
    with that same sliding attack, and its own king. 

    Pieces can only move within the generated pinned mask. A non pinned piece
    will return a mask of the full board.

    This concept does not apply to kings, so should not be called for a piece_bb with a king on it.

    There is an extremely specific case for capturing en passant and revaling a horizontal attack.
    */
	
		/* Revised note: A pinned mask should represent the squares any Piece
		 * could move to without placing the King in check. There is too points that
		 * are raised by testing:
		 * - Should the origin of a piece be included?
		 * - Should the King's square manually be exlcuded?
		 */	


    position_t *position = board->position;
		bitboard_t friendly;
    bitboard_t hostile;
    if (for_color == WHITE_VAL) {
        friendly = position->white_oc;
        hostile = position->black_oc;
    }
    else {
        friendly = position->black_oc;
        hostile = position->white_oc;
    }
		
    bitboard_t pin_mask = FULL_BB;
		
		bitboard_t friendly_pawns = friendly & position->pawns;
		bool is_pawn;
		if (!(is_pawn = friendly_pawns & piece_bb) && !(attack_mask & piece_bb)) return pin_mask; 
		bitboard_t slide_danger = hostile & (position->rooks | position->queens);
    bitboard_t diagonal_danger=  hostile & (position->bishops | position->queens);
    bitboard_t friendly_kings = friendly & position->kings;
    bitboard_t empty = ~(friendly | hostile);
    if (is_pawn) {
        bitboard_t ep_bb = make_ep_bb(board->en_passant_square);
        if (ep_bb) {
            bitboard_t our_pawn_attacks;
            bitboard_t ep_pawn;
            if (for_color == WHITE_VAL){
                our_pawn_attacks = white_pawn_attack_mask(piece_bb, hostile | ep_bb);
                ep_pawn = SAFE_BELOW_BB(ep_bb);
            } 
            else {
                our_pawn_attacks = black_pawn_attack_mask(piece_bb, hostile | ep_bb);
                ep_pawn = SAFE_ABOVE_BB(ep_bb);
            } 
            if (our_pawn_attacks & ep_bb) {
                // If our pawn attacks the ep square, does removing 
                // the ep pawn place our king under attack?
                bitboard_t old_empty = empty;
                empty |= ep_pawn | piece_bb;
                empty &= ~ep_bb;
                bitboard_t temp_pin = FULL_BB;
                if (slide_danger) {
                    bitboard_t horizontal = horizontal_attack_mask(ep_pawn, FULL_BB, empty);
                    
										temp_pin &= pin_mask_from(horizontal,slide_danger,friendly_kings);
								}

                if (diagonal_danger) {
                    bitboard_t ascending = ascending_attack_mask(ep_pawn, FULL_BB, empty);
                    temp_pin &= pin_mask_from( ascending, diagonal_danger, friendly_kings);
                    bitboard_t descending = descending_attack_mask(ep_pawn, FULL_BB, empty);
                    temp_pin &= pin_mask_from( descending, diagonal_danger, friendly_kings);
                }
                if (temp_pin != FULL_BB) {
                    pin_mask &= ~ep_bb;
                }
                empty = old_empty;
            }
        }
    }
    if (slide_danger) {
        bitboard_t vertical = vertical_attack_mask(piece_bb, FULL_BB, empty);
        pin_mask &= pin_mask_from(vertical, slide_danger, friendly_kings);
        bitboard_t horizontal = horizontal_attack_mask(piece_bb, FULL_BB, empty);
        pin_mask &= pin_mask_from( horizontal, slide_danger, friendly_kings);
		}
    if (diagonal_danger) {
        bitboard_t ascending = ascending_attack_mask(piece_bb, FULL_BB, empty);
        pin_mask &= pin_mask_from( ascending, diagonal_danger, friendly_kings);
        bitboard_t descending = descending_attack_mask(piece_bb, FULL_BB, empty);
        pin_mask &= pin_mask_from( descending, diagonal_danger, friendly_kings);
    }
    return pin_mask;
}



// Makes a bitboard of squares a side is attacking
// If this overlaps with the King, the position is check
bitboard_t make_attack_mask(full_board_t *board, piece_color_t attacker) {
    position_t *position = board->position;
    bitboard_t friendly;
    bitboard_t hostile;
    if (attacker == WHITE_VAL) {
        hostile = position->white_oc;
        friendly = position->black_oc;
    }
    else {
        hostile = position->black_oc;
        friendly = position->white_oc;
    }
    bitboard_t enemy_pawns = hostile & position->pawns;
    bitboard_t enemy_bishops = hostile & position->bishops;
    bitboard_t enemy_knights = hostile & position->knights;
    bitboard_t enemy_rooks = hostile & position->rooks;
    bitboard_t enemy_queens = hostile & position->queens;
    bitboard_t enemy_kings = hostile & position->kings;
    bitboard_t friendly_kings = friendly & position->kings;
    friendly &= ~friendly_kings;
    bitboard_t empty = ~(hostile | friendly);
    bitboard_t can_move_to = FULL_BB;
    bitboard_t attacking = 0; 
    if (enemy_pawns) 
			attacking |= pawn_attack_mask(enemy_pawns, attacker, can_move_to);
    if (enemy_rooks) 
			attacking |= sliding_attack_mask(enemy_rooks, can_move_to, empty);
    if (enemy_knights) 
			attacking |= knight_attack_mask(enemy_knights, can_move_to);
    if (enemy_bishops) 
			attacking |= diagonal_attack_mask(enemy_bishops, can_move_to, empty);
		if (enemy_queens) {
        attacking |= sliding_attack_mask(enemy_queens, can_move_to, empty);
        attacking |= diagonal_attack_mask(enemy_queens, can_move_to, empty);
    }
    attacking |= king_attack_mask(enemy_kings, can_move_to);
		return attacking;
}


check_info_t non_check_info() {
    check_info_t escapes;
    escapes.allowed_move_mask = FULL_BB;
    escapes.extra_pawn_capture_mask = FULL_BB;
    escapes.king_attacker_count = 0;
    return escapes;
} 





bool in_check_with_attacker_mask(position_t * position, piece_color_t for_color, bitboard_t attcker_mask) {
    bitboard_t king;
    if (for_color == WHITE_VAL) {
        king = position->white_oc & position->kings;
    }
    else {
        king = position->black_oc & position->kings;
    }
    return king & attcker_mask;
}

check_info_t update_info(check_info_t current_info, bitboard_t move_mask, bitboard_t enemy_mask) {
    bitboard_t attackers = move_mask & enemy_mask;
    if (attackers) {
        current_info.king_attacker_count += 1;
				if (current_info.king_attacker_count > 1){
    			current_info.allowed_move_mask = 0;
    			current_info.extra_pawn_capture_mask = 0;
 					return current_info;
				}
				else {
            current_info.allowed_move_mask = move_mask;
            current_info.extra_pawn_capture_mask = move_mask;
            return current_info;
        }
    }
    return current_info;
}



check_info_t make_check_info(full_board_t *board, piece_color_t for_color, bitboard_t attack_mask) {
    /*
    Creates bitboards of where non Kings are allowed to move or capture. 
    - If the King is not in check
        - Other pieces can capture or push anywhere (that is otherwise legal, which is handled later)
    - If the King is in check, with only one attacker 
        - Other pieces can capture the attacker, or can block the path of attack 
    - If the King is in check, with two or more attackers
        - Other pieces cannot attack or move anywhere
    */
    bitboard_t friendly;
    bitboard_t hostile;
    position_t *position = board->position;
    if (for_color == WHITE_VAL) {
        hostile = position->black_oc;
        friendly = position->white_oc;
    }
    else {
        hostile = position->white_oc;
        friendly = position->black_oc;

    }
    bitboard_t friendly_kings = friendly & position->kings;

    // Case 1
    check_info_t info = non_check_info();

    if (!in_check_with_attacker_mask(position, for_color, attack_mask)) {
        return info;
    }
    bitboard_t enemy_pawns = hostile & position->pawns;
    bitboard_t enemy_bishops = hostile & position->bishops;
    bitboard_t enemy_knights = hostile & position->knights;
    bitboard_t enemy_rooks = hostile & position->rooks;
    bitboard_t enemy_queens = hostile & position->queens;
    
    bitboard_t enemy_slide = enemy_rooks | enemy_queens;
    bitboard_t enemy_diagonal = enemy_bishops | enemy_queens;

    bitboard_t empty = ~(hostile | friendly);
    bitboard_t can_move_to = ~friendly;
    // can_move_to is not friendly here because we DONT want
    // attack masks going through our own pieces

    bitboard_t ep_bb = make_ep_bb(board->en_passant_square);

    
    // It is an invariant (I hope...) that we cannot be in check from two of the same type of move
    // That is two say, we CAN be in check from only two of the same piece if they are queens
    // attacking as a rook and the other as a bishop


    
    // In order to find attackers against the king, we treat the King
    // as if it moved like each piece type, and see if it could attack an enemy piece of that type
    bool add_ep = false;
    if (enemy_pawns) {
        /*
        If we are in check by a pawn, and there is an en passant square, then we can get out
        of check by an en passant capture. 
        */
        if (for_color == BLACK_VAL){
            info = update_info(info, sw_pawn_attack(friendly_kings, can_move_to), enemy_pawns);
            info = update_info(info, se_pawn_attack(friendly_kings, can_move_to), enemy_pawns);
        } 
        else {
            info = update_info(info, nw_pawn_attack(friendly_kings, can_move_to), enemy_pawns);
            info = update_info(info, ne_pawn_attack(friendly_kings, can_move_to), enemy_pawns);
        }
			 //add_ep = true;	// This line was uncommented, with the below instead
			 // annotated with "WHAT???". This is a pretty hairy and silly function,
			 // a refactor should be done down the line
        if (info.king_attacker_count > 0) add_ep = true; 
    }
    if (enemy_knights) {
        info = update_info(info, SAFE_KNIGHT_MOVE_BB1(friendly_kings), enemy_knights);
        info = update_info(info, SAFE_KNIGHT_MOVE_BB2(friendly_kings), enemy_knights);
        info = update_info(info, SAFE_KNIGHT_MOVE_BB3(friendly_kings), enemy_knights);
        info = update_info(info, SAFE_KNIGHT_MOVE_BB4(friendly_kings), enemy_knights);
        info = update_info(info, SAFE_KNIGHT_MOVE_BB5(friendly_kings), enemy_knights);
        info = update_info(info, SAFE_KNIGHT_MOVE_BB6(friendly_kings), enemy_knights);
        info = update_info(info, SAFE_KNIGHT_MOVE_BB7(friendly_kings), enemy_knights);
        info = update_info(info, SAFE_KNIGHT_MOVE_BB8(friendly_kings), enemy_knights);
    }

    if (enemy_slide) {
        info = update_info(info, north_sliding_mask(friendly_kings, can_move_to, empty), enemy_slide);
        info = update_info(info, south_sliding_mask(friendly_kings, can_move_to, empty), enemy_slide);
        info = update_info(info, east_sliding_mask(friendly_kings, can_move_to, empty), enemy_slide);
        info = update_info(info, west_sliding_mask(friendly_kings, can_move_to, empty), enemy_slide);
    }

    if (enemy_diagonal) {
        info = update_info(info, ne_sliding_mask(friendly_kings, can_move_to, empty), enemy_diagonal);
        info = update_info(info, nw_sliding_mask(friendly_kings, can_move_to, empty), enemy_diagonal);
        info = update_info(info, se_sliding_mask(friendly_kings, can_move_to, empty), enemy_diagonal);
        info = update_info(info, sw_sliding_mask(friendly_kings, can_move_to, empty), enemy_diagonal);
    }
    if (add_ep) {
        info.extra_pawn_capture_mask |= ep_bb;
    }
    return info;
}

bitboard_t kingside_castling_mask(bitboard_t origin_bb, bitboard_t attacked_mask, bitboard_t empty){
    bitboard_t move_through = SAFE_RIGHT_BB(origin_bb);
    bitboard_t castling_dest = SAFE_RIGHT_BB(move_through);
    bitboard_t illegal = (move_through | castling_dest) & (attacked_mask | ~empty);
    if (!illegal) return castling_dest;
    else return 0;
}

bitboard_t queenside_castling_mask(bitboard_t origin_bb, bitboard_t attacked_mask, bitboard_t empty) {
    bitboard_t move_through = SAFE_LEFT_BB(origin_bb);
    bitboard_t castling_dest = SAFE_LEFT_BB(move_through);
    bitboard_t rook_through = SAFE_LEFT_BB(castling_dest);
    bitboard_t illegal = (move_through | castling_dest) & (attacked_mask | ~empty);
    illegal |= rook_through & ~empty;
    if (!illegal) return castling_dest;
    else return 0;
}

bitboard_t inner_knight_dest_bb(bitboard_t origin_bb, bitboard_t non_friendly, bitboard_t allowed_mask){
	bitboard_t destination_bb = knight_attack_mask(origin_bb, non_friendly);
  destination_bb &= allowed_mask;
	return destination_bb;
}


bitboard_t inner_rook_dest_bb(bitboard_t origin_bb, bitboard_t non_friendly, bitboard_t empty, bitboard_t allowed_mask){
	bitboard_t destination_bb = sliding_attack_mask(origin_bb, non_friendly,empty);
  destination_bb &= allowed_mask;
	return destination_bb;
}


bitboard_t inner_bishop_dest_bb(bitboard_t origin_bb, bitboard_t non_friendly, 
		bitboard_t empty, bitboard_t allowed_mask){
	bitboard_t destination_bb = diagonal_attack_mask(origin_bb, non_friendly, empty);
  destination_bb &= allowed_mask;
	return destination_bb;
}


bitboard_t inner_queen_dest_bb(bitboard_t origin_bb, bitboard_t non_friendly, bitboard_t empty, bitboard_t allowed_mask){
	bitboard_t destination_bb = diagonal_attack_mask(origin_bb, non_friendly, empty);
  destination_bb |= sliding_attack_mask(origin_bb, non_friendly, empty);
	destination_bb &= allowed_mask;
	return destination_bb;
}

bitboard_t inner_king_dest_bb(bitboard_t origin_bb, 
								castling_rights_t can_kingside, 
								castling_rights_t can_queenside,
								bitboard_t non_friendly, 
								bitboard_t empty, 
								bitboard_t attacked_mask){
		bitboard_t destination_bb 
			= king_attack_mask(origin_bb, non_friendly & ~attacked_mask);
		if (can_kingside) {
				bitboard_t kingside 
					= kingside_castling_mask(origin_bb, attacked_mask, empty);
				destination_bb |= kingside;
		}
		if (can_queenside) {
				bitboard_t queenside 
					= queenside_castling_mask(origin_bb, attacked_mask, empty);
				destination_bb |= queenside;
		}
		return destination_bb;
}

//destination_bb = inner_white_pawn_dest_bb(square_bb, pawn_hostile, empty, pinned_mask, allowed_mask, info.extra_pawn_capture_mask); 
bitboard_t inner_white_pawn_dest_bb(bitboard_t origin_bb, 
																		bitboard_t pawn_hostile, 
																		bitboard_t empty, 
																		bitboard_t allowed_push,
																		bitboard_t allowed_capture,
																		bitboard_t pinned_mask){	
				bitboard_t destination_bb = 
					white_pawn_push_mask(origin_bb, empty) & allowed_push;	
				destination_bb 
					|= white_pawn_attack_mask(origin_bb, pawn_hostile) 
					& allowed_capture; 
				destination_bb &= pinned_mask;
				return destination_bb;
}


bitboard_t inner_black_pawn_dest_bb(bitboard_t origin_bb, 
																		bitboard_t pawn_hostile, 
																		bitboard_t empty, 
																		bitboard_t allowed_push,
																		bitboard_t allowed_capture,
																		bitboard_t pinned_mask){ 
				bitboard_t destination_bb 
					= black_pawn_push_mask(origin_bb, empty) & allowed_push;
				destination_bb 
					|= black_pawn_attack_mask(origin_bb, pawn_hostile) & allowed_capture; 
				destination_bb &= pinned_mask;
				return destination_bb;
}






u_int8_t count_moves(
    full_board_t *board, 
    piece_color_t for_color, 
    bitboard_t attacked_mask,
    check_info_t info) {

    position_t *pos = board->position;
    bitboard_t friendly;
    bitboard_t hostile;

    bool can_kingside;
    bool can_queenside;
    if (for_color == WHITE_VAL) {
        friendly = pos->white_oc;
        hostile = pos->black_oc;
        can_kingside = board->castling_rights & WHITE_KINGSIDE;
        can_queenside = board->castling_rights & WHITE_QUEENSIDE;
    }
    else {
        friendly = pos->black_oc;
        hostile = pos->white_oc;
        can_kingside = board->castling_rights & BLACK_KINGSIDE;
        can_queenside = board->castling_rights & BLACK_QUEENSIDE;
    }
		bool not_check = info.king_attacker_count == 0;
    can_kingside = can_kingside && not_check;
    can_queenside = can_queenside && not_check;
		bitboard_t ep_bb = make_ep_bb(board->en_passant_square);
    bitboard_t empty = ~(friendly | hostile);


    bitboard_t pawn_hostile = (hostile | ep_bb);
    bitboard_t non_friendly = ~friendly;

    u_int8_t moves = 0;
		forbitboard(square_bb, friendly) {  
      bitboard_t destination_bb = 0;
			if (square_bb & pos->kings){
				destination_bb =
					inner_king_dest_bb(square_bb, 
							can_kingside, 
							can_queenside, 
							non_friendly, 
							empty, 
							attacked_mask);
        }
        bitboard_t pinned_mask = 
					make_pinned_mask(board, square_bb, for_color, attacked_mask);
        bitboard_t allowed_mask = pinned_mask & info.allowed_move_mask;
        if (square_bb & pos->pawns) {
						#define PAWN_DEST_BB(COLOR, PRO_RANK){\
								destination_bb =\
									COLOR##_pawn_push_mask(square_bb, empty) & allowed_mask;\
                destination_bb |= COLOR ##_pawn_attack_mask(square_bb, pawn_hostile)\
						 										& info.extra_pawn_capture_mask;\
                destination_bb &= pinned_mask;\
								if (square_bb & PRO_RANK)\
									moves += count_bits(destination_bb) * 4;\
								else moves += count_bits(destination_bb);\
						}
						if (square_bb & pos->white_oc)	
							PAWN_DEST_BB(white, RANK_7)	
						else 
							PAWN_DEST_BB(black, RANK_2)
						
					continue;
        }
        else if (square_bb & pos->knights) 
            destination_bb = 
							inner_knight_dest_bb(square_bb, non_friendly, allowed_mask);
        else if (square_bb & pos->rooks) {
          	destination_bb = 
							inner_rook_dest_bb(square_bb, non_friendly, empty, allowed_mask);	
        }
        else if (square_bb & pos->bishops) {
						destination_bb = 
							inner_bishop_dest_bb(square_bb, non_friendly, empty, allowed_mask);
				}
        else if (square_bb & pos->queens) {
          	destination_bb =
							inner_queen_dest_bb(square_bb, non_friendly, empty, allowed_mask);	
				}
				
        moves += count_bits(destination_bb);
    }
    return moves;
}

/*
typedef struct {
	bitboard_t destination;
	bitboard_t promotion_dest;
} destination_t;

typedef struct {
	bitboard_t our_white_pawns;
	bitboard_t our_black_pawns;
	bitboard_t our_kings;
	bitboard_t our_queens;
	bitboard_t our_rooks;
	bitboard_t our_bishops;
	bitboard_t our_knights;
	bitboard_t our
	bitboard_t attack_mask;
} foo_t;
*/


// returns true if there are any possible moves
bool has_moves(
    full_board_t *board, 
    piece_color_t for_color, 
    bitboard_t attacked_mask,
		bitboard_t allowed_origins,
    check_info_t info) {

    position_t *pos = board->position;
    bitboard_t friendly;
    bitboard_t hostile;
		
		bool is_white;
    if ((is_white = (for_color == WHITE_VAL))) {
        friendly = pos->white_oc;
        hostile = pos->black_oc;
    }
    else {
        friendly = pos->black_oc;
        hostile = pos->white_oc;
    }
    
      
		bitboard_t ep_bb = make_ep_bb(board->en_passant_square);
    bitboard_t empty = ~(friendly | hostile);
    bitboard_t pawn_hostile = (hostile | ep_bb);
    bitboard_t non_friendly = ~friendly;

		forbitboard(square_bb, (friendly & allowed_origins)) {
        bitboard_t destination_bb = 0;
        if (square_bb & pos->kings) {
						// if we could have castled, theres another king move
            destination_bb = inner_king_dest_bb(square_bb, false, 
										false, non_friendly, empty, attacked_mask);
						if (destination_bb) return true;
				}
				bitboard_t pinned_mask = make_pinned_mask(board, square_bb, for_color, 
																		attacked_mask);
        bitboard_t allowed_mask = pinned_mask & info.allowed_move_mask;
        if (square_bb & pos->pawns) {
						if (is_white) {
								destination_bb = inner_white_pawn_dest_bb(square_bb, pawn_hostile, 
										empty, allowed_mask, 
										info.extra_pawn_capture_mask,
										pinned_mask); 
            }
            else {
								destination_bb = inner_black_pawn_dest_bb(square_bb, pawn_hostile, empty, allowed_mask, 
										info.extra_pawn_capture_mask, pinned_mask); 
            }
        }
        else if (square_bb & pos->knights) {
            destination_bb = inner_knight_dest_bb(square_bb, non_friendly, 
														allowed_mask);
        }
        else if (square_bb & pos->rooks) {
            destination_bb = inner_rook_dest_bb(square_bb, 
														non_friendly, empty, allowed_mask);
            
        }
        else if (square_bb & pos->bishops) {
            destination_bb = inner_bishop_dest_bb(square_bb, non_friendly, 
														empty, allowed_mask);
        }
        else if (square_bb & pos->queens) {
            destination_bb = inner_queen_dest_bb(square_bb, non_friendly, 
														empty, allowed_mask);
        }
				if (destination_bb) return true;
    }
		return false;
}


#define CHECK_KNIGHT \
if (square_bb & position->knights){\
	bitboard_t destination_bb = inner_knight_dest_bb(square_bb,\
														non_friendly, allowed_mask);\
            add_from_bitboard(origin, destination_bb, move_buffer, KNIGHT_VAL, &move_index);}



#define CHECK_PIECE(PIECE, VAL)\
if (square_bb & position->PIECE ##s){\
	bitboard_t destination_bb = inner_##PIECE##_dest_bb(square_bb,\
														non_friendly, empty, allowed_mask);\
            add_from_bitboard(origin, destination_bb, move_buffer, VAL, &move_index);}

#define ADD_PAWN(COLOR, RANK)\
destination_bb = inner_##COLOR##_pawn_dest_bb(square_bb,\
		pawn_hostile, empty, allowed_mask, info.extra_pawn_capture_mask, pinned_mask);\
if (square_bb & RANK)\
	add_from_bitboard_##COLOR##_promotes(origin, destination_bb,\
																	move_buffer, &move_index);\
else add_from_bitboard(origin, destination_bb, move_buffer, PAWN_VAL, &move_index);\
        

u_int8_t generate_moves(full_board_t *board, piece_color_t for_color, 
    bitboard_t attacked_mask, check_info_t info, bitboard_t allowed_origins,
		move_t * move_buffer) {
    
		u_int8_t move_index = 0;
    position_t *position = board->position;
    bitboard_t friendly;
    bitboard_t hostile;
		
		bool can_kingside;
    bool can_queenside;
		bool is_white;

    if ((is_white = (for_color == WHITE_VAL))) {
        friendly = position->white_oc;
        hostile = position->black_oc;
        can_kingside = board->castling_rights & WHITE_KINGSIDE;
        can_queenside = board->castling_rights & WHITE_QUEENSIDE;
    }
    else {
        friendly = position->black_oc;
        hostile = position->white_oc;
        can_kingside = board->castling_rights & BLACK_KINGSIDE;
        can_queenside = board->castling_rights & BLACK_QUEENSIDE;
    }
    
		can_kingside = can_kingside && (info.king_attacker_count == 0);
    can_queenside = can_queenside && (info.king_attacker_count == 0);
		bitboard_t ep_bb = make_ep_bb(board->en_passant_square);
    bitboard_t empty = ~(friendly | hostile);
    bitboard_t pawn_hostile = (hostile | ep_bb);
    bitboard_t non_friendly = ~friendly;
		bitboard_t unallowed = ~allowed_origins | non_friendly;	
		
		for (square_t origin = A1; origin <= H8; origin++) {
				bitboard_t square_bb = SQUARE_TO_BB(origin);
        if (square_bb & unallowed) continue;
        if (square_bb & position->kings) {
            bitboard_t destination_bb = 
							inner_king_dest_bb(square_bb, can_kingside, 
														can_queenside, non_friendly, empty, attacked_mask);
            add_from_bitboard(origin, destination_bb, move_buffer, KING_VAL, &move_index);
            continue;
        }
				bitboard_t pinned_mask = make_pinned_mask(board, square_bb, 
						for_color, attacked_mask);
        bitboard_t allowed_mask = pinned_mask & info.allowed_move_mask;
				if (square_bb & position->pawns) {
            bitboard_t destination_bb;
						if (is_white) {
            	ADD_PAWN(white, RANK_7)
						}
						else {
							ADD_PAWN(black, RANK_2)
            }
        }
				else CHECK_KNIGHT
				else CHECK_PIECE(bishop, BISHOP_VAL)
				else CHECK_PIECE(rook, ROOK_VAL)
				else CHECK_PIECE(queen, QUEEN_VAL)
		}
    return move_index;
}


bitboard_t ext_get_pinned_mask(full_board_t *board, square_t square) {
	piece_color_t for_color = board->turn;
  bitboard_t attack_mask = make_attack_mask(board, WHITE_VAL == for_color ? BLACK_VAL : WHITE_VAL);
	return make_pinned_mask(board, SQUARE_TO_BB(square), for_color, attack_mask);	
}

bitboard_t ext_get_attack_mask(full_board_t *board) {
	return make_attack_mask(board, WHITE_VAL == board->turn ? BLACK_VAL : WHITE_VAL);
}


bitboard_t piece_attack_mask(piece_t piece, bitboard_t origins, 
								bitboard_t non_friendly, bitboard_t empty) {
	switch (piece.type) {
		case KNIGHT_VAL:
		return knight_attack_mask(origins, non_friendly);
		case BISHOP_VAL:
		return diagonal_attack_mask(origins, non_friendly, empty);
		case ROOK_VAL:
		return sliding_attack_mask(origins, non_friendly, empty);
		case QUEEN_VAL:
		return sliding_attack_mask(origins, non_friendly, empty) | 
					diagonal_attack_mask(origins, non_friendly, empty);
		case KING_VAL:
		return king_attack_mask(origins, non_friendly);
		case PAWN_VAL:
		return piece.color == WHITE_VAL ? 
						white_pawn_attack_mask(origins, non_friendly)	: 
						black_pawn_attack_mask(origins, non_friendly);
		default: return 0;
	}
}

bitboard_t possible_pawn_origins(piece_color_t color, 
											bitboard_t dest_bb, bitboard_t empty, bitboard_t hostile, bool is_capture) {
	bitboard_t origins;
	if (color == WHITE_VAL) {
		if (!is_capture) {
			origins = SAFE_BELOW_BB(dest_bb & empty);
	 		origins |= SAFE_BELOW_BB(origins & empty) & RANK_2;
		}
		else {
			bitboard_t below = SAFE_BELOW_BB(dest_bb & hostile);
			origins = (SAFE_RIGHT_BB(below) | SAFE_LEFT_BB(below));	
		}
	}
	else {
		if (!is_capture) {
			origins = SAFE_ABOVE_BB(dest_bb & empty);
			origins |= SAFE_ABOVE_BB(origins & empty) 
				& RANK_7;
		}
		else {
			bitboard_t above = SAFE_ABOVE_BB(dest_bb & hostile);
			origins = (SAFE_RIGHT_BB(above) | SAFE_LEFT_BB(above)); 
		}
	}
	return origins;
}




// From the given board, determines the origin
// of a move specified by piece type and destination
// Returns a non existant square if there is no possible
// move, allowing for pseudolegality. 
// Writes a descriptive error message into the provided pointer
// if this occurs.
// This function does not consider castling
optional_square_t determine_origin(full_board_t *board, 
																	piece_type_t piece_type,
																	bool is_capture,
																	square_t destination,
																	bitboard_t allowed_origins,
																	char *err) {
	
	position_t * pos = board->position;	
	bitboard_t dest_bb = SQUARE_TO_BB(destination);
	
	bitboard_t empty = ~pos->white_oc & ~pos->black_oc;
	bitboard_t hostile_oc;
	bitboard_t friendly_oc;

	if (board->turn == WHITE_VAL) {
		friendly_oc = pos->white_oc;
		hostile_oc = pos->black_oc;
	}

	else {
		hostile_oc = pos->white_oc;
		friendly_oc = pos->black_oc;
	
	}
	piece_t piece;
	piece.type = piece_type;
	piece.color = board->turn;
	bitboard_t piece_bb = get_piece_bb(pos, piece);
	bitboard_t possible_origins;
	allowed_origins &= piece_bb;
	if (!allowed_origins) { // may result in bad err messaging
		char piece_name[10];
		write_name(piece_type, piece_name);
		char dest[3];
		serialize_square(destination, dest);
		sprintf(err, "%s has no %s to move", 
				board->turn == WHITE_VAL ? "White" : "Black", 
				piece_name);
		optional_square_t no_sq;
		no_sq.exists = false;
		return no_sq;	
	}
	
	if (piece_type == PAWN_VAL) {
		bitboard_t hostile = hostile_oc | make_ep_bb(board->en_passant_square);
		possible_origins = possible_pawn_origins(piece.color, dest_bb, empty, hostile, is_capture);
	}
	else {
		possible_origins = piece_attack_mask(piece, dest_bb, FULL_BB, empty);
	}
	possible_origins &= allowed_origins & piece_bb;
	if (possible_origins) {
		optional_square_t single_origin = bitboard_to_square(possible_origins);
		if (single_origin.exists) return single_origin;
		else {
			// slow fallback, we shouldnt have to check all this in most cases
			bitboard_t refined_origins = 0;
			move_t piece_moves[64];	
			u_int8_t count = generate_piece_moves(board, piece_type, piece_moves);
			for (u_int8_t i = 0; i < count; i++) {
				if (get_destination(piece_moves[i]) == destination)
					refined_origins |= SQUARE_TO_BB(get_origin(piece_moves[i]));	
			}
			optional_square_t origin = bitboard_to_square(refined_origins);
			// still not certain if the given move 
			// and position are "weird"
			// dont ask me for an example
			if (origin.exists) return origin; 
		}
	}
	else {
		char piece_name[10];
		write_name(piece_type, piece_name);
		char dest[3];
		serialize_square(destination, dest);
		sprintf(err, "%s moving to %s is not legal", 
			piece_name, dest); 
		optional_square_t no_sq;
		no_sq.exists = false;
		return no_sq;
	}
	char piece_name[10];
	write_name(piece_type, piece_name);
	char dest[3];
	serialize_square(destination, dest);
	sprintf(err, "Ambigious origin for %s moving to %s", 
			piece_name, dest); 
	optional_square_t no_sq;
	no_sq.exists = false;
	return no_sq;	
}

move_t san_pawn_push_to_move(full_board_t * board, 
														 san_pawn_push_t move,
														 char *err) {
	//return get_matching_move(board, PAWN_VAL, FULL_BB, move.promote_to, false, move.destination); 	
	square_t destination = move.destination;
	optional_square_t origin = determine_origin(board, PAWN_VAL, 
																false, destination, FULL_BB, err);
	if (origin.exists) {
		if (move.promote_to == EMPTY_VAL)
			return generic_move(move_body(origin.square, destination));
		else return promotion_move(move_body(origin.square, destination), 
															move.promote_to);
	} 
	else {
		// error msg already set by determine origin
		return error_move();
	}
}

move_t san_pawn_capture_to_move(full_board_t * board, san_pawn_capture_t move, char *err){
	bitboard_t allowed_origins = FILE_A << (move.from_file);
	if (move.from_rank.exists) 
		allowed_origins &= RANK_1 << (8 * move.from_rank.value);
	square_t destination = move.destination;
	optional_square_t origin = determine_origin(board, PAWN_VAL, true,
																destination, allowed_origins, err);

	if (origin.exists) {
		if (move.promote_to == EMPTY_VAL)
			return generic_move(move_body(origin.square, destination));
		else return promotion_move(move_body(origin.square, destination), 
															move.promote_to);
	} else return error_move();
}

move_t san_std_to_move(full_board_t * board, 
											 san_std_move_t move,
											 char *err) {
	bitboard_t origins_bb = FULL_BB;
	if (move.from_file.exists) {
		origins_bb &= (FILE_A << move.from_file.value);
	}
	if (move.from_rank.exists) {
		origins_bb &= (RANK_1 << 8 * move.from_rank.value);
	}
	square_t destination = move.destination;
	optional_square_t origin = 
		determine_origin(board, move.moving_piece,
				move.is_capture, destination, origins_bb, err);
	if (origin.exists) {
		return generic_move(move_body(origin.square, destination));
	} 
	else {
		return error_move();
	}
}

move_t san_castling_to_move(full_board_t * board, bool kingside) {
	bool whites_turn = board->turn == WHITE_VAL;
	square_t destination;
	square_t origin = whites_turn ? E1 : E8;
	if (kingside) {
		destination = whites_turn ? G1 : G8;
	}
	else {
		destination = whites_turn ? C1 : C8;
	}
	return generic_move(move_body(origin, destination)); 

}

move_t san_to_move(full_board_t * board, san_move_t san, char* err) {
	switch (san.type) {
	case SAN_STD: 
		return san_std_to_move(board, san.std_move, err);
	case SAN_PAWN_PUSH: 
		return san_pawn_push_to_move(board, san.pawn_push, err);
	case SAN_PAWN_CAPTURE: 
		return san_pawn_capture_to_move(board, san.pawn_capture, err);
	case SAN_CASTLING: 
		return san_castling_to_move(board, san.castling_kingside);
	default: 
		strcpy(err, "Invalid SAN");								 
		return error_move();
	}
}

move_t san_str_to_move(full_board_t *board, char *str, 
		bool *is_err, char *error) {
	bool parse_err;
	san_move_t san = parse_san(str, &parse_err);
	if (parse_err) {
		*is_err = true;
		return error_move();
	}
	move_t move = san_to_move(board, san, error);
	if (move.type == ERROR_MOVE) *is_err = true; 
	return move;
}

/*
// Checks if the given piece (as color and type) can legally moved
// given a found pinned_mask
bool can_move_piece(
		
		bitboard_t pinned_mask){
	switch (moving_type) {
		case PAWN_VAL:
					
	}


}	
*/
													
san_move_t promotion_to_san(full_board_t * board, promotion_move_t move){
	bitboard_t pawn_attacks; 
				
	square_t dest = move.body.destination;
	bitboard_t dest_bb = SQUARE_TO_BB(dest);
	square_t origin = move.body.origin;
	bitboard_t origin_bb = SQUARE_TO_BB(origin);
	position_t * pos = board->position;
	bitboard_t empty = ~pos->white_oc & ~pos->black_oc;
	bitboard_t white_pawns = pos->white_oc & pos->pawns;
	bitboard_t black_pawns = pos->black_oc & pos->pawns;
	bitboard_t hostile_oc;
	bool is_white;
	piece_color_t color;
	if ((dest_bb & RANK_1)
			&& (origin_bb & RANK_2 & black_pawns)) {
		is_white = false;
		color = BLACK_VAL;
		hostile_oc = pos->white_oc;
		pawn_attacks = piece_attack_mask(black_piece(PAWN_VAL), origin_bb, FULL_BB, FULL_BB);
	}
	else if ((dest_bb & RANK_8)
					&& (origin_bb & RANK_7 & white_pawns)){
		is_white = true;
		color = WHITE_VAL;
		hostile_oc = pos->black_oc;
		pawn_attacks = piece_attack_mask(white_piece(PAWN_VAL), origin_bb, FULL_BB, FULL_BB);
	}
	else return error_san();
	if ((dest_bb & empty) 
			&&
			((!is_white && (dest_bb == BELOW_BB(origin_bb)))
			||
			(is_white && (dest_bb == ABOVE_BB(origin_bb))))) {		
			san_move_t san;
			san.type = SAN_PAWN_PUSH;
			san.pawn_push.destination = dest;
			san.pawn_push.promote_to = move.promote_to;
			return san;
	}
	else if (dest_bb & hostile_oc & pawn_attacks) {
		san_move_t san;
		san.type = SAN_PAWN_CAPTURE;
		san.pawn_capture.destination = dest;
		san.pawn_capture.promote_to = move.promote_to;
		san.pawn_capture.from_file = file_char_of_square(origin) - 'a';
		san.pawn_capture.from_rank.exists = false;
		return san;
	}
	else return error_san(); 
}


san_move_t pawn_generic_to_san(full_board_t * board,
								generic_move_t move, piece_color_t for_color) {
			position_t * pos = board->position;
			bitboard_t hostile_bb = for_color == WHITE_VAL ? 
															pos->black_oc : pos->white_oc;
			bitboard_t dest_bb = SQUARE_TO_BB(move.destination);
			bitboard_t origin_bb = SQUARE_TO_BB(move.origin);
			bitboard_t pawn_hostile = hostile_bb | make_ep_bb(board->en_passant_square);
			bitboard_t empty = ~(pos->white_oc | pos->black_oc);
			
			bool is_capture = pawn_hostile & dest_bb;
			bitboard_t attack_mask;
			bitboard_t push_mask;
			if (for_color == WHITE_VAL) {
				if (!is_capture) push_mask = white_pawn_push_mask(origin_bb, empty);	
				else attack_mask = white_pawn_attack_mask(origin_bb, pawn_hostile);
			}
			else {
				if (!is_capture) push_mask = black_pawn_push_mask(origin_bb, empty);
				else attack_mask = black_pawn_attack_mask(origin_bb, pawn_hostile);
			}	
			if (!is_capture && (dest_bb & push_mask)) {
					san_move_t san;
					san.type = SAN_PAWN_PUSH;
					san.pawn_push.destination = move.destination;
				 	san.pawn_push.promote_to = EMPTY_VAL;
					san.pawn_push.from_file.exists = false;
					san.pawn_push.from_rank.exists = false;
					return san;
			}
			else if (is_capture && (dest_bb & attack_mask)) {
					san_move_t san;
					san.type = SAN_PAWN_CAPTURE;
					san.pawn_capture.destination = move.destination;
					san.pawn_capture.promote_to = EMPTY_VAL;
					san.pawn_capture.from_file = file_char_of_square(move.origin) - 'a';
					san.pawn_capture.from_rank.exists = false;
					return san;
			}
			else {
			
				return error_san();
			}	
}

san_move_t other_generic_to_san(full_board_t * board, 
																generic_move_t move,
																piece_t piece){
	position_t * pos = board->position;
				
				
	bitboard_t dest_bb = SQUARE_TO_BB(move.destination);
	bitboard_t origin_bb = SQUARE_TO_BB(move.origin);

	bitboard_t empty = ~(pos->white_oc | pos->black_oc);
	bitboard_t hostile = piece.color == WHITE_VAL ? pos->black_oc : pos->white_oc;
	bitboard_t friendly = ~hostile & ~empty;
	
	bool is_capture = dest_bb & hostile;
		
	bitboard_t attack_mask = piece_attack_mask(piece, dest_bb, FULL_BB, empty);
	bitboard_t piece_mask = get_piece_bb(pos, piece); 
	
	bitboard_t possible_origins = piece_mask & attack_mask;
	if (origin_bb == possible_origins) {
		san_move_t san;
		san.type = SAN_STD;
		san.std_move.moving_piece = piece.type;
		san.std_move.from_file.exists = false;
		san.std_move.from_rank.exists = false;
		san.std_move.is_capture = is_capture;
		san.std_move.destination = move.destination;	
		return san;
	}
	else if (origin_bb & possible_origins) {
		bitboard_t origin_file_bb = file_bb_of_square(move.origin);
		bitboard_t file_view_bb = origin_file_bb & possible_origins;
	
		bitboard_t origin_rank_bb = rank_bb_of_square(move.destination);
		bitboard_t rank_view_bb = origin_rank_bb & possible_origins;
	
		optional_u_int8_t maybe_file;
		optional_u_int8_t maybe_rank;
			
		if (file_view_bb == origin_bb) {
			maybe_file.exists = true;
			maybe_rank.exists = false;
			maybe_file.value = file_char_of_square(move.origin) - 'a'; 	
		}
		else if (rank_view_bb == origin_bb) {
			maybe_rank.exists = true;
			maybe_file.exists = false;
			maybe_rank.value = rank_char_of_square(move.origin) - '1'; 	
		}
		else {
			maybe_rank.exists = true;
			maybe_rank.value = rank_char_of_square(move.origin) - '1'; 	
			maybe_file.exists = true;
			maybe_file.value = file_char_of_square(move.origin) - 'a'; 	
		}
		san_move_t san;
		san.type = SAN_STD;
		san.std_move.moving_piece = piece.type;
		san.std_move.from_file = maybe_file;
		san.std_move.from_rank = maybe_rank;
		san.std_move.is_capture = is_capture;
		san.std_move.destination = move.destination;	

		return san;	
	}
	else {
		return error_san();	
	}
}

san_move_t generic_to_san(full_board_t * board, generic_move_t move){
	piece_t piece = get_piece_at(board->position, move.origin);	
	switch (piece.type) {
			case EMPTY_VAL:
			return error_san();						
			case PAWN_VAL:
			return pawn_generic_to_san(board, move, piece.color);
			default:
			return other_generic_to_san(board, move, piece);
	}
	return error_san();
}

san_move_t castling_to_san(castling_rights_t castling_type) {
	san_move_t san;
	san.type = SAN_CASTLING;
	san.castling_kingside = castling_type & ANY_KINGSIDE;
	return san;
}

// Cannot assume move is legal, but can that it is valid
san_move_t move_to_san_inner(full_board_t *board, move_t move) {	
	castling_rights_t castling_type = get_castling_type(move, board);
	if (castling_type == NO_CASTLING) {
		switch (move.type) {
			case PROMOTION_MOVE:
			return promotion_to_san(board, move.promotion);	
			case GENERIC_MOVE:
			return generic_to_san(board, move.generic);
			default:
			return error_san();
		}	
	}
	else return castling_to_san(castling_type);
}

// gets the status of a board after applying a move,
// excluding the case of threefold and fivefold rep
board_status_t status_of_app(full_board_t *board, move_t move) {
	full_board_t copy;
	position_t pos;
	copy.position = &pos;
	copy_into(&copy, board);
	apply_move(&copy, move);
	board_status_t status = get_status(&copy, 0, 0);
 	return status;	
		
}


san_move_t move_to_san(full_board_t *board, move_t move) {
	san_move_t san = move_to_san_inner(board,move);
	san.ann_type = NO_ANN;
	board_status_t status = status_of_app(board, move);
	if (status & CHECK_STATUS) {
		if (status & MATE_STATUS) {
			san.check_status = SAN_CHECKMATE;			
		}
		else san.check_status = SAN_CHECK;
	}
	else san.check_status = SAN_NOCHECK;
	return san;
}

bool move_to_san_str(full_board_t * board, move_t move, char * buffer) {
	return write_san(move_to_san(board, move), buffer);
}

// Returns true if the side to move is in check
bool in_check(full_board_t *board) {
		piece_color_t for_color = board->turn;
    bitboard_t attack_mask = make_attack_mask(board, WHITE_VAL == for_color ? BLACK_VAL : WHITE_VAL);
    return in_check_with_attacker_mask(board->position, for_color, attack_mask);
}

bool opponent_in_check(full_board_t *board) {
		piece_color_t for_color = board->turn == WHITE_VAL ? BLACK_VAL : WHITE_VAL;
    bitboard_t attack_mask = make_attack_mask(board, WHITE_VAL == for_color ? BLACK_VAL : WHITE_VAL);
    return in_check_with_attacker_mask(board->position, for_color, attack_mask);
}

u_int8_t get_checkers(full_board_t *board) {
		piece_color_t for_color = board->turn;
    bitboard_t attack_mask = make_attack_mask(board, WHITE_VAL == for_color ? BLACK_VAL : WHITE_VAL);
		check_info_t info = make_check_info(board, for_color, attack_mask);
		return info.king_attacker_count;	
}	


bool is_stalemate(full_board_t *board) {
		piece_color_t for_color = board->turn;
    bitboard_t attack_mask = make_attack_mask(board, WHITE_VAL == for_color ? BLACK_VAL : WHITE_VAL);
    if (in_check_with_attacker_mask(board->position, for_color, attack_mask)) return false;
		check_info_t info = non_check_info();
		return count_moves(board, for_color, attack_mask, info) == 0;
}

bool is_checkmate(full_board_t *board) {
		piece_color_t for_color = board->turn;
    bitboard_t attack_mask = make_attack_mask(board, WHITE_VAL == for_color ? BLACK_VAL : WHITE_VAL);
    if (in_check_with_attacker_mask(board->position, for_color, attack_mask)) {
			check_info_t info = make_check_info(board, for_color, attack_mask);
    	return count_moves(board, for_color, attack_mask, info) == 0;
		}
		return false;
}



board_status_t get_repetition_outcome(full_board_t *board, 
																			undoable_move_t *move_stack, 
																			u_int16_t stack_size) {
	turn_clock_t halfmove = board->halfmove_clock;
	if (halfmove < 3 || stack_size < 3) return NO_STATUS;	
	u_int8_t matches = 1; //1 match with itself
	full_board_t copy;
	position_t pos;
	copy.position = &pos;
	copy_into(&copy, board); 
	board_status_t outcome = NO_STATUS;
	for (int16_t index = stack_size - 1; index >= 0; index--) {
		undo_move(&copy, move_stack[index]);
		halfmove = halfmove ? halfmove - 1 : 0;
		if (halfmove != copy.halfmove_clock) break;
		if (boards_legally_equal(&copy, board)) ++matches;
		if (matches == 3) outcome |= THREE_FOLD_REPETITION;
		else if (matches == 5) return outcome | FIVE_FOLD_REPETITION;
	}
	return outcome;	
}


bool is_nfold_repetition(full_board_t *board, undoable_move_t *stack,
		size_t stack_size, u_int8_t n){
	turn_clock_t halfmove = board->halfmove_clock;
	if (halfmove < n || stack_size < n) return false;	
	u_int8_t matches = 1; //1 match with itself
	full_board_t copy;
	position_t pos;
	copy.position = &pos;
	copy_into(&copy, board); 
	for (int16_t index = stack_size - 1; index >= 0; index--) {
		undo_move(&copy, stack[index]);
		halfmove = halfmove ? halfmove - 1 : 0;
		if (halfmove != copy.halfmove_clock) break;
		if (boards_legally_equal(&copy, board)) ++matches;
		if (matches == n) return true;
	}
	return false;	
}


bool is_fivefold_repetition(full_board_t *board, 
		undoable_move_t *stack, size_t stack_size){
	return is_nfold_repetition(board, stack, stack_size, 5);
}


bool is_threefold_repetition(full_board_t *board, 
		undoable_move_t *stack, size_t stack_size){
	return is_nfold_repetition(board, stack, stack_size, 3);
}


bool is_insufficient_material(full_board_t * board) {
	position_t * position = board->position;
	if (position->pawns || position->rooks || position->queens) {
		return false;
	}
	if (!position->bishops) {
		return count_bits(position->knights) < 2;
	}
	else if (!position->knights) {
		u_int8_t bishop_count = count_bits(position->bishops);
		if (bishop_count <= 1) return true;
		else {
			bitboard_t light_sq_bishops = LIGHT_SQ_BB & position->bishops;
			bitboard_t dark_sq_bishops = DARK_SQ_BB & position->bishops;
			//bitboard_t black_bishops = position->white_oc & position->bishops;
			//bitboard_t white_bishops = position->black_oc & position->bishops;
			return !(light_sq_bishops && dark_sq_bishops);
			/*
			bitboard_t light_bishops;
			bitboard_t dark_bishops;
			if (white_bishops) {
				light_bishops = LIGHT_SQ_BB & white_bishops;
 				dark_bishops = DARK_SQ_BB & white_bishops;			
			}
			else {
				light_bishops = LIGHT_SQ_BB & black_bishops;
				dark_bishops = DARK_SQ_BB & black_bishops;
			}
			return !light_bishops || !dark_bishops;
			*/
		}
	}
	return false;
}

/*
 *  The game is drawn, upon a correct claim by a player having the move, if:

9.3.1    he/she indicates his/her move, which cannot be changed, by writing it on the paper scoresheet or entering it on the electronic scoresheet and declares to the arbiter his/her intention to make this move which will result in the last 50 moves by each player having been made without the movement of any pawn and without any capture, or

9.3.2    the last 50 moves by each player have been completed without the movement of any pawn and without any capture.
 */
bool can_claim_fifty(full_board_t *board) {
	if (board->halfmove_clock < 99) return false;
	else if (board->halfmove_clock == 99) {
		// not worried about efficiency in this case, since this 
		// is very rare
		move_t moves[100];
		u_int8_t count = generate_legal_moves(board, moves);
		if (!count) return false;
		for (int i = 0; i < count; i++) {
			undoable_move_t m = apply_move(board, moves[i]);
			turn_clock_t halfs = board->halfmove_clock;
			undo_move(board, m);
			if (halfs == 100) return true;
		}
		return false;	
	}
	else return !is_checkmate(board);
}

bool is_seventy_five(full_board_t *board) {
	return (board->halfmove_clock >= 150) && !is_checkmate(board);
}

// Returns the outcome of the game this board is a part of 
board_status_t get_status(full_board_t * board, 
								undoable_move_t * stack,
								u_int16_t stack_size) {
		piece_color_t for_color = board->turn;
    bitboard_t attack_mask = make_attack_mask(board, 
															WHITE_VAL == for_color ? BLACK_VAL : WHITE_VAL);
    check_info_t info = make_check_info(board, for_color, attack_mask);
		bool has_m = has_moves(board, for_color, attack_mask, FULL_BB, info);
		board_status_t outcome = info.king_attacker_count ? CHECK_STATUS : NO_STATUS;
		if (has_m) {
			if (stack && stack_size) 
				outcome |= get_repetition_outcome(board, stack, stack_size);
			if (can_claim_fifty(board)) outcome |= FIFTY_MOVE_TIMEOUT;
			if (is_seventy_five(board)) outcome |= SEVENTY_FIVE_MOVE_TIMEOUT;
			if (is_insufficient_material(board)) outcome |= INSUFFICIENT_MATERIAL;
			}
		else outcome |= MATE_STATUS;
		return outcome;	
}


bool board_is_forced_draw(full_board_t *board, 
		undoable_move_t *stack, size_t stack_size){
		piece_color_t for_color = board->turn;
    bitboard_t attack_mask = make_attack_mask(board, 
															WHITE_VAL == for_color ? BLACK_VAL : WHITE_VAL);
    check_info_t info = make_check_info(board, for_color, attack_mask);
		bool has_m = has_moves(board, for_color, attack_mask, FULL_BB, info);
		if (has_m) {
			return is_seventy_five(board) 
				|| is_insufficient_material(board) 
				|| is_nfold_repetition(board, stack, stack_size, 5);
		}
		else return info.king_attacker_count ? false : true;
}



bool board_is_draw(full_board_t *board, 
		undoable_move_t *stack, size_t stack_size){
		piece_color_t for_color = board->turn;
    bitboard_t attack_mask = make_attack_mask(board, 
															WHITE_VAL == for_color ? BLACK_VAL : WHITE_VAL);
    check_info_t info = make_check_info(board, for_color, attack_mask);
		bool has_m = has_moves(board, for_color, attack_mask, FULL_BB, info);
		if (has_m) {
			return can_claim_fifty(board) 
				|| is_seventy_five(board) 
				|| is_insufficient_material(board) 
				|| is_nfold_repetition(board, stack, stack_size, 3);
		}
		else return info.king_attacker_count ? false : true;
}


bool is_draw(board_status_t status) {
	return (status & MATE_STATUS && status & ~CHECK_STATUS)
		|| (status & INSUFFICIENT_MATERIAL)
		|| (status & FIFTY_MOVE_TIMEOUT)
		|| (status & THREE_FOLD_REPETITION);
}


bool is_capture(full_board_t *board, move_t move) {
	position_t *pos = board->position;
	bitboard_t origin = SQUARE_TO_BB(get_origin(move));
	bitboard_t destination = SQUARE_TO_BB(get_destination(move));
	if (origin & pos->white_oc) {
		return destination & pos->black_oc;
	}
	else if (origin & pos->black_oc) {
		return destination & pos->white_oc;
	}
	else return false;
}

// Gets the status of the board after applying the given move
board_status_t get_apply_status(move_t move,
															full_board_t *board,
															undoable_move_t *stack,
															u_int16_t stack_size) {
	position_t pos;
	full_board_t copy;
	copy.position = &pos;
	copy_into(&copy, board);
	apply_move(board, move);
	return get_status(board, stack, stack_size);
}


u_int8_t count_legal_moves(full_board_t *board) {
		piece_color_t for_color = board->turn;
    bitboard_t attack_mask = make_attack_mask(board, WHITE_VAL == for_color ? BLACK_VAL : WHITE_VAL);
    check_info_t info = make_check_info(board, for_color, attack_mask);
    return count_moves(board, for_color, attack_mask, info);
}



bool has_legal_moves(full_board_t *board) {
		piece_color_t for_color = board->turn;
    bitboard_t attack_mask = make_attack_mask(board, WHITE_VAL == for_color ? BLACK_VAL : WHITE_VAL);
    check_info_t info = make_check_info(board, for_color, attack_mask);
    return has_moves(board, for_color, attack_mask, FULL_BB, info);
}

int16_t net_mobility(full_board_t * board) {
	bitboard_t attack_mask = make_attack_mask(board, BLACK_VAL);
	check_info_t info = make_check_info(board, WHITE_VAL, attack_mask);
	int16_t white_count = count_moves(board, WHITE_VAL, attack_mask, info);
	attack_mask = make_attack_mask(board, WHITE_VAL);
	info = make_check_info(board, BLACK_VAL, attack_mask);
	int16_t black_count = count_moves(board, BLACK_VAL, attack_mask, info);
	return white_count - black_count;
}



u_int8_t count_pseudolegal_moves(full_board_t *board) {
    return count_moves(board, board->turn, 0, non_check_info());
}

u_int8_t generate_legal_moves(full_board_t *board, move_t * move_buffer) {
		piece_color_t for_color = board->turn;
    bitboard_t attack_mask = make_attack_mask(board, WHITE_VAL == for_color ? BLACK_VAL : WHITE_VAL);
    check_info_t info = make_check_info(board, for_color, attack_mask);
    return generate_moves(board, for_color, attack_mask, info, FULL_BB, move_buffer);
}


u_int8_t generate_piece_moves(full_board_t *board, piece_type_t for_piece, move_t *move_buffer) {
		piece_color_t for_color = board->turn;
    bitboard_t attack_mask = 
			make_attack_mask(board, 
					WHITE_VAL == for_color ? BLACK_VAL : WHITE_VAL);
    check_info_t info = make_check_info(board, for_color, attack_mask);
		bitboard_t allowed = get_piece_type_bb(board->position, for_piece);
    return generate_moves(board, for_color, attack_mask, info, allowed, move_buffer);
}


u_int8_t generate_legal_move_hashes(full_board_t *board, u_int64_t *hash_buffer) {
	move_t move_buffer[256];
	u_int8_t length = generate_legal_moves(board, move_buffer);
	for (int i = 0; i < length; i++) {
		hash_buffer[i] = hash_move(move_buffer[i]);
	}
	return length;
}



u_int8_t generate_pseudolegal_moves(full_board_t *board, move_t * move_buffer) {
     return generate_moves(board, board->turn, 0, non_check_info(), FULL_BB, move_buffer);
}



u_int64_t pseudo_perft(full_board_t * board, u_int8_t depth) {
    if (depth == 0) {
        return 1;
    }
    else if (depth == 1) {
        return (u_int64_t)count_pseudolegal_moves(board);
    }
    else{
        move_t moves[256];
        u_int8_t count = generate_pseudolegal_moves(board,moves);
        u_int64_t nodes = 0;
        for (u_int8_t i = 0; i < count; i ++){
            undoable_move_t undo = apply_move(board, moves[i]);
            nodes += pseudo_perft(board, depth - 1);
        		undo_move(board, undo);
				}
        return nodes;

    }
}


void randomize_board(full_board_t *board) {
		u_int8_t should_continue = random() % 100;
		if (!should_continue) return;	
		move_t moves[256];
		u_int8_t count = generate_legal_moves(board, moves);
		if (count == 0) return;
		u_int8_t index = random() % count;
		apply_move(board, moves[index]);
		return randomize_board(board);
}



//openness: How much do pawns block movement across the board?
double board_openness(full_board_t *board) {
	bitboard_t core_center_mask = 
			SQUARE_TO_BB(E4) | SQUARE_TO_BB(E5) 
			| SQUARE_TO_BB(D4) | SQUARE_TO_BB(D5);
	bitboard_t outer_center_mask = 
			SQUARE_TO_BB(C6) | SQUARE_TO_BB(D6) | SQUARE_TO_BB(E6) | SQUARE_TO_BB(F6)
			| SQUARE_TO_BB(C5) | SQUARE_TO_BB(F5)
			| SQUARE_TO_BB(C4) | SQUARE_TO_BB(F4)
			| SQUARE_TO_BB(C3) | SQUARE_TO_BB(D3) | SQUARE_TO_BB(E3) | SQUARE_TO_BB(F3);
	position_t *pos = board->position;
	bitboard_t core_center_pawns = pos->pawns & core_center_mask;
	bitboard_t outer_center_pawns = pos->pawns & outer_center_mask;
	bitboard_t distant_pawns = pos->pawns & ~(core_center_mask | outer_center_mask);
	//TODO
	return 0;
}

bitboard_t ext_piece_attacks(piece_index_t index, square_t square) {
	piece_t piece = index_to_piece(index);
	bitboard_t origin = SQUARE_TO_BB(square);
	return piece_attack_mask(piece, origin, FULL_BB, FULL_BB);
}
