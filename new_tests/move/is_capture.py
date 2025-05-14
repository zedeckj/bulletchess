import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestIsCapture(unittest.TestCase):

    def test_basic(self):
        board = Board.from_fen("rnbqkbnr/pppp1p1p/6p1/4p2Q/4P3/8/PPPP1PPP/RNB1KBNR w KQkq - 0 3")
        capture = Move(H5, E5)
        blunder = Move(D2, D3)
        self.assertTrue(capture.is_capture(board))
        self.assertFalse(blunder.is_capture(board))

if __name__ == "__main__":
    unittest.main()
