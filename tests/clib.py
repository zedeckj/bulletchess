import sys
sys.path.append("./")
import unittest
import chess
import testing_utils
import random
import time
import bulletchess
from bulletchess import *


class TestMisc(unittest.TestCase):


    def test_attack_mask(self):
        starting = Board.starting()
        attack_mask = bulletchess._make_attack_mask(byref(starting), WHITE)
        self.assertEqual(testing_utils.square_list_to_bitboard([A3, B3, C3, D3, E3, F3, G3, H3, A2, B2, C2, D2, E2, F2, G2, H2, B1, C1, D1, E1, F1, G1]), attack_mask)
        

if __name__ == "__main__":
    unittest.main()