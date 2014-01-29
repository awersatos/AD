/**************************************************************************
**                                                                        *
**  FILE        :  strerror.c                                             *
**                                                                        *
**  DESCRIPTION :  Source file for strerror() routine                     *
**                 Maps the error number in 'errnum' to an error message  *
**                 string.                                                *
**                                                                        *
**  Copyright 1996-2005 Altium BV                                         *
**                                                                        *
**************************************************************************/

#include <errno.h>
#include <string.h>

static
const char * errors [ _NERR ] =
{
/*0*/   "Success",
/*1*/   "Operation not permitted",
/*2*/   "No such file or directory",
/*3*/   "Interrupted system call",
/*4*/   "I/O error",
/*5*/   "Bad file number",
/*6*/   "Resource temporarily unavailable",
/*7*/   "Cannot allocate memory",
/*8*/   "Permission denied",
/*9*/   "Bad address",
/*10*/  "File exists",
/*11*/  "Not a directory",
/*12*/  "Is a directory",
/*13*/  "Invalid argument",
/*14*/  "File table overflow",
/*15*/  "Too many open files",
/*16*/  "Text file busy",
/*17*/  "No space left on device",
/*18*/  "Illegal seek",
/*19*/  "Read-only file system",
/*20*/  "Broken pipe",
/*21*/  "Too many levels of symbolic links",
/*22*/  "File name too long",
/*23*/  "Argument too large",
/*24*/  "Result too large",
/*25*/  "illegal format string for printf/scanf",
/*26*/  "floating point not supported",
/*27*/  "long not supported",
/*28*/  "pointers not supported",
/*29*/  "Invalid or incomplete multibyte or wide character",
/*30*/  "Operation canceled",
/*31*/  "No such device",
/*32*/  "Resource deadlock would occur",
/*33*/  "Connection timed out",
/*34*/  "Device or resource busy",
/*35*/  "Not supported",
/*36*/  "No such process",
/*37*/  "No such ISR installed",
/*38*/  "Wrong devce i/o configuration",
/*39*/  "Message length exceeds size",
/*40*/  "Cross-device link",
/*41*/  "Timer expired",
/*42*/  "Cannot send after transport endpoint shutdown",
/*43*/  "Operation now in progress",
/*44*/  "Remote I/O error"
};

char*
strerror ( int errcode )
{
        return (char*)errors[errcode];
}
