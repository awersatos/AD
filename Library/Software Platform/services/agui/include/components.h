#ifndef _COMPONENTS_H
#define _COMPONENTS_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <agui_common.h>
#include <stdint.h>
#include <stdbool.h>
#include <graphics.h>
#include <pointer.h>

 /**
 * @brief
 *      Object structure
 *
 * This structure describes an object.
 * The object is part of components and contains general information like position, size and component type.
 *
 * The position is given relative to the parent.
 *
 * The @em tag is for general use and is not used by the agui itself.
 */

typedef struct obj_t
{
    int                   x;                 /**< x position, relative to parent */
    int                   y;                 /**< y position, relative to parent */
    unsigned              width;             /**< component widht */
    unsigned              height;            /**< component height */
    draw_t                draw;              /**< function to draw the component: typedef void (*draw_t)(struct _obj_s *obj) */
    handler_t             handler;           /**< function to handle mouse-input events: typedef void (*handler_t)(struct _obj_s *obj, pointerstate_t state) */
    action_t              action;            /**< callback function called when an event occurs: typedef void (*action_t)(struct obj_t *obj, const action_event_t *action) */
    bool                  direct_action;     /**< action-function will be performed in the agui thread. */
    struct obj_t         *parent;            /**< parent of the component, used to calculate position */
    unsigned              agui_index;        /**< agui structure index */
    const cursor_shape_t *cursor_shape;      /**< cursor shape when cursor is above this component */
    bool                  enabled;           /**< if set, component is enabled */
    bool                  visible;           /**< if not set, component will not be (re)drawn and is not enabled */
    bool                  invalidated;       /**< if set, draw this component in the next agui_update */
    bool                  invalidated_child; /**< if set, one or more of the children belonging to this object are invalidated */
    bool                  pressed;           /**< component is pressed */
    uintptr_t             tag;               /**< tag for general use */
} obj_t;


 /**
 * @brief
 *      Form component
 *
 * This structure describes the form component.
 *
 * The form can contain other components, called children.
 * When drawing the form, all children are drawn too.
 *
 * The form is drawn when calling the draw function with 'visible' = true and 'state' = false or when obj->invalidated = true.
 * The form is hidden when calling the draw function with 'visible' = false, 'state' = true.
 * At the end of the draw function, 'state' is set to the value of 'visible'.
 */

typedef struct
{
    obj_t      obj;              /**< object structure */
    string_t   caption;          /**< form-caption */
    color_t    captionbarcolor;  /**< color of the caption bar (top) */
    obj_t    **children;         /**< pointer to list of children */
    unsigned   n_children;       /**< number of children */
    obj_t     *last_child;       /**< last child the pointer was pointing to */
    relief_t   relief;           /**< relief: flat, raised, lowered etc. */
    color_t    color;            /**< background color of form */
    obj_t     *previous_form;    /**< previous active form */
    rect_t     invalidated_area; /**< if this is a valid rectangle, the components that are within the rectangle are invalidated */
} form_t;


 /**
 * @brief
 *      Bitmap component
 *
 * This structure describes the bitmap component.
 *
 * The bitmap doesn't generate callback events.
 */

typedef struct
{
    obj_t       obj; /**< object structure */
    const void *bm;  /**< pointer to bitmap */
} bitmap_t;


 /**
 * @brief
 *      Button component
 *
 * This structure describes the button component.
 *
 * The button generates callback events for mouse-down, mouse-up and mouse-click.
 * The mouse-click is generated after a mouse-down and a mouse-up if the mouse didn't leave the button between the mouse-down and mouse-up.
 */

typedef struct
{
    obj_t    obj;     /**< object structure */
    string_t label;   /**< button label, NULL if no label */
    relief_t relief;  /**< button relief: flat, raised, lowered etc. */
    color_t  color;   /**< color of the button */
} button_t;


 /**
 * @brief
 *      Bitmap-button component
 *
 * This structure describes the bitmap-button component.
 *
 * The bitmap-button generates callback events for mouse-down, mouse-up and mouse-click.
 * The mouse-click is generated after a mouse-down and a mouse-up if the mouse didn't leave the button between the mouse-down and mouse-up.
 */

typedef struct
{
    obj_t        obj;     /**< object structure */
    const void  *bm;      /**< bitmap, NULL if no bitmap */
    bool         fit;     /**< fit (stretch or shrink) bitmap on button */
    relief_t     relief;  /**< button relief: flat, raised, lowered etc. */
} bitmapbutton_t;


 /**
 * @brief
 *      Label component
 *
 * This structure describes the label component.
 *
 * The label draws a text string with a transparent background.
 * The label doesn't generates callback events.
 */

typedef struct
{
    obj_t    obj;  /**< object structure */
    string_t text; /**< string structure */
} label_t;


 /**
 * @brief
 *      List structure
 *
 * This structure describes a linked list.
 */

typedef struct list_t
{
    struct list_t *next;    /**< next item in list */
    void          *vp;      /**< void pointer */
    bool          dynamic;  /**< dynamically allocated */
} list_t;


 /**
 * @brief
 *      Listbox item structure
 *
 * This structure describes the item as used by the listbox.
 */

typedef struct listbox_item_t
{
    char *text;        /**< text string */
    void *vp;          /**< void pointer, to be used for general use */
    bool  selected;    /**< this item is selected */
    bool  invalidated; /**< this item is invalidated */
    bool  dynamic;     /**< dynamically allocated */
} listbox_item_t;


 /**
 * @brief
 *      Listbox component
 *
 * This structure describes the listbox component. If not defined at compile-time, the list is allocated when items are addded.
 * The listbox generates callback events for mouse-down and mouse-up.
 *
 * @see
 *      listbox_draw(), listbox_handler(), listbox_add(),
 *      listbox_insert(), listbox_delete(), listbox_count(),
 *      listbox_get_text(), listbox_get_vp(), listbox_sort(),
 *      listbox_clear(), listbox_set_multiselect()
 */

typedef struct
{
    obj_t            obj;                /**< object structure */
    list_t          *list;               /**< pointer to list */
    int              count;              /**< number of entries in list, for internal use */
    unsigned         first;              /**< first visible entry, for internal use */
    listbox_item_t  *select;             /**< last selected entry, for iternal use */
    int              window;             /**< number of visible lines, for internal use */
    sort_algorithm_t sort;               /**< algorithm used to sort the listbox. If NULL, default algorithm will be used */
    relief_t         relief;             /**< listbox relief: flat, raised, lowered etc. */
    bool             separator;          /**< separate lines by a single line */
    bool             multiselect;        /**< allow selection of multiple items */
    bool             autohide_scrollbar; /**< hide scrollbar if all entries are visible (count lower or equal window) */
    bool             scrollbar_visible;  /**< scrollbar is visible, for internal use */
    bool             scrollbar_moving;   /**< scrollbar is moving, for internal use */
    string_t         item_string;        /**< template for item text */
    color_t          selectioncolor;     /**< field color of selected item */
    color_t          selectiontextcolor; /**< field color of selected item */
    color_t          color;              /**< field color of unselected items */
} listbox_t;


 /**
 * @brief
 *      Listbox item structure
 *
 * This structure describes the item as used by the listbox.
 */

typedef struct icon_listbox_item_t
{
    char       *text;        /**< text string */
    const void *icon;        /**< icon of this item */
    void       *vp;          /**< void pointer, can be used for general use */
    bool        selected;    /**< this item is selected */
    bool        invalidated; /**< this item is invalidated */
    bool        dynamic;     /**< dynamically allocated */
} icon_listbox_item_t;


 /**
 * @brief
 *      Listbox with icons component
 *
 * This structure describes the listbox with icons component.
 * The listbox generates callback events for mouse-down and mouse-up.
 *
 * @see
 *      icon_listbox_draw(), icon_listbox_handler(), icon_listbox_add(),
 *      icon_listbox_insert(), icon_listbox_delete(), icon_listbox_count(),
 *      icon_listbox_get_text(), icon_listbox_get_vp(), icon_listbox_sort(),
 *      icon_listbox_clear(), icon_listbox_set_multiselect()
 */

typedef struct
{
    obj_t                 obj;                /**< object structure */
    list_t               *list;               /**< pointer to list */
    int                   count;              /**< number of entries in list */
    unsigned              first;              /**< first visible entry */
    icon_listbox_item_t  *select;             /**< selected entry */
    int                   window;             /**< number of visible lines */
    sort_algorithm_t      sort;               /**< algorithm used to sort the listbox. If NULL, default algorithm will be used */
    relief_t              relief;             /**< listbox relief: flat, raised, lowered etc. */
    bool                  separator;          /**< separate lines if true */
    bool                  multiselect;        /**< if set, multiple items can be selected */
    bool                  autohide_scrollbar; /**< hide scrollbar if all entries are visible (count lower or equal window) */
    bool                  scrollbar_visible;  /**< for internal use */
    bool                  scrollbar_moving;   /**< for internal use */
    bool                  icon_behind;        /**< if set, icon is displayed behind the text, otherwise in front of the text */
    string_t              item_string;        /**< template for item text */
    color_t               selectioncolor;     /**< field color of selected item */
    color_t               selectiontextcolor; /**< field color of selected item */
    color_t               color;              /**< field color of unselected items */
} icon_listbox_t;


 /**
 * @brief
 *      progress bar component
 *
 * This structure describes the progress bar component.
 * The progress bar doesn't generates callback events.
 */

typedef struct
{
    obj_t    obj;           /**< object structure */
    unsigned percentage;    /**< percentage done (0-100) */
    relief_t relief;        /**< progress bar relief: flat, raised, lowered etc. */
    color_t  progresscolor; /**< color of progress bar already done */
    color_t  color;         /**< color of progress bar not done yet */
} progressbar_t;


 /**
 * @brief
 *      Slider component
 *
 * This structure describes the slider component.
 * The slider generates callback events for mouse-down, mouse-drag and mouse-up.
 */

typedef struct
{
    obj_t    obj;              /**< object structure */
    int      low;              /**< low end of slider range */
    int      high;             /**< high end of slider range */
    int      position;         /**< slider position */
    int      handlesize;       /**< size of sliderhandle in percent of slidersize (0% - 100%) */
    bool     moving;           /**< slider is moving */
    relief_t relief;           /**< slider relief: flat, raised, lowered etc. (only in 3D) */
    color_t  color1;           /**< color of sliderbar */
    color_t  color2;           /**< color of sliderbar */
    color_t  handlecolor;      /**< color of the slider handle */
} slider_t;


 /**
 * @brief
 *      Scrollbar component
 *
 * This structure describes a scrollbar.
 * The scrollbar generates callback events for mouse-down, mouse-drag and mouse-up.
 */

typedef struct
{
    obj_t    obj;         /**< object structure */
    unsigned range;       /**< high end of scrollbar range */
    unsigned window;      /**< size of scrollbarhandle in same units as 'low' and 'high' */
    unsigned position;    /**< scrollbar position */
    bool     moving;      /**< scrollbar is moving */
    relief_t relief;      /**< scrollbar relief: flat, raised, lowered etc. (only in 3D) */
    color_t  color;       /**< color of scrollbarbar */
    color_t  handlecolor; /**< color of the scrollbar handle */
} scrollbar_t;


 /**
 * @brief
 *      Textbox component
 *
 * This structure describes the textbox component. A textbox can contain 1 line of text on a solid background.
 */

typedef struct
{
    obj_t    obj;    /**< object structure */
    string_t text;   /**< text string */
    relief_t relief; /**< textbox relief: flat, raised, lowered etc. (only in 3D) */
    color_t  color;  /**< color of the background of the textbox */
} textbox_t;


 /**
 * @brief
 *      Textarea component
 *
 * This structure describes the textarea component. A textarea can contain multiple lines of text on a solid background.
 */

typedef struct
{
    obj_t    obj;    /**< object structure */
    string_t text;   /**< text string */
    relief_t relief; /**< textarea relief: flat, raised, lowered etc. (only in 3D) */
    color_t  color;  /**< color of the background of the textarea */
} textarea_t;


 /**
 * @brief
 *      Bevel component
 *
 * This structure describes the bevel component. A bevel can be used for a horizontal or vertical separator or a box (all four sides are drawn).
 */

typedef struct
{
    obj_t     obj;     /**< object structure */
    relief_t  relief;  /**< bevel relief: flat, raised, lowered etc. */
    outline_t outline; /**< bevel shape, only one side or all sides. */
} bevel_t;


 /**
 * @brief
 *      Checkbox component
 *
 * This structure describes the checkbox component.
 *
 * The checkbox generates callback events for mouse-down, mouse-up and mouse-click.
 * The mouse-click is generated after a mouse-down and a mouse-up if the mouse didn't leave the checkbox between the mouse-down and mouse-up.
 * The checkbox is checked or unchecked when it is clicked.
 */

typedef struct
{
    obj_t    obj;     /**< object structure */
    string_t label;   /**< label displayed next to the checkbox */
    bool     checked; /**< checkbox is checked */
    relief_t relief;  /**< relief: flat, raised, lowered etc. */
    color_t  color;   /**< checkbox color */
} checkbox_t;


 /**
 * @brief
 *      Radiobutton component
 *
 * This structure describes the radiobutton component.
 *
 * The radiobutton generates callback events for mouse-down.
 * The radiobutton is selected at mouse-down.
 *
 * @see
 *      radiogroup_t
 */

typedef struct
{
    obj_t    obj;       /**< object structure */
    string_t label;     /**< radiobutton label */
    bool     selected;  /**< radiobutton is selected */
    relief_t relief;    /**< relief: flast, raised, lowered etc */
    color_t  color;     /**< radiobutton color */
} radiobutton_t;


 /**
 * @brief
 *      Radiogroup component
 *
 * This structure describes the radiogroup component.
 *
 * The radiogroup contains a number of radiobuttons. Only one button can be selected at a time, selecting a button unselects the others.
 * The radiogroup generates callback events for mouse-down.
 *
 * @see
 *      radiobutton_t
 */

typedef struct
{
    obj_t           obj;             /**< object structure */
    string_t        label;           /**< radiogroup label */
    radiobutton_t **buttons;         /**< list of buttons being part of this group */
    unsigned        n_buttons;       /**< number of buttons in this group */
    unsigned        selected_button; /**< index of selected button */
    relief_t        relief;          /**< relief: flast, raised, lowered etc */
    color_t         color;           /**< radiogroup color */
} radiogroup_t;

 /**
 * @brief
 *      Panel component
 *
 * This structure describes the panel component.
 *
 * The panel can contain other components, called children.
 * When drawing the panel, all children are drawn too.
 */

typedef struct
{
    obj_t      obj;              /**< object structure */
    obj_t    **children;         /**< pointer to list of children */
    unsigned   n_children;       /**< number of children */
    obj_t     *last_child;       /**< last child the pointer was pointing to */
    rect_t     invalidated_area; /**< if this is a valid rectangle, the components that are within the rectangle are invalidated */
    relief_t   relief;           /**< panel relief: flat, raised, lowered etc. */
    outline_t  outline;          /**< panel shape, only one side or all sides. */
} panel_t;

#ifdef  __cplusplus
}
#endif

#endif

