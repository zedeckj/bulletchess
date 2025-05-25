import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re
import json
import tqdm

class TestCountMoves(unittest.TestCase):

    def test_basic(self):
        boards = [utils.random_board() for _ in range(1000)]
        for b in boards:
            self.assertEqual(len(b.legal_moves()), utils.count_moves(b))

    def assertCountSame(self, board : Board, moves : list[Move]):
        self.assertEqual(utils.count_moves(board), len(moves))
        self.assertEqual(utils.perft(board, 1), len(moves))

    def assertValidTree(self, board : Board, depth : int):
        if depth > 0:
            moves = board.legal_moves()
            self.assertCountSame(board, moves)
            for move in moves:
                board.apply(move)
                self.assertValidTree(board, depth - 1)
                board.undo()
    
    def test_perfts(self):
        [self.assertValidTree(utils.random_board(), 4) for _ in range(10)]

    def test_against_json(self):
        with open("data/move_counts.json", "r") as f:
            data = json.load(f)
        for fen in tqdm.tqdm(data):
            board = Board.from_fen(fen)
            self.assertEqual(utils.count_moves(board), data[fen], msg = fen)
    
    def test_against_json_pos2(self):
        with open("data/move_counts_pos2.json", "r") as f:
            data = json.load(f)
        for fen in tqdm.tqdm(data):
            board = Board.from_fen(fen)
            self.assertEqual(utils.count_moves(board), data[fen], msg = fen)

if __name__ == "__main__":
    unittest.main()