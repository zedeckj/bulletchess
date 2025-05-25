import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

statuses = [CHECK, CHECKMATE, DRAW, STALEMATE, FORCED_DRAW, INSUFFICIENT_MATERIAL, FIFTY_MOVE_TIMEOUT, SEVENTY_FIVE_MOVE_TIMEOUT, THREEFOLD_REPETITION, FIVEFOLD_REPETITION]

class TestBoardStatusRepr(unittest.TestCase):

    def assertRepr(self, status : BoardStatus, body : str):
        self.assertEqual(f"<BoardStatus: {body}>", repr(status))

    def test_all(self):
        for i in range(len(statuses)):
            for j in range(len(statuses)):
                if i == j:
                    self.assertEqual(statuses[i], statuses[j])
                else:
                     self.assertNotEqual(statuses[i], statuses[j])

    def test_hash(self):
        hashes = [hash(status) for status in statuses]
        print(hashes)
        self.assertEqual(len(statuses), len([hash(status) for status in statuses]))

if __name__ == "__main__":
    unittest.main()
