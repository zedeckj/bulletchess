import unittest
import sys
sys.path.append("./")
from bulletchess import *
import json
import tqdm

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
    pieces1 = [board[square] for square in SQUARES]
    board3 = board.copy()
    tester.assertEqual(board, board3)
    board.apply(Move.from_uci(move_uci))
    board2 = Board.from_fen(after_fen)
    tester.assertEqual(board, board2)
    tester.assertNotEqual(board, board3)
    board.undo()
    tester.assertEqual(board, board3)
    pieces2 = [board3[square] for square in SQUARES]
    tester.assertEqual(pieces1, pieces2)
    tester.assertNotEqual(board, board2)
   
def test_apply_undo_same(tester : unittest.TestCase, board : Board, move : Move):
    pieces1 = [board[square] for square in SQUARES]
    board3 = board.copy()
    tester.assertEqual(board, board3)
    board.apply(move)
    board.undo()
    tester.assertEqual(board, board3)
    pieces2 = [board3[square] for square in SQUARES]
    tester.assertEqual(pieces1, pieces2)

class TestMoveApply(unittest.TestCase):

    """
    Tests applying and undoing moves
    """

    def assert_valid_double_undos(self, board : Board):
        original = board.copy()
        for move1 in board.legal_moves():
            board.apply(move1)
            for move2 in board.legal_moves():
                test_apply_undo_same(self, board, move2)
            board.undo()
            self.assertEqual(board, original, msg = move1.uci())
    
    def assert_valid_triple_undos(self, board : Board):
        original = board.copy()
        for move1 in original.legal_moves():
            board = original.copy()
            move_list = [move1]
            board.apply(move1)
            one_deep = board.copy()
            for move2 in board.legal_moves():
                move_list.append(move2)
                board.apply(move2)
                for move3 in board.legal_moves():
                    move_list.append(move3)
                    test_apply_undo_same(self, board, move3)
                board.undo()
                self.assertEqual(board, one_deep)
            board.undo()
            self.assertEqual(board, original)

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
        boards = [Board.random() for _ in range(1000)]
        for board in boards:
            moves = board.legal_moves()
            if len(moves) == 0:
                continue
            copy = board.copy()
            for move in moves:
                board.apply(move)
                self.assertNotEqual(board, copy)
                board.undo()
                self.assertEqual(board, copy, msg = move)

    def testRandomDoubleUndo(self):
        boards = [Board.random() for _ in range(1000)]
        for board in boards:
            self.assert_valid_double_undos(board)

    def testRandomTripleUndo(self):
        boards = [Board.random() for _ in range(100)]
        for board in boards:
            self.assert_valid_triple_undos(board)

    def testFailedCases(self):
        board = Board.from_fen("8/7k/3P4/2P5/p6p/p2n3R/3N4/3R4 w - - 7 97")
        moves = board.legal_moves()
        copy = board.copy()    
        for move in moves:
            board.apply(move)
            self.assertNotEqual(board, copy)
            board.undo()
            self.assertEqual(board, copy)

        board = Board.from_fen("rr6/5b1p/p2pp1p1/P1p3k1/6P1/5P2/2R4R/3B2K1 b - - 1 34")
        copy = board.copy()
        board.apply(Move.from_uci("c5c4"))
        board.apply(Move.from_uci("d1e2"))
        board.apply(Move.from_uci("c4c3"))
        board.undo()
        board.undo()
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

    """
    def testAgainstJson(self):
        with open("new_tests/data/move_results.json", "r") as f:
            data = json.load(f)
        for fen in tqdm.tqdm(data):
            board = Board.from_fen(fen)
            copy = board.copy()
            for uci in data[fen]:
                move = Move.from_uci(uci)
                board.apply(move)
                self.assertEqual(board, Board.from_fen(data[fen][uci]), msg = {"uci": uci, "start":fen, "res": data[fen][uci]})
                board.undo()
                self.assertEqual(copy, board)
    """

    def test_rook_one_square(self):
        FEN = "r3k2r/p1ppqpb1/bn2pnp1/3PN3/1p2P3/2N2Q1p/PPPBBPPP/R3K2R w KQkq - 0 1"
        board = Board.from_fen(FEN)
        move = Move.from_uci("a1b1")
        board.apply(move)
        board.undo()
        self.assertEqual(board.fen(), FEN)
        self.assertEqual(board[A1], Piece(WHITE, ROOK))

    def test_found_err(self):
        FEN = "2b1kq2/8/4p3/7r/3P4/2NQ3N/6P1/R3KB2 w KQkq - 2 36"
        board = Board.from_fen(FEN)
        board.apply(Move.from_uci("e1c1"))
        board.undo()
        self.assertEqual(board.fen(), FEN)

    def test_error_apply1(self):
        FEN = "rnb1kbnr/ppp1p1p1/5p2/5q1p/2pP1P2/N2QP3/PP1B2PP/R3KBNR w KQkq - 2 8"
        board = Board.from_fen(FEN)
        board.apply(Move.from_uci("a1d1"))
        self.assertEqual(board.fen(), "rnb1kbnr/ppp1p1p1/5p2/5q1p/2pP1P2/N2QP3/PP1B2PP/3RKBNR b Kkq - 3 8")

    def test_error_apply2(self):
        FEN = "1nb2b1r/6k1/6p1/7p/7q/3PB3/5PP1/4KBNR b K - 3 29"
        board = Board.from_fen(FEN)
        board.apply(Move.from_uci("h4h1"))
        self.assertEqual(board.fen(), "1nb2b1r/6k1/6p1/7p/8/3PB3/5PP1/4KBNq w - - 0 30")

    def test_abuse(self):
        # this is technically possible to do, since we don't
        # check legallity before applying a move. 
        board = Board()
        moves = []
        for _ in range(10000000):
            move = Move(E2, E4)
            board.apply(move)
            moves.append(move)
        self.assertEqual(board.history, moves)
        print(board.fen())
        

if __name__ == "__main__":
    unittest.main()
