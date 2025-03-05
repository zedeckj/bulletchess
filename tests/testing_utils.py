import chess
import sys
from typing import Optional
sys.path.append("./")
import bulletchess


def to_bullet_piece(piece : Optional[chess.Piece]):
    if piece == None:
        return None
    else:
        if piece.color == chess.WHITE:
            color = bulletchess.WHITE
        else:
            color = bulletchess.BLACK
        match piece.piece_type:
            case chess.PAWN:
                piece_type = bulletchess.PAWN
            case chess.KNIGHT:
                piece_type = bulletchess.KNIGHT
            case chess.BISHOP:
                piece_type = bulletchess.BISHOP
            case chess.ROOK:
                piece_type = bulletchess.ROOK
            case chess.QUEEN:
                piece_type = bulletchess.QUEEN
            case chess.KING:
                piece_type = bulletchess.KING
        return bulletchess.Piece.new(piece_type, color)
    

def make_bullet_from_chess(copy_from : chess.Board):
    board = bulletchess.Board.empty()
    # board.set_turn(bulletchess.WHITE if copy_from.turn == chess.WHITE else bulletchess.BLACK)
    for i in range(64):
        piece = to_bullet_piece(copy_from.piece_at(i))
        board.set_piece_at(i, piece)
    if copy_from.has_kingside_castling_rights(chess.WHITE):
        board.add_castling_rights(bulletchess.WHITE, True)

    if copy_from.has_kingside_castling_rights(chess.BLACK):
        board.add_castling_rights(bulletchess.BLACK, True)

    if copy_from.has_queenside_castling_rights(chess.WHITE):
        board.add_castling_rights(bulletchess.WHITE, False)

    if copy_from.has_queenside_castling_rights(chess.BLACK):
        board.add_castling_rights(bulletchess.BLACK, False)

    if copy_from.ep_square != None:
        board.set_ep_square(copy_from.ep_square)
    board.set_fullmove_number(copy_from.fullmove_number)
    board.set_halfmove_clock(copy_from.halfmove_clock)
    board.set_turn(bulletchess.WHITE if copy_from.turn == chess.WHITE else bulletchess.BLACK)
    return board

import random

def random_chess_board():
    board = chess.Board()
    plys = random.randint(2, 100)
    for i in range(plys):
        moves = list(board.legal_moves)
        if len(moves) == 0:
            return board
        board.push(random.choice(moves))
    return board

import unittest

class TestUtils(unittest.TestCase):

    def testChessToBullet(self):
        bullet = bulletchess.Board.starting()
        chess_board = chess.Board()
        self.assertEqual(bullet, make_bullet_from_chess(chess_board))

        bullet.set_turn(bulletchess.BLACK)
        chess_board.turn = chess.BLACK
        self.assertEqual(bullet, make_bullet_from_chess(chess_board))

        bullet.clear_castling_rights(bulletchess.WHITE)
        chess_board.set_castling_fen("KQ")
        self.assertEqual(bullet, make_bullet_from_chess(chess_board))


if __name__ == "__main__":
    unittest.main()