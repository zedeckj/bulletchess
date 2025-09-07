#include "board.h"


/*
// Initialzes the move stack to have a given length
move_stack_t *initialize_move_stack(u_int64_t capacity){
  move_stack_t * stack = (move_stack_t *)malloc(sizeof(move_stack_t));
  if (!stack) return 0;
  stack->length = 0;
  stack->capacity = capacity;
  stack->values = (undoable_move_t *)malloc(sizeof(undoable_move_t) * capacity);
  if (!stack->values) return 0;
  return stack;
}


// Pushes an undoable move to the move stack, growing the stack's 
// capacity if needed, and increasing the length by 1
void push_move(move_stack_t *stack, undoable_move_t move){
  #define GROW_STACK 5
  if (stack) {
    if (stack->capacity >= stack->length) {
      u_int16_t new_capacity = stack->capacity * GROW_STACK;
      undoable_move_t *new_values = malloc(sizeof(undoable_move_t) * new_capacity); 
      stack->capacity = new_capacity;
      memcpy(new_values, stack->values, sizeof(undoable_move_t) * stack->length);
      stack->values = new_values; 
    }
    stack->values[stack->length] = move;
    stack->length += 1;
  }
}
// Pops a move from the stack, decreasing the length by 1
undoable_move_t pop_move(move_stack_t *stack){
  if (stack && stack->length > 0) {
    undoable_move_t move = stack->values[stack->length - 1];
    stack->length -= 1;
    return move;
  }
  else {
    undoable_move_t move;
    move.move.type = ERROR_MOVE;
    return move;
  }
}
// Undoes the last move in the board's move_stack
move_t undo_move(full_board_t * board);
*/


void starting_board(full_board_t *board) {
	position_t *pos = board->position;
	pos->pawns = PAWNS_STARTING;
	pos->knights = KNIGHTS_STARTING;
	pos->bishops = BISHOPS_STARTING;
	pos->rooks = ROOKS_STARTING;
	pos->queens = QUEENS_STARTING;
	pos->kings = KINGS_STARTING;
	pos->white_oc = WHITE_STARTING;
	pos->black_oc = BLACK_STARTING;
	board->castling_rights = FULL_CASTLING;
	board->turn = WHITE_VAL;
	board->en_passant_square.exists = false;
	board->halfmove_clock = 0;
	board->fullmove_number = 1;
}



piece_t get_piece_at_bb(position_t * board, bitboard_t square_bb);


#define DOT "\u2022"
#define TEXT_COLOR "\x1B[38;5;%dm"
#define BKG_COLOR "\x1B[48;5;%dm"

void unicode_write_board(full_board_t *board, char *buffer, 
		u_int8_t text_color,
		u_int8_t light_color,
		u_int8_t dark_color,
		u_int8_t select_color,
		bitboard_t select_bb, 
		bitboard_t target_bb) {
		int str_i = sprintf(buffer, TEXT_COLOR, text_color);
		int i = 0;
		for (bitboard_t rank = RANK_8; i < 8; i++) {
        int j = 0;
        for (bitboard_t file = FILE_A; j < 8; j++) {
					bitboard_t sq_bb = rank & file;
					piece_t p = get_piece_at_bb(board->position, sq_bb);	
					
					int color;
					if (sq_bb & select_bb) color = select_color;
					else color = sq_bb & LIGHT_SQ_BB ? light_color : dark_color;
					str_i += sprintf(buffer + str_i, BKG_COLOR, color); 
					
					if (sq_bb & select_bb) str_i += sprintf(buffer + str_i, "\x1B[5;23m");
					else str_i += sprintf(buffer + str_i, "\x1B[25m"); 
					
					str_i += sprintf(buffer + str_i, "%s", piece_unicode(p));
					
					if (sq_bb & target_bb) 
						str_i += sprintf(buffer + str_i, DOT);
					else buffer[str_i++] = ' ';
			

					file = SAFE_RIGHT_BB(file);
				}
				str_i += sprintf(buffer + str_i, "\x1B[49m"); 
				buffer[str_i++] = '\n';
        rank = BELOW_BB(rank);
    }
		str_i += sprintf(buffer + str_i, "\x1B[0m");
		buffer[str_i] = 0;
}


void str_write_board(full_board_t *board, char *buffer) {
		int str_i = 0;
		int i = 0;
    for (bitboard_t rank = RANK_8; i < 8; i++) {
        int j = 0;
        for (bitboard_t file = FILE_A; j < 8; j++) {
					bitboard_t sq_bb = rank & file;
					piece_t p = get_piece_at_bb(board->position, sq_bb);	
					char c = piece_symbol(p);					
					buffer[str_i++] = c;
					buffer[str_i++] = ' ';
					file = SAFE_RIGHT_BB(file);
				}
				buffer[str_i++] = '\n';
        rank = BELOW_BB(rank);
    }
		buffer[str_i] = 0;
}

bool square_empty(position_t * position, square_t square) {
    return !((position->black_oc & SQUARE_TO_BB(square)) || (position->white_oc & SQUARE_TO_BB(square)));
}

bool white_occupies(position_t * position, square_t square) {
    return position->white_oc & SQUARE_TO_BB(square);
}

bool black_occupies(position_t * position, square_t square) {
    return position->black_oc & SQUARE_TO_BB(square);
}

bool color_occupies(position_t * position, square_t square, piece_color_t color) {
    if (color == WHITE_VAL) return white_occupies(position, square);
    else if (color == BLACK_VAL) return black_occupies(position, square);
    else return false;
}

bool en_passant_is(full_board_t * board, square_t square) {
    if (board->en_passant_square.exists) {
        return board->en_passant_square.square == square;
    }
    return false;
}

bitboard_t get_piece_type_bb(position_t* position, piece_type_t piece_type) {
	bitboard_t piece_bb;
	switch (piece_type) {
		case EMPTY_VAL:
		return ~(position->white_oc | position->black_oc);
		case PAWN_VAL:
		piece_bb = position->pawns;
	 	break;
		case KNIGHT_VAL:
		piece_bb = position->knights;
		break;
		case BISHOP_VAL:
		piece_bb = position->bishops;
		break;
		case ROOK_VAL:
		piece_bb = position->rooks;
		break;
		case QUEEN_VAL:
		piece_bb = position->queens;
		break;
		default:
		piece_bb = position->kings;
		break;
	}
	return piece_bb;
}



bitboard_t get_piece_bb(position_t* position, piece_t piece) {
	bitboard_t piece_bb = get_piece_type_bb(position, piece.type);
	bitboard_t color_bb = piece.color == WHITE_VAL ? position->white_oc : position->black_oc;
	return piece_bb & color_bb;
}

bitboard_t get_piece_bb_from_board(full_board_t * board, piece_t piece) {
	return get_piece_bb(board->position, piece);
}



u_int8_t count_piece_type(full_board_t * board, piece_type_t type) {
	position_t * pos = board->position;
	switch (type) {
		case PAWN_VAL:
		return count_bits(pos->pawns);
		case KNIGHT_VAL:
		return count_bits(pos->knights);
		case BISHOP_VAL:
		return count_bits(pos->bishops);
		case ROOK_VAL:
		return count_bits(pos->rooks);
		case QUEEN_VAL:
		return count_bits(pos->queens);
		case KING_VAL:
		return count_bits(pos->kings);
	}
	return 0;
}	




u_int8_t count_color(full_board_t * board, piece_color_t color) {
	position_t *pos = board->position;
	if (color == WHITE_VAL) return count_bits(pos->white_oc);	
	else if (color == BLACK_VAL) return count_bits(pos->black_oc);
	return 0;
}

u_int8_t count_piece(full_board_t * board, piece_index_t index) {
	bitboard_t bb = get_piece_bb(board->position, index_to_piece(index));
	return count_bits(bb);
}

int8_t net_piece_type(full_board_t * board, piece_type_t type) {
	position_t * position = board->position;
	bitboard_t piece_bb = get_piece_type_bb(position, type);
	return count_bits(piece_bb & position->white_oc) - count_bits(piece_bb & position->black_oc);
}

void write_bitboard(bitboard_t board, char * buffer) {
    int i = 0;
		int n = 0;
    for (bitboard_t rank = RANK_8; i < 8; i++) {
        int j = 0;
        for (bitboard_t file = FILE_A; j < 8; j++) {
        		buffer[n++] = (file & rank & board) ? '1' : '0';
            buffer[n++] = ' ';
						file = SAFE_RIGHT_BB(file);
        }
        buffer[n++] = '\n';
				rank = BELOW_BB(rank);
    }
		buffer[n++] = '\0';
}


void mask_board_with(position_t * board, bitboard_t keep_bb) {
    board->pawns &= keep_bb;
    board->knights &= keep_bb;
    board->bishops &= keep_bb;
    board->queens &= keep_bb;
    board->kings &= keep_bb;
    board->rooks &= keep_bb;
    board->white_oc &= keep_bb;
    board->black_oc &= keep_bb;
}

void delete_piece_at(position_t * board, square_t square) {
    bitboard_t square_bb = SQUARE_TO_BB(square);
    bitboard_t keep_bb = ~square_bb;
    board->pawns &= keep_bb;
    board->knights &= keep_bb;
    board->bishops &= keep_bb;
    board->queens &= keep_bb;
    board->kings &= keep_bb;
    board->rooks &= keep_bb;
    board->white_oc &= keep_bb;
    board->black_oc &= keep_bb;
}


void delete_piece_at_board(full_board_t * board, piece_index_t * array, square_t square) {
	delete_piece_at(board->position, square); 
	if (array)
		array[square] = EMPTY_INDEX;
}


piece_counts_t count_pieces(position_t *position) {
    piece_counts_t counts;
    counts.black_pawns = 0;
    counts.black_knights = 0;
    counts.black_bishops = 0;
    counts.black_rooks = 0;
    counts.black_queens = 0;
    counts.white_pawns = 0;
    counts.white_knights = 0;
    counts.white_bishops = 0;
    counts.white_rooks = 0;
    counts.white_queens = 0;
    for (square_t square = A1; square <= H8; square++) {
        bitboard_t bb = SQUARE_TO_BB(square);
        if (position->white_oc & bb) {
            if (position->pawns & bb) {
                counts.white_pawns += 1;
            }
            else if (position->knights & bb) {
                counts.white_knights += 1;
            }
            else if (position->bishops & bb) {
                counts.white_bishops +=1;
            }
            else if (position->rooks & bb) {
                counts.white_rooks += 1;
            }
            else if (position->queens & bb) {
                counts.white_queens += 1;
            }
        }
        else if (position->black_oc & bb) {
            if (position->pawns & bb) {
                counts.black_pawns += 1;
            }
            else if (position->knights & bb) {
                counts.black_knights += 1;
            }
            else if (position->bishops & bb) {
                counts.black_bishops +=1;
            }
            else if (position->rooks & bb) {
                counts.black_rooks += 1;
            }
            else if (position->queens & bb) {
                counts.black_queens += 1;
            }
        }
    }
    return counts;
}


bool counts_match(u_int8_t ref_counts, u_int8_t check_counts) {
	bool out = !((u_int8_t)~ref_counts) || ref_counts == check_counts;
	return out;
}

bool board_has_counts(full_board_t *board, piece_counts_t counts) {
	piece_counts_t to_check = count_pieces(board->position);
	bool out = counts_match(counts.white_pawns, to_check.white_pawns) &&
				 counts_match(counts.white_knights, to_check.white_knights) &&
	       counts_match(counts.white_bishops, to_check.white_bishops) &&
	       counts_match(counts.white_rooks, to_check.white_rooks) &&
	       counts_match(counts.white_queens, to_check.white_queens) &&
				 counts_match(counts.black_pawns, to_check.black_pawns) &&
				 counts_match(counts.black_knights, to_check.black_knights) &&
	       counts_match(counts.black_bishops, to_check.black_bishops) &&
	       counts_match(counts.black_rooks, to_check.black_rooks) &&
	       counts_match(counts.black_queens, to_check.black_queens);
	return out;
}
u_int64_t filter_boards_from_counts(full_board_t **boards, 
								u_int64_t in_length,
								piece_counts_t counts, 
								full_board_t **out_list) {
	u_int64_t out_length = 0;
	for (u_int64_t i = 0; i < in_length; i++) {
		if (board_has_counts(boards[i], counts)) {
			out_list[out_length++] = boards[i];
		}
	}
	return out_length;
}

bool contains_piece(position_t * position, piece_t piece) {
    if (piece.type == EMPTY_VAL) {
        return (~position->black_oc | ~position->white_oc);
    }
    bitboard_t color_bb = piece.color == WHITE_VAL ? position->white_oc : position->black_oc;
    switch (piece.type) {
        case PAWN_VAL:
            return color_bb & position->pawns;
        case KNIGHT_VAL:
            return color_bb & position->knights;
        case BISHOP_VAL:
            return color_bb & position->bishops;
        case ROOK_VAL:
            return color_bb & position->rooks;
        case QUEEN_VAL:
            return color_bb & position->queens;
        default:
            return color_bb & position->kings;
        }
}

bool contains_piece_index(full_board_t *board, piece_index_t index) {
	position_t * pos = board->position;
	switch(index) {
		case EMPTY_INDEX:
			return ~(pos->white_oc | pos->black_oc);
		case PAWN_INDEX:
			return pos->white_oc & pos->pawns;
		case KNIGHT_INDEX:
			return pos->white_oc & pos->knights;
		case BISHOP_INDEX:
			return pos->white_oc & pos->bishops;
		case ROOK_INDEX:
			return pos->white_oc & pos->rooks;
		case QUEEN_INDEX:
			return pos->white_oc & pos->queens;
		case KING_INDEX:
			return pos->white_oc & pos->kings;
		case PAWN_INDEX + BLACK_OFFSET:
			return pos->black_oc & pos->pawns;
		case KNIGHT_INDEX + BLACK_OFFSET:
			return pos->black_oc & pos->knights;
		case BISHOP_INDEX + BLACK_OFFSET:
			return pos->black_oc & pos->bishops;
		case ROOK_INDEX + BLACK_OFFSET:
			return pos->black_oc & pos->rooks;
		case QUEEN_INDEX + BLACK_OFFSET:
			return pos->black_oc & pos->queens;
		case KING_INDEX + BLACK_OFFSET:
			return pos->black_oc & pos->kings;
	}
	return false;
}

bool is_subset(position_t * source, position_t * check) {
    // For a position to be a subset of another,
    // it must not have any pieces that are not in the superset.
    // This means that performing an and should result in the same position
    return (
        ((source->white_oc & check->white_oc) == source->white_oc) &&
        ((source->black_oc & check->black_oc) == source->black_oc) &&
        ((source->pawns & check->pawns) == source->pawns) &&
        ((source->knights & check->knights) == source->knights) &&
        ((source->bishops & check->bishops) == source->bishops) &&
        ((source->rooks & check->rooks) == source->rooks) &&
        ((source->queens & check->queens) == source->queens) &&
        ((source->kings & check->kings) == source->kings)
    );
}
/*
void debug_equal(full_board_t *board1, full_board_t *board2) {
	if (!board1) fprintf(stdout, "Board1 is null\n");
	if (!board2) fprintf(stdout, "Board2 is null\n");
	if (board1->castling_rights != board2->castling_rights)
		fprintf(stdout, "Castling rights do not match");
	if (board1->turn != board2->turn)
		fprintf(stdout, "Turns do not match");
	if (!board1->position) 
		fprintf(stdout, "Pos1 is null");
	if (!board2->position)
		fprintf(stdout, "Pos2 is null");
	if (board1->position->pawns != board2->position->pawns)
		fprintf(stdout, "Pawns mismatch");
  if (board1->position->knights != board2->position->knights)
		fprintf(stdout, "Knights mismatch");
	if (board1->position->bishops != board2->position->bishops)
		fprintf(stdout, "Bishops mismatch");
	if (board1->position->queens != board2->position->queens)
		fprintf(stdout, "Queens mismatch");
	if (board1->position->kings != board2->position->kings)
		fprintf(stdout, "Kings mismatch");
	optional_square_t ep1 = board1->en_passant_square;
  optional_square_t ep2 = board2->en_passant_square;
	if (ep1.exists && !ep2.exists) 
		fprintf(stdout, "EP1 exists but not ep2");
	if (!ep1.exists && ep2.exists)
		fprintf(stdout, "EP1 does not exists but EP2 does");
	if (ep1.exists && ep2.exists)
		if (ep1.square != ep2.square) fprintf(stdout, "eps mismatch");
  

	fprintf(stdout, "EQ WAS TESTED !!!!!!!!!!!!!!!!!!!!!!!!1\n\n\n");	
}
*/



bool positions_equal(position_t *pos1, position_t *pos2){
		return 
        pos1 && pos2 && 
        pos1->black_oc == pos2->black_oc &&
        pos1->white_oc == pos2->white_oc &&
				pos1->pawns == pos2->pawns &&
        pos1->knights == pos2->knights &&
        pos1->bishops == pos2->bishops &&
        pos1->queens == pos2->queens &&
        pos1->rooks == pos2->rooks &&
				pos1->kings == pos2->kings;


}
bool boards_legally_equal(full_board_t *board1, full_board_t *board2) {
		//debug_equal(board1, board2);
		if (board1 && board2 &&
        board1->castling_rights == board2->castling_rights &&
        board1->turn == board2->turn &&
        positions_equal(board1->position, board2->position)
    ) {
				optional_square_t ep1 = board1->en_passant_square;
        optional_square_t ep2 = board2->en_passant_square;
				if (ep1.exists) {
            return ep2.exists && ep1.square == ep2.square;
        } 
        return !ep2.exists;
    }
    return false;
}

bool boards_equal(full_board_t * board1, full_board_t * board2) {
	if (boards_legally_equal(board1, board2)) {
   			return board1->halfmove_clock == board2->halfmove_clock &&
        board1->fullmove_number == board2->fullmove_number;
	}
	return false;
}


bool board_has_pattern(full_board_t * board, piece_pattern_t pattern) {
	bitboard_t piece_bb = get_piece_bb(board->position, pattern.piece);
 	switch (pattern.pattern_type) {
		case COUNT_PATTERN:
		return count_bits(piece_bb) == pattern.count;
		case BITBOARD_PATTERN:
	 	return piece_bb == pattern.bitboard;
	}
	return false;	
}

bool board_has_patterns(full_board_t *board, piece_pattern_t *patterns, u_int64_t pattern_count) {
	bool has = true;
	for (u_int64_t i = 0; has && i < pattern_count; i++) {
		has = board_has_pattern(board, patterns[i]);
	}
	return has;
}



// Should be called with a buffer of length 64
u_int8_t squares_with_piece(full_board_t *board, piece_t piece, square_t *square_buffer) {
	u_int8_t count = 0;
	bitboard_t piece_bb = get_piece_bb(board->position, piece);
	for (square_t square = A1; square <= H8; square++) {
		bitboard_t sq_bb = SQUARE_TO_BB(square);
		if (sq_bb & piece_bb) {
			square_buffer[count++] = square;
		}		
	}
	return count;
}
piece_index_t index_into(piece_index_t *array, square_t square) {
	return array[square];
}

void copy_into(full_board_t * dst, full_board_t * source) {
    dst->turn = source->turn;
		dst->castling_rights = source->castling_rights;
    dst->en_passant_square = source->en_passant_square;
    dst->fullmove_number = source->fullmove_number;
    dst->halfmove_clock = source->halfmove_clock;
    
		dst->position->pawns = source->position->pawns;
    dst->position->knights = source->position->knights;
    dst->position->bishops = source->position->bishops;
    dst->position->rooks = source->position->rooks;
    dst->position->queens = source->position->queens;
    dst->position->kings = source->position->kings;
    dst->position->white_oc = source->position->white_oc;
    dst->position->black_oc = source->position->black_oc;
}

/*
bitboard_t bitboard_diff(full_board_t * board1, full_board_t * board2) {
    bitboard_t xord = 
        (board1->position->knights ^ board1->position->knights) |
        (board1->position->bishops ^ board1->position->bishops) |
        (board1->position->rooks ^ board1->position->rooks) |
        (board1->position->queens ^ board1->position->queens) |
        (board1->position->kings ^ board1->position->kings) |
        (board1->position->white_oc ^ board1->position->white_oc) |
        (board1->position->black_oc ^ board1->position->black_oc);
    return xord;
}
*/


void set_piece_at(position_t * board, square_t square, piece_t piece) {
    bitboard_t square_bb = SQUARE_TO_BB(square);
    if (!square_empty(board, square)) {
        mask_board_with(board, ~square_bb);
    }
    switch (piece.type) {
        case EMPTY_VAL:
            return;
        case PAWN_VAL:
            board->pawns |= square_bb;
            break;
        case BISHOP_VAL:
            board->bishops |= square_bb;
            break;
        case KNIGHT_VAL:
            board->knights |= square_bb;
            break;
        case ROOK_VAL:
            board->rooks |= square_bb;
            break;
        case QUEEN_VAL:
            board->queens |= square_bb;
            break;
        case KING_VAL:
            board->kings |= square_bb;
            break;
    }

    if (piece.color == WHITE_VAL) {
        board->white_oc |= square_bb;
    }
    else {
        board->black_oc |= square_bb;
    }
}

void set_piece_index(full_board_t *board, piece_index_t *array, square_t square, piece_index_t index) {
	piece_t piece = index_to_piece(index);
	set_piece_at(board->position, square, piece);
	if (array)
		array[square] = index;
}

piece_t get_piece_at_bb(position_t * board, bitboard_t square_bb){
    piece_color_t color;
    piece_color_t type;
    if (board->black_oc & square_bb) {
        color = BLACK_VAL;
    }
    else if (board->white_oc & square_bb) {
        color = WHITE_VAL;
    }
    else {
        return empty_piece();
    }

    if (board->pawns & square_bb) {
        type = PAWN_VAL;
    }
    else if (board->knights & square_bb) {
        type = KNIGHT_VAL;
    }
    else if (board->bishops & square_bb) {
        type = BISHOP_VAL;
    }
    else if (board->rooks & square_bb) {
        type = ROOK_VAL;
    }
    else if (board->queens & square_bb) {
        type = QUEEN_VAL;
    }
    else if (board->kings & square_bb) {
        type = KING_VAL;
    }
    piece_t piece;
    piece.color = color;
    piece.type = type;
    return piece;
}


piece_t get_piece_at(position_t * board, square_t square) {
    bitboard_t square_bb = SQUARE_TO_BB(square);
    return get_piece_at_bb(board, square_bb);
}

piece_index_t get_index_at(position_t *position, square_t square) {
    piece_index_t index = EMPTY_INDEX;
		bitboard_t square_bb = SQUARE_TO_BB(square);
		if (position->black_oc & square_bb) {
    	index = BLACK_OFFSET;
    }
    else if (~position->white_oc & square_bb) {
    	return index;
		}
    if (position->pawns & square_bb) {
        return index + PAWN_INDEX;
    }
    else if (position->knights & square_bb) {
        return index + KNIGHT_INDEX;
    }
    else if (position->bishops & square_bb) {
        return index + BISHOP_INDEX;
    }
    else if (position->rooks & square_bb) {
        return index + ROOK_INDEX;
    }
    else if (position->queens & square_bb) {
        return index + QUEEN_INDEX;
    }
    else if (position->kings & square_bb) {
        return index + KING_INDEX;
    }
    return index;
}


piece_index_t get_piece_at_board(full_board_t * board, square_t square) {
    return get_index_at(board->position, square);
}


// index_list should be an array of length 64
void fill_piece_index_array(full_board_t *board, piece_index_t* index_array) {
	position_t * position = board->position;
	for (square_t square = A1; square <= H8; square++) {
		index_array[square] = get_index_at(position, square);
	}
}



void clear_board(position_t *board) {
    board->pawns = 0;
    board->knights = 0;
    board->bishops = 0;
    board->rooks = 0;
    board->queens = 0;
    board->kings = 0;
    board->white_oc = 0;
    board->black_oc = 0;
}

bool has_kingside_castling_rights(full_board_t* board, piece_color_t color) {
    if (color == WHITE_VAL) {
        return board->castling_rights & WHITE_KINGSIDE;
    }
    else {
        return board->castling_rights & BLACK_KINGSIDE;
    }
}

bool has_queenside_castling_rights(full_board_t* board, piece_color_t color) {
    if (color == WHITE_VAL) {
        return board->castling_rights & WHITE_QUEENSIDE;
    }
    else {
        return board->castling_rights & BLACK_QUEENSIDE;
    }
}

bool has_castling_rights(full_board_t* board, piece_color_t color) {
    if (color == WHITE_VAL) {
        return (board->castling_rights & WHITE_KINGSIDE) || 
        (board->castling_rights & WHITE_QUEENSIDE);
    }
    else {
        return (board->castling_rights & BLACK_KINGSIDE) ||
        (board->castling_rights & BLACK_QUEENSIDE);
    }
}

void clear_castling_rights(full_board_t* board, piece_color_t color) {
    if (color == WHITE_VAL) {
        board->castling_rights &= BLACK_FULL_CASTLING;
    }
    else {
        board->castling_rights &= WHITE_FULL_CASTLING;
    }
}

void clear_kingside_castling_rights(full_board_t* board, piece_color_t color) {
    if (color == WHITE_VAL) {
        board->castling_rights &= ~WHITE_KINGSIDE;
    }
    else {
        board->castling_rights &= ~BLACK_KINGSIDE;
    }
}

void clear_queenside_castling_rights(full_board_t* board, piece_color_t color) {
    if (color == WHITE_VAL) {
        board->castling_rights &= ~WHITE_QUEENSIDE;
    }
    else {
        board->castling_rights &= ~BLACK_QUEENSIDE;
    }
}

void set_full_castling_rights(full_board_t* board) {
    board->castling_rights = FULL_CASTLING;
}


void add_castling_rights(full_board_t* board, bool kingside, piece_color_t color) {
    if (color == WHITE_VAL) {
        if (kingside) board->castling_rights |= WHITE_KINGSIDE;
        else board->castling_rights |= WHITE_QUEENSIDE;
    }
    else {
        if (kingside) board->castling_rights |= BLACK_KINGSIDE;
        else board->castling_rights |= BLACK_QUEENSIDE;
    }
}

void clear_ep_square(full_board_t * board) {
    board->en_passant_square.exists = false;
    board->en_passant_square.square = EMPTY_EP;
}

void set_ep_square(full_board_t * board, square_t square) {
    board->en_passant_square.exists = true;
    board->en_passant_square.square = square;
}



char * set_ep_square_checked(full_board_t *board, square_t square) {
 	position_t *pos = board->position;
	bitboard_t white_pawns = pos->white_oc & pos->pawns;
	bitboard_t black_pawns = pos->black_oc & pos->pawns;
	bitboard_t ep_bb = SQUARE_TO_BB(square);
	bitboard_t on_3 = ep_bb & RANK_3;
	bitboard_t on_6 = ep_bb & RANK_6;
	if (square > H8) {
		return "Illegal en passant Square, {ep} is not a valid Square";
	}
	if (!on_3 && !on_6) {
		return "Illegal en passant Square {ep}, must be on either rank 3 or rank 6";
	}	
	if (board->turn == WHITE_VAL) {
			if (on_3) {
				return "Illegal en passant Square {ep}, must be on rank 6 if it is white's turn";
			}
			if (!(SAFE_BELOW_BB(ep_bb) & black_pawns)) {
				return "Illegal en passant Square {ep}, there is no corresponding black pawn";
			}
	}
	else {	
			if (on_6) {
				return "Illegal en passant Square {ep}, must be on rank 3 if it is black's turn";
			}
			if (!(SAFE_ABOVE_BB(ep_bb) & white_pawns)) {
				return "Illegal en passant Square {ep}, there is no corresponding white pawn";
			}
	}
	set_ep_square(board, square);	
	return 0;
}


void update_castling_rights(full_board_t *board, piece_color_t color) {
    if (color == WHITE_VAL) {
        bitboard_t color_bb = board->position->white_oc;
        bitboard_t king_bb = board->position->kings & color_bb;
        if (!(king_bb & KINGS_STARTING)) {
            board->castling_rights &= ~WHITE_FULL_CASTLING;
            return;
        }
        bitboard_t rook_bb = board->position->rooks & color_bb;
        if (!(rook_bb & (1llu << A1))) {
            board->castling_rights &= ~WHITE_QUEENSIDE;
        }
        if (!(rook_bb & (1llu << H1))) {
            board->castling_rights &= ~WHITE_KINGSIDE;
        }
    }
    else {
        bitboard_t color_bb = board->position->black_oc;
        bitboard_t king_bb = board->position->kings & color_bb;
        if (!(king_bb & KINGS_STARTING)) {
            board->castling_rights &= ~BLACK_FULL_CASTLING;
            return;
        }
        bitboard_t rook_bb = board->position->rooks & color_bb;
        if (!(rook_bb & (1llu << A8))) {
            board->castling_rights &= ~BLACK_QUEENSIDE;
        }
        if (!(rook_bb & (1llu << H8))) {
            board->castling_rights &= ~BLACK_KINGSIDE;
        }
    }
}


void update_all_castling_rights(full_board_t * board) {
    update_castling_rights(board, WHITE_VAL);
    update_castling_rights(board, BLACK_VAL);
}



void fill_board_string(full_board_t *board, char *string_buffer) {
    if (string_buffer) {
        int string_i = 0;
        int i = 0;
        for (bitboard_t rank = RANK_8; i < 8; i++) {
            int j = 0;
            for (bitboard_t file = FILE_A; j < 8; j++) {
                piece_t piece = get_piece_at_bb(board->position, rank & file);
                string_buffer[string_i++] = piece_symbol(piece);
                string_buffer[string_i++] = ' ';
                file = SAFE_RIGHT_BB(file);
            }
            string_buffer[string_i++] = '\n';
            rank = BELOW_BB(rank);
        }
        string_buffer[string_i++] = '\0';
    }
}



void print_board(full_board_t *board) {
    char buffer[255];
    fill_board_string(board, buffer);
    printf("%s\n", buffer);
}


#define PIECE_NOT_MOVED(COLOR, PIECE, ORIGIN)(\
	(pos->COLOR ## _oc & pos->PIECE ## s & SQUARE_TO_BB(ORIGIN))\
)

#define CASTLING_VALID(COLOR, RANK)(\
((!(COLOR##_kingside || COLOR##_queenside) || PIECE_NOT_MOVED(COLOR, king, E##RANK)))\
&& (!COLOR##_kingside || PIECE_NOT_MOVED(COLOR, rook, H##RANK))\
&& (!COLOR##_queenside || PIECE_NOT_MOVED(COLOR, rook, A##RANK))\
)\

bool valid_castling(full_board_t *board, castling_rights_t castling){
	// INVALID IF:
	// - Color has castling rights and king has moved
	// - Color has kingside and no rook on H1/H8
	// - Color has queenside and no rook on A1/A8 
	castling_rights_t white_kingside = castling & WHITE_KINGSIDE;
	castling_rights_t black_kingside = castling & BLACK_KINGSIDE;
	castling_rights_t white_queenside = castling & WHITE_QUEENSIDE;
	castling_rights_t black_queenside = castling & BLACK_QUEENSIDE;	
	position_t *pos = board->position;
	return CASTLING_VALID(white, 1) && CASTLING_VALID(black, 8);
	return true;
}	
	


// ridiculous function, dont know what i was thinking with this mess
char* validate_board(full_board_t * board) {
    /*
    pawns in the back ranks
    no kings
    more than 1 king
    side to move is in check
    */
    position_t * position = board->position;
    if (!position){
       return "Board has no position";
    }
 		if (board->turn != WHITE_VAL && board->turn != BLACK_VAL) {
			return "Board turn is not White or Black";
		}
		if (position->white_oc & position->black_oc) {
			return "Piece color bitboard values are conflicting";
		}
		if (position->bishops & position->knights) {
			return "Knight and bishops bitboard values are conflicting";
		}	
		if (position->rooks & position->queens) {
			return "Rook and queen bitboard values are conflicting";
		}
		if (position->pawns & position->kings) {
			return "Pawn and king bitboard values ares conflicting";
		}
		bitboard_t minor_pieces = position->bishops | position->knights;
		bitboard_t major_pieces = position->rooks | position->queens;
		if (minor_pieces & major_pieces) {
			return "Minor and major piece bitboard values are conflicting";
		}
		bitboard_t non_king_pawn = minor_pieces | major_pieces;
		bitboard_t king_pawn = position->pawns & position->kings;
		if (king_pawn & non_king_pawn){
			return "Piece bitboard values are conflicting";
		}
		if (position->pawns & (RANK_1 | RANK_8)){
            return "Board cannot have pawns on the back ranks";
    }
    bitboard_t white_kings = position->white_oc & position->kings;
    bitboard_t black_kings = position->black_oc & position->kings;
    if (!white_kings || !black_kings){
            return "Board must have a king for both players";
    }
    if (count_bits(white_kings) > 1){
            return "Board cannot have more than 1 white king";
    }
    if (count_bits(black_kings)> 1) {
            return "Board cannot have more than 1 black king";
    }
    bitboard_t white_pawns = position->white_oc & position->pawns;
    bitboard_t black_pawns = position->black_oc & position->pawns; 
    u_int8_t white_pawn_count = count_bits(white_pawns);
		u_int8_t black_pawn_count = count_bits(black_pawns);
		if (white_pawn_count > 8){
            return "Board cannot have more than 8 white pawns";
    }
    if (black_pawn_count > 8){
            return "Board cannot have more than 8 black pawns";
    }
		int8_t white_bishop_count = count_bits(position->white_oc & position->bishops);
		int8_t white_rook_count = count_bits(position->white_oc & position->rooks);
		int8_t white_queen_count = count_bits(position->white_oc & position->queens);
		int8_t white_knight_count = count_bits(position->white_oc & position->knights);
		if (white_bishop_count + white_pawn_count > 10) {
			return "Board cannot have more white bishops than are able to promote";
		}		
		if (white_rook_count + white_pawn_count > 10) {
			return "Board cannot have more white rooks than are able to promote";
		}
		if (white_knight_count + white_pawn_count > 10) {
			return "Board cannot have more white knights than are able to promote";
		}
		if (white_queen_count + white_pawn_count > 9) {
			return "Board cannot have more white queens than are able to promote";
		}
		int8_t black_bishop_count = count_bits(position->black_oc & position->bishops);
		int8_t black_rook_count = count_bits(position->black_oc & position->rooks);
		int8_t black_queen_count = count_bits(position->black_oc & position->queens);
		int8_t black_knight_count = count_bits(position->black_oc & position->knights);
		if (black_bishop_count + black_pawn_count > 10) {
			return "Board cannot have more black bishops than are able to promote";
		}		
		if (black_rook_count + black_pawn_count > 10) {
			return "Board cannot have more black rooks than are able to promote";
		}
		if (black_knight_count + black_pawn_count > 10) {
			return "Board cannot have more black knights than are able to promote";
		}
		if (black_queen_count + black_pawn_count > 9) {
			return "Board cannot have more black queens than are able to promote";
		}

		// TODO: We know bishops are promoted if there is another bishop of the same square color
		// We also know that 7 pawns, 3 rooks, and 3 bishops and similiar cases are illegal 

		castling_rights_t rights = board->castling_rights;
    if (rights) {
      bitboard_t white_king_moved = ~white_kings & SQUARE_TO_BB(E1);
      bitboard_t black_king_moved = ~black_kings & SQUARE_TO_BB(E8);
      castling_rights_t white_rights = rights & WHITE_FULL_CASTLING;
      castling_rights_t black_rights = rights & BLACK_FULL_CASTLING;
      if (white_rights && white_king_moved) {
        if (black_rights && black_king_moved) {
          return "Board castling rights are illegal, neither player can castle";
        }
        else return "Board castling rights are illegal, white cannot castle";
      }
      else {
        if (black_rights && black_king_moved)
          return "Board castling rights are illegal, black cannot castle";
        bitboard_t not_white_rooks = ~(position->rooks & position->white_oc);
        if (white_rights & WHITE_QUEENSIDE && not_white_rooks & SQUARE_TO_BB(A1))  
          return "Board castling rights are illegal, white cannot castle queenside";
        if (white_rights & WHITE_KINGSIDE && not_white_rooks & SQUARE_TO_BB(H1))  
          return "Board castling rights are illegal, white cannot castle kingside";
        bitboard_t not_black_rooks = ~(position->rooks & position->black_oc);
        if (black_rights & BLACK_QUEENSIDE && not_black_rooks & SQUARE_TO_BB(A8))
          return "Board castling rights are illegal, black cannot castle queenside";
        if (black_rights & BLACK_KINGSIDE && not_black_rooks & SQUARE_TO_BB(H8))
          return "Board castling rights are illegal, black cannot castle kingside";
      }
    }
		optional_square_t ep = board->en_passant_square;
    if (ep.exists) {
			bitboard_t ep_bb = SQUARE_TO_BB(ep.square);
			bitboard_t on_3 = ep_bb & RANK_3;
			bitboard_t on_6 = ep_bb & RANK_6;
			if (!on_3 && !on_6) {
				return "Board has illegal en passant square, must be on either rank 3 or rank 6";
			}	
			if (board->turn == WHITE_VAL) {
					if (on_3) {
						return "Board has illegal en passant square, must be on rank 6 if it is white's turn";
					}
					if (!(SAFE_BELOW_BB(ep_bb) & black_pawns)) {
						return "Board has illegal en passant square, there is no corresponding black pawn";
					}
			}
			else {	
					if (on_6) {
						return "Board has illegal en passant square, must be on rank 3 if it is black's turn";
					}
					if (!(SAFE_ABOVE_BB(ep_bb) & white_pawns)) {
						return "Board has illegal en passant square, there is no corresponding white pawn";
					}
			}	
		}
		if (opponent_in_check(board)){
            return "Board has impossible position, the player to move cannot be able to capture the opponent's king.";
    }
    u_int8_t checkers = get_checkers(board);
		if (checkers > 2) {
				return "Board has impossible position, a player cannot be in check from more than 2 attackers.";
		}
		return 0;
}



