#ifndef RULEHEADER
#define RULEHEADER 0
#include "apply.h"


// Checks if the given board is a possible position in a game
// Some examples of features of impossible positions:
// - 9 White Pawns 
// - 2 Black Kings
// - 3 Black Pawns, 6 Black Queens
char * is_legal(full_board_t * board);

// Generates the legal moves for the given position, filling out the 
// given buffer. Returns the number of moves generated
u_int8_t generate_legal_moves(full_board_t * board, move_t * buffer); 

bool is_capture(full_board_t *board, move_t move);

u_int8_t generate_pseudolegal_moves(full_board_t *board, move_t * move_buffer);

// Returns a count of how many moves the given player can make.
// If the opponent is in check, a king capture is considered a move
// and is included in the count
u_int8_t count_legal_moves(full_board_t * board);


// Generates legal moves for only the specified piece type
u_int8_t generate_piece_moves(full_board_t *board, piece_type_t piece, move_t *buffer);


// Counts the number of pieces giving check to the side to move
u_int8_t get_checkers(full_board_t *board);


// Returns true if the given position is stalemate
bool is_stalemate(full_board_t *board);

// Returns true if the given position is checkmate
bool is_checkmate(full_board_t *board);

// Returns true if the given position was repeated n - 1 before. This is 
// checked by undoing the given move stack on a scratch board and comparing.
bool is_nfold_repetition(full_board_t *board, undoable_move_t *move_stack, 
								size_t stack_size, u_int8_t n);


bool is_fivefold_repetition(full_board_t *board, undoable_move_t *stack, size_t stack_size);
bool is_threefold_repetition(full_board_t *board, undoable_move_t *stack, size_t stack_size);




bool is_seventy_five(full_board_t *board);


bool can_claim_fifty(full_board_t *board);

bool board_is_draw(full_board_t *board, undoable_move_t *stack, size_t stack_size);


bool board_is_forced_draw(full_board_t *board, undoable_move_t *stack, size_t stack_size);
// returns true if there is insufficient mating material, a condition for a draw
bool is_insufficient_material(full_board_t * board);

// Returns true if the side to move is in check
bool in_check(full_board_t *board);

move_t san_to_move(full_board_t * board, san_move_t san, char *err);
typedef u_int8_t board_status_t;
#define NO_STATUS 0
#define CHECK_STATUS 1
#define MATE_STATUS 2
#define CHECKMATE_STATUS 3
#define STALEMATE_STATUS 5 // vals are artifact of old implementation
#define INSUFFICIENT_MATERIAL 4
#define FIFTY_MOVE_TIMEOUT 8
#define SEVENTY_FIVE_MOVE_TIMEOUT 16
#define THREE_FOLD_REPETITION 32
#define FIVE_FOLD_REPETITION 64
#define RESIGNATION 128
#define DRAW_STATUS 129
#define FORCED_DRAW_STATUS 130

// Returns the outcome of the game this board is a part of 
board_status_t get_status(full_board_t * board, 
								undoable_move_t * stack,
								u_int16_t stack_size);

// Returns true if the given status is a draw
bool is_draw(board_status_t status);


move_t san_str_to_move(full_board_t *board, char *str, 
		bool *is_err, char *error);



int16_t net_mobility(full_board_t * board);

bool move_to_san_str(full_board_t * board, move_t move, char * buffer);

bitboard_t vertical_attack_mask(bitboard_t bb, bitboard_t non_friendly, bitboard_t empty);

bitboard_t make_attack_mask(full_board_t *board, piece_color_t attacker);

typedef struct {
    // where non kings are allowed to move
    bitboard_t allowed_move_mask;
    // a necessary extra mask for where pawns are allowed to capture 
    // this is to account for en passant weirdness.
    bitboard_t extra_pawn_capture_mask;
    // Number of pieces currently attacking the king
		u_int8_t king_attacker_count;
} check_info_t;



bool has_legal_moves(full_board_t *board);
bool has_moves(
    full_board_t *board, 
    piece_color_t for_color, 
    bitboard_t attacked_mask,
		bitboard_t allowed_origins,
    check_info_t info);


check_info_t make_check_info(full_board_t *board, piece_color_t for_color, bitboard_t attack_mask);

bitboard_t ext_get_pinned_mask(full_board_t *board, square_t square);

bitboard_t white_pawn_attack_mask(bitboard_t white_pawns, bitboard_t enemies_and_ep);
bitboard_t black_pawn_attack_mask(bitboard_t black_pawns, bitboard_t enemies_and_ep);


bitboard_t make_pinned_mask(full_board_t * board, bitboard_t piece_bb, piece_color_t for_color, bitboard_t attack_mask);

#endif

