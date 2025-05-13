import sys
sys.path.append("./")
from bulletchess import *
import unittest
from bulletchess.pgn import *
from new_tests.pgn.pgn_test import PGNTestCase
import faulthandler

faulthandler.enable()
FILEPATH = "new_tests/pgn/files/example.pgn"

class TestPGN(PGNTestCase):

    def test_tags(self):
        f = PGNFile.open(FILEPATH)
        game = f.next_game()
        self.assertEqual(game.starting_board, Board())
        self.assertEventEq(game, "F/S Return Match")
        self.assertSiteEq(game, "Belgrade, Serbia JUG")
        self.assertDateEq(game, PGNDate(1992, 11, 4))
        self.assertRoundEq(game, "29")
        self.assertWhiteEq(game, "Fischer, Robert J.")
        self.assertBlackEq(game, "Spassky, Boris V.")
        self.assertResultEq(game, PGNResult.draw())
        self.assertEqual(game["Random tag"], None)
        f.close()

    def test_moves(self):
        f = PGNFile.open(FILEPATH)
        game = f.next_game()
        moves = game.moves
        print("got moves in test")
        self.assertMoveEq(moves[0], "e2e4")
        self.assertMoveEq(moves[1], "e7e5")
        self.assertMoveEq(moves[2], "g1f3") 
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
        print("done moves test")
        f.close()



if __name__ == "__main__":
    unittest.main()
    
