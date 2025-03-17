import unittest
import sys
sys.path.append("./")
from bulletchess import *

class TestIssues(unittest.TestCase):
    """
    This is a collection of tests that unfortunately pass.
    """

    def testEpEquality(self):
        """
        Boards are not considered equal if they have different en-passant squares, which is intended.
        However, many times the en-passant square is not indicated if it would not be legal.
        """

        board1 = Board.from_fen("rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1")
        board2 = Board.from_fen("rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq - 0 1")
        self.assertNotEqual(board1, board2)

    def fenError(self):
        # 3kbnr/pppqpppp/2n5/3p1b2/3P1B2/2N5/PPPQPPPP/2KR1BNR b kq - 7 5
        ...
    def enPassantDoubleCheck(self):
        ...


if __name__ == "__main__":
    unittest.main()
