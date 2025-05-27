#include "piece.h"
#include <string.h>

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
	return EMPTY_INDEX;
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

static inline char *black_piece_unicode(piece_type_t piece_type){
	switch (piece_type) {
		case EMPTY_VAL:
			return " ";
		case PAWN_VAL:
			return "\u265F";
		case KNIGHT_VAL:
			return "\u265E";
		case BISHOP_VAL:
			return "\u265D";
		case ROOK_VAL:
			return "\u265C";
		case QUEEN_VAL:
			return "\u265B";
		case KING_VAL:
			return "\u265A";
		default: {
			char *temp = malloc(20);
			sprintf(temp, "%d", piece_type);
			return temp;
		}
	}
}

static inline char *white_piece_unicode(piece_type_t piece_type){
	switch (piece_type) {
		case EMPTY_VAL:
			return " ";
		case PAWN_VAL:
			return "\u2659";
		case KNIGHT_VAL:
			return "\u2658";
		case BISHOP_VAL:
			return "\u2657";
		case ROOK_VAL:
			return "\u2656";
		case QUEEN_VAL:
			return "\u2655";
		case KING_VAL:
			return "\u2654";
		default: {
			char *temp = malloc(20);
			sprintf(temp, "%d", piece_type);
			return temp;
		}
	}
}


char *piece_unicode(piece_t piece){
	if (piece.color == WHITE_VAL) return white_piece_unicode(piece.type);
	else return black_piece_unicode(piece.type);	
}

const char* get_piece_name(piece_type_t type) {
	switch (type) {
		case PAWN_VAL: return "Pawn";
		case BISHOP_VAL: return "Bishop";
		case KNIGHT_VAL: return "Knight";
		case ROOK_VAL: return "Rook";
		case QUEEN_VAL: return "Queen";
		case KING_VAL: return "King";
		default: return 0;
	}
}


void write_name(piece_type_t type, char *buffer){
	switch (type) {
		case PAWN_VAL: strcpy(buffer, "Pawn");
									 break;
		case BISHOP_VAL: strcpy(buffer, "Bishop");
									 break;
		case KNIGHT_VAL: strcpy(buffer, "Knight");
									 break;
		case ROOK_VAL: strcpy(buffer, "Rook");
									 break;
		case QUEEN_VAL: strcpy(buffer, "Queen");
									 break;
		case KING_VAL: strcpy(buffer, "King");
									 break;
		default: strcpy(buffer, "Unknown");
	}
	
}
