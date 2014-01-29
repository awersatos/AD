/******************************************************************************
 * FILE:        ioreq.h
 * DESCRIPTION:
 *      io request type
 *****************************************************************************/

#ifndef _IOREQ_H
#define _IOREQ_H

#include <sys/types.h>

typedef struct
{
        uint8_t     *buf;   /* application io request buffer */
        ssize_t     len;    /* number of bytes (standard i/o) or number of blocks (block i/o) */
        ssize_t     cnt;    /* number of bytes (standard i/o) or number of blocks (block i/o) written/read */
        ssize_t     offset; /* unused (standard i/o) or offset in blocks ( block i/o) */
} ioreq_t ;

#endif



