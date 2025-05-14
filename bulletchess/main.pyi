from typing import Optional, Any, Collection, Iterator


class Color:

    """
    @staticmethod
    def from_str(color : str) -> Color:
        ...
    """

    def __eq__(self, other : Any) -> bool:
        ...

    def __hash__(self) -> int:
        ...

    def __str__(self) -> str:
        ...


WHITE : Color
BLACK : Color

class PieceType:


    @staticmethod
    def from_str(piece_type : str) -> PieceType:
        ...

    def __eq__(self, other : Any) -> bool:
        ...

    def __hash__(self) -> int:
        ...

    def __str__(self) -> str:
        ...


PAWN : PieceType
KNIGHT : PieceType
BISHOP : PieceType
ROOK : PieceType
QUEEN : PieceType
KING : PieceType

PIECE_TYPES : list[PieceType] = [PAWN, KNIGHT, BISHOP, ROOK, QUEEN, KING]


class Piece:

    def __init__(self, color : Color, type : PieceType):
        ...

    @staticmethod
    def from_str(piece_str : str) -> Piece:
        ...

    @property
    def piece_type(self) -> Piece:
        ...

    @property
    def color(self) -> Piece:
        ...

    def __eq__(self, other : Any):
        ...

    def __hash__(self) -> int: 
        ...

    def __str__(self) -> str:
        ...


class Square:


    @staticmethod
    def from_str(square_str : str) -> Square:
        ...

    """
    @staticmethod
    def from_int(square_num : int) -> Square:
        ...

    def __int__(self) -> int:
        ...
    """


    def north(self) -> Optional[Square]: ...

    def south(self) -> Optional[Square]: ...

    def east(self) -> Optional[Square]: ...

    def west(self) -> Optional[Square]: ...

    def __eq__(self, other : Any) -> bool:
        ...

    def __hash__(self) -> int:
        ...

    def __str__(self) -> str:
        ...


A1 : Square
B1 : Square
C1 : Square
D1 : Square
E1 : Square
F1 : Square
G1 : Square
H1 : Square
A2 : Square
B2 : Square
C2 : Square
D2 : Square
E2 : Square
F2 : Square
G2 : Square
H2 : Square
A3 : Square
B3 : Square
C3 : Square
D3 : Square
E3 : Square
F3 : Square
G3 : Square
H3 : Square
A4 : Square
B4 : Square
C4 : Square
D4 : Square
E4 : Square
F4 : Square
G4 : Square
H4 : Square
A5 : Square
B5 : Square
C5 : Square
D5 : Square
E5 : Square
F5 : Square
G5 : Square
H5 : Square
A6 : Square
B6 : Square
C6 : Square
D6 : Square
E6 : Square
F6 : Square
G6 : Square
H6 : Square
A7 : Square
B7 : Square
C7 : Square
D7 : Square
E7 : Square
F7 : Square
G7 : Square
H7 : Square
A8 : Square
B8 : Square
C8 : Square
D8 : Square
E8 : Square
F8 : Square
G8 : Square
H8 : Square

SQUARES : list[Square] = [A1, B1, C1, D1, E1, F1, G1, H1, A2, B2, ..., H8]

class Bitboard:

    def __init__(self, squares : Collection[Square]):
        ...


    """
    def __str__(self) -> str:
        ...

    def __repr__(self) -> str:
        ...
    """
    
    @staticmethod
    def from_int(value : int):
        ...

    def __iter__(self) -> Iterator[Square]:
        ...

    def __getitem__(self, square : Square) -> bool:
        ...

    def __setitem__(self, square : Square, value : bool):
        ...

    def __delitem__(self, square : Square):
        ...

    def __len__(self) -> int:
        ...

    def __contains__(self, square : Square) -> bool:
        ...

    def __eq__(self, other : Any) -> bool:
        ...

    def __invert__(self) -> "Bitboard":
        ...

    def __and__(self, other : "Bitboard") -> "Bitboard":
        ...

    def __or__(self, other : "Bitboard") -> "Bitboard":
        ...

    def __xor__(self, other : "Bitboard") -> "Bitboard":
        ...

    def __int__(self) -> int:
        ...

    def __bool__(self) -> bool:
        ...

RANK_1 : Bitboard
RANK_2 : Bitboard
RANK_3 : Bitboard
RANK_4 : Bitboard
RANK_5 : Bitboard
RANK_6 : Bitboard
RANK_7 : Bitboard
RANK_8 : Bitboard

A_FILE : Bitboard
B_FILE : Bitboard
C_FILE : Bitboard
D_FILE : Bitboard
E_FILE : Bitboard
F_FILE : Bitboard
G_FILE : Bitboard
H_FILE : Bitboard

FULL_BB : Bitboard
EMPTY_BB : Bitboard
LIGHT_SQUARE_BB : Bitboard
DARK_SQUARE_BB : Bitboard
class CastlingType:

    @staticmethod
    def from_str(castling_type : str) -> str: ...

    def __str__(self) -> str: ...

    def __repr__(self) -> str: ...

    def __eq__(self, other : Any) -> bool: ...

    def __hash__(self) -> int: ...


WHITE_KINGSIDE : CastlingType
WHITE_QUEENSIDE : CastlingType
BLACK_KINGSIDE : CastlingType
BLACK_QUEENSIDE : CastlingType

class Move:

    def __init__(self, 
                    origin : Square, 
                    destination : Square, 
                    promote_to : Optional[PieceType] = None):
        ...

    @staticmethod
    def castle(castling_type : CastlingType) -> Move: 
        ...

    @staticmethod
    def from_uci(uci : str) -> Optional["Move"]:
        ...

    @property 
    def origin(self) -> Square:
        ...

    @property
    def destination(self) -> Square:
        ...

    @property
    def promotion(self) -> Optional[PieceType]:
        ...

    def __eq__(self, other : Any) -> bool:
        ...

    def __hash__(self) -> int: 
        ...

    @staticmethod
    def from_san(san : str, board : "Board") -> "Move":
        ...

    def san(self, board : "Board") -> str:
        ...

    def uci(self) -> str:
        ...

    def is_promotion(self) -> bool:
        ...

    def is_capture(self, board : Board) -> bool:
        ...

    def is_castling(self, board : Board) -> bool:
        ...

    def castling_type(self, board : Board) -> Optional[CastlingType]:
        ...

    def __str__(self) -> str:
        ...


class CastlingRights:

    def __init__(self, castling_types : Collection[CastlingType]) -> None:
        ...

    """
    @staticmethod
    def full() -> "CastlingRights":
        ...
    """

    def __contains__(self, castling_type : CastlingType) -> bool:
        ...

    def __add__(self, other : CastlingRights) -> CastlingRights:
        ...

    def __eq__(self, other : Any) -> bool:
        ...

    def __le__(self, other : Any) -> bool:
        ...

    def __str__(self) -> str:
        ...

    def __repr__(self) -> str:
        ...

    def full(self) -> bool: ...

    def any(self) -> bool: ...

    def kingside(self, color : Optional[Color] = None) -> bool: ...

    def queenside(self, color : Optional[Color] = None) -> bool: ...

    """
    def has_all(self) -> bool: ...

    def has_any(self) -> bool: ...

    def has_kingside(self, color : Optional[Color] = None) -> bool: ...

    def has_queenside(self, color : Optional[Color] = None) -> bool: ...
    """

class Board:

    def __init__(self) -> None:
        ...

    @staticmethod
    def from_fen(fen : str) -> "Board":
        ...

    @staticmethod
    def random() -> "Board":
        ...

    @staticmethod
    def empty() -> "Board":
        ...

    @property
    def turn(self) -> Color:
        ...

    @property
    def halfmove_clock(self) -> int:
        ...

    @property
    def fullmove_number(self) -> int:
        ...

    @property
    def en_passant_square(self) -> Optional[Square]:
        ...

    @property
    def castling_rights(self) -> CastlingRights:
        ...

    @castling_rights.setter
    def castling_rights(self, castling_rights : CastlingRights) -> None:
        ...

    @turn.setter
    def turn(self, new_turn : Color) -> None:
        ...

    @halfmove_clock.setter
    def halfmove_clock(self, new_halfmove_clock : int) -> None:
        ...

    @fullmove_number.setter
    def fullmove_number(self, new_fullmove_number : int) -> None:
        ...

    @en_passant_square.setter
    def en_passant_square(self, new_ep_square : Optional[Square]) -> None:
        ...

    @castling_rights.setter
    def castling_rights(self) -> CastlingRights:
        ...

    def is_checkmate(self) -> bool:
        ...

    def is_stalemate(self) -> bool:
        ...

    def is_check(self) -> bool:
        ...

    def is_insufficient_material(self) -> bool:
        ...

    def is_forced_draw(self) -> bool:
        ...

    def is_draw(self) -> bool:
        ...
    
    def is_fifty_move_timeout(self) -> bool:
        ...

    def is_seventy_five_move_timeout(self) -> bool:
        ...

    def is_threefold_repetition(self) -> bool:
        ...

    def is_fivefold_reptition(self) -> bool:
        ...

    """


    def is_nfold_repetition(self, n : int) -> bool:
        ...
    """


    def legal_moves(self) -> list[Move]:
        ...

    def apply(self, move : Optional[Move]) -> None:
        ...

    def undo(self) -> Move: 
        ...

    def fen(self) -> str:
        ...

    def copy(self) -> "Board":
        ...

    def __getitem__(self, square : Square) -> Optional[Piece]:
        ...

    def __setitem__(self, square : Square, piece : Optional[Piece]):
        ...

    def __delitem__(self, square : Square):
        ...

    def __eq__(self, other : Any) -> bool:
        ...

    def __hash__(self) -> int:
        ...
    
    def __contains__(self, piece : Optional[Piece]) -> bool:
        ...

    """
    def status(self) -> "BoardStatus":
        ...

    """
    @property
    def pawns(self) -> Bitboard:
        ...

    @property
    def knights(self) -> Bitboard:
        ...

    @property
    def bishops(self) -> Bitboard:
        ...

    @property
    def rooks(self) -> Bitboard:
        ...

    @property
    def queens(self) -> Bitboard:
        ...

    @property
    def kings(self) -> Bitboard:
        ...

    @property
    def white(self) -> Bitboard:
        ...

    @property
    def black(self) -> Bitboard:
        ...

    @property
    def unoccupied(self) -> Bitboard:
        ...

"""
class BoardStatus:
    ...

"""

