#ifndef AGUI_H
#define AGUI_H

#ifdef  __cplusplus
extern "C" {
#endif

/**
 * @file
 * Altium Graphical User Interface (AGUI).
 *
 */


/* include object structures */
#include <components.h>
#include <cursor.h>
#include <graphics.h>

#define AGUI_HANDLE(x)  &x.obj

 /**
 * @brief
 *      Action Message
 *
 * This structure describes the action message.
 * An action message contains information about the action, i.e. the function to be called,
 * the component that causes the action message and the action-event with the event,
 * e.g. button-released, the location and the button involved.
 *
 */

typedef struct
{
    action_t action;        /**< Action to perform */
    obj_t *obj;             /**< Object to perform action on */
    action_event_t event;   /**< Action event */
} action_message_t;

typedef struct _agui_s agui_t;

agui_t *agui_open(unsigned int id);

extern void agui_service(agui_t *agui);

extern obj_t *agui_get_active_form(agui_t *agui);
extern void agui_show_form(obj_t *form);
extern void agui_hide_form(agui_t *agui);
extern void agui_invalidate_area(agui_t *agui, rect_t area);
extern void agui_invalidate_screen(agui_t *agui);
extern void agui_set_palette(agui_t *agui, const agui_palette_t *palette);
extern void agui_get_palette(const agui_t *agui, agui_palette_t *palette);

extern void obj_draw(obj_t *obj);
extern void obj_invalidate(obj_t *obj);
extern void obj_set_enabled(obj_t *obj, bool enabled);
extern void obj_set_visible(obj_t *obj, bool enabled);
extern bool obj_store_action(obj_t *obj, action_t action, action_event_t *event);

extern void bevel_draw(obj_t *obj);

extern void bitmap_draw(obj_t *obj);

extern void bitmapbutton_draw(obj_t *obj);
extern void bitmapbutton_handler( obj_t *obj, const input_event_t *input );

extern void button_draw(obj_t *obj);
extern void button_handler(obj_t *obj, const input_event_t *input);

extern void cursor_set_shape(agui_t *agui, const cursor_shape_t *cursor_shape);
extern void cursor_set_position(agui_t *agui, point_t point);
extern point_t cursor_get_position(agui_t *agui);
extern int  cursor_hide(agui_t *agui);
extern int  cursor_show(agui_t *agui);

extern void checkbox_draw(obj_t *obj);
extern void checkbox_handler(obj_t *obj, const input_event_t *input);

extern void form_draw(obj_t *obj);
extern void form_handler(obj_t *obj, const input_event_t *input);
extern void form_show(obj_t *obj, obj_t *previous_form);
extern obj_t *form_hide(obj_t *obj);

extern void icon_listbox_draw(obj_t *obj);
extern void icon_listbox_handler(obj_t *obj, const input_event_t *input);
extern int  icon_listbox_add( icon_listbox_t *listbox, const char *str, const void *icon, void *vp );
extern int  icon_listbox_insert( icon_listbox_t *listbox, const char *str, const void *icon, void *vp, int index );
extern int  icon_listbox_delete( icon_listbox_t *listbox, int index );
extern int  icon_listbox_count( icon_listbox_t *listbox);
extern char *icon_listbox_get_text( icon_listbox_t *listbox, int index);
extern void *icon_listbox_get_vp( icon_listbox_t *listbox, int index);
extern void icon_listbox_sort( icon_listbox_t *listbox, bool descending );
extern void icon_listbox_clear( icon_listbox_t *listbox );
extern void icon_listbox_set_multiselect(obj_t *obj, bool multiselect);
extern int  icon_listbox_get_selection( icon_listbox_t *listbox, int index_array[], int size );

extern void label_draw(obj_t *obj);

extern void list_sort( list_t **list, sort_algorithm_t sort, bool descending );
extern int  list_add( list_t **list, void *vp );
extern int  list_insert( list_t **list, void *vp, int index );
extern int  list_concatenate( list_t **first_list, list_t **second_list );
extern int  list_delete( list_t **list, int index );
extern int  list_count( list_t **list);
extern void *list_get( list_t **list, int index);
extern void *list_get_next( list_t **current);
extern void list_set_current( list_t **current, int index);
extern void list_clear( list_t **list );

extern void listbox_draw(obj_t *obj);
extern void listbox_handler(obj_t *obj, const input_event_t *input);
extern int  listbox_add( listbox_t *listbox, const char *str, void *vp );
extern int  listbox_insert( listbox_t *listbox, const char *str, void *vp, int index );
extern int  listbox_delete( listbox_t *listbox, int index );
extern int  listbox_count( listbox_t *listbox);
extern char *listbox_get_text( listbox_t *listbox, int index);
extern void *listbox_get_vp( listbox_t *listbox, int index);
extern void listbox_sort( listbox_t *listbox, bool descending );
extern void listbox_clear( listbox_t *listbox );
extern void listbox_set_multiselect(obj_t *obj, bool multiselect);
extern int  listbox_get_selection( listbox_t *listbox, int index_array[], int size );

extern void progressbar_draw(obj_t *obj);
extern void progressbar_set_percentage(obj_t *obj, unsigned int percentage);

extern void radiogroup_draw(obj_t *obj);
extern void radiogroup_handler(obj_t *obj, const input_event_t *input);
extern void radiobutton_draw(obj_t *obj);
extern void radiogroup_select_button(radiogroup_t *group, unsigned int button);

extern void slider_draw(obj_t *obj);
extern void slider_handler(obj_t *obj, const input_event_t *input);
extern void slider_set_position(obj_t *obj, int position);
extern void slider_set_handlesize(obj_t *obj, int size);
extern void slider_set_range(obj_t *obj, int low, int high);

extern void scrollbar_draw(obj_t *obj);
extern void scrollbar_handler(obj_t *obj, const input_event_t *input);
extern void scrollbar_set_position(obj_t *obj, unsigned int position);
extern void scrollbar_set_handlesize(obj_t *obj, unsigned int size);
extern void scrollbar_set_range(obj_t *obj, unsigned int range);

extern void textarea_draw(obj_t *obj);
extern void textarea_handler(obj_t *obj, const input_event_t *input);

extern void textbox_draw(obj_t *obj);
extern void textbox_handler(obj_t *obj, const input_event_t *input);


/* dialogs */

#if ( __POSIX_FILE_SYSTEM__ > 0 )
typedef struct _opendialog_s opendialog_t;
extern opendialog_t *opendialog_create(agui_t *agui, int x, int y, int width, int height, char *title, char *open, char *cancel, char *startdir, bool (*filter)(char *filename));
extern void opendialog_destroy(opendialog_t *opendialog);
extern bool opendialog_get_result(opendialog_t *opendialog, char *file, int size);
extern bool opendialog_execute(opendialog_t *opendialog);
#endif /* __POSIX_FILE_SYSTEM */

typedef struct _messagedialog_s messagedialog_t;
extern messagedialog_t *messagedialog_create(agui_t *agui, int x, int y, align_t align, char *title, char *message, int buttons, ...);
extern void messagedialog_destroy(messagedialog_t *messagedialog);
extern int messagedialog_get_result(messagedialog_t *messagedialog);
extern bool messagedialog_execute(messagedialog_t *messagedialog);

#ifdef  __cplusplus
}
#endif

#endif
