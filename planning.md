BulletChess plan:

1) Implement basic board manipulation:
    - Set Piece at
    - Remove Piece

Finish before morning of 3/2

2) Unlink from python-chess
    - Create own Piece and Move classes
    - Use python-chess only for testing, create functions
      in test interface for comparing BulletPieces with chess.Piece, etc
    - Implement FEN validation and parsing

Finish by end of 3/2

3) Implement Move Generation
   - Follow python-chess implementation

Finish by end of 3/4


3/3 UPDATE

Finished parsing, serializing, and interface for board and pieces. 
Finish by tonight:
- clean up C lib, add docs for everything and organize headers and files better X
- Pass through on Python interface to be clear X
- Create Move class and struct X
- Move UCI parsing X

- Create basic move validation, which will consist of simply checking if there is a piece
at the origin: NOT NEEDED. python-chess doesnt even do this, if a move is specified just
attempt to apply it. SKIP


- Create move application. IN PROGRESS

3/4 PLAN
- fix castling and ep square update for move application X
- Rethink union structure, leading to code duplication. X
- implement popping moves SKIPPED
- study python-chess move generation, make skeleton code and wish list in header X
- DIDNT PLAN implemented pseudo legal move generation

My pseudo legal move generation is about 50% slower than python-chess, although they may be "cheating" by precomputing things im not, which
makes their board construction much slower. 

3/4 Night Plan:
Optimizations:
- remove conditionals where possible. A difficult but potentially rewarding change would be replacing the struct with a simple array,
and indexing using PIECE_VAL's instead of field names. 
- Knights require no "sliding" mechanism, so there moves can be the bitwise and of pre computed bitboards and not occupied by same color. This would require a means to turn a square origin and a bitboard of destinations into moves, which would likely be faster still.  

- PRE ALLOCATE 64 BITBOARD DESTINATION ARRAY. 


3/5 UPDATE
Most of the overhead turned out to be on the python side.
Now generating all legal moves for positions where player is not already in check
3/6 Plan:
- Finish move generation cleanup, pull out more helper functions
- Use concept of push and capture masks to find legal moves in check
https://peterellisjones.com/posts/generating-legal-chess-moves-efficiently/





3/17

Essentially all features in terms of playing chess are implemented and are well tested and reasonably fast.
There are essentially two design problems left to tackle

- Board legality/validation
    Should it be allowed to create a board that describes an illegal position from a FEN? Should boards be able to be mutated such that they are now illegal positions? 
    If yes, how far does this go? It seems like a lot of useful functionality would be excluded.

    It seems like the best solution is to allow illegal boards, as this may allow interesting analysis, but not allowed the generation of moves in these positions...
    Or why not? Simply provide an is_legal function.


- Board Predicates

    The way im imagining this is a function which operates over a list of boards and a list of predicates, boards that match at least one pred will be retained. 
    A predicate is a list of perscriptions for specific piece configuration or a piece count



3/19/25

Generally, there seems to be a distinction between Board state that is conventionally illegal in real games, and Board state that is inherently invalid.

In the simplest case, there is no reason moves cannot be generated for a position with 9 white pawns. Or even moves for a position with only a knight, and no kings, or no pieces at all.

However, if the bitboard values for knights and pawns have an overlap, that is always invalid. 

Since castling is `hardcoded`, castling rights should always be valid as well. 



In terms of organization, we need to signifincalty consolidate `__init__.py`. Ideally, all public facing classes would simply hold a C Struct inside, while all ctypes interfacing would be hidden.
```python

Piece.new(WHITE, PAWN)
Piece.pawn(WHITE)
Pawn(WHITE)
``` 

3/24/25
Backend is now fully seperate. Next TODOs:
- Write an engine in python using shannons evaluation function, and test on lichess X
- Profile the engine and address slow points 
- Likely to be game status, refactor to have one function return status, improve and test draw conditions
- Fix all failing unit tests, address Move model and Null moves
- Improve insufficent material marker


3/28/25
Timeline
- Finish SAN, parse castling and check/checkmate notation.
- Add more utility functions, reorganize python classes
- Aggressive testing
- docs for everything
- deployment testing, windows/linux port
- publish
- PGN, pushed to v0.2 


4/9/25

4/15/25
"Soft" published already.
Notes to work on:
- Found a weird error when creating a bad move
- PGN file stream 


4/16/25
PGN TODO:
Instead of allocating an arbitrarily large number of char* fields and moves in python, 
dynamically allocate in C, then realloc in python, copy, then free? 
That all seems very slow. 


4/18/25
Updated TODO:
- Dynamic reallocation in python may be too slow, but at the least reduce allocation
    - FEN should be replaced with a starting board pointer (much smaller)
    - result should be replaced with a BoardStatus enum
    - date replaced by date struct
- Add support for extra tags for ELO, or anything else that is strictly numeric or formatted in a manner which is not an unbounded string
- Write tests for each individual field being correct, empty, blank, and malformed.
- Refactor main.py to remove (or at least reduce) type errors
- Exapnd on utilities, focus on defining objective functions, not random heuristics you've come up with. 
