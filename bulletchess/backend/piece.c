#include "piece.h"

piece_type_t get_rook_val(){
    return ROOK_VAL;
}

piece_type_t get_knight_val(){
    return KNIGHT_VAL;
}

piece_type_t get_pawn_val(){
    return PAWN_VAL;
}

piece_type_t get_queen_val(){
    return QUEEN_VAL;
}

piece_type_t get_king_val(){
    return KING_VAL;
}

piece_type_t get_bishop_val(){
    return BISHOP_VAL;
}

piece_type_t get_empty_val() {
  return EMPTY_VAL;
}

piece_type_t get_error_val() {
  return ERROR_VAL;
}


piece_color_t get_white_val() {
    return WHITE_VAL;
}

piece_color_t get_black_val() {
    return BLACK_VAL;
}


bool piece_is_type(piece_t piece, piece_type_t type){
    return piece.type == type;
}


bool piece_is_color(piece_t piece, piece_color_t color){
    return piece.color == color;
}


bool same_color(piece_t piece1, piece_t piece2) {
    return piece1.color == piece2.color;
}

bool same_type(piece_t piece1, piece_t piece2) {
    return piece1.type == piece2.type;
}

bool pieces_equal(piece_t piece1, piece_t piece2) {
    return (
        piece1.type == piece2.type &&
        piece1.color == piece2.color
    );
}

u_int64_t hash_piece(piece_t piece){
    return piece.type + (piece.color << 4);
}

piece_t error_piece(){
    piece_t piece;
    piece.type = ERROR_VAL;
    return piece;
}



piece_t empty_piece(){
    piece_t piece;
    piece.type = EMPTY_VAL;
    return piece;
}

piece_t white_piece(piece_type_t type){
    piece_t piece;
    piece.color = WHITE_VAL;
    piece.type = type;
    return piece;
}

piece_t black_piece(piece_type_t type){
    piece_t piece;
    piece.color = BLACK_VAL;
    piece.type = type;
    return piece;
}



bool piece_is_empty(piece_t piece) {
    return piece.color == EMPTY_VAL;
}

