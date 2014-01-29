////////////////////////////////////////////////////////////////////////////////
// swp_tsleep.h

#ifndef __SWP_TSLEEP_H
#define __SWP_TSLEEP_H

#ifdef  __cplusplus
extern "C" {
#endif

#define PCATCH 0

////////////////////////////////////////////////////////////////////////////////
int tsleep(const void *ident, int priority, const char *wmesg, int timo);
void wakeup(const void *chan);

#ifdef  __cplusplus
}
#endif

#endif // __SWP_TSLEEP_H
