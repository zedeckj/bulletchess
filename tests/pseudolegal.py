import sys
sys.path.append("./")
import unittest
import bulletchess
import chess
import testing_utils
import random
import time
from bulletchess import *

test_speed = False

# class TestApplyMove(unittest.TestCase):


#     def test_pseudo_legal_no_castling(self):
#         COUNT = 1000
#         chess_boards = [testing_utils.random_chess_board() for _ in range(COUNT)]
#         bullet_boards = [testing_utils.make_bullet_from_chess(board) for board in chess_boards]
#         for i in range(COUNT):
#             moves = {m.uci() for m in list(chess_boards[i].pseudo_legal_moves) if not chess_boards[i].is_castling(m)}
#             moves2 = {str(m) for m in bullet_boards[i].pseudo_legal_moves()}
#             sorted(moves)
#             sorted(moves2)
#             for move in moves2:
#                 self.assertIn(move, moves, msg = f"\nFor Board:\n\n{chess_boards[i].fen()}\nGenerated: {sorted(list(moves2))}")
#             for move in moves:
#                self.assertIn(move, moves2, msg = f"\nNot generating a legal move For Board:\n\n{chess_boards[i].fen()}")

#     def test_legal_speed_no_checks(self):
#         if (not test_speed):
#             return
#         COUNT = 1000
#         chess_boards = []
#         while len(chess_boards) < COUNT:
#             board = testing_utils.random_chess_board()
#             if not board.is_check():
#                 chess_boards.append(board)        
#         bullet_boards = [testing_utils.make_bullet_from_chess(board) for board in chess_boards]
#         t = time.time()
#         for i in range(COUNT):
#             list(chess_boards[i].legal_moves)
#         t = time.time() - t
#         time.sleep(2)
#         t2 = time.time()
#         for i in range(COUNT):
#             bullet_boards[i].legal_moves()
#         t2 = time.time() - t2
#         print(f"\nFinding Pseudo Legal Moves for {COUNT} boards took:\npython-chess: {t}\nbullet-chess: {t2}\n")
#         self.assertLess(t2, t)

        

#     def test_legal_no_checks(self):
#         COUNT = 10000
#         chess_boards = []
#         while len(chess_boards) < COUNT:
#             board = testing_utils.random_chess_board()
#             if not board.is_check():
#                 chess_boards.append(board)        
#         bullet_boards = [testing_utils.make_bullet_from_chess(board) for board in chess_boards]
#         for i in range(COUNT):
#             moves = {m.uci() for m in list(chess_boards[i].legal_moves)}
#             moves2 = {str(m) for m in bullet_boards[i].legal_moves()}
#             sorted(moves)
#             sorted(moves2)
#             for move in moves2:
#                 self.assertIn(move, moves, msg = f"\nFor Board:\n\n{chess_boards[i].fen()}\nGenerated: {sorted(list(moves2))}")
#             for move in moves:
#                self.assertIn(move, moves2, msg = f"\nFor Board:\n\n{str(chess_boards[i].fen())}")


# if __name__ == "__main__":
#     unittest.main()