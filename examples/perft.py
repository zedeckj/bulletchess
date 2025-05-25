import bulletchess
from bulletchess.utils import count_moves

def perft(board : bulletchess.Board, depth : int) -> int:
    if depth == 0:
        return 1
    elif depth == 1:
        return count_moves(board)
    else:
        nodes = 0
        moves = board.legal_moves()
        for move in moves:
            board.apply(move)
            nodes += perft(board, depth - 1)
            board.undo()
        return nodes 


