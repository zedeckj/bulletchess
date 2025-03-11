from abc import ABC, abstractmethod
from typing import override
import sys
sys.path.append("./")
from bulletchess import Piece, Board, Move, PieceType, WHITE, BLACK, PAWN, KNIGHT, BISHOP, QUEEN, KING, ROOK, clib

from ctypes import * 



class DefaultEngineParameters:


    BLACK_PAWN_TABLE = [
     0,  0,  0,  0,  0,  0,  0,  0,   # Rank 1
    50, 50, 50, 50, 50, 50, 50, 50,   # Rank 2
    10, 10, 20, 40, 40, 20, 10, 10,   # Rank 3
     5,  5, 10, 30, 30, 10,  5,  5,   # Rank 4
     0,  0,  0, 25, 25,  0,  0,  0,   # Rank 5
     5, -5,-10,  0,  0,-10, -5,  5,   # Rank 6
     5, 10, 10,-40,-40, 10, 10,  5,   # Rank 7
     0,  0,  0,  0,  0,  0,  0,  0,   # Rank 8
    ]

    BLACK_KNIGHT_TABLE = [
    -50,-40,-30,-30,-30,-30,-40,-50,   # Rank 1
    -40,-20,  0,  0,  0,  0,-20,-40,   # Rank 2
    -30,  0, 10, 15, 15, 10,  0,-30,   # Rank 3
    -30,  5, 15, 20, 20, 15,  5,-30,   # Rank 4
    -30,  0, 15, 20, 20, 15,  0,-30,   # Rank 5
    -30,  5, 10, 15, 15, 10,  5,-30,   # Rank 6
    -40,-20,  0,  5,  5,  0,-20,-40,   # Rank 7
    -50,-40,-30,-30,-30,-30,-40,-50,   # Rank 8
    ]

    BLACK_BISHOP_TABLE = [
    -20,-10,-10,-10,-10,-10,-10,-20,   # Rank 1
    -10,  0,  0,  0,  0,  0,  0,-10,   # Rank 2
    -10,  0,  5, 10, 10,  5,  0,-10,   # Rank 3
    -10,  5,  5, 10, 10,  5,  5,-10,   # Rank 4
    -10,  0, 10, 10, 10, 10,  0,-10,   # Rank 5
    -10, 10, 10, 10, 10, 10, 10,-10,   # Rank 6
    -10,  5,  0,  0,  0,  0,  5,-10,   # Rank 7
    -20,-10,-10,-10,-10,-10,-10,-20,   # Rank 8
    ]
    
    BLACK_ROOK_TABLE = [
     0,  0,  0,  0,  0,  0,  0,  0,   # Rank 1
     5, 10, 10, 10, 10, 10, 10,  5,   # Rank 2
    -5,  0,  0,  0,  0,  0,  0, -5,   # Rank 3
    -5,  0,  0,  0,  0,  0,  0, -5,   # Rank 4
    -5,  0,  0,  0,  0,  0,  0, -5,   # Rank 5
    -5,  0,  0,  0,  0,  0,  0, -5,   # Rank 6
    -5,  0,  0,  0,  0,  0,  0, -5,   # Rank 7
     0,  0,  0,  5,  5,  0,  0,  0,   # Rank 8
    ]

    BLACK_QUEEN_TABLE = [
    -20,-10,-10, -5, -5,-10,-10,-20,   # Rank 1
    -10,  0,  0,  0,  0,  0,  0,-10,   # Rank 2
    -10,  0,  5,  5,  5,  5,  0,-10,   # Rank 3
     -5,  0,  5,  5,  5,  5,  0, -5,   # Rank 4
      0,  0,  5,  5,  5,  5,  0, -5,   # Rank 5
    -10,  5,  5,  5,  5,  5,  0,-10,   # Rank 6
    -10,  0,  5,  0,  0,  0,  0,-10,   # Rank 7
    -20,-10,-10, -5, -5,-10,-10,-20,   # Rank 8
    ]

    BLACK_KING_MID_TABLE = [
        -30,-40,-40,-50,-50,-40,-40,-30,  # Rank 1
        -30,-40,-40,-50,-50,-40,-40,-30,  # Rank 2
        -30,-40,-40,-50,-50,-40,-40,-30,  # Rank 3
        -30,-40,-40,-50,-50,-40,-40,-30,  # Rank 4
        -20,-30,-30,-40,-40,-30,-30,-20,  # Rank 5
        -10,-20,-20,-20,-20,-20,-20,-10,  # Rank 6
        20, 20,  0,  0,  0,  0, 20, 20,  # Rank 7
        20, 30, 10,  0,  0, 10, 30, 20,  # Rank 8
    ]

    BLACK_KING_END_TABLE = [
        -50,-40,-30,-20,-20,-30,-40,-50,  # Rank 1
        -30,-20,-10,  0,  0,-10,-20,-30,  # Rank 2
        -30,-10, 20, 30, 30, 20,-10,-30,  # Rank 3
        -30,-10, 30, 40, 40, 30,-10,-30,  # Rank 4
        -30,-10, 30, 40, 40, 30,-10,-30,  # Rank 5
        -30,-10, 20, 30, 30, 20,-10,-30,  # Rank 6
        -30,-30,  0,  0,  0,  0,-30,-30,  # Rank 7
        -50,-30,-30,-30,-30,-30,-30,-50,  # Rank 8
    ]

    PAWN_VALUE = 100
    BISHOP_VALUE = 300
    KNIGHT_VALUE = 300
    ROOK_VALUE = 500
    QUEEN_VALUE = 900
    CHECKMATE_VALUE = 20000
    CHECK_VALUE = 30

class EngineParameters(Structure):
    
    _fields_ = [
        ("white_pawn", c_int32 * 64),
        ("white_knight", c_int32 * 64),
        ("white_bishop", c_int32 * 64),
        ("white_rook", c_int32 * 64),
        ("white_queen", c_int32 * 64),
        ("white_king", c_int32 * 64),
        ("white_king_endgame", c_int32 * 64),

        ("black_pawn", c_int32 * 64),
        ("black_knight", c_int32 * 64),
        ("black_bishop", c_int32 * 64),
        ("black_rook", c_int32 * 64),
        ("black_queen", c_int32 * 64),
        ("black_king", c_int32 * 64),
        ("black_king_endgame", c_int32 * 64),

        ("pawn_value", c_int32),
        ("bishop_value", c_int32),
        ("knight_value", c_int32),
        ("rook_value", c_int32),
        ("queen_value", c_int32),

        ("check_value", c_int32),
        ("checkmate_value", c_int32),
    ]

    @staticmethod
    def flip_table(table : list[int]):
        new_table = []
        for square in range(0, 64, 8):
            rank = table[square : square + 8]
            rank.reverse()
            new_table.extend(rank)
        new_table.reverse()
        return new_table

    @staticmethod
    def table_to_array(table : list[int]):
        assert(len(table) == 64)
        return (c_int32 * 64)(*table)

    @staticmethod
    def default() -> "EngineParameters":
        return EngineParameters(
            EngineParameters.table_to_array(EngineParameters.flip_table(DefaultEngineParameters.BLACK_PAWN_TABLE)),
            EngineParameters.table_to_array(EngineParameters.flip_table(DefaultEngineParameters.BLACK_KNIGHT_TABLE)), 
            EngineParameters.table_to_array(EngineParameters.flip_table(DefaultEngineParameters.BLACK_BISHOP_TABLE)), 
            EngineParameters.table_to_array(EngineParameters.flip_table(DefaultEngineParameters.BLACK_ROOK_TABLE)), 
            EngineParameters.table_to_array(EngineParameters.flip_table(DefaultEngineParameters.BLACK_QUEEN_TABLE)), 
            EngineParameters.table_to_array(EngineParameters.flip_table(DefaultEngineParameters.BLACK_KING_MID_TABLE)),
            EngineParameters.table_to_array(EngineParameters.flip_table(DefaultEngineParameters.BLACK_KING_END_TABLE)),
            
            EngineParameters.table_to_array(DefaultEngineParameters.BLACK_PAWN_TABLE),
            EngineParameters.table_to_array(DefaultEngineParameters.BLACK_KNIGHT_TABLE), 
            EngineParameters.table_to_array(DefaultEngineParameters.BLACK_BISHOP_TABLE), 
            EngineParameters.table_to_array(DefaultEngineParameters.BLACK_ROOK_TABLE), 
            EngineParameters.table_to_array(DefaultEngineParameters.BLACK_QUEEN_TABLE), 
            EngineParameters.table_to_array(DefaultEngineParameters.BLACK_KING_MID_TABLE),
            EngineParameters.table_to_array(DefaultEngineParameters.BLACK_KING_END_TABLE),
            
            DefaultEngineParameters.PAWN_VALUE,
            DefaultEngineParameters.BISHOP_VALUE,
            DefaultEngineParameters.KNIGHT_VALUE,
            DefaultEngineParameters.ROOK_VALUE,
            DefaultEngineParameters.QUEEN_VALUE,
        
            DefaultEngineParameters.CHECK_VALUE,
            DefaultEngineParameters.CHECKMATE_VALUE,
    )

        
class SearchResult(Structure):
    _fields_ = [
        ("eval", c_int),
        ("move", Move)
    ]

    

class Engine:

    def __init__(self, parameters : EngineParameters):
        self.parameters = pointer(parameters)
        
    def search(self, board : Board, depth : int) -> tuple[Move, int]:
        if depth < 0:
            raise Exception("Cannot search with <0 depth")
        res = _search(byref(board), self.parameters, c_uint8(depth))
        print(res.move, res.eval)
        return (res.move, int(res.eval))
_search = clib.search_wrapper

_search.argtypes = [POINTER(Board), POINTER(EngineParameters), c_uint8]
_search.restype = SearchResult


