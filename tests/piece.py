import unittest
import sys
import string
import random
sys.path.append("./")
from bulletchess import *

VALID_SYMBOLS = ["p", "n", "b", "q", "r", "k", "P", "N", "B", "Q", "R", "K", "-"]

EXPECTED_SYMBOLS = {
    (BLACK, PAWN): "p",
    (BLACK, KNIGHT): "n",
    (BLACK, BISHOP): "b",
    (BLACK, ROOK): "r",
    (BLACK, QUEEN): "q",
    (BLACK, KING): "k",

    (WHITE, PAWN): "P",
    (WHITE, KNIGHT): "N",
    (WHITE, BISHOP): "B",
    (WHITE, ROOK): "R",
    (WHITE, QUEEN): "Q",
    (WHITE, KING): "K",

}

class TestPiece(unittest.TestCase):
    """
    Tests the basic functionality of the Piece class
    """

    def test_construct(self):
        for piece_type in PIECE_TYPES:
            self.assertNoLogs(Piece(WHITE, piece_type))
            self.assertNoLogs(Piece(BLACK, piece_type))
        for symbol in VALID_SYMBOLS:
            self.assertNoLogs(Piece.from_symbol(symbol))
        
        for s in string.ascii_letters + string.digits:
            if s not in VALID_SYMBOLS:
                with self.assertRaisesRegex(ValueError, f"Invalid piece symbol: {s}"):
                    Piece.from_symbol(s)
        for symbol in VALID_SYMBOLS:
            longer = symbol + random.choice(string.ascii_letters)
            with self.assertRaisesRegex(ValueError, f"Invalid piece symbol: {s}"):
                Piece.from_symbol(s)

        with self.assertRaises(ValueError):
            Piece(10, 10)
        with self.assertRaises(ValueError):
            Piece(KING, WHITE)
        with self.assertRaises(ValueError):
            Piece(PAWN, BLACK)

    def test_attributes(self):
        self.assertNotEqual(WHITE, BLACK)
        for i in range(len(PIECE_TYPES) - 1):
            for j in range(i + 1, len(PIECE_TYPES)):
                self.assertNotEqual(PIECE_TYPES[i], PIECE_TYPES[j])

        for piece_type in PIECE_TYPES:
            piece = Piece(WHITE, piece_type)
            self.assertEqual(piece.color, WHITE)
            self.assertEqual(piece.piece_type, piece_type)
            piece = Piece(BLACK, piece_type)
            self.assertEqual(piece.color, BLACK)
            self.assertEqual(piece.piece_type, piece_type)
                 
    def test_equality(self):
        self.assertEqual(None, Piece.from_symbol("-"))
        for color in [WHITE, BLACK]:
            for piece_type in PIECE_TYPES:
                piece = Piece(color, piece_type)
                self.assertEqual(piece, piece)
                for color2 in [WHITE, BLACK]:
                    for piece_type2 in PIECE_TYPES:
                        piece2 = Piece(color2, piece_type2)
                        piece3 = Piece.from_symbol(EXPECTED_SYMBOLS[(color2, piece_type2)])
                        if piece_type == piece_type2 and color == color2:
                            self.assertEqual(piece, piece2)
                            self.assertEqual(piece, piece3)
                        else:
                            self.assertNotEqual(piece, piece2)
                            self.assertNotEqual(piece, piece3)
                        self.assertEqual(piece2, piece3)
                   
    def test_to_string(self):
        for color, piece_type in EXPECTED_SYMBOLS:
            self.assertEqual(str(Piece(color, piece_type)), EXPECTED_SYMBOLS[(color, piece_type)])
          
    def test_hashing(self):
        pieces = []
        for color in [WHITE, BLACK]:
            for piece_type in PIECE_TYPES:
                pieces.append(Piece(color, piece_type))
        hashes = {hash(piece) for piece in pieces + [None]}
        self.assertEqual(len(hashes), 13)

    def test_empy(self):
        piece = Piece.from_symbol("-")
        self.assertEqual(piece, None)

if __name__ == "__main__":
    unittest.main()
