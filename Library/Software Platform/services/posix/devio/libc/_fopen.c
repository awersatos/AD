/**************************************************************************
**                                                                        *
**  FILE        :  _fopen.c                                               *
**                                                                        *
**  DESCRIPTION :  The real work of fopen() and freopen()                 *
**                                                                        *
**  Copyright 1996-2008 Altium BV                                         *
**                                                                        *
**************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <io.h>

/*
 * When _fopen is referenced, pull in the free function so that weak
 * reference _dofree in fclose is filled in.
 */
#pragma extern free

/*
 * Parse the fopen mode string and initialize _flag and _fd when the
 * file open succeeds. Next, try to get file buffering. Gracefully
 * handle malloc() stubs which refuse to allocate anything by simply
 * switching to unbuffered mode in that case.
 *
 * Return nonzero for success.
 */
int _fopen(const char *file, const char *mode, FILE *fp, int fd)
{
        _open_flags_t   open_flags;
        _iob_flag_t     flag;
        char            c;

        open_flags = 0;
        flag = 0;
        while ((c = *mode++))
        {
                switch (c)
                {
                case 'r':
                        open_flags = O_RDONLY;
                        flag = _IORD;
                        break;
                case 'w':
                        open_flags = O_WRONLY | O_CREAT | O_TRUNC;
                        flag = _IORW;
                        break;
                case 'a':
                        open_flags = O_WRONLY | O_CREAT | O_APPEND;
                        flag = _IORW;
                        break;
                case 'b':
                        open_flags |= O_BINARY;
                        break;
#ifdef O_PACKED
                case '8':
                        open_flags |= O_PACKED;
                        break;
#endif
                case '+':
                        open_flags = (open_flags & ~O_ACCMODE) | O_RDWR;
                        flag = _IORD | _IORW;
                        break;
                default:
                        break;
                }
        }

		/* fdopen passes the already opened id, fopen and freopen pass -1 */
        if (fd == -1)
        {
        	    fd = _open(file, open_flags);
		}

        if (fd >= 0)
        {
                fileno(fp) = (unsigned char)fd;
                fp->_base = malloc(BUFSIZ);
                fp->_ptr = fp->_base;
                fp->_cnt = 0;
                if (fp->_base)
                {
                        flag |= _IOFBF | _IOMYBUF;
                        fp->_bufsiz = BUFSIZ;
                }
                else
                {
                        flag |= _IONBF;
                        fp->_bufsiz = EOF;      /* no ungetc() character yet */
                }
                fp->_flag = flag;
                return 1;
        }
        return 0;
}
