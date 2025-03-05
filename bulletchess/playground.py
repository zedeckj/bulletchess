import chess
import sys
sys.path.append("./")
import bulletchess
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

moves = bulletchess.Board.starting().pseudo_legal_moves()
ucis = [str(m) for m in moves]
ucis.sort()
print(ucis)