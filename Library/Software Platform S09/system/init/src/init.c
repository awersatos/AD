
#if ( __POSIX_KERNEL__ != 0 )

#include <stdlib.h>
#include <init.h>

typedef struct mainhookqueue_t mainhookqueue_t;
struct mainhookqueue_t
{
    mainhookqueue_t*     next;
    mainhookdata_t       data;
};

/* posix main hooks queue */
static mainhookqueue_t*         mainhookroot    = NULL;

static void mainhookqueue_run		( void );
static void mainhookqueue_install 	( mainhookdata_t* data );

static void mainhookqueue_install( mainhookdata_t* data)
{
    mainhookqueue_t*   elem   = (mainhookqueue_t*) malloc ( sizeof( mainhookqueue_t ) );
    mainhookqueue_t**  pptr   = NULL;
    mainhookqueue_t*   ptr    = NULL;

    elem->next = NULL;
    elem->data.handler 		= data->handler;
    elem->data.priority    	= data->priority;

    if (mainhookroot == NULL)
    {
        mainhookroot = elem;
        return;
    }

    pptr  = &mainhookroot;
    while ( *pptr != NULL )
    {
        if ( (*pptr)->data.priority <= data->priority )
        {
            elem->next = *pptr;
            *pptr = elem;
            return;
        }
        pptr =  &(*pptr)->next;
    }
    *pptr = elem;
}


static void mainhookqueue_run( void )
{
    mainhookqueue_t*  ptr1;
    mainhookqueue_t*  ptr2;

    for ( ptr1 = mainhookroot, ptr2=NULL; ptr1 != NULL; ptr1=ptr1->next )
    {
        if (ptr2 != NULL )
            free ( (void*) ptr2 );

        if ( ptr1->data.handler != NULL )
        {
            ptr1->data.handler ();
        }
        ptr2 = ptr1;
    }
    if ( ptr2 != NULL )
        free ( (void*) ptr2 );
}

extern void posix_mainhook_install ( void    (*mainhookhandler)(void), int prio)
{
     mainhookdata_t data;
     data.handler 		= mainhookhandler;
     data.priority    	= prio;
     mainhookqueue_install( &data );
}

void posix_mainhook_run( void )
{
    mainhookqueue_run( );
    return;
}

#endif

