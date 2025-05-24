import sys
sys.path.append("./")
from bulletchess import *
import unittest
from bulletchess.pgn import *
from new_tests.pgn.pgn_test import PGNTestCase

FILEPATH = "new_tests/pgn/files/example.pgn"

class TestPGNResult(PGNTestCase):


    def test_black(self):
        res = BLACK_WON
        self.assertEqual(res.winner, BLACK)
        self.assertFalse(res.is_unknown)
        self.assertFalse(res.is_draw)
        self.assertEqual(res, res.from_str("0-1"))
        self.assertIs(res, res.from_str("0-1"))
        self.assertEqual(str(res), "0-1")
        self.assertEqual(repr(res), '<PGNResult: "0-1">')

    def test_white(self):
        res = WHITE_WON
        self.assertEqual(res.winner, WHITE)
        self.assertFalse(res.is_unknown)
        self.assertFalse(res.is_draw)
        self.assertEqual(res, res.from_str("1-0"))
        self.assertIs(res, res.from_str("1-0"))
        self.assertEqual(str(res), "1-0")
        self.assertEqual(repr(res), '<PGNResult: "1-0">')

    def test_unk(self):
        res = UNKNOWN_RESULT
        self.assertEqual(res.winner, None)
        self.assertTrue(res.is_unknown)
        self.assertFalse(res.is_draw)
        self.assertEqual(res, res.from_str("*"))
        self.assertIs(res, res.from_str("*"))
        self.assertEqual(str(res), "*")
        self.assertEqual(repr(res), '<PGNResult: "*">')

    def test_draw(self):
        res = DRAW_RESULT
        self.assertEqual(res.winner, None)
        self.assertFalse(res.is_unknown)
        self.assertTrue(res.is_draw)
        self.assertEqual(res, res.from_str("1/2-1/2"))
        self.assertIs(res, res.from_str("1/2-1/2"))
        self.assertEqual(str(res), "1/2-1/2")
        self.assertEqual(repr(res), '<PGNResult: "1/2-1/2">')

if __name__ == "__main__":
    unittest.main()
    
