#ifndef MOVEHEADER
#define MOVEHEADER 0
#include "board.h"
#include "serialization.h"
// The move.c file will not only define moves, but their application to boards

// typedef struct {
//     square_t origin;
//     square_t destination;
// } reg_move_t;

// typedef struct {
//     square_t origin;
//     square_t destination;
//     piece_type_t promote_to;
// } promotion_t;


typedef u_int8_t move_type_t;

#define NULL_MOVE 0
// A Null move signifies a "pass", rather than an error
#define ERROR_MOVE 1
// Signifes an invalid move was parsed
#define GENERIC_MOVE 2
// A move with no information besides that it is not a promotion (UCI limitation)
#define PROMOTION_MOVE 3
// A promotion, resets halfmoves, resets EP (NOTICE PAWN MOVE)
// Following are only from internally generated
#define CASTLING_MOVE 4
// Has all known information that will be generated from finding legal moves
#define FULL_MOVE 5

typedef struct {
    square_t origin;
    square_t destination;

} generic_move_t;

typedef struct {
    generic_move_t body;
    piece_type_t promote_to; 
} promotion_move_t; 

typedef struct {
    generic_move_t body;
    piece_type_t place_type; 
    optional_square_t new_ep_square;
    bool removes_castling;
    bool resets_halfmove;
} full_move_t; 


typedef struct {
    union {
        generic_move_t generic;
        promotion_move_t promotion;
        castling_rights_t castling;
        full_move_t full;
    };
    move_type_t type;
} move_t;

move_t error_move() {
    move_t move;
    move.type = ERROR_MOVE;
    return move;
}

move_t null_move() {
    move_t move;
    move.type = NULL_MOVE;
    return move;
}

generic_move_t move_body(square_t origin, square_t destination){
    generic_move_t generic;
    generic.origin = origin;
    generic.destination = destination;
    return generic;
}

move_t generic_move(generic_move_t body) {
    move_t move;
    move.type = GENERIC_MOVE;
    move.generic = body;
    return move;
}


move_t promotion_move(generic_move_t body, piece_type_t promote_to) {
    move_t move;
    move.type = PROMOTION_MOVE;
    move.promotion.body = body;
    move.promotion.promote_to = promote_to;
    return move;
}

bool is_error_move(move_t move) {
    return move.type == ERROR_MOVE;
}

bool is_null_move(move_t move) {
    return move.type == NULL_MOVE;
}

inline void do_castling(full_board_t * board, square_t king_origin, square_t king_dest, square_t rook_origin, bitboard_t rook_dest);
inline void do_white_kingside(full_board_t *board);
inline void do_white_queenside(full_board_t *board);
inline void do_black_kingside(full_board_t *board);
inline void do_black_quenside(full_board_t *board);
// Aplies a move to the given board
bool apply_move(full_board_t *board, move_t move);

// Parses a UCI formatted string into a move_t, returns an Error move
// if the given string is ill-formatted
move_t parse_uci(char * uci_str);

// Writes the given move's UCI representation to a provided buffer of length 6
// Returns false if given an invalid move.
bool write_uci(move_t move, char * buffer);

move_t generate_pseudo_legal_move_from_square(full_board_t *board, square_t origin);

move_t generate_pseudo_legal_move(full_board_t *board);

typedef struct {
    bitboard_t * kings_moves;
    bitboard_t * knights_moves;
    // bitboard_t * straight_moves;
    // bitboard_t * diagonal_moves;

} moveable_table_t;


// moveable_table_t *move_table;


// // Initializes the global move table if it is not already
// void prepare_move_table();



#endif