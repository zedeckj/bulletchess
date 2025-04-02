import os
from ctypes import *

path = os.path.dirname(os.path.abspath(__file__))
clib = CDLL(path + "/chess_c.so")

_BITBOARD = c_uint64
_PIECE_TYPE = c_uint8
_COLOR = c_uint8
_SQUARE = c_uint8
_CASTLING_RIGHTS = c_uint8
_TURN_CLOCK = c_uint16

_PIECE_INDEX = c_uint8
_OUTCOME = c_uint8

class _OPTIONAL_SQUARE(Structure):

    _fields_ = [
        ("square", _SQUARE),
        ("exists", c_bool),
    ]

class _POSITION(Structure):

    """
    Represents the pieces on a Board.
    """

    _fields_ = [
        ("pawns", _BITBOARD),
        ("knights", _BITBOARD),
        ("bishops", _BITBOARD),
        ("rooks", _BITBOARD),
        ("queens", _BITBOARD),
        ("kings", _BITBOARD),
        ("white_oc", _BITBOARD),
        ("black_ok", _BITBOARD),
    ]


class _ZORBIST_TABLE(Structure):

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
        ("origin", _SQUARE),
        ("destination", _SQUARE),
    ]

class _PROMOTION_MOVE(Structure):
    _fields_ = [
        ("body", _GENERIC_MOVE),
        ("promote_to", _PIECE_TYPE),
    ]

class _FULL_MOVE(Structure):
    _fields_ = [
        ("body", _GENERIC_MOVE),
        ("place_type", _PIECE_TYPE),
        ("new_ep_square", _OPTIONAL_SQUARE),
        ("removes_castling", c_bool),
        ("resets_halfmove", c_bool),
    ]

class _MOVE_UNION(Union):
    _fields_ = [
        ("generic", _GENERIC_MOVE),
        ("promotion", _PROMOTION_MOVE),
    ]

class _PIECE(Structure):
    _fields_ = [
        ("color", _COLOR),
        ("type", _PIECE_TYPE)
    ]

    def __hash__(self):
        return int(_hash_piece(self)) 

    def __eq__(self, other : "_PIECE"):
        return bool(_pieces_equal(self, other))

class _MOVE(Structure):
    _anonymous_ = ("u",)
    _fields_ = [
        ("u", _MOVE_UNION),
        ("type", c_uint8),
    ]

class _UNDOABLE_MOVE(Structure):
    _fields_ = [
        ("move", _MOVE),
        ("captured_piece", _PIECE),
        ("old_castling_rights", _CASTLING_RIGHTS),
        ("was_castling", _CASTLING_RIGHTS),
        ("old_en_passant", _OPTIONAL_SQUARE),
        ("old_halfmove", _TURN_CLOCK)
    ]

class _BOARD(Structure):
    _fields_ = [
        ("position", POINTER(_POSITION)),
        ("turn", _COLOR),
        ("castling_rights", _CASTLING_RIGHTS),
        ("en_passant_square", _OPTIONAL_SQUARE),
        ("halfmove_clock", _TURN_CLOCK),
        ("fullmove_number", _TURN_CLOCK),
    ]

class _PIECE_PATTERN_UNION(Union):

    _fields_ = [
        ("count", c_uint8),
        ("bitboard", _BITBOARD)
    ]

class _PIECE_PATTERN(Structure):

    _anonymous_ = ("u",)

    _fields_ = [
        ("piece", _PIECE),
        ("type", c_uint8),
        ("u", _PIECE_PATTERN_UNION)
    ]



def _alloc_boardPY() -> POINTER(_BOARD):
    pos = pointer(_POSITION())
    board = pointer(_BOARD(pos))
    return board

def _init_empty_boardPY() -> POINTER(_BOARD):
    pos_pointer = pointer(_POSITION(
        0,0,0,0,0,0,0,0
    ))
    castling_rights = NO_CASTLING_RIGHTS  
    en_passant = _OPTIONAL_SQUARE(0, 0)
    turn = _WHITE
    halfmove = _TURN_CLOCK(0)
    fullmove = _TURN_CLOCK(1)
    full_board = _BOARD(
        pos_pointer,
        turn,
        castling_rights,
        en_passant,
        halfmove,
        fullmove,
    )
    return pointer(full_board)



def _init_starting_boardPY() -> POINTER(_BOARD):
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
    en_passant = _OPTIONAL_SQUARE(0, 0)
    turn = _WHITE
    halfmove = _TURN_CLOCK(0)
    fullmove = _TURN_CLOCK(1)
    full_board = _BOARD(
        pos_pointer,
        turn,
        castling_rights,
        en_passant,
        halfmove,
        fullmove,
    )
    return pointer(full_board)




def _init_board_from_fenPY(fen : str) -> tuple[POINTER(_BOARD), (_PIECE_INDEX * 64)]:
    pos_pointer = pointer(_POSITION())
    board = pointer(_BOARD(pos_pointer))
    piece_array = (_PIECE_INDEX * 64)()
    error = _parse_fen(fen.encode("utf-8"), board, piece_array)
    if error == None:
        return board, piece_array
    else:
        error = bytes(error).decode()
        raise ValueError(f"Invalid FEN '{fen}': {error}")


def san_to_movePY(board : POINTER(_BOARD), san : str) -> _MOVE:
    struct = _san_to_move(board, san.encode("utf-8"))
    if struct.type == _ERR_MOVE_VAL:
        raise ValueError(f"Invalid Move SAN: {san}")
    return struct




def _init_move_from_uciPY(uci : str) -> _MOVE:
    struct = _parse_uci(uci.encode("utf-8")) 
    if struct.type == _ERR_MOVE_VAL:
        raise ValueError(f"Invalid Move UCI: '{uci}'")
    return struct

def _make_fenPY(board : POINTER(_BOARD)) -> str:
    fen = create_string_buffer(300)
    _make_fen(board, fen)
    return fen.raw.rstrip(b'\x00 ').decode()

def _make_board_stringPY(board : POINTER(_BOARD)) -> str:
    str_buffer = create_string_buffer(300)
    _fill_board_string(board, str_buffer)
    return str_buffer.raw.rstrip(b'\x00 ').decode()

def _write_uciPY(struct : _MOVE) -> str:
    uci = create_string_buffer(6)
    _write_uci(struct, uci)
    return uci.raw.rstrip(b'\x00').decode()

def _pointer_write_uciPY(pointer : POINTER(_MOVE), index : c_uint64) -> str:
    uci = create_string_buffer(6)
    _pointer_write_uci(pointer, index, uci)
    return uci.raw.rstrip(b'\x00').decode()


def _write_bitboardPY(bitboard : _BITBOARD) -> str:
    s = create_string_buffer(137)
    _write_bitboard(bitboard, s)
    return s.raw.rstrip(b'\x00 ').decode()

def _make_piece_arrayPY(board : POINTER(_BOARD)) -> _PIECE * 64:
    array = (_PIECE * 64)()
    _fill_piece_list(board, array)
    return array

def construct_movePY(origin : _SQUARE, destination : _SQUARE, promote_to : _PIECE_TYPE):
    struct = _MOVE();
    err = _ext_construct_move(origin, destination, promote_to, byref(struct))
    if err:
        return bytes(err).rstrip(b'\x00').decode("utf-8")
    return struct

_piece_from_string = clib.piece_from_string
_piece_from_string.argtypes = [c_char_p]
_piece_from_string.restype = _PIECE


# _material = clib.material
# _material.restype = c_int
# _material.argtypes = [POINTER(_POSITION), c_int, c_int, c_int, c_int]

_get_piece_at = clib.get_piece_at_board
_get_piece_at.restype = c_uint8
_get_piece_at.argtypes = [POINTER(_BOARD), _SQUARE]


_is_quiescent = clib.is_quiescent
_is_quiescent.argtypes = [POINTER(_BOARD)]
_is_quiescent.restype = c_bool

_set_piece_index = clib.set_piece_index
_set_piece_index.argtypes = [POINTER(_BOARD), POINTER(_PIECE_INDEX), _SQUARE, _PIECE_INDEX]

_delete_piece_at = clib.delete_piece_at_board
_delete_piece_at.argtypes = [POINTER(_BOARD), POINTER(_PIECE_INDEX), _SQUARE]

_get_pawn_value = clib.get_pawn_val
_get_pawn_value.restype = _PIECE_TYPE

_get_knight_value = clib.get_knight_val
_get_knight_value.restype = _PIECE_TYPE

_get_bishop_value = clib.get_bishop_val
_get_bishop_value.restype = _PIECE_TYPE

_get_rook_value = clib.get_rook_val
_get_rook_value.restype = _PIECE_TYPE

_get_king_value = clib.get_king_val
_get_king_value.restype = _PIECE_TYPE

_get_queen_value = clib.get_queen_val
_get_queen_value.restype = _PIECE_TYPE

_get_white_value = clib.get_white_val
_get_white_value.restype = _COLOR

_get_black_value = clib.get_black_val
_get_black_value.restype = _COLOR

_get_empty_value = clib.get_empty_val
_get_empty_value.restype = _PIECE_TYPE

_get_error_value = clib.get_error_val
_get_error_value.restype = _PIECE_TYPE

_piece_is_type = clib.piece_is_type
_piece_is_type.restype = c_bool
_piece_is_type.argtypes = [_PIECE, _PIECE_TYPE]

_piece_is_empty = clib.piece_is_empty
_piece_is_empty.restype = c_bool
_piece_is_empty.argtypes = [_PIECE]

_piece_is_color = clib.piece_is_color
_piece_is_color.restype = c_bool
_piece_is_color.argtypes = [_PIECE, _COLOR]


_piece_symbol = clib.piece_symbol
_piece_symbol.restype = c_char
_piece_symbol.argtypes = [_PIECE]

_pieces_equal = clib.pieces_equal
_pieces_equal.restype = c_bool
_pieces_equal.argtypes = [_PIECE, _PIECE]

_same_color = clib.same_color
_same_color.restype = c_bool
_same_color.argtypes = [_PIECE, _PIECE]

_same_type = clib.same_type
_same_type.restype = c_bool
_same_type.argtypes = [_PIECE, _PIECE]

_hash_piece = clib.hash_piece
_hash_piece.restype = c_int64
_hash_piece.argtypes = [_PIECE]

_has_kingside_castling_rights  = clib.has_kingside_castling_rights
_has_kingside_castling_rights.restype = c_bool
_has_kingside_castling_rights.argtypes = [POINTER(_BOARD), _COLOR]

_has_queenside_castling_rights = clib.has_queenside_castling_rights
_has_queenside_castling_rights.restype = c_bool
_has_queenside_castling_rights.argtypes = [POINTER(_BOARD), _COLOR]

_has_castling_rights = clib.has_castling_rights
_has_castling_rights.restype = c_bool 
_has_castling_rights.argtypes = [POINTER(_BOARD), _COLOR]


_clear_castling_rights = clib.clear_castling_rights
_clear_castling_rights.argtypes = [POINTER(_BOARD), _COLOR]

_set_full_castling_rights = clib.set_full_castling_rights
_set_full_castling_rights.argtypes = [POINTER(_BOARD)]

_update_castling_rights = clib.update_castling_rights
_update_castling_rights.argtypes = [POINTER(_BOARD), _COLOR]

_update_all_castling_rights = clib.update_all_castling_rights
_update_all_castling_rights.argtypes = [POINTER(_BOARD)]

_contains_piece = clib.contains_piece
_contains_piece.argtypes = [POINTER(_POSITION), _PIECE]
_contains_piece.restype = c_bool

_is_subset = clib.is_subset
_is_subset.argtypes = [POINTER(_POSITION), POINTER(_POSITION)]
_is_subset.restype = c_bool

_boards_equal = clib.boards_equal
_boards_equal.argtypes = [POINTER(_BOARD), POINTER(_BOARD)]
_boards_equal.restype = c_bool


_create_zobrist_table = clib.create_zobrist_table
_create_zobrist_table.restype = POINTER(_ZORBIST_TABLE)

_hash_board = clib.hash_board
_hash_board.argtypes = [POINTER(_BOARD), POINTER(_ZORBIST_TABLE)]
_hash_board.restype = c_uint64

_add_castling_rights = clib.add_castling_rights
_add_castling_rights.argtypes = [POINTER(_BOARD), c_bool, _COLOR]

_clear_ep_square = clib.clear_ep_square
_clear_ep_square.argtypes = [POINTER(_BOARD)]

_set_ep_square_checked = clib.set_ep_square_checked
_set_ep_square_checked.argtypes = [POINTER(_BOARD), _SQUARE]
_set_ep_square_checked.restype = c_char_p

_make_fen = clib.make_fen
_make_fen.argtypes = [POINTER(_BOARD), c_char_p]

_split_fen = clib.split_fen
_split_fen.argtypes = [c_char_p]
_split_fen.restype = POINTER(_SPLIT_FEN)

_parse_fen = clib.parse_fen
_parse_fen.argtypes = [c_char_p, POINTER(_BOARD), POINTER(_PIECE_INDEX)]
_parse_fen.restype = c_char_p

_parse_uci = clib.parse_uci
_parse_uci.argtypes = [c_char_p]
_parse_uci.restype = _MOVE

_write_uci = clib.write_uci
_write_uci.argtypes = [_MOVE, c_char_p]
_write_uci.restype = c_bool


_is_error_move = clib.is_error_move
_is_error_move.argtypes = [_MOVE]
_is_error_move.restype = c_bool

_is_null_move = clib.is_null_move
_is_null_move.argtypes = [_MOVE]
_is_null_move.restype = c_bool

_apply_move = clib.apply_move
_apply_move.argtypes = [POINTER(_BOARD), _MOVE]
_apply_move.restype = _UNDOABLE_MOVE

_undo_move = clib.undo_move
_undo_move.argtypes = [POINTER(_BOARD), _UNDOABLE_MOVE]

# _generate_pseudo_legal_moves = clib.generate_pseudo_legal_moves
# _generate_pseudo_legal_moves.argtypes = [POINTER(_BOARD), _COLOR, POINTER(_MOVE)]
# _generate_pseudo_legal_moves.restype = c_uint8

_generate_legal_moves = clib.generate_legal_moves
_generate_legal_moves.argtypes = [POINTER(_BOARD), POINTER(_MOVE)]
_generate_legal_moves.restype = c_uint8

_fill_board_string = clib.fill_board_string
_fill_board_string.argtypes = [POINTER(_BOARD), c_char_p]

_make_attack_mask = clib.make_attack_mask
_make_attack_mask.argtypes = [POINTER(_BOARD), _COLOR]
_make_attack_mask.restype = _BITBOARD

_in_check = clib.in_check
_in_check.argtypes = [POINTER(_BOARD)]
_in_check.restype = c_bool

_copy_into = clib.copy_into
_copy_into.argtypes = [POINTER(_BOARD), POINTER(_BOARD)]

_debug_print_board = clib.debug_print_board
_debug_print_board.argtypes = [POINTER(_BOARD)]

_print_bitboard = clib.print_bitboard
_print_bitboard.argtypes = [_BITBOARD]

_perft = clib.perft
_perft.argtypes = [POINTER(_BOARD), c_uint8]
_perft.restype = c_uint64


_pseudo_perft = clib.pseudo_perft
_pseudo_perft.argtypes = [POINTER(_BOARD), c_uint8]
_pseudo_perft.restype = c_uint64


_get_origin = clib.get_origin
_get_origin.argtypes = [_MOVE]
_get_origin.restype = _SQUARE

_get_destination = clib.get_destination
_get_destination.argtypes = [_MOVE]
_get_destination.restype = _SQUARE

_is_promotion = clib.is_promotion
_is_promotion.argtypes = [_MOVE]
_is_promotion.restype = c_bool

_promotes_to = clib.promotes_to
_promotes_to.argtypes = [_MOVE]
_promotes_to.restype = _PIECE_INDEX

_hash_move = clib.hash_move
_hash_move.argtypes = [_MOVE]
_hash_move.restype = c_uint64

_unhash_move = clib.unhash_move
_unhash_move.argtypes = [c_uint64]
_unhash_move.restype = _MOVE

_moves_equal = clib.moves_equal
_moves_equal.argtypes = [_MOVE, _MOVE]
_moves_equal.restype = c_bool

_move_to_san = clib.move_to_san_str
_move_to_san.argtypes = [POINTER(_BOARD), _MOVE, c_char_p]
_move_to_san.restype = c_bool

def move_to_sanPY(board : POINTER(_BOARD), move : _MOVE) -> str:
    out = create_string_buffer(10)
    res = _move_to_san(board, move, out)
    #if not res:
    #    raise ValueError(f"{_write_uciPY(move)}")
    return bytes(out).rstrip(b'\x00 ').decode("utf-8")



_validate_board = clib.validate_board
_validate_board.argtypes = [POINTER(_BOARD)]
_validate_board.restype = c_char_p

_write_bitboard = clib.write_bitboard
_write_bitboard.argtypes = [_BITBOARD, c_char_p]

_count_moves = clib.count_legal_moves
_count_moves.argtypes = [POINTER(_BOARD)]
_count_moves.restype = c_uint8

_is_stalemate = clib.is_stalemate
_is_stalemate.argtypes = [POINTER(_BOARD)]
_is_stalemate.restype = c_bool

_is_checkmate = clib.is_checkmate
_is_checkmate.argtypes = [POINTER(_BOARD)]
_is_checkmate.restype = c_bool

_randomize_board = clib.randomize_board
_randomize_board.argtypes = [POINTER(_BOARD)]

_get_piece_bb = clib.get_piece_bb_from_board
_get_piece_bb.argtypes = [POINTER(_BOARD), _PIECE]
_get_piece_bb.restype = _BITBOARD

_squares_with_piece = clib.squares_with_piece
_squares_with_piece.argtypes = [POINTER(_BOARD), _PIECE, POINTER(_SQUARE)]
_squares_with_piece.restype = c_uint8

_board_has_patterns = clib.board_has_patterns
_board_has_patterns.argtypes = [POINTER(_BOARD), POINTER(_PIECE_PATTERN), c_uint64]
_board_has_patterns.restype = c_bool

_get_outcome = clib.get_status
_get_outcome.argtypes = [POINTER(_BOARD), POINTER(_UNDOABLE_MOVE), c_uint16]
_get_outcome.restype = _OUTCOME

_ext_construct_move = clib.ext_construct_move
_ext_construct_move.argtypes = [_SQUARE, _SQUARE, _PIECE_TYPE, POINTER(_MOVE)]
_ext_construct_move.restype = c_char_p

_square_in_bitboard = clib.square_in_bitboard
_square_in_bitboard.argtypes = [_BITBOARD, _SQUARE]
_square_in_bitboard.restype = c_bool

_bitboard_and = clib.bitboard_and
_bitboard_and.argtypes = [_BITBOARD, _BITBOARD]
_bitboard_and.restype = _BITBOARD

_bitboard_or = clib.bitboard_or
_bitboard_or.argtypes = [_BITBOARD, _BITBOARD]
_bitboard_or.restype = _BITBOARD

_bitboard_xor = clib.bitboard_xor
_bitboard_xor.argtypes = [_BITBOARD, _BITBOARD]
_bitboard_xor.restype = _BITBOARD

_bitboard_not = clib.bitboard_not
_bitboard_not.argtypes = [_BITBOARD]
_bitboard_not.restype = _BITBOARD

_fill_piece_index_array = clib.fill_piece_index_array
_fill_piece_index_array.argtypes = [POINTER(_BOARD), POINTER(_PIECE_INDEX)]

_index_into = clib.index_into
_index_into.argtypes = [POINTER(_PIECE_INDEX), _SQUARE]
_index_into.restype = _PIECE_INDEX

_from_squares = clib.from_squares
_from_squares.argtypes = [POINTER(_SQUARE), c_uint8]
_from_squares.restype = _BITBOARD

_count_piece_type = clib.count_piece_type
_count_piece_type.argtypes = [POINTER(_BOARD), _PIECE_TYPE]
_count_piece_type.restype = c_uint8

_count_color = clib.count_color
_count_color.argtypes = [POINTER(_BOARD), _PIECE_TYPE]
_count_color.restype = c_uint8


_count_color = clib.count_color
_count_color.argtypes = [POINTER(_BOARD), _PIECE_INDEX]
_count_color.restype = c_uint8

_generate_legal_move_hashes = clib.generate_legal_move_hashes
_generate_legal_move_hashes.argtypes = [POINTER(_BOARD), POINTER(c_uint64)]
_generate_legal_move_hashes.restype = c_uint8


_count_backwards_pawns = clib.count_backwards_pawns
_count_backwards_pawns.argtypes = [POINTER(_BOARD), _COLOR]
_count_backwards_pawns.restype = c_uint8

_count_doubled_pawns = clib.count_doubled_pawns
_count_doubled_pawns.argtypes = [POINTER(_BOARD), _COLOR]
_count_doubled_pawns.restype = c_uint8

_count_isolated_pawns = clib.count_isolated_pawns
_count_isolated_pawns.argtypes = [POINTER(_BOARD), _COLOR]
_count_isolated_pawns.restype = c_uint8

_net_backwards_pawns = clib.net_backwards_pawns
_net_backwards_pawns.argtypes = [POINTER(_BOARD)]
_net_backwards_pawns.restype = c_int8

_net_doubled_pawns = clib.net_doubled_pawns
_net_doubled_pawns.argtypes = [POINTER(_BOARD)]
_net_doubled_pawns.restype = c_int8

_net_isolated_pawns = clib.net_isolated_pawns
_net_isolated_pawns.argtypes = [POINTER(_BOARD)]
_net_isolated_pawns.restype = c_int8

_net_mobility = clib.net_mobility
_net_mobility.argtypes = [POINTER(_BOARD)]
_net_mobility.restype = c_int16


_net_piece_type = clib.net_piece_type
_net_piece_type.argtypes = [POINTER(_BOARD), _PIECE_TYPE]
_net_piece_type.restype = c_int8

_ext_get_pinned_mask = clib.ext_get_pinned_mask
_ext_get_pinned_mask.argtypes = [POINTER(_BOARD), _SQUARE]
_ext_get_pinned_mask.restype = _BITBOARD

_ext_get_attack_mask = clib.ext_get_attack_mask 
_ext_get_attack_mask.argtypes = [POINTER(_BOARD)]
_ext_get_attack_mask.restype = _BITBOARD

_above_bb = clib.above_bb
_above_bb.argtypes = [_BITBOARD]
_above_bb.restype = _BITBOARD

_below_bb = clib.below_bb
_below_bb.argtypes = [_BITBOARD]
_below_bb.restype = _BITBOARD

_left_bb = clib.left_bb
_left_bb.argtypes = [_BITBOARD]
_left_bb.restype = _BITBOARD

_right_bb = clib.right_bb
_right_bb.argtypes = [_BITBOARD]
_right_bb.restype = _BITBOARD

_piece_attacks = clib.ext_piece_attacks
_piece_attacks.argtypes = [_PIECE_INDEX, _SQUARE]
_piece_attacks.restype = _BITBOARD

"""
_shannon_evaluation = clib.shannon_evaluation
_shannon_evaluation.argtypes = [POINTER(_BOARD), POINTER(_UNDOABLE_MOVE), c_uint8]
_shannon_evaluation.restype = c_int32
"""

_roundtrip_san = clib.roundtrip_san
_roundtrip_san.argtypes = [c_char_p, c_char_p]
_roundtrip_san.restype = c_bool

_san_to_move = clib.san_str_to_move
_san_to_move.argtypes = [POINTER(_BOARD), c_char_p]
_san_to_move.restype = _MOVE
def roundtrip_san(san : str) -> str:
    out = create_string_buffer(10)
    res = _roundtrip_san(san.encode("utf-8"), out)
    if not res:
        print(f"incorrect: {san} => {bytes(out)}")
    return False if not res else bytes(out).rstrip(b'\x00 ').decode("utf-8")

_PAWN : _PIECE_TYPE = _get_pawn_value()
_BISHOP : _PIECE_TYPE = _get_bishop_value()
_KNIGHT : _PIECE_TYPE = _get_knight_value()
_ROOK : _PIECE_TYPE = _get_rook_value()
_QUEEN : _PIECE_TYPE = _get_queen_value()
_KING : _PIECE_TYPE = _get_king_value()

_WHITE : _COLOR = _get_white_value()
_BLACK : _COLOR = _get_black_value()

_EMPTY_PIECE_TYPE : _PIECE_TYPE = _get_empty_value()
_ERROR_PIECE_TYPE : _PIECE_TYPE = _get_error_value()


_EMPTY_PIECE : _PIECE = _PIECE(_EMPTY_PIECE_TYPE, _EMPTY_PIECE_TYPE)
_ERR_MOVE_VAL = 1
_NULL_MOVE_VAL = 0

PAWNS_STARTING = _BITBOARD(71776119061282560)
KNIGHTS_STARTING = _BITBOARD(4755801206503243842)
BISHOPS_STARTING = _BITBOARD(2594073385365405732)
ROOKS_STARTING = _BITBOARD(9295429630892703873)
QUEENS_STARTING = _BITBOARD(576460752303423496)
KINGS_STARTING = _BITBOARD(1152921504606846992)
WHITE_STARTING = _BITBOARD(65535)
BLACK_STARTING = _BITBOARD(18446462598732840960)


STARTING_CASTLING_RIGHTS = _CASTLING_RIGHTS(0xF)
NO_CASTLING_RIGHTS = _CASTLING_RIGHTS(0)


# Piece Return Type Signals



ZORBIST_TABLE = _create_zobrist_table
