import json
from bulletchess import *

with open("data/status.json") as f:
    data = json.load(f)

for fen in data:
    print(fen)
    board = Board.from_fen(fen)
    assert(len(board[KING]) == 2)
