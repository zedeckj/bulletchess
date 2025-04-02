import unittest
import sys
sys.path.append("./")
from bulletchess import *




class TestIllegalMoves(unittest.TestCase):
    """
    Tests that illegal moves cannot be generated or applied
    """

    def assertIllegalArgs(self, origin : Any, dest : Any, promote_to : Any, error: str):
        with self.assertRaisesRegex(ValueError, error):
            move = Move(origin, dest, promote_to)

    def testPromotion(self):
       self.assertIllegalArgs(E2, E4, 
            QUEEN, "Invalid promotion Move destination e4, must be a back rank")
       self.assertIllegalArgs(E2, E8, 
            QUEEN, "Invalid promotion Move from e2 to e8, not a legal Pawn move")

       self.assertIllegalArgs(E8, E8, 
            QUEEN, "Invalid promotion Move from e8 to e8, not a legal Pawn move")
        
       self.assertIllegalArgs(E8, E8, 
            KING, "Invalid promotion Move, a Pawn cannot promote to a King")


       self.assertIllegalArgs(E8, E8, 
            PAWN, "Invalid promotion Move, a Pawn cannot promote to a Pawn")


    def testRegular(self):
        self.assertIllegalArgs(A1, B8, None, 
            "Invalid Move from a1 to b8, illegal for every Piece")
        self.assertIllegalArgs(E2, E2, None, 
            "Invalid Move from and to e2, a Piece cannot move "
            "to the same Square it currently occupies")

    def validityPerft(self, board : Board, depth : int):
        if depth == 0:
            return
        else:
            moves = board.legal_moves()
            for move in moves:
                origin = move.origin
                destination = move.destination
                promote_to = move.promotes_to
                move = Move(origin, destination, promote_to)
                board.apply(move)
                self.validityPerft(board, depth -1)
                board.undo()

    def testValid(self):
        with self.assertNoLogs():
            self.validityPerft(Board(), 4)

if __name__ == "__main__":
    unittest.main()
