#include "fen.h"

#define NUMCASES(digit) case 10 * digit + 0: case 10 * digit + 1: \
				case 10 * digit + 2: case 10 * digit + 3: case 10 * digit + 4: \
				case 10 * digit + 5: case 10 * digit + 6: case 10 * digit + 7: \
				case 10 * digit + 8: case 10 * digit + 9


square_t fen_index_to_square(u_int8_t index) {
    return (square_t)(8 * (7 - index/8) + (index % 8)); 
}



int use_empties(char * fen_buffer, int empties, int index) {
    if (empties > 0) {
        fen_buffer[index] = '0' + empties;
        return index + 1;
    }
    return index;
}


int write_num(char * buffer, int offset, int num) {
	return offset + sprintf(buffer + offset, "%d", num);
}

/*
int write_num(char * buffer, int offset, int num) {
    switch (num) {
			NUMCASES(0):
				buffer[offset++] = num + '0';
				return offset;
			NUMCASES(1):
				buffer[offset++] = '1';
				buffer[offset++] = (num % 10)+ '0';
				return offset;
			NUMCASES(2):
				buffer[offset++] = '2';
				buffer[offset++] = (num % 10)+ '0';
				return offset;
			NUMCASES(3):
				buffer[offset++] = '3';
				buffer[offset++] = (num % 10)+ '0';
				return offset;
			NUMCASES(4):
				buffer[offset++] = '4';
				buffer[offset++] = (num % 10)+ '0';
				return offset;
			NUMCASES(5):
				buffer[offset++] = '5';
				buffer[offset++] = (num % 10)+ '0';
				return offset;
			NUMCASES(6):
				buffer[offset++] = '6';
				buffer[offset++] = (num % 10)+ '0';
				return offset;
			NUMCASES(7):
				buffer[offset++] = '7';
				buffer[offset++] = (num % 10)+ '0';
				return offset;
			NUMCASES(8):
				buffer[offset++] = '8';
				buffer[offset++] = (num % 10)+ '0';
				return offset;
			NUMCASES(9):
				buffer[offset++] = '9';
				buffer[offset++] = (num % 10)+ '0';
				return offset;
		}
    int digits = (int)log10(num);
    for (int i = 0; i <= digits; i++) {
        char c = ((int)(num / pow(10,i)) % 10) + '0';
        buffer[offset + digits - i] = c;
    }
    return offset + digits + 1;
}
*/


/*
char * parse_position_new(char * str, 
								position_t *position, piece_index_t *index_array){

	if (!str) return "No position specified";
	for (u_int8_t i = 0; str[i]; i++) {
		switch (str[i]) {
			case '/':
			//
			case '1': case '2': case '3': case '4': 
			case '5': case '6': case '7': case '8':
			//
			case 'p':

			case 'P':

			case 'n':

			case 'N':

			case 'b':

			case 'B':

			case 'r':

			case 'R':

			case 'q':

			case 'Q':

			case 'k':

			case 'K':
			return "not implemented";
		}
	}
}*/

char * parse_position(char * str, position_t * position) {
		if (!str) return "No position specified";
    u_int8_t rank = 0;
    u_int8_t file = 0;
    u_int8_t index = 0;
    bitboard_t pawns = 0;
    bitboard_t knights = 0;
    bitboard_t bishops = 0;
    bitboard_t rooks = 0;
    bitboard_t queens = 0;
    bitboard_t kings = 0;
    bitboard_t white_oc = 0;
    bitboard_t black_oc = 0;
    for (u_int8_t i = 0; str[i]; i++) {
        if (file == 8) {
            if (str[i] != '/') return "Position has too many squares in a rank";
            
            else {
                file = 0;
                ++rank; 
            }
        }
        else {
						switch (str[i]) {
							case '1': case '2': case '3': case '4': case '5': case '6': case '7': case '8': {
                u_int8_t count = str[i] - '0';
								file += count;
                index += count;
								break;
							}
							default: {
								square_t square = fen_index_to_square(index);
                bitboard_t square_bb = SQUARE_TO_BB(square);
                char lower = tolower(str[i]);
								piece_index_t piece_index;
                switch (lower) {
                    
										case 'p':
                    pawns |= square_bb;
										piece_index = PAWN_INDEX;
                    break;
                    case 'n':
                    knights |= square_bb;
										piece_index = KNIGHT_INDEX;
                    break;
                    case 'b':
                    bishops |= square_bb;
										piece_index = BISHOP_INDEX;
                    break;
                    case 'r':
                    rooks |= square_bb;
										piece_index = ROOK_INDEX;
                    break;
                    case 'q':
                    queens |= square_bb;
										piece_index = QUEEN_INDEX;
                    break;
                    case 'k':
                    kings |= square_bb;
										piece_index = KING_INDEX;
                    break;
                    default:
                    return "Position has unknown character";
                }
                if (lower != str[i]) white_oc |= square_bb;
                else {
										black_oc |= square_bb;
										piece_index += BLACK_OFFSET;
								}
                ++file;
                ++index;
 
							}
						}
        }
 
    }
    if (rank > 7) return "Position has too many ranks";
		if (rank < 7 || file < 8) return "Position does not describe entire board";
    position->pawns = pawns;
    position->knights = knights;
    position->bishops = bishops;
    position->rooks = rooks;
    position->queens = queens;
    position->kings = kings;
    position->white_oc = white_oc;
    position->black_oc = black_oc;
    return 0;
}

char * parse_turn(char * str, piece_color_t * color) {

		if (!str) return "No turn specified";
    if (str[0]) {
        if (!str[1]) {
            if (str[0] == 'w') {
                *color = WHITE_VAL;
                return 0;
            }
            else if (str[0] == 'b'){ 
                *color = BLACK_VAL;
                return 0;
            }
            else if (str[0] == 'B' || str[0] == 'W'){
              return "Turn must be specified in lowercase";
            }
            else {
                return "Turn is not 'w' or 'b'";
            }
        }
        else {
            return "Length of turn is greater than one character";
        }
    } else {
        return "No turn specified";
    }
}

char *parse_castling(char * str, castling_rights_t * castling) {
		if (!str || !str[0]) return "No castling rights specified";
    *castling = 0;
    if (str[0] == '-' && str[1] == '\0') {
        return 0;
    }
    int a = 0;       
    int i = 0;
    for (; i < 4; i++) {
						switch (str[i]) {
							case 'K':
								switch (a) {
									case 1:
									return "Invalid castling rights, 'K' cannot be specified twice";
									case 0:
									*castling |= WHITE_KINGSIDE;
                	a = 1;
									break;
									default:
                	return "Invalid castling rights, 'K' cannot be specified after 'Q', 'k', or 'q'";
								}
								break;
							case 'Q':
								switch (a) {
									case 2: 
									return "Invalid castling rights, 'Q' cannot be specified twice";
									case 0: case 1:
									*castling |= WHITE_QUEENSIDE;
                	a = 2;
									break; 
                  default: 
									return "Invalid castling rights, 'Q' cannot be specified after 'k' or 'q'";

								}
								break;
							case 'k': 
								switch (a) {
									case 3:
                	return "Invalid castling rights, 'k' cannot be specified twice";
									case 2: case 1: case 0:
                	*castling |= BLACK_KINGSIDE;
                	a = 3;
									break;	
									default:
                	return "Invalid castling rights, 'k' cannot be specified after 'q'";
								}
								break;
							case 'q': 
								switch(a) {
									case 4:
                	return "Invalid castling rights, 'q' cannot be specified twice";
									default:
                	*castling |= BLACK_QUEENSIDE;
                	a = 4;
								}
								break;
							case 0:
								return 0;
							default:
							return "Invalid castling rights, unknown character";
						}
		}
		if (!str[i]) {
    	return 0;
    } 
    return "Invalid castling rights, too many characters";
}



char * parse_ep_square(char * str, optional_square_t * ep) {
    
		if (!str || !str[0]) return "Missing en-passant square";
    if (str[0] == '-' && str[1] == '\0') {
        ep->exists = false;
        ep->square = EMPTY_EP;
        return 0;
    }
    else if (str[0] && str[1] && !str[2]) {
        if (valid_square_chars(str[0], str[1])) {
            ep->exists = true;
            ep->square = make_square(str[0], str[1]);
            return 0;
        }
        return "Invalid en-passant square";
    }
    else return "Invalid en-passant square";
}




char *parse_clock_forced(char * str, turn_clock_t * clock, char * missing) {
		if (!str || !str[0]) {
			return missing;
		}
    if (str[0]) {
        for (int i = 0; str[i]; i++) {
						if (!isdigit(str[i])) {
							return "Clock includes a non-digit";
            }
        }
        int parsed = atoi(str);
        if (parsed < UINT64_MAX) {
            *clock = parsed;
            return 0;
        }
    }
    return "Empty clock";
}

char *parse_clock(char * str, turn_clock_t * clock, 
		turn_clock_t def, char *msg) {
    if (str && str[0]) {
        for (int i = 0; str[i]; i++) {
						if (!isdigit(str[i])) {
							return msg;
            }
        }
        int parsed = atoi(str);
        if (parsed < UINT64_MAX) {
            *clock = parsed;
            return 0;
        }
    }
		*clock = def;
		return 0;
}

char *parse_halfmove(char * str, turn_clock_t *clock) {
	//return parse_clock(str, clock, "Missing halfmove clock");
	return parse_clock(str, clock, 0, "Halfmove clock includes a non-digit"); 
}

char *parse_fullmove(char *str, turn_clock_t *clock) {
	//return parse_clock(str, clock, "Missing fullmove timer");
	return parse_clock(str, clock, 1, "Fullmove timer includes a non-digit"); 
}




// Fills out a board from parsing the given FEN. 
// Returns boolean of if parsing was a success
char * parse_fen(const char *fen_input, full_board_t * board) {
		if (!fen_input) return "Empty FEN";
		char fen[200];
		strcpy(fen, fen_input);	
    char *rest = 0;
    char * error = parse_position(strtok_r(fen, " ", &rest), board->position);
    
		if (error) return error;
    error = parse_turn(strtok_r(0, " ", &rest), &(board->turn));
    if (error) return error;
    error = parse_castling(strtok_r(0, " ", &rest), &(board->castling_rights));
    if (error) return error;    
    error = parse_ep_square(strtok_r(0, " ", &rest), &(board->en_passant_square));
		if (error) return error;
		error = parse_halfmove(strtok_r(0, " ", &rest), &(board->halfmove_clock));
    if (error) return error;
    error = parse_fullmove(strtok_r(0, " ", &rest), &(board->fullmove_number));
    if (error) return error;
    if (strtok_r(0, " ", &rest)) return "FEN has too many terms";
    return 0;
}


/*
char * parse_fen_array(char ** fens, full_board_t *boards, u_int64_t count) {
	char * error;
	for (int i = 0; i < count; i++) {
		error = parse_fen(fens[i], boards[i]);
		if (error) return error;
	}
	return 0;
}
*/



// massive switch case to minimize branching
char *castling_fen(castling_rights_t castling) {
	switch (castling) {
		case NO_CASTLING: return "-";
		case FULL_CASTLING: return "KQkq";
		case WHITE_FULL_CASTLING: return "KQ";
		case BLACK_FULL_CASTLING: return "kq";
		case WHITE_FULL_CASTLING | BLACK_QUEENSIDE: return "KQq";
		case WHITE_FULL_CASTLING | BLACK_KINGSIDE: return "KQk";
		case BLACK_FULL_CASTLING | WHITE_QUEENSIDE: return "Qkq";
		case BLACK_FULL_CASTLING | WHITE_KINGSIDE: return "Kkq";
		case WHITE_KINGSIDE | BLACK_KINGSIDE: return "Kk";
		case WHITE_QUEENSIDE | BLACK_QUEENSIDE: return "Qq";
		case WHITE_KINGSIDE | BLACK_QUEENSIDE: return "Kq";
		case WHITE_QUEENSIDE | BLACK_KINGSIDE: return "Qk";
		case WHITE_KINGSIDE: return "K";
		case WHITE_QUEENSIDE: return "Q";
		case BLACK_KINGSIDE: return "k";
		case BLACK_QUEENSIDE: return "q";
	}
	return 0;
}





// massive switch case to minimize branching
u_int8_t write_castling(castling_rights_t castling, char *fen_buffer, 
								u_int8_t s_i) {
	switch (castling) {
		case NO_CASTLING: {
    	fen_buffer[s_i++] = '-';
			break;
		}
		case FULL_CASTLING: {
			fen_buffer[s_i++] = 'K';
			fen_buffer[s_i++] = 'Q';
			fen_buffer[s_i++] = 'k';
			fen_buffer[s_i++] = 'q';
			break;
		}
		case WHITE_FULL_CASTLING: {
			fen_buffer[s_i++] = 'K';
			fen_buffer[s_i++] = 'Q';
			break;
		}
		case BLACK_FULL_CASTLING: {
			fen_buffer[s_i++] = 'k';
			fen_buffer[s_i++] = 'q';
			break;
		}
		case WHITE_FULL_CASTLING | BLACK_QUEENSIDE: {
			fen_buffer[s_i++] = 'K';
			fen_buffer[s_i++] = 'Q';
			fen_buffer[s_i++] = 'q';
			break;
		}
		case WHITE_FULL_CASTLING | BLACK_KINGSIDE: {
			fen_buffer[s_i++] = 'K';
			fen_buffer[s_i++] = 'Q';
			fen_buffer[s_i++] = 'k';
			break;
		}	case BLACK_FULL_CASTLING | WHITE_QUEENSIDE: {
			fen_buffer[s_i++] = 'Q';
			fen_buffer[s_i++] = 'k';
			fen_buffer[s_i++] = 'q';
			break;
		}	case BLACK_FULL_CASTLING | WHITE_KINGSIDE: {
			fen_buffer[s_i++] = 'K';
			fen_buffer[s_i++] = 'k';
			fen_buffer[s_i++] = 'q';
			break;
		}	case WHITE_KINGSIDE | BLACK_KINGSIDE: {
			fen_buffer[s_i++] = 'K';
			fen_buffer[s_i++] = 'k';
			break;
		}	case WHITE_QUEENSIDE | BLACK_QUEENSIDE: {
			fen_buffer[s_i++] = 'Q';
			fen_buffer[s_i++] = 'q';
			break;
		}	case WHITE_KINGSIDE | BLACK_QUEENSIDE: {
			fen_buffer[s_i++] = 'K';
			fen_buffer[s_i++] = 'q';
			break;
		}	case WHITE_QUEENSIDE | BLACK_KINGSIDE: {
			fen_buffer[s_i++] = 'Q';
			fen_buffer[s_i++] = 'k';
			break;
		}	case WHITE_KINGSIDE: {
			fen_buffer[s_i++] = 'K';
			break;
		}	case WHITE_QUEENSIDE: {
			fen_buffer[s_i++] = 'Q';
			break;
		}	case BLACK_KINGSIDE: {
			fen_buffer[s_i++] = 'k';
			break;
		}	case BLACK_QUEENSIDE: {
			fen_buffer[s_i++] = 'q';
			break;
		}
	}
	return s_i;
}

u_int8_t make_fen(full_board_t *board, char *fen_buffer) {
	if (!fen_buffer) return 0;
	int s_i = 0;
	int empties = 0;
	for (u_int8_t index = 0; index < 64; index++) {
		square_t square = fen_index_to_square(index);
		bitboard_t bb = SQUARE_TO_BB(square);
		position_t *pos = board->position;
		bool is_white;
    if ((index && (index % 8) == 0)) {
    	s_i = use_empties(fen_buffer, empties, s_i);
      empties = 0;
      fen_buffer[s_i++] = '/';
    }
		if (!(is_white = bb & pos->white_oc)) {
			if (!(bb & pos->black_oc)) {
				empties += 1;
				continue;
			}
		}
    s_i = use_empties(fen_buffer, empties, s_i);
    empties = 0;
		s_i = use_empties(fen_buffer, empties, s_i);
		if (pos->pawns & bb) fen_buffer[s_i++] = is_white ? 'P' : 'p';
		else if (pos->bishops & bb) fen_buffer[s_i++] = is_white ? 'B' : 'b';
		else if (pos->knights & bb) fen_buffer[s_i++] = is_white ? 'N' : 'n';
		else if (pos->rooks & bb) fen_buffer[s_i++] = is_white ? 'R' : 'r';
		else if (pos->queens & bb) fen_buffer[s_i++] = is_white ? 'Q' : 'q';
		else fen_buffer[s_i++] = is_white ? 'K' : 'k';
	}
	s_i = use_empties(fen_buffer, empties, s_i);
  fen_buffer[s_i++] = ' ';
  fen_buffer[s_i++] = board->turn == WHITE_VAL ? 'w' : 'b';
  fen_buffer[s_i++] = ' ';
  castling_rights_t castling = board->castling_rights;
	s_i = write_castling(castling, fen_buffer, s_i);
  fen_buffer[s_i++] = ' ';
  optional_square_t ep = board->en_passant_square;
  if (ep.exists) {
        fen_buffer[s_i++] = file_char_of_square(ep.square);
        fen_buffer[s_i++] = rank_char_of_square(ep.square);
  }
  else fen_buffer[s_i++] = '-';
  fen_buffer[s_i++] = ' ';
  turn_clock_t halfmoves = board->halfmove_clock;
  s_i = write_num(fen_buffer, s_i, halfmoves);
  fen_buffer[s_i++] = ' ';
  turn_clock_t fulmoves = board->fullmove_number;
  s_i = write_num(fen_buffer, s_i, fulmoves);
  fen_buffer[s_i++] = '\0';
	return s_i;
}




