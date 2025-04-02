import unittest
import sys
sys.path.append("./")
from bulletchess import *

def testMoves(tester : unittest.TestCase, expected_ucis : set[str], board : Board):
    real_moves = set(board.legal_moves())
    expected_moves = {Move.from_uci(uci) for uci in expected_ucis}
    real_ucis = {str(move) for move in real_moves}
    tester.assertEqual(expected_moves, real_moves, msg = board.fen())
    tester.assertEqual(expected_ucis, real_ucis, msg = board.fen())
     

class TestMoveGeneration(unittest.TestCase):

    """
    Tests the generation of moves in specific positions. Move generation is tested more robustly with perft.py.
    """

    def testStarting(self):
        board = Board.starting()
        real_moves = board.legal_moves()
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
        ucis = {"b4a5", "b4b5", "b4c5", "b4a4", "b4c4",         "b4a3", "b4b3", "b4c3", "d4d3"}
        testMoves(self, ucis, board)
        fen2 = "6K1/7Q/8/8/1k1pP3/8/8/8 b - e3 0 1"
        board = Board.from_fen(fen2)
        testMoves(self, ucis | {"d4e3"}, board)

    def testOther(self):
        board = Board.from_fen("rnb3r1/R3Q3/2p5/1p1k1p1r/1n1P4/8/4P3/2K2B1r b - - 3 69")
        moves = set(board.legal_moves())
        self.assertIn(Move.from_uci("g8h8"), moves)

    # Illegal board tests
    def testEmpty(self):
        empty = Board.empty()
        self.assertEqual(len(empty.legal_moves()), 0)

    def testPawnOnBackRank(self):
        board = Board.empty()
        # flip the turn to black
        board.apply(Move.from_uci("0000"))
        board.set_piece_at(A1, Piece(BLACK, PAWN))
        self.assertEqual(len(board.legal_moves()), 0)
        board.set_piece_at(A8, Piece(BLACK, PAWN))
        moves = board.legal_moves()
        self.assertEqual(len(moves), 1)
        self.assertTrue(Move.from_uci("a8a7"), board)


if __name__ == "__main__":
    unittest.main()
