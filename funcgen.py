
def make_case(sq_str):
    return f"\t\tcase SQUARE_TO_BB({sq_str}): return {sq_str};"

def make_cases():
    cases = ""
    for file in "ABCDEFGH":
        for rank in range(1,9):
            cases += make_case(file + str(rank)) + "\n"
    return cases

func = f"""
square_t unchecked_bb_to_square(bitboard_t bb){{
	switch (bb){{
        {make_cases()}				
	}}
}}
"""

print(func)
