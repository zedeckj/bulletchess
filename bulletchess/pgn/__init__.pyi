from typing import Optional, Any
from bulletchess import *

class PGNDate:
    """
    Represents a date for PGN. Has a year, month, and day.
    """

    def __init__(self, year : Optional[int], month : Optional[int], day : Optional[int]): 
        """
        Initializes a :class:`PGNDate` with the given *year*, *month*, and *day*. Providing ``None`` for any of these fields 
        indicates the term is unknown.

        :param int | None year: The year field of this date.
        :param int | None month: The month field of this date.
        :param int | None day: The day field of this date.

        :raise: :exc:`ValueError` if the given year, month, or day cannot represent a valid date.
        """
        ...

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

        >>> PGNResult.from_str("1-0") is WHITE_WON
        True
        >>> PGNResult.from_str("0-1") is BLACK_WON
        True
        >>> PGNResult.from_str("1/2-1/2") is DRAW_RESULT
        True
        >>> PGNResult.from_str("*") is UNKNOWN_RESULT
        True
        >>> PGNResult.from_str("or anything else") is UNKNOWN_RESULT
        True
        """
        ...

    @property
    def winner(self) -> Optional[Color]: 
        """
        Returns the :class:`Color` of the winner, if this result indicates one.
        """
        ...

    @property
    def is_draw(self) -> bool: 
        """
        Returns ``True`` if this result is a draw.
        """
        ...

    @property
    def is_unknown(self) -> bool: 
        """
        Returns ``True`` if this result is unknown.
        """
        ...

    def __eq__(self, other : Any) -> bool: ...

    def __str__(self) -> str: 
        """
        Returns a ``str`` of the PGN format of this result.

        >>> str(WHITE_WON)
        '1-0'
        >>> str(BLACK_WON)
        '0-1'
        >>> str(DRAW_RESULT)
        '1/2-1/2'
        >>> str(UNKNOWN_RESULT)
        '*'
        """
        ...

    def __repr__(self) -> str: ...

    def __hash__(self) -> int: ...

WHITE_WON : PGNResult
BLACK_WON : PGNResult
DRAW_RESULT : PGNResult
UNKNOWN_RESULT : PGNResult

class PGNGame:
    @property
    def event(self) -> str: 
        """
        The contents of the "Event" tag, as a ``str``.
        """
        ...

    @property
    def site(self) -> str: 
        """
        The contents of the "Site" tag, as a ``str``.
        """
        ...

    @property
    def round(self) -> str: 
        """
        The contents of the "Round" tag, as a ``str``.
        """
        ...

    @property
    def date(self) -> PGNDate: 
        """
        A :class:`PGNResult` formed from the "Date" tag. Alternatively looks 
        at "UTCDate" as a fallback. If neither of these are provided, 
        the year, month, and day are marked as unknown.
        """
        ...

    @property
    def white_player(self) -> str: 
        """
        The contents of the "White" tag, as a ``str``.
        """
        ...

    @property
    def black_player(self) -> str: 
        """
        The contents of the "Black" tag, as a ``str``.
        """
        ...

    @property
    def result(self) -> PGNResult: 
        """
        A :class:`PGNResult` formed from the "Result" tag.
        If this field is malformed or not provided, an unknown
        result is returned.
        """
        ...

    @property
    def move_count(self) -> int: 
        """
        The number of moves played in this game.
        """
        ...
    
    @property
    def moves(self) -> list[Move]: 
        """
        A list of moves played in this game.
        """
        ...
    
    @property
    def starting_board(self) -> Board: 
        """
        The starting position of this game. Determined by looking at the
        "FEN" tag, if it is provided. Otherwise, is the same as the standard starting position.
        """
        ...

    def __getitem__(self, tag : str) -> Optional[str]: 
        """
        Gets the raw ``str`` value of the given tag. If the tag is absent,
        returns ``None``.
        """
        ...

    def __hash__(self) -> int: ...

    def __eq__(self, other : Any) -> bool: ... 




class PGNFile:
    
    @staticmethod
    def open(path : str) -> "PGNFile": 
        """
        Opens a PGN file for reading.

        :raises: :exc:`FileNotFoundError` If the given path does not lead to a file.
        """
        ...

    def close(self) -> None: 
        """
        Closes a PGN file. Closing an already closed file has no effect.
        """
        ...

    def is_open(self) -> bool: 
        """
        Returns ``True`` if this file is open.
        """
        ...

    def next_game(self) -> Optional[PGNGame]: 
        """
        Gets the next game from a file as a :class:`PGNGame`
        If the file is exhausted of games, returns None.

        :raises: :exc:`ValueError` if an error is found while parsing.
        """
        ...

    def skip_game(self) -> None: 
        """
        Skips over the next game in a file.
        """
        ...

    def __enter__(self) -> PGNFile: ...

    def __exit__(self, exc_type, exc_val, exc_tb) -> None: ...
