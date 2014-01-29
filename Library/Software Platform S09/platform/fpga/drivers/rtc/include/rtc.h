/** @file
 *      Generic interface for Real Time Clock
 *
 * This device provides a generic interface for different RTCs
 */

#ifndef _RTC_H
#define _RTC_H
#include <time.h>

typedef struct _rtc_s rtc_t;

#ifdef  __cplusplus
extern "C" {
#endif

extern rtc_t *rtc_open(unsigned int id);
extern int rtc_get_time(rtc_t *rtc, struct tm *t);
extern int rtc_set_time(rtc_t *rtc, struct tm *t);

#ifdef  __cplusplus
}
#endif

#endif
