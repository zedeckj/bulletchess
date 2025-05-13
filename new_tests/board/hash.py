import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re



class TestBoardIndex(unittest.TestCase):

    def test_collisions(self):
        COUNT = 10000
        utils.set_random_seed(0)
        boards = set([Board.random() for _ in range(COUNT)])
        hashes = set([hash(board) for board in boards])
        self.assertEqual(len(hashes), len(boards))

    def test_eq(self):
        board = Board()
        self.assertEqual(hash(board), hash(Board()))


    def test_stateless(self):
        boards = [Board.random() for _ in range(1000)]
        hashes1 = [hash(board) for board in boards]
        hashes2 = [hash(board) for board in boards]
        self.assertEqual(hashes1, hashes2)

    def test_castling(self):
        board1 = Board.from_fen("r1b1kb1r/ppppq1pp/2n2n2/4p1N1/2B1P3/8/PPPP1PPP/RNBQK2R w KQ - 3 7")
        board2 = Board.from_fen("r1b1kb1r/ppppq1pp/2n2n2/4p1N1/2B1P3/8/PPPP1PPP/RNBQK2R w KQq - 3 7")
        self.assertNotEqual(hash(board1), hash(board2))


if __name__ == "__main__":
    unittest.main()
