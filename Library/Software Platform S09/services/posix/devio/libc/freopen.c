/**************************************************************************
**                                                                        *
**  FILE        :  freopen.c                                              *
**                                                                        *
**  DESCRIPTION :  Source file for freopen() routine                      *
**                 Flushes the given stream, closes it and opens it again *
**                                                                        *
**  Copyright 1996-2005 Altium BV                                         *
**                                                                        *
**************************************************************************/

// FIXME: use better names for Altium Designer specific defines

#include <stdio.h>
#include <io.h>

/*
 * When file==NULL we're supposed to do a mode change only as far
 * as the platform permits it (implementation defined): we don't.
 *
 * However, it is unclear if the original file handle should
 * still be open after a mode change failure. We close it
 * so a NULL return value always implies that fp is closed.
 *
 * Gracefully handle fclose() followed by freopen() because the
 * standard is not entirely clear about this either: we should "attempt
 * to close" the file and we should ignore a failure to close the file.
 */
FILE *freopen(const char * restrict file, const char * restrict mode, FILE * restrict fp)
{
        FILE    *ret = NULL;

        if (fp->_flag)
        {
                fclose(fp);
        }

        if (file && _fopen(file, mode, fp, -1))
        {
                ret = fp;
        }

        return ret;
}
