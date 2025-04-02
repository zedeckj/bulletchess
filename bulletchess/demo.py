import sys
sys.path.append("./")

from bulletchess import *
MIN = -20000
MAX =  20000

def evaluate(board : Board) -> int:
    return board.evaluate()
    """ 
    if board.is_checkmate():
        return MIN if board.turn == WHITE else MAX
    elif board.is_draw():
        return 0
    return (
        900 * board.net_piece_type(QUEEN) +
        500 * board.net_piece_type(ROOK) +
        300 * board.net_piece_type(BISHOP) +
        300 * board.net_piece_type(KNIGHT) +
        100 * board.net_piece_type(PAWN) +
        50 * (board.net_backwards_pawns() + 
              board.net_doubled_pawns() +
              board.net_isolated_pawns()) +
        10 * board.net_mobility()
    )
    """

def maxi(board : Board, depth : int, 
         alpha : int = MIN, beta : int = MAX) -> tuple[int, Optional[Move]]:
    if depth == 0:
        return evaluate(board), None
    else:
        moves = board.legal_moves()
        if len(moves) == 0:
            return evaluate(board), None
        best_move = None
        best_eval = MIN
        for move in moves:
            board.apply(move)
            this_eval, _ = mini(board, depth - 1, alpha, beta)
            board.undo()
            if this_eval > best_eval:
                best_eval = this_eval
                best_move = move
            if this_eval > beta:
                break
            if this_eval > alpha:
                alpha = this_eval
        return (best_eval, best_move)


def mini(board : Board, depth : int, 
         alpha : int = MIN, beta : int = MAX) -> tuple[int, Optional[Move]]:
    if depth == 0:
        return evaluate(board), None
    else:
        moves = board.legal_moves()
        if len(moves) == 0:
            return evaluate(board), None
        best_move = None
        best_eval = MAX
        for move in moves:
            board.apply(move)
            this_eval, _ = maxi(board, depth - 1, alpha, beta)
            board.undo()
            if this_eval < best_eval:
                best_eval = this_eval
                best_move = move
            if this_eval < alpha:
                break

            if this_eval < beta:
                beta = this_eval
        return (best_eval, best_move) 


def best_move(board : Board, depth : int) -> Move:
    bound = evaluate(board)
    if board.turn == WHITE:
        e, move = maxi(board, depth)
    else:
        e, move = mini(board, depth)
    print(e, move)
    if move == None:
        raise Exception("oops")
    return move

if __name__ == "__main__":
    fen = "2b1k1nr/5ppp/2np2q1/rpb1p1B1/p3P3/3P1N2/PPP1QPPP/R4RK1 w k - 0 15"
    board = Board.from_fen(fen)
    print(best_move(board, 5))
