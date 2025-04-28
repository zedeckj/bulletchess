from bulletchess import *

def test():
    board = Board.from_fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
    print(board.fen())
    board2 = Board(2)
test()
