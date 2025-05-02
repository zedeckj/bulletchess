import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

"""
<SAN move descriptor piece moves>   
	::= <Piece symbol>[<from file>|<from rank>|<from square>]['x']<to square>
<SAN move descriptor pawn captures> 
	::= <from file>[<from rank>] 'x' <to square>[<promoted to>]
<SAN move descriptor pawn push>     
	::= <to square>[<promoted to>]
"""


STRICT_SANS = [
    "Na2",
    "e4",
    "h8Q",
    "Bae2",
    "R2h2",
    "a1",
    "h2",
    "f8R",
    "b4N",
    "Ra2xa4",
    "Bbxb3",
    "e3!!",
    "Kd3?",
    "N1d2!?",
    "axb2?!",
    "c6??",
    "Na3xa2!",
    "d8=Q",
    "hxg8=Q+"
]

INVALID_SANS = [
    "",
    "Na12",
    "e4 ",
    "B1",
    "f8R1",
    "e3!!!",
    "a",
    "2?!",
    "Pe2",
    "e2e4"
]

def testSanEq(tester : unittest.TestCase,
              san : str,
              uci : str,
              board : Board = Board()):
    move = Move.from_uci(uci)
    tester.assertEqual(Move.from_san(san, board), move)
    tester.assertEqual(type(move), Move)
    if type(move) is Move:
        tester.assertEqual(move.san(board), san)  
   
def roundtrip_move_san(tester : unittest.TestCase,
              move : Move,
              board : Board):
    san = move.san(board)
    tester.assertNotEqual(san, "", msg = (board.fen(), str(move)))
    move2 = Move.from_san(san, board)
    tester.assertEqual(move, move2, msg = (board.fen(), san))

def roundtrip_str_san(tester : unittest.TestCase,
              san : str,
              board : Board):
    """
    Tests that a move is equal to serializing to SAN,
    then reading from SAN
    """
    move = Move.from_san(san, board)
    san2 = move.san(board)
    tester.assertEqual(san, san2)



def roundtripPerft(tester : unittest.TestCase,
                   board : Board, 
                   depth : int):
    if depth == 0:
        return
    else:
        for move in board.legal_moves():
            roundtrip_move_san(tester, move, board)
            board.apply(move)
            roundtripPerft(tester, board, depth - 1)
            board.undo()


class TestSAN(unittest.TestCase):


   
    def test_starting(self):
        testSanEq(self, "a3", "a2a3")
        testSanEq(self, "a4", "a2a4")
        testSanEq(self, "b3", "b2b3")
        testSanEq(self, "b4", "b2b4")
        testSanEq(self, "c3", "c2c3")
        testSanEq(self, "c4", "c2c4")
        testSanEq(self, "d3", "d2d3")
        testSanEq(self, "d4", "d2d4")
        testSanEq(self, "e3", "e2e3")
        testSanEq(self, "e4", "e2e4")
        testSanEq(self, "d3", "d2d3")
        testSanEq(self, "d4", "d2d4")
        testSanEq(self, "f3", "f2f3")
        testSanEq(self, "f4", "f2f4")
        testSanEq(self, "g3", "g2g3")
        testSanEq(self, "g4", "g2g4")
        testSanEq(self, "h3", "h2h3")
        testSanEq(self, "h4", "h2h4")
        testSanEq(self, "Na3", "b1a3")
        testSanEq(self, "Nc3", "b1c3")
        testSanEq(self, "Nf3", "g1f3")
        testSanEq(self, "Nh3", "g1h3")

    def test_check1(self):
        board = Board.from_fen("r1bqkbnr/pppp2pp/2n5/4pp2/2B1P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 0 4")
        moves = board.legal_moves()
        checks = Move.from_uci("c4f7")
        self.assertIn(checks, moves)
        self.assertEqual(Move.from_san("Bf7+", board), checks)
        if type(checks) is Move:
            self.assertEqual(checks.san(board), "Bf7+")


    def test_check2(self):
        board = Board.from_fen("r1bqkb1r/pppp1ppp/2n2n2/4p2Q/2B1P3/8/PPPP1PPP/RNB1K1NR w KQkq - 4 4") 
        moves = board.legal_moves()
        checks = Move.from_uci("h5f7")
        self.assertIn(checks, moves)
        self.assertEqual(Move.from_san("Qxf7#", board), checks)
        if type(checks) is Move:
            self.assertEqual(checks.san(board), "Qxf7#")



    def test_promotion(self):
        if FOCUS:
            return
        board = Board.from_fen("8/8/5k2/2B5/4n3/8/1K3p2/8 b - - 0 1")
        testSanEq(self, "Kf7", "f6f7", board)
        testSanEq(self, "Kg7", "f6g7", board)
        testSanEq(self, "Kg6", "f6g6", board)
        testSanEq(self, "Kg5", "f6g5", board)
        testSanEq(self, "Kf5", "f6f5", board)
        testSanEq(self, "Ke5", "f6e5", board)
        testSanEq(self, "Ke6", "f6e6", board)
        testSanEq(self, "Nd6", "e4d6", board)
        testSanEq(self, "Nxc5", "e4c5", board)
        testSanEq(self, "Nc3", "e4c3", board)
        testSanEq(self, "Nd2", "e4d2", board)
        testSanEq(self, "f1Q", "f2f1q", board)
        testSanEq(self, "f1N", "f2f1n", board)
        testSanEq(self, "f1R", "f2f1r", board)
        testSanEq(self, "f1B", "f2f1b", board)

    def test_other(self):
        if FOCUS:
            return;
        board = Board.from_fen("rnb3r1/R3Q3/2p5/1p1k1p1r/1n1P4/8/4P3/2K2B1r b - - 3 69")
        testSanEq(self, "Rgh8", "g8h8", board)

    def test_perft(self):
        if FOCUS:
            return
        for i in range(20):
            board = Board.random()
            roundtripPerft(self, board, 3)

    def test_ambigious_pseudolegal(self):
        FEN = "rnbk3r/pp3pbp/2p2np1/4p1B1/2P1P3/2N2P2/PP2N1PP/4KB1R b K - 2 9"
        board = Board.from_fen(FEN)
        san = "Nd7"
        move = Move.from_san(san, board)
        san2 = Move.san(move, board)
        self.assertEqual(san2, "Nbd7") # overly specifies, but not an explicit error
        self.assertEqual(move, Move.from_uci("b8d7"))


    def test_ambigious_pseudolegal2(self):
        FEN = "2R2rk1/1p5p/3p2rq/p2P1Q2/2P1P3/P7/1P5P/5R1K b - - 2 36"
        board = Board.from_fen(FEN)
        san = "Rf6"
        move = Move.from_san(san, board)
        san2 = Move.san(move, board)
        self.assertEqual(san2, "Rgf6") # overly specifies, but not an explicit error
        self.assertEqual(move, Move.from_uci("g6f6"))


    def test_castling(self):
        if FOCUS:
            return
        testSanEq(self, "O-O", "e1g1")
        testSanEq(self, "O-O-O", "e1c1")
        board = Board()
        board.turn = BLACK
        testSanEq(self, "O-O", "e1g1")
        testSanEq(self, "O-O-O", "e1c1")

    def testRegressionReadSan(self):
        if FOCUS:
            return
        sans = ["axb6", "Nxb5"]
        fens = ["rnbqkbnr/2pppppp/p7/Pp6/8/8/1PPPPPPP/RNBQKBNR w KQkq b6 0 3",
                "rnbqkbnr/2pppppp/8/pp6/8/N7/PPPPPPPP/1RBQKBNR w Kkq b6 0 3"]
        for i in range(len(fens)):
            board = Board.from_fen(fens[i])
            roundtrip_str_san(self, sans[i], board)



    def testMisuse(self):
        with self.assertRaisesRegex(TypeError, re.escape("function takes exactly 2 arguments (1 given)")):
            san = Move.from_san("e2") #type: ignore
        with self.assertRaisesRegex(TypeError, re.escape("Expected a Board, got None (NoneType)")):
            san = Move.from_san("e2", None) #type: ignore
        with self.assertRaisesRegex(TypeError, re.escape("Expected a Board, got None (NoneType)")):
            san = Move(E2,E4).san(None) #type: ignore
        with self.assertRaisesRegex(ValueError, re.escape("Cannot convert Move to san, <Move: e2e4> is illegal for <Board: 8/8/8/8/8/8/8/8 w - - 0 1>")):
            san = Move(E2,E4).san(Board.empty()) #type: ignore


FOCUS = False
if __name__ == "__main__":
    unittest.main() 
