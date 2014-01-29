///////////////////////////////////////////////////////////////////////////////
// swp_altq.h


#ifndef _SWP_IF_ALTQ_H_
#define _SWP_IF_ALTQ_H_

//#include <kernel.h>

/*
 * Structure defining a queue for a network interface.
 */
struct  ifaltq {
    /* fields compatible with struct ifqueue */
    struct  mbuf *ifq_head;
    struct  mbuf *ifq_tail;
    int ifq_len;
    int ifq_maxlen;
    int ifq_drops;
    struct  timeout *ifq_congestion;

    pthread_mutex_t *mutex;
    pthread_cond_t  *cond;
    
};


#endif /* _SWP_IF_ALTQ_H_ */
