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


    def test_piece_at(self):
        board = utils.random_board()
        copy = board.copy()
        for square in SQUARES:
            self.assertEqual(board.get_piece_at(square), 
                             copy.get_piece_at(square))

    def test_copied_move_stack(self):
        board = Board.starting()
        board.apply(Move.from_san("e4", board))
        copy = board.copy()
        move = copy.undo()
        self.assertEqual(copy, Board.starting())
        self.assertEqual(move, Move.from_uci("e2e4"))


if __name__ == "__main__":
    unittest.main()
