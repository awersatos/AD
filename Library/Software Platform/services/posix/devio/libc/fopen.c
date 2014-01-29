/**************************************************************************
**                                                                        *
**  FILE        :  fopen.c                                                *
**                                                                        *
**  DESCRIPTION :  Source file for fopen() routine                        *
**                 Searches for an empty stream and opens it              *
**                                                                        *
**  Copyright 1996-2006 Altium BV                                         *
**                                                                        *
**************************************************************************/

// FIXME: use better names for Altium Designer specific defines

#include <stdio.h>
#include <io.h>

FILE *fopen(const char * restrict file, const char * restrict mode)
{
        FILE    *fp;
#ifndef __POSIX_KERNEL__
        int     i;
#endif

#ifdef __POSIX_KERNEL__
        fp = posix_file_alloc();
        if (fp != NULL)
        {
                /* no locking of fp necessary (because no one else has it) */
                if (_fopen(file, mode, fp, -1))
                {
                        return fp;
                }
                posix_file_free(fp);
        }
#else /* __POSIX */
        for (i = 0; i < _NFILE; ++i)
        {
                fp = &_iob[i];
                if (!fp->_flag)
                {
                        if (_fopen(file, mode, fp, -1))
                        {
                                return fp;
                        }
                        break;
                }
        }
#endif /* else __POSIX_KERNEL__ */

        return NULL;
}
