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
        (piece1.type == EMPTY_VAL &&
				piece2.type == EMPTY_VAL) ||
				(piece1.type == piece2.type &&
        piece1.color == piece2.color)
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


piece_index_t piece_to_index(piece_t piece) {
	if (piece.type == EMPTY_VAL) return EMPTY_INDEX;
	u_int8_t index = 0;
	if (piece.color == BLACK_VAL) index = BLACK_OFFSET;
	switch (piece.type) {
		case PAWN_VAL:
		return index + PAWN_INDEX; 
		case KNIGHT_VAL:
		return index + KNIGHT_INDEX;
	  case BISHOP_VAL:
		return index + BISHOP_INDEX;
		case ROOK_VAL:
		return index + ROOK_INDEX;
		case QUEEN_VAL:
		return index + QUEEN_INDEX;
		case KING_VAL:
		return index + KING_INDEX;
	}
}


piece_t index_to_piece(piece_index_t index){
	if (index == EMPTY_INDEX) return empty_piece();
	piece_t piece;
	u_int8_t type_index = (index - 1) % BLACK_OFFSET;
	switch (type_index + 1)	{
		case PAWN_INDEX:
		piece.type = PAWN_VAL;
		break;
		case KNIGHT_INDEX:
		piece.type = KNIGHT_VAL;
		break;
		case BISHOP_INDEX:
		piece.type = BISHOP_VAL;
		break;
		case ROOK_INDEX:
		piece.type = ROOK_VAL;
		break;
		case QUEEN_INDEX:
		piece.type = QUEEN_VAL;
		break;
		case KING_INDEX:
		piece.type = KING_VAL;
		break;
	}
	piece.color = type_index + 1 == index ? WHITE_VAL : BLACK_VAL;
	return piece;
}

