from bulletchess import *
import backend as _backend 

def evaluate(board : Board) -> int:
    """
    A simple heuristic function for the utility of a Board
    based on Claude Shannon's † example evaluation function.
    This implementation differs in using centipawns instead of fractional values,
    and explicitly evaluates positions which can be claimed as a draw as 0.

    ```
    f(P) = 200(K-K') + 9(Q-Q') + 5(R-R') + 3(B-B'+N-N') + (P-P') -
        0.5(D-D'+S-S'+I-I') + 0.1(M-M') ...
    in which: -
    (1) K,Q,R,B,B,P are the number of White kings, queens, rooks, bishops, knights
    and pawns on the board.
    (2) D,S,I are doubled, backward and isolated White pawns.
    (3) M= White mobility (measured, say, as the number of legal moves available to
    White).
    
    Primed letters are the similar quantities for Black.
    ```

    † Shannon, C. E. (1950). XXII. Programming a computer for playing chess. The London,    Edinburgh, and Dublin Philosophical Magazine and Journal of Science, 41(314), 256–27    5. https://doi.org/10.1080/14786445008521796

    """
    ln = len(self.__undoable_stack)
    moves_array = (_backend.UNDOABLE_MOVE * ln)(*self.__undoable_stack)
    return int(_backend.shannon_evaluation(board, moves_array, ln))

def material(board : Board,
             pawn_value : int = 100,
             bishop_value : int = 300,
             knight_value : int = 300,
             rook_value : int = 500,
             queen_value : int = 900) -> int:
    """
    Calculates the net material value on the provided Board. By default,
    uses the standard evaluations of each PieceType measured in centipawns.
    """


def pinned_mask(board : Board, origin : Square) -> Bitboard:
    """
    A `pinned mask` represents the destination Squares a Piece can move from
    without putting its own King in check. This method gets the pinned mask 
    corresponding to the given square.
    """
    return Bitboard(int(_backend.ext_get_pinned_mask(
                    board, origin.value)))

def attack_mask(board : Board) -> Bitboard:
    """
    An `attack mask` is a Bitboard representing all Squares the opposing color of 
    the Player to move is attacking with a Piece, such that the current
    player would be in check if their King was on one of these Squares.
    """
    return Bitboard(int(_backend.ext_get_attack_mask(board)))



def is_quiescent(board : Board) -> bool:
    """
    Determines if the given Board's position is 'quiescent', meaning that there are 
    no possible captures that could be made on this turn.
    """
    return bool(_backend.is_quiescent(board))



def count_moves(board : Board) -> int:
    """
    Counts the number of legal moves that could be performed, without actually
    constructing the Move objects. This is much faster than doing 
    `len(Board.legal_moves())`
    """
    return int(_backend.count_moves(board))


def count_piece(board : Board, piece : Optional[Piece]) -> int:
    """
    Returns the number of Pieces on the given Board that match the specified Piece.
    If given None, counts the number of empty squares on the given Board.
    """
    return _backend.countpiece(board, PIECE_INDEXES[piece])

def count_color(board : Board, color : Color) -> int:
    """
    Counts the number of Pieces on the given board with the provided Color.
    """
    return _backend.count_color(board, color.value)

def count_piece_type(board : Board, piece_type : PieceType) -> int:
    """
    Counts the number of Pieces on the given Board that are of the provided
    PieceType.
    """
    return _backend.count_piece_type(board, piece_type.value)


def count_backwards_pawns(board : Board, color : Color) -> int:
    """
    Counts the number of backwards Pawns of the given color in the 
    provided Board's position. 
    TODO: DEFINE
    """
    return _backend.count_backwards_pawns(board, color.value)

def count_doubled_pawns(board : Board, color : Color) -> int:
    """
    Counts the number of doubled Pawns of the given color in the provided
    Board's position. A Pawn is considered to be "doubled" if there is 
    a friendly Pawn in its File with in a higher Rank. 
    """
    return _backend.count_doubled_pawns(board, color.value)

def count_isolated_pawns(board : Board, color : Color) -> int:
    """
    Count's the number of isolated Pawns of the given color in the provided
    Board's position. A Pawn is considered to be "isolated" if there are
    no friendly pawns in the Files adjacent to it. 
    """
    return _backend.count_isolated_pawns(board, color.value)


def net_backwards_pawns(board : Board) -> int:
    return _backend.net_backwards_pawns(board)

def net_doubled_pawns(board : Board) -> int:
    return _backend.net_doubled_pawns(board)

def net_isolated_pawns(board : Board) -> int:
    return _backend.net_isolated_pawns(board)

def net_mobility(board : Board) -> int:
    return _backend.net_mobility(board)

def net_piece_type(board : Board, piece_type : PieceType) -> int:
    return _backend.net_piece_type(board, piece_type.value)


def perft(board : Board, depth: int) -> int:
    """
    Performs a tree walk of legal moves starting from the provided Board, 
    and returns the number of leaf nodes at the given depth. For more information, 
    see: https://www.chessprogramming.org/Perft
    """
    if depth < 0:
        raise ValueError("Cannot perform perft with a negative depth")
    if depth > 255:
        raise ValueError("Cannot perform perft with a value > 255, this would take longer than the heat death of the Universe")
    return _backend.perft(board, depth)



