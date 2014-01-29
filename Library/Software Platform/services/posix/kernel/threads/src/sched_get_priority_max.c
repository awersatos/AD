/*****************************************************************************
 * FILE:        @(#)sched_get_priority_max.c    1.2 06/09/29
 * DESCRIPTION:
 *      The sched_get_priority_max() function shall return the appropriate 
 *      maximum priority for the scheduling policy specified by policy.
 ****************************************************************************/
#include <sched.h>

int sched_get_priority_max(int policy)
{
        return SCHED_PRIORITY_MAX;
}

