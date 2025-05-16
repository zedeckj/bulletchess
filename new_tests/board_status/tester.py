import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re


class BoardStatusTester(unittest.TestCase):

    def assertMate(self, board : Board):
        self.assertEqual(utils.count_moves(board), 0)
        self.assertTrue(board in MATE)
        self.assertFalse(board in INSUFFICIENT_MATERIAL)
        self.assertFalse(board in FIFTY_MOVE_TIMEOUT)
        self.assertFalse(board in SEVENTY_FIVE_MOVE_TIMEOUT)
        self.assertFalse(board in THREEFOLD_REPETITION)
        self.assertFalse(board in FIVEFOLD_REPETITION)
        self.assertFalse(board in INSUFFICIENT_MATERIAL)

    def assertCheck(self, board : Board):
        self.assertTrue(utils.attack_mask(board, board.turn.opposite) & board.kings)

    def assertNotCheck(self, board : Board):
        self.assertTrue(board not in CHECK)
        self.assertFalse(utils.attack_mask(board, board.turn.opposite) & board.kings)

    def assertCheckmate(self, board : Board):
        self.assertCheck(board)
        self.assertMate(board)

    def assertStalemate(self, board : Board):
        self.assertNotCheck(board)
        self.assertMate(board)

    def assertThreefold(self, board : Board):
        ...