# Portable Game Notation

### *class* PGNDate(year: int | None, month: int | None, day: int | None)

Represents a date for PGN. Has a year, month, and day.

#### \_\_init_\_(year: int | None, month: int | None, day: int | None)

#### *property* year *: int | None*

The year of this date, or `None` if not specified.

#### *property* month *: int | None*

The month of this date, or `None` if not specified.

#### *property* day *: int | None*

The day of this date, or `None` if not specified.

#### \_\_str_\_() → str

Returns a `str` of this date in the form of YYYY.MM.DD

```pycon
>>> str(PGNDate(1990, 4, 10))
'1990.04.10'
>>> str(PGNDate(2015, 7, None))
'2015.07.??'
>>> str(PGNDate(None, None, None))
'????.??.??'
```

#### \_\_repr_\_() → str

#### \_\_eq_\_(other: Any) → bool

Returns `True` if compared with an identical [`PGNDate`](#bulletchess.pgn.PGNDate)

#### \_\_le_\_(other: [PGNDate](#bulletchess.pgn.PGNDate)) → bool

Returns `True` if compared with an earlier or equivalent [`PGNDate`](#bulletchess.pgn.PGNDate)

#### \_\_ge_\_(other: [PGNDate](#bulletchess.pgn.PGNDate)) → bool

Returns `True` if compared with a later or equivalent [`PGNDate`](#bulletchess.pgn.PGNDate)

#### \_\_lt_\_(other: [PGNDate](#bulletchess.pgn.PGNDate)) → bool

Returns `True` if compared with an earlier [`PGNDate`](#bulletchess.pgn.PGNDate)

#### \_\_gt_\_(other: [PGNDate](#bulletchess.pgn.PGNDate)) → bool

Returns `True` if compared with a later [`PGNDate`](#bulletchess.pgn.PGNDate)

#### \_\_hash_\_() → int

### *class* PGNResult

#### *static* from_str(result_str: str) → [PGNResult](#bulletchess.pgn.PGNResult)

Returns the [`PGNResult`](#bulletchess.pgn.PGNResult) corresponding to the given `str`.
Any `str` besides “1-0”, “0-1”, or “1/2-1/2” corresponds to an Unknown Result.

```pycon
>>> PGNResult.from_str("1-0") is WHITE_WON
True
>>> PGNResult.from_str("0-1") is BLACK_WON
True
>>> PGNResult.from_str("1/2-1/2") is DRAW_RESULT
True
>>> PGNResult.from_str("*") is UNKNOWN_RESULT
True
>>> PGNResult.from_str("or anything else") is UNKNOWN_RESULT
True
```

#### *property* winner *: [Color](main.md#bulletchess.main.Color) | None*

Returns the `Color` of the winner, if this result indicates one.

#### *property* is_draw *: bool*

Returns `True` if this result is a draw.

#### *property* is_unknown *: bool*

Returns `True` if this result is unknown.

#### \_\_eq_\_(other: Any) → bool

#### \_\_str_\_() → str

Returns a `str` of the PGN format of this result.

```pycon
>>> str(WHITE_WON)
'1-0'
>>> str(BLACK_WON)
'0-1'
>>> str(DRAW_RESULT)
'1/2-1/2'
>>> str(UNKNOWN_RESULT)
'*'
```

#### \_\_repr_\_() → str

#### \_\_hash_\_() → int

### WHITE_WON *: [PGNResult](#bulletchess.pgn.PGNResult)*

### BLACK_WON *: [PGNResult](#bulletchess.pgn.PGNResult)*

### DRAW_RESULT *: [PGNResult](#bulletchess.pgn.PGNResult)*

### UNKNOWN_RESULT *: [PGNResult](#bulletchess.pgn.PGNResult)*

### *class* PGNGame

#### *property* event *: str*

The contents of the “Event” tag, as a `str`.

#### *property* site *: str*

The contents of the “Site” tag, as a `str`.

#### *property* round *: str*

The contents of the “Round” tag, as a `str`.

#### *property* date *: [PGNDate](#bulletchess.pgn.PGNDate)*

A [`PGNResult`](#bulletchess.pgn.PGNResult) formed from the “Date” tag. Alternatively looks 
at “UTCDate” as a fallback. If neither of these are provided, 
the year, month, and day are marked as unknown.

#### *property* white_player *: str*

The contents of the “White” tag, as a `str`.

#### *property* black_player *: str*

The contents of the “Black” tag, as a `str`.

#### *property* result *: [PGNResult](#bulletchess.pgn.PGNResult)*

A [`PGNResult`](#bulletchess.pgn.PGNResult) formed from the “Result” tag.
If this field is malformed or not provided, an unknown
result is returned.

#### *property* move_count *: int*

The number of moves played in this game.

#### *property* moves *: list[[Move](main.md#bulletchess.main.Move)]*

A list of moves played in this game.

#### *property* starting_board *: [Board](main.md#bulletchess.main.Board)*

The starting position of this game. Determined by looking at the
“FEN” tag, if it is provided. Otherwise, is the same as the standard starting position.

#### \_\_getitem_\_(tag: str) → str | None

Gets the raw `str` value of the given tag. If the tag is absent,
returns `None`.

#### \_\_hash_\_() → int

#### \_\_eq_\_(other: Any) → bool

### *class* PGNFile

#### *static* open(path: str) → [PGNFile](#bulletchess.pgn.PGNFile)

Opens a PGN file for reading.

* **Raises:**
  `FileNotFoundError` If the given path does not lead to a file.

#### close() → None

Closes a PGN file. Closing an already closed file has no effect.

#### is_open() → bool

Returns `True` if this file is open.

#### next_game() → [PGNGame](#bulletchess.pgn.PGNGame) | None

Gets the next game from a file as a [`PGNGame`](#bulletchess.pgn.PGNGame)
If the file is exhausted of games, returns None.

* **Raises:**
  `ValueError` if an error is found while parsing.

#### skip_game() → None

Skips over the next game in a file.

#### \_\_enter_\_() → [PGNFile](#bulletchess.pgn.PGNFile)

#### \_\_exit_\_(exc_type, exc_val, exc_tb) → None
