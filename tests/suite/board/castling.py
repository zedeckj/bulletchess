import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re
from typing import Optional

class TestBoardCastling(unittest.TestCase):

    def test_starting(self):
        self.assertTrue(Board().castling_rights.full())

    def test_empty(self):
        self.assertFalse(Board.empty().castling_rights.any())

    def test_set(self):
        with self.assertNoLogs():
            board = Board()
            board.castling_rights = CastlingRights([])
        with self.assertRaisesRegex(ValueError, re.escape('<CastlingRights: "KQkq"> is illegal for <Board: "8/8/8/8/8/8/8/8 w - - 0 1">')):
            board = Board.empty()
            board.castling_rights = CastlingRights([WHITE_KINGSIDE, WHITE_QUEENSIDE, BLACK_KINGSIDE, BLACK_QUEENSIDE])


if __name__ == "__main__":
    unittest.main()
        