New Tests Directory Files

- position.py: 
    - Test Board position creation through the basic `.starting()` and `.empty()` constructors, using `get_piece_at`
    - Test the mutation of positions through `set_piece_at` and `remove_piece_at`
    - Test the equality method for different positions (pieces only!)    

- validation.py:
    NOTE: FEATURES NOT FULLY IMPLEMENTED
    - Test that positions can be validated as legal
    - Test that positions cannot have more than 8 pawns of each color
    - Test that positions can have multiple bishops, rooks, knights, and queens
    - Test that positions cannot have pawns on the back ranks
    - Tests that positions must have a single king for each color

- fen.py:
    - Test Board FEN parsing, checking with equality with manually set up positions
    - Test Board FEN serialization against given FENs
    - Test that syntatically valid FENs that produce illegal positions are not parsed
        - Note: the desired semantics of this aren't certain. One may wish to be allowed to create
        - invalid positions, but be restricted from generating moves 

- move-uci.py
    - Test the parsing of move ucis
    - Test serialization of moves back into uci
    - Test that completely invalid strings are not parsed
    - Test that almost reasonable ucis are not parsed (a9b1 for example)
    - Test that well formatted, but impossible moves are not parsed (a1b5 for example)
 
- move-gen.py
    - Test that all correct moves are generated in basic positions
    - Test that en-passant moves are generated
    - Test that castling moves are generated
    - Test that moving the king into check is not legal
    - Test that moving a piece to expose the king are not legal
    - Test that illegal positions either produce 0 legal moves, or raise an Exception

- move-apply.py
    - Test that the application of moves to basic positions produces the expected boards
    - Test the application of castling moves
    - Test the application of en-passant captures

- move-validate.py
    TODO: Implement move caching and an `is_validated` flag on moves
    - Test that illegal moves cannot be applied to a board

- perft.py
    - Use the `perft` function to test move generation and application more robustly
    - Do for both native and c implementations of perft

- check.py
    - Test that a predfined list of positions are either correctly marked as being in check or not

- checkmate.py
    - Test that a predefined list of positions are either corrected marked as checkmate or not

- 
