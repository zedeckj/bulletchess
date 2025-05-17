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

    def test_from_str(self):
        self.assertEqual(PieceType.from_str("pawn"), PAWN)
        self.assertEqual(PieceType.from_str("KNIGHT"), KNIGHT)
        self.assertEqual(PieceType.from_str("Bishop"), BISHOP)
        self.assertEqual(PieceType.from_str("rOoK"), ROOK)
        self.assertEqual(PieceType.from_str("QUeEN"), QUEEN)
        self.assertEqual(PieceType.from_str("king"), KING)

        with self.assertRaisesRegex(ValueError, re.escape('Unknown PieceType string "Foo"')):
            PieceType.from_str("Foo")

        with self.assertRaisesRegex(ValueError, re.escape('Unknown PieceType string "kingg"')):
            PieceType.from_str("kingg")

        with self.assertRaisesRegex(TypeError, re.escape('Expected a str, got 2 (int)')):
            PieceType.from_str(2) #type: ignore

    def test_hash(self):
        hashes = set()
        for pt in PIECE_TYPES:
            hashes.add(hash(pt))
        self.assertEqual(len(hashes), 6)

    def test_str(self):
        self.assertEqual(str(PAWN), "Pawn")
        self.assertEqual(str(BISHOP), "Bishop")
        self.assertEqual(str(KNIGHT), "Knight")
        self.assertEqual(str(ROOK), "Rook")
        self.assertEqual(str(QUEEN), "Queen")
        self.assertEqual(str(KING), "King")


    def test_misuse(self):
        with self.assertRaisesRegex(TypeError, re.escape("cannot create 'bulletchess.PieceType' instances")):
            pt = PieceType()
        with self.assertRaisesRegex(TypeError, re.escape("cannot create 'bulletchess.PieceType' instances")):
            pt = PieceType(2) #type: ignore
        with self.assertRaisesRegex(AttributeError, re.escape("'bulletchess.PieceType' object has no attribute 'foo' and no __dict__ for setting new attributes")):
            PAWN.foo = 2 #type: ignore

if __name__ == "__main__":
    unittest.main()
