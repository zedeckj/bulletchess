import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re
import random
class TestToint(unittest.TestCase):


    def test_get(self):
        self.assertEqual(int(Bitboard([])), 0)
        self.assertEqual(int(Bitboard([A1])), 1)
        self.assertEqual(int(Bitboard([A1, B1])), 3)
        self.assertEqual(int(Bitboard([A1, B1, C1])), 7)
        self.assertEqual(int(Bitboard([E2, E3, E4, D2, F2])), 269498368)
        self.assertEqual(int(Bitboard([H8])), 0x8000000000000000)
        self.assertEqual(int(Bitboard(SQUARES)), 0xFFFF_FFFF_FFFF_FFFF)

    def test_symmetry(self):
        for _ in range(1000):
            i = random.randint(10, 100000000000)
            self.assertEqual(i, int(Bitboard.from_int(i)))



if __name__ == "__main__":
    unittest.main()
