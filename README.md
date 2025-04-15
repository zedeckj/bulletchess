## `bulletchess`

`bulletchess` is a Python module for playing, analyzing, and building engines for chess. Unlike other chess libraries in Python, the core of `bulletchess` is written in C, allowing it to be **much** more performant than alternatives.

The examples provided compare the performance of `bulletchess` against the popular library `python-chess`. The origin of `bulletchess` stemmed from a realization that the speed of `python-chess` was restrictive in my personal machine learning projects for chess. As a long-time user of `python-chess` I've happened to model much of the API of `bulletchess`
off of `python-chess`, mostly out of comfort for what is familiar. I've used `python-chess` singificantly in testing `bulletchess`, but have not taken any actual code from the library, or referenced its inner workings to any real extent. It was much easier for me to experiment by trial and error, rather than attempt to simply port `python-chess` to C and write a wrapper around it. That wouldn't have been as much fun anyway. 

### Overview
``` python
>>> board = Board()
>>> print(board)
r n b q k b n r 
p p p p p p p p 
- - - - - - - - 
- - - - - - - - 
- - - - - - - - 
- - - - - - - - 
P P P P P P P P 
R N B Q K B N R 

>>> board.get_piece_at(E1)
Piece(K)
>>> board.legal_moves()
[Move(b1a3), Move(b1c3), Move(g1f3), Move(g1h3), Move(a2a3), 
Move(a2a4), Move(b2b3), Move(b2b4), Move(c2c3), Move(c2c4), 
Move(d2d3), Move(d2d4), Move(e2e3), Move(e2e4), Move(f2f3), 
Move(f2f4), Move(g2g3), Move(g2g4), Move(h2h3), Move(h2h4)]
```

At a high level, `bulletchess` includes:
- A complete game model with intuitive representations for pieces, moves, and positions.
- Extensively tested legal move generation, application, and undoing.
- Parsing and writing of positions specified in [Forsyth-Edwards Notation](https://www.chessprogramming.org/Forsyth-Edwards_Notation) (FEN), 
and moves specified in both [Long Algebraic Notation](https://www.chessprogramming.org/Algebraic_Chess_Notation#Long_Algebraic_Notation_.28LAN.29) and [Standard Algebraic Notation](https://www.chessprogramming.org/Algebraic_Chess_Notation#Standard_Algebraic_Notation_.28SAN.29).
- Methods to determine if a position is check, checkmate, stalemate, and each specific type of draw.
- Efficient hashing of positions using [Zobrist Keys](https://en.wikipedia.org/wiki/Zobrist_hashing).
- Utility functions for writing engines. 

### Examples

#### Move Generation
Consider the following nearly identical implementations of 
[Perft](https://www.chessprogramming.org/Perft) in `python-chess` 
and `bulletchess`:

```python
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
```

```python
import bulletchess
from bulletchess import utils

def bullet_perft(board : bulletchess.Board, depth : int) -> int:
    if depth == 0:
        return 1
    elif depth == 1:
        return utils.count_moves(board)
    else:
        nodes = 0
        for move in board.legal_moves():
            board.apply(move)
            nodes += bullet_perft(board, depth -1)
            board.undo()
        return nodes 
```

Comparing the results and run times...
```python
import time
chess_board = chess.Board() 
bullet_board = bulletchess.Board()
# same starting position

start = time.time()
result = chess_perft(chess_board, 5)
print(f"chess_perft returned {result} in {time.time() - start:.4}s") 


start = time.time()
result = bullet_perft(bullet_board, 5)
print(f"bullet_perft returned {result} in {time.time() - start:.4}s") 
```

`bulletchess` is almost 11x faster.

```
chess_perft returned 4865609 in 3.703s
bullet_perft returned 4865609 in 0.343s
```

A `perft` function with a backend fully in C is provided in `bulletchess.utils`, which is even faster:

```
built-in perft returned 4865609 in 0.04637s
```

#### Parsing and Writing FEN

`bulletchess` is performant in parsing and writing positions specified in [Forsyth-Edwards Notation](https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation), or FEN. 

Another example, comparing `bulletchess` to `python-chess`:

```python
import json
# JSON file with a list of 100k FENs
with open("fens.json", "r") as f:
    fens = json.load(f)

# "roundtrip" functions parse a list of FENs into
# Boards, then produce a new list of FENs from serializing
# each parsed Board into a FEN string. The output list
# should be identical to the input

import bulletchess
def bullet_roundtrip(fens : list[str]):
    boards = [bulletchess.Board.from_fen(fen)
              for fen in fens]
    return [board.fen() for board in boards]

import chess
def chess_roundtrip(fens : list[str]):
    boards = [chess.Board(fen) for fen in fens]
    return [board.fen(en_passant = "fen") for board in boards]


import time
start = time.time()
bullet_fens = bullet_roundtrip(fens)
print(f"`bullet_roundtrip` took {time.time() - start:.4}")

start = time.time()
chess_fens = chess_roundtrip(fens)
print(f"`chess_roundtrip` took {time.time() - start:.4}")

assert(fens == bullet_fens)
assert(fens == chess_fens)
```

```
bullet_roundtrip took 0.4865s
chess_roundtrip took 4.186s
```

#### Board Analysis

Using the same dataset of FENs, lets compare `bulletchess` to `python-chess` in checking the number of positions that are checkmate, a draw, or ongoing. 

``` python
from bulletchess import *
def bullet_statuses(boards : list[Board]) -> dict:
    outcomes = {"ongoing": 0, "checkmate": 0, "draw": 0}
    for board in boards:
        if board.status.checkmate:
            outcomes["checkmate"] += 1
        elif board.status.claim_draw:
            outcomes["draw"] += 1
        else:
            outcomes["ongoing"] += 1
    return outcomes
```

``` python
import chess
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
```

```
bulletchess results:
{'ongoing': 93477, 'checkmate': 3910, 'draw': 2613}
took: 0.2492s
python-chess results:
{'ongoing': 93477, 'checkmate': 3910, 'draw': 2613}
took: 10.98s
```

### Other Features

#### Hashing

`python-chess`'s `Board` class does not implement the `__hash__` method, making `Board` instances unable to be put directly in `sets` and as keys in `dicts`

```python
>>> from chess import *
>>> {Board() : 0}
Traceback (most recent call last):
  File "<python-input-1>", line 1, in <module>
    {Board() : 0}
TypeError: unhashable type: 'Board'
```

`bulletchess` does, using a hash function written in the C backend. This makes doing any large scale data analysis using chess positions much quicker.

``` python
def bullet_piece_at_e1(boards : list[bulletchess.Board]):
    return {board:board.get_piece_at(bulletchess.E1)
            for board in boards}

def chess_piece_at_e1(boards : list[chess.Board]):
    return {board.fen() : board.piece_at(chess.E1)
            for board in boards}
```

```
bullet_piece_at_e1 took: 0.1034s
chess_piece_at_e1 took: 1.919s
```

#### Plans and TODO

This project is a work in progress and not in its release stage. Before making installable via `pip`, I'd like to clean up some internal object representations and provide more utility functions. 
Major new features are still planned, specifically the parsing of [Portable Game Notation](https://en.wikipedia.org/wiki/Portable_Game_Notation), as well as a "prefab" configurable [UCI](https://en.wikipedia.org/wiki/Universal_Chess_Interface) engine.
