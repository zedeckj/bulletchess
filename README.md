## `bulletchess`

`bulletchess` is a Python module for playing, analyzing, and building engines for chess. Unlike other chess libraries in Python, the core of `bulletchess` is written in C, allowing it to be **much** more performant than alternatives.


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

#### Parsing and Writing FEN

`bulletchess` is performant in parsining and writing positions specified in [Forsyth-Edwards Notation](https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation), or FEN. 

Another example, comparing `bulletchess` and `python-chess`:

```python
import json
# JSON file with a list of 100k FENs
with open("fens.json", "r") as f:
    fens = json.load(f)

# "roundtrip" functions parse a list of FENs into
# Boards, then produce a new list of FENs from serializing
# each parsed Board into a FEN string. The output should list
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


