import unittest
import sys
import re
sys.path.append("./")
from bulletchess import *
from bulletchess.utils import *

class TestAliasBitboards(unittest.TestCase):

    def test_all(self):
        boards = [utils.random_board() for _ in range(1000)]
        for board in boards:
            self.assertEqual(Bitboard([king_square(board, WHITE)]), board[WHITE, KING])
            self.assertEqual(Bitboard([king_square(board, BLACK)]), board[BLACK, KING])


    def test_starting(self):
        self.assertEqual(king_square(Board(), WHITE), E1)
        self.assertEqual(king_square(Board(), BLACK), E8)

    def test_err(self):
        board = Board()
        board[A4] = Piece(WHITE, KING)
        self.assertEqual(king_square(board, BLACK), E8)
        with self.assertRaisesRegex(AttributeError, re.escape("Board has multiple White kings")):
            king_square(board, WHITE)

        board = Board()
        board[G5] = Piece(BLACK, KING)
        with self.assertRaisesRegex(AttributeError, re.escape("Board has multiple Black kings")):
            king_square(board, BLACK)

if __name__ == "__main__":
    unittest.main()