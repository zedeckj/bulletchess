import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestBitboardContains(unittest.TestCase):


    def test_in(self):
        b2 = Bitboard([A1, A2])
        self.assertTrue(A1 in b2)
        self.assertTrue(A2 in b2)
        self.assertFalse(A3 in b2)

if __name__ == "__main__":
    unittest.main()
