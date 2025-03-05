import unittest
import sys
sys.path.append("./")
import bulletchess
from bulletchess import (
    Board, Piece, WHITE, BLACK, SQUARES, 
    PAWN, KNIGHT, BISHOP, ROOK, QUEEN, KING
)

class TestBoard(unittest.TestCase):

    def testEmpty(self):
        empty_board = Board.empty()
        for square in bulletchess.SQUARES:
            self.assertEqual(empty_board.piece_at(square), None)
        self.assertFalse(empty_board.has_castling_rights(WHITE))
        self.assertFalse(empty_board.has_castling_rights(BLACK))

    def testStarting(self):
        board = Board.starting()
        expected = {
            bulletchess.A1: "R",
            bulletchess.B1: "N",
            bulletchess.C1: "B",
            bulletchess.D1: "Q",
            bulletchess.E1: "K",
            bulletchess.F1: "B",
            bulletchess.G1: "N",
            bulletchess.H1: "R",

            bulletchess.A2: "P",
            bulletchess.B2: "P",
            bulletchess.C2: "P",
            bulletchess.D2: "P",
            bulletchess.E2: "P",
            bulletchess.F2: "P",
            bulletchess.G2: "P",
            bulletchess.H2: "P",

            bulletchess.A7: "p",
            bulletchess.B7: "p",
            bulletchess.C7: "p",
            bulletchess.D7: "p",
            bulletchess.E7: "p",
            bulletchess.F7: "p",
            bulletchess.G7: "p",
            bulletchess.H7: "p",

            bulletchess.A8: "r",
            bulletchess.B8: "n",
            bulletchess.C8: "b",
            bulletchess.D8: "q",
            bulletchess.E8: "k",
            bulletchess.F8: "b",
            bulletchess.G8: "n",
            bulletchess.H8: "r"
        }
        for square in bulletchess.SQUARES:
            if square not in expected:
                self.assertEqual(board.piece_at(square), None)
            else:
                self.assertEqual(str(board.piece_at(square)), expected[square])
        self.assertTrue(board.has_castling_rights(WHITE))
        self.assertTrue(board.has_castling_rights(BLACK))


    def testCastlingRights(self):
        board = Board.starting()
        board.clear_castling_rights(WHITE)
        self.assertFalse(board.has_castling_rights(WHITE))
        self.assertTrue(board.has_castling_rights(BLACK))
        board.clear_castling_rights(BLACK)
        self.assertFalse(board.has_castling_rights(WHITE))
        self.assertFalse(board.has_castling_rights(BLACK))
        board.set_full_castling_rights()
        self.assertTrue(board.has_castling_rights(WHITE))
        self.assertTrue(board.has_castling_rights(BLACK))
        
    def testSetPiece(self):
        to_set = {
            bulletchess.A4 : Piece.new(BISHOP, WHITE),
            bulletchess.H1 : Piece.new(ROOK, BLACK),
            bulletchess.B3 : Piece.new(PAWN,WHITE),
            bulletchess.C8 : Piece.new(QUEEN, BLACK),
        }
        board = Board.empty()
        for square in to_set:
            board.set_piece_at(square, to_set[square])
        for square in SQUARES:
            if square not in to_set:
                self.assertEqual(board.piece_at(square), None)
            else:
                self.assertEqual(board.piece_at(square), to_set[square])

    def testCastlingUpdate(self):
        board = Board.starting()

        # Castling should be legal in starting position
        board.update_castling_rights(WHITE)
        board.update_castling_rights(BLACK)
        self.assertTrue(board.has_castling_rights(WHITE))
        self.assertTrue(board.has_castling_rights(BLACK))
        
        # White should lose queenside
        board.remove_piece_at(bulletchess.A1)
        self.assertTrue(board.has_queenside_castling_rights(WHITE))
        board.update_castling_rights(WHITE)     
        self.assertFalse(board.has_queenside_castling_rights(WHITE))
        self.assertTrue(board.has_kingside_castling_rights(WHITE))
        self.assertTrue(board.has_queenside_castling_rights(BLACK))
        self.assertTrue(board.has_kingside_castling_rights(BLACK))

        # White should lose kingside
        board.remove_piece_at(bulletchess.H1)
        board.update_castling_rights(WHITE)     
        self.assertFalse(board.has_queenside_castling_rights(WHITE))
        self.assertFalse(board.has_kingside_castling_rights(WHITE))
        self.assertTrue(board.has_queenside_castling_rights(BLACK))
        self.assertTrue(board.has_kingside_castling_rights(BLACK))

        # Black should lose queenside
        board.remove_piece_at(bulletchess.A8)
        board.update_castling_rights(BLACK)     
        self.assertFalse(board.has_queenside_castling_rights(WHITE))
        self.assertFalse(board.has_kingside_castling_rights(WHITE))
        self.assertFalse(board.has_queenside_castling_rights(BLACK))
        self.assertTrue(board.has_kingside_castling_rights(BLACK))     

        # Black should lose kingside
        board.remove_piece_at(bulletchess.H8)
        board.update_castling_rights(BLACK)     
        self.assertFalse(board.has_queenside_castling_rights(WHITE))
        self.assertFalse(board.has_kingside_castling_rights(WHITE))
        self.assertFalse(board.has_queenside_castling_rights(BLACK))
        self.assertFalse(board.has_kingside_castling_rights(BLACK))     

        board = Board.starting()
        board.remove_piece_at(bulletchess.E1)
        board.set_piece_at(bulletchess.E5, Piece.new(KING, WHITE))
        board.update_castling_rights(WHITE)   
        self.assertFalse(board.has_castling_rights(WHITE))
        self.assertTrue(board.has_castling_rights(BLACK))

        board = Board.starting()
        board.remove_piece_at(bulletchess.E8)
        board.set_piece_at(bulletchess.E3, Piece.new(KING, BLACK))
        board.update_castling_rights(BLACK)   
        self.assertTrue(board.has_castling_rights(WHITE))
        self.assertFalse(board.has_castling_rights(BLACK))

    def testEquality(self):
        empty = Board.empty()
        starting = Board.starting()
        self.assertEqual(empty, empty)
        self.assertEqual(empty, Board.empty())
        self.assertNotEqual(empty, starting)
        self.assertEqual(starting, Board.starting())
        
        board1 = starting
        board2 = Board.starting()
        board1.set_turn(BLACK)
        self.assertNotEqual(board1, board2)
        board2.set_turn(BLACK)
        self.assertEqual(board1, board2)

    def testEpSquare(self):
        empty = Board.empty()
        self.assertEqual(empty.get_ep_square(), None)
        empty.set_ep_square(bulletchess.C3)
        self.assertEqual(empty.get_ep_square(), bulletchess.C3)
        self.assertEqual(empty.get_ep_square(), 18)
        empty.clear_ep_square()
        self.assertEqual(empty.get_ep_square(), None)

    def testTurn(self):
        board = Board.starting()
        self.assertEqual(WHITE, board.get_turn())
        board.set_turn(BLACK)
        self.assertEqual(BLACK, board.get_turn())
        

    def testAddCastling(self):
        empty = Board.empty()
        empty.add_castling_rights(WHITE, True)
        self.assertTrue(empty.has_kingside_castling_rights(WHITE))
        self.assertFalse(empty.has_queenside_castling_rights(WHITE))
        self.assertFalse(empty.has_kingside_castling_rights(BLACK))
        self.assertFalse(empty.has_queenside_castling_rights(BLACK))

        empty.add_castling_rights(BLACK, True)
        self.assertTrue(empty.has_kingside_castling_rights(WHITE))
        self.assertFalse(empty.has_queenside_castling_rights(WHITE))
        self.assertTrue(empty.has_kingside_castling_rights(BLACK))
        self.assertFalse(empty.has_queenside_castling_rights(BLACK))
    
        empty.add_castling_rights(WHITE, False)
        self.assertTrue(empty.has_kingside_castling_rights(WHITE))
        self.assertTrue(empty.has_queenside_castling_rights(WHITE))
        self.assertTrue(empty.has_kingside_castling_rights(BLACK))
        self.assertFalse(empty.has_queenside_castling_rights(BLACK))

        empty.add_castling_rights(BLACK, False)
        self.assertTrue(empty.has_kingside_castling_rights(WHITE))
        self.assertTrue(empty.has_queenside_castling_rights(WHITE))
        self.assertTrue(empty.has_kingside_castling_rights(BLACK))
        self.assertTrue(empty.has_queenside_castling_rights(BLACK))
        

if __name__ == "__main__":
    unittest.main()