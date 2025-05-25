#ifndef HASHHEADERCHESS 
#define HASHHEADERCHESS 0
#include <inttypes.h>
#include <stdlib.h>
#include "board.h"


// A struct used to hash boards
typedef struct {  
    u_int64_t ** square_piece_rands; 
    u_int64_t white_to_move_rand;
    u_int64_t black_to_move_rand;
		u_int64_t * castling_rights_rands;
    u_int64_t * en_passant_rands;
    u_int64_t halfmove_rand_coeff;
    u_int64_t fullmove_rand_coeff;
} zobrist_table_t;

// Allocates and creates a zobrist table, which is used to hash boards
zobrist_table_t *create_zobrist_table();

// Returns a hash of the given board
u_int64_t hash_board(full_board_t *board, zobrist_table_t * table);


void fill_zobrist_table(zobrist_table_t *table);

void print_table(zobrist_table_t *table);
#endif
