import unittest
import sys
sys.path.append("./")
from bulletchess import *
from pgn_test import PGNTestCase

FILEPATH = "tests/pgn/invalid/errors.pgn"

def err_text(line : int, col : int, text : str) :
    return f"<{FILEPATH}:{line}:{col}>: Error When Parsing PGN: {text}"

class TestPGNErrors(PGNTestCase):


    def test_errors(self):
        """
        Not happy with current line and col of these errors
        """
        with PGNReader.open(FILEPATH) as f:
            with self.assertRaisesRegex(Exception, 
                err_text(9, 3, "Could not read move for the position rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1, Pawn moving to e5 is not legal, got e5")):
                _ = f.next_game()
            with self.assertRaisesRegex(Exception,
                err_text(25, 6, "Position has unknown character, got \"Illegal Fen\"")):
                game = f.next_game()


if __name__ == "__main__":
    unittest.main()
