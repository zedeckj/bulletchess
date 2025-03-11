from typing import Optional, NewType
import enum
import os
import sys
sys.path.append("./")
from ctypes import *
path = os.path.dirname(os.path.abspath(__file__))
print(path)
clib = CDLL(path + "/backend/chess_c.so")

# TYPE ALIASES

Bitboard = c_uint64
PieceType = c_uint8
Color = c_uint8
Square = c_uint8
CastlingRights = c_uint8
TurnClock = c_uint16

# INTERNAL STRUCT DEFINITIONS



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

# class Board(Structure):

#     """
#     Represenets a fully described Board with state.
#     """



class _PIECE(Structure):

    _fields_ = [
        ("type", PieceType),
        ("color", Color),
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
        ("origin", Square),
        ("destination", Square),
    ]

class _PROMOTION_MOVE(Structure):
    _fields_ = [
        ("body", _GENERIC_MOVE),
        ("promote_to", PieceType),
    ]

class _FULL_MOVE(Structure):
    _fields_ = [
        ("body", _GENERIC_MOVE),
        ("place_type", PieceType),
        ("new_ep_square", _OPTIONAL_SQUARE),
        ("removes_castling", c_bool),
        ("resets_halfmove", c_bool),
    ]

class _MOVE_UNION(Union):
    _fields_ = [
        ("generic", _GENERIC_MOVE),
        ("promotion", _PROMOTION_MOVE),
        ("castling", CastlingRights),
        ("full", _FULL_MOVE),
    ]

class Move(Structure):
    "Here is stuff"

    _anonymous_ = ("u",)
    _fields_ = [
        ("u", _MOVE_UNION),
        ("type", c_uint8),
    ]

    @staticmethod
    def from_uci(uci_str : str) -> "Move":
        struct = _parse_uci(uci_str.encode("utf-8"))
        return struct

    def __str__(self):
        uci = create_string_buffer(6)
        _write_uci(self, uci)
        return uci.raw.rstrip(b'\x00').decode()
    
    def __repr__(self):
        return f"Move({str(self)})"
    


class Piece:

    def __init__(self, _struct : _PIECE):
        """
        Private constructor for creating a Piece around a c-struct _PIECE. 
        Use Piece.new() instead. This should never be directly used.
        """
        self._piece_struct = _struct

    @staticmethod
    def _from_struct(_struct : _PIECE) -> Optional["Piece"]:
        """
        Private constructor for creating a Piece around a c-struct,
        or for returning None for an empty piece. Use Piece.new() instead.
        """
        if _piece_is_empty(_struct):
            return None
        return Piece(_struct)

    @staticmethod
    def new(piece_type : PieceType, color : Color) -> "Piece":
        """
        Creates a new Piece from the given PieceType and Color. 
        """
        return Piece(
            _PIECE(
                piece_type,
                color
            )
        )
    

    def get_type(self) -> PieceType:
        return PieceType(self._piece_struct.type)

    def get_color(self) -> Color:
        return Color(self._piece_struct.color)    
    
    def same_color(self, other : Optional["Piece"]):
        return other != None and _same_color(self._piece_struct, other._piece_struct)

    def same_type(self, other : Optional["Piece"]):
        return other != None and _same_color(self._piece_struct, other._piece_struct)

    def is_type(self, piece_type : PieceType) -> bool:
        """
        Checks if this Piece is of the given type.
        """
        return bool(_piece_is_type(self._piece_struct, piece_type))

    def is_color(self, color : Color) -> bool:
        """
        Checks if this Piece is of the given color.
        """
        return bool(_piece_is_color(self._piece_struct, color))

    def __str__(self):
        return _piece_symbol(self._piece_struct).decode()
    
    def __repr__(self):
        return f"Piece({str(self)})"

    def __eq__(self, other):
        try:
            if other == None:
                return bool(_pieces_equal(self._piece_struct, _empty_piece))
            return bool(_pieces_equal(self._piece_struct, other._piece_struct))
        except:
            return False
        
    def __hash__(self) -> int:
        return int(_hash_piece(self._piece_struct))


def _piece_to_struct(piece : Optional[Piece]):
    if piece == None:
        return _empty_piece
    return piece._piece_struct
        




class Board(Structure):

    """A ```bulletchess.Board``` is a wrapper around a C ```struct``` which represents the state of a Chess board.
This class directly encodes the configuration of pieces, whose turn it is, castling rights, the existance of the en passant square, as well as the
halfmove clock and fullmove number
    """
        
    _fields_ = [
        ("position", POINTER(_POSITION)),
        ("turn", Color),
        ("castling_rights", CastlingRights),
        ("en_passant_square", _OPTIONAL_SQUARE),
        ("halfmove_clock", TurnClock),
        ("fullmove_number", TurnClock),
    ]
    
    @staticmethod
    def empty() -> "Board":
        """
        Creats a new Board for an empty position.
        """
        pos_pointer = pointer(_POSITION(0, 0, 0, 0, 0, 0, 0, 0))
        castling_rights = NO_CASTLING_RIGHTS
        turn = WHITE
        en_passant = _OPTIONAL_SQUARE(0, 0)
        halfmove = TurnClock(0)
        fullmove = TurnClock(0)
        full_board = Board(
            pos_pointer,
            turn,
            castling_rights,
            en_passant,
            halfmove,
            fullmove,
        )
        return full_board
    
    @staticmethod
    def from_fen(fen : str) -> "Board":
        """
        Creates a new Board using the given FEN description. 
        """
        board = Board.empty()
        buffer = create_string_buffer(init = fen.encode("utf-8"))
        error = _parse_fen(buffer, board)
        if error == None:
            return board
        else:
            error = bytes(error).decode()
            raise Exception(f"Invalid FEN {fen}: {error}")
        

    
    @staticmethod
    def starting() -> "Board":
        """
        Creates a new Board for the starting position
        """
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
        castling_rights = STARING_CASTLING_RIGHTS
        en_passant = _OPTIONAL_SQUARE(0, 0)
        turn = WHITE
        halfmove = TurnClock(0)
        fullmove = TurnClock(1)
        full_board = Board(
            pos_pointer,
            turn,
            castling_rights,
            en_passant,
            halfmove,
            fullmove,
        )
        return full_board
    
    # def pseudo_legal_moves(self) -> list[Move]:
    #     moves_buffer = (Move * 256)()
    #     length = _generate_pseudo_legal_moves(byref(self), self.turn, moves_buffer)
    #     out_list = []
    #     for i in range(length):
    #         out_list.append(moves_buffer[i])
    #     return out_list

    def legal_moves(self) -> list[Move]:
        moves_buffer = (Move * 256)()
        length = _generate_legal_moves(byref(self), self.turn, moves_buffer)
        out_list = []
        for i in range(length):
            out_list.append(moves_buffer[i])
        return out_list
    
    def count_legal_moves(self) -> int:
        moves_buffer = (Move * 256)()
        return int(_generate_legal_moves(byref(self), self.turn, moves_buffer))

    def apply(self, move : Move) -> None:
        """
        Mutates this board by applying the given move
        """
        _apply_move(byref(self), move)

    def piece_at(self, square : Square) -> Optional[Piece]:
        """
        Gets the piece at the specified Square
        """
        return Piece._from_struct(_get_piece_at(self.position, square))
    
    def remove_piece_at(self, square : Square) -> None:
        """
        Removes the Piece specified at the given square
        """
        _delete_piece_at(self.position, square)
    
    def set_piece_at(self, square : Square, piece : Optional[Piece]) -> None:
        """
        Sets the given square to have the given piece
        """
        piece_struct = _piece_to_struct(piece)
        _set_piece_at(self.position, square, piece_struct)


    def set_ep_square(self, square : Optional[Square]) -> None:
        """
        Sets the en-passant square to the given Square. If given None, this clears the ep square.
        """
        if square == None:
            self.clear_ep_square()
        else:    
            _set_ep_square(byref(self), square)

    def clear_ep_square(self) -> None:
        _clear_ep_square(byref(self))
    
    def get_ep_square(self) -> Optional[Square]:
        optional_square = self.en_passant_square
        if bool(optional_square.exists):
            return optional_square.square
        return None
        

    def get_halfmove_clock(self) -> int:
        return int(self.halfmove_clock)

    def get_fullmove_number(self) -> int:
        return int(self.fullmove_number)
    
    def set_halfmove_clock(self, value : int) -> None:
        self.halfmove_clock = TurnClock(value)

    def set_fullmove_number(self, value : int) -> None:
        self.fullmove_number = TurnClock(value)

    def in_check(self) -> bool:
        """
        Returns true if the side to move is in check
        """
        return bool(_in_check(byref(self), self.turn))
    
    def get_turn(self) -> Color:
        """
        Gets the Color of the player to move.
        """
        return self.turn

    def set_turn(self, player : Color) -> None:
        """
        Sets the Color of the player to move.
        """
        self.turn = player

    def has_queenside_castling_rights(self, color : Color) -> bool:
        """
        Returns True if the given color has queenside castling rights
        """
        return bool(_has_queenside_castling_rights(byref(self), color))
    
    def has_kingside_castling_rights(self, color : Color) -> bool:
        """
        Returns True if the given color has kingside castling rights
        """
        return bool(_has_kingside_castling_rights(byref(self), color))

        
    def has_castling_rights(self, color : Color) -> bool:
        """
        Returns True if the given color has any castling rights
        """
        return bool(_has_castling_rights(byref(self), color))
    
    def clear_castling_rights(self, color : Color) -> bool:
        """
        Clears all castling rights for the given color
        """
        return bool(_clear_castling_rights(byref(self), color))
    
    def set_full_castling_rights(self) -> None:
        """
        Restores full castling rights
        """
        _set_full_castling_rights(byref(self))

    def update_castling_rights(self, color : Color) -> None:
        """
        Removes castling rights for a given color if they are illegal 
        in the given board's piece configuation
        """
        _update_castling_rights(byref(self), color)

    def add_castling_rights(self, player : Color, kingside : bool):
        """
        Adds castling rights for either king or queen side for the given player.
        """
        _add_castling_rights(byref(self), c_bool(kingside), player)


    def __contains__(self, piece : Optional[Piece]):
        """
        Returns True if the given piece exists in this Board
        """
        piece_struct = _piece_to_struct(piece)
        return _contains_piece(byref(self), piece_struct)


    def __le__(self, other : "Board") -> bool:
        """
        Returns True if this Board's piece configuration is a subset of the given Board's piece configuration
        """
        return bool(_is_subset(byref(self), byref(other)))

    def __ge__(self, other : "Board"):
        """
        Returns True if the given Board's piece configuration is a subset of this Board's piece configuration
        """
        return bool(_is_subset(byref(other), byref(self)))


    def __eq__(self, other):
        """
        Returns True if compared with another Board that has the same position, as
        well as identical state aspects including the en-passant square, castling rights,
        the halfmove timer, and the fullmove clock.
        """
        if type(other) is type(self):
            return bool(_boards_equal(byref(self), byref(other)))
        return False
        
    def fen(self) -> str:
        """
        Returns a string of the FEN description of this Board.
        """
        fen = create_string_buffer(300)
        _make_fen(byref(self), fen)
        return fen.raw.rstrip(b'\x00 ').decode()
    
    def __str__(self) -> str:
        """
        Returns a string of the FEN description of this Board.
        """
        board = create_string_buffer(300)
        _make_board_string(byref(self), board)
        return board.raw.rstrip(b'\x00 ').decode()
    

    def __repr__(self):
        return f"Board({self.fen()})\n"
        
    def __hash__(self) -> int:
        """
        Returns a 64-bit integer hash of this Board using randomized Zobrist keys.
        """
        return int(_hash_board(byref(self), ZORBIST_TABLE))
    
    def copy(self) -> "Board":
        """
        Returns a copy of this Board
        """
        copy = Board.empty()
        _copy_into(byref(copy), byref(self))
        return copy
    
    def material(self, knight_value : int = 300, bishop_value : int = 300, rook_value : int = 500, queen_value : int = 900) -> int:
        return int(_material(self.position, c_int(knight_value), c_int(bishop_value), c_int(rook_value), c_int(queen_value)))
        
    def perft(self, depth : int) -> int:
        if depth < 0:
            raise Exception("Cannot perform perft with a negative depth")
        return _perft(byref(self), c_uint8(depth))
    
    def best_move(self, depth : int) -> Move:
        if depth < 0:
            raise Exception("Cannot perform search with a negative depth")
        res : SearchResult = _search(byref(self), c_uint8(depth))
        return res.move


# C LIBRARY IMPORTS

_material = clib.material
_material.restype = c_int
_material.argtypes = [POINTER(_POSITION), c_int, c_int, c_int, c_int]

_get_piece_at = clib.get_piece_at
_get_piece_at.restype = _PIECE
_get_piece_at.argtypes = [POINTER(_POSITION), Square]


_set_piece_at = clib.set_piece_at
_set_piece_at.argtypes = [POINTER(_POSITION), Square, _PIECE]

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

_piece_is_type = clib.piece_is_type
_piece_is_type.restype = c_bool
_piece_is_type.argtypes = [_PIECE, PieceType]

_piece_is_empty = clib.piece_is_empty
_piece_is_empty.restype = c_bool
_piece_is_empty.argtypes = [_PIECE]

_piece_is_color = clib.piece_is_color
_piece_is_color.restype = c_bool
_piece_is_color.argtypes = [_PIECE, Color]


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
_contains_piece.argtypes = [POINTER(_POSITION), _PIECE]
_contains_piece.restype = c_bool

_is_subset = clib.is_subset
_is_subset.argtypes = [POINTER(_POSITION), POINTER(_POSITION)]
_is_subset.restype = c_bool

_boards_equal = clib.boards_equal
_boards_equal.argtypes = [POINTER(Board), POINTER(Board)]
_boards_equal.restype = c_bool


_create_zobrist_table = clib.create_zobrist_table
_create_zobrist_table.restype = POINTER(_ZORBIST_TABLE)

_hash_board = clib.hash_board
_hash_board.argtypes = [POINTER(Board), POINTER(_ZORBIST_TABLE)]
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
_split_fen.restype = POINTER(_SPLIT_FEN)

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

_perft = clib.perft
_perft.argtypes = [POINTER(Board), c_uint8]
_perft.restype = c_uint64


# _prepare_move_table = clib.prepare_move_table
ZORBIST_TABLE = _create_zobrist_table()
# _prepare_move_table()

# CONSTANT DECLARATIONS 

PAWN : PieceType = _get_pawn_value()
BISHOP : PieceType = _get_bishop_value()
KNIGHT : PieceType = _get_knight_value()
ROOK : PieceType = _get_rook_value()
QUEEN : PieceType = _get_queen_value()
KING : PieceType = _get_king_value()
PIECE_TYPES = [PAWN, BISHOP, KNIGHT, ROOK, QUEEN, KING]

WHITE : Color = _get_white_value()
BLACK : Color = _get_black_value()

PAWNS_STARTING = Bitboard(71776119061282560)
KNIGHTS_STARTING = Bitboard(4755801206503243842)
BISHOPS_STARTING = Bitboard(2594073385365405732)
ROOKS_STARTING = Bitboard(9295429630892703873)
QUEENS_STARTING = Bitboard(576460752303423496)
KINGS_STARTING = Bitboard(1152921504606846992)
WHITE_STARTING = Bitboard(65535)
BLACK_STARTING = Bitboard(18446462598732840960)

STARING_CASTLING_RIGHTS = CastlingRights(0xF)
NO_CASTLING_RIGHTS = CastlingRights(0)

SQUARES: list[Square] = list(range(64))
A1: Square = 0
B1: Square = 1
C1: Square = 2
D1: Square = 3
E1: Square = 4
F1: Square = 5
G1: Square = 6
H1: Square = 7
A2: Square = 8
B2: Square = 9
C2: Square = 10
D2: Square = 11
E2: Square = 12
F2: Square = 13
G2: Square = 14
H2: Square = 15
A3: Square = 16
B3: Square = 17
C3: Square = 18
D3: Square = 19
E3: Square = 20
F3: Square = 21
G3: Square = 22
H3: Square = 23
A4: Square = 24
B4: Square = 25
C4: Square = 26
D4: Square = 27
E4: Square = 28
F4: Square = 29
G4: Square = 30
H4: Square = 31
A5: Square = 32
B5: Square = 33
C5: Square = 34
D5: Square = 35
E5: Square = 36
F5: Square = 37
G5: Square = 38
H5: Square = 39
A6: Square = 40
B6: Square = 41
C6: Square = 42
D6: Square = 43
E6: Square = 44
F6: Square = 45
G6: Square = 46
H6: Square = 47
A7: Square = 48
B7: Square = 49
C7: Square = 50
D7: Square = 51
E7: Square = 52
F7: Square = 53
G7: Square = 54
H7: Square = 55
A8: Square = 56
B8: Square = 57
C8: Square = 58
D8: Square = 59
E8: Square = 60
F8: Square = 61
G8: Square = 62
H8: Square = 63


_empty_piece = _PIECE(0, 0)
