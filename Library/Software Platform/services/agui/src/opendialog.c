#if ( __POSIX_FILE_SYSTEM__ > 0 )
#include <agui.h>
#include <agui_i.h>
#include <stdio.h>
#include "devices.h"
#include <unistd.h>
#include <string.h>
#include <assert.h>
#include <sys/stat.h>
#include <dirent.h>

#define FS_DIRSEPCHAR   '/'

typedef bool (*filter_t)(char *filename);

struct _opendialog_s
{
    form_t dialogform;      /* MUST BE THE FIRST MEMBER OF opendialog_t ! */
    obj_t *children[5];
    textbox_t location;
    bitmapbutton_t up;
    icon_listbox_t dirlist;
    button_t cancel;
    button_t open;
    filter_t filter;
    char path[PATH_MAX];
    bool ready;
    bool canceled;
};

static void _od_dirlist_action(obj_t *obj, const action_event_t *action);
static void _od_open_action(obj_t *obj, const action_event_t *action);
static void _od_cancel_action(obj_t *obj, const action_event_t *action);
static void _od_up_action(obj_t *obj, const action_event_t *action);
static void _dirlisting( const char *path, opendialog_t *od );
static int  _dir_sort(void *first, void *second);
static void _opendialog_draw(obj_t *obj);


const static textbox_t       _od_location;
const static bitmapbutton_t  _od_up;
const static icon_listbox_t  _od_dirlist;
const static button_t        _od_open;
const static button_t        _od_cancel;

const static form_t _dialogform =
{
    .obj.x = 0,
    .obj.y = 0,
    .obj.width = 200,
    .obj.height = 200,
    .obj.draw = _opendialog_draw,
    .obj.handler = form_handler,
    .obj.visible = false,
    .obj.enabled = true,
    .caption.x = 0,
    .caption.y = 0,
    .caption.fontstyle = FS_BOLD,
    .caption.align = ALIGN_CENTRE,
    .n_children = 5,
    .relief = RELIEF_RAISED,
};

const static textbox_t _od_location =
{
    .obj.x = 10,
    .obj.y = 25,
    .obj.width = 150,
    .obj.height = 20,
    .obj.draw = textbox_draw,
    .obj.handler = textbox_handler,
    .obj.visible = true,
    .obj.enabled = true,
    .text.x = 4,
    .text.y = 0,
    .text.fontstyle = FS_NONE,
    .text.align = ALIGN_VERTICAL_LEFT,
    .relief = RELIEF_LOWERED,
};

const static bitmapbutton_t _od_up =
{
    .obj.x = 170,
    .obj.y = 25,
    .obj.width = 20,
    .obj.height = 20,
    .obj.draw = bitmapbutton_draw,
    .obj.handler = bitmapbutton_handler,
    .obj.action = _od_up_action,
    .obj.direct_action = true,
    .obj.visible = true,
    .obj.enabled = true,
    .bm = up_bmp,
    .relief = RELIEF_RAISED,
    .fit = true,
};

const static icon_listbox_t _od_dirlist =
{
    .obj.x = 10,
    .obj.y = 55,
    .obj.width = 180,
    .obj.height = 100,
    .obj.draw = icon_listbox_draw,
    .obj.handler = icon_listbox_handler,
    .obj.action = _od_dirlist_action,
    .obj.direct_action = true,
    .obj.visible = true,
    .obj.enabled = true,
    .count = 0,
    .first = 0,
    .select = NULL,
    .window = 4,
    .relief = RELIEF_LOWERED,
    .separator = false,
    .multiselect = false,
    .autohide_scrollbar = true,
    .item_string.x = 4,
    .item_string.y = 1,
    .item_string.fontstyle = FS_NONE,
    .item_string.align = ALIGN_LEFT,
};

const static button_t _od_cancel =
{
    .obj.x = 80,
    .obj.y = 165,
    .obj.width = 65,
    .obj.height = 25,
    .obj.draw = button_draw,
    .obj.handler = button_handler,
    .obj.action = _od_cancel_action,
    .obj.direct_action = true,
    .obj.visible = true,
    .obj.enabled = true,
    .label.x = 0,
    .label.y = 0,
    .label.fontstyle = FS_NONE,
    .label.align = ALIGN_CENTRE,
    .relief = RELIEF_RAISED,
};

const static button_t _od_open =
{
    .obj.x = 140,
    .obj.y = 165,
    .obj.width = 65,
    .obj.height = 25,
    .obj.draw = button_draw,
    .obj.handler = button_handler,
    .obj.action = _od_open_action,
    .obj.direct_action = true,
    .obj.visible = true,
    .obj.enabled = false,
    .label.x = 0,
    .label.y = 0,
    .label.fontstyle = FS_NONE,
    .label.align = ALIGN_CENTRE,
    .relief = RELIEF_RAISED,
};


static void _opendialog_draw(obj_t *obj)
{
   opendialog_t *od = (opendialog_t*)obj;

    obj->draw = form_draw;
    _dirlisting(od->path, od);
    form_draw(obj);
}


static void _od_cancel_action(obj_t *obj, const action_event_t *action)
{
    opendialog_t *od = (opendialog_t*)(obj->parent);
    if (action->event == ACTION_RELEASED)
    {
        od->ready = true;
        od->canceled = true;
    }
}


static void _od_open_action(obj_t *obj, const action_event_t *action)
{
    opendialog_t *od = (opendialog_t*)(obj->parent);
    if (action->event == ACTION_RELEASED)
    {
        od->ready = true;
        od->canceled = false;
    }
}


static void _od_up_action(obj_t *obj, const action_event_t *action)
{
    char *sep;
    opendialog_t *od = (opendialog_t*)(obj->parent);

    if (action->event == ACTION_RELEASED)
    {
        sep = strrchr(od->path, FS_DIRSEPCHAR);
        *sep = 0;
        _dirlisting(od->path, od);
        obj_set_enabled(AGUI_HANDLE(od->open), false);
        obj_invalidate(AGUI_HANDLE(od->open));
    }
}


static void _od_dirlist_action(obj_t *obj, const action_event_t *action)
{
    opendialog_t *od = (opendialog_t*)(obj->parent);
    int item;
    char *subdir;
    int pathlen;

    if (action->event == ACTION_RELEASED)
    {
        if (icon_listbox_get_selection((icon_listbox_t*)obj, &item, 1))
        {
            if (icon_listbox_get_vp((icon_listbox_t*)obj, item))
            {
                /* file */
                obj_set_enabled(AGUI_HANDLE(od->open), true);
            }
            else
            {
                /* dir */
                obj_set_enabled(AGUI_HANDLE(od->open), false);
                subdir = icon_listbox_get_text((icon_listbox_t*)obj, item);
                if ((pathlen = strlen(od->path)) + strlen(subdir) < PATH_MAX - 1)
                {
                    od->path[pathlen] = FS_DIRSEPCHAR;
                    od->path[pathlen + 1] = 0;
                    strcat(od->path, subdir);
                    _dirlisting(od->path, od);
                }
            }
        }
        else
        {
            /* nothing */
            obj_set_enabled(AGUI_HANDLE(od->open), false);
        }
        obj_invalidate(AGUI_HANDLE(od->open));
    }
}


/**
 * @brief    Create open dialog
 *
 * Create and show an open dialog.
 *
 * The text on the @em Open and @em Cancel buttons are taken from the arguments. 
 * 
 * The current directory at time of creation is given by @em startdir.
 * 
 * The @em filter function pointer can be used to show only specific files.
 * If the filter function returns true the file is added to the file list, otherwise it is ignored.
 * If no filter function is provided (@em filter = NULL), all files are added to the fiel list.
 *
 * Memory is allocated on the heap to create the open dialog.
 *
 * The open dialog is only available if the posix filesystem is available.
 *
 * @param  agui     Service pointer as returned from agui_open()
 * @param  x        x Location of the dialog
 * @param  y        y Location of the dialog
 * @param  width    Width of the dialog
 * @param  height   Height of the dialog
 * @param  title    Title text
 * @param  open     Text on the @em Open button
 * @param  cancel   Text on the @em Cancel button
 * @param  startdir Current directory at time of creation
 * @param  filter   Pointer to function to filter filenames
 *
 * @return Message dialog pointer if succesful created
 */

opendialog_t *opendialog_create(agui_t *agui, int x, int y, int width, int height, char *title, char *open, char *cancel, char *startdir, bool (*filter)(char *filename))
{
    char *curdir;
    opendialog_t *od = (opendialog_t*)malloc(sizeof(opendialog_t));

    if (od)
    {
        /* init structures */
        od->dialogform = _dialogform;
        od->dialogform.caption.text = title;
        od->dialogform.caption.color = agui->palette.titletext;
        od->dialogform.obj.agui_index = agui - agui_table;
        od->dialogform.children = od->children;
        od->dialogform.color = agui->palette.form;
        od->dialogform.captionbarcolor = agui->palette.titlebar;

        od->location = _od_location;
        od->location.obj.parent = AGUI_HANDLE(od->dialogform);
        curdir = strrchr(startdir, FS_DIRSEPCHAR) + 1;
        od->location.text.text =  curdir;
        od->location.text.color = agui->palette.edittext,
        od->location.color = agui->palette.editcontrol;

        od->up = _od_up;
        od->up.obj.parent = AGUI_HANDLE(od->dialogform);

        od->dirlist = _od_dirlist;
        od->dirlist.obj.parent = AGUI_HANDLE(od->dialogform);
        od->dirlist.item_string.color = agui->palette.edittext;
        od->dirlist.selectioncolor = agui->palette.selected;
        od->dirlist.color = agui->palette.editcontrol;

        od->cancel = _od_cancel;
        od->cancel.obj.parent = AGUI_HANDLE(od->dialogform);
        od->cancel.label.text = cancel;
        od->cancel.label.color = agui->palette.controltext;
        od->cancel.color = agui->palette.control;

        od->open = _od_open;
        od->open.obj.parent = AGUI_HANDLE(od->dialogform);
        od->open.label.text = open;
        od->open.label.color = agui->palette.controltext;
        od->open.color = agui->palette.control;

        od->children[0] = AGUI_HANDLE(od->location);
        od->children[1] = AGUI_HANDLE(od->up);
        od->children[2] = AGUI_HANDLE(od->dirlist);
        od->children[3] = AGUI_HANDLE(od->cancel);
        od->children[4] = AGUI_HANDLE(od->open);

        od->canceled = false;
        od->ready = false;
        od->filter = filter;
        strncpy(od->path, startdir, PATH_MAX);

        /* set position */
        od->dialogform.obj.x = x;
        od->dialogform.obj.y = y;

        /* resize */
        if (width < 160) width = 160;
        if (height < 150) height = 150;

        od->dialogform.obj.width = width;
        od->dialogform.obj.height = height;
        od->open.obj.x = width - 150;
        od->open.obj.y = height - 35;
        od->cancel.obj.x = width - 75;
        od->cancel.obj.y = height - 35;
        od->dirlist.obj.width = width - 20;
        od->dirlist.obj.height = height - 100;
        od->up.obj.x = width - 30;
        od->location.obj.width = width - 50;

        /* show */
        agui_show_form(AGUI_HANDLE(od->dialogform));
    }
    else
    {
        *(uint8_t *)0xFF060000 = 10;
    }

    return (opendialog_t*)od;
}


/**
 * @brief    Execute the message dialog
 *
 * This function returns true as long as it needs to be called again.
 * After the @em Open button or the @em Cancel button is clicked, the function returns false. Call this function until it returns false.
 *
 * This function calls the agui_service() function.
 *
 * @param  opendialog  Pointer as returned from opendialog_create()
 *
 * @return False after the @em Open or @em Cancel button is clicked, true otherwise
 */

bool opendialog_execute(opendialog_t *opendialog)
{
    assert(opendialog);

    agui_t *agui = &agui_table[opendialog->dialogform.obj.agui_index];

    agui_service(agui);
    return !opendialog->ready;
}


/**
 * @brief    Get the open dialog result
 *
 * This function gives the filename of the selected file, including the path, after the @em Open button was clicked.
 * The filename is copied to @em file if the size of the provided buffer is large enough to hold the filename.
 * Otherwise, @em file is empty. The function returns true if the @em Open button was clicked.
 *
 * If the @em Cancel button was clicked, @em file remains untouched and the function returns false.
 * 
 * Call this function after opendialog_execute() returns false and before opendialog_destroy() is called.
 *
 * @param  opendialog  Pointer as returned from opendialog_create()
 * @param  file        Pointer to provided buffer that will hold the filename
 * @param  size        Size of the provided buffer @em file
 *
 * @return False if @em cancel button was clicked, otherwise true
 */

bool opendialog_get_result(opendialog_t *opendialog, char *file, int size)
{
    int pathlen;

    assert(opendialog);
    assert(file);

    int index;
    char *filename;

    if (!opendialog->canceled && opendialog->ready)
    {
        icon_listbox_get_selection(&opendialog->dirlist, &index, 1);

        filename = icon_listbox_get_text(&opendialog->dirlist, index);

        if (size >= ((pathlen = strlen(opendialog->path)) + strlen(filename) + 2))  /* add 1 for null termination and 1 for dir-separator */
        {
            strcpy(file, opendialog->path);
            file[pathlen] = FS_DIRSEPCHAR;
            file[pathlen + 1] = 0;
            strcat(file, filename);
        }
        else
        {
            file[0] = 0;
        }
    }

    return !opendialog->canceled;
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

void opendialog_destroy(opendialog_t *opendialog)
{
    assert(opendialog);

    agui_t *agui = &agui_table[opendialog->dialogform.obj.agui_index];

    icon_listbox_clear(&opendialog->dirlist);
    agui_hide_form(agui);

    free(opendialog);
}


static void _dirlisting( const char *path, opendialog_t *od )
{
    DIR             *dir;
    struct dirent   *dirent;
    struct stat     buf;
    char            path_to_file[PATH_MAX];
    char            *ext;
    char            *curdir;
    bool            up = false;

    curdir = strrchr(path, FS_DIRSEPCHAR) + 1;
    od->location.text.text =  curdir;
    obj_invalidate(AGUI_HANDLE(od->location));

    chdir(path);
    dir = opendir(path);
    if ( dir != NULL )
    {
        icon_listbox_clear(&od->dirlist);
        while ( 1 )
        {
            dirent = readdir(dir);
            if (dirent == NULL)
            {
                break;
            }
            sprintf(path_to_file, "%s%c%s", path, FS_DIRSEPCHAR, dirent->d_name);
            if (stat(path_to_file, &buf) == 0)
            {
                if (S_ISDIR(buf.st_mode))
                {
                    if (strcmp(dirent->d_name, ".") == 0)
                    {
                        /* skip */
                    }
                    else if (strcmp(dirent->d_name, "..") == 0)
                    {
                        up = true;
                    }
                    else
                    {
                        icon_listbox_add(&od->dirlist, dirent->d_name, folder_bmp, NULL);
                    }
                }
                else if (S_ISREG(buf.st_mode))
                {
                    if (od->filter && !od->filter(dirent->d_name))
                    {
                        continue;
                    }
                    if ((ext = strrchr(dirent->d_name, '.')))
                    {
                        if (stricmp(ext, ".wav") == 0)
                        {
                            icon_listbox_add(&od->dirlist, dirent->d_name, wav_bmp, (void*)1);
                        }
                        else if (stricmp(ext, ".txt") == 0)
                        {
                            icon_listbox_add(&od->dirlist, dirent->d_name, txt_bmp, (void*)1);
                        }
                        else
                        {
                            icon_listbox_add(&od->dirlist, dirent->d_name, file_bmp, (void*)1);
                        }
                    }
                    else
                    {
                        icon_listbox_add(&od->dirlist, dirent->d_name, file_bmp, (void*)1);
                    }
                }
            }
        }
        closedir(dir);
        list_sort(&od->dirlist.list, _dir_sort, false);
        obj_invalidate(AGUI_HANDLE(od->dirlist));
        obj_set_visible(AGUI_HANDLE(od->up), up);
    }
}


static int _dir_sort(void *first, void *second)
{
    int diff;

    assert(first);
    assert(second);

    icon_listbox_item_t *first_item = (icon_listbox_item_t*)first;
    icon_listbox_item_t *second_item = (icon_listbox_item_t*)second;

    diff = first_item->vp - second_item->vp;

    if (diff)
    {
        return diff;
    }

    return stricmp( first_item->text, second_item->text);
}

#endif /* __POSIX_FILE_SYSTEM__ */
