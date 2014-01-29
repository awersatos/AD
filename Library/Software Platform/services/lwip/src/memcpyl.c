
/*
 * FILE         : memcpyl.c
 *
 * DESCRIPTION  : large size aligned memory
 * Copyright 1996-2009 Altium BV
 *
 */

typedef __size_t        size_t;
#include <stdint.h>

void *memcpyl( void * restrict s, const void * restrict ct, size_t n )
{
    uintptr_t so = (uintptr_t)s;

    if (n > 7)                                     // if n < 8, copy bytewise to avoid too much overhead
    {
        if ((so & 3) == ((uintptr_t)ct & 3))        // both have the same 4-byte alignment
        {
            while (so & 3)                          // align to 4-byte boundary
            {
                *(int8_t *)so = *(int8_t *)ct;
                so++;
                ct = (int8_t *)ct + 1;
                n--;
            }
            while (n > 3)                           // copy per 4 byte
            {
                *(int32_t *)so = *(int32_t *)ct;
                so += 4;
                ct = (int32_t *)ct + 1;
                n -= 4;
            }
        }
        else if ((so & 1) == ((uintptr_t)ct & 1))   // both have the same 2-byte alignment
        {
            if (so & 1)                             // align to 2-byte boundary
            {
                *(int8_t *)so = *(int8_t *)ct;
                so++;
                ct = (int8_t *)ct + 1;
                n--;
            }
            while (n > 1)                           // copy per 2 byte
            {
                *(int16_t *)so = *(int16_t *)ct;
                so += 2;
                ct = (int16_t *)ct + 1;
                n -= 2;
            }
        }
    }

    while (n--)                                     // copy remainder bytewise
    {
        *(int8_t *)so = *(int8_t *)ct;
        so++;
        ct = (int8_t *)ct + 1;
    }

    return (void *)s;
}

