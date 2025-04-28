import unittest
import sys
sys.path.append("./")
from bulletchess import *

class TestMoveProps(unittest.TestCase):

    def test_basic(self):
        move = Move(E1, E2)
        self.assertEqual(move.origin, E1)
        self.assertEqual(move.destination, E2)
        self.assertEqual(move.promotion, None)


    def test_promotion(self):
        move = Move(A7, A8, QUEEN)
        self.assertEqual(move.origin, A7)
        self.assertEqual(move.destination, A8)
        self.assertEqual(move.promotion, QUEEN)


if __name__ == "__main__":
    unittest.main()
