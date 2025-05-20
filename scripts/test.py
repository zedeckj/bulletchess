import sys
sys.path.append("./")
from bulletchess import *
board = Board.from_fen("rn2qb2/3bpk1r/p4n1p/2p3pP/7K/4PPP1/PPPPN3/RNB4R w - g6 0 15")
moves = board.legal_moves()
print(moves, utils.count_moves(board), board in MATE)