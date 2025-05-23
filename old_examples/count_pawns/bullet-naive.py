import sys
import json
sys.path.append("./")
from bulletchess import *

with open("examples/fens.json", "r") as f:
    fens = json.load(f)
boards = [Board.from_fen(fen) for fen in fens]
pawns = 0
for board in boards:
    for square in SQUARES:
        piece = board.get_piece_at(square) # instinct was `piece_at`
        if piece != None and piece.piece_type == PAWN: # and `type`, None check is annoying
            pawns += 1

print(pawns/len(boards))
