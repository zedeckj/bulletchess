import unittest
import sys

sys.path.append("./")
from bulletchess import *


def evaluate(board : Board):
    if board in CHECKMATE:
        return 20000 if board.turn == BLACK else -20000
    elif board in DRAW:
        return 0
    else:
        bad_pawns = utils.backwards_pawns(board) | utils.isolated_pawns(board) | utils.doubled_pawns(board)
        return (
            utils.material(board) + 
            + 50 * (len(bad_pawns & board.black) - len(bad_pawns & board.white))
            + 10 * utils.mobility(board))

class TestEvaluation(unittest.TestCase):


    def assertEvalEqual(self, board : Board):
        self.assertEqual(utils.evaluate(board), evaluate(board), msg = f"\n{board.fen()}\n" + board.pretty())

    def test_basic(self):
        board = Board()
        board[D1] = None
        self.assertLess(utils.evaluate(board), 0)

    def test_pawns(self):
        board = Board.empty()
        board[E4] = Piece(WHITE, PAWN)
        self.assertEvalEqual(board)

    def test_queen(self):
        board = Board.empty()
        board[E4] = Piece(WHITE, QUEEN)
        self.assertEvalEqual(board)

    def test_random(self):
        boards = [Board.random() for _ in range(100000)]
        for board in boards:
            self.assertEvalEqual(board)

    def test_regression(self):
        board = Board.from_fen("rnb2bB1/2ppq3/6R1/p3kp2/P3pP2/4P3/N1P5/2KRB3 b - - 0 1")
        self.assertEvalEqual(board)
        board = Board.from_fen("rn2qb2/3bpk1r/p4n1p/2p3pP/7K/4PPP1/PPPPN3/RNB4R w - g6 0 15")
        self.assertEvalEqual(board)

if __name__ == "__main__":
    unittest.main()