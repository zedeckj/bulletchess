import unittest
import sys
sys.path.append("./")
from bulletchess import *


class TestPredicates(unittest.TestCase):

    def test_starting_counts(self):
        board = Board.starting()
        pattern = Pattern().piece_count(Piece(WHITE, PAWN), 8)
        self.assertTrue(pattern in board)
        pattern = Pattern().piece_count(None, 32)
        self.assertTrue(pattern in board)
        pattern = pattern.piece_count(Piece(WHITE, ROOK), 2)
        self.assertTrue(pattern in board)
        pattern = pattern.piece_count(Piece(BLACK, KNIGHT), 3)
        self.assertFalse(pattern in board)
        pattern = pattern.piece_count(Piece(BLACK, KING), 1)
        self.assertFalse(pattern in board)

    def test_pawn_structure(self):
        board1 = Board.starting()
        board2 = Board.from_fen("r1bqkbnr/pppppppp/2n5/8/8/5N2/PPPPPPPP/RNBQKB1R w KQkq - 2 2")
        board3 = Board.from_fen("r1bqkbnr/pppppppp/2n5/8/3P4/5N2/PPP1PPPP/RNBQKB1R b KQkq - 0 2")
        pat = Pattern().from_board(PAWN, board1)
        self.assertTrue(pat in board1)
        self.assertTrue(pat in board2)
        self.assertFalse(pat in board3)

if __name__ == "__main__":
    unittest.main()
