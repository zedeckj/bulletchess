import unittest
import sys
sys.path.append("./")
from bulletchess import *

class TestBoardCop(unittest.TestCase):

    def test_basic(self):
        board = Board()
        board.apply(Move(E2, E4))
        cpy = board.copy()
        self.assertEqual(board, cpy)
        self.assertIsNot(board, cpy)
        undone = cpy.undo()
        self.assertEqual(undone, Move(E2, E4))
        self.assertEqual(cpy, Board())

if __name__ == "__main__":
    unittest.main()
