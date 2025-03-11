import unittest
import sys
sys.path.append("./")
import bulletchess
from bulletchess import (
    Board, Piece, WHITE, BLACK, SQUARES, 
    PAWN, KNIGHT, BISHOP, ROOK, QUEEN, KING
)
from bulletchess.engine import Engine, EngineParameters

def evaluate(engine, board, depth = 0):
    _, e = engine.search(board, depth)
    return e

class TestEngine(unittest.TestCase):

    def testParamters(self):
        params = EngineParameters.default()
        self.assertEqual(params.white_pawn[bulletchess.A1], 0)
        self.assertEqual(params.black_pawn[bulletchess.A2], 50)
        self.assertEqual(params.white_bishop[bulletchess.H8], -20)
        self.assertEqual(params.black_king[bulletchess.E1], -50)
        self.assertEqual(params.black_king[bulletchess.E8], 0)
        self.assertEqual(params.white_pawn[bulletchess.E2], -40)
        self.assertEqual(params.pawn_value, 100)
        self.assertEqual(params.bishop_value, 300)
        self.assertEqual(params.knight_value, 300)
        self.assertEqual(params.rook_value, 500)
        self.assertEqual(params.queen_value, 900)


    def testEvaluate(self):
        engine = Engine(EngineParameters.default())
        board = Board.starting()
        self.assertEqual(evaluate(engine, board), 0)
        board.remove_piece_at(bulletchess.E2)
        self.assertEqual(evaluate(engine, board), -60)
        board.remove.piece.at(bulletchess.E7)
        self.assertEqual(evaluate(engine, board) 0)
        
        
if __name__ == "__main__":
    unittest.main()
 
