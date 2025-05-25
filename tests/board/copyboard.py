import unittest
import sys
sys.path.append("./")
from bulletchess import *

class TestBoardCop(unittest.TestCase):

    def assertBoardsEqual(self, board1: Board, board2: Board):
        self.assertEqual(board1, board2)
        self.assertEqual(board1[PAWN], board2[PAWN])
        self.assertEqual(board1[KNIGHT], board2[KNIGHT])
        self.assertEqual(board1[BISHOP], board2[BISHOP])
        self.assertEqual(board1[ROOK], board2[ROOK])
        self.assertEqual(board1[QUEEN], board2[QUEEN])
        self.assertEqual(board1[KING], board2[KING])
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
        boards = [utils.random_board() for _ in range(10000)]
        for board in boards:
            self.assertBoardsEqual(board, board.copy())

if __name__ == "__main__":
    unittest.main()
