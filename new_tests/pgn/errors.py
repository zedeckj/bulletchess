import unittest
import sys
sys.path.append("./")
from bulletchess import *
from bulletchess.pgn import *
from new_tests.pgn.pgn_test import PGNTestCase

FILEPATH = "new_tests/pgn/files/empty.pgn"

class TestPGNErrors(PGNTestCase):

    def test_open_doesnt_exist(self):
        with self.assertRaisesRegex(FileNotFoundError, "Could not find PGN file with path \"foo\""):
            PGNFile.open("foo")
        
    def test_open_dir(self):
        with self.assertRaisesRegex(IsADirectoryError, "The given path \"new_tests\" is a directory, cannot read as a PGN file."):
            f = PGNFile.open("new_tests")

    def test_open_read_invalid(self):
        f = PGNFile.open(str(__file__))
        with self.assertRaisesRegex(ValueError, "Invalid PGN File, could not read a game"):
            g = f.next_game()

    
if __name__ == "__main__":
    unittest.main()
