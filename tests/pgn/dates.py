import sys
sys.path.append("./")
from bulletchess import *
import unittest
from bulletchess.pgn import *
from tests.pgn.pgn_test import PGNTestCase

FILEPATH = "data/pgn/example.pgn"

class TestPGNDate(PGNTestCase):

    def test_basic(self):
        date = PGNDate(2000, None, 1)
        self.assertEqual(date.year, 2000)
        self.assertEqual(date.month, None)
        self.assertEqual(date.day, 1)

    def test_compare(self):
        date = PGNDate(2000, None, 3)
        self.assertEqual(date, PGNDate(2000, None, 3))
        self.assertLess(date, PGNDate(2010, None, 3))
        self.assertLess(date, PGNDate(2010, None, 1))
        self.assertGreater(date, PGNDate(1990, None, 3))
        self.assertGreater(date, PGNDate(1990, None, 1))
        date = PGNDate(2000, 5, 3)
        self.assertEqual(date, PGNDate(2000, 5, 3))
        self.assertGreater(date, PGNDate(2000, 1, 3))
        self.assertLess(date, PGNDate(1990, 10, 3))
        self.assertGreater(date, PGNDate(2000, 5, 1))
        self.assertLess(date, PGNDate(2000, 5, 5))

    def compare_unk(self):
        unk = PGNDate(None, None, None)
        date = PGNDate(2000, 10, 5)
        self.assertFalse(date == unk)
        self.assertFalse(date < unk)
        self.assertFalse(date > unk)
        self.assertFalse(date <= unk)
        self.assertFalse(date >= unk)
        unk = PGNDate(None, 10, 5)
        self.assertFalse(date == unk)
        self.assertFalse(date < unk)
        self.assertFalse(date > unk)
        self.assertFalse(date <= unk)
        self.assertFalse(date >= unk)

    def test_str(self):
        self.assertEqual(str(PGNDate(None, None, None)), "????.??.??")
        self.assertEqual(str(PGNDate(2020, 1, 10)), "2020.01.10")
        self.assertEqual(str(PGNDate(900, None, None)), "0900.??.??")
        self.assertEqual(str(PGNDate(1988, None, 2)), "1988.??.02")
        self.assertEqual(str(PGNDate(None, 2, 2)), "????.02.02")

if __name__ == "__main__":
    unittest.main()
    
