from typing import Optional, Any, Collection, Iterator, overload, override


class Color:

    """
    Represents either White or Black, used to identity the two players 
    and their pieces.
    """

    @staticmethod
    def from_str(name: str) -> "Color":
        """Return the colour corresponding to *name* (case‑insensitive).

        Examples
        --------
        >>> Color.from_str("White") is WHITE
        True
        >>> Color.from_str("BLACK") is BLACK
        True

        :param name: The string ``"white"`` or ``"black"`` in any case.
        :type name: str
        :returns: The matching :class:`Color` instance.
        :rtype: Color
        :raises ValueError: If *name* is not recognised.
        """
        ...

    @property
    def opposite(self) -> "Color": 
        """
        Gets the opposite `Color` to this one. 

        Examples
        --------
        >>> WHITE.opposite is BLACK
        True
        >>> BLACK.opposite is WHITE
        True

        :returns: The opposite :class:`Color` instance.
        :rtype: Color
        """
        ...

    def __str__(self) -> str:
        """
        Serializes a `Color` to a string of its name in title case.

        Examples
        ---------
        >>> str(WHITE)
        "White"
        >>> str(BLACK)
        "Black"
        """
        ...

    def __invert__(self) -> "Color":
        """
        Alias for :pyattr:`opposite`,  Allows ``~WHITE`` syntax."""
        ...

    def __hash__(self) -> int: ...
    def __repr__(self) -> str: ...
    def __eq__(self, other : Any) -> bool: ...
    
#: The white player
WHITE : Color
#: The black player
BLACK : Color

class PieceType:

    """
    Represents one of the 6 types of pieces in chess, either a Pawn, Knight, Bishop, Rook, Queen, or King.
    """


    @staticmethod
    def from_str(piece_type : str) -> "PieceType":
        """Return the piece type corresponding to *name* (case‑insensitive).

        Examples
        --------
        >>> PieceType.from_str("pawn") is PAWN
        True
        >>> PieceType.from_str("kNiGhT") is KNIGHT
        True

        :param name: One of ``"pawn"``, ``"knight"``, ``"bishop"``,
                     ``"rook"``, ``"queen"`` or ``"king"`` (any case).
        :type name: str
        :rtype: PieceType
        :returns: The matching :class:`PieceType`.
        :raises ValueError: If *name* is not recognised.
        """
        ...


    def __str__(self) -> str:
        """
        Serializes a `PieceType` to a `str` of its name in title case.

        Examples
        ---------
        >>> str(PAWN)
        "Pawn"
        >>> str(BISHOP)
        "Bishop"
        ```
        """
        ...

    def __repr__(self) -> str: ...
    def __eq__(self, other : Any) -> bool: ...
    def __hash__(self) -> int: ...

#: PieceType for pawns
PAWN : PieceType
#: PieceType for knights
KNIGHT : PieceType
#: PieceType for bishops
BISHOP : PieceType
#: PieceType for rooks
ROOK : PieceType
#: PieceType for queens
QUEEN : PieceType
#: PieceType for kings
KING : PieceType

#: A list of all PieceTypes
PIECE_TYPES : list[PieceType] = [PAWN, KNIGHT, BISHOP, ROOK, QUEEN, KING]


class Piece:

    """
    Represents a piece with both a Color and a PieceType, such as a White Pawn, or a Black Rook. 
    """


    def __init__(self, color : Color, type : PieceType):
        """Initialise the `Piece` with *color* and *type*.

        :param color: The owning side.
        :type color: Color
        :param type: The intrinsic kind of the piece.
        :type type: PieceType
        """
        ...

    @staticmethod
    def from_chr(char : str) -> Piece:
        """Return the piece encoded by *char* (ASCII piece letter).

        Upper‑case letters encode *white* pieces, lower‑case letters encode
        *black*.

        Examples
        --------
        >>> Piece.from_chr("P")
        <Piece: (White, Pawn)>
        >>> Piece.from_chr("n")
        <Piece: (Black, Knight)>

        :param char: One of ``PRNBQKprnbqk``.
        :type char: str
        :rtype: Piece
        :returns: The corresponding :class:`Piece`.
        :raises ValueError: If *char* is not a valid piece letter.
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
        Returns Unicode figurine character corresponding to this `Piece`.

        Examples
        --------
        >>> Piece(WHITE, PAWN).unicode()
        "♙"
        >>> Piece(BLACK, KNIGHT).unicode()
        "♞"
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

        Examples
        --------
        >>> str(Piece(WHITE, PAWN))
        "P"
        >>> str(Piece(BLACK, KNIGHT))
        "n"
        """
        ...


class Square:

    """
    Represents one of the 64 squares on a chess board. 
    """

    @staticmethod
    def from_str(name : str) -> Square:
        """
        Return the square encoded by *name* (case‑insensitive).

        Examples
        --------
        Square.from_string("E1") == E1
        >>> True
        Square.from_string("a2") == A2
        >>> True

        :raises: :exc: `ValueError` if given a string which does not represent a Square
        """
        ...

    def bb(self) -> Bitboard: 
        """
        Creates a :class:`Bitboard` containing **only** this :class:`Square`. 

        Examples
        --------
        >>> A1.bb() == Bitboard([A1])
        True
        >>> H3.bb() == Bitboard([H3])
        True
        """
        ...

    def adjacent(self) -> Bitboard: 
        """
        Creates a `Bitboard` of all neighbors orthogonal or diagonal to this :class:`Square`.

        Examples
        --------
        >>> A1.adjacent() == Bitboard([A2, B1, B2])
        True
        >>> E5.adjacent() == Bitboard([D4, D5, D6, E4, E6, F4, F5, F6])
        True
        """



        ...

    def north(self, distance: int = 1) -> Optional["Square"]:
        """
        Return the square *distance* ranks above this square.

        :param distance: how many ranks to move north.
        :type  distance: int, default 1
        :returns: the target square, or ``None`` if it would be off the board.
        :rtype:   Square | None

        Examples
        --------
        >>> B6.north() is B7
        True
        >>> A1.north(distance=3) is A4
        True
        >>> B8.north(distance=2)
        None
        """
        ...

    def south(self, distance: int = 1) -> Optional["Square"]:
        """
        Return the square *distance* ranks below this square.

        :param distance: how many ranks to move south.
        :type  distance: int, default 1
        :returns: the target square, or ``None`` if it would be off the board.
        :rtype:   Square | None

        Examples
        --------
        >>> B6.south() is B5
        True
        >>> B8.south(distance=2) is B6
        True
        >>> A1.south(distance=3)
        None
        """
        ...

    def east(self, distance: int = 1) -> Optional["Square"]:
        """
        Return the square *distance* files to the east of this square.

        :param distance: how many files to move east (toward the H-file).
        :type  distance: int, default 1
        :returns: the target square, or ``None`` if it would be off the board.
        :rtype:   Square | None

        Examples
        --------
        >>> B6.east() is C6
        True
        >>> A1.east(distance=3) is D1
        True
        >>> H8.east(distance=2)
        None
        """
        ...

    def west(self, distance: int = 1) -> Optional["Square"]:
        """
        Return the square *distance* files to the west of this square.

        :param distance: how many files to move west (toward the A-file).
        :type  distance: int, default 1
        :returns: the target square, or ``None`` if it would be off the board.
        :rtype:   Square | None

        Examples
        --------
        >>> B6.west() == A6
        True
        >>> H8.west(distance=2) == E8
        True
        >>> A1.west(distance=3)
        None
        """
        ...

    def nw(self, distance: int = 1) -> Optional["Square"]:
        """
        Return the square *distance* files west and ranks north of this square.

        :param distance: number of steps to move north-west.
        :type  distance: int, default 1
        :returns: the target square, or ``None`` if it would be off the board.
        :rtype:   Square | None

        Examples
        --------
        >>> C3.nw() == B4
        True
        >>> A1.nw()
        None
        >>> D4.nw(distance=2) == B6
        True
        """
        ...

    def ne(self, distance: int = 1) -> Optional["Square"]:
        """
        Return the square *distance* files east and ranks north of this square.

        :param distance: number of steps to move north-east.
        :type  distance: int, default 1
        :returns: the target square, or ``None`` if it would be off the board.
        :rtype:   Square | None

        Examples
        --------
        >>> C3.ne() is D4
        True
        >>> E4.ne(distance = 2) is G2
        True
        >>> H8.ne()
        None
        """
        ...

    def sw(self, distance: int = 1) -> Optional["Square"]:
        """
        Return the square *distance* files west and ranks south of this square.

        :param distance: number of steps to move south-west.
        :type  distance: int, default 1
        :returns: the target square, or ``None`` if it would be off the board.
        :rtype:   Square | None

        Examples
        --------
        >>> C3.sw() is B2
        True
        >>> E4.sw(distance = 2) is C6
        True
        >>> A1.sw()
        None
        """
        ...

    def se(self, distance: int = 1) -> Optional["Square"]:
        """
        Return the square *distance* files east and ranks south of this square.

        :param distance: number of steps to move south-east.
        :type  distance: int, default 1
        :returns: the target square, or ``None`` if it would be off the board.
        :rtype:   Square | None

        Examples
        --------
        >>> C3.se() is D2
        True
        >>> E4.se(distance = 2) is G6
        True
        >>> H1.se()
        None
        """
        ...

    def __eq__(self, other : Any) -> bool: ...
    def __hash__(self) -> int: ...
    def __str__(self) -> str: ...

#: The A1 Square
A1: Square
#: The B1 Square
B1: Square
#: The C1 Square
C1: Square
#: The D1 Square
D1: Square
#: The E1 Square
E1: Square
#: The F1 Square
F1: Square
#: The G1 Square
G1: Square
#: The H1 Square
H1: Square
#: The A2 Square
A2: Square
#: The B2 Square
B2: Square
#: The C2 Square
C2: Square
#: The D2 Square
D2: Square
#: The E2 Square
E2: Square
#: The F2 Square
F2: Square
#: The G2 Square
G2: Square
#: The H2 Square
H2: Square
#: The A3 Square
A3: Square
#: The B3 Square
B3: Square
#: The C3 Square
C3: Square
#: The D3 Square
D3: Square
#: The E3 Square
E3: Square
#: The F3 Square
F3: Square
#: The G3 Square
G3: Square
#: The H3 Square
H3: Square
#: The A4 Square
A4: Square
#: The B4 Square
B4: Square
#: The C4 Square
C4: Square
#: The D4 Square
D4: Square
#: The E4 Square
E4: Square
#: The F4 Square
F4: Square
#: The G4 Square
G4: Square
#: The H4 Square
H4: Square
#: The A5 Square
A5: Square
#: The B5 Square
B5: Square
#: The C5 Square
C5: Square
#: The D5 Square
D5: Square
#: The E5 Square
E5: Square
#: The F5 Square
F5: Square
#: The G5 Square
G5: Square
#: The H5 Square
H5: Square
#: The A6 Square
A6: Square
#: The B6 Square
B6: Square
#: The C6 Square
C6: Square
#: The D6 Square
D6: Square
#: The E6 Square
E6: Square
#: The F6 Square
F6: Square
#: The G6 Square
G6: Square
#: The H6 Square
H6: Square
#: The A7 Square
A7: Square
#: The B7 Square
B7: Square
#: The C7 Square
C7: Square
#: The D7 Square
D7: Square
#: The E7 Square
E7: Square
#: The F7 Square
F7: Square
#: The G7 Square
G7: Square
#: The H7 Square
H7: Square
#: The A8 Square
A8: Square
#: The B8 Square
B8: Square
#: The C8 Square
C8: Square
#: The D8 Square
D8: Square
#: The E8 Square
E8: Square
#: The F8 Square
F8: Square
#: The G8 Square
G8: Square
#: The H8 Square
H8: Square


#: A list of all Squares
SQUARES : list[Square] = [A1, B1, C1, D1, E1, F1, G1, H1, A2, B2, ..., H8]

class Bitboard:
    """
    A set of squares represented as a 64-bit integer, where each bit
    indicates whether a :class:`Square` is included.
    """

    def __init__(self, squares: Collection[Square]):
        """
        Initialise a bitboard that contains *squares*.

        :param squares: squares to include in the new bitboard.
        :type  squares: Collection[Square]
        """
        ...

    def __str__(self) -> str:
        """
        Return a string in which included squares are shown as ``1`` and
        excluded squares as ``0``.

        :returns: an 8×8 grid row-major from A8 to H1.
        :rtype:   str

        Examples
        --------
        >>> print(str(RANK_5))
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        1 1 1 1 1 1 1 1 
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0
        """
        ...

    @staticmethod
    def from_int(value: int) -> "Bitboard":
        """
        Construct a bitboard from its integer encoding (see :py:meth:`__int__`).

        :param value: 64-bit integer to convert.
        :type  value: int
        :returns: new bitboard corresponding to *value*.
        :rtype:   Bitboard
        :raises OverflowError: if `value < 0` or `value >= 2 ** 64`

        Examples
        --------
        >>> Bitboard.from_int(0) == Bitboard([])
        True
        >>> Bitboard.from_int(1) == Bitboard([A1])
        True
        >>> Bitboard.from_int(269498368) == Bitboard([E2, E3, E4, D2, F2])
        True
        >>> Bitboard.from_int(0xFFFF_FFFF_FFFF_FFFF) == FULL_BB
        True
        """
        ...

    def __int__(self) -> int:
        """
        Return the integer encoding of this bitboard.

        :returns: 64-bit integer with one bit per square.
        :rtype:   int

        Examples
        --------
        >>> int(EMPTY_BB)
        0
        >>> int(Bitboard([A1]))
        1
        >>> int(Bitboard([E2, E3, E4, D2, F2]))
        269498368
        >>> Bitboard.from_int(int(DARK_SQUARE_BB)) == DARK_SQUARE_BB
        True
        """
        ...

    def __getitem__(self, square: Square) -> bool:
        """
        Return ``True`` if *square* is in this bitboard.

        :param square: square to query.
        :type  square: Square
        :returns: membership flag.
        :rtype:   bool

        Examples
        --------
        >>> bb = Bitboard([A1, B2, C3])
        >>> bb[A1]
        True
        >>> bb[A2]
        False
        """
        ...

    def __setitem__(self, square: Square, value: bool):
        """
        Add or remove *square* depending on *value*.

        :param square: square to modify.
        :type  square: Square
        :param value: ``True`` → add, ``False`` → remove.
        :type  value: bool

        Examples
        --------
        >>> bb = Bitboard([A1, B2, C3])
        >>> bb2 = Bitboard([B2, C3])
        >>> bb3 = Bitboard([B2, C3, C4])
        >>> bb[A1] = False
        >>> bb == bb2
        True
        >>> bb[C4] = True
        >>> bb == bb3
        True
        """
        ...

    def __delitem__(self, square: Square):
        """
        Remove *square* from the bitboard.

        :param square: square to delete.
        :type  square: Square

        Examples
        --------
        >>> bb = Bitboard([A1, B2, C3])
        >>> bb2 = Bitboard([B2, C3])
        >>> del bb[A1]
        >>> bb == bb2
        True
        """
        ...


    def __len__(self) -> int:
        """
        Return the number of squares contained in this bitboard.

        :returns: population count.
        :rtype:   int

        Examples
        --------
        >>> len(Bitboard([]))
        0
        >>> len(Bitboard([A1, A2]))
        2
        >>> len(RANK_1)
        8
        >>> len(FULL_BB)
        64
        """
        ...

    def __contains__(self, square: Square) -> bool:
        """
        Test whether *square* is in this bitboard.

        :param square: square to test.
        :type  square: Square
        :returns: membership flag.
        :rtype:   bool

        Examples
        --------
        >>> A1 in Bitboard([A1, A2])
        True
        >>> H3 in FULL_BB
        True
        >>> C6 in RANK_1
        False
        """
        ...

    def __eq__(self, other: Any) -> bool:
        """
        Return ``True`` if *other* is a bitboard with the same squares.

        :param other: bitboard to compare.
        :type  other: Any
        :returns: equality flag.
        :rtype:   bool

        Examples
        --------
        >>> Bitboard([A1, A2, A3, A4, A5, A6, A7, A8]) == A_FILE
        True
        >>> Bitboard([C4]) == Bitboard([C3])
        False
        """
        ...

    def __invert__(self) -> "Bitboard":
        """
        Return the complement of this bitboard.

        :returns: new bitboard with opposite membership.
        :rtype:   Bitboard

        Examples
        --------
        >>> FULL_BB == ~EMPTY_BB
        True
        >>> LIGHT_SQUARE_BB == ~DARK_SQUARE_BB
        True
        """
        ...

    def __and__(self, other: "Bitboard") -> "Bitboard":
        """
        Return the intersection of two bitboards.

        :param other: bitboard to intersect with.
        :type  other: Bitboard
        :returns: squares common to both operands.
        :rtype:   Bitboard

        Examples
        --------
        >>> Bitboard([A1]) & Bitboard([A1, A2]) == Bitboard([A1])
        True
        >>> LIGHT_SQUARE_BB & DARK_SQUARE_BB == EMPTY_BB
        True
        """
        ...

    def __or__(self, other: "Bitboard") -> "Bitboard":
        """
        Return the union of two bitboards.

        :param other: bitboard to union with.
        :type  other: Bitboard
        :returns: squares contained in either operand.
        :rtype:   Bitboard

        Examples
        --------
        >>> Bitboard([A1]) | Bitboard([A1, A2]) == Bitboard([A1, A2])
        True
        >>> LIGHT_SQUARE_BB | DARK_SQUARE_BB == FULL_BB
        True
        """
        ...

    def __xor__(self, other: "Bitboard") -> "Bitboard":
        """
        Return the symmetric difference of two bitboards.

        :param other: bitboard to XOR with.
        :type  other: Bitboard
        :returns: squares in exactly one operand.
        :rtype:   Bitboard

        Examples
        --------
        >>> Bitboard([A1]) ^ Bitboard([A1, A2]) == Bitboard([A2])
        True
        >>> LIGHT_SQUARE_BB ^ DARK_SQUARE_BB == FULL_BB
        True
        """
        ...

    def __bool__(self) -> bool:
        """
        Return ``True`` if the bitboard is non-empty.

        :returns: truth value.
        :rtype:   bool

        Examples
        --------
        >>> bool(Bitboard([]))
        False
        >>> bool(EMPTY_BB)
        False
        >>> bool(Bitboard([A1]))
        True
        """
        ...

    def __iter__(self) -> Iterator[Square]:
        """Iterate over included squares from A1 upward."""
        ...

    def __repr__(self) -> str:  ...

    def __hash__(self) -> int: ...

#: Bitboard containing every square on Rank 1.
RANK_1: Bitboard
#: Bitboard containing every square on Rank 2.
RANK_2: Bitboard
#: Bitboard containing every square on Rank 3.
RANK_3: Bitboard
#: Bitboard containing every square on Rank 4.
RANK_4: Bitboard
#: Bitboard containing every square on Rank 5.
RANK_5: Bitboard
#: Bitboard containing every square on Rank 6.
RANK_6: Bitboard
#: Bitboard containing every square on Rank 7.
RANK_7: Bitboard
#: Bitboard containing every square on Rank 8.
RANK_8: Bitboard

#: Ordered list of the eight rank bitboards, ``RANK_1`` through ``RANK_8``.
RANKS: list[Bitboard] = [RANK_1, RANK_2, RANK_3, RANK_4,
                         RANK_5, RANK_6, RANK_7, RANK_8]

#: Bitboard containing every square on the **A-file**.
A_FILE: Bitboard
#: Bitboard containing every square on the **B-file**.
B_FILE: Bitboard
#: Bitboard containing every square on the **C-file**.
C_FILE: Bitboard
#: Bitboard containing every square on the **D-file**.
D_FILE: Bitboard
#: Bitboard containing every square on the **E-file**.
E_FILE: Bitboard
#: Bitboard containing every square on the **F-file**.
F_FILE: Bitboard
#: Bitboard containing every square on the **G-file**.
G_FILE: Bitboard
#: Bitboard containing every square on the **H-file**.
H_FILE: Bitboard

#: Ordered list of the eight file bitboards, ``A_FILE`` through ``H_FILE``.
FILES: list[Bitboard] = [A_FILE, B_FILE, C_FILE, D_FILE,
                         E_FILE, F_FILE, G_FILE, H_FILE]

#: Bitboard containing **all 64 squares**.
FULL_BB: Bitboard
#: An **empty** bitboard containing no squares.
EMPTY_BB: Bitboard
#: Bitboard of all **light-squared** squares (A1 is dark, so B1 is light, etc.).
LIGHT_SQUARE_BB: Bitboard
#: Bitboard of all **dark-squared** squares.
DARK_SQUARE_BB: Bitboard
class CastlingType:
    """
    One of four legal castling options: the king moves either kingside or
    queenside for *WHITE* or *BLACK*.
    """

    @staticmethod
    def from_chr(castling_type: str) -> "CastlingType":
        """
        Return the castling type corresponding to a single-character code.

        :param castling_type: one of ``"K"``, ``"Q"``, ``"k"``, ``"q"``.
        :type  castling_type: str
        :returns: the matching :class:`CastlingType`.
        :rtype:   CastlingType
        :raises ValueError: if *castling_type* is not a valid code.

        Examples
        --------
        >>> CastlingType.from_chr("K") is WHITE_KINGSIDE
        True
        >>> CastlingType.from_chr("Q") is WHITE_QUEENSIDE
        True
        >>> CastlingType.from_chr("k") is BLACK_KINGSIDE
        True
        >>> CastlingType.from_chr("q") is BLACK_QUEENSIDE
        True
        """
        ...

    def __str__(self) -> str:
        """
        Return the one-character code for this castling type.

        :returns: ``"K"``, ``"Q"``, ``"k"``, or ``"q"``.
        :rtype:   str

        Examples
        --------
        >>> str(WHITE_KINGSIDE)
        'K'
        >>> str(WHITE_QUEENSIDE)
        'Q'
        >>> str(BLACK_KINGSIDE)
        'k'
        >>> str(BLACK_QUEENSIDE)
        'q'
        """
        ...

    def __eq__(self, other: Any) -> bool:
        """
        Return ``True`` if *other* is the same castling type.

        :param other: object to compare.
        :type  other: Any
        :returns: equality flag.
        :rtype:   bool
        """
        ...

    def __repr__(self) -> str: ...

    def __hash__(self) -> int: ...



#: Castling type representing **White** kingside castling
WHITE_KINGSIDE: CastlingType
#: Castling type representing **White** queenside castling
WHITE_QUEENSIDE: CastlingType
#: Castling type representing **Black** kingside castling
BLACK_KINGSIDE: CastlingType
#: Castling type representing **Black** queenside castling
BLACK_QUEENSIDE: CastlingType

class Move:
    """
    A chess move, defined by its origin and destination squares and an
    optional promotion piece type.
    """

    def __init__(
        self,
        origin: Square,
        destination: Square,
        promote_to: Optional[PieceType] = None,
    ):
        """
        Create a move from *origin* to *destination*.

        :param origin: square the piece starts on.
        :type  origin: Square
        :param destination: square the piece ends on.
        :type  destination: Square
        :param promote_to: piece type to promote to, if any.
        :type  promote_to: PieceType | None
        """
        ...


    @staticmethod
    def castle(castling_type: CastlingType) -> "Move":
        """
        Return the move corresponding to *castling_type*.

        :param castling_type: one of the four castling constants.
        :type  castling_type: CastlingType
        :returns: appropriate king move for that castling.
        :rtype:   Move

        Examples
        --------
        >>> Move.castle(WHITE_KINGSIDE) == Move(E1, G1)
        True
        >>> Move.castle(WHITE_QUEENSIDE) == Move(E1, C1)
        True
        >>> Move.castle(BLACK_KINGSIDE) == Move(E8, G8)
        True
        >>> Move.castle(BLACK_QUEENSIDE) == Move(E8, C8)
        True
        """
        ...

    @staticmethod
    def from_uci(uci: str) -> Optional["Move"]:
        """
        Parse a UCI long-algebraic string and build a move.

        :param uci: UCI string such as ``"e2e4"`` or ``"b7b8q"``.
        :type  uci: str
        :returns: move instance, or ``None`` for a null move.
        :rtype:   Move | None
        :raises ValueError: if *uci* is malformed or illegal.

        Examples
        --------
        >>> Move.from_uci("e2e4") == Move(E2, E4)
        True
        >>> Move.from_uci("a1d4") == Move(A1, D4)
        True
        >>> Move.from_uci("b7b8q") == Move(B7, B8, promote_to=QUEEN)
        True
        """
        ...

    @staticmethod
    def from_san(san: str, board: "Board") -> "Move":
        """
        Parse a SAN string in the context of *board*.

        :param san: SAN text (e.g. ``"Nf6"``, ``"O-O"``, ``"e4"``).
        :type  san: str
        :param board: position used to disambiguate the SAN.
        :type  board: Board
        :returns: the corresponding move.
        :rtype:   Move
        :raises ValueError: if *san* is invalid for *board*.

        Examples
        --------
        >>> Move.from_san("e4", Board()) == Move(E2, E4)
        True
        >>> FEN = "r1bqkbnr/pppp1ppp/2n5/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R b KQkq - 3 3"
        >>> board = Board.from_fen(FEN)
        >>> Move.from_san("Nf6", board) == Move(G8, F6)
        True
        """
        ...

    def san(self, board: "Board") -> str:
        """
        Return this move in SAN notation relative to *board*.

        :param board: position that provides context.
        :type  board: Board
        :returns: SAN string.
        :rtype:   str
        :raises ValueError: if the move is illegal for *board*.

        Examples
        --------
        >>> Move(E2, E4).san(Board())
        'e4'
        >>> FEN = "r1bqkb1r/pppp1ppp/2n2n2/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 4 4"
        >>> Move(E1, G1).san(Board.from_fen(FEN))
        'O-O'
        """
        ...

    def uci(self) -> str:
        """
        Return the move in UCI long-algebraic form.

        :returns: UCI string.
        :rtype:   str

        Examples
        --------
        >>> Move(E2, E4).uci()
        'e2e4'
        >>> Move(A1, D4).uci()
        'a1d4'
        >>> Move(B7, B8, promote_to=QUEEN).uci()
        'b7b8q'
        """
        ...

    def __str__(self) -> str:
        """
        Alias for :py:meth:`uci`.

        Examples
        --------
        >>> str(Move(E2, E4))
        'e2e4'
        >>> str(Move(A1, D4))
        'a1d4'
        >>> str(Move(B7, B8, promote_to=QUEEN))
        'b7b8q'
        """
        ...

    @property
    def origin(self) -> Square:
        """
        Square the piece moves from.

        Examples
        --------
        >>> Move(E2, E4).origin is E2
        True
        >>> Move.from_uci("a1d4").origin is A1
        True
        """
        ...

    @property
    def destination(self) -> Square:
        """
        Square the piece moves to.

        Examples
        --------
        >>> Move(E2, E4).destination is E4
        True
        >>> Move.from_uci("a1d4").destination is D4
        True
        """
        ...

    @property
    def promotion(self) -> Optional[PieceType]:
        """
        Promotion piece type, or ``None`` for a non-promotion.

        Examples
        --------
        >>> Move.from_uci("b7b8q").promotion is QUEEN
        True
        >>> Move(E2, E4).promotion is None
        True
        """
        ...

    def is_promotion(self) -> bool:
        """
        Return ``True`` if the move is a promotion.

        Examples
        --------
        >>> Move.from_uci("b7b8q").is_promotion()
        True
        >>> Move(E2, E4).is_promotion()
        False
        """
        ...

    def is_capture(self, board: "Board") -> bool:
        """
        Return ``True`` if the move captures a piece on *board*.

        :param board: position in which to evaluate the capture.
        :type  board: Board
        :returns: capture flag.
        :rtype:   bool

        Examples
        --------
        >>> FEN = "r1bqkbnr/pppp1ppp/2n5/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R w KQkq - 2 3"
        >>> board = Board.from_fen(FEN)
        >>> Move(F3, E5).is_capture(board)
        True
        """
        ...

    def is_castling(self, board: "Board") -> bool:
        """
        Return ``True`` if the move is a legal castling move on *board*.

        :param board: position used for validation.
        :type  board: Board
        :returns: castling flag.
        :rtype:   bool

        Examples
        --------
        >>> FEN = "r1bqkb1r/pppp1ppp/2n2n2/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 4 4"
        >>> board = Board.from_fen(FEN)
        >>> Move(E1, G1).is_castling(board)
        True
        >>> Move(E1, G1).is_castling(Board.empty())
        False
        """
        ...

    def castling_type(self, board: "Board") -> Optional[CastlingType]:
        """
        If the move is castling, return its type; otherwise ``None``.

        :param board: position used for classification.
        :type  board: Board
        :returns: corresponding castling type or ``None``.
        :rtype:   CastlingType | None

        Examples
        --------
        >>> FEN = "r1bqkb1r/pppp1ppp/2n2n2/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 4 4"
        >>> board = Board.from_fen(FEN)
        >>> Move(E1, G1).castling_type(board) is WHITE_KINGSIDE
        True
        >>> Move(E1, G1).castling_type(Board.empty()) is None
        True
        """
        ...

    def __eq__(self, other: Any) -> bool:
        """
        Return ``True`` if *other* has the same origin, destination and
        promotion.

        :param other: object to compare.
        :type  other: Any
        :returns: equality flag.
        :rtype:   bool

        Examples
        --------
        >>> Move(E2, E4) == Move.from_uci("e2e4")
        True
        >>> Move(A7, A8) == Move.from_uci("a7a8q")
        False
        """
        ...

    def __hash__(self) -> int: ...

    def __repr__(self) -> str: ...


class CastlingRights:
    """
    A set of :class:`CastlingType` values that encodes a :class:`Board`'s castling
    permissions.
    """

    def __init__(self, castling_types: Collection[CastlingType]) -> None:
        """
        Initialise the object with *castling_types*.

        :param castling_types: iterable of castling constants to include.
        :type  castling_types: Collection[CastlingType]
        """
        ...

    @staticmethod
    def from_fen(castling_fen: str) -> "CastlingRights":
        """
        Build a :class:`CastlingRights` object from a FEN castling field.

        :param castling_fen: ``"KQkq"``, ``"KQ"``, ``"-"`` …
        :type  castling_fen: str
        :returns: rights object matching *castling_fen*.
        :rtype:   CastlingRights
        :raises ValueError: if *castling_fen* is not valid FEN.

        Examples
        --------
        >>> CastlingRights.from_fen("KQkq") == ALL_CASTLING
        True
        >>> CastlingRights.from_fen("Qk") == CastlingRights([WHITE_QUEENSIDE, BLACK_KINGSIDE])
        True
        >>> CastlingRights.from_fen("-") == NO_CASTLING
        True
        """
        ...

    def __contains__(self, castling_type: CastlingType) -> bool:
        """
        Return ``True`` if *castling_type* is present.

        :param castling_type: entry to test.
        :type  castling_type: CastlingType
        :returns: membership flag.
        :rtype:   bool

        Examples
        --------
        >>> WHITE_KINGSIDE in ALL_CASTLING
        True
        >>> BLACK_KINGSIDE in NO_CASTLING
        False
        """
        ...

    def __add__(self, other: "CastlingRights") -> "CastlingRights":
        """
        Return the union of two castling-rights sets.

        :param other: rights to add.
        :type  other: CastlingRights
        :returns: combined rights.
        :rtype:   CastlingRights

        Examples
        --------
        >>> CastlingRights.from_fen("KQ") + CastlingRights.from_fen("kq") == ALL_CASTLING
        True
        """
        ...

    def __eq__(self, other: Any) -> bool:
        """Return ``True`` if *other* has the identical rights set."""
        ...

    def __le__(self, other: "CastlingRights") -> bool:
        """
        Return ``True`` if this set is a subset of *other*.

        Examples
        --------
        >>> CastlingRights.from_fen("KQ") <= CastlingRights.from_fen("KQkq")
        True
        >>> CastlingRights.from_fen("KQkq") <= CastlingRights.from_fen("KQkq")
        True
        """
        ...

    def __lt__(self, other: "CastlingRights") -> bool:
        """
        Return ``True`` if this set is a **strict** subset of *other*.

        Examples
        --------
        >>> CastlingRights.from_fen("KQ") < CastlingRights.from_fen("KQkq")
        True
        >>> CastlingRights.from_fen("KQkq") < CastlingRights.from_fen("KQkq")
        False
        """
        ...

    def __gt__(self, other: "CastlingRights") -> bool:
        """
        Return ``True`` if this set is a **strict** superset of *other*.

        Examples
        --------
        >>> CastlingRights.from_fen("KQkq") > CastlingRights.from_fen("KQ")
        True
        >>> CastlingRights.from_fen("KQkq") > CastlingRights.from_fen("KQkq")
        False
        """
        ...

    def __ge__(self, other: "CastlingRights") -> bool:
        """
        Return ``True`` if this set is a superset of, or equal to, *other*.

        Examples
        --------
        >>> CastlingRights.from_fen("KQkq") >= CastlingRights.from_fen("KQ")
        True
        >>> CastlingRights.from_fen("KQkq") >= CastlingRights.from_fen("KQkq")
        True
        """
        ...

    def __str__(self) -> str:
        """
        Return the FEN castling field for this object.

        :returns: ``"KQkq"``, ``"-"`` or similar.
        :rtype:   str

        Examples
        --------
        >>> str(NO_CASTLING)
        '-'
        >>> str(CastlingRights([WHITE_KINGSIDE, WHITE_QUEENSIDE]))
        'KQ'
        >>> str(ALL_CASTLING)
        'KQkq'
        """
        ...

    def full(self, color: Optional[Color] = None) -> bool:
        """
        Return ``True`` if **all** relevant rights are present.

        :param color: restrict the check to *WHITE* or *BLACK*.
        :type  color: Color | None
        :returns: completeness flag.
        :rtype:   bool

        Examples
        --------
        >>> ALL_CASTLING.full()
        True
        >>> CastlingRights.from_fen("KQk").full()
        False
        >>> CastlingRights.from_fen("KQk").full(WHITE)
        True
        >>> NO_CASTLING.full()
        False
        """
        ...

    def any(self, color: Optional[Color] = None) -> bool:
        """
        Return ``True`` if **any** relevant right is present.

        :param color: restrict the check to *WHITE* or *BLACK*.
        :type  color: Color | None
        :returns: presence flag.
        :rtype:   bool

        Examples
        --------
        >>> ALL_CASTLING.any()
        True
        >>> CastlingRights.from_fen("KQk").any()
        True
        >>> CastlingRights.from_fen("K").any()
        True
        >>> CastlingRights.from_fen("K").any(BLACK)
        False
        >>> NO_CASTLING.any()
        False
        """
        ...

    def kingside(self, color: Optional[Color] = None) -> bool:
        """
        Return ``True`` if any kingside right is present.

        :param color: restrict the check to *WHITE* or *BLACK*.
        :type  color: Color | None
        :returns: kingside flag.
        :rtype:   bool

        Examples
        --------
        >>> ALL_CASTLING.kingside()
        True
        >>> CastlingRights.from_fen("Q").kingside()
        False
        >>> CastlingRights.from_fen("K").kingside()
        True
        >>> CastlingRights.from_fen("K").kingside(BLACK)
        False
        >>> NO_CASTLING.kingside()
        False
        """
        ...

    def queenside(self, color: Optional[Color] = None) -> bool:
        """
        Return ``True`` if any queenside right is present.

        :param color: restrict the check to *WHITE* or *BLACK*.
        :type  color: Color | None
        :returns: queenside flag.
        :rtype:   bool

        Examples
        --------
        >>> ALL_CASTLING.queenside()
        True
        >>> CastlingRights.from_fen("Q").queenside()
        True
        >>> CastlingRights.from_fen("K").queenside()
        False
        >>> CastlingRights.from_fen("Q").queenside(BLACK)
        False
        >>> NO_CASTLING.queenside()
        False
        """
        ...

    def __repr__(self) -> str: ...

    def __hash__(self) -> int: ...


#: Castling rights which include all types of castling
ALL_CASTLING : CastlingRights
#: Castling rights which include no types of castling
NO_CASTLING : CastlingRights


class Board:

    """
    A mutable chess position.

    A `Board` represents a configuration of chess pieces as a mapping of each :class:`Square` to optional an :class:`Piece`. 
    The `Board` class includes attributes for :class:`CastlingRights`, the existance of an en-passant `Square`, and the `Color` for the turn of the current player.
    Also holds the halfmove clock and fullmove number each as an `int`. 

    The `Board` class provides an interface for generating `Move` objects representing legal actions for a turn, 
    as well as applying and undoing these moves. 

    """

    def __init__(self):
        """
        Initializes a `Board` representing the starting position.
        """
        ...

    @staticmethod
    def from_fen(fen : str) -> "Board":
        """
        Build a board from a FEN string.

        The FEN is not required to included a halfmove clock or fullmove number. The default values for these are 0 and 1.

        :param fen: full FEN record.
        :type  fen: str
        :returns: board represented by *fen*.
        :rtype:   Board
        :raises ValueError: if *fen* is malformed.

        Examples
        --------
        >>> Board.from_fen("8/8/8/8/8/8/8/K6k w - - 0 1").turn is WHITE
        True
        """
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
        """
        Side to move, either `WHITE` or `BLACK`.
        """
        ...

    @property
    def halfmove_clock(self) -> int:
        """
        Gets the current halfmove clock as an `int`. This represents the number of ply that have passed since a
        capture or pawn advance.
        """
        ...

    @property
    def fullmove_number(self) -> int:
        """
        Gets the current fullmove number as an `int`. This represents the total number of turns each player has taken
        since the start of a game.
        """
        ...

    @property
    def en_passant_square(self) -> Optional[Square]:
        """
        Gets the current en passant `Square`, if it exists. Otherwise returns `None`.
        """
        ...

    @property
    def castling_rights(self) -> CastlingRights:
        """
        Gets the current `CastlingRights` of this `Board`.
        """
        ...

    @castling_rights.setter
    def castling_rights(self, castling_rights : CastlingRights) -> None:
        """
        Sets this `Board`'s `CastlingRights` to the given value. 

        :raises: :exc: `ValueError` if the given `CastlingRights` are illegal for this `Board`'s position.
        """
        ...

    @turn.setter
    def turn(self, new_turn : Color) -> None:
        """
        Sets this `Board`'s turn to the specified `Color.
        """

    @halfmove_clock.setter
    def halfmove_clock(self, new_halfmove_clock : int) -> None:
        """
        Sets this `Board`'s halfmove clock to the provided `int`.

        :raises: :exc: `OverflowError` if the provided `int` value is greater or equal to `2 ** 64`
        """
        ...

    @fullmove_number.setter
    def fullmove_number(self, new_fullmove_number : int) -> None:
        """
        Sets this `Board`'s fullmove number to the provided `int`.

        :raises: :exc: `OverflowError` if the provided `int` value is greater or equal to `2 ** 64`
        """
        ...

    @en_passant_square.setter
    def en_passant_square(self, new_ep_square : Optional[Square]) -> None:
        """
        Sets this `Board`'s en passant `Square` to the provided value. Cleares the en passant `Square` if given `None`

        :raises: :exc: If the specified `Square` could not be one that a Pawn has just passed over in an intial two square advance.
        """
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

        Examples
        ---------
        >>>
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

    @overload
    def __getitem__(self, square : Square) -> Optional[Piece]:
        """
        Returns the `Piece` at the specified `Square` on this `Board`. Evaluates to `None` if no `Piece` is placed
        on the given `Square`.
        """
        ...

    @overload
    def __getitem__(self, piece_type : Optional[PieceType]) -> Bitboard:
        """
        Returns a :class:`Bitboard` of all squares which have the given :class:`PieceType`
        If given `None`, returns a :class:`Bitboard` of all empty squares.
        """
        ...

    @overload
    def __getitem__(self, color : Optional[Color]) -> Bitboard:
        """
        Returns a :class:`Bitboard` of all squares which have a piece with the given :class:`Color`.
        If given `None`, returns a :class:`Bitboard` of all empty squares.
        """
        ...

    @overload
    def __getitem__(self, piece : Optional[Piece]) -> Bitboard:
        """
        Returns a :class:`Bitboard` of all squares which have the given :class:`Piece`.
        If given `None`, returns a :class:`Bitboard` of all empty squares.
        """
        ...

    @overload
    def __getitem__(self, piece_tuple : tuple[Color, PieceType]) -> Bitboard:
        """
        Returns a :class:`Bitboard` of all squares which have the given :class:`Color` and :class:`PieceType`.
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

        Two boards may be considered equal despite having different move histories. 
        """
        ...

    def __hash__(self) -> int:
        """
        Performs a Zobrist hash of this Board.
        """
        ...
    
    def __contains__(self, piece : Optional[Piece]) -> bool:
        """
        Returns `True` if this `Board` has the specified `Piece`. When given `None`, returns `True` if there
        are any empy squares.
        """
        ...

    @property
    def history(self) -> list[Move]:
        """
        Gets a `list` of `Move` objects of every `Move` which have been used with `Board.apply()` and have not 
        been undone with `Board.undo()` for this `Board` 

        Examples
        --------
        >>> board = Board()
        >>> board.apply(Move(E2, E4))
        >>> board.apply(Move(E7, E5))
        >>> board.apply(Move(G1, F3))
        >>> board.history
        [<Move: e2e4>, <Move: e7e5>, <Move: g1f3>]
        """
        ...

    def __str__(self):
        """
        Returns an ASCII `str` representation of this :class:`Board`.

        Examples
        ---------
        >>> print(str(Board()))
        r n b q k b n r 
        p p p p p p p p 
        - - - - - - - - 
        - - - - - - - - 
        - - - - - - - - 
        - - - - - - - - 
        P P P P P P P P 
        R N B Q K B N R 

        >>> FEN = "rnb3r1/R3Q3/2p5/1p1k1p1r/1n1P4/8/4P3/2K2B1r b - - 3 69"
        >>> board = Board.from_fen(FEN)
        >>> print(str(board))
        r n b - - - r - 
        R - - - Q - - - 
        - - p - - - - - 
        - p - k - p - r 
        - n - P - - - - 
        - - - - - - - - 
        - - - - P - - - 
        - - K - - B - r 
        """

    def pretty(self, 
               color_scheme : Board.ColorScheme = Board.OAK,
               highlighted_squares : Bitboard = EMPTY_BB,
               targeted_squares : Bitboard = EMPTY_BB) -> str:
        """
        Creates a `str` representation of this `Board` using Unicode chess characters and the provided `Board.ColorScheme` as a palette. 
        `Bitboard`s can be specified for highlighting particular squares, as for example a `Move`'s origin, as well as for targetting 
        certain squares, as for possible `Move` destinations.
        """
        ...

    class ColorScheme:

        """
        A pallete of colors to be used with :func:`Board.pretty()` to stylize printed 
        boards.
        """

    #: A light blue color pallete
    LAGOON : ColorScheme
    #: A slightly purplish, grey color pallete
    SLATE : ColorScheme
    #: A classical, wood styled color pallete
    OAK : ColorScheme
    #: A familiar green and white color pallete
    GREEN : ColorScheme
    #: A less saturated wood styled color pallete 
    WALNUT: ColorScheme
    #: A pinkish red color pallete
    ROSE : ColorScheme
    #: A dulled rosy brown and grey color pallete
    CLAY : ColorScheme
    #: A monochromatic grey color pallete
    STEEL : ColorScheme

class BoardStatus:
    """
    A predicate-like object that answers the question *“is this board in
    status X?”*  Examples of statuses include **check**, **check-mate**,
    **stalemate**, and repetition or 50-move draw claims.
    """

    def __contains__(self, board: Board) -> bool:
        """
        Return ``True`` if *board* satisfies this status.

        :param board: position to test.
        :type  board: Board
        :returns: membership flag.
        :rtype:   bool

        Examples
        --------
        >>> Board() in DRAW
        False
        >>> FEN = "r1bqkb1r/pppp1Qpp/2n2n2/4p3/2B1P3/8/PPPP1PPP/RNB1K1NR b KQkq - 0 4"
        >>> Board.from_fen(FEN) in CHECKMATE
        True
        """
        ...

    def __repr__(self) -> str: ...

    def __eq__(self, other : Any) -> bool: ...


#: The side to move is currently in check.
CHECK: BoardStatus
#: The side to move has no legal moves.
MATE: BoardStatus
#: Side to move has no legal moves, and is in check.
CHECKMATE: BoardStatus
#: Side to move has no legal moves, and is **not** in check.
STALEMATE: BoardStatus
#: Not enough material remains for either side to mate.
INSUFFICIENT_MATERIAL: BoardStatus
#: Fifty moves (plies) have passed without a pawn move or capture.
FIFTY_MOVE_TIMEOUT: BoardStatus
#: Seventy-five moves (plies) have passed without a pawn move or capture.
SEVENTY_FIVE_MOVE_TIMEOUT: BoardStatus
#: Same position has occurred three times with the same side to move.
THREEFOLD_REPETITION: BoardStatus
#: Same position has occurred five times with the same side to move.
FIVEFOLD_REPETITION: BoardStatus
#: Any condition that entitles a player to claim a draw.
DRAW: BoardStatus
#: Draw that the rules enforce automatically (e.g. 75-move, 5-fold, or
#: insufficient material) even if the player does not claim it.
FORCED_DRAW: BoardStatus
