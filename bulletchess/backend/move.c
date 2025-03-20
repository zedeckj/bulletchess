#include "move.h"

move_t error_move() {
    move_t move;
    move.type = ERROR_MOVE;
    return move;
}

move_t null_move() {
    move_t move;
    move.type = NULL_MOVE;
    return move;
}

generic_move_t move_body(square_t origin, square_t destination){
    generic_move_t generic;
    generic.origin = origin;
    generic.destination = destination;
    return generic;
}

move_t generic_move(generic_move_t body) {
    move_t move;
    move.type = GENERIC_MOVE;
    move.generic = body;
    return move;
}


move_t promotion_move(generic_move_t body, piece_type_t promote_to) {
    move_t move;
    move.type = PROMOTION_MOVE;
    move.promotion.body = body;
    move.promotion.promote_to = promote_to;
    return move;
}


u_int64_t hash_move(move_t move) {
  u_int64_t origin;
  u_int64_t destination;
  u_int64_t promotion = 0;
  if (move.type == PROMOTION_MOVE) {
    promotion_move_t prm = move.promotion;
    origin = prm.body.origin;
    destination = prm.body.destination;
    promotion = prm.promote_to;
  }
  else {
    origin = move.generic.origin;
    destination = move.generic.destination;
  }
  return (origin << 16) + (destination << 8) + promotion;
}

bool moves_equal(move_t move1, move_t move2) {
  if (move1.type == PROMOTION_MOVE){
    return move2.type == PROMOTION_MOVE && move1.promotion.body.origin == move2.promotion.body.origin
            && move1.promotion.body.destination == move2.promotion.body.destination;
  }
  else if (move1.type == GENERIC_MOVE) {
    return move2.type == GENERIC_MOVE && move1.generic.origin == move2.generic.origin &&
           move1.generic.destination == move2.generic.destination;
  }
  else return false;
}


bool is_error_move(move_t move) {
    return move.type == ERROR_MOVE;
}

bool is_null_move(move_t move) {
    return move.type == NULL_MOVE;
}

void print_bitboard(bitboard_t board) {
    int i =0;
    for (bitboard_t rank = RANK_8; i < 8; i++) {
        int j = 0;
        for (bitboard_t file = FILE_A; j < 8; j++) {
            file = SAFE_RIGHT_BB(file);
        }
        printf("\n");
        rank = BELOW_BB(rank);
    }
    printf("\n");
}

void debug_print_board(full_board_t * board) {
    printf("white occupied\n");
    print_bitboard(board->position->white_oc);
    printf("black occupied\n");
    print_bitboard(board->position->black_oc);
    printf("pawns\n");
    print_bitboard(board->position->pawns);
    printf("bishops\n");
    print_bitboard(board->position->bishops);
    printf("knights\n");
    print_bitboard(board->position->knights);
    printf("rooks\n");
    print_bitboard(board->position->rooks);
    printf("queens\n");
    print_bitboard(board->position->queens);
    printf("kings\n");
    print_bitboard(board->position->kings);
}



void write_uci_body(generic_move_t move, char * buffer) {
    buffer[0] = file_char_of_square(move.origin);
    buffer[1] = rank_char_of_square(move.origin);
    buffer[2] = file_char_of_square(move.destination);
    buffer[3] = rank_char_of_square(move.destination);
}

bool write_uci(move_t move, char * buffer) {
    switch(move.type) {

        case GENERIC_MOVE: 
        write_uci_body(move.generic, buffer);
        buffer[4] = '\0';
        return true;
        /*
        case CASTLING_MOVE: 
            switch (move.castling) {
                case WHITE_KINGSIDE:
                strcpy(buffer, "e1g1");
                return true;
                case WHITE_QUEENSIDE:
                strcpy(buffer, "e1c1");
                return true;
                case BLACK_KINGSIDE:
                strcpy(buffer, "e8g8");
                return true;
                case BLACK_QUEENSIDE:
                strcpy(buffer, "e8c8");
                return true;
            }
            return false;
        */
    case PROMOTION_MOVE: 
        write_uci_body(move.promotion.body, buffer);
        buffer[4] = piece_type_symbol(move.promotion.promote_to);
        buffer[5] = '\0';
        return true;

    case ERROR_MOVE:
        return false;

    case NULL_MOVE: 
        strcpy(buffer, "0000");
        return true;
    }
    return false;
}


bool validate_promotion_move(char origin_file, char origin_rank, char dest_file, char dest_rank) {
    return ((origin_rank == '7' && dest_rank == '8') 
          || (origin_rank == '2' && dest_rank == '1')) 
          && (dest_file == origin_file 
              || dest_file == origin_file + 1 
              || dest_file == origin_file - 1); 
} 


bool validate_generic_move(char origin_file, char origin_rank, char dest_file, char dest_rank) {
    if (dest_file == origin_file) return origin_rank != dest_rank;
    if (dest_rank == origin_rank) return origin_file != dest_file;
    int8_t dist;
    if ((dist = abs(dest_file - origin_file)) == abs(dest_rank - origin_rank)) return dist != 0;
    int8_t file_diff = abs(dest_file - origin_file);
    int8_t rank_diff = abs(dest_rank - origin_rank);
    return ((file_diff == 1 && rank_diff == 2) || (file_diff == 2 && rank_diff == 1)); 
}



move_t parse_uci(char * str) {
    if (!str) return error_move();
    bool all_zero = true;
    for (int i = 0; i < 4; i++) {
        if (!str[i]) {
            return error_move();
        }
        else if (str[i] != '0') {
            all_zero = false;
            break;
        }
    }
    if (all_zero) {
			return str[5] ? error_move() : null_move();
    }
    if (valid_square_chars(str[0], str[1]) && 
        valid_square_chars(str[2], str[3])) {
            if (!str[4] || isspace(str[4])) {
              if (validate_generic_move(str[0], str[1], str[2], str[3])){
                move_t move = generic_move(
                        move_body(
                            make_square(str[0], str[1]), 
                            make_square(str[2], str[3])));
                return move;
              }
            }
            else if (!str[5] || isspace(str[5])){
                char c = tolower(str[4]);
                piece_type_t promote_to;
                switch (c) {
                    case 'q':
                    promote_to = QUEEN_VAL;
                    break;
                    case 'n':
                    promote_to = KNIGHT_VAL;
                    break;
                    case 'b':
                    promote_to = BISHOP_VAL;
                    break;
                    case 'r':
                    promote_to = ROOK_VAL;
                    break;
                    default:
                    return error_move();
                }
                if (validate_promotion_move(str[0], str[1], str[2], str[3])) {
                  return promotion_move(
                    move_body(
                        make_square(str[0], str[1]), 
                        make_square(str[2], str[3])),
                      promote_to);
               }
            }
    }
    return error_move();
}


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

move_t undo_move(full_board_t *board, undoable_move_t move) {
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
	return move.move; 
}

/*
// handles constructing the undoable move, and calls the inner function for actual application
void best_apply_move(full_board_t * board, move_t move) {
  undoable_move_t undoable;
  undoable.move = move;
  castling_rights_t old_rights = board->castling_rights;
  inner_apply_move(board, move);
  push_move(board->move_stack, undoable);
}
void apply_full_move(full_board_t *board, full_move_t move) {
    return;
}
*/


// void apply_generic_move(full_board_t *board, generic_move_t move) {
    
//     //piece_t piece = get_piece_at(board->position, move.origin);
//     bitboard_t origin_bb = SQUARE_TO_BB(move.origin);
//     bitboard_t destination_bb = SQUARE_TO_BB(move.destination);
//     bool castled = false;
//     if (is_king) {
//         if (move.origin == E1) {
//             if (move.destination == G1) {
//                 do_white_kingside(board);
//                 castled = true;
//             }
//             else if (move.destination == C1) {
//                 do_white_queenside(board);
//                 castled = true;
//             }
//         }
//         else if (move.origin == E8) {
//             if (move.destination == G8) {
//                 do_black_kingside(board);
//                 castled = true;
//             }
//             else if (move.destination == C8) {
//                 do_black_quenside(board);
//                 castled = true;
//             }
//         }
//         if (castled) {
//             clear_ep_square(board);
//             board->halfmove_clock += 1;
//             return;
//         }
//     }
//     do_state_change(board, move, piece);
//     move_piece(board, move, piece.type);
// }

// ************* MOVE GEN BELOW ***********************



void add_from_bitboard(square_t origin, bitboard_t destinations, move_t * moves, u_int8_t *move_index) {
    if (destinations) {
        for (square_t square = A1; square <= H8; square++) {
            bitboard_t bb = SQUARE_TO_BB(square);
            if (bb & destinations) {
                moves[(*move_index)++] = generic_move(move_body(origin, square));
            }
        }
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

void make_all_pinned_masks(full_board_t * board, bitboard_t attack_mask, piece_color_t for_color, bitboard_t * pinned_buffer) {
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
    bitboard_t slide_danger = hostile & (position->rooks | position->queens);
    bitboard_t diagonal_danger=  hostile & (position->bishops | position->queens);
    bitboard_t friendly_kings = friendly & position->kings;
    bitboard_t friendly_pawns = friendly & position->pawns;
    bitboard_t empty = ~(friendly | hostile);
    for (square_t square = A1; square <= H8; square++) { 
        bitboard_t pin_mask = FULL_BB;
        bitboard_t piece_bb = SQUARE_TO_BB(square);
        if (piece_bb & friendly) {   
           if (piece_bb & friendly_pawns) {
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
                            temp_pin &= pin_mask_from( horizontal, slide_danger, friendly_kings);
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
            if (attack_mask & piece_bb) { 
                    if (slide_danger) {
                        bitboard_t vertical = vertical_attack_mask(piece_bb, FULL_BB, empty);
                        pin_mask &= pin_mask_from( vertical, slide_danger, friendly_kings);
                        bitboard_t horizontal = horizontal_attack_mask(piece_bb, FULL_BB, empty);
                        pin_mask &= pin_mask_from( horizontal, slide_danger, friendly_kings);

                    }
                    if (diagonal_danger) {
                        bitboard_t ascending = ascending_attack_mask(piece_bb, FULL_BB, empty);
                        pin_mask &= pin_mask_from( ascending, diagonal_danger, friendly_kings);
                        bitboard_t descending = descending_attack_mask(piece_bb, FULL_BB, empty);
                        pin_mask &= pin_mask_from( descending, diagonal_danger, friendly_kings);
                    }
            }
        }
        pinned_buffer[square] = pin_mask;
    }
}   

bitboard_t make_pinned_mask(full_board_t * board, bitboard_t piece_bb, piece_color_t for_color) {
    /*
    A "pinned" piece is one which cannot move or its king would be placed in check. 
    This can be done by seeing if any sliding mask attacks both an enemy piece,
    with that same sliding attack, and its own king. 

    Pieces can only move within the generated pinned mask. A non pinned piece
    will return a mask of the full board.

    This concept does not apply to kings, so should not be called for a piece_bb with a king on it.

    There is an extremely specific case for capturing en passant and revaling a horizontal attack.
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
    bitboard_t slide_danger = hostile & (position->rooks | position->queens);
    bitboard_t diagonal_danger=  hostile & (position->bishops | position->queens);
    bitboard_t pin_mask = FULL_BB;
    bitboard_t friendly_kings = friendly & position->kings;
    bitboard_t friendly_pawns = friendly & position->pawns;
    bitboard_t empty = ~(friendly | hostile);
    if (piece_bb & friendly_pawns) {
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
                    temp_pin &= pin_mask_from( horizontal, slide_danger, friendly_kings);
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
        pin_mask &= pin_mask_from( vertical, slide_danger, friendly_kings);
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
    if (enemy_pawns) {
    
        if (attacker == WHITE_VAL) attacking |= white_pawn_attack_mask(enemy_pawns, can_move_to);
        else attacking |= black_pawn_attack_mask(enemy_pawns, can_move_to);
    }
    if (enemy_rooks) attacking |= sliding_attack_mask(enemy_rooks, can_move_to, empty);
    if (enemy_knights) attacking |= knight_attack_mask(enemy_knights, can_move_to);
    if (enemy_bishops) attacking |= diagonal_attack_mask(enemy_bishops, can_move_to, empty);
		if (enemy_queens) {
        attacking |= sliding_attack_mask(enemy_queens, can_move_to, empty);
        attacking |= diagonal_attack_mask(enemy_queens, can_move_to, empty);
    }
    attacking |= king_attack_mask(enemy_kings, can_move_to);
    //printf("ATTACKING MASK\n");
    //print_bitboard(attacking); // DEBUG
    return attacking;
}


typedef struct {
    // where non kings are allowed to move
    bitboard_t allowed_move_mask;
    // a necessary extra mask for where pawns are allowed to capture 
    // this is to account for en passant weirdness.
    bitboard_t extra_pawn_capture_mask;
    // Number of pieces currently attacking the king
		u_int8_t king_attacker_count;
} check_info_t;



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
    bitboard_t enemy_kings = hostile & position->kings;
    
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
    // as if it move like each piece type, and see if it could attack an enemy piece of that type
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
			 add_ep = true;	
        // if (info.king_attacker_count > 0) add_ep = true; // WHAT???
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


u_int8_t count_moves(
    full_board_t *board, 
    piece_color_t for_color, 
    bitboard_t attacked_mask,
    check_info_t info) {
    u_int8_t move_index = 0;

    position_t *position = board->position;
    bitboard_t friendly;
    bitboard_t hostile;

    bitboard_t pawn_one_square_advance;
    bitboard_t our_white_pawns = 0;
    bitboard_t our_black_pawns = 0;
    bool can_kingside;
    bool can_queenside;
    if (for_color == WHITE_VAL) {
        friendly = position->white_oc;
        hostile = position->black_oc;
        our_white_pawns = friendly & position->pawns;
        can_kingside = board->castling_rights & WHITE_KINGSIDE;
        can_queenside = board->castling_rights & WHITE_QUEENSIDE;
    }
    else {
        friendly = position->black_oc;
        hostile = position->white_oc;
        our_black_pawns = friendly & position->pawns;
        can_kingside = board->castling_rights & BLACK_KINGSIDE;
        can_queenside = board->castling_rights & BLACK_QUEENSIDE;
    }
    can_kingside = can_kingside && (info.king_attacker_count == 0);
    can_queenside = can_queenside && (info.king_attacker_count == 0);
    bitboard_t our_pawns = friendly & position->pawns;
    bitboard_t our_bishops = friendly & position->bishops;
    bitboard_t our_knights = friendly & position->knights;
    bitboard_t our_rooks = friendly & position->rooks;
    bitboard_t our_queens = friendly & position->queens;
    bitboard_t our_kings = friendly & position->kings;
    bitboard_t ep_bb = make_ep_bb(board->en_passant_square);
    bitboard_t empty = ~(friendly | hostile);


    bitboard_t pawn_hostile = (hostile | ep_bb);
    bitboard_t non_friendly = ~friendly;


    // printf("EN PASSANT SQUARE\n");
    // print_bitboard(ep_bb);
    // print_bitboard(info.allowed_move_mask);
    // print_bitboard(info.extra_pawn_capture_mask);
   	 
    u_int8_t moves = 0;
    bitboard_t iter = friendly;
		bitboard_t square_bb;
		while ((square_bb = LSB(iter))) {
        if (square_bb & our_kings) {
            bitboard_t destination_bb = king_attack_mask(square_bb, non_friendly & ~attacked_mask);
            if (can_kingside) {
                bitboard_t kingside = kingside_castling_mask(square_bb, attacked_mask, empty);
                destination_bb |= kingside;
            }
            if (can_queenside) {
                bitboard_t queenside = queenside_castling_mask(square_bb, attacked_mask, empty);
                destination_bb |= queenside;
            }
						moves += count_bits(destination_bb);
						iter &= ~LSB(iter);
            continue;
        }
        //bitboard_t pinned_mask = pinned_masks[square];
        bitboard_t pinned_mask = make_pinned_mask(board, square_bb, for_color);
        bitboard_t allowed_mask = pinned_mask & info.allowed_move_mask;
        if (square_bb & our_pawns) {
            bitboard_t destination_bb;
            if (square_bb & our_white_pawns) {
                destination_bb = white_pawn_push_mask(square_bb, empty) & allowed_mask;
                destination_bb |= white_pawn_attack_mask(square_bb, pawn_hostile) & info.extra_pawn_capture_mask;
                destination_bb &= pinned_mask;
                if (square_bb & RANK_7) moves += count_bits(destination_bb) * 4; //possible promotions
								else moves += count_bits(destination_bb);
						}
            else {
                destination_bb = black_pawn_push_mask(square_bb, empty) & allowed_mask;
                destination_bb |= black_pawn_attack_mask(square_bb, pawn_hostile)  & info.extra_pawn_capture_mask;
                destination_bb &= pinned_mask;
                if (square_bb & RANK_2) moves += count_bits(destination_bb) * 4; //possible promotions
								else moves += count_bits(destination_bb);
						}
        }
        else if (square_bb & our_knights) {
            bitboard_t destination_bb;
            destination_bb = knight_attack_mask(square_bb, non_friendly);
            destination_bb &= allowed_mask;
        		moves += count_bits(destination_bb);
				}
        else if (square_bb & our_rooks ) {
            bitboard_t destination_bb = sliding_attack_mask(square_bb, non_friendly, empty);
            destination_bb &= allowed_mask;
        		moves += count_bits(destination_bb);
        }
        else if (square_bb & our_bishops) {
            bitboard_t destination_bb = diagonal_attack_mask(square_bb, non_friendly, empty);
            destination_bb &= allowed_mask;
        		moves += count_bits(destination_bb);
				}
        else if (square_bb & our_queens) {
            bitboard_t destination_bb = diagonal_attack_mask(square_bb, non_friendly, empty);
            destination_bb |= sliding_attack_mask(square_bb, non_friendly, empty);
            destination_bb &= allowed_mask;
        		moves += count_bits(destination_bb);
				}
				iter &= ~LSB(iter);
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


u_int8_t generate_moves(
    full_board_t *board, 
    piece_color_t for_color, 
    bitboard_t attacked_mask,
    check_info_t info,
    move_t * move_buffer) {
    u_int8_t move_index = 0;

    position_t *position = board->position;
    bitboard_t friendly;
    bitboard_t hostile;

    bitboard_t pawn_one_square_advance;
    bitboard_t our_white_pawns = 0;
    bitboard_t our_black_pawns = 0;
    bool can_kingside;
    bool can_queenside;
    if (for_color == WHITE_VAL) {
        friendly = position->white_oc;
        hostile = position->black_oc;
        our_white_pawns = friendly & position->pawns & ~RANK_8;
        can_kingside = board->castling_rights & WHITE_KINGSIDE;
        can_queenside = board->castling_rights & WHITE_QUEENSIDE;
    }
    else {
        friendly = position->black_oc;
        hostile = position->white_oc;
        our_black_pawns = friendly & position->pawns & ~RANK_1;
        can_kingside = board->castling_rights & BLACK_KINGSIDE;
        can_queenside = board->castling_rights & BLACK_QUEENSIDE;
    }
    can_kingside = can_kingside && (info.king_attacker_count == 0);
    can_queenside = can_queenside && (info.king_attacker_count == 0);
    bitboard_t our_pawns = friendly & position->pawns;
    bitboard_t our_bishops = friendly & position->bishops;
    bitboard_t our_knights = friendly & position->knights;
    bitboard_t our_rooks = friendly & position->rooks;
    bitboard_t our_queens = friendly & position->queens;
    bitboard_t our_kings = friendly & position->kings;
    bitboard_t ep_bb = make_ep_bb(board->en_passant_square);
    bitboard_t empty = ~(friendly | hostile);


    bitboard_t pawn_hostile = (hostile | ep_bb);
    bitboard_t non_friendly = ~friendly;

    
    bitboard_t pinned_masks[64];
    make_all_pinned_masks(board, attacked_mask, for_color, pinned_masks);
    for (square_t origin = A1; origin <= H8; origin++) {
        //printf("%d at %d\n", get_piece_at(position, origin).type, origin);
        bitboard_t square_bb = SQUARE_TO_BB(origin);
        
        // pawn moves
        if (square_bb & empty) {
            continue;
        }
        if (square_bb & our_kings) {
            bitboard_t destination_bb = king_attack_mask(square_bb, non_friendly & ~attacked_mask);
            if (can_kingside) {
                bitboard_t kingside = kingside_castling_mask(square_bb, attacked_mask, empty);
                destination_bb |= kingside;
            }
            if (can_queenside) {
                bitboard_t queenside = queenside_castling_mask(square_bb, attacked_mask, empty);
                destination_bb |= queenside;
            }
            add_from_bitboard(origin, destination_bb, move_buffer, &move_index);
            continue;
        }
        
				bitboard_t pinned_mask = make_pinned_mask(board, square_bb, for_color);
        bitboard_t allowed_mask = pinned_mask & info.allowed_move_mask;
        if (square_bb & our_pawns) {
            bitboard_t destination_bb;

            if (square_bb & our_white_pawns) {
                destination_bb = white_pawn_push_mask(square_bb, empty) & allowed_mask;
                destination_bb |= white_pawn_attack_mask(square_bb, pawn_hostile) & info.extra_pawn_capture_mask;
                destination_bb &= pinned_mask;
                if (square_bb & RANK_7) {
                    add_from_bitboard_white_promotes(origin, destination_bb, move_buffer, &move_index);
                }
                else {
                    add_from_bitboard(origin, destination_bb, move_buffer, &move_index);
                }
            }
            else {
                destination_bb = black_pawn_push_mask(square_bb, empty) & allowed_mask;
                destination_bb |= black_pawn_attack_mask(square_bb, pawn_hostile)  & info.extra_pawn_capture_mask;
                destination_bb &= pinned_mask;
                if (square_bb & RANK_2) {
                    add_from_bitboard_black_promotes(origin, destination_bb, move_buffer, &move_index);
                }
                else {
                    add_from_bitboard(origin, destination_bb, move_buffer, &move_index);
                }
            }
        }
        else if (square_bb & our_knights) {
            bitboard_t destination_bb;
            destination_bb = knight_attack_mask(square_bb, non_friendly);
            destination_bb &= allowed_mask;
            add_from_bitboard(origin, destination_bb, move_buffer, &move_index);
        }
        else if (square_bb & our_rooks) {
            bitboard_t destination_bb = sliding_attack_mask(square_bb, non_friendly, empty);
            destination_bb &= allowed_mask;
            add_from_bitboard(origin, destination_bb, move_buffer, &move_index);
            
        }
        else if (square_bb & our_bishops) {
            bitboard_t destination_bb = diagonal_attack_mask(square_bb, non_friendly, empty);
            destination_bb &= allowed_mask;
            add_from_bitboard(origin, destination_bb, move_buffer, &move_index);
        }
        else if (square_bb & our_queens) {
            bitboard_t destination_bb = diagonal_attack_mask(square_bb, non_friendly, empty);
            destination_bb |= sliding_attack_mask(square_bb, non_friendly, empty);
            destination_bb &= allowed_mask;
            add_from_bitboard(origin, destination_bb, move_buffer, &move_index);
        }
    }
    return move_index;
}
/*
bool is_legal_promotion(full_board_t * board, promotion_move_t promotion) {
	bitboard_t origin = SQUARE_TO_BB(promotion.body.origin);
	bitboard_t destination = SQUARE_TO_BB(promotion.body.destination);
	position_t * position;
	if (origin & position->pawns) {
		if (board->turn == WHITE_VAL 
				&& (origin & position->white_oc & RANK_7) 
				&& (destination & RANK_8)) {
			if (destination & ABOVE_BB(origin)){
				bitboard_t empty = ~(position->white_oc | position->black_oc);
				return empty & destination;
			}
			else if (destination & ABOVE_BB(SAFE_LEFT_BB(origin))) {
				return position->black_oc & destination;
			}
			else if (destination & ABOVE_BB(SAFE_RIGHT_BB(origin))) {
				return position->black_oc & destination;
			}
		}
		else if (board->turn == BLACK_VAL 
				&& (origin & position->black_oc & RANK_2) 
				&& (destination & RANK_1)) {
			if (destination & BELOW_BB(origin)){
				bitboard_t empty = ~(position->white_oc | position->black_oc);
				return empty & destination;
			}
			else if (destination & BELOW_BB(SAFE_LEFT_BB(origin))) {
				return position->white_oc & destination;
			}
			else if (destination & BELOW_BB(SAFE_RIGHT_BB(origin))) {
				return position->white_oc & destination;
			}
		}
	}
	return false;
}

bool is_legal_generic(full_board_t *board, generic_move_t move) {
	bitboard_t origin = SQUARE_TO_BB(move.origin);
	bitboard_t destination = SQUARE_TO_BB(move.destination);
	if 

}
bool is_legal_move(full_board_t *board, move_t move) {
	if (move.type == PROMOTION_MOVE){
		return is_legal_promotion(board, move.promotion);
	}
	else if (move.type == GENERIC_MOVE) {
		return is_legal_generic(board, move.generic);
	}

}

*/

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

bool is_threefold_repetition(full_board_t *board, undoable_move_t *move_stack, u_int16_t stack_size) {
	turn_clock_t halfmove = board->halfmove_clock;	
	u_int8_t matches = 0;
	full_board_t copy;
	position_t pos;
	copy.position = &pos;
	copy_into(&copy, board); 
	for (int16_t index = stack_size - 1; index >= 0; index--) {
		undo_move(&copy, move_stack[index]);
		halfmove = halfmove ? halfmove - 1 : 0;
		if (halfmove != copy.halfmove_clock) break;
		if (positions_equal(copy.position, board->position)) ++matches;
		if (matches > 1) return true;
	}
	return false;	
}

bool is_draw(full_board_t *board, undoable_move_t *move_stack, u_int8_t stack_size) {
		piece_color_t for_color = board->turn;
    bitboard_t attack_mask = make_attack_mask(board, WHITE_VAL == for_color ? BLACK_VAL : WHITE_VAL);
    check_info_t info = make_check_info(board, for_color, attack_mask);
		u_int8_t move_count = count_moves(board, for_color, attack_mask, info);
		if (move_count) {
					return board->halfmove_clock >= 50 
									|| is_threefold_repetition(board, move_stack, stack_size);	
		}
		return info.king_attacker_count == 0;
}



u_int8_t count_legal_moves(full_board_t *board) {
		piece_color_t for_color = board->turn;
    bitboard_t attack_mask = make_attack_mask(board, WHITE_VAL == for_color ? BLACK_VAL : WHITE_VAL);
    check_info_t info = make_check_info(board, for_color, attack_mask);
    return count_moves(board, for_color, attack_mask, info);
}



u_int8_t count_pseudolegal_moves(full_board_t *board) {
    return count_moves(board, board->turn, 0, non_check_info());
}

u_int8_t generate_legal_moves(full_board_t *board, move_t * move_buffer) {
		piece_color_t for_color = board->turn;
    bitboard_t attack_mask = make_attack_mask(board, WHITE_VAL == for_color ? BLACK_VAL : WHITE_VAL);
    check_info_t info = make_check_info(board, for_color, attack_mask);
    // printf("ATTACK MASK 2\n");
    // print_bitboard(attack_mask);
    return generate_moves(board, for_color, attack_mask, info, move_buffer);
}


u_int8_t generate_pseudolegal_moves(full_board_t *board, move_t * move_buffer) {
     return generate_moves(board, board->turn, 0, non_check_info(), move_buffer);
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




square_t get_origin(move_t move){
  generic_move_t body;
  if (move.type == PROMOTION_MOVE) body = move.promotion.body;
  else body = move.generic;
  return body.origin;
}

square_t get_destination(move_t move) {
  generic_move_t body;
  if (move.type == PROMOTION_MOVE) body = move.promotion.body;
  else body = move.generic;
  return body.origin;
}

bool is_promotion(move_t move){
  return move.type == PROMOTION_MOVE;
}

piece_t promotes_to(move_t move) {
  if (move.type != PROMOTION_MOVE) return empty_piece();
  piece_t out;
  out.type = move.promotion.promote_to; 
  out.color = move.promotion.body.destination & RANK_8 ? WHITE_VAL : BLACK_VAL;
  return out;
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










// bitboard_t king_moves_bb(square_t square) {
//     bitboard_t around = 0;
//     for (int i = -1; i < 2; i++) {
//         for (int j = -1; j < 2; j++) {
//             if (offset_valid(square, i, j)) {
//                 square_t offset = offset_square(square, i, j);
//                 around |= SQUARE_TO_BB(offset);
//             }
//         }
//     }
//     return around;
// }

// bitboard_t knight_moves_bb(square_t square) {
//     bitboard_t bb = 0;
//     int8_t file_offsets[] = {-2, -2, -1, -1,  1,  1,  2,  2};
//     int8_t rank_offsets[] = {-1,  1, -2,  2, -2,  2, -1,  1};
//     for (int8_t i = 0; i < 8; i ++) {
//         if (offset_valid(square, rank_offsets[i], file_offsets[i])) {
//             square_t dest = offset_square(square, rank_offsets[i], file_offsets[i]);
//             bb |= SQUARE_TO_BB(dest);
//         }
//     }
//     return bb;
// }

// bitboard_t straight_moves_bb(square_t square) {
//     bitboard_t bb = 0;
//     for (int dist = 1; dist < 8; dist ++) {
//         if (offset_valid(square, dist, 0)) {
//             square_t dest = offset_square(square, dist, 0);
//             bb |= SQUARE_TO_BB(dest);
//         } else break;
//     }
//     for (int dist = 1; dist < 8; dist ++) {
//         if (offset_valid(square, -dist, 0)) {
//             square_t dest = offset_square(square, -dist, 0);
//             bb |= SQUARE_TO_BB(dest);
//         } else break;
//     }
//     for (int dist = 1; dist < 8; dist ++) {
//         if (offset_valid(square, 0, dist)) {
//             square_t dest = offset_square(square, 0, dist);
//             bb |= SQUARE_TO_BB(dest);
//         } else break;
//     }
//     for (int dist = 1; dist < 8; dist ++) {
//         if (offset_valid(square, 0, -dist)) {
//             square_t dest = offset_square(square, 0, -dist);
//             bb |= SQUARE_TO_BB(dest);
//         } else break;
//     }
//     return bb;
// }

// bitboard_t diagonal_moves_bb(square_t square) {
//     bitboard_t bb = 0;
//     for (int dist = 1; dist < 8; dist ++) {
//         if (offset_valid(square, dist, dist)) {
//             square_t dest = offset_square(square, dist, dist);
//             bb |= SQUARE_TO_BB(dest);
//         } else break;
//     }
//     for (int dist = 1; dist < 8; dist ++) {
//         if (offset_valid(square, -dist, -dist)) {
//             square_t dest = offset_square(square, -dist, -dist);
//             bb |= SQUARE_TO_BB(dest);
//         } else break;
//     }
//     for (int dist = 1; dist < 8; dist ++) {
//         if (offset_valid(square, -dist, dist)) {
//             square_t dest = offset_square(square, -dist, dist);
//             bb |= SQUARE_TO_BB(dest);
//         } else break;
//     }
//     for (int dist = 1; dist < 8; dist ++) {
//         if (offset_valid(square, dist, -dist)) {
//             square_t dest = offset_square(square, dist, -dist);
//             bb |= SQUARE_TO_BB(dest);
//         } else break;
//     }
//     return bb;
// }

// void prepare_moves(bitboard_t * moves_buffer, bitboard_t (*bb_maker)(square_t)) {
//     if (moves_buffer) {
//         for (square_t square = A1; square <= H8; square++) {
//             moves_buffer[square] = bb_maker(square);
//         }
//     }
// }

// void prepare_move_table() {
//     if (move_table == 0) {
//         move_table = (moveable_table_t *)malloc(sizeof(moveable_table_t));
//         if (move_table == 0) {
//             return;
//         }
//         move_table->kings_moves = (bitboard_t *)malloc(sizeof(bitboard_t) * 64);
//         move_table->knights_moves = (bitboard_t *)malloc(sizeof(bitboard_t) * 64);
//         // move_table->straight_moves = (bitboard_t *)malloc(sizeof(bitboard_t) * 64);
//         // move_table->diagonal_moves = (bitboard_t *)malloc(sizeof(bitboard_t) * 64);
//         prepare_moves(move_table->kings_moves, &king_moves_bb);
//         prepare_moves(move_table->knights_moves, &knight_moves_bb);
//         // prepare_moves(move_table->straight_moves, &straight_moves_bb);
//         // prepare_moves(move_table->diagonal_moves, &diagonal_moves_bb);
//     }
// }


