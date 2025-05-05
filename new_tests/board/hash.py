import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re



class TestBoardIndex(unittest.TestCase):

    def test_collisions(self):
        COUNT = 100000
        utils.set_random_seed(0)
        boards = set([Board.random() for _ in range(COUNT)])
        hashes = set([hash(board) for board in boards])
        self.assertGreater(len(hashes), len(boards) * 0.9999)

    def test_eq(self):
        board = Board()
        self.assertEqual(hash(board), hash(Board()))



if __name__ == "__main__":
    unittest.main()
