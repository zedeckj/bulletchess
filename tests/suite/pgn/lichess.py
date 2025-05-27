import unittest
import sys
sys.path.append("./")
from bulletchess import *
from bulletchess.pgn import *
from suite.pgn.pgn_test import PGNTestCase
from suite import data_file

FILEPATH = data_file("pgn/lichess.pgn")


class TestPGN(PGNTestCase):

    def test_read_all(self):
        with self.assertNoLogs():
            games = 0
            with PGNFile.open(FILEPATH) as f:
                game = f.next_game()
                while game != None: 
                    games += 1
                    self.assertEqual(type(game.black_player), str)
                    self.assertEqual(type(game.white_player), str)
                    date = game.date
                    year = date.year
                    month = date.month
                    day = date.day
                    self.assertTrue(type(year) is int)
                    self.assertTrue(type(month) is int)
                    self.assertTrue(type(day) is int)
                    self.assertEqual(type(game.result), PGNResult)
                    self.assertEqual(game.round, None)
                    self.assertEqual(type(game.event), str)
                    self.assertEqual(type(game.site), str)
                    game = f.next_game()
            self.assertFalse(f.is_open())
            self.assertEqual(games, 4)

    def test_values(self):
        with PGNFile.open(FILEPATH) as f:
            game = f.next_game()
            self.assertEventEq(game, "Rated Classical game")
            self.assertSiteEq(game, "https://lichess.org/j1dkb5dw")
            self.assertWhiteEq(game, "BFG9k")
            self.assertBlackEq(game, "mamalak")
            self.assertResultEq(game, WHITE_WON)
            self.assertDateEq(game, PGNDate(2012, 12, 31))
            self.assertEqual(game["WhiteElo"], "1639")
            self.assertEqual(game["BlackElo"], "1403")
            self.assertEqual(game["WhiteRatingDiff"], "+5")
            self.assertEqual(game["BlackRatingDiff"], "-8")
            self.assertEqual(game["ECO"], "C00")
            self.assertEqual(game["Opening"], "French Defense: Normal Variation")
            self.assertEqual(game["TimeControl"], "600+8")
            self.assertEqual(game["Termination"], "Normal")
            self.assertEqual(game["Something Else"], None)
            self.assertMovesAre(game, [
                "e4", "e6", "d4", "b6", "a3", "Bb7", "Nc3", "Nh6", "Bxh6", "gxh6", "Be2", "Qg5", "Bg4", "h5", "Nf3", "Qg6", "Nh4", "Qg5", "Bxh5", "Qxh4", "Qf3", "Kd8", "Qxf7", "Nc6", "Qe8#"
            ])
            game = f.next_game()
            self.assertEventEq(game, "Rated Classical game")
            self.assertSiteEq(game, "https://lichess.org/a9tcp02g")
            self.assertWhiteEq(game, "Desmond_Wilson")
            self.assertBlackEq(game, "savinka59")
            self.assertResultEq(game, WHITE_WON)
            self.assertDateEq(game, PGNDate(2012, 12, 31))
            self.assertEqual(game["UTCTime"], "23:04:12")
            self.assertEqual(game["WhiteElo"], "1654")
            self.assertEqual(game["BlackElo"], "1919")
            self.assertEqual(game["WhiteRatingDiff"], "+19")
            self.assertEqual(game["BlackRatingDiff"], "-22")
            self.assertEqual(game["ECO"], "D04")
            self.assertEqual(game["Opening"], "Queen's Pawn Game: Colle System, Anti-Colle")
            self.assertEqual(game["TimeControl"], "480+2")
            self.assertEqual(game["Termination"], "Normal")
            self.assertEqual(game["Date"], None)
            self.assertMovesAre(game,[
                "d4", "d5", "Nf3", "Nf6", "e3", "Bf5", "Nh4", "Bg6", "Nxg6", "hxg6", "Nd2", "e6", "Bd3", "Bd6", "e4", "dxe4", "Nxe4", "Rxh2", "Ke2", "Rxh1", "Qxh1", "Nc6", "Bg5", "Ke7", "Qh7", "Nxd4+", "Kd2", "Qe8", "Qxg7", "Qh8", "Bxf6+", "Kd7", "Qxh8", "Rxh8", "Bxh8",
            ])


    
if __name__ == "__main__":
    unittest.main()
