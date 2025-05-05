import unittest
import sys
from typing import Sequence
sys.path.append("./")
from bulletchess import *
import re


def int_to_crs(i : int) -> list[CastlingType]:
    out = []
    if i & 1: 
        out.append(WHITE_KINGSIDE)
    if i & 2: 
        out.append(WHITE_QUEENSIDE)
    if i & 4: 
        out.append(BLACK_KINGSIDE)
    if i & 8: 
        out.append(BLACK_QUEENSIDE)
    return out

combinations = [int_to_crs(i) for i in range(16)]

class TestCastlingType(unittest.TestCase):

    def test_combinations(self):
        self.assertEqual(len(combinations), 16)

    def test_hash(self):
        hashes = len(set([hash(CastlingRights(cts)) for cts in combinations]))
        self.assertEqual(hashes, 16)

    def test_is(self):
        for cts in combinations:
            cr1 = CastlingRights(cts)
            cr2 = CastlingRights(cts)
            self.assertIs(cr1, cr2)

    def assert_str_valid(self, cts : Sequence[CastlingType]):
        cr = CastlingRights(cts)
        string = ""
        if WHITE_KINGSIDE in cts:
            string += "K"
        if WHITE_QUEENSIDE in cts:
            string += "Q"
        if BLACK_KINGSIDE in cts:
            string += "k"
        if BLACK_QUEENSIDE in cts:
            string += "q"
        if len(string) == 0:
            string = "-"
        self.assertEqual(str(cr), string)
        self.assertEqual(repr(cr), f"<CastlingRights: {string}>")

    def assert_contains(self, cts : Sequence[CastlingType]):
        cr = CastlingRights(cts)
        ALL_CTS = [WHITE_KINGSIDE, WHITE_QUEENSIDE, BLACK_KINGSIDE, BLACK_QUEENSIDE]
        for ct in ALL_CTS:
            if ct in cts:
                self.assertTrue(ct in cr)
            else:
                self.assertTrue(ct not in cr)


    def test_basic(self):
        for cts in combinations:
            self.assert_contains(cts)

    def test_str(self):
        self.assertEqual(str(CastlingRights([WHITE_KINGSIDE, WHITE_QUEENSIDE])), "KQ")
        for cts in combinations:
            self.assert_str_valid(cts)

    def test_full(self):
        cr = CastlingRights([WHITE_KINGSIDE, WHITE_QUEENSIDE, BLACK_KINGSIDE, BLACK_QUEENSIDE])
        self.assertTrue(cr.full())
        self.assertTrue(cr.any())
        self.assertTrue(cr.kingside(None))
        self.assertTrue(cr.kingside(WHITE))
        self.assertTrue(cr.kingside(BLACK))
        self.assertTrue(cr.queenside(None))
        self.assertTrue(cr.queenside(WHITE))
        self.assertTrue(cr.queenside(BLACK))

if __name__ == "__main__":
    unittest.main()
