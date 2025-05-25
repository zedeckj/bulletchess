"""
Basic Walkthrough
=================

First, lets import everything from ``bulletchess``
"""

from bulletchess import *

# %%
# The :func:`Board()` constructor returns a :class:`Board` representing the starting position.
# 

board = Board()
board

# %%
# the :class:`Board` class defines :func:`Board._repr_html_()`, which allows positions to be rendered
# like the above in Jupyter note books, or Sphinx documenation like this page.
# For displaying a :class:`Board` as plain text, we use :func:`Board.__str__()`

print(str(board))

# %% 
# Other positions can be specified by either using :func:`Board.from_fen()`. When rendering a :class:`Board` as HTML, the side to move is always oriented on the bottom. 

board = Board.from_fen("rnbqkbnr/pp1ppppp/8/2p5/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq - 1 2")
board

# %%
# Or by assigning :class:`Piece` locations manually. We can use :func:`Board.empty()` to start from a clean slate.

board = Board.empty()
board

# %%
# And then assign a :class:`Piece` to each :class:`Square`.
#

board[G2] = Piece(WHITE, KING)
board[F2] = Piece(WHITE, PAWN)
board[G3] = Piece(WHITE, PAWN)
board[H2] = Piece(WHITE, PAWN)
board[B3] = Piece(WHITE, ROOK)

board[F7] = Piece(BLACK, KING)
board[D7] = Piece(BLACK, ROOK)
board[F6] = Piece(BLACK, PAWN)
board[G7] = Piece(BLACK, PAWN)

board

# %%
# We can get the FEN of this position with :func:`Board.fen()`. We might want to set the halfmove clock
# and fullmove number for this endgame position. Let's also make it black's turn.

board.halfmove_clock = 3
board.fullmove_number = 43
board.turn = BLACK

board.fen()

# %%
# Indexing a :class:`Board` with a :class:`Color`, :class:`PieceType`, or both returns :class:`Bitboard` 
# of squares with the relevant kind of :class:`Piece`. A :class:`Bitboard` is simply an efficient representation 
# of a set of squares.

print(board[WHITE])
print(board[ROOK])
print(board[BLACK, PAWN])

# %%
# We can generate legal :class:`Move` objects for this position with :func:`Board.legal_moves()`

moves = board.legal_moves()
print(moves)

# %%
# Lets move our rook. To perform a move, we use :func:`Board.apply()`. 
# Moves can be created manually with the :func:`Move()` constructor.

selected_move = Move(D7, D3)
board.apply(selected_move)
board


# %% 
# Oh, but that was a blunder. moves can be undone with `Board.undo()`, which returns
# the last :class:`Move` applied. Getting the `str` of a :class:`Move` renders the move
# in UCI long algebraic notation.

print("Undoing " + str(board.undo()))
board


# %% 
# Lets run the game through for a bit. Moves can also be constructed from UCI or standard algebraic notation.

board.apply(Move.from_san("g5", board))
board.apply(Move.from_uci("h2h4"))
board.apply(Move(G5, H4))
board.apply(Move(G3, H4))
board.apply(Move.from_san("Kg7", board))
board.apply(Move.from_san("Rg3", board))
board

# %%
# Black exposed their king, and is now in check.

board in CHECK

# %%
# But the game is still ongoing.

board in CHECKMATE or board in DRAW

