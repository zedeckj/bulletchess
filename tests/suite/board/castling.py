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

    def test_set_valid(self):
        with self.assertNoLogs():
            board = Board()
            board.castling_rights = CastlingRights([])
        with self.assertNoLogs():
            board = Board()
            board.castling_rights = ALL_CASTLING
        with self.assertNoLogs():
            board = Board()
            board.castling_rights = CastlingRights([WHITE_KINGSIDE, BLACK_QUEENSIDE])
        with self.assertNoLogs():
            board = Board.empty()
            board.castling_rights = NO_CASTLING
        with self.assertNoLogs():
            board = Board.from_fen("r1bqkbnr/pppp1ppp/2n5/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R b KQkq - 3 3")
            board.castling_rights = CastlingRights([WHITE_KINGSIDE])
        with self.assertNoLogs():
            board = Board.from_fen("r1bqkbnr/pppp1ppp/2n5/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R b KQkq - 3 3")
            board.castling_rights = CastlingRights([WHITE_KINGSIDE])
        with self.assertNoLogs():
            board = Board.from_fen("r1bq1knr/pppp1ppp/2nb4/4p3/2B1P3/5N2/PPPPQPPP/RNB1K2R w KQ - 6 5")
            board.castling_rights = CastlingRights([WHITE_QUEENSIDE])
        with self.assertNoLogs():
            board = Board.from_fen("r1bqk1nr/pppp1ppp/2nb4/4p3/2B1P3/5N2/PPPPQPPP/RNB2K1R w - - 8 6")
            board.castling_rights = CastlingRights([BLACK_QUEENSIDE, BLACK_KINGSIDE])

    def test_set_invalid(self):
        with self.assertRaisesRegex(ValueError, re.escape('<CastlingRights: "KQkq"> is illegal for <Board: "8/8/8/8/8/8/8/8 w - - 0 1">')):
            board = Board.empty()
            board.castling_rights = CastlingRights([WHITE_KINGSIDE, WHITE_QUEENSIDE, BLACK_KINGSIDE, BLACK_QUEENSIDE])
        with self.assertRaisesRegex(ValueError, re.escape('<CastlingRights: "KQkq"> is illegal for <Board: "r1bqk1nr/pppp1ppp/2n5/2b1p3/2B1P3/5N2/PPPP1PPP/RNBQ1RK1 w kq - 0 1')):
            board = Board.from_fen("r1bqk1nr/pppp1ppp/2n5/2b1p3/2B1P3/5N2/PPPP1PPP/RNBQ1RK1 w kq - 0 1")
            board.castling_rights = ALL_CASTLING



if __name__ == "__main__":
    unittest.main()
        