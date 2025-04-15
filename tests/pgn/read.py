import unittest
import sys
sys.path.append("./")
from bulletchess import *

FILEPATH = "/Users/jordan/Documents/C/ChessLibrary/tests/pgn/example.pgn"

class TestPGN(unittest.TestCase):


    def assertMoveEq(self, move, uci):
        self.assertEqual(move, Move.from_uci(uci))

    def test_tags(self):
        return
        game = Game(FILEPATH)
        self.assertEqual(game.event, "F/S Return Match")
        self.assertEqual(game.site, "Belgrade, Serbia JUG")
        self.assertEqual(game.date, "1992.11.04")
        self.assertEqual(game.round, "29")
        self.assertEqual(game.white, "Fischer, Robert J.")
        self.assertEqual(game.black, "Spassky, Boris V.")
        self.assertEqual(game.result, "1/2-1/2")

    def test_moves(self):
        game = Game(FILEPATH)
        board, moves = game.board_moves()
        self.assertMoveEq(moves[0], "e2e4")
        self.assertMoveEq(moves[1], "e7e5")
        self.assertMoveEq(moves[2], "g1f3") # "g6f3" bad error
        self.assertMoveEq(moves[3], "b8c6")
        self.assertMoveEq(moves[4], "f1b5")
        self.assertMoveEq(moves[5], "a7a6")

if __name__ == "__main__":
    unittest.main()
