/******************************************************************************
|*
|*  COPYRIGHT:          Copyright 2008, Altium
|*
|*  DESCRIPTION:        Macro definition to handle debugging output and
|*                      asserts. Define __SSAS_DEBUG__ to enable this
|*                      functionality.
|*
\******************************************************************************/

#ifndef __UTIL_DEBUG_H
#define __UTIL_DEBUG_H

#ifdef __SSAS_DEBUG__

#include <stdio.h>
#include <stdlib.h>

#define ASSERT(x)               \
    {                           \
        if (!(x))               \
        {                       \
            printf( "\nAssertion '%s' failed in %s at line %d\n", #x, __FILE__, __LINE__); \
            abort();            \
        }                       \
    }

#define debug_printf            printf

#else

#define ASSERT(x)               do {} while (0)
#define debug_printf(...)       do {} while (0)

#endif /* __SSAS_DEBUG__ */

#endif /* __UTIL_DEBUG_H */

