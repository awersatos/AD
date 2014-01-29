/*****************************************************************************\
|*
|* Copyright:   Copyright 2008, Altium
|*
|* Description: Dummy implementation of lseek to prevent inclusion of fss
|*              when using printf.
|*
\*****************************************************************************/

#include <limits.h>

#if ( (__POSIX_DEVIO__ != 0) && (__POSIX_FILE_SYSTEM__ == 0) )

#include <unistd.h>

extern off_t _lseek( int fd, off_t offset, int whence )
{
    return 0;
}

extern off_t lseek(int fd, off_t offset, int whence)
{
        return _lseek(fd, offset, whence);
}

#endif
