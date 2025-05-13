#ifndef DATEHEADER
#define DATEHEADER
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdbool.h>
typedef struct {
	bool known_year;
	u_int16_t year;
	
	bool known_month;
	u_int8_t month;
	
	bool known_day;
	u_int8_t day;
} date_t;

// Parses a string specifying a date in the format of "YYYY<sep>MM<sep>DD".
// Returns 0 if properly parsed, else an error message 
const char *parse_date(date_t *dst, char *str); 

date_t unknown_date();

#endif
