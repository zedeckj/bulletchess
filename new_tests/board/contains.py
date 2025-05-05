import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re
from typing import Optional

class TestBoardClocks(unittest.TestCase):

    def test_all(self):
        for color in [WHITE, BLACK]:
            for piece_type in PIECE_TYPES:
                piece = Piece(color, piece_type)
                for square in SQUARES:
                    board = Board.empty()
                    board[square] = piece
                    for color2 in [WHITE, BLACK]:
                        for piece_type2 in PIECE_TYPES:
                            piece2 = Piece(color2, piece_type2)
                            if piece == piece2:
                                self.assertTrue(piece2 in board)
                            else:
                                self.assertFalse(piece2 in board)
                    self.assertTrue(None in board)

    def test_full(self):
        board = Board.empty()
        for square in SQUARES:
            board[square] = Piece(WHITE, PAWN)
        self.assertTrue(Piece(WHITE, PAWN) in board)
        self.assertFalse(None in board)

    def test_start(self):
        board = Board()
        for color in [WHITE, BLACK]:
            for piece_type in PIECE_TYPES:
                piece = Piece(color, piece_type)
                self.assertTrue(piece in board)
        self.assertTrue(None in board)

if __name__ == "__main__":
    unittest.main()
