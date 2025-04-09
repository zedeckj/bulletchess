
### `count_pawns`
Original comparison was about 50% slower for bulletchess.

I believe we do not have any Structure reconstruction when getting a piece, we use
the struct return to access a dict of Pieces. However, this is probably not necessary.

We could devise a "transport" int format for pieces, and simply use this int to get the true piece back.
However, a large issue is likely from all the calls to C for a relatively simple operation.
Therefore, as a design philosophy, we need to include as many function compositions that occur inside of C as possible

Additionally, we should profile the actual parsing of the FEN json, this could be done with one C call as well. 


While its easy to make these composition functions, like `count_pieces`, it seems silly to have any functions that are significantly 
slower than python-chess. 

This is **key**, **EVERYTHING** must be faster, or at least equivalent.

Implementing a simulatenously updated `piece array` seems to improve performance significantly, but not more than python-chess.
The overhead of creating the list is small, so its strange to me that we still do worse with how much faster parsing is. 


Looking over the profiling further, it seems that ALL overhead is in turning the structs into the class. 
