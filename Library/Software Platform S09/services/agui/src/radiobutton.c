/*****************************************************************************\
|*
|*  IN PACKAGE:     Agui
|*
|*  COPYRIGHT:      Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:    Raduobutton routines
|*
 */

#include <stdlib.h>
#include <graphics.h>
#include <pointer.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg.h"


/**
 * @brief    Draw a radiobutton
 *
 * Draw an radiobutton on the canvas.
 *
 * @see
 *     radiobutton_t
 *
 * @param obj    Pointer to the object member of the radiobutton
 *
 * @return Nothing
 */

void radiobutton_draw(obj_t *obj)
{
    radiobutton_t *rbutton = (radiobutton_t*)obj;
    obj_t *parent = obj->parent;
    int x1 = obj->x;
    int x2;
    int y1 = obj->y;
    int y2;
    int agui_index = obj->agui_index;
    canvas_t * restrict canvas;
    agui_t * restrict agui;
#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D
    color_t color1, color2;
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
    x2 = x1 + AGUI_CHECKBOX_SIZE - 1;
    y2 = y1 + AGUI_CHECKBOX_SIZE - 1;

    cursor_hide(agui);

    graphics_fill_circle(canvas, x1 + AGUI_CHECKBOX_SIZE/2, y1 + AGUI_CHECKBOX_SIZE/2, AGUI_CHECKBOX_SIZE/2, rbutton->color);

#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D

    switch (rbutton->relief)
    {
    case RELIEF_RAISED:
        color1 = agui->palette.lightoutline;
        color2 = agui->palette.darkoutline;
        break;
    case RELIEF_FLAT:
        color1 = agui->palette.darkoutline;
        color2 = agui->palette.darkoutline;
        break;
    case RELIEF_LOWERED:
    default:
        color1 = agui->palette.darkoutline;
        color2 = agui->palette.lightoutline;
        break;
    }

    graphics_draw_arc(canvas, x1 + AGUI_CHECKBOX_SIZE/2, y1 + AGUI_CHECKBOX_SIZE/2, AGUI_CHECKBOX_SIZE/2, 45, 180, color1);
    graphics_draw_arc(canvas, x1 + AGUI_CHECKBOX_SIZE/2, y1 + AGUI_CHECKBOX_SIZE/2, AGUI_CHECKBOX_SIZE/2, 225, 180, color2);

#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D

    graphics_draw_circle(canvas, x1 + AGUI_CHECKBOX_SIZE/2, y1 + AGUI_CHECKBOX_SIZE/2, AGUI_CHECKBOX_SIZE/2, agui->palette.outline);

#endif

    if (rbutton->selected)
    {
        graphics_fill_circle(canvas, x1 + AGUI_CHECKBOX_SIZE/2, y1 + AGUI_CHECKBOX_SIZE/2, (AGUI_CHECKBOX_SIZE-1)/4, agui->palette.edittext);
    }

    agui_draw_string( agui, x2 + 2, y1, x1 - 2, y2, &rbutton->label, true);

    cursor_show(agui);
}


static void _radiogroup_draw(obj_t *obj)
{
    radiogroup_t *rbgroup = (radiogroup_t*)obj;
    obj_t *parent = obj->parent;
    int x1 = obj->x;
    int x2;
    int y1 = obj->y;
    int y2;
    int w = obj->width;
    int h = obj->height;
    int agui_index = obj->agui_index;
    canvas_t * restrict canvas;
    agui_t * restrict agui;

    obj->invalidated = false;

    while (parent != NULL)
    {
        x1 += parent->x;
        y1 += parent->y;
        agui_index = parent->agui_index;
        parent = parent->parent;
    }
    agui = &agui_table[agui_index];
    canvas = agui->canvas;
    x2 = x1 + w - 1;
    y2 = y1 + h - 1;

    cursor_hide(agui);

#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D

    agui_draw_body_3d(agui, x1, y1, w, h, true, true, rbgroup->relief, rbgroup->color );

#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D

    agui_draw_body_2d(agui, x1, y1, w, h, true, true, rbgroup->color);

#endif

    for (int i = 0; i < rbgroup->n_buttons; i++)
    {
        obj_draw(&rbgroup->buttons[i]->obj);
    }

    agui_draw_string(agui, x1, y1, x2, y2, &rbgroup->label, obj->enabled);

    cursor_show(agui);
}


/**
 * @brief    Draw a radiogroup
 *
 * Draw an radiogroup on the canvas.
 *
 * @see
 *     radiogroup_t
 *
 * @param obj    Pointer to the object member of the radiogroup
 *
 * @return Nothing
 */

void radiogroup_draw(obj_t *obj)
{
    radiogroup_t *rgroup = (radiogroup_t*)obj;
    radiobutton_t **rbutton = rgroup->buttons;
    radiobutton_t *cur_button = NULL;

    if (obj->invalidated)
    {
        _radiogroup_draw(obj);
    }
    else
    {
        obj->invalidated_child = false;

        for (int i = rgroup->n_buttons - 1; i >= 0; i--)
        {
            if (rbutton[i] != NULL)
            {
                cur_button = rbutton[i];
                if (cur_button->obj.invalidated)
                {
                    if (cur_button->obj.draw)
                    {
                        cur_button->obj.draw(&cur_button->obj);
                    }
                }
            }
        }
    }
}


/**
 * @brief    Handler for a radiogroup
 *
 * Handle the pointer-event for radiogroups. The input event may result in one or more actions.
 *
 * @see
 *     radiogroup_t
 *
 * @param obj    Pointer to the object member of the radiogroup
 * @param input  Pointer to the input event (location and button state)
 *
 * @return Nothing
 */

void radiogroup_handler(obj_t *obj, const input_event_t *input)
{
    radiogroup_t *rgroup = (radiogroup_t*)obj;
    obj_t *parent = rgroup->obj.parent;
    int i;
    radiobutton_t **rbutton = rgroup->buttons;
    radiobutton_t *cur_button = NULL;
    int x, y;
    action_event_t action;

    cursor_set_shape(&agui_table[obj->agui_index], obj->cursor_shape);

    if ((( input->buttons & (BUTTON_LEFT | BUTTON_LEFT_EVENT) ) == (BUTTON_LEFT | BUTTON_LEFT_EVENT) ) && obj->enabled)         // left click and enabled
    {
        action.x = input->x;
        action.y = input->y;
        action.button = BUTTON_LEFT;

        for (i = 0; i < rgroup->n_buttons; i++)
        {
            if (rbutton[i] != NULL)
            {
                cur_button = rbutton[i];
                parent = cur_button->obj.parent;
                x = cur_button->obj.x;
                y = cur_button->obj.y;
                while (parent != NULL)
                {
                    x += parent->x;
                    y += parent->y;
                    parent = parent->parent;
                }
                if (x <= input->x &&
                    x + cur_button->obj.width >= input->x &&
                    y <= input->y &&
                    y + cur_button->obj.height >= input->y)
                {
                    break;
                }
            }
        }
        if (i != rgroup->n_buttons) // button found
        {
            if (i != rgroup->selected_button)
            {
                cur_button->selected = true;
                rgroup->buttons[rgroup->selected_button]->selected = false;
                obj_invalidate(&rgroup->buttons[rgroup->selected_button]->obj);
                obj_invalidate(&cur_button->obj);
                action.event = ACTION_UNSELECTED;
                obj_store_action(&rgroup->buttons[rgroup->selected_button]->obj, rgroup->buttons[rgroup->selected_button]->obj.action, &action);
                action.event = ACTION_SELECTED;
                obj_store_action(&cur_button->obj, cur_button->obj.action, &action);
                rgroup->selected_button = i;
            }
        }
        action.event = ACTION_PRESSED;
        obj_store_action(obj, obj->action, &action);
    }
}


/**
 * @brief    Select a radiobutton
 *
 * Select the given radiobutton.
 *
 * @see
 *     radiogroup_t
 *
 * @param group  Pointer to the radiogroup
 * @param button Index of radiobutton to be selected
 *
 * @return Nothing
 */

void radiogroup_select_button(radiogroup_t *group, unsigned int button)
{
    obj_t *parent = group->obj.parent;
    if (button < group->n_buttons)
    {
        for (int i = 0; i < group->n_buttons; i++)
        {
            if ( i == button)
            {
                if (! group->buttons[i]->selected)
                {
                    group->buttons[i]->selected = true;
                    obj_invalidate(&group->buttons[i]->obj);
                }
            }
            else
            {
                if (group->buttons[i]->selected)
                {
                    group->buttons[i]->selected = false;
                    obj_invalidate(&group->buttons[i]->obj);
                }
            }
        }
        group->selected_button = button;
    }
}


