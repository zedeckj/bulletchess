import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestBoardClocks(unittest.TestCase):

    def test_starting(self):
        board = Board()
        self.assertEqual(board.halfmove_clock, 0)
        self.assertEqual(board.fullmove_number, 1)

    def test_other(self):
        board = Board.from_fen("rnbqkbnr/pppppppp/8/8/8/5P2/PPPPP1PP/RNBQKBNR b KQkq - 15 30")
        self.assertEqual(board.halfmove_clock, 15)
        self.assertEqual(board.fullmove_number, 30)

    def test_set_clocks(self):
        board = Board()
        with self.assertRaisesRegex(AttributeError, re.escape("attribute 'halfmove_clock' of 'bulletchess.Board' objects is not writable")):
            board.halfmove_clock = WHITE #type: ignore
        with self.assertRaisesRegex(AttributeError, re.escape("attribute 'fullmove_number' of 'bulletchess.Board' objects is not writable")):
            board.fullmove_number = WHITE #type: ignore


if __name__ == "__main__":
    unittest.main()
