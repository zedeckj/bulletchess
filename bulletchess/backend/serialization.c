#include "serialization.h"


square_t fen_index_to_square(u_int8_t index) {
    return (square_t)(8 * (7 - index/8) + (index % 8)); 
}

square_t make_square(char file, char rank) {
    return (file - 'a') + ((rank - '1')* 8);
}

bool valid_square_chars(char file, char rank) {
    return rank >= '1' && rank<= '8' && (file>= 'a' && file<= 'h');
}

piece_t piece_from_symbol(char symbol) {
  piece_type_t type;
  char upper = toupper(symbol);
  switch (upper) {
    case '-':
    return empty_piece();
    case 'P':
    type = PAWN_VAL;
    break;
    case 'N':
    type = KNIGHT_VAL;
    break;
    case 'B':
    type = BISHOP_VAL;
    break;
    case 'R':
    type = ROOK_VAL;
    break;
    case 'Q':
    type = QUEEN_VAL;
    break;
    case 'K':
    type = KING_VAL;
    break;
    default:
    return error_piece();
  }
  piece_t piece;
  piece.type = type; 
  if (upper != symbol) piece.color = BLACK_VAL;
  else piece.color = WHITE_VAL;
  return piece;
}

piece_t piece_from_string(char *piece_string) {
  if (piece_string[0] && !piece_string[1]) {
    return piece_from_symbol(piece_string[0]);
  }
  return error_piece();
}

char piece_type_symbol(piece_type_t piece_type) {
    switch (piece_type) {
        case EMPTY_VAL:
            return '-';
        case PAWN_VAL:
            return 'p';
        case KNIGHT_VAL:
            return 'n';
        case BISHOP_VAL:
            return 'b';
        case ROOK_VAL:
            return 'r';
        case QUEEN_VAL:
            return 'q';
        case KING_VAL:
            return 'k';    
    }
    return '?';
}

char piece_symbol(piece_t piece) {
    bool is_white = piece.color == WHITE_VAL;
    char symbol = piece_type_symbol(piece.type);
    if (is_white) {
        symbol = toupper(symbol);
    }
    return symbol;
}


int use_empties(char * fen_buffer, int empties, int index) {
    if (empties > 0) {
        fen_buffer[index] = '0' + empties;
        return index + 1;
    }
    return index;
}

char file_char_of_square(square_t square) {
    return (square % 8) + 'a';
}

char rank_char_of_square(square_t square) {
    return (square / 8) + '1';
}

int write_num(char * buffer, int offset, int num) {
    if (num == 0) {
        buffer[offset] = '0';
        return offset + 1;
    }
    int digits = (int)log10(num);
    for (int i = 0; i <= digits; i++) {
        char c = ((int)(num / pow(10,i)) % 10) + '0';
        buffer[offset + digits - i] = c;
    }
    return offset + digits + 1;
}

// White space insensitive splitting function for FENs
// Predicated on fen != 0
split_fen_t *split_fen(char * fen) {
    split_fen_t *split = malloc(sizeof(split_fen_t));
    int lengths[] = {72, 2, 5, 3, 5, 5};
    split->position_str = (char *)malloc(72);
    split->turn_str = (char * )malloc(2); 
    split->castling_str = (char *)malloc(5);
    split->ep_str = (char *)malloc(3);
    split->halfmove_str = (char *)malloc(5);
    split->fullmove_str = (char *)malloc(5);
    char * strings[] = {split->position_str, split->turn_str, split->castling_str, split->ep_str, split->halfmove_str, split->fullmove_str};
    int current_pointer = 0;
    int pi = 0;
    bool in_space = true;
    for (int i = 0; i == 0 || fen[i - 1]; i++) {
      printf("i: %d, pi: %d, current_pointer: %d\n", i, pi, current_pointer);
      if (fen[i] && !isspace(fen[i])) {
            in_space = false;
            if (pi > lengths[current_pointer]) {
                return split;
            }
            strings[current_pointer][pi++] = fen[i];
        } 
        else if (fen[i]) {
            if (pi > lengths[current_pointer]) {
                return split;
            }
            if (current_pointer < 6) {
              in_space = true;
              strings[current_pointer++][pi] = '\0';
              pi = 0;
            }
        }
    }
    return split;
}

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
            if (str[i] != '/') {
                return "Position has too many squares in a rank";
            }
            else {
                file = 0;
                ++rank; 
            }
        }
        else {
            if (str[i] >= '0' && str[i] < '9') {
                u_int8_t count = str[i] - '0';
                file += count;
                index += count;
            }
            else {
                bitboard_t square_bb = SQUARE_TO_BB(fen_index_to_square(index));
                char lower = tolower(str[i]);
                switch (lower) {
                    case 'p':
                    pawns |= square_bb;
                    break;
                    case 'n':
                    knights |= square_bb;
                    break;
                    case 'b':
                    bishops |= square_bb;
                    break;
                    case 'r':
                    rooks |= square_bb;
                    break;
                    case 'q':
                    queens |= square_bb;
                    break;
                    case 'k':
                    kings |= square_bb;
                    break;
                    default:
                    return "Position has unknown character";
                }
                if (lower != str[i]) white_oc |= square_bb;
                else black_oc |= square_bb;
                ++file;
                ++index;
            }
        }
        if (file > 8) return "Position has too many squares in a rank";
        if (rank > 7) return "Position has too many ranks";
 
    }
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


char * parse_castling(char * str, castling_rights_t * castling) {
    if (!str || !str[0]) return "No castling rights specified";
    *castling = 0;
    if (str[0] == '-' && str[1] == '\0') {
        return 0;
    }
    int a = 0;       
    int i = 0;
    for (; i < 4; i++) {
            if (str[i] == 'K') {
                if (a == 1) return "Invalid castling rights, 'K' cannot be specified twice";
                if (a > 1) return "Invalid castling rights, 'K' cannot be specified after 'Q', 'k', or 'q'";
                *castling |= WHITE_KINGSIDE;
                a = 1;
            }
            else if (str[i] == 'Q') {
                if (a == 2) return "Invalid castling rights, 'Q' cannot be specified twice";
                if (a > 2) return "Invalid castling rights, 'Q' cannot be specified after 'k' or 'q'";
                *castling |= WHITE_QUEENSIDE;
                a = 2;
            }
            else if (str[i] == 'k') {
                if (a == 3) return "Invalid castling rights, 'k' cannot be specified twice";
                if (a > 3) return "Invalid castling rights, 'k' cannot be specified after 'q'";
                *castling |= BLACK_KINGSIDE;
                a = 3;
            }
            else if (str[i] == 'q') {
                if (a == 4) return "Invalid castling rights, 'q' cannot be specified twice";
                *castling |= BLACK_QUEENSIDE;
                a = 4;
            }
            else if (!str[i]) {
                return 0;
            }
            else return "Invalid castling rights, unknown character";
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

char * parse_clock(char * str, turn_clock_t * clock) {
    if (!str || !str[0]) return "Missing move timer";
    turn_clock_t num = 0;
    if (str[0]) {
        for (int i = 0; str[i]; i++) {
            if (str[i] < '0' || str[i] > '9') {
                return "Clock includes a non-digit";
            }
        }
        int parsed = atoi(str);
        if (parsed < UINT16_MAX) {
            *clock = parsed;
            return 0;
        }
    }
    return "Empty clock";
}


// Fills out a board from parsing the given FEN. 
// Returns boolean of if parsing was a success
char * parse_fen(char * fen, full_board_t * board) {
    piece_color_t turn;
    turn_clock_t halfmove;
    turn_clock_t fullmove;
    optional_square_t ep;
    castling_rights_t castling;
    if (!fen) return "Empty FEN";
    char *rest;
    char * error = parse_position(strtok_r(fen, " ", &rest), board->position);
    if (error) return error;
    error = parse_turn(strtok_r(0, " ", &rest), &(board->turn));
    if (error) return error;
    error = parse_castling(strtok_r(0, " ", &rest), &(board->castling_rights));
    if (error) return error;    
    error = parse_ep_square(strtok_r(0, " ", &rest), &(board->en_passant_square));
    if (error) return error;
    error = parse_clock(strtok_r(0, " ", &rest), &(board->halfmove_clock));
    if (error) return error;
    error = parse_clock(strtok_r(0, " ", &rest), &(board->fullmove_number));
    if (error) return error;
    if (strtok_r(0, " ", &rest)) return "FEN has too many terms";
    return 0;
}

void make_fen(full_board_t *board, char * fen_buffer) {
    if (!fen_buffer) {
        return;
    }
    int s_i = 0;
    int empties = 0;
    for (u_int8_t index = 0; index < 64; index++) {
        square_t square = fen_index_to_square(index);
        if ((index && (index % 8)== 0)) {
            s_i = use_empties(fen_buffer, empties, s_i);
            empties = 0;
            fen_buffer[s_i++] = '/';
        }
        piece_t piece = get_piece_at(board->position, square);
        if (piece.type == EMPTY_VAL) {
            empties += 1;
        }
        else {
            s_i = use_empties(fen_buffer, empties, s_i);
            empties = 0;
            fen_buffer[s_i++] = piece_symbol(piece);
        }
    }
    s_i = use_empties(fen_buffer, empties, s_i);
    fen_buffer[s_i++] = ' ';
    fen_buffer[s_i++] = board->turn == WHITE_VAL ? 'w' : 'b';
    fen_buffer[s_i++] = ' ';
    castling_rights_t castling = board->castling_rights;
    if (castling == 0) {
        fen_buffer[s_i++] = '-';
    }
    else {
        if (castling & WHITE_KINGSIDE) fen_buffer[s_i++] = 'K';
        if (castling & WHITE_QUEENSIDE) fen_buffer[s_i++] = 'Q';
        if (castling & BLACK_KINGSIDE) fen_buffer[s_i++] = 'k';
        if (castling & BLACK_QUEENSIDE) fen_buffer[s_i++] = 'q';
    }
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
    fen_buffer[s_i++] = ' ';
    fen_buffer[s_i++] = ' ';
    fen_buffer[s_i++] = '\0';
}


void make_board_string(full_board_t *board, char *string_buffer) {
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
    make_board_string(board, buffer);
    printf("%s\n", buffer);
}
