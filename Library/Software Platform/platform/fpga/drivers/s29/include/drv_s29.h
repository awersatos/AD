/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        S29 low level driver.
|*
\*****************************************************************************/

/**
 * @file
 * Low-level driver for the S29 parallel flash on the shared memory controller.
 * Usually applications will access the device through a higher level interface.
 *
 */

#ifndef _DRV_S29_H
#define _DRV_S29_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

typedef struct s29_s s29_t;

extern s29_t *s29_open( int id );

extern int s29_erase_sector( s29_t * restrict  s29, size_t offset );

extern int s29_erase( s29_t * restrict  s29 );

extern int s29_program( s29_t * restrict  s29, size_t offset, void *memptr, size_t bytes );

extern int s29_program_block( s29_t * restrict  s29, size_t offset, void *memptr, size_t bytes );

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_S29_H */
