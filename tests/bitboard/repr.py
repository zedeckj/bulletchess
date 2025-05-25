import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestBitboardRepr(unittest.TestCase):


    def test_get(self):
        self.assertEqual(repr(Bitboard([])), "<Bitboard: 0x0>")
        self.assertEqual(repr(Bitboard([A1])), "<Bitboard: 0x1>")
        self.assertEqual(repr(Bitboard([A1, B1])), "<Bitboard: 0x3>")
        self.assertEqual(repr(Bitboard([H8])), "<Bitboard: 0x8000000000000000>")
        self.assertEqual(repr(Bitboard(SQUARES)), "<Bitboard: 0xFFFFFFFFFFFFFFFF>")
        
        """ # I think the above is better than the below, as each value is more quickly able to be distinguished 
        self.assertEqual(repr(Bitboard([])), "<Bitboard: 0x0000000000000000>")
        self.assertEqual(repr(Bitboard([A1])), "<Bitboard: 0x0000000000000001>")
        self.assertEqual(repr(Bitboard([A1, B1])), "<Bitboard: 0x0000000000000003>")
        self.assertEqual(repr(Bitboard([H8])), "<Bitboard: 0x8000000000000000>")
        self.assertEqual(repr(Bitboard(SQUARES)), "<Bitboard: 0xFFFFFFFFFFFFFFFF>")
        """
        

if __name__ == "__main__":
    unittest.main()
