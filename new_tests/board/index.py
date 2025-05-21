import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestBoardIndexing(unittest.TestCase):

    def test_starting(self):
        board = Board()
        self.assertEqual(board[PAWN], Bitboard([A2, B2, C2, D2, E2, F2, G2, H2, A7, B7, C7, D7, E7, F7, G7, H7]))
        self.assertEqual(board[WHITE, PAWN], RANK_2)
        self.assertEqual(board[BLACK, PAWN], RANK_7)
        self.assertEqual(board[KNIGHT], Bitboard([B1, G1, B8, G8]))
        self.assertEqual(board[WHITE, KNIGHT], Bitboard([B1, G1]))
        self.assertEqual(board[BLACK, KNIGHT], Bitboard([B8, G8]))
        self.assertEqual(board[ROOK], Bitboard([A1, H1, A8, H8]))
        self.assertEqual(board[WHITE, ROOK], Bitboard([A1, H1]))
        self.assertEqual(board[BLACK, ROOK], Bitboard([A8, H8]))
        self.assertEqual(board[BISHOP], Bitboard([C1, F1, C8, F8]))
        self.assertEqual(board[WHITE,BISHOP], Bitboard([C1, F1]))
        self.assertEqual(board[BLACK,BISHOP], Bitboard([C8, F8]))
        self.assertEqual(board[QUEEN], Bitboard([D1, D8]))
        self.assertEqual(board[WHITE,QUEEN], Bitboard([D1]))
        self.assertEqual(board[BLACK,QUEEN], Bitboard([D8]))
        self.assertEqual(board[KING], Bitboard([E1, E8]))
        self.assertEqual(board[WHITE,KING], Bitboard([E1]))
        self.assertEqual(board[BLACK,KING], Bitboard([E8]))
        self.assertEqual(board[WHITE], RANK_1 | RANK_2)
        self.assertEqual(board[BLACK], RANK_7 | RANK_8)
        self.assertEqual(board[None], RANK_3 | RANK_4 | RANK_5 | RANK_6)



    def test_specific(self):
        board = Board.from_fen("6nr/7p/p1k5/4k3/2N5/PP1bPp1P/1R3P2/6KR w - - 0 31")
        self.assertEqual(board[PAWN], Bitboard([A3, A6, B3, E3, F3, F2, H3, H7]))
        self.assertEqual(board[KNIGHT], Bitboard([G8, C4]))
        self.assertEqual(board[ROOK], Bitboard([H1, H8, B2]))
        self.assertEqual(board[BISHOP], Bitboard([D3]))
        self.assertEqual(board[QUEEN], Bitboard([]))
        self.assertEqual(board[KING], Bitboard([C6, E5, G1]))

    def test_err(self):
        board = Board()
        with self.assertRaisesRegex(TypeError, re.escape("Expected a Color as the first item, got A1 (bulletchess.Square)")):
            _ = board[A1, WHITE] #type: ignore
        with self.assertRaisesRegex(TypeError, re.escape("Expected a PieceType as the second item, got White (bulletchess.Color)")):
            _ = board[WHITE, WHITE] #type: ignore
        with self.assertRaisesRegex(TypeError, re.escape("Expected a PieceType, Color, Piece, Square, tuple[Color, PieceType], or None, got 2 (int)")):
            _ = board[2] #type: ignore

if __name__ == "__main__":
    unittest.main()
    
