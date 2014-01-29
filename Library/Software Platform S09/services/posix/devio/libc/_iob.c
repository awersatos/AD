/**************************************************************************
**                                                                        *
**  FILE        :  _iob.c                                                 *
**                                                                        *
**  DESCRIPTION :  Source file with _iob structure definitions            *
**                 The streams 'stdin', 'stdout' and 'stderr' are         *
**                 already opened and ready to use.                       *
**                                                                        *
**  Copyright 1996-2006 Altium BV                                         *
**                                                                        *
**************************************************************************/

// FIXME: use better names for Altium Designer specific defines

#include <stdio.h>

#ifdef __POSIX_KERNEL__
#include <pthread.h>
#include <sys/types.h>
#endif

#if ( __POSIX_DEVIO__ == 0 ) // for devio stdin/stdout/stderr are initialized from posix_devio_init()

#ifndef STDIN_BUF
#define STDIN_BUF       80
#endif

#ifndef STDOUT_BUF
#define STDOUT_BUF      80
#endif

#if     STDIN_BUF > 0
static  char    stdin_buf[STDIN_BUF];
#endif

#if     STDOUT_BUF > 0
static  char    stdout_buf[STDOUT_BUF];
#endif

#else  /* __POSIX_DEVIO__ != 0 */

#undef STDIN_BUF
#undef STDOUT_BUF
#define STDIN_BUF       0
#define STDOUT_BUF      0

#endif

#if ( __POSIX_DEVIO__ != 0 && __POSIX_FILE_SYSTEM__ == 0 ) // FIXME: ???
/*
 * set the id's to -1 so write/read will be mapped to whatever devices where opened first
 * use freopen to connect streams to the correct device(s)
 */
#define STDIN_ID                -1
#define STDOUT_ID               -1
#define STDERR_ID               -1
#else
#define STDIN_ID                0
#define STDOUT_ID               1
#define STDERR_ID               2
#endif

#ifdef __POSIX_KERNEL__
// does not work because it is extern in stdio.h
//static
#endif
FILE    _iob[_NFILE] =
{
        /* stdin */
#if     STDIN_BUF > 0
        { stdin_buf,  stdin_buf,  0, STDIN_BUF,  _IORD + _IOLBF, STDIN_ID },
#else
        { NULL,       NULL,       0, EOF,        _IORD + _IONBF, STDIN_ID },
#endif
        /* stdout */
#if     STDOUT_BUF > 0
        { stdout_buf, stdout_buf, 0, STDOUT_BUF, _IOWR + _IOLBF, STDOUT_ID },
#else
        { NULL,       NULL,       0, EOF,        _IOWR + _IONBF, STDOUT_ID },
#endif
        /* stderr */
        { NULL,       NULL,       0, EOF,        _IOWR + _IONBF, STDERR_ID },
};


/*
 * Buffered input/output
 * ---------------------
 *
 * When a stream is unbuffered (_IONBF), the following conditions hold:
 *   _ptr    == NULL
 *   _base   == NULL
 *   _cnt    == 0 (output) -1 (input)
 *   _bufsiz is used as the "ungetc" buffer: EOF means empty
 *
 * When a stream is buffered, (_IOLBF or _IOFBF), the following holds:
 *   _base   is a valid buffer address
 *   _ptr    is a pointer into the buffer
 *   _bufsiz > 0
 *
 * After a buffered stream is opened and after a file positioning
 * operation, the following is true:
 *   _cnt    == 0
 *   _base   is a valid buffer address
 *   _ptr    == _base
 *
 * There is only one buffer which is shared for both reading and writing
 * but not at the same time. Meaning of _cnt is as follows:
 *
 *      >=0     free buffer space for buffered writes is _cnt bytes
 *      < 0     unread characters in input buffer is -_cnt - 1 bytes.
 *
 * After initialization, _cnt is always zero.
 * In [f]getc() and [f]putc() the _cnt member will be adjusted regardless of
 * the _iob state. At least in the macro versions this is required for
 * maximizing speed. So there are some special cases where _cnt and the
 * actual buffer disagree. This is solved by writing out (_ptr - _base) bytes
 * instead of _bufsiz minus _cnt and by compensating code in the _filbuf()
 * and _flsbuf() functions (read also their respective comment):
 *
 * _filbuf() _cnt range: -BUFSIZ..-1, exceptions upon entry and cause:
 *      _cnt == 0:      [f]getc incremented _cnt when input buffer is empty.
 *      _cnt > 0:       in addition, buffer still contains unflushed output.
 *
 * _flsbuf() _cnt range: 0..BUFSIZ-1, exceptions upon entry and cause:
 *      _cnt == -1:     [f]putc decremented _cnt when output buffer is full
 *      _cnt < -1:      in addition, buffer still contains unread input.
 *
 * On every file positioning operation, fflush() is called to write
 * the buffer to the file when the stream is in output mode, or to
 * discard the input buffer when the stream is in input mode.
 * Discarding the input buffer involves seeking back to the file
 * position of the first unread character. Although the ANSI-C
 * standard says that you may not switch from input to output mode
 * without an intervening file positioning operation except when EOF,
 * or from output to input mode without a file positioning operation or
 * fflush(), this situation is easy to detect, and so _filbuf() and _flsbuf()
 * will call _fflush() whenever such a switch is detected.
 */

#pragma extern  exit

/*
 * Close all open files. This function will be called from exit().
 */
void _doclose( void )
{
        int    i;

        for ( i = 0; i < _NFILE; i++ )
        {
                if ( _iob[i]._flag )
                {
                        fclose( &_iob[i] );
                }
        }
}

/*
 * When _iob[] is referenced, pull in the character I/O functions so that any
 * weak references to them are filled in. They need to because
 * (struct _io *)->fp referenced in _io_*.c might now be non-NULL.
 */
#pragma extern fgetc
#pragma extern fputc
#pragma extern ungetc
#ifdef WCHAR_SUPPORT_ENABLED
# pragma extern fgetwc
# pragma extern fputwc
# pragma extern ungetwc
#endif

#if ( __POSIX_KERNEL__ != 0 )
pthread_mutex_t _posix_file_mutex = PTHREAD_MUTEX_INITIALIZER;

FILE *posix_file_alloc(void)
{
        FILE *ret = NULL;
        int i;

        pthread_mutex_lock( &_posix_file_mutex );

        for ( i = 0; i < _NFILE; i++ )
        {
                if ( _iob[i]._flag == 0 )
                {
                        ret = &_iob[i];
                        break;
                }
        }

        if ( ret != NULL )
        {
                ret->_flag = 1;
        }

        pthread_mutex_unlock( &_posix_file_mutex );

        return ret;
}

void posix_file_free(FILE *fp)
{
        int i;

        for ( i = 0; i < _NFILE; i++ )
        {
                if ( &_iob[i] == fp )
                {
                        _iob[i]._flag = 0;
                        break;
                }
        }

}

#endif /* __POSIX_KERNEL__ */
