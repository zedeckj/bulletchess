with open("../scripts/test.html", "r") as f:
    template = f.read()

import random

piece_divs = [f"<div class = \"{cls}\"></div>" for cls in ["bP", "bK", "wK", "bR", "wB", "wQ"]]
piece_divs.extend(["" for _ in range(10)])

html = "\n".join(["<meta http-equiv=\"refresh\" content=\"1\">"] + [line.replace("%s", random.choice(piece_divs)) for line in template.split("\n")])


with open("../scripts/slate.html", "w") as f:
    f.write(html)

