import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re


class TestBoardStatusRepr(unittest.TestCase):

    def assertRepr(self, status : BoardStatus, body : str):
        self.assertEqual(f"<BoardStatus: {body}>", repr(status))

    def test_all(self):
        self.assertRepr(CHECK, "Check")
        self.assertRepr(CHECKMATE, "Checkmate")
        self.assertRepr(DRAW, "Draw")
        self.assertRepr(STALEMATE, "Stalemate")
        self.assertRepr(FORCED_DRAW, "ForcedDraw")
        self.assertRepr(INSUFFICIENT_MATERIAL, "INSUFFICIENT_MATERIAL")
        self.assertRepr(FIFTY_MOVE_TIMEOUT, "FIFTY_MOVE_TIMEOUT")
        self.assertRepr(SEVENTY_FIVE_MOVE_TIMEOUT, "SEVENTY_FIVE_MOVE_TIMEOUT")
        self.assertRepr(THREEFOLD_REPETITION, "THREE_FOLD_REPETITION")
        self.assertRepr(FIVEFOLD_REPETITION, "FIVE_FOLD_REPETITION")



if __name__ == "__main__":
    unittest.main()
