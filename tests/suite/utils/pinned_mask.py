"""
import unittest
import sys
sys.path.append("./")
from bulletchess import *

class TestPinnedMask(unittest.TestCase):

    def testStarting(self):
        board = Board()
        for square in SQUARES:
            self.assertEqual(utils.pinned_mask(board, square), FULL_BB)

    def testPinnedKnight(self):
        board = Board.from_fen("rnbqk1nr/pppp1ppp/8/4p3/1b6/2NP4/PPP1PPPP/R1BQKBNR w KQkq - 1 3")
        mask = utils.pinned_mask(board, C3)
        self.assertEqual(mask, Bitboard([B4, C3, D2]), msg = mask)

    def testInCheck(self):
        board = Board.from_fen("rnbqk1nr/pppp1ppp/8/4P3/1b6/8/PPP1PPPP/RNBQKBNR w KQkq - 0 1")
        mask = utils.pinned_mask(board, E2)
        self.assertEqual(mask, Bitboard([B4, C3, D2]), msg = mask)

if __name__ == "__main__":
    unittest.main()
"""
    