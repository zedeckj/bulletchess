import unittest
import sys
sys.path.append("./")
from bulletchess import *

FILEPATH = "/Users/jordan/Documents/C/ChessLibrary/tests/pgn/example.pgn"

class TestPGN(unittest.TestCase):
    
    def test_tags(self):
        game = Game(FILEPATH)
        self.assertEqual(game.event, "F/S Return Match")
        self.assertEqual(game.site, "Belgrade, Serbia JUG")
        self.assertEqual(game.date, "1992.11.04")
        self.assertEqual(game.round, "29")
        self.assertEqual(game.white, "Fischer, Robert J.")
        self.assertEqual(game.black, "Spassky, Boris V.")
        self.assertEqual(game.result, "1/2-1/2")

if __name__ == "__main__":
    unittest.main()
