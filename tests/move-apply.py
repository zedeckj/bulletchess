import unittest
import sys
sys.path.append("./")
from bulletchess import *

class TestMoveApply(unittest.TestCase):

    """
    Tests applying and undoing moves
    """

    def testItalianGame(self):
        board = Board.starting()
        fen1 = "rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1"
        fen2 ="rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR w KQkq e6 0 2" 
        fen3 = "rnbqkbnr/pppp1ppp/8/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq - 1 2"
        fen4 = "r1bqkbnr/pppp1ppp/2n5/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R w KQkq - 2 3"
        fen5 = "r1bqkbnr/pppp1ppp/2n5/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R b KQkq - 3 3"
        undo5 = board.apply(Move.from_uci("e2e4"))
        self.assertEqual(board, Board.from_fen(fen1))
        undo4 = board.apply(Move.from_uci("e7e5"))
        self.assertEqual(board, Board.from_fen(fen2))
        undo3 = board.apply(Move.from_uci("g1f3"))
        self.assertEqual(board, Board.from_fen(fen3))
        undo2 = board.apply(Move.from_uci("b8c6"))
        self.assertEqual(board, Board.from_fen(fen4))
        undo1 = board.apply(Move.from_uci("f1c4"))
        self.assertEqual(board, Board.from_fen(fen5))
        board.undo(undo1)
        self.assertEqual(board, Board.from_fen(fen4))
        board.undo(undo2)
        self.assertEqual(board, Board.from_fen(fen3))
        board.undo(undo3)
        self.assertEqual(board, Board.from_fen(fen2))
        board.undo(undo4)
        self.assertEqual(board, Board.from_fen(fen1))
        board.undo(undo5)
        self.assertEqual(board, Board.starting())

if __name__ == "__main__":
    unittest.main()
