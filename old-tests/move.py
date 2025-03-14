import sys
sys.path.append("./")
import unittest
import bulletchess
import chess
import testing_utils
import random
import time
from bulletchess import *


class TestMove(unittest.TestCase):

    def test_serialize(self):
        chess_boards = [testing_utils.random_chess_board() for _ in range(10)]
        ucis = []
        for board in chess_boards:
            ucis.extend([move.uci() for move in board.legal_moves])
        for uci in ucis:
            move = bulletchess.Move.from_uci(uci)
            uci2 = str(move)
            self.assertEqual(uci, uci2)
            

    def test_legal(self):
        COUNT = 100
        chess_boards = []
        while len(chess_boards) < COUNT:
            board = testing_utils.random_chess_board()
            chess_boards.append(board)        
        bullet_boards = [testing_utils.make_bullet_from_chess(board) for board in chess_boards]
        for i in range(COUNT):
            moves = {m.uci() for m in list(chess_boards[i].legal_moves)}
            moves2 = {str(m) for m in bullet_boards[i].legal_moves()}
            for move in moves2:
                self.assertIn(move, moves, msg = f"\nFor Board:\n\n{chess_boards[i].fen()}\nGenerated: {sorted(list(moves2))}")
            for move in moves:
               self.assertIn(move, moves2, msg = f"\nFor Board:\n\n{chess_boards[i].fen()}")
    

        
        

if __name__ == "__main__":
    unittest.main()