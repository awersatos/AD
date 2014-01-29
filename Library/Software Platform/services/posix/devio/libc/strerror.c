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
const char * errors [ _NERR + 1] =
{
/*0*/   "Success",
/*1*/   "Argument list too long",
/*2*/   "Permission denied",
/*3*/   "Address in use",
/*4*/   "Address not available",
/*5*/   "Address family not supported",
/*6*/   "Resource unavailable, try again",
/*7*/   "Connection already in progress",
/*8*/   "Bad file descriptor",
/*9*/   "Bad message",
/*10*/  "Device or resource busy",
/*11*/  "Operation canceled",
/*12*/  "No child processes",
/*13*/  "Connection aborted",
/*14*/  "Connection refused",
/*15*/  "Connection reset",
/*16*/  "Resource deadlock would occur",
/*17*/  "Destination address required",
/*18*/  "Mathematics argument out of domain of function",
/*19*/  "Reserved (EDQUOT)",
/*20*/  "File exists",
/*21*/  "Bad address",
/*22*/  "File too large",
/*23*/  "Host is unreachable",
/*24*/  "Identifier removed",
/*25*/  "Illegal byte sequence",
/*26*/  "Operation in progress",
/*27*/  "Interrupted function",
/*28*/  "Invalid argument",
/*29*/  "I/O error",
/*30*/  "Socket is connected",
/*31*/  "Is a directory",
/*32*/  "Too many levels of symbolic links",
/*33*/  "Too many open files",
/*34*/  "Too many links",
/*35*/  "Message too large",
/*36*/  "Reserved (EMULTIHOP)",
/*37*/  "Filename too long",
/*38*/  "Network is down",
/*39*/  "Connection aborted by network",
/*40*/  "Network unreachable",
/*41*/  "Too many files open in system",
/*42*/  "No buffer space available",
/*43*/  "No message is available on the STREAM head read queue",
/*44*/  "No such device",
/*45*/  "No such file or directory",
/*46*/  "Executable file format error",
/*47*/  "No locks available",
/*48*/  "Reserved (ENOLINK)",
/*49*/  "Not enough space",
/*50*/  "No message of the desired type",
/*51*/  "Protocol not available",
/*52*/  "No space left on device",
/*53*/  "No STREAM resources",
/*54*/  "Not a STREAM",
/*55*/  "Function not supported",
/*56*/  "The socket is not connected",
/*57*/  "Not a directory",
/*58*/  "Directory not empty",
/*59*/  "Not a socket",
/*60*/  "Not supported",
/*61*/  "Inappropriate I/O control operation",
/*62*/  "No such device or address",
/*63*/  "Operation not supported on socket",
/*64*/  "Value too large to be stored in data type",
/*65*/  "Operation not permitted",
/*66*/  "Broken pipe",
/*67*/  "Protocol error",
/*68*/  "Protocol not supported",
/*69*/  "Protocol wrong type for socket",
/*70*/  "Result too large",
/*71*/  "Read-only file system",
/*72*/  "Invalid seek",
/*73*/  "No such process",
/*74*/  "Reserved (ESTALE)",
/*75*/  "Stream ioctl() timeout",
/*76*/  "Connection timed out",
/*77*/  "Text file busy",
/*78*/  "Cross-device link",
/*79*/  "Remote I/O error",
/*80*/  "Wrong devce i/o configuration",
/*81*/  "Cannot send after transport endpoint shutdown.",
/*_NERR*/   "Invalid error number"
};

char*
strerror ( int errcode )
{
    if (errcode < 0 || errcode > _NERR)
    {
        errcode = _NERR;
    }

    return (char*)errors[errcode];
}
