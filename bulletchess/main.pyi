from typing import Optional, Any, Collection, Iterator


class Color:

    """
    Represents either White or Black, used to identity the two players 
    and their pieces.
    """

    @staticmethod
    def from_str(color : str) -> Color:
        """
        Gets the `Color` corresponding to the given `str`.
        This function is case insensitive. 
        
        Examples:
        ```
        Color.from_str("White") == WHITE
        Color.from_str("BLACK") == BLACK
        ```

        :raises: :exc:`ValueError` if the string is not some case variation of `"WHITE"` or `"BLACK"`.
        """
        ...

    @property
    def opposite(self) -> Color: 
        """
        Gets the opposite `Color` to this one. 
        """
        ...

    def __eq__(self, other : Any) -> bool:
        """
        Evalutes to `True` if compared with the same `Color`
        """
        ...

    def __hash__(self) -> int:
        ...

    def __str__(self) -> str:
        """
        Serializes a `Color` to a string of its name in title case.

        Examples:
        ```
        str(WHITE) == "White"
        str(BLACK) == "Black"
        ```
        """
        ...

    def __invert__(self) -> Color:
        """
        Short-hand for `Color.opposite`, gets the opposite `Color` to this one. 
        """
        ...

    def __repr__(self) -> str:
        ...
    



WHITE : Color
BLACK : Color

class PieceType:

    """
    Represents one of the 6 types of pieces in chess, either a Pawn, Knight, Bishop, Rook, Queen, or King.
    """


    @staticmethod
    def from_str(piece_type : str) -> PieceType:
        """
        Gets the `PieceType` corresponding to the given `str` while being case insensitive.  
        
        Examples:
        ```
        PieceType.from_str("pawn") == PAWN
        PieceType.from_str("KNIGHT") == KNIGHT
        PieceType.from_str("Bishop") == BISHOP
        PieceType.from_str("rOoK") == ROOK
        PieceType.from_str("QUeEN") == QUEEN
        PieceType.from_str("king") == KING
        ```
        :raises: :exc: `ValueError` If the given string is not of the six PieceType names
        """
        ...

    def __eq__(self, other : Any) -> bool:
        """
        Evalutes to `True` if compared with the same PieceType 
        """
        ...

    def __hash__(self) -> int:
        ...

    def __str__(self) -> str:
        """
        Serializes a `PieceType` to a `str` of its name in title case.

        Examples:
        ```
        str(PAWN) == "Pawn"
        str(BISHOP) == "Bishop"
        ```
        """
        ...

    def __repr__(self) -> str:
        ...


PAWN : PieceType
KNIGHT : PieceType
BISHOP : PieceType
ROOK : PieceType
QUEEN : PieceType
KING : PieceType

PIECE_TYPES : list[PieceType] = [PAWN, KNIGHT, BISHOP, ROOK, QUEEN, KING]


class Piece:

    """
    Represents a piece with both a Color and a PieceType, such as a White Pawn, or a Black Rook. 
    """


    def __init__(self, color : Color, type : PieceType):
        """
        Initializes a Piece of the given Color and PieceType
        """
        ...

    @staticmethod
    def from_chr(piece_str : str) -> Piece:
        """
        Gets the Piece corresponding to the given ASCII character. Capital letters are used for White pieces, 
        and lower case for Black.

        Examples:
        ```
        Piece.from_chr("P") == Piece(WHITE, PAWN)
        Piece.from_chr("B") == Piece(WHITE, BISHOP)
        Piece.from_chr("R") == Piece(WHITE, ROOK)
        Piece.from_chr("n") == Piece(BLACK, KNIGHT)
        Piece.from_chr("q") == Piece(BLACK, QUEEN)
        Piece.from_chr("k") == Piece(BLACK, KING)
        Piece.from_chr(str(Piece(WHITE, KING))) == Piece(WHITE, KING)
        ```

        :raises: :exc: `ValueError` if given anything besides one of the 12 ASCII character's representing a Piece

        """
        ...

    @property
    def piece_type(self) -> PieceType:
        """
        Gets the `PieceType` of this `Piece`.
        """
        ...

    @property
    def color(self) -> Color:
        """
        Gets the `Color` of this `Piece`.
        """
        ...

    def unicode(self) -> str:
        """
        Gets a `str` of the Unicode character corresponding to this `Piece`.

        Examples:
        ```
        Piece(WHITE, PAWN).unicode() == "♙"
        Piece(BLACK, KNIGHT).unicode() == "♞"
        Piece(WHITE, BISHOP).unicode() == "♗"
        Piece(WHITE, ROOK).unicode() == "♖"
        Piece(BLACK, QUEEN).unicode() == "♛"
        Piece(BLACK, KING).unicode() == "♚"
        ```
        """
        ...

    def __eq__(self, other : Any):
        """
        Evaluates to `True` when compared with another `Piece` with the same `PieceType` and `Color`
        """
        ...

    def __hash__(self) -> int: 
        ...

    def __str__(self) -> str:
        """
        Serializes a `Piece` as a single ASCII character `str`. Uses uppercase for `Piece` that is `WHITE`, and lowercase for any `Piece` that is `BLACK`.

        Examples:
        ```
        str(Piece(WHITE, PAWN)) == "P"
        str(Piece(WHITE, BISHOP)) == "B"
        str(Piece(WHITE, ROOK)) == "R"
        str(Piece(BLACK, KNIGHT)) == "n"
        str(Piece(BLACK, QUEEN)) == "q"
        str(Piece(BLACK, KING)) == "k"
        ```
        """
        ...


class Square:

    """
    Represents one of the 64 squares on a chess board. 
    """

    @staticmethod
    def from_str(square_str : str) -> Square:
        """
        Gets the `Square` corresponding to the given `str` in a case insentive manner.

        Examples:
        ```
        Square.from_string("E1") == E1
        Square.from_string("a2") == A2
        Square.from_string(str(H8)) == H8

        ```

        :raises: :exc: `ValueError` if given a string which does not represent a Square
        """
        ...

    def bb(self) -> Bitboard: 
        """
        Creates a `Bitboard` containing only this `Square`. 

        Examples:
        ```
        A1.bb() == Bitboard([A1])
        H3.bb() == Bitboard([H3])
        ```
        """
        ...

    def adjacent(self) -> Bitboard: 
        """
        Creates a `Bitboard` of all adjacent `Squares` to this `Square`.

        Examples:
        ```
        A1.adjacent() == Bitboard([A2, B1, B2])
        E5.adjacent() == Bitboard([D4, D5, D6, E4, E6, F4, F5, F6])
        ```
        
        """



        ...

    def north(self, distance : int = 1) -> Optional[Square]: 
        """
        Gets the `Square` on the same file but with a rank that is the specified distance higher. 
        If this would be out of bounds of a `Board`, returns `None`.
        
        Examples:
        ```
        B6.north() == B7
        A1.north(distance = 3) == A4
        B8.north(distance = 2) == None

        ```

        """
        ...

    def south(self, distance : int = 1) -> Optional[Square]: 
        """
        Gets the `Square` on the same file but with a rank that is the specified distance lower. 
        If this would be out of bounds of a `Board`, returns `None`.
        
        Examples:
        ```
        B6.south() == B5
        A1.south(distance = 3) == None
        B8.south(distance = 2) == B6
        
        ```

        """
        
        ...

    def east(self, distance : int = 1) -> Optional[Square]: 
        """
        Gets the `Square` on the same rank but with a file that is the specified amount further through the alphabet. 
        If this would be out of bounds of a `Board`, returns `None`.
        
        Examples:
        ```
        B6.east() == C6
        A1.east(distance = 3) == D1
        H8.east(distance = 2) == None
        
        ```

        """
        ...

    def west(self, distance : int = 1) -> Optional[Square]: 
        """
        Gets the `Square` on the same rank but with a file that is the specified amount backwards through the alphabet. 
        If this would be out of bounds of a `Board`, returns `None`.
        
        Examples:
        ```
        B6.west() == A6
        A1.west(distance = 3) == None
        H8.west(distance = 2) == E8
        
        ```

        """
        ...

    def nw(self, distance : int = 1) -> Optional[Square]: ...

    def ne(self, distance : int = 1) -> Optional[Square]: ...

    def sw(self, distance : int = 1) -> Optional[Square]: ...

    def se(self, distance : int = 1) -> Optional[Square]: ...

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

    """
    A set of Squares. Internally stored as a 64-bit integer, where each bit corresponds to the inclusion of a Square in the set.
    """

    def __init__(self, squares : Collection[Square]):
        """
        Initializes a Bitboard to include the given Squares
        """
        ...


    def __str__(self) -> str:
        ...

    def __repr__(self) -> str:
        ...
    
    @staticmethod
    def from_int(value : int):
        """
        Constructs a `Bitboard` using the `int` representation which would be used internally.

        Examples:
        ```
        Bitboard([]) ==  Bitboard.from_int(0)
        Bitboard([A1]) ==  Bitboard.from_int(1)
        Bitboard([A1, B1]) ==  Bitboard.from_int(3)
        Bitboard([A1, B1, C1]) ==  Bitboard.from_int(7)
        Bitboard([H8]) ==  Bitboard.from_int(0x8000000000000000)
        Bitboard(SQUARES) ==  Bitboard.from_int(0xFFFF_FFFF_FFFF_FFFF)
        Bitboard([E2, E3, E4, D2, F2]) ==  Bitboard.from_int(269498368)
        ```

        :raises: :exc: `OverflowError` if given a negative `int` or a value greater than `2 ** 64 - 1`
        """
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

RANKS : list[Bitboard] = [RANK_1, RANK_2, RANK_3, RANK_4, RANK_5, RANK_6, RANK_7, RANK_8]

A_FILE : Bitboard
B_FILE : Bitboard
C_FILE : Bitboard
D_FILE : Bitboard
E_FILE : Bitboard
F_FILE : Bitboard
G_FILE : Bitboard
H_FILE : Bitboard

FILES : list[Bitboard] = [A_FILE, B_FILE, C_FILE, D_FILE, E_FILE, F_FILE, G_FILE, H_FILE]


FULL_BB : Bitboard
EMPTY_BB : Bitboard
LIGHT_SQUARE_BB : Bitboard
DARK_SQUARE_BB : Bitboard
class CastlingType:

    """
    Represents on of the four types of castling moves, being 
    for `WHITE` or `BLACK`, and for the kingside or for the queenside.
    """

    @staticmethod
    def from_chr(castling_type : str) -> str: 
        """
        Gets the `CastlingType` corresponding to the given `str` character. 

        Examples:
        ```
        CastlingType.from_chr("K") == WHITE_KINGSIDE)
        CastlingType.from_chr("Q") == WHITE_QUEENSIDE)
        CastlingType.from_chr("k") == BLACK_KINGSIDE)
        CastlingType.from_chr("q") == BLACK_QUEENSIDE)
        CastlingType.from_chr(str(WHITE_KINGSIDE)) == WHITE_KINGSIDE
        ```

        :raises: :exc: `ValueError` if given any other string besides "K", "Q", "k", or "q"
        """
        ...

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
        """
        Constructs a `Move` which can be used to enact the given `CastlingType`. 
        
        Examples:
        ```
        Move.castle(WHITE_KINGSIDE) == Move(E1, G1)
        Move.castle(WHITE_QUEENSIDE) == Move(E1, C1)
        Move.castle(BLACK_KINGSIDE) == Move(E8, G8)
        Move.castle(BLACK_QUEENSIDE) == Move(E8, C8)
        ```
        """
        ...

    @staticmethod
    def from_uci(uci : str) -> Optional["Move"]:
        """
        Constructs a `Move` from a `str` using Universal Chess Interface's Long Algebraic Notation.
        Supports null moves as `None`.

        Examples:
        ```
        Move.from_uci("e2e4") == Move(E2, E4)
        Move.from_uci("a1d4") == Move(A1, D4)
        Move.from_uci("b7b8q") == Move(B7, B8, promote_to = QUEEN)
        ```

        :raises: :exc:`ValueError` if the `str` is invalid or if the specified `Move` would be illegal for all pieces.
        """
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
        """
        Constructs a `Move` from a `str` using Standard Algebraic Notation, using the given `Board` as context.

        Examples:
        ```
        Move.from_san("e4", Board()) == Move(E2, E4)
        # Italian Game
        FEN = "r1bqkbnr/pppp1ppp/2n5/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R b KQkq - 3 3"
        board = Board.from_fen(FEN)
        Move.from_san("Nf6", board) == Move(G8, F6)
        ```

        :raises: :exc: `ValueError` if the given SAN `str` is invalid or illegal for the specified `Board`.
        """
        ...

    def san(self, board : "Board") -> str:
        """
        Gets a string of this `Move` represented in Standard Algebraic Notation, given a `Board` for context.

        Examples:
        ```
        Move(E2, E4).san(Board()) == "e4"
        FEN = "r1bqkb1r/pppp1ppp/2n2n2/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 4 4"
        Move(E1, G1).san(Board.from_fen(FEN)) == "O-O"
        ```

        :raises: :exc: `ValueError` if this `Move` is illegal for the given `Board`.
        
        """
        ...

    def uci(self) -> str:
        """
        Gets a `str` of this `Move` reprsented in Long Algebraic Notation as for the Universal Chess Inferface.

        Examples:
        ```
        Move(E2, E4).uci() == "e2e4"
        Move(A1, D4).uci() == "a1d4"
        Move(B7, B8, promote_to = QUEEN).uci() == "b7b8q"
        ```
        """
        ...

    def is_promotion(self) -> bool:
        """
        Returns `True` if this `Move` is a promotion

        Examples:
        ```
        Move.from_uci("b7b8q").is_promotion() == True
        Move(E2, E4).is_promotion() == False
        ```
        
        """
        ...

    def is_capture(self, board : Board) -> bool:
        """
        Returns `True` if this `Move` is a capture for the given `Board`.

        Examples:
        ```
        FEN = "r1bqkbnr/pppp1ppp/2n5/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R w KQkq - 2 3"
        board = Board.from_fen(FEN)
        Move(F3, E5).is_capture(board) == True
        ```
        """
        ...

    def is_castling(self, board : Board) -> bool:
        """
        Returns `True` if this `Move` is a castling move for the given `Board`.

        Examples:
        ```
        FEN = "r1bqkb1r/pppp1ppp/2n2n2/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 4 4"
        board = Board.from_fen(FEN)
        Move(E1, G1).is_castling(board) == True
        Move(E1, G1).is_castling(Board.empty()) == False
        ```
        """
        ...

    def castling_type(self, board : Board) -> Optional[CastlingType]:
        """
        Gets the `CastlingType` corresponding to this `Move`, if it is a castling move for the given `Board`. Otherwise, returns `None`.

        Examples:
        ```
        FEN = "r1bqkb1r/pppp1ppp/2n2n2/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 4 4"
        board = Board.from_fen(FEN)
        Move(E1, G1).castling_type(board) == WHITE_KINGSIDE
        Move(E1, G1).castling_type(Board.empty()) == None
        ```
        """
        ...

    def __str__(self) -> str:
        ...


class CastlingRights:

    """
    A set of `CastlingType` which can be used to indicate the castling rights of a `Board` 
    """

    def __init__(self, castling_types : Collection[CastlingType]) -> None:
        """
        Initializes a `CastlingRights` to have the given `Collection` of `CastlingType`.
        """
        ...

    @staticmethod
    def from_fen(castling_fen : str) -> CastlingRights:
        """
        Gets the `CastlingRights` object corresponding to the Forsyth-Edwards Notation `str` representation of castling rights for a position.

        Examples:
        ```
        CastlingRights.from_fen("KQkq") == CastlingRights([WHITE_KINGSIDE, WHITE_QUEENSIDE, BLACK_KINGSIDE, BLACK_QUEENSIDE])
        CastlingRights.from_fen("Qk") == CastlingRights([WHITE_QUEENSIDE, BLACK_KINGSIDE])
        CastlingRights.from_fen("-") == CastlingRights([])
        
        :raises: :exc: `ValueError` if the given `str` is not a valid FEN descriptor of castling rights.
        ```

        """
        ...

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

    def full(self, color : Optional[Color] = None) -> bool: 
        """
        Returns `True` if this `CastlingRights` object contains each `CastlingType`.
        If given a `Color` only checks the given side.

        Examples:
        ```
        CastlingRights.from_fen("KQkq").full() == True
        CastlingRights.from_fen("KQk").full() == False
        CastlingRights.from_fen("KQk").full(WHITE) == True
        CastlingRights.from_fen("-").full() == False
        ```
        """
        ...

    def any(self, color : Optional[Color] = None) -> bool: 
        """
        Returns `True` if this `CastlingRights` object contains any `CastlingType`.
        If given a `Color` only checks the given side.

        Examples:
        ```
        CastlingRights.from_fen("KQkq").any() == True
        CastlingRights.from_fen("KQk").any() == True
        CastlingRights.from_fen("K").any() == True
        CastlingRights.from_fen("K").any(BLACK) == False
        CastlingRights.from_fen("-").full() == False
        ```
        """
        ...

    def kingside(self, color : Optional[Color] = None) -> bool: 
        """
        Returns `True` if this `CastlingRights` object contains any kingside `CastlingType`.
        If given a `Color` only checks the given side.

        Examples:
        ```
        CastlingRights.from_fen("KQkq").kingside() == True
        CastlingRights.from_fen("Q").kingside() == False
        CastlingRights.from_fen("K").kingside() == True
        CastlingRights.from_fen("K").kingside(BLACK) == False
        CastlingRights.from_fen("-").kingside() == False
        ```
        """
        ...

    def queenside(self, color : Optional[Color] = None) -> bool: 
        """
        Returns `True` if this `CastlingRights` object contains any queenside `CastlingType`.
        If given a `Color` only checks the given side.

        Examples:
        ```
        CastlingRights.from_fen("KQkq").queenside() == True
        CastlingRights.from_fen("Q").queenside() == True
        CastlingRights.from_fen("K").queenside() == False
        CastlingRights.from_fen("Q").queenside(BLACK) == False
        CastlingRights.from_fen("-").queenside() == False
        ```
        """
        ...


ALL_CASTLING : CastlingRights
NO_CASTLING : CastlingRights


class Board:

    """
    Represents a chess position and gamestate as a mapping of `Square` to `Piece`, as well as
    the `CastlingRights`, the existance of an en-passant `Square`, and the `Color` for the turn of the current player.
    Also holds the halfmove clock and fullmove number each as an `int`. 

    The `Board` class provides an interface for generating `Move` objects representing legal actions for a turn, as well as applying and undoing these moves. 

    """

    def __init__(self) -> None:
        ...

    @staticmethod
    def from_fen(fen : str) -> "Board":
        ...

    @staticmethod
    def random() -> "Board":
        """
        Creates a `Board` with a position determined by appling a random number of randomly selected legal moves.
        """
        ...

    @staticmethod
    def empty() -> "Board":
        """
        Creates a completely empty `Board`, with no pieces on it.
        """
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

    def legal_moves(self) -> list[Move]:
        """
        Generates a `list` of legal `Move` objects for this `Board`'s position. 
        """
        ...

    def apply(self, move : Optional[Move]) -> None:
        """
        Applies the given `Move` to this `Board`, updating its state. The `Move` argument is not checked
        to be legal. `None` can be passed as the argument to skip a turn.   
        """
        ...

    def undo(self) -> Move: 
        """
        Undoes the last `Move` applied to this `Board`, and returns the `Move` that was played.
        """
        ...

    def fen(self) -> str:
        """
        Gets the Forsyth-Edwards Notation representation as a `str` of this `Board`.
        """
        ...

    def copy(self) -> "Board":
        """
        Returns a new `Board` which is an exact copy of this `Board`, including its `Move` history.
        """
        ...

    def __getitem__(self, square : Square) -> Optional[Piece]:
        """
        Gets the `Piece` at the specified `Square` on this `Board`. Evaluates to `None` if no `Piece` is placed
        on the given `Square`.
        """
        ...

    def __setitem__(self, square : Square, piece : Optional[Piece]):
        """
        Sets the `Piece` at the specified `Square` to the given `Piece`. 
        If set to `None`, the `Square` becomes empty.
        """
        ...

    def __delitem__(self, square : Square):
        """
        Deletes any `Piece` at the specified `Square`, leaving the `Square` empty.
        """
        ...

    def __eq__(self, other : Any) -> bool:
        """
        Returns `True` if compared with another `Board` with the same mapping of `Square` to `Piece` objects,
        equvilent `CastlingRights`, en-passant `Square` values, and halfmove and fullmove clocks.
        """
        ...

    def __hash__(self) -> int:
        ...
    
    def __contains__(self, piece : Optional[Piece]) -> bool:
        """
        Returns `True` if this `Board` has the specified `Piece`. When given `None`, returns `True` if there
        are any empy squares.
        """
        ...


    @property
    def pawns(self) -> Bitboard:
        """
        Gets a `Bitboard` of all `Square` objects which have a `PAWN` typed `Piece` for this `Board`
        """
        ...

    @property
    def knights(self) -> Bitboard:
        """
        Gets a `Bitboard` of all `Square` objects which have a `KNIGHT` typed `Piece` for this `Board`
        """
        ...

    @property
    def bishops(self) -> Bitboard:
        """
        Gets a `Bitboard` of all `Square` objects which have a `BISHOP` typed `Piece` for this `Board`
        """
        ...

    @property
    def rooks(self) -> Bitboard:
        """
        Gets a `Bitboard` of all `Square` objects which have a `ROOK` typed `Piece` for this `Board`
        """
        ...

    @property
    def queens(self) -> Bitboard:
        """
        Gets a `Bitboard` of all `Square` objects which have a `QUEEN` typed `Piece` for this `Board`
        """
        ...

    @property
    def kings(self) -> Bitboard:
        """
        Gets a `Bitboard` of all `Square` objects which have a `KING` typed `Piece` for this `Board`
        """
        ...

    @property
    def white(self) -> Bitboard:
        """
        Gets a `Bitboard` of all `Square` objects which have a `WHITE` colored `Piece` for this `Board`
        """
        ...

    @property
    def black(self) -> Bitboard:
        """
        Gets a `Bitboard` of all `Square` objects which have a `BLACK` colored `Piece` for this `Board`
        """
        ...

    @property
    def unoccupied(self) -> Bitboard:
        """
        Gets a `Bitboard` of all `Square` objects which have no `Piece` value for this `Board`
        """
        ...

    @property
    def history(self) -> list[Move]:
        """
        Gets a `list` of `Move` objects of every `Move` which have been used with `Board.apply()` and have not 
        been undone with `Board.undo()` for this `Board` 
        """
        ...


    def pretty(self, 
               color_scheme : Board.ColorScheme = OAK,
               highlighted_squares : Bitboard = EMPTY_BB,
               targeted_squares : Bitboard = EMPTY_BB) -> str:
        ...

    class ColorScheme:

        """
        A pallete of colors to be used with `Board.pretty()` 
        """

    LAGOON : ColorScheme
    SLATE : ColorScheme
    OAK : ColorScheme
    GREEN : ColorScheme
    WALNUT: ColorScheme
    ROSE : ColorScheme
    CLAY : ColorScheme
    STEEL : ColorScheme

class BoardStatus:
    """
    Represents a possible state, such as Check, Checkmate, Stalemate, or Threefold Repetition that 
    a `Board` may have.
    """

    def __repr__(self) -> str:
        ...

    def __contains__(self, board : Board) -> bool:
        """
        Checks if a a `Board` is "in" the state represented by this `BoardStatus`
        """
        ...


CHECK : BoardStatus
MATE : BoardStatus
CHECKMATE : BoardStatus
STALEMATE : BoardStatus
INSUFFICIENT_MATERIAL : BoardStatus
FIFTY_MOVE_TIMEOUT : BoardStatus
SEVENTY_FIVE_MOVE_TIMEOUT : BoardStatus
THREEFOLD_REPETITION : BoardStatus
FIVEFOLD_REPETITION : BoardStatus
DRAW : BoardStatus
FORCED_DRAW : BoardStatus