import unittest
import sys
sys.path.append("./")
from bulletchess import *
import json
import tqdm

def testMoves(tester : unittest.TestCase, expected_ucis : set[str], board : Board):
    real_moves = set(tester.checkedLegalMoves(board)) #type: ignore
    expected_moves = {Move.from_uci(uci) for uci in expected_ucis}
    # real_ucis = {str(move) for move in real_moves}
    tester.assertEqual(expected_moves, real_moves, msg = board.fen())
    tester.assertEqual(len(expected_moves), utils.count_moves(board))
    # tester.assertEqual(expected_ucis, real_ucis, msg = board.fen())
     

class TestMoveGeneration(unittest.TestCase):

    """
    Tests the generation of moves in specific positions. Move generation is tested more robustly with tests/integration/perft.py.
    This file also tests utils.count_moves
    """

    def assertBoardsEqual(self, board1: Board, board2: Board):
        self.assertEqual(board1, board2)
        self.assertEqual(board1[PAWN], board2[PAWN])
        self.assertEqual(board1[KNIGHT], board2[KNIGHT])
        self.assertEqual(board1[BISHOP], board2[BISHOP])
        self.assertEqual(board1[ROOK], board2[ROOK])
        self.assertEqual(board1[QUEEN], board2[QUEEN])
        self.assertEqual(board1[KING], board2[KING])
        self.assertEqual(board1.halfmove_clock, board2.halfmove_clock)
        self.assertEqual(board1.fullmove_number, board2.fullmove_number)
        self.assertEqual(board1.turn, board2.turn)
        self.assertEqual(board1.castling_rights, board2.castling_rights)

    def checkedLegalMoves(self, board : Board):
        pieces = [board[square] for square in SQUARES]
        copy = board.copy()
        moves = board.legal_moves()
        self.assertBoardsEqual(board, copy)
        self.assertEqual(pieces, [board[square] for square in SQUARES])
        return moves

    def testStarting(self):
        board = Board()
        ucis = {"a2a3", "a2a4", "b2b3", "b2b4", "c2c3", "c2c4", "d2d3", "d2d4", "e2e3", "e2e4", "f2f3", "f2f4", "g2g3", "g2g4", "h2h3", "h2h4", "b1a3", "b1c3", "g1f3", "g1h3"}
        testMoves(self, ucis, board)
        
    def testEnPassant(self):
        fen = "r1bqkbnr/ppp1pppp/2n5/3pP3/8/8/PPPP1PPP/RNBQKBNR w KQkq d6 0 3"
        board = Board.from_fen(fen)
        ucis = {"a2a3", "a2a4", "b2b3", "b2b4", "c2c3", "c2c4", "d2d3", "d2d4", "e5e6", "e5d6", 
                "f2f3", "f2f4", "g2g3", "g2g4", "h2h3", "h2h4", "b1a3", "b1c3", "g1f3", "g1h3",
                "f1e2", "f1d3", "f1c4", "f1b5", "f1a6", "d1e2", "d1f3", "d1g4", "d1h5", "e1e2",
                "g1e2"}
        testMoves(self, ucis, board)

    def testCastling(self):
        fen_no_rights = "r3kbnr/ppp2ppp/2np1q2/4p3/2B1P1b1/2NP1N2/PPP2PPP/R1BQ1RK1 b k - 0 6"
        board = Board.from_fen(fen_no_rights)
        ucis = {"a7a6", "a7a5", "b7b6", "b7b5", "d6d5", "g7g6", "g7g5", "h7h6", "h7h5", #pawn moves
                    "c6a5", "c6b4", "c6d4", "c6e7", "c6d8", "c6b8", "g8h6", "g8e7",  #knight moves
                    "g4h3", "g4f3", "g4h5", "g4f5", "g4e6", "g4d7", "g4c8", "f8e7", #bishop moves
                    "f6f3",
                    "f6h4", "f6f4",
                    "f6f5", "f6g5", 
                    "f6h6", "f6g6", "f6h6", "f6e6" ,
                    "f6e7",
                    "f6d8", # queen moves
                    "a8b8", "a8c8", "a8d8", #rook moves
                    "e8d8", "e8d7", "e8e7"}
        testMoves(self, ucis, board)
        fen = "r3kbnr/ppp2ppp/2np1q2/4p3/2B1P1b1/2NP1N2/PPP2PPP/R1BQ1RK1 b kq - 0 6"
        board = Board.from_fen(fen)
        testMoves(self, ucis | {"e8c8"}, board)

    def testEnPassantRevaled(self):
        fen1 = "8/1q6/8/3pP3/8/5K2/2k5/8 w - d6 0 1" 
        board = Board.from_fen(fen1)
        ucis = {"f3f4", "f3g4", "f3g3", "f3g2", "f3f2", "f3e2", "f3e3", "e5e6"}
        testMoves(self, ucis, board)
        fen2 = "8/8/8/3pP3/8/5K2/2k5/8 w - d6 0 1"
        board = Board.from_fen(fen2)
        testMoves(self, ucis | {"e5d6"}, board)

        ## repeated pattern for new position
        fen1 = "6K1/8/8/8/1k1pP1Q1/8/8/8 b - e3 0 1"
        board = Board.from_fen(fen1)
        ucis = {"b4a5", "b4b5", "b4c5", "b4a4", "b4c4", "b4a3", "b4b3", "b4c3", "d4d3"}
        testMoves(self, ucis, board)
        fen2 = "6K1/7Q/8/8/1k1pP3/8/8/8 b - e3 0 1"
        board = Board.from_fen(fen2)
        testMoves(self, ucis | {"d4e3"}, board)

    def testOther(self):
        board = Board.from_fen("rnb3r1/R3Q3/2p5/1p1k1p1r/1n1P4/8/4P3/2K2B1r b - - 3 69")
        moves = set(self.checkedLegalMoves(board))
        self.assertIn(Move.from_uci("g8h8"), moves)

    def test_check1(self):
        board = Board.from_fen("rnb1kbnr/pppp1ppp/8/4p3/4PP1q/8/PPPP2PP/RNBQKBNR w KQkq - 1 3")
        ucis = {"g2g3", "e1e2"}
        testMoves(self, ucis, board)

    def test_no_reveal(self):
        board = Board.from_fen("rnbqkbnr/pp3ppp/2pp4/1B2p3/4P3/5N2/PPPP1PPP/RNBQK2R b KQkq - 1 4")
        self.assertNotIn(Move.from_uci("c6c5"),self.checkedLegalMoves(board))

        board2 = Board.from_fen("rnbqkbnr/pp3ppp/2pp4/4p3/4P3/5N2/PPPP1PPP/RNBQK2R b KQkq - 1 4")
        self.assertIn(Move.from_uci("c6c5"), self.checkedLegalMoves(board2))

    def test_white_kingside_castle(self):
        board = Board.from_fen("rnbqk2r/ppppp1bp/5np1/5p2/5P2/6PN/PPPPP1BP/RNBQK2R w KQkq - 2 5")
        self.assertIn(Move.from_uci("e1g1"), self.checkedLegalMoves(board))

    def test_white_queenside_castle(self):
        board = Board.from_fen("r1b1k1nr/pppq1ppp/2np4/2b1p1BQ/4P3/2NP4/PPP2PPP/R3KBNR w KQkq - 2 6")
        self.assertIn(Move.from_uci("e1c1"), self.checkedLegalMoves(board))   

    def test_black_kingside_castle(self):
        board = Board.from_fen("r1b1k2r/pppq1ppp/2np1n2/2b1p1BQ/4P3/2NP4/PPP1BPPP/2KR2NR b kq - 5 7")
        self.assertIn(Move.from_uci("e8g8"), self.checkedLegalMoves(board))

    def test_black_queenside_castle(self):
        board = Board.from_fen("r3k2r/pppb1ppp/2npqn2/1Nb1p1BQ/4P3/3P1N2/PPP1BPPP/2KR3R b kq - 9 9")
        self.assertIn(Move.from_uci("e8c8"), self.checkedLegalMoves(board))

    def test_scholars_mate(self):
        board = Board.from_fen("r1bqkb1r/pppp1Qpp/2n2n2/4p3/2B1P3/8/PPPP1PPP/RNB1K1NR b KQkq - 0 4")
        testMoves(self, set(), board)

    def test_empty(self):
        empty = Board.empty()
        testMoves(self, set(), empty)


    def testRegression(self):
        board = Board.from_fen("rnbk3r/pp3pbp/2p2np1/4p1B1/2P1P3/2N2P2/PP2N1PP/4KB1R b K - 2 9")
        moves = set(self.checkedLegalMoves(board))
        self.assertIn(Move.from_uci("b8d7"), moves)

        board = Board.from_fen("r1bqk1n1/p1p3pr/8/p2pP2p/2P4P/Nn1p2PK/PB5R/R5N1 w - d6 0 19")
        moves = set(self.checkedLegalMoves(board))
        self.assertNotIn(Move.from_uci("e5d6"), moves)
        testMoves(self, {"g3g4", "e5e6", "h3g2"}, board)


    def testAgainstJson(self):
        with open("new_tests/data/move_results.json", "r") as f:
            data : dict[str, dict[str, str]]= json.load(f)
        for fen in tqdm.tqdm(data):
            board = Board.from_fen(fen)
            ucis = set([move.uci() for move in self.checkedLegalMoves(board)])
            self.assertEqual(set(data[fen].keys()), ucis)


    def useTree(self, tree : dict, fens : list[str]):
        if tree != {}:
            expect = Board.from_fen(fens[0])
            for fen in tree:
                board = Board.from_fen(fen)
                self.assertEqual(board, expect)
                got_moves = set(self.checkedLegalMoves(board))
                real_moves = []
                ucis = [uci for uci in tree[fen]]
                for uci in ucis:
                    move = Move.from_uci(uci)
                    self.assertIn(move, got_moves)
                    board.apply(move)
                    real_moves.append(move)
                    fens = [fen for fen in tree[fen][uci]]
                    self.useTree(tree[fen][uci], fens)
                    board.undo()
                self.assertEqual(set(real_moves), got_moves)
        else:
            self.assertEqual(len(fens), 0)

    def testJsonTree(self):
        with open("new_tests/data/move_tree_pos2.json", "r") as f:
            self.useTree(json.load(f), ["r3k2r/p1ppqpb1/bn2pnp1/3PN3/1p2P3/2N2Q1p/PPPBBPPP/R3K2R w KQkq - 0 1"])


    def test_forced_ep(self):
        board = Board.from_fen("rn2qb2/3bpk1r/p4n1p/2p3pP/7K/4PPP1/PPPPN3/RNB4R w - g6 0 15")
        moves = board.legal_moves()
        self.assertEqual(len(moves), 1)
        self.assertIn(Move.from_uci("h5g6"), moves)

    def test_fen_mutation(self):
        board = Board()
        fen = board.fen()
        _ = self.checkedLegalMoves(board)
        self.assertEqual(board.fen(), fen)



if __name__ == "__main__":
    unittest.main()
