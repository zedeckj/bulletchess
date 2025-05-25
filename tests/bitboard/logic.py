import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestBitboardLogic(unittest.TestCase):


    def test_and(self):
        b1 = Bitboard([H3, F1])
        b2 = Bitboard([H3, F1, A3])
        self.assertEqual(b1 & b2, b1)

    def test_or(self):
        b1 = Bitboard([H3, F1])
        b2 = Bitboard([H3, F1, A3])
        self.assertEqual(b1 | b2, b2)

    def test_xor(self):
        b1 = Bitboard([H3, F1])
        b2 = Bitboard([H3, F1, A3])
        self.assertEqual(b1 ^ b2, Bitboard([A3]))

    def test_not(self):
        self.assertEqual(~Bitboard(SQUARES), Bitboard([])) 
        self.assertEqual(~Bitboard([A1]), Bitboard([sq for sq in SQUARES if sq != A1]))

    def test_bool(self):
        self.assertFalse(EMPTY_BB)
        self.assertTrue(Bitboard([A1]))
        self.assertTrue(FULL_BB)

if __name__ == "__main__":
    unittest.main()
