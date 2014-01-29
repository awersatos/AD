#ifndef _AGUI_COMMON_H
#define _AGUI_COMMON_H

#include <graphics.h>
#include "agui_cfg.h"



/*******************************
 * Enumerations
 *******************************/


/**
 * @brief
 *      Action events enumeration
 *
 * This enum defines all possible events. This is used in combination with mouse-button number
 *
 * @see
 *      action_event_t
 */

typedef enum
{
    ACTION_PRESSED,    /**< the mouse button is pressed */
    ACTION_RELEASED,   /**< the mouse button is released */
    ACTION_CLICKED,    /**< the mouse button is clicked (pressed and released)*/
    ACTION_ENTERED,    /**< the mouse pointer has entered the component */
    ACTION_LEAVED,     /**< the mouse pointer has leaved the component */
    ACTION_MOVED,      /**< the mouse is moved within the component */
    ACTION_DRAGGED,    /**< the mouse is dragged (moved with a butten pressed) */
    ACTION_SELECTED,   /**< the component is selected */
    ACTION_UNSELECTED, /**< the component is unselected */
} _action_event_t;


/**
 * @brief
 *      Action buttons
 *
 * This enum defines the buttons as used in the action_event.
 *
 * @see
 *      action_event_t
 */
typedef enum
{
    ACTION_BUTTON_NONE   = 0x00, /**< no button down */
    ACTION_BUTTON_LEFT   = 0x01, /**< left button down */
    ACTION_BUTTON_RIGHT  = 0x04, /**< right button down */
    ACTION_BUTTON_MIDDLE = 0x10, /**< middle button down */
} _action_button_t;


/**
 * @brief
 *      Buttons and events
 *
 * This enum defines all possible buttons and events.
 * Multiple enums can be or-ed.
 *
 * @see
 *      input_event_t
 */
typedef enum
{
    INPUT_BUTTON_NONE         = 0x00, /**< no button down and no button event */
    INPUT_BUTTON_LEFT         = 0x01, /**< left button down */
    INPUT_BUTTON_LEFT_EVENT   = 0x02, /**< left button event */
    INPUT_BUTTON_RIGHT        = 0x04, /**< right button down */
    INPUT_BUTTON_RIGHT_EVENT  = 0x08, /**< right button event */
    INPUT_BUTTON_MIDDLE       = 0x10, /**< middle button down */
    INPUT_BUTTON_MIDDLE_EVENT = 0x20, /**< middle button event */
} _input_buttons_t;


/**
 * @brief
 *      Relief enumeration
 *
 * This enum defines all possible reliefs.
 * The meaning of the reliefs depend on the kind of component, not all components support all kinds of reliefs
 */

typedef enum
{
    RELIEF_NONE,    /**< no relief (no outline) */
    RELIEF_FLAT,    /**< flat relief (2D) */
    RELIEF_RAISED,  /**< component is raised */
    RELIEF_LOWERED, /**< component is lowered */
} relief_t;


/**
 * @brief
 *      Outline enumeration
 *
 * This enum defines all possible outlines for the bevel_t.
 */

typedef enum
{
    OUTLINE_LEFT,   /**< draw only left line */
    OUTLINE_TOP,    /**< draw only top line */
    OUTLINE_RIGHT,  /**< draw only right line */
    OUTLINE_BOTTOM, /**< draw only bottom line */
    OUTLINE_FRAME,  /**< draw all four lines, draw 3D lines if relief is RELIEF_LOWERED or RELIEF_RAISED */
    OUTLINE_PANEL,  /**< draw all four lines, draw lowered or raised panel if relief is RELIEF_LOWERED or RELIEF_RAISED */
} outline_t;


/**
 * @brief
 *      Align enumeration
 *
 * This enum defines all possible alignments.
 */

typedef enum
{
    ALIGN_NONE              = 0x00, /**< no align */
    ALIGN_TOP               = 0x01, /**< vertical align at top, no horizontal align */
    ALIGN_BOTTOM            = 0x02, /**< vertical align at bottom, no horizontal align */
    ALIGN_VERTICAL          = 0x03, /**< vertical align at centre, no horizontal align */
    ALIGN_LEFT              = 0x10, /**< no vertical align, horizontal align at the left */
    ALIGN_TOP_LEFT          = 0x11, /**< vertical align at top, horizontal align at the left */
    ALIGN_BOTTOM_LEFT       = 0x12, /**< vertical align at bottom, horizontal align at the left */
    ALIGN_VERTICAL_LEFT     = 0x13, /**< vertical align at centre, horizontal align at the left */
    ALIGN_RIGHT             = 0x20, /**< no vertical align, horizontal align at the right */
    ALIGN_TOP_RIGHT         = 0x21, /**< vertical align at top, horizontal align at the right */
    ALIGN_BOTTOM_RIGHT      = 0x22, /**< vertical align at bottom, horizontal align at the right */
    ALIGN_VERTICAL_RIGHT    = 0x23, /**< vertical align t centre, horizontal align at the right */
    ALIGN_HORIZONTAL        = 0x30, /**< no vertical align, horizontal align at centre */
    ALIGN_TOP_HORIZONTAL    = 0x31, /**< vertical align at top, horizontal align at centre */
    ALIGN_BOTTOM_HORIZONTAL = 0x32, /**< vertical align at bottom, horizontal align at centre */
    ALIGN_CENTRE            = 0x33, /**< vertical align at centre, horizontal align at centre */
} align_t;



/*******************************
 * Common structures
 *******************************/


/**
 * @brief
 *      Action event structure
 *
 * This structure describes an action event.
 *
 */
typedef struct
{
    int              x;      /**< x position of cursor */
    int              y;      /**< y position of cursor */
    _action_event_t  event;  /**< action event type */
    _action_button_t button; /**< button corresponding to event */
} action_event_t;


/**
 * @brief
 *      Input event structure
 *
 * This structure describes an input event.
 *
 */
typedef struct
{
    int x;                      /**< x position */
    int y;                      /**< y position */
    _input_buttons_t buttons;   /**< button state */
} input_event_t;


/**
 * @brief
 *      Point structure
 *
 * This structure describes a point on a plane
 */

typedef struct
{
    int x; /**< x position */
    int y; /**< y position */
} point_t;


/**
 * @brief
 *      Boundary structure
 *
 * This structure describes the boundaries of an area.
 */

typedef struct
{
    int left;   /**< left boundary */
    int top;    /**< top boundary */
    int right;  /**< right boundary */
    int bottom; /**< bottom boundary */
} bound_t;


/**
 * @brief
 *      Rectangle structure
 *
 * This structure describes the position and dimensions of a rectangle.
 */

typedef struct
{
    int x;      /**< x position (upper left corner) */
    int y;      /**< y position (upper left corner) */
    int width;  /**< rectangle width */
    int height; /**< rectangle height */
} rect_t;


/**
 * @brief
 *      String structure
 *
 * This structure contains information to describe a string.
 */

typedef struct
{
    int           x;         /**< x position */
    int           y;         /**< y position  */
    char         *text;      /**< string text */
    const font_t *font;      /**< string-text font */
    color_t       color;     /**< string-text color */
    fontstyle_t   fontstyle; /**< string-text font style (none, bold, italic or bold-italic) */
    align_t       align;     /**< alignment with respect to x and y position */
} string_t;


/**
 * @brief
 *      Agui palette
 *
 * This structure contains the palette colors.
 */

typedef struct
{
    color_t screen;         /**< screen color */
    color_t titlebar;       /**< titlebar background color */
    color_t titletext;      /**< titlebar text color */
    color_t form;           /**< form background color */
    color_t control;        /**< controls color */
    color_t controltext;    /**< control-text color */
    color_t editcontrol;    /**< color of editable controls */
    color_t edittext;       /**< text color of editable controls */
    color_t controlbg;      /**< background color of controls */
    color_t disabled;       /**< color of disabled controls */
    color_t selected;       /**< color of the selected items in standard dialogs */
    color_t pressed;        /**< color of pressed controls */
#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D
    color_t darkoutline;    /**< dark control outline in 3D mode */
    color_t lightoutline;   /**< light control outline in 3D mode */
#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D
    color_t outline;        /**< control outline in 2D mode */
#endif
} agui_palette_t;



/*******************************
 * Function pointer definitions
 *******************************/

#ifdef  __cplusplus
extern "C" {
#endif

struct obj_t;

typedef void (*draw_t)(struct obj_t *obj);
typedef void (*update_t)(struct obj_t *obj);
typedef void (*handler_t)(struct obj_t *obj, const input_event_t *input);
typedef void (*action_t)(struct obj_t *obj, const action_event_t *action);
typedef struct _cursor_shape_s cursor_shape_t;
typedef int (*sort_algorithm_t)(void *first, void *second);

#ifdef  __cplusplus
}
#endif

#endif
