import unittest
import sys
sys.path.append("./")
from bulletchess import *

def testInvalid(tester : unittest.TestCase, fen : str, msg : str):
    with tester.assertRaisesRegex(ValueError, msg):
        board = Board.from_fen(fen)

def testFenInvalid(tester : unittest.TestCase, fen : str, msg : str):
    with tester.assertRaisesRegex(ValueError, f"Invalid FEN '{fen}': {msg}"):
        board = Board.from_fen(fen)


class TestFen(unittest.TestCase):

    """
    Tests the serialization and parsing of FEN strings.
    """

    def testStarting(self):
        starting_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
        board1 = Board.from_fen(starting_fen)
        board2 = Board.starting()
        self.assertEqual(board1, board2)
        self.assertEqual(starting_fen, board2.fen())
        self.assertEqual(starting_fen, board1.fen())

    def testIllegalFens(self):
        err = "Board must have a king for both players"
        testInvalid(self,"8/8/8/8/8/8/8/8 w - - 0 0",err) 
        testInvalid(self, "8/8/8/8/5K2/8/8/8 b - - 0 1", err)
        testInvalid(self, "8/8/8/8/1k6/8/8/8 w - - 10 5", err)
        testInvalid(self, "8/8/3k4/8/8/8/2PBPPQ1/8 b - - 0 30", err) 
        err = "Board cannot have more than 1 white king"
        testInvalid(self,"8/8/3k4/8/8/7K/K1PBPPQ1/8 w - - 0 1" ,err)
        testInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBKKBNR w KQkq - 0 1", err)
        err = "Board cannot have more than 1 black king"
        testInvalid(self, "rnbqkbnr/pppppppp/8/8/6k1/8/PPPPPPPP/RNBQKBNR b KQkq - 0 1", err)
        err = "The player to move cannot be able to capture the opponent's king"
        testInvalid(self, "rnb1kbnr/pppp1ppp/8/8/7q/8/PPPPP1PP/RNBQKBNR b KQkq - 0 1", err)
        testInvalid(self, "rnbqkbnr/pppp1ppp/8/4Q3/3P4/8/PPP1P1PP/RNB1KBNR w KQkq - 0 1", err)
        err = "Board cannot have pawns on the back ranks"
        testInvalid(self, "rnbqkbnr/pppp1ppp/8/1Q6/3P4/8/PPP1P1PP/RNBPKBNR w KQkq - 0 1", err)
        testInvalid(self, "rnbqkbnr/pppp1ppp/8/1Q6/3P4/8/PPP1P1PP/RNBpKBNR w KQkq - 0 1", err)
        testInvalid(self, "rnbqkbPr/pppp1ppp/8/1Q6/3P4/8/PPP1P1PP/RNB1KBNR w KQkq - 0 1", err)
        testInvalid(self, "rnbqkbpr/pppp1ppp/8/1Q6/3P4/8/PPP1P1PP/RNB1KBNR w KQkq - 0 1", err)
        err = "Board castling rights are illegal, neither player can castle"
        testInvalid(self, "rnbq1bnr/ppppkppp/8/4p3/4P3/8/PPPPKPPP/RNBQ1BNR w KQk - 2 3", err)
        err = "Board castling rights are illegal, white cannot castle"
        testInvalid(self, "r1bqk1nr/pppp1ppp/2n5/2b1p3/2B1P3/5N2/PPPP1PPP/RNBQ1RK1 b KQkq - 5 4", err)
        err = "Board castling rights are illegal, black cannot castle"
        testInvalid(self, "r1bq1rk1/pppp1ppp/2n2n2/2b1p3/2B1P3/3P1N2/PPP2PPP/RNBQ1RK1 w kq - 1 6", err)
        err = "Board castling rights are illegal, white cannot castle kingside"
        testInvalid(self, "rnbqkbnr/ppp1pppp/8/3p4/7P/7R/PPPPPPP1/RNBQKBN1 b Kkq - 1 2", err)
        err = "Board castling rights are illegal, white cannot castle queenside"
        testInvalid(self, "rnbqkbnr/pppp1ppp/8/4p3/P7/8/RPPPPPPP/1NBQKBNR b KQ - 1 2", err)
        err = "Board castling rights are illegal, black cannot castle kingside"
        testInvalid(self, "rnbqkr2/ppp2ppp/5n2/3pp3/PP6/R7/2PPPPPP/1N1QKBNR w Kkq - 1 6", err)
        err = "Board castling rights are illegal, black cannot castle queenside"
        testInvalid(self, "2bqkbnr/2pppppp/r7/p7/3PP3/8/PPP2PPP/RNBQK1NR w KQkq - 0 5", err)

    def testInvalidFens(self):
        err = "Empty FEN"
        testFenInvalid(self, "", err)
        err = "Position does not describe entire board"
        testFenInvalid(self, "r", err)
        testFenInvalid(self, "rnbqkbnr b KQ - 1 2", err)
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBN w - - 0 1", err)
        err = "Position has too many squares in a rank"
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8P/PPPPPPPP/RNBQKBNR", err)
        err = "Position has unknown character"
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQLBNR", err)
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/9/PPPPPPPP/RNBQKBNR", err)
        err = "Position has too many ranks" 
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR/8 w - - 0 1", err)
        
        err = "No turn specified"
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR", err)
        err = "Turn is not 'w' or 'b'"
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR c - - 0 1", err)
        err = "Turn must be specified in lowercase"
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR W", err)
        err = "Length of turn is greater than one character"
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR black - - 0 1", err)

        err = "No castling rights specified"
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b", err)
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w   ", err)
        err = "Invalid castling rights, 'K' cannot be specified after 'Q', 'k', or 'q'"
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w QKkq - 0 1", err)
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w qK - 0 1", err)
        err = "Invalid castling rights, 'Q' cannot be specified after 'k' or 'q'"
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w kqQ- 0 1", err)
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w qQ - 0 1", err)
        err = "Invalid castling rights, 'k' cannot be specified after 'q'"
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w qk- 0 1", err)
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQqk - 0 1", err)
        err = "Invalid castling rights, 'K' cannot be specified twice"
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KK- 0                 ", err)
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KKQk- ojo1ij23o130                 ", err)
        err = "Invalid castling rights, 'Q' cannot be specified twice"

        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQQ- 0 1", err)
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w QQ.", err)
        err = "Invalid castling rights, 'q' cannot be specified twice"
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w qq foo bar", err)
        err = "Invalid castling rights, 'k' cannot be specified twice"
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w kk foo bar test test test test", err)

        err = "Missing en-passant square"
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq", err)
        err = "Invalid en-passant square"
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq --", err)
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq 2", err)
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq k8", err)
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq a9", err)
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq e12", err)
        testFenInvalid(self, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq hhhh", err)

        err = "Missing move timer"
        testFenInvalid(self,"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - ", err) 
        testFenInvalid(self,"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 1", err) 
        err = "Clock includes a non-digit"
        testFenInvalid(self,"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - a", err) 
        testFenInvalid(self,"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 10 1.", err) 
 



if __name__ == "__main__":
    unittest.main()
