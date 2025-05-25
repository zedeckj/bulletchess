import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestColor(unittest.TestCase):

    def test_str(self):
        self.assertEqual(str(WHITE), "White")
        self.assertEqual(str(BLACK), "Black")

    def test_repr(self):
        self.assertEqual(repr(BLACK), "<Color: Black>")
        self.assertEqual(repr(WHITE), "<Color: White>")

    def test_eq(self):
        self.assertNotEqual(WHITE, BLACK)
        board = Board()
        self.assertIs(WHITE, board.turn)
        board.apply(Move(E2, E4))
        self.assertIs(BLACK, board.turn)

    def test_hash(self):
        self.assertEqual(hash(WHITE), 2)
        self.assertEqual(hash(BLACK), 1)

    def test_bool(self):
        self.assertIs(bool(WHITE), True)
        self.assertIs(bool(BLACK), True)

    def test_flip(self):
        self.assertIs(BLACK.opposite, WHITE) 
        self.assertIs(WHITE.opposite, BLACK)
        self.assertIs(~BLACK, WHITE) 
        self.assertIs(~WHITE, BLACK)

    def test_from_str(self):
        self.assertEqual(Color.from_str("White"), WHITE)
        self.assertEqual(Color.from_str("BLACK"), BLACK)
        with self.assertRaisesRegex(ValueError, re.escape("Unknown Color string \"RED\"")):
            Color.from_str("RED")

if __name__ == "__main__":
    unittest.main()
