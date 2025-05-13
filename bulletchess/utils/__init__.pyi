
from bulletchess.main import *
from typing import Optional

def count_moves(board : Board) -> int: 
    """
    Counts the number of legal moves that could be performed, without actually
    constructing the Move objects. This is much faster than doing 
    `len(Board.legal_moves())`
    """
    ...

def set_random_seed(seed : Optional[int]) -> None:
    ...

"""
def material(board : Board,
             pawn_value : int = 100,
             bishop_value : int = 300,
             knight_value : int = 300,
             rook_value : int = 500,
             queen_value : int = 900) -> int:

    Calculates the net material value on the provided Board. By default,
    uses the standard evaluations of each PieceType measured in centipawns.
    """
    #

"""
def shannon(board : Board):

    A simple heuristic function for the utility of a Board
    based on Claude Shannon's † example evaluation function.
    This implementation differs in using centipawns instead of fractional values,
    and explicitly evaluates positions which can be claimed as a draw as 0.
    The number of Kings is reconsidered as whether or not a player is in Checkmate. 

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

    † Shannon, C. E. (1950). XXII. Programming a computer for playing chess. The London, 
    Edinburgh, and Dublin Philosophical Magazine and Journal of Science, 41(314), 256–27    
    5. https://doi.org/10.1080/14786445008521796
"""
    #

def is_quiescent(board : Board) -> bool:
    """
    Determines if the given Board's position is 'quiescent', meaning that there are 
    no possible captures that could be made on this turn.
    """
    #

def perft(board : Board, depth: int) -> int:
    """
    Performs a tree walk of legal moves starting from the provided Board, 
    and returns the number of leaf nodes at the given depth. For more information, 
    see: https://www.chessprogramming.org/Perft
    """
    #

def perft_fen(fen : str, depth : int) -> int: ...

def backwards_pawns(board : Board) -> Bitboard: ...
def isolated_pawns(board : Board) -> Bitboard: ...
def doubled_pawns(board : Board) -> Bitboard: ...

def reset_hashing() -> None: ...

def attack_mask(board : Board, attacker : Color) -> Bitboard: ...
def pinned_mask(board : Board, on_square : Square) -> Bitboard: ...

#def checkers(board : Board) -> Bitboard: ...
#def net_mobility(board : Board) -> int: ...
#def trapped_mask(board : Board) -> Bitboard: ...
#def open_files(board : Board) -> Bitboard: ...
#def hanging_mask(board : Board) -> Bitboard: ...

    

__all__ = [
    "count_moves",
]