import json
from chess import *



with open("examples/fens.json", "r") as f:
    fens = json.load(f)
boards = [Board(fen) for fen in fens]
pawns = 0
for board in boards:
    for square in range(64):
        piece = board.piece_at(square)
        if piece != None and piece.piece_type == PAWN: 
            pawns += 1

print(pawns)
