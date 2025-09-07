import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestBitboardLogic(unittest.TestCase):


    def test_and(self):
        s1 = H3
        s2 = A4
        b2 = Bitboard([H3, F1, A3])
        self.assertEqual(b2 & s1, Bitboard([H3]))
        self.assertEqual(s1 & b2, Bitboard([H3]))
        self.assertEqual(b2 & s2, EMPTY_BB)
        self.assertEqual(s2 & b2, EMPTY_BB)
    def test_or(self):
        b2 = Bitboard([H3, F1, A3])
        self.assertEqual(A3 | b2, b2)
        self.assertEqual(b2 | H4, Bitboard([H4, H3, F1, A3]))
    def test_xor(self):
        b1 = Bitboard([H3, F1])
        b2 = Bitboard([H3, F1, A3])
        self.assertEqual(H3 ^ b2, Bitboard([F1, A3]))
        self.assertEqual(b2 ^ G1, Bitboard([H3, F1, A3, G1]))

    def test_not(self):
        self.assertEqual(~Bitboard(SQUARES), Bitboard([])) 
        self.assertEqual(~Bitboard([A1]), Bitboard([sq for sq in SQUARES if sq != A1]))

    def test_bool(self):
        self.assertFalse(EMPTY_BB)
        self.assertTrue(Bitboard([A1]))
        self.assertTrue(FULL_BB)


if __name__ == "__main__":
    unittest.main()
