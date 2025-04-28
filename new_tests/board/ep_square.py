import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestBoardClocks(unittest.TestCase):

    def test_starting(self):
        board = Board()
        self.assertEqual(board.en_passant_square, None)

    def test_other(self):
        board = Board.from_fen("rnb1qbnr/1pppp3/4kpp1/p6p/Q1P1P2P/N4BP1/PP1P1P2/R1B1K1NR b KQ e3 0 8")
        self.assertEqual(board.en_passant_square, E3)

    def test_set_clocks(self):
        board = Board()
        with self.assertRaisesRegex(AttributeError, re.escape("attribute 'en_passant_square' of 'bulletchess.Board' objects is not writable")):
            board.en_passant_square = E3 #type: ignore

if __name__ == "__main__":
    unittest.main()
