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
        self.assertNotIn(-1, hashes)

    def test_repr(self):
        piece = Piece(WHITE, KNIGHT)
        self.assertEqual(repr(piece), "<Piece: (White, Knight)>")
        piece = Piece(BLACK, QUEEN)
        self.assertEqual(repr(piece), "<Piece: (Black, Queen)>")

    def test_str(self):
        expected = {
            Piece(WHITE, PAWN) : "P",
            Piece(WHITE, KNIGHT) : "N",
            Piece(WHITE, BISHOP) : "B",
            Piece(WHITE, ROOK) : "R",
            Piece(WHITE, QUEEN) : "Q",
            Piece(WHITE, KING) : "K",
            Piece(BLACK, PAWN) : "p",
            Piece(BLACK, KNIGHT) : "n",
            Piece(BLACK, ROOK) : "r",
            Piece(BLACK, BISHOP) : "b",
            Piece(BLACK, QUEEN) : "q",
            Piece(BLACK, KING) : "k",
        }
        for piece in expected:
            self.assertEqual(str(piece), expected[piece])


    def test_from_str(self):
        expected = {
            Piece(WHITE, PAWN) : "P",
            Piece(WHITE, KNIGHT) : "N",
            Piece(WHITE, BISHOP) : "B",
            Piece(WHITE, ROOK) : "R",
            Piece(WHITE, QUEEN) : "Q",
            Piece(WHITE, KING) : "K",
            Piece(BLACK, PAWN) : "p",
            Piece(BLACK, KNIGHT) : "n",
            Piece(BLACK, ROOK) : "r",
            Piece(BLACK, BISHOP) : "b",
            Piece(BLACK, QUEEN) : "q",
            Piece(BLACK, KING) : "k",
        }
        for piece in expected:
            self.assertEqual(Piece.from_chr(expected[piece]), piece)


    def test_unicode(self):
        expected = {
            Piece(WHITE, PAWN) : "♙",
            Piece(WHITE, KNIGHT) : "♘",
            Piece(WHITE, BISHOP) : "♗",
            Piece(WHITE, ROOK) : "♖",
            Piece(WHITE, QUEEN) : "♕",
            Piece(WHITE, KING) : "♔",
            Piece(BLACK, PAWN) : "♟",
            Piece(BLACK, KNIGHT) : "♞",
            Piece(BLACK, ROOK) : "♜",
            Piece(BLACK, BISHOP) : "♝",
            Piece(BLACK, QUEEN) : "♛",
            Piece(BLACK, KING) : "♚",
        }
        for piece in expected:
            self.assertEqual(piece.unicode(), expected[piece])

    def test_bool(self):
        for color in [WHITE, BLACK]:
            for pt in PIECE_TYPES:
                piece = Piece(color, pt)
                self.assertTrue(bool(piece))

    def test_from_str_err(self):
        with self.assertRaisesRegex(TypeError, re.escape("Expected a str, got 2 (int)")):
            Piece.from_chr(2) #type: ignore
        with self.assertRaisesRegex(ValueError, re.escape("Invalid Piece string \"m\"")):
            Piece.from_chr("m") 


    def test_type_err(self):
        with self.assertRaisesRegex(TypeError, re.escape("Expected a Color, got Pawn (bulletchess.PieceType)")):
            _ = Piece(PAWN, WHITE) #type: ignore
        with self.assertRaisesRegex(TypeError, re.escape("Expected a PieceType, got Black (bulletchess.Color)")):
            _ = Piece(WHITE, BLACK) #type: ignore

if __name__ == "__main__":
    unittest.main()
