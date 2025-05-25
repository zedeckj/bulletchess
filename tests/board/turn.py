import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestBoardTurn(unittest.TestCase):

    def test_starting(self):
        board = Board()
        self.assertEqual(board.turn, WHITE)

    def test_black(self):
        board = Board.from_fen("rnbqkbnr/pppppppp/8/8/8/5P2/PPPPP1PP/RNBQKBNR b KQkq - 0 1")
        self.assertEqual(board.turn, BLACK)

    def test_set_turn(self):
        board = Board()
        board.turn = BLACK 
        self.assertEqual(board.turn, BLACK)
        
if __name__ == "__main__":
    unittest.main()
