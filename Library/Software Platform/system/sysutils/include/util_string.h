////////////////////////////////////////////////////////////////////////////////
// util_string.h

#ifndef __STRING_UTIL_H
#define __STRING_UTIL_H

#include <stdio.h>
#include <stdint.h>

////////////////////////////////////////////////////////////////////////////////
#define strncasecmp     __strnicmp
#define strcasecmp      __stricmp
#define strnstr         __strnstr
#define strdup          __strdup

////////////////////////////////////////////////////////////////////////////////
extern int __strnicmp(const char * cs,const char * ct,size_t count);
extern int __stricmp(const char * cs,const char * ct);
extern char *__strnstr(const char *cs, const char *ct, size_t n);
extern char *__strdup(const char *s);



#endif // __STRING_UTIL_H
