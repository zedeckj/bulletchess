import sys
sys.path.append("./")
import unittest
import bulletchess
import chess
import testing_utils
import time


class TestFen(unittest.TestCase):

    def test_fen_creation(self):
        chess_boards = [testing_utils.random_chess_board() for _ in range(1000)]
        bullet_boards = [testing_utils.make_bullet_from_chess(board) for board in chess_boards]
        
        t = time.time()
        fens1 = []
        for board in chess_boards:
            fens1.append(board.fen(en_passant= "fen"))
        t = time.time() - t

        t2 = time.time()
        fens2 = []
        for board in bullet_boards:
            fens2.append(board.fen())
        t2 = time.time() - t2

        print(f"FEN creation in python-chess took {t}, and bullet-chess took {t2}")
        self.assertLess(t2, t)
        for i in range(1000):
            self.assertEqual(fens1[i], fens2[i], msg= f"index {i}: {fens1[i]} != {fens2[i]}")

if __name__ == "__main__":
    unittest.main()