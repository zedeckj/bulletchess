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
        self.assertNotEqual(Move(A2, A1), Move(A2, A1, promote_to = QUEEN))

    def test_hash(self):
        moves = []
        for origin in SQUARES:
            for destination in SQUARES:
                for promote_to in [None] + PIECE_TYPES:
                    try:
                        moves.append(Move(origin, destination, promote_to = promote_to))
                    except:
                        continue
        self.assertGreater(len(moves), 64 * 24)
        hashes = [hash(m) for m in moves]
        self.assertEqual(len(hashes), len(moves))
        self.assertNotIn(-1, hashes)

if __name__ == "__main__":
    unittest.main()
