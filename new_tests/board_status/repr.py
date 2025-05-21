import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re


class TestBoardStatusRepr(unittest.TestCase):

    def assertRepr(self, status : BoardStatus, body : str):
        self.assertEqual(f"<BoardStatus: {body}>", repr(status))

    def test_all(self):
        self.assertRepr(CHECK, "CHECK")
        self.assertRepr(CHECKMATE, "CHECKMATE")
        self.assertRepr(DRAW, "DRAW")
        self.assertRepr(STALEMATE, "STALEMATE")
        self.assertRepr(FORCED_DRAW, "FORCED_DRAW")
        self.assertRepr(INSUFFICIENT_MATERIAL, "INSUFFICIENT_MATERIAL")
        self.assertRepr(FIFTY_MOVE_TIMEOUT, "FIFTY_MOVE_TIMEOUT")
        self.assertRepr(SEVENTY_FIVE_MOVE_TIMEOUT, "SEVENTY_FIVE_MOVE_TIMEOUT")
        self.assertRepr(THREEFOLD_REPETITION, "THREE_FOLD_REPETITION")
        self.assertRepr(FIVEFOLD_REPETITION, "FIVE_FOLD_REPETITION")



if __name__ == "__main__":
    unittest.main()
