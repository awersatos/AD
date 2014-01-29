/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        S29 low level driver.
|*
\*****************************************************************************/

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
