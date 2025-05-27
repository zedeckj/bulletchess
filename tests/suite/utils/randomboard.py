import unittest
import sys
from bulletchess import *
from bulletchess.utils import random_board

class TestBoardRandom(unittest.TestCase):

    def test_unique_and_valid(self):
        COUNT = 100000
        boards = set([random_board() for _ in range(COUNT)])
        self.assertGreater(len(boards), COUNT * 0.98)
        for board in boards:
            self.assertEqual(len(board[KING]), 2)

    def test_density(self):
        COUNT = 10000
        boards = [random_board() for _ in range(COUNT)]
        filled = 64 - sum([len(board[None]) for board in boards])/COUNT
        max_filled = 64 - min(len(board[None]) for board in boards)
        min_filled = 64 - max(len(board[None]) for board in boards)
        # Random boards should represent a full spectrum of piece counts,
        # and should average at around half the possible number of pieces.
        self.assertGreater(filled, 12)
        self.assertLess(filled, 20)
        self.assertEqual(max_filled, 32)
        self.assertLessEqual(min_filled, 3)


if __name__ == "__main__":
    unittest.main()
