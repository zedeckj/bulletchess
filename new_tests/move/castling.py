import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

W_KINGSIDE_BOARD = Board.from_fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQK2R w KQkq - 0 1")
W_QUEENSIDE_BOARD = Board.from_fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/R3KBNR w KQkq - 0 1")
B_KINGSIDE_BOARD = Board.from_fen("rnbqk2r/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
B_QUEENSIDE_BOARD = Board.from_fen("r3kbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")


class TestCastlingMoves(unittest.TestCase):

    def test_is_castles(self):
        self.assertTrue(Move(E1, G1).is_castling(W_KINGSIDE_BOARD))
        self.assertTrue(Move(E1, C1).is_castling(W_QUEENSIDE_BOARD))
        self.assertTrue(Move(E8, G8).is_castling(B_KINGSIDE_BOARD))
        self.assertTrue(Move(E8, C8).is_castling(B_QUEENSIDE_BOARD))
        self.assertFalse(Move(E2, E4).is_castling(Board()))

    def test_get_castles(self):
        self.assertEqual(Move(E1, G1).castling_type(W_KINGSIDE_BOARD), WHITE_KINGSIDE)
        self.assertEqual(Move(E1, C1).castling_type(W_QUEENSIDE_BOARD), WHITE_QUEENSIDE)
        self.assertEqual(Move(E8, G8).castling_type(B_KINGSIDE_BOARD), BLACK_KINGSIDE)
        self.assertEqual(Move(E8, C8).castling_type(B_QUEENSIDE_BOARD), BLACK_QUEENSIDE)
        self.assertIsNone(Move(E2, E4).castling_type(Board()))

if __name__ == "__main__":
    unittest.main()
