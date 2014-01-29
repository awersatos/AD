/*
 * NAME
 *  dirent.h - format of directory entries
 *
 * SYNOPSIS
 *  #include <dirent.h>
 */

// FIXME: implement all prototypes defined here

#ifndef _DIRENT_H
#define _DIRENT_H

#include <limits.h>
//#ifdef XSI
#include <sys/types.h>
//#endif

#ifdef  __cplusplus
extern "C" {
#endif  /* defined(__cplusplus) */

typedef void *  DIR;

struct dirent {
//#ifdef XSI
    ino_t   d_ino;      /* File serial number.      */
//#endif
    char    d_name[NAME_MAX + 1];    /* Name of entry.       */
};


extern int      closedir(DIR *);
extern DIR      *opendir(const char *);
extern struct dirent    *readdir(DIR *);
//#ifdef TSF Thread-Safe Functions
extern int      readdir_r(DIR *restrict, struct dirent *restrict, struct dirent **restrict);
//#endif
extern void     rewinddir(DIR *);
//#ifdef XSI
extern void     seekdir(DIR *, long);
extern long     telldir(DIR *);
//#endif

#ifdef  __cplusplus
}
#endif  /* defined(__cplusplus) */

#endif /* _DIRENT_H */
