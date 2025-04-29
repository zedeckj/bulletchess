import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestFromInt(unittest.TestCase):


    def test_valid(self):
        self.assertEqual(Bitboard([]), Bitboard.from_int(0))
        self.assertEqual(Bitboard([A1]), Bitboard.from_int(1))
        self.assertEqual(Bitboard([A1, B1]), Bitboard.from_int(3))
        self.assertEqual(Bitboard([H8]), Bitboard.from_int(0x8000000000000000))
        self.assertEqual(Bitboard(SQUARES), Bitboard.from_int(0xFFFF_FFFF_FFFF_FFFF))
        

    def test_invalid(self):
        with self.assertRaisesRegex(OverflowError, re.escape("can't convert negative int to unsigned")):
            self.assertEqual(Bitboard(SQUARES), Bitboard.from_int(-1))
        with self.assertRaisesRegex(OverflowError, re.escape("int too big to convert")):
            self.assertEqual(Bitboard(SQUARES), Bitboard.from_int(0xFFFF_FFFF_FFFF_FFFF_F))


if __name__ == "__main__":
    unittest.main()
