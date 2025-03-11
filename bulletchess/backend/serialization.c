#include "serialization.h"


square_t fen_index_to_square(u_int8_t index) {
    return (square_t)(8 * (7 - index/8) + (index % 8)); 
}

square_t make_square(char rank, char file) {
    rank = tolower(rank);
    return (rank - 'a') + ((file - '1')* 8);
}

bool valid_square_chars(char rank, char file) {
    return file >= '1' && file <= '8' && 
        ((rank >= 'a' && rank <= 'h') || (rank >= 'A' && rank <= 'H'));
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


// Splits a FEN string into parts. Returns 0 if any parts are missing. 
// Does not allocate any new string, or check if the parts are valid.
split_fen_t *split_fen(char * fen) {
    split_fen_t *split = malloc(sizeof(split_fen_t));
    int lengths[] = {72, 1, 4, 2, 5, 5};
    split->position_str = malloc(71);
    split->turn_str = malloc(1);
    split->castling_str = malloc(4);
    split->ep_str = malloc(2);
    split->halfmove_str = malloc(5);
    split->fullmove_str = malloc(5);
    char * strings[] = {split->position_str, split->turn_str, split->castling_str, split->ep_str, split->halfmove_str, split->fullmove_str};
    int current_pointer = 0;
    int pi = 0;
    bool in_space = true;
    for (int i = 0; i == 0 || fen[i - 1]; i++) {
        if (fen[i] && !isspace(fen[i])) {
            in_space = false;
            if (pi > lengths[current_pointer]) {
                free(split);
                return 0;
            }
            strings[current_pointer][pi++] = fen[i];
        } else if (!in_space) {
            if (pi > lengths[current_pointer]) {
                free(split);
                return 0;
            }
            in_space = true;
            strings[current_pointer++][pi] = '\0';
            pi = 0;
        }
    }
    return split;
}


char * parse_position(char * str, position_t * position) {
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
        if (file > 8|| rank > 7) {
            return "Invalid Position";
        }
        else if (file == 8) {
            if (str[i] != '/') {
                return "Invalid Position";
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
                    return "Invalid position, unknown piece";
                }
                if (lower != str[i]) white_oc |= square_bb;
                else black_oc |= square_bb;
                ++file;
                ++index;
            }
        }
    }
    if (rank == 7 && file == 8) {
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
    return "Invalid position";
}

char * parse_turn(char * str, piece_color_t * color) {
    if (str[0]) {
        if (!str[1]) {
            if (tolower(str[0]) == 'w') {
                *color = WHITE_VAL;
                return 0;
            }
            else if (tolower(str[0]) == 'b'){ 
                *color = BLACK_VAL;
                return 0;
            }
            else {
                return "Turn is not 'w' or 'b";
            }
        }
        else {
            return "Length of turn greater than one character";
        }
    } else {
        return "No turn specified";
    }
}


char * parse_castling(char * str, castling_rights_t * castling) {
    if (str[0] == '-' && str[1] == '\0') {
        *castling = 0;
        return 0;
    }
    else if (str[0]) {
        int a = 0;       
        int i = 0;
        for (; i < 4; i++) {
            if (str[i] == 'K' && a == 0) {
                *castling |= WHITE_KINGSIDE;
                a = 1;
            }
            else if (str[i] == 'Q' &&  a <= 1) {
                *castling |= WHITE_QUEENSIDE;
                a = 2;
            }
            else if (str[i] == 'k' &&  a <= 2) {
                *castling |= BLACK_KINGSIDE;
                a = 3;
            }
            else if (str[i] == 'q' &&  a <= 3) {
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
        } return "Invalid castling rights";
    }
    else return "Empty castling rights";
}



char * parse_ep_square(char * str, optional_square_t * ep) {
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
    split_fen_t *split = split_fen(fen);
    if (!split) {
        return "Missing parts of FEN";
    }
    piece_color_t turn;
    turn_clock_t halfmove;
    turn_clock_t fullmove;
    optional_square_t ep;
    castling_rights_t castling;
    char * error = parse_turn(split->turn_str, &turn);
    if (!error) {
        error = parse_turn(split->turn_str, &turn);
        if (!error) {
            error = parse_ep_square(split->ep_str, &ep);
            if (!error) {
                error = parse_clock(split->fullmove_str, &fullmove);
                if (!error) {
                    error = parse_clock(split->halfmove_str, &halfmove);
                    if (!error) {
                        error = parse_clock(split->halfmove_str, &halfmove);
                        if (!error) {
                            error = parse_castling(split->castling_str, &castling);
                            if (!error) {
                                error = parse_position(split->position_str, board->position);
                            }
                        }
                    }
                }
            }
        }
    }
    if (!error) {
        board->turn = turn;
        board->halfmove_clock = halfmove;
        board->fullmove_number = fullmove;
        board->en_passant_square = ep;
        board->castling_rights = castling;
    }
    free(split->position_str);
    free(split->castling_str);
    free(split->ep_str);
    free(split->fullmove_str);
    free(split->halfmove_str);
    free(split);
    return error;
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