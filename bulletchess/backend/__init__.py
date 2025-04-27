import os
from ctypes import *
import ctypes

from typing import TypeAlias

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


class _PIECE(Structure):
    _fields_ = [
        ("color", COLOR),
        ("type", PIECE_TYPE)
    ]



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
        ("moving_type", PIECE_TYPE),
    ]

class MOVE_UNION(Union):
    _fields_ = [
        ("generic", _GENERIC_MOVE),
        ("promotion", _PROMOTION_MOVE),
    ]

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
        ("moved_piece", PIECE_TYPE),
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

BOARD_P = POINTER(BOARD)

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

class _DATE(Structure):
    _fields_ = [
        ("known_year", c_bool), 
        ("year", c_uint16),

        ("known_month", c_bool),
        ("month", c_uint8),

        ("known_day", c_bool),
        ("day", c_uint8)
    ]

class _PGN_TAGS(Structure):
    
    _fields_ = [
        ("event", c_char_p),
        ("site", c_char_p),
        ("date", _DATE),
        ("round", c_char_p),
        ("white_player", c_char_p),
        ("black_player", c_char_p),
        ("result", c_uint8),
    ]

class PGN(Structure):

    _fields_ = [
        ("tags", POINTER(_PGN_TAGS)),
        ("moves", POINTER(MOVE)),
        ("starting_board", BOARD_P),
        ("count", c_uint16),
    ]

PGN_P = POINTER(PGN)


class _TOKLOC(Structure):
    _fields_ = [
        ("source_name", c_char_p),
        ("line", c_size_t),
        ("row", c_size_t)
    ]

class _TOKCTX(Structure):
    _fields_ = [
        ("loc", _TOKLOC),
        ("index", c_size_t),
        ("pntr", c_void_p),
        ("escape", c_char),
        ("operators", c_char_p),
        ("delims", c_char_p),
        ("ungot", c_void_p)
    ]



class _PGN_FILE(Structure):
    _fields_ = [
        ("file", c_void_p),
        ("ctx", POINTER(_TOKCTX)),
    ]

def charp_to_str(c : c_char_p) -> str:
    b = bytes(c)
    print(b)
    return b.decode("utf-8")

def init_pgn() -> PGN_P:
    LINE_LEN = 255
    pgn = PGN()
    pgn.moves = (MOVE* 600)()
    pgn.count = 600
    tags = _PGN_TAGS()
    tags.event = cast(create_string_buffer(LINE_LEN), c_char_p)
    tags.site = cast(create_string_buffer(LINE_LEN), c_char_p)
    tags.date = _DATE()
    tags.round = cast(create_string_buffer(LINE_LEN), c_char_p)
    tags.white_player = cast(create_string_buffer(LINE_LEN), c_char_p)
    tags.black_player = cast(create_string_buffer(LINE_LEN), c_char_p)
    pgn.tags = pointer(tags)
    pgn.starting_board = alloc_boardPY()
    return pointer(pgn)

def alloc_boardPY() -> BOARD_P :
    pos = pointer(_POSITION())
    board = pointer(BOARD(pos))
    return board


def next_pgnPY(fp : c_void_p) -> POINTER(PGN):
    pgn = init_pgn()
    err = cast(create_string_buffer(500), c_char_p)
    status = int(next_pgn(fp, pgn, err))
    if status != 0:
        if status == 2:
            return None
        else:
            raise Exception(err.value.decode("utf-8"))
    return pgn

def init_empty_boardPY() -> BOARD_P:
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

def init_starting_boardPY() -> BOARD_P:
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

def init_board_from_fenPY(fen : str) -> tuple[BOARD_P, bytes]:
    pos_pointer = pointer(_POSITION())
    board = pointer(BOARD(pos_pointer))
    piece_array = bytes(64)
    error = parse_fen(encode(fen), board, piece_array)
    if error == None:
        return board, piece_array
    else:
        error = bytes(error).decode()
        raise ValueError(f"Invalid FEN '{fen}': {error}")

def san_to_movePY(board : BOARD_P, san : str) -> MOVE:
    err = c_bool(False)
    msg = bytes(300)
    struct = san_to_move(board, san.encode("utf-8"), byref(err), msg)
    if err:
        raise ValueError(f"Could not read {san} for position " 
                         f"{make_fenPY(board)}:\n\t"
                         f"{msg.decode('utf-8')}")
    return struct

def init_move_from_uciPY(uci : str) -> MOVE:
    err = c_bool(False)
    struct = MOVE()
    err = parse_uci(uci.encode("utf-8"), byref(struct)) 
    if err:
        raise ValueError(err.rstrip(b'\x00 ').decode().format(uci = uci))
    return struct

def make_fenPY(board : BOARD_P) -> str:
    fen : Array[c_char] = create_string_buffer(200)
    l = make_fen(board, fen)
    return fen[:l-1].decode("utf-8")

def make_board_stringPY(board : BOARD_P) -> str:
    str_buffer = create_string_buffer(300)
    fill_board_string(board, str_buffer)
    return str_buffer.raw.rstrip(b'\x00 ').decode()

def write_uciPY(struct : MOVE) -> str:
    uci = create_string_buffer(6)
    write_uci(struct, uci)
    return uci.raw.rstrip(b'\x00').decode()


def write_bitboardPY(bitboard : BITBOARD) -> str:
    s = create_string_buffer(137)
    write_bitboard(bitboard, s)
    return s.raw.rstrip(b'\x00 ').decode()


def construct_movePY(origin : SQUARE, destination : SQUARE, promote_to : PIECE_TYPE):
    struct = MOVE()
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
get_piece_at.argtypes = [BOARD_P, SQUARE]


is_quiescent = clib.is_quiescent
is_quiescent.argtypes = [BOARD_P]
is_quiescent.restype = c_bool

set_piece_index = clib.set_piece_index
set_piece_index.argtypes = [BOARD_P, c_char_p, SQUARE, PIECE_INDEX]

delete_piece_at = clib.delete_piece_at_board
delete_piece_at.argtypes = [BOARD_P, c_char_p, SQUARE]

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
has_kingside_castling_rights.argtypes = [BOARD_P, COLOR]

has_queenside_castling_rights = clib.has_queenside_castling_rights
has_queenside_castling_rights.restype = c_bool
has_queenside_castling_rights.argtypes = [BOARD_P, COLOR]

has_castling_rights = clib.has_castling_rights
has_castling_rights.restype = c_bool 
has_castling_rights.argtypes = [BOARD_P, COLOR]


clear_castling_rights = clib.clear_castling_rights
clear_castling_rights.argtypes = [BOARD_P, COLOR]

set_full_castling_rights = clib.set_full_castling_rights
set_full_castling_rights.argtypes = [BOARD_P]

update_castling_rights = clib.update_castling_rights
update_castling_rights.argtypes = [BOARD_P, COLOR]

update_all_castling_rights = clib.update_all_castling_rights
update_all_castling_rights.argtypes = [BOARD_P]

contains_piece = clib.contains_piece_index
contains_piece.argtypes = [BOARD_P, PIECE_INDEX]
contains_piece.restype = c_bool

is_subset = clib.is_subset
is_subset.argtypes = [POINTER(_POSITION), POINTER(_POSITION)]
is_subset.restype = c_bool

boards_equal = clib.boards_equal
boards_equal.argtypes = [BOARD_P, BOARD_P]
boards_equal.restype = c_bool


create_zobrist_table = clib.create_zobrist_table
create_zobrist_table.restype = POINTER(_ZOBRIST_TABLE)

hash_board = clib.hash_board
hash_board.argtypes = [BOARD_P, POINTER(_ZOBRIST_TABLE)]
hash_board.restype = c_uint64

def hash_board_wrapper(board : BOARD_P): 
    return hash_board(board, ZOBRIST_TABLE)

add_castling_rights = clib.add_castling_rights
add_castling_rights.argtypes = [BOARD_P, c_bool, COLOR]

clear_ep_square = clib.clear_ep_square
clear_ep_square.argtypes = [BOARD_P]

set_ep_square_checked = clib.set_ep_square_checked
set_ep_square_checked.argtypes = [BOARD_P, SQUARE]
set_ep_square_checked.restype = c_char_p

make_fen = clib.make_fen
make_fen.argtypes = [BOARD_P, c_char_p]
make_fen.restype = c_uint8

parse_fen = clib.parse_fen
parse_fen.argtypes = [c_char_p, BOARD_P, c_char_p]
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
apply_move.argtypes = [BOARD_P, MOVE]
apply_move.restype = UNDOABLE_MOVE

void_apply = clib.void_apply
void_apply.argtypes = [BOARD_P, MOVE]
void_apply.restype = None

undo_move = clib.undo_move
undo_move.argtypes = [BOARD_P, UNDOABLE_MOVE]

# _generate_pseudo_legal_moves = clib.generate_pseudo_legal_moves
# _generate_pseudo_legal_moves.argtypes = [BOARD_P, COLOR, POINTER(MOVE)]
# _generate_pseudo_legal_moves.restype = c_uint8

generate_legal_moves = clib.generate_legal_moves
generate_legal_moves.argtypes = [BOARD_P, POINTER(MOVE)]
generate_legal_moves.restype = c_uint8

fill_board_string = clib.fill_board_string
fill_board_string.argtypes = [BOARD_P, c_char_p]

make_attack_mask = clib.make_attack_mask
make_attack_mask.argtypes = [BOARD_P, COLOR]
make_attack_mask.restype = BITBOARD

in_check = clib.in_check
in_check.argtypes = [BOARD_P]
in_check.restype = c_bool

copy_into = clib.copy_into
copy_into.argtypes = [BOARD_P, BOARD_P]

debug_print_board = clib.debug_print_board
debug_print_board.argtypes = [BOARD_P]

print_bitboard = clib.print_bitboard
print_bitboard.argtypes = [BITBOARD]

perft = clib.perft
perft.argtypes = [BOARD_P, c_uint8]
perft.restype = c_uint64


pseudo_perft = clib.pseudo_perft
pseudo_perft.argtypes = [BOARD_P, c_uint8]
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
move_to_san.argtypes = [BOARD_P, MOVE, c_char_p]
move_to_san.restype = c_bool

def move_to_sanPY(board : BOARD_P, move : MOVE) -> str:
    out = create_string_buffer(10)
    res = move_to_san(board, move, out)
    #if not res:
    #    raise ValueError(f"{_write_uciPY(move)}")
    return bytes(out).rstrip(b'\x00 ').decode("utf-8")



validate_board = clib.validate_board
validate_board.argtypes = [BOARD_P]
validate_board.restype = c_char_p

write_bitboard = clib.write_bitboard
write_bitboard.argtypes = [BITBOARD, c_char_p]

count_moves = clib.count_legal_moves
count_moves.argtypes = [BOARD_P]
count_moves.restype = c_uint8

is_stalemate = clib.is_stalemate
is_stalemate.argtypes = [BOARD_P]
is_stalemate.restype = c_bool

is_checkmate = clib.is_checkmate
is_checkmate.argtypes = [BOARD_P]
is_checkmate.restype = c_bool

randomize_board = clib.randomize_board
randomize_board.argtypes = [BOARD_P]

get_piece_bb = clib.get_piece_bb_from_board
get_piece_bb.argtypes = [BOARD_P, _PIECE]
get_piece_bb.restype = BITBOARD

squares_with_piece = clib.squares_with_piece
squares_with_piece.argtypes = [BOARD_P, _PIECE, POINTER(SQUARE)]
squares_with_piece.restype = c_uint8

board_has_patterns = clib.board_has_patterns
board_has_patterns.argtypes = [BOARD_P, POINTER(_PIECE_PATTERN), c_uint64]
board_has_patterns.restype = c_bool

get_outcome = clib.get_status
get_outcome.argtypes = [BOARD_P, POINTER(UNDOABLE_MOVE), c_uint16]
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
fill_piece_index_array.argtypes = [BOARD_P, c_char_p]

index_into = clib.index_into
index_into.argtypes = [c_char_p, SQUARE]
index_into.restype = PIECE_INDEX

from_squares = clib.from_squares
from_squares.argtypes = [POINTER(SQUARE), c_uint8]
from_squares.restype = BITBOARD

count_piece_type = clib.count_piece_type
count_piece_type.argtypes = [BOARD_P, PIECE_TYPE]
count_piece_type.restype = c_uint8

count_color = clib.count_color
count_color.argtypes = [BOARD_P, PIECE_TYPE]
count_color.restype = c_uint8


count_color = clib.count_color
count_color.argtypes = [BOARD_P, PIECE_INDEX]
count_color.restype = c_uint8

generate_legal_move_hashes = clib.generate_legal_move_hashes
generate_legal_move_hashes.argtypes = [BOARD_P, POINTER(c_uint64)]
generate_legal_move_hashes.restype = c_uint8


count_backwards_pawns = clib.count_backwards_pawns
count_backwards_pawns.argtypes = [BOARD_P, COLOR]
count_backwards_pawns.restype = c_uint8

count_doubled_pawns = clib.count_doubled_pawns
count_doubled_pawns.argtypes = [BOARD_P, COLOR]
count_doubled_pawns.restype = c_uint8

count_isolated_pawns = clib.count_isolated_pawns
count_isolated_pawns.argtypes = [BOARD_P, COLOR]
count_isolated_pawns.restype = c_uint8

net_backwards_pawns = clib.net_backwards_pawns
net_backwards_pawns.argtypes = [BOARD_P]
net_backwards_pawns.restype = c_int8

net_doubled_pawns = clib.net_doubled_pawns
net_doubled_pawns.argtypes = [BOARD_P]
net_doubled_pawns.restype = c_int8

net_isolated_pawns = clib.net_isolated_pawns
net_isolated_pawns.argtypes = [BOARD_P]
net_isolated_pawns.restype = c_int8

net_mobility = clib.net_mobility
net_mobility.argtypes = [BOARD_P]
net_mobility.restype = c_int16


net_piece_type = clib.net_piece_type
net_piece_type.argtypes = [BOARD_P, PIECE_TYPE]
net_piece_type.restype = c_int8

ext_get_pinned_mask = clib.ext_get_pinned_mask
ext_get_pinned_mask.argtypes = [BOARD_P, SQUARE]
ext_get_pinned_mask.restype = BITBOARD

ext_get_attack_mask = clib.ext_get_attack_mask 
ext_get_attack_mask.argtypes = [BOARD_P]
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
shannon_evaluation.argtypes = [BOARD_P, POINTER(UNDOABLE_MOVE), c_uint8]
shannon_evaluation.restype = c_int32

roundtrip_san = clib.roundtrip_san
roundtrip_san.argtypes = [c_char_p, c_char_p]
roundtrip_san.restype = c_bool

san_to_move = clib.san_str_to_move
san_to_move.argtypes = [BOARD_P, c_char_p, POINTER(c_bool), c_char_p]
san_to_move.restype = MOVE

"""
pgn_to_board_and_moves = clib.pgn_to_board_and_moves
pgn_to_board_and_moves.argtypes = [POINTER(PGN), BOARD_P, 
                                   c_char_p, POINTER(MOVE), c_char_p]
pgn_to_board_and_moves.restype = c_uint16
"""

is_san_correct = clib.is_san_correct 
is_san_correct.argtypes = [c_char_p]
is_san_correct.restype = c_bool

def is_san_correctPY(san_str : str) -> bool:
    san = san_str.encode("utf-8")
    return bool(is_san_correct(san))

"""
def pgn_to_board_movesPY(pgn : POINTER(PGN)) -> tuple[BOARD_P,
                                                      bytes,list[MOVE]]:
    board = alloc_boardPY() 
    piece_array = bytes(64)
    error = create_string_buffer(300)
    moves = (MOVE * 300)()
    print("go..\ngo\n")
    num = pgn_to_board_and_moves(pgn, board, piece_array, moves, error)
    if num == 0:
        raise Exception(bytes(error).decode("utf-8"))
    else:
        return board, piece_array, [m for m in moves[:num]]                         
"""
next_pgn = clib.next_pgn
next_pgn.argtypes = [c_void_p, POINTER(PGN), c_char_p]
next_pgn.restype = c_int


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
open_pgn.restype = POINTER(_PGN_FILE)

close_pgn = clib.close_pgn
close_pgn.argtypes = [POINTER(_PGN_FILE)]
