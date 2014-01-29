/**************************************************************************
**                                                                        *
**  FILE        :  fdopen.c                                               *
**                                                                        *
**  DESCRIPTION :  Source file for fdopen() routine                       *
**                 Searches for an empty stream and assignes id to it     *
**                                                                        *
**  Copyright 1996-2006 Altium BV                                         *
**                                                                        *
**************************************************************************/

// FIXME: use better names for Altium Designer specific defines

#include <stdio.h>
#include <io.h>

FILE *fdopen(int fildes, const char * restrict mode)
{
        FILE    *fp;

#if ( __POSIX_KERNEL__ != 0 )
        fp = posix_file_alloc();

        if (_fopen(NULL, mode, fp, fildes))
        {
                return fp;
        }
        else
        {
                posix_file_free(fp);
        }
#else
        for (int i = 0; i < _NFILE; ++i)
        {
                fp = &_iob[i];
                if (!fp->_flag)
                {
                        if (_fopen(NULL, mode, fp, fildes))
                        {
                                return fp;
                        }
                        break;
                }
        }
#endif /* __POSIX_KERNEL__ */

        return NULL;
}
