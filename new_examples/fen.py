from bulletchess import *

def make_fen(board : Board) -> str:
    """
    A simple implementation of creating a FEN from a Board.
    This function pretends that Board.fen(), and CastlingRights.fen() dont exist
    """
    rank_strs = []
    for rank in reversed(RANKS):
        empty = 0
        rank_str = ""
        for square in rank:
            piece = board[square]
            if piece:
                if empty:
                    rank_str += str(empty)
                    empty = 0
                rank_str += str(piece)
            else:
                empty += 1
        if empty:
            rank_str += str(empty)
            
        rank_strs.append(rank_str)

    position_str = "/".join(rank_strs)

    turn_str = "w" if board.turn == WHITE else "b"

    castling = board.castling_rights
    if castling:
        castling_str = ""
        if WHITE_KINGSIDE in castling:
            castling_str += "K"
        if WHITE_QUEENSIDE in castling:
            castling_str += "Q"
        if BLACK_KINGSIDE in castling:
            castling_str += "k"
        if BLACK_QUEENSIDE in castling:
            castling_str += "q"
    else:
        castling_str = "-"
    
    ep_square = board.en_passant_square
    ep_str = str(ep_square).lower() if ep_square else "-"

    return f"{position_str} {turn_str} {castling_str} {ep_str} {board.halfmove_clock} {board.fullmove_number}"

boards = [utils.random_board() for _ in range(1000)]
for board in boards:
    assert(make_fen(board) == board.fen())