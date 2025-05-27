#ifndef DATEHEADER
#define DATEHEADER
#include "../compat.h"
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <stdio.h>
#include <stdbool.h>

typedef struct {
	bool known_year;
	uint16_t year;
	
	bool known_month;
	uint8_t month;
	
	bool known_day;
	uint8_t day;
} date_t;

// Parses a string specifying a date in the format of "YYYY<sep>MM<sep>DD".
// Returns 0 if properly parsed, else an error message 
const char *parse_date(date_t *dst, char *str); 

const char *make_date(date_t *dst, int year, int month, int day, bool known_y, bool known_m, bool known_d);

date_t unknown_date();

#endif
