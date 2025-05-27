import unittest
import sys
sys.path.append("./")
from bulletchess import *
from suite import data_file
import json
class TestBoardStr(unittest.TestCase):
    

    def test_starting(self):
        board = Board()
        self.assertEqual(str(board),"r n b q k b n r \np p p p p p p p \n- - - - - - - - \n- - - - - - - - \n- - - - - - - - \n- - - - - - - - \nP P P P P P P P \nR N B Q K B N R \n")
        print("\n" + str(board))
        self.assertValidToStr(board)

    
    def assertValidToStr(self, board : Board):
        expect = ""
        for rank in reversed(RANKS): #hmmm
            for square in rank:
                piece = board[square]
                if piece:
                    expect += str(piece) + " "
                else:
                    expect += "- "
            expect += "\n"
        self.assertEqual(str(board), expect)
        

    def test_from_fen(self):
        with open (data_file("fens.json"), "r") as f:
            fens = json.load(f)
        for fen in fens:
            board = Board.from_fen(fen)
            self.assertValidToStr(board)



if __name__ == "__main__":
    unittest.main()
