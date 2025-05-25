import os
import bulletchess

with open("../scripts/html_template.c") as f:
    c_template = f.read()

with open("../scripts/compressed.html") as f:
    html_template = f.read()

html_template = html_template.replace('"', '\\"')
html_template = "\n".join([f'"{line.rstrip()}\\n"' for line in html_template.split("\n") if line.strip() != ""])


declarations = "\n".join([
    f"\tchar {sq}_str[40];\n\timg_for_piece(get_piece_at(pos, {sq}), {sq}_str);" for sq in bulletchess.SQUARES_FLIPPED
])


args = ",".join([f" {sq}_str" for sq in bulletchess.SQUARES_FLIPPED])
args2 = ",".join([f" {sq}_str" for sq in bulletchess.SQUARES])


with open("../bulletchess/src/internal/html.c", "w") as f:
    f.write(c_template.format(template = html_template, declarations = declarations, args = args, args2 = args2))
