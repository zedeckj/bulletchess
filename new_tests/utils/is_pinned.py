import unittest
import sys

sys.path.append("./")
from bulletchess import *

PINNED = {
    "6k1/5p2/8/3B4/2K5/8/8/8 w - - 0 1": [F7],
    "1rkr4/2n5/8/8/2R5/2K5/8/8 w - - 0 1": [C7],
    "R5nk/6p1/8/4B3/8/8/8/2K5 w - - 0 1": [G7, G8],
    "3k4/4r3/8/6B1/P3P3/2P5/1P1P1PPP/3K4 w - - 0 1": [E7]
}

class TestIsPinned(unittest.TestCase):

    def testStarting(self):
        board = Board()
        for square in SQUARES:
            self.assertFalse(utils.is_pinned(board, square))
        
    def testPinnedKnight(self):
        board = Board.from_fen("rnbqk1nr/pppp1ppp/8/4p3/1b6/2NP4/PPP1PPPP/R1BQKBNR w KQkq - 1 3")
        self.assertTrue(utils.is_pinned(board, C3))
        for square in SQUARES:
            if square != C3:
                self.assertFalse(utils.is_pinned(board, square))
        board.turn = board.turn.opposite
        self.assertTrue(utils.is_pinned(board, C3))

    def testNotPinnedBishop(self):
        board = Board.from_fen("rnbqk1nr/pppp1ppp/8/4p3/1b6/2BP4/PPP1PPPP/R1BQKBNR w KQkq - 1 3")
        self.assertFalse(utils.is_pinned(board, C3))
        board.turn = board.turn.opposite
        self.assertFalse(utils.is_pinned(board, C3))

    def testDualingQueens(self):
        board = Board.from_fen("6k1/5q2/8/8/3Q4/2K5/8/8 w - - 0 1")
        for square in SQUARES:
            self.assertFalse(utils.is_pinned(board, square))


    def testDict(self):
        for fen in PINNED:
            board = Board.from_fen(fen)
            for square in SQUARES:
                if square in PINNED[fen]:
                    self.assertTrue(utils.is_pinned(board, square), msg = fen + "\n" + board.pretty(highlighted_squares=Bitboard([square])))
                else:
                    self.assertFalse(utils.is_pinned(board, square), msg = "\n" + board.pretty(highlighted_squares=Bitboard([square])))

if __name__ == "__main__":
    board = Board.from_fen("6k1/5p2/8/3B4/2K5/8/8/8 w - - 0 1")
    utils.is_pinned(board, F7)
    #unittest.main()
    