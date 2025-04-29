import unittest
import sys
sys.path.append("./")
from bulletchess import *


def undoing_test(tester : unittest.TestCase, board : Board, depth : int, seen : list[Move] = []):
    if depth == 0:
        return seen
    for move in board.legal_moves():
        old = board.copy()
        board.apply(move)
        undoing_test(tester, board, depth - 1, seen)
        board.undo()
        tester.assertEqual(old, board, msg = seen)

def test_apply_undo(tester : unittest.TestCase, before_fen : str, move_uci : str, after_fen : str):
    board = Board.from_fen(before_fen)
    board3 = board.copy()
    tester.assertEqual(board, board3)
    board.apply(Move.from_uci(move_uci))
    board2 = Board.from_fen(after_fen)
    tester.assertEqual(board, board2)
    tester.assertNotEqual(board, board3)
    board.undo()
    tester.assertEqual(board, board3)
    tester.assertNotEqual(board, board2)
   

class TestMoveApply(unittest.TestCase):

    """
    Tests applying and undoing moves
    """

    def testItalianGame(self):
        board = Board()
        board1 = Board.from_fen("rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1")
        board2 = Board.from_fen("rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR w KQkq e6 0 2")
        board3 = Board.from_fen("rnbqkbnr/pppp1ppp/8/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq - 1 2")
        board4 = Board.from_fen("r1bqkbnr/pppp1ppp/2n5/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R w KQkq - 2 3")
        board5 = Board.from_fen("r1bqkbnr/pppp1ppp/2n5/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R b KQkq - 3 3")
        board6 = Board.from_fen("r1bqkb1r/pppp1ppp/2n2n2/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 4 4")
        board7 = Board.from_fen("r1bqkb1r/pppp1ppp/2n2n2/4p3/2B1P3/5N2/PPPP1PPP/RNBQ1RK1 b kq - 5 4")
        board.apply(Move.from_uci("e2e4"))
        self.assertEqual(board, board1)
        board.apply(Move.from_uci("e7e5"))
        self.assertEqual(board, board2)
        board.apply(Move.from_uci("g1f3"))
        self.assertEqual(board, board3)
        board.apply(Move.from_uci("b8c6"))
        self.assertEqual(board, board4)
        board.apply(Move.from_uci("f1c4"))
        self.assertEqual(board, board5)
        board.apply(Move.from_uci("g8f6"))
        self.assertEqual(board, board6)
        board.apply(Move.from_uci("e1g1"))
        self.assertEqual(board, board7)
        board.undo()
        self.assertEqual(board, board6)
        board.undo()
        self.assertEqual(board, board5)
        board.undo()
        self.assertEqual(board, board4)
        board.undo()
        self.assertEqual(board, board3)
        board.undo()
        self.assertEqual(board, board2)
        board.undo()
        self.assertEqual(board, board1)
        board.undo()
        self.assertEqual(board, Board())

    def testWhiteKingsideCastling(self):
        test_apply_undo(
            self,
            "r1bqk1nr/pppp1ppp/2n5/2b1p3/8/5NP1/PPPPPPBP/RNBQK2R w KQkq - 4 4",
            "e1g1",
            "r1bqk1nr/pppp1ppp/2n5/2b1p3/8/5NP1/PPPPPPBP/RNBQ1RK1 b kq - 5 4"
        )

    def testWhiteQueensideCastling(self):
        test_apply_undo(
            self,
            "r3kbnr/pppqpppp/2n5/3p1b2/3P1B2/2N5/PPPQPPPP/R3KBNR w KQkq - 6 5",
            "e1c1",
            "r3kbnr/pppqpppp/2n5/3p1b2/3P1B2/2N5/PPPQPPPP/2KR1BNR b kq - 7 5",
        )

    def testBlackKingsideCastling(self):
        test_apply_undo(
                self,
                "rnbqk2r/pppp1ppp/5n2/2b1p3/8/1PPPP3/P4PPP/RNBQKBNR b KQkq - 0 4",
                "e8g8",
                "rnbq1rk1/pppp1ppp/5n2/2b1p3/8/1PPPP3/P4PPP/RNBQKBNR w KQ - 1 5")

    def testBlackQueensideCastling(self):
        test_apply_undo(
            self,
            "r3kbnr/pppqpppp/2np4/5b2/8/1PNP1N2/PBP1PPPP/R2QKB1R b KQkq - 0 5",
            "e8c8",
            "2kr1bnr/pppqpppp/2np4/5b2/8/1PNP1N2/PBP1PPPP/R2QKB1R w KQ - 1 6")
    
    def testEnPassant(self):
        test_apply_undo(
            self,
            "rnbqkb1r/p1pppppp/5n2/Pp6/8/8/1PPPPPPP/RNBQKBNR w KQkq b6 0 3",
            "a5b6",
            "rnbqkb1r/p1pppppp/1P3n2/8/8/8/1PPPPPPP/RNBQKBNR b KQkq - 0 3"
            )
        
    def testBlackEnPassant(self):
        test_apply_undo(
            self,
            "rnbqkbnr/pppppp1p/8/8/1P3Pp1/2N5/P1PPP1PP/R1BQKBNR b KQkq f3 0 3",
            "g4f3",
            "rnbqkbnr/pppppp1p/8/8/1P6/2N2p2/P1PPP1PP/R1BQKBNR w KQkq - 0 4")

    def testRandomUndo(self):
        boards = [Board.random() for _ in range(10000)]
        for board in boards:
            moves = board.legal_moves()
            if len(moves) == 0:
                continue
            copy = board.copy()
            for move in moves:
                board.apply(move)
                self.assertNotEqual(board, copy)
                board.undo()
                self.assertEqual(board, copy)

    def testFailedCases(self):
        board = Board.from_fen("8/7k/3P4/2P5/p6p/p2n3R/3N4/3R4 w - - 7 97")
        moves = board.legal_moves()
        copy = board.copy()    
        for move in moves:
            board.apply(move)
            self.assertNotEqual(board, copy)
            board.undo()
            self.assertEqual(board, copy)

    def testGetPiece(self):
        board = Board()
        board.apply(Move(E2, E4))
        self.assertEqual(board[E4], Piece(WHITE, PAWN))
    
    def testNullMove(self):
        board = Board()
        null_move = Move.from_uci("0000")
        board.apply(null_move)
        fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b KQkq - 1 1"
        board2 = Board.from_fen(fen)
        self.assertEqual(board, board2)
        undone = board.undo()
        self.assertEqual(undone, None)
        self.assertEqual(board, Board())
        
if __name__ == "__main__":
    unittest.main()
