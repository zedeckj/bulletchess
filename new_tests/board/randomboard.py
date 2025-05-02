import unittest
import sys
sys.path.append("./")
from bulletchess import *
from bulletchess.utils import set_random_seed

class TestBoardRandom(unittest.TestCase):

    def test_unique(self):
        set_random_seed(0)
        COUNT = 10000
        boards = set([Board.random() for _ in range(COUNT)])
        self.assertEqual(len(boards), COUNT)
        
    def test_density(self):
        set_random_seed(0)
        COUNT = 10000
        boards = [Board.random() for _ in range(COUNT)]
        filled = 64 - sum([len(board.unoccupied) for board in boards])/COUNT
        max_filled = 64 - min(len(board.unoccupied) for board in boards)
        min_filled = 64 - max(len(board.unoccupied) for board in boards)
        # Random boards should represent a full spectrum of piece counts,
        # and should average at around half the possible number of pieces.
        self.assertGreater(filled, 12)
        self.assertLess(filled, 20)
        self.assertEqual(max_filled, 32)
        self.assertLessEqual(min_filled, 3)

if __name__ == "__main__":
    unittest.main()
