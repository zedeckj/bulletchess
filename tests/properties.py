import unittest
import sys
sys.path.append("./")
from bulletchess import *


class TestProperties(unittest.TestCase):

    def testStarting(self):
        board = Board.starting()
        self.assertEqual(board.halfmove_clock, 0)
        self.assertEqual(board.fullmove_number, 1)
        self.assertEqual(board.turn, WHITE)
        self.assertEqual(board.ep_square, None)

               
    def testEp(self):
        board = Board.starting()
        with self.assertRaisesRegex(ValueError,  
                                    "Illegal en passant Square c1, must be on either rank 3 or rank 6"):
            board.ep_square = C1
        with self.assertRaisesRegex(ValueError,
                                    "Illegal en passant Square e3, must be on rank 6 if it is white's turn"):
            board.ep_square = E3
        board.apply(Move.from_uci("e2e4"))
        self.assertEqual(board.ep_square, E3)
        board.ep_square = None
        self.assertEqual(board.ep_square, None)
        with self.assertRaisesRegex(ValueError, 
                                    "Illegal en passant Square f3, there is no corresponding white pawn"):
            board.ep_square = F3
        with self.assertRaisesRegex(ValueError,
                                    "Illegal en passant Square e6, must be on rank 3 if it is black's turn"):
            board.ep_square = E6

        board.ep_square = E3
        self.assertEqual(board.ep_square, E3)
        board.apply(Move.from_uci("e7e5"))
        self.assertEqual(board.ep_square, E6)
        with self.assertRaisesRegex(ValueError, 
                                    "Illegal en passant Square a6, there is no corresponding black pawn"):
            board.ep_square = A6       
        with self.assertRaisesRegex(ValueError, 
                                    "Illegal en passant Square, 64 is not a valid Square"):
            board.ep_square = 64


    def testClocks(self):
        board = Board.starting()
        board.halfmove_clock = 50
        self.assertEqual(board.halfmove_clock, 50)
        with self.assertRaisesRegex(ValueError, "Cannot set halfmove clock to a negative value, but got -1"):
            board.halfmove_clock = -1
        with self.assertRaisesRegex(ValueError, "Cannot set halfmove clock to a value greater than 65535, but got 70000"):
            board.halfmove_clock = 70000
        board.fullmove_number = 20
        self.assertEqual(board.fullmove_number, 20)
        with self.assertRaisesRegex(ValueError, "Cannot set fullmove number to a negative value, but got -2"):
            board.fullmove_number = -2
        with self.assertRaisesRegex(ValueError, "Cannot set fullmove number to a value greater than 65535, but got 80000"):
            board.fullmove_number = 80000


    def testTurn(self):
        board = Board.starting()
        self.assertEqual(board.turn, WHITE)
        board.apply(Move.from_uci("e2e4"))
        self.assertEqual(board.turn, BLACK)
        board.turn = WHITE
        self.assertEqual(board.turn, WHITE)
        with self.assertRaisesRegex(ValueError, 
                                    "Cannot set turn to a value that is not WHITE or BLACK, got: 3"):
            board.turn = 3

if __name__ == "__main__":
    unittest.main()

