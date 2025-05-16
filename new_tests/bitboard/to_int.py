import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestToint(unittest.TestCase):


    def test_get(self):
        self.assertEqual(int(Bitboard([])), 0)
        self.assertEqual(int(Bitboard([A1])), 1)
        self.assertEqual(int(Bitboard([A1, B1])), 3)
        self.assertEqual(int(Bitboard([H8])), 0x8000000000000000)
        self.assertEqual(int(Bitboard(SQUARES)), 0xFFFF_FFFF_FFFF_FFFF)



if __name__ == "__main__":
    unittest.main()
