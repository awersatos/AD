/*
 * NAME
 *  dirent.h - format of directory entries
 *
 * SYNOPSIS
 *  #include <dirent.h>
 */

// NOTE: not all functions defined by the posix standard are supported

#ifndef _DIRENT_H
#define _DIRENT_H

#include <limits.h>
#include <sys/types.h>

#ifdef  __cplusplus
extern "C" {
#endif  /* defined(__cplusplus) */

typedef void *  DIR;

struct dirent {
    ino_t   d_ino;                   /* File serial number. */
    char    d_name[NAME_MAX + 1];    /* Name of entry.      */
};

extern int              closedir(DIR *);
extern DIR              *opendir(const char *);
extern struct dirent    *readdir(DIR *);
extern void             rewinddir(DIR *);

// Not implemented:
//extern int      readdir_r(DIR *restrict, struct dirent *restrict, struct dirent **restrict);
//extern void     seekdir(DIR *, long);
//extern long     telldir(DIR *);

#ifdef  __cplusplus
}
#endif  /* defined(__cplusplus) */

#endif /* _DIRENT_H */
