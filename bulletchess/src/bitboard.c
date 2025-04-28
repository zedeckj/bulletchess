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



/*
 * forbit (bitboard_t check, bb) {
 *
 * } 
 *
 */

u_int8_t count_bits(bitboard_t bb) {
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





