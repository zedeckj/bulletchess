### Reorganized Backend Files Plan

#### __init__.py 
- Provides interface between C library and Python

#### piece.h/c
- Defines types and functions relating only to Pieces 
- Defines piece serialization and parsing methods, which are trivial

#### board.h/c 
- Definitions for maniuplating and inspecting the Board and Bitboards. 
- This file excludes anything to do with serialization, parsing, moves, or outcomes.

#### fen.h/c
- Defintions for parsing Boards from FEN, and for serializing boards into FEN

#### move.h/c
- Defintions for the Move struct, as well as for serialization and parsing of string
represenations of moves 

#### rules.h/c
- Defintions for core gameplay rules, such as move generation, checkmate, and draw

#### apply.h/c
- Defintions for applying and undoing moves from Boards

#### encode.h/c
- Definitions for encoding Boards into a dense bytes format (TODO)


