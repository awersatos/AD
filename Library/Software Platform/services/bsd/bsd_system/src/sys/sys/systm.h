// systm.h

#ifndef __SYSTM_H__
#define __SYSTM_H__


#include <sys/queue.h>


/*
 * Startup/shutdown hooks.  Startup hooks are functions running after
 * the scheduler has started but before any threads have been created
 * or root has been mounted. The shutdown hooks are functions to be run
 * with all interrupts disabled immediately before the system is
 * halted or rebooted.
 */

struct hook_desc {
        TAILQ_ENTRY(hook_desc) hd_list;
        void    (*hd_fn)(void *);
        void    *hd_arg;
};

TAILQ_HEAD(hook_desc_head, hook_desc);

extern struct hook_desc_head shutdownhook_list, startuphook_list,
    mountroothook_list;

void    *hook_establish(struct hook_desc_head *, int, void (*)(void *), void *);
void    hook_disestablish(struct hook_desc_head *, void *);
void    dohooks(struct hook_desc_head *, int);

#define HOOK_REMOVE     0x01
#define HOOK_FREE       0x02

#define startuphook_establish(fn, arg) \
        hook_establish(&startuphook_list, 1, (fn), (arg))
#define startuphook_disestablish(vhook) \
        hook_disestablish(&startuphook_list, (vhook))
#define dostartuphooks() dohooks(&startuphook_list, HOOK_REMOVE|HOOK_FREE)

#define shutdownhook_establish(fn, arg) \
        hook_establish(&shutdownhook_list, 0, (fn), (arg))
#define shutdownhook_disestablish(vhook) \
        hook_disestablish(&shutdownhook_list, (vhook))
#define doshutdownhooks() dohooks(&shutdownhook_list, HOOK_REMOVE)

#define mountroothook_establish(fn, arg) \
        hook_establish(&mountroothook_list, 1, (fn), (arg))
#define mountroothook_disestablish(vhook) \
        hook_disestablish(&mountroothook_list, (vhook))
#define domountroothooks() dohooks(&mountroothook_list, HOOK_REMOVE|HOOK_FREE)

#endif // __SYSTM_H__

