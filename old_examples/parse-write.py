import sys
import json
import time
sys.path.append("./")


import bulletchess
import chess

# JSON file with a list of 100k FENs
with open("data/fens.json", "r") as f:
    fens = json.load(f)

# "roundtrip" functions parse a list of FENs into
# Boards, then produce a new list of FENs from serializing
# each parsed Board into a FEN string. The output should list
# should be identical to the input

def bullet_roundtrip(fens : list[str]):
    boards = [bulletchess.Board.from_fen(fen)
              for fen in fens]
    return [board.fen() for board in boards]

def chess_roundtrip(fens : list[str]):
    boards = [chess.Board(fen) for fen in fens]
    return [board.fen(en_passant = "fen") for board in boards]



start = time.time()
bullet_fens = bullet_roundtrip(fens)
print(f"bullet_roundtrip took {time.time() - start:.4}s")

start = time.time()
chess_fens = chess_roundtrip(fens)
print(f"chess_roundtrip took {time.time() - start:.4}s")

assert(fens == bullet_fens)
assert(fens == chess_fens)
