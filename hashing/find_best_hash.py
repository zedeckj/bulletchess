import sys
sys.path.append("./")
from bulletchess import *
from bulletchess.pgn import *
from typing import Optional
import json
import random


def optional_piece_str(string : str) -> Optional[Piece]:
    if string == "None":
        return None
    return Piece.from_str(string)

def optional_square_str(string : str) -> Optional[Square]:
    if string == "None":
        return None
    return Square.from_str(string)

def random_int64() -> int:
    return random.randrange(0, (2 ** 64) - 1)

def random_int60() -> int:
    return random.randrange(0, (2 ** 60) - 1)

class ZobristHasher:

    def __init__(self, piece_square_table : dict[Piece, dict[Square, int]],
                       castling_table : dict[CastlingType, int],
                       ep_table : dict[Square, int],
                       turn_table : dict[Color, int],
                       half_coeff : int, full_coeff : int):
        self.piece_square_table = piece_square_table
        self.castling_table = castling_table
        self.ep_table = ep_table
        self.turn_table = turn_table
        self.half_coeff = half_coeff
        self.full_coeff = full_coeff


    @staticmethod
    def random():
        pieces = []
        piece_square_table : dict[Piece, dict[Square, int]] = {}
        for piece_type in PIECE_TYPES:
            for color in [WHITE, BLACK]:
                pieces.append(Piece(color, piece_type))
        for piece in pieces:
            piece_square_table[piece] = {}
            for square in SQUARES:
                piece_square_table[piece][square] = random_int64()

        castling_table : dict[CastlingType, int]= {}
        for castling in [WHITE_KINGSIDE, WHITE_QUEENSIDE, BLACK_KINGSIDE, BLACK_QUEENSIDE]:
            castling_table[castling] = random_int64()
        

        ep_table : dict[Square, int] = {}
        for square in SQUARES:
            ep_table[square] = random_int64()

        turn_table = {WHITE: random_int64(), BLACK: random_int64()}
        half_coeff = random_int60()
        full_coeff = random_int60()
        return ZobristHasher(piece_square_table, castling_table, ep_table, turn_table, half_coeff, full_coeff)
        

    def hash_board(self, board : Board) -> int:
        hash_val = self.turn_table[board.turn]    
        for square in SQUARES:
            piece = board[square]
            if piece != None:
                hash_val ^= self.piece_square_table[piece][square]
        for castling_type in [WHITE_KINGSIDE, WHITE_QUEENSIDE, BLACK_KINGSIDE, BLACK_QUEENSIDE]:
            if castling_type in board.castling_rights:
                hash_val ^= self.castling_table[castling_type]
        ep_square = board.en_passant_square
        if ep_square != None:
            hash_val ^= self.ep_table[ep_square]
        hash_val ^= self.half_coeff * board.halfmove_clock
        hash_val ^= self.full_coeff * board.fullmove_number
        return hash_val

    def serialize(self):
        PST = "piece_square_table"
        EPT = "ep_table"
        CT = "castling_table"
        TT = "turn_table"
        out = {}
        out[PST] = {str(piece) : {str(square):num for square,num in d.items()} 
                    for piece, d in self.piece_square_table.items()}
        out[CT] = {str(ct) : num for ct,num in self.castling_table.items()}
        out[EPT] = {str(sq):num for sq,num in self.ep_table.items()}
        out[TT] = {str(color):num for color,num in self.turn_table.items()}
        return out
    
def make_fens():
    boards = []
    with PGNFile.open("hashing/lichess_db_standard_rated_2013-01.pgn") as f:
        while True:
            game = f.next_game()
            if game is None:
                break
            boards.append(game.starting_board)
            board = game.starting_board
            for move in game.moves:
                board.apply(move)
                boards.append(board.copy())
    boards = set(boards)
    fens = [board.fen() for board in boards]
    json.dump(fens, open("real_fens.json", "w"), indent=2)

def load_boards():
    with open("hashing/real_fens.json") as f:
        fens = json.load(f)
    boards = list(set([Board.from_fen(fen) for fen in fens]))
    return boards


print("getting fens")
boards = load_boards()

"""
least_collisions = len(boards)
print("runnin")
for i in range(10000):
    hasher = ZobristHasher.random()
    # hashed = [hasher.hash_board(board) for board in boards]
    # hashed_set = set(hashed)
    print(len(set([hash(board) for board in boards]))/len(boards))
    # "hash 1:", hashed[0], list(hashed_set)[0])
    # collisions = len(boards) - len(set(hashed))
    # print(f"Got {collisions} collisions")
    # if collisions < least_collisions:
    #     print(f"Saving")
    #    json.dump(hasher.serialize(), open("hashing/hasher.json", "w"))
    #     least_collisions = collisions
"""

hash_dict = {}
for board in boards:
    hashed = hash(board) 
    if hashed in hash_dict:
        hash_dict[hashed].append(board)
    else:
        hash_dict[hashed] = [board]

for hashed in hash_dict:
    if len(hash_dict[hashed]) > 1:
        print(hash_dict[hashed])

    
# rnbq1rk1/ppp1bppp/4pn2/1PPp4/P2P4/8/4PPPP/RNBQKBNR b KQ - 0 6
# rnbq1rk1/ppp1bppp/4pn2/1PPp4/P2P4/8/4PPPP/RNBQKBNR b KQ a3 0 6
