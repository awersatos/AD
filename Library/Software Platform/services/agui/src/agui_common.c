#include <string.h>
#include <components.h>
#include <graphics.h>
#include <agui.h>
#include <agui_i.h>
#include <pal.h>
#include <ctype.h>


/* No public functions insite this file */



/*
 * get the number of characters of the string that fits within the given width
 * 
 * agui = agui pointer
 * string = string
 * width =  maximum width of the string in pixels
 */
int agui_get_fitting_string_count(agui_t *agui, const string_t *string, int width)
{
    unsigned int len;
    unsigned int low = 0;
    unsigned int high;
    unsigned int step;

    len = high = strlen(string->text);
    step = (len + 1) / 2;

    do
    {
        if (graphics_get_nstringwidth(agui->canvas, string->text, string->font, string->fontstyle, len) <= width)
        {
            low = len;
            len += step;
        }
        else
        {
            high = len;
            len -= step;
        }
        step++;
        step /= 2;
    } while (low + 1 < high);

    return low;
}


/*
 * get the number of characters of the string that fits within the given width
 * This function will break at whitespace, return ('\\n') or,
 * if this will not end up in a string of given maximum width, halfway a word.
 *
 * agui = agui pointer
 * string = string
 * width =  maximum width of the string in pixels
 */
int agui_get_breaking_string_count(agui_t *agui, const string_t *string, int width)
{
    const char *str = string->text;
    const char *cursor = str;
    const char *last_cursor = str;
    unsigned int len, nlen;

    /* empty string? */
    if (*cursor == '\0')
    {
        return 0;
    }

    /* get max number of chars that fits within width */
    len = agui_get_fitting_string_count(agui, string, width);

    /* new-line in these chars, or number of chars is length of whole string? */
    nlen = strcspn(str, "\n");   // get new-line position, or string length if no new-line
    if (nlen <= len)
    {
        return nlen;
    }

    /* find last whitespace to break on */
    while (cursor && (cursor <= (str + len)))
    {
        last_cursor = cursor;
        cursor++;
        cursor = strpbrk(cursor, " \t");
    }

    /* look for break char (-) after last whitespace */
    cursor = last_cursor - 1;

    while (cursor && (cursor < (str + len)))
    {
        cursor++;
        last_cursor = cursor;
        cursor = strpbrk(cursor, "-");
    }

    return last_cursor > str ? last_cursor - str : len;
}


int agui_align_horizontal(agui_t *agui, int left, int right, const string_t *string)
{

    switch ( string->align & 0xF0 )
    {
    case ALIGN_RIGHT:
        return right + 1 - string->x - graphics_get_stringwidth(agui->canvas, string->text, string->font, string->fontstyle);
    case ALIGN_HORIZONTAL:
        return (left + right + 1 - graphics_get_stringwidth(agui->canvas, string->text, string->font, string->fontstyle )) / 2;
    case ALIGN_LEFT:
    default:
        return left + string->x;
    }
}


int agui_align_horizontal_count(agui_t *agui, int left, int right, const string_t *string, unsigned int count)
{

    switch ( string->align & 0xF0 )
    {
    case ALIGN_RIGHT:
        return right + 1 - string->x - graphics_get_nstringwidth(agui->canvas, string->text, string->font, string->fontstyle, count);
    case ALIGN_HORIZONTAL:
        return (left + right + 1 - graphics_get_nstringwidth(agui->canvas, string->text, string->font, string->fontstyle, count )) / 2;
    case ALIGN_LEFT:
    default:
        return left + string->x;
    }
}


int agui_align_vertical(agui_t *agui, int top, int bottom, const string_t *string)
{
    switch ( string->align & 0x0F )
    {
    case ALIGN_BOTTOM:
        return bottom + 1 - string->y - graphics_get_fontheight(agui->canvas, string->font);
    case ALIGN_VERTICAL:
        return ( top + bottom + 1 - graphics_get_fontheight(agui->canvas, string->font)) / 2;
    case ALIGN_TOP:
    default:
        return top + string->y;
    }
}


/*
 * Draw the string inside the given rectangle. The size of the string is not checked.
 *
 * agui = agui pointer
 * left = left side of rectangle
 * top = top side of rectangle
 * right = right side of rectangle
 * bottom = bottom side of rectangle
 * string = string
 * enabled = color is related to enabled/disabled
 */
void agui_draw_string(agui_t *agui, int left, int top, int right, int bottom, const string_t *string, bool enabled)
{
    canvas_t *canvas;
    int x, y;
    color_t color;

    if (agui == NULL || string->text == NULL)
    {
        return;
    }

    canvas = agui->canvas;
    x = agui_align_horizontal(agui, left, right, string);
    y = agui_align_vertical(agui, top, bottom, string);

    color = enabled ? string->color : agui->palette.disabled_dark;
    graphics_draw_string( canvas, x, y, string->text, string->font, color, string->fontstyle);
}


/*
 * Draw the string inside the given rectangle. If the length of the string if greater than
 * the widht of the rectangle, clip the string. The height of the string is not checked.
 * If indication = true, the function draws three dots (...) at the end of the string if string clips.
 *
 * agui = agui pointer
 * left = left side of rectangle
 * top = top side of rectangle
 * right = right side of rectangle
 * bottom = bottom side of rectangle
 * string = string
 * enabled = color is related to enabled/disabled
 * clip_mark = add 3 dots at the end if true and clipped
 */
void agui_draw_string_clipped(agui_t *agui, int left, int top, int right, int bottom, const string_t *string, bool enabled, bool clip_mark)
{
    int w, x, y;
    int clip_mark_width = 0, string_width;
    int count;
    color_t color;

    w = right - left - 2 * string->x;
    if (graphics_get_stringwidth(agui->canvas, string->text, string->font, string->fontstyle) <= w)
    {
        /* string fits */
        agui_draw_string(agui, left, top, right, bottom, string, enabled);
    }
    else
    {
        if (clip_mark)
        {
            clip_mark_width = graphics_get_stringwidth(agui->canvas, "....", string->font, string->fontstyle) - graphics_get_stringwidth(agui->canvas, ".", string->font, string->fontstyle);
        }
        count = agui_get_fitting_string_count(agui, string, w - clip_mark_width);
        string_width = graphics_get_nstringwidth(agui->canvas, string->text, string->font, string->fontstyle, count) + clip_mark_width;

        switch ( string->align & 0xF0 )
        {
        case ALIGN_RIGHT:
            x =  right + 1 - string->x - string_width;
            break;
        case ALIGN_HORIZONTAL:
            x = (left + right + 1 - string_width) / 2;
            break;
        case ALIGN_LEFT:
        default:
            x = left + string->x;
        }

        y = agui_align_vertical(agui, top, bottom, string);
        color = enabled ? string->color : agui->palette.disabled_dark;
        x = graphics_draw_nstring( agui->canvas, x, y, string->text, string->font, color, string->fontstyle, count);
        if (clip_mark)
        {
            graphics_draw_string( agui->canvas, x, y, "...", string->font, color, string->fontstyle);
        }
    }
}


bool obj_repeat(obj_t *obj)
{
    agui_t * restrict agui;
    int agui_index = obj->agui_index;
    obj_t *parent = obj->parent;

    while (parent != NULL)
    {
        agui_index = parent->agui_index;
        parent = parent->parent;
    }
    agui = &agui_table[agui_index];

    if (obj != agui->repeat_obj)
    {
        return false;
    }

    if (clock() < agui->next_repeat)
    {
        return false;
    }
    agui->next_repeat = clock() + (clock_t)PAL_CLOCKHZ / 8;
    return true;

}


void obj_set_repeat(obj_t *obj)
{
    agui_t * restrict agui;
    int agui_index = obj->agui_index;
    obj_t *parent = obj->parent;

    while (parent != NULL)
    {
        agui_index = parent->agui_index;
        parent = parent->parent;
    }
    agui = &agui_table[agui_index];

    agui->repeat_obj = obj;
    agui->next_repeat = clock() + (clock_t)PAL_CLOCKHZ / 2;
}


bool obj_store_action(obj_t *obj, action_t action, action_event_t *event)
{
    action_queue_t * restrict queue;
    int next;
    bool result = false;
    agui_t * restrict agui;
    int agui_index;
    obj_t *parent;

    if (action == NULL || obj == NULL || event == NULL)
    {
        return false;   // invalid input
    }

    agui_index = obj->agui_index;
    parent = obj->parent;

    if (obj->direct_action)
    {
        action(obj, event); // execute direct action,
        return true;        // nothing to store
    }

    while (parent != NULL)
    {
        agui_index = parent->agui_index;
        parent = parent->parent;
    }
    agui = &agui_table[agui_index];
    queue = &agui->action_queue;

    ACTION_MUTEX_LOCK;

    next = queue->head + 1;

    if (next >= (sizeof(queue->messages)/sizeof(queue->messages[0])))
    {
        next = 0;
    }

    if (queue->tail != next)
    {
        queue->messages[queue->head].action = action;
        queue->messages[queue->head].obj = obj;
        queue->messages[queue->head].event = *event;
        queue->head = next;
        result = true;
    }
    ACTION_MUTEX_UNLOCK;

    return result;
}


void obj_invalidate_child(obj_t *obj)
{
    int agui_index = -1;
    while (obj)
    {
        obj->invalidated_child = true;
        agui_index = obj->agui_index;
        obj = obj->parent;
    }
    if (agui_index != -1)
    {
        agui_table[agui_index].invalidated = true;
    }
}


int stricmp( const char *s1, const char *s2 )
{
    unsigned int c1, c2;
    do
    {
        c2 = toupper(*s2++);
        c1 = toupper(*s1++);
    } while ( c1 != '\0' && c1 == c2);
    return( (int)c1 - (int)c2 );
}


/* concatenate rect 1 and rect 2 and store result in rect 1
 * concatenation gives the smallest rectangle that covers both rectangles */
void agui_rect_cat(rect_t * restrict rect1, const rect_t * restrict rect2)
{
    int right1, right2, right;
    int bottom1, bottom2, bottom;

    if (rect2->width <= 0 || rect2->height <= 0)
    {
        /* rect2 doesn't exist, return rect1 */
        return;
    }

    if (rect1->width <= 0 || rect1->height <= 0)
    {
        /* rect1 doesn't exist, return rect2 */
        *rect1 = *rect2;
        return;
    }

    /* both exist, concatenate */
    right1 = rect1->x + rect1->width;
    right2 = rect2->x + rect2->width;
    right  = right1 > right2 ? right1 : right2;

    rect1->x = rect1->x < rect2->x ? rect1->x : rect2->x;
    rect1->width = right - rect1->x;

    bottom1 = rect1->y + rect1->height;
    bottom2 = rect2->y + rect2->height;
    bottom  = bottom1 > bottom2 ? bottom1 : bottom2;

    rect1->y = rect1->y < rect2->y ? rect1->y : rect2->y;
    rect1->height = bottom - rect1->y;
}


/* intersection of rect 1 and rect 2, result stored in rect 1
 * intersection gives the largest rectangle that is part of both rectangles */
void agui_rect_isect(rect_t * restrict rect1, const rect_t * restrict rect2)
{
    int right1, right2, right;
    int bottom1, bottom2, bottom;

    right1 = rect1->x + rect1->width;
    right2 = rect2->x + rect2->width;
    right  = right1 < right2 ? right1 : right2;

    rect1->x = rect1->x > rect2->x ? rect1->x : rect2->x;
    rect1->width = right - rect1->x;
    if (rect1->width < 0) rect1->width = 0;

    bottom1 = rect1->y + rect1->height;
    bottom2 = rect2->y + rect2->height;
    bottom  = bottom1 < bottom2 ? bottom1 : bottom2;

    rect1->y = rect1->y > rect2->y ? rect1->y : rect2->y;
    rect1->height = bottom - rect1->y;
    if (rect1->height < 0) rect1->height = 0;
}


/* complement of rect 2 in rect 1, result stored in rect 1
 * complement gives the smallest rectangle that covers the part of rect 1 that is not in rect 2,
 * the result may be equal to rect 1, even while rect 1 intersects with rect 2 */
void agui_rect_cmpl(rect_t * restrict rect1, const rect_t * restrict rect2)
{
    int right1, right2;
    int bottom1, bottom2;

    right1 = rect1->x + rect1->width - 1;
    right2 = rect2->x + rect2->width - 1;
    bottom1 = rect1->y + rect1->height - 1;
    bottom2 = rect2->y + rect2->height - 1;

    if (rect1->x >= rect2->x && right1 <= right2)
    {
        /* rect 1 is within rect 2 in x-direction */
        if (rect1->y >= rect2->y && bottom1 <= bottom2)
        {
            /* rect 1 is completely within rect 2 */
            rect1->width = 0;
            rect1->height = 0;
        }
        else if (rect1->y < rect2->y && bottom1 <= bottom2 && bottom1 >= rect2->y)
        {
            /* rect 1 is partly above rect 2 */
            rect1->height = rect2->y - rect1->y;
        }
        else if (rect1->y >= rect2->y && bottom1 > bottom2 && rect1->y <= bottom2)
        {
            /* rect 1 is partly below rect 2 */
            rect1->y = rect2->y + 1;
            rect1->height = bottom1 - rect1->y;
        }
        /* else keep original size */
    }
    else if (rect1->x < rect2->x && right1 <= right2 && right1 >= rect2->x)
    {
        /* rect 1 is partly left of rect 2 */
        if (rect1->y >= rect2->y && bottom1 <= bottom2)
        {
            /* rect 1 is within rect 2 in y-direction */
            rect1->width = rect2->x - rect1->x;
        }
        /* else keep original size */
    }
    else if (rect1->x >= rect2->x && right1 > right2 && rect1->x <= right2)
    {
        /* rect 1 is partly right of rect 2 */
        if (rect1->y >= rect2->y && bottom1 <= bottom2)
        {
            /* rect 1 is within rect 2 in y-direction */
            rect1->x = right2 + 1;
            rect1->width = right1 - rect1->x;
        }
        /* else keep original size */
    }
}


