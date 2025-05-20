import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

board1 = Board.from_fen("8/p1p3p1/3p3p/1P5P/1PP1P1P1/8/8/8 w - - 0 1")
board2 = Board.from_fen("4k3/2p3p1/1p2p2p/1P2P2P/1PP3P1/4P3/8/4K3 w - - 0 1")
board3 = Board.from_fen("3k4/8/4p3/4P3/5PP1/8/8/3K4 w - - 0 1")
board4 = Board.from_fen("8/8/7p/1P2Pp1P/2Pp1PP1/8/8/8 w - - 0 1")
board5 = Board.from_fen("5rk1/1q1r1pbp/pp1p1np1/4p1B1/1PP1P3/2NQ1P2/P5PP/2RR2K1 w - - 9 22")
board6 = Board.from_fen("8/5p2/8/4P3/8/8/5P2/8 w - - 0 1")

def print_boards():
    boards = [board1, board2, board3, board4, board5, board6]
    for i, board in enumerate(boards):
        print(f"board{i+1}")
        print(board.pretty())

class TestPawnBitboardUtils(unittest.TestCase):

    def assertBitboardEqual(self, bb : Bitboard, squares : list[Square]):
        self.assertEqual(bb, Bitboard(squares), msg = "\n" + str(bb) + "\n doesnt equal \n" + str(Bitboard(squares)))

    def test_isolated(self):
        self.assertBitboardEqual(utils.isolated_pawns(board1), ([A7, E4]))
        self.assertBitboardEqual(utils.isolated_pawns(board2), ([E3, E5, E6]))
        self.assertBitboardEqual(utils.isolated_pawns(board1, color = WHITE), ([E4]))
        self.assertBitboardEqual(utils.isolated_pawns(board1, color = BLACK), ([A7]))
        self.assertBitboardEqual(utils.isolated_pawns(board2, WHITE), ([E3, E5]))
        self.assertBitboardEqual(utils.isolated_pawns(board2, BLACK), ([E6]))

    def test_doubled(self):
        self.assertBitboardEqual(utils.doubled_pawns(board1), ([B4, B5]))
        self.assertBitboardEqual(utils.doubled_pawns(board1, WHITE), ([B4, B5]))
        self.assertBitboardEqual(utils.doubled_pawns(board1, color = BLACK), ([]))
        self.assertBitboardEqual(utils.doubled_pawns(board2), ([B4, B5, E3, E5]))
        self.assertBitboardEqual(utils.doubled_pawns(board2, color = WHITE), ([B4, B5, E3, E5]))
        self.assertBitboardEqual(utils.doubled_pawns(board2, BLACK), ([]))

    def test_backwards(self):
        self.assertBitboardEqual(utils.backwards_pawns(board1), ([E4, A7, C7, G7, G4]))
        self.assertBitboardEqual(utils.backwards_pawns(board2), ([C7, G7, G4]))
        self.assertBitboardEqual(utils.backwards_pawns(board3), [])
        self.assertBitboardEqual(utils.backwards_pawns(board5), [D6])
        self.assertBitboardEqual(utils.backwards_pawns(board6), [F7])

        self.assertBitboardEqual(utils.backwards_pawns(board1, color = WHITE), ([E4, G4]))
        self.assertBitboardEqual(utils.backwards_pawns(board2, WHITE), ([G4]))
        self.assertBitboardEqual(utils.backwards_pawns(board3, WHITE), [])
        self.assertBitboardEqual(utils.backwards_pawns(board5, WHITE), [])
        self.assertBitboardEqual(utils.backwards_pawns(board6, WHITE), [])

        self.assertBitboardEqual(utils.backwards_pawns(board1, BLACK), ([A7, C7, G7]))
        self.assertBitboardEqual(utils.backwards_pawns(board2, color = BLACK), ([C7, G7]))
        self.assertBitboardEqual(utils.backwards_pawns(board3, BLACK), [])
        self.assertBitboardEqual(utils.backwards_pawns(board5, BLACK), [D6])
        self.assertBitboardEqual(utils.backwards_pawns(board6, BLACK), [F7])
        

    def test_passed(self):
        self.assertBitboardEqual(utils.passed_pawns(board1), [])
        self.assertBitboardEqual(utils.passed_pawns(board2), ([]))
        self.assertBitboardEqual(utils.passed_pawns(board4), ([B5, C4, E5, D4]))
        self.assertBitboardEqual(utils.passed_pawns(board5), [])

        self.assertBitboardEqual(utils.passed_pawns(board1, color = WHITE), [])
        self.assertBitboardEqual(utils.passed_pawns(board2, WHITE), ([]))
        self.assertBitboardEqual(utils.passed_pawns(board4, WHITE), ([B5, C4, E5]))
        self.assertBitboardEqual(utils.passed_pawns(board5, WHITE), [])

        self.assertBitboardEqual(utils.passed_pawns(board1, BLACK), [])
        self.assertBitboardEqual(utils.passed_pawns(board2, BLACK), ([]))
        self.assertBitboardEqual(utils.passed_pawns(board4, BLACK), ([D4]))
        self.assertBitboardEqual(utils.passed_pawns(board5, color = BLACK), [])

    def test_open_files(self):
        self.assertBitboardEqual(utils.open_files(board1), list(F_FILE))
        self.assertBitboardEqual(utils.open_files(board2), list(F_FILE | A_FILE | D_FILE))

    def test_half_open_files(self):
        self.assertBitboardEqual(utils.half_open_files(board1, BLACK), list(B_FILE | E_FILE))
        self.assertBitboardEqual(utils.half_open_files(board1, WHITE), list(A_FILE | D_FILE))
        self.assertBitboardEqual(utils.half_open_files(board2, BLACK), [])

if __name__ == "__main__":
    print_boards()
    unittest.main()
    
