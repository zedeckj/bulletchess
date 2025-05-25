import unittest
import sys
sys.path.append("./")
from bulletchess import *
from bulletchess.utils import *

class TestAliasBitboards(unittest.TestCase):

    def test_all(self):
        boards = [utils.random_board() for _ in range(1000)]
        for board in boards:
            self.assertEqual(pawn_bitboard(board), board[PAWN])
            self.assertEqual(knight_bitboard(board), board[KNIGHT])
            self.assertEqual(bishop_bitboard(board), board[BISHOP])
            self.assertEqual(rook_bitboard(board), board[ROOK])
            self.assertEqual(queen_bitboard(board), board[QUEEN])
            self.assertEqual(king_bitboard(board), board[KING])
            self.assertEqual(white_bitboard(board), board[WHITE])
            self.assertEqual(black_bitboard(board), board[BLACK])
            self.assertEqual(unoccupied_bitboard(board), board[None])

    def test_piece(self):
        boards = [utils.random_board() for _ in range(100)]
        for board in boards:
            for color in [WHITE, BLACK]:
                for piece_type in PIECE_TYPES:
                    piece = Piece(color, piece_type)
                    self.assertEqual(piece_bitboard(board, piece), board[color, piece_type])


if __name__ == "__main__":
    unittest.main()