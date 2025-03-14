import sys
sys.path.append("./")
import unittest
import bulletchess
import chess
import testing_utils
import time
from ctypes import *
import re


class TestParsing(unittest.TestCase):

    def test_split(self):
        fens = [testing_utils.random_chess_board().fen(en_passant="legal") for _ in range(100)]
        for fen_str in fens:
            fen = create_string_buffer(init = fen_str.encode("utf-8"))
            split = bulletchess._split_fen(fen)
            true_split = [s.encode("utf-8") for s in re.split("\\s+", fen_str)]
            self.assertNotEqual(split, None)
            split = split.contents
            self.assertEqual(split.position_str, true_split[0])
            self.assertEqual(split.turn_str, true_split[1])
            self.assertEqual(split.castling_str, true_split[2])
            self.assertEqual(split.ep_str, true_split[3])
            self.assertEqual(split.halfmove_str,true_split[4])
            self.assertEqual(split.fullmove_str, true_split[5])

    def test_parse(self):
        COUNT = 100
        fens = [testing_utils.random_chess_board().fen(en_passant="legal") for _ in range(COUNT)]

        for i in range(COUNT):
            fen = bulletchess.Board.from_fen(fens[i]).fen()
            self.assertEqual(fens[i], fen, msg = i)

    def test_time(self):
        COUNT = 1000
        fens = [testing_utils.random_chess_board().fen(en_passant="legal") for _ in range(COUNT)]
        t = time.time()
        for fen in fens:
            board = chess.Board(fen)
        t = time.time() - t

        t2 = time.time()
        for fen in fens:
            board = bulletchess.Board.from_fen(fen)
        t2 = time.time() - t2
        print(f"\nParsing {COUNT} FENs:\npython-chess:{t}\nbullet-chess:{t2}")
        self.assertLess(t2,t)


if __name__ == "__main__":
    unittest.main()