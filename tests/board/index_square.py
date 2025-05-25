import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re


STARTING_SQUARE_TABLE = {
        A2: Piece(WHITE, PAWN),
        B2: Piece(WHITE, PAWN),
        C2: Piece(WHITE, PAWN),
        D2: Piece(WHITE, PAWN),
        E2: Piece(WHITE, PAWN),
        F2: Piece(WHITE, PAWN),
        G2: Piece(WHITE, PAWN),
        H2: Piece(WHITE, PAWN),

        A7: Piece(BLACK, PAWN),
        B7: Piece(BLACK, PAWN),
        C7: Piece(BLACK, PAWN),
        D7: Piece(BLACK, PAWN),
        E7: Piece(BLACK, PAWN),
        F7: Piece(BLACK, PAWN),
        G7: Piece(BLACK, PAWN),
        H7: Piece(BLACK, PAWN),

        A1: Piece(WHITE, ROOK),
        B1: Piece(WHITE, KNIGHT),
        C1: Piece(WHITE, BISHOP),
        D1: Piece(WHITE, QUEEN),
        E1: Piece(WHITE, KING),
        F1: Piece(WHITE, BISHOP),
        G1: Piece(WHITE, KNIGHT),
        H1: Piece(WHITE, ROOK),

        A8: Piece(BLACK, ROOK),
        B8: Piece(BLACK, KNIGHT),
        C8: Piece(BLACK, BISHOP),
        D8: Piece(BLACK, QUEEN),
        E8: Piece(BLACK, KING),
        F8: Piece(BLACK, BISHOP),
        G8: Piece(BLACK, KNIGHT),
        H8: Piece(BLACK, ROOK)
}

class TestBoardIndex(unittest.TestCase):

    def test_get(self):
        board = Board()
        for square in SQUARES:
            if square in STARTING_SQUARE_TABLE:
                self.assertIs(board[square], STARTING_SQUARE_TABLE[square])
            else:
                 self.assertIs(board[square], None)

    def test_set(self):
        board = Board()
        board[A1] = Piece(WHITE, QUEEN)
        self.assertIs(board[A1], Piece(WHITE, QUEEN))
        board[H8] = None
        self.assertIs(board[H8], None)

    def test_set2(self):
        for piece_type in PIECE_TYPES:
            for color in [WHITE, BLACK]:
                board = Board()
                unchanged = STARTING_SQUARE_TABLE.copy()
                for square in SQUARES:
                    board[square] = Piece(color, piece_type)
                    if square in unchanged:
                        del unchanged[square]
                        for square2 in unchanged:
                            self.assertIs(board[square2], unchanged[square2])
                    self.assertIs(board[square], Piece(color, piece_type))


    def test_typerr(self):
        board = Board()
        with self.assertRaisesRegex(TypeError, re.escape("Expected a Piece or None, got A1 (bulletchess.Square)")):
            board[A1] = A1 #type: ignore

    def test_del(self):
        board = Board()
        del board[E2]
        self.assertIs(board[E2], None)
        board[E2] = Piece(WHITE, PAWN)
        self.assertIs(board[E2], Piece(WHITE, PAWN))

    def test_del2(self):
        board = Board()
        unchanged = STARTING_SQUARE_TABLE.copy()
        for square in SQUARES:
            del board[square]
            if square in unchanged:
                del unchanged[square]
                self.assertIs(board[square], None)
                for square2 in unchanged:
                    self.assertIs(board[square2], unchanged[square2])

    def test_set_none(self):
        board = Board()
        for square in SQUARES:
            board[square] = None
            self.assertIs(board[square], None)

if __name__ == "__main__":
    unittest.main()
