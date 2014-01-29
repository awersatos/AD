#include <stdlib.h>
#include <string.h>
#include <graphics.h>
#include <pointer.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg.h"

static void _draw_empty_form(agui_t *agui, form_t *form)
{
    int captionheight;
    int x1 = form->obj.x;
    int x2;
    int y1 = form->obj.y;
    int y2;
    int w = form->obj.width;
    int h = form->obj.height;


    x2 = x1 + w - 1;
    y2 = y1 + h - 1;

    /* draw form and components */
    captionheight = graphics_get_fontheight(agui->canvas, form->caption.font) + 4;

#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D

    if (form->caption.text != NULL)
    {
        /* draw caption too */
        agui_draw_body_3d(agui, x1, y1, w, captionheight, true, false, form->relief, form->captionbarcolor);
        agui_draw_string(agui, x1, y1, x2, y1 + captionheight, &form->caption, true);
        agui_draw_body_3d(agui, x1, y1 + captionheight, w, h - captionheight, false, true, form->relief, form->color);
    }
    else
    {
        agui_draw_body_3d(agui, x1, y1, w, h, true, true, form->relief, form->color);
    }

#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D

    if (form->caption.text != NULL)
    {
        /* draw caption too */
        agui_draw_body_2d(agui, x1, y1, w, captionheight, true, false, form->captionbarcolor);
        graphics_draw_line(agui->canvas, x1, y1 + captionheight, x2,  y1 + captionheight, agui->palette.outline);
        agui_draw_string(agui, x1, y1, x2, y1 + captionheight, &form->caption, true);
        agui_draw_body_2d(agui, x1, y1 + captionheight + 1, w, h - captionheight - 1, false, true, form->color);
    }
    else
    {
        agui_draw_body_2d(agui, x1, y1, w, h, true, true, form->color);
    }

#endif
}


/**
 * @brief    Draw a form
 *
 * Draw a form on the canvas.
 *
 * @see
 *     form_t
 *
 * @param obj    Pointer to the object member of the form
 *
 * @return Nothing
 */

void form_draw(obj_t *obj)
{
    form_t *form = (form_t*)obj;
    obj_t **objects = form->children;
    obj_t *o = NULL;    // object
    obj_t *op;          //object his parent
    int ox, oy;         // object his x, object his y
    int iw;
    int ih;
    unsigned int agui_index = obj->agui_index;
    agui_t * restrict agui;
    canvas_t * restrict canvas;

    agui = &agui_table[agui_index];
    canvas = agui->canvas;

    if (obj->visible)
    {
        cursor_hide(agui);
        if (obj->invalidated)
        {
            obj->invalidated = false;
            obj->invalidated_child = true;
            form->invalidated_area.width = form->invalidated_area.height = 0;
            if (obj->visible)
            {
                _draw_empty_form(agui, form);
                for (int i = form->n_children - 1; i >= 0; i--)
                {
                    if (objects[i] != NULL)
                    {
                        o = objects[i];
                        if (o->draw != NULL && o->visible)
                        {
                            o->invalidated = true;
                        }
                    }
                }
            }
        }
        else if (form->invalidated_area.width && form->invalidated_area.height)
        {
            iw = form->invalidated_area.width;
            ih = form->invalidated_area.height;
            form->invalidated_area.width = form->invalidated_area.height = 0;
            graphics_set_pane(canvas,
                              form->invalidated_area.x,
                              form->invalidated_area.y,
                              iw,
                              ih);
            _draw_empty_form(agui, form);
            for (int i = form->n_children - 1; i >= 0; i--)
            {
                if (objects[i] != NULL)
                {
                    o = objects[i];
                    if (o->draw != NULL && o->visible)
                    {
                        op = o->parent;
                        ox = o->x;
                        oy = o->y;
                        while (op)
                        {
                            ox += op->x;
                            oy += op->y;
                            op  = op->parent;
                        }
                        if ((ox < (form->invalidated_area.x + iw)) &&
                            ((ox + o->width) > form->invalidated_area.x) &&
                            (oy < (form->invalidated_area.y + ih)) &&
                            ((oy + o->height) > form->invalidated_area.y))
                        {
                            o->invalidated = true;
                            obj->invalidated_child = true;
                        }
                    }
                }
            }
            graphics_set_pane(canvas, 0, 0, canvas_get_width(canvas), canvas_get_height(canvas));
        }
        if (obj->invalidated_child)
        {
            obj->invalidated_child = false;
            for (int i = form->n_children - 1; i >= 0; i--)
            {
                if (objects[i] != NULL)
                {
                    o = objects[i];
                    if (o->invalidated || o->invalidated_child)
                    {
                        if (o->draw && o->visible)
                        {
                            o->draw(o);
                        }
                    }
                }
            }
        }
        cursor_show(agui);
    }
}


/**
 * @brief    Handler for form
 *
 * This function is the handler for the form. The input event may result in one or more actions.
 *
 * @see
 *     form_t
 *
 * @param obj    Pointer to the object member of the form
 * @param input  Pointer to the input event (location and button state)
 *
 * @return Nothing
 */

void form_handler(obj_t *obj, const input_event_t *input)
{
    form_t *form = (form_t*)obj;
    uint8_t i;
    obj_t **objects = form->children;
    obj_t *cur_obj = NULL;
    obj_t *parent;
    int32_t x, y;
    action_event_t action;
    const input_event_t input_leave = {0, 0, ACTION_LEAVED};

    for (i = 0; i < form->n_children; i++)
    {
        if (objects[i] != NULL)
        {
            cur_obj = objects[i];
            parent = cur_obj->parent;
            x = cur_obj->x;
            y = cur_obj->y;
            while (parent != NULL)
            {
                x += parent->x;
                y += parent->y;
                parent = parent->parent;
            }
            if (x <= input->x &&
                x + cur_obj->width >= input->x &&
                y <= input->y &&
                y + cur_obj->height >= input->y)
            {
                if (cur_obj->handler != NULL && cur_obj->visible)
                {
                    break;
                }
            }
        }
    }
    if (i == form->n_children)
    {
        cursor_set_shape(&agui_table[obj->agui_index], obj->cursor_shape);

        cur_obj = NULL;
        if ( input->buttons & BUTTON_LEFT_EVENT )
        {
            action.x = input->x;
            action.y = input->y;
            action.button = BUTTON_LEFT;
            action.event = input->buttons & BUTTON_LEFT ? ACTION_PRESSED : ACTION_RELEASED;
            obj_store_action(obj, obj->action, &action );
        }
    }
    if (form->last_child != cur_obj)
    {
        if ((form->last_child != NULL) && (form->last_child->handler != NULL))
        {
            form->last_child->handler(form->last_child, &input_leave);
        }
        form->last_child = cur_obj;
    }

    if ((cur_obj != NULL) && (cur_obj->handler != NULL) && cur_obj->visible)
    {
        cursor_set_shape(&agui_table[obj->agui_index], cur_obj->cursor_shape);
        cur_obj->handler(cur_obj, input);
    }
}


/**
 * @brief    Show the form
 *
 * This function shows the form. The @em previous_form will be shown if the form is hidden by form_hide(). 
 * Give the active form prior to the call of this function as the previous form.
 *
 * @param  obj              Pointer to the form to show
 * @param  previous_form    Pointer to the previous form
 *
 * @return Previous form
 */

void form_show(obj_t *obj, obj_t *previous_form)
{
    form_t *form = (form_t*)obj;

    form->previous_form = previous_form;
    obj->visible = true;
    obj_invalidate(obj);
}


/**
 * @brief    Hide the form
 *
 * This function hides the form and returns the previous form
 *
 * @param  obj    Pointer to the form to hide
 *
 * @return Previous form
 */

obj_t *form_hide(obj_t *obj)
{
    form_t *form = (form_t*)obj;

    obj->visible = false;
    obj_invalidate(obj);
    return form->previous_form;
}


/**
 * @brief    Invalidate area on form
 *
 * This function invalidates an area on the form.
 * If the area is partial outsize the form, the area is cropped to the part inside the form.
 * If the form had already an invalidated area, the new area is the smallest rectangle that holds both invalidated areas.
 *
 * @param  obj    Pointer to the object member of the form
 * @param  area   Area to invalidate
 *
 * @return Nothing
 */

void form_invalidate_area(obj_t *obj, rect_t *area)
{
    form_t *form = (form_t*)obj;
    rect_t form_area;

    form_area.x = obj->x;
    form_area.y = obj->y;
    form_area.width = obj->width;
    form_area.height = obj->height;

    agui_rect_isect(&form_area, area);                 /* crop area to part inside form */
    agui_rect_cat(&form->invalidated_area, &form_area); /* concatenate area with previous invalidated area */
    *area = form->invalidated_area;
}



