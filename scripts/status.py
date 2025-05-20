import chess
import json
import sys
sys.path.append("./")
from bulletchess import *
import tqdm
import random


def gen_fens_random(init_count : int) -> list[str]:
    return [board.fen() for board in set([Board.random() for _ in tqdm.tqdm(range(init_count), desc = "Making fens")])]


def make_status_dict(fens : list[str]):
    out = {}
    for fen in tqdm.tqdm(fens, desc = "Making status"):
        board = chess.Board(fen)
        if board.is_checkmate():
            out[fen] = "checkmate"
        elif board.is_stalemate():
            out[fen] = "stalemate"
        elif board.is_check():
            out[fen] = "check"
        elif board.is_insufficient_material():
            out[fen] = "insf"
        elif board.is_fifty_moves():
            out[fen] = "50"
        elif board.is_seventyfive_moves():
            out[fen] = "75"
        else:
            if random.random() < 0.5:
                out[fen] = "none"
    return out

def save_json(dic : dict) -> None:
    json.dump(dic, open("./new_tests/data/status.json", "w"), indent=3)


save_json(make_status_dict(gen_fens_random(1000000)))