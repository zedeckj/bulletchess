import unittest
import sys

sys.path.append("./")
from bulletchess import *


class TestMobility(unittest.TestCase):

    def testRandom(self):
        boards = [Board.random() for _ in range(10000)]
        for board in boards:
            real = utils.mobility(board)
            first_count = utils.count_moves(board)
            board.turn = board.turn.opposite
            second_count = utils.count_moves(board)
            if board.turn == BLACK:
                self.assertEqual(first_count - second_count, real)
            else:
                self.assertEqual(second_count - first_count, real)

if __name__ == "__main__":
    unittest.main()