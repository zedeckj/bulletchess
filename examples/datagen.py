from bulletchess import *
import json

def make_random_fens(count : int):
    fens = [utils.random_board().fen() for _ in range(count)]
    json.dump(fens, open("fens.json", "w"), indent = 2)

make_random_fens(1000000)
