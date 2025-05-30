
from typing import Optional
from bulletchess import *

def count_moves(board : Board) -> int: 
    """
    Counts the number of legal moves that could be performed for the given :class:`Board`, without actually
    constructing any :class:`Move` objects. This is much faster than calling 
    ``len(Board.legal_moves())``
    """
    ...

def evaluate(board : Board) -> int:
    """
    A simple heuristic function for the utility of a :class:`Board`
    based on Claude Shannon's example evaluation function.
    This implementation differs in using centipawns instead of fractional values,
    and explicitly evaluates positions which can be claimed as a draw as 0.
    The number of Kings is reconsidered as whether or not a player is in Checkmate. 
        

        f(P) = 200(K-K') + 9(Q-Q') + 5(R-R') + 3(B-B'+N-N') + (P-P') - 0.5(D-D'+S-S'+I-I') + 0.1(M-M')

        in which:

        1) 
        K,Q,R,B,B,P are the number of White kings, queens, rooks, bishops, knights
        and pawns on the board.


        2)
        D,S,I are doubled, backward and isolated White pawns.


        3)
        M= White mobility (measured, say, as the number of legal moves available to
        White).

        Primed letters are the similar quantities for Black.

        Shannon, C. E. (1950). XXII. Programming a computer for playing chess. The London, 
        Edinburgh, and Dublin Philosophical Magazine and Journal of Science, 41(314), 256–27    
        5. https://doi.org/10.1080/14786445008521796
    """
    ...

def is_quiescent(board : Board) -> bool:
    """
    Determines if the given :class:`Board`'s position is 'quiescent', meaning that the position is not check,
    and that there are no possible captures that could be made on this turn.

    >>> is_quiescent(Board())
    True

    >>> board = Board.from_fen("rnbqkbnr/pppp1ppp/8/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq - 1 2")
    >>> print(board)
    r n b q k b n r 
    p p p p - p p p 
    - - - - - - - - 
    - - - - p - - - 
    - - - - P - - - 
    - - - - - N - - 
    P P P P - P P P 
    R N B Q K B - R 
    >>> is_quiescent(board)
    True

    >>> board = Board.from_fen("r1bqkbnr/pppp1ppp/2n5/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R w KQkq - 2 3")
    >>> print(board)
    r - b q k b n r 
    p p p p - p p p 
    - - n - - - - - 
    - - - - p - - - 
    - - - - P - - - 
    - - - - - N - - 
    P P P P - P P P 
    R N B Q K B - R 
    >>> is_quiescent(board)
    False
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
    Sames as :func:`utils.perft()`, but takes a Forsyth-Edwards Notation ``str`` description of a position instead of a :class:`Board`. 
    """
    ...

def backwards_pawns(board : Board, color : Optional[Color] = None) -> Bitboard: 
    """
    Returns a :class:`Bitboard` containing all :class:`Square` values with a backwards pawn for the given :class:`Board`.

    A backwards pawn is defined as a pawn that:
    - is behind all other friendly pawns in its own and adjacent files.
    - has no enemy pawn directly in front of it
    - can not advance without being attacked by an enemy pawn

    >>> board = Board.from_fen("4k3/2p3p1/1p2p2p/1P2P2P/1PP3P1/4P3/8/4K3 w - - 0 1")
    >>> print(board)
    - - - - k - - - 
    - - p - - - p - 
    - p - - p - - p 
    - P - - P - - P 
    - P P - - - P - 
    - - - - P - - - 
    - - - - - - - - 
    - - - - K - - - 

    >>> print(backwards_pawns(board))
    0 0 0 0 0 0 0 0 
    0 0 1 0 0 0 1 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 1 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    """
    ...

def isolated_pawns(board : Board, color : Optional[Color] = None) -> Bitboard: 
    """
    Returns a :class:`Bitboard` containing all :class:`Square` values with an isolated pawn for the given :class:`Board`.

    An isolated pawn is defined as a pawn with no friendly pawns in adjacent files.  

    >>> board = Board.from_fen("4k3/2p3p1/1p2p2p/1P2P2P/1PP3P1/4P3/8/4K3 w - - 0 1")
    >>> print(board)
    - - - - k - - - 
    - - p - - - p - 
    - p - - p - - p 
    - P - - P - - P 
    - P P - - - P - 
    - - - - P - - - 
    - - - - - - - - 
    - - - - K - - - 

    >>> print(isolated_pawns(board))
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 1 0 0 0 
    0 0 0 0 1 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 1 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    """
    ...

def doubled_pawns(board : Board, color : Optional[Color] = None) -> Bitboard: 
    """
    Returns a :class:`Bitboard` containing all :class:`Square` values with a passed pawn for the given :class:`Board`.

    A doubled pawn is defined as a pawn with a friendly pawn in the same file.  

    >>> board = Board.from_fen("4k3/2p3p1/1p2p2p/1P2P2P/1PP3P1/4P3/8/4K3 w - - 0 1")
    >>> print(board)
    - - - - k - - - 
    - - p - - - p - 
    - p - - p - - p 
    - P - - P - - P 
    - P P - - - P - 
    - - - - P - - - 
    - - - - - - - - 
    - - - - K - - - 

    >>> print(doubled_pawns(board))
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 1 0 0 1 0 0 0 
    0 1 0 0 0 0 0 0 
    0 0 0 0 1 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    """
    ...

def passed_pawns(board : Board, color : Optional[Color] = None) -> Bitboard:
    """
    Returns a :class:`Bitboard` containing all :class:`Square` values with a passed pawn for the given :class:`Board`.

    A passed pawn is defined as a pawn with no enemy pawns in its file or adjacent files which can
    block it from advancing forward, ulitmately to promote.

    >>> board = Board.from_fen("7k/8/7p/1P2Pp1P/2Pp1PP1/8/8/7K w - - 0 1")
    >>> print(board)
    - - - - - - - k 
    - - - - - - - - 
    - - - - - - - p 
    - P - - P p - P 
    - - P p - P P - 
    - - - - - - - - 
    - - - - - - - - 
    - - - - - - - K 

    >>> print(passed_pawns(board))
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 1 0 0 1 0 0 0 
    0 0 1 1 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    """
    ...

def is_pinned(board : Board, square : Square) -> bool:
    """
    Returns ``True`` if the given :class:`Square` has a piece which is pinned in the given :class:`Board`.

    A piece is considered pinned if it is not allowed to move at all, as doing so would place the moving player's king in check.

    >>> board = Board.from_fen("rnbqk1nr/pppp1ppp/8/4p3/1b6/2NP4/PPP1PPPP/R1BQKBNR w KQkq - 1 3")
    >>> print(board)
    r n b q k - n r 
    p p p p - p p p 
    - - - - - - - - 
    - - - - p - - - 
    - b - - - - - - 
    - - N P - - - - 
    P P P - P P P P 
    R - B Q K B N R 

    >>> is_pinned(board, A1)
    False
    >>> is_pinned(board, D3)
    False
    >>> is_pinned(board, C3)
    True
    """
    ...

def attack_mask(board : Board, attacker : Color) -> Bitboard: 
    """
    Returns a :class:`Bitboard` of containing all squares which are being attacked by the specified :class:`Color`. 


    >>> board = Board()
    >>> print(attack_mask(board, WHITE))
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    1 1 1 1 1 1 1 1 
    1 1 1 1 1 1 1 1 
    0 1 1 1 1 1 1 0 

    >>> board = Board.from_fen("7k/8/8/1r6/8/8/8/7K w - - 0 1")
    >>> print(board)
    - - - - - - - k 
    - - - - - - - - 
    - - - - - - - - 
    - r - - - - - - 
    - - - - - - - - 
    - - - - - - - - 
    - - - - - - - - 
    - - - - - - - K 

    >>> print(attack_mask(board, BLACK))
    0 1 0 0 0 0 1 0 
    0 1 0 0 0 0 1 1 
    0 1 0 0 0 0 0 0 
    1 0 1 1 1 1 1 1 
    0 1 0 0 0 0 0 0 
    0 1 0 0 0 0 0 0 
    0 1 0 0 0 0 0 0 
    0 1 0 0 0 0 0 0 
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
    Returns the number of moves for the :class:`Board` as if it were it the :data:`WHITE`'s turn,
    subtracted by the number of moves as if it were :data:`BLACK`'s turn.  
    """
    ...

def open_files(board : Board) -> Bitboard: 
    """
    Returns a :class:`Bitboard` of all files that have no pawns of either :class:`Color`.
    
    >>> board = Board.from_fen("4k3/2p3p1/1p2p2p/1P2P2P/1PP3P1/4P3/8/4K3 w - - 0 1")
    >>> print(board)
    - - - - k - - - 
    - - p - - - p - 
    - p - - p - - p 
    - P - - P - - P 
    - P P - - - P - 
    - - - - P - - - 
    - - - - - - - - 
    - - - - K - - - 

    >>> print(open_files(board))
    1 0 0 1 0 1 0 0 
    1 0 0 1 0 1 0 0 
    1 0 0 1 0 1 0 0 
    1 0 0 1 0 1 0 0 
    1 0 0 1 0 1 0 0 
    1 0 0 1 0 1 0 0 
    1 0 0 1 0 1 0 0 
    1 0 0 1 0 1 0 0 
    """
    ...

def half_open_files(board : Board, for_color : Color) -> Bitboard:
    """
    Returns a :class:`Bitboard` of all files that have no pawns of the given :class:`Color`, but do 
    have pawns of the opposite :class:`Color`.
    
    >>> board = Board.from_fen("3k4/8/4p3/4P3/5PP1/8/8/3K4 w - - 0 1")
    >>> print(board)
    - - - k - - - - 
    - - - - - - - - 
    - - - - p - - - 
    - - - - P - - - 
    - - - - - P P - 
    - - - - - - - - 
    - - - - - - - - 
    - - - K - - - - 

    >>> print(half_open_files(board, WHITE))
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 

    >>> print(half_open_files(board, BLACK))
    0 0 0 0 0 1 1 0 
    0 0 0 0 0 1 1 0 
    0 0 0 0 0 1 1 0 
    0 0 0 0 0 1 1 0 
    0 0 0 0 0 1 1 0 
    0 0 0 0 0 1 1 0 
    0 0 0 0 0 1 1 0 
    0 0 0 0 0 1 1 0 
    """
    ...

def random_legal_move(board : Board) -> Optional[Move]: 
    """
    Returns a random legal :class:`Move` for the given :class:`Board`.

    This is much faster than ``random.choice(board.legal_moves())``.

    >>> board = Board()
    >>> random_legal_move(board)
    <Move: g1h3>
    >>> random_legal_move(board)
    <Move: d2d3>
    """
    ...


def random_board() -> Board:
    """
    Returns a :class:`Board` with a position determined by applying a random number of randomly selected legal moves.
    The generated :class:`Board` may be checkmate or a draw. 

    >>> board = random_board()
    >>> print(board)
    r Q - - k - - r 
    - b - p n p p - 
    p b - - p - - - 
    - - - - - - P - 
    - p P - - - p - 
    N - - - - N - - 
    P - - P P P - - 
    R - B - K - - - 

    >>> board2 = random_board()
    >>> print(board2)
    - - K - - - - - 
    - - - - - - - - 
    - - - - - - - - 
    - - - - - - - - 
    - - - - - - - - 
    - - - - - - - - 
    - k - - - - - - 
    - - - - - - - - 
    """
    ...


def legally_equal(board1 : Board, board2 : Board) -> bool:
    """
    Returns ``True`` if given two :class:`Board` instances with the same mapping of :class:`Square` to :class:`Piece` objects,
    equivalent :class:`CastlingRights`, and en-passant :class:`Square` values.

    Unlike :func:`Board.__eq__`, does not check the halfmove clock and fullmove number. 

    >>> board = Board()
    >>> board2 = Board()
    >>> board.halfmove_clock = 10
    >>> board == board2
    False
    >>> legally_equal(board, board2)
    True
    """
    ...

def deeply_equal(board1 : Board, board2 : Board) -> bool:
    """
    Returns ``True`` if given two :class:`Board` instances have the same move history,
    along with equivalent mappings of :class:`Square` to :class:`Piece` objects,
    equivalent :class:`CastlingRights`, and en-passant :class:`Square` values, halfmove clocks, and fullmove numbers.

    This function has the same behavior as ``board1 == board2 and board1.history == board2.history``, but is much faster.
    
    >>> board = Board()
    >>> board2 = Board()
    >>> board.apply(Move(E2, E4))
    >>> board2[E2] = None
    >>> board2[E4] = Piece(WHITE, PAWN)
    >>> board2.turn = BLACK
    >>> board2.en_passant_square = E3
    >>> board == board2
    True
    >>> deeply_equal(board, board2)
    False
    """
    ...

def piece_bitboard(board : Board, piece : Piece) -> Bitboard:
    """
    Gets a :class:`Bitboard` of squares with the given :class:`Piece` on the given :class:`Board`.

    >>> from bulletchess import *
    >>> piece = Piece(WHITE, PAWN)
    >>> board = Board()
    >>> bb = piece_bitboard(board, piece)
    >>> print(bb)
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    1 1 1 1 1 1 1 1 
    0 0 0 0 0 0 0 0 

    >>> bb == board[WHITE, PAWN]
    True
    """
    ...

def unoccupied_bitboard(board : Board) -> Bitboard:
    """
    An explict alias for indexing a :class:`Board` with ``None``.

    Gets a :class:`Bitboard` of all empty squares on the given :class:`Board`. 

    >>> board = Board()
    >>> bb = unoccupied_bitboard(board)
    >>> print(bb)
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    1 1 1 1 1 1 1 1 
    1 1 1 1 1 1 1 1 
    1 1 1 1 1 1 1 1 
    1 1 1 1 1 1 1 1 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 

    >>> bb == board[None]
    True
    """
    ...

def white_bitboard(board : Board) -> Bitboard:
    """
    An explicit alias for indexing a :class:`Board` with :data:`WHITE`.

    Gets a :class:`Bitboard` of all squares with a white piece on the given :class:`Board`. 

    >>> board = Board()
    >>> bb = white_bitboard(board)
    >>> print(bb)
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    1 1 1 1 1 1 1 1 
    1 1 1 1 1 1 1 1 

    >>> bb == board[WHITE]
    True
    """
    ...

def black_bitboard(board : Board) -> Bitboard:
    """
    An explicit alias for indexing a :class:`Board` with :data:`BLACK`.

    Gets a :class:`Bitboard` of all squares with a black piece on the given :class:`Board`. 

    >>> board = Board()
    >>> bb = black_bitboard(board)
    >>> print(bb)
    1 1 1 1 1 1 1 1 
    1 1 1 1 1 1 1 1 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 

    >>> bb == board[BLACK]
    True
    """
    ...

def king_bitboard(board : Board) -> Bitboard:
    """
    An explicit alias for indexing a :class:`Board` with :data:`KING`.

    Gets a :class:`Bitboard` of all squares with a king on the given :class:`Board`. 

    >>> board = Board()
    >>> bb = king_bitboard(board)
    >>> print(bb)
    0 0 0 0 1 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 1 0 0 0 

    >>> bb == board[KING]
    True
    """
    ...

def queen_bitboard(board : Board) -> Bitboard:
    """
    An explicit alias for indexing a :class:`Board` with :data:`QUEEN`.

    Gets a :class:`Bitboard` of all squares with a queen on the given :class:`Board`. 

    Examples
    --------
    >>> board = Board()
    >>> bb = queen_bitboard(board)
    >>> print(bb)
    0 0 0 1 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 1 0 0 0 0 

    >>> bb == board[QUEEN]
    True
    """
    ...

def bishop_bitboard(board : Board) -> Bitboard:
    """
    An explicit alias for indexing a :class:`Board` with :data:`BISHOP`.

    Gets a :class:`Bitboard` of all squares with a bishop on the given :class:`Board`. 

    >>> board = Board()
    >>> bb = bishop_bitboard(board)
    >>> print(bb)
    0 0 1 0 0 1 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 1 0 0 1 0 0 

    >>> bb == board[BISHOP]
    True
    """
    ...

def rook_bitboard(board : Board) -> Bitboard:
    """
    An explicit alias for indexing a :class:`Board` with :data:`ROOK`.

    Gets a :class:`Bitboard` of all squares with a rook on the given :class:`Board`. 

    >>> board = Board()
    >>> bb = rook_bitboard(board)
    >>> print(bb)
    1 0 0 0 0 0 0 1 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    1 0 0 0 0 0 0 1 

    >>> bb == board[ROOK]
    True
    """
    ...

def pawn_bitboard(board : Board) -> Bitboard:
    """
    An explicit alias for indexing a :class:`Board` with :data:`PAWN`.

    Gets a :class:`Bitboard` of all squares with a pawn on the given :class:`Board`. 

    >>> board = Board()
    >>> bb = pawn_bitboard(board)
    >>> print(bb)
    0 0 0 0 0 0 0 0 
    1 1 1 1 1 1 1 1 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    1 1 1 1 1 1 1 1 
    0 0 0 0 0 0 0 0 

    >>> bb == board[PAWN]
    True
    """
    ...

def knight_bitboard(board : Board) -> Bitboard:
    """
    An explicit alias for indexing a :class:`Board` with :data:`KNIGHT`.

    Gets a :class:`Bitboard` of all squares with a knight on the given :class:`Board`. 


    >>> board = Board()
    >>> bb = knight_bitboard(board)
    >>> print(bb)
    0 1 0 0 0 0 1 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 
    0 1 0 0 0 0 1 0 

    >>> bb == board[KNIGHT]
    True
    >>> 
    """
    ...

def king_square(board : Board, color : Color) -> Square:
    """
    Gets the :class:`Square` which has the the king of the specified :class:`Color` on the given :class:`Board`. 

    :raises: :exc:`AttributeError` if the given :class:`Board` has multiple kings of the given :class:`Color`.

    
    >>> board = Board()
    >>> king_square(board, WHITE) is E1
    True
    >>> king_square(board, BLACK) is E8
    True
    """
    ...