import unittest
import sys
sys.path.append("./")
from bulletchess import *

class TestMoveOverrides(unittest.TestCase):

    def test_eq(self):
        move = Move(E1, E2)
        self.assertEqual(move, move)
        self.assertEqual(move, Move(E1,E2))
        self.assertNotEqual(move, Move(E2, E1))

    def test_hash(self):
        move = Move(E1, E2)
        self.assertEqual(move, move)
        self.assertEqual(move, Move(E1,E2))
        self.assertNotEqual(move, Move(E2, E1))

if __name__ == "__main__":
    unittest.main()
