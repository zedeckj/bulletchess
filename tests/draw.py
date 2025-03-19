import unittest
import sys
sys.path.append("./")
from bulletchess import *
import random

class TestDraw(unittest.TestCase):

    def test_threefold(self):
        board = Board.starting()
        self.assertFalse(board.is_draw())
        board.apply(Move.from_uci("g1f3"))
        self.assertFalse(board.is_draw())
        board.apply(Move.from_uci("b8c6"))
        self.assertFalse(board.is_draw())
        board.apply(Move.from_uci("f3g1"))
        self.assertFalse(board.is_draw())
        board.apply(Move.from_uci("c6b8"))
        # repetition 2
        
        self.assertFalse(board.is_draw())
        board.apply(Move.from_uci("g1f3"))
        self.assertFalse(board.is_draw())
        board.apply(Move.from_uci("b8c6"))
        self.assertFalse(board.is_draw())
        board.apply(Move.from_uci("f3g1"))
        self.assertFalse(board.is_draw())
        board.apply(Move.from_uci("c6b8"))
        # repetition 3
        self.assertTrue(board.is_draw())
 

if __name__ == "__main__":
    unittest.main()

