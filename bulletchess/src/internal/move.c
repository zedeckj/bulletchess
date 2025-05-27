#include "move.h"
#include <stdarg.h>

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

move_t make_move_from_parts(square_t origin, square_t destination, piece_type_t promote_to) {
	generic_move_t body;
	body.origin = origin;
	body.destination = destination;
	if (promote_to == EMPTY_VAL) {
		return generic_move(body);
	}
	else {
		return promotion_move(body, promote_to);
	}
}

char * ext_construct_move(square_t origin, 
								square_t destination, 
								piece_type_t promote_to, 
								move_t *out_move) {
	if (origin >= 64) return "Origin {origin} is not a valid square";
	if (destination >= 64) return "Destination {destination} is not a valid square";
	*out_move = make_move_from_parts(origin, destination, promote_to);
	return error_from_move(*out_move);	
}

u_int64_t hash_move(move_t move) {
  u_int64_t origin = 0;
  u_int64_t destination = 0;
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


u_int16_t create_all_legal(move_t *moves, u_int64_t *hashes);

move_t unhash_move(u_int64_t move_hash) {
	square_t origin = move_hash >> 16;
	square_t destination = (move_hash & 0xFF00) >> 8;
	piece_type_t promotion = move_hash & 0xFF;
	return make_move_from_parts(origin, destination, promotion);
}

bool moves_equal(move_t move1, move_t move2) {
	switch (move1.type) {
		case PROMOTION_MOVE:
			return move2.type == PROMOTION_MOVE 
						 && move1.promotion.body.origin 
								 == move2.promotion.body.origin
             && move1.promotion.body.destination 
						 		 == move2.promotion.body.destination;
		case GENERIC_MOVE:
 			return move2.type == GENERIC_MOVE 
						 && move1.generic.origin == move2.generic.origin 
						 && move1.generic.destination == move2.generic.destination;
  	case NULL_MOVE:
			return move2.type == NULL_MOVE;
		default:
			return false;
	}
}

bool pointer_moves_equal(move_t *move1, u_int64_t index1, move_t *move2, u_int64_t index2){
	return moves_equal(move1[index1], move2[index2]);
}


bool is_error_move(move_t move) {
    return move.type == ERROR_MOVE;
}

bool is_null_move(move_t move) {
    return move.type == NULL_MOVE;
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



// Checks if the given move specifies castling, not if it is legal
castling_rights_t get_castling_type(move_t move, full_board_t *board) {
	castling_rights_t type; 
	bool for_white;
	if (move.type == GENERIC_MOVE) {
		if (move.generic.origin == E1) {
			for_white = true;
			if (move.generic.destination == G1) type = WHITE_KINGSIDE;
			else if (move.generic.destination == C1) type = WHITE_QUEENSIDE;
			else return NO_CASTLING;
		}
		else if (move.generic.origin == E8) {
			for_white = false;
			if (move.generic.destination == G8) type = BLACK_KINGSIDE;
			else if (move.generic.destination == C8) type = BLACK_QUEENSIDE;
			else return NO_CASTLING;
		}
		else return NO_CASTLING;
	}
	else return NO_CASTLING;
	position_t * pos = board->position;
	bitboard_t friendly_oc = for_white ? pos->white_oc : pos->black_oc;
	bitboard_t friendly_king = friendly_oc & pos->kings;
	if (friendly_king & SQUARE_TO_BB(move.generic.origin)) return type;
	else return NO_CASTLING;
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

#define return_new_err(fmt, ...) { char *out = malloc(strlen(fmt) * 2); if (out) { \
	sprintf(out, fmt, __VA_ARGS__); \
	return out; } return "Invalid Move"; } 


bool pointer_write_uci(move_t *move, u_int64_t index, char * buffer) {
	return write_uci(move[index], buffer);
}	

char * err_promotion_move_with(char origin_file, char origin_rank, char dest_file, char dest_rank) {
			if (dest_rank != '8' && dest_rank != '1'){
				return_new_err("Illegal Move, a promotion's destination must be on a back rank, got %c%c", toupper(dest_file), dest_rank);	
			}
			
			if ((origin_rank == '7' && dest_rank == '8') 
          || (origin_rank == '2' && dest_rank == '1') 
          && (dest_file == origin_file 
              || dest_file == origin_file + 1 
              || dest_file == origin_file - 1)) {
				return 0;
			}
			return_new_err("Illegal Move, %c%c to %c%c is not a legal Pawn move and cannot be a promotion", toupper(origin_file), origin_rank, 
					toupper(dest_file), dest_rank);
} 


char * err_generic_move_with(char origin_file, char origin_rank, char dest_file, char dest_rank) {
    if (dest_file == origin_file) { 
				if (origin_rank != dest_rank) return 0;
				return_new_err("Illegal Move, a Piece cannot "
								"move to the same Square it currently occupies, got %c%c to %c%c", toupper(origin_file), origin_rank, toupper(dest_file), dest_rank);
		}
		if (dest_rank == origin_rank) return 0;
    int8_t dist;
    if ((dist = abs(dest_file - origin_file)) == abs(dest_rank - origin_rank)) return 0; 
    int8_t file_diff = abs(dest_file - origin_file);
    int8_t rank_diff = abs(dest_rank - origin_rank);
    if ((file_diff == 1 && rank_diff == 2) || (file_diff == 2 && rank_diff == 1))
			return 0; 
		return_new_err("Illegal Move, %c%c to %c%c is illegal for every Piece", toupper(origin_file), origin_rank, toupper(dest_file), dest_rank); 
}

char * err_generic_move(generic_move_t move) {
	char dest_file = file_char_of_square(move.destination);
	char dest_rank = rank_char_of_square(move.destination);
	char origin_file = file_char_of_square(move.origin);
	char origin_rank = rank_char_of_square(move.origin);
	return err_generic_move_with(origin_file, origin_rank, dest_file, dest_rank);
}

char * err_promotion_move(promotion_move_t move) {
	piece_type_t pro = move.promote_to;
	switch (pro) {
			case QUEEN_VAL:
			case KNIGHT_VAL:
			case ROOK_VAL:
			case BISHOP_VAL: {
				char dest_file = file_char_of_square(move.body.destination);
				char dest_rank = rank_char_of_square(move.body.destination);
				char origin_file = file_char_of_square(move.body.origin);
				char origin_rank = rank_char_of_square(move.body.origin);
			return err_promotion_move_with(origin_file, origin_rank, dest_file, dest_rank);
			}
			default:
			return_new_err("Illegal Move, a Pawn cannot promote to a %s", get_piece_name(pro));
}	
}

char *error_from_move(move_t move) {
	switch(move.type) {
		case GENERIC_MOVE: 
		return err_generic_move(move.generic);
		case PROMOTION_MOVE: {
			char *err = err_promotion_move(move.promotion);
			if (err) return err;
			return err_generic_move(move.promotion.body);
		}
		case NULL_MOVE:
		return 0;
		default:
		return_new_err("Unknown move type%s", "");		
	}
}

char *parse_uci(char * str, move_t *move) {
		if (!str) return_new_err("Invalid UCI:" 
				" Cannot parse empty string%s", "");
		bool all_zero = true;
    if (strlen(str) < 4)
	  	return_new_err("Invalid UCI: " 
				"UCI must be at least 4 characters long, got '%s'", str)
		for (int i = 0; i < 4; i++) {
       if (str[i] != '0') {
            all_zero = false;
            break;
        }
    }
    if (all_zero) {
			if (str[4]) 
				return_new_err("Invalid UCI: A Null move is specified "
						"as only '0000', got '%s'", str)
			else {
				*move = null_move();
				return 0;
			}
		}
		bool first_valid;
		if (((first_valid = valid_square_chars(str[0], str[1]))) && 
        valid_square_chars(str[2], str[3])) {
						if (!str[4] || isspace(str[4])) {
              char * err;
							if (!(err = err_generic_move_with(str[0], str[1], str[2], str[3]))){
                move_t gen = generic_move(
                        move_body(
                            make_square(str[0], str[1]), 
                            make_square(str[2], str[3])));
								*move = gen;
								return 0;
              }
							else return err;
            }
						else if (!str[5] || isspace(str[5])){
                char c = tolower(str[4]);
                piece_type_t promote_to;
                switch (c) {
                    case 'q': promote_to = QUEEN_VAL;
                    break;
                    case 'n': promote_to = KNIGHT_VAL;
                    break;
                    case 'b': promote_to = BISHOP_VAL;
                    break;
                    case 'r': promote_to = ROOK_VAL;
                    break;
										case 'p': 
                    return_new_err("Invalid UCI: Cannot promote to a Pawn, got '%s'", str); 
										case 'k': 
                    return_new_err("Invalid UCI: Cannot promote to a King, got '%s'", str); 
										default:
                		return_new_err("Invalid UCI: Unrecognized promote-to character %c in '%s'", c, str);
								}
								char *err;
								if (!(err = err_promotion_move_with(str[0], 
														str[1], str[2], str[3]))) {
									move_t pro = promotion_move(
                    move_body(
                        make_square(str[0], str[1]), 
                        make_square(str[2], str[3])),
                      promote_to);
									*move = pro;
									return 0;
               }
							 else return err;
						}
						else return_new_err("Invalid UCI: Given string is too long, expected at most 5 characters, got '%s'", str);
    }
		else {
			if (!first_valid)	{
				return_new_err("Invalid UCI: Invalid origin square %c%c in '%s'", str[0], str[1], str);
			}
			else return_new_err("Invalid UCI: Invalid destination square %c%c in '%s'", str[2], str[3], str);
		}
}

piece_type_t san_parse_piece_type(char symbol) {
	switch(symbol) {
			case 'B': return BISHOP_VAL;
			case 'N': return KNIGHT_VAL;
			case 'R': return ROOK_VAL;
			case 'Q': return QUEEN_VAL;
			case 'K': return KING_VAL;
			default: return EMPTY_VAL;
	}
}

optional_u_int8_t san_parse_file(char symbol) {
	optional_u_int8_t res;
	if (symbol >= 'a' && symbol <= 'h') {
		res.exists = true;
		res.value = symbol - 'a';
	}
	else {
		res.exists = false;
	}
	return res;
}

optional_u_int8_t san_parse_rank(char symbol) {
	optional_u_int8_t res;
	if (symbol >= '1' && symbol <= '8') {
		res.exists = true;
		res.value = symbol - '1';
	}
	else {
		res.exists = false;
	}
	return res;
}


u_int8_t parse_ann_helper(char * str, 
													u_int8_t q_res, 
													u_int8_t e_res,
													u_int8_t null_res) {
	if (str[0] && str[1]) return ERROR_ANN;
	switch(str[0]) {
		case 0:
		return null_res;
		case '?':
		return q_res;
		case '!':
		return e_res;
		default:
		return ERROR_ANN;
	}
}

u_int8_t parse_ann(char * str){
	switch (str[0]) {
		case 0:
		return NO_ANN;
		case '?':
		return parse_ann_helper(str + 1, BLUNDER_ANN, DUBIOUS_ANN, MISTAKE_ANN);	
		case '!':
		return parse_ann_helper(str + 1, INTEREST_ANN, BRILLIANT_ANN, GOOD_ANN);
		default:
		return ERROR_ANN;
	}
	return ERROR_ANN;
}

//returns the length of the parsed status
u_int8_t parse_san_status(char * str, u_int8_t *status) {
	if (str) {
		switch (str[0]) {
			case '#':
			*status = SAN_CHECKMATE;
			return 1;
			case '+':
			if (str[1] == '+'){
				*status = SAN_CHECKMATE;
				return 2;
			}
			else {
				*status = SAN_CHECK;
				return 1;
			}
			default:
			*status = SAN_NOCHECK;
			return 0;
		}
}
	*status = SAN_NOCHECK;
	return 0;
}



san_move_t parse_pawn_capture_san(char * str){
	optional_u_int8_t maybe_file = san_parse_file(str[0]);
	if (maybe_file.exists) {
		optional_u_int8_t maybe_rank = san_parse_rank(str[1]);
		//can have no rank
		u_int8_t x_off;
		if (maybe_rank.exists && str[2]) x_off = 2;
		else x_off = 1;
		if (str[x_off] == 'x' && str[x_off + 1] && str[x_off + 2]) {
			optional_square_t maybe_dest = parse_square(str + x_off + 1);
			if (maybe_dest.exists) {
				piece_type_t promote_to;
				u_int8_t index = x_off;
				if (str[x_off + 3] == '=') {
						promote_to = san_parse_piece_type(str[x_off + 4]);

					if (promote_to == EMPTY_VAL) goto err;
					index += 5;	
				}
				else {
					promote_to = san_parse_piece_type(str[x_off + 3]);
					index = x_off + (promote_to == EMPTY_VAL ? 3 : 4);
				}

				u_int8_t status;
				index += parse_san_status(str + index, &status);	
				u_int8_t ann = parse_ann(str + index);
				if (ann == ERROR_ANN) goto err;
				san_move_t san;
				san.type = SAN_PAWN_CAPTURE;
				san.pawn_capture.from_file = maybe_file.value;
				san.pawn_capture.from_rank = maybe_rank;
				san.pawn_capture.destination = maybe_dest.square;
				san.pawn_capture.promote_to = promote_to;
				san.ann_type = ann;
				san.check_status = status;
				return san;	
			}	
		}
	}
	err: {
		san_move_t e;
		e.type = SAN_ERR;
		return e;
	}	
}

san_move_t parse_pawn_push_san(char * str) {
	optional_square_t maybe_dest = parse_square(str);
	if (maybe_dest.exists) {
		san_move_t san;
		san.type = SAN_PAWN_PUSH; 
		san.pawn_push.destination = maybe_dest.square;
		u_int8_t end;
		if (str[2] == '=') {
			san.pawn_push.promote_to = san_parse_piece_type(str[3]);	
			if (san.pawn_push.promote_to == EMPTY_VAL) goto err;
			end = 4;
		}	
		else {
			san.pawn_push.promote_to = san_parse_piece_type(str[2]);	
			if (san.pawn_push.promote_to != EMPTY_VAL) end = 3;
			else end = 2;
		}
		u_int8_t status;
		end += parse_san_status(str + end, &status);
		san.check_status = status;
		san.ann_type = parse_ann(str + end);
		if (san.ann_type == ERROR_ANN) goto err;  
		return san;
	}
	err: {
		san_move_t err;
		err.type = SAN_ERR;
		return err;
	}
}

san_move_t parse_pawn_san(char * str) {
	if (str[1]) {
		if (str[1] == 'x' || str[2] == 'x') return parse_pawn_capture_san(str);
		return parse_pawn_push_san(str); 
	}
	san_move_t err;
	err.type = SAN_ERR;
	return err;
}


san_move_t parse_std_san(char * str, piece_type_t type) {
	if (str[1] && str[2]) { // must be at least length 3
		san_move_t san;
		san.type = SAN_STD;
		if (str[1] == 'x'){ // no origin capture 
			san.std_move.is_capture = true;
			san.std_move.from_file.exists = false;
			san.std_move.from_rank.exists = false;
			san.std_move.moving_piece = type;
			optional_square_t destination = parse_square(str + 2);
			if (!destination.exists) goto err;
			san.std_move.destination = destination.square;
			u_int8_t index = 4;
			u_int8_t status;
			index += parse_san_status(str + index, &status);
			san.check_status = status;
			san.ann_type = parse_ann(str + index);
			return san;
		}
		else if (str[2] == 'x') { // one specifier capture
			san.std_move.is_capture = true;
			optional_u_int8_t file = san_parse_file(str[1]);
			optional_u_int8_t rank = san_parse_rank(str[1]);
			if (!file.exists && !rank.exists) goto err;
			san.std_move.from_file = file;
			san.std_move.from_rank = rank;
			san.std_move.moving_piece = type;
			optional_square_t destination = parse_square(str + 3);
			if (!destination.exists) goto err;
			san.std_move.destination = destination.square; 
			u_int8_t index = 5;
			u_int8_t status;
			index += parse_san_status(str + index, &status);
			san.check_status = status;
			san.ann_type = parse_ann(str + index);  
			return san;
		}	
		else if (str[3] && str[3] == 'x') { // full origin capture
			optional_u_int8_t file = san_parse_file(str[1]);
			optional_u_int8_t rank = san_parse_rank(str[2]);
			if (!file.exists || !rank.exists) goto err;
			san.std_move.is_capture = true;	
			san.std_move.from_file = file;
			san.std_move.from_rank = rank;
			san.std_move.moving_piece = type;
			optional_square_t destination = parse_square(str + 4);
			if (!destination.exists) goto err;
			san.std_move.destination = destination.square; 
			u_int8_t index = 6;
			u_int8_t status;
			index += parse_san_status(str + index, &status);
			san.check_status = status;
			san.ann_type = parse_ann(str + index);  
			return san;
		}
		else {
			u_int8_t index = 1;
			optional_u_int8_t file;
			optional_u_int8_t rank;
			file = san_parse_file(str[index]);
			if (file.exists) index ++;
			rank = san_parse_rank(str[index]);
			if (rank.exists) index ++;
			
			optional_square_t dest = parse_square(str + index);
			if (!dest.exists) {
				if (file.exists && rank.exists && !isdigit(str[3])) {
					 
					dest = parse_square(str + 1);
					if (!dest.exists) goto err;
					file.exists = false;
					rank.exists = false;
				}
				else goto err;
			}
			else index += 2;
			san.std_move.is_capture = false;	
			san.std_move.from_file = file;
			san.std_move.from_rank = rank;
			san.std_move.destination = dest.square;
			san.std_move.moving_piece = type;
			u_int8_t status;
			index += parse_san_status(str + index, &status);
			san.check_status = status;	
			san.ann_type = parse_ann(str + index);
			return san;
		}
	}
	err: return error_san(); 
}

/*
san_move_t parse_std_san_old(char * str, piece_type_t type){
	if (str[1] && str[2]) {
		optional_u_int8_t maybe_file;
		optional_u_int8_t maybe_rank;
		optional_square_t destination;
		destination.exists = false;
		maybe_file.exists = false;
		maybe_rank.exists = false;
		bool is_capture;
		optional_square_t origin = parse_square(str + 1);
		u_int8_t index = 2;
		if (!origin.exists){ 
			maybe_file = san_parse_file(str[1]);
			if (!maybe_file.exists) {
				maybe_rank = san_parse_rank(str[1]); 
				if (!maybe_rank.exists) goto err;
			}
		}
		else {
			index = 3;
		}
		if (str[index] == 'x') { 
				is_capture = true;
				++index;
				destination = parse_square(str + index);
				if (!destination.exists) goto err;		
				index += 2;
		}
		else {
			is_capture = false;
			destination = parse_square(str + index);
			if (!destination.exists){
					if (origin.exists) {
						destination = origin;
						origin.exists = false;
					}
					else goto err;
			}
			else index += 2;

		}
		san_move_t san;
		san.type = SAN_STD;
		san.std_move.moving_piece = type;
		san.std_move.from_file = maybe_file;
		san.std_move.from_rank = maybe_rank;
		san.std_move.is_capture = is_capture;
		san.std_move.destination = destination.square;
		san.ann_type = parse_ann(str + index);
		if (san.ann_type == ERROR_ANN) goto err;
		return san;
	}
	err: {
		san_move_t err;
		err.type = SAN_ERR;
		return err;
	}
}
*/
/*
<SAN move descriptor piece moves>   
	::= <Piece symbol>[<from file>|<from rank>|<from square>]['x']<to square>
<SAN move descriptor pawn captures> 
	::= <from file>[<from rank>] 'x' <to square>[<promoted to>]
<SAN move descriptor pawn push>     
	::= <to square>[<promoted to>]
*/

san_move_t parse_castling_san(char * str) {
	san_move_t san;
	san.type = SAN_CASTLING;
	if (strlen(str) > 2) {
		if (strlen(str) > 4 && !strncmp(str, "O-O-O", 5)) {
			san.castling_kingside = false;
			return san;
		}
		else if (!strncmp(str, "O-O", 3)) {
			san.castling_kingside = true;	
			return san;	
		}	
	}
	san_move_t err;
	err.type = SAN_ERR;
	return err;
}

san_move_t parse_san_inner(char *str){
	if (str && str[0]) {
		if (str[0] == 'O') return parse_castling_san(str);
		piece_type_t type = san_parse_piece_type(str[0]);
		if (type == EMPTY_VAL) return parse_pawn_san(str);
		return parse_std_san(str, type);
	}			
	san_move_t san;
	san.type = SAN_ERR;
	return san;	
}

san_move_t parse_san(char *str, bool *err) {
	san_move_t san = parse_san_inner(str);
	*err = san.type == SAN_ERR;
	return san;
}


bool is_san_correct(char *str) {
	bool out;
	parse_san(str, &out);
	return !out;
}

bool write_san_ann(u_int8_t ann, char * buffer) {
	switch (ann) {
		case NO_ANN:
		buffer[0] = 0;
		break;
		case BLUNDER_ANN:
		buffer[0] = '?';
		buffer[1] = '?';
		buffer[2] = 0;
		break;
		case MISTAKE_ANN:
		buffer[0] = '?';
		buffer[1] = 0;
		break;
		case DUBIOUS_ANN:
		buffer[0] = '?';
		buffer[1] = '!';
		buffer[2] = 0;
		break;
		case INTEREST_ANN:
		buffer[0] = '!';
		buffer[1] = '?';
		buffer[2] = 0;
		break;
		case GOOD_ANN:
		buffer[0] = '!';
		buffer[1] = 0;
		break;
		case BRILLIANT_ANN:
		buffer[0] = '!';
		buffer[1] = '!';
		buffer[2] = 0;
		break;
		default:
		return false;
	}
	return true;
}

int8_t write_san_promotion(piece_type_t type, char * buffer) {
	switch(type) {
			case EMPTY_VAL:
			return 0;
			case QUEEN_VAL:
			buffer[0] = 'Q';
			return 1;
			case KNIGHT_VAL:
			buffer[0] = 'N';
			return 1;
			case BISHOP_VAL:
			buffer[0] = 'B';
			return 1;
			case ROOK_VAL:
			buffer[0] = 'R';
			return 1;
			default:
		 	return -1;
	}
}



// basically identical, but with a different ordering
int8_t write_san_piece(piece_type_t type, char * buffer) {
	switch(type) {
			case KNIGHT_VAL:
			buffer[0] = 'N';
			return 1;
			case BISHOP_VAL:
			buffer[0] = 'B';
			return 1;
			case ROOK_VAL:
			buffer[0] = 'R';
			return 1;
			case QUEEN_VAL:
			buffer[0] = 'Q';
			return 1;
			case KING_VAL:
			buffer[0] = 'K';
			return 1;
			default:
		 	return -1;
	}
}

int8_t write_san_pawn_push(san_pawn_push_t push, char * buffer) {
	if (serialize_square(push.destination, buffer)) { 
		int8_t offset = 2;
		int8_t inc = write_san_promotion(push.promote_to, buffer + offset);
		if (inc == -1) return offset;
		return offset+inc;
	}
	return -1;
}

int8_t write_san_pawn_capture(san_pawn_capture_t capt, char * buffer){
	if (buffer) {
		buffer[0] = capt.from_file + 'a';
		u_int8_t index = 1;
		if (capt.from_rank.exists) {
			buffer[index++] = capt.from_rank.value + '1';
		}
		buffer[index++] = 'x';
		serialize_square(capt.destination, buffer + index);
		index += 2;
	  int8_t inc = write_san_promotion(capt.promote_to, buffer + index);
		if (inc == -1) return index;
		return index + inc;
	}
	return -1;	
}


int8_t write_san_std_move(san_std_move_t move, char * buffer) {
	if (buffer) {
		if (write_san_piece(move.moving_piece, buffer)) {
			int8_t index = 1;
			if (move.from_file.exists) buffer[index++] = move.from_file.value + 'a';
			if (move.from_rank.exists) buffer[index++] = move.from_rank.value + '1';
			if (move.is_capture) buffer[index++] = 'x';
			serialize_square(move.destination, buffer + index);
			return index + 2;
		}	
	}
	return -1;
}

int8_t write_san_castling(bool kingside, char * buffer) {
	if (kingside) {
		strcpy(buffer, "O-O");
		return 3;
	}
	else {
		strcpy(buffer, "O-O-O");
		return 5;
	}
}

int8_t write_san_check_status(san_move_t move, char * buffer) {
	switch (move.check_status) {
		case SAN_NOCHECK:
		return 0;
		case SAN_CHECK:
		*buffer = '+';
		return 1;
		case SAN_CHECKMATE:
		*buffer = '#';
		return 1;
		default:
		return -1;
	}
}


bool write_san(san_move_t move, char * buffer) {
	int8_t index;
	switch (move.type) {
		case SAN_STD: 
		index = write_san_std_move(move.std_move, buffer);
		break;
		case SAN_PAWN_PUSH: 
		index = write_san_pawn_push(move.pawn_push, buffer);
		break;
		case SAN_PAWN_CAPTURE: 
		index = write_san_pawn_capture(move.pawn_capture, buffer);	
		break;
		case SAN_CASTLING:
		index = write_san_castling(move.castling_kingside, buffer); 
		break;
		default: return false;
	}

	if (index == -1) return false;
	int8_t add_i = write_san_check_status(move, buffer + index);
	if (add_i == -1) return false;
	return write_san_ann(move.ann_type, buffer + index + add_i);
}

bool roundtrip_san(char * in_san, char * out_buffer) {
	bool err;
	san_move_t san = parse_san(in_san, &err);
	return write_san(san, out_buffer);
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
  return body.destination;
}

piece_type_t get_promotes_to(move_t move) {
	if (move.type != PROMOTION_MOVE) return EMPTY_VAL;
	return move.promotion.promote_to;
}

bool is_promotion(move_t move){
  return move.type == PROMOTION_MOVE;
}


piece_index_t promotes_to(move_t move) {
  if (move.type != PROMOTION_MOVE) return piece_to_index(empty_piece());
  piece_t out;
  out.type = move.promotion.promote_to; 
  out.color = move.promotion.body.destination & RANK_8 ? WHITE_VAL : BLACK_VAL;
  return piece_to_index(out);
}

san_move_t error_san(){
	san_move_t err;
	err.type = SAN_ERR;
	return err;
}

