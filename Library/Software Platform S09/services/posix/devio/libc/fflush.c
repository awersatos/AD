/**************************************************************************
**                                                                        *
**  FILE        :  fflush.c                                               *
**                                                                        *
**  DESCRIPTION :  Source file for fflush() routine                       *
**                 Flushes the input or output buffer of a file.          *
**                                                                        *
**  Copyright 1996-2008 Altium BV                                         *
**                                                                        *
**************************************************************************/

#include <stdio.h>
#include <io.h>

/*
 * The core fflush() routine. Cleanup the buffer state as if the
 * file handle has just been returned by fopen()/freopen(). Buffered
 * input is undone by seeking back. The code seems to contain a very subtle
 * bug by emptying the unget buffer using a seek: what we unget may not
 * be identical to what we've read. But somehow it seems impossible to
 * trip over this bug without crossing the land of "undefined behavior"
 * in the standards.
 */
int _fflush(FILE *fp)
{
        int             status = 0;
        long            off = 0;
        char            *base;
        __ptrdiff_t     n;

        if (!(fp->_flag & _IONBF))              /* buffering ? */
        {
                base = fp->_base;
                if (fp->_cnt < 0)               /* input mode */
                {
                        off = fp->_cnt + 1;
                }
                else                            /* output mode */
                {
                        n = fp->_ptr - base;
                        if (n > 0 && _write(fileno(fp), base, n) != n)
                        {
                                fp->_flag |= _IOERR;
                                status = EOF;
                        }
                }
                fp->_ptr = base;                /* reset buffer ptr */
                fp->_cnt = 0;
        }
        else if (fp->_bufsiz != EOF)            /* ungetc buffer occupied ? */
        {
                off = -1;
                fp->_bufsiz = EOF;              /* reset unget buffer */
        }
        if (off && _lseek(fileno(fp), off, SEEK_CUR) == -1)
        {
                fp->_flag |= _IOERR;
                status = EOF;
        }
        return status;
}

/*
 * fflush() should not try to recurse for the NULL case because that won't
 * work for architectures with non-reentrant memory models.
 * 
 * fflush() behavior for input streams is undefined. The core _fflush()
 * routine will seek back to get rid of buffered input in preparation for
 * buffering output. However, fflush(0) should not try to do that because
 * the lseek operation is not always supported (try that on an UART).
 */
int fflush(FILE *fp)
{
        int     status;

        if (fp)
        {
                status = _fflush(fp);
        }
        else
        {
                status = 0;
                for (fp = &_iob[0]; fp < &_iob[_NFILE]; ++fp)
                {
                        if (fp->_cnt >= 0)
                        {
                                status |= _fflush(fp);
                        }
                }
        }
        return status;
}
