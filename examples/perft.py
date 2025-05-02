import chess
import time


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

#board = chess.Board() # starting position

#start = time.time()
#result = chess_perft(board, 5)
#print(f"chess_perft returned {result} in {time.time() - start:.4}s") 

import sys
sys.path.append("./")
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
        for move in board.legal_moves():
            board.apply(move)
            nodes += bullet_perft(board, depth -1)
            board.undo()
        return nodes 

board = bulletchess.Board()

start = time.time()
result = chess_perft(chess.Board(), 5)
chess_time = time.time() - start
print(f"chess_perft returned {result} in {chess_time:.6}s")

start = time.time()
result = bullet_perft(board, 5)
bullet_time = time.time() - start
print(f"bullet_perft returned {result} in {bullet_time:.6}s") 

print(f"ratio is {chess_time/bullet_time:.6}")
"""
start = time.time()
result = utils.perft(board, 5)
print(f"built-in perft returned {result} in {time.time() - start:.4}s")

print("This is pre refactor results")
"""
