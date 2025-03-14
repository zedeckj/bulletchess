from ctypes import *
import os
import sys
sys.path.append("./")
path = os.path.dirname(os.path.abspath(__file__))
print(path)
clib = CDLL(path + "/chess_c.so")

Bitboard = c_uint64
PieceType = c_uint8
Color = c_uint8
Square = c_uint8
CastlingRights = c_uint8
TurnClock = c_uint16



class _OPTIONAL_SQUARE(Structure):

    _fields_ = [
        ("square", Square),
        ("exists", c_bool),
    ]

class _POSITION(Structure):

    """
    Represents the pieces on a Board.
    """

    _fields_ = [
        ("pawns", Bitboard),
        ("knights", Bitboard),
        ("bishops", Bitboard),
        ("rooks", Bitboard),
        ("queens", Bitboard),
        ("kings", Bitboard),
        ("white_oc", Bitboard),
        ("black_ok", Bitboard),
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
        ("origin", Square),
        ("destination", Square),
    ]

class _PROMOTION_MOVE(Structure):
    _fields_ = [
        ("body", _GENERIC_MOVE),
        ("promote_to", PieceType),
    ]


class _MOVE_UNION(Union):
    _fields_ = [
        ("generic", _GENERIC_MOVE),
        ("promotion", _PROMOTION_MOVE),
    ]



_material = clib.material
_material.restype = c_int
_material.argtypes = [POINTER(_POSITION), c_int, c_int, c_int, c_int]

_delete_piece_at = clib.delete_piece_at
_delete_piece_at.argtypes = [POINTER(_POSITION), Square]

_get_pawn_value = clib.get_pawn_val
_get_pawn_value.restype = PieceType

_get_knight_value = clib.get_knight_val
_get_knight_value.restype = PieceType

_get_bishop_value = clib.get_bishop_val
_get_bishop_value.restype = PieceType

_get_rook_value = clib.get_rook_val
_get_rook_value.restype = PieceType

_get_king_value = clib.get_king_val
_get_king_value.restype = PieceType

_get_queen_value = clib.get_queen_val
_get_queen_value.restype = PieceType

_get_white_value = clib.get_white_val
_get_white_value.restype = Color

_get_black_value = clib.get_black_val
_get_black_value.restype = Color

_create_zobrist_table = clib.create_zobrist_table
_create_zobrist_table.restype = POINTER(_ZOBRIST_TABLE)

_is_subset = clib.is_subset
_is_subset.argtypes = [POINTER(_POSITION), POINTER(_POSITION)]
_is_subset.restype = c_bool



_piece_is_type = clib.piece_is_type
_piece_is_type.restype = c_bool
_piece_is_type.argtypes = [Piece, PieceType]

_piece_is_empty = clib.piece_is_empty
_piece_is_empty.restype = c_bool
_piece_is_empty.argtypes = [Piece]

_piece_is_color = clib.piece_is_color
_piece_is_color.restype = c_bool
_piece_is_color.argtypes = [Piece, Color]

_piece_symbol = clib.piece_symbol
_piece_symbol.restype = c_char
_piece_symbol.argtypes = [Piece]

_pieces_equal = clib.pieces_equal
_pieces_equal.restype = c_bool
_pieces_equal.argtypes = [Piece, Piece]

_same_color = clib.same_color
_same_color.restype = c_bool
_same_color.argtypes = [Piece, Piece]

_same_type = clib.same_type
_same_type.restype = c_bool
_same_type.argtypes = [Piece, Piece]

_hash_piece = clib.hash_piece
_hash_piece.restype = c_int64
_hash_piece.argtypes = [Piece]

_has_kingside_castling_rights  = clib.has_kingside_castling_rights
_has_kingside_castling_rights.restype = c_bool
_has_kingside_castling_rights.argtypes = [POINTER(Board), Color]

_has_queenside_castling_rights = clib.has_queenside_castling_rights
_has_queenside_castling_rights.restype = c_bool
_has_queenside_castling_rights.argtypes = [POINTER(Board), Color]

_has_castling_rights = clib.has_castling_rights
_has_castling_rights.restype = c_bool 
_has_castling_rights.argtypes = [POINTER(Board), Color]


_clear_castling_rights = clib.clear_castling_rights
_clear_castling_rights.argtypes = [POINTER(Board), Color]

_set_full_castling_rights = clib.set_full_castling_rights
_set_full_castling_rights.argtypes = [POINTER(Board)]

_update_castling_rights = clib.update_castling_rights
_update_castling_rights.argtypes = [POINTER(Board), Color]

_update_all_castling_rights = clib.update_all_castling_rights
_update_all_castling_rights.argtypes = [POINTER(Board)]

_contains_piece = clib.contains_piece
_contains_piece.argtypes = [POINTER(backend._POSITION), Piece]
_contains_piece.restype = c_bool

_boards_equal = clib.boards_equal
_boards_equal.argtypes = [POINTER(Board), POINTER(Board)]
_boards_equal.restype = c_bool


_hash_board = clib.hash_board
_hash_board.argtypes = [POINTER(Board), POINTER(backend._ZOBRIST_TABLE)]
_hash_board.restype = c_uint64

_add_castling_rights = clib.add_castling_rights
_add_castling_rights.argtypes = [POINTER(Board), c_bool, Color]

_clear_ep_square = clib.clear_ep_square
_clear_ep_square.argtypes = [POINTER(Board)]

_set_ep_square = clib.set_ep_square
_set_ep_square.argtypes = [POINTER(Board), Square]

_make_fen = clib.make_fen
_make_fen.argtypes = [POINTER(Board), c_char_p]

_split_fen = clib.split_fen
_split_fen.argtypes = [c_char_p]
_split_fen.restype = POINTER(backend._SPLIT_FEN)

_parse_fen = clib.parse_fen
_parse_fen.argtypes = [c_char_p, POINTER(Board)]
_parse_fen.restype = c_char_p

_parse_uci = clib.parse_uci
_parse_uci.argtypes = [c_char_p]
_parse_uci.restype = Move

_write_uci = clib.write_uci
_write_uci.argtypes = [Move, c_char_p]
_write_uci.restype = c_bool


_is_error_move = clib.is_error_move
_is_error_move.argtypes = [Move]
_is_error_move.restype = c_bool

_is_null_move = clib.is_null_move
_is_null_move.argtypes = [Move]
_is_null_move.restype = c_bool

_apply_move = clib.best_apply_move
_apply_move.argtypes = [POINTER(Board), Move]

# _generate_pseudo_legal_moves = clib.generate_pseudo_legal_moves
# _generate_pseudo_legal_moves.argtypes = [POINTER(Board), Color, POINTER(Move)]
# _generate_pseudo_legal_moves.restype = c_uint8

_generate_legal_moves = clib.generate_legal_moves
_generate_legal_moves.argtypes = [POINTER(Board), Color, POINTER(Move)]
_generate_legal_moves.restype = c_uint8

_make_board_string = clib.make_board_string
_make_board_string.argtypes = [POINTER(Board), c_char_p]

_make_attack_mask = clib.make_attack_mask
_make_attack_mask.argtypes = [POINTER(Board), Color]
_make_attack_mask.restype = Bitboard

_in_check = clib.in_check
_in_check.argtypes = [POINTER(Board), Color]
_in_check.restype = c_bool

_copy_into = clib.copy_into
_copy_into.argtypes = [POINTER(Board), POINTER(Board)]

_debug_print_board = clib.debug_print_board
_debug_print_board.argtypes = [POINTER(Board)]

_print_bitboard = clib.print_bitboard
_print_bitboard.argtypes = [Bitboard]

_perft = clib.perft
_perft.argtypes = [POINTER(Board), c_uint8]
_perft.restype = c_uint64

_get_piece_at = clib.get_piece_at
_get_piece_at.restype = Piece
_get_piece_at.argtypes = [POINTER(backend._POSITION), Square]


_set_piece_at = clib.set_piece_at



