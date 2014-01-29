#include <stdint.h>
#include "pal.h"


int pal_lsbit32_index(uint32_t val32) __attribute__((weak))
{
    int fb;

    val32 &= -(int32_t)val32;
    if (!(val32 & 0x55555555)) fb = 1; else fb = 0;
    if (!(val32 & 0x33333333)) fb |= 2;
    if (!(val32 & 0x0F0F0F0F)) fb |= 4;
    if (!(val32 & 0x00FF00FF)) fb |= 8;
    if (!(val32 & 0x0000FFFF)) fb |= 16;

    return fb;
}


int pal_lsbit64_index(uint64_t val64) __attribute__((weak))
{
    uint32_t high_part;
    uint32_t low_part = (uint32_t)(val64 & 0xffffffffU);
    if (low_part)
    {
        return pal_lsbit32_index(low_part);
    }
    else
    {
        high_part = (uint32_t)((val64 >> 32) & 0xffffffffU);
        return 32 + pal_lsbit32_index(high_part);
    }
}


int pal_msbit32_index(uint32_t val32) __attribute__((weak))
{
    int c = -1;

    if (val32 & 0xFFFF0000)
    {
        c = 0x10;
        val32 &= 0xFFFF0000;
    }
    else
    {
        c = 0x00;
    }

    if (val32 & 0xFF00FF00)
    {
        c |= 0x08;
        val32 &= 0xFF00FF00;
    }

    if (val32 & 0xF0F0F0F0)
    {
        c |= 0x04;
        val32 &= 0xF0F0F0F0;
    }

    if (val32 & 0xCCCCCCCC)
    {
        c |= 0x02;
        val32 &= 0xCCCCCCCC;
    }

    if (val32 & 0xAAAAAAAA)
    {
        c |= 0x01;
        val32 &= 0xAAAAAAAA;
    }

    return c;
}


int pal_msbit64_index(uint64_t val64) __attribute__((weak))
{
    uint32_t high_part = (uint32_t)((val64 >> 32) & 0xffffffffU);
    uint32_t low_part;

    if (high_part)
    {
        return 32 + pal_msbit32_index(high_part);
    }
    else
    {
        low_part = (uint32_t)(val64 & 0xffffffffU);
        return pal_msbit32_index(low_part);
    }
}

