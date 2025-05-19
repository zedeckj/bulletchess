import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestBitboardIndex(unittest.TestCase):


    def test_get(self):
        b2 = Bitboard([A1, A2])
        self.assertTrue(b2[A1])
        self.assertTrue(b2[A2])
        self.assertFalse(b2[A3])

    def test_set(self):
        b1 = Bitboard([])
        b2 = Bitboard([A1, A2])
        b1[A1] = True
        b1[A2] = True
        b1[A3] = False
        self.assertEqual(b1, b2)
        b1[A1] = False
        b1[A2] = False
        self.assertEqual(b1, Bitboard([]))

    def test_del(self):
        b1 = Bitboard([])
        b2 = Bitboard([A1, A2])
        del b2[A1]
        del b2[A2]
        self.assertEqual(b1, b2)

if __name__ == "__main__":
    unittest.main()
