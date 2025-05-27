import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestLen(unittest.TestCase):


    def test_get(self):
        self.assertEqual(len(Bitboard(SQUARES)), 64)
        self.assertEqual(len(Bitboard([E1, E2])), 2)
        self.assertEqual(len(Bitboard([])), 0)
        self.assertEqual(len(Bitboard(SQUARES + SQUARES)), 64)


if __name__ == "__main__":
    unittest.main()
