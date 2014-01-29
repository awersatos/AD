/*****************************************************************************\
|*
|*  IN PACKAGE:     Agui
|*
|*  COPYRIGHT:      Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:    Listbox routines
|*
 */

#include <stdlib.h>
#include <string.h>
#include <graphics.h>
#include <pointer.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg.h"

static int _listbox_sort(void *first, void *second)
{
    listbox_item_t *first_item = (listbox_item_t*)first;
    listbox_item_t *second_item = (listbox_item_t*)second;

    return stricmp( first_item->text, second_item->text);
}

/**
 * @brief    Draw a listbox
 *
 * Draw an listbox on the canvas.
 *
 * @see
 *     listbox_t
 *
 * @param obj    Pointer to the object member of the listbox
 *
 * @return Nothing
 */

void listbox_draw(obj_t *obj)
{
    listbox_t * restrict listbox = (listbox_t*)obj;
    obj_t * restrict parent = obj->parent;
    int x1 = obj->x;
    int x2;
    int y1 = obj->y;
    int y2;
    int y;
    int w = obj->width;
    int h = obj->height;
    int agui_index = obj->agui_index;
    canvas_t * restrict canvas;
    pointer_t * restrict pointer;
    agui_t *agui;
    list_t *l;
    listbox_item_t *item;
    int i;
    int string_height;
    char str[256];
    string_t string;
    color_t color1;
    int separator = listbox->separator ? 1 : 0;
    bool top, bottom;
    bool invalidated = listbox->obj.invalidated;
    bool scrollbar_enabled;
    bool scrollbar_visible;
    _scrollbar_draw_t scrollbar;
    relief_t relief = listbox->relief;
#if AGUI_APPEARANCE==AGUI_APPEARANCE_2D
    int line_height;
#endif

    obj->invalidated = false;
    obj->invalidated_child = false;

    while (parent != NULL)
    {
        x1 += parent->x;
        y1 += parent->y;
        agui_index = parent->agui_index;
        parent = parent->parent;
    }
    agui = &agui_table[agui_index];
    canvas = agui->canvas;
    pointer = agui->pointer;
    x2 = x1 + w - 1;
    y2 = y1 + h - 1;

    string = listbox->item_string;
    string.text = str;
    l = listbox->list;
    string_height = graphics_get_fontheight(canvas, string.font) + 2 * string.y;
    string.y = 0;

    y = y1;
    top = true;
    bottom = false;
    i = listbox->first;

#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D

    cursor_hide(agui);

    if (relief != RELIEF_NONE)
    {
        agui_draw_outline_3d(agui, x1, y1, w, h, true, true, relief);
        x1++;
        y1++;
        x2--;
        y2--;
        w -= 2;
        h -= 2;
    }
    y = y1;

    item = list_get(&l, i);

    listbox->window = h / string_height;
    scrollbar_enabled = (listbox->window < listbox->count) && obj->enabled;
    scrollbar_visible = scrollbar_enabled || !listbox->autohide_scrollbar;

    if (scrollbar_visible)
    {
        listbox->scrollbar_visible = true;
        w -= AGUI_BAR_WIDTH;
        x2 -= AGUI_BAR_WIDTH;
    }

    while ( item && (( y + string_height) <= y2 ))
    {
        bottom = ( y + string_height) == y2;

        if (invalidated || item->invalidated)
        {
            color1 = item->selected ? listbox->selectioncolor : listbox->color;
            graphics_fill_rect(canvas, x1, y, w, string_height - separator, color1);

            /* copy first part of text that fits in the listbox, add "..." if cut-off */
            agui_cut_string_indicated(agui, str, item->text, sizeof(str)-1, string.font, string.fontstyle, w - 2 * string.x - 2);

            /* text is cut off, now draw next listbox-line*/
            agui_draw_string(agui, x1, y, x2, y + string_height, &string, obj->enabled);

            if (!bottom && separator)
            {
                if (relief == RELIEF_NONE)
                {
                    graphics_draw_line( canvas, x1, y + string_height - 1, x2, y + string_height - 1, agui->palette.disabled);
                }
                else
                {
                    graphics_draw_line( canvas, x1 + 1, y + string_height - 1, x2 - 1, y + string_height - 1, agui->palette.disabled);
                }
            }
            item->invalidated = false;
        }
        y += string_height;
        i++;
        top = false;
        item = list_get(&l, i);
    }


    /* clear unused space below text */
    if (!bottom)
    {
        graphics_fill_rect(canvas, x1, y, w, y2 + 1 - y, listbox->color);
    }

    if (scrollbar_visible)
    {
        scrollbar.agui = agui;
        scrollbar.x = x2 + 1;
        scrollbar.y = y1;
        scrollbar.w = AGUI_BAR_WIDTH;
        scrollbar.h = h;
        scrollbar.relief = relief;
        scrollbar.color = agui->palette.controlbg;
        scrollbar.enabled = scrollbar_enabled;
        scrollbar.range = listbox->count;
        scrollbar.window = listbox->window;
        scrollbar.position = listbox->first;
        scrollbar.handlecolor =agui->palette.control;

        _scrollbar_draw(&scrollbar);
    }

    cursor_show(agui);

#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D

    item = list_get(&l, i);

    listbox->window = (h - 2) / string_height;
    scrollbar_enabled = (listbox->window < listbox->count) && obj->enabled;
    scrollbar_visible = scrollbar_enabled || !listbox->autohide_scrollbar;

    if (scrollbar_visible)
    {
        if (!listbox->scrollbar_visible)
        {
            listbox->scrollbar_visible = true;
            agui_invalidate_area(agui, (rect_t){x2 - AGUI_BAR_WIDTH + 1 - AGUI_CORNER_RADIUS, y1, AGUI_CORNER_RADIUS * 2 + 1, h});
            obj_invalidate(obj);
            return;     // stop drawing, agui_invalidate_area() already have drawn the listbox
        }

        w -= AGUI_BAR_WIDTH - 1;
        x2 -= AGUI_BAR_WIDTH - 1;
    }
    listbox->scrollbar_visible = scrollbar_visible;

    cursor_hide(agui);

    if (scrollbar_visible)
    {
        scrollbar.agui = agui;
        scrollbar.x = x2;
        scrollbar.y = y1;
        scrollbar.w = AGUI_BAR_WIDTH;
        scrollbar.h = h;
        scrollbar.relief = relief;
        scrollbar.color = agui->palette.control;
        scrollbar.enabled = scrollbar_enabled;
        scrollbar.range = listbox->count;
        scrollbar.window = listbox->window;
        scrollbar.position = listbox->first;
        scrollbar.handlecolor = agui->palette.controltext;

        _scrollbar_draw(&scrollbar);
    }

    line_height = string_height + 2;

    while ( item && (( y + line_height ) <= y2 ))
    {
        bottom = ( y + line_height + AGUI_CORNER_RADIUS ) >= y2;
        if (bottom)
        {
            line_height = y2 - y + 1;
        }
        else
        {
            line_height = string_height + (top ? 1 : 0);
        }

        if (invalidated || item->invalidated)
        {
            color1 = item->selected ? listbox->selectioncolor : listbox->color;
            if (bottom)
            {
                separator = 0;
            }
            agui_draw_body_2d(agui, x1, y, w, line_height - separator, top, bottom, color1);

            /* cut off text till it fits in the listbox */
            agui_cut_string_indicated(agui, str, item->text, sizeof(str)-1, string.font, string.fontstyle, w - 2 * string.x - 2);

            /* text is cut off, now draw next listbox-line*/
            if (top)
            {
                agui_draw_string(agui, x1, y + 1, x2, y + 1 + string_height, &string, obj->enabled);
            }
            else
            {
                agui_draw_string(agui, x1, y, x2, y + string_height, &string, obj->enabled);
            }

            if (!bottom && listbox->separator)
            {
                graphics_draw_pixel( canvas, x1, y + line_height - 1, agui->palette.outline);
                graphics_draw_pixel( canvas, x2, y + line_height - 1, agui->palette.outline);
                graphics_draw_line( canvas, x1 + 1, y + line_height - 1, x2 - 1, y + line_height - 1, agui->palette.disabled);
            }
            item->invalidated = false;
        }
        y += line_height;
        i++;
        top = false;
        item = list_get(&l, i);
        line_height = string_height + 1;
    }

    /* clear unused space below text */
    if (!bottom)
    {
        agui_draw_body_2d(agui, x1, y, w, y2 + 1 - y, top, true, listbox->color);
    }

    cursor_show(agui);

#endif
}


/**
 * @brief    Handler for listbox
 *
 * This function is the handler for the listbox. The input event may result in one or more actions.
 *
 * @see
 *     listbox_t
 *
 * @param obj    Pointer to the object member of the listbox
 * @param input  Pointer to the input event (location and button state)
 *
 * @return Nothing
 */

void listbox_handler(obj_t *obj, const input_event_t *input)
{
    listbox_t *listbox = (listbox_t*)obj;
    obj_t *parent = obj->parent;
    int x1 = obj->x;
    int y1 = obj->y;
    int y;
    int i;
    int agui_index = obj->agui_index;
    canvas_t *canvas;
    list_t *l = listbox->list;
    listbox_item_t *item;
    int line_height;
    action_event_t action;
    _scrollbar_handler_t scrollbar;

    if (!obj->enabled)
    {
        return;
    }
    /* find location of listbox */
    while (parent != NULL)
    {
        x1 += parent->x;
        y1 += parent->y;
        agui_index = parent->agui_index;
        parent = parent->parent;
    }
    canvas = agui_table[agui_index].canvas;

    if (listbox->scrollbar_visible && (input->x > (x1 + obj->width - AGUI_BAR_WIDTH) || listbox->scrollbar_moving))
    {
        if (listbox->window < listbox->count)
        {
            scrollbar.x = x1 + obj->width - AGUI_BAR_WIDTH;
            scrollbar.y = y1;
            scrollbar.w = AGUI_BAR_WIDTH;
            scrollbar.h = obj->height;
            scrollbar.relief = listbox->relief;
            scrollbar.range = listbox->count;
            scrollbar.window = listbox->window;
            scrollbar.position = &listbox->first;
            scrollbar.moving = &listbox->scrollbar_moving;
            scrollbar.action = obj->action;
            scrollbar.caller = obj;

            _scrollbar_handler(&scrollbar, input);
        }
    }
    else if (input->buttons & BUTTON_LEFT_EVENT)
    {
        listbox->scrollbar_moving = false;

        action.x = input->x;
        action.y = input->y;
        action.button = BUTTON_LEFT;

        if (input->buttons & BUTTON_LEFT)
        {
            line_height = graphics_get_fontheight(canvas, listbox->item_string.font) + 2 * listbox->item_string.y;

#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D

            y = y1 + (listbox->relief == RELIEF_NONE ? 0 : 1);

#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D

            y = y1 + 1;

#endif

            i = listbox->first + (input->y - y) / line_height;

            if (listbox->multiselect)
            {
                item = list_get(&l, i);
                if (item)
                {
                    item->selected = !item->selected;
                    item->invalidated = true;
                    obj_invalidate_child(obj);
                    listbox->select = i;
                }
                else
                {
                    listbox->select = -1;
                }
            }
            else
            {
                if (i != listbox->select)
                {
                    if (listbox->select >= 0)
                    {
                        item = list_get(&l, listbox->select);
                        if (item)
                        {
                            item->selected = false;
                            item->invalidated = true;
                            obj_invalidate_child(obj);
                        }
                    }
                    item = list_get(&l, i);
                    if (item)
                    {
                        item->selected = true;
                        item->invalidated = true;
                        listbox->select = i;
                        obj_invalidate_child(obj);
                    }
                    else
                    {
                        listbox->select = -1;
                    }
                }
            }
            action.event = ACTION_PRESSED;
            obj_store_action(obj, obj->action, &action);
        }
        else
        {
            action.event = ACTION_RELEASED;
            obj_store_action(obj, obj->action, &action);
            listbox->scrollbar_moving = false;
        }
    }
}


/**
 * @brief    Set multi-select
 *
 * If multiselect is true, multiple items can be selected.
 * If multiselect is false, only one item can be selected.
 * After setting multiselec to false, the last item clicked (if any) will be the only selected item.
 *
 * @see
 *     listbox_t
 *
 * @param obj           Pointer to the object member of the listbox
 * @param multiselect   If true, multiple items can be selected
 *
 * @return              Nothing
 */

void listbox_set_multiselect(obj_t *obj, bool multiselect)
{
    listbox_t *listbox = (listbox_t*)obj;
    listbox_item_t *item;
    list_t *current;
    int i;

    if (listbox->multiselect != multiselect)
    {
        listbox->multiselect = multiselect;
        if (!multiselect)
        {
            i = 0;
            current = listbox->list;
            while (current)
            {
                item = list_get_next(&current);
                if (i == listbox->select)
                {
                    if (!item->selected)
                    {
                        item->selected = true;
                        item->invalidated = true;
                    }
                }
                else
                {
                    if (item->selected)
                    {
                        item->selected = false;
                        item->invalidated = true;
                    }
                }
                i++;
            }
            obj_invalidate_child(obj);
        }
    }
}

/**
 * @brief    Add an item to the listbox
 *
 * Add an item to the list of the listbox. Memory is allocated to store this item and the item is added at the end of the list.
 * Memory is allocated to copy the item-string @em str. The item-string is the text displayed in the listbox.
 * The void pointer @em vp is stored with the item and can be used to link any information to the item.
 *
 * @see
 *     listbox_t
 *
 * @param listbox   Pointer to the listbox
 * @param str       Item-string
 * @param vp        Void pointer
 *
 * @return Index of added item, -1 if error.
 */

int listbox_add( listbox_t *listbox, const char *str, void *vp )
{
    int retval;
    listbox_item_t *item;

    item = malloc(sizeof(listbox_item_t));
    item->text = malloc(strlen(str));
    strcpy(item->text, str);
    item->vp = vp;
    item->selected = false;
    item->invalidated = true;
    retval = list_add(&listbox->list, item);
    if (retval != -1)
    {
        listbox->count = retval + 1;
        obj_invalidate_child(&listbox->obj);
    }
    return retval;
}


/**
 * @brief    Insert an item in the listbox
 *
 * Insert an item in the list of the listbox. Memory is allocated to store this item and the item is added at the given index (0 = first line).
 * Memory will be allocated to copy the item-string 'str'. The item-string is the text displayed in the listbox.
 * The void pointer @em vp is stored with the item and can be used to link any information to the item.
 * If the given index is larger than the number of items in the list, the item is added at the end of the list.
 *
 * @see
 *     listbox_t
 *
 * @param listbox   Pointer to the listbox
 * @param str       Item-string
 * @param vp        Void pointer
 * @param index     Index where this item has to be inserted
 *
 * @return Index of inserted item, -1 if error.
 */

int listbox_insert( listbox_t *listbox, const char *str, void *vp, int index )
{
    int retval;
    listbox_item_t *item;
    list_t *current = listbox->list;

    item = malloc(sizeof(listbox_item_t));
    item->text = malloc(strlen(str));
    strcpy(item->text, str);
    item->vp = vp;
    item->selected = false;
    item->invalidated = true;
    retval = list_insert(&listbox->list, item, index);
    if (retval != -1)
    {
        listbox->count++;
        if (retval <= listbox->select)
        {
            listbox->select++;
        }
        list_set_current(&current, retval);
        item = list_get_next(&current);
        while (current)
        {
            item->invalidated = true;
            item = list_get_next(&current);
        }
        obj_invalidate_child(&listbox->obj);
    }
    return retval;
}


/**
 * @brief    Delete an item from the listbox
 *
 * Delete an item from the listbox. The index indicates the item to delete (0 = first line).
 * All memory allocated when adding this item (item and item-string) will be freed.
 * If the given index doesn't exists, the function returns -1.
 *
 *
 * @see
 *     listbox_t
 *
 * @param listbox   Pointer to the listbox
 * @param index     Index of the item to be deleted
 *
 * @return Index of deleted item, -1 if error.
 */

int listbox_delete( listbox_t *listbox, int index )
{
    int retval;
    listbox_item_t *item;

    if (listbox_count(listbox) == 0)
    {
        return -1;
    }

    item = list_get(&listbox->list, index);
    free(item->text);
    free(item);
    retval = list_delete(&listbox->list, index);
    if (retval != -1)
    {
        listbox->count--;
        if (retval < listbox->select)
        {
            listbox->select--;
        }
        else if (retval == listbox->select)
        {
            listbox->select = -1;
        }
        obj_invalidate(&listbox->obj);
    }
    return retval;
}


/**
 * @brief    Count the items in the listbox
 *
 * Count the items in the listbox.
 *
 *
 * @see
 *     listbox_t
 *
 * @param listbox   Pointer to the listbox
 *
 * @return Number of items in the listbox
 */

int listbox_count( listbox_t *listbox)
{
    int count = 0;

    count = list_count(&listbox->list);
    listbox->count = count;

    if (listbox->select >= count)
    {
        listbox->select = -1;
    }
    return count;
}


/**
 * @brief    Get the text of the item
 *
 * Get the text that belongs to the item indicated by the index.
 *
 * @see
 *     listbox_t
 *
 * @param listbox   Pointer to the listbox
 * @param index     Index of the item which text is asked for
 *
 * @return String if item exists, otherwise NULL
 */

char* listbox_get_text( listbox_t *listbox, int index)
{
    listbox_item_t *item;
    item = list_get(&listbox->list, index);
    if (item)
    {
        return item->text;
    }
    return NULL;
}


/**
 * @brief    Get the void pointer of the item
 *
 * Get the void pointer that belongs to the item indicated by the index.
 *
 * @see
 *     listbox_t
 *
 * @param listbox   Pointer to the listbox
 * @param index     Index of the item which text is asked for
 *
 * @return String if item exists, otherwise NULL
 */

void* listbox_get_vp( listbox_t *listbox, int index)
{
    listbox_item_t *item;
    item = list_get(&listbox->list, index);
    if (item)
    {
        return item->vp;
    }
    return NULL;
}


/**
 * @brief    Sort the listbox
 *
 * Sort the listbox alphabetically. Set the descending flag to sort descending.
 *
 * @see
 *     listbox_t
 *
 * @param listbox       Pointer to the listbox
 * @param descending    Sort descending
 *
 * @return Nothing
 */

void listbox_sort( listbox_t *listbox, bool descending )
{
    list_t *current;
    listbox_item_t *item;
    /*
     * list_sort uses bubble-sort to sort the list
     */

    if (listbox->sort)
    {
        list_sort(&listbox->list, listbox->sort, descending);
    }
    else
    {
        list_sort(&listbox->list, _listbox_sort, descending);
    }
    current = listbox->list;
    while (current)
    {
        item = list_get_next(&current);
        item->invalidated = true;
    }
    obj_invalidate_child(&listbox->obj);
}


/**
 * @brief    Clear the listbox
 *
 * Clear the listbox. This will delete all items
 *
 * @see
 *     listbox_t
 *
 * @param listbox   Pointer to the listbox
 *
 * @return Nothing
 */

void listbox_clear( listbox_t *listbox )
{
    while (listbox->count)
    {
        listbox_delete(listbox, 0);
    }
    listbox->select = -1;
    listbox->first = 0;
    obj_invalidate(&listbox->obj);
}


/**
 * @brief    Get selected item index
 *
 * Get the index of the selected items. The index-array is filled with the indices of the selected items.
 * If the number of selected items is larger as the size of the array, only the first indices are given.
 *
 * @see
 *     listbox_t
 *
 * @param listbox       Pointer to the listbox
 * @param index_array   Pointer to index-array
 * @param size          Size of the index-array
 *
 * @return Number of selected items 
 */

int listbox_get_selection( listbox_t *listbox, int index_array[], int size )
{
    int i = 0;
    int j = 0;
    listbox_item_t *item;
    list_t *current = listbox->list;

    while (current)
    {
        item = list_get_next(&current);
        if (item->selected)
        {
            if (i < size)
            {
                index_array[i] = j;
            }
            i++;
        }
        j++;
    }
    return i;
}
