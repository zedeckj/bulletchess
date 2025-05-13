import unittest
import sys
sys.path.append("./")
from bulletchess import *

import json
class TestBoardFEN(unittest.TestCase):
    
    def assertFenInvalid(self, fen : str, msg : str):
        with self.assertRaisesRegex(ValueError, f"Invalid FEN '{fen}': {msg}"):
            Board.from_fen(fen)

    def testBoardInvalidFens(self):
        err = "No position specified"
        self.assertFenInvalid("", err)
        err = "Position does not describe entire board"
        self.assertFenInvalid( "r", err)
        self.assertFenInvalid( "rnbqkbnr b KQ - 1 2", err)
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBN w - - 0 1", err)
        err = "Position has too many squares in a rank"
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8P/PPPPPPPP/RNBQKBNR", err)
        err = "Position has unknown character"
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQLBNR", err)
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/9/PPPPPPPP/RNBQKBNR", err)
        err = "Position has too many ranks" 
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR/8 w - - 0 1", err)
        
        err = "No turn specified"
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR", err)
        err = "Turn is not 'w' or 'b'"
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR c - - 0 1", err)
        err = "Turn must be specified in lowercase"
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR W", err)
        err = "Length of turn is greater than one character"
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR black - - 0 1", err)

        err = "No castling rights specified"
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b", err)
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w   ", err)
        err = "Invalid castling rights, 'K' cannot be specified after 'Q', 'k', or 'q'"
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w QKkq - 0 1", err)
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w qK - 0 1", err)
        err = "Invalid castling rights, 'Q' cannot be specified after 'k' or 'q'"
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w kqQ- 0 1", err)
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w qQ - 0 1", err)
        err = "Invalid castling rights, 'k' cannot be specified after 'q'"
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w qk- 0 1", err)
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQqk - 0 1", err)
        err = "Invalid castling rights, 'K' cannot be specified twice"
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KK- 0                 ", err)
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KKQk- ojo1ij23o130                 ", err)
        err = "Invalid castling rights, 'Q' cannot be specified twice"

        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQQ- 0 1", err)
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w QQ.", err)
        err = "Invalid castling rights, 'q' cannot be specified twice"
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w qq foo bar", err)
        err = "Invalid castling rights, 'k' cannot be specified twice"
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w kk foo bar test test test test", err)

        err = "Missing en-passant square"
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq", err)
        err = "Invalid en-passant square"
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq --", err)
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq 2", err)
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq k8", err)
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq a9", err)
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq e12", err)
        self.assertFenInvalid( "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq hhhh", err)

        err = "Missing halfmove clock"
        self.assertFenInvalid("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - ", err) 
        err = "Missing fullmove timer"
        self.assertFenInvalid("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 1", err) 
        err = "Clock includes a non-digit"
        self.assertFenInvalid("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - a", err) 
        self.assertFenInvalid("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 10 1.", err) 
 

    def test_starting(self):
        board = Board()
        self.assertEqual(board.fen(), 
        "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")

    def test_from_fen(self):
        with open ("data/fens.json", "r") as f:
            fens = json.load(f)
        for fen in fens:
            board = Board.from_fen(fen)
            self.assertEqual(board.fen(), fen)

    def test_misuse(self):
        with self.assertRaises(TypeError):
            Board().fen(3) #type: ignore

    def test_Roundtrip(self):
        FEN = "r4rk1/1pp1qppp/p1np1n2/2b1p1B1/2B1P1b1/P1NP1N2/1PP1QPPP/R4RK1 w - - 0 10"
        board = Board.from_fen(Board.from_fen(FEN).fen())
        self.assertEqual(board.fen(), FEN)

if __name__ == "__main__":
    unittest.main()
