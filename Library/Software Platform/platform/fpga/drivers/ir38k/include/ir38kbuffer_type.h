/*****************************************************************************\
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        IR 38K RX buffer type
|*
 */
#ifndef _IR38KBUFFER_TYPE_H_
#define _IR38KBUFFER_TYPE_H_

#ifdef  __cplusplus
extern "C" {
#endif

typedef struct ir38kbuffer_s
{
    int		    repeat;	    // was it repeated data
    uint32_t	data;       // received data
} ir38kbuffer_t;

#ifdef  __cplusplus
}
#endif

#endif //_IR38KBUFFER_TYPE_H_