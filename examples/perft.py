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

board = chess.Board() # starting position

start = time.time()
result = chess_perft(board, 5)
print(f"chess_perft returned {result} in {time.time() - start:.4}s") 

import sys
sys.path.append("../")
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

board = bulletchess.Board()

start = time.time()
result = bullet_perft(board, 5)
print(f"bullet_perft returned {result} in {time.time() - start:.4}s") 

start = time.time()
result = utils.perft(board, 5)
print(f"built-in perft returned {result} in {time.time() - start:.4}s")

