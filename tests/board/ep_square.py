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

    def test_set_ep(self):
        board = Board()
        board[E2] = None
        board[E4] = Piece(WHITE, PAWN)
        board.turn = BLACK
        board.en_passant_square = E3 
        self.assertEqual(board.en_passant_square, E3)

    def test_illegal_ep(self):
        board = Board()
        with self.assertRaisesRegex(ValueError, re.escape("Illegal en passant Square: A1. Must be on either rank 3 or rank 6.")):
            board.en_passant_square = A1
        with self.assertRaisesRegex(ValueError, re.escape("Illegal en passant Square: E3. Must be on rank 6 if it is white's turn.")):
            board.en_passant_square = E3
        board.turn = BLACK
        with self.assertRaisesRegex(ValueError, re.escape("Illegal en passant Square: E3. There is no corresponding white pawn.")):
            board.en_passant_square = E3
        with self.assertRaisesRegex(ValueError, re.escape("Illegal en passant Square: E6. Must be on rank 3 if it is black's turn.")):
            board.en_passant_square = E6
        board.turn = WHITE
        with self.assertRaisesRegex(ValueError, re.escape("Illegal en passant Square: E6. There is no corresponding black pawn.")):
            board.en_passant_square = E6

if __name__ == "__main__":
    unittest.main()
