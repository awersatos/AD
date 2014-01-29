/**************************************************************************
**                                                                        *
**  FILE        :  perror.c                                               *
**                                                                        *
**  DESCRIPTION :  Source file for perror() routine.                      *
**                 Maps the error number in the integer errno to an       *
**                 error message. It writes the message to standard error *
**                 stream. The message can be preceded by a user          *
**                 supplied message.                                      *
**                                                                        *
**  Copyright 1996-2008 Altium BV                                         *
**                                                                        *
**************************************************************************/

#include <errno.h>
#include <string.h>
#include <stdio.h>

void
perror( const char * s )
{
        /* 's' points to the user supplied prefix */
        if ( s && *s )
        {       /* First print user supplied message */
                fputs( s, stderr );
                fputs( ": ", stderr );
        }

        /* Then print the system message */
        fputs( strerror( errno ), stderr );
        fputc( '\n', stderr );
}
