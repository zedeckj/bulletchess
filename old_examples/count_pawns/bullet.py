import sys
import json
sys.path.append("./")
from bulletchess import *

with open("examples/fens.json", "r") as f:
    fens = json.load(f)
boards = [Board.from_fen(fen) for fen in fens]
pawns = 0
for board in boards:
    pawns += board.count_piece_type(PAWN)

print(pawns/len(boards))
