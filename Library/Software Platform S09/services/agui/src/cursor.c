#include <stdlib.h>
#include <graphics.h>
#include <pointer.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg.h"


#define cursor_arrow_small_size (sizeof(arrow_small_pattern)/sizeof(arrow_small_pattern[0]))
#define cursor_arrow_medium_size (sizeof(arrow_medium_pattern)/sizeof(arrow_medium_pattern[0]))
#define cursor_arrow_large_size (sizeof(arrow_large_pattern)/sizeof(arrow_large_pattern[0]))
#define cursor_crosshair_size (sizeof(crosshair_pattern)/sizeof(crosshair_pattern[0]))
#define cursor_arrow_size (sizeof(arrow_pattern)/sizeof(arrow_pattern[0]))


enum
{
    C1, // black
    C2, // white
    C3  // shadow
};

static color_t color[3] =
{
    BLACK,
    WHITE,
    BLACK
};

static uint8_t alpha[3] =
{
    255,
    255,
    96
};



/* arrow_small */
static const cursor_element_t arrow_small_pattern[25] =
{
    {C1, 0, 1},
    {C1, 1, 0},{C1,-1, 1},
    {C1, 1, 0},{C2, 1, 0},{C1,-2, 1},
    {C1, 1, 0},{C2, 1 ,0},{C2, 1, 0},{C1,-3, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C1,-4, 1},
    {C1, 1, 0},{C1, 1, 0},{C1,-2, 1},
    {C1, 2, 0},           {C1, 1, 0},{C1, 0, 1},
                                     {C1, 0, 1},
                                     {C1, 1, 0},{C1, 0, 1},
                                                {C1, 0, 0}
};

const cursor_shape_t cursor_arrow_small =
{
    cursor_arrow_small_size,
    arrow_small_pattern
};


/* arrow_medium */
static const cursor_element_t arrow_medium_pattern[57] =
{
    {C1, 0, 1},
    {C1, 1, 0},{C1,-1, 1},
    {C1, 1, 0},{C2, 1, 0},{C1,-2, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1,-3, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1,-4, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1,-5, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1,-6, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1,-7, 1},
    {C1, 1, 0},{C2, 1, 0},{C1, 1, 0},{C2, 1, 0},{C1,-4, 1},
    {C1, 1, 0},{C1, 2, 0},           {C1, 1, 0},{C2, 1, 0},{C1,-5, 1},
    {C1, 3, 0},                      {C1, 1, 0},{C2, 1, 0},{C1,-1, 1},
                                                {C1, 1, 0},{C2, 1, 0},{C1,-2, 1},
                                                {C1, 1, 0},{C2, 1, 0},{C1,-1, 1},
                                                           {C1, 0, 0}
};

const cursor_shape_t cursor_arrow_medium =
{
    cursor_arrow_medium_size,
    arrow_medium_pattern
};


/* arrow_large */
static const cursor_element_t arrow_large_pattern[157] =
{
    {C1, 0, 1},
    {C1, 1, 0},{C1, 2, 0},           {C3,-3, 1},
    {C1, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-4, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-5, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-6, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-7, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-8, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-9, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-10, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-11, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-12, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3,-13, 1},
    {C1, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-9, 1},
    {C1, 1, 0},{C1, 2, 0},           {C3, 1, 0},{C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3,-10, 1},
    {C1, 3, 0},                      {C3, 1, 0},{C3, 1, 0},{C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-7, 1},
                                     {C3, 2, 0},           {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3,-5, 1},
                                                                      {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-5, 1},
                                                                      {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3,-5, 1},
                                                                                 {C1, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3,-2, 1},
                                                                                                                  {C3, 1, 0},{C3, 0, 0}
};

const cursor_shape_t cursor_arrow_large =
{
    cursor_arrow_large_size,
    arrow_large_pattern
};



/* arrow_crosshair */
static const cursor_element_t crosshair_pattern[45] =
{
    {C2,-1,-4},  // center is active point, jump to top of cross
                                     {C1, 1, 0},{C1, 1, 0},{C1,-2, 1},
                                     {C1, 1, 0},{C2, 1, 0},{C1,-2, 1},
                                     {C1, 1, 0},{C2, 1, 0},{C1,-5, 1},
    {C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C2, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1,-8, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 2, 0},           {C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1,-8, 1},
    {C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C2, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1,-5, 1},
                                     {C1, 1, 0},{C2, 1, 0},{C1,-2, 1},
                                     {C1, 1, 0},{C2, 1, 0},{C1,-2, 1},
                                     {C1, 1, 0},{C1, 1, 0},{C1, 0, 0}
};

const cursor_shape_t cursor_crosshair =
{
    cursor_crosshair_size,
    crosshair_pattern
};



/* arrow */
static const cursor_element_t arrow_pattern[101] =
{
    {C1, 0, 1},
    {C1, 1, 0},{C1, 2, 0},           {C3,-3, 1},
    {C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-4, 1},
    {C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-5, 1},
    {C1, 1, 0},{C2, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-6, 1},
    {C1, 1, 0},{C2, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-7, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-8, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-9, 1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-10,1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3,-11,1},
    {C1, 1, 0},{C2, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3,-12,1},
    {C1, 1, 0},{C2, 1, 0},{C1, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3, 1, 0},{C3,-6, 1},
    {C1, 1, 0},{C1, 2, 0},           {C3, 1, 0},{C3, 1, 0},{C3,-5, 1},
    {C1, 3, 0},                      {C3, 1, 0},{C3,-1, 1},
                                     {C3, 0, 0}
};

const cursor_shape_t cursor_arrow =
{
    cursor_arrow_size,
    arrow_pattern
};


static color_t cursor_background[256];


/**
 * @brief    Set cursor shape
 *
 * This function changes the shape of the cursor. Provided cursor shapes are listed in cursor.h
 *
 * @param  agui    Service pointer as returned from agui_open()
 * @param  cursor  Pointer to the cursor shape
 *
 * @return Nothing
 */

void cursor_set_shape(agui_t *agui, const cursor_shape_t *cursor)
{
    if (cursor != NULL && cursor != agui->cursor.shape)
    {
        cursor_hide(agui);
        agui->cursor.shape = cursor;
        cursor_show(agui);
    }
}


/**
 * @brief    Set cursor position
 *
 * This function moves the cursor to the given position.
 *
 * @param  agui    Service pointer as returned from agui_open()
 * @param  point   New position
 *
 * @return Nothing
 */

void cursor_set_position(agui_t *agui, point_t point)
{
    pointer_t *pointer = agui->pointer;

    pointer_set_position(pointer, point.x, point.y);
    cursor_hide(agui);
    agui->cursor.x = point.x;
    agui->cursor.y = point.y;
    cursor_show(agui);
}


/**
 * @brief    Get current cursor position
 *
 * This function returns the current cursor position.
 *
 * @param  agui    Service pointer as returned from agui_open()
 *
 * @return Current cursor position
 */

point_t cursor_get_position(agui_t *agui)
{
    point_t result;

    result.x = agui->cursor.x;
    result.y = agui->cursor.y;

    return result;
}


/**
 * @brief    Update cursor
 *
 * This function updates the cursor state, i.e the current position and button state.
 *
 * @param  agui    Service pointer as returned from agui_open()
 * @param  input   Will be filled by this function
 *
 * @return True if the position and/or the button state is updated, false otherwise 
 */

bool cursor_update(agui_t *agui, input_event_t *input)
{
    pointer_t *pointer = agui->pointer;
    pointer_state_t state;
    bool result;

    result = pointer_update(pointer, &state);

    input->x = state.x;
    input->y = state.y;
    input->buttons = (int)state.buttons;
    if (agui->cursor.x != input->x || agui->cursor.y != input->y)
    {
        cursor_hide(agui);
        agui->cursor.x = input->x;
        agui->cursor.y = input->y;
        cursor_show(agui);
    }

    return result;
}

/**
 * @brief    Unhide the cursor one level
 *
 * This function decrements the hide-level of the cursor one level.
 * The cursor becomes visible if the hide-level changes from one to zero.
 * Call cursor_hide() to increment the hide-level.
 *
 * @param  agui    Service pointer as returned from graphics_open()
 *
 * @return New hide-level
 */

int cursor_show( agui_t *agui )
{
    int x = agui->cursor.x;
    int y = agui->cursor.y;
    int size = agui->cursor.shape->size;
    int w = graphics_get_width(agui->graphics);
    int h = graphics_get_height(agui->graphics);
    color_t *pb = cursor_background;                // local pointer to cursor_background
    cursor_element_t const *pp = agui->cursor.shape->pattern;    // local pointer to cursor_pattern

    if ( agui->cursor.shape && agui->cursor.hide_level == 1 )
    {
        for ( int i = 0; i < size; i++ )
        {
            if ( (unsigned int)x < w && (unsigned int)y < h)
            {
                *pb = graphics_get_pixel(agui->canvas, x, y);
                graphics_draw_pixel_alpha(agui->canvas, x, y,  color[pp->color], alpha[pp->color]);
            }
            pb++;
            x += pp->move_x;
            y += pp->move_y;
            pp++;
        }
    }
    return agui->cursor.hide_level--;
}


/**
 * @brief    Hide the cursor one level
 *
 * This function increments the hide-level of the cursor one level.
 * The cursor becomes invisible if the hide-level changes from zero to one.
 * Call cursor_show() to decrement the hide-level.
 *
 * @param  agui    Service pointer as returned from graphics_open()
 *
 * @return New hide-level
 */

int cursor_hide( agui_t *agui )
{
    int x = agui->cursor.x;
    int y = agui->cursor.y;
    int size = agui->cursor.shape->size;
    int w = graphics_get_width(agui->graphics);
    int h = graphics_get_height(agui->graphics);
    color_t *pb = cursor_background;                // local pointer to cursor_background
    cursor_element_t const *pp = agui->cursor.shape->pattern;    // local pointer to cursor_pattern

    if ( agui->cursor.shape && agui->cursor.hide_level == 0 )
    {

        for ( int i = 0; i < size; i++ )
        {
            if ( (unsigned int)x < w && (unsigned int)y < h )
            {
                graphics_draw_pixel(agui->canvas, x, y,  *pb);
            }
            pb++;
            x += pp->move_x;
            y += pp->move_y;
            pp++;
        }
    }
    return agui->cursor.hide_level++;
}

