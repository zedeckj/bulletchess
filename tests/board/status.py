import unittest
import sys
sys.path.append("./")
from bulletchess import *
import random


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

NOT_INSF_MATERIAL = [
    "2b5/5k2/8/8/8/8/2K2B2/8 w - - 0 1",
    "8/2n2k2/8/8/8/6N1/2K5/8 w - - 0 1"
]


class TestDraw(unittest.TestCase):

    def assertOngoing(self, board : Board):
        status = board.status
        self.assertTrue(status.ongoing)
        self.assertFalse(status.stalemate)
        self.assertFalse(status.claim_draw)
        self.assertFalse(status.forced_draw)
        self.assertFalse(status.gameover)
        self.assertFalse(status.checkmate)
        self.assertFalse(status.fifty_move_timeout)
        self.assertFalse(status.seventyfive_move_timeout)
        self.assertFalse(status.threefold_repetition)
        self.assertFalse(status.resignation)
        self.assertFalse(status.fivefold_repetition)
        self.assertFalse(status.insufficient_material)

    def assertStalemate(self, board : Board):
        status = board.status
        self.assertFalse(status.ongoing)
        self.assertTrue(status.stalemate)
        self.assertTrue(status.claim_draw)
        self.assertTrue(status.forced_draw)
        self.assertTrue(status.gameover)
        self.assertFalse(status.checkmate)
        self.assertFalse(status.fifty_move_timeout)
        self.assertFalse(status.seventyfive_move_timeout)
        self.assertFalse(status.threefold_repetition)
        self.assertFalse(status.resignation)
        self.assertFalse(status.fivefold_repetition)
        self.assertFalse(status.insufficient_material)
    
    def assertCheckmate(self, board : Board):
        status = board.status
        self.assertFalse(status.stalemate)
        self.assertFalse(status.ongoing)
        self.assertFalse(status.claim_draw)
        self.assertFalse(status.forced_draw)
        self.assertTrue(status.gameover)
        self.assertTrue(status.checkmate)
        self.assertFalse(status.fifty_move_timeout)
        self.assertFalse(status.seventyfive_move_timeout)
        self.assertFalse(status.threefold_repetition)
        self.assertFalse(status.resignation)
        self.assertFalse(status.fivefold_repetition)
        self.assertFalse(status.insufficient_material)
        
    def assertThreefold(self, board : Board):
        status = board.status
        self.assertFalse(status.stalemate)
        self.assertTrue(status.claim_draw)
        self.assertFalse(status.ongoing)
        self.assertFalse(status.forced_draw)
        self.assertTrue(status.gameover)
        self.assertFalse(status.checkmate)
        self.assertFalse(status.fifty_move_timeout)
        self.assertFalse(status.seventyfive_move_timeout)
        self.assertTrue(status.threefold_repetition)
        self.assertFalse(status.fivefold_repetition)
        self.assertFalse(status.resignation)
        self.assertFalse(status.insufficient_material)

    def assertFiftyMove(self, board : Board):
        status = board.status
        self.assertFalse(status.stalemate)
        self.assertFalse(status.ongoing)
        self.assertTrue(status.claim_draw)
        self.assertFalse(status.forced_draw)
        self.assertTrue(status.gameover)
        self.assertFalse(status.checkmate)
        self.assertTrue(status.fifty_move_timeout)
        self.assertFalse(status.seventyfive_move_timeout)
        self.assertFalse(status.threefold_repetition)
        self.assertFalse(status.fivefold_repetition)
        self.assertFalse(status.resignation)
        self.assertFalse(status.insufficient_material)
    
    def assertFivefold(self, board : Board):
        status = board.status
        self.assertFalse(status.stalemate)
        self.assertTrue(status.claim_draw)
        self.assertTrue(status.forced_draw)
        self.assertFalse(status.ongoing)
        self.assertTrue(status.gameover)
        self.assertFalse(status.checkmate)
        self.assertFalse(status.fifty_move_timeout)
        self.assertFalse(status.seventyfive_move_timeout)
        self.assertTrue(status.threefold_repetition)
        self.assertTrue(status.fivefold_repetition)
        self.assertFalse(status.resignation)
        self.assertFalse(status.insufficient_material)

    def assertSeventyfive(self, board : Board):
        status = board.status
        self.assertFalse(status.stalemate)
        self.assertTrue(status.claim_draw)
        self.assertTrue(status.forced_draw)
        self.assertFalse(status.ongoing)
        self.assertTrue(status.gameover)
        self.assertFalse(status.checkmate)
        self.assertTrue(status.fifty_move_timeout)
        self.assertTrue(status.seventyfive_move_timeout)
        self.assertFalse(status.threefold_repetition)
        self.assertFalse(status.fivefold_repetition)
        self.assertFalse(status.resignation)
        self.assertFalse(status.insufficient_material)

    def assertInsufficientMaterial(self, board : Board):
        status = board.status
        self.assertFalse(status.stalemate)
        self.assertTrue(status.claim_draw)
        self.assertTrue(status.forced_draw)
        self.assertFalse(status.ongoing)
        self.assertTrue(status.gameover)
        self.assertFalse(status.checkmate)
        self.assertFalse(status.fifty_move_timeout)
        self.assertFalse(status.seventyfive_move_timeout)
        self.assertFalse(status.threefold_repetition)
        self.assertFalse(status.fivefold_repetition)
        self.assertFalse(status.resignation)
        self.assertTrue(status.insufficient_material)

    def testOngoing(self):
        board = Board.starting()
        self.assertOngoing(board)


    def testThreefold(self):
        board = Board.starting()
        self.assertOngoing(board)
        board.apply(Move.from_uci("g1f3"))
        self.assertOngoing(board)
        board.apply(Move.from_uci("b8c6"))
        self.assertOngoing(board)
        board.apply(Move.from_uci("f3g1"))
        self.assertOngoing(board)
        board.apply(Move.from_uci("c6b8"))
        # repetition 2

        self.assertOngoing(board)
        board.apply(Move.from_uci("g1f3"))
        self.assertOngoing(board)
        board.apply(Move.from_uci("b8c6"))
        self.assertOngoing(board)
        board.apply(Move.from_uci("f3g1"))
        self.assertOngoing(board)
        board.apply(Move.from_uci("c6b8"))
        # repetition 3
        self.assertThreefold(board)


    def testInsufficientMaterial(self):
        board = Board.empty()
        board.set_piece_at(E2, Piece(WHITE, KING))
        board.set_piece_at(F4, Piece(BLACK, KING))
        base = board.copy()
        self.assertInsufficientMaterial(base)
        board.set_piece_at(A1, Piece(WHITE, KNIGHT))
        self.assertInsufficientMaterial(board)
        board = base.copy()
        self.assertInsufficientMaterial(board)
        board.set_piece_at(H4, Piece(BLACK, BISHOP))
        self.assertInsufficientMaterial(board)
        board.set_piece_at(H6, Piece(BLACK, BISHOP))
        self.assertInsufficientMaterial(board)

    def testSeventyFive(self):
        board = Board()
        board.halfmove_clock = 149
        self.assertFiftyMove(board)
        board.apply(Move.from_uci("g1f3"))
        self.assertSeventyfive(board)


    def testFifty(self):
        board = Board()
        board.halfmove_clock = 98
        self.assertOngoing(board)
        board.apply(Move.from_uci("g1f3"))
        self.assertFiftyMove(board)
        board = Board.from_fen("r1bqkb1r/pppp1Qpp/2n2n2/4p3/2B1P3/8/PPPP1PPP/RNB1K1NR b KQkq - 100 4")
        self.assertFalse(board.status.fifty_move_timeout)

    def testCheck(self):
        for fen in CHECK_FENS:
            board = Board.from_fen(fen)
            self.assertTrue(board.status.check, msg = fen)
            self.assertFalse(board.status.checkmate, msg = fen)
            self.assertFalse(board.status.stalemate, msg = fen)

    def testCheckmate(self):
        for fen in CHECKMATE_FENS:
            board = Board.from_fen(fen)
            self.assertTrue(board.status.check, msg = fen)
            self.assertTrue(board.status.checkmate, msg = fen)
            self.assertFalse(board.status.stalemate, msg = fen)

    
    def testStalemate(self):
        for fen in STALEMATE_FENS:
            board = Board.from_fen(fen)
            self.assertFalse(board.status.check, msg = fen)
            self.assertFalse(board.status.checkmate, msg = fen)
            self.assertTrue(board.status.stalemate, msg = fen)


    def testInsufficientMaterialMore(self):
        for fen in INSF_MATERIAL:
            board = Board.from_fen(fen)
            self.assertTrue(board.status.insufficient_material, msg = fen)
            self.assertFalse(board.status.stalemate, msg = fen)
        for fen in NOT_INSF_MATERIAL:
            board = Board.from_fen(fen)
            self.assertFalse(board.status.insufficient_material, msg = fen)
            
if __name__ == "__main__":
    unittest.main()




