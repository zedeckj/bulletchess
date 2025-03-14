import sys
sys.path.append("./")
import unittest
import bulletchess
import chess
import testing_utils
import random
import time
from bulletchess import *


class TestApplyMove(unittest.TestCase):


    # def test_apply(self):
    #     COUNT = 1000
    #     chess_boards = [testing_utils.random_chess_board() for _ in range(COUNT)]
    #     bullet_boards = [testing_utils.make_bullet_from_chess(board) for board in chess_boards]
    #     moves = []
    #     for i in range(COUNT):
    #         chs = chess_boards[i]
    #         blt = bullet_boards[i]
    #         moves = list(chs.legal_moves)
    #         if len(moves) == 0:
    #             continue
    #         move = random.choice(moves)
    #         uci = move.uci()
    #         blt_move = bulletchess.Move.from_uci(uci)
    #         original = str(chs)
    #         chs.push(move)
    #         blt.apply(blt_move)
    #         self.assertEqual(chs.fen(en_passant="fen"), blt.fen(), msg = f"TEST {i}, MOVE {uci} BEFORE\n\n{original}\nAFTER\n\n{str(chs)}\n")

    def test_starting(self):
        board = bulletchess.Board.starting()
        reference = bulletchess.Board.starting()
        c_board = chess.Board()
        self.assertEqual(board, reference)
        self.assertEqual(board.fen(), reference.fen())
        board.apply(Move.from_uci("h2h4"))
        reference.remove_piece_at(H2)
        c_board.push(chess.Move.from_uci("h2h4"))
        reference.set_piece_at(H4, Piece.new(PAWN, WHITE))
        reference.set_ep_square(H3)
        reference.set_turn(BLACK)
        self.assertEqual(board, reference)
        self.assertEqual(board.fen(), reference.fen())
        self.assertEqual(len(board.legal_moves()), len(reference.legal_moves()))
        self.assertEqual(len(board.legal_moves()), c_board.legal_moves.count())
        board.apply(Move.from_uci("h7h5"))
        c_board.push(chess.Move.from_uci("h7h5"))
        reference.remove_piece_at(H7)
        reference.set_piece_at(H5, Piece.new(PAWN, BLACK))
        reference.set_ep_square(H6)
        reference.set_turn(WHITE)
        reference.set_fullmove_number(2)
        self.assertEqual(board.fen(), reference.fen())
        self.assertEqual(board, reference)

        self.assertEqual(len(board.legal_moves()), len(reference.legal_moves()))
        self.assertEqual(len(board.legal_moves()), c_board.legal_moves.count())
        self.assertEqual({str(m) for m in board.legal_moves()}, {m.uci() for m in c_board.legal_moves})
        self.assertEqual(board.fen(), c_board.fen(en_passant="fen"))
        c_board.push(chess.Move.from_uci("g1f3"))
        board.apply(Move.from_uci("g1f3"))
        reference.remove_piece_at(G1)
        reference.set_piece_at(F3, Piece.new(KNIGHT, WHITE))
        reference.set_turn(BLACK)
        reference.set_halfmove_clock(1)
        reference.clear_ep_square()
        # bulletchess._debug_print_board(board)
        # bulletchess._debug_print_board(reference)
        self.assertEqual(board.fen(), reference.fen())
        self.assertEqual(board, reference)

        self.assertEqual(len(board.legal_moves()), len(reference.legal_moves()))
        self.assertEqual(len(board.legal_moves()), c_board.legal_moves.count())



if __name__ == "__main__":
    unittest.main()
