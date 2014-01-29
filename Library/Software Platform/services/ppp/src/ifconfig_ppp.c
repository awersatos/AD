/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*
|*  IN PACKAGE:         PPP Interface Config
|*
|*  COPYRIGHT:          Copyright (c) 2010, Altium
|*
|*  DESCRIPTION:        Configure a PPP-based network interface
|*
 */
#include <assert.h>

#include "ppp_cfg_instance.h"
#include "ppp_internal.h"
#include <ppp.h>

#define PPP_UNUSED(x) (void)x

#if PAP_SUPPORT && CHAP_SUPPORT
#  define IFCONFIG_PPP_AUTH_TYPE PPPAUTHTYPE_ANY
#elif PAP_SUPPORT
#  define IFCONFIG_PPP_AUTH_TYPE PPPAUTHTYPE_PAP
#elif CHAP_SUPPORT
#  define IFCONFIG_PPP_AUTH_TYPE PPPAUTHTYPE_CHAP
#else
#  define IFCONFIG_PPP_AUTH_TYPE PPPAUTHTYPE_NONE
#endif

/** @brief Set the username and password to be used to
 *         authenticate the PPP connection.
 *
 * @param  ppp         a pointer to a ppp_t instance
 *                     which was previously returned by
 *                     ppp_open
 * @param  username    the user name string
 * @param  password    the password string
 *
 * @return 0 on failure, or non-zero otherwise
 */
extern int ifconfig_ppp_set_credentials(ppp_t * ppp, const char * username, const char * password)
{
    if (ppp->signature != PPP_SIGNATURE)
        return 0;

    pppSetAuth(IFCONFIG_PPP_AUTH_TYPE,username,password);
    return 1;
}

/** @brief Set the name of the remote Access Point for
 *         the PPP connection.
 *
 * @param  ppp         a pointer to a ppp_t instance
 *                     which was previously returned by
 *                     ppp_open
 * @param  access_point_name    the access point name string
 *
 * @return 0 on failure, or non-zero otherwise
 */
extern int ifconfig_ppp_set_access_point      (ppp_t * ppp, const char * access_point_name)
{
    assert(ppp);

    if (ppp->signature != PPP_SIGNATURE)
        return 0;
    if (strlen(access_point_name) >= APN_MAX_LEN)
        return 0;

    strncpy(ppp->apn,access_point_name,APN_MAX_LEN);
    return 1;
}


/** @brief Set the number of times to attempt to create
 *         the PPP connection.
 *
 * @param  ppp         a pointer to a ppp_t instance
 *                     which was previously returned by
 *                     ppp_open
 * @param  retries     the number of times to retry
 *
 * @return 0 on failure, or non-zero otherwise
 */
extern int ifconfig_ppp_set_retry_count       (ppp_t * ppp, uint8_t retries)
{
    assert(ppp);

    if (ppp->signature != PPP_SIGNATURE)
        return 0;

    ppp->retries = retries;
    return 1;
}

