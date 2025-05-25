import json
from bulletchess import *

def shrink_dict(d : dict, new_len : int) -> dict:
    data = list(d.items())
    return {k:v for k,v in data[:new_len]}

with open("data/move_tree_pos2.json", "r") as f:
    data : dict = json.load(f)

with open("data/move_tree_pos2.json", "w") as f:
    json.dump(shrink_dict(data, len(data)//10), f, indent=3)



