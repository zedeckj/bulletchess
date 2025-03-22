from typing import Optional, Any, Collection, NewType
from warnings import deprecated
import typing
from enum import Enum
import os
import sys

path = os.path.dirname(os.path.abspath(__file__))
sys.path.append(path)

# goal should be removing ctypes import from this file

import backend

class Color(Enum):
    BLACK = backend._BLACK
    WHITE = backend._WHITE

    def __str__(self):
        return self.name

    def __repr__(self):
        return str(self)


class PieceType(Enum):
    PAWN = backend._PAWN
    KNIGHT = backend._KNIGHT
    BISHOP = backend._BISHOP
    ROOK = backend._ROOK
    QUEEN = backend._QUEEN
    KING = backend._KING

    def __str__(self):
        return self.name

    def __repr__(self):
        return str(self)


class Square(Enum):
    A1 = 0
    B1 = 1
    C1 = 2
    D1 = 3
    E1 = 4
    F1 = 5
    G1 = 6
    H1 = 7
    A2 = 8
    B2 = 9
    C2 = 10
    D2 = 11
    E2 = 12
    F2 = 13
    G2 = 14
    H2 = 15
    A3 = 16
    B3 = 17
    C3 = 18
    D3 = 19
    E3 = 20
    F3 = 21
    G3 = 22
    H3 = 23
    A4 = 24
    B4 = 25
    C4 = 26
    D4 = 27
    E4 = 28
    F4 = 29
    G4 = 30
    H4 = 31
    A5 = 32
    B5 = 33
    C5 = 34
    D5 = 35
    E5 = 36
    F5 = 37
    G5 = 38
    H5 = 39
    A6 = 40
    B6 = 41
    C6 = 42
    D6 = 43
    E6 = 44
    F6 = 45
    G6 = 46
    H6 = 47
    A7 = 48
    B7 = 49
    C7 = 50
    D7 = 51
    E7 = 52
    F7 = 53
    G7 = 54
    H7 = 55
    A8 = 56
    B8 = 57
    C8 = 58
    D8 = 59
    E8 = 60
    F8 = 61
    G8 = 62
    H8 = 63

    def __str__(self):
        return self.name.lower()

A1 = Square.A1
B1 = Square.B1
C1 = Square.C1
D1 = Square.D1
E1 = Square.E1
F1 = Square.F1
G1 = Square.G1
H1 = Square.H1
A2 = Square.A2
B2 = Square.B2
C2 = Square.C2
D2 = Square.D2
E2 = Square.E2
F2 = Square.F2
G2 = Square.G2
H2 = Square.H2
A3 = Square.A3
B3 = Square.B3
C3 = Square.C3
D3 = Square.D3
E3 = Square.E3
F3 = Square.F3
G3 = Square.G3
H3 = Square.H3
A4 = Square.A4
B4 = Square.B4
C4 = Square.C4
D4 = Square.D4
E4 = Square.E4
F4 = Square.F4
G4 = Square.G4
H4 = Square.H4
A5 = Square.A5
B5 = Square.B5
C5 = Square.C5
D5 = Square.D5
E5 = Square.E5
F5 = Square.F5
G5 = Square.G5
H5 = Square.H5
A6 = Square.A6
B6 = Square.B6
C6 = Square.C6
D6 = Square.D6
E6 = Square.E6
F6 = Square.F6
G6 = Square.G6
H6 = Square.H6
A7 = Square.A7
B7 = Square.B7
C7 = Square.C7
D7 = Square.D7
E7 = Square.E7
F7 = Square.F7
G7 = Square.G7
H7 = Square.H7
A8 = Square.A8
B8 = Square.B8
C8 = Square.C8
D8 = Square.D8
E8 = Square.E8
F8 = Square.F8
G8 = Square.G8
H8 = Square.H8

SQUARES = [square for square in Square]

WHITE = Color.WHITE
BLACK = Color.BLACK

PAWN = PieceType.PAWN
KNIGHT = PieceType.KNIGHT
BISHOP = PieceType.BISHOP
ROOK = PieceType.ROOK
QUEEN = PieceType.QUEEN
KING = PieceType.KING


PIECE_TYPES = [piece_type for piece_type in PieceType]

class Piece:

    __slots__ = ("__color", "__piece_type", "__struct")


    def __init__(self, color : Color, piece_type : PieceType):
        self.__color = color
        self.__piece_type = piece_type
    
    def __new__(cls, color : Color, piece_type : PieceType):
        if not hasattr(cls, "instances"):
            Piece.instances = {}
            for pt in PieceType:
                for c in Color:
                    piece = object.__new__(Piece)
                    Piece.__init__(piece, c, pt)
                    Piece.instances[(c,pt)] = piece
        try:
            return cls.instances[(color, piece_type)]       
        except:
            if type(color) != Color:
                raise ValueError(f"Cannot construct a piece with invalid Color {color}")
            elif type(piece_type) != PieceType:
                raise ValueError(f"Cannot construct a piece with invalid PieceType {piece_type}")
            else:
                raise Exception("Piece initilization failed")


    @staticmethod
    def from_symbol(symbol : str) -> Optional["Piece"]:
        try:
            return SYMBOLS_TO_PIECES[symbol]
        except:
            raise ValueError(f"Invalid piece symbol: {symbol}")
        
    @property
    def color(self) -> Color:
        return self.__color

    @property
    def piece_type(self) -> PieceType:
        return self.__piece_type

    def __str__(self) -> str:
        return PIECE_SYMBOLS[self]

    def __repr__(self) -> str:
        return f"Piece({str(self)})"

    def __hash__(self) -> int:
        return self.__color.value + (2 * self.__piece_type.value)

PIECES = [
    None,
    Piece(WHITE,PAWN),
    Piece(WHITE,KNIGHT),
    Piece(WHITE,BISHOP),
    Piece(WHITE,ROOK),
    Piece(WHITE,QUEEN),
    Piece(WHITE,KING),
    Piece(BLACK,PAWN),
    Piece(BLACK,KNIGHT),
    Piece(BLACK,BISHOP),
    Piece(BLACK,ROOK),
    Piece(BLACK,QUEEN),
    Piece(BLACK,KING)
]

PIECE_INDEXES = {
    None : 0,
    Piece(WHITE,PAWN) : 1,
    Piece(WHITE,KNIGHT) : 2,
    Piece(WHITE,BISHOP) : 3,
    Piece(WHITE,ROOK) : 4,
    Piece(WHITE,QUEEN) : 5,
    Piece(WHITE,KING) : 6,
    Piece(BLACK,PAWN) : 7,
    Piece(BLACK,KNIGHT) : 8,
    Piece(BLACK,BISHOP) : 9,
    Piece(BLACK,ROOK) : 10,
    Piece(BLACK,QUEEN) : 11,
    Piece(BLACK,KING) : 12
}

PIECE_SYMBOLS = {
    None : '-',
    Piece(WHITE,PAWN) : 'P',
    Piece(WHITE,KNIGHT) : 'N',
    Piece(WHITE,BISHOP) : 'B',
    Piece(WHITE,ROOK) : 'R',
    Piece(WHITE,QUEEN) : 'Q',
    Piece(WHITE,KING) : 'K',
    Piece(BLACK,PAWN) : 'p',
    Piece(BLACK,KNIGHT) : 'n',
    Piece(BLACK,BISHOP) : 'b',
    Piece(BLACK,ROOK) : 'r',
    Piece(BLACK,QUEEN) : 'q',
    Piece(BLACK,KING) : 'k',
}

SYMBOLS_TO_PIECES = {
    '-': None,
    'P': Piece(WHITE,PAWN),
    'N': Piece(WHITE,KNIGHT),
    'B': Piece(WHITE,BISHOP),
    'R': Piece(WHITE,ROOK),
    'Q': Piece(WHITE,QUEEN),
    'K': Piece(WHITE,KING),
    'p': Piece(BLACK,PAWN),
    'n': Piece(BLACK,KNIGHT),
    'b': Piece(BLACK,BISHOP),
    'r': Piece(BLACK,ROOK),
    'q': Piece(BLACK,QUEEN),
    'k': Piece(BLACK,KING)
}

class Move:

    __slots__ = ("__struct",)

    def __init__(self, origin : Square, 
                       destination : Square, 
                       promote_to : Optional[PieceType] = None):
        try:
            pt = backend._EMPTY_PIECE_TYPE if promote_to == None else promote_to.value
            self.__struct = backend._make_move_from_parts(origin.value, 
                                                      destination.value, 
                                                      pt)
        except:
            if type(origin) != Square:
                raise ValueError(f"Invalid origin is not a Square: {origin}")
            if type(destination) != Square:
                raise ValueError(f"Invalid destination is not a Square: {destination}")
            if promote_to != None and type(promote_to) != PieceType:
                raise ValueError(f"Invalid promote to value is not a PieceType: {promote_to}")
            raise Exception(f"Move initialization failed")
    
    @staticmethod
    def __inst(__struct : backend._MOVE) -> "Move":
        move = object.__new__(Move)
        move.__struct = __struct
        return move

    @staticmethod
    def from_uci(uci : str) -> "Move":
        return Move.__inst(backend._init_move_from_uciPY(uci))

    @property
    def origin(self) -> Square:
        return Square(backend._get_origin(self.__struct))

    @property
    def destination(self) -> Square:
        return Square(backend._get_destination(self.__struct))
    
    @property
    def promotes_to(self) -> Optional[PieceType]:
        return _C_PIECE_STRUCT_TABLE[backend._promotes_to(self.__struct)]
    
    def is_promption(self) -> bool:
        return bool(backend._is_promotion(self.__struct))

    def __str__(self) -> str:
        return backend._write_uciPY(self.__struct)

    def __hash__(self) -> int:
        return int(backend._hash_move(self.__struct))

    def __eq__(self, other : Any) -> bool:
        if type(other) == Move:
            return bool(backend._moves_equal(self.__struct, other.__struct))
        return False

    def __repr__(self) -> str:
        return f"Move({str(self)})"

class Bitboard:

    __slots__ = ("__int",)

    def __init__(self, squares : Collection[Square]):
        squares_array = (backend._SQUARE * 64)(*[square.value for square in squares])
        self.__int = backend._from_squares(squares_array, len(squares))

    @staticmethod
    def __inst(__int : backend._BITBOARD) -> "Bitboard":
        bb = object.__new__(Bitboard)
        bb.__int = __int
        return bb

    def __str__(self):
        return backend._write_bitboardPY(self.__int)

    def __contains__(self, square : Square):
        if type(square) == Square:
            return backend._square_in_bitboard(self.__int, square.value); 
        return False

    def __or__(self, other : "Bitboard") -> "Bitboard":
        return Bitboard.__inst(self.__int | other.__int)

    def __and__(self, other : "Bitboard") -> "Bitboard":
        return Bitboard.__inst(self.__int & other.__int)

    def __xor__(self, other : "Bitboard") -> "Bitboard":
        return Bitboard.__inst(self.__int ^ other.__int)

    def __invert__(self) -> "Bitboard":
        return Bitboard.__inst(~self.__int)

    def __eq__(self, other : Any) -> bool:
        if type(other) == Bitboard:
            return self.__int == other.__int
        return False



class Board:


    __slots__ = ("__pointer", "__move_stack", "__piece_array")

    def __init__(self):
        self.__piece_array = (backend._PIECE_INDEX * 64)()
        self.__pointer = backend._init_starting_boardPY() 
        self.__move_stack = []
        backend._fill_piece_index_array(self.__pointer, self.__piece_array)
    
    @staticmethod
    def starting() -> "Board":
        return Board()

    @staticmethod
    def __inst(__pointer : backend.POINTER(backend._BOARD),
                 __move_stack : list[backend._UNDOABLE_MOVE]):
        board = object.__new__(Board)
        board.__piece_array = (backend._PIECE_INDEX * 64)()
        board.__pointer = __pointer
        board.__move_stack = __move_stack
        backend._fill_piece_index_array(board.__pointer, board.__piece_array)
        return board        


    @staticmethod
    def from_fen(fen : str) -> "Board":
        pointer = backend._init_board_from_fenPY(fen)
        return Board.__inst(pointer, [])

    @staticmethod
    def empty() -> "Board":
        pointer = backend._init_empty_boardPY()
        return Board.__inst(pointer, [])

    @staticmethod
    def random() -> "Board":
       board = Board()
       backend._randomize_board(board.__pointer)
       return board

    @staticmethod
    def __make_piece_list(__pointer : backend.POINTER(backend._BOARD)):
        return [Piece._Piece__inst(struct) for struct in 
                backend._make_piece_arrayPY(__pointer)[0:64]]

    def copy(self) -> "Board":
        pointer = backend._alloc_boardPY()
        cpy = Board.__inst(pointer, self.__move_stack.copy())
        backend._copy_into(cpy.__pointer, self.__pointer)
        return cpy

    def validate(self):
        """
        Raises an Exception if this Board is invalid 
        """
        error = backend._validate_board(self.__pointer)
        if error != None:
            raise ValueError(error.decode("utf-8"))
 

    @property 
    def ep_square(self) -> Optional[Square]:
        """
        The current en passant Square, or None if it does not exist.
        """
        optional_square = self.__pointer.contents.en_passant_square
        if bool(optional_square.exists):
            return Square(optional_square.square)
        return None

    @ep_square.setter
    def ep_square(self, square : Optional[Square]):
        if square == None:
            backend._clear_ep_square(self.__pointer)
        else:
            if type(square) == Square:
                error = backend._set_ep_square_checked(self.__pointer, square.value)
            else:
                raise ValueError(f"Illegal en passant Square, {square} is not a valid Square")
            if error != None:
                raise ValueError(error.decode("utf-8").format(ep = str(square)))

    @property
    def turn(self) -> Color:
        """
        The Color of the player whose turn it is.
        """
        return Color(self.__pointer.contents.turn)

    @turn.setter
    def turn(self, color : Color):
        if type(color) == Color:
            self.__pointer.contents.turn = color.value
        else:
            raise ValueError(f"Cannot set turn to a value that is not WHITE or BLACK, got: {color}")

    @property
    def halfmove_clock(self) -> int:
        """
        The number of ply that have passed since a pawn advancement or a capture.
        """
        return int(self.__pointer.contents.halfmove_clock)


    @halfmove_clock.setter
    def halfmove_clock(self, value : int):
        if value < 0:
            raise ValueError(f"Cannot set halfmove clock to a negative value, but got {value}")
        elif value > 65535:
            raise ValueError(f"Cannot set halfmove clock to a value greater than 65535, but got {value}")
        else:
            self.__pointer.contents.halfmove_clock = backend._TURN_CLOCK(value) 

    @property
    def fullmove_number(self) -> int:
        """
        The turn number of the current Board, which is initialized to 1 in the starting position.
        After both players have made a move, the fullmove number increments by 1.
        """
        return int(self.__pointer.contents.fullmove_number)


    @fullmove_number.setter
    def fullmove_number(self, value : int):
        if value < 0:
            raise ValueError(f"Cannot set fullmove number to a negative value, but got {value}")
        elif value > 65535:
            raise ValueError(f"Cannot set fullmove number to a value greater than 65535, but got {value}")
        else:
            self.__pointer.contents.fullmove_number = backend._TURN_CLOCK(value) 

    def fen(self) -> str:
        return backend._make_fenPY(self.__pointer)

    def perft(self, depth: int) -> int:
        if depth < 0:
            raise ValueError("Cannot perform perft with a negative depth")
        if depth > 255:
            raise ValueError("Cannot perform perft with a value > 255, this would take longer than the heat death of the Universe")
        return backend._perft(self.__pointer, depth)


    def legal_moves(self) -> list[Move]:
        moves_buffer = (backend._MOVE * 256)()
        length = backend._generate_legal_moves(self.__pointer, moves_buffer)
        return [Move._Move__inst(m) for m in moves_buffer[:length]]

    def count_moves(self) -> int:
        return int(backend._count_moves(self.__pointer))

    def apply(self, move : Move) -> None:
        if type(move) != Move:
            raise ValueError(f"Board.apply() expected a Move, got {move}, which is a {type(move)}") 
        self.__move_stack.append(backend._apply_move(self.__pointer, self.__piece_array, move._Move__struct))

    def undo(self) -> Move:
        undoable = self.__move_stack.pop()
        move = Move._Move__inst(backend._undo_move(self.__pointer, self.__piece_array, undoable))

    def in_check(self) -> bool:
        return bool(backend._in_check(self.__pointer))

    def is_checkmate(self) -> bool:
        return bool(backend._is_checkmate(self.__pointer))

    def is_stalemate(self) -> bool:
        return bool(backend._is_stalemate(self.__pointer))

    def is_draw(self) -> bool:
        ln = len(self.__move_stack)
        moves_array = (backend._UNDOABLE_MOVE * ln)(*self.__move_stack)
        return bool(backend._is_draw(self.__pointer, moves_array, ln))

    def bitboard_of(self, piece : Optional[Piece]) -> Bitboard: 
        struct = _get_piece_struct(piece)
        return Bitboard(backend._get_piece_bb(self.__pointer, struct))


    def get_piece_at(self, square : Square) -> Optional[Piece]:
        if type(square) != Square:
            raise ValueError("Board.get_piece_at() expected a Square, got {square}")
        #return PIECES[backend._get_piece_at(self.__pointer, square.value)]
        #return PIECES[backend._index_into(self.__piece_array, square.value)]
        return PIECES[self.__piece_array[square.value]]

    def set_piece_at(self, square : Square, piece : Optional[Piece]) -> None:
        if type(square) != Square:
            raise ValueError("Board.set_piece_at() expected a Square, got {square}")
        try:
            index = PIECE_INDEXES[piece]
        except:
            raise ValueError(f"Invalid piece: {piece}")
        backend._set_piece_index(self.__pointer, self.__piece_array, square.value, index)


    def delete_piece_at(self, square : Square) -> None:
        if type(square) != Square:
            raise Exception("Board.delete_piece_at() expected a Square, got {square}")
        backend._delete_piece_at(self.__pointer, self.__piece_array, square.value)

    def __eq__(self, other : Any):
        """
        Returns True if compared with another Board that has the same position, as
        well as identical state aspects including the en-passant square, castling rights,
        the halfmove timer, and the fullmove clock.
        """
        if type(other) is type(self):
            return bool(backend._boards_equal(self.__pointer, other.__pointer))
        return False

    def __str__(self) -> str:
        return backend._make_board_stringPY(self.__pointer)

    def __eq__(self, other : Any) -> bool: 
        if type(other) == Board:
            return bool(backend._boards_equal(self.__pointer, other.__pointer))
        return False
    
    def __hash__(self) -> int:
        return int(backend._hash_board(self.__pointer))



def _get_piece_struct(piece : Optional[Piece]):
    if piece == None:
        return backend._EMPTY_PIECE
    else:
        return piece._Piece__struct
        

