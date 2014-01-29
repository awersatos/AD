#include <agui.h>
#include <agui_i.h>
#include <stdio.h>
#include "devices.h"
#include <unistd.h>
#include <string.h>
#include <assert.h>

#define CAPTION_FONT_STYLE  FS_BOLD
#define MESSAGE_FONT_STYLE  FS_NONE

struct _messagedialog_s
{
    form_t dialogform;      /* MUST BE THE FIRST MEMBER OF messagedialog_t ! */
    textarea_t message;
    int result;
    bool ready;
};

static void _md_button_action(obj_t *obj, const action_event_t *action);

const static form_t _dialogform =
{
    .obj.x = 0,
    .obj.y = 0,
    .obj.width = 200,
    .obj.height = 180,
    .obj.draw = form_draw,
    .obj.handler = form_handler,
    .obj.visible = false,
    .obj.enabled = true,
    .caption.x = 0,
    .caption.y = 0,
    .caption.fontstyle = CAPTION_FONT_STYLE,
    .caption.align = ALIGN_CENTRE,
    .n_children = 5,
    .relief = RELIEF_RAISED,
};

const static textarea_t _md_message =
{
    .obj.x = 1,
    .obj.y = 25,
    .obj.width = 0,
    .obj.height = 20,
    .obj.draw = textarea_draw,
    .obj.visible = true,
    .obj.enabled = true,
    .text.x = 0,
    .text.y = 0,
    .text.fontstyle = MESSAGE_FONT_STYLE,
    .text.align = ALIGN_TOP_HORIZONTAL,
    .text.color = BLACK,
    .relief = RELIEF_NONE,
};


const static button_t _md_button =
{
    .obj.y = 50,
    .obj.width = 65,
    .obj.height = 25,
    .obj.draw = button_draw,
    .obj.handler = button_handler,
    .obj.action = _md_button_action,
    .obj.direct_action = true,
    .obj.visible = true,
    .obj.enabled = true,
    .label.x = 0,
    .label.y = 0,
    .label.fontstyle = FS_NONE,
    .label.align = ALIGN_CENTRE,
    .relief = RELIEF_RAISED,
};

static void _md_button_action(obj_t *obj, const action_event_t *action)
{
    messagedialog_t *md = (messagedialog_t*)(obj->parent);
    if (action->event == ACTION_RELEASED)
    {
        md->ready = true;
        md->result = obj->tag;
    }
}


/**
 * @brief    Create message dialog
 *
 * Create and show a message dialog.
 * The message may contain multiple lines, separated by new-lines ('\\n').
 *
 * The number of buttons and the text on the buttons must be given.
 * The size of the buttons is fixed to 65 x 25 pixels.
 * The buttons are count from left to right, the most left button is button 0, the next button is button 1, and so on.
 *
 * The size of the message dialog is determined runtime, it depends on the number of buttons and the length of the texts.
 * The message dialog is aligned at the location given by x, y.
 *
 * Memory is allocated on the heap to create the message dialog.
 *
 * @param  agui    Service pointer as returned from agui_open()
 * @param  x       x Location of alignment point
 * @param  y       y Location of alignment point
 * @param  align   Alignment
 * @param  title   Title text
 * @param  message Message text
 * @param  buttons Number of buttons on the message dialog
 * @param  ...     Texts on the buttons
 *
 * @see align_t
 *
 * @return Message dialog pointer if succesful created
 */

messagedialog_t *messagedialog_create(agui_t *agui, int x, int y, align_t align, const char *title, const char *message, int buttons, ...)
{
    int width, twidth, mwidth = 0, bwidth, swidth;
    int mheight, fheight, dheight;
    int offset;
    va_list ap;
    button_t *btn;
    va_start( ap, buttons );
    const char *c0;
    const char *c1;
    int lines = 0;
    int count;

    messagedialog_t *md = (messagedialog_t*)malloc(sizeof(messagedialog_t));
    if (!md)
    {
        va_end(ap);
        return NULL;
    }
    obj_t **children = (obj_t **)malloc(sizeof(obj_t*) * (buttons + 1));
    if (!children)
    {
        free(md);
        va_end(ap);
        return NULL;
    }

    for (int i = 0; i < buttons; i++)
    {
        btn = (button_t*)malloc(sizeof(button_t));
        if (btn)
        {
            *btn = _md_button;
            btn->obj.parent = AGUI_HANDLE(md->dialogform);
            btn->obj.tag = i;
            btn->label.text = va_arg( ap, char* );
            btn->label.color = agui->palette.controltext;
            btn->color = agui->palette.control;
            children[i + 1] = (obj_t *)btn;
        }
        else
        {
            while (i--)
            {
                free(children[i]);
            }
            free(children);
            free(md);
            va_end(ap);
            return NULL;
        }
    }

    /* init structures */
    md->message = _md_message;
    md->message.obj.parent = AGUI_HANDLE(md->dialogform);
    md->message.text.text = (char*)message;
    children[0] = AGUI_HANDLE(md->message);

    md->dialogform = _dialogform;
    md->dialogform.caption.text = (char*)title;
    md->dialogform.caption.color = agui->palette.titletext;
    md->dialogform.obj.agui_index = agui - agui_table;
    md->dialogform.children = children;
    md->dialogform.n_children = buttons + 1;
    md->dialogform.color = agui->palette.form;
    md->dialogform.captionbarcolor = agui->palette.titlebar;

    md->message.color = agui->palette.form;

    md->ready = false;
    md->result = -1;

    /* resize */

    // calculate message width:
    c0 = c1 = message;
    while (*c0)
    {
        if (*c0 == '\n')
        {
            count = c0 - c1;
            lines++;
            swidth = graphics_get_nstringwidth(agui->canvas, c1, NULL, MESSAGE_FONT_STYLE, count);
            mwidth = mwidth < swidth ? swidth : mwidth;
            c1 = c0;
        }
        c0++;
    }
    if (lines == 0)
    {
        mwidth = graphics_get_stringwidth(agui->canvas, c1, NULL, MESSAGE_FONT_STYLE);
    }
    mwidth += 20;

    // calculate title width:
    twidth = 20 + graphics_get_stringwidth(agui->canvas, title, NULL, CAPTION_FONT_STYLE);

    // calculate button width:
    bwidth = buttons * 75 + 10;

    width = mwidth > twidth ? mwidth : twidth;
    width = bwidth > width ? bwidth : width;
    offset = (width - bwidth) / 2;

    fheight = graphics_get_fontheight(agui->canvas, NULL);
    mheight = 5 + (fheight + 1) * (lines + 1);
    dheight = title ? fheight + mheight + 59 : mheight + 55;

    md->dialogform.obj.width = width;
    md->dialogform.obj.height = dheight;

    md->message.obj.width = width - 2;
    md->message.obj.height = mheight;
    md->message.obj.y = title ? fheight + 15 : 10;

    /* set position */
    switch (align & 0xF0)
    {
    case ALIGN_RIGHT:
        md->dialogform.obj.x = x - width;
        break;
    case ALIGN_HORIZONTAL:
        md->dialogform.obj.x = x - width / 2;
        break;
    case ALIGN_LEFT:
    default:
        md->dialogform.obj.x = x;
        break;
    }

    switch (align & 0x0F)
    {
    case ALIGN_BOTTOM:
        md->dialogform.obj.y = y - dheight;
        break;
    case ALIGN_VERTICAL:
        md->dialogform.obj.y = y - dheight / 2;
        break;
    case ALIGN_TOP:
    default:
        md->dialogform.obj.y = y;
        break;
    }


    for (int i = 0; i < buttons; i++)
    {
        children[i+1]->x = width - 75 * (buttons - i) - offset;
        children[i+1]->y = md->dialogform.obj.height - 35;
    }

    /* show */
    agui_show_form(AGUI_HANDLE(md->dialogform));

    va_end(ap);
    return (messagedialog_t*)md;
}


/**
 * @brief    Execute the message dialog
 *
 * This function returns true as long as it needs to be called again.
 * After a button is clicked, the function returns false. Call this function until it returns false.
 *
 * This function calls the agui_service() function.
 *
 * @param  messagedialog  Pointer as returned from messagedialog_create()
 *
 * @return False after a button is clicked, true otherwise
 */

bool messagedialog_execute(messagedialog_t *messagedialog)
{
    assert(messagedialog);

    agui_t *agui = &agui_table[messagedialog->dialogform.obj.agui_index];

    agui_service(agui);
    return !messagedialog->ready;
}


/**
 * @brief    Get the message dialog result
 *
 * This function gives the index of the button that is clicked.
 * The buttons are count from left to right, the most left button is button 0, the next button is button 1, and so on.
 *
 * Call this function after messagedialog_execute() returns false and before messagedialog_destroy() is called.
 *
 * @param  messagedialog  Pointer as returned from messagedialog_create()
 *
 * @return Index of the clicked button
 */

int messagedialog_get_result(messagedialog_t *messagedialog)
{
    assert(messagedialog);

    return messagedialog->result;
}


/**
 * @brief    Destroy the message dialog
 *
 * This function destroys the message dialog. It hides the dialog and frees all memory allocated for the dialog.
 * The @em messagedialog pointer is no longer valid.
 *
 * @param  messagedialog  Pointer as returned from messagedialog_create()
 *
 * @return Nothing
 */

void messagedialog_destroy(messagedialog_t *messagedialog)
{
    assert(messagedialog);

    agui_t *agui = &agui_table[messagedialog->dialogform.obj.agui_index];

    agui_hide_form(agui);

    for (int i = 0; i < messagedialog->dialogform.n_children; i++)
    {
        free(messagedialog->dialogform.children[i]);
    }
    free(messagedialog->dialogform.children);
    free(messagedialog);
}

