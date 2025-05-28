import codecs

pieces = ["bK", "bP", "bB", "bN", "bQ", "bR"]
white = ["wK", "wP", "wB", "wN", "wQ", "wR"]

import re

for piece in pieces:
    with codecs.open(f'../scripts/maestro/{piece}.svg', encoding='utf-8', errors='ignore') as f:
        content = f.read()
    print(content)
    print(re.findall("#[0-9abcdef]+", content))
    #ece9df -> dee6ed
    #content = content.replace("#ece9df", "#f4f7f9")
    #content = content.replace("#f4e0c8", "#d7dde2")    # content = content.replace("#737373", "#535353")
    # content = content.replace("#303030", "#101010")

    with open(f"../gfx/pieces/{piece}.svg", "w") as f:
        f.write(content)