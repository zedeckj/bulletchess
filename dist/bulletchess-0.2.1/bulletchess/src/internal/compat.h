#ifndef COMPATHEADER
#define COMPATHEADER
#include <stdint.h>
#define u_int8_t uint8_t
#define u_int16_t uint16_t
#define u_int32_t uint32_t
#define u_int64_t uint64_t


#if defined(_WIN32) || defined(_WIN64)

#define random() rand()

static inline u_int8_t  __builtin_popcountll(u_int64_t bb) {
	u_int8_t count = 0;
	while (bb & -bb) {
		bb &= ~(bb & -bb);
		++count;
	}
	return count;
}

#define strtok_r(...) strtok_s(__VA_ARGS__) 

#define srandom(X) NULL


#endif



#endif
