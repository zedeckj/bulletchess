import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestSquare(unittest.TestCase):

    def test_exists(self):
        with self.assertNoLogs():
            _ = A1
        
    def test_compare(self):
        self.assertEqual(A1, A1)
        self.assertNotEqual(B3, A1)

    def test_list(self):
        self.assertEqual(len(SQUARES), 64)
        self.assertEqual(SQUARES[0], A1)
        self.assertEqual(SQUARES[1], B1)
        self.assertEqual(SQUARES[2], C1)
        self.assertEqual(SQUARES[3], D1)
        self.assertEqual(SQUARES[63], H8)

    def test_hash(self):
        hashes = set()
        for square in SQUARES:
            hashes.add(hash(square))
        self.assertEqual(len(hashes), 64)

    def test_repr(self):
        self.assertEqual(repr(A3), "<Square: A3>")
        self.assertEqual(repr(B1), "<Square: B1>")
        self.assertEqual(repr(H8), "<Square: H8>")

    def test_str(self):
        self.assertEqual(str(A3), "A3")
        self.assertEqual(str(B1), "B1")
        self.assertEqual(str(H8), "H8")

    def test_from_str(self):
        self.assertEqual(A3, Square.from_str("A3"))
        self.assertEqual(B1, Square.from_str("b1"))
        self.assertEqual(H8, Square.from_str("H8"))

    def test_from_str_err(self):
        with self.assertRaisesRegex(ValueError, re.escape("Square string must be two characters (ex. \"B1\"), got 'aaa'")):
            Square.from_str("aaa")
        with self.assertRaisesRegex(ValueError, re.escape("Expected a valid rank indicator [1-8], got 9")):
            Square.from_str("a9")
        with self.assertRaisesRegex(ValueError, re.escape("Expected a valid file indicator [a-hA-H], got k")):
            Square.from_str("k2")


    def test_misuse(self):
        with self.assertRaisesRegex(TypeError, re.escape("cannot create 'bulletchess.Square' instances")):
            square = Square()
        with self.assertRaisesRegex(TypeError, re.escape("cannot create 'bulletchess.Square' instances")):
            square = Square(2) #type: ignore
        with self.assertRaisesRegex(AttributeError, re.escape("'bulletchess.Square' object has no attribute 'foo' and no __dict__ for setting new attributes")):
            A1.foo = 2 #type: ignore

if __name__ == "__main__":
    unittest.main()
