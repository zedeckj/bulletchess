import unittest
import sys
sys.path.append("./")
from bulletchess import *
from bulletchess.pgn import *
from new_tests.pgn.pgn_test import PGNTestCase

FILEPATH = "new_tests/pgn/files/empty.pgn"

class TestPGN(PGNTestCase):

    def test(self):
        with self.assertNoLogs():
            with PGNFile.open(FILEPATH) as f:
                game = f.next_game()
                self.assertEqual(game, None)
                game = f.next_game()
                self.assertEqual(game, None)
            self.assertFalse(f.is_open())


    
if __name__ == "__main__":
    unittest.main()
