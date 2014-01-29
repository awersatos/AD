#include <stdlib.h>
#include <graphics.h>
#include <pointer.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg.h"


/**
 * @brief    Default Handler
 *
 * This function is a default handler for all components that don't need component-type specific functionality.
 * It sets the cursor shape for the component and the input event may result in one or more actions.
 * The generated action-events includes the following events for the left button: em@ pressed, em@ released, em@ clicked, em@ leaved.
 *
 * @param obj    Pointer to the object member of the component
 * @param input  Pointer to the input event (location and button state)
 *
 * @return Nothing
 */

void default_handler( obj_t *obj, const input_event_t *input )
{
    action_event_t action;
    bool was_pressed;

    action.x = input->x;
    action.y = input->y;

    if ( obj->enabled )
    {
        if ( input->buttons == ACTION_LEAVED )
        {
            if (obj->pressed)
            {
                obj->pressed = false;
            }
            action.button = BUTTON_NONE;
            action.event = ACTION_LEAVED;
            obj_store_action(obj, obj->action, &action);
        }
        else if ( input->buttons & BUTTON_LEFT_EVENT )
        {
            action.button = BUTTON_LEFT;

            if (input->buttons & BUTTON_LEFT)
            {
                obj->pressed = true;
                action.event = ACTION_PRESSED;
                obj_store_action(obj, obj->action, &action);
            }
            else
            {
                was_pressed = obj->pressed;
                obj->pressed = false;
                action.event = ACTION_RELEASED;
                obj_store_action(obj, obj->action, &action);
                if (was_pressed)
                {
                    action.event = ACTION_CLICKED;
                    obj_store_action(obj, obj->action, &action);
                }
            }
        }
    }
    else if ( obj->pressed )
    {
        obj->pressed = 0;
    }
}

