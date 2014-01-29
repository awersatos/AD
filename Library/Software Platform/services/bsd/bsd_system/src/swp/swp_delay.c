////////////////////////////////////////////////////////////////////////////////
// swp_delay.c

#include <swp_delay.h>


void delay_yield_us(uint32_t us)
{
    struct timespec ts;

    if(us < 100){
        delay_us(us);
    }else{
        ts.tv_sec   = (us / 1000000);
        ts.tv_nsec  = (us % 1000000) * 1000L;

        nanosleep(&ts, NULL);
    }
}
