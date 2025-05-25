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
        

        

if __name__ == "__main__":
    unittest.main()
