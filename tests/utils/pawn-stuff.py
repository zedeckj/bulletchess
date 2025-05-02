import unittest
import sys
sys.path.append("./")
from bulletchess import *

FEN_DICT = {}

def add_entry(FEN, doubled, isolated, backwards):
    FEN_DICT[FEN] = (doubled, isolated, backwards)

def get_doubled(FEN, color):
    return FEN_DICT[FEN][0][color == BLACK]

def get_isolated(FEN, color):
    return FEN_DICT[FEN][1][color == BLACK]

def get_backwards(FEN, color):
    return FEN_DICT[FEN][2][color == BLACK]

class TestPawnInfo(unittest.TestCase):

    def test_backwards(self):
        for entry in FEN_DICT:
            board = Board.from_fen(entry)
            for color in COLORS:
                self.assertEqual(utilsf.count_backwards_pawns(board, color), get_backwards(entry, color), msg = str(color) + "\n" + str(board)) 
    def test_doubled(self):

        for entry in FEN_DICT:
            board = Board.from_fen(entry)
            for color in COLORS:
                self.assertEqual(utilsf.count_doubled_pawns(board, color), get_doubled(entry, color), msg = str(color) + "\n" + str(board))

    def test_isolated(self):
        for entry in FEN_DICT:
            board = Board.from_fen(entry)
            for color in COLORS:
                self.assertEqual(utilsf.count_isolated_pawns(board, color), get_isolated(entry, color), msg = str(color) + "\n" + str(board))



if __name__ == "__main__":
    add_entry("r1bqkb1r/p1pp1ppp/2p2n2/4p3/4P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 0 1", (0,1), (0,1), (0,0)) # ruy lopez trade 
    add_entry("8/5p2/1k4p1/6P1/8/1P2K3/8/8 w - - 0 1", (0, 0), (2,0), (0,1)) 
    
    unittest.main()
