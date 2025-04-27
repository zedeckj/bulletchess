import unittest
import sys
sys.path.append("./")
from bulletchess import *

class PGNTestCase(unittest.TestCase):
    def assertMoveEq(self, move : Move, uci : str):
        self.assertEqual(move, Move.from_uci(uci))

    def assertMovesAre(self, game : Game, move_sans: list[str]):
        moves = game.moves()
        board = Board()
        
        self.assertEqual(board, Board())
        for i in range(len(move_sans)):
            san = moves[i].to_san(board)
            self.assertEqual(san, move_sans[i])
            board.apply(moves[i])
        

    def assertDraw(self, game : Game):
        self.assertEqual(game.result.draw, True)
        self.assertEqual(game.result.unknown, False)
        self.assertEqual(game.result.winner, None)

    def assertWinnerIs(self, game : Game, winner : Color):
        self.assertEqual(game.result.draw, False)
        self.assertEqual(game.result.unknown, False)
        self.assertEqual(game.result.winner, winner)

