import unittest
import sys
sys.path.append("./")
from bulletchess import *
from suite import data_file

import json
class TestBoardRepr(unittest.TestCase):
    

    def test_specific(self):
        board = Board()
        self.assertEqual(repr(board), 
        "<Board: \"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1\">")
        board = Board.empty()
        self.assertEqual(repr(board), 
        "<Board: \"8/8/8/8/8/8/8/8 w - - 0 1\">")

    def test_from_fen(self):
        with open (data_file("fens.json"), "r") as f:
            fens = json.load(f)
        for fen in fens:
            board = Board.from_fen(fen)
            self.assertEqual(repr(board), f"<Board: \"{fen}\">")

if __name__ == "__main__":
    unittest.main()
