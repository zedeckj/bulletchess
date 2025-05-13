import sys
sys.path.append("./")

from bulletchess import Board, utils

# ----- 1. create the same position you use in the failing test
FEN =  "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"   # <-- replace
FEN1 = "r4rk1/1pp1qppp/p1np1n2/2b1p1B1/2B1P1b1/P1NP1N2/1PP1QPPP/R4RK1 w - - 0 10 "   # <-- replace
board = Board.from_fen(FEN)
COUNT = 3
print("Original board.fen():", board.fen())
print("utils.perft(original, 2) =", utils.perft(board, COUNT))

# ----- 2. serialize to FEN and reconstruct
roundtrip = Board.from_fen(board.fen())
print("\nRound-tripped board.fen():", roundtrip.fen())
print("utils.perft(roundtrip, 2) =", utils.perft(roundtrip, COUNT))

# ----- 3. board.copy()
copy = board.copy()
print("\nCopy board.fen():", copy.fen())
print("utils.perft(copy, 2)      =", utils.perft(copy, COUNT))
print("\nCopy board.fen() 2:", copy.fen())

# ----- 4. show the pieces/flags C perft relies on
for b, tag in [(board,      "original"),
               (roundtrip,  "roundtrip"),
               (copy,       "copy")]:
    print(f"\n=== {tag} ===")
    print("castling_rights  :", b.castling_rights)
    print("en_passant_square:", b.en_passant_square)
    print("halfmove_clock   :", b.halfmove_clock)
    print("fullmove_number  :", b.fullmove_number)


