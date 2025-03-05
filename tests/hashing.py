import sys
sys.path.append("./")
import unittest
import bulletchess
import chess
import testing_utils
import time


class TestHasing(unittest.TestCase):

    def test_hashing_speed(self):
        COUNT= 1000
        chess_boards = [testing_utils.random_chess_board() for _ in range(COUNT)]
        bullet_boards = [testing_utils.make_bullet_from_chess(board) for board in chess_boards]
        
        t = time.time()
        chess_set = set()
        for board in chess_boards:
            chess_set.add(board.fen())
        t = time.time() - t

        t2 = time.time()
        bullet_set = set()
        for board in bullet_boards:
            bullet_set.add(board)
        t2 = time.time() - t2

        print(f"python-chess took {t} bullet-chess took {t2}")
        self.assertLess(t2, t)

if __name__ == "__main__":
    unittest.main()