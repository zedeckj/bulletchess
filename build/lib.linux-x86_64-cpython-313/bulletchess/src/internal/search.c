#include "search.h"

// Calculates the material advantage of white versus black, measured in centipawns. A positive material calculation indicates an
// advantage for white.
/*
int material(position_t * position, int knight_value, int bishop_value, int rook_value, int queen_value) {
    piece_counts_t counts = count_pieces(position);
    int white_value = 100 * counts.white_pawns 
                      + knight_value * counts.white_knights 
                      + knight_value * counts.white_bishops 
                      + rook_value * counts.white_rooks 
                      + queen_value * counts.white_queens;
    int black_value = 100 * counts.black_pawns 
                      + knight_value * counts.black_knights 
                      + bishop_value * counts.black_bishops
                      + rook_value * counts.black_rooks 
                      + queen_value * counts.black_queens;
    return white_value - black_value;
}


// int basic_eval(full_board_t * board, u_int8_t allowed_moves_count) {
//     float eval = 0;
//     if (!allowed_moves_count) {
//         bool c = in_check(board, board->turn);
//         if (c) {
//             eval = board->turn == BLACK_VAL ? MAX_EVAL : MIN_EVAL;
//         }
//     }
//     else {
//         return material(board->position, 300, 300, 500, 900);
//     }
// }


int8_t endgame_factor(full_board_t * board) {
    position_t * position;
    bitboard_t hostile;
    u_int8_t factor = 100;
    if (board->turn == WHITE_VAL) hostile = position->black_oc;
    else hostile = position->white_oc;
    if (position->queens & hostile) factor -= 50;
    if (position->rooks & hostile) factor -= 30;
    if (position->knights & hostile) factor -= 10;
    if (position->bishops & hostile) factor -= 10;
    return factor;
}

int32_t evaluate(full_board_t * board, u_int8_t move_count, evaluation_table_t *table) {
    int32_t eval;
    bool check = in_check(board);
    int8_t endgame_coeff = endgame_factor(board);
    if (!move_count) {
        if (check) {
            return board->turn == WHITE_VAL ? 0 - table->checkmate_value : table->checkmate_value;
        } 
        return 0;
    }
    else {
        u_int64_t color_specific = 0;
        position_t * position = board->position;
        eval = 0;
        if (check) color_specific -= table->check_value;
        for (square_t square = A1; square <= H8; square++) {
             bitboard_t bb = SQUARE_TO_BB(square);
                if (bb & position->white_oc) {
                    if (bb & position->pawns) {
                        eval += table->pawn_value;
                        eval += table->white_pawn[square];
                    }
                    else if (bb & position->knights) {
                        eval += table->knight_value;
                        eval += table->white_knight[square];
                    }
                    else if (bb & position->bishops) {
                        eval += table->bishop_value;
                        eval += table->white_bishop[square];
                    }
                    else if (bb & position->rooks) {
                        eval += table->rook_value;
                        eval += table->white_rook[square];
                    }
                    else if (bb & position->queens) {
                        eval += table->queen_value;
                        eval += table->white_queen[square];
                    }
                    else {
                        int32_t king_eval;
                        king_eval = endgame_coeff * table->white_king_endgame[square];
                        king_eval += (100 - endgame_coeff) * table->white_king[square];
                        eval += king_eval / 100;
                    }
                }
                else if (bb & position->black_oc){
                    if (bb & position->pawns) {
                        eval -= table->pawn_value;
                        eval -= table->black_pawn[square]; 
                    }
                    else if (bb & position->knights) {
                        eval -= table->knight_value;
                        eval -= table->black_knight[square];
                    }
                    else if (bb & position->bishops) {
                        eval -= table->bishop_value;
                        eval -= table->black_bishop[square];
                    }
                    else if (bb & position->rooks) {
                        eval -= table->rook_value;
                        eval -= table->black_rook[square];
                    }
                    else if (bb & position->queens) {
                        eval -= table->queen_value;
                        eval -= table->black_queen[square];
                    }
                    else {
                        int32_t king_eval;
                        king_eval = endgame_coeff * table->black_king_endgame[square];
                        king_eval -= (100 - endgame_coeff) * table->black_king[square];
                        eval -= king_eval / 100;
                    }
                }
            }
        if (board->turn == WHITE_VAL) eval += color_specific;
        else eval -= color_specific;
        return eval;
    }
}

search_result_t search(full_board_t *board, int32_t alpha, int32_t beta, evaluation_table_t * table, u_int8_t depth) {
    move_t moves[256];
    u_int8_t count = generate_legal_moves(board, moves);
    if (depth == 0 || count == 0) {
        search_result_t result;
        result.eval = evaluate(board, count, table);
        return result;
    }
    else {
       int32_t best_eval;
        u_int8_t best_i = 0;
        if (board->turn == WHITE_VAL) {
            best_eval = MIN_EVAL;
            for (u_int8_t i = 0; i < count; i++) {
                position_t position;
                full_board_t copy;
                copy.position = &position;
                copy_into(&copy, board);
                apply_move(&copy, moves[i]);
                search_result_t result = search(&copy, alpha, beta, table, depth - 1);
                if (result.eval > best_eval) {
                    best_eval = result.eval;
                    best_i = i;
                }
                if (result.eval > alpha) alpha = result.eval;
                if (result.eval >= beta) break;
            }
        }
        else {
            best_eval = MAX_EVAL;
            for (u_int8_t i = 0; i < count; i++) {
                position_t position;
                full_board_t copy;
                copy.position = &position;
                copy_into(&copy, board);
                apply_move(&copy, moves[i]);
                search_result_t result = search(&copy, alpha, beta, table, depth - 1);
                if (result.eval < best_eval) {
                    best_eval = result.eval;
                    best_i = i;
                }
                if (result.eval < beta) beta = result.eval;
                if (result.eval <= alpha) break;
            }
        }
        search_result_t result;
        result.eval = best_eval;
        result.move = moves[best_i];
        return result;
    }
}


search_result_t search_wrapper(full_board_t * board, evaluation_table_t * table, u_int8_t depth) {
    printf("checkmate value %d %d\n", 0-table->checkmate_value, table->checkmate_value);
    return search(board, 0- table->checkmate_value, table->checkmate_value, table, depth);
 }
*/
