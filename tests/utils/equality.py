import unittest
import sys
sys.path.append("./")
from bulletchess import *
from bulletchess.utils import *

class TestAlternativeEquality(unittest.TestCase):

    def test_starting(self):
        board = Board()
        board2 = Board()
        board.apply(Move(E2, E4))
        board2[E2] = None
        board2[E4] = Piece(WHITE, PAWN)
        board2.turn = BLACK
        board2.en_passant_square = E3
        self.assertTrue(legally_equal(board, board2))
        self.assertFalse(deeply_equal(board, board2))
        self.assertTrue(board == board2)
        board2.halfmove_clock = 100
        self.assertTrue(legally_equal(board, board2))
        self.assertFalse(deeply_equal(board, board2))
        self.assertFalse(board == board2)

    def test_deep(self):
        board = Board()
        board2 = Board()
        moves = []
        for i in range(100):
            move = random_legal_move(board)
            board.apply(move)
            board2.apply(move)
            moves.append(move)
        self.assertEqual(board, board2)
        self.assertTrue(deeply_equal(board, board2))

if __name__ == "__main__":
    unittest.main()