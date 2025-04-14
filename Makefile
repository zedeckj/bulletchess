run:
	cc -W -O3 -fPIC -shared -o bulletchess/backend/chess_c.so bulletchess/backend/*.c bulletchess/backend/dictionary/*.c bulletchess/backend/tokenizer/*.c bulletchess/backend/date-parsing/*.c
