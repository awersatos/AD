////////////////////////////////////////////////////////////////////////////////
// tsleep.c

#include <stdint.h>
#include <stdbool.h>
#include <time.h>
#include <kernel.h>
#include <assert.h>
#include <timing.h>

#include <sys/types.h>

#include <swp_tsleep.h>

////////////////////////////////////////////////////////////////////////////////
typedef struct  __tsleep_entry_t {
    const void     *ident;
    pthread_cond_t  cond;
    int32_t         ref;
    int32_t         sig;
}tsleep_entry_t;

////////////////////////////////////////////////////////////////////////////////
#define MAX_SLEEPERS    16
#define TSLEEP_SLOT_COUNT (sizeof(sleepTable)/sizeof(tsleep_entry_t))

////////////////////////////////////////////////////////////////////////////////
static tsleep_entry_t   sleepTable[MAX_SLEEPERS];
static pthread_mutex_t  tsleep_mutex;

////////////////////////////////////////////////////////////////////////////////
static void timeout_ticks_to_abs_timespec(clock_t ticks, struct timespec *tmspec)
{
    ticks += bsdticks;
    tmspec->tv_sec  = (long)(ticks / bsdtick);
    tmspec->tv_nsec = (long)(((ticks % bsdtick) * 1000000000ll) /  bsdtick);

    return;
}

////////////////////////////////////////////////////////////////////////////////
void bsd_tsleep_init(void)
{
    int32_t i;

    //printf("bsd_tsleep_init()\n");

    memset(sleepTable, 0, sizeof(sleepTable));

    for(i=0;i<TSLEEP_SLOT_COUNT;i++){
        pthread_cond_init(&sleepTable[i].cond, NULL);
    }

    {
        pthread_mutexattr_t mutexattr;
        pthread_mutexattr_init( &mutexattr );

        // Init driver lock
        mutexattr.type = PTHREAD_MUTEX_RECURSIVE;
        pthread_mutex_init(&tsleep_mutex, &mutexattr);
    }

}

////////////////////////////////////////////////////////////////////////////////
static tsleep_entry_t *get_ident_slot(const void *ident, bool ref, bool create, bool sig)
{
    int32_t i;
    tsleep_entry_t *p=NULL;

    // See if already registered
    for(i=0;i<TSLEEP_SLOT_COUNT;i++){
        if(sleepTable[i].ident == ident){
            if(ref) sleepTable[i].ref++;
            p = &sleepTable[i];
            goto done;
        }
    }

    if(create){
        for(i=0;i<TSLEEP_SLOT_COUNT;i++){
            if(sleepTable[i].ident == NULL){
                sleepTable[i].ident = ident;
                sleepTable[i].ref = 1;
                sleepTable[i].sig = sig;
                //pthread_cond_init(&sleepTable[i].cond, NULL);
                p = &sleepTable[i];
                goto done;
            }
        }
    }

done:
    return p;
}

////////////////////////////////////////////////////////////////////////////////
static void free_ident_slot(tsleep_entry_t *s)
{
    if(--s->ref <= 0){
        s->ident = NULL;
        s->ref   = 0;
        s->sig   = 0;
        pthread_cond_init(&s->cond, NULL);
    }
}

////////////////////////////////////////////////////////////////////////////////
// From BSD:
// General sleep call.  Suspends the current process until a wakeup is
// performed on the specified identifier.  The process will then be made
// runnable with the specified priority.  Sleeps at most timo/hz seconds
// (0 means no timeout).  If pri includes PCATCH flag, signals are checked
// before and after sleeping, else signals are not checked.  Returns 0 if
// awakened, EWOULDBLOCK if the timeout expires.  If PCATCH is set and a
// signal needs to be delivered, ERESTART is returned if the current system
// call should be restarted if possible, and EINTR is returned if the system
// call should be interrupted by the signal (return EINTR).
//
////////////////////////////////////////////////////////////////////////////////
int tsleep(const void *ident, int priority, const char *wmesg, int timo)
{
    int32_t         retVal;
    struct timespec ts;
    tsleep_entry_t  *s;
    pthread_cond_t  testcond    = PTHREAD_COND_INITIALIZER;

    pthread_mutex_lock(&tsleep_mutex);

    if((s = get_ident_slot(ident, true, true, false))==NULL){
        //printf("tsleep(): Could not allocate slot!\n");
        return -1;
    }

    if(!s->sig){
        if(timo){
            timeout_ticks_to_abs_timespec(timo, &ts);
            //printf("WAIT ON[%p]\n", s->ident);
            retVal = pthread_cond_timedwait(&s->cond, &tsleep_mutex, &ts);
            // tsleep_mutex is locked here
        }else{
            retVal = pthread_cond_wait(&s->cond, &tsleep_mutex);
            // tsleep_mutex is locked here
        }
    }else{
        s->sig = 0;
        retVal = 0;
    }

    //printf("EVENT[%s - [%p]\n", retVal?"TIMEOUT]":"SIGNALED]", s->ident);

    free_ident_slot(s);

    pthread_mutex_unlock(&tsleep_mutex);

    return retVal;
}

////////////////////////////////////////////////////////////////////////////////
void wakeup(const void *chan)
{
    tsleep_entry_t  *s;

    pthread_mutex_lock(&tsleep_mutex);

    //printf("WAKEUP[%p]\n", chan);

    if((s = get_ident_slot(chan, false, true, true))!=NULL){
        pthread_cond_broadcast(&s->cond);
    }

    pthread_mutex_unlock(&tsleep_mutex);
}



