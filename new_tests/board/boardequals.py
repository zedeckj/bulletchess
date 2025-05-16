import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re



class TestBoardEquality(unittest.TestCase):

    def assertBoardsEqual(self, board1 : Board, board2 : Board):
        self.assertEqual(board1, board2)
        for sq in SQUARES:
            self.assertEqual(board1[sq], board2[sq])
        self.assertEqual(board1.castling_rights, board2.castling_rights)
        self.assertEqual(board1.halfmove_clock, board2.halfmove_clock)
        self.assertEqual(board1.fullmove_number, board2.fullmove_number)
        self.assertEqual(board1.turn, board2.turn)

    def test_basic(self):
        board = Board()
        self.assertBoardsEqual(board, Board())
        self.assertBoardsEqual(board, Board.from_fen(board.fen()))
        board2 = Board()
        board2.apply(Move(E2, E4))
        self.assertNotEqual(board2, Board())
        self.assertNotEqual(board2, Board.from_fen(board.fen()))

    def test_with_stack(self):
        board = Board()
        board.apply(Move(E2, E4))
        board2 = Board.from_fen(board.fen())
        self.assertBoardsEqual(board, board2)




if __name__ == "__main__":
    unittest.main()
