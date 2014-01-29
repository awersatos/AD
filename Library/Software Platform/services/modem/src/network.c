/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         MODEM Communication
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        Generic AT commands to access and handle the GSM network
|*
 */
#include <timing.h>
#if ( __POSIX_KERNEL__ != 0 )
# include <pthread.h>
#else
#include <time.h>
#endif

#include <string.h>
#include "modem_i.h"
#include "csv.h"

#define NETWORK_TOKEN_COUNT 10
#define NETWORK_STATUS_TIMEOUT_MS 10000

/**
 * @brief Enter PIN code (AT+CPIN)
 *
 * @param modem        pointer to modem device struct
 * @param pin_code     string containing the pincode
 *
 * @return   1 on success, 0 on error.
 */
int modem_enter_pin(modem_t *modem, const char *pin_code)
{
    char buf[MODEM_SMALL_MSG] = "AT+CPIN=";
    int ret = 0;
    const char * responses[] = {  "+CPIN: ", "SIM PIN", "+CPIN: READY" };

    // check if PIN is needed
    if (modem_cmd_ex(modem, "AT+CPIN?",&responses[0],1,MODEM_DEFAULT_TIMEOUT)==0)
    {
        if (modem_cmd_ex(modem, NULL,&responses[1],1,MODEM_DEFAULT_TIMEOUT) == 0 && pin_code)
        {
            strcat(buf, pin_code);
            modem_cmd(modem, buf);
        }
        // refresh CPIN query to check if we passed the pin...
        if (modem_cmd_ex(modem, "AT+CPIN?",&responses[2],1 ,MODEM_DEFAULT_TIMEOUT) == 0)
            ret = 1;
    }
    return ret;
}


/**
 * @brief Check mobile network registration (AT+CREG?)
 *
 * Checks if mobile is registered to the GSM-network (AT+CREG). Reply is like :
 * AT+CREG: <n>, <stat>[, ....] stat should be 1 or 5 (mobile registered)
 *
 * @param modem     pointer to modem device struct
 *
 * @return 1 on success, 0 on error.
 */
int modem_check_network(modem_t *modem)
{
    char * token[NETWORK_TOKEN_COUNT];
    int token_count = NETWORK_TOKEN_COUNT;
    bool success;
    int len;
    char buf[MODEM_SMALL_MSG];
    const char * expected = "+CREG: ";

    // check if registration to GSM network is ok
    success = modem_cmd_ex(modem, "AT+CREG?", &expected,1,NETWORK_STATUS_TIMEOUT_MS)==0;
    if (!success) return 0;

    len = modem_read(modem,(uint8_t *) buf,MODEM_SMALL_MSG);
    if (len == 0) return 0;

    tokenize_csv_line(buf,len,token,&token_count);
    if (token_count < 2) return 0;

    return *token[1]=='1' || *token[1]=='5';     // look at the <stat> parameter from the response
}



/**
 * @brief Return a string describing mobile network status
 *
 * Checks if mobile is registered to the GSM-network (AT+CREG). Reply is like :
 * AT+CREG: <n>, <stat>[, ....] stat should be 1 or 5 (mobile registered)
 *
 * @param modem     pointer to modem device struct
 *
 * @return a modem_status_t value describing the current network state
 */
modem_status_t modem_network_status(modem_t *modem)
{
    char * token[NETWORK_TOKEN_COUNT];
    int token_count = NETWORK_TOKEN_COUNT;
    bool success;
    int len=0, r = 0;
    modem_status_t status;
    char buf[MODEM_SMALL_MSG];
    const char * expected = "+CREG: ";

    // check if registration to GSM network is ok
    success = modem_cmd_ex(modem, "AT+CREG?", &expected,1,NETWORK_STATUS_TIMEOUT_MS)==0;
    if (!success) return MODEM_STATUS_UNKNOWN;

    len = modem_read(modem,(uint8_t *) (buf+len),MODEM_SMALL_MSG);
    if (len==0) return MODEM_STATUS_UNKNOWN;

    tokenize_csv_line(buf,len,token,&token_count);
    if (token_count < 2) return MODEM_STATUS_UNKNOWN;

    status = (modem_status_t) atoi(token[1]);
    if (MODEM_STATUS_IDLE <= status && status <= MODEM_STATUS_REGISTERED_ROAMING)
        return status;

    return MODEM_STATUS_UNKNOWN;
}

#define CME_ERROR_STRING "+CME ERROR: "

/**
 * @brief Return a string describing mobile network status
 *
 * Checks if mobile is registered to the GSM-network (AT+CREG). Reply is like :
 * AT+CREG: <n>, <stat>[, ....] stat should be 1 or 5 (mobile registered)
 *
 * @param modem     pointer to modem device struct
 *
 * @return a modem_status_t value describing the current network state
 */
modem_cme_error_t modem_sim_status(modem_t *modem)
{
    int result, len=0, r=0;
    char buf[MODEM_SMALL_MSG];
    const char * responses[] = { "+CRSM", "+CME ERROR: "};

    result = modem_cmd_ex(modem, "AT+CRSM=242", responses, 2,NETWORK_STATUS_TIMEOUT_MS);
    switch (result)
    {
    case  0: // found "OK"
        return CME_OK;
    case  1: // found cme error
        len = modem_read(modem,(uint8_t *) buf,MODEM_SMALL_MSG);
        if (len==0)
            return MODEM_STATUS_UNKNOWN;
        return atoi(buf);
    default:
        return CME_UNKNOWN;
    }
}

/**
 * @brief Return a string describing a CME (Connected Mobile Equiment) error code
 *
 * @param error     The error code to describe
 *
 * @return a string describing the CME Error code
 */
const char * modem_cme_error_str(modem_cme_error_t error)
{
    switch (error)
    {
    case CME_PHONE_FAILURE:                                            return "phone failure";
    case CME_NO_CONNECTION_TO_PHONE:                                   return "no connection to phone";
    case CME_PHONE_ADAPTOR_LINK_RESERVED:                              return "phone-adaptor link reserved";
    case CME_OPERATION_NOT_ALLOWED:                                    return "operation not allowed";
    case CME_OPERATION_NOT_SUPPORTED:                                  return "operation not supported";
    case CME_PH_SIM_PIN_REQUIRED:                                      return "PH-SIM PIN required";
    case CME_PH_FSIM_PIN_REQUIRED:                                     return "PH-FSIM PIN required";
    case CME_PH_FSIM_PUK_REQUIRED:                                     return "PH-FSIM PUK required";
    case CME_SIM_NOT_INSERTED:                                         return "SIM not inserted";
    case CME_SIM_PIN_REQUIRED:                                         return "SIM PIN required";
    case CME_SIM_PUK_REQUIRED:                                         return "SIM PUK required";
    case CME_SIM_FAILURE:                                              return "SIM failure";
    case CME_SIM_BUSY:                                                 return "SIM busy";
    case CME_SIM_WRONG:                                                return "SIM wrong";
    case CME_INCORRECT_PASSWORD:                                       return "incorrect password";
    case CME_SIM_PIN_2_REQUIRED:                                       return "SIM PIN 2 required";
    case CME_SIM_PUK_2_REQUIRED:                                       return "SIM PUK 2 required";
    case CME_MEMORY_FULL:                                              return "memory full";
    case CME_INVALID_INDEX:                                            return "invalid index";
    case CME_NOT_FOUND:                                                return "not found";
    case CME_MEMORY_FAILURE:                                           return "memory failure";
    case CME_STRING_TOO_LONG:                                          return "text string too long";
    case CME_INVALID_TEXT_STRING:                                      return "invalid characters in text string";
    case CME_DIAL_STRING_TOO_LONG:                                     return "dial string too long";
    case CME_INVALID_DIAL_STRING:                                      return "invalid characters in dial string";
    case CME_NO_NETWORK_SERVICE:                                       return "no network service";
    case CME_NETWORK_TIMEOUT:                                          return "network timeout";
    case CME_NETWORK_NOT_ALLOWED_EMERGENCY_CALLS_ONLY:                 return "network not allowed - emergency calls only";
    case CME_NETWORK_PERSONALIZATION_PIN_REQUIRED:                     return "network personalization PIN required";
    case CME_NETWORK_PERSONALIZATION_PUK_REQUIRED:                     return "network personalization PUK required";
    case CME_NETWORK_SUBSET_PERSONALIZATION_PIN_REQUIRED:              return "network subset personalization PIN required";
    case CME_NETWORK_SUBSET_PERSONALIZATION_PUK_REQUIRED:              return "network subset personalization PUK required";
    case CME_SERVICE_PROVIDER_PERSONALIZATION_PIN_REQUIRED:            return "service provider personalization PIN required";
    case CME_SERVICE_PROVIDER_PERSONALIZATION_PUK_REQUIRED:            return "service provider personalization PUK required";
    case CME_CORPORATE_PERSONALIZATION_PIN_REQUIRED:                   return "corporate personalization PIN required";
    case CME_CORPORATE_PERSONALIZATION_PUK_REQUIRED:                   return "corporate personalization PUK required";
    case CME_UNKNOWN:                                                  return "unknown";
    case CME_ILLEGAL_MS:                                               return "Illegal MS (#3)";
    case CME_ILLEGAL_ME:                                               return "Illegal ME (#6)";
    case CME_GPRS_NOT_ALLOWED:                                         return "GPRS services not allowed (#7)";
    case CME_PLMN_NOT_ALLOWED:                                         return "PLMN not allowed (#11)";
    case CME_LOCATION_AREA_NOT_ALLOWED:                                return "Location area not allowed (#12)";
    case CME_ROAMING_NOT_ALLOWED:                                      return "Roaming not allowed in this location area (#13)";
    case CME_SERVICE_OPTION_NOT_SUPPORTED:                             return "service option not supported (#32)";
    case CME_REQUESTED_SERVICE_OPTION_NOT_SUBSCRIBED:                  return "requested service option not subscribed (#33)";
    case CME_SERVICE_OPTION_TEMPORARILY_OUT_OF_ORDER:                  return "service option temporarily out of order (#34)";
    case CME_PDP_AUTHENTICATION_FAILURE:                               return "PDP authentication failure";
    case CME_INVALID_MOBILE_CLASS:                                     return "invalid mobile class";
    case CME_UNSPECIFIED_GPRS_ERROR:                                   return "unspecified GPRS error";
    case CME_VBS_VGCS_NOT_SUPPORTED_BY_THE_NETWORK:                    return "VBS/VGCS not supported by the network";
    case CME_NO_SERVICE_SUBSCRIPTION_ON_SIM:                           return "No service subscription on SIM";
    case CME_NO_SUBSCRIPTION_FOR_GROUP_ID:                             return "No subscription for group ID";
    case CME_GROUP_ID_NOT_ACTIVATED_ON_SIM:                            return "Group Id not activated on SIM";
    case CME_NO_MATCHING_NOTIFICATION:                                 return "No matching notification";
    case CME_VBS_VGCS_CALL_ALREADY_PRESENT:                            return "VBS/VGCS call already present";
    case CME_CONGESTION:                                               return "Congestion";
    case CME_NETWORK_FAILURE:                                          return "Network failure";
    case CME_UPLINK_BUSY:                                              return "Uplink busy";
    case CME_NO_ACCESS_RIGHTS_FOR_SIM_FILE:                            return "No access rights for SIM file";
    case CME_NO_SUBSCRIPTION_FOR_PRIORITY:                             return "No subscription for priority";
    case CME_OPERATION_NOT_APPLICABLE:                                 return "operation not applicable or not possible";
    default:                                                           return "UNKNOWN CME ERROR";
    }
}

/**
 * @brief Get the signal quality (AT+CSQ) and convert value on a scale 0-5
 *
 * @param modem     pointer to modem device struct
 *
 * @return signal quality (0 = very bad, 5 = very good)
 */
int modem_signal_quality(modem_t *modem)
{
    const char * expected =  "+CSQ: ";
    char * token[NETWORK_TOKEN_COUNT];
    int token_count = NETWORK_TOKEN_COUNT;
    bool success;
    int len;
    int level;
    char buf[MODEM_SMALL_MSG];

    // check GSM reception level
    success = modem_cmd_ex(modem, "AT+CSQ",&expected,1,MODEM_DEFAULT_TIMEOUT)==0;
    if (!success) return 0;

    len = modem_read(modem,(uint8_t *) buf,MODEM_SMALL_MSG);
    if (len == 0) return 0;

    tokenize_csv_line(buf,len,token,&token_count);
    if (token_count < 1) return 0;

    level = atoi(token[0]);
    if (level > 30) return 5; // -51 dBm or more
    if (level > 27) return 4; // -53 dBm
    if (level > 20) return 3; //  ...
    if (level > 1 ) return 2; // -109
    if (level > 0 ) return 1; // -111 dBm
    return 0;                 // -113 dBm or less
}
