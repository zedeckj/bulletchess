import unittest
import sys

sys.path.append("./")
from bulletchess import *



class TestEvaluation(unittest.TestCase):


    def test_basic(self):
        board = Board()
        board[D1] = None
        self.assertLess(utils.evaluate(board), 0)

    def test_something(self):
        raise NotImplementedError("Need to do something more")


if __name__ == "__main__":
    unittest.main()