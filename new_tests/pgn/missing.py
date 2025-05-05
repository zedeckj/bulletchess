import unittest
import sys
sys.path.append("./")
from bulletchess import *
from bulletchess.pgn import *
from new_tests.pgn.pgn_test import PGNTestCase

FILEPATH = "new_tests/pgn/files/missing.pgn"

def err_text(line : int, col : int, text : str) :
    return f"<{FILEPATH}:{line}:{col}>: Error When Parsing PGN: {text}"

class TestPGNMissing(PGNTestCase):


    def test_errors(self):
        """
        Not happy with current line and col of these errors
        """
        f = PGNFile.open(FILEPATH)
        with self.assertRaisesRegex(Exception, 
            err_text(12, 2, "Missing tag pair for Event")):
            _ = f.next_game()
        with self.assertRaisesRegex(Exception,
            err_text(29, 2,"Missing tag pair for Site")):
            game = f.next_game()
        game = f.next_game()
        self.assertEqual(game.date, PGNDate(None, None, None))
        with self.assertRaisesRegex(Exception,
            err_text(66, 2, "Missing tag pair for Round")):
            game = f.next_game()
        with self.assertRaisesRegex(Exception,
            err_text(84, 2, "Missing tag pair for White")):
            game = f.next_game()
        with self.assertRaisesRegex(Exception,
            err_text(102, 2, "Missing tag pair for Black")):
            game = f.next_game()
        # Result uses default of unknown
        game = f.next_game()
        self.assertTrue(game.result.unknown)
        f.close()


if __name__ == "__main__":
    unittest.main()
