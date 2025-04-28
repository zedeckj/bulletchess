import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestUCI(unittest.TestCase):


    def assert_symmetric(self, origin : Square, destination : Square):
        move = Move.from_uci(f"{origin}{destination}")
        self.assertEqual(type(move), Move)
        if type(move) is Move:
            self.assertEqual(move.origin, origin)
            self.assertEqual(move.destination, destination)
            self.assertEqual(move.promotion, None)
            self.assertEqual(move, Move(origin, destination))

    def test_construct(self):
        with self.assertNoLogs():
            Move.from_uci("e2e4")
            Move.from_uci("a1a5")
            Move.from_uci("h7h8q")
            Move.from_uci("H7H8q")
            
    def test_batch(self):
        self.assert_symmetric(A1, A2)
        self.assert_symmetric(E1, E2)
        self.assert_symmetric(H3, H7)
        self.assert_symmetric(F5, F3)
        self.assert_symmetric(B2, H2)
        self.assert_symmetric(H1, H2)
        self.assert_symmetric(G1, G3)
        self.assert_symmetric(A1, H8)
            

    def test_null(self):
        self.assertEqual(Move.from_uci("0000"), None)

    def test_get(self):
       move = Move.from_uci("a3a4")
       self.assertNotEqual(move, None)
       self.assertEqual(type(move), Move)
       if type(move) is Move:
            self.assertEqual(move.origin, A3)
            self.assertEqual(move.destination, A4)
            self.assertEqual(move.promotion, None)

        


    def test_illegal(self):
        with self.assertRaisesRegex(ValueError, re.escape("Illegal Move, a promotion's destination must be on a back rank, got C4")):
            Move.from_uci("c3c4q")
        with self.assertRaisesRegex(ValueError, re.escape("Illegal Move, H3 to H8 is not a legal Pawn move and cannot be a promotion")):
            Move.from_uci("h3h8q")
        with self.assertRaisesRegex(ValueError, re.escape("Illegal Move, a Piece cannot move to the same Square it currently occupies, got B2 to B2")):
            Move.from_uci("b2b2")
        with self.assertRaisesRegex(ValueError, re.escape("Illegal Move, H8 to H8 is not a legal Pawn move and cannot be a promotion")):
            Move.from_uci("h8h8r")
        with self.assertRaisesRegex(ValueError, re.escape("Illegal Move, A1 to F7 is illegal for every Piece")):
            Move.from_uci("a1f7")

    def test_invalid(self):
        with self.assertRaisesRegex(ValueError, re.escape("Invalid UCI: UCI must be at least 4 characters long, got 'a'")):
            Move.from_uci("a")
        with self.assertRaisesRegex(ValueError, re.escape("Invalid UCI: A Null move is specified as only '0000', got '0000a'")):
            Move.from_uci("0000a")
        with self.assertRaisesRegex(ValueError, re.escape("Cannot promote to a King, got 'e7e8k'")):
            Move.from_uci("e7e8k")
        with self.assertRaisesRegex(ValueError, re.escape("Cannot promote to a Pawn, got 'e7e8p'")):
            Move.from_uci("e7e8p")
        with self.assertRaisesRegex(ValueError, re.escape("Invalid UCI: Unrecognized promote-to character c in 'e7e8c'")):
            Move.from_uci("e7e8c")
        with self.assertRaisesRegex(ValueError, re.escape("Invalid UCI: Given string is too long, expected at most 5 characters, got 'a2a3a4'")):
            Move.from_uci("a2a3a4")

if __name__ == "__main__":
    unittest.main()
