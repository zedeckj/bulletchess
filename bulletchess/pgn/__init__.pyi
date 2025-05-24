from typing import Optional, Any
from bulletchess.main import *


class PGNDate:
    """
    Represents a date for PGN. Has a year, month, and day.
    """

    def __init__(self, year : Optional[int], month : Optional[int], day : Optional[int]): ...

    @property
    def year(self) -> Optional[int]: 
        """
        The year of this date, or ``None`` if not specified.
        """
        ...

    @property
    def month(self) -> Optional[int]: 
        """
        The month of this date, or ``None`` if not specified.
        """
        ...

    @property
    def day(self) -> Optional[int]: 
        """
        The day of this date, or ``None`` if not specified.
        """
        ...

    def __str__(self) -> str: 
        """
        Returns a ``str`` of this date in the form of YYYY.MM.DD

        >>> str(PGNDate(1990, 4, 10))
        '1990.04.10'
        >>> str(PGNDate(2015, 7, None))
        '2015.07.??'
        >>> str(PGNDate(None, None, None))
        '????.??.??'
        """
        ...

    def __repr__(self) -> str: ...

    def __eq__(self, other : Any) -> bool: 
        """
        Returns ``True`` if compared with an identical :class:`PGNDate`
        """
        ...

    def __le__(self, other : PGNDate) -> bool: 
        """
        Returns ``True`` if compared with an earlier or equivalent :class:`PGNDate`
        """
        ...

    def __ge__(self, other : PGNDate) -> bool: 
        """
        Returns ``True`` if compared with a later or equivalent :class:`PGNDate`
        """
        ...

    def __lt__(self, other : PGNDate) -> bool: 
        """
        Returns ``True`` if compared with an earlier :class:`PGNDate`
        """
        ...

    def __gt__(self, other : PGNDate) -> bool: 
        """
        Returns ``True`` if compared with a later :class:`PGNDate`
        """
        ...

    def __hash__(self) -> int: ...


class PGNResult:

    @staticmethod
    def from_str(result_str : str) -> "PGNResult": 
        """
        Returns the :class:`PGNResult` corresponding to the given ``str``.
        Any ``str`` besides "1-0", "0-1", or "1/2-1/2" corresponds to an Unknown Result.

        
        

        """
        ...

    @property
    def winner(self) -> Optional[Color]: ...

    @property
    def is_draw(self) -> bool: ...

    @property
    def is_unknown(self) -> bool: ...

    def __int__(self) -> int: ...

    def __eq__(self, other : Any) -> bool: ...

    def __str__(self) -> str: ...

    def __repr__(self) -> str: ...

    def __hash__(self) -> int: ...

WHITE_WON : PGNResult
BLACK_WON : PGNResult
DRAW_RESULT : PGNResult
UNKNOWN_RESULT : PGNResult

class PGNGame:
    @property
    def event(self) -> str: ...

    @property
    def site(self) -> str: ...

    @property
    def round(self) -> str: ...

    @property
    def date(self) -> PGNDate: ...

    @property
    def white_player(self) -> str: ...

    @property
    def black_player(self) -> str: ...

    @property
    def result(self) -> PGNResult: ...

    @property
    def move_count(self) -> int: ...
    
    @property
    def moves(self) -> list[Move]: ...
    
    @property
    def starting_board(self) -> Board: ...

    def __hash__(self) -> int: ...

    def __eq__(self, other : Any) -> bool: ... 

    def __getitem__(self, tag : str) -> Optional[str]: ...


class PGNFile:
    
    @staticmethod
    def open(path : str) -> "PGNFile": ...

    def close(self) -> None: ...

    def is_open(self) -> bool: ...

    def next_game(self) -> PGNGame: ...

    def skip_game(self) -> None: ...

    def __enter__(self) -> PGNFile: ...

    def __exit__(self, exc_type, exc_val, exc_tb) -> None: ...
