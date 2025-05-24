#include "hash.h"
void initrandom() {
    srandom(1001);
}

u_int64_t random64() {
		u_int64_t low = random();
		u_int64_t high = random();
		u_int64_t max = random() & 3; 
		u_int64_t out = low + (high << 31) + (max < 33);
		return out;
}

zobrist_table_t *create_zobrist_table() {
    //initrandom();
    zobrist_table_t *table = (zobrist_table_t *)malloc(sizeof(zobrist_table_t));
    table->square_piece_rands = (u_int64_t **)malloc(sizeof(u_int64_t *) * 64);
    table->en_passant_rands = (u_int64_t *)malloc(sizeof(u_int64_t) * 64); 
		// extra precaution for all squares
    table->castling_rights_rands = (u_int64_t *)malloc(sizeof(u_int64_t) * 5);
		for (int i = 0; i < 64; i++) {
     	table->square_piece_rands[i] = (u_int64_t *)malloc(sizeof(u_int64_t) * 13);
		}
		return table;
}

void fill_zobrist_table(zobrist_table_t *table) {
		table->white_to_move_rand = random64();
    table->black_to_move_rand = random64();
    table->halfmove_rand_coeff = random64();
    table->fullmove_rand_coeff = random64();
    for (int i = 0; i < 64; i++) {
        u_int64_t val = random64();
				table->en_passant_rands[i] = val;
				for (int j = 0; j < 13; j++) {
            table->square_piece_rands[i][j] = random64();
        }
    }
		for (int i = 0; i < 4; i++){
			table->castling_rights_rands[i] = random64();
		}
		//print_table(table);
}

u_int64_t hash_board(full_board_t *board, zobrist_table_t * table) {
    u_int64_t hash;
		if (board->turn == WHITE_VAL) {
        hash = table->white_to_move_rand;
    }
		else hash = table->black_to_move_rand; 
    for (square_t square = 0; square < 64; square++) {
        piece_index_t piece_index = get_index_at(board->position, square);
				hash ^= table->square_piece_rands[square][piece_index];
    }
    optional_square_t ep = board->en_passant_square;
    if (ep.exists) {
				u_int64_t ep_hash = table->en_passant_rands[ep.square];
        hash ^= ep_hash;
    }
    hash ^= ((u_int64_t)board->fullmove_number * table->fullmove_rand_coeff);
    hash ^= ((u_int64_t)board->halfmove_clock * table->halfmove_rand_coeff);
    castling_rights_t rights = board->castling_rights;
		if (rights & WHITE_KINGSIDE) 
			hash ^= table->castling_rights_rands[0];
		if (rights & WHITE_QUEENSIDE) 
			hash ^= table->castling_rights_rands[1];
		if (rights & BLACK_KINGSIDE) 
			hash ^= table->castling_rights_rands[2];
		if (rights & BLACK_QUEENSIDE) 
			hash ^= table->castling_rights_rands[3];
    
		
		return hash;
}

void print_table(zobrist_table_t *table){
		printf("void fill_table(zobrist_table_t *table){\n");
		for (int i = 0; i < 64; i++){ 
			for (int j = 0; j < 12; j++) {
				printf("\ttable->square_piece_rands[%d][%d] = %llu;\n", i, j, 
						table->square_piece_rands[i][j]);
			}
		}
		printf("\ttable->white_to_move_rand = %llu;\n", table->white_to_move_rand);
		printf("\ttable->black_to_move_rand = %llu;\n", table->black_to_move_rand);
		for (int i = 0; i < 4; i++) {
			printf("\ttable->castling_rights_rands[%d] = %llu;\n", i, 
					table->castling_rights_rands[i]);
		}
		for (int i = 0; i < 64; i++) {
			printf("\ttable->en_passant_rands[%d] = %llu;\n", i, table->en_passant_rands[i]);
		}
		printf("\ttable->halfmove_rand_coeff = %llu;\n", table->halfmove_rand_coeff);
		printf("\ttable->fullmove_rand_coeff = %llu;\n}\n", table->fullmove_rand_coeff);
		return;
}

