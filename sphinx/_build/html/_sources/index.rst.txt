.. bulletchess documentation master file, created by
   sphinx-quickstart on Thu May 22 18:37:37 2025.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

``bulletchess``
==============================
``bulletchess`` is a Python module for playing, analyzing, and building engines for chess. Unlike other chess libraries in Python, 
the core of ``bulletchess`` is written in C, allowing it to be *much* faster than alternatives.


Overview
---------
At a high level, ``bulletchess`` includes:

* A complete game model with intuitive representations for pieces, moves, and positions.
* Extensively tested legal move generation, application, and undoing.
* Parsing and writing of positions specified in `Forsyth-Edwards Notation <https://www.chessprogramming.org/Forsyth-Edwards_Notation>`_ (FEN), and moves specified in both `Long Algebraic Notation <https://www.chessprogramming.org/Algebraic_Chess_Notation#Long_Algebraic_Notation_.28LAN.29>`_ and `Standard Algebraic Notation <https://www.chessprogramming.org/Algebraic_Chess_Notation#Standard_Algebraic_Notation_.28SAN.29>`_.
* Methods to determine if a position is check, checkmate, stalemate, and each specific type of draw.
* Efficient hashing of positions using `Zobrist Keys <https://en.wikipedia.org/wiki/Zobrist_hashing>`_.
* A `Portable Game Notation <https://thechessworld.com/articles/general-information/portable-chess-game-notation-pgn-complete-guide/>`_ (PGN) file reader
* Utility functions for writing engines. 


Glossary
---------
.. toctree::
  :maxdepth: 3

  auto_examples/walkthrough 
  auto_examples/performance
  main
  utils
  pgn
