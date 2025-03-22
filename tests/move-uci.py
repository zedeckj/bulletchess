import unittest
import sys
sys.path.append("./")
from bulletchess import *

VALID_MOVES = [
    # PAWN MOVES
    "e2e4", 
    "d7d6",
    "h7g8q",
    "a2a1n",
    "b2a1r",
    "f7e8n",
    # KNIGHT MOVES
    "g1f3",
    "b8c6",
    "c4e5",
    "b3d2",
    "h6f5",
    "c3a2",
    # BISHOP MOVE
    "b5d7",
    # ROOK MOVES
    "a1a8",
    "h8h1"
]

GARBLED_MOVES = ["", "a1", "b3a", "aij31", "12ij31", "r2d2"]

ILLEGAL_MOVES = ["a4a5q", "b5h6", "c5a1", "a7a8k", "b1b1", "e2e4q"]

FILE_CHARS = ['a','b','c','d','e','f','g','h']
RANK_CHARS = ['1','2','3','4','5','6','7','8']
PROMOTE_CHARS = ['r','n','q','b', '']

class TestMove(unittest.TestCase):

    """
    Tests the construction of moves from UCI and basic properties 
    """

    def testValid(self):
        return
        for uci in VALID_MOVES:
            move = Move.from_uci(uci)
            self.assertEqual(uci, str(move))

    def testGarbled(self):
        for s in GARBLED_MOVES:
            with self.assertRaises(Exception):
                move = Move.from_uci(s)

    def testIllegal(self):
        for s in ILLEGAL_MOVES:
            with self.assertRaises(Exception):
                move = Move.from_uci(s)

    def testEqual(self):
        moves1 = [Move.from_uci(uci) for uci in VALID_MOVES]
        moves2 = [Move.from_uci(uci) for uci in VALID_MOVES]
        for i in range(len(VALID_MOVES)):
            self.assertEqual(moves1[i], moves2[i])
            for j in range(i + 1, len(VALID_MOVES)):
                self.assertNotEqual(moves1[i], moves2[j])

    def testHash(self):
        # tests that all valid moves have unique hashes
        # all valid moves are found in an obviously efficient manner
        all_legal = []
        for orr in RANK_CHARS:
            for ofe in FILE_CHARS:
                for dr in RANK_CHARS:
                    for df in FILE_CHARS:
                        for p in PROMOTE_CHARS:
                            try:
                                uci = f"{ofe}{orr}{df}{dr}{p}"
                                move = Move.from_uci(uci)
                                all_legal.append(move)
                            except:
                                continue
        self.assertGreater(len(all_legal), 1000)
        hash_count = len({hash(move) for move in all_legal})
        self.assertEqual(len(all_legal), hash_count)

    def testNull(self):
        null = Move.from_uci("0000")
        self.assertEqual(null, "0000")


if __name__ == "__main__":
    unittest.main()
