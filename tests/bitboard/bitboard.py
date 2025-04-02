import unittest
import sys
sys.path.append("./")
from bulletchess import *

class TestBitboard(unittest.TestCase):
    """ 
    Tests the basic functionality of the Bitboard class
    """

    def testDirections(self):
        start = Bitboard.from_squares([G8])
        right = start.right()
        self.assertEqual(right, Bitboard.from_squares([H8]))
        none = right.right()
        self.assertEqual(none, Bitboard.from_squares([]))
        self.assertEqual(right.above(), Bitboard.from_squares([])) 
        self.assertEqual(right.below(), Bitboard.from_squares([H7]))
        self.assertEqual(start.left(), Bitboard.from_squares([F8]))
        self.assertEqual(start.above(), none)
        self.assertEqual(start.left().left(), Bitboard.from_squares([E8]))


    def testPieces(self):
        rook = Bitboard.piece_attacking(Piece(WHITE, ROOK), A1)
        self.assertEqual((FILE_A | RANK_1) & ~Bitboard.from_squares([A1]), rook)
        
        knight = Bitboard.piece_attacking(Piece(WHITE, KNIGHT), A1)
        self.assertEqual(Bitboard.from_squares([C2, B3]), knight)
        
        knight = Bitboard.piece_attacking(Piece(BLACK, KNIGHT), H8)
        self.assertEqual(Bitboard.from_squares([F7, G6]), knight)
       
        knight = Bitboard.piece_attacking(Piece(BLACK, KNIGHT), G1)

        print(knight)
        
        self.assertEqual(Bitboard.from_squares([H3, F3, E2]), knight)
        

        king = Bitboard.piece_attacking(Piece(WHITE, KING), E1)
        self.assertEqual(Bitboard.from_squares([D1, F1, D2, E2, F2]), king)


if __name__ == "__main__":
    unittest.main()
