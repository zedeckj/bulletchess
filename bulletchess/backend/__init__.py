import os
from ctypes import *

path = os.path.dirname(os.path.abspath(__file__))
clib = CDLL(path + "/chess_c.so")

BITBOARD = c_uint64
PIECE_TYPE = c_uint8
COLOR = c_uint8
SQUARE = c_uint8
CASTLING_RIGHTS = c_uint8
TURN_CLOCK = c_uint16

PIECE_INDEX = c_uint8
OUTCOME = c_uint8

class OPTIONAL_SQUARE(Structure):

    _fields_ = [
        ("square", SQUARE),
        ("exists", c_bool),
    ]

class _POSITION(Structure):

    """
    Represents the pieces on a Board.
    """

    _fields_ = [
        ("pawns", BITBOARD),
        ("knights", BITBOARD),
        ("bishops", BITBOARD),
        ("rooks", BITBOARD),
        ("queens", BITBOARD),
        ("kings", BITBOARD),
        ("white_oc", BITBOARD),
        ("black_ok", BITBOARD),
    ]


class _ZOBRIST_TABLE(Structure):

    _fields_ = [
        ("square_piece_rands", POINTER(POINTER(c_uint64))),
        ("white_to_move_rand", c_uint64),
        ("castling_rights_rands", POINTER(c_uint64)),
        ("en_passant_rands", POINTER(c_uint64)),
        ("halfmove_rand_coeff", c_uint64),
        ("fullmove_rand_coeff", c_uint64),
    ]

class _SPLIT_FEN(Structure):

    _fields_ = [
        ("position_str", c_char_p),
        ("turn_str", c_char_p),
        ("castling_str", c_char_p),
        ("ep_str", c_char_p),
        ("halfmove_str", c_char_p),
        ("fullmove_str", c_char_p),
    ]

class _GENERIC_MOVE(Structure):
    _fields_ = [
        ("origin", SQUARE),
        ("destination", SQUARE),
    ]

class _PROMOTION_MOVE(Structure):
    _fields_ = [
        ("body", _GENERIC_MOVE),
        ("promote_to", PIECE_TYPE),
    ]

class _FULL_MOVE(Structure):
    _fields_ = [
        ("body", _GENERIC_MOVE),
        ("place_type", PIECE_TYPE),
        ("new_ep_square", OPTIONAL_SQUARE),
        ("removes_castling", c_bool),
        ("resets_halfmove", c_bool),
    ]

class MOVE_UNION(Union):
    _fields_ = [
        ("generic", _GENERIC_MOVE),
        ("promotion", _PROMOTION_MOVE),
    ]

class _PIECE(Structure):
    _fields_ = [
        ("color", COLOR),
        ("type", PIECE_TYPE)
    ]

    def __hash__(self):
        return int(_hash_piece(self)) 

    def __eq__(self, other : "_PIECE"):
        return bool(_pieces_equal(self, other))

class MOVE(Structure):
    _anonymous_ = ("u",)
    _fields_ = [
        ("u", MOVE_UNION),
        ("type", c_uint8),
    ]

class UNDOABLE_MOVE(Structure):
    _fields_ = [
        ("move", MOVE),
        ("captured_piece", _PIECE),
        ("old_castling_rights", CASTLING_RIGHTS),
        ("was_castling", CASTLING_RIGHTS),
        ("old_en_passant", OPTIONAL_SQUARE),
        ("old_halfmove", TURN_CLOCK)
    ]

class BOARD(Structure):
    _fields_ = [
        ("position", POINTER(_POSITION)),
        ("turn", COLOR),
        ("castling_rights", CASTLING_RIGHTS),
        ("en_passant_square", OPTIONAL_SQUARE),
        ("halfmove_clock", TURN_CLOCK),
        ("fullmove_number", TURN_CLOCK),
    ]

class _PIECE_PATTERN_UNION(Union):

    _fields_ = [
        ("count", c_uint8),
        ("bitboard", BITBOARD)
    ]

class _PIECE_PATTERN(Structure):

    _anonymous_ = ("u",)

    _fields_ = [
        ("piece", _PIECE),
        ("type", c_uint8),
        ("u", _PIECE_PATTERN_UNION)
    ]


class _DATE(Structure):
    _fields_ = [
        ("known_year", c_int, 1),
        ("year", c_uint16),

        ("known_month", c_int,1),
        ("month", c_uint8),

        ("known_day", c_int, 1),
        ("month", c_uint8)
    ]

class _OPT_U8(Structure):
    _fields_ = [
        ("exists", c_bool),
        ("value", c_uint8),
    ]


class _SAN_STD(Structure):
    _fields_ = [
        ("moving_piece", PIECE_TYPE),
        ("from_file", _OPT_U8),
        ("from_rank", _OPT_U8),
        ("is_capture", c_bool),
        ("destination", SQUARE),
    ]


class _SAN_PAWN_PUSH(Structure):
    _fields_ = [
        ("from_file", _OPT_U8),
        ("from_rank", _OPT_U8),
        ("destination", SQUARE),
        ("promote_to", PIECE_TYPE),
    ]

class _SAN_PAWN_CAPTURE(Structure):
    _fields_ = [
        ("from_file", c_uint8),
        ("from_rank", _OPT_U8),
        ("destination", SQUARE),
        ("piece_type_t", PIECE_TYPE),
    ]

class _SAN_UNION(Union):
    _fields_ = [
        ("std_move", _SAN_STD),
        ("pawn_push", _SAN_PAWN_PUSH),
        ("pawn_capture", _SAN_PAWN_CAPTURE),
        ("castling_kingside", c_bool)
    ]

class _SAN_MOVE(Structure):

    _anonymous_ = ("u",)

    _fields_ = [
       ("u", _SAN_UNION),
       ("type", c_uint8),
       ("ann_type", c_uint8),
       ("check_status", c_uint8)
    ]
class _PGN_TAGS(Structure):
    
    _fields_ = [
        ("event", c_char_p),
        ("site", c_char_p),
        ("date", c_char_p),
        ("round", c_char_p),
        ("white_player", c_char_p),
        ("black_player", c_char_p),
        ("result", c_char_p),
        ("FEN", c_char_p)
    ]


class PGN(Structure):

    _fields_ = [
        ("tags", _PGN_TAGS),
        ("moves", POINTER(_SAN_MOVE)),
        ("count", c_uint16)
    ]

def charp_to_str(c : c_char_p) -> str:
    return c.raw.rstrip(b'\x00').decode()

def init_pgn() -> POINTER(PGN):
    LINE_LEN = 256
    pgn = PGN()
    pgn.moves = (_SAN_MOVE * 300)()
    pgn.count = 300
    pgn.tags = _PGN_TAGS()
    pgn.tags.event = cast(create_string_buffer(255), c_char_p)
    pgn.tags.site = cast(create_string_buffer(255), c_char_p)
    pgn.tags.date = cast(create_string_buffer(20), c_char_p)
    pgn.tags.round = cast(create_string_buffer(20), c_char_p)
    pgn.tags.white_player = cast(create_string_buffer(255), c_char_p)
    pgn.tags.black_player = cast(create_string_buffer(255), c_char_p)
    pgn.tags.FEN = cast(create_string_buffer(100), c_char_p)
    pgn.tags.result = cast(create_string_buffer(10), c_char_p) 
    return pointer(pgn)

def alloc_boardPY() -> POINTER(BOARD):
    pos = pointer(_POSITION())
    board = pointer(BOARD(pos))
    return board


def next_pgnPY(fp : c_void_p) -> POINTER(PGN):
    pgn = init_pgn()
    err = create_string_buffer(255)
    has_err = not next_pgn(fp, pgn, err)
    if has_err:
        raise Exception(charp_to_str(err))
    return pgn

def init_empty_boardPY() -> POINTER(BOARD):
    pos_pointer = pointer(_POSITION(
        0,0,0,0,0,0,0,0
    ))
    castling_rights = NO_CASTLING_RIGHTS  
    en_passant = OPTIONAL_SQUARE(0, 0)
    turn = WHITE
    halfmove = TURN_CLOCK(0)
    fullmove = TURN_CLOCK(1)
    full_board = BOARD(
        pos_pointer,
        turn,
        castling_rights,
        en_passant,
        halfmove,
        fullmove,
    )
    return pointer(full_board)



def init_starting_boardPY() -> POINTER(BOARD):
    pos_pointer = pointer(_POSITION(
        PAWNS_STARTING, 
        KNIGHTS_STARTING, 
        BISHOPS_STARTING, 
        ROOKS_STARTING, 
        QUEENS_STARTING,
        KINGS_STARTING,
        WHITE_STARTING,
        BLACK_STARTING
    ))
    castling_rights = STARTING_CASTLING_RIGHTS
    en_passant = OPTIONAL_SQUARE(0, 0)
    turn = WHITE
    halfmove = TURN_CLOCK(0)
    fullmove = TURN_CLOCK(1)
    full_board = BOARD(
        pos_pointer,
        turn,
        castling_rights,
        en_passant,
        halfmove,
        fullmove,
    )
    return pointer(full_board)


def encode(fen) -> bytes:
    return fen.encode("utf-8")





def init_board_from_fenPY(fen : str) -> tuple[POINTER(BOARD), bytes]:
    pos_pointer = pointer(_POSITION())
    board = pointer(BOARD(pos_pointer))
    piece_array = bytes(64)
    error = parse_fen(encode(fen), board, piece_array)
    if error == None:
        return board, piece_array
    else:
        error = bytes(error).decode()
        raise ValueError(f"Invalid FEN '{fen}': {error}")


def san_to_movePY(board : POINTER(BOARD), san : str) -> MOVE:
    err = c_bool(False)
    struct = san_to_move(board, san.encode("utf-8"), byref(err))
    if err:
        raise ValueError(f"Invalid Move SAN: {san}")
    return struct




def init_move_from_uciPY(uci : str) -> MOVE:
    err = c_bool(False)
    struct = MOVE()
    err = parse_uci(uci.encode("utf-8"), byref(struct)) 
    if err:
        raise ValueError(err.rstrip(b'\x00 ').decode().format(uci = uci))
    return struct

def make_fenPY(board : POINTER(BOARD)) -> str:
    fen = create_unicode_buffer(200)
    l = make_fen(board, fen)
    return fen[:l-1]

def make_board_stringPY(board : POINTER(BOARD)) -> str:
    str_buffer = create_string_buffer(300)
    fill_board_string(board, str_buffer)
    return str_buffer.raw.rstrip(b'\x00 ').decode()

def write_uciPY(struct : MOVE) -> str:
    uci = create_string_buffer(6)
    write_uci(struct, uci)
    return uci.raw.rstrip(b'\x00').decode()

def pointer_write_uciPY(pointer : POINTER(MOVE), index : c_uint64) -> str:
    uci = create_string_buffer(6)
    pointer_write_uci(pointer, index, uci)
    return uci.raw.rstrip(b'\x00').decode()


def write_bitboardPY(bitboard : BITBOARD) -> str:
    s = create_string_buffer(137)
    write_bitboard(bitboard, s)
    return s.raw.rstrip(b'\x00 ').decode()

def make_piece_arrayPY(board : POINTER(BOARD)) -> _PIECE * 64:
    array = (_PIECE * 64)()
    fill_piece_list(board, array)
    return array

def construct_movePY(origin : SQUARE, destination : SQUARE, promote_to : PIECE_TYPE):
    struct = MOVE();
    err = ext_construct_move(origin, destination, promote_to, byref(struct))
    if err:
        return bytes(err).rstrip(b'\x00').decode("utf-8")
    return struct

piece_from_string = clib.piece_from_string
piece_from_string.argtypes = [c_char_p]
piece_from_string.restype = _PIECE


# _material = clib.material
# _material.restype = c_int
# _material.argtypes = [POINTER(_POSITION), c_int, c_int, c_int, c_int]

get_piece_at = clib.get_piece_at_board
get_piece_at.restype = c_uint8
get_piece_at.argtypes = [POINTER(BOARD), SQUARE]


is_quiescent = clib.is_quiescent
is_quiescent.argtypes = [POINTER(BOARD)]
is_quiescent.restype = c_bool

set_piece_index = clib.set_piece_index
set_piece_index.argtypes = [POINTER(BOARD), c_char_p, SQUARE, PIECE_INDEX]

delete_piece_at = clib.delete_piece_at_board
delete_piece_at.argtypes = [POINTER(BOARD), c_char_p, SQUARE]

get_pawn_value = clib.get_pawn_val
get_pawn_value.restype = PIECE_TYPE

get_knight_value = clib.get_knight_val
get_knight_value.restype = PIECE_TYPE

get_bishop_value = clib.get_bishop_val
get_bishop_value.restype = PIECE_TYPE

get_rook_value = clib.get_rook_val
get_rook_value.restype = PIECE_TYPE

get_king_value = clib.get_king_val
get_king_value.restype = PIECE_TYPE

get_queen_value = clib.get_queen_val
get_queen_value.restype = PIECE_TYPE

get_white_value = clib.get_white_val
get_white_value.restype = COLOR

get_black_value = clib.get_black_val
get_black_value.restype = COLOR

get_empty_value = clib.get_empty_val
get_empty_value.restype = PIECE_TYPE

get_error_value = clib.get_error_val
get_error_value.restype = PIECE_TYPE

piece_is_type = clib.piece_is_type
piece_is_type.restype = c_bool
piece_is_type.argtypes = [_PIECE, PIECE_TYPE]

piece_is_empty = clib.piece_is_empty
piece_is_empty.restype = c_bool
piece_is_empty.argtypes = [_PIECE]

piece_is_color = clib.piece_is_color
piece_is_color.restype = c_bool
piece_is_color.argtypes = [_PIECE, COLOR]


piece_symbol = clib.piece_symbol
piece_symbol.restype = c_char
piece_symbol.argtypes = [_PIECE]

pieces_equal = clib.pieces_equal
pieces_equal.restype = c_bool
pieces_equal.argtypes = [_PIECE, _PIECE]

same_color = clib.same_color
same_color.restype = c_bool
same_color.argtypes = [_PIECE, _PIECE]

same_type = clib.same_type
same_type.restype = c_bool
same_type.argtypes = [_PIECE, _PIECE]

hash_piece = clib.hash_piece
hash_piece.restype = c_int64
hash_piece.argtypes = [_PIECE]

has_kingside_castling_rights  = clib.has_kingside_castling_rights
has_kingside_castling_rights.restype = c_bool
has_kingside_castling_rights.argtypes = [POINTER(BOARD), COLOR]

has_queenside_castling_rights = clib.has_queenside_castling_rights
has_queenside_castling_rights.restype = c_bool
has_queenside_castling_rights.argtypes = [POINTER(BOARD), COLOR]

has_castling_rights = clib.has_castling_rights
has_castling_rights.restype = c_bool 
has_castling_rights.argtypes = [POINTER(BOARD), COLOR]


clear_castling_rights = clib.clear_castling_rights
clear_castling_rights.argtypes = [POINTER(BOARD), COLOR]

set_full_castling_rights = clib.set_full_castling_rights
set_full_castling_rights.argtypes = [POINTER(BOARD)]

update_castling_rights = clib.update_castling_rights
update_castling_rights.argtypes = [POINTER(BOARD), COLOR]

update_all_castling_rights = clib.update_all_castling_rights
update_all_castling_rights.argtypes = [POINTER(BOARD)]

contains_piece = clib.contains_piece_index
contains_piece.argtypes = [POINTER(BOARD), PIECE_INDEX]
contains_piece.restype = c_bool

is_subset = clib.is_subset
is_subset.argtypes = [POINTER(_POSITION), POINTER(_POSITION)]
is_subset.restype = c_bool

boards_equal = clib.boards_equal
boards_equal.argtypes = [POINTER(BOARD), POINTER(BOARD)]
boards_equal.restype = c_bool


create_zobrist_table = clib.create_zobrist_table
create_zobrist_table.restype = POINTER(_ZOBRIST_TABLE)

hash_board = clib.hash_board
hash_board.argtypes = [POINTER(BOARD), POINTER(_ZOBRIST_TABLE)]
hash_board.restype = c_uint64

def hash_board_wrapper(board : POINTER(BOARD)): 
    return hash_board(board, ZOBRIST_TABLE)

add_castling_rights = clib.add_castling_rights
add_castling_rights.argtypes = [POINTER(BOARD), c_bool, COLOR]

clear_ep_square = clib.clear_ep_square
clear_ep_square.argtypes = [POINTER(BOARD)]

set_ep_square_checked = clib.set_ep_square_checked
set_ep_square_checked.argtypes = [POINTER(BOARD), SQUARE]
set_ep_square_checked.restype = c_char_p

make_fen = clib.make_fen
make_fen.argtypes = [POINTER(BOARD), c_wchar_p]
make_fen.restype = c_uint8

parse_fen = clib.parse_fen
parse_fen.argtypes = [c_char_p, POINTER(BOARD), c_char_p]
parse_fen.restype = c_char_p

parse_uci = clib.parse_uci
parse_uci.argtypes = [c_char_p, POINTER(MOVE)]
parse_uci.restype = c_char_p

write_uci = clib.write_uci
write_uci.argtypes = [MOVE, c_char_p]
write_uci.restype = c_bool


is_error_move = clib.is_error_move
is_error_move.argtypes = [MOVE]
is_error_move.restype = c_bool

is_null_move = clib.is_null_move
is_null_move.argtypes = [MOVE]
is_null_move.restype = c_bool

apply_move = clib.apply_move
apply_move.argtypes = [POINTER(BOARD), MOVE]
apply_move.restype = UNDOABLE_MOVE

undo_move = clib.undo_move
undo_move.argtypes = [POINTER(BOARD), UNDOABLE_MOVE]

# _generate_pseudo_legal_moves = clib.generate_pseudo_legal_moves
# _generate_pseudo_legal_moves.argtypes = [POINTER(BOARD), COLOR, POINTER(MOVE)]
# _generate_pseudo_legal_moves.restype = c_uint8

generate_legal_moves = clib.generate_legal_moves
generate_legal_moves.argtypes = [POINTER(BOARD), POINTER(MOVE)]
generate_legal_moves.restype = c_uint8

fill_board_string = clib.fill_board_string
fill_board_string.argtypes = [POINTER(BOARD), c_char_p]

make_attack_mask = clib.make_attack_mask
make_attack_mask.argtypes = [POINTER(BOARD), COLOR]
make_attack_mask.restype = BITBOARD

in_check = clib.in_check
in_check.argtypes = [POINTER(BOARD)]
in_check.restype = c_bool

copy_into = clib.copy_into
copy_into.argtypes = [POINTER(BOARD), POINTER(BOARD)]

debug_print_board = clib.debug_print_board
debug_print_board.argtypes = [POINTER(BOARD)]

print_bitboard = clib.print_bitboard
print_bitboard.argtypes = [BITBOARD]

perft = clib.perft
perft.argtypes = [POINTER(BOARD), c_uint8]
perft.restype = c_uint64


pseudo_perft = clib.pseudo_perft
pseudo_perft.argtypes = [POINTER(BOARD), c_uint8]
pseudo_perft.restype = c_uint64


get_origin = clib.get_origin
get_origin.argtypes = [MOVE]
get_origin.restype = SQUARE

get_destination = clib.get_destination
get_destination.argtypes = [MOVE]
get_destination.restype = SQUARE

is_promotion = clib.is_promotion
is_promotion.argtypes = [MOVE]
is_promotion.restype = c_bool

promotes_to = clib.promotes_to
promotes_to.argtypes = [MOVE]
promotes_to.restype = PIECE_INDEX

hash_move = clib.hash_move
hash_move.argtypes = [MOVE]
hash_move.restype = c_uint64

unhash_move = clib.unhash_move
unhash_move.argtypes = [c_uint64]
unhash_move.restype = MOVE

moves_equal = clib.moves_equal
moves_equal.argtypes = [MOVE, MOVE]
moves_equal.restype = c_bool

move_to_san = clib.move_to_san_str
move_to_san.argtypes = [POINTER(BOARD), MOVE, c_char_p]
move_to_san.restype = c_bool

def move_to_sanPY(board : POINTER(BOARD), move : MOVE) -> str:
    out = create_string_buffer(10)
    res = move_to_san(board, move, out)
    #if not res:
    #    raise ValueError(f"{_write_uciPY(move)}")
    return bytes(out).rstrip(b'\x00 ').decode("utf-8")



validate_board = clib.validate_board
validate_board.argtypes = [POINTER(BOARD)]
validate_board.restype = c_char_p

write_bitboard = clib.write_bitboard
write_bitboard.argtypes = [BITBOARD, c_char_p]

count_moves = clib.count_legal_moves
count_moves.argtypes = [POINTER(BOARD)]
count_moves.restype = c_uint8

is_stalemate = clib.is_stalemate
is_stalemate.argtypes = [POINTER(BOARD)]
is_stalemate.restype = c_bool

is_checkmate = clib.is_checkmate
is_checkmate.argtypes = [POINTER(BOARD)]
is_checkmate.restype = c_bool

randomize_board = clib.randomize_board
randomize_board.argtypes = [POINTER(BOARD)]

get_piece_bb = clib.get_piece_bb_from_board
get_piece_bb.argtypes = [POINTER(BOARD), _PIECE]
get_piece_bb.restype = BITBOARD

squares_with_piece = clib.squares_with_piece
squares_with_piece.argtypes = [POINTER(BOARD), _PIECE, POINTER(SQUARE)]
squares_with_piece.restype = c_uint8

board_has_patterns = clib.board_has_patterns
board_has_patterns.argtypes = [POINTER(BOARD), POINTER(_PIECE_PATTERN), c_uint64]
board_has_patterns.restype = c_bool

get_outcome = clib.get_status
get_outcome.argtypes = [POINTER(BOARD), POINTER(UNDOABLE_MOVE), c_uint16]
get_outcome.restype = OUTCOME

ext_construct_move = clib.ext_construct_move
ext_construct_move.argtypes = [SQUARE, SQUARE, PIECE_TYPE, POINTER(MOVE)]
ext_construct_move.restype = c_char_p

square_in_bitboard = clib.square_in_bitboard
square_in_bitboard.argtypes = [BITBOARD, SQUARE]
square_in_bitboard.restype = c_bool

bitboard_and = clib.bitboard_and
bitboard_and.argtypes = [BITBOARD, BITBOARD]
bitboard_and.restype = BITBOARD

bitboard_or = clib.bitboard_or
bitboard_or.argtypes = [BITBOARD, BITBOARD]
bitboard_or.restype = BITBOARD

bitboard_xor = clib.bitboard_xor
bitboard_xor.argtypes = [BITBOARD, BITBOARD]
bitboard_xor.restype = BITBOARD

bitboard_not = clib.bitboard_not
bitboard_not.argtypes = [BITBOARD]
bitboard_not.restype = BITBOARD

fill_piece_index_array = clib.fill_piece_index_array
fill_piece_index_array.argtypes = [POINTER(BOARD), c_char_p]

index_into = clib.index_into
index_into.argtypes = [c_char_p, SQUARE]
index_into.restype = PIECE_INDEX

from_squares = clib.from_squares
from_squares.argtypes = [POINTER(SQUARE), c_uint8]
from_squares.restype = BITBOARD

count_piece_type = clib.count_piece_type
count_piece_type.argtypes = [POINTER(BOARD), PIECE_TYPE]
count_piece_type.restype = c_uint8

count_color = clib.count_color
count_color.argtypes = [POINTER(BOARD), PIECE_TYPE]
count_color.restype = c_uint8


count_color = clib.count_color
count_color.argtypes = [POINTER(BOARD), PIECE_INDEX]
count_color.restype = c_uint8

generate_legal_move_hashes = clib.generate_legal_move_hashes
generate_legal_move_hashes.argtypes = [POINTER(BOARD), POINTER(c_uint64)]
generate_legal_move_hashes.restype = c_uint8


count_backwards_pawns = clib.count_backwards_pawns
count_backwards_pawns.argtypes = [POINTER(BOARD), COLOR]
count_backwards_pawns.restype = c_uint8

count_doubled_pawns = clib.count_doubled_pawns
count_doubled_pawns.argtypes = [POINTER(BOARD), COLOR]
count_doubled_pawns.restype = c_uint8

count_isolated_pawns = clib.count_isolated_pawns
count_isolated_pawns.argtypes = [POINTER(BOARD), COLOR]
count_isolated_pawns.restype = c_uint8

net_backwards_pawns = clib.net_backwards_pawns
net_backwards_pawns.argtypes = [POINTER(BOARD)]
net_backwards_pawns.restype = c_int8

net_doubled_pawns = clib.net_doubled_pawns
net_doubled_pawns.argtypes = [POINTER(BOARD)]
net_doubled_pawns.restype = c_int8

net_isolated_pawns = clib.net_isolated_pawns
net_isolated_pawns.argtypes = [POINTER(BOARD)]
net_isolated_pawns.restype = c_int8

net_mobility = clib.net_mobility
net_mobility.argtypes = [POINTER(BOARD)]
net_mobility.restype = c_int16


net_piece_type = clib.net_piece_type
net_piece_type.argtypes = [POINTER(BOARD), PIECE_TYPE]
net_piece_type.restype = c_int8

ext_get_pinned_mask = clib.ext_get_pinned_mask
ext_get_pinned_mask.argtypes = [POINTER(BOARD), SQUARE]
ext_get_pinned_mask.restype = BITBOARD

ext_get_attack_mask = clib.ext_get_attack_mask 
ext_get_attack_mask.argtypes = [POINTER(BOARD)]
ext_get_attack_mask.restype = BITBOARD

above_bb = clib.above_bb
above_bb.argtypes = [BITBOARD]
above_bb.restype = BITBOARD

below_bb = clib.below_bb
below_bb.argtypes = [BITBOARD]
below_bb.restype = BITBOARD

left_bb = clib.left_bb
left_bb.argtypes = [BITBOARD]
left_bb.restype = BITBOARD

right_bb = clib.right_bb
right_bb.argtypes = [BITBOARD]
right_bb.restype = BITBOARD

piece_attacks = clib.ext_piece_attacks
piece_attacks.argtypes = [PIECE_INDEX, SQUARE]
piece_attacks.restype = BITBOARD

shannon_evaluation = clib.shannon_evaluation
shannon_evaluation.argtypes = [POINTER(BOARD), POINTER(UNDOABLE_MOVE), c_uint8]
shannon_evaluation.restype = c_int32

roundtrip_san = clib.roundtrip_san
roundtrip_san.argtypes = [c_char_p, c_char_p]
roundtrip_san.restype = c_bool

san_to_move = clib.san_str_to_move
san_to_move.argtypes = [POINTER(BOARD), c_char_p, POINTER(c_bool)]
san_to_move.restype = MOVE


pgn_to_board_and_moves = clib.pgn_to_board_and_moves
pgn_to_board_and_moves.argtypes = [POINTER(PGN), POINTER(BOARD), 
                                   c_char_p, POINTER(MOVE), c_char_p]
pgn_to_board_and_moves.restype = c_uint16




def pgn_to_board_movesPY(pgn : POINTER(PGN)) -> tuple[POINTER(BOARD),
                                                      bytes,list[MOVE]]:
    board = alloc_boardPY() 
    piece_array = bytes(64)
    error = cast(create_string_buffer(200), c_char_p)
    moves = (MOVE * 300)()
    print("go..")
    num = pgn_to_board_and_moves(pgn, board, piece_array, moves, error)
    if num == 0:
        raise Exception(bytes(error).encode("utf-8"))
    else:
        return board, piece_array, [m for m in moves[:num]]                         
next_pgn = clib.next_pgn
next_pgn.argtypes = [c_void_p, POINTER(PGN)]
next_pgn.restype = c_bool


def roundtrip_sanPY(san : str) -> str:
    out = create_string_buffer(10)
    res = roundtrip_san(san.encode("utf-8"), out)
    if not res:
        print(f"incorrect: {san} => {bytes(out)}")
    return False if not res else bytes(out).rstrip(b'\x00 ').decode("utf-8")

PAWN_VAL : PIECE_TYPE = get_pawn_value()
BISHOP_VAL : PIECE_TYPE = get_bishop_value()
KNIGHT_VAL : PIECE_TYPE = get_knight_value()
ROOK_VAL : PIECE_TYPE = get_rook_value()
QUEEN_VAL : PIECE_TYPE = get_queen_value()
KING_VAL : PIECE_TYPE = get_king_value()

WHITE : COLOR = get_white_value()
BLACK : COLOR = get_black_value()

EMPTY_PIECE_TYPE : PIECE_TYPE = get_empty_value()
ERROR_PIECE_TYPE : PIECE_TYPE = get_error_value()


EMPTY_PIECE : _PIECE = _PIECE(EMPTY_PIECE_TYPE, EMPTY_PIECE_TYPE)
ERR_MOVE_VAL = 1
NULL_MOVE_VAL = 0

PAWNS_STARTING = BITBOARD(71776119061282560)
KNIGHTS_STARTING = BITBOARD(4755801206503243842)
BISHOPS_STARTING = BITBOARD(2594073385365405732)
ROOKS_STARTING = BITBOARD(9295429630892703873)
QUEENS_STARTING = BITBOARD(576460752303423496)
KINGS_STARTING = BITBOARD(1152921504606846992)
WHITE_STARTING = BITBOARD(65535)
BLACK_STARTING = BITBOARD(18446462598732840960)


STARTING_CASTLING_RIGHTS = CASTLING_RIGHTS(0xF)
NO_CASTLING_RIGHTS = CASTLING_RIGHTS(0)


ZOBRIST_TABLE = create_zobrist_table()



## stdlib
open_pgn = clib.open_pgn
open_pgn.argtypes = [c_char_p]
open_pgn.restype = c_void_p

close_pgn = clib.close_pgn
close_pgn.argtypes = [c_void_p]
