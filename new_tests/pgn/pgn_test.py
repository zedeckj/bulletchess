import unittest
import sys
sys.path.append("./")
from bulletchess import *
from bulletchess.pgn import *
from typing import Any, Optional

class PGNTestCase(unittest.TestCase):
    
    def assertEventEq(self, game : PGNGame, value : Optional[str]):
        self.assertEqual(game.event, value)
        self.assertEqual(game["Event"], value)

    def assertSiteEq(self, game : PGNGame, value : Optional[str]):
        self.assertEqual(game.site, value)
        self.assertEqual(game["Site"], value)

    def assertWhiteEq(self, game : PGNGame, value : Optional[str]):
        self.assertEqual(game.white_player, value)
        self.assertEqual(game["White"], value)

    def assertBlackEq(self, game : PGNGame, value : Optional[str]):
        self.assertEqual(game.black_player, value)
        self.assertEqual(game["Black"], value)

    def assertRoundEq(self, game : PGNGame, value : Optional[str]):
        self.assertEqual(game.round, value)
        self.assertEqual(game["Round"], value)

    def assertDateEq(self, game : PGNGame, value : PGNDate):
        self.assertEqual(game.date, value)
        string_date = str(value)
        self.assertTrue(game["Date"] == string_date or game["UTCDate"] == string_date)

    def assertResultEq(self, game : PGNGame, value : PGNResult):
        self.assertEqual(game.result, value)
        self.assertTrue(game["Result"] == str(value))

    def assertMoveEq(self, move : Move, uci : str):
        self.assertEqual(move, Move.from_uci(uci))

    def assertOptional(self, thing : Any, t : type):
        self.assertTrue(thing is None or type(thing) == t)

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

