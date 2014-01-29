/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $25/09/2009$
|*
|*  IN PACKAGE:         
|*
|*  COPYRIGHT:          Copyright (c) 2009, Altium
|*
|*  DESCRIPTION:        
|*
 */

#ifndef PPP_INTERNAL_H_
#define PPP_INTERNAL_H_

#include <ppp.h>
#include <fsm.h>
#include <ipcp.h>

#include "ppp_api.h"
#include "ppp_cfg_instance.h"

#define PPP_UNUSED(x) (void)x
#define PPP_SIGNATURE 0x00DDD000

#define APN_MAX_LEN 128
#define PHONE_NUM_MAX_LEN 32

struct ppp_s
{
    int             signature;

    sio_fd_t        sio_fd;
    int             ppp_fd;

    int             retries;
    char            phone_num[PHONE_NUM_MAX_LEN];
    char            apn[APN_MAX_LEN];
};

typedef struct ppp_result
{
    sys_sem_t sem;
    int       err;
} ppp_result_t;

#define U32_AS_IP4_ADDR(addr) (*(struct ip_addr *)&(addr))

#endif /* PPP_INTERNAL_H_ */
