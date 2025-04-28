from typing import Optional, Any

class Color:

    def __eq__(self, other : Any) -> bool:
        ...

    def __hash__(self) -> int:
        ...

    def __str__(self) -> str:
        ...


WHITE : Color
BLACK : Color

class PieceType:

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

SQUARES : list[Square] = [A1, B1, C1, D1, E1, F1, G1, H1, A2, ..., H8]


class Move:

    def __init__(self, 
                    origin : Square, 
                    destination : Square, 
                    promote_to : Optional[PieceType] = None):
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

    """
    @staticmethod
    def from_san(san : str, board : "Board") -> "Move":
        ...

    def uci(self) -> str:
        ...

    def san(self, board : "Board") -> str:
        ...

    def __hash__(self) -> int: 
        ...

    def __str__(self) -> str:
        ...
    """

class Board:

    def __init__(self) -> None:
        ...

    @staticmethod
    def from_fen(fen : str) -> "Board":
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

    def fen(self) -> str:
        ...

    def __eq__(self, other : Any) -> bool:
        ...

    def __hash__(self) -> int:
        ...


__all__ = [
    "Color",
    "WHITE",
    "BLACK",
    "PieceType",
    "PAWN",
    "KNIGHT",
    "BISHOP",
    "ROOK",
    "QUEEN",
    "KING",
    "PIECE_TYPES",
    "Board",
    "Square",
    "A1",
    "B1",
    "C1",
    "D1",
    "E1",
    "F1",
    "G1",
    "H1",
    "A2",
    "B2",
    "C2",
    "D2",
    "E2",
    "F2",
    "G2",
    "H2",
    "A3",
    "B3",
    "C3",
    "D3",
    "E3",
    "F3",
    "G3",
    "H3",
    "A4",
    "B4",
    "C4",
    "D4",
    "E4",
    "F4",
    "G4",
    "H4",
    "A5",
    "B5",
    "C5",
    "D5",
    "E5",
    "F5",
    "G5",
    "H5",
    "A6",
    "B6",
    "C6",
    "D6",
    "E6",
    "F6",
    "G6",
    "H6",
    "A7",
    "B7",
    "C7",
    "D7",
    "E7",
    "F7",
    "G7",
    "H7",
    "A8",
    "B8",
    "C8",
    "D8",
    "E8",
    "F8",
    "G8",
    "H8",
    "SQUARES",
    "Piece",
    "Move",
]