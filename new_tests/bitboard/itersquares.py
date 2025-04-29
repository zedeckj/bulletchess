import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestBitboardIter(unittest.TestCase):


    def test_get(self):

        squares = [A1, A2, H3]
        bb = Bitboard(squares)
        self.assertEqual(squares, [sq for sq in bb])
        self.assertEqual(squares, list(bb))
        self.assertEqual(set(squares), set(bb))
        out = []
        for square in bb:
            for square2 in bb:
                out.append([square,square2])
        self.assertEqual([[A1, A1], [A1, A2], [A1, H3], [A2, A1], [A2, A2], [A2, H3], [H3, A1], [H3, A2], [H3, H3]], out)

if __name__ == "__main__":
    unittest.main()