import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestBoardHistory(unittest.TestCase):

    def test_starting(self):
        board = Board()
        self.assertEqual(board.history, [])

    def test_some(self):
        board = Board()
        moves = [Move(E2, E4), Move(E7, E5), Move(G1, F3)]
        for move in moves:
            board.apply(move)
        self.assertEqual(board.history, moves)






if __name__ == "__main__":
    unittest.main()
