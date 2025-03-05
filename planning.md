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



