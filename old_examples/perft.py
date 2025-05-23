import chess
import time
import numpy

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


import sys
sys.path.append("../")

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



start = time.time()
result = chess_perft(chess.Board(), 6)
chess_time = time.time() - start
print(f"chess_perft returned {result} in {chess_time:.4f}s")

start = time.time()
bullet_perft(bulletchess.Board(), 6)
bullet_time = time.time() - start
print(f"bullet_perft returned {result} in {bullet_time:.4f}s")

print(f"bulletchess is {chess_time/bullet_time:.4f}x faster")
