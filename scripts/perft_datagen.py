"""
Generates reference move count values from chess-python
"""

import json
import chess
import sys
sys.path.append("./")
from bulletchess import *
import tqdm


def gen_fens_random(init_count : int) -> list[str]:
    return [board.fen() for board in set([utils.random_board() for _ in tqdm.tqdm(range(init_count), desc = "Making fens")])]

def get_fens_tree(board : chess.Board, depth : int) -> list[str]:
    fens = [board.fen(en_passant= "fen")]
    if depth == 0:
        return fens
    for move in board.legal_moves:
        board.push(move)
        fens.extend(get_fens_tree(board, depth - 1))
        board.pop()
    return fens

def make_app_dict(fens : list[str]) -> dict[str,dict[str, str]]:
    out = {}
    for fen in tqdm.tqdm(fens):
        board = chess.Board(fen)
        out[fen] = {}
        for move in board.legal_moves:
            board.push(move)
            out[fen][move.uci()] = board.fen(en_passant = "fen")
            board.pop()
    return out

def make_app_tree(board : chess.Board, depth : int) -> dict:
    out = {}
    if depth == 0:
        return out
    fen = board.fen(en_passant="fen")
    out[fen] = {}
    for move in board.legal_moves:
        board.push(move)
        out[fen][move.uci()] = make_app_tree(board, depth - 1)
        board.pop()
    return out

def make_count_dict(fens : list[str]) -> dict[str, int]:
    return {fen:chess.Board(fen).legal_moves.count() for fen in tqdm.tqdm(fens, desc = "Making counts")}

def save_json(count_dict : dict) -> None:
    json.dump(count_dict, open("./new_tests/data/perft_values.json", "w"), indent=3)


def perft(board : chess.Board, depth : int) -> int:
    if depth == 0:
        return 1
    elif depth == 1:
        return board.legal_moves.count()
    else:
        nodes = 0
        for move in board.legal_moves:
            board.push(move)
            nodes += perft(board, depth - 1)
            board.pop()
        return nodes

def perft_node_counts(fens : list[str], max_depth : int) -> dict[str, dict[str,int]]:
    out = {}
    for fen in tqdm.tqdm(fens):
        for depth in range(1, max_depth):
            board = chess.Board(fen)
            out[fen] = {"depth": depth, "nodes": perft(board, depth)}
    return out


save_json(perft_node_counts(gen_fens_random(10000), 3))