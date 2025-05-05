import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestCastlingType(unittest.TestCase):

    def test_constants(self):
        self.assertNotEqual(WHITE_KINGSIDE, WHITE_QUEENSIDE)
        self.assertNotEqual(WHITE_KINGSIDE, BLACK_QUEENSIDE)
        self.assertNotEqual(WHITE_KINGSIDE, BLACK_KINGSIDE)

        self.assertNotEqual(WHITE_QUEENSIDE, BLACK_QUEENSIDE)
        self.assertNotEqual(WHITE_QUEENSIDE, BLACK_KINGSIDE)

        self.assertNotEqual(BLACK_QUEENSIDE, BLACK_KINGSIDE)

    def test_repr(self):
        self.assertEqual(repr(WHITE_KINGSIDE), "<CastlingType: (WHITE, KINGSIDE)>")
        self.assertEqual(repr(WHITE_QUEENSIDE), "<CastlingType: (WHITE, QUEENSIDE)>")
        self.assertEqual(repr(BLACK_KINGSIDE), "<CastlingType: (BLACK, KINGSIDE)>")
        self.assertEqual(repr(BLACK_QUEENSIDE), "<CastlingType: (BLACK, QUEENSIDE)>")

    def test_str(self):
        self.assertEqual(str(WHITE_KINGSIDE), "K")
        self.assertEqual(str(WHITE_QUEENSIDE), "Q")
        self.assertEqual(str(BLACK_KINGSIDE), "k")
        self.assertEqual(str(BLACK_QUEENSIDE), "q")

 
    def test_hash(self):
        self.assertEqual(hash(WHITE_KINGSIDE), 1)
        self.assertEqual(hash(WHITE_QUEENSIDE), 2)
        self.assertEqual(hash(BLACK_KINGSIDE), 4)
        self.assertEqual(hash(BLACK_QUEENSIDE), 8)       

if __name__ == "__main__":
    unittest.main()
