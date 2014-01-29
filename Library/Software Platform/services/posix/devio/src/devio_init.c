
#include <limits.h>

#include <stdio.h>
#include <stdint.h>
#include <fcntl.h>
#include <unistd.h>
#include <io.h>
#include <init.h>
#include <string.h>
#include <devio.h>

#include "posix_devio_cfg.h"

/* extract these from ssas library (just in case) */
#pragma extern open
#pragma extern close
#pragma extern read
#pragma extern write

/* forward declaration */

#if ( POSIX_DEVIO_STDIN != 0 || POSIX_DEVIO_STDOUT != 0 || POSIX_DEVIO_STDERR != 0 )
static void stdio_init(void);
#endif

/* plugin initialization */

extern void posix_devio_init (void )
{
#if ( POSIX_DEVIO_STDIN != 0 || POSIX_DEVIO_STDOUT != 0 || POSIX_DEVIO_STDERR != 0 )
# if ( __POSIX_KERNEL__ != 0 )
    posix_mainhook_install( stdio_init, 16 );
# else
    stdio_init();
# endif
#endif
}

/* initialize stdin/stdout/stderr */

#if ( POSIX_DEVIO_STDIN != 0 || POSIX_DEVIO_STDOUT != 0 || POSIX_DEVIO_STDERR != 0 )

/* buffers */
#if ( POSIX_DEVIO_STDIN != 0 && POSIX_DEVIO_STDIN_BUFTYPE != POSIX_DEVIO_STDIN_BUFTYPE_NONE )
# ifndef POSIX_DEVIO_STDIN_BUFSIZE
# define POSIX_DEVIO_STDIN_BUFSIZE 80
# endif
static char stdin_buf [ POSIX_DEVIO_STDIN_BUFSIZE ];
#endif

#if ( POSIX_DEVIO_STDOUT != 0 && POSIX_DEVIO_STDOUT_BUFTYPE != POSIX_DEVIO_STDOUT_BUFTYPE_NONE )
# ifndef POSIX_DEVIO_STDOUT_BUFSIZE
# define POSIX_DEVIO_STDOUT_BUFSIZE 80
# endif
static char stdout_buf [ POSIX_DEVIO_STDOUT_BUFSIZE ];
#endif

/* helper functions */
static inline int get_buf_flags ( int cfg )
{
    int retval =   ~_IOBUF;

    switch ( cfg )
    {
        case 0: retval = _IONBF; break;
        case 1: retval = _IOFBF; break;
        case 2: retval = _IOLBF; break;
        default: break;
    }
    return retval;
}

/* reopen stdin/stdout/stderr */
static void stdio_init(void)
{
#if ( __POSIX_FILE_SYSTEM__ != 0 )

# define SET_DEV_NAME( result, name )   strncpy( result + 5, name, NAME_MAX )

    char stdname[NAME_MAX + 6];

    strcpy( stdname, "/dev/" );
#else

# define SET_DEV_NAME( result, name )   result = name

    const char *stdname;
#endif

#if ( POSIX_DEVIO_STDIN != 0 )
    SET_DEV_NAME( stdname, (POSIX_DEVIO_STDINDEV)->name );
    if ( freopen ( stdname, "w+", stdin ) != NULL )
    {
# if POSIX_DEVIO_STDIN_BUFTYPE != POSIX_DEVIO_STDIN_BUFTYPE_NONE
        setvbuf ( stdin, stdin_buf, get_buf_flags( POSIX_DEVIO_STDIN_BUFTYPE ),sizeof(stdin_buf) );
# else
        setvbuf ( stdin, NULL, _IONBF, 0 );
# endif
    }
#endif

#if ( POSIX_DEVIO_STDOUT != 0 )
    SET_DEV_NAME( stdname, (POSIX_DEVIO_STDOUTDEV)->name );
    if ( freopen ( stdname, "w+", stdout ) != NULL )
    {
# if POSIX_DEVIO_STDOUT_BUFTYPE != POSIX_DEVIO_STDOUT_BUFTYPE_NONE
        setvbuf ( stdout, stdout_buf,get_buf_flags( POSIX_DEVIO_STDOUT_BUFTYPE ), sizeof(stdout_buf));
# else
        setvbuf ( stdout, NULL, _IONBF, 0 );
# endif
    }
#endif

#if ( POSIX_DEVIO_STDERR != 0 )
    SET_DEV_NAME( stdname, (POSIX_DEVIO_STDERRDEV)->name );
    if ( freopen ( stdname, "w+", stderr ) != NULL )
    {
        setvbuf ( stderr, NULL, _IONBF, 0 );
    }
#endif

#undef SET_DEV_NAME
}

#endif /* ( POSIX_DEVIO_STDIN != 0 || POSIX_DEVIO_STDOUT != 0 || POSIX_DEVIO_STDERR != 0 ) */
