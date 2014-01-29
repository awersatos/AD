/*****************************************************************************\
|*
|*  IN PACKAGE:     Graphics
|*
|*  COPYRIGHT:      Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:    Generic routines
|*
 */

/**
 * file
 * Service for graphics routines
 *
 */

#include <stdint.h>
#include <string.h>
#include <stdbool.h>
#include <assert.h>
#include <init.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg_instance.h"
#include "agui_cfg.h"

#if __POSIX_KERNEL__
# include <pthread.h>
#endif


agui_t agui_table[AGUI_INSTANCE_COUNT];

#if __POSIX_KERNEL__
void *agui_main_thread(void *arg)
{
    agui_t *agui = arg;
    struct timespec ts =
    {
        .tv_sec = 0,
        .tv_nsec = 10 * 1000 * 1000,     // 10 ms
    };

    while (1)
    {
        nanosleep(&ts, NULL);   // sleep for 10 ms
        PROPERTY_MUTEX_LOCK;
        agui_handler(arg);
        agui_update(arg);
        PROPERTY_MUTEX_UNLOCK;
    }

    /* never reached */
}
#endif

#if __POSIX_KERNEL__

#define AGUI_MAIN_THREAD_NAME "AGUI_MAIN"

static void agui_create_agui_main_thread(void)
{
    agui_t *agui;
    pthread_t thread;
    pthread_attr_t attr;
    struct sched_param schedparam;

    memset(&attr, 0, sizeof(attr));
    pthread_attr_init(&attr);
    pthread_attr_setinheritsched    (&attr, PTHREAD_EXPLICIT_SCHED  );
    pthread_attr_setschedpolicy     (&attr, SCHED_FIFO              );
    pthread_attr_setstacksize       (&attr, 5000                    );
#if (__POSIX_THREAD_ATTR_NAME != 0)
    pthread_attr_setname            (&attr, AGUI_MAIN_THREAD_NAME   );
#endif


    for (int i= 0; i < AGUI_INSTANCE_COUNT; i++)
    {
        agui = agui_open(0);
        schedparam.sched_priority = agui->priority;
        pthread_attr_setschedparam(&attr, &schedparam);
        pthread_create(&thread, &attr, agui_main_thread, agui);
    }
}
#endif

void agui_init(void)
{
#if __POSIX_KERNEL__
    posix_mainhook_install(agui_create_agui_main_thread, 1);
#endif
}


/**
 * @brief    Open an instance of the service
 *
 * This function initializes the service and opens the driver beneath the first time the function is called.
 * Further attemps to open an already opened instance of the service simply returns the same pointer.
 *
 * @param  id  Valid service id
 *
 * @return Service pointer if succesful initialized
 */

agui_t *agui_open(unsigned int id)
{
    assert((id >= 0) && (id < AGUI_INSTANCE_COUNT));

    agui_t * restrict srv = &agui_table[id];
#if __POSIX_KERNEL__
    pthread_mutexattr_t attr;
#endif

    if (!srv->graphics)
    {
        // get configuration of driver (created by plugin system)
        const agui_cfg_instance_t * restrict srv_cfg = &agui_instance_table[id];

        srv->graphics = graphics_open(srv_cfg->graphics);
        srv->pointer = pointer_open(srv_cfg->pointer);
        srv->palette.screen = BLACK;
        srv->palette.titlebar = ROYALBLUE;
        srv->palette.titletext = BLACK;
        srv->palette.form = GRAY75;
        srv->palette.control = GRAY75;
        srv->palette.controltext = BLACK;
        srv->palette.editcontrol = WHITE;
        srv->palette.edittext = BLACK;
        srv->palette.controlbg = GRAY85;
        srv->palette.disabled_dark = GRAY50;
        srv->palette.disabled_light = GRAY75;
        srv->palette.selected = ROYALBLUE;
        srv->palette.pressed = GRAY85;
#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D
        srv->palette.darkoutline = GRAY50;
        srv->palette.lightoutline = GRAY85;
#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D
        srv->palette.outline = GRAY40;
#endif
        srv->cursor.x = 0;
        srv->cursor.y = 0;
        srv->cursor.hide_level = 1;
        srv->action_queue.head = 0;
        srv->action_queue.tail = 0;
#if __POSIX_KERNEL__
        srv->priority = srv_cfg->priority;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
        pthread_mutex_init(&srv->property_mutex, &attr);
        pthread_mutex_init(&srv->action_mutex, NULL);
#endif
        srv->canvas = graphics_get_visible_canvas(srv->graphics);
        graphics_fill_canvas(srv->canvas, srv->palette.screen);
    }

    return srv;
}


static void _agui_update(agui_t *agui, obj_t *form)
{
    form_t *f = (form_t*)form;

    if (f && f->previous_form)
    {
        _agui_update(agui, f->previous_form);
    }
    else if (agui->invalidated_screenarea.width != 0 && agui->invalidated_screenarea.height != 0)
    {
        graphics_fill_rect(agui->canvas,
                           agui->invalidated_screenarea.x,
                           agui->invalidated_screenarea.y,
                           agui->invalidated_screenarea.width,
                           agui->invalidated_screenarea.height,
                           agui->palette.screen);
        agui->invalidated_screenarea.width = 0;
        agui->invalidated_screenarea.height = 0;
    }
    obj_draw(form);
    if (f && f->previous_form)
    {
        form->invalidated |= f->previous_form->invalidated | f->previous_form->invalidated_child;
    }
}


/**
 * @brief    Update the agui service
 *
 * Update (redraw) invalidated parts of the service.
 *
 * @param  agui    Service pointer as returned from agui_open()
 *
 * @return Nothing
 */

void agui_update(agui_t *agui)
{
    obj_t *active_form = agui->active_form;
    form_t *form = (form_t*)active_form;

    if (agui->invalidated)
    {
        while (!graphics_visible_canvas_is_set(agui->graphics)) ;
        agui->invalidated = false;
        while (!graphics_lock(agui->canvas)) ;
        _agui_update(agui, active_form);
        graphics_unlock(agui->canvas);
        graphics_set_visible_canvas(agui->graphics, agui->canvas);
    }
}


/**
 * @brief    Handle the agui service
 *
 * Handle input event for the service.
 *
 * @param  agui    Service pointer as returned from agui_open()
 *
 * @return Nothing
 */

void agui_handler(agui_t *agui)
{
    input_event_t input;

    cursor_update(agui, &input);
    if (agui->active_form)
    {
        form_handler(agui->active_form, &input);
    }
}


/**
 * @brief    Perform the service actions
 *
 * Perform the next action set by agui_handler(). 
 *
 * @param  agui    Service pointer as returned from agui_open()
 *
 * @return True if there was an action to perform, false otherwise
 */

bool agui_action(agui_t *agui)
{
    action_t action;
    obj_t *obj;
    action_event_t event;
    bool result = false;

    action_queue_t * restrict queue = &agui->action_queue;

    ACTION_MUTEX_LOCK;

    if (queue->tail != queue->head)
    {
        /* something to execute */
        action = queue->messages[queue->tail].action;
        obj    = queue->messages[queue->tail].obj;
        event  = queue->messages[queue->tail].event;
        action(obj, &event);

        queue->tail++;
        if (queue->tail >= (sizeof(queue->messages)/sizeof(queue->messages[0])))
        {
            queue->tail = 0;
        }
        result = true;
    }

    ACTION_MUTEX_UNLOCK;

    return result;
}


/**
 * @brief    Call the agui_service
 *
 * This function executes actions, handles the input event and updates the agui.
 *
 * @param  agui    Service pointer as returned from agui_open()
 *
 * @return Nothing
 */

void agui_service(agui_t *agui)
{
    while(agui_action(agui));   // execute all actions
#if __POSIX_KERNEL__ == 0
    agui_handler(agui);
    agui_update(agui);
#endif
}


/**
 * @brief    Show form
 *
 * This function shows the given form. The form which was active before this call is stored.
 * Previous form will become active again after current form is hidden.
 *
 * @param  form    New active form
 *
 * @return Nothing
 */

void agui_show_form(obj_t *form)
{
    agui_t *agui = &agui_table[form->agui_index];
    form_show(form, agui->active_form);
    agui->active_form = form;
}


/**
 * @brief    Hide form
 *
 * This function hides the active form. The previous active form becomes active again.
 *
 * @param  agui    Service pointer as returned from agui_open()
 *
 * @return Nothing
 */

void agui_hide_form(agui_t *agui)
{
    obj_t *obj = agui->active_form;
    rect_t rect = {obj->x, obj->y, obj->width, obj->height};

    agui->active_form = form_hide(obj);
    agui_invalidate_area(agui, rect);

}


/**
 * @brief    Get active form
 *
 * This function returns the currently active form.
 *
 * @param  agui    Service pointer as returned from agui_open()
 *
 * @return Currently active form
 */

obj_t *agui_get_active_form(agui_t *agui)
{
    return agui->active_form;
}


static void _invalidate_area(agui_t *agui, obj_t *form, rect_t *rect)
{
    rect_t r = *rect;
    rect_t form_rect;

    if (form)
    {
        form_rect = (rect_t){form->x, form->y, form->width, form->height};
        agui_rect_cmpl(rect, &form_rect);
        _invalidate_area(agui, ((form_t*)form)->previous_form, rect);
        agui_rect_cat(rect, &r);
        form_invalidate_area(form, rect);
    }
    else
    {
        /* invalidate screen background */
        agui_rect_cat(&agui->invalidated_screenarea, rect); /* concatenate area with previous invalidated area */
        *rect = agui->invalidated_screenarea;
    }
}

/**
 * @brief    Invalidate area
 *
 * This function invalidates the given area for all visible forms.
 * If another area was already invalidated, the new area is added to it, resulting in the smallest rectangle that holds both areas.
 *
 * @param  agui    Service pointer as returned from agui_open()
 * @param  area    Area to invalidate
 *
 * @return Nothing
 */

void agui_invalidate_area(agui_t *agui, rect_t area)
{
    rect_t rect = area;

    _invalidate_area(agui, agui->active_form, &rect);
}


/**
 * @brief    Invalidate screen
 *
 * This function invalidates the whole screen with all visible forms.
 *
 * @param  agui    Service pointer as returned from agui_open()
 *
 * @return Nothing
 */

void agui_invalidate_screen(agui_t *agui)
{
    rect_t rect;

    rect.x = 0;
    rect.y = 0;
    rect.width = canvas_get_width(agui->canvas);
    rect.height = canvas_get_height(agui->canvas);

    _invalidate_area(agui, agui->active_form, &rect);
}


/**
 * @brief    Draw object
 *
 * This function draws the object.
 *
 * @param  obj    Object to be drawn
 *
 * @return Nothing
 */

void obj_draw(obj_t *obj)
{
    if ((obj != NULL) && (obj->draw != NULL))
    {
        obj->draw(obj);
    }
}


/**
 * @brief    Invalidate object
 *
 * This function invalidates the object and it marks the parent(s) of having an invalidated child.
 *
 * @param  obj    Object to be invalidated
 *
 * @return Nothing
 */

void obj_invalidate(obj_t *obj)
{
    obj->invalidated = true;
    if (obj->parent)
    {
        obj_invalidate_child(obj->parent);
    }
    else
    {
        agui_table[obj->agui_index].invalidated = true;
    }
}


/**
 * @brief    Set object enable
 *
 * This function enables or disables the object and invalidates it.
 *
 * @param  obj      Object to be enabled or disabled
 * @param  enabled  Enable object if true, disable if false
 *
 * @return Nothing
 */

void obj_set_enabled(obj_t *obj, bool enabled)
{
    agui_t * restrict agui;
    int agui_index;
    obj_t *parent;

    if (obj->enabled != enabled)
    {
        agui_index = obj->agui_index;
        parent = obj->parent;

        while (parent != NULL)
        {
            agui_index = parent->agui_index;
            parent = parent->parent;
        }
        agui = &agui_table[agui_index];
        PROPERTY_MUTEX_LOCK;
        obj->enabled = enabled;
        obj_invalidate(obj);
        PROPERTY_MUTEX_UNLOCK;
    }
}


/**
 * @brief    Set object visibility
 *
 * This function sets the object as being visible or invisible.
 * If the object becomes visible, the object is invalidated.
 * If the object becomes invisible, the area of the object is invalidated.
 *
 * @param  obj      Object which visibility is set
 * @param  visible  Show object if true, hide if false
 *
 * @return Nothing
 */

void obj_set_visible(obj_t *obj, bool visible)
{
    int x = obj->x;
    int y = obj->y;
    agui_t * restrict agui;
    int agui_index = obj->agui_index;
    obj_t *parent = obj->parent;

    while (parent != NULL)
    {
        x += parent->x;
        y += parent->y;
        agui_index = parent->agui_index;
        parent = parent->parent;
    }
    agui = &agui_table[agui_index];
    if (obj->visible != visible)
    {
        PROPERTY_MUTEX_LOCK;
        obj->visible = visible;
        if (visible)
        {
            obj_invalidate(obj);
        }
        else
        {
            agui_invalidate_area(agui, (rect_t){x, y, obj->width, obj->height});
        }
        PROPERTY_MUTEX_UNLOCK;
    }
}


/**
 * @brief    Set palette
 *
 * This function sets the agui palette.
 *
 * @param  agui    Service pointer as returned from agui_open()
 * @param  palette Palette structure containing the new palette
 *
 * @return Nothing
 */

void agui_set_palette(agui_t *agui, const agui_palette_t *palette)
{
    PROPERTY_MUTEX_LOCK;
    agui->palette = *palette;
    agui_invalidate_screen(agui);
    PROPERTY_MUTEX_UNLOCK;
}


/**
 * @brief    Get palette
 *
 * This function copies the agui palette to the location pointed to by palette.
 *
 * @param  agui    Service pointer as returned from agui_open()
 * @param  palette Palette structure to be filled by function
 *
 * @return Nothing
 */

void agui_get_palette(const agui_t *agui, agui_palette_t *palette)
{
    *palette = agui->palette;
}


bool begin_draw(struct obj_t* obj, struct draw_struct_t* draw_struct)
{
    obj_t *parent = obj->parent;
    int x = obj->x;
    int y = obj->y;
    int agui_index = obj->agui_index;

    obj->invalidated = false;

    while (parent != NULL)
    {
        x += parent->x;
        y += parent->y;
        agui_index = parent->agui_index;
        parent = parent->parent;
    }

    draw_struct->agui = &agui_table[agui_index];
    draw_struct->graphics = draw_struct->agui->graphics;
    draw_struct->canvas = draw_struct->agui->canvas;
    draw_struct->x1 = x;
    draw_struct->y1 = y;
    draw_struct->x2 = x + obj->width - 1;
    draw_struct->y2 = y + obj->height - 1;

    cursor_hide(draw_struct->agui);
    
    return true;
}

void end_draw(obj_t* obj, draw_struct_t* draw_struct)
{
    cursor_show(draw_struct->agui);
}


