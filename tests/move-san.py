import unittest
import sys
sys.path.append("./")
from bulletchess import *

from bulletchess.backend import is_san_correctPY


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
    tester.assertEqual(move.to_san(board), san)  
   
def roundtrip_uci(tester : unittest.TestCase,
              move : Move,
              board : Board):
    """
    Tests that a move is equal to serializing to SAN,
    then reading from SAN
    """
    san = move.to_san(board)
    tester.assertNotEqual(san, "", msg = (board.fen(), str(move)))
    try:
        move2 = Move.from_san(san, board)
    except:
        raise Exception(f"Could not parse {san} on {board.fen()}")
    tester.assertEqual(move, move2, msg = (board.fen(), san))

def roundtrip_san(tester : unittest.TestCase,
              san : str,
              board : Board):
    """
    Tests that a move is equal to serializing to SAN,
    then reading from SAN
    """
    move = Move.from_san(san, board)
    san2 = move.to_san(board)
    tester.assertEqual(san, san2)



def roundtripPerft(tester : unittest.TestCase,
                   board : Board, 
                   depth : int):
    if depth == 0:
        return
    else:
        for move in board.legal_moves():
            roundtrip_uci(tester, move, board)
            board.apply(move)
            roundtripPerft(tester, board, depth - 1)
            board.undo()


class TestSAN(unittest.TestCase):

    def test_rountrip_strict(self):
        if FOCUS:
            return
        for san in STRICT_SANS:
            self.assertTrue(is_san_correctPY(san), msg = san)
   
    def test_rountrip_invalid(self):
        
        if FOCUS:
            return
        for san in INVALID_SANS:
            self.assertFalse(is_san_correctPY(san), msg = san)

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

    def test_check(self):
        board = Board.from_fen("r1bqkbnr/pppp2pp/2n5/4pp2/2B1P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 0 4")
        moves = board.legal_moves()
        checks = Move.from_uci("c4f7")
        self.assertIn(checks, moves)
        self.assertEqual(Move.from_san("Bf7+", board), checks)
        self.assertEqual(Move.to_san(checks, board), "Bf7+")


    def test_check(self):
        board = Board.from_fen("r1bqkb1r/pppp1ppp/2n2n2/4p2Q/2B1P3/8/PPPP1PPP/RNB1K1NR w KQkq - 4 4") 
        moves = board.legal_moves()
        checks = Move.from_uci("h5f7")
        self.assertIn(checks, moves)
        self.assertEqual(Move.from_san("Qxf7#", board), checks)
        self.assertEqual(Move.to_san(checks, board), "Qxf7#")



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
            board = utils.random_board()
            roundtripPerft(self, board, 3)

    def test_ambigious_pseudolegal(self):
        FEN = "rnbk3r/pp3pbp/2p2np1/4p1B1/2P1P3/2N2P2/PP2N1PP/4KB1R b K - 2 9"
        board = Board.from_fen(FEN)
        san = "Nd7"
        self.assertTrue(is_san_correctPY(san))
        move = Move.from_san(san, board)
        print(move._Move__struct.type)
        san2 = Move.to_san(move, board)
        #self.assertEqual(san, san2) # Nbd7 currently
        self.assertEqual(move, Move.from_uci("b8d7"))


    def test_ambigious_pseudolegal2(self):
        FEN = "2R2rk1/1p5p/3p2rq/p2P1Q2/2P1P3/P7/1P5P/5R1K b - - 2 36"
        board = Board.from_fen(FEN)
        san = "Rf6"
        self.assertTrue(is_san_correctPY(san))
        move = Move.from_san(san, board)
        print(move._Move__struct.type)
        san2 = Move.to_san(move, board)
        #self.assertEqual(san, san2) # Nbd7 currently
        self.assertEqual(move, Move.from_uci("g6f6"))


    def test_castling(self):
        if FOCUS:
            return
        testSanEq(self, "O-O", "e1g1")
        testSanEq(self, "O-O-O", "e1c1")
        board = Board.starting()
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
            roundtrip_san(self, sans[i], board)


FOCUS = False
if __name__ == "__main__":
    unittest.main() 
