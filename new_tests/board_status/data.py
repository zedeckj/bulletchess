import unittest
import sys
sys.path.append("./")
from bulletchess import *
from new_tests.board_status.tester import BoardStatusTester
import re
import json


class TestBoardStatusFromJson(BoardStatusTester):


    def test_file(self):
        with open("new_tests/data/status.json", "r") as f:
            data = json.load(f)
        for fen in data:
            board = Board.from_fen(fen)
            match data[fen]:
                case "check":
                    self.assertOnlyCheck(board)
                case "insf":
                    self.assertInsf(board)
                case "checkmate":
                    self.assertCheckmate(board)
                case "stalemate":
                    self.assertStalemate(board)
                case "50":
                    self.assertFifty(board)
                case "75":
                    self.assertSeventyFive(board)




if __name__ == "__main__":
    unittest.main()
