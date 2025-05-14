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

    def test_is_castles_no_king(self):
        W_KINGSIDE_BOARD2 = W_KINGSIDE_BOARD.copy()
        W_KINGSIDE_BOARD2[E1] = None
        W_QUEENSIDE_BOARD2 = W_QUEENSIDE_BOARD.copy()
        W_QUEENSIDE_BOARD2[E1] = None
        B_KINGSIDE_BOARD2 = B_KINGSIDE_BOARD.copy()
        B_KINGSIDE_BOARD2[E8] = None
        B_QUEENSIDE_BOARD2 = B_QUEENSIDE_BOARD.copy()
        B_QUEENSIDE_BOARD2[E8] = None
        self.assertFalse(Move(E1, G1).is_castling(W_KINGSIDE_BOARD2))
        self.assertFalse(Move(E1, C1).is_castling(W_QUEENSIDE_BOARD2))
        self.assertFalse(Move(E8, G8).is_castling(B_KINGSIDE_BOARD2))
        self.assertFalse(Move(E8, C8).is_castling(B_QUEENSIDE_BOARD2))

    def test_is_castles_no_rook(self):
        W_KINGSIDE_BOARD2 = W_KINGSIDE_BOARD.copy()
        W_KINGSIDE_BOARD2[H1] = None
        W_QUEENSIDE_BOARD2 = W_QUEENSIDE_BOARD.copy()
        W_QUEENSIDE_BOARD2[A1] = None
        B_KINGSIDE_BOARD2 = B_KINGSIDE_BOARD.copy()
        B_KINGSIDE_BOARD2[H8] = None
        B_QUEENSIDE_BOARD2 = B_QUEENSIDE_BOARD.copy()
        B_QUEENSIDE_BOARD2[A8] = None
        self.assertFalse(Move(E1, G1).is_castling(W_KINGSIDE_BOARD2))
        self.assertFalse(Move(E1, C1).is_castling(W_QUEENSIDE_BOARD2))
        self.assertFalse(Move(E8, G8).is_castling(B_KINGSIDE_BOARD2))
        self.assertFalse(Move(E8, C8).is_castling(B_QUEENSIDE_BOARD2))


    def test_make_castle(self):
        self.assertEqual(Move.castle(WHITE_KINGSIDE), Move(E1, G1))
        self.assertEqual(Move.castle(WHITE_QUEENSIDE), Move(E1, C1))
        self.assertEqual(Move.castle(BLACK_KINGSIDE), Move(E8, G8))
        self.assertEqual(Move.castle(BLACK_QUEENSIDE), Move(E8, C8))

if __name__ == "__main__":
    unittest.main()
