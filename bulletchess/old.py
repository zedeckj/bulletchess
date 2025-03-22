from typing import Optional, NewType
import typing
import enum
import os
import sys
sys.path.append("./")
from ctypes import *
path = os.path.dirname(os.path.abspath(__file__))
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
    ]

class _PIECE(Structure):
    _fields_ = [
        ("color", Color),
        ("type", PieceType)
    ]



class Piece(Structure):

    _fields_ = [
        ("color", Color),
        ("type", PieceType),
    ]

    def __init__(self, color : Color, piece_type : PieceType):
        """
        Create a Piece of the given PieceType and Color
        """
        if piece_type != 0:
            if not (color == WHITE or color == BLACK) or not (piece_type == PAWN or piece_type == BISHOP or piece_type == KNIGHT or piece_type == ROOK or piece_type == QUEEN or piece_type == KING):
                raise ValueError(f"Invalid piece Piece({color},{piece_type})")
        self.type = piece_type
        self.color = color


    @staticmethod 
    def new(color : Color, piece_type : PieceType) -> "Piece":
        return Piece(color, piece_type)

    @staticmethod
    def from_symbol(symbol : str) -> Optional["Piece"]:
        try:
            return _from_c_piece(_piece_from_string(symbol.encode("utf-8")))
        except:
            raise ValueError(f"Invalid piece symbol: {symbol}")

    def get_type(self) -> PieceType:
        return self.type

    def get_color(self) -> Color:
        return self.color    
    
    def __str__(self):
        return _piece_symbol(self).decode()
    
    def __repr__(self):
        return f"Piece({str(self)})"

    def __eq__(self, other):
        if type(other) == type(self):
            return bool(_pieces_equal(self, other))
        else:
            return False

    def __hash__(self) -> int:
        return int(_hash_piece(self))

def Pawn(color : Color) -> Piece:
    return Piece.new(color, PAWN)

def Knight(color : Color) -> Piece:
    return Piece.new(color, KNIGHT)

def Bishop(color : Color) -> Piece:
    return Piece.new(color, BISHOP)

def Rook(color : Color) -> Piece:
    return Piece.new(color, ROOK)

def Queen(color : Color) -> Piece:
    return Piece.new(color, QUEEN)

def King(color : Color) -> Piece:
    return Piece.new(color, KING)



def _from_c_piece(piece : Piece) -> Optional[Piece]:
    """
    Bridge for bringing Pieces returned from C into python
    """
    if piece.type == _EMPTY_PIECE:
        return None
    elif piece.type == _ERROR_PIECE:
        raise Exception("Invalid Piece")
    else:
        return piece

def _to_c_piece(piece : Optional[Piece]) -> Piece:
    if piece == None:
        return Piece(_EMPTY_PIECE, _EMPTY_PIECE)
    return piece




class Move(Structure):
    "Represents a chess move from an origin to a destination, as well as whether the move is a pawn promotion. Moves can be created `Move.from_uci`, which takes a move specified in long algebraic notation."

    _anonymous_ = ("u",)
    _fields_ = [
        ("u", _MOVE_UNION),
        ("type", c_uint8),
    ]

    @staticmethod
    def from_uci(uci_str : str) -> "Move":
        move = _parse_uci(uci_str.encode("utf-8"))
        if int(move.type) == 1:
            raise ValueError(f"Illegal move: {uci_str}")
        return move

    def is_promotion(self) -> bool:
        return bool(_is_promotion(self))

    def promotion_to(self) -> Optional[Piece]:
        return _from_c_piece(_promotes_to(self))

    def origin(self) -> Square:
        return _get_origin(self)

    def destination(self) -> Square:
        return _get_destination(self)

    def __str__(self):
        uci = create_string_buffer(6)
        _write_uci(self, uci)
        return uci.raw.rstrip(b'\x00').decode()
    
    def __repr__(self):
        return f"Move({str(self)})"
    
    def __hash__(self) -> int:
        return int(_hash_move(self))

    def __eq__(self, other):
        if type(self) == type(other):
            return bool(_moves_equal(self, other))
        return False


class UndoableMove(Structure):
    _fields_ = [
        ("move", Move),
        ("captured_piece", Piece),
        ("old_castling_rights", CastlingRights),
        ("was_castling", CastlingRights),
        ("old_en_passant", _OPTIONAL_SQUARE),
        ("old_halfmove", TurnClock)
    ]

class _BOARD(Structure):
    _fields_ = [
        ("position", POINTER(_POSITION)),
        ("turn", Color),
        ("castling_rights", CastlingRights),
        ("en_passant_square", _OPTIONAL_SQUARE),
        ("halfmove_clock", TurnClock),
        ("fullmove_number", TurnClock),
    ]
   

    @staticmethod
    def empty() -> "_BOARD":
        """
        Creats a new Board for an empty position.
        """
        pos_pointer = pointer(_POSITION(0, 0, 0, 0, 0, 0, 0, 0))
        castling_rights = NO_CASTLING_RIGHTS
        turn = WHITE
        en_passant = _OPTIONAL_SQUARE(0, 0)
        halfmove = TurnClock(0)
        fullmove = TurnClock(0)
        full_board = _BOARD(
            pos_pointer,
            turn,
            castling_rights,
            en_passant,
            halfmove,
            fullmove,
        )
        return full_board

class PiecePatternUnion(Union):

    _fields_ = [
        ("count", c_uint8),
        ("bitboard", Bitboard)
    ]

class PiecePattern(Structure):

    _anonymous_ = ("u",)

    _fields_ = [
        ("piece", Piece),
        ("type", c_uint8),
        ("u", PiecePatternUnion)
    ]

class Pattern:

    COUNT_TYPE = c_uint8(1)
    BITBOARD_TYPE = c_uint8(2)

    """
    Represents some configuration details about Piece locations in Boards. Can be used to efficiently query if a Board has some configuartion of Pieces.
    """

    __slots__ = ["__piece_patterns", "__current_buffer"]

    def __init__(self):
        self.__piece_patterns = []
        self.__current_buffer = None

    def __update_buffer(self):
        self.__current_buffer = (PiecePattern * len(self.__piece_patterns))(*self.__piece_patterns)

    def piece_count(self, piece : Optional[Piece], count : int) -> "Pattern":
        """
        Adds a requirement to this Pattern for a specified count of the given Piece.
        """
        if count < 0 or count > 64:
            raise Exception("A specified Piece count for a pattern must be >= 0 and <= 64")
        piece_pattern = PiecePattern(
            _to_c_piece(piece), Pattern.COUNT_TYPE, PiecePatternUnion(count = c_uint8(count))
        )
        self.__piece_patterns.append(piece_pattern)
        self.__update_buffer()
        return self

    def from_board(self, 
                    pieces : typing.Union[PieceType, 
                                          Optional[Piece], 
                                          list[Optional[typing.Union[Piece, PieceType]]]], 
                   board : "Board") -> "Pattern":
        if type(pieces) != list:
            pieces = [pieces]
        new_pieces = []
        for piece in pieces:
            if type(piece) != Piece:
                new_pieces.append(Piece(WHITE, piece))
                new_pieces.append(Piece(BLACK, piece))
            else:
                new_pieces.append(piece)
        pieces = new_pieces
        for piece in pieces:
            pattern = PiecePattern(
                _to_c_piece(piece), 
                Pattern.BITBOARD_TYPE, 
                PiecePatternUnion(bitboard = board.piece_bitboard(piece))            
            )
            self.__piece_patterns.append(pattern)
        self.__update_buffer()
        return self

class Dummy:
    def __init__(self, x):
        self.x = x

class Board:

    """A ```bulletchess.Board``` is a wrapper around a C ```struct``` which represents the state of a Chess board.
This class directly encodes the configuration of pieces, whose turn it is, castling rights, the existance of the en passant square, as well as the halfmove clock and fullmove number."""
   
    __slots__ = ['__board', '__move_stack']

    def __init__(self, __board : _BOARD):
        """
        """
        self.__board = pointer(__board)
        self.__move_stack = []

  
    @staticmethod
    def from_fen(fen : str) -> "Board":
        """
        Creates a new Board using the given FEN description. 
        """
        if fen == "":
            raise ValueError(f"Invalid FEN '': Empty FEN")
        board = Board(_BOARD.empty())
        Board
        buffer = create_string_buffer(init = fen.encode("utf-8"))
        error = _parse_fen(buffer, board.__board)
        if error == None:
            return board
        else:
            error = bytes(error).decode()
            raise ValueError(f"Invalid FEN '{fen}': {error}")

    @staticmethod
    def empty() -> "Board":
        """
        Creates a new Board with no Pieces.
        """
        return Board(_BOARD.empty())

    
    @staticmethod
    def starting() -> "Board":
        """
        Creates a new Board for the starting position.
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
        castling_rights = STARTING_CASTLING_RIGHTS
        en_passant = _OPTIONAL_SQUARE(0, 0)
        turn = WHITE
        halfmove = TurnClock(0)
        fullmove = TurnClock(1)
        full_board = _BOARD(
            pos_pointer,
            turn,
            castling_rights,
            en_passant,
            halfmove,
            fullmove,
        )
        return Board(full_board)
    
    @staticmethod
    def random() -> "Board":
        """
        Generates a random Board by applying a random number of randomly selected moves to the starting position.
        """
        board = Board.starting()
        _randomize_board(board.__board)
        return board


    def validate(self):
        """
        Raises an Exception if this Board is invalid 
        """
        error = _validate_board(self.__board)
        if error != None:
            raise ValueError(error.decode("utf-8"))
 
    def legal_moves(self) -> list[Move]:
        """
        Creates a list of legal Moves that can be applied to this Board.
        """
        moves_buffer = (Move * 256)()
        length = _generate_legal_moves(self.__board, moves_buffer)
        dummy = [Dummy(move) for move in moves_buffer[:length]]
        return moves_buffer[:length]
    
    def count_moves(self) -> int:
        """
        Counts the number of legal moves for this Board. This is faster than calling
        `legal_moves()` and checking the length
        """
        return int(_count_moves(self.__board))


    def apply(self, move : Move) -> None:
        """
        Mutates this board by applying the given move
        """
        self.__move_stack.append(_apply_move(self.__board, move))

    def undo(self) -> Move:
        undoable = self.__move_stack.pop()
        return _undo_move(self.__board, undoable)
    
    def in_check(self) -> bool:
        """
        Returns `True` if the side to move is in check.
        """
        return bool(_in_check(self.__board))


    def is_checkmate(self) -> bool:
        """
        Returns `True` if the side to move is in checkmate.
        """
        return bool(_is_checkmate(self.__board))

    def is_stalemate(self) -> bool:
        """
        Returns `True` if the Board is in checkmate. 
        """
        return bool(_is_stalemate(self.__board))

    def is_draw(self) -> bool:
        """
        Returns `True` if the Board's position is a draw, whether by stalemate,
        the halfmove clock being 50 or greater (for a position that is not checkmate), 
        or by threefold repetition
        """
        l = len(self.__move_stack)
        moves_array = (UndoableMove * l)(*self.__move_stack)
        return bool(_is_draw(self.__board, moves_array, l))

    def get_piece_at(self, square : Square) -> Optional[Piece]:
        """
        Gets the Piece at the specified Square
        """
        return _from_c_piece(_get_piece_at(self.__board.contents.position, square))

    def remove_piece_at(self, square : Square) -> None:
        """
        Removes the Piece specified at the given square
        """
        _delete_piece_at(self.__board.contents.position, square)
    
    def set_piece_at(self, square : Square, piece : Optional[Piece]) -> None:
        """
        Sets the given square to have the given piece
        """
        _set_piece_at(self.__board.contents.position, square, _to_c_piece(piece))

    @property 
    def ep_square(self) -> Optional[Square]:
        """
        The current en passant Square, or None if it does not exist.
        """
        optional_square = self.__board.contents.en_passant_square
        if bool(optional_square.exists):
            return optional_square.square
        return None

    @ep_square.setter
    def ep_square(self, square : Optional[Square]):
        if square == None:
            _clear_ep_square(self.__board)
            
        else:
            error = _set_ep_square_checked(self.__board, square)
            if error != None:
                raise ValueError(error.decode("utf-8").format(ep = square_to_str(square)))

    @property
    def turn(self) -> Color:
        """
        The Color of the player whose turn it is.
        """
        return self.__board.contents.turn

    @turn.setter
    def turn(self, value : Color):
        if value == WHITE or value == BLACK:
            self.__board.contents.turn = value
        else:
            raise ValueError(f"Cannot set turn to a value that is not WHITE or BLACK, but got {value}")

    @property
    def halfmove_clock(self) -> int:
        """
        The number of ply that have passed since a pawn advancement or a capture.
        """
        return int(self.__board.contents.halfmove_clock)


    @halfmove_clock.setter
    def halfmove_clock(self, value : int):
        if value < 0:
            raise ValueError(f"Cannot set halfmove clock to a negative value, but got {value}")
        elif value > 65535:
            raise ValueError(f"Cannot set halfmove clock to a value greater than 65535, but got {value}")
        else:
            self.__board.contents.halfmove_clock = TurnClock(value) 



    @property
    def fullmove_number(self) -> int:
        """
        The turn number of the current Board. After both players have made a move, the fullmove
        number increments by 1.
        """
        return int(self.__board.contents.fullmove_number)


    @fullmove_number.setter
    def fullmove_number(self, value : int):
        if value < 0:
            raise ValueError(f"Cannot set fullmove number to a negative value, but got {value}")
        elif value > 65535:
            raise ValueError(f"Cannot set fullmove number to a value greater than 65535, but got {value}")
        else:
            self.__board.contents.fullmove_number = TurnClock(value) 




    def __contains__(self, obj : typing.Union[Optional[Piece], Pattern]):
        """
        If given a Piece, returns True if it exists in this Board's position. 
        If given a Pattern, returns True if the Pattern matches this Board's position.
        """
        if type(obj) == Piece: 
            return _contains_piece(self.__board, _to_c_piece(piece))
        else:
            return bool(_board_has_patterns(self.__board, 
                                            obj._Pattern__current_buffer, 
                                            len(obj._Pattern__piece_patterns)))

    def __eq__(self, other):
        """
        Returns True if compared with another Board that has the same position, as
        well as identical state aspects including the en-passant square, castling rights,
        the halfmove timer, and the fullmove clock.
        """
        if type(other) is type(self):
            return bool(_boards_equal(self.__board, other.__board))
        return False
        
    def fen(self) -> str:
        """
        Returns a string of the FEN description of this Board.
        """
        fen = create_string_buffer(300)
        _make_fen(self.__board, fen)
        return fen.raw.rstrip(b'\x00 ').decode()
    
    def __str__(self) -> str:
        """
        Creates a visual representation of this Board in the form of a string.
        """
        board = create_string_buffer(300)
        _make_board_string(self.__board, board)
        return board.raw.rstrip(b'\x00 ').decode()
    

    def __repr__(self):
        return f"Board({self.fen()})\n"
        
    def __hash__(self) -> int:
        """
        Returns a 64-bit integer hash of this Board using randomized Zobrist keys.
        """
        return int(_hash_board(self.__board, ZORBIST_TABLE))

    def piece_bitboard(self, piece : Optional[Piece]) -> Bitboard:
        """
        Returns a Bitboard representing the locations of the specified Piece, or 
        the empty squares if given None.
        """
        return _get_piece_bb(self.__board, _to_c_piece(piece))

    def copy(self) -> "Board":
        """
        Returns a copy of this Board.
        """
        copy = Board(_BOARD.empty())
        _copy_into(copy.__board, self.__board)
        copy.__move_stack = self.__move_stack.copy()
        return copy
    
    def material(self, knight_value : int = 300, bishop_value : int = 300, rook_value : int = 500, queen_value : int = 900) -> int:
        """
        Find the material value of the Pieces in this Board, where White Pieces are counted positively and Black Pieces are counted negatively. 
        The default arguments are the typical material evaluations described in centipawns.
        """
        return int(_material(self.__board.position, c_int(knight_value), c_int(bishop_value), c_int(rook_value), c_int(queen_value)))


    def debug_position(self, legal_moves : list[Move]):
        import chess
        fen = self.fen()
        chess_board = chess.Board(fen)
        chess_fen = chess_board.fen(en_passant = "fen")
        if fen != chess_fen:
            raise Exception(fen, chess_fen)
        uci_moves = sorted([str(move) for move in legal_moves])
        chess_moves = list(chess_board.legal_moves)
        uci_chess = sorted([str(move) for move in chess_moves])
        if uci_chess != uci_moves:
            print(self)
            _print_bitboard(_make_attack_mask(self.__board, BLACK if self.turn == WHITE else WHITE))
            raise Exception(fen +"\n" + str(uci_chess) + "\n" +str(uci_moves))
    
    def debug_perft(self, depth : int, move_stack : list[Move] = []) -> int:
        import chess
        if depth == 0:
            return 1
        elif depth == 1:
            legal_moves = self.legal_moves()
            self.debug_position(legal_moves)
            return len(legal_moves)
        else:
            moves = self.legal_moves()
            self.debug_position(moves)
            if len(moves) == 0:
                return 1
            nodes = 0
            chess_board = chess.Board(fen = self.fen());
            for move in moves:
                old_fen = self.fen()
                self.apply(move)
                chess_board.push(chess.Move.from_uci(str(move)))
                fen = self.fen()
                chess_fen = chess_board.fen(en_passant = "fen")
                if fen != chess_fen:
                    raise Exception(fen, chess_fen, move_stack + [move], old_fen)
                nodes += self.debug_perft(depth - 1, move_stack + [move])
                self.undo()
                chess_board.pop()
            return nodes

    def get_squares_with(self, piece : Optional[Piece]) -> list[Square]:
        """
        Returns a list of Squares where the given Piece can be found on this Board.
        Passing `None` will return a list of squares where there is no Piece.
        """
        buffer = (Square * 64)()
        length = _squares_with_piece(self.__board, _to_c_piece(piece), buffer)
        return buffer[:length]

    def perft(self, depth : int, debug: bool = False) -> int:
        """
        Walks through the move generation tree for this Board to the specified depth, and
        counts the number of leaf node Boards created. 

        For a more detailed explanation, see: 
        https://www.chessprogramming.org/Perft
        """
        if depth < 0:
            raise Exception("Cannot perform perft with a negative depth")
        if debug:
            print("Running on debug mode...")
            return self.debug_perft(depth)
        return _perft(self.__board, c_uint8(depth))


    def pseudo_perft(self, depth : int, debug: bool = False) -> int:
        return _pseudo_perft(self.__board, c_uint8(depth))


    

def square_to_str(square : Square) -> str:
    if square > H8:
        return f"{square}"
    else:
        rank = chr(square // 8 + ord('1'))
        file = chr(square % 8 + ord('a'))
        return f"{file}{rank}"


# C LIBRARY IMPORTS

_piece_from_string = clib.piece_from_string
_piece_from_string.argtypes = [c_char_p]
_piece_from_string.restype = Piece


# _material = clib.material
# _material.restype = c_int
# _material.argtypes = [POINTER(_POSITION), c_int, c_int, c_int, c_int]

_get_piece_at = clib.get_piece_at
_get_piece_at.restype = Piece
_get_piece_at.argtypes = [POINTER(_POSITION), Square]


_set_piece_at = clib.set_piece_at
_set_piece_at.argtypes = [POINTER(_POSITION), Square, Piece]

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

_get_empty_value = clib.get_empty_val
_get_empty_value.restype = PieceType

_get_error_value = clib.get_error_val
_get_error_value.restype = PieceType

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
_has_kingside_castling_rights.argtypes = [POINTER(_BOARD), Color]

_has_queenside_castling_rights = clib.has_queenside_castling_rights
_has_queenside_castling_rights.restype = c_bool
_has_queenside_castling_rights.argtypes = [POINTER(_BOARD), Color]

_has_castling_rights = clib.has_castling_rights
_has_castling_rights.restype = c_bool 
_has_castling_rights.argtypes = [POINTER(_BOARD), Color]


_clear_castling_rights = clib.clear_castling_rights
_clear_castling_rights.argtypes = [POINTER(_BOARD), Color]

_set_full_castling_rights = clib.set_full_castling_rights
_set_full_castling_rights.argtypes = [POINTER(_BOARD)]

_update_castling_rights = clib.update_castling_rights
_update_castling_rights.argtypes = [POINTER(_BOARD), Color]

_update_all_castling_rights = clib.update_all_castling_rights
_update_all_castling_rights.argtypes = [POINTER(_BOARD)]

_contains_piece = clib.contains_piece
_contains_piece.argtypes = [POINTER(_POSITION), Piece]
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
_add_castling_rights.argtypes = [POINTER(_BOARD), c_bool, Color]

_clear_ep_square = clib.clear_ep_square
_clear_ep_square.argtypes = [POINTER(_BOARD)]

_set_ep_square_checked = clib.set_ep_square_checked
_set_ep_square_checked.argtypes = [POINTER(_BOARD), Square]
_set_ep_square_checked.restype = c_char_p

_make_fen = clib.make_fen
_make_fen.argtypes = [POINTER(_BOARD), c_char_p]

_split_fen = clib.split_fen
_split_fen.argtypes = [c_char_p]
_split_fen.restype = POINTER(_SPLIT_FEN)

_parse_fen = clib.parse_fen
_parse_fen.argtypes = [c_char_p, POINTER(_BOARD)]
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

_apply_move = clib.apply_move
_apply_move.argtypes = [POINTER(_BOARD), Move]
_apply_move.restype = UndoableMove

_undo_move = clib.undo_move
_undo_move.argtypes = [POINTER(_BOARD), UndoableMove]
_undo_move.restype = Move

# _generate_pseudo_legal_moves = clib.generate_pseudo_legal_moves
# _generate_pseudo_legal_moves.argtypes = [POINTER(_BOARD), Color, POINTER(Move)]
# _generate_pseudo_legal_moves.restype = c_uint8

_generate_legal_moves = clib.generate_legal_moves
_generate_legal_moves.argtypes = [POINTER(_BOARD), POINTER(Move)]
_generate_legal_moves.restype = c_uint8

_make_board_string = clib.make_board_string
_make_board_string.argtypes = [POINTER(_BOARD), c_char_p]

_make_attack_mask = clib.make_attack_mask
_make_attack_mask.argtypes = [POINTER(_BOARD), Color]
_make_attack_mask.restype = Bitboard

_in_check = clib.in_check
_in_check.argtypes = [POINTER(_BOARD)]
_in_check.restype = c_bool

_copy_into = clib.copy_into
_copy_into.argtypes = [POINTER(_BOARD), POINTER(_BOARD)]

_debug_print_board = clib.debug_print_board
_debug_print_board.argtypes = [POINTER(_BOARD)]

_print_bitboard = clib.print_bitboard
_print_bitboard.argtypes = [Bitboard]

_perft = clib.perft
_perft.argtypes = [POINTER(_BOARD), c_uint8]
_perft.restype = c_uint64


_pseudo_perft = clib.pseudo_perft
_pseudo_perft.argtypes = [POINTER(_BOARD), c_uint8]
_pseudo_perft.restype = c_uint64


_get_origin = clib.get_origin
_get_origin.argtypes = [Move]
_get_origin.restype = Square

_get_destination = clib.get_destination
_get_destination.argtypes = [Move]
_get_destination.restype = Square

_is_promotion = clib.is_promotion
_is_promotion.argtypes = [Move]
_is_promotion.restype = c_bool

_promotes_to = clib.promotes_to
_promotes_to.argtypes = [Move]
_promotes_to.restype = Piece

_hash_move = clib.hash_move
_hash_move.argtypes = [Move]
_hash_move.restype = c_uint64

_moves_equal = clib.moves_equal
_moves_equal.argtypes = [Move, Move]
_moves_equal.restype = c_bool

_validate_board = clib.validate_board
_validate_board.argtypes = [POINTER(_BOARD)]
_validate_board.restype = c_char_p


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
_get_piece_bb.argtypes = [POINTER(_BOARD), Piece]
_get_piece_bb.restype = Bitboard

_squares_with_piece = clib.squares_with_piece
_squares_with_piece.argtypes = [POINTER(_BOARD), Piece, POINTER(Square)]
_squares_with_piece.restype = c_uint8

_board_has_patterns = clib.board_has_patterns
_board_has_patterns.argtypes = [POINTER(_BOARD), POINTER(PiecePattern), c_uint64]
_board_has_patterns.restype = c_bool

_is_draw = clib.is_draw
_is_draw.argtypes = [POINTER(_BOARD), POINTER(UndoableMove), c_uint16]
_is_draw.restype = c_bool

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

_EMPTY_PIECE : PieceType = _get_empty_value()
_ERROR_PIECE : PieceType = _get_error_value()

_ERR_MOVE_VAL = c_uint8(1)

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

STARTING_CASTLING_RIGHTS = CastlingRights(0xF)
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


