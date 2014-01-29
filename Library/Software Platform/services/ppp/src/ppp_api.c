/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         PPP Plugin
|*
|*  COPYRIGHT:          Copyright (c) 2009, Altium
|*
|*  DESCRIPTION:        Plugin providing PPP communication using the Light Weight IP (LWIP) package
|*
 */
#include <string.h>
#include <assert.h>

#include <sys/types.h>
#include <pthread.h>

#include <modem.h>
#include "ppp_internal.h"

#define NSEC_PER_MSEC 1000000
#define PPP_DEFAULT_CID 1

static ppp_t ppp_table[PPP_INSTANCE_COUNT];
static ppp_result_t ppp_start_result;           // FIXME -- jtk this is not threadsafe
static bool ppp_is_initialized = false;


/** @brief Internal callback that is executed when PPP has finished opening.
 *
 * @param  ctx     an allocated ppp_result_t structure
 * @param  err     the result of the PPP open operation
 * @param  arg     unused
 */
static void ppp_link_status_changed(void *ctx, int err, void *arg)
{
    ppp_result_t * result = (ppp_result_t *) ctx;

    assert(result);
    LWIP_UNUSED_ARG(arg);

    if (result->sem)
        sys_sem_signal(&result->sem);

    result->err = err;
}

void ppp_init()
{
    pppInit();
    ppp_is_initialized = true;
}

/** @brief Open function which sets up the adaptor and calls open on the plugin
 *         attached to the lower interface.
 *
 * @param  id      the identification number of the ppp adaptor to open
 * @return NULL    if the adaptor failed to open, OR
 *         A pointer to the adaptor instance.
 */
extern ppp_t * ppp_open(unsigned int id)
{
    const ppp_cfg_instance_t * ppp_cfg;
    ppp_t                    * ppp;

    assert(id < PPP_INSTANCE_COUNT);

    ppp           = &ppp_table[id];
    ppp_cfg       = &ppp_instance_table[id];

    if (!ppp_is_initialized)
    {
        LWIP_DEBUGF(PPP_DEBUG,("PPP Not initialized.\n"));
        goto error;
    }
    if (ppp->signature != PPP_SIGNATURE)
    {
        memset(ppp,0,sizeof(ppp_t));

        ifconfig_ppp_set_credentials(NULL,
                ppp_cfg->has_username ? ppp_cfg->username : "",
                ppp_cfg->has_password ? ppp_cfg->password : ""
        );

        ppp->sio_fd = sio_open(ppp_cfg->modem);
        if (!ppp->sio_fd)
        {
            LWIP_DEBUGF(PPP_DEBUG,("Modem open failed.\n"));
            goto error;
        }
        ppp->signature = PPP_SIGNATURE;

        if (!ifconfig_ppp_set_access_point(ppp, ppp_cfg->apn))
           goto error;
        if (!ifconfig_ppp_set_retry_count(ppp, ppp_cfg->retries))
           goto error;
    }
    return ppp;
error:
    ppp->signature = 0;
    return NULL;
}


/** @brief Start function which activates the adaptor and registers it with
 *         LWIP. This function will block until either the PPP Startup
 *         timeout has been exceeded, or the adaptor has been successfully
 *         started.
 *
* @param  instance         a pointer to a ppp instance
 *                         which was previously returned by
 *                         ppp_open
 * @return PPPERR_NONE     if the adaptor started successfully
           PPPERR_PARAM    if instance does not point to a valid
 *                         ppp instance.
 *         PPPERR_CONNECT  if the function failed to connect to the modem.
 *         PPPERR_OPEN     if the ppp instance failed to open.
 *         PPPERR_DEVICE   if the timeout was exceeded before the device succeeded in opening
 *         PPPERR_ALLOC    if PPP was unable to allocate sufficient memory to operate
 *         PPPERR_PROTOCOL if one of the PPP protocols failed to start
 */
extern int ppp_start(ppp_t * instance)
{
    int i;
    ppp_t * ppp = (ppp_t *) instance;

    assert(ppp);

    if (!ppp_is_initialized)
    {
        LWIP_DEBUGF(PPP_DEBUG,("PPP Not initialized.\n"));
        return PPPERR_OPEN;
    }
    if (ppp->signature != PPP_SIGNATURE)
        return PPPERR_PARAM;

    if (!modem_start(ppp->sio_fd))
        return PPPERR_DEVICE;

    modem_echo(ppp->sio_fd,false,true);
    modem_autoanswer(ppp->sio_fd,0);

    if (!modem_define_pdp(ppp->sio_fd,PPP_DEFAULT_CID,ppp->apn))
        return PPPERR_DEVICE;

    for (i=0;i<ppp->retries;i++)
    {
        if (!modem_check_network(ppp->sio_fd))
        {
            sys_msleep(2000);
            continue;
        }
        if (modem_connect_pdp(ppp->sio_fd,PPP_DEFAULT_CID))
            break;
        else
            modem_reset(ppp->sio_fd);
    }
    if (i >= ppp->retries)
    {
        LWIP_DEBUGF(PPP_DEBUG,("Modem failed to connect.\n"));
        return PPPERR_CONNECT;
    }
    sys_sem_new(&ppp_start_result.sem, 0);
    ppp_start_result.err = PPPERR_NONE;
    ppp->ppp_fd = pppOpen(ppp->sio_fd, &ppp_link_status_changed, &ppp_start_result);
    if (ppp->ppp_fd < 0)
    {
        LWIP_DEBUGF(PPP_DEBUG,("PPP failed to open (%d).\n",ppp->ppp_fd));
        sys_sem_free(&ppp_start_result.sem);
        return PPPERR_OPEN;
    }
    if (!sys_arch_sem_wait(&ppp_start_result.sem,PPP_START_TIMEOUT_MS))
    {
        LWIP_DEBUGF(PPP_DEBUG,("Timed out bringing PPP interface up.\n"));
        sys_sem_free(&ppp_start_result.sem);
        pppClose(ppp->ppp_fd);
        return PPPERR_DEVICE;
    }
    if (ppp_start_result.err != PPPERR_NONE)
    {
        LWIP_DEBUGF(PPP_DEBUG,("Failed to bring PPP interface up (%d).\n",ppp_start_result.err));
        sys_sem_free(&ppp_start_result.sem);
        pppClose(ppp->ppp_fd);
        return ppp_start_result.err;
    }
    sys_sem_free(&ppp_start_result.sem);
    ppp_start_result.sem = NULL;

    return PPPERR_NONE;
}


/** @brief Stop function which deactivates the adaptor
 *
* @param  instance         a pointer to a ppp instance
 *                         which was previously returned by
 *                         ppp_open
 * @return PPPERR_PARAM    if instance does not point to a valid
 *                         ppp instance.
 *         PPPERR_DEVICE   if the timeout was exceeded before the device succeeded in opening
 */
extern int ppp_stop(ppp_t * instance)
{
    ppp_t * ppp = (ppp_t *) instance;

    assert(ppp);

    if (!ppp_is_initialized)
    {
        LWIP_DEBUGF(PPP_DEBUG,("PPP Not initialized.\n"));
        return PPPERR_OPEN;
    }
    if (ppp->signature != PPP_SIGNATURE)
        return PPPERR_PARAM;

    pppClose(ppp->ppp_fd);

    if (modem_hangup(ppp->sio_fd))
       return PPPERR_NONE;
    else
       return PPPERR_DEVICE;
}


/** @brief Get the local IP address that is associated with this adaptor.
 *
 * @param  ppp         a pointer to a ppp instance
 *                     which was previously returned by
 *                     ppp_open
 * @return IP_ADDR_ANY if the address is not found, OR
 *         a valid IP address.
 */
extern struct ip_addr    ppp_get_local_addr        (ppp_t * ppp)
{
    return U32_AS_IP4_ADDR(ipcp_gotoptions[ppp->ppp_fd].ouraddr);
}

/** @brief Get the remote endpoint address that is associated with this adaptor.
 *
 * @param  ppp         a pointer to a ppp instance
 *                     which was previously returned by
 *                     ppp_open
 * @return IP_ADDR_ANY if the address is not found, OR
 *         a valid IP address.
 */
extern struct ip_addr    ppp_get_remote_addr       (ppp_t * ppp)
{
    return U32_AS_IP4_ADDR(ipcp_gotoptions[ppp->ppp_fd].hisaddr);
}

/** @brief Get the primary DNS address that is associated with this adaptor.
 *
 * @param  ppp         a pointer to a ppp instance
 *                     which was previously returned by
 *                     ppp_open
 * @return IP_ADDR_ANY if the address is not found, OR
 *         a valid IP address.
 */
extern struct ip_addr    ppp_get_primary_dns_addr  (ppp_t * ppp)
{
    return U32_AS_IP4_ADDR(ipcp_gotoptions[ppp->ppp_fd].dnsaddr[0]);
}

/** @brief Get secondary DNS address that is associated with this adaptor.
 *
 * @param  ppp         a pointer to a ppp instance
 *                     which was previously returned by
 *                     ppp_open
 * @return IP_ADDR_ANY if the address is not found, OR
 *         a valid IP address.
 */
extern struct ip_addr    ppp_get_secondary_dns_addr(ppp_t * ppp)
{
    return U32_AS_IP4_ADDR(ipcp_gotoptions[ppp->ppp_fd].dnsaddr[1]);
}



/** @brief Get secondary DNS address that is associated with this adaptor.
 *
 * @param  ppp         a pointer to a ppp instance
 *                     which was previously returned by
 *                     ppp_open
 * @return IP_ADDR_ANY if the address is not found, OR
 *         a valid IP address.
 */
extern int ppp_set_default(ppp_t * ppp, bool is_default)
{
    assert(ppp);

    if (!ppp_is_initialized)
    {
        LWIP_DEBUGF(PPP_DEBUG,("PPP Not initialized.\n"));
        return PPPERR_OPEN;
    }
    if (ppp->signature != PPP_SIGNATURE)
        return PPPERR_PARAM;
    if (!is_default)
        return PPPERR_NONE;
        
    if (sifdefaultroute(ppp->ppp_fd,0,0))
        return PPPERR_NONE;

    return PPPERR_PARAM;
}

