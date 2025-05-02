import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestCountMoves(unittest.TestCase):

    def test_basic(self):
        boards = [Board.random() for _ in range(1000)]
        for b in boards:
            self.assertEqual(len(b.legal_moves()), utils.count_moves(b))

if __name__ == "__main__":
    unittest.main()