/**************************************************************************
**                                                                        *
**  FILE        :  exit.c                                                 *
**                                                                        *
**  DESCRIPTION :  Source file for exit() routine                         *
**                                                                        *
**  Copyright 1996-2005 Altium BV                                         *
**                                                                        *
**************************************************************************/

extern void _doexit( void );

extern void _doclose( void );

#include <unistd.h>

extern void _Exit( int );

#pragma weak    _doexit
#pragma weak    _doclose
#pragma extern  _weakstub

void exit(int val)
{
        _doexit();              /* only when atexit() is used */
        _doclose();             /* only when _iob[] is referenced */
#if !defined(__POSIX_DEVIO__) && !defined(__POSIX_KERNEL__)
        _exit(val);
#endif
        _Exit( val );           /* never returns */
}
