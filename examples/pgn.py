import sys
sys.path.append("./")

from bulletchess import *


FILEPATH = "/Users/jordan/Documents/C/ChessLibrary/tests/pgn/Modern.pgn"

from time import time

def timer_func(func): 
    def wrap_func(*args, **kwargs): 
        t1 = time() 
        result = func(*args, **kwargs) 
        t2 = time() 
        print(f'Function {func.__name__!r} executed in {(t2-t1):.4f}s') 
        return result 
    return wrap_func 

@timer_func
def get_fens_bullet():
    fens = set()
    with PGNReader.open(FILEPATH) as pgn:
        while True:
            game = pgn.next_game()
            if game == None:
                break
            board = Board()
            moves = game.moves()
            for m in moves:
                fens.add(board.fen())
                board.apply(m)
    return fens

import chess.pgn

@timer_func
def get_fens_chess():
    fens = set()
    with open(FILEPATH, encoding="utf-8", errors = "ignore") as pgn:
        while True:
            game = chess.pgn.read_game(pgn)
            if game == None:
                break
            moves = game.mainline_moves()
            board = chess.Board()
            for m in moves:
                fens.add(board.fen(en_passant = "fen"))
                board.push(m)
    return fens


fens1 = get_fens_bullet()
fens2 = get_fens_chess()

for fen in fens1:
    assert(fen in fens2)

for fen in fens2:
    assert(fen in fens1)
