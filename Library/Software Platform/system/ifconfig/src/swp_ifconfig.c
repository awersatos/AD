////////////////////////////////////////////////////////////////////////////////
// ifconfig.c

#include <swp_ifconfig.h>


#define CHECK_IS_IMPLIMENTED(check)   {if(!(check)) return -1;}

///////////////////////////////////////////////////////////////////////////////
void *ifconfig_get_interface(void *inst)
{
    ifconfig_stub_t *ifcfg_stub = (ifconfig_stub_t *)inst;

    if(ifcfg_stub && ifcfg_stub->signature == IFCONFIG_SIGNATURE){
        return ifcfg_stub->get_ifconfig?ifcfg_stub->get_ifconfig(inst):NULL;
    }

    return NULL;
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_ioctl(ifconfig_t *ifcfg, uint32_t cmd, void *data)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->ioctl);

    return ifcfg->ioctl(ifcfg, cmd, data);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_link_get_state(ifconfig_t *ifcfg, uint32_t *state)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_link && ifcfg->if_link->get_state);

    return ifcfg->if_link->get_state(ifcfg, state);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_link_start(ifconfig_t *ifcfg)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_link && ifcfg->if_link->start);

    return ifcfg->if_link->start(ifcfg);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_link_stop(ifconfig_t *ifcfg)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_link && ifcfg->if_link->stop);

    return ifcfg->if_link->stop(ifcfg);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_link_set_state_callback(ifconfig_t *ifcfg, void (*state_callback)(void *, uint32_t), void *state_callback_context)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_link);

    ifcfg->if_link->state_callback          = state_callback;
    ifcfg->if_link->state_callback_context  = state_callback_context;

    return 0;
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_link_state_callback(ifconfig_t *ifcfg, uint32_t state)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_link && ifcfg->if_link->state_callback);

    ifcfg->if_link->state_callback(ifcfg->if_link->state_callback_context, state);

    return 0;
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_phy_get_state(ifconfig_t *ifcfg, uint32_t *state)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_phy && ifcfg->if_phy->get_state);

    return ifcfg->if_phy->get_state(ifcfg, state);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_ieee80211_get_state(ifconfig_t *ifcfg, uint32_t *state)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_80211 && ifcfg->if_80211->get_state);

    return ifcfg->if_80211->get_state(ifcfg, state);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_set_mac(ifconfig_t *ifcfg, const void *mac)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_phy && ifcfg->if_phy->set_mac);

    return ifcfg->if_phy->set_mac(ifcfg, mac);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_get_mac(ifconfig_t *ifcfg, void *mac)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_phy && ifcfg->if_phy->get_mac);

    return ifcfg->if_phy->get_mac(ifcfg, mac);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_ieee80211_set_ssid(ifconfig_t *ifcfg, const int8_t *ssid)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_80211 && ifcfg->if_80211->set_ssid);

    return ifcfg->if_80211->set_ssid(ifcfg, ssid);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_ieee80211_get_ssid(ifconfig_t *ifcfg, int8_t **ssid)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_80211 && ifcfg->if_80211->get_ssid);

    return ifcfg->if_80211->get_ssid(ifcfg, ssid);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_ieee80211_set_channel(ifconfig_t *ifcfg, int32_t chan)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_80211 && ifcfg->if_80211->set_channel);

    return ifcfg->if_80211->set_channel(ifcfg, chan);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_ieee80211_get_channel(ifconfig_t *ifcfg, int32_t *chan)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_80211 && ifcfg->if_80211->get_channel);

    return ifcfg->if_80211->get_channel(ifcfg, chan);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_ieee80211_set_passphrase(ifconfig_t *ifcfg, const int8_t *passphrase)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_80211 && ifcfg->if_80211->set_passphrase);

    return ifcfg->if_80211->set_passphrase(ifcfg, passphrase);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_ieee80211_get_passphrase(ifconfig_t *ifcfg, int8_t **passphrase)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_80211 && ifcfg->if_80211->get_passphrase);

    return ifcfg->if_80211->get_passphrase(ifcfg, passphrase);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_ieee80211_set_wep_key(ifconfig_t *ifcfg, const int8_t *key, uint32_t idx)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_80211 && ifcfg->if_80211->set_wep_key);

    return ifcfg->if_80211->set_wep_key(ifcfg, key, idx);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_ieee80211_get_wep_key(ifconfig_t *ifcfg, int8_t **key, uint32_t idx)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_80211 && ifcfg->if_80211->get_wep_key);

    return ifcfg->if_80211->get_wep_key(ifcfg, key, idx);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_ieee80211_set_wpapsk_key(ifconfig_t *ifcfg, const int8_t *key)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_80211 && ifcfg->if_80211->set_wpapsk_key);

    return ifcfg->if_80211->set_wpapsk_key(ifcfg, key);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_ieee80211_get_wpapsk_key(ifconfig_t *ifcfg, int8_t **key)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_80211 && ifcfg->if_80211->get_wpapsk_key);

    return ifcfg->if_80211->get_wpapsk_key(ifcfg, key);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_ieee80211_set_crypt(ifconfig_t *ifcfg, uint32_t crypt, uint32_t genKeys)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_80211 && ifcfg->if_80211->set_crypt);

    return ifcfg->if_80211->set_crypt(ifcfg, crypt, genKeys);
}

///////////////////////////////////////////////////////////////////////////////
int ifconfig_ieee80211_get_crypt(ifconfig_t *ifcfg, uint32_t *crypt)
{
    CHECK_IS_IMPLIMENTED(ifcfg && ifcfg->if_80211 && ifcfg->if_80211->get_crypt);

    return ifcfg->if_80211->get_crypt(ifcfg, crypt);
}

