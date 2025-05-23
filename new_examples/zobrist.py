
from bulletchess import *
import random
from typing import Optional

def random_int64() -> int:
    """
    Generates a random 64 bit integer
    """
    return int(random.randrange(0, (2 ** 64) - 1))


class ZobristHasher:

    """
    Holds dictionaries of 64 bit integer corresponding to possible features of a Board. 
    Creates a hash value for a board by indexing into theses dicts with the boards features,
    and xor-ing the values together
    https://en.wikipedia.org/wiki/Zobrist_hashing
    """


    def __init__(self, piece_square_table : dict[Optional[Piece], dict[Square, int]],
                       castling_table : dict[CastlingType, int],
                       ep_table : dict[Optional[Square], int],
                       turn_table : dict[Color, int]):
        self.piece_square_table = piece_square_table
        self.castling_table = castling_table
        self.ep_table = ep_table
        self.turn_table = turn_table

    @staticmethod
    def random():
        """
        Initializes a ZobristHasher with random values
        """
        pieces : list[Optional[Piece]] = [None]
        for piece_type in PIECE_TYPES:
            for color in [WHITE, BLACK]:
                pieces.append(Piece(color, piece_type))
        
        piece_square_table : dict[Optional[Piece], dict[Square, int]] = {}
        for piece in pieces:
            piece_square_table[piece] = {}
            for square in SQUARES:
                piece_square_table[piece][square] = random_int64()
        
        castling_table : dict[CastlingType, int]= {}
        for castling in [WHITE_KINGSIDE, WHITE_QUEENSIDE, BLACK_KINGSIDE, BLACK_QUEENSIDE]:
            castling_table[castling] = random_int64()
        
        ep_table : dict[Optional[Square], int] = {None : random_int64()}
        for square in SQUARES:
            ep_table[square] = random_int64()
        
        turn_table = {WHITE: random_int64(), BLACK: random_int64()}
        return ZobristHasher(piece_square_table, castling_table, ep_table, turn_table)
        

    def __call__(self, board : Board) -> int:
        """
        Produces a hash value for the given Board
        """
        hash_val = self.turn_table[board.turn]    
        for square in SQUARES:
            hash_val ^= self.piece_square_table[board[square]][square]
        for castling_type in ALL_CASTLING:
            if castling_type in board.castling_rights:
                hash_val ^= self.castling_table[castling_type]
        hash_val ^= self.ep_table[board.en_passant_square]
        return hash_val
    
hasher = ZobristHasher.random()

COUNT = 1000
boards = [utils.random_board() for _ in range(COUNT)]
hashes = {hasher(board) for board in boards}
print(f"{COUNT - len(hashes)} collisions for {COUNT} hashes")
