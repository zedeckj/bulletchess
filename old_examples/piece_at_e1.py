import time
import chess
import json
import sys
sys.path.append("../")
import bulletchess


# JSON file with a list of 1m FENs
with open("fens.json", "r") as f:
    fens = json.load(f)[:100_000]

bullet_boards = [bulletchess.Board.from_fen(fen) for fen in fens]
chess_boards = [chess.Board(fen) for fen in fens]

def bullet_piece_at_e1(boards : list[bulletchess.Board]):
    return {board:board.get_piece_at(bulletchess.E1)
            for board in boards}

def chess_piece_at_e1(boards : list[chess.Board]):
    return {board.fen() : board.piece_at(chess.E1)
            for board in boards}

start = time.time()
bullet_piece_at_e1(bullet_boards)
print(f"bullet_piece_at_e1 took: {time.time() - start:.4}s")


start = time.time()
chess_piece_at_e1(chess_boards)
print(f"chess_piece_at_e1 took: {time.time() - start:.4}s")


