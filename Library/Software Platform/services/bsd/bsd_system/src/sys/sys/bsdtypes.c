////////////////////////////////////////////////////////////////////////////////
// bsdtypes.c

#include <pthread.h>
#include <time.h>
#include "bsdtypes.h"

#include <interrupts.h>

#define SPLNET_ID       -1
#define USBLOCK_MUTEX   -2

#ifdef BSD_USB_DEBUG
uint32_t usbdebug = BSD_USB_DEBUG_LEVEL;
#endif

////////////////////////////////////////////////////////////////////////////////
unsigned char etherbroadcastaddr[ETHER_ADDR_LEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };

////////////////////////////////////////////////////////////////////////////////
int hz = 100;

////////////////////////////////////////////////////////////////////////////////
unsigned int min(unsigned int a, unsigned int b)
{
    return (a < b ? a : b);
}

////////////////////////////////////////////////////////////////////////////////
pthread_mutex_t SPLNET_mutex;
pthread_mutex_t USBLOCK_mutex;

pthread_mutex_t mbuf_Free_mutex;
pthread_mutex_t mbuf_Alloc_mutex;

extern void bsd_device_subsystem_init(void);

////////////////////////////////////////////////////////////////////////////////
void bsd_subystem_internal_init(void)
{
    pthread_mutex_init(&USBLOCK_mutex, NULL);

    pthread_mutex_init(&mbuf_Free_mutex, NULL);

    bsd_timeout_init();

    bsd_tsleep_init();

    bsd_device_subsystem_init();

    // Device Tables init
    config_init();

    // Networking Interface Timers
    ifinit();
}

////////////////////////////////////////////////////////////////////////////////
void bsd_subystem_init(void)
{
#if __POSIX_KERNEL__
    posix_mainhook_install(bsd_subystem_internal_init, 15);
#endif
}

////////////////////////////////////////////////////////////////////////////////
int  splnet(void)
{
    return SPLNET_ID;
}

////////////////////////////////////////////////////////////////////////////////
void splx(int32_t intr)
{
#if 0
    if(intr > 0){
        interrupt_enable(intr);
    } else {
        switch(intr){
            case SPLNET_ID:
                break;
            case USBLOCK_MUTEX:
                // Release lock

                pthread_mutex_unlock(&USBLOCK_mutex);

                break;
            default:
                // Do Nothing
                break;
        };
    }
#endif
}

clock_t bsdticks_routine(void)
{
    int rc;
    clock_t ret;
    struct timespec ts;

    rc = clock_gettime(CLOCK_MONOTONIC, &ts);
    if (rc == 0)
    {
        ret = ((clock_t)ts.tv_nsec * CLOCKS_PER_SEC) / 1000000000;
        ret += (clock_t)ts.tv_sec * CLOCKS_PER_SEC;
    }
    else
    {
        ret = (clock_t) -1;
    }

    return ret;
}

