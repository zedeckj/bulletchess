#include "board.h"

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

bool positions_equal(position_t *pos1, position_t *pos2){
    return 
        pos1->black_oc == pos2->black_oc &&
        pos1->white_oc == pos2->white_oc &&
        pos1->pawns == pos2->pawns &&
        pos1->knights == pos2->knights &&
        pos1->bishops == pos2->bishops &&
        pos1->queens == pos2->queens &&
        pos1->rooks == pos2->rooks &&
        pos1->kings == pos2->kings;

}

bool boards_equal(full_board_t * board1, full_board_t * board2) {
    if (
        board1->castling_rights == board2->castling_rights &&
        board1->halfmove_clock == board2->halfmove_clock &&
        board1->fullmove_number == board2->fullmove_number &&
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


void copy_into(full_board_t * dst, full_board_t * source) {
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



piece_t get_piece_at(position_t * board, square_t square) {
    bitboard_t square_bb = SQUARE_TO_BB(square);
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




