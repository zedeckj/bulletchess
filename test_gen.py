import bulletchess.backend as bk
from bulletchess import *
import random

boards = [Board.random() for _ in range(100000)]
moves = []

new_boards = []
for board in boards:
    opts = board.legal_moves()
    if len(opts) > 0:
        new_boards.append(board)
        moves.append(random.choice(opts))

boards = new_boards
boards2 = [board.copy() for board in boards]

from time import time

def timer_func(func): 
    def wrap_func(*args, **kwargs): 
        t1 = time() 
        result = func(*args, **kwargs) 
        t2 = time() 
        print(f'Function {func.__name__!r} executed in {(t2-t1):.4f}s') 
        return result 
    return wrap_func 


@timer_func
def applies():
    for i in range(len(boards)):    
        boards[i].apply(moves[i])
            
@timer_func
def applies_void():
    for i in range(len(boards)):    
        boards2[i].void_apply(moves[i])


applies()
applies_void()
assert(boards == boards2)
