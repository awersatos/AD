#include <stdlib.h>
#include <graphics.h>
#include <pointer.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg.h"

/**
 * @brief    Draw a label
 *
 * Draw a label on the canvas.
 *
 * @see
 *     label_t
 *
 * @param obj    Pointer to the object member of the label
 *
 * @return Nothing
 */

void label_draw(obj_t *obj)
{
    label_t *label = (label_t*)obj;
    obj_t *parent = obj->parent;
    int x = obj->x;
    int y = obj->y;
    graphics_t * restrict graphics;
    agui_t * restrict agui;
    int agui_index = obj->agui_index;

    obj->invalidated = false;

    if (label->text.text == NULL)
    {
        return;
    }

    while (parent != NULL)
    {
        x += parent->x;
        y += parent->y;
        agui_index = parent->agui_index;
        parent = parent->parent;
    }
    agui = &agui_table[agui_index];
    graphics = agui->graphics;

    cursor_hide(agui);
    agui_draw_string(agui, x, y, x + obj->width - 1, y + obj->height - 1, &label->text, obj->enabled);
    cursor_show(agui);
}

