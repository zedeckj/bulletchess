import unittest
import sys
sys.path.append("./")
from bulletchess import *


CHECK_FENS = [
    "r3k2r/Pppp1ppp/1b3nbN/nP6/BBP1P3/q4N2/Pp1P2PP/R2Q1RK1 w kq - 0 1",
    "rnbqk1nr/pppp1ppp/8/4P3/1b6/8/PPP1PPPP/RNBQKBNR w KQkq - 1 3",
    "rnbqkbnr/ppp1pppp/8/1B1p4/4P3/8/PPPP1PPP/RNBQK1NR b KQkq - 1 2",
    "r1bqkb1r/pppppppp/3N4/8/3n2n1/2N5/PPPPPPPP/R1BQKB1R b KQkq - 9 5",
    "rnbq1bnr/pppp1ppp/4k3/4p3/4P1Q1/4K3/PPPP1PPP/RNB2BNR b - - 5 4",
]

CHECKMATE_FENS = [  
    "r1bqkb1r/pppp1Qpp/2n2n2/4p3/2B1P3/8/PPPP1PPP/RNB1K1NR b KQkq - 0 4",
    "rnb1k1nr/pppp1ppp/8/2b1p1N1/4P3/2N5/PPPP1qPP/R1BQKB1R w KQkq - 0 5",

]

STALEMATE_FENS = [
    "8/Kbk5/8/8/8/8/8/8 w - - 0 1",
    "8/5KBk/8/8/8/8/8/8 b - - 0 1",
    "2R5/5B2/5K2/4N1B1/3k4/7R/3N4/8 b - - 0 1"
]

class TestCheck(unittest.TestCase):
    """
    Tests for checking if a player is in check, checkmate, and stalemate.
    """

    def testCheck(self):
        for fen in CHECK_FENS:
            board = Board.from_fen(fen)
            self.assertTrue(board.in_check(), msg = fen)
            self.assertFalse(board.is_checkmate(), msg = fen)
            self.assertFalse(board.is_stalemate(), msg = fen)

    def testCheckmate(self):
        for fen in CHECKMATE_FENS:
            board = Board.from_fen(fen)
            self.assertTrue(board.in_check(), msg = fen)
            self.assertTrue(board.is_checkmate(), msg = fen)
            self.assertFalse(board.is_stalemate(), msg = fen)

    
    def testStalemate(self):
        for fen in STALEMATE_FENS:
            board = Board.from_fen(fen)
            self.assertFalse(board.in_check(), msg = fen)
            self.assertFalse(board.is_checkmate(), msg = fen)
            self.assertTrue(board.is_stalemate(), msg = fen)


if __name__ == "__main__":
    unittest.main()


