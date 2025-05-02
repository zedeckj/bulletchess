import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

Board1 = Board.from_fen("8/p1p3p1/3p3p/1P5P/1PP1P1P1/8/8/8 w - - 0 1")
Board2 = Board.from_fen("4k3/2p3p1/1p2p2p/1P2P2P/1PP3P1/4P3/8/4K3 w - - 0 1")

class TestPawnBitboardUtils(unittest.TestCase):

    def test_isolated(self):
        self.assertEqual(utils.isolated_pawns(Board1), Bitboard([A7, E4]))
        self.assertEqual(utils.isolated_pawns(Board2), Bitboard([E3, E5, E6]))

    def test_doubled(self):
        self.assertEqual(utils.doubled_pawns(Board1), Bitboard([B4, B5]))
        self.assertEqual(utils.doubled_pawns(Board2), Bitboard([B4, B5, E3, E5]))

    def test_backwards(self):
        self.assertEqual(utils.backwards_pawns(Board1), Bitboard([C4, E4, A7, C7, G7, G4]))
        self.assertEqual(utils.backwards_pawns(Board2), Bitboard([C4, C7, G7, G4]))


if __name__ == "__main__":
    unittest.main()