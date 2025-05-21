#include "bitboard.h"

void print_bitboard(bitboard_t board) {
    int i =0;
    for (bitboard_t rank = RANK_8; i < 8; i++) {
        int j = 0;
        for (bitboard_t file = FILE_A; j < 8; j++) {
        	printf("%d ", board & file & rank ? 1 : 0);
					file = SAFE_RIGHT_BB(file);
				}
        printf("\n");
        rank = BELOW_BB(rank);
    }
    printf("\n");
}


void str_write_bitboard(bitboard_t board, char *buffer) {
		int str_i = 0;
		int i = 0;
    for (bitboard_t rank = RANK_8; i < 8; i++) {
        int j = 0;
        for (bitboard_t file = FILE_A; j < 8; j++) {
					bitboard_t sq_bb = rank & file;
					buffer[str_i++] = (sq_bb & board) ? '1' : '0';
					buffer[str_i++] = ' ';
					file = SAFE_RIGHT_BB(file);
				}
				buffer[str_i++] = '\n';
        rank = BELOW_BB(rank);
    }
		buffer[str_i] = 0;
}


bool serialize_square(square_t square, char * buffer){
	if (!buffer) return false;
	buffer[0] = file_char_of_square(square);
	buffer[1] = rank_char_of_square(square);
	buffer[2] = 0;
	return true;
}

bool serialize_sqr_caps(square_t square, char *buffer) {
	if (serialize_square(square, buffer)) {
		buffer[0] = buffer[0] - 'a' + 'A';
		return true;
	}
	return false;
}


square_t unchecked_bb_to_square(bitboard_t bb){
	switch (bb){
    case SQUARE_TO_BB(A1): return A1;
		case SQUARE_TO_BB(A2): return A2;
		case SQUARE_TO_BB(A3): return A3;
		case SQUARE_TO_BB(A4): return A4;
		case SQUARE_TO_BB(A5): return A5;
		case SQUARE_TO_BB(A6): return A6;
		case SQUARE_TO_BB(A7): return A7;
		case SQUARE_TO_BB(A8): return A8;
		case SQUARE_TO_BB(B1): return B1;
		case SQUARE_TO_BB(B2): return B2;
		case SQUARE_TO_BB(B3): return B3;
		case SQUARE_TO_BB(B4): return B4;
		case SQUARE_TO_BB(B5): return B5;
		case SQUARE_TO_BB(B6): return B6;
		case SQUARE_TO_BB(B7): return B7;
		case SQUARE_TO_BB(B8): return B8;
		case SQUARE_TO_BB(C1): return C1;
		case SQUARE_TO_BB(C2): return C2;
		case SQUARE_TO_BB(C3): return C3;
		case SQUARE_TO_BB(C4): return C4;
		case SQUARE_TO_BB(C5): return C5;
		case SQUARE_TO_BB(C6): return C6;
		case SQUARE_TO_BB(C7): return C7;
		case SQUARE_TO_BB(C8): return C8;
		case SQUARE_TO_BB(D1): return D1;
		case SQUARE_TO_BB(D2): return D2;
		case SQUARE_TO_BB(D3): return D3;
		case SQUARE_TO_BB(D4): return D4;
		case SQUARE_TO_BB(D5): return D5;
		case SQUARE_TO_BB(D6): return D6;
		case SQUARE_TO_BB(D7): return D7;
		case SQUARE_TO_BB(D8): return D8;
		case SQUARE_TO_BB(E1): return E1;
		case SQUARE_TO_BB(E2): return E2;
		case SQUARE_TO_BB(E3): return E3;
		case SQUARE_TO_BB(E4): return E4;
		case SQUARE_TO_BB(E5): return E5;
		case SQUARE_TO_BB(E6): return E6;
		case SQUARE_TO_BB(E7): return E7;
		case SQUARE_TO_BB(E8): return E8;
		case SQUARE_TO_BB(F1): return F1;
		case SQUARE_TO_BB(F2): return F2;
		case SQUARE_TO_BB(F3): return F3;
		case SQUARE_TO_BB(F4): return F4;
		case SQUARE_TO_BB(F5): return F5;
		case SQUARE_TO_BB(F6): return F6;
		case SQUARE_TO_BB(F7): return F7;
		case SQUARE_TO_BB(F8): return F8;
		case SQUARE_TO_BB(G1): return G1;
		case SQUARE_TO_BB(G2): return G2;
		case SQUARE_TO_BB(G3): return G3;
		case SQUARE_TO_BB(G4): return G4;
		case SQUARE_TO_BB(G5): return G5;
		case SQUARE_TO_BB(G6): return G6;
		case SQUARE_TO_BB(G7): return G7;
		case SQUARE_TO_BB(G8): return G8;
		case SQUARE_TO_BB(H1): return H1;
		case SQUARE_TO_BB(H2): return H2;
		case SQUARE_TO_BB(H3): return H3;
		case SQUARE_TO_BB(H4): return H4;
		case SQUARE_TO_BB(H5): return H5;
		case SQUARE_TO_BB(H6): return H6;
		case SQUARE_TO_BB(H7): return H7;
		case SQUARE_TO_BB(H8): return H8;
	}
	return ERR_SQ;
}



u_int8_t count_bits_func(bitboard_t bb) {
	
	u_int8_t count = 0;
	while (bb & -bb) {
		bb &= ~(bb & -bb);
		++count;
	}
	return count;
}

bool square_in_bitboard(bitboard_t board, square_t square) {
	bitboard_t check = SQUARE_TO_BB(square);
	return board & check;
}

bitboard_t file_bb_of_square(square_t sq) {
	bitboard_t bb = SQUARE_TO_BB(sq);
	bitboard_t file = FILE_A;
	for (int i = 0; i < 8; i++) {
		if (file & bb) return file;
		file <<= 1;
	}
	return 0;
}	


bitboard_t rank_bb_of_square(square_t sq) {
	bitboard_t bb = SQUARE_TO_BB(sq);
	bitboard_t rank = RANK_1;
	for (int i = 0; i < 8; i++) {
		if (rank & bb) return rank;
		rank = ABOVE_BB(rank);
	}
	return 0;
}

optional_square_t parse_square(char *str) {
	optional_square_t out;
	out.exists = false;
	if (str && str[0] && str[1]) {
		char file = str[0];
		char rank = str[1];
		if (valid_square_chars(file, rank)) {
			out.exists = true;
		 	out.square = make_square(file, rank);	
		}
	}
	return out;
}


square_t make_square(char file, char rank) {
		if (file > 'a' - 1)
    	return (file - 'a') + ((rank - '1')* 8);
		else 
    	return (file - 'A') + ((rank - '1')* 8);
}

bool valid_square_chars(char file, char rank) {
    return rank >= '1' && rank<= '8' && 
						((file>= 'a' && file<= 'h') 
						 || (file >= 'A' && file <= 'H'));
}

char file_char_of_square(square_t square) {
    return (square % 8) + 'a';
}

char rank_char_of_square(square_t square) {
    return (square / 8) + '1';
}


bitboard_t from_squares(square_t * squares, u_int8_t length) {
	bitboard_t out = 0;
	for (u_int8_t i = 0; i < length; i++) {
		out |= SQUARE_TO_BB(squares[i]);
	}
	return out;
}



optional_square_t bitboard_to_square(bitboard_t bb){
	optional_square_t sq;
	if (bb && !(bb & ~(bb & -bb))){
		for (int i = A1; i <= H8; i++){
			if (bb == SQUARE_TO_BB(i)) {
				sq.square = i;
				sq.exists = true;
				break;
			}
		}
	}
	else sq.exists = false;
	return sq;
}

bitboard_t above_bb(bitboard_t bb) {
	return SAFE_ABOVE_BB(bb);
}

bitboard_t right_bb(bitboard_t bb) {
	return SAFE_RIGHT_BB(bb);
}

bitboard_t left_bb(bitboard_t bb) {
	return SAFE_LEFT_BB(bb);
}
bitboard_t below_bb(bitboard_t bb) {
	return SAFE_BELOW_BB(bb);
}

//TODO: get rid of these
bitboard_t bitboard_or(bitboard_t b1, bitboard_t b2) {
	return b1 | b2;
}

bitboard_t bitboard_and(bitboard_t b1, bitboard_t b2) {
	return b1 & b2;
}

bitboard_t bitboard_not(bitboard_t b1) {
	return ~b1;
}

bitboard_t bitboard_xor(bitboard_t b1, bitboard_t b2) {
	return b1 ^ b2;
}





