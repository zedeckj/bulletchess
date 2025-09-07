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

    def test_flipped_list(self):
        self.assertEqual(len(SQUARES_FLIPPED), 64)
        self.assertEqual(SQUARES_FLIPPED[0], A8)
        self.assertEqual(SQUARES_FLIPPED[1], B8)
        self.assertEqual(SQUARES_FLIPPED[2], C8)
        self.assertEqual(SQUARES_FLIPPED[3], D8)
        self.assertEqual(SQUARES_FLIPPED[63], H1)

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

    def test_index(self):
        self.assertEqual(A1.index(), 0)
        self.assertEqual(A2.index(), 8)
        self.assertEqual(H8.index(), 63)
        self.assertEqual(B1.index(), 1)
        for i in range(63):
            self.assertEqual(i, SQUARES[i].index())

    def test_misuse(self):
        with self.assertRaisesRegex(TypeError, re.escape("cannot create 'bulletchess.Square' instances")):
            square = Square()
        with self.assertRaisesRegex(TypeError, re.escape("cannot create 'bulletchess.Square' instances")):
            square = Square(2) #type: ignore
        with self.assertRaisesRegex(AttributeError, re.escape("'bulletchess.Square' object has no attribute 'foo' and no __dict__ for setting new attributes")):
            A1.foo = 2 #type: ignore

    def test_direction(self):
        self.assertEqual(A1.north(), A2)
        self.assertEqual(B3.north(), B4)
        self.assertEqual(E8.north(), None)

        self.assertEqual(A8.south(), A7)
        self.assertEqual(B3.south(), B2)
        self.assertEqual(E1.south(), None)

        self.assertEqual(A8.east(), None)
        self.assertEqual(B3.east(), A3)
        self.assertEqual(E1.east(), D1)

        self.assertEqual(A8.west(), B8)
        self.assertEqual(B3.west(), C3)
        self.assertEqual(E1.west(), F1)
        self.assertEqual(H3.west(), None)

    def test_direction_dist(self):
        self.assertEqual(A1.north(2), A3)
        self.assertEqual(B3.north(distance=3), B6)
        self.assertEqual(E5.north(distance=5), None)

        self.assertEqual(A8.south(distance=2), A6)
        self.assertEqual(B3.south(distance=2), B1)
        self.assertEqual(E1.south(distance=4), None)

        self.assertEqual(A8.east(distance=6), None)
        self.assertEqual(B3.east(1), A3)
        self.assertEqual(E1.east(2), C1)

        self.assertEqual(A8.west(3), D8)
        self.assertEqual(B3.west(1), C3)
        self.assertEqual(E1.west(4), None)
        self.assertEqual(H3.west(1), None)

    def test_middle_directions(self):
        self.assertEqual(A1.ne(), B2)
        self.assertEqual(B3.ne(), C4)
        self.assertEqual(E8.ne(), None)

        self.assertEqual(A8.se(), B7)
        self.assertEqual(B3.se(), C2)
        self.assertEqual(E1.se(), None)

        self.assertEqual(A8.nw(), None)
        self.assertEqual(B3.nw(), A4)
        self.assertEqual(E1.nw(), D2)

        self.assertEqual(A8.sw(), None)
        self.assertEqual(B3.sw(), A2)
        self.assertEqual(E1.sw(), None)
        self.assertEqual(H3.sw(), G2)

    def test_middle_directions_dist(self):
        self.assertEqual(A1.ne(2), C3)
        self.assertEqual(B3.ne(4), F7)
        self.assertEqual(E8.ne(), None)

        self.assertEqual(A8.se(2), C6)
        self.assertEqual(B3.se(distance= 2), D1)
        self.assertEqual(E6.se(4), None) 

        self.assertEqual(A8.nw(4), None)
        self.assertEqual(H1.nw(7), A8)
        self.assertEqual(E1.nw(distance= 3), B4)

        self.assertEqual(A8.sw(distance= 7), None)
        self.assertEqual(C3.sw(2), A1)
        self.assertEqual(E1.sw(5), None)
        self.assertEqual(H5.sw(distance= 3), E2)

    def test_around(self):
        self.assertEqual(E5.adjacent(), Bitboard([D4, D5, D6, E4, E6, F4, F5, F6]))
        self.assertEqual(A1.adjacent(), Bitboard([A2, B1, B2]))

    def test_bb(self):
        for square in SQUARES:
            self.assertEqual(square.bb(), Bitboard([square]))

if __name__ == "__main__":
    unittest.main()
