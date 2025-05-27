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

    def test_set(self):
        board = Board()
        board.halfmove_clock = 10
        board.fullmove_number = 11
        self.assertEqual(board.halfmove_clock, 10)
        self.assertEqual(board.fullmove_number, 11)
    

    def test_set_clocks(self):
        board = Board()
        with self.assertRaisesRegex(TypeError, re.escape("Expected an int, got White (bulletchess.Color)")):
            board.halfmove_clock = WHITE #type: ignore
        with self.assertRaisesRegex(TypeError, re.escape("Expected an int, got White (bulletchess.Color)")):
            board.fullmove_number = WHITE #type: ignore

    def test_out_of_range(self):
        board = Board()
        with self.assertRaises(OverflowError):
            board.halfmove_clock = 2 ** 64  
        with self.assertRaises(OverflowError):
            board.fullmove_number = 2 ** 64  

if __name__ == "__main__":
    unittest.main()
