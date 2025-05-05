import sys
sys.path.append("./")
from bulletchess import *
from bulletchess.pgn import *
from typing import Optional

class ZobristHasher:

    def __init__(self, piece_square_table : dict[Optional[Piece], dict[Square, int]],
                       castling_table : dict[CastlingType, int],
                       ep_table : dict[Optional[Square], int],
                       turn_table : dict[Color, int]):
        self.piece_square_table = piece_square_table
        self.castling_table = castling_table
        self.ep_table = ep_table
        self.turn_table = turn_table

    def hash_board(self, board : Board):
        hash_val : int = self.turn_table[board.turn]
        for square in SQUARES:
            hash_val ^= self.piece_square_table[board[square]][square]
        for castling_type in [WHITE_KINGSIDE, WHITE_QUEENSIDE, BLACK_KINGSIDE, BLACK_QUEENSIDE]:
            if castling_type in board.castling_rights:
                hash_val ^= self.castling_table[castling_type]
        hash_val ^= self.ep_table[board.en_passant_square]


def get_boards():
    boards = []
    with PGNFile.open("hashing/lichess_db_standard_rated_2013-01.pgn") as f:
        while True:
            game = f.next_game()
            if game is None:
                break
            these_boards = [Board()]
            board = Board()
            for move in game.moves:
                board.apply(move)
                boards.append(board.copy())
    return boards

boards = get_boards()
print(boards)