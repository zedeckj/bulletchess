import chess
import sys
sys.path.append("./")
import bulletchess
from ctypes import *
from bulletchess import *
# board = chess.Board()

# def print_decl_str(name : str, bitboard : int) -> str:
#     print(f"{name.upper()}_STARTING = Bitboard({bitboard})")

# print_decl_str("pawns", board.pawns)
# print_decl_str("knights", board.knights)
# print_decl_str("bishops", board.bishops)
# print_decl_str("rooks", board.rooks)
# print_decl_str("queens", board.queens)
# print_decl_str("kings", board.kings)
# print_decl_str("white", board.occupied_co[chess.WHITE])
# print_decl_str("black", board.occupied_co[chess.BLACK])

# CHECK FENS
# 1r2kb2/2p1p1rn/p7/1q2Pbp1/P1pP1p1P/B1Pn1P1P/4N3/N1R1K1RQ w - - 3 42
# 4r2n/ppp5/4k3/2Pb2n1/P2pB1pP/3P4/R1q5/2BK2R1 w - - 10 48

# CHECKMATE FENS
# 6qr/1b2n1bp/r1kQp2n/ppP5/PP3p2/N1P1PP1P/6PR/R3KBN1 b - - 0 24

# EN PASSANT CHECK EVASION
# 3R4/rbpnb3/4p2q/ppr2k1p/P3Pp2/RP3NR1/K7/1N3B2 b - e3 0 45
# 2bk4/5r2/2p5/1pPpB1p1/4KbP1/2p1P3/3N2B1/2R5 w - d6 0 50

fen1 = "2bk4/5r2/2p5/1pPpB1p1/4KbP1/2p1P3/3N2B1/2R5 w - d6 0 50"
fen2 = "3R4/rbpnb3/4p2q/ppr2k1p/P3Pp2/RP3NR1/K7/1N3B2 b - e3 0 45"
fen3 = "rB1n1b1r/3p1k1p/pp1P4/P4pp1/4q3/1n1N1b1B/1PPQ3P/3RK2R w K - 0 24"
fen4 = "rnbqkbnr/ppp2p2/3pp2p/6p1/Q6P/2P2N2/PP1PPPP1/RNB1KB1R b KQkq - 1 5"
fen5 = "8/8/8/K2Pp2q/8/8/8/7k w - e6 0 1"
fen6 = "8/2p5/3p4/KP5r/1R2Pp1k/8/6P1/8 b - e3 0 1"

def do(FEN):
    board = bulletchess.Board.from_fen(FEN)
    chess_board = chess.Board(FEN)
    our_moves = [str(m) for m in board.legal_moves()]
    print("our moves")
    print(sorted(our_moves))
    print("real moves")
    real_moves = [str(m) for m in chess_board.legal_moves]
    print(sorted(real_moves))
    print(board.in_check())
    print("HALLUCINATED MOVES")
    diff = []
    for move in our_moves:
        if move not in real_moves:
            diff.append(move)
    print(diff)
    print("EXCLUDED MOVES")
    diff = []
    for move in real_moves:
        if move not in our_moves:
            diff.append(move)
    print(diff)
    print(board)



board = Board.starting()
move = Move.from_uci("e8e9")
board.apply(move)
print(board)

Board
#do("rnbq1k1r/pp1Pbppp/2p5/8/2B5/8/PPPNNnPP/R1BQK2R b KQ - 2 8")
