#ifndef SEARCHHEADER
#define SEARCHHEADER 0
#include "move.h"

#define MAX_EVAL 10000
#define MIN_EVAL -10000


typedef struct {
    int32_t eval;
    move_t move;
} search_result_t;

typedef struct {
    int32_t white_pawn[64];
    int32_t white_knight[64];
    int32_t white_bishop[64];
    int32_t white_rook[64];
    int32_t white_queen[64];
    int32_t white_king[64];
    int32_t white_king_endgame[64];

    int32_t black_pawn[64];
    int32_t black_knight[64];
    int32_t black_bishop[64];
    int32_t black_rook[64];
    int32_t black_queen[64];
    int32_t black_king[64];
    int32_t black_king_endgame[64];

    int32_t pawn_value;
    int32_t bishop_value;
    int32_t knight_value;
    int32_t rook_value;
    int32_t queen_value;

    int32_t check_value;
    int32_t checkmate_value;
} evaluation_table_t;


int32_t material(position_t * board, int knight_value, int bishop_value, int rook_value, int queen_value);

search_result_t search(full_board_t *board, int32_t alpha, int32_t beta, evaluation_table_t *table, u_int8_t depth);
#endif
