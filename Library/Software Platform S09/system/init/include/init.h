#ifndef     _INIT_H
#define     _INIT_H


#if ( __POSIX_KERNEL__ != 0 )
 typedef struct {
    void    (*handler)(void);
    int     priority;
 } mainhookdata_t;

extern void posix_mainhook_install ( void (*mainhookhandler)(void), int priority);
extern void posix_mainhook_run     ( void );
#endif

#endif // _INIT_H
