import unittest
import sys
sys.path.append("./")
from bulletchess import *
from bulletchess.pgn import *
from tests.pgn.pgn_test import PGNTestCase

FILEPATH = "data/pgn/Modern.pgn"

class TestPGN(PGNTestCase):

    def test_read_all(self):
        with self.assertNoLogs():
            with PGNFile.open(FILEPATH) as f:
                game = f.next_game()
                while game != None: 
                    self.assertEqual(type(game.black_player), str)
                    self.assertEqual(type(game.white_player), str)
                    date = game.date
                    year = date.year
                    month = date.month
                    day = date.day
                    self.assertTrue(year is None or type(year) is int)
                    self.assertTrue(month is None or type(month) is int)
                    self.assertTrue(day is None or type(day) is int)
                    self.assertEqual(type(game.result), PGNResult)
                    self.assertEqual(type(game.round), str)
                    self.assertEqual(type(game.event), str)
                    self.assertEqual(type(game.site), str)
                    game = f.next_game()
            self.assertFalse(f.is_open())


    def test_moves(self):
        f = PGNFile.open(FILEPATH)
        game = f.next_game()
        self.assertMovesAre(game, [
            "e4", "d6", "d4", "g6", "c4", "Bg7", "Nc3", "Nc6",
            "Be3", "e5", "d5", "Nce7", "c5", "Nh6", "f3", "f5",
            "cxd6", "cxd6", "Bb5+", "Kf8", "Qa4", "f4", "Bf2", "Bf6",
            "Nge2", "Kg7", "Rc1", "a6", "O-O", "g5", "Rc2", "Rb8", 
            "Bd3", 
            "Nf7", "Rfc1", "Qd7", "Bb6", "Qxa4", "Nxa4", "Bd7",
            "Nec3", "Rbc8", "Ba5", "Bxa4", "Nxa4", "Rxc2", "Rxc2", 
            "Rc8", "Nb6", "Rxc2", "Bxc2", "h5", "Ba4", "g4", "Bd7", 
            "gxf3", "gxf3", "Ng5", "Kf2",
            "Kf8", "Nc4", "Ng6", "Bc8", "Be7", "Bxb7", "Nh4", "Nd2",
            "Nh3+", "Kf1"
        ])
        game = f.next_game()
        self.assertMovesAre(game, [
            "c4", "g6", "d4", "Bg7", "e4", "d6", "Nc3", "c5", "dxc5",
            "Bxc3+", "bxc3", "dxc5", "Bd3", "Nc6", "f4", "Qa5", 
            "Ne2", "Be6", "f5", "O-O-O", "fxe6", "Ne5", "exf7",
            "Nf6", "O-O", "Nxd3", "Bh6", "Ne5", "Qb3", "Nxf7"
        ])
    
if __name__ == "__main__":
    unittest.main()
