import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestPiece(unittest.TestCase):

    def test_create(self):
        with self.assertNoLogs():
            _ = Piece(WHITE, PAWN)
        

    def test_get(self):
        piece = Piece(WHITE, KNIGHT)
        self.assertEqual(piece.color, WHITE)
        self.assertEqual(piece.piece_type, KNIGHT)

        piece = Piece(BLACK, BISHOP)
        self.assertEqual(piece.color, BLACK)
        self.assertEqual(piece.piece_type, BISHOP)

    def test_hash(self):
        hashes = set()
        for color in [WHITE, BLACK]:
            for pt in PIECE_TYPES:
                hashes.add(hash(Piece(color, pt)))
        self.assertEqual(len(hashes), 12)

    def test_repr(self):
        piece = Piece(WHITE, KNIGHT)
        self.assertEqual(repr(piece), "<Piece: (White, Knight)>")
        piece = Piece(BLACK, QUEEN)
        self.assertEqual(repr(piece), "<Piece: (Black, Queen)>")

    def test_type_err(self):
        with self.assertRaisesRegex(TypeError, re.escape("Expected a Color, got Pawn (bulletchess.PieceType)")):
            _ = Piece(PAWN, WHITE) #type: ignore
        with self.assertRaisesRegex(TypeError, re.escape("Expected a PieceType, got Black (bulletchess.Color)")):
            _ = Piece(WHITE, BLACK) #type: ignore

if __name__ == "__main__":
    unittest.main()
