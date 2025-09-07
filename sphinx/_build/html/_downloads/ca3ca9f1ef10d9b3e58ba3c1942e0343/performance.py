"""
Performance Comparisons
========================

``bulletchess``'s creation was motivated by my frustration with `python-chess <https://python-chess.readthedocs.io/en/latest/>`_'s slow performance, especially for areas such as machine learning and engine development. 
``python-chess`` is a fantastic, feature-rich library, but is inherently limited in its speed by being implemented in python. ``bulletchess``, however, is implemented as a pure C-extension, 
allowing it to be significantly faster. To demonstrate this, we can write equivalent functions in both libraries, and compare the runtimes.


.. note::
     ``bulletchess`` is neither an extension nor a port of ``python-chess``, and has a distinct and independent implementation. 

Let's start by implementing a `Perft <https://www.chessprogramming.org/Perft>`_ function. In ``bulletchess``:

"""

import bulletchess
from bulletchess.utils import count_moves

def bullet_perft(board : bulletchess.Board, depth : int) -> int:
    if depth == 0:
        return 1
    elif depth == 1:
        return count_moves(board)
    else:
        nodes = 0
        moves = board.legal_moves()
        for move in moves:
            board.apply(move)
            nodes += bullet_perft(board, depth - 1)
            board.undo()
        return nodes 

# %%
# And in ``python-chess``

import chess
def chess_perft(board : chess.Board, depth : int) -> int:
    if depth == 0:
        return 1
    elif depth == 1:
        return board.legal_moves.count()
    else:
        nodes = 0
        for move in board.legal_moves:
            board.push(move)
            nodes += chess_perft(board, depth - 1)
            board.pop()
        return nodes
    
# %%
# Notice how the code we write is nearly identical. However, when we test their run times:


from time import time

start = time()
result = chess_perft(chess.Board(), 6)
chess_time = time() - start
print(f"`chess_perft` returned {result} in {chess_time:.4f}s")

start = time()
bullet_perft(bulletchess.Board(), 6)
bullet_time = time() - start
print(f"`bullet_perft` returned {result} in {bullet_time:.4f}s")

print(f"bulletchess is {chess_time/bullet_time:.4f}x faster")

# %% 
# We see a massive difference in ``bulletchess``'s move generation and application speed. 
# ``bulletchess`` is also very fast at writing and parsing FEN strings. 

import json
# JSON file with a list of 1 million FENs
with open("../data/fens.json", "r") as f:
    fens = json.load(f)

# %%
# We can define FEN "roundtrip" functions in ``bulletchess`` and ``python-chess``, which will take in a list of FEN strings.
# Each FEN will be parsed to create a object representation for the position it describes.
# Then, each object will write a new FEN string describing itself, which should match the original.
# Neither library stores the given FEN when a board object is created,
# so both ``bulletchess`` and ``python-chess`` will fully parse and rewrite the input FENs.


def bullet_roundtrip(fens : list[str]):
    boards = [bulletchess.Board.from_fen(fen)
              for fen in fens]
    return [board.fen() for board in boards]


def chess_roundtrip(fens : list[str]):
    boards = [chess.Board(fen) for fen in fens]
    return [board.fen(en_passant = "fen") for board in boards]

# %%
# Like before, we'll compare the runtimes of each version.

start = time()
chess_fens = chess_roundtrip(fens)
chess_time = time() - start
print(f"`chess_roundtrip` took {chess_time:.4}s")

start = time()
bullet_fens = bullet_roundtrip(fens)
bullet_time = time() - start
print(f"`bullet_roundtrip` took {bullet_time:.4}s")

print(f"bulletchess is {chess_time/bullet_time:.4f}x faster")

assert(chess_fens == bullet_fens)

# %%
# Once again, ``bulletchess`` is much faster. Using the same dataset of FENs, lets compare checking if positions
# are checkmate, a draw, or ongoing. 


def chess_statuses(boards : list[chess.Board]) -> dict:
    outcomes = {"ongoing": 0, "checkmate": 0, "draw": 0}
    for board in boards:
        outcome = board.outcome(claim_draw = True)
        if outcome == None:
            outcomes["ongoing"] += 1
        elif outcome.winner != None:
            outcomes["checkmate"] += 1
        else:
            outcomes["draw"] += 1
    return outcomes


from bulletchess import CHECKMATE, DRAW
def bullet_statuses(boards : list[bulletchess.Board]) -> dict:
    outcomes = {"ongoing": 0, "checkmate": 0, "draw": 0}
    for board in boards:
        if board in CHECKMATE:
            outcomes["checkmate"] += 1
        elif board in DRAW:
            outcomes["draw"] += 1
        else:
            outcomes["ongoing"] += 1
    return outcomes

# %%
# The syntax of ``bulletchess`` and ``python-chess`` diverges more here,
# but the structure is still the same. Running the comparison:

chess_boards = [chess.Board(fen) for fen in fens]
bullet_boards = [bulletchess.Board.from_fen(fen) for fen in fens]

start = time()
chess_res = chess_statuses(chess_boards)
chess_time = time() - start
print(f"`chess_statuses` took {chess_time:.4}s")
print(chess_res)

start = time()
bullet_res = bullet_statuses(bullet_boards)
bullet_time = time() - start
print(f"`bullet_statuses` took {bullet_time:.4}s")
print(bullet_res)

print(f"bulletchess is {chess_time/bullet_time:.4f}x faster")

# %%
# The speed up is even larger. Like ``python-chess``, ``bulletchess`` provides a PGN reader. Let's do a simple task reading a PGN file,
# we'll go through every position in each game, and check how many have a pawn of any color on E4. 

import chess.pgn
import bulletchess.pgn
# a large PGN file
PATH = "../data/pgn/modern.pgn"

def chess_check_games():
    count = 0
    with open(PATH, "r") as f:
        game = chess.pgn.read_game(f)
        while game:
            board = chess.Board()
            for move in game.mainline_moves():
                board.push(move)
                if board.piece_type_at(chess.E4) == chess.PAWN:
                    count += 1
            game = chess.pgn.read_game(f)
    return count

def bullet_check_games():
    count = 0
    with bulletchess.pgn.PGNFile.open(PATH) as f:
        game = f.next_game()
        while game:
            board = game.starting_board
            for move in game.moves:
                board.apply(move)
                piece = board[bulletchess.E4]
                if piece and piece.piece_type == bulletchess.PAWN:
                    count += 1
            game = f.next_game()
    return count


# %% 
# We've kept the operation on each position simple on purpose, so we can more directly compare 
# reading through games.

start = time()
chess_res = chess_check_games()
chess_time = time() - start
print(f"`chess_check_games` took {chess_time:.4}s")
print(f"python-chess found {chess_res} positions with a pawn on E4")

start = time()
bullet_res = bullet_check_games()
bullet_time = time() - start
print(f"`bullet_check_games` took {bullet_time:.4}s")
print(f"bulletchess found {bullet_res} positions with a pawn on E4")

print(f"bulletchess is {chess_time/bullet_time:.4f}x faster")

            
