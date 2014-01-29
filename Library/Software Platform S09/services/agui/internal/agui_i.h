#ifndef _AGUI_I_H
#define _AGUI_I_H

#include <time.h>
#include <graphics.h>
#include <..\..\platform\graphics\internal\graphics_i.h>
#include <pointer.h>
#include <canvas.h>
#include "agui_cfg.h"

#if __POSIX_KERNEL__
# include <pthread.h>
# define ACTION_MUTEX_LOCK      pthread_mutex_lock(&agui->action_mutex)
# define ACTION_MUTEX_UNLOCK    pthread_mutex_unlock(&agui->action_mutex)
# define PROPERTY_MUTEX_LOCK    pthread_mutex_lock(&agui->property_mutex)
# define PROPERTY_MUTEX_UNLOCK  pthread_mutex_unlock(&agui->property_mutex)
#else
# define ACTION_MUTEX_LOCK
# define ACTION_MUTEX_UNLOCK
# define PROPERTY_MUTEX_LOCK
# define PROPERTY_MUTEX_UNLOCK
#endif


extern agui_t agui_table[AGUI_INSTANCE_COUNT];
extern const char up_bmp[];
extern const char folder_bmp[];
extern const char file_bmp[];
extern const char txt_bmp[];
extern const char wav_bmp[];

typedef struct
{
    uint8_t color;
    int8_t move_x;
    int8_t move_y;
} cursor_element_t;

struct _cursor_shape_s
{
    const int size;
    const cursor_element_t *pattern;
};

typedef struct
{
    int x;
    int y;
    int hide_level;
    const cursor_shape_t *shape;
} cursor_t;

typedef struct
{
    int head;
    int tail;
    action_message_t messages[16];
} action_queue_t;

struct _agui_s
{
    graphics_t     *graphics;
    canvas_t       *canvas;
    pointer_t      *pointer;
    obj_t          *active_form;
    agui_palette_t  palette;
    cursor_t        cursor;
    rect_t          invalidated_screenarea;
    bool            invalidated;
#if __POSIX_KERNEL__
    int             priority;
    pthread_mutex_t property_mutex;
    pthread_mutex_t action_mutex;
#endif
    action_queue_t  action_queue;
    clock_t         next_repeat;
    obj_t          *repeat_obj;
};

typedef struct
{
    agui_t *agui;
    int x;
    int y;
    int w;
    int h;
    bool enabled;
    relief_t relief;
    color_t color;
    color_t handlecolor;
    unsigned int range;
    unsigned int window;
    unsigned int position;
} _scrollbar_draw_t;

typedef struct
{
    obj_t *caller;
    int x;
    int y;
    int w;
    int h;
    action_t action;
    relief_t relief;
    unsigned int range;
    unsigned int window;
    unsigned int *position;
    bool *moving;
} _scrollbar_handler_t;

extern void agui_update(agui_t *agui);
extern void agui_handler(agui_t *agui);
extern bool agui_action(agui_t *agui);
extern const char *agui_cut_string(agui_t *agui, char *to, const char *from, unsigned int count, const font_t *font, fontstyle_t fontstyle, int width);
extern const char *agui_cut_string_indicated(agui_t *agui, char *to, const char *from, unsigned int count, const font_t *font, fontstyle_t fontstyle, int width);
extern const char *agui_break_string(agui_t *agui, char *to, const char *from, unsigned int count, const font_t *font, fontstyle_t fontstyle, int width);
extern int agui_align_horizontal(agui_t *agui, int left, int right, const string_t *string);
extern int agui_align_vertical(agui_t *agui, int top, int bottom, const string_t *string);
extern void agui_draw_body_3d(agui_t *agui, int x, int y, int width, int height, bool top, bool bottom, relief_t relief, color_t color);
extern void agui_draw_outline_3d(agui_t *agui, int x, int y, int width, int height, bool top, bool bottom, relief_t relief);
extern void agui_draw_body_2d(agui_t *agui, int x, int y, int width, int height, bool top, bool bottom, color_t color);
extern void agui_draw_outline_2d(agui_t *agui, int x, int y, int width, int height, bool top, bool bottom);
extern void agui_draw_string(agui_t *agui, int left, int top, int right, int bottom, const string_t *string, bool enabled);
extern bool cursor_update(agui_t *agui, input_event_t *input);
extern obj_t *obj_get_ancestor(const obj_t *obj);
extern void _scrollbar_draw(_scrollbar_draw_t *scrollbar);
extern void _scrollbar_handler(_scrollbar_handler_t *scrollbar, const input_event_t *input);
extern void agui_invalidate_area(agui_t *agui, rect_t area);
extern void form_invalidate_area(obj_t *obj, rect_t *area);
extern void obj_set_repeat(obj_t *obj);
extern bool obj_repeat(obj_t *obj);
extern void obj_invalidate_child(obj_t *obj);
extern int stricmp( const char *s1, const char *s2 );
extern void agui_rect_cat(rect_t * restrict rect1, const rect_t * restrict rect2);
extern void agui_rect_isect(rect_t * restrict rect1, const rect_t * restrict rect2);
extern void agui_rect_cmpl(rect_t * restrict rect1, const rect_t * restrict rect2);

#endif
