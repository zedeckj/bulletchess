#include "board.h"

void img_for_piece(piece_t piece, char * buffer){{
	char code[3] = {{0}};
	switch (piece.type) {{
		case EMPTY_VAL:
			buffer[0] = 0;
			return;
		case PAWN_VAL:
			code[1] = 'P';
			break;
		case KNIGHT_VAL:
			code[1] = 'N';
			break;
		case BISHOP_VAL:
			code[1] = 'B';
			break;
		case ROOK_VAL:
			code[1] = 'R';
			break;
		case QUEEN_VAL:
			code[1] = 'Q';
			break;
		default:
			code[1] = 'K';
			break;
	}}
	if (piece.color == WHITE_VAL) code[0] = 'w';
	else code[0] = 'b';
	sprintf(buffer, "<div class = \"%s\"></div>", code);
}}

void board_html(full_board_t *board, char * buffer){{
	position_t *pos = board->position;
	const char *template = {template};
	{declarations}
	sprintf(buffer, template, {args}); 
}}


