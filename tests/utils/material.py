import unittest
import sys

sys.path.append("./")
from bulletchess import *
import random

class TestMaterial(unittest.TestCase):

    def testStarting(self):
        board = Board()
        self.assertEqual(utils.material(board), 0)

    def testRemovedPawn(self):
        board = Board()
        board[E2] = None
        self.assertEqual(utils.material(board), -100)

    def testRemovedBishop(self):
        board = Board()
        board[F1] = None
        self.assertEqual(utils.material(board), -300)


    def testRemovedKnight(self):
        board = Board()
        board[G1] = None
        self.assertEqual(utils.material(board), -300)

    def testRemovedRook(self):
        board = Board()
        board[H1] = None
        self.assertEqual(utils.material(board), -500)

    def testRemovedQueen(self):
        board = Board()
        board[D1] = None
        self.assertEqual(utils.material(board), -900)

    def testRemovedKing(self):
        board = Board()
        board[E1] = None
        self.assertEqual(utils.material(board), 0)

    def testSetup(self):
        board = Board.empty()
        board[E1] = Piece(WHITE, QUEEN) 
        self.assertEqual(utils.material(board), 900)
        board[E2] = Piece(WHITE, QUEEN) 
        self.assertEqual(utils.material(board), 1800)
        board[E3] = Piece(BLACK, PAWN) 
        self.assertEqual(utils.material(board), 1700)
        board[A1] = Piece(BLACK, PAWN) 
        self.assertEqual(utils.material(board), 1600)
        board[C3] = Piece(BLACK, ROOK) 
        self.assertEqual(utils.material(board), 1100)

    def testRandom(self):
        boards = [utils.random_board() for _ in range(10000)]
        for board in boards:
            vals = {
                PAWN : random.randint(1, 10),
                KNIGHT : random.randint(1, 10),
                BISHOP : random.randint(1, 10),
                ROOK : random.randint(1, 10),
                QUEEN : random.randint(1, 10),
                KING : random.randint(1, 10)
            }
            counts = {
                PAWN : 0,
                KNIGHT : 0,
                BISHOP : 0,
                ROOK : 0,
                QUEEN : 0,
                KING : 0
            }
            for square in SQUARES:
                piece = board[square]
                if piece:
                    counts[piece.piece_type] += 1 if piece.color == WHITE else -1
            material = 0
            for pt in counts:
                material += counts[pt] * vals[pt]
            self.assertEqual(material, 
                             utils.material(board, 
                                            pawn_value=vals[PAWN],
                                            knight_value=vals[KNIGHT],
                                            bishop_value=vals[BISHOP],
                                            rook_value=vals[ROOK],
                                            queen_value=vals[QUEEN]), 
                             msg = f"\n{board.pretty()}")



if __name__ == "__main__":
    unittest.main()