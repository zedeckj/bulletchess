import unittest
import sys
sys.path.append("./")
from bulletchess import *
from bulletchess.pgn import *
from suite.pgn.pgn_test import PGNTestCase

from suite import data_file

FILEPATH = data_file("pgn/missing.pgn")


def err_text(line : int, col : int, text : str) :
    return f"<{FILEPATH}:{line}:{col}>: Error When Parsing PGN: {text}"

class TestPGNMissing(PGNTestCase):


    def test_missing(self):
        f = PGNFile.open(FILEPATH)
        game = f.next_game()
        self.assertIsNotNone(game)
        if game != None:
            self.assertEqual(game.event, None)
            game = f.next_game()
            self.assertEqual(game.site, None)
            game = f.next_game()
            self.assertEqual(game.date, PGNDate(None, None, None))
            game = f.next_game()
            self.assertEqual(game.round, None)
            game = f.next_game()
            self.assertEqual(game.white_player, None)
            game = f.next_game()
            self.assertEqual(game.black_player, None)
            game = f.next_game()
            self.assertTrue(game.result.is_unknown)
        f.close()


if __name__ == "__main__":
    unittest.main()
