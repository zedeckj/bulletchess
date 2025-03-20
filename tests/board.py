import unittest
import sys
sys.path.append("./")
from bulletchess import *

class TestBoard(unittest.TestCase):
    """
    Tests basic methods of boards, outside of using Moves
    """

    def test_copy(self):
        
        board = Board.starting()
        self.assertEqual(board, board.copy())
        self.assertIsNot(board, board.copy())
        board = Board.from_fen("r1bqkbnr/pppp2pp/2n5/4pp2/2B1P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 0 4")
        self.assertEqual(board, board.copy())
        self.assertIsNot(board, board.copy())


if __name__ == "__main__":
    unittest.main()
