import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestPieceBitboards(unittest.TestCase):

    def test_starting(self):
        board = Board()
        self.assertEqual(board.pawns, Bitboard([A2, B2, C2, D2, E2, F2, G2, H2, A7, B7, C7, D7, E7, F7, G7, H7]))
        self.assertEqual(board.knights, Bitboard([B1, G1, B8, G8]))
        self.assertEqual(board.rooks, Bitboard([A1, H1, A8, H8]))
        self.assertEqual(board.bishops, Bitboard([C1, F1, C8, F8]))
        self.assertEqual(board.queens, Bitboard([D1, D8]))
        self.assertEqual(board.kings, Bitboard([E1, E8]))
        self.assertEqual(board.white, RANK_1 | RANK_2)
        self.assertEqual(board.black, RANK_7 | RANK_8)
        self.assertEqual(board.unoccupied, RANK_3 | RANK_4 | RANK_5 | RANK_6)

    def test_specific(self):
        board = Board.from_fen("6nr/7p/p1k5/4k3/2N5/PP1bPp1P/1R3P2/6KR w - - 0 31")
        self.assertEqual(board.pawns, Bitboard([A3, A6, B3, E3, F3, F2, H3, H7]))
        self.assertEqual(board.knights, Bitboard([G8, C4]))
        self.assertEqual(board.rooks, Bitboard([H1, H8, B2]))
        self.assertEqual(board.bishops, Bitboard([D3]))
        self.assertEqual(board.queens, Bitboard([]))
        self.assertEqual(board.kings, Bitboard([C6, E5, G1]))

if __name__ == "__main__":
    unittest.main()
