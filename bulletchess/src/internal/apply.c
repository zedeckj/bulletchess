#include "apply.h"

static void update_castling_from(bitboard_t bb, full_board_t *board) {
	switch (bb) {
		case A1_BB:
			board->castling_rights &= ~WHITE_QUEENSIDE;
			break;
		case A8_BB: 
			board->castling_rights &= ~BLACK_QUEENSIDE;
			break;
		case H1_BB:
			board->castling_rights &= ~WHITE_KINGSIDE;
			break;
		case H8_BB:
			board->castling_rights &= ~BLACK_KINGSIDE;
			break; 
	}
}


piece_t apply_pawn_promotion(full_board_t * board, bitboard_t origin, 
                    bitboard_t destination, piece_type_t promote_to) {
}

piece_t apply_pawn_other(full_board_t * board, square_t square_origin, bitboard_t origin, bitboard_t destination){
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

void apply_king_move(full_board_t * board, bitboard_t origin, 
																bitboard_t destination, 
																undoable_move_t *out_move){
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
    else {
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
    bitboard_t at_home;
    if ((at_home = (origin & king_home)) && 
				(kingside_dest & destination)) {
        bitboard_t not_origin = ~origin;
        bitboard_t not_kingside = ~kingside_rook;
        position->kings &= not_origin;
        position->rooks &= not_kingside;
        position->kings |= destination;
        position->rooks |= kingside_rook_dest;
        *friendly_oc &= (not_origin & not_kingside);
        *friendly_oc |= (destination | kingside_rook_dest);
        board->halfmove_clock += 1;
   			out_move->was_castling = ANY_KINGSIDE; 
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
				out_move->was_castling = ANY_QUEENSIDE;
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
							update_castling_from(destination, board);
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
    out_move->captured_piece = captured;
		return;
}

int other_apply_move(full_board_t * board, bitboard_t origin, bitboard_t destination, undoable_move_t *out_move) {
    position_t * position = board->position;
		bitboard_t * hostile_oc;
    bitboard_t * friendly_oc;
		if (origin & position->white_oc) {
        hostile_oc = &position->black_oc;
        friendly_oc = &position->white_oc; 
        board->turn = BLACK_VAL;
				out_move->captured_piece.color = BLACK_VAL; 
    }
		else if (origin & position->black_oc) {
				hostile_oc = &position->white_oc;
        friendly_oc = &position->black_oc; 
        board->fullmove_number += 1;
        board->turn = WHITE_VAL;
				out_move->captured_piece.color = WHITE_VAL;
    }
		else {
			return EMPTY_ORIGIN;
		}
		if (*hostile_oc & destination) {
			board->halfmove_clock = 0;		
			#define CAPTURE(PIECES, PIECE_VAL)\
			if (position->PIECES & destination){\
					out_move->captured_piece.type = PIECE_VAL;\
					position->PIECES &= ~destination;\
					update_castling_from(destination, board);\
			}
			CAPTURE(pawns, PAWN_VAL)
			else CAPTURE(knights, KNIGHT_VAL)
			else CAPTURE(bishops, BISHOP_VAL)
			else CAPTURE(rooks, ROOK_VAL)
			else CAPTURE(queens, QUEEN_VAL)
			*hostile_oc &= ~destination;
		}
		else {
				board->halfmove_clock += 1;
				update_castling_from(destination, board);
    }
		#define EXEC_MOVE(PIECES, PIECE_VAL)\
			position->PIECES |= destination;\
			position->PIECES &= ~origin;\
			*friendly_oc |= destination;\
			*friendly_oc &= ~origin;\
			out_move->moved_piece = PIECE_VAL;\

		#define MOVE_PIECE_LCL(PIECES, PIECE_VAL) if (origin & position->PIECES) {\
			EXEC_MOVE(PIECES, PIECE_VAL)\
		}

   	MOVE_PIECE_LCL(bishops, BISHOP_VAL)
		else MOVE_PIECE_LCL(knights, KNIGHT_VAL)
		else MOVE_PIECE_LCL(queens, QUEEN_VAL)
		else if (origin & position->rooks) {
			EXEC_MOVE(rooks, ROOK_VAL);
			update_castling_from(origin, board);	
		}
		board->en_passant_square.exists = false;
		board->en_passant_square.square = EMPTY_EP;
		return VALID_APPLY;
}

static int handle_null_move(full_board_t * board) {
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
		return VALID_APPLY;
}

static int handle_promotion_move(full_board_t *board, 
		promotion_move_t promotion, undoable_move_t *out_move) {
	 	bitboard_t origin = SQUARE_TO_BB(promotion.body.origin);
   	bitboard_t destination = SQUARE_TO_BB(promotion.body.destination);
   	position_t *position = board->position;
    bitboard_t *hostile_oc;
    bitboard_t *friendly_oc;
    piece_t captured;
    captured.type = EMPTY_VAL;
    if (origin & position->white_oc) {
        hostile_oc = &position->black_oc;
        friendly_oc = &position->white_oc; 
        board->turn = BLACK_VAL;
        captured.color = BLACK_VAL;
    }
    else if (origin & position->black_oc) {
				hostile_oc = &position->white_oc;
        friendly_oc = &position->black_oc; 
        board->fullmove_number += 1;
        board->turn = WHITE_VAL;
        captured.color = WHITE_VAL;
    }
		else {
			return EMPTY_ORIGIN;
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
        	update_castling_from(destination, board);
				}
        else if (position->knights & destination){
          captured.type = KNIGHT_VAL;
          position->knights &= keep;
        }
        else if (position->queens & destination) {
          captured.type = QUEEN_VAL;
          position->queens &= keep;
        }
    }
    position->pawns &= ~origin;
    switch (promotion.promote_to) {
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
    out_move->captured_piece = captured;	
	 	out_move->moved_piece = PAWN_VAL;
		return VALID_APPLY;
}

static int handle_generic_move(full_board_t *board,
		generic_move_t generic, undoable_move_t *out_move) {

   		bitboard_t origin = SQUARE_TO_BB(generic.origin);
    	bitboard_t destination = SQUARE_TO_BB(generic.destination);
    	position_t *position = board->position;
			if (origin & position->pawns) {
        out_move->captured_piece = 
					apply_pawn_other(board, generic.origin, origin, destination);
	 			out_move->moved_piece = PAWN_VAL;
				return VALID_APPLY;
			}
			else if (origin & position->kings) {
	 			out_move->moved_piece = KING_VAL;
        apply_king_move(board, origin, destination, out_move);
    		return VALID_APPLY;
			}
			else {
				return other_apply_move(board, origin, destination, out_move);
			}	
}

int apply_move_ext(full_board_t * board, move_t move, undoable_move_t *out_move){
		out_move->old_halfmove = board->halfmove_clock;
		out_move->old_castling_rights = board->castling_rights;
		out_move->old_en_passant = board->en_passant_square;
		out_move->move = move;
		out_move->was_castling = 0;
		out_move->captured_piece.type = EMPTY_VAL;
    switch (move.type) {
			case NULL_MOVE:
				return handle_null_move(board);
			case PROMOTION_MOVE:
				return handle_promotion_move(board, move.promotion, out_move);
			default: 
				return handle_generic_move(board, move.generic, out_move);
	}
}


undoable_move_t apply_move(full_board_t *board, move_t move) {
	undoable_move_t undo;
	apply_move_ext(board, move, &undo);
	return undo;
}

undoable_move_t apply_move_checked(full_board_t *board, 
		move_t move, int *status) {
	undoable_move_t undo;
	*status = apply_move_ext(board, move, &undo);
	return undo;
}




void void_apply(full_board_t *board, move_t move) {
	apply_move(board, move);
}

/*
undoable_move_t apply_move_ext(full_board_t * board, piece_index_t* index_array, move_t move) {
		undoable_move_t out = apply_move(board, move);
		fill_piece_index_array(board, index_array);
		return out;
}

undoable_move_t apply_pointer_move(full_board_t *board, move_t *move, u_int64_t index) {
	return apply_move(board, move[index]);
}
*/

#define MOVE_PIECE(TYPE, ORIGIN, DEST)\
(position->TYPE ## s) &= (~(ORIGIN)); (position->TYPE ## s) |= (DEST);

void undo_if_capture(position_t *position, bitboard_t destination, 
	piece_type_t captured, bitboard_t *hostile_oc) {
	switch (captured) {
		case PAWN_VAL:
				position->pawns |= destination;
				break;
			case BISHOP_VAL:
				position->bishops |= destination;
				break;
			case KNIGHT_VAL:
				position->knights |= destination;
				break;
			case ROOK_VAL:
				position->rooks |= destination;
				break;
			case QUEEN_VAL:
				position->queens |= destination;
				break;
			case KING_VAL:
				// still possible, even if illegal		
				position->kings |= destination; 
				break;
			default:
				return;			
		}
		*hostile_oc |= destination;
}

void undo_promotion(full_board_t *board, undoable_move_t move){
	promotion_move_t promotion = move.move.promotion;
	bitboard_t origin = SQUARE_TO_BB(promotion.body.origin);
	bitboard_t destination = SQUARE_TO_BB(promotion.body.destination);
	piece_type_t promote_to = promotion.promote_to;
	position_t *position = board->position;
  switch (promote_to) {
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
	bitboard_t *friendly_oc;
	bitboard_t *hostile_oc;
	if (board->turn == BLACK_VAL) {
		friendly_oc = &(position->white_oc);
		hostile_oc = &(position->black_oc);
	}
	else {
		hostile_oc = &(position->white_oc);
		friendly_oc = &(position->black_oc);
	}
	*friendly_oc &= ~destination;
	*friendly_oc |= origin;
	position->pawns |= origin;
	undo_if_capture(position, destination, move.captured_piece.type, hostile_oc);
}

void undo_generic(full_board_t *board, undoable_move_t move){
		bitboard_t origin = SQUARE_TO_BB(move.move.generic.origin);
		bitboard_t destination = SQUARE_TO_BB(move.move.generic.destination);
		position_t *position = board->position;
		bitboard_t *friendly_oc;
		bitboard_t *hostile_oc;
		if (board->turn == BLACK_VAL) {
			friendly_oc = &(position->white_oc);
			hostile_oc = &(position->black_oc);
		}
		else {
			friendly_oc = &(position->black_oc);
			hostile_oc = &(position->white_oc);
		}
		//piece_type_t ref = get_piece_at(board->position, move.move.generic.destination).type;
		//printf("ref %d vs moved %d\n", ref, move.moved_piece);
		switch (move.moved_piece) {	
			case KNIGHT_VAL:
				MOVE_PIECE(knight, destination, origin);
				break;
			case PAWN_VAL:
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
				MOVE_PIECE(pawn, destination, origin);
				break;	
			case BISHOP_VAL:
				MOVE_PIECE(bishop, destination, origin);
				break;
			case ROOK_VAL:
				MOVE_PIECE(rook, destination, origin);
				break;
			case QUEEN_VAL:
				MOVE_PIECE(queen, destination, origin);
				break;
			case KING_VAL:
				MOVE_PIECE(king, destination, origin);
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
			break;
		}
		*friendly_oc &= ~destination;
		*friendly_oc |= origin;
		undo_if_capture(position, destination, move.captured_piece.type, hostile_oc);
}



void undo_state(full_board_t *board, undoable_move_t move) {
	board->castling_rights = move.old_castling_rights;
	board->en_passant_square = move.old_en_passant;
	board->halfmove_clock = move.old_halfmove;
	if (board->turn == WHITE_VAL) {
		board->fullmove_number -= 1;
		board->turn = BLACK_VAL;	
	}
	else {
		board->turn = WHITE_VAL;
	}
}

void undo_move(full_board_t *board, undoable_move_t move) {
		switch (move.move.type) {
			case PROMOTION_MOVE:
				undo_promotion(board, move);
				break;
			case GENERIC_MOVE:
				undo_generic(board, move);
				break;
			case NULL_MOVE:
				break;
		}
		undo_state(board, move);
}


