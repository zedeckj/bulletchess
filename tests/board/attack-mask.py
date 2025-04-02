import unittest
import sys
sys.path.append("./")
from bulletchess import *

class TestAttackMask(unittest.TestCase):

    def testStarting(self):
        expected = Bitboard.from_squares([
            A6, B6, C6, D6, E6, F6, G6, H6,
            A7, B7, C7, D7, E7, F7, G7, H7,
            B8, C8, D8, E8, F8, G8
        ])
        
        board = Board()
        attack = board.attack_mask()
        self.assertEqual(expected, attack)

    def testRook(self):
        expected = (FILE_B | RANK_5 | Bitboard.from_squares([H7, G7, G8])) & ~Bitboard.from_squares([B5])
        board = Board.from_fen("7k/8/8/1r6/8/8/8/7K w - - 0 1")
        attack = board.attack_mask()
        self.assertEqual(expected,attack)
    
    def testKnight(self):
        expected = Bitboard.from_squares([H6, F6, E7])
        board = Board.from_fen("6n1/8/8/8/8/8/8/8 w - - 0 1")
        attack = board.attack_mask()
        self.assertEqual(expected,attack)

if __name__ == "__main__":
    unittest.main()
