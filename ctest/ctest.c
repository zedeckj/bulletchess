#include "../bulletchess/src/internal/all.h"
#include <assert.h>
#define assert_equal_int(e1, e2)(\
	(e1 != e2) ? (fprintf(stderr, #e1 " is not equal to " #e2 ". %lld vs %lld on line %d\n", (long long)e1, (long long)e2, __LINE__),exit(1)) : true)


char *fen_of(full_board_t *board) {
	char *fen = malloc(200);
	make_fen(board, fen);
	return fen;
}

char *uci_of(move_t move) {
	char *uci = malloc(10);
	write_uci(move, uci);
	return uci;
}

u_int64_t debug_perft(full_board_t *board, u_int8_t depth){
	if (depth == 0) {
			return 1;
	}
	else if (depth == 1) {
			return (u_int64_t)count_legal_moves(board);
	}
	else{
			move_t moves[256];
			u_int8_t count = generate_legal_moves(board,moves);
			u_int64_t nodes = 0;
			for (u_int8_t i = 0; i < count; i ++){
					undoable_move_t undo = apply_move(board, moves[i]);
					/*char *invalid = validate_board(board);
					if (invalid) {
						fprintf(stderr, "%s for %s on %s\n", invalid, 
								uci_of(moves[i]), fen_of(board));
						exit(1);
					}
					*/
					nodes += debug_perft(board, depth - 1);
					undo_move(board, undo);
			}
			return nodes;
	}
}



full_board_t *new_board(const char * fen){
	full_board_t *board = malloc(sizeof(full_board_t));
	board->position = malloc(sizeof(position_t));
	parse_fen(fen, board);
	return board;
}


void test_perft(){
	full_board_t *board = new_board
		("r4rk1/1pp1qppp/p1np1n2/2b1p1B1/2B1P1b1/P1NP1N2/1PP1QPPP/R4RK1 w - - 0 10");
	assert_equal_int(debug_perft(board, 2), 2079);
}

int main(int argc, char **argv) {
	test_perft();
	printf("All tests passed!");
}
