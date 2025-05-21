
from bulletchess.main import *
from typing import Optional

def count_moves(board : Board) -> int: 
    """
    Counts the number of legal moves that could be performed for the given :class:`Board`, without actually
    constructing any :class:`Move` objects. This is much faster than calling 
    `len(Board.legal_moves())`
    """
    ...

def set_random_seed(seed : Optional[int]) -> None:
    ...



def evaluate(board : Board):
    """
    A simple heuristic function for the utility of a Board
    based on Claude Shannon's example evaluation function.
    This implementation differs in using centipawns instead of fractional values,
    and explicitly evaluates positions which can be claimed as a draw as 0.
    The number of Kings is reconsidered as whether or not a player is in Checkmate. 
    
    "f(P) = 200(K-K') + 9(Q-Q') + 5(R-R') + 3(B-B'+N-N') + (P-P') - 0.5(D-D'+S-S'+I-I') + 0.1(M-M')

    in which: -
    (1) K,Q,R,B,B,P are the number of White kings, queens, rooks, bishops, knights
    and pawns on the board.
    (2) D,S,I are doubled, backward and isolated White pawns.
    (3) M= White mobility (measured, say, as the number of legal moves available to
    White).
    
    Primed letters are the similar quantities for Black."

    Shannon, C. E. (1950). XXII. Programming a computer for playing chess. The London, 
    Edinburgh, and Dublin Philosophical Magazine and Journal of Science, 41(314), 256–27    
    5. https://doi.org/10.1080/14786445008521796
    """
    ...

def is_quiescent(board : Board) -> bool:
    """
    Determines if the given Board's position is 'quiescent', meaning that the position is not Check,
    and that there are  no possible captures that could be made on this turn.
    """
    ...

def perft(board : Board, depth: int) -> int:
    """
    Performs a tree walk of legal moves starting from the provided :class:`Board`, 
    and returns the number of leaf nodes at the given depth. For more information, 
    see: https://www.chessprogramming.org/Perft
    """
    ...

def perft_fen(fen : str, depth : int) -> int: 
    """
    Sames as `utils.perft()`, but takes a Forsyth-Edwards Notation `str` description of a position instead of a :class:`Board`. 
    """
    ...

def backwards_pawns(board : Board, color : Optional[Color] = None) -> Bitboard: 
    """
    Returns a :class:`Bitboard` containing all :class:`Square` values with a backwards pawn for the given `Board`.

    A backwards pawn is defined as a pawn that:
    - is behind all other friendly pawns in its own and adjacent files.
    - has no enemy pawn directly in front of it
    - can not advance without being attacked by an enemy pawn
    """
    ...

def isolated_pawns(board : Board, color : Optional[Color] = None) -> Bitboard: 
    """
    Returns a :class:`Bitboard` containing all :class:`Square` values with an isolated pawn for the given `Board`.

    An isolated pawn is defined as a pawn with no friendly pawns in adjacent files.  
    """
    ...

def doubled_pawns(board : Board, color : Optional[Color] = None) -> Bitboard: 
    """
    Returns a :class:`Bitboard` containing all :class:`Square` values with a passed pawn for the given `Board`.

    A doubled pawn is defined as a pawn with a friendly pawn in the same file.  

    """
    ...

def passed_pawns(board : Board, color : Optional[Color] = None) -> Bitboard:
    """
    Returns a :class:`Bitboard` containing all :class:`Square` values with a passed pawn for the given `Board`.

    A passed pawn is defined as a pawn with no enemy pawns in its file or adjacent files which can
    block it from advancing forward, ulitmately to promote.
    """
    ...

def is_pinned(board : Board, square : Square) -> bool:
    """
    Returns `True` if the given :class:`Square` has a piece which is pinned in the given :class:`Board`.

    A piece is considered pinned if it is not allowed to move at all, as doing so would place the moving player's king in check.
    """
    ...

def reset_hashing() -> None: ...

def attack_mask(board : Board, attacker : Color) -> Bitboard: 
    """
    Returns a :class:`Bitboard` of containing all :class:`Square` which are being attacked by the specified :class:`Color`. 
    """
    ...


def material(board : Board, 
             pawn_value : int = 100,
             knight_value : int = 300,
             bishop_value : int = 300,
             rook_value : int = 500,
             queen_value : int = 900) -> int: 
    """
    Calculates the net material value on the provided :class:`Board`. By default,
    uses standard evaluations of each :class:`PieceType` measured in centipawns.
    """
    ...

def mobility(board : Board) -> int: 
    """
    Returns the number of moves for the `Board` as if it were it the `WHITE`'s turn,
    subtracted by the number of moves as if it were `BLACK`'s turn.  
    """
    ...

def open_files(board : Board) -> Bitboard: 
    """
    Returns a :class:`Bitboard` of all files that have no pawns of either :class:`Color`.
    """
    ...

def half_open_files(board : Board, for_color : Color) -> Bitboard:
    """
    Returns a :class:`Bitboard` of all files that have no pawns of the given :class:`Color`.
    """
    ...

#NOT USING def pinned_mask(board : Board, on_square : Square) -> Bitboard: ...

#def checkers(board : Board) -> int: ...
#def trapped_mask(board : Board) -> Bitboard: ...

#
def random_legal_move(board : Board) -> Optional[Move]: 
    """
    Returns a random legal :class:`Move` for the given :class:`Board`.

    This is much faster than `random.choice(board.legal_moves())`.
    """
    ...


def random_board() -> Board:
    """
    Returns a :class:`Board` with a position determined by appling a random number of randomly selected legal moves.
    """
    ...


def legally_equal(board1 : Board, board2 : Board) -> bool:
    """
    Returns `True` if given two :class:`Board` instances with the same mapping of `Square` to `Piece` objects,
    equivilant `CastlingRights`, and en-passant `Square` values.

    Unlike :func:`Board.__eq__`, does not check the halfmove clock and fullmove number. 
    """
    ...

def deeply_equal(board1 : Board, board2 : Board) -> bool:
    """
    Returns `True` if given two :class:`Board` instances have the same move history,
    along with equivalent mappings of `Square` to `Piece` objects,
    equivilant `CastlingRights`, and en-passant `Square` values, halfmove clocks, and fullmove numbers.

    This function has the same behavior as `board1 == board2 and board1.history == board2.history`, but is much faster.
    """
    ...

def piece_bitboard(board : Board, piece : Piece) -> Bitboard:
    ...

def unoccupied_bitboard(board : Board) -> Bitboard:
    ...

def white_bitboard(board : Board) -> Color:
    ...

def black_bitboard(board : Board) -> Color:
    ...

def king_bitboard(board : Board) -> Color:
    ...

def queen_bitboard(board : Board) -> Color:
    ...

def bishop_bitboard(board : Board) -> Color:
    ...

def rook_bitboard(board : Board) -> Color:
    ...

def pawn_bitboard(board : Board) -> Color:
    ...

def knight_bitboard(board : Board) -> Color:
    ...

def king_square(board : Board, color : Color) -> Square:
    ...