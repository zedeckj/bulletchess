import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestSquare(unittest.TestCase):

    def test_exists(self):
        with self.assertNoLogs():
            _ = PAWN
            _ = PIECE_TYPES
        
    def test_compare(self):
        self.assertEqual(PAWN, PAWN)
        self.assertNotEqual(BISHOP, ROOK)
        self.assertNotEqual(QUEEN, 2)

    def test_list(self):
        self.assertEqual(len(PIECE_TYPES), 6)
        self.assertEqual(PIECE_TYPES[0], PAWN)
        self.assertEqual(PIECE_TYPES[1], KNIGHT)
        self.assertEqual(PIECE_TYPES[2], BISHOP)
        self.assertEqual(PIECE_TYPES[3], ROOK)
        self.assertEqual(PIECE_TYPES[4], QUEEN)
        self.assertEqual(PIECE_TYPES[5], KING)


    def test_hash(self):
        hashes = set()
        for pt in PIECE_TYPES:
            hashes.add(hash(pt))
        self.assertEqual(len(hashes), 6)


    def test_misuse(self):
        with self.assertRaisesRegex(TypeError, re.escape("cannot create 'bulletchess.PieceType' instances")):
            pt = PieceType()
        with self.assertRaisesRegex(TypeError, re.escape("cannot create 'bulletchess.PieceType' instances")):
            pt = PieceType(2) #type: ignore
        with self.assertRaisesRegex(AttributeError, re.escape("'bulletchess.PieceType' object has no attribute 'foo' and no __dict__ for setting new attributes")):
            PAWN.foo = 2 #type: ignore

if __name__ == "__main__":
    unittest.main()
