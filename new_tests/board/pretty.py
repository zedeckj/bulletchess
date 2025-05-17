import unittest
import sys
sys.path.append("./")
from bulletchess import *

import json

def print_moves_from(board : Board, origin : Square, color_scheme : Board.ColorScheme, name : str):
    moves = board.legal_moves()
    dest = EMPTY_BB
    for move in moves:
        if move.origin == origin:
            dest |= Bitboard([move.destination])
    print(f"\n{name}\n" + board.pretty(color_scheme, highlighted_squares=Bitboard([origin]), targeted_squares=dest))

class TestBoardPretty(unittest.TestCase):
    def assertCleanup(self, unicode : str):
        cleanup = "\033[0m"
        self.assertEqual(unicode[-len(cleanup):], "\033[0m")
    

    def test_staring(self):
        uni = Board().pretty()
        self.assertCleanup(uni)

    def test_visual(self):
        board = Board()
        board.apply(Move(E2, E4))
        board.apply(Move(E7, E5))
        board.apply(Move(G1, F3))
        board.apply(Move(B8, C6))
        print_moves_from(board, D2, Board.LAGOON, "LAGOON")
        print_moves_from(board, F3, Board.SLATE, "SLATE")
        print_moves_from(board, E1, Board.OAK, "OAK")
        print_moves_from(board, B1, Board.GREEN, "GREEN")
        print_moves_from(board, F1, Board.WALNUT, "WALNUT")
        #NEW_COLOR1 = ColorScheme(251, 138, 222)
        print_moves_from(board, B2, Board.CLAY, "CLAY")
        #NEW_COLOR2 = ColorScheme(224, 197, 189) 
        print_moves_from(board, A2, Board.ROSE, "ROSE")
        #GREY_COLOR = ColorScheme(251,243,231)
        print_moves_from(board, A2, Board.STEEL, "STEEL")
        


if __name__ == "__main__":
    unittest.main()
