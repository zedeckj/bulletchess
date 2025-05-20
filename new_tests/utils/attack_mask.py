import unittest
import sys
sys.path.append("./")
from bulletchess import *

class TestAttackMask(unittest.TestCase):

    def testStarting(self):
        expected = Bitboard([
            A6, B6, C6, D6, E6, F6, G6, H6,
            A7, B7, C7, D7, E7, F7, G7, H7,
            B8, C8, D8, E8, F8, G8
        ])
        
        board = Board()
        attack = utils.attack_mask(board, BLACK)
        self.assertEqual(expected, attack)

    def testRook(self):
        expected = (B_FILE | RANK_5 | Bitboard([H7, G7, G8])) & ~Bitboard([B5])
        board = Board.from_fen("7k/8/8/1r6/8/8/8/7K w - - 0 1")
        attack = utils.attack_mask(board, BLACK)
        self.assertEqual(expected, attack)
    
    def testKnight(self):
        expected = Bitboard([H6, F6, E7])
        board = Board.from_fen("6n1/8/8/8/8/8/8/8 w - - 0 1")
        attack = utils.attack_mask(board, BLACK)
        self.assertEqual(expected,attack)

    def testPawn(self):
        expected = Bitboard([D5, F5])
        board = Board.empty()
        board[E4] = Piece(WHITE, PAWN)
        self.assertEqual(utils.attack_mask(board, WHITE), expected)
        self.assertEqual(utils.attack_mask(board, BLACK), EMPTY_BB)

if __name__ == "__main__":
    unittest.main()