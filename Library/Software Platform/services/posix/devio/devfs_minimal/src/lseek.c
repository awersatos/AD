/*****************************************************************************\
|*
|* Copyright:   Copyright 2008, Altium
|*
|* Description: Dummy implementation of lseek to prevent inclusion of fss
|*              when using printf.
|*
\*****************************************************************************/

#include <limits.h>

#include <io.h>
#include <unistd.h>

extern long _lseek(_fd_t fd, long offset, _whence_t whence)
{
    return 0;
}

extern off_t lseek(int fd, off_t offset, int whence)
{
        return _lseek((_fd_t) fd, offset, (_whence_t) whence);
}

