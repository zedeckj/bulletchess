import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestMakeBitboard(unittest.TestCase):

    def test_def(self):
        with self.assertNoLogs():
            Bitboard([A1])

    def test_all(self):
        self.assertEqual(Bitboard.all(), A_FILE | B_FILE | C_FILE | D_FILE | E_FILE | F_FILE | G_FILE | H_FILE)
        self.assertEqual(Bitboard.empty(), Bitboard([]))

    def test_err(self):
        with self.assertRaisesRegex(TypeError, re.escape("Expected an Iterable, got A1 (bulletchess.Square)")):
            Bitboard(A1) #type: ignore
        with self.assertRaisesRegex(TypeError, re.escape("Expected a Square, got 2 (int)")):
            Bitboard([2]) #type: ignore
        with self.assertRaisesRegex(TypeError, re.escape("function takes exactly 1 argument (2 given)")):
            Bitboard([A1], 2) #type: ignore

if __name__ == "__main__":
    unittest.main()
