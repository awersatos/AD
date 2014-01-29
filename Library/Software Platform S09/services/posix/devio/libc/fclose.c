/**************************************************************************
**                                                                        *
**  FILE        :  fclose.c                                               *
**                                                                        *
**  DESCRIPTION :  Source file for fclose() routine                       *
**                 Flushes the buffer for given stream, then closes the   *
**                 stream.                                                *
**                                                                        *
**  Copyright 1996-2008 Altium BV                                         *
**                                                                        *
**************************************************************************/

#include <stdio.h>
#include <io.h>

/*
 * The function fclose() is called (indirectly) from exit() for every
 * application. To prevent linking in malloc/free and the allocation of
 * the heap for every application, a weak reference _dofree is used that
 * is only filled with a reference to free when _fopen or setvbuf is linked.
 */
extern  void    _dofree    ( void * );
#pragma weak    _dofree
#pragma extern  _weakstub

int fclose(FILE *fp)
{
        int     ret;

        ret = _fflush(fp);                      /* flush unwritten data, don't care about undoing read */
        if (fp->_flag & _IOMYBUF)               /* Only free() when we did the malloc() */
        {
                _dofree(fp->_base);
        }
        if (_close(fileno(fp)) < 0)
        {
                ret = EOF;
        }

        /*
         * Free the _iob[] element by clearing _flag. We don't care about the other members.
         */
        fp->_flag = 0;
        return ret;
}
