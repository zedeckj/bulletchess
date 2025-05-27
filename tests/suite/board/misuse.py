import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestBoardMisuse(unittest.TestCase):

    def test_new_attr(self):
        with self.assertRaisesRegex(TypeError, re.escape("cannot set 'foo' attribute of immutable type 'bulletchess.Board'")):
            Board.foo = "x" #type: ignore
        board = Board()
        with self.assertRaisesRegex(AttributeError, re.escape("bulletchess.Board' object has no attribute 'foo' and no __dict__ for setting new attributes")):
            board.foo = "x" #type: ignore


if __name__ == "__main__":
    unittest.main()
