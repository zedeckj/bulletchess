import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestMoveConstruction(unittest.TestCase):

    def test_construct(self):
        with self.assertNoLogs():
            Move(E2, E4)
            Move(A1, B3, promote_to = None)
            Move(H7, H8, promote_to = QUEEN)

    def test_misuse(self):
        with self.assertRaisesRegex(TypeError, re.escape("function missing required argument 'destination' (pos 2)")):
            Move('foo') #type: ignore
        with self.assertRaisesRegex(TypeError, re.escape("Expected a PieceType or None, got E3 (bulletchess.Square)")):
            Move(E1, E2, promote_to=E3) #type: ignore
        with self.assertRaisesRegex(TypeError, re.escape("Expected a destination Square, got True (bool)")):
            Move(E1, True, promote_to=E3) #type: ignore
        with self.assertRaisesRegex(TypeError, re.escape("Expected an origin Square, got 1 (int)")):
            Move(1, A3, promote_to=E3) #type: ignore

    def test_illegal(self):
        with self.assertRaisesRegex(ValueError, re.escape("Illegal Move, a promotion's destination must be on a back rank, got C4")):
            Move(C3, C4, promote_to = QUEEN)
        with self.assertRaisesRegex(ValueError, re.escape("Illegal Move, H3 to A8 is not a legal Pawn move and cannot be a promotion")):
            Move(H3, A8, promote_to = QUEEN)
        with self.assertRaisesRegex(ValueError, re.escape("Illegal Move, a Piece cannot move to the same Square it currently occupies, got B2 to B2")):
            Move(B2, B2)
        with self.assertRaisesRegex(ValueError, re.escape("Illegal Move, H8 to H8 is not a legal Pawn move and cannot be a promotion")):
            Move(H8, H8, promote_to = ROOK)
        with self.assertRaisesRegex(ValueError, re.escape("Illegal Move, A1 to F7 is illegal for every Piece")):
            Move(A1, F7)
        with self.assertRaisesRegex(ValueError, re.escape("Illegal Move, a Pawn cannot promote to a Pawn")):
            Move(H7, H8, promote_to = PAWN)
        with self.assertRaisesRegex(ValueError, re.escape("Illegal Move, a Pawn cannot promote to a King")):
            Move(H7, H8, promote_to = KING)

    def test_is(self):
        self.assertIs(Move(E2, E4), Move(E2, E4))

if __name__ == "__main__":
    unittest.main()
