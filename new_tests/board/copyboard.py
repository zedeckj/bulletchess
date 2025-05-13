import unittest
import sys
sys.path.append("./")
from bulletchess import *

class TestBoardCop(unittest.TestCase):

    def assertBoardsEqual(self, board1: Board, board2: Board):
        self.assertEqual(board1, board2)
        self.assertEqual(board1.pawns, board2.pawns)
        self.assertEqual(board1.knights, board2.knights)
        self.assertEqual(board1.bishops, board2.bishops)
        self.assertEqual(board1.rooks, board2.rooks)
        self.assertEqual(board1.queens, board2.queens)
        self.assertEqual(board1.kings, board2.kings)
        self.assertEqual(board1.halfmove_clock, board2.halfmove_clock)
        self.assertEqual(board1.fullmove_number, board2.fullmove_number)
        self.assertEqual(board1.turn, board2.turn)
        self.assertEqual(board1.castling_rights, board2.castling_rights)


    def test_basic(self):
        board = Board()
        board.apply(Move(E2, E4))
        cpy = board.copy()
        self.assertBoardsEqual(board, cpy)
        self.assertIsNot(board, cpy)
        undone = cpy.undo()
        self.assertEqual(undone, Move(E2, E4))
        self.assertEqual(cpy, Board())

    def test_random(self):
        boards = [Board.random() for _ in range(10000)]
        for board in boards:
            self.assertBoardsEqual(board, board.copy())

if __name__ == "__main__":
    unittest.main()
