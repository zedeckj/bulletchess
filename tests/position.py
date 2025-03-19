import unittest
import sys
sys.path.append("./")
from bulletchess import *


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

class TestPosition(unittest.TestCase):
    """
    Tests basic position creation using the `.starting()` staticmethod, as
    well as position manipulation using `get_piece_at`, `set_piece_at`, and `remove_piece_at`.
    
    Only deals with piece configurations

    Implicitly tests the equality function for Boards as well in terms of piece configuration
    """

       
    def testStarting(self):
        board = Board.starting()
        self.assertEqual(board.get_piece_at(A2), Piece(WHITE, PAWN))
        self.assertEqual(board.get_piece_at(B2), Piece(WHITE, PAWN))
        self.assertEqual(board.get_piece_at(C2), Piece(WHITE, PAWN))
        self.assertEqual(board.get_piece_at(D2), Piece(WHITE, PAWN))
        self.assertEqual(board.get_piece_at(E2), Piece(WHITE, PAWN))
        self.assertEqual(board.get_piece_at(F2), Piece(WHITE, PAWN))
        self.assertEqual(board.get_piece_at(G2), Piece(WHITE, PAWN))
        self.assertEqual(board.get_piece_at(H2), Piece(WHITE, PAWN))

        self.assertEqual(board.get_piece_at(A7), Piece(BLACK, PAWN))
        self.assertEqual(board.get_piece_at(B7), Piece(BLACK, PAWN))
        self.assertEqual(board.get_piece_at(C7), Piece(BLACK, PAWN))
        self.assertEqual(board.get_piece_at(D7), Piece(BLACK, PAWN))
        self.assertEqual(board.get_piece_at(E7), Piece(BLACK, PAWN))
        self.assertEqual(board.get_piece_at(F7), Piece(BLACK, PAWN))
        self.assertEqual(board.get_piece_at(G7), Piece(BLACK, PAWN))
        self.assertEqual(board.get_piece_at(H7), Piece(BLACK, PAWN))

        self.assertEqual(board.get_piece_at(A1), Piece(WHITE, ROOK))
        self.assertEqual(board.get_piece_at(B1), Piece(WHITE, KNIGHT))
        self.assertEqual(board.get_piece_at(C1), Piece(WHITE, BISHOP))
        self.assertEqual(board.get_piece_at(D1), Piece(WHITE, QUEEN))
        self.assertEqual(board.get_piece_at(E1), Piece(WHITE, KING))
        self.assertEqual(board.get_piece_at(F1), Piece(WHITE, BISHOP))
        self.assertEqual(board.get_piece_at(G1), Piece(WHITE, KNIGHT))
        self.assertEqual(board.get_piece_at(H1), Piece(WHITE, ROOK))

        self.assertEqual(board.get_piece_at(A8), Piece(BLACK, ROOK))
        self.assertEqual(board.get_piece_at(B8), Piece(BLACK, KNIGHT))
        self.assertEqual(board.get_piece_at(C8), Piece(BLACK, BISHOP))
        self.assertEqual(board.get_piece_at(D8), Piece(BLACK, QUEEN))
        self.assertEqual(board.get_piece_at(E8), Piece(BLACK, KING))
        self.assertEqual(board.get_piece_at(F8), Piece(BLACK, BISHOP))
        self.assertEqual(board.get_piece_at(G8), Piece(BLACK, KNIGHT))
        self.assertEqual(board.get_piece_at(H8), Piece(BLACK, ROOK))


    def testRemove(self):
        board = Board.starting()
        unchanged = STARTING_SQUARE_TABLE.copy()
        for square in SQUARES:
            board.remove_piece_at(square)
            if square in unchanged:
                del unchanged[square]
                self.assertEqual(board.get_piece_at(square), None)
                for square2 in unchanged:
                    self.assertEqual(board.get_piece_at(square2), unchanged[square2])
        # Removing using `set_piece_at`
        board = Board.starting()
        for square in SQUARES:
            board.set_piece_at(square, None)
            self.assertEqual(board.get_piece_at(square), None)

    def testSet(self):
        for piece_type in PIECE_TYPES:
            for color in [WHITE, BLACK]:
                board = Board.starting()
                unchanged = STARTING_SQUARE_TABLE.copy()
                for square in SQUARES:
                    board.set_piece_at(square, Piece(color, piece_type))
                    if square in unchanged:
                        del unchanged[square]
                        for square2 in unchanged:
                            self.assertEqual(board.get_piece_at(square2), unchanged[square2])
                    self.assertEqual(board.get_piece_at(square), Piece(color, piece_type))


    def testSquaresWith(self):
        board = Board.starting()
        self.assertEqual([A2, B2, C2, D2, E2, F2, G2, H2], board.get_squares_with(Piece(WHITE, PAWN))) 
        self.assertEqual([A8, H8], board.get_squares_with(Piece(BLACK, ROOK))) 
        self.assertEqual([E1], board.get_squares_with(Piece(WHITE, KING)))

if __name__ == "__main__":
    unittest.main()

