Pieces:
The first implemention used a `struct` that held the type and color of every piece. However, this causes some weirdness with empty pieces, which should not have a color. None in python can be
passed to C as a null pointer, so we should transion to using pointers to pieces, and use null to represent an empty piece. There should be no equivalent of a pointer to an empty piece struct.

Boards/Positions:
There should be a distinction between a Board and a Position at the python level, a Board should have a Position. Positions should have optimized C functions for checking if a piece is present,
if a piece is at a location, hashing, subsets, etc.

Parsing/FEN:
This should be implemented after more functionality of Boards and Positions are finalized.

Move Generation:
This could be tricky because of having to malloc