/*****************************************************************************\
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        IR RX buffer type
|*
 */
#ifndef _IRRXBUFFER_TYPE_H_
#define _IRRXBUFFER_TYPE_H_

typedef struct irrxbuffer_s
{
    int		repeat;	    // was it repeated data
    uint32_t	data;       // received data
} irrxbuffer_t;

#endif //_IRRXBUFFER_TYPE_H_