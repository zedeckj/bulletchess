import sys
sys.path.append("./")

from bulletchess import *
from collections import Counter

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

@timer_func
def get_results():
    results = Counter()
    with PGNReader.open(FILEPATH) as pgn:
        while True:
            game = pgn.next_game()
            if game == None:
                break
            print("python got", game.result)
            results[game.result] += 1
    return results




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

results = get_results()
print(results)

#fens1 = get_fens_bullet()
#fens2 = get_fens_chess()
