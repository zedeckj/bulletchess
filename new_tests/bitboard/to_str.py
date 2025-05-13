import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestBitboardRepr(unittest.TestCase):


    def test_get(self):
        self.assertEqual(str(Bitboard([])), "0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n")
        self.assertEqual(str(Bitboard([A1])), "0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n1 0 0 0 0 0 0 0 \n")
        self.assertEqual(str(Bitboard([A1, H8])), "0 0 0 0 0 0 0 1 \n0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 \n1 0 0 0 0 0 0 0 \n")
        
        """ # I think the above is better than the below, as each value is more quickly able to be distinguished 
        self.assertEqual(repr(Bitboard([])), "<Bitboard: 0x0000000000000000>")
        self.assertEqual(repr(Bitboard([A1])), "<Bitboard: 0x0000000000000001>")
        self.assertEqual(repr(Bitboard([A1, B1])), "<Bitboard: 0x0000000000000003>")
        self.assertEqual(repr(Bitboard([H8])), "<Bitboard: 0x8000000000000000>")
        self.assertEqual(repr(Bitboard(SQUARES)), "<Bitboard: 0xFFFFFFFFFFFFFFFF>")
        """
        

if __name__ == "__main__":
    unittest.main()
