#include <string.h>
#include <stdlib.h>
#include <components.h>
#include <agui.h>

/**
 * @brief    Sort the list
 *
 * Sort the list. The sort is based on the sort algorithm set for @em sort. 
 * This algorithm must return an integer based on the two arguments provided to this algorithm.
 * The arguments provided are void pointers given to list_add() and list_insert().
 * The sign of the integer return value determines the order of the corresponding items of the provided void pointers.
 * The sort order can be ascending or descending, depending the @em descending value.
 *
 * @param list          Pointer to modifiable pointer to the list to be sort
 * @param sort          Sort algorithm
 * @param descending    Sort list in descending order if true, in ascending order if false
 *
 * @return Nothing
 */

void list_sort( list_t **list, sort_algorithm_t sort, bool descending )
{
    /*
     * Using bubble-sort to sort the textlist
     * Bubble sort is the easiest way to sort if you have only access to two successive entries of the textlist
     */

    bool swapped = true;
    list_t **l;
    list_t **l_next;
    list_t **l_next_next;
    list_t *l_swap;

    if ( ! *list )
    {
        /* empty list, nothing to sort, return */
        return;
    }

    while (swapped)
    {
        swapped = false;
        l = list;
        l_next = &((*l)->next);

        while ( *l_next != NULL)
        {
            if (( sort((*l)->vp, (*l_next)->vp) > 0 ) ^ descending)
            {
                /* swap */
                swapped = true;
                l_next_next = &((*l_next)->next);
                l_swap = *l;
                *l = *l_next;
                *l_next = *l_next_next;
                *l_next_next = l_swap;
            }
            else
            {
                l = l_next;
            }
            l_next = &((*l)->next);
        }
    }
}


/**
 * @brief    Add an item to the list
 *
 * Add an item to the list. Memory is allocated to store this item and the item is added at the end of the list.
 * Memory is allocated for the item. The void pointer @em vp can be used to link any information to the item.
 *
 * @see
 *     listbox_t
 *
 * @param list      Pointer to the list
 * @param vp        Void pointer
 *
 * @return Index of added item, -1 if error.
 */

int list_add( list_t **list, void *vp )
{
    int index = 0;
    list_t **l;
    list_t *new;

    new = (list_t*)malloc(sizeof(list_t));

    if (new)
    {
        l = list;
        while( *l != NULL )
        {
            l = &((*l)->next);
            index++;
        }
        *l = new;
        (*l)->next = NULL;
        (*l)->vp = vp;
        (*l)->dynamic = true;
    }
    else
    {
        index = -1;
    }

    return index;
}


/**
 * @brief    Insert an item in the list
 *
 * Insert an item in the list. Memory is allocated to store this item and the item is added at the given index (0 = first item).
 * The void pointer @em vp can be used to link any information to the item.
 * If the given index is larger than the number of items in the list, the item is added at the end of the list.
 *
 * @see
 *     listbox_t
 *
 * @param list      Pointer to the listbox
 * @param vp        Void pointer
 * @param index     Index where this item has to be inserted
 *
 * @return Index of inserted item, -1 if error.
 */

int list_insert( list_t **list, void *vp, int index )
{
    list_t **l;
    list_t *p;
    int insert_index = 0;

    l = list;
    while ( index-- && *l )
    {
        l =&((*l)->next);
        insert_index++;
    }

    p = *l;
    (*l) = (list_t *)malloc(sizeof(list_t));
    if (*l)
    {
        (*l)->next = p;
        (*l)->vp = vp;
        (*l)->dynamic = true;
    }
    else
    {
        insert_index = -1;
    }

    return insert_index;
}


/**
 * @brief    Concatenate two lists
 *
 * Concatenate two lists. Add the second list at the end of the first list.
 *
 * @param first_list   Pointer to first list
 * @param second_list  Pointer to second list
 *
 * @return Number of items in concatenated list
 */

int list_concatenate( list_t **first_list, list_t **second_list )
{
    int index = 0;
    list_t **l;

    if ( ! *first_list )
    {
        l = first_list;
        first_list = second_list;
        second_list = l;
    }

    l = first_list;
    while( *l != NULL )
    {
        l = &((*l)->next);
    }
    *l = *second_list;

    l = first_list;
    while ( *l != NULL )
    {
        l = &((*l)->next);
        index++;
    }

    return index;
}



/**
 * @brief    Delete an item from the list
 *
 * Delete an item from the list. The index indicates the item to delete (0 = first item).
 * The memory allocated when adding this item will be freed.
 * If the given index doesn't exists, the function returns -1.
 *
 * @param list      Pointer to the list
 * @param index     Index of the item to be deleted
 *
 * @return Index of deleted item, -1 if error.
 */

int list_delete( list_t **list, int index )
{
    list_t **l;
    list_t *p;
    int delete_index = 0;

    l = list;
    while ( index-- && *l )
    {
        l =&((*l)->next);
        delete_index++;
    }
    if ( *l != NULL )
    {
        p = *l;
        *l = (*l)->next;
        if (p->dynamic)
        {
            free(p);
        }
        return delete_index;
    }

    return -1;
}


/**
 * @brief    Count the items in the list
 *
 * Count the items in the list.
 *
 * @param list   Pointer to the list
 *
 * @return Number of items in the list
 */

int list_count( list_t **list)
{
    list_t *l;
    int count = 0;

    l = *list;
    while( l != NULL )
    {
        l = l->next;
        count++;
    }
    return count;
}


/**
 * @brief    Get the item
 *
 * Get the void pointer that belongs to the item indicated by the index.
 *
 * @see
 *     list_add(), list_insert()
 *
 * @param list      Pointer to the list
 * @param index     Index of the item which text is asked for
 *
 * @return Void Pointer if item exists, otherwise NULL
 */

void *list_get( list_t **list, int index)
{
    list_t *l;

    if (index < 0)
    {
        return NULL;
    }

    l = *list;
    while ( index-- && l )
    {
        l = l->next;
    }

    if (l == NULL)
    {
        return NULL;
    }
    return l->vp;
}


/**
 * @brief    Get next item
 *
 * Get the void pointer that belongs to the next item in the list. The @em current pointer will be updated to the next item.
 *
 * @see
 *     list_get()
 *
 * @param current   Pointer to current item in the list
 *
 * @return Void Pointer if item exists, otherwise NULL
 */

void *list_get_next(list_t **current)
{
    list_t *l;
    if (current == NULL || *current == NULL)
    {
        return NULL;
    }

    l = *current;
    *current = (*current)->next;

    return l->vp;
}


/**
 * @brief    Set current item
 *
 * Set the current item in the list. This can be used by list_get_next().
 *
 * @see
 *     list_get_next()
 *
 * @param current     Location that will be set
 * @param index       Index in the list
 *
 * @return Nothing
 */

void list_set_current( list_t **current, int index)
{
    while ( index-- && *current )
    {
        current = &((*current)->next);
    }
}


/**
 * @brief    Clear list
 *
 * Delete all items from the list and fee all allocated memory
 *
 * @param list      Pointer to list that will be cleared
 *
 * @return Nothing
 */

void list_clear( list_t **list )
{
    while (list_count(list))
    {
        list_delete(list, 0);
    }
}

