/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_equal
|*
\*****************************************************************************/

#include <pthread.h>

/**
 * @brief
 *      compares the thread IDs t1 and t2.
 *
 * @param thread1
 *      thread1 id
 * @param thread2
 *      thread2 id
 *
 * @return
 *    	The pthread_equal() function shall return a non-zero value if t1 and t2 are equal; 
 *		otherwise, zero shall be returned.
 *		If either t1 or t2 are not valid thread IDs, the behavior is undefined.
 */
int pthread_equal (pthread_t thread1, pthread_t thread2)
{
         return thread1 == thread2;
}
