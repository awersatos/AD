/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        Create and install POSIX devices. The device will be
|*                      accessed through standard POSIX_DEVICEIO services.
|*
\*****************************************************************************/

#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>

#include <stdbool.h>
#include <stdint.h>

#include <devio_adaptor.h>      /* posix devices */
#include <textdisplay.h>             /* textdisplay dev_ctl() interfaces */
#include <graphics.h>           /* non-posix driver interface */

#include "textdisplay_cfg_instance.h"
#include "graphics_to_textdisplay_cfg_instance.h"

/* The io functions */
static int graphics_to_textdisplay_open(devio_t *dev, int flags);
static ssize_t graphics_to_textdisplay_write(devio_t *dev);
static int graphics_to_textdisplay_ctl(devio_t *dev, int, void *, size_t, int *);

static int graphics_to_textdisplay_mmap(devio_t *dev, void *addr, size_t len, int flag, off_t off, void **ret)
{
    return EINVAL;
}



typedef struct
{
    devio_t dev;
    graphics_t  * restrict graphics;
    int         xpos;
    int         ypos;
    int         saved_xpos;
    int         saved_ypos;
    color_t     bg_color;
    color_t     fg_color;
    fontstyle_t fontstyle;
    const font_t  * font;
    short       state;
    int         arg0;
    int         arg1;
} graphics_devio_t;

static devio_iofuns_t graphics_to_textdisplay_iofuncs;
static graphics_devio_t graphics_to_textdisplay_table[GRAPHICS_TO_TEXTDISPLAY_INSTANCE_COUNT];

static int setfont( graphics_devio_t * drv, const void * font );

/*****************************************************************************
|*
|*  Function:           graphics_to_textdisplay_init
|*
|*  Description:        Plugin initialization. Initializes the device table
|*                      and installs a posix device for every instance.
 */
extern void graphics_to_textdisplay_init(void)
{
    graphics_devio_t *device;
    graphics_to_textdisplay_cfg_instance_t *cfg;
    const char *name;

    /* register posix io functions */
    DEV_IOFUNS_CREATE(&graphics_to_textdisplay_iofuncs,
                      graphics_to_textdisplay_open,
                      graphics_to_textdisplay_write,
                      NULL, 
                      graphics_to_textdisplay_ctl, 
                      graphics_to_textdisplay_mmap, 
                      NULL);

    /* posix device table (devio_t) */
    for (int i = 0; i < GRAPHICS_TO_TEXTDISPLAY_INSTANCE_COUNT; i++)
    {
        device = &graphics_to_textdisplay_table[i];
        cfg = &graphics_to_textdisplay_instance_table[i];

        /* get name from our parent instance */
        name = textdisplay_instance_table[cfg->textdisplay_adaptor].name;

        DEV_CREATE((devio_t*)device, name, &graphics_to_textdisplay_iofuncs, (void *)cfg->graphics);

        devio_install((devio_t*)device);
    }
}

/*****************************************************************************
|*
|*  Function:           graphics_to_textdisplay_open
|*
|*  Parameters:         dev      : posix device
|*
|*  Returns:            '0' on success, or an error code otherwise.
|*
|*  Description:        Open GRAPHICS device. Initializes a device and
|*                      registers interrupt handlers.
 */
static int graphics_to_textdisplay_open(devio_t *dev, int flags)
{
    int id = (int) dev->device;
    graphics_devio_t *graphics_dev = (graphics_devio_t *)dev;
    graphics_t *graphics;

    graphics = graphics_open(id);
    if (graphics)
    {
        graphics_dev->graphics = graphics;
        graphics_dev->xpos = 0;
        graphics_dev->ypos = 0;
        graphics_dev->saved_xpos = 0;
        graphics_dev->saved_ypos = 0;
        graphics_dev->fg_color = WHITE;
        graphics_dev->bg_color = BLACK;
        graphics_dev->font = NULL;
        graphics_dev->fontstyle = FS_NONE;
        graphics_dev->state = 0;
        graphics_dev->arg0 = 0;
        graphics_dev->arg1 = 0;
        return 0;
    }

    return EIOCONF;
}

/*****************************************************************************
|*
|*  Function:           graphics_to_textdisplay_write
|*
|*  Parameters:         dev      : posix device
|*
|*  Returns:            '0' on success or an error code otherwise.
|*
|*  Description:        Write a number of bytes to the device.
 */
static ssize_t graphics_to_textdisplay_write(devio_t *dev)
{
    graphics_devio_t *graphics_dev = (graphics_devio_t *)dev;
    graphics_t * graphics = graphics_dev->graphics;
    canvas_t *canvas = graphics_get_visible_canvas(graphics);
    int x = graphics_dev->xpos;
    int y = graphics_dev->ypos;
    short state = graphics_dev->state;

    const char *p = (const char *)dev->iotx->buf;

    for ( int i = 0; i < dev->iotx->len; i++ )
    {
        char c = p[i];
        switch( state )
        {
        case 1 :    // Seen an escape character, next should be '['
            if ( c == '[' )
            {
                // Clear arguments and continue scanning
                graphics_dev->arg0 = 0;
                graphics_dev->arg1 = 0;
                state = 2;
                break;
            }
            else
            {
                x += graphics_draw_char( canvas, x, y, 0x1B, graphics_dev->font, graphics_dev->fg_color, graphics_dev->fontstyle );
                state = 0;
                // escape not followed by opening bracket => fallthrough
            }
            // Might fall through
        case 0 :    // Not in an escape sequence
            if ( c == '\n' )        // Newline
            {
                int nextline;
                x = 0;
                nextline = y + 2 * graphics_get_fontheight( canvas, graphics_dev->font );
                if ( nextline < canvas_get_height( canvas ) )
                {
                    y += graphics_get_fontheight( canvas, graphics_dev->font );
                }
                else
                {
                    // Scroll
                    graphics_copy_rect( canvas, 0, 0, canvas_get_width( canvas ), nextline, 0, -graphics_get_fontheight( canvas, graphics_dev->font ) );
                    graphics_fill_rect( canvas, 0, y, canvas_get_width( canvas ), graphics_get_fontheight( canvas, graphics_dev->font ), graphics_dev->bg_color );

                }
            }
            else if ( c == '\x1B' ) // Escape, might be start of escape sequence
            {
                state = 1;
            }
            else                    // Not a special case, just print it
            {
                x += graphics_draw_char( canvas, x, y, c, graphics_dev->font, graphics_dev->fg_color, graphics_dev->fontstyle );
            }
            break;
        case 2 :    // Found escape indicator, check parameters
            switch( c )
            {
            case 'H' :  // ESC [ <line> ; <col> H = gotoxy
                x = graphics_dev->arg0 * graphics_get_charwidth( canvas, 'M', graphics_dev->font, graphics_dev->fontstyle );
                y = graphics_dev->arg1 * graphics_get_fontheight( canvas, graphics_dev->font );
                state = 0;
                break;
            case 'J' : // ESC [ <value> J = clearscreen
                {
                    int xmax = canvas_get_width( canvas );
                    int ymax = canvas_get_height( canvas );
                    int lineheight = graphics_get_fontheight( canvas, graphics_dev->font );
                    if ( graphics_dev->arg0 == 0 )  // Clear from cursor to end of screen
                    {
                        graphics_fill_rect( canvas, x, y, xmax - x, lineheight, graphics_dev->bg_color );
                        graphics_fill_rect( canvas, 0, y + lineheight, xmax, ymax - y - lineheight, graphics_dev->bg_color );
                    }
                    else if ( graphics_dev->arg0 == 1 ) // Clear from home to current pos
                    {
                        graphics_fill_rect( canvas, 0, 0, xmax, y, graphics_dev->bg_color );
                        graphics_fill_rect( canvas, 0, y, x, lineheight, graphics_dev->bg_color );
                    }
                    else if ( graphics_dev->arg0 == 2 ) // Clear entire screen and go home
                    {
                        graphics_fill_rect( canvas, 0, 0, xmax, ymax, graphics_dev->bg_color );
                        x = 0;
                        y = 0;
                    }
                }
                state = 0;
                break;
            case 'K' :  // Erase until end of line
                graphics_fill_rect( canvas, x, y, canvas_get_width( canvas ) - x, graphics_get_fontheight( canvas, graphics_dev->font ), graphics_dev->bg_color );
                state = 0;
                break;
            case 's' : // Save cursor position
                graphics_dev->saved_xpos = x;
                graphics_dev->saved_ypos = y;
                state = 0;
                break;
            case 'u' : // Restore a previously saved cursor position
                x = graphics_dev->saved_xpos;
                y = graphics_dev->saved_ypos;
                state = 0;
                break;
            case 'm' :
                switch( graphics_dev->arg0 )
                {
                case  0 : graphics_dev->fontstyle = FS_NONE; break;
                case  1 : graphics_dev->fontstyle = FS_BOLD; break;
                case 30 : graphics_dev->fg_color = BLACK; break;
                case 31 : graphics_dev->fg_color = RED; break;
                case 32 : graphics_dev->fg_color = GREEN; break;
                case 33 : graphics_dev->fg_color = YELLOW; break;
                case 34 : graphics_dev->fg_color = BLUE; break;
                case 35 : graphics_dev->fg_color = MAGENTA; break;
                case 36 : graphics_dev->fg_color = CYAN; break;
                case 37 : graphics_dev->fg_color = WHITE; break;
                case 40 : graphics_dev->bg_color = BLACK; break;
                case 41 : graphics_dev->bg_color = RED; break;
                case 42 : graphics_dev->bg_color = GREEN; break;
                case 43 : graphics_dev->bg_color = YELLOW; break;
                case 44 : graphics_dev->bg_color = BLUE; break;
                case 45 : graphics_dev->bg_color = MAGENTA; break;
                case 46 : graphics_dev->bg_color = CYAN; break;
                case 47 : graphics_dev->bg_color = WHITE; break;
                default : /* Do nothing */ ;
                }
                state = 0;
                break;
            case  ';' : // Start of next argument, copy arg0 to arg1 and continue scanning
                graphics_dev->arg1 = graphics_dev->arg0;
                graphics_dev->arg0 = 0;
                break;
            default :   // Expecting a digit. If not, unknown escape sequence - ignore
                if ( (c < '0') || (c > '9') )
                {
                    state = 0;
                }
                else
                {
                    graphics_dev->arg0 = graphics_dev->arg0 * 10 + c - '0';
                }
                break;
            }
            break;
        }
    }

    graphics_dev->state = state;
    graphics_dev->xpos = x;
    graphics_dev->ypos = y;

    dev->iotx->cnt = dev->iotx->len;

    return 0;
}

/*****************************************************************************
|*
|*  Function:           graphics_to_textdisplay_ctl
|*
|*  Parameters:         dev     : posix device
|*                      cmd     : device control command
|*                      buf     : data pointer
|*                      size    : size of the data buffer
|*                      res     : location for a return value
|*
|*  Returns:            Depends on the command.
|*
|*  Description:        Implementation of posix_dev_ctl() interface.
 */
static int graphics_to_textdisplay_ctl(devio_t *dev, int cmd, void *buf, size_t size, int *res)
{
    int     id     = (int)dev->device;
    int     retval = 0;
    posix_devctl_textdisplay_impl_t *cfg = (posix_devctl_textdisplay_impl_t *) buf;

    graphics_devio_t *graphics_dev = (graphics_devio_t *)dev;

    switch ( cmd )
    {
    case DEVCTL_TEXTDISPLAY_IMPL:
        cfg->device = (void *)graphics_dev;
        cfg->setfont = (int (*)(void *, const void *))setfont;
        break;
    default:
        break;
    }
    return retval;

}

static int setfont( graphics_devio_t * drv, const void * font )
{
    drv->font = font;
    return 0;
}

