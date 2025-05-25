# Main Documentation

### *class* Color

Represents either White or Black, used to identify the two players 
and their pieces.

#### *static* from_str(name: str) → [Color](#bulletchess.main.Color)

Return the colour corresponding to *name* (case‑insensitive).

* **Parameters:**
  **name** (*str*) – The string `"white"` or `"black"` in any case.
* **Returns:**
  The matching [`Color`](#bulletchess.main.Color) instance.
* **Return type:**
  [Color](#bulletchess.main.Color)
* **Raises:**
  **ValueError** – If *name* is not recognised.

```pycon
>>> Color.from_str("White") is WHITE
True
>>> Color.from_str("BLACK") is BLACK
True
```

#### *property* opposite *: [Color](#bulletchess.main.Color)*

Gets the opposite [`Color`](#bulletchess.main.Color) to this one.

* **Returns:**
  The opposite [`Color`](#bulletchess.main.Color) instance.
* **Return type:**
  [Color](#bulletchess.main.Color)

```pycon
>>> WHITE.opposite is BLACK
True
>>> BLACK.opposite is WHITE
True
```

#### \_\_str_\_() → str

Serializes a [`Color`](#bulletchess.main.Color) to a `str` of its name in title case.

* **Returns:**
  A `str` of the [`Color`](#bulletchess.main.Color)’s name

```pycon
>>> str(WHITE)
"White"
>>> str(BLACK)
"Black"
```

#### \_\_invert_\_() → [Color](#bulletchess.main.Color)

Alias for [`Color.opposite`](#bulletchess.main.Color.opposite),  Allows `~WHITE` syntax.

#### \_\_hash_\_() → int

#### \_\_repr_\_() → str

#### \_\_eq_\_(other: Any) → bool

### WHITE *: [Color](#bulletchess.main.Color)*

The white player

### BLACK *: [Color](#bulletchess.main.Color)*

The black player

### *class* PieceType

Represents one of the 6 types of pieces in chess, either a Pawn, Knight, Bishop, Rook, Queen, or King.

#### *static* from_str(piece_type: str) → [PieceType](#bulletchess.main.PieceType)

Return the piece type corresponding to *name* (case‑insensitive).

* **Parameters:**
  **name** (*str*) – One of `"pawn"`, `"knight"`, `"bishop"`,
  `"rook"`, `"queen"` or `"king"` (any case).
* **Return type:**
  [PieceType](#bulletchess.main.PieceType)
* **Returns:**
  The matching [`PieceType`](#bulletchess.main.PieceType).
* **Raises:**
  **ValueError** – If *name* is not recognised.

```pycon
>>> PieceType.from_str("pawn") is PAWN
True
>>> PieceType.from_str("kNiGhT") is KNIGHT
True
```

#### \_\_str_\_() → str

Serializes a [`PieceType`](#bulletchess.main.PieceType) to a `str` of its name in title case.

```pycon
>>> str(PAWN)
"Pawn"
>>> str(BISHOP)
"Bishop"
```
```

#### \_\_repr_\_() → str

#### \_\_eq_\_(other: Any) → bool

#### \_\_hash_\_() → int

### PAWN *: [PieceType](#bulletchess.main.PieceType)*

The [`PieceType`](#bulletchess.main.PieceType) for pawns

### KNIGHT *: [PieceType](#bulletchess.main.PieceType)*

The [`PieceType`](#bulletchess.main.PieceType) for knights

### BISHOP *: [PieceType](#bulletchess.main.PieceType)*

The [`PieceType`](#bulletchess.main.PieceType) for bishops

### ROOK *: [PieceType](#bulletchess.main.PieceType)*

The [`PieceType`](#bulletchess.main.PieceType) for rooks

### QUEEN *: [PieceType](#bulletchess.main.PieceType)*

The [`PieceType`](#bulletchess.main.PieceType) for queens

### KING *: [PieceType](#bulletchess.main.PieceType)*

The [`PieceType`](#bulletchess.main.PieceType) for kings

### PIECE_TYPES *: list[[PieceType](#bulletchess.main.PieceType)]*

A list of all [`PieceType`](#bulletchess.main.PieceType) values. In order of `[PAWN, KNIGHT, BISHOP, ROOK, QUEEN, KING]`

### *class* Piece(color: [Color](#bulletchess.main.Color), type: [PieceType](#bulletchess.main.PieceType))

Represents a piece with both a Color and a PieceType, such as a White Pawn, or a Black Rook.

#### \_\_init_\_(color: [Color](#bulletchess.main.Color), type: [PieceType](#bulletchess.main.PieceType))

Initialise the `Piece` with *color* and *type*.

* **Parameters:**
  * **color** ([*Color*](#bulletchess.main.Color)) – The owning side.
  * **type** ([*PieceType*](#bulletchess.main.PieceType)) – The intrinsic kind of the piece.

#### *static* from_chr(char: str) → [Piece](#bulletchess.main.Piece)

Return the piece encoded by *char* (ASCII piece letter).

Upper‑case letters encode [`WHITE`](#bulletchess.main.WHITE) pieces, lower‑case letters encode [`BLACK`](#bulletchess.main.BLACK).

* **Parameters:**
  **char** (*str*) – One of `PRNBQKprnbqk`.
* **Return type:**
  [Piece](#bulletchess.main.Piece)
* **Returns:**
  The corresponding [`Piece`](#bulletchess.main.Piece).
* **Raises:**
  **ValueError** – If *char* is not a valid piece letter.

```pycon
>>> Piece.from_chr("P")
<Piece: (White, Pawn)>
>>> Piece.from_chr("n")
<Piece: (Black, Knight)>
```

#### *property* piece_type *: [PieceType](#bulletchess.main.PieceType)*

Gets the [`PieceType`](#bulletchess.main.PieceType) of this [`Piece`](#bulletchess.main.Piece).

#### *property* color *: [Color](#bulletchess.main.Color)*

Gets the [`Color`](#bulletchess.main.Color) of this [`Piece`](#bulletchess.main.Piece).

#### unicode() → str

Returns Unicode figurine character corresponding to this [`Piece`](#bulletchess.main.Piece).

```pycon
>>> Piece(WHITE, PAWN).unicode()
"♙"
>>> Piece(BLACK, KNIGHT).unicode()
"♞"
```

#### \_\_eq_\_(other: Any)

Evaluates to `True` when compared with another [`Piece`](#bulletchess.main.Piece) with the same [`PieceType`](#bulletchess.main.PieceType) and [`Color`](#bulletchess.main.Color)

#### \_\_str_\_() → str

Serializes a [`Piece`](#bulletchess.main.Piece) as a single ASCII character `str`. Uses uppercase for a [`Piece`](#bulletchess.main.Piece) that is [`WHITE`](#bulletchess.main.WHITE), and lowercase for any [`Piece`](#bulletchess.main.Piece) that is [`BLACK`](#bulletchess.main.BLACK).

```pycon
>>> str(Piece(WHITE, PAWN))
"P"
>>> str(Piece(BLACK, KNIGHT))
"n"
```

#### \_\_hash_\_() → int

### *class* Square

Represents one of the 64 squares on a chess board.

#### *static* from_str(name: str) → [Square](#bulletchess.main.Square)

Return the [`Square`](#bulletchess.main.Square) encoded by *name* (case‑insensitive).

* **Parameters:**
  **name** (*str*) – The name of the square
* **Return type:**
  [Square](#bulletchess.main.Square)
* **Returns:**
  The corresponding [`Square`](#bulletchess.main.Square)
* **Raises:**
  `ValueError` if given a string which does not represent a Square

```pycon
>>> Square.from_string("E1") == E1
True
>>> Square.from_string("a2") == A2
Tru
```

#### bb() → [Bitboard](#bulletchess.main.Bitboard)

Creates a [`Bitboard`](#bulletchess.main.Bitboard) containing **only** this [`Square`](#bulletchess.main.Square).

```pycon
>>> A1.bb() == Bitboard([A1])
True
>>> H3.bb() == Bitboard([H3])
True
```

#### adjacent() → [Bitboard](#bulletchess.main.Bitboard)

Creates a [`Bitboard`](#bulletchess.main.Bitboard) of all neighbors orthogonal or diagonal to this [`Square`](#bulletchess.main.Square).

```pycon
>>> A1.adjacent() == Bitboard([A2, B1, B2])
True
>>> E5.adjacent() == Bitboard([D4, D5, D6, E4, E6, F4, F5, F6])
True
```

#### north(distance: int = 1) → [Square](#bulletchess.main.Square) | None

Return the square *distance* ranks above this square.

* **Parameters:**
  **distance** – how many ranks to move north.
* **Returns:**
  the target square, or `None` if it would be off the board.
* **Return type:**
  [Square](#bulletchess.main.Square) | None

```pycon
>>> B6.north() is B7
True
>>> A1.north(distance=3) is A4
True
>>> B8.north(distance=2)
None
```

#### south(distance: int = 1) → [Square](#bulletchess.main.Square) | None

Return the square *distance* ranks below this square.

* **Parameters:**
  **distance** (*int* *,* *default = 1*) – how many ranks to move south.
* **Returns:**
  the target square, or `None` if it would be off the board.
* **Return type:**
  [Square](#bulletchess.main.Square) | None

```pycon
>>> B6.south() is B5
True
>>> B8.south(distance=2) is B6
True
>>> A1.south(distance=3)
None
```

#### east(distance: int = 1) → [Square](#bulletchess.main.Square) | None

Return the square *distance* files to the east of this square.

* **Parameters:**
  **distance** (*int* *,* *default = 1*) – how many files to move east (toward the H-file).
* **Returns:**
  the target square, or `None` if it would be off the board.
* **Return type:**
  [Square](#bulletchess.main.Square) | None

```pycon
>>> B6.east() is C6
True
>>> A1.east(distance=3) is D1
True
>>> H8.east(distance=2)
None
```

#### west(distance: int = 1) → [Square](#bulletchess.main.Square) | None

Return the square *distance* files to the west of this square.

* **Parameters:**
  **distance** (*int* *,* *default = 1*) – how many files to move west (toward the A-file).
* **Returns:**
  the target square, or `None` if it would be off the board.
* **Return type:**
  [Square](#bulletchess.main.Square) | None

```pycon
>>> B6.west() == A6
True
>>> H8.west(distance=2) == E8
True
>>> A1.west(distance=3)
None
```

#### nw(distance: int = 1) → [Square](#bulletchess.main.Square) | None

Return the square *distance* files west and ranks north of this square.

* **Parameters:**
  **distance** (*int* *,* *default = 1*) – number of steps to move north-west.
* **Returns:**
  the target square, or `None` if it would be off the board.
* **Return type:**
  [Square](#bulletchess.main.Square) | None

```pycon
>>> C3.nw() == B4
True
>>> A1.nw()
None
>>> D4.nw(distance=2) == B6
True
```

#### ne(distance: int = 1) → [Square](#bulletchess.main.Square) | None

Return the square *distance* files east and ranks north of this square.

* **Parameters:**
  **distance** (*int* *,* *default = 1*) – number of steps to move north-east.
* **Returns:**
  the target square, or `None` if it would be off the board.
* **Return type:**
  [Square](#bulletchess.main.Square) | None

```pycon
>>> C3.ne() is D4
True
>>> E4.ne(distance = 2) is G2
True
>>> H8.ne()
None
```

#### sw(distance: int = 1) → [Square](#bulletchess.main.Square) | None

Return the square *distance* files west and ranks south of this square.

* **Parameters:**
  **distance** (*int* *,* *default = 1*) – number of steps to move south-west.
* **Returns:**
  the target square, or `None` if it would be off the board.
* **Return type:**
  [Square](#bulletchess.main.Square) | None

```pycon
>>> C3.sw() is B2
True
>>> E4.sw(distance = 2) is C6
True
>>> A1.sw()
None
```

#### se(distance: int = 1) → [Square](#bulletchess.main.Square) | None

Return the square *distance* files east and ranks south of this square.

* **Parameters:**
  **distance** (*int* *,* *default = 1*) – number of steps to move south-east.
* **Returns:**
  the target square, or `None` if it would be off the board.
* **Return type:**
  [Square](#bulletchess.main.Square) | None

```pycon
>>> C3.se() is D2
True
>>> E4.se(distance = 2) is G6
True
>>> H1.se()
None
```

#### \_\_eq_\_(other: Any) → bool

#### \_\_hash_\_() → int

#### \_\_str_\_() → str

### A1 *: [Square](#bulletchess.main.Square)*

The A1 [`Square`](#bulletchess.main.Square)

### B1 *: [Square](#bulletchess.main.Square)*

The B1 [`Square`](#bulletchess.main.Square)

### C1 *: [Square](#bulletchess.main.Square)*

The C1 [`Square`](#bulletchess.main.Square)

### D1 *: [Square](#bulletchess.main.Square)*

The D1 [`Square`](#bulletchess.main.Square)

### E1 *: [Square](#bulletchess.main.Square)*

The E1 [`Square`](#bulletchess.main.Square)

### F1 *: [Square](#bulletchess.main.Square)*

The F1 [`Square`](#bulletchess.main.Square)

### G1 *: [Square](#bulletchess.main.Square)*

The G1 [`Square`](#bulletchess.main.Square)

### H1 *: [Square](#bulletchess.main.Square)*

The H1 [`Square`](#bulletchess.main.Square)

### A2 *: [Square](#bulletchess.main.Square)*

The A2 [`Square`](#bulletchess.main.Square)

### B2 *: [Square](#bulletchess.main.Square)*

The B2 [`Square`](#bulletchess.main.Square)

### C2 *: [Square](#bulletchess.main.Square)*

The C2 [`Square`](#bulletchess.main.Square)

### D2 *: [Square](#bulletchess.main.Square)*

The D2 [`Square`](#bulletchess.main.Square)

### E2 *: [Square](#bulletchess.main.Square)*

The E2 [`Square`](#bulletchess.main.Square)

### F2 *: [Square](#bulletchess.main.Square)*

The F2 [`Square`](#bulletchess.main.Square)

### G2 *: [Square](#bulletchess.main.Square)*

The G2 [`Square`](#bulletchess.main.Square)

### H2 *: [Square](#bulletchess.main.Square)*

The H2 [`Square`](#bulletchess.main.Square)

### A3 *: [Square](#bulletchess.main.Square)*

The A3 [`Square`](#bulletchess.main.Square)

### B3 *: [Square](#bulletchess.main.Square)*

The B3 [`Square`](#bulletchess.main.Square)

### C3 *: [Square](#bulletchess.main.Square)*

The C3 [`Square`](#bulletchess.main.Square)

### D3 *: [Square](#bulletchess.main.Square)*

The D3 [`Square`](#bulletchess.main.Square)

### E3 *: [Square](#bulletchess.main.Square)*

The E3 [`Square`](#bulletchess.main.Square)

### F3 *: [Square](#bulletchess.main.Square)*

The F3 [`Square`](#bulletchess.main.Square)

### G3 *: [Square](#bulletchess.main.Square)*

The G3 [`Square`](#bulletchess.main.Square)

### H3 *: [Square](#bulletchess.main.Square)*

The H3 [`Square`](#bulletchess.main.Square)

### A4 *: [Square](#bulletchess.main.Square)*

The A4 [`Square`](#bulletchess.main.Square)

### B4 *: [Square](#bulletchess.main.Square)*

The B4 [`Square`](#bulletchess.main.Square)

### C4 *: [Square](#bulletchess.main.Square)*

The C4 [`Square`](#bulletchess.main.Square)

### D4 *: [Square](#bulletchess.main.Square)*

The D4 [`Square`](#bulletchess.main.Square)

### E4 *: [Square](#bulletchess.main.Square)*

The E4 [`Square`](#bulletchess.main.Square)

### F4 *: [Square](#bulletchess.main.Square)*

The F4 [`Square`](#bulletchess.main.Square)

### G4 *: [Square](#bulletchess.main.Square)*

The G4 [`Square`](#bulletchess.main.Square)

### H4 *: [Square](#bulletchess.main.Square)*

The H4 [`Square`](#bulletchess.main.Square)

### A5 *: [Square](#bulletchess.main.Square)*

The A5 [`Square`](#bulletchess.main.Square)

### B5 *: [Square](#bulletchess.main.Square)*

The B5 [`Square`](#bulletchess.main.Square)

### C5 *: [Square](#bulletchess.main.Square)*

The C5 [`Square`](#bulletchess.main.Square)

### D5 *: [Square](#bulletchess.main.Square)*

The D5 [`Square`](#bulletchess.main.Square)

### E5 *: [Square](#bulletchess.main.Square)*

The E5 [`Square`](#bulletchess.main.Square)

### F5 *: [Square](#bulletchess.main.Square)*

The F5 [`Square`](#bulletchess.main.Square)

### G5 *: [Square](#bulletchess.main.Square)*

The G5 [`Square`](#bulletchess.main.Square)

### H5 *: [Square](#bulletchess.main.Square)*

The H5 [`Square`](#bulletchess.main.Square)

### A6 *: [Square](#bulletchess.main.Square)*

The A6 [`Square`](#bulletchess.main.Square)

### B6 *: [Square](#bulletchess.main.Square)*

The B6 [`Square`](#bulletchess.main.Square)

### C6 *: [Square](#bulletchess.main.Square)*

The C6 [`Square`](#bulletchess.main.Square)

### D6 *: [Square](#bulletchess.main.Square)*

The D6 [`Square`](#bulletchess.main.Square)

### E6 *: [Square](#bulletchess.main.Square)*

The E6 [`Square`](#bulletchess.main.Square)

### F6 *: [Square](#bulletchess.main.Square)*

The F6 [`Square`](#bulletchess.main.Square)

### G6 *: [Square](#bulletchess.main.Square)*

The G6 [`Square`](#bulletchess.main.Square)

### H6 *: [Square](#bulletchess.main.Square)*

The H6 [`Square`](#bulletchess.main.Square)

### A7 *: [Square](#bulletchess.main.Square)*

The A7 [`Square`](#bulletchess.main.Square)

### B7 *: [Square](#bulletchess.main.Square)*

The B7 [`Square`](#bulletchess.main.Square)

### C7 *: [Square](#bulletchess.main.Square)*

The C7 [`Square`](#bulletchess.main.Square)

### D7 *: [Square](#bulletchess.main.Square)*

The D7 [`Square`](#bulletchess.main.Square)

### E7 *: [Square](#bulletchess.main.Square)*

The E7 [`Square`](#bulletchess.main.Square)

### F7 *: [Square](#bulletchess.main.Square)*

The F7 [`Square`](#bulletchess.main.Square)

### G7 *: [Square](#bulletchess.main.Square)*

The G7 [`Square`](#bulletchess.main.Square)

### H7 *: [Square](#bulletchess.main.Square)*

The H7 [`Square`](#bulletchess.main.Square)

### A8 *: [Square](#bulletchess.main.Square)*

The A8 [`Square`](#bulletchess.main.Square)

### B8 *: [Square](#bulletchess.main.Square)*

The B8 [`Square`](#bulletchess.main.Square)

### C8 *: [Square](#bulletchess.main.Square)*

The C8 [`Square`](#bulletchess.main.Square)

### D8 *: [Square](#bulletchess.main.Square)*

The D8 [`Square`](#bulletchess.main.Square)

### E8 *: [Square](#bulletchess.main.Square)*

The E8 [`Square`](#bulletchess.main.Square)

### F8 *: [Square](#bulletchess.main.Square)*

The F8 [`Square`](#bulletchess.main.Square)

### G8 *: [Square](#bulletchess.main.Square)*

The G8 [`Square`](#bulletchess.main.Square)

### H8 *: [Square](#bulletchess.main.Square)*

The H8 [`Square`](#bulletchess.main.Square)

### SQUARES *: list[[Square](#bulletchess.main.Square)]*

### SQUARES_FLIPPED *: list[[Square](#bulletchess.main.Square)]*

A list of all Squares

### *class* Bitboard(squares: Collection[[Square](#bulletchess.main.Square)])

A set of squares represented as a 64-bit integer, where each bit
indicates whether a [`Square`](#bulletchess.main.Square) is included.

#### \_\_init_\_(squares: Collection[[Square](#bulletchess.main.Square)])

Initialise a [`Bitboard`](#bulletchess.main.Bitboard) that contains *squares*.

* **Parameters:**
  **squares** (*Collection* *[*[*Square*](#bulletchess.main.Square) *]*) – squares to include in the new bitboard.

#### \_\_str_\_() → str

Return a `str` in which included squares are shown as `1` and
excluded squares as `0`.

* **Returns:**
  an 8×8 grid row-major from A8 to H1.
* **Return type:**
  str

```pycon
>>> print(str(RANK_5))
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
1 1 1 1 1 1 1 1 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0
```

#### *static* from_int(value: int) → [Bitboard](#bulletchess.main.Bitboard)

Construct a [`Bitboard`](#bulletchess.main.Bitboard) from its integer encoding (see [`__int__()`](#bulletchess.main.Bitboard.__int__)).

* **Parameters:**
  **value** (*int*) – 64-bit integer to convert.
* **Returns:**
  new bitboard corresponding to *value*.
* **Return type:**
  [Bitboard](#bulletchess.main.Bitboard)
* **Raises:**
  **OverflowError** – if `value < 0` or `value >= 2 ** 64`

```pycon
>>> Bitboard.from_int(0) == Bitboard([])
True
>>> Bitboard.from_int(1) == Bitboard([A1])
True
>>> Bitboard.from_int(269498368) == Bitboard([E2, E3, E4, D2, F2])
True
>>> Bitboard.from_int(0xFFFF_FFFF_FFFF_FFFF) == FULL_BB
True
```

#### \_\_int_\_() → int

Return the integer encoding of this [`Bitboard`](#bulletchess.main.Bitboard).

* **Returns:**
  64-bit integer with one bit per square.
* **Return type:**
  int

```pycon
>>> int(EMPTY_BB)
0
>>> int(Bitboard([A1]))
1
>>> int(Bitboard([E2, E3, E4, D2, F2]))
269498368
>>> Bitboard.from_int(int(DARK_SQUARE_BB)) == DARK_SQUARE_BB
True
```

#### \_\_getitem_\_(square: [Square](#bulletchess.main.Square)) → bool

Return `True` if *square* is in this [`Bitboard`](#bulletchess.main.Bitboard).

* **Parameters:**
  **square** ([*Square*](#bulletchess.main.Square)) – square to query.
* **Returns:**
  membership flag.
* **Return type:**
  bool

```pycon
>>> bb = Bitboard([A1, B2, C3])
>>> bb[A1]
True
>>> bb[A2]
False
```

#### \_\_setitem_\_(square: [Square](#bulletchess.main.Square), value: bool)

Add or remove *square* depending on *value*.

* **Parameters:**
  * **square** ([*Square*](#bulletchess.main.Square)) – square to modify.
  * **value** (*bool*) – `True` → add, `False` → remove.

```pycon
>>> bb = Bitboard([A1, B2, C3])
>>> bb2 = Bitboard([B2, C3])
>>> bb3 = Bitboard([B2, C3, C4])
>>> bb[A1] = False
>>> bb == bb2
True
>>> bb[C4] = True
>>> bb == bb3
True
```

#### \_\_delitem_\_(square: [Square](#bulletchess.main.Square))

Remove *square* from the [`Bitboard`](#bulletchess.main.Bitboard).

* **Parameters:**
  **square** ([*Square*](#bulletchess.main.Square)) – square to delete.

```pycon
>>> bb = Bitboard([A1, B2, C3])
>>> bb2 = Bitboard([B2, C3])
>>> del bb[A1]
>>> bb == bb2
True
```

#### \_\_len_\_() → int

Return the number of squares contained in this bitboard.

* **Returns:**
  population count.
* **Return type:**
  int

```pycon
>>> len(Bitboard([]))
0
>>> len(Bitboard([A1, A2]))
2
>>> len(RANK_1)
8
>>> len(FULL_BB)
64
```

#### \_\_contains_\_(square: [Square](#bulletchess.main.Square)) → bool

Test whether *square* is in this [`Bitboard`](#bulletchess.main.Bitboard).

* **Parameters:**
  **square** ([*Square*](#bulletchess.main.Square)) – square to test.
* **Returns:**
  membership flag.
* **Return type:**
  bool

```pycon
>>> A1 in Bitboard([A1, A2])
True
>>> H3 in FULL_BB
True
>>> C6 in RANK_1
False
```

#### \_\_eq_\_(other: Any) → bool

Return `True` if *other* is a [`Bitboard`](#bulletchess.main.Bitboard) with the same squares.

* **Parameters:**
  **other** (*Any*) – bitboard to compare.
* **Returns:**
  equality flag.
* **Return type:**
  bool

```pycon
>>> Bitboard([A1, A2, A3, A4, A5, A6, A7, A8]) == A_FILE
True
>>> Bitboard([C4]) == Bitboard([C3])
False
```

#### \_\_invert_\_() → [Bitboard](#bulletchess.main.Bitboard)

Return the complement of this [`Bitboard`](#bulletchess.main.Bitboard).

* **Returns:**
  new bitboard with opposite membership.
* **Return type:**
  [Bitboard](#bulletchess.main.Bitboard)

```pycon
>>> FULL_BB == ~EMPTY_BB
True
>>> LIGHT_SQUARE_BB == ~DARK_SQUARE_BB
True
```

#### \_\_and_\_(other: [Bitboard](#bulletchess.main.Bitboard)) → [Bitboard](#bulletchess.main.Bitboard)

Return the intersection of two bitboards.

* **Parameters:**
  **other** ([*Bitboard*](#bulletchess.main.Bitboard)) – bitboard to intersect with.
* **Returns:**
  squares common to both operands.
* **Return type:**
  [Bitboard](#bulletchess.main.Bitboard)

```pycon
>>> Bitboard([A1]) & Bitboard([A1, A2]) == Bitboard([A1])
True
>>> LIGHT_SQUARE_BB & DARK_SQUARE_BB == EMPTY_BB
True
```

#### \_\_or_\_(other: [Bitboard](#bulletchess.main.Bitboard)) → [Bitboard](#bulletchess.main.Bitboard)

Return the union of two bitboards.

* **Parameters:**
  **other** ([*Bitboard*](#bulletchess.main.Bitboard)) – bitboard to union with.
* **Returns:**
  squares contained in either operand.
* **Return type:**
  [Bitboard](#bulletchess.main.Bitboard)

```pycon
>>> Bitboard([A1]) | Bitboard([A1, A2]) == Bitboard([A1, A2])
True
>>> LIGHT_SQUARE_BB | DARK_SQUARE_BB == FULL_BB
True
```

#### \_\_xor_\_(other: [Bitboard](#bulletchess.main.Bitboard)) → [Bitboard](#bulletchess.main.Bitboard)

Return the symmetric difference of two bitboards.

* **Parameters:**
  **other** ([*Bitboard*](#bulletchess.main.Bitboard)) – bitboard to XOR with.
* **Returns:**
  squares in exactly one operand.
* **Return type:**
  [Bitboard](#bulletchess.main.Bitboard)

```pycon
>>> Bitboard([A1]) ^ Bitboard([A1, A2]) == Bitboard([A2])
True
>>> LIGHT_SQUARE_BB ^ DARK_SQUARE_BB == FULL_BB
True
```

#### \_\_bool_\_() → bool

Return `True` if the [`Bitboard`](#bulletchess.main.Bitboard) is non-empty.

* **Returns:**
  truth value.
* **Return type:**
  bool

```pycon
>>> bool(Bitboard([]))
False
>>> bool(EMPTY_BB)
False
>>> bool(Bitboard([A1]))
True
```

#### \_\_iter_\_() → Iterator[[Square](#bulletchess.main.Square)]

Iterate over included squares from A1 upward.

#### \_\_repr_\_() → str

#### \_\_hash_\_() → int

### RANK_1 *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containing every square on Rank 1

### RANK_2 *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containing every square on Rank 2

### RANK_3 *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containing every square on Rank 3

### RANK_4 *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containing every square on Rank 4

### RANK_5 *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containing every square on Rank 5

### RANK_6 *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containing every square on Rank 6

### RANK_7 *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containing every square on Rank 7

### RANK_8 *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containing every square on Rank 8

### RANKS *: list[[Bitboard](#bulletchess.main.Bitboard)]*

List of the eight rank [`Bitboard`](#bulletchess.main.Bitboard) values in order, from [`RANK_1`](#bulletchess.main.RANK_1) to [`RANK_8`](#bulletchess.main.RANK_8).

### A_FILE *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containing every square on the A-file.

### B_FILE *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containing every square on the B-file.

### C_FILE *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containing every square on the C-file.

### D_FILE *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containing every square on the D-file.

### E_FILE *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containing every square on the E-file.

### F_FILE *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containg every square on the F-file

### G_FILE *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containing every square on the G-file.

### H_FILE *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containing every square on the H-file.

### FILES *: list[[Bitboard](#bulletchess.main.Bitboard)]*

List of the eight file [`Bitboard`](#bulletchess.main.Bitboard) values in order, from [`A_FILE`](#bulletchess.main.A_FILE) to [`H_FILE`](#bulletchess.main.H_FILE).

### FULL_BB *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containing all 64 squares

### EMPTY_BB *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) containing no squares

### LIGHT_SQUARE_BB *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) of all light colored squares (B1, D1, etc.)

### DARK_SQUARE_BB *: [Bitboard](#bulletchess.main.Bitboard)*

[`Bitboard`](#bulletchess.main.Bitboard) of all dark colored squares (A1, C1, etc.)

### *class* CastlingType

One of four legal castling options: the king moves either kingside or
queenside for [`WHITE`](#bulletchess.main.WHITE) or [`BLACK`](#bulletchess.main.BLACK).

#### *static* from_chr(castling_type: str) → [CastlingType](#bulletchess.main.CastlingType)

Return the castling type corresponding to a single-character code.

* **Parameters:**
  **castling_type** (*str*) – one of `"K"`, `"Q"`, `"k"`, `"q"`.
* **Returns:**
  the matching [`CastlingType`](#bulletchess.main.CastlingType).
* **Return type:**
  [CastlingType](#bulletchess.main.CastlingType)
* **Raises:**
  **ValueError** – if *castling_type* is not a valid code.

```pycon
>>> CastlingType.from_chr("K") is WHITE_KINGSIDE
True
>>> CastlingType.from_chr("Q") is WHITE_QUEENSIDE
True
>>> CastlingType.from_chr("k") is BLACK_KINGSIDE
True
>>> CastlingType.from_chr("q") is BLACK_QUEENSIDE
True
```

#### \_\_str_\_() → str

Return the one-character code for this castling type.

* **Returns:**
  `"K"`, `"Q"`, `"k"`, or `"q"`.
* **Return type:**
  str

```pycon
>>> str(WHITE_KINGSIDE)
'K'
>>> str(WHITE_QUEENSIDE)
'Q'
>>> str(BLACK_KINGSIDE)
'k'
>>> str(BLACK_QUEENSIDE)
'q'
```

#### \_\_eq_\_(other: Any) → bool

Return `True` if *other* is the same castling type.

* **Parameters:**
  **other** (*Any*) – object to compare.
* **Returns:**
  equality flag.
* **Return type:**
  bool

#### \_\_repr_\_() → str

#### \_\_hash_\_() → int

### WHITE_KINGSIDE *: [CastlingType](#bulletchess.main.CastlingType)*

Castling type representing [`WHITE`](#bulletchess.main.WHITE) kingside castling

### WHITE_QUEENSIDE *: [CastlingType](#bulletchess.main.CastlingType)*

Castling type representing [`WHITE`](#bulletchess.main.WHITE) queenside castling

### BLACK_KINGSIDE *: [CastlingType](#bulletchess.main.CastlingType)*

Castling type representing [`BLACK`](#bulletchess.main.BLACK) kingside castling

### BLACK_QUEENSIDE *: [CastlingType](#bulletchess.main.CastlingType)*

Castling type representing [`BLACK`](#bulletchess.main.BLACK) queenside castling

### *class* Move(origin: [Square](#bulletchess.main.Square), destination: [Square](#bulletchess.main.Square), promote_to: [PieceType](#bulletchess.main.PieceType) | None = None)

A chess move, defined by its origin and destination squares and an
optional promotion piece type.

#### \_\_init_\_(origin: [Square](#bulletchess.main.Square), destination: [Square](#bulletchess.main.Square), promote_to: [PieceType](#bulletchess.main.PieceType) | None = None)

Create a move from *origin* to *destination*.

* **Parameters:**
  * **origin** ([*Square*](#bulletchess.main.Square)) – square the piece starts on.
  * **destination** ([*Square*](#bulletchess.main.Square)) – square the piece ends on.
  * **promote_to** ([*PieceType*](#bulletchess.main.PieceType) *|* *None*) – piece type to promote to, if any.
* **Raises:**
  `ValueError` if the specified origin, destination, and promtion is illegal for every piece for every position.

#### *static* castle(castling_type: [CastlingType](#bulletchess.main.CastlingType)) → [Move](#bulletchess.main.Move)

Return the move corresponding to *castling_type*.

* **Parameters:**
  **castling_type** ([*CastlingType*](#bulletchess.main.CastlingType)) – one of the four castling constants.
* **Returns:**
  appropriate king move for that castling.
* **Return type:**
  [Move](#bulletchess.main.Move)

```pycon
>>> Move.castle(WHITE_KINGSIDE) == Move(E1, G1)
True
>>> Move.castle(WHITE_QUEENSIDE) == Move(E1, C1)
True
>>> Move.castle(BLACK_KINGSIDE) == Move(E8, G8)
True
>>> Move.castle(BLACK_QUEENSIDE) == Move(E8, C8)
True
```

#### *static* from_uci(uci: str) → [Move](#bulletchess.main.Move) | None

Parse a UCI long-algebraic `str` and build a move.

Null moves are supported as “0000”, and are represented as `None`.

* **Parameters:**
  **uci** (*str*) – UCI string such as `"e2e4"` or `"b7b8q"`.
* **Returns:**
  move instance, or `None` for a null move.
* **Return type:**
  [Move](#bulletchess.main.Move) | None
* **Raises:**
  **ValueError** – if *uci* is malformed or illegal.

```pycon
>>> Move.from_uci("e2e4") == Move(E2, E4)
True
>>> Move.from_uci("a1d4") == Move(A1, D4)
True
>>> Move.from_uci("b7b8q") == Move(B7, B8, promote_to=QUEEN)
True
>>> Move.from_uci("0000") is None
True
```

#### *static* from_san(san: str, board: [Board](#bulletchess.main.Board)) → [Move](#bulletchess.main.Move)

Parse a SAN `str` in the context of *board*.

* **Parameters:**
  * **san** (*str*) – SAN text (e.g. `"Nf6"`, `"O-O"`, `"e4"`).
  * **board** ([*Board*](#bulletchess.main.Board)) – position used to disambiguate the SAN.
* **Returns:**
  the corresponding move.
* **Return type:**
  [Move](#bulletchess.main.Move)
* **Raises:**
  **ValueError** – if *san* is invalid for *board*.

```pycon
>>> Move.from_san("e4", Board()) == Move(E2, E4)
True
>>> FEN = "r1bqkbnr/pppp1ppp/2n5/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R b KQkq - 3 3"
>>> board = Board.from_fen(FEN)
>>> Move.from_san("Nf6", board) == Move(G8, F6)
True
```

#### san(board: [Board](#bulletchess.main.Board)) → str

Return this move in SAN notation relative to *board*.

* **Parameters:**
  **board** ([*Board*](#bulletchess.main.Board)) – position that provides context.
* **Returns:**
  SAN string.
* **Return type:**
  str
* **Raises:**
  **ValueError** – if the move is illegal for *board*.

```pycon
>>> Move(E2, E4).san(Board())
'e4'
>>> FEN = "r1bqkb1r/pppp1ppp/2n2n2/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 4 4"
>>> Move(E1, G1).san(Board.from_fen(FEN))
'O-O'
```

#### uci() → str

Return a `str` of the UCI long algebraic notation representation of this move.

* **Returns:**
  UCI string.
* **Return type:**
  str

```pycon
>>> Move(E2, E4).uci()
'e2e4'
>>> Move(A1, D4).uci()
'a1d4'
>>> Move(B7, B8, promote_to=QUEEN).uci()
'b7b8q'
```

#### \_\_str_\_() → str

Alias for [`Move.uci()`](#bulletchess.main.Move.uci).

```pycon
>>> str(Move(E2, E4))
'e2e4'
>>> str(Move(A1, D4))
'a1d4'
>>> str(Move(B7, B8, promote_to=QUEEN))
'b7b8q'
```

#### *property* origin *: [Square](#bulletchess.main.Square)*

The [`Square`](#bulletchess.main.Square) the piece moves from.

```pycon
>>> Move(E2, E4).origin is E2
True
>>> Move.from_uci("a1d4").origin is A1
True
```

#### *property* destination *: [Square](#bulletchess.main.Square)*

The [`Square`](#bulletchess.main.Square) the piece moves to.

```pycon
>>> Move(E2, E4).destination is E4
True
>>> Move.from_uci("a1d4").destination is D4
True
```

#### *property* promotion *: [PieceType](#bulletchess.main.PieceType) | None*

Promotion [`PieceType`](#bulletchess.main.PieceType), or `None` for a non-promotion.

```pycon
>>> Move.from_uci("b7b8q").promotion is QUEEN
True
>>> Move(E2, E4).promotion is None
True
```

#### is_promotion() → bool

Return `True` if the move is a promotion.

```pycon
>>> Move.from_uci("b7b8q").is_promotion()
True
>>> Move(E2, E4).is_promotion()
False
```

#### is_capture(board: [Board](#bulletchess.main.Board)) → bool

Return `True` if the move captures a piece on *board*.

* **Parameters:**
  **board** ([*Board*](#bulletchess.main.Board)) – position to check if this is a capture.
* **Returns:**
  capture flag.
* **Return type:**
  bool

```pycon
>>> FEN = "r1bqkbnr/pppp1ppp/2n5/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R w KQkq - 2 3"
>>> board = Board.from_fen(FEN)
>>> Move(F3, E5).is_capture(board)
True
```

#### is_castling(board: [Board](#bulletchess.main.Board)) → bool

Return `True` if the move is a legal castling move on *board*.

* **Parameters:**
  **board** ([*Board*](#bulletchess.main.Board)) – position to check if this is a castling move.
* **Returns:**
  castling flag.
* **Return type:**
  bool

```pycon
>>> FEN = "r1bqkb1r/pppp1ppp/2n2n2/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 4 4"
>>> board = Board.from_fen(FEN)
>>> Move(E1, G1).is_castling(board)
True
>>> Move(E1, G1).is_castling(Board.empty())
False
```

#### castling_type(board: [Board](#bulletchess.main.Board)) → [CastlingType](#bulletchess.main.CastlingType) | None

If the move is castling, return its type; otherwise `None`.

* **Parameters:**
  **board** ([*Board*](#bulletchess.main.Board)) – position used for classification.
* **Returns:**
  corresponding castling type or `None`.
* **Return type:**
  [CastlingType](#bulletchess.main.CastlingType) | None

```pycon
>>> FEN = "r1bqkb1r/pppp1ppp/2n2n2/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 4 4"
>>> board = Board.from_fen(FEN)
>>> Move(E1, G1).castling_type(board) is WHITE_KINGSIDE
True
>>> Move(E1, G1).castling_type(Board.empty()) is None
True
```

#### \_\_eq_\_(other: Any) → bool

Return `True` if *other* has the same origin, destination and
promotion value.

* **Parameters:**
  **other** (*Any*) – object to compare.
* **Returns:**
  equality flag.
* **Return type:**
  bool

```pycon
>>> Move(E2, E4) == Move.from_uci("e2e4")
True
>>> Move(A7, A8) == Move.from_uci("a7a8q")
False
```

#### \_\_hash_\_() → int

#### \_\_repr_\_() → str

### *class* CastlingRights(castling_types: Collection[[CastlingType](#bulletchess.main.CastlingType)])

A set of [`CastlingType`](#bulletchess.main.CastlingType) values that encodes a [`Board`](#bulletchess.main.Board)’s castling
permissions.

#### \_\_init_\_(castling_types: Collection[[CastlingType](#bulletchess.main.CastlingType)]) → None

Initialise the object with *castling_types*.

* **Parameters:**
  **castling_types** (*Collection* *[*[*CastlingType*](#bulletchess.main.CastlingType) *]*) – iterable of castling constants to include.

#### *static* from_fen(castling_fen: str) → [CastlingRights](#bulletchess.main.CastlingRights)

Build a [`CastlingRights`](#bulletchess.main.CastlingRights) object from a FEN castling field.

* **Parameters:**
  **castling_fen** (*str*) – `"KQkq"`, `"KQ"`, `"-"` …
* **Returns:**
  rights object matching *castling_fen*.
* **Return type:**
  [CastlingRights](#bulletchess.main.CastlingRights)
* **Raises:**
  **ValueError** – if *castling_fen* is not valid FEN.

```pycon
>>> CastlingRights.from_fen("KQkq") == ALL_CASTLING
True
>>> CastlingRights.from_fen("Qk") == CastlingRights([WHITE_QUEENSIDE, BLACK_KINGSIDE])
True
>>> CastlingRights.from_fen("-") == NO_CASTLING
True
```

#### fen() → str

Returns the Forsyth-Edwards Notation `str` represetnation of this [`CastlingRights`](#bulletchess.main.CastlingRights).

* **Returns:**
  `"KQkq"`, `"-"` or similar.
* **Return type:**
  str

```pycon
>>> NO_CASTLING.fen()
'-'
>>> CastlingRights([WHITE_KINGSIDE, WHITE_QUEENSIDE]).fen()
'KQ'
>>> ALL_CASTLING.fen()
'KQkq'
```

#### \_\_contains_\_(castling_type: [CastlingType](#bulletchess.main.CastlingType)) → bool

Return `True` if *castling_type* is present.

* **Parameters:**
  **castling_type** ([*CastlingType*](#bulletchess.main.CastlingType)) – entry to test.
* **Returns:**
  membership flag.
* **Return type:**
  bool

```pycon
>>> WHITE_KINGSIDE in ALL_CASTLING
True
>>> BLACK_KINGSIDE in CastlingRights([WHITE_QUEENSIDE])
False
```

#### \_\_iter_\_() → Iterator[[CastlingType](#bulletchess.main.CastlingType)]

Iteratator over included [`CastlingType`](#bulletchess.main.CastlingType) values

#### \_\_len_\_() → int

The number of castling types included

#### \_\_bool_\_() → [CastlingRights](#bulletchess.main.CastlingRights)

Returns `True` if **any** castling rights are present, alias for [`CastlingRights.any()`](#bulletchess.main.CastlingRights.any)

#### \_\_add_\_(other: [CastlingRights](#bulletchess.main.CastlingRights)) → [CastlingRights](#bulletchess.main.CastlingRights)

Return the union of two castling-rights sets.

* **Parameters:**
  **other** ([*CastlingRights*](#bulletchess.main.CastlingRights)) – rights to add.
* **Returns:**
  combined rights.
* **Return type:**
  [CastlingRights](#bulletchess.main.CastlingRights)

```pycon
>>> CastlingRights.from_fen("KQ") + CastlingRights.from_fen("kq") == ALL_CASTLING
True
```

#### \_\_eq_\_(other: Any) → bool

Return `True` if *other* has the identical rights set.

#### \_\_le_\_(other: [CastlingRights](#bulletchess.main.CastlingRights)) → bool

Return `True` if this set is a subset of *other*.

```pycon
>>> CastlingRights.from_fen("KQ") <= CastlingRights.from_fen("KQkq")
True
>>> CastlingRights.from_fen("KQkq") <= CastlingRights.from_fen("KQkq")
True
```

#### \_\_lt_\_(other: [CastlingRights](#bulletchess.main.CastlingRights)) → bool

Return `True` if this set is a **strict** subset of *other*.

```pycon
>>> CastlingRights.from_fen("KQ") < CastlingRights.from_fen("KQkq")
True
>>> CastlingRights.from_fen("KQkq") < CastlingRights.from_fen("KQkq")
False
```

#### \_\_gt_\_(other: [CastlingRights](#bulletchess.main.CastlingRights)) → bool

Return `True` if this set is a **strict** superset of *other*.

```pycon
>>> CastlingRights.from_fen("KQkq") > CastlingRights.from_fen("KQ")
True
>>> CastlingRights.from_fen("KQkq") > CastlingRights.from_fen("KQkq")
False
```

#### \_\_ge_\_(other: [CastlingRights](#bulletchess.main.CastlingRights)) → bool

Return `True` if this set is a superset of, or equal to, *other*.

```pycon
>>> CastlingRights.from_fen("KQkq") >= CastlingRights.from_fen("KQ")
True
>>> CastlingRights.from_fen("KQkq") >= CastlingRights.from_fen("KQkq")
True
```

#### \_\_str_\_() → str

Alias for [`CastlingRights.fen()`](#bulletchess.main.CastlingRights.fen)

* **Returns:**
  `"KQkq"`, `"-"` or similar.
* **Return type:**
  str

```pycon
>>> str(NO_CASTLING)
'-'
>>> str(CastlingRights([WHITE_KINGSIDE, WHITE_QUEENSIDE]))
'KQ'
>>> str(ALL_CASTLING)
'KQkq'
```

#### full(color: [Color](#bulletchess.main.Color) | None = None) → bool

Return `True` if **all** relevant rights are present.

* **Parameters:**
  **color** ([*Color*](#bulletchess.main.Color) *|* *None*) – optionally restrict the check to [`WHITE`](#bulletchess.main.WHITE) or [`BLACK`](#bulletchess.main.BLACK).
* **Returns:**
  completeness flag.
* **Return type:**
  bool

```pycon
>>> ALL_CASTLING.full()
True
>>> CastlingRights.from_fen("KQk").full()
False
>>> CastlingRights.from_fen("KQk").full(WHITE)
True
>>> NO_CASTLING.full()
False
```

#### any(color: [Color](#bulletchess.main.Color) | None = None) → bool

Return `True` if any castling right is present.

* **Parameters:**
  **color** ([*Color*](#bulletchess.main.Color) *|* *None*) – optionally restrict the check to [`WHITE`](#bulletchess.main.WHITE) or [`BLACK`](#bulletchess.main.BLACK).
* **Returns:**
  presence flag.
* **Return type:**
  bool

```pycon
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
```

#### kingside(color: [Color](#bulletchess.main.Color) | None = None) → bool

Return `True` if any kingside right is present.

* **Parameters:**
  **color** ([*Color*](#bulletchess.main.Color) *|* *None*) – optionally restrict the check to [`WHITE`](#bulletchess.main.WHITE) or [`BLACK`](#bulletchess.main.BLACK).
* **Returns:**
  kingside flag.
* **Return type:**
  bool

```pycon
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
```

#### queenside(color: [Color](#bulletchess.main.Color) | None = None) → bool

Return `True` if any queenside right is present.

* **Parameters:**
  **color** ([*Color*](#bulletchess.main.Color) *|* *None*) – optionally restrict the check to [`WHITE`](#bulletchess.main.WHITE) or [`BLACK`](#bulletchess.main.BLACK).
* **Returns:**
  queenside flag.
* **Return type:**
  bool

```pycon
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
```

#### \_\_repr_\_() → str

#### \_\_hash_\_() → int

### ALL_CASTLING *: [CastlingRights](#bulletchess.main.CastlingRights)*

Castling rights which include all types of castling

### NO_CASTLING *: [CastlingRights](#bulletchess.main.CastlingRights)*

Castling rights which include no types of castling

### *class* Board

A mutable chess position.

A [`Board`](#bulletchess.main.Board) represents a configuration of chess pieces as a mapping of each [`Square`](#bulletchess.main.Square) to optional an [`Piece`](#bulletchess.main.Piece). 
The [`Board`](#bulletchess.main.Board) class includes attributes for [`CastlingRights`](#bulletchess.main.CastlingRights), the existance of an en-passant [`Square`](#bulletchess.main.Square), and the [`Color`](#bulletchess.main.Color) for the turn of the current player.
Also holds the halfmove clock and fullmove number each as an `int`.

The [`Board`](#bulletchess.main.Board) class provides an interface for generating [`Move`](#bulletchess.main.Move) objects representing legal actions for a turn, 
as well as applying and undoing these moves.

#### \_\_init_\_()

Initializes a [`Board`](#bulletchess.main.Board) representing the starting position.

#### *static* from_fen(fen: str) → [Board](#bulletchess.main.Board)

Build a board from a `str` of a Forsyth-Edwards Notation (FEN) representation of a position.

The FEN is not required to include a halfmove clock or fullmove number. The default values for these are 0 and 1.

* **Parameters:**
  **fen** (*str*) – full FEN record.
* **Returns:**
  board represented by *fen*.
* **Return type:**
  [Board](#bulletchess.main.Board)
* **Raises:**
  **ValueError** – if *fen* is malformed.

```pycon
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
```

#### *static* empty() → [Board](#bulletchess.main.Board)

Creates a completely empty [`Board`](#bulletchess.main.Board), with no pieces on it.

* **Returns:**
  An empty position
* **Return type:**
  :class:`Board`

#### *property* turn *: [Color](#bulletchess.main.Color)*

Side to move, either [`WHITE`](#bulletchess.main.WHITE) or [`BLACK`](#bulletchess.main.BLACK).

#### *property* halfmove_clock *: int*

Gets the current halfmove clock as an `int`. This represents the number of ply that have passed since a
capture or pawn advance.

#### *property* fullmove_number *: int*

Gets the current fullmove number as an `int`. This represents the total number of turns each player has taken
since the start of a game.

#### *property* en_passant_square *: [Square](#bulletchess.main.Square) | None*

Gets the current en passant [`Square`](#bulletchess.main.Square), if it exists. Otherwise returns `None`.

#### *property* castling_rights *: [CastlingRights](#bulletchess.main.CastlingRights)*

Gets the current [`CastlingRights`](#bulletchess.main.CastlingRights) of this [`Board`](#bulletchess.main.Board).

#### legal_moves() → list[[Move](#bulletchess.main.Move)]

Generates a `list` of legal [`Move`](#bulletchess.main.Move) objects for this [`Board`](#bulletchess.main.Board)’s position.

* **Returns:**
  A list of legal moves for this position.
* **Return type:**
  list[Move]

```pycon
>>> Board().legal_moves()
[<Move: b1a3>, <Move: b1c3>, <Move: g1f3>, <Move: g1h3>, <Move: a2a3>, <Move: a2a4>, <Move: b2b3>, <Move: b2b4>, <Move: c2c3>, <Move: c2c4>, <Move: d2d3>, <Move: d2d4>, <Move: e2e3>, <Move: e2e4>, <Move: f2f3>, <Move: f2f4>, <Move: g2g3>, <Move: g2g4>, <Move: h2h3>, <Move: h2h4>]
```

#### apply(move: [Move](#bulletchess.main.Move) | None) → None

Applies the given [`Move`](#bulletchess.main.Move) to this [`Board`](#bulletchess.main.Board).

The [`Move`](#bulletchess.main.Move) argument is not checked to be legal outside of checking if the origin has a Piece. `None` can be passed as the argument to skip a turn.

* **Parameters:**
  **move** ([*Move*](#bulletchess.main.Move) *|* *None*) – The move to apply, or `None` for a null move.
* **Raises:**
  **ValueError** – if the origin of *move* does not have a piece.

```pycon
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
```

* **Raises:**
  `ValueError` if the given [`Move`](#bulletchess.main.Move)’s origin is an empty square.

#### undo() → [Move](#bulletchess.main.Move) | None

Undoes the last [`Move`](#bulletchess.main.Move) applied to this [`Board`](#bulletchess.main.Board).

* **Returns:**
  The last move applied to this board.
* **Return type:**
  [Move](#bulletchess.main.Move) | None
* **Raises:**
  `AttributeError` if there are no moves to undo. This is true when [`Board.history`](#bulletchess.main.Board.history) has a len() of 0

```pycon
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
```

* **Raises:**
  `AttributeError` if there are no moves to undo.

#### fen() → str

Gets the Forsyth-Edwards Notation representation as a `str` of this [`Board`](#bulletchess.main.Board).

* **Returns:**
  A FEN representing the position
* **Return type:**
  `str`

```pycon
>>> board = Board()
>>> board.fen()
'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
```

#### copy() → [Board](#bulletchess.main.Board)

Returns a new [`Board`](#bulletchess.main.Board) which is an exact copy of this :class:

```
``
```

Board\`, including its [`Move`](#bulletchess.main.Move) history.

* **Returns:**
  A deep copy of this position and its state.
* **Return type:**
  [`Board`](#bulletchess.main.Board)

#### \_\_getitem_\_(index)

Index a [`Board`](#bulletchess.main.Board) with a value. Can either index with a [`Square`](#bulletchess.main.Square), `None`, a [`PieceType`](#bulletchess.main.PieceType), a [`Color`](#bulletchess.main.Color), a `tuple[Color, PieceType]`, or a [`Piece`](#bulletchess.main.Piece),

If given a [`Square`](#bulletchess.main.Square), returns the [`Piece`](#bulletchess.main.Piece) at the square, or `None` if the square is unoccupied.

```pycon
>>> board = Board()
>>> board[E2] is Piece(WHITE, PAWN)
True
>>> board[E4] is None
True
```

If given `None`, returns a [`Bitboard`](#bulletchess.main.Bitboard) of all empty squares.

```pycon
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
```

If given a :class:`Color`, returns a [`Bitboard`](#bulletchess.main.Bitboard) of all squares with a piece of that color

```pycon
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
```

If given a :class:`PieceType`, returns a [`Bitboard`](#bulletchess.main.Bitboard) of all squares with a piece of that type.

```pycon
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
```

If given a [`Piece`](#bulletchess.main.Piece) or a tuple of a [`Color`](#bulletchess.main.Color) and a [`PieceType`](#bulletchess.main.PieceType), returns a [`Bitboard`](#bulletchess.main.Bitboard) of all squares with matching pieces.

```pycon
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
```

#### \_\_setitem_\_(square: [Square](#bulletchess.main.Square), piece: [Piece](#bulletchess.main.Piece) | None)

Sets this [`Board`](#bulletchess.main.Board) to have the given [`Piece`](#bulletchess.main.Piece) and the indexed [`Square`](#bulletchess.main.Square) . 
If set to `None`, the [`Square`](#bulletchess.main.Square) becomes empty.

```pycon
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
```

#### \_\_delitem_\_(square: [Square](#bulletchess.main.Square))

Deletes any [`Piece`](#bulletchess.main.Piece) at the specified [`Square`](#bulletchess.main.Square), leaving the [`Square`](#bulletchess.main.Square) empty.

```pycon
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
```

#### \_\_eq_\_(other: Any) → bool

Returns `True` if compared with another [`Board`](#bulletchess.main.Board) with the same mapping of [`Square`](#bulletchess.main.Square) to [`Piece`](#bulletchess.main.Piece) objects,
equvilent [`CastlingRights`](#bulletchess.main.CastlingRights), en-passant [`Square`](#bulletchess.main.Square) values, and halfmove and fullmove clocks.

To check if two [`Board`](#bulletchess.main.Board) instances are “legally” equal, as in in terms of all of the above besides the halfmove
and fullmove clocks, use `utils.legally_equal()`

Two boards may be considered equal despite having different move histories.

#### \_\_hash_\_() → int

Performs a [Zobrist hash](https://www.chessprogramming.org/Zobrist_Hashing) of this Board.

#### \_\_contains_\_(piece: [Piece](#bulletchess.main.Piece) | None) → bool

Returns `True` if this [`Board`](#bulletchess.main.Board) has the specified [`Piece`](#bulletchess.main.Piece). When given `None`, returns `True` if there
are any empy squares.

#### *property* history *: list[[Move](#bulletchess.main.Move)]*

Gets a `list` of [`Move`](#bulletchess.main.Move) objects of every [`Move`](#bulletchess.main.Move) which have been used with [`Board.apply()`](#bulletchess.main.Board.apply) and have not 
been undone with [`Board.undo()`](#bulletchess.main.Board.undo) for this [`Board`](#bulletchess.main.Board)

```pycon
>>> board = Board()
>>> board.apply(Move(E2, E4))
>>> board.apply(Move(E7, E5))
>>> board.apply(Move(G1, F3))
>>> board.history
[<Move: e2e4>, <Move: e7e5>, <Move: g1f3>]
```

#### \_\_str_\_()

Returns an ASCII `str` representation of this [`Board`](#bulletchess.main.Board).

```pycon
>>> print(str(Board()))
r n b q k b n r 
p p p p p p p p 
- - - - - - - - 
- - - - - - - - 
- - - - - - - - 
- - - - - - - - 
P P P P P P P P 
R N B Q K B N R 
```

```pycon
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
```

#### pretty(color_scheme: [Board](#bulletchess.main.Board) = Board.OAK, highlighted_squares: [Bitboard](#bulletchess.main.Bitboard) = EMPTY_BB, targeted_squares: [Bitboard](#bulletchess.main.Bitboard) = EMPTY_BB) → str

A pretty to-string method for terminal outputs.

Creates a `str` representation of this [`Board`](#bulletchess.main.Board) using Unicode chess figurines and the provided [`Board.ColorScheme`](#bulletchess.main.Board.ColorScheme) as a palette
for the background and highlights. [`Bitboard`](#bulletchess.main.Bitboard)’s can be specified for highlighting particular squares, as for example a [`Move`](#bulletchess.main.Move)’s origin, 
as well as for targetting certain squares, as for possible [`Move`](#bulletchess.main.Move) destinations.

* **Returns:**
  A rendering of this position as a UTF-8 string with `ANSI` color codes
* **Return type:**
  `str`

#### *class* ColorScheme

A pallete of colors to be used with [`Board.pretty()`](#bulletchess.main.Board.pretty) to stylize printed 
boards.

#### LAGOON *: [Board.ColorScheme](#bulletchess.main.Board.ColorScheme)*

A light blue color pallete

#### SLATE *: [Board.ColorScheme](#bulletchess.main.Board.ColorScheme)*

A slightly purplish, grey color pallete

#### OAK *: [Board.ColorScheme](#bulletchess.main.Board.ColorScheme)*

A classical, wood styled color pallete

#### WALNUT *: [Board.ColorScheme](#bulletchess.main.Board.ColorScheme)*

A less saturated wood styled color pallete

#### GREEN *: [Board.ColorScheme](#bulletchess.main.Board.ColorScheme)*

A familiar green and white color pallete

#### ROSE *: [Board.ColorScheme](#bulletchess.main.Board.ColorScheme)*

A pinkish red color pallete

#### CLAY *: [Board.ColorScheme](#bulletchess.main.Board.ColorScheme)*

A dulled, rosy brown and grey color pallete

#### STEEL *: [Board.ColorScheme](#bulletchess.main.Board.ColorScheme)*

A monochromatic grey color pallete

### *class* BoardStatus

A predicate-like object that answers the question  *“is this board in
status X?”*  Examples of statuses include check, check-mate,
stalemate, and repetition or 50-move draw claims.

#### \_\_contains_\_(board: [Board](#bulletchess.main.Board)) → bool

Return `True` if *board* satisfies this status.

* **Parameters:**
  **board** ([*Board*](#bulletchess.main.Board)) – position to test.
* **Returns:**
  membership flag.
* **Return type:**
  bool

## Examples

```pycon
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
```

```pycon
>>> board in CHECKMATE
True
```

#### \_\_repr_\_() → str

#### \_\_eq_\_(other: Any) → bool

### CHECK *: [BoardStatus](#bulletchess.main.BoardStatus)*

The side to move is in check

### MATE *: [BoardStatus](#bulletchess.main.BoardStatus)*

The side to move has no legal moves.

### CHECKMATE *: [BoardStatus](#bulletchess.main.BoardStatus)*

The side to move is in checkmate. The player is in check and has no legal moves.

### STALEMATE *: [BoardStatus](#bulletchess.main.BoardStatus)*

The side to move is in stalemate. The player has no legal moves but is *not* in check.

### INSUFFICIENT_MATERIAL *: [BoardStatus](#bulletchess.main.BoardStatus)*

There is not enough material for either player to be placed in checkmate.

### FIFTY_MOVE_TIMEOUT *: [BoardStatus](#bulletchess.main.BoardStatus)*

Fifty full-moves have passed without a pawn move or capture.

### SEVENTY_FIVE_MOVE_TIMEOUT *: [BoardStatus](#bulletchess.main.BoardStatus)*

Seventy five full-moves have passed without a pawn move or capture.

### THREEFOLD_REPETITION *: [BoardStatus](#bulletchess.main.BoardStatus)*

The same position has occured at least three times.

### FIVEFOLD_REPETITION *: [BoardStatus](#bulletchess.main.BoardStatus)*

The same position has occured at least five times.

### DRAW *: [BoardStatus](#bulletchess.main.BoardStatus)*

Any position in which a player may claim a draw. 
This includes stalemate, insufficient material, a fifty move timeout, or threefold repetition.

### FORCED_DRAW *: [BoardStatus](#bulletchess.main.BoardStatus)*

A forced draw. This includes stalemate, insufficient material, a seventy five move timeout, or fivefold repetition.
