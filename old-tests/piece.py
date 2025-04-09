import unittest
import sys
sys.path.append("./")
import bulletchess
from bulletchess import (
    PIECE_TYPES, Piece, WHITE, BLACK, SQUARES, 
    PAWN, KNIGHT, BISHOP, ROOK, QUEEN, KING
)


class TestPieces(unittest.TestCase):


    def testWhite(self):
        for piece_type in PIECE_TYPES:
            piece = Piece.new(piece_type, WHITE)
            self.assertTrue(piece.is_color(WHITE))
            for other_type in PIECE_TYPES:
                if other_type != piece_type:
                    self.assertFalse(piece.is_type(other_type))
                else:
                    self.assertTrue(piece.is_type(other_type))

    def testBlack(self):
        for piece_type in PIECE_TYPES:
            piece = Piece.new(piece_type, BLACK)
            self.assertTrue(piece.is_color(BLACK))
            for other_type in PIECE_TYPES:
                if other_type != piece_type:
                    self.assertFalse(piece.is_type(other_type))
                else:
                    self.assertTrue(piece.is_type(other_type))

    def testStr(self):
        expected = {
            Piece.new(PAWN, WHITE) : "P",
            Piece.new(KNIGHT, WHITE) : "N",
            Piece.new(BISHOP, WHITE) : "B",
            Piece.new(ROOK, WHITE) : "R",
            Piece.new(QUEEN, WHITE) : "Q",
            Piece.new(KING, WHITE) : "K",

            Piece.new(PAWN, BLACK) : "p",
            Piece.new(KNIGHT, BLACK) : "n",
            Piece.new(BISHOP, BLACK) : "b",
            Piece.new(ROOK, BLACK) : "r",
            Piece.new(QUEEN, BLACK) : "q",
            Piece.new(KING, BLACK) : "k",
        }

        for piece in expected:
            self.assertEqual(expected[piece], str(piece))

    def testRepr(self):
        expected = {
            Piece.new(PAWN, WHITE) : "P",
            Piece.new(KNIGHT, WHITE) : "N",
            Piece.new(BISHOP, WHITE) : "B",
            Piece.new(ROOK, WHITE) : "R",
            Piece.new(QUEEN, WHITE) : "Q",
            Piece.new(KING, WHITE) : "K",

            Piece.new(PAWN, BLACK) : "p",
            Piece.new(KNIGHT, BLACK) : "n",
            Piece.new(BISHOP, BLACK) : "b",
            Piece.new(ROOK, BLACK) : "r",
            Piece.new(QUEEN, BLACK) : "q",
            Piece.new(KING, BLACK) : "k",
        }


        for piece in expected:
            self.assertEqual(f"Piece({expected[piece]})", repr(piece))

    def testHash(self):
        expected = {

            Piece.new(PAWN, WHITE) : 17,
            Piece.new(KNIGHT, WHITE) : 18,
            Piece.new(BISHOP, WHITE) : 19,
            Piece.new(ROOK, WHITE) : 20,
            Piece.new(QUEEN, WHITE) : 21,
            Piece.new(KING, WHITE) : 22,

            Piece.new(PAWN, BLACK) : 33,
            Piece.new(KNIGHT, BLACK) : 34,
            Piece.new(BISHOP, BLACK) : 35,
            Piece.new(ROOK, BLACK) : 36,
            Piece.new(QUEEN, BLACK) : 37,
            Piece.new(KING, BLACK) : 38,
        }
        for piece in expected:
            self.assertEqual(hash(piece), expected[piece], msg = piece)




if __name__ == "__main__":
    unittest.main()