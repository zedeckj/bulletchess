import unittest
import sys
sys.path.append("./")
from bulletchess import *
import json


CHECK_FENS = [
    "r3k2r/Pppp1ppp/1b3nbN/nP6/BBP1P3/q4N2/Pp1P2PP/R2Q1RK1 w kq - 0 1",
    "rnbqk1nr/pppp1ppp/8/4P3/1b6/8/PPP1PPPP/RNBQKBNR w KQkq - 1 3",
    "rnbqkbnr/ppp1pppp/8/1B1p4/4P3/8/PPPP1PPP/RNBQK1NR b KQkq - 1 2",
    "r1bqkb1r/pppppppp/3N4/8/3n2n1/2N5/PPPPPPPP/R1BQKB1R b KQkq - 9 5",
    "rnbq1bnr/pppp1ppp/4k3/4p3/4P1Q1/4K3/PPPP1PPP/RNB2BNR b - - 5 4",
]

CHECKMATE_FENS = [  
    "r1bqkb1r/pppp1Qpp/2n2n2/4p3/2B1P3/8/PPPP1PPP/RNB1K1NR b KQkq - 0 4",
    "rnb1k1nr/pppp1ppp/8/2b1p1N1/4P3/2N5/PPPP1qPP/R1BQKB1R w KQkq - 0 5",

]

STALEMATE_FENS = [
    "8/Kbk5/8/8/8/8/8/8 w - - 0 1",
    "8/5KBk/8/8/8/8/8/8 b - - 0 1",
    "2R5/5B2/5K2/4N1B1/3k4/7R/3N4/8 b - - 0 1",
    "8/8/qnnp1k2/6p1/8/4b3/r7/1K6 w - - 0 83",
]

INSF_MATERIAL = [
    "8/8/8/8/4B1b1/8/7k/5K2 b - - 44 156",
    "8/8/2K3B1/8/3k4/8/2b5/8 w - - 22 158",
    "8/1k6/8/8/8/5K2/8/8 w - - 0 1",
    "8/2b2k2/8/8/8/8/2K2B2/8 w - - 0 1",
    "8/2n2k2/8/8/8/8/2K5/8 w - - 0 1",

]

ALMOST_INSF = [
    "2b5/5k2/8/8/8/8/2K2B2/8 w - - 0 1",
    "8/2n2k2/8/8/8/6N1/2K5/8 w - - 0 1"
]

NOT_CHECKMATE = ALMOST_INSF + INSF_MATERIAL + STALEMATE_FENS + CHECK_FENS 


class TestStatusPredicates(unittest.TestCase):

    def test_is_checkmate(self):
        for fen in CHECKMATE_FENS:
            board = Board.from_fen(fen)
            self.assertTrue(board in CHECKMATE)

    def test_is_not_checkmate(self):
        for fen in NOT_CHECKMATE:
            board = Board.from_fen(fen)
            self.assertTrue(board not in CHECKMATE)

    def test_is_stalemate(self):
        for fen in STALEMATE_FENS:
            board = Board.from_fen(fen)
            self.assertTrue(board in STALEMATE)

    def test_is_check(self):
        for fen in CHECK_FENS + CHECKMATE_FENS:
            board = Board.from_fen(fen)
            self.assertTrue(board in CHECK)

    def test_is_insf(self):
        for fen in INSF_MATERIAL:
            board = Board.from_fen(fen)
            self.assertTrue(board in INSUFFICIENT_MATERIAL)
            self.assertTrue(board in DRAW)
            self.assertTrue(board in FORCED_DRAW)

    def test_agreement_move_count(self):
        boards = [Board.random() for _ in range(10000)]
        for board in boards:
            if utils.count_moves(board) != 0:
                self.assertFalse(board in CHECKMATE)
                self.assertFalse(board in STALEMATE)


    def testThreefold(self):
        board = Board()
        board.apply(Move.from_uci("g1f3"))
        board.apply(Move.from_uci("b8c6"))
        board.apply(Move.from_uci("f3g1"))
        board.apply(Move.from_uci("c6b8"))
        # repetition 2

        board.apply(Move.from_uci("g1f3"))
        board.apply(Move.from_uci("b8c6"))
        board.apply(Move.from_uci("f3g1"))
        board.apply(Move.from_uci("c6b8"))
        # repetition 3
        self.assertTrue(board in THREEFOLD_REPETITION)


    def testInsufficientMaterial(self):
        board = Board.empty()
        board[E2] = Piece(WHITE, KING)
        board[F4] = Piece(BLACK, KING)
        base = board.copy()
        self.assertTrue(base in INSUFFICIENT_MATERIAL)
        board[A1] =  Piece(WHITE, KNIGHT)
        self.assertTrue(board in INSUFFICIENT_MATERIAL)
        board = base.copy()
        self.assertTrue(board in INSUFFICIENT_MATERIAL)
        board[H4] = Piece(BLACK, BISHOP)
        self.assertTrue(board in INSUFFICIENT_MATERIAL)
        board[H6] = Piece(BLACK, BISHOP)
        self.assertTrue(board in INSUFFICIENT_MATERIAL)
        board[H8] = Piece(BLACK, ROOK)
        self.assertFalse(board in INSUFFICIENT_MATERIAL)

    def testSeventyFive(self):
        board = Board()
        board.halfmove_clock = 149
        self.assertTrue(board in FIFTY_MOVE_TIMEOUT)
        board.apply(Move.from_uci("g1f3"))
        self.assertTrue(board in SEVENTY_FIVE_MOVE_TIMEOUT)
        self.assertFalse(Board.from_fen("r1bqkb1r/pppp1Qpp/2n2n2/4p3/2B1P3/8/PPPP1PPP/RNB1K1NR b KQkq - 150 4") in SEVENTY_FIVE_MOVE_TIMEOUT)


    def testFifty(self):
        board = Board()
        board.halfmove_clock = 98
        self.assertFalse(board in FIFTY_MOVE_TIMEOUT)
        board.apply(Move.from_uci("g1f3"))
        self.assertTrue(board in FIFTY_MOVE_TIMEOUT)
        board = Board.from_fen("r1bqkb1r/pppp1Qpp/2n2n2/4p3/2B1P3/8/PPPP1PPP/RNB1K1NR b KQkq - 100 4")
        self.assertFalse(board in FIFTY_MOVE_TIMEOUT)

    def test_json(self):
        with open("new_tests/data/status.json", "r") as f:
            data = json.load(f)
        for fen in data:
            board = Board.from_fen(fen)
            match data[fen]:
                case "checkmate":
                    self.assertTrue(board in CHECKMATE)
                    self.assertTrue(board in CHECK)
                    self.assertFalse(board in FORCED_DRAW)
                    self.assertFalse(board in DRAW)
                case "stalemate":
                    self.assertTrue(board in STALEMATE)
                    self.assertFalse(board in CHECK)
                    self.assertTrue(board in FORCED_DRAW)
                    self.assertTrue(board in DRAW)
                case "insf":
                    self.assertTrue(board in INSUFFICIENT_MATERIAL)
                    self.assertFalse(board in CHECK)
                    self.assertTrue(board in FORCED_DRAW)
                    self.assertTrue(board in DRAW)
                case "other":
                    self.assertFalse(board in CHECK)
                    self.assertFalse(board in INSUFFICIENT_MATERIAL)

if __name__ == "__main__":
    unittest.main()




