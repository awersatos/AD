/**
 * @file
 *      Device driver for PCF2123 (Real Time Clock) peripheral.
 *
 */

#ifndef _PCF2123_H
#define _PCF2123_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <time.h>

typedef struct drv_pcf2123_s pcf2123_t;

extern pcf2123_t * pcf2123_open( unsigned int id );
extern int pcf2123_get_time( pcf2123_t * drv, struct tm * t );
extern int pcf2123_set_time( pcf2123_t * drv, struct tm * t );

#ifdef  __cplusplus
}
#endif


#endif /* _PCF2123_H */

