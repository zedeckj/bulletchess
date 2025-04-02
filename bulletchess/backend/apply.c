#include "apply.h"


piece_t apply_pawn_promotion(full_board_t * board, bitboard_t origin, 
                    bitboard_t destination, piece_type_t promote_to) {
    position_t * position = board->position;
    bitboard_t * hostile_oc;
    bitboard_t * friendly_oc;
    castling_rights_t remove_if_kingside;
    castling_rights_t remove_if_queenside;
    piece_t captured;
    captured.type = EMPTY_VAL;
    if (origin & position->white_oc) {
        hostile_oc = &position->black_oc;
        friendly_oc = &position->white_oc; 
        board->turn = BLACK_VAL;
        remove_if_kingside = ~BLACK_KINGSIDE;
        remove_if_queenside = ~BLACK_QUEENSIDE;
        captured.color = BLACK_VAL;
    }
    else if (origin & position->black_oc) {
        hostile_oc = &position->white_oc;
        friendly_oc = &position->black_oc; 
        board->fullmove_number += 1;
        board->turn = WHITE_VAL;
        remove_if_kingside = ~WHITE_KINGSIDE;
        remove_if_queenside = ~WHITE_QUEENSIDE;
        captured.color = WHITE_VAL;
    }
    else {
        return captured;
    }
    if (*hostile_oc & destination) {
        bitboard_t keep = ~destination;
        *hostile_oc &= keep;
        // can't capture king, no pawns on back rank
        if (position->bishops & destination) {
          captured.type = BISHOP_VAL;
          position->bishops &= keep;
        }
        else if (position->rooks & destination){
          captured.type = ROOK_VAL;
          position->rooks &= keep;
        }
        else if (position->knights & destination){
          captured.type = KNIGHT_VAL;
          position->knights &= keep;
        }
        else if (position->queens & destination) {
          captured.type = QUEEN_VAL;
          position->queens &= keep;
        }
        if (destination & FILE_A) board->castling_rights &= remove_if_queenside;
        else if (destination & FILE_H) board->castling_rights &= remove_if_kingside;
    }
    position->pawns &= ~origin;
    switch (promote_to) {
        case QUEEN_VAL:
        position->queens |= destination;
        break;
        case BISHOP_VAL:
        position->bishops |= destination;
        break;
        case ROOK_VAL:
        position->rooks |= destination;
        break;
        case KNIGHT_VAL:
        position->knights |= destination;
        break;
    }
    *friendly_oc |= destination;
    *friendly_oc &= ~origin;

    board->en_passant_square.exists = false;
    board->en_passant_square.square = EMPTY_EP;
		board->halfmove_clock = 0;
    return captured;
}

piece_t apply_pawn_other(full_board_t * board, square_t square_origin, bitboard_t origin, 
    bitboard_t destination){
    position_t * position = board->position;
    bitboard_t * hostile_oc;
    bitboard_t * friendly_oc;
    bitboard_t home_rank;
    bitboard_t new_ep_rank;
    square_t new_ep_square;
		piece_t captured;
		captured.type = EMPTY_VAL;
    if (origin & position->white_oc) {
        hostile_oc = &position->black_oc;
        friendly_oc = &position->white_oc; 
        home_rank = RANK_2;
        new_ep_rank = RANK_3;
        new_ep_square = square_origin + 8;
        board->turn = BLACK_VAL;
				captured.color = BLACK_VAL;
    }
    else if (origin & position->black_oc) {
        hostile_oc = &position->white_oc;
        friendly_oc = &position->black_oc; 
        board->fullmove_number += 1;
        home_rank = RANK_7;
        new_ep_rank = RANK_6;
        new_ep_square = square_origin - 8;
        board->turn = WHITE_VAL;
				captured.color = WHITE_VAL;
    }
    
    else {
        return captured;
    }  
    // printf("here\n");
    // print_bitboard(origin);
    // print_bitboard(home_rank);
    // print_bitboard(destination);
    // print_bitboard(~new_ep_rank);
    if ((origin & home_rank) && (destination & ~new_ep_rank)) {
        // first two square advance
        board->en_passant_square.square = new_ep_square;
        board->en_passant_square.exists = true;
    }
    else {
        if (*hostile_oc & destination) {
            bitboard_t keep = ~destination;
						if (position->pawns & destination) {
							captured.type = PAWN_VAL;
							// dont need to delete old pawn
						}
						else if (position->bishops & destination) {
								captured.type = BISHOP_VAL;
								position->bishops &= keep;
						}
						else if (position->rooks & destination){
								captured.type = ROOK_VAL;
								position->rooks &= keep;
						}
						else if (position->knights & destination){
								captured.type = KNIGHT_VAL;
								position->knights &= keep;
						}
						else if (position->queens & destination) {
								captured.type = QUEEN_VAL;
								position->queens &= keep;
						}
            *hostile_oc &= keep;
            // can't capture king
            position->bishops &= keep;
            position->rooks &= keep;
            position->knights &= keep;
            position->queens &= keep;
        }
        else if (board->en_passant_square.exists) {
            bitboard_t ep_bb = SQUARE_TO_BB(board->en_passant_square.square);
            if (ep_bb & destination) {
                if (ep_bb & RANK_3) {
                    bitboard_t keep = ~ABOVE_BB(destination);
                    *hostile_oc &= keep;
                    position->pawns &= keep;
                }
                else {
                    bitboard_t keep = ~BELOW_BB(destination);
                    *hostile_oc &= keep;
                    position->pawns &= keep;
                }
            }
        }
        board->en_passant_square.exists = false;
        board->en_passant_square.square = EMPTY_EP;
    }
    position->pawns &= ~origin;
    position->pawns |= destination;
    *friendly_oc |= destination;
    *friendly_oc &= ~origin;
    
    board->halfmove_clock = 0;
		return captured;
}



undoable_move_t apply_king_move(full_board_t * board, bitboard_t origin, bitboard_t destination, undoable_move_t out_move){
    position_t * position = board->position;
    bitboard_t * hostile_oc;
    bitboard_t * friendly_oc;
    bitboard_t kingside_rook;
    bitboard_t queenside_rook;
    bitboard_t kingside_dest;
    bitboard_t queenside_dest;
    bitboard_t kingside_rook_dest;
    bitboard_t queenside_rook_dest;
    bitboard_t king_home;
    piece_t captured;
    captured.color = EMPTY_VAL;
    captured.type = EMPTY_VAL;
    if (origin & position->white_oc) {
        hostile_oc = &position->black_oc;
        friendly_oc = &position->white_oc; 
        kingside_rook = H1_BB;
        queenside_rook = A1_BB;
        king_home = E1_BB; 
        kingside_rook_dest = F1_BB;
        queenside_rook_dest = D1_BB;
        kingside_dest = G1_BB;
        queenside_dest = C1_BB;
        board->turn = BLACK_VAL;
        board->castling_rights &= ~WHITE_FULL_CASTLING;
        captured.color = BLACK_VAL;
    }
    else if (origin & position->black_oc) {
        hostile_oc = &position->white_oc;
        friendly_oc = &position->black_oc; 
        board->fullmove_number += 1;
        kingside_rook = H8_BB;
        queenside_rook = A8_BB;
        king_home = E8_BB;
        kingside_rook_dest = F8_BB;
        queenside_rook_dest = D8_BB;
        kingside_dest = G8_BB;
        queenside_dest = C8_BB;
        board->turn = WHITE_VAL;
        board->castling_rights &= ~BLACK_FULL_CASTLING;
        captured.color = WHITE_VAL;
    }
    else {
				out_move.captured_piece = captured;
        return out_move;
    }  
    bitboard_t at_home;
    if ((at_home = (origin & king_home)) && (kingside_dest & destination)) {
        bitboard_t not_origin = ~origin;
        bitboard_t not_kingside = ~kingside_rook;
        position->kings &= not_origin;
        position->rooks &= not_kingside;
        position->kings |= destination;
        position->rooks |= kingside_rook_dest;
        *friendly_oc &= (not_origin & not_kingside);
        *friendly_oc |= (destination | kingside_rook_dest);
        board->halfmove_clock += 1;
   			out_move.was_castling = ANY_KINGSIDE; 
	 	} 
    else if (at_home &&  (queenside_dest & destination)) {
        bitboard_t not_origin = ~origin;
        bitboard_t not_queenside = ~queenside_rook;
        position->kings &= not_origin;
        position->rooks &= not_queenside;
        position->kings |= destination;
        position->rooks |= queenside_rook_dest;
        *friendly_oc &= (not_origin & not_queenside);
        *friendly_oc |= (destination | queenside_rook_dest);
        board->halfmove_clock += 1;
				out_move.was_castling = ANY_QUEENSIDE;
    }
    else {
        if (*hostile_oc & destination) {
            bitboard_t keep = ~destination;
            if (position->pawns & destination) {
              captured.type = PAWN_VAL;
              position->pawns &= keep;
            }
            else if (position->bishops & destination) {
              captured.type = BISHOP_VAL;
              position->bishops &= keep;
            }
            else if (position->rooks & destination) {
              captured.type = ROOK_VAL;
              position->rooks &= keep;
							if (destination & A1_BB) board->castling_rights &= ~WHITE_QUEENSIDE;
							else if (destination & A8_BB) board->castling_rights &= ~BLACK_QUEENSIDE;
							else if (destination & H1_BB) board->castling_rights &= ~WHITE_KINGSIDE;
							else if (destination & H8_BB) board->castling_rights &= ~BLACK_KINGSIDE;
						}
            else if (position->knights & destination) {
              captured.type = KNIGHT_VAL;
              position->knights &= keep;
            }
					  else if (position->queens & destination) {
							captured.type = QUEEN_VAL;
							position->queens &= keep;
						}
            *hostile_oc &= keep;
            board->halfmove_clock = 0;
        }
        else board->halfmove_clock += 1;
        *friendly_oc |= destination;
        *friendly_oc &= ~origin;
        position->kings |= destination;
        position->kings &= ~origin;
    }
    board->en_passant_square.exists = false;
    board->en_passant_square.square = EMPTY_EP;
    out_move.captured_piece = captured;
		return out_move;
}

piece_t other_apply_move(full_board_t * board, bitboard_t origin, bitboard_t destination) {
    position_t * position = board->position;
		bitboard_t * hostile_oc;
    bitboard_t * friendly_oc;
    bitboard_t remove_if_kingside;
    bitboard_t remove_if_queenside;
    bitboard_t kingside_square;
    bitboard_t queenside_square;
    piece_t captured;
		captured.type = EMPTY_VAL;
		if (origin & position->white_oc) {
        hostile_oc = &position->black_oc;
        friendly_oc = &position->white_oc; 
        board->turn = BLACK_VAL;
        remove_if_kingside = ~BLACK_KINGSIDE;
        remove_if_queenside = ~BLACK_QUEENSIDE;
        kingside_square = H8_BB;
        queenside_square = A8_BB;
				captured.color = BLACK_VAL; 
    }
    else if (origin & position->black_oc) {
        hostile_oc = &position->white_oc;
        friendly_oc = &position->black_oc; 
        board->fullmove_number += 1;
        board->turn = WHITE_VAL;
        remove_if_kingside = ~WHITE_KINGSIDE;
        remove_if_queenside = ~WHITE_QUEENSIDE;
        kingside_square = H1_BB;
        queenside_square = A1_BB;
				captured.color = WHITE_VAL;
    }
    else {
        return captured;
    }  
    bitboard_t is_capture;
    if ((is_capture = (*hostile_oc & destination))) {
		 	bitboard_t keep = ~destination;
			board->halfmove_clock = 0;	
			if (position->pawns & destination) {
				captured.type = PAWN_VAL;
				position->pawns &= keep;
			}
			else if (position->bishops & destination) {
				captured.type = BISHOP_VAL;
				position->bishops &= keep;
			}
			else if (position->rooks & destination){
				captured.type = ROOK_VAL;
				position->rooks &= keep;
				if (destination & A1_BB) board->castling_rights &= ~WHITE_QUEENSIDE;
				else if (destination & A8_BB) board->castling_rights &= ~BLACK_QUEENSIDE;
				else if (destination & H1_BB) board->castling_rights &= ~WHITE_KINGSIDE;
				else if (destination & H8_BB) board->castling_rights &= ~BLACK_KINGSIDE;
			}
			else if (position->knights & destination){
				captured.type = KNIGHT_VAL;
				position->knights &= keep;
			}
			else if (position->queens & destination) {
				captured.type = QUEEN_VAL;
				position->queens &= keep;
			}
			*hostile_oc &= keep;
		}
		else {
				board->halfmove_clock += 1;
				if (destination & kingside_square) board->castling_rights &= remove_if_kingside;
        else if (destination & queenside_square) board->castling_rights &= remove_if_queenside;
    }
    if (origin & position->bishops) {
        position->bishops |= destination;
        position->bishops &= ~origin;
        *friendly_oc |= destination;
        *friendly_oc &= ~origin;

    }
    else if (origin & position->knights) {
        position->knights |= destination;
        position->knights &= ~origin;
        *friendly_oc |= destination;
        *friendly_oc &= ~origin;
    }
    else if (origin & position->rooks) {
				if (origin & A1_BB) board->castling_rights &= ~WHITE_QUEENSIDE;
       	else if (origin & A8_BB) board->castling_rights &= ~BLACK_QUEENSIDE;
      	else if (origin & H1_BB) board->castling_rights &= ~WHITE_KINGSIDE;
        else if (origin & H8_BB) board->castling_rights &= ~BLACK_KINGSIDE;
        position->rooks |= destination;
        position->rooks &= ~origin;
        *friendly_oc |= destination;
        *friendly_oc &= ~origin;
    }
    else if (origin & position->queens) {
        position->queens |= destination;
        position->queens &= ~origin;
        *friendly_oc |= destination;
        *friendly_oc &= ~origin;
    }
    board->en_passant_square.exists = false;
    board->en_passant_square.square = EMPTY_EP;
		return captured;
}



// function responsible for making the changes to the position and state 
// of a move
undoable_move_t apply_move(full_board_t * board, move_t move) {
    undoable_move_t out_move;
		out_move.old_halfmove = board->halfmove_clock;
		out_move.old_castling_rights = board->castling_rights;
		out_move.old_en_passant = board->en_passant_square;
		out_move.move = move;
		out_move.was_castling = 0;
		if (move.type == NULL_MOVE) {
			if (board->turn == WHITE_VAL){
				board->turn = BLACK_VAL;
			}
			else {
				board->turn = WHITE_VAL;
				board->fullmove_number += 1;
			}
			board->halfmove_clock += 1;
			board->en_passant_square.exists = false;
			board->en_passant_square.square = EMPTY_EP;
			return out_move;
		}
		else if (move.type == PROMOTION_MOVE) {
        bitboard_t origin = SQUARE_TO_BB(move.promotion.body.origin);
        bitboard_t destination = SQUARE_TO_BB(move.promotion.body.destination);
        out_move.captured_piece = apply_pawn_promotion(board, origin, destination, move.promotion.promote_to);
    }
		else {
    	bitboard_t origin = SQUARE_TO_BB(move.generic.origin);
    	bitboard_t destination = SQUARE_TO_BB(move.generic.destination);
    	position_t *position = board->position;
    	if (origin & position->pawns) {
        out_move.captured_piece = apply_pawn_other(board, move.generic.origin, origin, destination);
    	}
    	else if (origin & position->kings) {
        return apply_king_move(board, origin, destination, out_move);
    	}
			else {
				out_move.captured_piece = other_apply_move(board, origin, destination);
			}
		}
		return out_move;
}

undoable_move_t apply_move_ext(full_board_t * board, piece_index_t* index_array, move_t move) {
		undoable_move_t out = apply_move(board, move);
		fill_piece_index_array(board, index_array);
		return out;
}

undoable_move_t apply_pointer_move(full_board_t *board, move_t *move, u_int64_t index) {
	return apply_move(board, move[index]);
}


void undo_move(full_board_t *board, undoable_move_t move) {
	position_t * position = board->position;
	bitboard_t *hostile_oc;
	bitboard_t *friendly_oc;
	if (board->turn == WHITE_VAL){
		board->turn = BLACK_VAL;
		friendly_oc = &(position->black_oc);
		hostile_oc = &(position->white_oc);
		board->fullmove_number -= 1;
	}
	else {
		board->turn = WHITE_VAL;
		friendly_oc = &(position->white_oc);
		hostile_oc = &(position->black_oc);
	}
	bitboard_t origin;
	bitboard_t destination;
	if (move.move.type == PROMOTION_MOVE) {
		promotion_move_t promotion = move.move.promotion;
		origin = SQUARE_TO_BB(promotion.body.origin);
		destination = SQUARE_TO_BB(promotion.body.destination);
		switch (promotion.promote_to) {
			case QUEEN_VAL:
			position->queens &= ~destination;
			break;
			case KNIGHT_VAL:
			position->knights &= ~destination;
			break;
			case ROOK_VAL:
			position->rooks &= ~destination;
			break;
			case BISHOP_VAL:
			position->bishops &= ~destination;
			break;
		}
		*friendly_oc &= ~destination;
		*friendly_oc |= origin;
		 position->pawns |= origin;
	}
	else if (move.move.type == GENERIC_MOVE) {
		origin = SQUARE_TO_BB(move.move.generic.origin);
		destination = SQUARE_TO_BB(move.move.generic.destination);
		if (position->knights & destination) {
			position->knights &= ~destination;
			position->knights |= origin;
		}
		else if (position->pawns & destination) {
			if (move.old_en_passant.exists) {
				bitboard_t ep_bb = SQUARE_TO_BB(move.old_en_passant.square);
				if (ep_bb & destination) {
					bitboard_t ep_pawn;
					if (ep_bb & RANK_3) ep_pawn = SAFE_ABOVE_BB(ep_bb);
					else ep_pawn = SAFE_BELOW_BB(ep_bb);	
					position->pawns |= ep_pawn;
					*hostile_oc |= ep_pawn;
				}
			}
			position->pawns &= ~destination;
			position->pawns |= origin;
		}
		else if (position->bishops & destination) {
			position->bishops &= ~destination;
			position->bishops |= origin;
		}
		else if (position->rooks & destination) {
			position->rooks &= ~destination;
			position->rooks |= origin;
		}
		else if (position->queens & destination) {
			position->queens &= ~destination;
			position->queens |= origin;
		}
		else if (position->kings & destination) {
			position->kings &= ~destination;
			position->kings |= origin;
			if (move.was_castling & ANY_KINGSIDE) {
				position->rooks &= ~SAFE_LEFT_BB(destination);
				*friendly_oc &= ~SAFE_LEFT_BB(destination);
				position->rooks |= SAFE_RIGHT_BB(destination);
				*friendly_oc |= SAFE_RIGHT_BB(destination);
			}
			if (move.was_castling & ANY_QUEENSIDE) {
				position->rooks &= ~SAFE_RIGHT_BB(destination);
				*friendly_oc &= ~SAFE_RIGHT_BB(destination);
				position->rooks |= SAFE_TWO_LEFT_BB(destination);
				*friendly_oc |= SAFE_TWO_LEFT_BB(destination);
			}
		}
		*friendly_oc &= ~destination;
		*friendly_oc |= origin;
	}
	piece_t captured = move.captured_piece;
	if (captured.type != EMPTY_VAL) {
		switch (captured.type) {
			case PAWN_VAL:
			position->pawns |= destination;
			break;
			case KNIGHT_VAL:
			position->knights |= destination;
			break;
			case BISHOP_VAL:
			position->bishops |= destination;
			break;
			case ROOK_VAL:
			position->rooks |= destination;
			break;
			case QUEEN_VAL:
			position->queens |= destination;
			break;
		}
		*hostile_oc |= destination;
	}
	board->castling_rights = move.old_castling_rights;
	board->en_passant_square = move.old_en_passant;
	board->halfmove_clock = move.old_halfmove;
}



