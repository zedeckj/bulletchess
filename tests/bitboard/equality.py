import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestBitboardEq(unittest.TestCase):


    def test_eq(self):
        b1 = Bitboard([])
        b2 = Bitboard([A1, A2])
        self.assertNotEqual(b1, b2)
        self.assertEqual(b1, Bitboard([]))
        self.assertEqual(b2, Bitboard([A1, A2]))

if __name__ == "__main__":
    unittest.main()
