import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

import bulletchess.utils

class TestBitboardConstants(unittest.TestCase):

    def test_ranks(self):
        self.assertEqual(RANK_1, Bitboard([A1, B1, C1, D1, E1, F1, G1, H1]))
        self.assertEqual(RANK_2, Bitboard([A2, B2, C2, D2, E2, F2, G2, H2]))
        self.assertEqual(RANK_3, Bitboard([A3, B3, C3, D3, E3, F3, G3, H3]))
        self.assertEqual(RANK_4, Bitboard([A4, B4, C4, D4, E4, F4, G4, H4]))
        self.assertEqual(RANK_5, Bitboard([A5, B5, C5, D5, E5, F5, G5, H5]))
        self.assertEqual(RANK_6, Bitboard([A6, B6, C6, D6, E6, F6, G6, H6]))
        self.assertEqual(RANK_7, Bitboard([A7, B7, C7, D7, E7, F7, G7, H7]))
        self.assertEqual(RANK_8, Bitboard([A8, B8, C8, D8, E8, F8, G8, H8]))

    def test_files(self):
        self.assertEqual(A_FILE, Bitboard([A1, A2, A3, A4, A5, A6, A7, A8]))
        self.assertEqual(B_FILE, Bitboard([B1, B2, B3, B4, B5, B6, B7, B8]))
        self.assertEqual(C_FILE, Bitboard([C1, C2, C3, C4, C5, C6, C7, C8]))
        self.assertEqual(D_FILE, Bitboard([D1, D2, D3, D4, D5, D6, D7, D8]))
        self.assertEqual(E_FILE, Bitboard([E1, E2, E3, E4, E5, E6, E7, E8]))
        self.assertEqual(F_FILE, Bitboard([F1, F2, F3, F4, F5, F6, F7, F8]))
        self.assertEqual(G_FILE, Bitboard([G1, G2, G3, G4, G5, G6, G7, G8]))
        self.assertEqual(H_FILE, Bitboard([H1, H2, H3, H4, H5, H6, H7, H8]))

    def test_full_empty(self):
        self.assertEqual(FULL_BB, A_FILE | B_FILE | C_FILE | D_FILE | E_FILE | F_FILE | G_FILE | H_FILE)
        self.assertEqual(EMPTY_BB, Bitboard([]))

    def test_dark_square(self):
        bb = Bitboard([
            A1, C1, E1, G1, 
            B2, D2, F2, H2, 
            A3, C3, E3, G3, 
            B4, D4, F4, H4, 
            A5, C5, E5, G5, 
            B6, D6, F6, H6, 
            A7, C7, E7, G7, 
            B8, D8, F8, H8, 
        ])
        self.assertEqual(bb, DARK_SQUARE_BB)

    def test_light_square(self):
        bb = Bitboard([
            B1, D1, F1, H1, 
            A2, C2, E2, G2, 
            B3, D3, F3, H3, 
            A4, C4, E4, G4, 
            B5, D5, F5, H5, 
            A6, C6, E6, G6, 
            B7, D7, F7, H7, 
            A8, C8, E8, G8, 
        ])
        self.assertEqual(bb, LIGHT_SQUARE_BB)

    def test_lists(self):
        self.assertEqual(RANKS, [RANK_1, RANK_2, RANK_3, RANK_4, RANK_5, RANK_6, RANK_7, RANK_8])
        self.assertEqual(FILES, [A_FILE, B_FILE, C_FILE, D_FILE, E_FILE, F_FILE, G_FILE, H_FILE])

    def test_mutability(self):
        bb = EMPTY_BB
        bb |= RANK_1
        self.assertEqual(EMPTY_BB, Bitboard([]))
        self.assertEqual(bb, RANK_1)

if __name__ == "__main__":
    unittest.main()
