#include "hash.h"
void initrandom() {
    srandom(1001);
}

u_int64_t random64() {
    return ((u_int64_t)random() << 32) + (u_int64_t)random();
}

zobrist_table_t *create_zobrist_table() {
    initrandom();
    zobrist_table_t *table = (zobrist_table_t *)malloc(sizeof(zobrist_table_t));
    table->square_piece_rands = (uint64_t **)malloc(sizeof(uint64_t *) * 64);
    table->en_passant_rands = (uint64_t *)malloc(sizeof(uint64_t) * 64); // extra precaution for all squares
    table->castling_rights_rands = (uint64_t *)malloc(sizeof(uint64_t) * 5);
    table->white_to_move_rand = random64();
    table->halfmove_rand_coeff = random64() >> 6;
    table->fullmove_rand_coeff = random64() >> 6;
    for (int i = 0; i < 64; i++) {
        table->en_passant_rands[i] = random64();
        table->square_piece_rands[i] = (uint64_t *)malloc(sizeof(uint64_t) * 12);
        for (int j = 0; j < 12; j++) {
            table->square_piece_rands[i][j] = random64();
        }
    }
    return table;
}

u_int64_t hash_board(full_board_t *board, zobrist_table_t * table) {
    u_int64_t hash = 0;
    if (board->turn == WHITE_VAL) {
        hash = table->white_to_move_rand;
    }
    for (square_t square = 0; square < 64; square++) {
        piece_t piece = get_piece_at(board->position, square);
        if (piece.type != EMPTY_VAL) {
            int piece_index = (piece.type - 1);
            if (piece.color == BLACK_VAL) {
                piece_index += 6;
            }
            hash ^= table->square_piece_rands[square][piece_index];
        }
    }
    optional_square_t ep = board->en_passant_square;
    if (ep.exists) {
        hash ^= table->castling_rights_rands[ep.square];
    }
    hash ^= (board->fullmove_number * table->fullmove_rand_coeff);
    hash ^= (board->halfmove_clock * table->halfmove_rand_coeff);
    for (u_int8_t index = 0; index < 4; index ++) {
        if (board->castling_rights & (1 << index)) {
            hash ^= table->castling_rights_rands[index];
        }
    }
    return hash;
}