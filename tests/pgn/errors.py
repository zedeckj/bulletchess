import unittest
import sys
sys.path.append("./")
from bulletchess import *
from bulletchess.pgn import *
from tests.pgn.pgn_test import PGNTestCase
import re

FILEPATH = "data/pgn/empty.pgn"

class TestPGNErrors(PGNTestCase):

    def test_open_doesnt_exist(self):
        with self.assertRaisesRegex(FileNotFoundError, "Could not find PGN file with path `foo`"):
            PGNFile.open("foo")
        
    def test_open_dir(self):
        with self.assertRaisesRegex(FileNotFoundError, "Could not find PGN file with path `new_tests`"):
            f = PGNFile.open("new_tests")
            f.next_game()

    def test_open_read_invalid(self):
        f = PGNFile.open(str(__file__))
        with self.assertRaisesRegex(ValueError, re.escape(f"{__file__}:1:1>: Error When Parsing PGN: Expected a tag pair begninning with [, got `import`")):
            f.next_game()

    
if __name__ == "__main__":
    unittest.main()
