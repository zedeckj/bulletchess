import unittest
import sys
from typing import Sequence
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

class TestCastlingRights(unittest.TestCase):

    def test_combinations(self):
        self.assertEqual(len(combinations), 16)

    def test_hash(self):
        hashes = set([hash(CastlingRights(cts)) for cts in combinations])
        self.assertEqual(len(hashes), 16)
        self.assertNotIn(-1, hashes)

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
        self.assertEqual(cr.fen(), string)
        self.assertEqual(repr(cr), f"<CastlingRights: \"{string}\">")

    def assert_contains(self, types_list : Sequence[CastlingType]):
        rights = CastlingRights(types_list)
        ALL_CTS = [WHITE_KINGSIDE, WHITE_QUEENSIDE, BLACK_KINGSIDE, BLACK_QUEENSIDE]
        for ct in ALL_CTS:
            if ct in types_list:
                self.assertTrue(ct in rights)
            else:
                self.assertTrue(ct not in rights)

    def test_contains(self):
        for cts in combinations:
            self.assert_contains(cts)

    def test_iter(self):
        self.assertEqual([WHITE_KINGSIDE, WHITE_QUEENSIDE, BLACK_KINGSIDE, BLACK_QUEENSIDE], list(ALL_CASTLING))
        self.assertEqual([], list(NO_CASTLING))

    def test_compare(self):
        self.assertTrue(CastlingRights.from_fen("KQ") < CastlingRights.from_fen("KQkq"))
        self.assertTrue(CastlingRights.from_fen("KQ") <= CastlingRights.from_fen("KQkq"))
        self.assertTrue(CastlingRights.from_fen("KQkq") <= CastlingRights.from_fen("KQkq"))
        self.assertFalse(CastlingRights.from_fen("KQkq") < CastlingRights.from_fen("KQkq"))

        self.assertTrue(CastlingRights.from_fen("KQkq") > CastlingRights.from_fen("KQ"))
        self.assertTrue(CastlingRights.from_fen("KQkq") >= CastlingRights.from_fen("KQ"))
        self.assertTrue(CastlingRights.from_fen("KQkq") >= CastlingRights.from_fen("KQkq"))
        self.assertFalse(CastlingRights.from_fen("KQkq") > CastlingRights.from_fen("KQkq"))

    def test_as_bool(self):
        self.assertTrue(bool(ALL_CASTLING))
        self.assertFalse(bool(NO_CASTLING))

    def test_len(self):
        self.assertEqual(len(ALL_CASTLING), 4)
        self.assertEqual(len(NO_CASTLING), 0)
        self.assertEqual(len(CastlingRights([WHITE_KINGSIDE])), 1)

    def test_compare_type(self):
        with self.assertRaises(TypeError):
            ALL_CASTLING < 0 # type: ignore
        with self.assertRaises(TypeError):
            ALL_CASTLING > True # type: ignore
        with self.assertRaises(TypeError):
            ALL_CASTLING <= "foo" # type: ignore
        with self.assertRaises(TypeError):
            ALL_CASTLING >= 3.5 # type: ignore

    def test_contains_err(self):
        with self.assertRaisesRegex(TypeError, re.escape("Expected a CastlingType, got True (bool)")):
            True in ALL_CASTLING #type: ignore

    def test_str(self):
        self.assertEqual(str(CastlingRights([WHITE_KINGSIDE, WHITE_QUEENSIDE])), "KQ")
        for cts in combinations:
            self.assert_str_valid(cts)

    def test_full(self):
        cr = CastlingRights([WHITE_KINGSIDE, WHITE_QUEENSIDE, BLACK_KINGSIDE, BLACK_QUEENSIDE])
        self.assertTrue(cr.full())
        self.assertTrue(cr.full(None))
        self.assertTrue(cr.full(WHITE))
        self.assertTrue(cr.full(BLACK))
        self.assertTrue(cr.any())
        self.assertTrue(cr.any(None))
        self.assertTrue(cr.any(BLACK))
        self.assertTrue(cr.any(WHITE))
        self.assertTrue(cr.kingside())
        self.assertTrue(cr.kingside(None))
        self.assertTrue(cr.kingside(WHITE))
        self.assertTrue(cr.kingside(BLACK))
        self.assertTrue(cr.queenside())
        self.assertTrue(cr.queenside(None))
        self.assertTrue(cr.queenside(WHITE))
        self.assertTrue(cr.queenside(BLACK))

    def test_kingside(self):
        cr = CastlingRights([WHITE_KINGSIDE, BLACK_KINGSIDE])
        self.assertFalse(cr.full())
        self.assertFalse(cr.full(None))
        self.assertFalse(cr.full(WHITE))
        self.assertFalse(cr.full(BLACK))
        self.assertTrue(cr.any())
        self.assertTrue(cr.any(None))
        self.assertTrue(cr.any(BLACK))
        self.assertTrue(cr.any(WHITE))
        self.assertTrue(cr.kingside(WHITE))
        self.assertTrue(cr.kingside(BLACK))
        self.assertFalse(cr.queenside(WHITE))
        self.assertFalse(cr.queenside(BLACK))

    def test_queenside(self):
        cr = CastlingRights([WHITE_QUEENSIDE, BLACK_QUEENSIDE])
        self.assertFalse(cr.full())
        self.assertFalse(cr.full(None))
        self.assertFalse(cr.full(WHITE))
        self.assertFalse(cr.full(BLACK))
        self.assertTrue(cr.any())
        self.assertTrue(cr.any(None))
        self.assertTrue(cr.any(BLACK))
        self.assertTrue(cr.any(WHITE))
        self.assertFalse(cr.kingside(WHITE))
        self.assertFalse(cr.kingside(BLACK))
        self.assertTrue(cr.queenside(WHITE))
        self.assertTrue(cr.queenside(BLACK))

    def test_white_queenside(self):
        cr = CastlingRights([WHITE_QUEENSIDE])
        self.assertFalse(cr.full())
        self.assertFalse(cr.full(None))
        self.assertFalse(cr.full(WHITE))
        self.assertFalse(cr.full(BLACK))
        self.assertTrue(cr.any())
        self.assertTrue(cr.any(None))
        self.assertFalse(cr.any(BLACK))
        self.assertTrue(cr.any(WHITE))
        self.assertFalse(cr.kingside(WHITE))
        self.assertFalse(cr.kingside(BLACK))
        self.assertTrue(cr.queenside(WHITE))
        self.assertFalse(cr.queenside(BLACK))

    def test_white_kingside(self):
        cr = CastlingRights([WHITE_KINGSIDE])
        self.assertFalse(cr.full())
        self.assertFalse(cr.full(None))
        self.assertFalse(cr.full(WHITE))
        self.assertFalse(cr.full(BLACK))
        self.assertTrue(cr.any())
        self.assertTrue(cr.any(None))
        self.assertFalse(cr.any(BLACK))
        self.assertTrue(cr.any(WHITE))
        self.assertTrue(cr.kingside(None))
        self.assertTrue(cr.kingside(WHITE))
        self.assertFalse(cr.kingside(BLACK))
        self.assertFalse(cr.queenside(None))
        self.assertFalse(cr.queenside(WHITE))
        self.assertFalse(cr.queenside(BLACK))

    def test_black_queenside(self):
        cr = CastlingRights([BLACK_QUEENSIDE])
        self.assertFalse(cr.full())
        self.assertFalse(cr.full(None))
        self.assertFalse(cr.full(WHITE))
        self.assertFalse(cr.full(BLACK))
        self.assertTrue(cr.any())
        self.assertTrue(cr.any(None))
        self.assertTrue(cr.any(BLACK))
        self.assertFalse(cr.any(WHITE))
        self.assertFalse(cr.kingside(None))
        self.assertFalse(cr.kingside(WHITE))
        self.assertFalse(cr.kingside(BLACK))
        self.assertTrue(cr.queenside(None))
        self.assertFalse(cr.queenside(WHITE))
        self.assertTrue(cr.queenside(BLACK))

    def test_black_kingside(self):
        cr = CastlingRights([BLACK_KINGSIDE])
        self.assertFalse(cr.full())
        self.assertTrue(cr.any())
        self.assertTrue(cr.any(None))
        self.assertTrue(cr.any(BLACK))
        self.assertFalse(cr.any(WHITE))
        self.assertTrue(cr.kingside(None))
        self.assertFalse(cr.kingside(WHITE))
        self.assertTrue(cr.kingside(BLACK))
        self.assertFalse(cr.queenside(None))
        self.assertFalse(cr.queenside(WHITE))
        self.assertFalse(cr.queenside(BLACK))

    def test_method_type_errs(self):
        with self.assertRaisesRegex(TypeError, re.escape("Expected a Color or None, got 3 (int)")):
            ALL_CASTLING.kingside(3) #type: ignore
        with self.assertRaisesRegex(TypeError, re.escape("Expected a Color or None, got foo (str)")):
            NO_CASTLING.queenside("foo") #type: ignore

    def test_fen(self):
        empty_rights = CastlingRights([])
        full_rights = CastlingRights([WHITE_KINGSIDE, WHITE_QUEENSIDE, BLACK_KINGSIDE, BLACK_QUEENSIDE])
        K_rights = CastlingRights([WHITE_KINGSIDE])
        Qk_rights = CastlingRights([WHITE_QUEENSIDE, BLACK_KINGSIDE])
        self.assertIs(empty_rights, CastlingRights.from_fen("-"))
        self.assertIs(full_rights, CastlingRights.from_fen("KQkq"))
        self.assertIs(K_rights, CastlingRights.from_fen("K"))
        self.assertIs(Qk_rights, CastlingRights.from_fen("Qk"))

    def test_fen_type_err(self):
        with self.assertRaisesRegex(TypeError, re.escape("Expected a str, got 4 (int)")):
            CastlingRights.from_fen(4) #type: ignore

    def test_fen_value_err(self):
        # same backend is tested more for Board.from_fen
        with self.assertRaisesRegex(ValueError, re.escape("No castling rights specified")):
            CastlingRights.from_fen("") #type: ignore
        with self.assertRaisesRegex(ValueError, re.escape("Invalid castling rights, 'K' cannot be specified twice")):
            CastlingRights.from_fen("KK") #type: ignore

    def test_constants(self):
        empty_rights = CastlingRights([])
        full_rights = CastlingRights([WHITE_KINGSIDE, WHITE_QUEENSIDE, BLACK_KINGSIDE, BLACK_QUEENSIDE])
        self.assertIs(empty_rights, NO_CASTLING)
        self.assertIs(full_rights, ALL_CASTLING)

    def test_add(self):
        self.assertIs(ALL_CASTLING, NO_CASTLING + ALL_CASTLING)
        self.assertIs(CastlingRights.from_fen("KQk"), 
                      CastlingRights.from_fen("K") + CastlingRights.from_fen("Qk"))
        
    def test_add_type_err(self):
        with self.assertRaisesRegex(TypeError, re.escape("Expected a CastlingRights, got 3 (int)")):
            ALL_CASTLING + 3 #type: ignore

if __name__ == "__main__":
    unittest.main()
    Board()
