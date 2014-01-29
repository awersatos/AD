/**************************************************************************
**                                                                        *
**  FILE        :  stdio.h                                                *
**                                                                        *
**  DESCRIPTION :  Include file with prototypes and macros for            *
**                 input and output functions                             *
**                                                                        *
**  Copyright 1996-2008 Altium BV                                         *
**                                                                        *
**************************************************************************/

// FIXME: use better names for Altium Designer specific defines

#ifndef _STDIO_H
#define _STDIO_H

#ifdef  __cplusplus
extern "C" {
#endif  /* defined(__cplusplus) */


#include <stdarg.h>

#ifdef __POSIX_KERNEL__
#include <sys/types.h>
#endif

#if ( __POSIX_FILE_SYSTEM__ != 0 )
#include <limits.h>
#endif

#ifndef _SIZE_T_DEF
typedef __size_t        size_t;
#define _SIZE_T_DEF
#endif

/* fpos_t and wide character <-> multibyte characters conversion.
 *
 * Because in the current implementation in this C library MB_CUR_MAX and MB_LEN_MAX are defined as 1,
 * there will never occure an incomplete conversion. Hence, the mbstate_t of a position does not need
 * to be stored with the fpos_t.
 * However, when multibyte characters of more than 1 character are supported, consider the following example:
 *
 *      stream s == "(...)(..)(...)(...)(...)(...)" // where each () pair surrounds 1 multibyte character
 *
 * - a read returns 7 bytes of this stream.
 * - a conversion to wide characters gives us 2 wc's and an mbstate_t which contains the partially converted
 *   multibyte character.
 * - we do an fgetpos which returns an fpos_t
 * - we do and fsetpos to a diffrent position
 * - we return to the previous position using the returned fpos_t object from fgetpos()
 * - we call read and it returns 7 more bytes (containing the 1 remaining byte of the multibyte chararcter and
 *   2 more multibyte characters.
 * - when we try to convert these 7 bytes into their corresponding wide characters, we get undefined behavior
 *   because we start interpreting the 8th byte as it was the start of multibyte character (we lost the
 *   mbstate_t object telling us otherwise).
 *
 * The fgetpos and fsetpos need to store the mbstate_t with the position (as described in ISO/IEC
 * 9899:1990/Amendment 1:1995 (E) 7.9.2 Streams)
 * This can be done by defining fpos_t as a struct which contains not only the position, but
 * also an mbstate_t object.
 * fsetpos, fgetpos, fseek, ftell and fflush would need to be modified for this.
 * HOWEVER :
 * Since this would result in a far larger code base for our library and since MB_CUR_MAX and MB_LEN_MAX are
 * currently defined as 1 this hasn't been done. When this is implemented,
 * fflush.c
 * fgetpos.c
 * fseek.c
 * fsetpos.c
 * ftell.c
 * need to be changed since these files contain functions which use fpos_t .
 */
typedef unsigned long   fpos_t;

#ifdef  __cplusplus
#define NULL    (0)
#else   /* !defined(__cplusplus) */
#define NULL    ((void *) 0)
#endif  /* defined(__cplusplus) */

// FIXME: make configurable
#define BUFSIZ  512

#if ( __POSIX_FILE_SYSTEM__ != 0 )
#define _NFILE  OPEN_MAX
#else
#define _NFILE  10
#endif

typedef unsigned short  _iob_flag_t;

struct _iobuf
{
        char *          _ptr;
        char *          _base;
        int             _cnt;
        int             _bufsiz;
        _iob_flag_t     _flag;
        unsigned char   _file;
};


typedef struct _iobuf   FILE;

extern          FILE _iob[_NFILE];

#ifdef __cplusplus
#define stdin   _iob + 0
#define stdout  _iob + 1
#define stderr  _iob + 2
#else
#define stdin   (&_iob[0])
#define stdout  (&_iob[1])
#define stderr  (&_iob[2])
#endif /* defined(__cplusplus) */

#define EOF     (-1)

/*
 * The struct _iobuf "_flag" values should fit in an 8 bit char
 * unless wide character support is enabled.
 */
#define _IORD           ((unsigned short)0x01)  /* file is open for reading */
#define _IOWR           ((unsigned short)0x02)  /* file is open for writing */
#define _IOFBF          ((unsigned short)0x00)  /* fully buffered (not a flag!) */
#define _IONBF          ((unsigned short)0x04)  /* unbuffered */
#define _IOLBF          ((unsigned short)0x08)  /* line buffered */
#define _IOBUF          (_IOFBF|_IONBF|_IOLBF)  /* buffering flags */
#define _IOMYBUF        ((unsigned short)0x10)  /* must be freed after use */
#define _IOEOF          ((unsigned short)0x20)  /* end of file indicator for feof() */
#define _IOERR          ((unsigned short)0x40)  /* error indicator for ferror() */
#ifdef WCHAR_SUPPORT_ENABLED
#define _IOCHAR         ((unsigned short)0x80)  /* stream is byte oriented */
#define _IOWCHAR        ((unsigned short)0x100) /* stream is wide-char oriented */
#endif

#define FOPEN_MAX       _NFILE  /* stdin, stdout, stderr, stduser */

#if ( __POSIX_FILE_SYSTEM__ != 0 )
#define FILENAME_MAX    NAME_MAX
#else
#define FILENAME_MAX    100
#endif

#define SEEK_CUR        1
#define SEEK_END        2
#define SEEK_SET        0

/* Filenames generated by the tmpnam() function will be generated in the
 * current directory. All files are prefixed with "tmp" so the user should not
 * create files that start with "tmp".
 */
#define _P_tmpdir       "tmp"
#define L_tmpnam        (sizeof(_P_tmpdir) + 5)
#define TMP_MAX         0x8000

extern  int    fprintf  ( FILE * restrict, const char * restrict, ... ) __format__(printf,2,3);
extern  int    fscanf   ( FILE * restrict, const char * restrict, ... ) __format__(scanf,2,3);
extern  int    printf   ( const char * restrict, ... ) __format__(printf,1,2);
extern  int    scanf    ( const char * restrict, ... ) __format__(scanf,1,2);
extern  int    snprintf ( char * restrict, size_t, const char * restrict, ... ) __format__(printf,3,4);
extern  int    sprintf  ( char * restrict, const char * restrict, ... ) __format__(printf,2,3);
extern  int    sscanf   ( const char * restrict, const char * restrict, ... ) __format__(scanf,2,3);
extern  int    vfprintf ( FILE * restrict, const char * restrict, va_list ) __format__(printf,2,0);
extern  int    vfscanf  ( FILE * restrict, const char * restrict, va_list ) __format__(scanf,2,0);
extern  int    vprintf  ( const char * restrict, va_list ) __format__(printf,1,0);
extern  int    vscanf   ( const char * restrict, va_list ) __format__(scanf,1,0);
extern  int    vsnprintf( char * restrict, size_t, const char * restrict, va_list ) __format__(printf,3,0);
extern  int    vsprintf ( char * restrict, const char * restrict, va_list ) __format__(printf,2,0);
extern  int    vsscanf  ( const char * restrict, const char * restrict, va_list ) __format__(scanf,2,0);
extern  int    getc     ( FILE * );
extern  int    getchar  ( void );
extern  int    fgetc    ( FILE * );
extern  char * fgets    ( char * restrict, int, FILE * restrict );
extern  int    putc     ( int, FILE * );
extern  int    putchar  ( int );
extern  int    fputc    ( int, FILE * );
extern  int    fputs    ( const char * restrict, FILE * restrict );
extern  char * gets     ( char * );
extern  int    puts     ( const char * );
extern  void   clearerr ( FILE * );
extern  int    feof     ( FILE * );
extern  int    ferror   ( FILE * );
extern  void   perror   ( const char * );
extern  int    ungetc   ( int, FILE * );

/* Direct input/output */
extern  size_t fread    ( void * restrict, size_t, size_t, FILE * restrict );
extern  size_t fwrite   ( const void * restrict, size_t, size_t, FILE * restrict );
extern  FILE * fopen    ( const char * restrict, const char * restrict );
extern  FILE * fdopen   ( int , const char * restrict );
extern  FILE * freopen  ( const char * restrict, const char * restrict, FILE * restrict );
extern  int    fclose   ( FILE * );
extern  int    fflush   ( FILE * );
extern  int    setvbuf  ( FILE * restrict, char * restrict, int, size_t );
extern  void   setbuf   ( FILE * restrict, char * restrict );
extern  int    fgetpos  ( FILE * restrict , fpos_t * restrict );
extern  int    fseek    ( FILE * , long , int  );
extern  int    fsetpos  ( FILE * , const fpos_t *  );
extern  long   ftell    ( FILE *  );
extern  int    remove   ( const char * );
extern  int    rename   ( const char *, const char * );
extern  void   rewind   ( FILE * );
extern  FILE * tmpfile  ( void );
extern  char * tmpnam   ( char * );

/* Prototypes we need for getc()/putc() */
extern  int     _filbuf ( FILE * );
extern  int     _flsbuf ( int, FILE * );

#define getc(p)         (++(p)->_cnt<0 ? (unsigned char)(*(p)->_ptr++): _filbuf(p))
#define getchar()       getc(stdin)
#define putc(x,p)       (--(p)->_cnt>=0 ?                               \
                                (unsigned char)(*(p)->_ptr++=((char)(x))): \
                                _flsbuf((unsigned char)(x),p))
#define putchar(x)      putc(x,stdout)
#define feof(p)         (((p)->_flag&_IOEOF)!=0)
#define ferror(p)       (((p)->_flag&_IOERR)!=0)
#define fileno(p)       p->_file
#define clearerr(p)     ((void)(p->_flag &= ~(_IOEOF|_IOERR)))

#ifdef  __cplusplus
}
#endif  /* defined(__cplusplus) */

#endif  /* _STDIO_H */
