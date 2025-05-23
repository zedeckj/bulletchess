import sys
sys.path.append("./")

from bulletchess import *
MIN = -20000
MAX =  20000

def evaluate(board : Board) -> int:
    
    if board.status.checkmate:
        return MIN if board.turn == WHITE else MAX
    elif board.status.claim_draw:
        return 0
    return (
        900 * utilsf.net_piece_type(board, QUEEN) +
        500 * utilsf.net_piece_type(board, ROOK) +
        300 * utilsf.net_piece_type(board, BISHOP) +
        300 * utilsf.net_piece_type(board, KNIGHT) +
        100 * utilsf.net_piece_type(board, PAWN) +
        50 * (utilsf.net_backwards_pawns(board) + 
              utilsf.net_doubled_pawns(board) +
              utilsf.net_isolated_pawns(board)) +
        10 * utilsf.net_mobility(board)
    )

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
