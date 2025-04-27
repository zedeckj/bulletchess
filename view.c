#include <stdint.h>

void _move_body(int);

void _add_from_bitboard(uint8_t *array, uint32_t index, uint32_t value, uint32_t *result) {
    uint64_t x19 = (uint64_t)array;
    uint64_t x20 = (uint64_t)index;
    uint64_t x21 = (uint64_t)value;
    uint64_t x22 = (uint64_t)result;
    uint32_t x24 = 0;

    if (x21 == 0) {
        return;
    }

    do {
        x24++;
        if (x24 == 64) {
            break;
        }
        uint64_t x8 = x21 >> x24;
        if ((x8 & 1) == 0) {
            continue;
        }

        uint8_t w25 = *(uint8_t *)x19;
        uint8_t w8 = w25 + 1;
        *(uint8_t *)x19 = w8;

        uint32_t w1 = x24 & 0xff;
        uint64_t x0 = x22;
        _move_body(x0); // Assuming _move_body is defined elsewhere

        uint32_t x23 = (x0 & 0xFFFF);
        *(uint32_t *)(x20 + (w25 << 2)) = x23;

    } while (1);
}
