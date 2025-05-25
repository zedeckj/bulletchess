import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re


class BoardStatusTester(unittest.TestCase):

    def assertMate(self, board : Board):
        self.assertEqual(utils.count_moves(board), 0)
        self.assertEqual(len(board.legal_moves()), 0)
        self.assertTrue(board in MATE)
    def assertNotMate(self, board : Board):
        self.assertGreater(utils.count_moves(board), 0)
        self.assertGreater(len(board.legal_moves()), 0)
        self.assertTrue(board not in MATE)

    def assertCheck(self, board : Board):
        self.assertTrue(board in CHECK)
        self.assertTrue(utils.attack_mask(board, board.turn.opposite) & board[KING])

    def assertNotCheck(self, board : Board):
        self.assertTrue(board not in CHECK)

        self.assertFalse(utils.attack_mask(board, board.turn.opposite) & board[board.turn, KING], msg = board.pretty())

    def assertOnlyCheck(self, board : Board):
        self.assertCheck(board)
        self.assertNotMate(board)

    def assertCheckmate(self, board : Board):
        self.assertCheck(board)
        self.assertMate(board)
        self.assertFalse(board in INSUFFICIENT_MATERIAL)
        self.assertFalse(board in FIFTY_MOVE_TIMEOUT)
        self.assertFalse(board in SEVENTY_FIVE_MOVE_TIMEOUT)
        self.assertFalse(board in THREEFOLD_REPETITION)
        self.assertFalse(board in FIVEFOLD_REPETITION)



    def assertLastNotCapture(self, board : Board):
        moves = board.history
        if len(moves) > 0:
            self.assertFalse(moves[-1].is_capture(board))

    def assertStalemate(self, board : Board):
        self.assertNotCheck(board)
        self.assertMate(board)
        self.assertTrue(board in FORCED_DRAW)
        self.assertTrue(board in DRAW)

    def assertThreefold(self, board : Board):
        self.assertNotMate(board)
        self.assertTrue(board in THREEFOLD_REPETITION)
        self.assertTrue(board.halfmove_clock >= 6)
        self.assertTrue(board.fullmove_number >= 3)
        self.assertLastNotCapture(board)
        self.assertTrue(board in DRAW)
        self.assertTrue(board not in FORCED_DRAW)

    def assertFivefold(self, board : Board):
        self.assertNotMate(board)
        self.assertThreefold(board)
        self.assertTrue(board in FIVEFOLD_REPETITION)
        self.assertTrue(board.halfmove_clock >= 10)
        self.assertTrue(board.fullmove_number >= 5)
        self.assertLastNotCapture(board)
        self.assertTrue(board in DRAW)
        self.assertTrue(board not in FORCED_DRAW)

    def assertFifty(self, board : Board):
        self.assertTrue(board in FIFTY_MOVE_TIMEOUT)
        self.assertTrue(board.halfmove_clock >= 99)
        self.assertIsNone(board.en_passant_square)
        self.assertNotMate(board)
        self.assertLastNotCapture(board)
        self.assertTrue(board in DRAW)


    def assertSeventyFive(self, board : Board):
        self.assertTrue(board in SEVENTY_FIVE_MOVE_TIMEOUT)
        self.assertTrue(board.halfmove_clock >= 149)
        self.assertIsNone(board.en_passant_square)
        self.assertNotMate(board)
        self.assertLastNotCapture(board)
        self.assertTrue(board in DRAW)
        self.assertTrue(board not in FORCED_DRAW)

    def assertInsf(self, board : Board):
        self.assertTrue(board in INSUFFICIENT_MATERIAL)
        self.assertTrue(board in DRAW)
        self.assertTrue(board in FORCED_DRAW)
        self.assertEqual(board[QUEEN], EMPTY_BB)
        self.assertEqual(board[ROOK], EMPTY_BB)
        self.assertEqual(board[PAWN], EMPTY_BB)
