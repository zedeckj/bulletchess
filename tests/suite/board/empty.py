import unittest
import sys
sys.path.append("./")
from bulletchess import *

class TestBoardEmpty(unittest.TestCase):

    def test_basic(self):
        board = Board.empty()
        for square in SQUARES:
            self.assertEqual(board[square], None)
        self.assertEqual(board.halfmove_clock, 0)
        self.assertEqual(board.fullmove_number, 1)
        self.assertEqual(board.en_passant_square, None)
        self.assertEqual(board.turn, WHITE)
        self.assertEqual(board[PAWN], Bitboard([]))
        self.assertEqual(board[KNIGHT], Bitboard([]))
        self.assertEqual(board[BISHOP], Bitboard([]))
        self.assertEqual(board[ROOK], Bitboard([]))
        self.assertEqual(board[QUEEN], Bitboard([]))
        self.assertEqual(board[KING], Bitboard([]))
        
if __name__ == "__main__":
    unittest.main()
