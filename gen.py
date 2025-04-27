from bulletchess import *

FILE_CHARS = ['a','b','c','d','e','f','g','h']
RANK_CHARS = ['1','2','3','4','5','6','7','8']
PROMOTE_CHARS = ['r','n','q','b', '']



all_legal = []
for orr in RANK_CHARS:
    for ofe in FILE_CHARS:
        for dr in RANK_CHARS:
            for df in FILE_CHARS:
                for p in PROMOTE_CHARS:
                    try:
                        uci = f"{ofe}{orr}{df}{dr}{p}"
                        move = Move.from_uci(uci)
                        all_legal.append(move)
                    except:
                        continue
d = {}
for move in all_legal:
    d[int(hash(move))] = move

import pickle
with open("bulletchess/moves.pickle", "wb") as f:
    pickle.dump(d, f)


