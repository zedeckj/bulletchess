#include "board.h"

void img_for_piece(piece_t piece, char * buffer){
	char code[3] = {0};
	switch (piece.type) {
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
	}
	if (piece.color == WHITE_VAL) code[0] = 'w';
	else code[0] = 'b';
	sprintf(buffer, "<div class = \"%s\"></div>", code);
}

void board_html(full_board_t *board, char * buffer){
	position_t *pos = board->position;
	const char *template = "<style>.bulletchess-board {all: unset;}.bulletchess-board *,.bulletchess-board *::before,.bulletchess-board *::after { all: unset; }.bulletchess-board .lt { height: 60px; width: 60px;background-color: #9aa8b4;text-align: center;vertical-align: middle;}.bulletchess-board .dk { height: 60px; width: 60px; background-color: #444f61; background-blend-mode: multiply;}.bulletchess-board .row {display: flex;}.bulletchess-board .wP {content:url(\"https://raw.githubusercontent.com/zedeckj/bulletchess/2291e1984fe64ee7b136987ce6366ae3b6355008/gfx/pieces/wP.svg\");scale: 100%%;}.bulletchess-board .wN {content:url(\"https://raw.githubusercontent.com/zedeckj/bulletchess/2291e1984fe64ee7b136987ce6366ae3b6355008/gfx/pieces/wN.svg\");scale: 100%%;}.bulletchess-board .wB {content:url(\"https://raw.githubusercontent.com/zedeckj/bulletchess/2291e1984fe64ee7b136987ce6366ae3b6355008/gfx/pieces/wB.svg\");scale: 100%%;align-content: center;}.bulletchess-board .wR {content:url(\"https://raw.githubusercontent.com/zedeckj/bulletchess/65dd15d1341cfe6dbb12239793a20b1678aa77df/gfx/pieces/wR.svg\");scale: 100%%;}.bulletchess-board .wQ {content:url(\"https://raw.githubusercontent.com/zedeckj/bulletchess/2291e1984fe64ee7b136987ce6366ae3b6355008/gfx/pieces/wQ.svg\");scale: 100%%;}.bulletchess-board .wK {content:url(\"https://raw.githubusercontent.com/zedeckj/bulletchess/2291e1984fe64ee7b136987ce6366ae3b6355008/gfx/pieces/wK.svg\");scale: 100%%;}.bulletchess-board .bP {content:url(\"https://raw.githubusercontent.com/zedeckj/bulletchess/2291e1984fe64ee7b136987ce6366ae3b6355008/gfx/pieces/bP.svg\");scale: 100%%;}.bulletchess-board .bN {content:url(\"https://raw.githubusercontent.com/zedeckj/bulletchess/2291e1984fe64ee7b136987ce6366ae3b6355008/gfx/pieces/bN.svg\");scale: 100%%;}.bulletchess-board .bB {content:url(\"https://raw.githubusercontent.com/zedeckj/bulletchess/2291e1984fe64ee7b136987ce6366ae3b6355008/gfx/pieces/bB.svg\");scale: 100%%;}.bulletchess-board .bR {content:url(\"https://raw.githubusercontent.com/zedeckj/bulletchess/65dd15d1341cfe6dbb12239793a20b1678aa77df/gfx/pieces/bR.svg\");scale: 100%%;}.bulletchess-board .bQ {content:url(\"https://raw.githubusercontent.com/zedeckj/bulletchess/2291e1984fe64ee7b136987ce6366ae3b6355008/gfx/pieces/bQ.svg\");scale: 100%%;}.bulletchess-board .bK {content:url(\"https://raw.githubusercontent.com/zedeckj/bulletchess/2291e1984fe64ee7b136987ce6366ae3b6355008/gfx/pieces/bK.svg\");scale: 100%%;}</style><div class =\"bulletchess-board\"><div class = \"row\"><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div></div><div class = \"row\"><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div></div><div class = \"row\"><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div></div><div class = \"row\"><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div></div><div class = \"row\"><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div></div><div class = \"row\"><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div></div><div class = \"row\"><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div></div><div class = \"row\"><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div><div class = \"dk\">%s</div><div class = \"lt\">%s</div></div></div>\n";
		char A8_str[100];
	img_for_piece(get_piece_at(pos, A8), A8_str);
	char B8_str[100];
	img_for_piece(get_piece_at(pos, B8), B8_str);
	char C8_str[100];
	img_for_piece(get_piece_at(pos, C8), C8_str);
	char D8_str[100];
	img_for_piece(get_piece_at(pos, D8), D8_str);
	char E8_str[100];
	img_for_piece(get_piece_at(pos, E8), E8_str);
	char F8_str[100];
	img_for_piece(get_piece_at(pos, F8), F8_str);
	char G8_str[100];
	img_for_piece(get_piece_at(pos, G8), G8_str);
	char H8_str[100];
	img_for_piece(get_piece_at(pos, H8), H8_str);
	char A7_str[100];
	img_for_piece(get_piece_at(pos, A7), A7_str);
	char B7_str[100];
	img_for_piece(get_piece_at(pos, B7), B7_str);
	char C7_str[100];
	img_for_piece(get_piece_at(pos, C7), C7_str);
	char D7_str[100];
	img_for_piece(get_piece_at(pos, D7), D7_str);
	char E7_str[100];
	img_for_piece(get_piece_at(pos, E7), E7_str);
	char F7_str[100];
	img_for_piece(get_piece_at(pos, F7), F7_str);
	char G7_str[100];
	img_for_piece(get_piece_at(pos, G7), G7_str);
	char H7_str[100];
	img_for_piece(get_piece_at(pos, H7), H7_str);
	char A6_str[100];
	img_for_piece(get_piece_at(pos, A6), A6_str);
	char B6_str[100];
	img_for_piece(get_piece_at(pos, B6), B6_str);
	char C6_str[100];
	img_for_piece(get_piece_at(pos, C6), C6_str);
	char D6_str[100];
	img_for_piece(get_piece_at(pos, D6), D6_str);
	char E6_str[100];
	img_for_piece(get_piece_at(pos, E6), E6_str);
	char F6_str[100];
	img_for_piece(get_piece_at(pos, F6), F6_str);
	char G6_str[100];
	img_for_piece(get_piece_at(pos, G6), G6_str);
	char H6_str[100];
	img_for_piece(get_piece_at(pos, H6), H6_str);
	char A5_str[100];
	img_for_piece(get_piece_at(pos, A5), A5_str);
	char B5_str[100];
	img_for_piece(get_piece_at(pos, B5), B5_str);
	char C5_str[100];
	img_for_piece(get_piece_at(pos, C5), C5_str);
	char D5_str[100];
	img_for_piece(get_piece_at(pos, D5), D5_str);
	char E5_str[100];
	img_for_piece(get_piece_at(pos, E5), E5_str);
	char F5_str[100];
	img_for_piece(get_piece_at(pos, F5), F5_str);
	char G5_str[100];
	img_for_piece(get_piece_at(pos, G5), G5_str);
	char H5_str[100];
	img_for_piece(get_piece_at(pos, H5), H5_str);
	char A4_str[100];
	img_for_piece(get_piece_at(pos, A4), A4_str);
	char B4_str[100];
	img_for_piece(get_piece_at(pos, B4), B4_str);
	char C4_str[100];
	img_for_piece(get_piece_at(pos, C4), C4_str);
	char D4_str[100];
	img_for_piece(get_piece_at(pos, D4), D4_str);
	char E4_str[100];
	img_for_piece(get_piece_at(pos, E4), E4_str);
	char F4_str[100];
	img_for_piece(get_piece_at(pos, F4), F4_str);
	char G4_str[100];
	img_for_piece(get_piece_at(pos, G4), G4_str);
	char H4_str[100];
	img_for_piece(get_piece_at(pos, H4), H4_str);
	char A3_str[100];
	img_for_piece(get_piece_at(pos, A3), A3_str);
	char B3_str[100];
	img_for_piece(get_piece_at(pos, B3), B3_str);
	char C3_str[100];
	img_for_piece(get_piece_at(pos, C3), C3_str);
	char D3_str[100];
	img_for_piece(get_piece_at(pos, D3), D3_str);
	char E3_str[100];
	img_for_piece(get_piece_at(pos, E3), E3_str);
	char F3_str[100];
	img_for_piece(get_piece_at(pos, F3), F3_str);
	char G3_str[100];
	img_for_piece(get_piece_at(pos, G3), G3_str);
	char H3_str[100];
	img_for_piece(get_piece_at(pos, H3), H3_str);
	char A2_str[100];
	img_for_piece(get_piece_at(pos, A2), A2_str);
	char B2_str[100];
	img_for_piece(get_piece_at(pos, B2), B2_str);
	char C2_str[100];
	img_for_piece(get_piece_at(pos, C2), C2_str);
	char D2_str[100];
	img_for_piece(get_piece_at(pos, D2), D2_str);
	char E2_str[100];
	img_for_piece(get_piece_at(pos, E2), E2_str);
	char F2_str[100];
	img_for_piece(get_piece_at(pos, F2), F2_str);
	char G2_str[100];
	img_for_piece(get_piece_at(pos, G2), G2_str);
	char H2_str[100];
	img_for_piece(get_piece_at(pos, H2), H2_str);
	char A1_str[100];
	img_for_piece(get_piece_at(pos, A1), A1_str);
	char B1_str[100];
	img_for_piece(get_piece_at(pos, B1), B1_str);
	char C1_str[100];
	img_for_piece(get_piece_at(pos, C1), C1_str);
	char D1_str[100];
	img_for_piece(get_piece_at(pos, D1), D1_str);
	char E1_str[100];
	img_for_piece(get_piece_at(pos, E1), E1_str);
	char F1_str[100];
	img_for_piece(get_piece_at(pos, F1), F1_str);
	char G1_str[100];
	img_for_piece(get_piece_at(pos, G1), G1_str);
	char H1_str[100];
	img_for_piece(get_piece_at(pos, H1), H1_str);
	if (board->turn == WHITE_VAL) 
		sprintf(buffer, template,  A8_str, B8_str, C8_str, D8_str, E8_str, F8_str, G8_str, H8_str, A7_str, B7_str, C7_str, D7_str, E7_str, F7_str, G7_str, H7_str, A6_str, B6_str, C6_str, D6_str, E6_str, F6_str, G6_str, H6_str, A5_str, B5_str, C5_str, D5_str, E5_str, F5_str, G5_str, H5_str, A4_str, B4_str, C4_str, D4_str, E4_str, F4_str, G4_str, H4_str, A3_str, B3_str, C3_str, D3_str, E3_str, F3_str, G3_str, H3_str, A2_str, B2_str, C2_str, D2_str, E2_str, F2_str, G2_str, H2_str, A1_str, B1_str, C1_str, D1_str, E1_str, F1_str, G1_str, H1_str); 
	else
		sprintf(buffer, template,  A1_str, B1_str, C1_str, D1_str, E1_str, F1_str, G1_str, H1_str, A2_str, B2_str, C2_str, D2_str, E2_str, F2_str, G2_str, H2_str, A3_str, B3_str, C3_str, D3_str, E3_str, F3_str, G3_str, H3_str, A4_str, B4_str, C4_str, D4_str, E4_str, F4_str, G4_str, H4_str, A5_str, B5_str, C5_str, D5_str, E5_str, F5_str, G5_str, H5_str, A6_str, B6_str, C6_str, D6_str, E6_str, F6_str, G6_str, H6_str, A7_str, B7_str, C7_str, D7_str, E7_str, F7_str, G7_str, H7_str, A8_str, B8_str, C8_str, D8_str, E8_str, F8_str, G8_str, H8_str); 
}


