/**************************************************************************
**                                                                        *
**  FILE        :  io.h                                                   *
**                                                                        *
**  DESCRIPTION :  Prototype I/O stubs the C library depends on: _open(), *
**                 _read(), _write(), _lseek(), _close() and _unlink().   *
**                                                                        *
**  Copyright 1996-2008 Altium BV                                         *
**                                                                        *
**************************************************************************/

// FIXME: use better names for Altium Designer specific defines

#ifndef _IO_H
#define _IO_H

#include <stdio.h>
#include <stdarg.h>

#ifdef __POSIX_KERNEL__
#include <sys/types.h>
#include <pthread.h>
#endif

#ifdef  __cplusplus
extern "C" {
#endif


#ifndef _SIZE_T_DEF
typedef __size_t        size_t;
#define _SIZE_T_DEF
#endif


struct _io
{
        FILE *  fp;     /* NULL for I/O on strings. MUST BE FIRST. */
        char *  ptr;    /* next character in string */
        char *  end;    /* one beyond last character in string */
};


/*
 * It is not necessary to be exactly POSIX so let's make some
 * small deviations in the types to get small code. This is
 * important for _open(), _read(), _write(), _lseek() and
 * _close() because they tend to be pulled in even for minimalistic
 * (test) applications.
 *
 * Type definitions such as _fd_t define the types for low level I/O
 * function arguments. This may slightly deviate from types inside FILE.
 */
#include <stdint.h>
typedef uint_least8_t   _fd_t;          /* for holding a file descriptor */
typedef int_least8_t    _err_t;         /* for holding a file descriptor and -1 */
typedef uint_least16_t  _open_flags_t;  /* for holding the O_* flags from fcntl.h */
typedef uint_least8_t   _whence_t;      /* 3rd _lseek() argument */

/*
 * Helper functions for standard I/O
 */
extern  int             _fopen(const char *file, const char *mode, FILE *fp, int fd);
extern  int             _fflush(FILE *fp);
extern  int             _doprint(struct _io *fp, const char *fmt, va_list ap);
extern  int             _doscan(struct _io *fp, const char *fmt, va_list ap);

/*
 * Helper functions for standard I/O when wide character support is enabled
 */
#ifdef WCHAR_SUPPORT_ENABLED
#include <wchar.h>
extern  wint_t          _wflsbuf(wint_t c, FILE *fp);
extern  wint_t          _wfilbuf(FILE *fp);
extern  int             _dowprint(struct _io *fp, const wchar_t *fmt, va_list ap);
extern  int             _dowscan(struct _io *fp, const wchar_t *fmt, va_list ap);
#endif

/*
 * Helper functions when wide character support is enabled
 */
#ifdef WCHAR_SUPPORT_ENABLED
extern  int             _dofls(int c, FILE *fp);
extern  int             _dofil(FILE *fp);
#endif

/*
 * With the exception of _unlink() these are all weak aliases so we can stack
 * a unified I/O layer on top of the real functions.
 */


extern  _err_t  _open(const char *pathname, _open_flags_t flags);
extern  int     _read(_fd_t fd, void *buffer, size_t nbytes);
extern  int     _write(_fd_t fd, const void *buffer, size_t nbytes);
extern  long    _lseek(_fd_t fd, long offset, _whence_t whence);
extern  _err_t  _close(_fd_t fd);
extern  int     _unlink(const char *pathname);

/*
 * The real functions.
 */
extern  _err_t          _host_open(const char *pathname, _open_flags_t flags);
extern  int             _host_read(_fd_t fd, void *buffer, size_t nbytes);
extern  int             _host_write(_fd_t fd, const void *buffer, size_t nbytes);
extern  long            _host_lseek(_fd_t fd, long offset, _whence_t whence);
extern  _err_t          _host_close(_fd_t fd);

/*
 * Functions which split formatted I/O into file or string version
 */
extern  int             _io_getc(struct _io *io);
extern  void            _io_putc(int c, struct _io *io);
extern  void            _io_puts(const char *s, struct _io *io);
extern  void            _io_ungetc(int c, struct _io *io);
#ifdef WCHAR_SUPPORT_ENABLED
extern  wint_t          _io_getwc(struct _io *io);
extern  void            _io_putwc(wchar_t c, struct _io *io);
extern  void            _io_putws(const wchar_t *s, struct _io *io);
extern  void            _io_ungetwc(wint_t c, struct _io *io);
#endif

#ifdef __POSIX_KERNEL__
extern FILE *posix_file_alloc(void);
extern void posix_file_free(FILE *fp);
#endif /* __POSIX_KERNEL__ */

#ifdef  __cplusplus
}
#endif

#endif
