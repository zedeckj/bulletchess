import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestBitboardHash(unittest.TestCase):


    def test_hash(self):
        self.assertEqual(hash(Bitboard([])), 0)
        self.assertEqual(hash(Bitboard([A1])), 1)
        self.assertEqual(hash(Bitboard([A1, B1])), 3)
        self.assertEqual(hash(Bitboard([H8])), -0x8000000000000000)
        self.assertEqual(hash(FULL_BB), -2) # special case, would have been -1 



if __name__ == "__main__":
    unittest.main()
