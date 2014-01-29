/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    open
|*
\*****************************************************************************/

#include <limits.h>

/**
 *  @file stdio.h
 *      
 *      Besides what's shown below the following functions are also implemented:
 *
 *      clearerr(), close(), fclose(), fdopen(), feof(), ferror(),
 *      fflush(), fgetc(), fgets(), fileno(), fopen(), fprintf(),
 *      fputc(), fputs(), fread(), freopen(), fscanf(), fwrite(),
 *      getc(), getchar(), gets(), open(), perror(), printf(),
 *      putc(), putchar(), puts(), read(), scanf(), setbuf(),
 *      setvbuf(), stderr, stdin, stdout, ungetc(), vfprintf(),
 *      vfscanf(), vprintf(), vscanf(), write()
 *      
 *      See the C language reference manual for a more detailed description
 *      
 *      
 */


#if ( (__POSIX_DEVIO__ != 0) && (__POSIX_FILE_SYSTEM__ == 0) )

#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <devio.h>
#include <sysutils.h>


#pragma alias _open=open

extern int open(const char* path, int oflag, ...)
{

    int     fd = 0, ret;

    CANCELLATION_POINT();

     fd = devio_lookup ( path);
     if ( fd == -1 )
     {
       errno = EBADF; return -1;
     }

     ret = devio_open( devio_getdev(fd), oflag );

     if ( 0 != ret )
     {
        errno = ret; return -1;
     }

     return fd;
}

#endif

