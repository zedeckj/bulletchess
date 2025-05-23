import time
import sys
import json
sys.path.append("../")
from bulletchess import *
import chess

# JSON file with a list of 1m FENs
with open("fens.json", "r") as f:
    fens = json.load(f)[:100_000]


bullet_boards = [Board.from_fen(fen) for fen in fens]

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


print("bulletchess results")
start = time.time()
print(bullet_statuses(bullet_boards))
print(f"took: {time.time() - start:.4}s")

chess_boards = [chess.Board(fen) for fen in fens]

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

print("python-chess results")
start = time.time()
print(chess_statuses(chess_boards))
print(f"took: {time.time() - start:.4}s")

"""
def bullet_draws(boards : list[Board]) -> list[str]:
    out = []
    for board in boards:
        if board.status.claim_draw:
            out.append(board.fen())
    return out

def chess_draws(boards : list[Board]) -> list[str]:
    out = []
    for board in boards:
        outcome = board.outcome(claim_draw = True)
        if outcome != None and outcome.winner == None:
            out.append(board.fen(en_passant = "legal"))
    return out

bd = bullet_draws([Board.from_fen(fen) for fen in fens])
cd = chess_draws([chess.Board(fen) for fen in fens])
for fen in cd:
    if fen not in bd:
        print(fen)
        board = Board.from_fen(fen)
        print(board.status.claim_draw)
"""

