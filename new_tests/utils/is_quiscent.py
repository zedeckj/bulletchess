import unittest
import sys
sys.path.append("./")
from bulletchess import *

class TestIsQuiscent(unittest.TestCase):

    def testStarting(self):
        board = Board()
        self.assertTrue(utils.is_quiescent(board))
        


    def testRandom(self):
        boards = [Board.random() for _ in range(10000)]
        for board in boards:
            moves = board.legal_moves()
            quiet = not board.is_check()
            if quiet:
                for move in moves:
                    if move.is_capture(board):
                        quiet = False
                        break
            self.assertEqual(utils.is_quiescent(board), quiet, msg = board.fen())

if __name__ == "__main__":
    unittest.main()
    