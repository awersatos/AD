/*
 * Copyright (c) 2001-2003 Swedish Institute of Computer Science.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
 * SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
 * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
 * OF SUCH DAMAGE.
 *
 * This file is part of the lwIP TCP/IP stack.
 *
 * Author: Adam Dunkels <adam@sics.se>
 *
 */

#include "lwip/debug.h"

#include <string.h>
#include <sys/time.h>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

#include <util_timespec.h>

#include "lwip/sys.h"
#include "lwip/opt.h"
#include "lwip/stats.h"
#include "lwip/timers.h"

////////////////////////////////////////////////////////////////////////////////
#define UMAX(a, b)      ((a) > (b) ? (a) : (b))

////////////////////////////////////////////////////////////////////////////////
static struct sys_thread *threads = NULL;
static pthread_mutex_t threads_mutex = PTHREAD_MUTEX_INITIALIZER;

////////////////////////////////////////////////////////////////////////////////
struct sys_mbox_msg {
    struct sys_mbox_msg *next;
    void *msg;
};

#define SYS_MBOX_SIZE 128

////////////////////////////////////////////////////////////////////////////////
struct sys_mbox {
    int first, last;
    void *msgs[SYS_MBOX_SIZE];
    struct sys_sem *not_empty;
    struct sys_sem *not_full;
    struct sys_sem *mutex;
    int wait_send;
};

////////////////////////////////////////////////////////////////////////////////
struct sys_sem {
    unsigned int    c;
    pthread_cond_t  cond;
    pthread_mutex_t mutex;
};

////////////////////////////////////////////////////////////////////////////////
struct sys_mutex {
    pthread_mutex_t mutex;
};

////////////////////////////////////////////////////////////////////////////////
struct sys_thread {
    struct sys_thread *next;
    struct sys_timeo timeouts;
    pthread_t pthread;
};

////////////////////////////////////////////////////////////////////////////////
static struct timeval starttime;

static pthread_mutex_t lwprot_mutex = PTHREAD_MUTEX_INITIALIZER;
static pthread_t lwprot_thread = (pthread_t) 0xDEAD;
static int lwprot_count = 0;

static struct sys_sem *sys_sem_new_internal(u8_t count);
static void sys_sem_free_internal(struct sys_sem *sem);

static u32_t cond_wait(pthread_cond_t * cond, pthread_mutex_t * mutex, u32_t timeout_ms);

////////////////////////////////////////////////////////////////////////////////
static struct sys_thread *introduce_thread(pthread_t id)
{
    struct sys_thread *thread;

    thread = calloc(1, sizeof(struct sys_thread));

    if (thread != NULL) {
        pthread_mutex_lock(&threads_mutex);
        thread->next = threads;
        thread->timeouts.next = NULL;
        thread->pthread = id;
        threads = thread;
        pthread_mutex_unlock(&threads_mutex);
    }

    return thread;
}

////////////////////////////////////////////////////////////////////////////////
static struct sys_thread *current_thread(void)
{
    struct sys_thread *st;
    pthread_t pt;
    pt = pthread_self();
    pthread_mutex_lock(&threads_mutex);

    for (st = threads; st != NULL; st = st->next) {
        if (pthread_equal(st->pthread, pt)) {
            pthread_mutex_unlock(&threads_mutex);

            return st;
        }
    }

    pthread_mutex_unlock(&threads_mutex);

    st = introduce_thread(pt);

    if (!st) {
        printf("current_thread???\n");
        abort();
    }

    return st;
}

////////////////////////////////////////////////////////////////////////////////
sys_thread_t sys_thread_new(const char *name, lwip_thread_fn function, void *arg, int stacksize, int prio)
{
    int code;
    pthread_t tmp;
    struct sys_thread *st = NULL;

    pthread_attr_t attr;
    struct sched_param sched_param;

    sched_param.sched_priority = prio;

    pthread_attr_init           (&attr                          );
    pthread_attr_setschedparam  (&attr, &sched_param            );
    pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED  );
    pthread_attr_setschedpolicy (&attr, SCHED_FIFO              );
    pthread_attr_setdetachstate (&attr, PTHREAD_CREATE_DETACHED );
#if (__POSIX_THREAD_ATTR_NAME != 0)
    pthread_attr_setname        (&attr, name                    );
#endif

    code = pthread_create(&tmp, &attr, (void *(*)(void *))function, arg);

    if (0 == code) {
        st = introduce_thread(tmp);
    }

    if (NULL == st) {
        LWIP_DEBUGF(SYS_DEBUG, ("sys_thread_new: pthread_create %d, st = 0x%lx",
                       code, (unsigned long)st));
        abort();
    }
    return st;
}

////////////////////////////////////////////////////////////////////////////////
err_t sys_mbox_new(sys_mbox_t *mbox, int size)
{
    //struct sys_mbox *mbox;
    LWIP_UNUSED_ARG(size);

    (*mbox) = calloc(1, sizeof(struct sys_mbox));
    if (*mbox != NULL) {
        (*mbox)->first = (*mbox)->last = 0;
        (*mbox)->not_empty = sys_sem_new_internal(0);
        (*mbox)->not_full = sys_sem_new_internal(0);
        (*mbox)->mutex = sys_sem_new_internal(1);
        (*mbox)->wait_send = 0;

#if SYS_STATS
        lwip_stats.sys.mbox.used++;
        if (lwip_stats.sys.mbox.used > lwip_stats.sys.mbox.max) {
            lwip_stats.sys.mbox.max = lwip_stats.sys.mbox.used;
        }
#endif                          /* SYS_STATS */
    }
    return ERR_OK;
}

////////////////////////////////////////////////////////////////////////////////
void sys_mbox_free(sys_mbox_t *mbox)
{
    if ((*mbox) != SYS_MBOX_NULL) {
#if SYS_STATS
        lwip_stats.sys.mbox.used--;
#endif                          /* SYS_STATS */
        sys_arch_sem_wait((&(*mbox)->mutex), 0);

        sys_sem_free_internal(((*mbox)->not_empty));
        sys_sem_free_internal(((*mbox)->not_full));
        sys_sem_free_internal(((*mbox)->mutex));
        (*mbox)->not_empty = (*mbox)->not_full = (*mbox)->mutex = NULL;
        /*  LWIP_DEBUGF("sys_(*mbox)_free: (*mbox) 0x%lx\n", (*mbox)); */
        free((*mbox));
    }
}

////////////////////////////////////////////////////////////////////////////////
err_t sys_mbox_trypost(sys_mbox_t *mbox, void *msg)
{
    u8_t first;

    sys_arch_sem_wait(&((*mbox)->mutex), 0);

    LWIP_DEBUGF(SYS_DEBUG, ("sys_(*mbox)_trypost: (*mbox) %p msg %p\n",
                            (void *) (*mbox), (void *) msg));

    if (((*mbox)->last + 1) >= ((*mbox)->first + SYS_MBOX_SIZE)) {
        sys_sem_signal(&((*mbox)->mutex));
        return ERR_MEM;
    }

    (*mbox)->msgs[(*mbox)->last % SYS_MBOX_SIZE] = msg;

    if ((*mbox)->last == (*mbox)->first) {
        first = 1;
    } else {
        first = 0;
    }

    (*mbox)->last++;

    if (first) {
        sys_sem_signal(&((*mbox)->not_empty));
    }

    sys_sem_signal(&((*mbox)->mutex));

    return ERR_OK;
}

////////////////////////////////////////////////////////////////////////////////
void sys_mbox_post(sys_mbox_t *mbox, void *msg)
{
    u8_t first;

    sys_arch_sem_wait(&((*mbox)->mutex), 0);

    LWIP_DEBUGF(SYS_DEBUG, ("sys_(*mbox)_post: (*mbox) %p msg %p\n", (void *)(*mbox), (void *)msg));

    while (((*mbox)->last + 1) >= ((*mbox)->first + SYS_MBOX_SIZE)) {
        (*mbox)->wait_send++;
        sys_sem_signal(&((*mbox)->mutex));
        sys_arch_sem_wait(&((*mbox)->not_full), 0);
        sys_arch_sem_wait(&((*mbox)->mutex), 0);
        (*mbox)->wait_send--;
    }

    (*mbox)->msgs[(*mbox)->last % SYS_MBOX_SIZE] = msg;

    if ((*mbox)->last == (*mbox)->first) {
        first = 1;
    } else {
        first = 0;
    }

    (*mbox)->last++;

    if (first) {
        sys_sem_signal(&((*mbox)->not_empty));
    }

    sys_sem_signal(&((*mbox)->mutex));
}
////////////////////////////////////////////////////////////////////////////////
u32_t sys_arch_mbox_tryfetch(sys_mbox_t *mbox, void **msg)
{
    sys_arch_sem_wait(&((*mbox)->mutex), 0);

    if ((*mbox)->first == (*mbox)->last) {
        sys_sem_signal(&((*mbox)->mutex));
        return SYS_MBOX_EMPTY;
    }

    if (msg != NULL) {
        LWIP_DEBUGF(SYS_DEBUG, ("sys_mbox_tryfetch: (*mbox) %p msg %p\n", (void *)(*mbox), *msg));
        *msg = (*mbox)->msgs[(*mbox)->first % SYS_MBOX_SIZE];
    }
    else{
        LWIP_DEBUGF(SYS_DEBUG, ("sys_mbox_tryfetch: (*mbox) %p, null msg\n", (void *)(*mbox)));
    }

    (*mbox)->first++;

    if ((*mbox)->wait_send) {
        sys_sem_signal(&((*mbox)->not_full));
    }

    sys_sem_signal(&((*mbox)->mutex));

    return 0;
}

////////////////////////////////////////////////////////////////////////////////
u32_t sys_arch_mbox_fetch(sys_mbox_t *mbox, void **msg, u32_t timeout_ms)
{
    u32_t time_needed = 0;

    /* The mutex lock is quick so we don't bother with the timeout
       stuff here. */
    sys_arch_sem_wait(&((*mbox)->mutex), 0);

    while ((*mbox)->first == (*mbox)->last) {
        sys_sem_signal(&((*mbox)->mutex));

        /* We block while waiting for a mail to arrive in the mailbox. We
           must be prepared to timeout. */
        if (timeout_ms != 0) {
            time_needed = sys_arch_sem_wait(&((*mbox)->not_empty), timeout_ms);

            if (time_needed == SYS_ARCH_TIMEOUT) {
                sched_yield();
                return SYS_ARCH_TIMEOUT;
            }
        } else {
            sys_arch_sem_wait(&((*mbox)->not_empty), 0);
        }
        sys_arch_sem_wait(&((*mbox)->mutex), 0);
    }

    if (msg != NULL) {
        LWIP_DEBUGF(SYS_DEBUG, ("sys_(*mbox)_fetch: (*mbox) %p msg %p\n", (void *)(*mbox), *msg));
        *msg = (*mbox)->msgs[(*mbox)->first % SYS_MBOX_SIZE];
    }
    else{
        LWIP_DEBUGF(SYS_DEBUG, ("sys_(*mbox)_fetch: (*mbox) %p, null msg\n", (void *)(*mbox)));
    }

    (*mbox)->first++;

    if ((*mbox)->wait_send) {
        sys_sem_signal(&((*mbox)->not_full));
    }

    sys_sem_signal(&((*mbox)->mutex));

    return time_needed;
}

////////////////////////////////////////////////////////////////////////////////
static struct sys_sem *sys_sem_new_internal(u8_t count)
{
    struct sys_sem *sem;

    sem = calloc(1, sizeof(struct sys_sem));
    if (sem != NULL) {
        sem->c = count;
        pthread_cond_init(&(sem->cond), NULL);
        pthread_mutex_init(&(sem->mutex), NULL);
    }
    return sem;
}

////////////////////////////////////////////////////////////////////////////////
err_t sys_mutex_new_prio_protect(sys_mutex_t *mutex, int priority)
{
    pthread_mutexattr_t attr;

    *mutex = (sys_mutex_t)calloc(1, sizeof(struct sys_mutex));
    if (*mutex != NULL) {
        pthread_mutexattr_init(&attr);
        if(priority){
            pthread_mutexattr_setprioceiling(&attr, priority);
        }
        pthread_mutex_init(&((*mutex)->mutex), &attr);
        return ERR_OK;
    }

    return ERR_MEM;
}

////////////////////////////////////////////////////////////////////////////////
err_t sys_mutex_new(sys_mutex_t *mutex)
{
    return sys_mutex_new_prio_protect(mutex, 0);
}

////////////////////////////////////////////////////////////////////////////////
void sys_mutex_lock(sys_mutex_t *mutex)
{
    pthread_mutex_lock(&((*mutex)->mutex));
}

////////////////////////////////////////////////////////////////////////////////
void sys_mutex_unlock(sys_mutex_t *mutex)
{
    pthread_mutex_unlock(&((*mutex)->mutex));
}

////////////////////////////////////////////////////////////////////////////////
void sys_mutex_free(sys_mutex_t *mutex)
{
    pthread_mutex_destroy(&((*mutex)->mutex));
    free(mutex);
}

////////////////////////////////////////////////////////////////////////////////
//err_t sys_sem_new(sys_sem_t *sem, u8_t count)

err_t sys_sem_new(sys_sem_t *sem, u8_t count)
{
    *sem = sys_sem_new_internal(count);

#if SYS_STATS
    if(*sem){
        lwip_stats.sys.sem.used++;
        if (lwip_stats.sys.sem.used > lwip_stats.sys.sem.max) {
            lwip_stats.sys.sem.max = lwip_stats.sys.sem.used;
        }
    }
#endif /* SYS_STATS */

    return (*sem)?ERR_OK:ERR_MEM;
}
////////////////////////////////////////////////////////////////////////////////
static u32_t cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex, u32_t timeout_ms)
{
    int waited_ms;
    struct timespec ts_start,ts_timeout,ts_wakeup;
    int result;

    if (timeout_ms > 0) {
        clock_gettime(cond->clock_id,&ts_start);
        timespec_from_ms(&ts_timeout,timeout_ms);
        timespec_add(&ts_timeout,&ts_start);
//printf("cond_wait: now=%u.%09u timeout=%u.%09u\n",ts_start.tv_sec,ts_start.tv_nsec,ts_timeout.tv_sec,ts_timeout.tv_nsec);
        result = pthread_cond_timedwait(cond, mutex, &ts_timeout);
        if (result == ETIMEDOUT) {
            return SYS_ARCH_TIMEOUT;
        } else {
            clock_gettime(cond->clock_id,&ts_wakeup);
            waited_ms = timespec_delta_ms(&ts_wakeup,&ts_start);
            return waited_ms < 0 ? 0 : waited_ms;
        }
    } else {
        pthread_cond_wait(cond, mutex);
        return SYS_ARCH_TIMEOUT;
    }
}

////////////////////////////////////////////////////////////////////////////////
u32_t sys_arch_sem_wait(sys_sem_t *sem, u32_t timeout_ms)
{
    u32_t time_needed = 0;

    pthread_mutex_lock(&((*sem)->mutex));
    while ((*sem)->c <= 0) {
        if (timeout_ms > 0) {
            time_needed = cond_wait(&((*sem)->cond), &((*sem)->mutex), timeout_ms);

            if (time_needed == SYS_ARCH_TIMEOUT) {
                pthread_mutex_unlock(&((*sem)->mutex));
                return SYS_ARCH_TIMEOUT;
            }
            /*      pthread_mutex_unlock(&((*sem)->mutex));
              return time_needed; */
        } else {
            cond_wait(&((*sem)->cond), &((*sem)->mutex), 0);
        }
    }
    (*sem)->c--;
    pthread_mutex_unlock(&((*sem)->mutex));
    return time_needed;
}

////////////////////////////////////////////////////////////////////////////////
void sys_sem_signal(sys_sem_t *sem)
{
    pthread_mutex_lock(&((*sem)->mutex));
    (*sem)->c++;

    if ((*sem)->c > 1) {
        (*sem)->c = 1;
    }

    pthread_cond_broadcast(&((*sem)->cond));
    pthread_mutex_unlock(&((*sem)->mutex));
}

////////////////////////////////////////////////////////////////////////////////
static void sys_sem_free_internal(struct sys_sem *sem)
{
    pthread_cond_destroy(&(sem->cond));
    pthread_mutex_destroy(&(sem->mutex));
    free(sem);
}

////////////////////////////////////////////////////////////////////////////////
void sys_sem_free(sys_sem_t *sem)
{
    if ((*sem) != SYS_SEM_NULL) {
#if SYS_STATS
        lwip_stats.sys.sem.used--;
#endif                          /* SYS_STATS */
        sys_sem_free_internal(*sem);

        *sem = SYS_SEM_NULL;
    }
}

////////////////////////////////////////////////////////////////////////////////
unsigned long sys_unix_now()
{
    struct timeval tv;
    // ALTIUM TODO: untested removal of tz
    //  struct timezone tz;
    long sec, usec;
    unsigned long msec;
    //  gettimeofday(&tv, &tz);
    gettimeofday(&tv, NULL);

    sec = tv.tv_sec - starttime.tv_sec;
    usec = tv.tv_usec - starttime.tv_usec;
    msec = sec * 1000 + usec / 1000;

    return msec;
}

////////////////////////////////////////////////////////////////////////////////
int sys_sem_valid(sys_sem_t *sem)
{
    return *sem != NULL; 
}

////////////////////////////////////////////////////////////////////////////////
int sys_mbox_valid(sys_mbox_t *mbox)
{
    return *mbox != NULL;
}

////////////////////////////////////////////////////////////////////////////////
void sys_mbox_set_invalid(sys_mbox_t *mbox)
{
    *mbox = NULL;
}

////////////////////////////////////////////////////////////////////////////////
void sys_sem_set_invalid(sys_sem_t *sem)
{
    *sem = NULL;
}

////////////////////////////////////////////////////////////////////////////////
void sys_init(void)
{
    // ALTIUM TODO: untested removal of tz
    //  struct timezone tz;
    //  gettimeofday(&starttime, &tz);
    gettimeofday(&starttime, NULL);
}

////////////////////////////////////////////////////////////////////////////////
struct sys_timeo *sys_arch_timeouts(void)
{
    struct sys_thread *thread;

    thread = current_thread();
    return &thread->timeouts;
}

////////////////////////////////////////////////////////////////////////////////
/** sys_prot_t sys_arch_protect(void)

This optional function does a "fast" critical region protection and returns
the previous protection level. This function is only called during very short
critical regions. An embedded system which supports ISR-based drivers might
want to implement this function by disabling interrupts. Task-based systems
might want to implement this by using a mutex or disabling tasking. This
function should support recursive calls from the same task or interrupt. In
other words, sys_arch_protect() could be called while already protected. In
that case the return value indicates that it is already protected.

sys_arch_protect() is only required if your port is supporting an operating
system.
*/
sys_prot_t sys_arch_protect(void)
{
    /* Note that for the UNIX port, we are using a lightweight mutex, and our
     * own counter (which is locked by the mutex). The return code is not actually
     * used. */
    if (lwprot_thread != pthread_self())
    {
        /* We are locking the mutex where it has not been locked before *
           * or is being locked by another thread */
        pthread_mutex_lock(&lwprot_mutex);
        lwprot_thread = pthread_self();
        lwprot_count = 1;
    }
    else
        /* It is already locked by THIS thread */
        lwprot_count++;
    return 0;
}

////////////////////////////////////////////////////////////////////////////////
/** void sys_arch_unprotect(sys_prot_t pval)

This optional function does a "fast" set of critical region protection to the
value specified by pval. See the documentation for sys_arch_protect() for
more information. This function is only required if your port is supporting
an operating system.
*/
void sys_arch_unprotect(sys_prot_t pval)
{
    LWIP_UNUSED_ARG(pval);
    if (lwprot_thread == pthread_self())
    {
        if (--lwprot_count == 0)
        {
            lwprot_thread = (pthread_t) 0xDEAD;
            pthread_mutex_unlock(&lwprot_mutex);
        }
    }
}

////////////////////////////////////////////////////////////////////////////////
#ifndef MAX_JIFFY_OFFSET
#define MAX_JIFFY_OFFSET ((~0U >> 1)-1)
#endif

#ifndef HZ
#define HZ 100
#endif

u32_t sys_jiffies(void)
{
    struct timeval tv;
    unsigned long sec;
    long usec;

    gettimeofday(&tv, NULL);
    sec = tv.tv_sec - starttime.tv_sec;
    usec = tv.tv_usec;

    if (sec >= (MAX_JIFFY_OFFSET / HZ))
        return MAX_JIFFY_OFFSET;
    usec += 1000000L / HZ - 1;
    usec /= 1000000L / HZ;
    return HZ * sec + usec;
}

////////////////////////////////////////////////////////////////////////////////
u32_t sys_now(void)
{
    return (u32_t)(clock() / (CLOCKS_PER_SEC / 1000LL));
}

////////////////////////////////////////////////////////////////////////////////
#if PPP_DEBUG
#include <stdarg.h>
void ppp_trace(int level, const char *format, ...)
{
    va_list args;

    (void) level;
    va_start(args, format);
    vprintf(format, args);
    va_end(args);
}
#endif


////////////////////////////////////////////////////////////////////////////////
// more or less a dummy for the moment
int gettimeofday(struct timeval *restrict tv, void *restrict tz_dummy)
{
    clock_t now = clock();

    unsigned long long nsecs;

    nsecs = now * (1000000000ll / CLOCKS_PER_SEC);
    tv->tv_sec = (long)(nsecs / 1000000000ll);
    nsecs = nsecs % 1000000000ll;
    tv->tv_usec = (long)(nsecs / 1000);

    return 0;
}

