import unittest
import sys
sys.path.append("./")
from bulletchess import *
from bulletchess.pgn import *

class PGNTestCase(unittest.TestCase):
    
    def assertMoveEq(self, move : Move, uci : str):
        self.assertEqual(move, Move.from_uci(uci))

    def assertMovesAre(self, game : PGNGame, move_sans: list[str]):
        moves = game.moves
        board = Board()
        
        self.assertEqual(board, Board())
        for i in range(len(move_sans)):
            san = moves[i].san(board)
            self.assertEqual(san, move_sans[i])
            board.apply(moves[i])

        

    def assertDraw(self, game : PGNGame):
        self.assertEqual(game.result.draw, True)
        self.assertEqual(game.result.unknown, False)
        self.assertEqual(game.result.winner, None)

    def assertWinnerIs(self, game : PGNGame, winner : Color):
        self.assertEqual(game.result.draw, False)
        self.assertEqual(game.result.unknown, False)
        self.assertEqual(game.result.winner, winner)

