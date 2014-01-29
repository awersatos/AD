/*****************************************************************************
 * FILE:        @(#)sched_get_priority_min.c    1.2 06/09/29
 * DESCRIPTION:
 *      The sched_get_priority_min() function shall return the appropriate 
 *      minimum priority for the scheduling policy specified by policy.
 ****************************************************************************/
#include <sched.h>

int sched_get_priority_min(int policy)
{
        return SCHED_PRIORITY_MIN;
}

