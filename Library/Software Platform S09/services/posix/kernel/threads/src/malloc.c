/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    malloc
|*
\*****************************************************************************/

#pragma profiling off

#include <stdlib.h>

/* ---------------------- _malloc.h ------------------- */
#include <stddef.h>

typedef unsigned long   msize_t;        /* malloc block size */
typedef char*           mptr_t;         /* malloc pointer type */

struct  align
{
        char    c;
        union
        {
                void*           p;
                long long       ll;
                double          d;
        }       u;
};

#define MINALIGN        ((int)offsetof(struct align, u))
#define ALIGN           (MINALIGN > 2 ? MINALIGN : 2)
#define ALIGNED(x)      (((x) + ALIGN - 1) & ~ (ALIGN - 1))
#define HEADER          ALIGNED(sizeof(msize_t))
/* ---------------------- _malloc.h ------------------- */

#include <interrupts.h> 

/* -------------------- external definitions ------------------ */

extern  void*   _sbrk ( long );

#define NOMEM   ((char*) -1)    /* (char*)_sbrk() return value */

/* -------------------- variables ----------------------------- */

static  mptr_t  head;           /* head of memory block list */
static  mptr_t  start;          /* starting point for block search */

/* -------------------- global functions ---------------------- */

extern  void*   malloc ( size_t size )
{
        mptr_t  p;
        mptr_t  next;
        mptr_t  mem;
        msize_t s;
        msize_t s2;
        int     align;

        if      ( size == 0 )
        {
                return NULL;
        }

        posix_interrupts_disable();

        size = HEADER + ALIGNED(size);
        if      ( ! start )
        {       /* initialize on first call */
                /* the break may be unaligned; calculate alignment */
                align = (- (int) (long) (char*)_sbrk( 0 )) & (ALIGN-1);
                mem = (char*)_sbrk( align + HEADER );
                if      ( mem == NOMEM )
                {
                        posix_interrupts_enable();
                        return NULL;
                }
                head = start = mem + align;
                *(msize_t*)head = 0;    /* end marker */
        }
        while   ( (s = *(msize_t*)start) && (s & 1) )
        {
                start += s - 1;
        }
        for     ( p = start
                ; (s = *(msize_t*)p) && ((s & 1) || size > s)
                ; p = next
                )
        {
                next = p + (s & ~ 1);
                if      ( ! (s & 1) )
                {       /* free block */
                        s2 = *(msize_t*)next;
                        if      ( s2 == 0 )
                        {       /* last free block is too small, so remove it */
                                if      (  (char*)_sbrk( 0 ) == next + HEADER
                                        && (char*)_sbrk( - (long) s ) != NOMEM
                                        )
                                {
                                        *(msize_t*)p = 0; /* new end marker */
                                        s = 0;
                                        break;
                                }
                        }
                        else if ( ! (s2 & 1) )
                        {       /* merge two consecutive free blocks */
                                *(msize_t*)p = s + s2;
                                next = p;
                        }
                }
        }
        if      ( s == 0 )
        {       /* nothing found, so allocate more memory */
                mem = (char*)_sbrk( size );
                if      ( mem == NOMEM )
                {
                        posix_interrupts_enable();
                        return NULL;
                }
                if      ( mem < p + HEADER )
                {       /* someone called (char*)_sbrk() with a negative value! */
                        posix_interrupts_enable();
                        return NULL;
                }
                if      ( mem > p + HEADER )
                {       /* (char*)_sbrk() was called: encapsulate the memory */
                        /* the break may be unaligned; calculate alignment */
                        align = (- (int) (long) mem) & (ALIGN-1);
                        if      ( (char*)_sbrk( align + HEADER ) == NOMEM )
                        {
                                posix_interrupts_enable();
                                return NULL;
                        }
                        mem += align;
                        *(msize_t*)p = (mem - p) | 1; /* mark as allocated */
                        p = mem;
                }
                *(msize_t*)(p + size) = 0;      /* new end marker */
        }
        else if ( s >= size + HEADER )
        {       /* the free block is big enough to split */
                next = p + size;
                *(msize_t*)next = s - size;
        }
        else
        {       /* use complete block */
                size = (size_t) s;
        }
        *(msize_t*)p = size | 1;                /* mark block as allocated */

        posix_interrupts_enable();

        return (void*) (p + HEADER);
}

extern  void    free ( void* mem )
{
        mptr_t  p;
        mptr_t  p2;
        msize_t s;
        msize_t s2;

        if      ( ! mem )
        {
                return;
        }

        posix_interrupts_disable();

        p = (mptr_t)mem - HEADER;
        s = *(msize_t*)p & ~ 1;                 /* mark block as free */
        /*
         * try to merge block with successor(s)
         */
        for     ( ;; )
        {
                *(msize_t*)p = s;
                p2 = p + s;
                s2 = *(msize_t*)p2;
                if      ( ! s2 || (s2 & 1) )
                {
                        break;
                }
                s += s2;                        /* merge free blocks */
        }
        /*
         * try to merge with first free block
         */
        if      ( start + *(msize_t*)start == p )
        {       /* start points to a preceding free block */
                s += *(msize_t*)start;
                *(msize_t*)start = s;           /* merge free blocks */
                p = start;
        }
        /*
         * try to reduce core
         */
        if      (  s2 == 0
                && (char*)_sbrk( 0 ) == p2 + HEADER
                && (char*)_sbrk( - (long) s ) != NOMEM
                )
        {
                *(msize_t*)p = 0;               /* new end marker */
        }
        /*
         * update 'start'
         */
        if      ( p < start )
        {
                start = p;
        }

        posix_interrupts_enable();

    return;
}

