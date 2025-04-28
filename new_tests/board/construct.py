import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestBoardConstruction(unittest.TestCase):

    def test_def(self):
        with self.assertNoLogs():
            Board()

    def test_invalid_def(self):
        with self.assertRaisesRegex(TypeError, re.escape("Board() creates a Board representing the starting position, and takes no arguments. "
        "Use Board.from_fen() to create a Board for a different position.")):
            Board('foo') #type: ignore

if __name__ == "__main__":
    unittest.main()
