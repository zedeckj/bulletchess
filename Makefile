all:
	cc -W -O3 -fPIC -shared -o bulletchess/backend/chess_c.so bulletchess/backend/*.c bulletchess/backend/dictionary/*.c bulletchess/backend/tokenizer/*.c bulletchess/backend/date-parsing/*.c
#inspect:
#	cc -S -W -O3 -fPIC -shared bulletchess/backend/*.c bulletchess/backend/dictionary/*.c bulletchess/backend/tokenizer/*.c bulletchess/backend/date-parsing/*.c

#debug:
#	cc -fsanitize=undefined -fno-sanitize=alignment -fsanitize=address -W -shared -o bulletchess/backend/chess_c.so bulletchess/backend/*.c bulletchess/backend/dictionary/*.c bulletchess/backend/tokenizer/*.c bulletchess/backend/date-parsing/*.c 
