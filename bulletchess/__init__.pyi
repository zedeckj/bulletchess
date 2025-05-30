from typing import Optional, Any, Collection, Iterator, overload, Union


class Color:

    """
    Represents either White or Black, used to identify the two players 
    and their pieces.
    """

    @staticmethod
    def from_str(name: str) -> "Color":
        """Return the color corresponding to *name* (case‑insensitive).
       
        :param str name: The string ``"white"`` or ``"black"`` in any case.
        :returns: The matching :class:`Color` instance.
        :rtype: Color
        :raises ValueError: If *name* is not recognized.
        
        >>> Color.from_str("White") is WHITE
        True
        >>> Color.from_str("BLACK") is BLACK
        True
        """
        ...

    @property
    def opposite(self) -> "Color": 
        """
        Gets the opposite :class:`Color` to this one. 

        :returns: The opposite :class:`Color` instance.
        :rtype: Color

        >>> WHITE.opposite is BLACK
        True
        >>> BLACK.opposite is WHITE
        True
        """
        ...

    def __str__(self) -> str:
        """
        Serializes a :class:`Color` to a ``str`` of its name in title case.

        :returns: A ``str`` of the :class:`Color`'s name
        
        >>> str(WHITE)
        "White"
        >>> str(BLACK)
        "Black"
        """
        ...

    def __invert__(self) -> "Color":
        """
        Alias for :attr:`Color.opposite`,  Allows ``~WHITE`` syntax."""
        ...

    def __hash__(self) -> int: ...
    def __repr__(self) -> str: ...
    def __eq__(self, other : Any) -> bool: ...
    

WHITE : Color 
"""
The white player
"""

BLACK : Color
"""
The black player
"""
class PieceType:

    """
    Represents one of the 6 types of pieces in chess, either a pawn, knight, bishop, rook, queen, or king.
    """


    @staticmethod
    def from_str(piece_type : str) -> "PieceType":
        """Return the piece type corresponding to *name* (case‑insensitive).

        :param str name: One of ``"pawn"``, ``"knight"``, ``"bishop"``,
                     ``"rook"``, ``"queen"`` or ``"king"`` (any case).
        :rtype: PieceType
        :returns: The matching :class:`PieceType`.
        :raises ValueError: If *name* is not recognized.

        >>> PieceType.from_str("pawn") is PAWN
        True
        >>> PieceType.from_str("kNiGhT") is KNIGHT
        True
        """
        ...


    def __str__(self) -> str:
        """
        Serializes a :class:`PieceType` to a ``str`` of its name in title case.

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

PAWN: PieceType
"""
The :class:`PieceType` for pawns
"""

KNIGHT: PieceType
"""
The :class:`PieceType` for knights
"""

BISHOP: PieceType
"""
The :class:`PieceType` for bishops
"""

ROOK: PieceType
"""
The :class:`PieceType` for rooks
"""

QUEEN: PieceType
"""
The :class:`PieceType` for queens
"""

KING: PieceType
"""
The :class:`PieceType` for kings
"""


PIECE_TYPES : list[PieceType] = [PAWN, KNIGHT, BISHOP, ROOK, QUEEN, KING]
"""
A list of all :class:`PieceType` values. In the order of ``[PAWN, KNIGHT, BISHOP, ROOK, QUEEN, KING]``
"""

class Piece:

    """
    Represents a piece with both a Color and a PieceType, such as a White Pawn, or a Black Rook. 
    """


    def __init__(self, color : Color, type : PieceType):
        """Initialize the ``Piece`` with *color* and *type*.

        :param Color color: The owning side.
        :param PieceType type: The intrinsic kind of the piece.
        """
        ...

    @staticmethod
    def from_chr(char : str) -> Piece:
        """Return the piece encoded by *char* (ASCII piece letter).

        Uppercase letters encode :data:`WHITE` pieces, lowercase letters encode :data:`BLACK`.

        :param str char: One of ``PRNBQKprnbqk``.
        :rtype: Piece
        :returns: The corresponding :class:`Piece`.
        :raises ValueError: If *char* is not a valid piece letter.
        
        >>> Piece.from_chr("P")
        <Piece: (White, Pawn)>
        >>> Piece.from_chr("n")
        <Piece: (Black, Knight)>
        """
        ...

    @property
    def piece_type(self) -> PieceType:
        """
        Gets the :class:`PieceType` of this :class:`Piece`.
        """
        ...

    @property
    def color(self) -> Color:
        """
        Gets the :class:`Color` of this :class:`Piece`.
        """
        ...

    def unicode(self) -> str:
        """
        Returns Unicode figurine character corresponding to this :class:`Piece`.

        >>> Piece(WHITE, PAWN).unicode()
        "♙"
        >>> Piece(BLACK, KNIGHT).unicode()
        "♞"
        """
        ...

    def __eq__(self, other : Any):
        """
        Evaluates to ``True`` when compared with another :class:`Piece` with the same :class:`PieceType` and :class:`Color`
        """
        ...

    def __str__(self) -> str:
        """
        Serializes a :class:`Piece` as a single ASCII character ``str``. Uses uppercase for any :class:`Piece` that is :data:`WHITE`, and lowercase for any :class:`Piece` that is :data:`BLACK`.

        >>> str(Piece(WHITE, PAWN))
        "P"
        >>> str(Piece(BLACK, KNIGHT))
        "n"
        """
        ...

    def __hash__(self) -> int: ...

class Square:

    """
    Represents one of the 64 squares on a chess board. 
    """

    @staticmethod
    def from_str(name : str) -> Square:
        """
        Return the :class:`Square` encoded by *name* (case‑insensitive).

        :param str name: The name of the square
        :rtype: Square
        :returns: The corresponding :class:`Square`
        :raises: :exc:`ValueError` if given a string which does not represent a Square
        
        >>> Square.from_string("E1") == E1
        True
        >>> Square.from_string("a2") == A2
        Tru
        """
        ...

    def bb(self) -> Bitboard: 
        """
        Creates a :class:`Bitboard` containing **only** this :class:`Square`. 

        >>> A1.bb() == Bitboard([A1])
        True
        >>> H3.bb() == Bitboard([H3])
        True
        """
        ...

    def adjacent(self) -> Bitboard: 
        """
        Creates a :class:`Bitboard` of all neighbors orthogonal or diagonal to this :class:`Square`.

        >>> A1.adjacent() == Bitboard([A2, B1, B2])
        True
        >>> E5.adjacent() == Bitboard([D4, D5, D6, E4, E6, F4, F5, F6])
        True
        """
        ...

    def north(self, distance: int = 1) -> Optional["Square"]:
        """
        Return the square that is the given *distance* number of ranks above this square.

        :param distance: how many ranks to move north.
        :returns: the target square, or ``None`` if it would be off the board.
        :rtype:   Square | None

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
        Return the square that is the given *distance* number of ranks below this square.

        :param distance: how many ranks to move south.
        :type  distance: int, default = 1
        :returns: the target square, or ``None`` if it would be off the board.
        :rtype:   Square | None

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
        Return the square that is the given *distance* number of files to the east of this square.

        :param distance: how many files to move east (toward the H-file).
        :type  distance: int, default = 1
        :returns: the target square, or ``None`` if it would be off the board.
        :rtype:   Square | None

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
        Return the square that is the given *distance* number of files to the west of this square.

        :param distance: how many files to move west (toward the A-file).
        :type  distance: int, default = 1
        :returns: the target square, or ``None`` if it would be off the board.
        :rtype:   Square | None

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
        Return the square that is the given *distance* number of files west and ranks north of this square.

        :param distance: number of steps to move north-west.
        :type  distance: int, default = 1
        :returns: the target square, or ``None`` if it would be off the board.
        :rtype:   Square | None

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
        Return the square that is the given *distance* number of files east and ranks north of this square.

        :param distance: number of steps to move north-east.
        :type  distance: int, default = 1
        :returns: the target square, or ``None`` if it would be off the board.
        :rtype:   Square | None

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
        Return the square that is the given *distance* number of files west and ranks south of this square.

        :param distance: number of steps to move south-west.
        :type  distance: int, default = 1
        :returns: the target square, or ``None`` if it would be off the board.
        :rtype:   Square | None

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
        Return the square that is the given *distance* number of files east and ranks south of this square.

        :param distance: number of steps to move south-east.
        :type  distance: int, default = 1
        :returns: the target square, or ``None`` if it would be off the board.
        :rtype:   Square | None

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

A1: Square
"""
The A1 :class:`Square`
"""

B1: Square
"""
The B1 :class:`Square`
"""

C1: Square
"""
The C1 :class:`Square`
"""

D1: Square
"""
The D1 :class:`Square`
"""

E1: Square
"""
The E1 :class:`Square`
"""

F1: Square
"""
The F1 :class:`Square`
"""

G1: Square
"""
The G1 :class:`Square`
"""

H1: Square
"""
The H1 :class:`Square`
"""

A2: Square
"""
The A2 :class:`Square`
"""

B2: Square
"""
The B2 :class:`Square`
"""

C2: Square
"""
The C2 :class:`Square`
"""

D2: Square
"""
The D2 :class:`Square`
"""

E2: Square
"""
The E2 :class:`Square`
"""

F2: Square
"""
The F2 :class:`Square`
"""

G2: Square
"""
The G2 :class:`Square`
"""

H2: Square
"""
The H2 :class:`Square`
"""

A3: Square
"""
The A3 :class:`Square`
"""

B3: Square
"""
The B3 :class:`Square`
"""

C3: Square
"""
The C3 :class:`Square`
"""

D3: Square
"""
The D3 :class:`Square`
"""

E3: Square
"""
The E3 :class:`Square`
"""

F3: Square
"""
The F3 :class:`Square`
"""

G3: Square
"""
The G3 :class:`Square`
"""

H3: Square
"""
The H3 :class:`Square`
"""

A4: Square
"""
The A4 :class:`Square`
"""

B4: Square
"""
The B4 :class:`Square`
"""

C4: Square
"""
The C4 :class:`Square`
"""

D4: Square
"""
The D4 :class:`Square`
"""

E4: Square
"""
The E4 :class:`Square`
"""

F4: Square
"""
The F4 :class:`Square`
"""

G4: Square
"""
The G4 :class:`Square`
"""

H4: Square
"""
The H4 :class:`Square`
"""

A5: Square
"""
The A5 :class:`Square`
"""

B5: Square
"""
The B5 :class:`Square`
"""

C5: Square
"""
The C5 :class:`Square`
"""

D5: Square
"""
The D5 :class:`Square`
"""

E5: Square
"""
The E5 :class:`Square`
"""

F5: Square
"""
The F5 :class:`Square`
"""

G5: Square
"""
The G5 :class:`Square`
"""

H5: Square
"""
The H5 :class:`Square`
"""

A6: Square
"""
The A6 :class:`Square`
"""

B6: Square
"""
The B6 :class:`Square`
"""

C6: Square
"""
The C6 :class:`Square`
"""

D6: Square
"""
The D6 :class:`Square`
"""

E6: Square
"""
The E6 :class:`Square`
"""

F6: Square
"""
The F6 :class:`Square`
"""

G6: Square
"""
The G6 :class:`Square`
"""

H6: Square
"""
The H6 :class:`Square`
"""

A7: Square
"""
The A7 :class:`Square`
"""

B7: Square
"""
The B7 :class:`Square`
"""

C7: Square
"""
The C7 :class:`Square`
"""

D7: Square
"""
The D7 :class:`Square`
"""

E7: Square
"""
The E7 :class:`Square`
"""

F7: Square
"""
The F7 :class:`Square`
"""

G7: Square
"""
The G7 :class:`Square`
"""

H7: Square
"""
The H7 :class:`Square`
"""

A8: Square
"""
The A8 :class:`Square`
"""

B8: Square
"""
The B8 :class:`Square`
"""

C8: Square
"""
The C8 :class:`Square`
"""

D8: Square
"""
The D8 :class:`Square`
"""

E8: Square
"""
The E8 :class:`Square`
"""

F8: Square
"""
The F8 :class:`Square`
"""

G8: Square
"""
The G8 :class:`Square`
"""

H8: Square
"""
The H8 :class:`Square`
"""


SQUARES : list[Square] = [A1, B1, C1, D1, E1, F1, G1, H1, A2, B2, ..., H8]
"""
Every defined :class:`Square`, in the order of ``[A1, B1, C1, D1, E1, F1, G1, H1, A2, B2, ..., H8]``.
"""


SQUARES_FLIPPED : list[Square] = [A8, B8, C8, D8, E8, F8, G8, H8, A7, B7, ..., H1]
"""
Every defined :class:`Square`, but flipped to be in the order of ``[A8, B8, C8, D8, E8, F8, G8, H8, A7, B7, ..., H1]``.
"""


"""
A list of all Squares
"""
class Bitboard:
    """
    A set of squares represented as a 64-bit integer, where each bit
    indicates whether a :class:`Square` is included.
    """

    def __init__(self, squares: Collection[Square]):
        """
        Initialize a :class:`Bitboard` that contains *squares*.

        :param squares: squares to include in the new bitboard.
        :type  squares: Collection[Square]
        """
        ...

    def __str__(self) -> str:
        """
        Return a ``str`` in which included squares are shown as ``1`` and
        excluded squares as ``0``.

        :returns: an 8×8 grid row-major from A8 to H1.
        :rtype:   str

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
        Construct a :class:`Bitboard` from its integer encoding (see :py:meth:`__int__`).

        :param value: 64-bit integer to convert.
        :type  value: int
        :returns: new bitboard corresponding to *value*.
        :rtype:   Bitboard
        :raises OverflowError: if ``value < 0`` or ``value >= 2 ** 64``

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
        Return the integer encoding of this :class:`Bitboard`.

        :returns: 64-bit integer with one bit per square.
        :rtype:   int

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
        Return ``True`` if *square* is in this :class:`Bitboard`.

        :param square: square to query.
        :type  square: Square
        :returns: membership flag.
        :rtype:   bool

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
        Remove *square* from the :class:`Bitboard`.

        :param square: square to delete.
        :type  square: Square

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
        Test whether *square* is in this :class:`Bitboard`.

        :param square: square to test.
        :type  square: Square
        :returns: membership flag.
        :rtype:   bool

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
        Return ``True`` if *other* is a :class:`Bitboard` with the same squares.

        :param other: bitboard to compare.
        :type  other: Any
        :returns: equality flag.
        :rtype:   bool

        >>> Bitboard([A1, A2, A3, A4, A5, A6, A7, A8]) == A_FILE
        True
        >>> Bitboard([C4]) == Bitboard([C3])
        False
        """
        ...

    def __invert__(self) -> "Bitboard":
        """
        Return the complement of this :class:`Bitboard`.

        :returns: new bitboard with opposite membership.
        :rtype:   Bitboard

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

        >>> Bitboard([A1]) ^ Bitboard([A1, A2]) == Bitboard([A2])
        True
        >>> LIGHT_SQUARE_BB ^ DARK_SQUARE_BB == FULL_BB
        True
        """
        ...

    def __bool__(self) -> bool:
        """
        Return ``True`` if the :class:`Bitboard` is non-empty.

        :returns: truth value.
        :rtype:   bool

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


RANK_1: Bitboard
"""
:class:`Bitboard` containing every square on Rank 1
"""

RANK_2: Bitboard
"""
:class:`Bitboard` containing every square on Rank 2
"""

RANK_3: Bitboard
"""
:class:`Bitboard` containing every square on Rank 3
"""

RANK_4: Bitboard
"""
:class:`Bitboard` containing every square on Rank 4
"""

RANK_5: Bitboard
"""
:class:`Bitboard` containing every square on Rank 5
"""

RANK_6: Bitboard
"""
:class:`Bitboard` containing every square on Rank 6
"""

RANK_7: Bitboard
"""
:class:`Bitboard` containing every square on Rank 7
"""

RANK_8: Bitboard
"""
:class:`Bitboard` containing every square on Rank 8
"""

RANKS: list[Bitboard] = [RANK_1, RANK_2, RANK_3, RANK_4,
                         RANK_5, RANK_6, RANK_7, RANK_8]
"""
List of the eight rank :class:`Bitboard` values in order, from :data:`RANK_1` to :data:`RANK_8`.
"""

A_FILE: Bitboard
"""
:class:`Bitboard` containing every square on the A-file.
"""

B_FILE: Bitboard
"""
:class:`Bitboard` containing every square on the B-file.
"""

C_FILE: Bitboard
"""
:class:`Bitboard` containing every square on the C-file.
"""

D_FILE: Bitboard
"""
:class:`Bitboard` containing every square on the D-file.
"""

E_FILE: Bitboard
"""
:class:`Bitboard` containing every square on the E-file.
"""

F_FILE: Bitboard
"""
:class:`Bitboard` containing every square on the F-file
"""

G_FILE: Bitboard
"""
:class:`Bitboard` containing every square on the G-file.
"""

H_FILE: Bitboard
"""
:class:`Bitboard` containing every square on the H-file.
"""

FILES: list[Bitboard] = [A_FILE, B_FILE, C_FILE, D_FILE,
                         E_FILE, F_FILE, G_FILE, H_FILE]
"""
List of the eight file :class:`Bitboard` values in order, from :data:`A_FILE` to :data:`H_FILE`.
"""

FULL_BB: Bitboard
"""
:class:`Bitboard` containing all 64 squares
"""

EMPTY_BB: Bitboard
"""
:class:`Bitboard` containing no squares
"""

LIGHT_SQUARE_BB: Bitboard
"""
:class:`Bitboard` of all light colored squares (B1, D1, etc.)
"""

DARK_SQUARE_BB: Bitboard
"""
:class:`Bitboard` of all dark colored squares (A1, C1, etc.)
"""
class CastlingType:
    """
    One of four legal castling options: the king moves either kingside or
    queenside for :data:`WHITE` or :data:`BLACK`.
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




WHITE_KINGSIDE: CastlingType
"""
Castling type representing :data:`WHITE` kingside castling.
"""

WHITE_QUEENSIDE: CastlingType
"""
Castling type representing :data:`WHITE` queenside castling.
"""

BLACK_KINGSIDE: CastlingType
"""
Castling type representing :data:`BLACK` kingside castling.
"""

BLACK_QUEENSIDE: CastlingType
"""
Castling type representing :data:`BLACK` queenside castling.
"""
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

        :param Square origin: square the piece starts on.
        :param Square destination: square the piece ends on.
        :param PieceType | None promote_to: piece type to promote to, if any.

        :raises: :exc:`ValueError` if the specified origin, destination, and promtion is illegal for every piece for every position.
        """
        ...


    @staticmethod
    def castle(castling_type: CastlingType) -> "Move":
        """
        Return the move corresponding to *castling_type*.

        :param CastlingType castling_type: one of the four castling constants.
        :returns: appropriate king move for that castling.
        :rtype:   Move

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
        Parse a UCI long-algebraic ``str`` and build a move. 

        Null moves are supported as "0000", and are represented as ``None``.

        :param uci: UCI string such as ``"e2e4"`` or ``"b7b8q"``.
        :type  uci: str
        :returns: move instance, or ``None`` for a null move.
        :rtype:   Move | None
        :raises ValueError: if *uci* is malformed or illegal.

        >>> Move.from_uci("e2e4") == Move(E2, E4)
        True
        >>> Move.from_uci("a1d4") == Move(A1, D4)
        True
        >>> Move.from_uci("b7b8q") == Move(B7, B8, promote_to=QUEEN)
        True
        >>> Move.from_uci("0000") is None
        True
        """
        ...

    @staticmethod
    def from_san(san: str, board: "Board") -> "Move":
        """
        Parse a SAN ``str`` in the context of *board*.

        :param str san: SAN text (e.g. ``"Nf6"``, ``"O-O"``, ``"e4"``).
        :param Board board: position used to disambiguate the SAN.
        :returns: the corresponding move.
        :rtype:   Move
        :raises ValueError: if *san* is invalid for *board*.

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

        :param Board board: position that provides context.
        :returns: SAN string.
        :rtype:   str
        :raises ValueError: if the move is illegal for *board*.

        >>> Move(E2, E4).san(Board())
        'e4'
        >>> FEN = "r1bqkb1r/pppp1ppp/2n2n2/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 4 4"
        >>> Move(E1, G1).san(Board.from_fen(FEN))
        'O-O'
        """
        ...

    def uci(self) -> str:
        """
        Return a ``str`` of the UCI long algebraic notation representation of this move.

        :returns: UCI string.
        :rtype:   str

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
        Alias for :func:`Move.uci`.

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
        The :class:`Square` the piece moves from.

        >>> Move(E2, E4).origin is E2
        True
        >>> Move.from_uci("a1d4").origin is A1
        True
        """
        ...

    @property
    def destination(self) -> Square:
        """
        The :class:`Square` the piece moves to.

        >>> Move(E2, E4).destination is E4
        True
        >>> Move.from_uci("a1d4").destination is D4
        True
        """
        ...

    @property
    def promotion(self) -> Optional[PieceType]:
        """
        Promotion :class:`PieceType`, or ``None`` for a non-promotion.

        >>> Move.from_uci("b7b8q").promotion is QUEEN
        True
        >>> Move(E2, E4).promotion is None
        True
        """
        ...

    def is_promotion(self) -> bool:
        """
        Return ``True`` if the move is a promotion.

        >>> Move.from_uci("b7b8q").is_promotion()
        True
        >>> Move(E2, E4).is_promotion()
        False
        """
        ...

    def is_capture(self, board: "Board") -> bool:
        """
        Return ``True`` if the move captures a piece on *board*.

        :param Board board: position to check if this is a capture.
        :returns: capture flag.
        :rtype:   bool

        >>> FEN = "r1bqkbnr/pppp1ppp/2n5/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R w KQkq - 2 3"
        >>> board = Board.from_fen(FEN)
        >>> Move(F3, E5).is_capture(board)
        True
        """
        ...

    def is_castling(self, board: "Board") -> bool:
        """
        Return ``True`` if the move is a legal castling move on *board*.

        :param Board board: position to check if this is a castling move.
        :returns: castling flag.
        :rtype:   bool

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

        :param Board board: position used for classification.
        :returns: corresponding castling type or ``None``.
        :rtype:   CastlingType | None

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
        promotion value.

        :param other: object to compare.
        :type  other: Any
        :returns: equality flag.
        :rtype:   bool

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
        Initialize the object with *castling_types*.

        :param Collection[CastlingType] castling_types: iterable of castling constants to include.
        """
        ...

    @staticmethod
    def from_fen(castling_fen: str) -> "CastlingRights":
        """
        Build a :class:`CastlingRights` object from a FEN castling field.

        :param str castling_fen: ``"KQkq"``, ``"KQ"``, ``"-"`` …
        :returns: rights object matching *castling_fen*.
        :rtype:   CastlingRights
        :raises ValueError: if *castling_fen* is not valid FEN.

        >>> CastlingRights.from_fen("KQkq") == ALL_CASTLING
        True
        >>> CastlingRights.from_fen("Qk") == CastlingRights([WHITE_QUEENSIDE, BLACK_KINGSIDE])
        True
        >>> CastlingRights.from_fen("-") == NO_CASTLING
        True
        """
        ...


    def fen(self) -> str:
        """
        
        Returns the Forsyth-Edwards Notation ``str`` represetnation of this :class:`CastlingRights`.

        :returns: ``"KQkq"``, ``"-"`` or similar.
        :rtype:   str

        >>> NO_CASTLING.fen()
        '-'
        >>> CastlingRights([WHITE_KINGSIDE, WHITE_QUEENSIDE]).fen()
        'KQ'
        >>> ALL_CASTLING.fen()
        'KQkq'
        """
        ...

    def __contains__(self, castling_type: CastlingType) -> bool:
        """
        Return ``True`` if *castling_type* is present.

        :param CastlingType castling_type: entry to test.
        :returns: membership flag.
        :rtype:   bool

        >>> WHITE_KINGSIDE in ALL_CASTLING
        True
        >>> BLACK_KINGSIDE in CastlingRights([WHITE_QUEENSIDE])
        False
        """
        ...

    def __iter__(self) -> Iterator[CastlingType]:
        """
        Iteratator over included :class:`CastlingType` values
        """
        ...

    def __len__(self) -> int:
        """
        The number of castling types included
        """


    def __bool__(self) -> "CastlingRights":
        """
        Returns ``True`` if **any** castling rights are present, alias for :func:`CastlingRights.any()`
        """
        ...    

    def __add__(self, other: "CastlingRights") -> "CastlingRights":
        """
        Return the union of two castling-rights sets.

        :param CastlingRights other: rights to add.
        :returns: combined rights.
        :rtype:   CastlingRights

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

        >>> CastlingRights.from_fen("KQ") <= CastlingRights.from_fen("KQkq")
        True
        >>> CastlingRights.from_fen("KQkq") <= CastlingRights.from_fen("KQkq")
        True
        """
        ...

    def __lt__(self, other: "CastlingRights") -> bool:
        """
        Return ``True`` if this set is a **strict** subset of *other*.

        >>> CastlingRights.from_fen("KQ") < CastlingRights.from_fen("KQkq")
        True
        >>> CastlingRights.from_fen("KQkq") < CastlingRights.from_fen("KQkq")
        False
        """
        ...

    def __gt__(self, other: "CastlingRights") -> bool:
        """
        Return ``True`` if this set is a **strict** superset of *other*.


        >>> CastlingRights.from_fen("KQkq") > CastlingRights.from_fen("KQ")
        True
        >>> CastlingRights.from_fen("KQkq") > CastlingRights.from_fen("KQkq")
        False
        """
        ...

    def __ge__(self, other: "CastlingRights") -> bool:
        """
        Return ``True`` if this set is a superset of, or equal to, *other*.

        >>> CastlingRights.from_fen("KQkq") >= CastlingRights.from_fen("KQ")
        True
        >>> CastlingRights.from_fen("KQkq") >= CastlingRights.from_fen("KQkq")
        True
        """
        ...


    def __str__(self) -> str:
        """
        
        Alias for :func:`CastlingRights.fen`

        :returns: ``"KQkq"``, ``"-"`` or similar.
        :rtype:   str

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

        :param Color | None color: optionally restrict the check to :data:`WHITE` or :data:`BLACK`.
        :returns: completeness flag.
        :rtype:   bool

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
        Return ``True`` if any castling right is present.

        :param Color | None color: optionally restrict the check to :data:`WHITE` or :data:`BLACK`.
        :returns: presence flag.
        :rtype:   bool

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

        :param Color | None color: optionally restrict the check to :data:`WHITE` or :data:`BLACK`.
        :returns: kingside flag.
        :rtype:   bool

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

        :param Color | None color: optionally restrict the check to :data:`WHITE` or :data:`BLACK`.
        :returns: queenside flag.
        :rtype:   bool

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



ALL_CASTLING : CastlingRights
"""
Castling rights which include all types of castling
"""

NO_CASTLING : CastlingRights
"""
Castling rights which include no types of castling
"""

class Board:

    """
    A mutable chess position.

    A :class:`Board` represents a configuration of chess pieces as a mapping of each :class:`Square` to optional an :class:`Piece`. 
    The :class:`Board` class includes attributes for :class:`CastlingRights`, the existence of an en-passant :class:`Square`, and the :class:`Color` for the turn of the current player.
    Also holds the half-move clock and full-move number each as an ``int``. 

    The :class:`Board` class provides an interface for generating :class:`Move` objects representing legal actions for a turn, 
    as well as applying and undoing these moves. 

    """

    def __init__(self):
        """
        Initializes a :class:`Board` representing the starting position.
        """
        ...

    @staticmethod
    def from_fen(fen : str) -> "Board":
        """
        Build a board from a ``str`` of a Forsyth-Edwards Notation (FEN) representation of a position.

        The FEN is not required to include a halfmove clock or fullmove number. The default values for these are 0 and 1.
   
        :param fen: full FEN record.
        :type  fen: str
        :returns: board represented by *fen*.
        :rtype:   Board
        :raises ValueError: if *fen* is malformed.

        >>> board = Board.from_fen("rnbqkbnr/pp1ppppp/8/2p5/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq - 1 2")
        >>> print(board)
        r n b q k b n r 
        p p - p p p p p 
        - - - - - - - - 
        - - p - - - - - 
        - - - - P - - - 
        - - - - - N - - 
        P P P P - P P P 
        R N B Q K B - R 

        """
        ...

    @staticmethod
    def empty() -> "Board":
        """
        Creates a completely empty :class:`Board`, with no pieces on it.

        :returns: An empty position
        :rtype: :class:``Board``
        """
        ...


    @property
    def turn(self) -> Color:
        """
        Side to move, either :data:`WHITE` or :data:`BLACK`.
        """
        ...

    @property
    def halfmove_clock(self) -> int:
        """
        Gets the current halfmove clock as an ``int``. This represents the number of ply that have passed since a
        capture or pawn advance.
        """
        ...

    @property
    def fullmove_number(self) -> int:
        """
        Gets the current fullmove number as an ``int``. This represents the total number of turns each player has taken
        since the start of a game.
        """
        ...

    @property
    def en_passant_square(self) -> Optional[Square]:
        """
        Gets the current en passant :class:`Square`, if it exists. Otherwise returns ``None``.
        """
        ...

    @property
    def castling_rights(self) -> CastlingRights:
        """
        Gets the current :class:`CastlingRights` of this :class:`Board`.
        """
        ...

    @castling_rights.setter
    def castling_rights(self, castling_rights : CastlingRights) -> None:
        """
        Sets this :class:`Board`'s :class:`CastlingRights` to the given value. 

        :raises: :exc:`ValueError` if the given :class:`CastlingRights` are illegal for this :class:`Board`'s position.
        """
        ...

    @turn.setter
    def turn(self, new_turn : Color) -> None:
        """
        Sets this :class:`Board`'s turn to the specified :class:`Color`.
        """

    @halfmove_clock.setter
    def halfmove_clock(self, new_halfmove_clock : int) -> None:
        """
        Sets this :class:`Board`'s halfmove clock to the provided ``int``.

        :raises: :exc:`OverflowError` if the provided ``int`` value is greater or equal to ``2 ** 64``
        """
        ...

    @fullmove_number.setter
    def fullmove_number(self, new_fullmove_number : int) -> None:
        """
        Sets this :class:`Board`'s fullmove number to the provided ``int``.

        :raises: :exc:`OverflowError` if the provided ``int`` value is greater or equal to ``2 ** 64``
        """
        ...

    @en_passant_square.setter
    def en_passant_square(self, new_ep_square : Optional[Square]) -> None:
        """
        Sets this :class:`Board`'s en passant :class:`Square` to the provided value. Cleares the en passant :class:`Square` if given ``None``

        :raises: :exc:`ValueError` If the specified :class:`Square` could not be one that a Pawn has just passed over in an intial two square advance.
        """
        ...

    def legal_moves(self) -> list[Move]:
        """
        Generates a ``list`` of legal :class:`Move` objects for this :class:`Board`'s position. 

        :returns: A list of legal moves for this position.
        :rtype: `list[Move]`

        >>> Board().legal_moves()
        [<Move: b1a3>, <Move: b1c3>, <Move: g1f3>, <Move: g1h3>, <Move: a2a3>, <Move: a2a4>, <Move: b2b3>, <Move: b2b4>, <Move: c2c3>, <Move: c2c4>, <Move: d2d3>, <Move: d2d4>, <Move: e2e3>, <Move: e2e4>, <Move: f2f3>, <Move: f2f4>, <Move: g2g3>, <Move: g2g4>, <Move: h2h3>, <Move: h2h4>]
        """
        ...

    def apply(self, move : Optional[Move]) -> None:
        """
        Applies the given :class:`Move` to this :class:`Board`.
         
        The :class:`Move` argument is not checked to be legal outside of checking if the origin has a Piece. ``None`` can be passed as the argument to skip a turn.   

        :param move: The move to apply, or ``None`` for a null move.
        :type  move: Move | None
        :raises ValueError: if the origin of *move* does not have a piece.

        >>> board = Board()
        >>> board.apply(Move(E2, E4))
        >>> print(board)
        r n b q k b n r 
        p p p p p p p p 
        - - - - - - - - 
        - - - - - - - - 
        - - - - P - - - 
        - - - - - - - - 
        P P P P - P P P 
        R N B Q K B N R 

        :raises: :exc:`ValueError` if the given :class:`Move`'s origin is an empty square.
        """
        ...

    def undo(self) -> Optional[Move]: 
        """
        Undoes the last :class:`Move` applied to this :class:`Board`.

        :returns: The last move applied to this board.
        :rtype: Move | None
        :raises: :exc:`AttributeError` if there are no moves to undo. This is true when :attr:`Board.history` has a `len()` of `0`

        >>> board = Board()
        >>> board.apply(Move(E2, E4))
        >>> board.apply(Move(E7, E5))
        >>> board.undo() == Move(E7, E5)
        True
        >>> print(board)
        r n b q k b n r 
        p p p p p p p p 
        - - - - - - - - 
        - - - - - - - - 
        - - - - P - - - 
        - - - - - - - - 
        P P P P - P P P 
        R N B Q K B N R 

        :raises: :exc:`AttributeError` if there are no moves to undo.
        """
        ...

    def fen(self) -> str:
        """
        Gets the Forsyth-Edwards Notation representation as a ``str`` of this :class:`Board`.

        :returns: A FEN representing the position
        :rtype: ``str``


        >>> board = Board()
        >>> board.fen()
        'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
        """
        ...

    def copy(self) -> "Board":
        """
        Returns a new :class:`Board` which is an exact copy of this :class:`Board`, including its :class:`Move` history.

        :returns: A deep copy of this position and its state.
        :rtype: :class:`Board`
        """
        ...


    #@overload
    #def __getitem__(self, item): ...

    @overload
    def __getitem__(self, none : None) -> Bitboard: ...

    @overload
    def __getitem__(self, square : Square) -> Optional[Piece]: ...

    @overload
    def __getitem__(self, piece_type : PieceType) -> Bitboard: ...

    @overload
    def __getitem__(self, color : Color) -> Bitboard: ...

    @overload
    def __getitem__(self, piece : Piece) -> Bitboard: ...

    @overload
    def __getitem__(self, piece_tuple : tuple[Color, PieceType]) -> Bitboard: ...
            

    def __getitem__(self, index):
        """
        Index a :class:`Board` with a value. Can either index with a :class:`Square`, ``None``, a :class:`PieceType`, a :class:`Color`, a ``tuple[Color, PieceType]``, or a :class:`Piece`,

        If given a :class:`Square`, returns the :class:`Piece` at the square, or ``None`` if the square is unoccupied.
        
        >>> board = Board()
        >>> board[E2] is Piece(WHITE, PAWN)
        True
        >>> board[E4] is None
        True
        

        If given ``None``, returns a :class:`Bitboard` of all empty squares.

        >>> board = Board()
        >>> print(board[None])
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        1 1 1 1 1 1 1 1 
        1 1 1 1 1 1 1 1 
        1 1 1 1 1 1 1 1 
        1 1 1 1 1 1 1 1 
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 

        If given a :class:``Color``, returns a :class:`Bitboard` of all squares with a piece of that color
        
        >>> board = Board()
        >>> print(board[WHITE])
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        1 1 1 1 1 1 1 1 
        1 1 1 1 1 1 1 1 

        If given a :class:``PieceType``, returns a :class:`Bitboard` of all squares with a piece of that type.
        
        >>> board = Board()
        >>> print(board[PAWN])
        0 0 0 0 0 0 0 0 
        1 1 1 1 1 1 1 1 
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        1 1 1 1 1 1 1 1 
        0 0 0 0 0 0 0 0 

        If given a :class:`Piece` or a tuple of a :class:`Color` and a :class:`PieceType`, returns a :class:`Bitboard` of all squares with matching pieces.
        
        >>> board = Board()
        >>> board[WHITE, PAWN] == board[Piece(WHITE, PAWN)]
        True
        >>> print(board[WHITE, PAWN])
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        0 0 0 0 0 0 0 0 
        1 1 1 1 1 1 1 1 
        0 0 0 0 0 0 0 0 
        """
        ...

    def __setitem__(self, square : Square, piece : Optional[Piece]):
        """
        Sets this :class:`Board` to have the given :class:`Piece` and the indexed :class:`Square` . 
        If set to ``None``, the :class:`Square` becomes empty.

        >>> board = Board()
        >>> board[E2] = None
        >>> board[E4] = Piece(WHITE, PAWN)
        >>> print(board)
        r n b q k b n r 
        p p p p p p p p 
        - - - - - - - - 
        - - - - - - - - 
        - - - - P - - - 
        - - - - - - - - 
        P P P P - P P P 
        R N B Q K B N R 
        """
        ...

    def __delitem__(self, square : Square):
        """
        Deletes any :class:`Piece` at the specified :class:`Square`, leaving the :class:`Square` empty.

        >>> board = Board()
        >>> del board[E2]
        >>> print(board)
        r n b q k b n r 
        p p p p p p p p 
        - - - - - - - - 
        - - - - - - - - 
        - - - - - - - - 
        - - - - - - - - 
        P P P P - P P P 
        R N B Q K B N R 
        """
        ...

    def __eq__(self, other : Any) -> bool:
        """
        Returns ``True`` if compared with another :class:`Board` with the same mapping of :class:`Square` to :class:`Piece` objects,
        equvilent :class:`CastlingRights`, en-passant :class:`Square` values, and halfmove and fullmove clocks.

        To check if two :class:`Board` instances are "legally" equal, as in in terms of all of the above besides the halfmove
        and fullmove clocks, use :func:`utils.legally_equal`

        Two boards may be considered equal despite having different move histories.
        """
        ...

    def __hash__(self) -> int:
        """
        Performs a `Zobrist hash <https://www.chessprogramming.org/Zobrist_Hashing>`_ of this Board.
        """
        ...
    
    def __contains__(self, piece : Optional[Piece]) -> bool:
        """
        Returns ``True`` if this :class:`Board` has the specified :class:`Piece`. When given ``None``, returns ``True`` if there
        are any empy squares.
        """
        ...

    @property
    def history(self) -> list[Move]:
        """
        Gets a ``list`` of :class:`Move` objects of every :class:`Move` which have been used with :class:`Board.apply()` and have not 
        been undone with :func:`Board.undo()` for this :class:`Board` 

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
        Returns an ASCII ``str`` representation of this :class:`Board`.

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

    def _repr_html_(self) -> str:
        """
        Creates an HTML representation of this :class:`Board`.
        """
        ...

    def pretty(self, 
               color_scheme : Board.ColorScheme = Board.OAK,
               highlighted_squares : Bitboard = EMPTY_BB,
               targeted_squares : Bitboard = EMPTY_BB) -> str:
        """
        A pretty to-string method for terminal outputs.

        Creates a ``str`` representation of this :class:`Board` using Unicode chess figurines and the provided :class:`Board.ColorScheme` as a palette
        for the background and highlights. :class:`Bitboard`'s can be specified for highlighting particular squares, as for example a :class:`Move`'s origin, 
        as well as for targetting certain squares, as for possible :class:`Move` destinations.

        :returns: A rendering of this position as a UTF-8 string with ``ANSI`` color codes
        :rtype: ``str``


        """
        ...

    class ColorScheme:

        """
        A pallete of colors to be used with :func:`Board.pretty()` to stylize printed 
        boards.
        """


    LAGOON : ColorScheme
    """
    A light blue color pallete
    """

    SLATE : ColorScheme
    """
    A slightly purplish, grey color pallete
    """

    OAK : ColorScheme
    """
    A classical, wood styled color pallete
    """

    WALNUT: ColorScheme
    """
    A less saturated wood styled color pallete 
    """

    GREEN : ColorScheme
    """
    A familiar green and white color pallete
    """


    ROSE : ColorScheme
    """
    A pinkish red color pallete
    """


    CLAY : ColorScheme
    """
    A dulled, rosy brown and grey color pallete
    """

    STEEL : ColorScheme
    """
    A monochromatic grey color pallete
    """

class BoardStatus:

    """
    A predicate-like object that answers the question *“is this board in
    status X?”*  Examples of statuses include check, check-mate,
    stalemate, and repetition or 50-move draw claims.
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
        >>> board = Board.from_fen(FEN)
        >>> print(board)
        r - b q k b - r 
        p p p p - Q p p 
        - - n - - n - - 
        - - - - p - - - 
        - - B - P - - - 
        - - - - - - - - 
        P P P P - P P P 
        R N B - K - N R 

        >>> board in CHECKMATE
        True
        """
        ...

    def __repr__(self) -> str: ...

    def __eq__(self, other : Any) -> bool: ...



CHECK: BoardStatus
"""
The side to move is in check
"""


MATE: BoardStatus
"""
The side to move has no legal moves.
"""


CHECKMATE: BoardStatus
"""
The side to move is in checkmate. The player is in check and has no legal moves.
"""

STALEMATE: BoardStatus
"""
The side to move is in stalemate. The player has no legal moves but is *not* in check.
"""

INSUFFICIENT_MATERIAL: BoardStatus
"""
There is not enough material for either player to be placed in checkmate.
"""


FIFTY_MOVE_TIMEOUT: BoardStatus
"""
Fifty full-moves have passed without a pawn move or capture.
"""

SEVENTY_FIVE_MOVE_TIMEOUT: BoardStatus
"""
Seventy five full-moves have passed without a pawn move or capture.
"""

THREEFOLD_REPETITION: BoardStatus
"""
The same position has occured at least three times.
"""

FIVEFOLD_REPETITION: BoardStatus
"""
The same position has occured at least five times.
"""

DRAW: BoardStatus
"""
Any position in which a player may claim a draw. 
This includes stalemate, insufficient material, a fifty move timeout, or threefold repetition.
"""

FORCED_DRAW: BoardStatus
"""
A forced draw. This includes stalemate, insufficient material, a seventy five move timeout, or fivefold repetition.
"""
