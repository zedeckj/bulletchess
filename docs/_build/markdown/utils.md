# Utilities

### count_moves(board: [Board](main.md#bulletchess.main.Board)) → int

Counts the number of legal moves that could be performed for the given `Board`, without actually
constructing any `Move` objects. This is much faster than calling 
`len(Board.legal_moves())`

### evaluate(board: [Board](main.md#bulletchess.main.Board))

A simple heuristic function for the utility of a `Board`
based on Claude Shannon’s example evaluation function.
This implementation differs in using centipawns instead of fractional values,
and explicitly evaluates positions which can be claimed as a draw as 0.
The number of Kings is reconsidered as whether or not a player is in Checkmate.

\`\`
f(P) = 200(K-K’) + 9(Q-Q’) + 5(R-R’) + 3(B-B’+N-N’) + (P-P’) - 0.5(D-D’+S-S’+I-I’) + 0.1(M-M’)

in which: -
(1) K,Q,R,B,B,P are the number of White kings, queens, rooks, bishops, knights
and pawns on the board.
(2) D,S,I are doubled, backward and isolated White pawns.
(3) M= White mobility (measured, say, as the number of legal moves available to
White).

Primed letters are the similar quantities for Black.\`\`

Shannon, C. E. (1950). XXII. Programming a computer for playing chess. The London, 
Edinburgh, and Dublin Philosophical Magazine and Journal of Science, 41(314), 256–27    
5. [https://doi.org/10.1080/14786445008521796](https://doi.org/10.1080/14786445008521796)

### is_quiescent(board: [Board](main.md#bulletchess.main.Board)) → bool

Determines if the given `Board`’s position is ‘quiescent’, meaning that the position is not Check,
and that there are  no possible captures that could be made on this turn.

### perft(board: [Board](main.md#bulletchess.main.Board), depth: int) → int

Performs a tree walk of legal moves starting from the provided `Board`, 
and returns the number of leaf nodes at the given depth. For more information, 
see: [https://www.chessprogramming.org/Perft](https://www.chessprogramming.org/Perft)

### perft_fen(fen: str, depth: int) → int

Sames as `utils.perft()`, but takes a Forsyth-Edwards Notation `str` description of a position instead of a `Board`.

### backwards_pawns(board: [Board](main.md#bulletchess.main.Board), color: [Color](main.md#bulletchess.main.Color) | None = None) → [Bitboard](main.md#bulletchess.main.Bitboard)

Returns a `Bitboard` containing all `Square` values with a backwards pawn for the given `Board`.

A backwards pawn is defined as a pawn that:
- is behind all other friendly pawns in its own and adjacent files.
- has no enemy pawn directly in front of it
- can not advance without being attacked by an enemy pawn

board = Board.from_fen(“4k3/2p3p1/1p2p2p/1P2P2P/1PP3P1/4P3/8/4K3 w - - 0 1”)
>>> print(board)
- - - - k - - - 
- - p - - - p - 
- p - - p - - p 
- P - - P - - P 
- P P - - - P - 
- - - - P - - - 
- - - - - - - - 
- - - - K - - -

```pycon
>>> print(backwards_pawns(board))
0 0 0 0 0 0 0 0 
0 0 1 0 0 0 1 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 1 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
```

### isolated_pawns(board: [Board](main.md#bulletchess.main.Board), color: [Color](main.md#bulletchess.main.Color) | None = None) → [Bitboard](main.md#bulletchess.main.Bitboard)

Returns a `Bitboard` containing all `Square` values with an isolated pawn for the given `Board`.

An isolated pawn is defined as a pawn with no friendly pawns in adjacent files.

board = Board.from_fen(“4k3/2p3p1/1p2p2p/1P2P2P/1PP3P1/4P3/8/4K3 w - - 0 1”)
>>> print(board)
- - - - k - - - 
- - p - - - p - 
- p - - p - - p 
- P - - P - - P 
- P P - - - P - 
- - - - P - - - 
- - - - - - - - 
- - - - K - - -

```pycon
>>> print(isolated_pawns(board))
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 1 0 0 0 
0 0 0 0 1 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 1 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
```

### doubled_pawns(board: [Board](main.md#bulletchess.main.Board), color: [Color](main.md#bulletchess.main.Color) | None = None) → [Bitboard](main.md#bulletchess.main.Bitboard)

Returns a `Bitboard` containing all `Square` values with a passed pawn for the given `Board`.

A doubled pawn is defined as a pawn with a friendly pawn in the same file.

board = Board.from_fen(“4k3/2p3p1/1p2p2p/1P2P2P/1PP3P1/4P3/8/4K3 w - - 0 1”)
>>> print(board)
- - - - k - - - 
- - p - - - p - 
- p - - p - - p 
- P - - P - - P 
- P P - - - P - 
- - - - P - - - 
- - - - - - - - 
- - - - K - - -

```pycon
>>> print(doubled_pawns(board))
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 1 0 0 1 0 0 0 
0 1 0 0 0 0 0 0 
0 0 0 0 1 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
```

### passed_pawns(board: [Board](main.md#bulletchess.main.Board), color: [Color](main.md#bulletchess.main.Color) | None = None) → [Bitboard](main.md#bulletchess.main.Bitboard)

Returns a `Bitboard` containing all `Square` values with a passed pawn for the given `Board`.

A passed pawn is defined as a pawn with no enemy pawns in its file or adjacent files which can
block it from advancing forward, ulitmately to promote.

```pycon
>>> board = Board.from_fen("7k/8/7p/1P2Pp1P/2Pp1PP1/8/8/7K w - - 0 1")
>>> print(board)
- - - - - - - k 
- - - - - - - - 
- - - - - - - p 
- P - - P p - P 
- - P p - P P - 
- - - - - - - - 
- - - - - - - - 
- - - - - - - K 
```

```pycon
>>> print(passed_pawns(board))
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 1 0 0 1 0 0 0 
0 0 1 1 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
```

### is_pinned(board: [Board](main.md#bulletchess.main.Board), square: [Square](main.md#bulletchess.main.Square)) → bool

Returns `True` if the given `Square` has a piece which is pinned in the given `Board`.

A piece is considered pinned if it is not allowed to move at all, as doing so would place the moving player’s king in check.

```pycon
>>> board = Board.from_fen("rnbqk1nr/pppp1ppp/8/4p3/1b6/2NP4/PPP1PPPP/R1BQKBNR w KQkq - 1 3")
>>> print(board)
r n b q k - n r 
p p p p - p p p 
- - - - - - - - 
- - - - p - - - 
- b - - - - - - 
- - N P - - - - 
P P P - P P P P 
R - B Q K B N R 
```

```pycon
>>> is_pinned(board, A1)
False
>>> is_pinned(board, D3)
False
>>> is_pinned(board, C3)
True
```

### attack_mask(board: [Board](main.md#bulletchess.main.Board), attacker: [Color](main.md#bulletchess.main.Color)) → [Bitboard](main.md#bulletchess.main.Bitboard)

Returns a `Bitboard` of containing all squares which are being attacked by the specified `Color`.

```pycon
>>> board = Board()
>>> print(attack_mask(board, WHITE))
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
1 1 1 1 1 1 1 1 
1 1 1 1 1 1 1 1 
0 1 1 1 1 1 1 0 
```

```pycon
>>> board = Board.from_fen("7k/8/8/1r6/8/8/8/7K w - - 0 1")
>>> print(board)
- - - - - - - k 
- - - - - - - - 
- - - - - - - - 
- r - - - - - - 
- - - - - - - - 
- - - - - - - - 
- - - - - - - - 
- - - - - - - K 
```

```pycon
>>> print(attack_mask(board, BLACK))
0 1 0 0 0 0 1 0 
0 1 0 0 0 0 1 1 
0 1 0 0 0 0 0 0 
1 0 1 1 1 1 1 1 
0 1 0 0 0 0 0 0 
0 1 0 0 0 0 0 0 
0 1 0 0 0 0 0 0 
0 1 0 0 0 0 0 0 
```

### material(board: [Board](main.md#bulletchess.main.Board), pawn_value: int = 100, knight_value: int = 300, bishop_value: int = 300, rook_value: int = 500, queen_value: int = 900) → int

Calculates the net material value on the provided `Board`. By default,
uses standard evaluations of each `PieceType` measured in centipawns.

### mobility(board: [Board](main.md#bulletchess.main.Board)) → int

Returns the number of moves for the `Board` as if it were it the `WHITE`’s turn,
subtracted by the number of moves as if it were `BLACK`’s turn.

### open_files(board: [Board](main.md#bulletchess.main.Board)) → [Bitboard](main.md#bulletchess.main.Bitboard)

Returns a `Bitboard` of all files that have no pawns of either `Color`.

```pycon
>>> board = Board.from_fen("4k3/2p3p1/1p2p2p/1P2P2P/1PP3P1/4P3/8/4K3 w - - 0 1")
>>> print(board)
- - - - k - - - 
- - p - - - p - 
- p - - p - - p 
- P - - P - - P 
- P P - - - P - 
- - - - P - - - 
- - - - - - - - 
- - - - K - - - 
```

```pycon
>>> print(open_files(board))
1 0 0 1 0 1 0 0 
1 0 0 1 0 1 0 0 
1 0 0 1 0 1 0 0 
1 0 0 1 0 1 0 0 
1 0 0 1 0 1 0 0 
1 0 0 1 0 1 0 0 
1 0 0 1 0 1 0 0 
1 0 0 1 0 1 0 0 
```

### half_open_files(board: [Board](main.md#bulletchess.main.Board), for_color: [Color](main.md#bulletchess.main.Color)) → [Bitboard](main.md#bulletchess.main.Bitboard)

Returns a `Bitboard` of all files that have no pawns of the given `Color`, but do 
have pawns of the opposite :class:

```
`
```

Color.

```pycon
>>> board = Board.from_fen("3k4/8/4p3/4P3/5PP1/8/8/3K4 w - - 0 1")
>>> print(board)
- - - k - - - - 
- - - - - - - - 
- - - - p - - - 
- - - - P - - - 
- - - - - P P - 
- - - - - - - - 
- - - - - - - - 
- - - K - - - - 
```

```pycon
>>> print(half_open_files(board, WHITE))
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
```

```pycon
>>> print(half_open_files(board, BLACK))
0 0 0 0 0 1 1 0 
0 0 0 0 0 1 1 0 
0 0 0 0 0 1 1 0 
0 0 0 0 0 1 1 0 
0 0 0 0 0 1 1 0 
0 0 0 0 0 1 1 0 
0 0 0 0 0 1 1 0 
0 0 0 0 0 1 1 0 
```

### random_legal_move(board: [Board](main.md#bulletchess.main.Board)) → [Move](main.md#bulletchess.main.Move) | None

Returns a random legal `Move` for the given `Board`.

This is much faster than `random.choice(board.legal_moves())`.

```pycon
>>> board = Board()
>>> random_legal_move(board)
<Move: g1h3>
>>> random_legal_move(board)
<Move: d2d3>
```

### random_board() → [Board](main.md#bulletchess.main.Board)

Returns a `Board` with a position determined by appling a random number of randomly selected legal moves.
The generated `Board` may be checkmate or a draw.

```pycon
>>> board = random_board()
>>> print(board)
r Q - - k - - r 
- b - p n p p - 
p b - - p - - - 
- - - - - - P - 
- p P - - - p - 
N - - - - N - - 
P - - P P P - - 
R - B - K - - - 
```

```pycon
>>> board2 = random_board()
>>> print(board2)
- - K - - - - - 
- - - - - - - - 
- - - - - - - - 
- - - - - - - - 
- - - - - - - - 
- - - - - - - - 
- k - - - - - - 
- - - - - - - - 
```

### legally_equal(board1: [Board](main.md#bulletchess.main.Board), board2: [Board](main.md#bulletchess.main.Board)) → bool

Returns `True` if given two `Board` instances with the same mapping of `Square` to `Piece` objects,
equivilant `CastlingRights`, and en-passant `Square` values.

Unlike `Board.__eq__()`, does not check the halfmove clock and fullmove number.

```pycon
>>> board = Board()
>>> board2 = Board()
>>> board.halfmove_clock = 10
>>> board == board2
False
>>> legally_equal(board, board2)
True
```

### deeply_equal(board1: [Board](main.md#bulletchess.main.Board), board2: [Board](main.md#bulletchess.main.Board)) → bool

Returns `True` if given two `Board` instances have the same move history,
along with equivalent mappings of `Square` to `Piece` objects,
equivilant `CastlingRights`, and en-passant `Square` values, halfmove clocks, and fullmove numbers.

This function has the same behavior as `board1 == board2 and board1.history == board2.history`, but is much faster.

```pycon
>>> board = Board()
>>> board2 = Board()
>>> board.apply(Move(E2, E4))
>>> board2[E2] = None
>>> board2[E4] = Piece(WHITE, PAWN)
>>> board2.turn = BLACK
>>> board2.en_passant_square = E3
>>> board == board2
True
>>> deeply_equal(board, board2)
False
```

### piece_bitboard(board: [Board](main.md#bulletchess.main.Board), piece: [Piece](main.md#bulletchess.main.Piece)) → [Bitboard](main.md#bulletchess.main.Bitboard)

Gets a `Bitboard` of squares with the given `Piece` on the given `Board`.

```pycon
>>> from bulletchess import *
>>> piece = Piece(WHITE, PAWN)
>>> board = Board()
>>> bb = piece_bitboard(board, piece)
>>> print(bb)
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
1 1 1 1 1 1 1 1 
0 0 0 0 0 0 0 0 
```

```pycon
>>> bb == board[WHITE, PAWN]
True
```

### unoccupied_bitboard(board: [Board](main.md#bulletchess.main.Board)) → [Bitboard](main.md#bulletchess.main.Bitboard)

An explict alias for indexing a `Board` with `None`.

Gets a `Bitboard` of all empty squares on the given `Board`.

```pycon
>>> board = Board()
>>> bb = unoccupied_bitboard(board)
>>> print(bb)
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
1 1 1 1 1 1 1 1 
1 1 1 1 1 1 1 1 
1 1 1 1 1 1 1 1 
1 1 1 1 1 1 1 1 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
```

```pycon
>>> bb == board[None]
True
```

### white_bitboard(board: [Board](main.md#bulletchess.main.Board)) → [Color](main.md#bulletchess.main.Color)

An explict alias for indexing a `Board` with `WHITE`.

Gets a `Bitboard` of all squares with a white piece on the given `Board`.

```pycon
>>> board = Board()
>>> bb = white_bitboard(board)
>>> print(bb)
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
1 1 1 1 1 1 1 1 
1 1 1 1 1 1 1 1 
```

```pycon
>>> bb == board[WHITE]
True
```

### black_bitboard(board: [Board](main.md#bulletchess.main.Board)) → [Color](main.md#bulletchess.main.Color)

An explict alias for indexing a `Board` with `BLACK`.

Gets a `Bitboard` of all squares with a black piece on the given `Board`.

```pycon
>>> board = Board()
>>> bb = black_bitboard(board)
>>> print(bb)
1 1 1 1 1 1 1 1 
1 1 1 1 1 1 1 1 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
```

```pycon
>>> bb == board[BLACK]
True
```

### king_bitboard(board: [Board](main.md#bulletchess.main.Board)) → [Color](main.md#bulletchess.main.Color)

An explict alias for indexing a `Board` with `KING`.

Gets a `Bitboard` of all squares with a king on the given `Board`.

```pycon
>>> board = Board()
>>> bb = king_bitboard(board)
>>> print(bb)
0 0 0 0 1 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 1 0 0 0 
```

```pycon
>>> bb == board[KING]
True
```

### queen_bitboard(board: [Board](main.md#bulletchess.main.Board)) → [Color](main.md#bulletchess.main.Color)

An explict alias for indexing a `Board` with `QUEEN`.

Gets a `Bitboard` of all squares with a queen on the given `Board`.

## Examples

```pycon
>>> board = Board()
>>> bb = queen_bitboard(board)
>>> print(bb)
0 0 0 1 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 1 0 0 0 0 
```

```pycon
>>> bb == board[QUEEN]
True
```

### bishop_bitboard(board: [Board](main.md#bulletchess.main.Board)) → [Color](main.md#bulletchess.main.Color)

An explict alias for indexing a `Board` with `BISHOP`.

Gets a `Bitboard` of all squares with a bishop on the given `Board`.

```pycon
>>> board = Board()
>>> bb = bishop_bitboard(board)
>>> print(bb)
0 0 1 0 0 1 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 1 0 0 1 0 0 
```

```pycon
>>> bb == board[BISHOP]
True
```

### rook_bitboard(board: [Board](main.md#bulletchess.main.Board)) → [Color](main.md#bulletchess.main.Color)

An explict alias for indexing a `Board` with `ROOK`.

Gets a `Bitboard` of all squares with a rook on the given `Board`.

```pycon
>>> board = Board()
>>> bb = rook_bitboard(board)
>>> print(bb)
1 0 0 0 0 0 0 1 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
1 0 0 0 0 0 0 1 
```

```pycon
>>> bb == board[ROOK]
True
```

### pawn_bitboard(board: [Board](main.md#bulletchess.main.Board)) → [Color](main.md#bulletchess.main.Color)

An explict alias for indexing a `Board` with `PAWN`.

Gets a `Bitboard` of all squares with a pawn on the given `Board`.

```pycon
>>> board = Board()
>>> bb = pawn_bitboard(board)
>>> print(bb)
0 0 0 0 0 0 0 0 
1 1 1 1 1 1 1 1 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
1 1 1 1 1 1 1 1 
0 0 0 0 0 0 0 0 
```

```pycon
>>> bb == board[PAWN]
True
```

### knight_bitboard(board: [Board](main.md#bulletchess.main.Board)) → [Color](main.md#bulletchess.main.Color)

An explict alias for indexing a `Board` with `KNIGHT`.

Gets a `Bitboard` of all squares with a knight on the given `Board`.

```pycon
>>> board = Board()
>>> bb = knight_bitboard(board)
>>> print(bb)
0 1 0 0 0 0 1 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 1 0 0 0 0 1 0 
```

```pycon
>>> bb == board[KNIGHT]
True
>>> 
```

### king_square(board: [Board](main.md#bulletchess.main.Board), color: [Color](main.md#bulletchess.main.Color)) → [Square](main.md#bulletchess.main.Square)

Gets the `Square` which has the the king of the specified `Color` on the given `Board`.

* **Raises:**
  `AttributeError` if the given `Board` has multiple kings of the given `Color`.

```pycon
>>> board = Board()
>>> king_square(board, WHITE) is E1
True
>>> king_square(board, BLACK) is E8
True
```
