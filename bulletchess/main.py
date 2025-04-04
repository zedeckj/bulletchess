from typing import Optional, Any, Collection, NewType, Callable, Union, Literal, TypeAlias
from warnings import deprecated
import typing
from enum import Enum, unique
import os
import sys
from array import array

path = os.path.dirname(os.path.abspath(__file__))
sys.path.append(path)

import backend as _backend


class Color:

    """
    Represents either White or Black, used to identity the two players 
    and their pieces.
    """


    def __init__(self, value : bool):
        self.__value = bool(value)

    def __str__(self) -> str:
        return ["BLACK", "WHITE"][self.__value]

    def __repr__(self) -> str:
        return str(self)
    
    def __invert__(self) -> "Color":
        return Color(not self.__value)

    def __bool__(self) -> bool:
        return self.__value

    def __int__(self) -> int:
        return int(self.__value)

    def __eq__(self, other : Any) -> bool:
        try:
            return self.__value == other.__value
        except:
            return False

    def __hash__(self) -> int:
        return int(self)

@unique
class PieceType(Enum):

    """
    A PieceType is on of the types of pieces in Chess, 
    either a Pawn, a Knight, a Bishop, a Rook, a Queen, or a King.
    """

    PAWN = _backend.PAWN_VAL
    KNIGHT = _backend.KNIGHT_VAL
    BISHOP = _backend.BISHOP_VAL
    ROOK = _backend.ROOK_VAL
    QUEEN = _backend.QUEEN_VAL
    KING = _backend.KING_VAL

    def __str__(self):
        return self.name

    def __repr__(self):
        return str(self)

    def __int__(self):
        return int(self.value)

class Square:

    """
    A Square represents one of the 64 squares on a Chess board.
    """

    __slots__ = ["value"]

    def __init__(self, value : int):
        self.value = value

    def __str__(self):
        rank = chr(self.value // 8 + ord('1'))
        file = chr(self.value % 8 + ord('a'))
        return f"{file}{rank}"

    def __repr__(self):
        return str(self)
    
    def __eq__(self, other : Any):
        if type(other) == Square:
            return self.value == other.value
        return False

    def __hash__(self) -> int:
        return self.value

A1 = Square(0)
B1 = Square(1)
C1 = Square(2)
D1 = Square(3)
E1 = Square(4)
F1 = Square(5)
G1 = Square(6)
H1 = Square(7)
A2 = Square(8)
B2 = Square(9)
C2 = Square(10)
D2 = Square(11)
E2 = Square(12)
F2 = Square(13)
G2 = Square(14)
H2 = Square(15)
A3 = Square(16)
B3 = Square(17)
C3 = Square(18)
D3 = Square(19)
E3 = Square(20)
F3 = Square(21)
G3 = Square(22)
H3 = Square(23)
A4 = Square(24)
B4 = Square(25)
C4 = Square(26)
D4 = Square(27)
E4 = Square(28)
F4 = Square(29)
G4 = Square(30)
H4 = Square(31)
A5 = Square(32)
B5 = Square(33)
C5 = Square(34)
D5 = Square(35)
E5 = Square(36)
F5 = Square(37)
G5 = Square(38)
H5 = Square(39)
A6 = Square(40)
B6 = Square(41)
C6 = Square(42)
D6 = Square(43)
E6 = Square(44)
F6 = Square(45)
G6 = Square(46)
H6 = Square(47)
A7 = Square(48)
B7 = Square(49)
C7 = Square(50)
D7 = Square(51)
E7 = Square(52)
F7 = Square(53)
G7 = Square(54)
H7 = Square(55)
A8 = Square(56)
B8 = Square(57)
C8 = Square(58)
D8 = Square(59)
E8 = Square(60)
F8 = Square(61)
G8 = Square(62)
H8 = Square(63)


SQUARES = [Square(i) for i in range(64)]

WHITE = Color(True)
BLACK = Color(False)
COLORS = [WHITE, BLACK]

PAWN = PieceType.PAWN
KNIGHT = PieceType.KNIGHT
BISHOP = PieceType.BISHOP
ROOK = PieceType.ROOK
QUEEN = PieceType.QUEEN
KING = PieceType.KING



PIECE_TYPES = [piece_type for piece_type in PieceType]





class Piece:

    """
    A Piece represents a piece in Chess, and has both a Color and a PieceType.
    Pieces of the same Color and PieceType point to the same object in memory,
    and are immutable. 
    """

    __slots__ = ("__color", "__piece_type")


    def __init__(self, color : Color, piece_type : PieceType):
        self.__color = color
        self.__piece_type = piece_type
    
    def __new__(cls, color : Color, piece_type : PieceType):
        if not hasattr(cls, "instances"):
            Piece.instances : dict[tuple[Color, PieceType], "Piece"]= {}
            for pt in PieceType:
                for c in COLORS:
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
        """
        Gets the Piece corresponding to the given character.
        The character corresponds to the first letter of the name 
        of the PieceType. White pieces correspond to capital letters,
        and Black pieces to lowercase letters. '-' corresponds to None,
        which is used to represent an empty Square.
        """

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
        return int(self.__color) + (2 * self.__piece_type.value)

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

    """
    A Move represents the movement of a Piece, or Pieces in the case of Castling,
    a player may enact during their turn.
    """

    __slots__ = ("__struct")

    def __init__(self, origin : Square, 
                       destination : Square, 
                       promote_to : Optional[PieceType] = None):
        """
        Constructs a move from the given origin and destination Squares.
        An error is raised if no chess Piece could legally enact the described move
        in any position.
        """
        pt = _backend.EMPTY_PIECE_TYPE if promote_to == None else promote_to.value
        struct = _backend.construct_movePY(origin.value, destination.value, pt)

        if type(struct) == str:
            raise ValueError(struct.format_map({"origin" : origin, 
                                                "destination" : destination,
                                                "promote_to" : str(promote_to).title()}))
        self.__struct = struct
    
    @staticmethod
    def __inst(__struct : _backend.MOVE) -> "Move":
        move = object.__new__(Move)
        move.__struct = __struct
        return move

    @staticmethod
    def from_uci(uci : str) -> "Move":
        """
        Constructs a Move from Long Algebraic Notation, which is 
        used by the UCI protocol.
        """
        return Move.__inst(_backend.init_move_from_uciPY(uci))

    @staticmethod
    def from_san(san : str, board : "Board") -> "Move":
        """
        Construct a Move using Standard Algebraic Notation. This method requires 
        a Board for context, in order to determine the origin of the Move.
        """
        return Move.__inst(_backend.san_to_movePY(board._Board__pointer, san))

    def to_san(self, board : "Board") -> str:
        """
        Serialized a Move into Standard Algebraic Notation, using the given
        Board as context.
        """
        return _backend.move_to_sanPY(board._Board__pointer, self.__struct) 

    @property
    def origin(self) -> Square:
        """
        Gets the origin Square of this Move.
        """
        return Square(_backend.get_origin(self.__struct))

    @property
    def destination(self) -> Square:
        """
        Gets the destination Square of this Move.
        """
        return Square(_backend.get_destination(self.__struct))

    @property
    def promotes_to(self) -> Optional[Piece]:
        """
        For promoting moves, returns the Piece that a Pawn would promote to.
        Returns None for non-promotions.
        """
        return PIECES[_backend.promotes_to(self.__struct)]

    def is_promption(self) -> bool:
        """
        Returns `True` if this Move is a promotion.
        """
        return bool(_backend.is_promotion(self.__struct))

    def status_from(self, board : "Board") -> "BoardStatus":
        """
        Returns the BoardStatus of the Board produced from applying this Move
        to the given Board.
        """


    def __str__(self) -> str:
        return _backend.write_uciPY(self.__struct)

    def __hash__(self) -> int:
        return int(_backend.hash_move(self.__struct))

    def __eq__(self, other : Any) -> bool:
        try:
            return bool(_backend.moves_equal(self.__struct, other.__struct))
        except:
            return False

    def __repr__(self) -> str:
        return f"Move({str(self)})"


class Bitboard:

    """
    A Bitboard is a representation of a set of Squares in the form of a 
    64-bit integer. 
    """

    __slots__ = ("__int",)

    def __init__(self, value : int):
        self.__int = value

    @staticmethod
    def from_squares(squares : Collection[Square]) -> "Bitboard":
        squares_array = (_backend.SQUARE * 64)(*[square.value for square in squares])
        return Bitboard(int(_backend.from_squares(squares_array, len(squares))))

    
    @staticmethod
    def piece_attacking(piece : Piece, from_square : Square) -> "Bitboard":
        return Bitboard(int(_backend.piece_attacks(PIECE_INDEXES[piece], from_square.value)))
    

    def left(self) -> "Bitboard":
        return Bitboard(_backend.left_bb(self.__int))

    def right(self) -> "Bitboard":
        return Bitboard(_backend.right_bb(self.__int))

    def above(self) -> "Bitboard":
        return Bitboard(_backend.above_bb(self.__int))

    def below(self) -> "Bitboard":
        return Bitboard(_backend.below_bb(self.__int))

    def __str__(self):
        return _backend.write_bitboardPY(self.__int)

    def __contains__(self, square : Square):
        return _backend.square_in_bitboard(self.__int, square.value); 

    def __or__(self, other : "Bitboard") -> "Bitboard":
        return Bitboard(self.__int | other.__int)

    def __and__(self, other : "Bitboard") -> "Bitboard":
        return Bitboard(self.__int & other.__int)

    def __xor__(self, other : "Bitboard") -> "Bitboard":
        return Bitboard(self.__int ^ other.__int)

    def __invert__(self) -> "Bitboard":
        return Bitboard(~self.__int)

    def __eq__(self, other : Any) -> bool:
        try:
            return self.__int == other.__int
        except:
            return False

    def __repr__(self) -> str:
        return f"Bitboard({hex(self.__int)})"

    def __hash__(self) -> int:
        return self.__int

FILE_A = Bitboard.from_squares([A8, A7, A6, A5, A4, A3, A2, A1])
FILE_B = Bitboard.from_squares([B8, B7, B6, B5, B4, B3, B2, B1])
FILE_C = Bitboard.from_squares([C8, C7, C6, C5, C4, C3, C2, C1])
FILE_D = Bitboard.from_squares([D8, D7, D6, D5, D4, D3, D2, D1])
FILE_E = Bitboard.from_squares([E8, E7, E6, E5, E4, E3, E2, E1])
FILF_F = Bitboard.from_squares([F8, F7, F6, F5, F4, F3, F2, F1])
FILE_G = Bitboard.from_squares([G8, G7, G6, G5, G4, G3, G2, G1])
FILE_H = Bitboard.from_squares([H8, H7, H6, H5, H4, H3, H2, H1])

RANK_1 = Bitboard.from_squares([A1, B1, C1, D1, E1, F1, G1, H1])
RANK_2 = Bitboard.from_squares([A2, B2, C2, D2, E2, F2, G2, H2])
RANK_3 = Bitboard.from_squares([A3, B3, C3, D3, E3, F3, G3, H3])
RANK_4 = Bitboard.from_squares([A4, B4, C4, D4, E4, F4, G4, H4])
RANK_5 = Bitboard.from_squares([A5, B5, C5, D5, E5, F5, G5, H5])
RANK_6 = Bitboard.from_squares([A6, B6, C6, D6, E6, F6, G6, H6])
RANK_7 = Bitboard.from_squares([A7, B7, C7, D7, E7, F7, G7, H7])
RANK_8 = Bitboard.from_squares([A8, B8, C8, D8, E8, F8, G8, H8])

   


class Board:

    """
    A Board represents the state associated with a Chess position, including 
    the configuration of Pieces, which player's turn it is, the existance and value
    of the en-passant square, castling rights, as well as the halfmove clock and 
    fullmove number. 
    """

    __slots__ = ("__pointer", "__undoable_stack", "__piece_array", "__move_stack", "__status")

    def __init__(self):
        """
        Initializes a Board representing the standard starting position of a game.
        """
        self.__pointer = _backend.init_starting_boardPY() 
        self.__undoable_stack = []
        self.__move_stack = []
        self.__create_piece_array()
        self.__status = None
    
    @staticmethod
    def starting() -> "Board":
        return Board()

    @staticmethod
    def __inst(__pointer : _backend.POINTER(_backend.BOARD),
                 __undoable_stack : list[_backend.UNDOABLE_MOVE],
                __move_stack : list[Move],
               __piece_array : (_backend.PIECE_INDEX * 64)):
        board = object.__new__(Board)
        board.__pointer = __pointer
        board.__undoable_stack = __undoable_stack
        board.__move_stack = __move_stack
        board.__piece_array = __piece_array
        board.__status = None
        return board        


    def __create_piece_array(self):

        self.__piece_array = bytes(64)
        _backend.fill_piece_index_array(self.__pointer, self.__piece_array)


    def __clear_status(self):
        self.__status = None
    
    def __clear_piece_array(self):
        self.__piece_array = None
        
    def __verify_piece_array(self):
        if self.__piece_array == None:
            self.__create_piece_array()

    @staticmethod
    def from_fen(fen : str) -> "Board":
        """
        Constructs a Board using Forsyth-Edwards Notation. 
        """
        pointer, piece_array = _backend.init_board_from_fenPY(fen)
        return Board.__inst(pointer, [], [], piece_array)

        

    @staticmethod
    def empty() -> "Board":
        """
        Constructs a completely empty Board with no Pieces.
        """
        pointer = _backend.init_empty_boardPY()
        return Board.__inst(pointer, [], [], None)

    @staticmethod
    def random() -> "Board":
       """
       Constructs a Board from applying a random number of randomly selected
       moves to the starting position.
       """
       board = Board()
       _backend.randomize_board(board.__pointer)
       board.__piece_array = None
       return board


    def copy(self) -> "Board":
        """
        Creates a copy of this Board, including the history of Moves
        that have been played.
        """
        pointer = _backend.alloc_boardPY()
        _backend.copy_into(pointer, self.__pointer)
        cpy = Board.__inst(pointer, self.__undoable_stack.copy(), 
                           self.__move_stack.copy(), self.__piece_array)
        return cpy

    def validate(self):
        """
        Raises an Exception if this Board is invalid. 
        """
        error = _backend.validate_board(self.__pointer)
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
        """
        Sets the en passant Square, checking if the given value is a valid Square
        """
        self.__clear_status()
        if square == None:
            _backend.clear_ep_square(self.__pointer)
        else:
            if type(square) == Square:
                error = _backend.set_ep_square_checked(self.__pointer, square.value)
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
        self.__clear_status()
        if type(color) == Color:
            self.__pointer.contents.turn = int(color)
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
        self.__clear_status()
        if value < 0:
            raise ValueError(f"Cannot set halfmove clock to a negative value, but got {value}")
        elif value > 65535:
            raise ValueError(f"Cannot set halfmove clock to a value greater than 65535, but got {value}")
        else:
            self.__pointer.contents.halfmove_clock = _backend.TURN_CLOCK(value) 

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
            self.__pointer.contents.fullmove_number = _backend.TURN_CLOCK(value) 

    def fen(self) -> str:
        return _backend.make_fenPY(self.__pointer)

    @property
    def status(self) -> "BoardStatus":
        if self.__status == None:
            ln = len(self.__undoable_stack)
            moves_array = (_backend.UNDOABLE_MOVE * ln)(*self.__undoable_stack)
            status = object.__new__(BoardStatus)
            status.value = _backend.get_outcome(self, moves_array, ln)
            self.__status = status
        return self.__status


    def legal_moves(self) -> list[Move]:
        """
        Produces a list of legal Moves that could be performed at the current position.
        """
        moves_buffer = (_backend.MOVE * 256)()
        length = _backend.generate_legal_moves(self.__pointer, moves_buffer)
        return self._make_move_objs(moves_buffer, length)

    def _make_move_objs(self, moves_buffer, length):
        return [Move._Move__inst(m) for m in moves_buffer[:length]]
                
    def apply(self, move : Move) -> None:
        """
        Applies the given Move to this Board, without checking for legality.
        """
        self.__clear_status()
        self.__clear_piece_array()
        self.__move_stack.append(move)
        self.__undoable_stack.append(_backend.apply_move(self.__pointer, 
                                                             move._Move__struct))
    def undo(self) -> Move:
        """
        Undoes and returns the last Move performed on this Board.
        """
        self.__clear_status()
        self.__clear_piece_array()
        undoable = self.__undoable_stack.pop()
        _backend.undo_move(self.__pointer, undoable)
        return self.__move_stack.pop()

    def get_piece_at(self, square : Square) -> Optional[Piece]:
        self.__verify_piece_array()
        return PIECES[self.__piece_array[square.value]]


    def _square_value(self, square):
        return square.value

    def _index_pieces(self, index):
        return PIECES[index]

    def set_piece_at(self, square : Square, piece : Optional[Piece]) -> None:
        """
        Sets the given Square on this Board to the specified Piece. If given
        None, sets the Square to be empty.
        """
        try:
            index = PIECE_INDEXES[piece]
        except:
            raise ValueError(f"Invalid piece: {piece}")
        _backend.set_piece_index(self.__pointer, self.__piece_array, square.value, index)
        self.__clear_status()

    def delete_piece_at(self, square : Square) -> None:
        """
        Deletes the Piece, if there is one, at the specified Square.
        """
        _backend.delete_piece_at(self.__pointer, self.__piece_array, square.value)
        
        self.__clear_status()
    
    def __eq__(self, other : Any):
        """
        Returns True if compared with another Board that has the same position, as
        well as identical state aspects including the en-passant square, castling rights,
        the halfmove timer, and the fullmove clock.
        """
        return bool(_backend.boards_equal(self.__pointer, other.__pointer))


    def _callback(self, func : Callable[[_backend.BOARD, 
                                _backend.POINTER(_backend.UNDOABLE_MOVE),
                                int], Any]):
        ln = len(self.__undoable_stack)
        moves_array = _backend.UNDOABLE_MOVE * ln
        moves_array = (moves_array)(*self.__undoable_stack)
        return func(self.__pointer, moves_array, ln)

 
    def __str__(self) -> str:
        return _backend.make_board_stringPY(self)
    
    def __hash__(self) -> int:
        return int(_backend.hash_board_wrapper(self.__pointer))

    def __contains__(self, piece : Optional[Piece]) -> bool:
        return bool(_backend.contains_piece(self, PIECE_INDEXES[piece]))
    
    @property
    def _as_parameter_(self):
        return self.__pointer
   
class BoardStatus:

    """
    A BoardStatus is used to hold whether a Board on is from an
    on-going game, or is a game over. If the Board is in a game over state,
    a BoardStatus can be used to determine the reason.
    """

    NO_STATUS = 0
    CHECK = 1
    MATE = 2
    INSUFFICIENT_MATERIAL = 4
    FIFTY_MOVE_TIMEOUT = 8
    SEVENTY_FIVE_MOVE_TIMEOUT = 16
    THREEFOLD_REPETITION = 32
    FIVEFOLD_REPETITION = 64
    RESIGNATION = 128

    __slots__ = ["value"]

    @property    
    def ongoing(self) -> bool:
        """
        True if the Board is part of an ongoing Game.
        """
        return not self.gameover
    
    @property
    def gameover(self) -> bool:
        """
        True if the Board is the last position of a Game.
        """
        return self.claim_draw or self.checkmate or self.resignation

    @property
    def checkmate(self) -> bool:
        """
        True if the Board's position is checkmate. 
        """
        return self.mate and self.check

    @property
    def stalemate(self) -> bool:
        """
        True if the Board's position is stalemate.
        """
        return self.mate and not self.check

    @property
    def claim_draw(self) -> bool:
        """
        True if the Board's position is inherently a draw,
        or if either player can claim a draw from the Fifty Move rule 
        or by Threefold repetition.
        """
        return (self.forced_draw or 
                self.threefold_repetition or 
                self.fifty_move_timeout)

    @property
    def forced_draw(self) -> bool:
        """
        True if the Board's positition is inherently a draw.
        """
        return (self.stalemate or
                self.fivefold_repetition or 
                self.seventyfive_move_timeout or
                self.insufficient_material)

    @property
    def check(self) -> bool:
        """
        True if the Player to move is currently in check.
        """
        return bool(self.value & BoardStatus.CHECK)

    @property
    def mate(self) -> bool:
        """
        True if the Player to move has no legal moves,
        either from stalemate or checkmate.
        """
        return bool(self.value & BoardStatus.MATE)

    @property
    def threefold_repetition(self) -> bool:
        """
        True if the Board's position has been repeated three times.
        A Board's position being repeated not only depends on comparing
        the configuration of Pieces, but castling rights and the 
        en-passant square as well. This enables a player to claim a draw.
        """
        return bool(self.value & BoardStatus.THREEFOLD_REPETITION)

    @property
    def insufficient_material(self) -> bool:
        """
        True if either player has insufficient mating material,
        meaning that there is no sequence of Moves that could be taken
        to lead to checkmate.
        """
        return bool(self.value & BoardStatus.INSUFFICIENT_MATERIAL)

    @property
    def fifty_move_timeout(self):
        """
        True if it has been at least 50 halfmoves since the last
        capture or pawn advancement, enabling a player to claim a draw.
        """
        return bool(self.value & BoardStatus.FIFTY_MOVE_TIMEOUT)
    
    @property
    def fivefold_repetition(self):
        """
        True if the Board's position has been repeated five times.
        A Board's position being repeated not only depends on comparing
        the configuration of Pieces, but castling rights and the 
        en-passant square as well. This condition being True forces a draw.
        """
        return bool(self.value & BoardStatus.FIVEFOLD_REPETITION)

    @property
    def seventyfive_move_timeout(self):
        """
        True if it has been at least 75 halfmoves since the last
        capture or pawn advancement, forcing a draw.
        """
        return bool(self.value & BoardStatus.SEVENTY_FIVE_MOVE_TIMEOUT)
    
    @property
    def resignation(self):
        """
        True if the Board is the last position in a game due to a Player
        resigining. (Currently this is never True)
        """
        return bool(self.value & BoardStatus.RESIGNATION)

