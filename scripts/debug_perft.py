import sys
sys.path.append("./")
from bulletchess import *
import chess

def to_ucis(bullet_moves : list[Move], chess_moves : list[chess.Move]):
    ucis1 = set([move.uci() for move in bullet_moves])
    ucis2 = set([move.uci() for move in bullet_moves])
    if ucis1 != ucis2:
        raise Exception("Moves not the same")
    return ucis1

def assert_boards_eqal(bullet_board : Board, chess_board : chess.Board):
    fen1 = bullet_board.fen()
    fen2 = chess_board.fen(en_passant= "fen")
    if fen1 != fen2:
        raise Exception("Fens not equal")

def debug_perft_inner(bullet_board : Board, 
                chess_board : chess.Board,
                depth : int):
    if depth == 0:
        return 1
    elif depth == 1:
        return utils.count_moves(bullet_board)
    bullet_moves = bullet_board.legal_moves()
    chess_moves = list(chess_board.legal_moves)
    ucis = to_ucis(bullet_moves, chess_moves)
    nodes = 0
    for uci in ucis:
        chess_move = chess.Move.from_uci(uci)
        bullet_move = Move.from_uci(uci)
        bullet_board.apply(bullet_move)
        chess_board.push(chess_move)
        assert_boards_eqal(bullet_board, chess_board)
        nodes += debug_perft_inner(bullet_board, chess_board, depth - 1)
        bullet_board.undo()
        chess_board.pop()
    return nodes



def debug_perft_inner2(bullet_board : Board, unused, depth : int):
    if depth == 0:
        return 1
    #Move(E2, E4)
    nodes = 0
    for move in bullet_board.legal_moves():
        bullet_board.apply(move)
        nodes += debug_perft_inner2(bullet_board, unused, depth - 1)
        bullet_board.undo()
    return nodes

def native_perft(board : Board, depth : int) -> int:
    if depth == 0:
        return 1
    elif depth == 1:
        return utils.count_moves(board)
    else:
        moves = board.legal_moves()
        nodes = 0
        for move in moves:
            board.apply(move)
            nodes += native_perft(board, depth - 1)
            board.undo()
        return nodes 

def debug_perft(fen : str, depth : int):
    return debug_perft_inner2(Board.from_fen(fen), chess.Board(fen), depth)

#  AssertionError: 4204256 != 4085603
print(debug_perft("r3k2r/p1ppqpb1/bn2pnp1/3PN3/1p2P3/2N2Q1p/PPPBBPPP/R3K2R w KQkq - 0 1", 4))
