#include <stdint.h>
#include <time.h>
#include <kernel.h>
#include <assert.h>

#include <sysutils.h>

#include <sys/types.h>
#include <sys/timeout.h>
#include <sys/queue.h>          /* _Q_INVALIDATE */

////////////////////////////////////////////////////////////////////////////////
struct circq timeout_todo;      /* Worklist */

////////////////////////////////////////////////////////////////////////////////
pthread_cond_t  TIMEOUT_Cond         = PTHREAD_COND_INITIALIZER;
pthread_mutex_t TIMEOUT_list_mutex   = PTHREAD_MUTEX_INITIALIZER;

/*
 * Circular queue definitions.
 */

#define CIRCQ_INIT(elem) do {                   \
        (elem)->next = (elem);                  \
        (elem)->prev = (elem);                  \
} while (0)

#define CIRCQ_INSERT(elem, list) do {           \
        (elem)->prev = (list)->prev;            \
        (elem)->next = (list);                  \
        (list)->prev->next = (elem);            \
        (list)->prev = (elem);                  \
} while (0)

#define CIRCQ_APPEND(fst, snd) do {             \
        if (!CIRCQ_EMPTY(snd)) {                \
                (fst)->prev->next = (snd)->next;\
                (snd)->next->prev = (fst)->prev;\
                (snd)->prev->next = (fst);      \
                (fst)->prev = (snd)->prev;      \
                CIRCQ_INIT(snd);                \
        }                                       \
} while (0)

#define CIRCQ_REMOVE(elem) do {                 \
        (elem)->next->prev = (elem)->prev;      \
        (elem)->prev->next = (elem)->next;      \
    _Q_INVALIDATE((elem)->prev);        \
    _Q_INVALIDATE((elem)->next);        \
} while (0)

#define CIRCQ_FIRST(elem) ((elem)->next)

#define CIRCQ_EMPTY(elem) (CIRCQ_FIRST(elem) == (elem))

////////////////////////////////////////////////////////////////////////////////
void timeout_set(struct timeout *new, void (*fn)(void *), void *arg)
{
    new->to_func = fn;
    new->to_arg = arg;
    new->to_flags = TIMEOUT_INITIALIZED;
}

////////////////////////////////////////////////////////////////////////////////
void timeout_add(struct timeout *new, int to_ticks)
{
    uint64_t old_time;

    //printf("timeout_add[%p]:%i)\n", new->to_func, to_ticks);

    pthread_mutex_lock(&TIMEOUT_list_mutex);
    /* Initialize the time here, it won't change. */
    old_time = new->to_time;
    new->to_time = to_ticks + bsdticks;
    new->to_flags &= ~TIMEOUT_TRIGGERED;

    /*
     * If this timeout already is scheduled and now is moved
     * earlier, reschedule it now. Otherwise leave it in place
     * and let it be rescheduled later.
     */
    if (new->to_flags & TIMEOUT_ONQUEUE) {
        if (new->to_time - bsdticks < old_time - bsdticks) {
            CIRCQ_REMOVE(&new->to_list);
            CIRCQ_INSERT(&new->to_list, &timeout_todo);
            pthread_cond_signal(&TIMEOUT_Cond);
        }
    } else {
#if 0
        new->to_flags |= TIMEOUT_ONQUEUE;
        CIRCQ_INSERT(&new->to_list, &timeout_todo);
#else
        // Sorted insert
        struct timeout *to;

        new->to_flags |= TIMEOUT_ONQUEUE;

        to = (struct timeout *)CIRCQ_FIRST(&timeout_todo);
        while( to != timeout_todo.prev){
            if(to->to_time > new->to_time){
                break;
            }
            to = to->to_list.prev;
        }
        CIRCQ_INSERT(&new->to_list,(struct circq *)to);
#endif
        pthread_cond_signal(&TIMEOUT_Cond);
    }
    pthread_mutex_unlock(&TIMEOUT_list_mutex);
}

////////////////////////////////////////////////////////////////////////////////
void timeout_del(struct timeout *to)
{
    //printf("timeout_del()\n");
    pthread_mutex_lock(&TIMEOUT_list_mutex);
    if (to->to_flags & TIMEOUT_ONQUEUE) {
        CIRCQ_REMOVE(&to->to_list);
        to->to_flags &= ~TIMEOUT_ONQUEUE;
    }
    to->to_flags &= ~TIMEOUT_TRIGGERED;
    pthread_cond_signal(&TIMEOUT_Cond);
    pthread_mutex_unlock(&TIMEOUT_list_mutex);
}

////////////////////////////////////////////////////////////////////////////////
void timeout_add_tv(struct timeout *to, const struct timeval *tv)
{
    long long to_ticks;

    to_ticks = (long long)(bsdtick * tv->tv_sec) + ((tv->tv_usec * bsdtick) / 1000000);
    if (to_ticks > INT_MAX)
        to_ticks = INT_MAX;

    timeout_add(to, (int)to_ticks);
}

////////////////////////////////////////////////////////////////////////////////
void timeout_add_ts(struct timeout *to, const struct timespec *ts)
{
    long long to_ticks;

    to_ticks = (long long)(bsdtick * ts->tv_sec) + ((ts->tv_nsec * bsdtick) / 1000000000);
    if (to_ticks > INT_MAX)
        to_ticks = INT_MAX;

    timeout_add(to, (int)to_ticks);
}

////////////////////////////////////////////////////////////////////////////////
void timeout_add_bt(struct timeout *to, const struct bintime *bt)
{
    long long to_ticks;

    to_ticks = (long long)(bsdtick * bt->sec) + (long)(((uint64_t)1000000 * (uint32_t)(bt->frac >> 32)) >> 32) / bsdtick;
    if (to_ticks > INT_MAX)
        to_ticks = INT_MAX;

    timeout_add(to, (int)to_ticks);
}

////////////////////////////////////////////////////////////////////////////////
void timeout_add_sec(struct timeout *to, int secs)
{
    long long to_ticks;

    to_ticks = (long long)bsdtick * secs;
    if (to_ticks > INT_MAX)
        to_ticks = INT_MAX;

    timeout_add(to, (int)to_ticks);
}

////////////////////////////////////////////////////////////////////////////////
void timeout_add_msec(struct timeout *to, int msecs)
{
    long long to_ticks;

    to_ticks = (long long)(msecs * bsdtick) / 1000;
    if (to_ticks > INT_MAX)
        to_ticks = INT_MAX;

    timeout_add(to, (int)to_ticks);
}

////////////////////////////////////////////////////////////////////////////////
void timeout_add_usec(struct timeout *to, int usecs)
{
    int to_ticks = (long long)(usecs * bsdtick) / 1000000;

    timeout_add(to, to_ticks);
}

////////////////////////////////////////////////////////////////////////////////
void timeout_add_nsec(struct timeout *to, int nsecs)
{
    int to_ticks = (long long)(nsecs * bsdtick) / 1000000000;

    timeout_add(to, to_ticks);
}

////////////////////////////////////////////////////////////////////////////////
static void timeout_ticks_to_timespec(clock_t ticks, struct timespec *tmspec)
{
        tmspec->tv_sec  = (long)(ticks / bsdtick);
        tmspec->tv_nsec = (long)(((ticks % bsdtick) * 1000000000ll) /  bsdtick);
        return;
}

////////////////////////////////////////////////////////////////////////////////
void* timeout_task_thread(void *arg)
{
    struct timeout *to;
    struct timeout *to_temp;
    struct timespec wake_time;
    void (*fn)(void *);
    void *arg;
    static clock_t ticktest;
    static unsigned int clockticksecond;

    while(1){

        pthread_mutex_lock(&TIMEOUT_list_mutex);

            ticktest = bsdticks;
            clockticksecond = bsdtick;

            // Calculate min sleep time
            if(CIRCQ_EMPTY(&timeout_todo)){
                timeout_ticks_to_timespec(bsdticks + (bsdtick * 10),  &wake_time);
            }else{
                to = (struct timeout *)CIRCQ_FIRST(&timeout_todo);
                timeout_ticks_to_timespec(to->to_time,  &wake_time);
            }

            //printf("Sleeping: %i....\n", wake_time.tv_sec);
            pthread_cond_timedwait(&TIMEOUT_Cond, &TIMEOUT_list_mutex, &wake_time);


            to = (struct timeout *)CIRCQ_FIRST(&timeout_todo);
            while(to != &timeout_todo){
                if (to->to_time < bsdticks){
                    //printf("to->to_time - bsdticks: %lld\n", to->to_time - bsdticks);

                    to_temp = to;
                    to = to->to_list.next;
                    CIRCQ_REMOVE(&to_temp->to_list);

                    to_temp->to_flags &= ~TIMEOUT_ONQUEUE;
                    to_temp->to_flags |= TIMEOUT_TRIGGERED;

                    fn = to_temp->to_func;
                    arg = to_temp->to_arg;

                    //printf("Procesing TIMEOUT Task[%p]....\n", fn);

                    pthread_mutex_unlock(&TIMEOUT_list_mutex);
                    fn(arg);
                    pthread_mutex_lock(&TIMEOUT_list_mutex);

					to = (struct timeout *)CIRCQ_FIRST(&timeout_todo);
                    continue;
                }
                to = to->to_list.next;
            }

        pthread_mutex_unlock(&TIMEOUT_list_mutex);

    }

    return NULL;
}

////////////////////////////////////////////////////////////////////////////////
void bsd_timeout_init(void)
{
    pthread_attr_t attr;
    struct sched_param sched_param;

    CIRCQ_INIT(&timeout_todo);

    sched_param.sched_priority = POSIX_THREADS_MAIN_PRIORITY + 25;

    pthread_attr_init           (&attr                          );
    pthread_attr_setschedparam  (&attr, &sched_param            );
    pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED  );
    pthread_attr_setschedpolicy (&attr, SCHED_FIFO              );
#if (__POSIX_THREAD_ATTR_NAME != 0)
    pthread_attr_setname        (&attr, "BSD_TimeOut"           );
#endif

    if ( pthread_create( NULL, &attr, timeout_task_thread, (void *)NULL) != 0 ) {
        assert(0);
    }
}





