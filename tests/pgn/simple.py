import unittest
import sys
sys.path.append("./")
from bulletchess import *

FILEPATH = "/Users/jordan/Documents/C/ChessLibrary/tests/pgn/example.pgn"

class TestPGN(unittest.TestCase):

    def assertMoveEq(self, move, uci):
        self.assertEqual(move, Move.from_uci(uci))

    def assertMovesAre(self, game : Game, move_sans : list[str]):
        board, moves = game.board_moves()
        print(board)
        print(board.fen())
        
        self.assertEqual(board, Board())
        for i in range(len(move_sans)):
            san = moves[i].to_san(board)
            self.assertEqual(san, move_sans[i])
            board.apply(moves[i])
        

    def test_tags(self):
        with PGNReader.open(FILEPATH) as f:
            game = f.next_game()
        self.assertEqual(game.event, "F/S Return Match")
        self.assertEqual(game.site, "Belgrade, Serbia JUG")
        self.assertEqual(game.date, "1992.11.04")
        self.assertEqual(game.round, "29")
        self.assertEqual(game.white, "Fischer, Robert J.")
        self.assertEqual(game.black, "Spassky, Boris V.")
        self.assertEqual(game.result, "1/2-1/2")

    def test_moves(self):
        with PGNReader.open(FILEPATH) as f:
            game = f.next_game()
        board, moves = game.board_moves()
        self.assertMoveEq(moves[0], "e2e4")
        self.assertMoveEq(moves[1], "e7e5")
        self.assertMoveEq(moves[2], "g1f3") # "g6f3" bad error
        self.assertMoveEq(moves[3], "b8c6")
        self.assertMoveEq(moves[4], "f1b5")
        self.assertMoveEq(moves[5], "a7a6")
        self.assertMovesAre(
            game, 
            ["e4", "e5", "Nf3", "Nc6", "Bb5", "a6", "Ba4", 
             "Nf6", "O-O", "Be7", "Re1", "b5", "Bb3", "d6", "c3",
             "O-O", "h3", "Nb8", "d4", "Nbd7", "c4", "c6", "cxb5",
             "axb5", "Nc3", "Bb7", "Bg5", "b4", "Nb1", "h6", 
             "Bh4", "c5", "dxe5", "Nxe4", "Bxe7", "Qxe7", "exd6", 
             "Qf6", "Nbd2", "Nxd6", "Nc4", "Nxc4", "Bxc4", "Nb6",
             "Ne5", "Rae8", "Bxf7+", "Rxf7", "Nxf7", "Rxe1+",
             "Qxe1", "Kxf7", "Qe3", "Qg5", "Qxg5", "hxg5", "b3",
             "Ke6", "a3", "Kd6", "axb4", "cxb4", "Ra5", "Nd5", "f3",
             "Bc8", "Kf2", "Bf5", "Ra7", "g6", "Ra6+", "Kc5", "Ke1",
             "Nf4", "g3", "Nxh3", "Kd2", "Kb5", "Rd6", "Kc5", "Ra6",
             "Nf2", "g4", "Bd3", "Re6"]) 

    def test_empty(self):
        with PGNReader.open(FILEPATH) as f:
            _ = f.next_game()
            none = f.next_game()
        self.assertEqual(none, None)


if __name__ == "__main__":
    unittest.main()
