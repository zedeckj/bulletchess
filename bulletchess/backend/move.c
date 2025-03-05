#include "move.h"



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

        case FULL_MOVE: 
        write_uci_body(move.full.body, buffer);
        buffer[4] = '\0';
        return true;



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

move_t parse_uci(char * str) {
    bool all_zero = true;
    for (int i = 0; i < 4; i++) {
        if (!str[i]) {
            printf("\nNull early\n");
            return error_move();
        }
        else if (str[i] != '0') {
            all_zero = false;
            break;
        }
    }
    if (all_zero) {
        printf("\nall zero\n");
        return str[5] ? error_move() : null_move();
    }
    if (valid_square_chars(str[0], str[1]) && 
        valid_square_chars(str[2], str[3])) {
            if (!str[4] || isspace(str[4])) {
                move_t move = generic_move(
                        move_body(
                            make_square(str[0], str[1]), 
                            make_square(str[2], str[3])));
                return move;
                
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
                }
                return promotion_move(
                    move_body(
                        make_square(str[0], str[1]), 
                        make_square(str[2], str[3])),
                    promote_to);
            }
            else{
                printf("\ntoo long\n");
            }

    }
    printf("\ninvalid squares\n");
    return error_move();
}



// void apply_move_old(full_board_t *board, move_t move) {
//     // almost all checks can be determined faster at generation time
//     // have a union between your move format and UCI style moves

//     bool reset_halfmove = false; 
//     if (move.type == REGULAR_MOVE) { 
//         if (try_castling(board, move.regular)) { // static castling
//             return;
//         }
//         bitboard_t origin_bb = square_to_bitboard(move.regular.origin);
//         bitboard_t destination_bb = square_to_bitboard(move.regular.destination);
//         // origin and destination duplication
//         piece_t moving = get_piece_at_bb(board->position, origin_bb);
//         reset_halfmove = moving.type == PAWN_VAL; 
//         // static moving piece 
//         printf("\n%c moving\n", piece_symbol(moving));
//         if (!reset_halfmove) reset_halfmove = !square_bb_empty(board->position, destination_bb);
//         mask_board_with(board->position, ~origin_bb);
//         set_piece_at_bb(board->position, destination_bb, moving);
//     }
//     else if (move.type == PROMOTION_MOVE) {
//         reset_halfmove = true;
//         bitboard_t origin_bb = square_to_bitboard(move.promotion.origin);
//         bitboard_t destination_bb = square_to_bitboard(move.promotion.destination);
//         mask_board_with(board->position, ~origin_bb);
//         piece_t piece;
//         piece.color = board->turn;
//         piece.type = move.promotion.promote_to;
//         set_piece_at_bb(board->position, destination_bb, piece);
//     }
//     if (board->turn == WHITE_VAL) board->turn = BLACK_VAL;
//     else {
//         ++(board->fullmove_number);
//         board->turn = WHITE_VAL;
//     }
//     if (reset_halfmove) board->halfmove_clock = 0;
//     else ++(board->halfmove_clock);
//     clear_ep_square(board);


// }

 void do_castling(full_board_t * board, square_t king_origin, square_t king_dest, square_t rook_origin, bitboard_t rook_dest) {
    piece_t king;
    king.type = KING_VAL;
    king.color = board->turn;

    piece_t rook;
    rook.type = ROOK_VAL;
    rook.color = board->turn;
    delete_piece_at(board->position, king_origin);
    delete_piece_at(board->position, rook_origin);
    set_piece_at(board->position, king_dest, king);
    set_piece_at(board->position, rook_dest, rook);
}

 void do_white_kingside(full_board_t *board) {
    do_castling(board, E1, G1, H1, F1);
    board->castling_rights &= ~WHITE_FULL_CASTLING;
}

 void do_white_queenside(full_board_t *board) {
    do_castling(board, E1, C1, A1, D1);
    board->castling_rights &= ~WHITE_FULL_CASTLING;
}

 void do_black_kingside(full_board_t *board) {
    do_castling(board, E8, G8, H8, F8);
    board->castling_rights &= ~BLACK_FULL_CASTLING;
}

 void do_black_quenside(full_board_t *board) {
    do_castling(board, E8, C8, A8, D8);
    board->castling_rights &= ~BLACK_FULL_CASTLING;
}


void apply_castling_move(full_board_t * board, castling_rights_t castling) {
    if (castling & WHITE_KINGSIDE) {
        do_white_kingside(board);
    }
    else if (castling & WHITE_QUEENSIDE) {
        do_white_queenside(board);
    }
    else if (castling & BLACK_KINGSIDE) {
        do_black_kingside(board);
    }
    else if (castling & BLACK_QUEENSIDE) {
        do_black_quenside(board);
    }
    clear_ep_square(board);
    board->halfmove_clock += 1;

}


// Should only be called if moving piece is known to be a pawn
void do_ep_change(full_board_t *board, generic_move_t move) {
    if (move.origin > 7 && move.origin < 16) {
        if (move.destination == move.origin + 16) {
            set_ep_square(board, move.origin + 8);
        }
        else {
            clear_ep_square(board);
        }
    }
    else if (move.origin > 47 && move.origin < 56) {
        if (move.destination == move.origin - 16) {
            set_ep_square(board, move.origin - 8);
        }
        else {
            clear_ep_square(board);
        }
    }
    else {
        clear_ep_square(board);
    }
}
 
void do_ep_capture(full_board_t *board, generic_move_t move) {
    if (board->en_passant_square.exists && (board->en_passant_square.square == move.destination)) {
        if (board->turn == WHITE_VAL) {
            delete_piece_at(board->position, move.destination - 8);
        }
        else {
            delete_piece_at(board->position, move.destination + 8);
        }
    }
}

// Should only be called if moving piece is known **NOT** to be a pawn
void do_halfmove_change(full_board_t *board, generic_move_t move) {
    if (!square_empty(board->position, move.destination)) {
        board->halfmove_clock = 0;
    }
    else {
        board->halfmove_clock += 1;
    }
}

void do_castling_change_rook_square(full_board_t *board, square_t square) {
    switch (square) {
        case A1:
        board->castling_rights &= ~WHITE_QUEENSIDE;
        return;
        case H1:
        board->castling_rights &= ~WHITE_KINGSIDE;
        return;
        case A8:
        board->castling_rights &= ~BLACK_QUEENSIDE;
        return;
        case H8:
        board->castling_rights &= ~BLACK_KINGSIDE;
        return;
    }
}

void do_castling_change(full_board_t *board, generic_move_t move, piece_t piece) {
    if (piece.type == KING_VAL && move.origin == E1) {
        board->castling_rights &= ~WHITE_FULL_CASTLING;
    }
    else if (piece.type == KING_VAL && move.origin == E8) {
        board->castling_rights &= ~BLACK_FULL_CASTLING;
    }
    else if (piece.type == ROOK_VAL) {
        do_castling_change_rook_square(board, move.origin);
    }
}

void do_state_change(full_board_t *board, generic_move_t move, piece_t moving) {
    /*
    if moving_piece is pawn 
        do_ep_change(origin, destination)
        halfmove = 0
    else
        do_castling(moving_piece, origin)
        do_halfmove_change(destination)
        clear_ep_square
    
    */
    // piece_t moving = get_piece_at(board->position, move.origin);
    if (moving.type == PAWN_VAL) {
        do_ep_capture(board, move);
        do_ep_change(board, move);
        board->halfmove_clock = 0;
    } 
    else {
        do_halfmove_change(board, move);
        do_castling_change(board, move, moving);
        clear_ep_square(board);
    }
}

void move_piece(full_board_t *board, generic_move_t move, piece_type_t piece_type) {
    delete_piece_at(board->position, move.origin);
    piece_t piece;
    piece.color = board->turn;
    piece.type = piece_type;
    set_piece_at(board->position, move.destination, piece);
    do_castling_change_rook_square(board, move.destination);
}


void apply_promotion_move(full_board_t *board, promotion_move_t move) {
    move_piece(board, move.body, move.promote_to);
    board->halfmove_clock = 0;
    clear_ep_square(board);
}

void apply_full_move(full_board_t *board, full_move_t move) {
    return;
}


void apply_generic_move(full_board_t *board, generic_move_t move) {
    piece_t piece = get_piece_at(board->position, move.origin);
    bool castled = false;
    if (piece.type == KING_VAL) {
        if (move.origin == E1) {
            if (move.destination == G1) {
                do_white_kingside(board);
                castled = true;
            }
            else if (move.destination == C1) {
                do_white_queenside(board);
                castled = true;
            }
        }
        else if (move.origin == E8) {
            if (move.destination == G8) {
                do_black_kingside(board);
                castled = true;
            }
            else if (move.destination == C8) {
                do_black_quenside(board);
                castled = true;
            }
        }
    }
    if (castled) {
        clear_ep_square(board);
        board->halfmove_clock += 1;
        return;
    }
    do_state_change(board, move, piece);
    move_piece(board, move, piece.type);
}

bool apply_move(full_board_t *board, move_t move) {
    switch (move.type) {
        case FULL_MOVE:
        apply_full_move(board, move.full);
        break;
        case GENERIC_MOVE:
        apply_generic_move(board, move.generic);
        break;
        case PROMOTION_MOVE:
        apply_promotion_move(board, move.promotion);
        break;
        case CASTLING_MOVE:
        apply_castling_move(board, move.castling);
        break;
        default:
        //printf("Unknown move type");
        return false;
    }
    if (board->turn == WHITE_VAL) board->turn = BLACK_VAL;
    else {
        board->turn = WHITE_VAL;
        board->fullmove_number += 1;
    }
    return true;
}

bool offset_valid(square_t square, int8_t rank_offset, int8_t file_offset) {
    int8_t file = FILE((int)square) + file_offset;
    int8_t rank = RANKNUM((int)square) + rank_offset;
    return file >= 1 && file <= 8 && rank >= 1 && rank <= 8;
}

// Only call after validating with offset_valid
square_t offset_square(square_t square, int8_t rank_offset, int8_t file_offset) {
    square += rank_offset;
    square += 8 * file_offset;
    return square;
}


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

void pawn_add_promotions(square_t origin, square_t destination, move_t * moves, u_int8_t *move_index) {
    moves[(*move_index)++] = promotion_move(move_body(origin, destination), QUEEN_VAL);
    moves[(*move_index)++] = promotion_move(move_body(origin, destination), ROOK_VAL);
    moves[(*move_index)++] = promotion_move(move_body(origin, destination), BISHOP_VAL);
    moves[(*move_index)++] = promotion_move(move_body(origin, destination), KNIGHT_VAL);
}



bool pawn_add_if_empty(full_board_t * board, square_t origin, square_t destination, move_t * moves, u_int8_t *move_index) {
    if (square_empty(board->position, destination)) {
        if (FILE(destination) == 1 || FILE(destination) == 8) pawn_add_promotions(origin, destination, moves, move_index);
        else moves[(*move_index)++] = generic_move(move_body(origin, destination));
        return true;
    }
    return false;
}

bool pawn_add_if_capture(full_board_t * board, square_t origin, square_t destination, piece_color_t color, move_t * moves, u_int8_t *move_index) {
    if ((color_occupies(board->position, destination, color == WHITE_VAL ? BLACK_VAL : WHITE_VAL))) {
        if (FILE(destination) == 1 || FILE(destination) == 8) pawn_add_promotions(origin, destination, moves, move_index);
        else moves[(*move_index)++] = generic_move(move_body(origin, destination));
        return true;
    }
    else if (board->en_passant_square.exists && (board->en_passant_square.square == destination)) {
        moves[(*move_index)++] = generic_move(move_body(origin, destination));
        return true;
    }
    return false;
}

// returns 0 if invalid, 1 if valid with occupied square, 2 if valid with empty square
int add_if_valid_offset(full_board_t * board, square_t origin, int8_t rank_offset, int8_t file_offset, piece_color_t color, move_t * moves, u_int8_t *move_index) {
    if (offset_valid(origin, rank_offset, file_offset)) {
        square_t destination = offset_square(origin, rank_offset, file_offset);
        bool empty = square_empty(board->position, destination);
        if (empty || !color_occupies(board->position, destination, color)) {
            moves[(*move_index)++] = generic_move(move_body(origin, destination));
            return empty ? 2 : 1;
        }
    }
    return 0;
}


u_int8_t add_pawn_moves(full_board_t *board, square_t origin, piece_color_t color, move_t * moves, u_int8_t move_index) {
    int8_t forward = color == WHITE_VAL ? 8 : -8;
    u_int8_t file = FILE(origin);
    u_int8_t rank = RANKNUM(origin);
    if (pawn_add_if_empty(board, origin, forward + origin, moves, &move_index)) {
        bool at_initial = (file == 2 && color == WHITE_VAL) || (file == 7 && color == BLACK_VAL);
        if (at_initial) {
            pawn_add_if_empty(board, origin, origin + (forward * 2), moves, &move_index);
        }
    }
    if (rank > 1) {
        pawn_add_if_capture(board, origin, LEFT(forward + origin), color, moves, &move_index);
    }
    if (rank < 8) {
        pawn_add_if_capture(board, origin, RIGHT(forward + origin), color, moves, &move_index);
    }
    return move_index;
}


// u_int8_t add_pawn_moves(full_board_t *board, square_t origin, piece_color_t color, move_t * moves, u_int8_t move_index) {
//     if (color == WHITE_VAL) {
//         if (is_valid_empty(board, ABOVE(origin))) {
//             moves[move_index++] = generic_move(move_body(origin, ABOVE(origin)));
//             if (FILENUM(origin) == 2 && square_empty(board->position, ABOVE(ABOVE(origin)))) {
//                 moves[move_index++] = generic_move(move_body(origin, ABOVE(ABOVE(origin))));
//             }
//         }
//         if (is_valid_white_capturing(board, LEFT(ABOVE(origin))) || en_passant_is(board, LEFT(ABOVE(origin)))) {
//             moves[move_index++] = generic_move(move_body(origin, LEFT(ABOVE(origin))));
//         }
//         if (is_valid_white_capturing(board, RIGHT(ABOVE(origin))) || en_passant_is(board, RIGHT(ABOVE(origin)))) {
//             moves[move_index++] = generic_move(move_body(origin, RIGHT(ABOVE(origin))));
//         }
//     }
//     else {
//         if (is_valid_empty(board, BELOW(origin))) {
//             moves[move_index++] = generic_move(move_body(origin, BELOW(origin)));
//             if (FILENUM(origin) == 7 && square_empty(board->position, BELOW(BELOW(origin)))) {
//                 moves[move_index++] = generic_move(move_body(origin, BELOW(BELOW(origin))));
//             }
//         }
//         if (is_valid_black_capturing(board, LEFT(BELOW(origin)) || en_passant_is(board, LEFT(BELOW(origin))))) {
//             moves[move_index++] = generic_move(move_body(origin, LEFT(BELOW(origin))));
//         }
//         if (is_valid_black_capturing(board, RIGHT(BELOW(origin)) || en_passant_is(board, RIGHT(BELOW(origin))))) {
//             moves[move_index++] = generic_move(move_body(origin, RIGHT(BELOW(origin))));
//         }
//     }
//     return move_index;
// }

u_int8_t add_knight_moves(full_board_t *board, square_t origin, piece_color_t color, move_t * moves, u_int8_t move_index) {
    int8_t file_offsets[] = {-2, -2, -1, -1,  1,  1,  2,  2};
    int8_t rank_offsets[] = {-1,  1, -2,  2, -2,  2, -1,  1};
    
    for (int8_t i = 0; i < 8; i ++) {
        add_if_valid_offset(board, origin, rank_offsets[i], file_offsets[i], color, moves, &move_index);
    }
    return move_index;
}

// u_int8_t add_knight_moves(full_board_t *board, square_t origin, piece_color_t color, move_t * moves, u_int8_t move_index) {
//     bitboard_t destinations = move_table->knights_moves[origin];
//     destinations &= color == WHITE_VAL ? ~board->position->white_oc : ~board->position->black_oc;
//     return add_from_bitboard(origin, destinations, moves, move_index);
// }



u_int8_t add_bishop_moves(full_board_t *board, square_t origin, piece_color_t color, move_t * moves, u_int8_t move_index) {
    int8_t rank_coeffs[] = {1, 1, -1, -1};
    int8_t file_coeffs[] = {1, -1, 1, -1};
    bool can_continue[] = {true, true, true, true};
    for (int8_t i = 1; i < 8; i++) {
        for (int8_t c = 0; c < 4; c++) {
            if (can_continue[c]) {
                int res = add_if_valid_offset(board, origin, i * rank_coeffs[c], i * file_coeffs[c], color, moves, &move_index);
                can_continue[c] = res == 2;
            }
        }
    }
    return move_index;
}

u_int8_t add_rook_moves(full_board_t *board, square_t origin, piece_color_t color, move_t * moves, u_int8_t move_index) {
    int8_t rank_coeffs[] = {1, -1, 0, 0};
    int8_t file_coeffs[] = {0, 0, 1, -1};
    bool can_continue[] = {true, true, true, true};
    for (int8_t i = 1; i < 8; i++) {
        for (int8_t c = 0; c < 4; c++) {
            if (can_continue[c]) {
                int res = add_if_valid_offset(board, origin, i * rank_coeffs[c], i * file_coeffs[c], color, moves, &move_index);
                can_continue[c] = res ==2;
            }
        }
    }
    return move_index;
}

u_int8_t add_queen_moves(full_board_t *board, square_t origin, piece_color_t color, move_t * moves, u_int8_t move_index) {
    move_index = add_rook_moves(board, origin, color, moves, move_index);
    return add_bishop_moves(board, origin, color, moves, move_index);
}
u_int8_t add_king_moves(full_board_t *board, square_t origin, piece_color_t color, move_t * moves, u_int8_t move_index) {
    for (int rank_offset = -1; rank_offset < 2; rank_offset++) {
        for (int file_offset = -1; file_offset < 2; file_offset++) {
            if (rank_offset != 0 || file_offset != 0) {
                add_if_valid_offset(board, origin, rank_offset, file_offset, color, moves, &move_index);
            }
        }
    }
    return move_index;
}


u_int8_t add_moves_from_square(full_board_t *board, square_t origin, piece_color_t for_color, move_t * moves, u_int8_t move_index) {
    piece_t piece_at = get_piece_at(board->position, origin);
    switch (piece_at.type) {
        case PAWN_VAL:
        return add_pawn_moves(board, origin, for_color, moves, move_index);
        case KNIGHT_VAL:
        return add_knight_moves(board, origin, for_color, moves, move_index);
        case BISHOP_VAL:
        return add_bishop_moves(board, origin, for_color, moves, move_index);
        case ROOK_VAL:
        return add_rook_moves(board, origin, for_color, moves, move_index);
        case QUEEN_VAL:
        return add_queen_moves(board, origin, for_color, moves, move_index);
        case KING_VAL:
        return add_king_moves(board, origin, for_color, moves, move_index);
    }
    return move_index;
}


void print_bitboard(bitboard_t board) {
    int i =0;
    for (bitboard_t rank = RANK_8; i < 8; i++) {
        int j = 0;
        for (bitboard_t file = FILE_A; j < 8; j++) {
            printf("%d ", rank & file & board ? 1 : 0);
            file = SAFE_RIGHT_BB(file);
        }
        printf("\n");
        rank = BELOW_BB(rank);
    }
    printf("\n");
}


bitboard_t white_pawn_attack_mask(bitboard_t bb) {
    bitboard_t above = ABOVE(bb);
    bitboard_t attacking = SAFE_LEFT_BB(above);
    attacking |= SAFE_RIGHT_BB(above);
    return attacking;
}

bitboard_t black_pawn_attack_mask(bitboard_t bb) {
    bitboard_t below = BELOW(bb);
    bitboard_t attacking = SAFE_LEFT_BB(below);
    attacking |= SAFE_RIGHT_BB(below);
    return attacking;
}

bitboard_t knight_attack_mask(bitboard_t bb) {
    bitboard_t attacking;
    attacking = SAFE_LEFT_BB(SAFE_TWO_ABOVE_BB(bb));
    attacking |= SAFE_RIGHT_BB(SAFE_TWO_ABOVE_BB(bb));

    attacking |= SAFE_LEFT_BB(SAFE_TWO_BELOW_BB(bb));
    attacking |= SAFE_RIGHT_BB(SAFE_TWO_BELOW_BB(bb));

    attacking |= SAFE_TWO_LEFT_BB(SAFE_ABOVE_BB(bb));
    attacking |= SAFE_TWO_RIGHT_BB(SAFE_ABOVE_BB(bb));

    attacking |= SAFE_TWO_LEFT_BB(SAFE_BELOW_BB(bb));
    attacking |= SAFE_TWO_RIGHT_BB(SAFE_BELOW_BB(bb));

    return attacking;
}


bitboard_t king_attack_mask(bitboard_t bb) {
    bitboard_t attacking;
    attacking = SAFE_ABOVE_BB(bb);
    attacking |= SAFE_BELOW_BB(bb);
    attacking |= SAFE_LEFT_BB(bb);
    attacking |= SAFE_RIGHT_BB(bb);
    attacking |= SAFE_LEFT_BB(SAFE_ABOVE_BB(bb));
    attacking |= SAFE_LEFT_BB(SAFE_BELOW_BB(bb));
    attacking |= SAFE_RIGHT_BB(SAFE_ABOVE_BB(bb));
    attacking |= SAFE_RIGHT_BB(SAFE_BELOW_BB(bb));
    return attacking;
}

bitboard_t sliding_attack_mask(bitboard_t bb, bitboard_t not_same_color, bitboard_t empty) {
    bitboard_t attacking = 0;
    bitboard_t more = 1;
    bitboard_t moving_left_bb = bb;
    bitboard_t moving_right_bb = bb;
    bitboard_t moving_above_bb = bb;
    bitboard_t moving_below_bb = bb;
    while (more) {
        moving_left_bb = moving_left_bb ? SAFE_LEFT_BB(moving_left_bb) & not_same_color : 0;
        moving_right_bb = moving_right_bb ?  SAFE_RIGHT_BB(moving_right_bb) & not_same_color : 0;
        moving_above_bb = moving_above_bb ? SAFE_ABOVE_BB(moving_above_bb) & not_same_color : 0;
        moving_below_bb = moving_below_bb ? SAFE_BELOW_BB(moving_below_bb) & not_same_color : 0;
        
        attacking |= moving_below_bb | moving_above_bb | moving_right_bb | moving_left_bb;
        moving_below_bb &= empty;
        moving_above_bb &= empty;
        moving_right_bb &= empty;
        moving_left_bb &= empty;
        more = moving_below_bb | moving_above_bb | moving_right_bb | moving_left_bb;
    }
    return attacking;
}

bitboard_t diagonal_attack_mask(bitboard_t bb, bitboard_t not_same_color, bitboard_t empty) {
    bitboard_t attacking = 0;
    bitboard_t more = 1;
    bitboard_t moving_lu_bb = bb;
    bitboard_t moving_ld_bb = bb;
    bitboard_t moving_ru_bb = bb;
    bitboard_t moving_rd_bb = bb;
    while (more) {
        moving_lu_bb = moving_lu_bb ? SAFE_ABOVE_BB(SAFE_LEFT_BB(moving_lu_bb)) & not_same_color : 0;
        moving_ld_bb = moving_ld_bb ? SAFE_BELOW_BB(SAFE_LEFT_BB(moving_ld_bb)) & not_same_color : 0;
        moving_ru_bb = moving_ru_bb ? SAFE_ABOVE_BB(SAFE_RIGHT_BB(moving_ru_bb)) & not_same_color : 0;
        moving_rd_bb = moving_rd_bb ? SAFE_BELOW_BB(SAFE_RIGHT_BB(moving_rd_bb)) & not_same_color : 0;
        
        attacking |= moving_lu_bb | moving_ld_bb | moving_ru_bb | moving_rd_bb;
        moving_lu_bb &= empty;
        moving_ld_bb &= empty;
        moving_ru_bb &= empty;
        moving_rd_bb &= empty;
        more = moving_lu_bb | moving_ld_bb | moving_ru_bb | moving_rd_bb;
    }
    return attacking;
}



bitboard_t make_attack_mask(full_board_t *board, piece_color_t attacker) {
    bitboard_t friendly;
    bitboard_t hostile;
    position_t *position = board->position;
    if (attacker == WHITE_VAL) {
        friendly = position->white_oc;
        hostile = position->black_oc;
    }
    else {
        friendly = position->black_oc;
        hostile = position->white_oc;
    }
    bitboard_t enemy_pawns = hostile & position->pawns;
    bitboard_t enemy_bishops = hostile & position->bishops;
    bitboard_t enemy_knights = hostile & position->knights;
    bitboard_t enemy_rooks = hostile & position->rooks;
    bitboard_t enemy_queens = hostile & position->queens;
    bitboard_t enemy_kings = hostile & position->kings;
    bitboard_t friendly_kings = hostile & position->kings;
    friendly &= ~friendly_kings;
    bitboard_t empty = ~(hostile | friendly);
    bitboard_t non_enemy = friendly | empty;

    bitboard_t attacking;
    if (attacker == WHITE_VAL) attacking = white_pawn_attack_mask(enemy_pawns);
    else attacking = black_pawn_attack_mask(enemy_pawns);
    attacking |= knight_attack_mask(enemy_knights);
    attacking |= king_attack_mask(enemy_kings);
    attacking |= sliding_attack_mask(enemy_rooks, non_enemy, empty);
    attacking |= diagonal_attack_mask(enemy_bishops, non_enemy, empty);
    attacking |= sliding_attack_mask(enemy_queens, non_enemy, empty);
    attacking |= diagonal_attack_mask(enemy_queens, non_enemy, empty);
    return attacking;
}

u_int8_t generate_moves(
    full_board_t *board, 
    piece_color_t for_color, 
    bitboard_t attacked_mask,
    move_t * move_buffer) {
    u_int8_t move_index = 0;

    position_t *position = board->position;
    bitboard_t friendly;
    bitboard_t hostile;

    bitboard_t pawn_one_square_advance;
    bitboard_t our_white_pawns = 0;
    bitboard_t our_black_pawns = 0;
    if (for_color == WHITE_VAL) {
        friendly = position->white_oc;
        hostile = position->black_oc;
        our_white_pawns = friendly & position->pawns & ~RANK_8;
    }
    else {
        friendly = position->black_oc;
        hostile = position->white_oc;
        our_black_pawns = friendly & position->pawns & ~RANK_1;
    }
    bitboard_t our_pawns = friendly & position->pawns;
    bitboard_t our_bishops = friendly & position->bishops;
    bitboard_t our_knights = friendly & position->knights;
    bitboard_t our_rooks = friendly & position->rooks;
    bitboard_t our_queens = friendly & position->queens;
    bitboard_t our_kings = friendly & position->kings;
    bitboard_t ep_bb = board->en_passant_square.exists ? SQUARE_TO_BB(board->en_passant_square.square) : 0;
    bitboard_t pawn_hostile = hostile | ep_bb;
    bitboard_t empty = ~(friendly | hostile);
    bitboard_t non_friendly = ~friendly;
    //print_bitboard(position->pawns);
    // print_bitboard(our_pawns);
    // print_bitboard(our_white_pawns);
    // print_bitboard(our_bishops);
    // print_bitboard(our_knights);
    // print_bitboard(our_rooks);
    // print_bitboard(our_queens);
    // print_bitboard(our_kings);
    for (square_t origin = A1; origin <= H8; origin++) {
        //printf("%d at %d\n", get_piece_at(position, origin).type, origin);
        bitboard_t square_bb = SQUARE_TO_BB(origin);
        // pawn moves
        if (square_bb & empty) {
            continue;
        }
        else if (square_bb & our_pawns) {
            bitboard_t destination_bb;
            if (square_bb & our_white_pawns) {
                // promotions
                if (square_bb & RANK_7) {
                    bitboard_t next_bb = ABOVE_BB(square_bb);
                    destination_bb = next_bb & empty;
                    destination_bb |= SAFE_LEFT_BB(next_bb) & hostile;
                    destination_bb |= SAFE_RIGHT_BB(next_bb) & hostile;
                    //printf("ADDING WHITE PAWN PROMOTES\n");
                    add_from_bitboard_white_promotes(origin, destination_bb, move_buffer, &move_index);
                }
                else {
                    bitboard_t first_square_advance = ABOVE_BB(square_bb);
                    destination_bb = first_square_advance & empty;
                    if (square_bb & RANK_2) {
                        destination_bb |= ABOVE_BB(destination_bb) & empty;
                    }
                    destination_bb |= SAFE_LEFT_BB(first_square_advance) & pawn_hostile;
                    destination_bb |= SAFE_RIGHT_BB(first_square_advance) & pawn_hostile;
                    //printf("ADDING WHITE PAWN PROMOTES\n");
                    add_from_bitboard(origin, destination_bb, move_buffer, &move_index);
                }
            }
            else {
                // promotions
                if (square_bb & RANK_2) {
                    bitboard_t next_bb = BELOW_BB(square_bb);
                    destination_bb = next_bb & empty;
                    destination_bb |= SAFE_LEFT_BB(next_bb) & hostile;
                    destination_bb |= SAFE_RIGHT_BB(next_bb) & hostile;
                    //printf("ADDING BLACK PAWN PROMOTES\n");
                    add_from_bitboard_black_promotes(origin, destination_bb, move_buffer, &move_index);
                }
                else {
                    bitboard_t first_square_advance = BELOW_BB(square_bb);
                    destination_bb = first_square_advance & empty;
                    if (square_bb & RANK_7) {
                        destination_bb |= BELOW_BB(destination_bb) & empty;
                    }
                    destination_bb |= SAFE_LEFT_BB(first_square_advance) & pawn_hostile;
                    destination_bb |= SAFE_RIGHT_BB(first_square_advance) & pawn_hostile;
                    //printf("ADDING BLACK PAWNS\n");
                    add_from_bitboard(origin, destination_bb, move_buffer, &move_index);
                }
            }
        }
        else if (square_bb & our_knights) {
            bitboard_t destination_bb;
            destination_bb = knight_attack_mask(square_bb) & non_friendly;
            //printf("ADDING KNIGHTS\n");
            add_from_bitboard(origin, destination_bb, move_buffer, &move_index);
        }
        else if (square_bb & our_kings) {
            bitboard_t destination_bb;
            destination_bb = king_attack_mask(square_bb) & non_friendly & ~attacked_mask;
            add_from_bitboard(origin, destination_bb, move_buffer, &move_index);
        }
        else {
            if (square_bb & (our_rooks | our_queens)) {
                bitboard_t destination_bb = sliding_attack_mask(square_bb, non_friendly, empty);
                add_from_bitboard(origin, destination_bb, move_buffer, &move_index);
                
            }
            if (square_bb & (our_bishops | our_queens)) {
                bitboard_t destination_bb = diagonal_attack_mask(square_bb, non_friendly, empty);
                add_from_bitboard(origin, destination_bb, move_buffer, &move_index);
            }
        }
    }
    return move_index;
}


u_int8_t generate_pseudo_legal_moves(full_board_t *board,  piece_color_t for_color,  move_t * move_buffer) {
    return generate_moves(board, for_color, 0, move_buffer);
}

u_int8_t generate_legal_moves(full_board_t *board,  piece_color_t for_color,  move_t * move_buffer) {
    bitboard_t attack_mask = make_attack_mask(board, WHITE_VAL == for_color ? BLACK_VAL : WHITE_VAL);
    return generate_moves(board, for_color, attack_mask, move_buffer);
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


