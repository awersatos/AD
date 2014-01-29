////////////////////////////////////////////////////////////////////////////////
// usbhost_network.c

#include <init.h>
#include <kernel.h>
#include <usbhost.h>
#include <usbhost_device.h>
#include <usbhost_network.h>
#include <usbhost_network_cfg_instance.h>
#include <BSD_USB_Adaptor.h>

#include <swp_ifconfig.h>

// Needed for BSD interface hooks
#include <sys/systm.h>

#include <net80211/ieee80211_var.h>
#include <sys/mbuf.h>

#include <sys/device.h>

// WepKey Gen
#include <crypto/wepkey.h>
#include <crypto/pbkdf2.h>

//#define UHN_DEBUG
#undef UHN_DEBUG

#ifdef UHN_DEBUG
#define UHN_DEBUG_LEVEL 14;
int uhn_debug_lvl = UHN_DEBUG_LEVEL;
#define UHN_DPRINTF(x)  do { if (uhn_debug_lvl) printf x; } while (0)
#define UHN_DPRINTFN(n,x)   do { if (n>uhn_debug_lvl) printf x; } while (0)
#else
#define UHN_DPRINTF(x)
#define UHN_DPRINTFN(n,x)
#endif

#define USBHOST_IDENT IFCONFIG_SIGNATURE

////////////////////////////////////////////////////////////////////////////////
usbhost_network_t usbNetworkInstance[USBHOST_NETWORK_INSTANCE_COUNT];

////////////////////////////////////////////////////////////////////////////////
int HexStringToByteArray(const int8_t *hexString, uint32_t len, int8_t *byteArray, int32_t *outLen)
{
    uint32_t i,j;
    uint8_t val;
    uint8_t c;

    // Jump "0x" prefix if any
    if(hexString[0] == '0' && hexString[1] == 'x'){
        len -= 2;
        hexString+=2;
    }

    len >>= 1;

    for (i = 0 ; i < len ; i++) {
        val = 0;

        for (j=0 ; j<2 ; j++) {
            c = *hexString;
            if (c >= '0' && c <= '9') {
                c -= '0';
            } else if (c >= 'a' && c <= 'f') {
                c -= ('a' - 10);
            } else if (c >= 'A' && c <= 'F') {
                c -= ('A' - 10);
            } else {
                return -1;
            }
            ++hexString;
            val <<= 4;
            val += c;
        }
        *byteArray++ = val;
    }

    if(outLen){
        *outLen = len;
    }

    return 0;
}

////////////////////////////////////////////////////////////////////////////////
int ByteArrayToHexString(int8_t *byteArray, uint32_t len, int8_t *hexString, int32_t *outLen)
{
    uint32_t i,j;
    uint32_t c;
    int8_t hexByte[] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};


    // Prefix the string with "0x"
    j=0;
    hexString[j++] = '0';
    hexString[j++] = 'x';

    for (i = 0; i < len; i++) {
        c = *byteArray++;
        hexString[j++] = (uint8_t) hexByte[c >> 0x4];
        hexString[j++] = (uint8_t) hexByte[c &  0xf];
    }

    hexString[j] = 0;

    if(outLen){
        *outLen = j;
    }

    return 0;
}

////////////////////////////////////////////////////////////////////////////////
static bool is_configured_if(usbhost_network_t *inst)
{
    if((inst->ident != USBHOST_IDENT)||(!inst->ifp)){
        return false;
    }
    return true;
}

////////////////////////////////////////////////////////////////////////////////
uint32_t *usbhost_network_corebuf_alloc(usbhost_network_t * restrict drv, int size)
{
    uint32_t hdrSize = sizeof(struct ieee80211_frame);

    drv->sendMBuf = (struct mbuf *)calloc(1, sizeof(struct mbuf));
    assert(drv->sendMBuf);

    m_clget(drv->sendMBuf, M_WAIT, drv->ifp, size + hdrSize);

    drv->sendMBuf->m_hdr.mh_len           = size + 18;
    drv->sendMBuf->M_dat.MH.MH_pkthdr.len = size + 18;
    drv->sendMBuf->m_hdr.mh_type          = MT_DATA;
    drv->sendMBuf->m_data                 = drv->sendMBuf->m_ext.ext_buf + hdrSize;
    drv->sendMBuf->m_ext.ext_type         = MT_DATA;

    return (uint32_t *)(drv->sendMBuf->m_ext.ext_buf - 4 + hdrSize);
}

////////////////////////////////////////////////////////////////////////////////
void usbhost_network_corebuf_send(usbhost_network_t * restrict drv, uint32_t *corebuf)
{
    int error;

    IFQ_ENQUEUE(&drv->ifp->if_snd, drv->sendMBuf, NULL, error);

    drv->ifp->if_flags &= ~IFF_OACTIVE;
    drv->ifp->if_start(drv->ifp);

    return;
}

////////////////////////////////////////////////////////////////////////////////
uint32_t *usbhost_network_corebuf_receive(usbhost_network_t * restrict drv)
{
    IFQ_LOCK(&drv->ifp->if_rcv);
        IF_DEQUEUE_NOLOCK(&drv->ifp->if_rcv, drv->recvMBuf);
        if(!drv->recvMBuf){
            IFQ_WAIT(&drv->ifp->if_rcv);
            IF_DEQUEUE_NOLOCK(&drv->ifp->if_rcv, drv->recvMBuf);
        }
    IFQ_UNLOCK(&drv->ifp->if_rcv);

    if(drv->recvMBuf){
        uint32_t pSize;

        drv->recvMBuf->m_hdr.mh_data -= 14;
        drv->recvMBuf->m_hdr.mh_len  += 14;
        drv->recvMBuf->m_pkthdr.len  += 14;

        pSize = drv->recvMBuf->m_pkthdr.len;

        assert(pSize <= sizeof(drv->recvBuf));
        //memset(recvBuf,0, sizeof(recvBuf));

        m_copydata(drv->recvMBuf, 0, pSize, (caddr_t)(drv->recvBuf + 4));

        m_freem(drv->recvMBuf);

#ifdef __BIG_ENDIAN__
        write_big32to8(
#else
        write_little32to8(
#endif
        drv->recvBuf, pSize);

        return (uint32_t *)drv->recvBuf;
    }

    return (uint32_t *)NULL;
}

////////////////////////////////////////////////////////////////////////////////
void usbhost_network_corebuf_free(usbhost_network_t * restrict drv, uint32_t *corebuf)
{
    return;
}

////////////////////////////////////////////////////////////////////////////////
int usbhost_network_send(usbhost_network_t * restrict drv, uint8_t *buf, int size)
{
    return 0;
}

////////////////////////////////////////////////////////////////////////////////
int usbhost_network_receive(usbhost_network_t * restrict drv, uint8_t *buf, int size)
{
    return 0;
}

////////////////////////////////////////////////////////////////////////////////
void usbhost_network_setmode(usbhost_network_t * restrict drv, uint32_t rx_cmd, uint32_t tx_cmd)
{
    return;
}

////////////////////////////////////////////////////////////////////////////////
void usbhost_network_setmac(usbhost_network_t * restrict drv, const uint8_t *mac)
{
    return;
}

////////////////////////////////////////////////////////////////////////////////
void usbhost_network_getmac(usbhost_network_t * restrict drv, uint8_t *mac)
{

    IEEE80211_ADDR_COPY(mac, LLADDR(drv->ifp->if_sadl));

    return;
}

////////////////////////////////////////////////////////////////////////////////
int usbhost_network_ifconfig_setmac(ifconfig_t *ifcfg, const uint8_t *mac)
{
    usbhost_network_t *drv = (usbhost_network_t *)ifcfg->priv;
    return 0;
}

////////////////////////////////////////////////////////////////////////////////
int usbhost_network_ifconfig_getmac(ifconfig_t *ifcfg, uint8_t *mac)
{
    usbhost_network_t *drv = (usbhost_network_t *)ifcfg->priv;

    IEEE80211_ADDR_COPY(mac, LLADDR(drv->ifp->if_sadl));

    return 0;
}

///////////////////////////////////////////////////////////////////////////////
int usbhost_network_ifconfig_ioctl(ifconfig_t *ifcfg, uint32_t cmd, void *data)
{
    struct ifnet* ifp = ((usbhost_network_t *)ifcfg->priv)->ifp;

    if(!ifp) return -1;

    return ifp->if_ioctl(ifp, cmd, data);
}


////////////////////////////////////////////////////////////////////////////////
int usbhost_network_set_ssid(ifconfig_t *ifcfg, const int8_t *ssid)
{
    struct ifreq            myReq;
    struct ieee80211_nwid   nwidReq;
    uint32_t                ssid_len = strlen(ssid);
    usbhost_network_t *drv = (usbhost_network_t *)ifcfg->priv;

    memset(&nwidReq, 0, sizeof(nwidReq));
    memcpy(nwidReq.i_nwid, ssid, ssid_len);
    nwidReq.i_len = (uint8_t)ssid_len;
    memset(&myReq, 0, sizeof(myReq));
    myReq.ifr_ifru.ifru_data = (void *)&nwidReq;
    UHN_DPRINTF(("Setting network SSID to: %s\n", ssid));
    //return ifp->if_ioctl(ifp, SIOCS80211NWID, (void *)&myReq);
    return usbhost_network_ifconfig_ioctl(ifcfg, SIOCS80211NWID, (void *)&myReq);
}

////////////////////////////////////////////////////////////////////////////////
int usbhost_network_get_ssid(ifconfig_t *ifcfg, int8_t **ssid)
{
    int32_t                 retVal;
    struct ifreq            myReq;
    struct ieee80211_nwid   nwidReq;

    memset(&myReq, 0, sizeof(myReq));
    myReq.ifr_ifru.ifru_data = (void *)&nwidReq;

    retVal = usbhost_network_ifconfig_ioctl(ifcfg, SIOCG80211NWID, (void *)&myReq);

    if(!retVal){
        *ssid = strdup((char *)nwidReq.i_nwid);
    }else{
        *ssid = NULL;
    }

    return retVal;
}

///////////////////////////////////////////////////////////////////////////////
int usbhost_network_set_passphrase(ifconfig_t *ifcfg, const int8_t *passphrase)
{
    usbhost_network_t *drv = (usbhost_network_t *)ifcfg->priv;

    if(drv->passphrase){
        free(drv->passphrase);
    }

    if(passphrase){
        drv->passphrase = strdup(passphrase);
    }

    return 0;
}

///////////////////////////////////////////////////////////////////////////////
int usbhost_network_get_passphrase(ifconfig_t *ifcfg, int8_t **passphrase)
{
    usbhost_network_t *drv = (usbhost_network_t *)ifcfg->priv;

    if(drv->passphrase){
        *passphrase = strdup(drv->passphrase);
    }

    return 0;
}

///////////////////////////////////////////////////////////////////////////////
int usbhost_network_set_wep_key(ifconfig_t *ifcfg, const int8_t *key, uint32_t idx)
{

    struct ieee80211_nwkey  nwKeyReq;
    int8_t                  wepKey[32];
    int32_t                 wepKeyLen;

    memset(wepKey, 0, sizeof(wepKey));
    memset(&nwKeyReq, 0, sizeof(nwKeyReq));

    nwKeyReq.i_wepon   = IEEE80211_NWKEY_WEP;
    nwKeyReq.i_defkid  = 1;

    HexStringToByteArray(key, strlen(key), wepKey, &wepKeyLen);

    if((wepKeyLen!=WEPKEY_64_BYTES) && (wepKeyLen!=WEPKEY_128_BYTES)){
        return -1;
    }

    nwKeyReq.i_key[idx].i_keylen = wepKeyLen;
    nwKeyReq.i_key[idx].i_keydat = (uint8_t *)wepKey;

    return usbhost_network_ifconfig_ioctl(ifcfg, SIOCS80211NWKEY, (void *)&nwKeyReq);
}

///////////////////////////////////////////////////////////////////////////////
int usbhost_network_get_wep_key(ifconfig_t *ifcfg, int8_t **key, uint32_t idx)
{
    int32_t retVal;
    struct ieee80211_nwkey  nwKeyReq;
    int8_t                  wepKey[32];

    if (idx > 3) return EINVAL;

    memset(wepKey, 0, sizeof(wepKey));
    memset(&nwKeyReq, 0, sizeof(nwKeyReq));

    nwKeyReq.i_key[idx].i_keydat = (uint8_t *)wepKey;

    retVal = usbhost_network_ifconfig_ioctl(ifcfg, SIOCS80211NWKEY, (void *)&nwKeyReq);

    if(!retVal){
        *key = calloc(1,(nwKeyReq.i_key[idx].i_keylen*2)+4);
        ByteArrayToHexString((int8_t *)nwKeyReq.i_key[idx].i_keydat, nwKeyReq.i_key[idx].i_keylen, *key, NULL);

    }else{
        *key = NULL;
    }

    return retVal;
}

///////////////////////////////////////////////////////////////////////////////
int usbhost_network_set_wpapsk_key(ifconfig_t *ifcfg, const int8_t *key)
{
    int32_t retVal;
    struct ieee80211_wpapsk psk;

    psk.i_enabled = 1;

    retVal = HexStringToByteArray(key, strlen(key), (int8_t *)psk.i_psk, NULL);

    if(!retVal){
        retVal = usbhost_network_ifconfig_ioctl(ifcfg, SIOCS80211WPAPSK, (void *)&psk);
    }

    return retVal;
}

///////////////////////////////////////////////////////////////////////////////
int usbhost_network_get_wpapsk_key(ifconfig_t *ifcfg, int8_t **key)
{
    int32_t retVal;
    struct ieee80211_wpapsk psk;

    retVal = usbhost_network_ifconfig_ioctl(ifcfg, SIOCG80211WPAPSK, (void *)&psk);

    if(!retVal){
        *key = calloc(1,(sizeof(psk.i_psk)*2)+4);
        retVal = ByteArrayToHexString((int8_t *)psk.i_psk, sizeof(psk.i_psk), *key, NULL);
        if(retVal){
            free(*key);
            *key = NULL;
        }
    }

    return retVal;
}

////////////////////////////////////////////////////////////////////////////////
int usbhost_network_config_crypt_wep(ifconfig_t *ifcfg, const int8_t *wepPassPhrase, int32_t default_key)
{
    int32_t                 i,j;
    struct ieee80211_nwkey  nwkey;
    uint8_t                 wepKeys[4][13];

    memset(wepKeys, 0, sizeof(wepKeys));

    nwkey.i_wepon   = IEEE80211_NWKEY_WEP;
    nwkey.i_defkid  = default_key;

    // If a WEP pass phrase is supplied then recalculate keys
    if(wepPassPhrase){
        for(i=0;i<4;i++){
            Generate_WEP40_Key(wepKeys[i], WEPKEY_64_BYTES, (uint8_t *)wepPassPhrase, i);
            nwkey.i_key[i].i_keylen = WEPKEY_64_BYTES;
            nwkey.i_key[i].i_keydat = wepKeys[i];
            UHN_DPRINTF(("WEP Key[%i]:", i));
            for(j=0;j<WEPKEY_64_BYTES;j++){
                UHN_DPRINTF(("%x", wepKeys[i][j]));
            }
            UHN_DPRINTF(("\n"));
        }
    }

    return usbhost_network_ifconfig_ioctl(ifcfg, SIOCS80211NWKEY, (void *)&nwkey);
}

////////////////////////////////////////////////////////////////////////////////
bool usbhost_network_validate_crypt_open(ifconfig_t *ifcfg)
{
    return true;
}

////////////////////////////////////////////////////////////////////////////////
bool usbhost_network_validate_crypt_wep(ifconfig_t *ifcfg)
{
    bool                        valid = true;
    struct ieee80211_nwkey      nwkey;
    uint8_t                     wepKeys[4][13];
    uint64_t                   *p64;

    memset(wepKeys, 0, sizeof(wepKeys));

    nwkey.i_key[0].i_keydat = wepKeys[0];
    nwkey.i_key[1].i_keydat = wepKeys[1];
    nwkey.i_key[2].i_keydat = wepKeys[2];
    nwkey.i_key[3].i_keydat = wepKeys[3];

    usbhost_network_ifconfig_ioctl(ifcfg, SIOCS80211NWKEY, (void *)&nwkey);

    p64 = (uint64_t *)nwkey.i_key[0].i_keydat;
    if(!*p64){
        valid = false;
    }

    return valid;
}

////////////////////////////////////////////////////////////////////////////////
bool usbhost_network_validate_crypt_wpapsk(ifconfig_t *ifcfg)
{
    int32_t                     i;
    bool                        valid = false;
    struct ieee80211_wpapsk     psk;

    memset(&psk, 0, sizeof(psk));

    usbhost_network_ifconfig_ioctl(ifcfg, SIOCG80211WPAPSK, (void *)&psk);

    for(i=0;i<sizeof(psk.i_psk);i++){
        if(psk.i_psk[i]){
            valid = true;
            break;
        }
    }

    return valid;
}

////////////////////////////////////////////////////////////////////////////////
int usbhost_network_config_crypt_wpapsk(ifconfig_t *ifcfg, const int8_t *passphrase, const int8_t *ssid)
{
    int i;
    int retVal = 0;

    struct ieee80211_wpapsk     psk;
    struct ieee80211_wpaparams  wpaparams;

    // Generate the key from the passphrase... this is going to take a while
    memset(&psk, 0, sizeof(psk));

    if(passphrase && ssid){
        psk.i_enabled = 1;

        UHN_DPRINTF(("Generating network key - [START]\n"));
        pkcs5_pbkdf2(passphrase, strlen(passphrase), (const char *)ssid, strlen((char *)ssid), psk.i_psk, sizeof(psk.i_psk), 4096);
        UHN_DPRINTF(("Generating network key - [END]\n"));

        UHN_DPRINTF(("NWKEY: 0x"));
        for(i=0;i<32;i++){
            UHN_DPRINTF(("%02x", psk.i_psk[i]));
        }
        UHN_DPRINTF(("\n"));

        if((retVal = usbhost_network_ifconfig_ioctl(ifcfg, SIOCS80211WPAPSK, (void *)&psk))!=0){
            return retVal;
        }
    }

    // Enable support for everything
    memset(&wpaparams, 0, sizeof(wpaparams));

    wpaparams.i_enabled     = 1;
    wpaparams.i_protos      = IEEE80211_WPA_PROTO_WPA1  | IEEE80211_WPA_PROTO_WPA2;
    wpaparams.i_akms        = IEEE80211_WPA_AKM_PSK     | IEEE80211_WPA_AKM_SHA256_PSK | IEEE80211_WPA_AKM_8021X | IEEE80211_WPA_AKM_SHA256_8021X;
    wpaparams.i_ciphers     = IEEE80211_WPA_CIPHER_TKIP | IEEE80211_WPA_CIPHER_CCMP;
    wpaparams.i_groupcipher = IEEE80211_WPA_CIPHER_TKIP;

    return usbhost_network_ifconfig_ioctl(ifcfg, SIOCS80211WPAPARMS, (void *)&wpaparams);
}

///////////////////////////////////////////////////////////////////////////////
int usbhost_network_set_crypt(ifconfig_t *ifcfg, uint32_t crypt, uint32_t genKeys)
{
    int32_t                     retVal;
    struct ieee80211_nwkey      nwkey;
    struct ieee80211_wpaparams  wpaparams;
    uint8_t                     wepKeys[4][13];

    int8_t                     *ssid = NULL;
    int8_t                     *passphrase = NULL;

    if(genKeys){
        usbhost_network_get_ssid(ifcfg, &ssid);
        usbhost_network_get_passphrase(ifcfg, &passphrase);
        if(!ssid || !passphrase) return -1;
    }

    switch(crypt){
    case IFCONFIG_IEEE80211_CRYPT_OPEN:
        break;
    case IFCONFIG_IEEE80211_CRYPT_WEP:
        usbhost_network_config_crypt_wep(ifcfg, passphrase, 1);
        break;
    case IFCONFIG_IEEE80211_CRYPT_WPAPSK:
        usbhost_network_config_crypt_wpapsk(ifcfg, passphrase, ssid);
        break;
    default:
        return -1;
    }

    if(genKeys){
        free(ssid);
        free(passphrase);
    }

    // WEP config
    nwkey.i_key[0].i_keydat = wepKeys[0];
    nwkey.i_key[1].i_keydat = wepKeys[1];
    nwkey.i_key[2].i_keydat = wepKeys[2];
    nwkey.i_key[3].i_keydat = wepKeys[3];
    usbhost_network_ifconfig_ioctl(ifcfg, SIOCS80211NWKEY, (void *)&nwkey);
    // WPA config
    usbhost_network_ifconfig_ioctl(ifcfg, SIOCG80211WPAPARMS, (void *)&wpaparams);

    switch(crypt){
    case IFCONFIG_IEEE80211_CRYPT_OPEN:
        nwkey.i_wepon           = 0;
        wpaparams.i_enabled     = 0;
        break;
    case IFCONFIG_IEEE80211_CRYPT_WEP:
        nwkey.i_wepon           = 1;
        wpaparams.i_enabled     = 0;
        break;
    case IFCONFIG_IEEE80211_CRYPT_WPAPSK:
        nwkey.i_wepon           = 0;
        wpaparams.i_enabled     = 1;
        break;
    default:
        return -1;
    }

    retVal = usbhost_network_ifconfig_ioctl(ifcfg, SIOCS80211NWKEY, (void *)&nwkey);

    if(!retVal){
        retVal = usbhost_network_ifconfig_ioctl(ifcfg, SIOCS80211WPAPARMS, (void *)&wpaparams);
    }

    return retVal;
}

///////////////////////////////////////////////////////////////////////////////
int usbhost_network_get_crypt(ifconfig_t *ifcfg, uint32_t *crypt)
{
    int32_t                     retVal;
    struct ieee80211_nwkey      nwkey;
    struct ieee80211_wpaparams  wpaparams;

    retVal = usbhost_network_ifconfig_ioctl(ifcfg, SIOCG80211NWKEY, (void *)&nwkey);

    if(!retVal){
        retVal = usbhost_network_ifconfig_ioctl(ifcfg, SIOCG80211WPAPARMS, (void *)&wpaparams);
    }else{
        *crypt = -1;
        return -1;
    }

    if(wpaparams.i_enabled){
        *crypt = IFCONFIG_IEEE80211_CRYPT_WPAPSK;
    } else if(nwkey.i_wepon){
        *crypt = IFCONFIG_IEEE80211_CRYPT_WEP;
    } else {
        *crypt = IFCONFIG_IEEE80211_CRYPT_OPEN;
    }

    return 0;
}

////////////////////////////////////////////////////////////////////////////////
int usbhost_network_get_channel(ifconfig_t *ifcfg, int32_t *chan)
{
    int32_t retVal;
    struct ieee80211chanreq chanReq;

    retVal = usbhost_network_ifconfig_ioctl(ifcfg, SIOCG80211CHANNEL, (void *)&chanReq);
    *chan = chanReq.i_channel;

    return retVal;
}

////////////////////////////////////////////////////////////////////////////////
int usbhost_network_set_channel(ifconfig_t *ifcfg, int32_t chan)
{
    struct ieee80211chanreq chanReq;
    chanReq.i_channel = (uint16_t)chan;

    return usbhost_network_ifconfig_ioctl(ifcfg, SIOCS80211CHANNEL, (void *)&chanReq);
}

////////////////////////////////////////////////////////////////////////////////
int usbhost_network_phy_get_state(ifconfig_t *ifcfg, uint32_t *state)
{
    usbhost_network_t *inst = (usbhost_network_t *)ifcfg->priv;

    if(is_configured_if(inst)){
        *state = IFCONFIG_PHY_S_AVAILABLE;
    } else{
        *state = 0;
    }

    return 0;
}

////////////////////////////////////////////////////////////////////////////////
int usbhost_network_link_get_state(ifconfig_t *ifcfg, uint32_t *state)
{
    struct ifnet* ifp = ((usbhost_network_t *)ifcfg->priv)->ifp;

    if(ifp){
        switch(ifp->if_data.ifi_link_state){
            case LINK_STATE_UNKNOWN:
            case LINK_STATE_DOWN:
                *state = IFCONFIG_LINK_S_DOWN;
                break;
            case LINK_STATE_UP:
            case LINK_STATE_HALF_DUPLEX:
            case LINK_STATE_FULL_DUPLEX:
            default:
                *state = IFCONFIG_LINK_S_UP;
        }
    } else {
        *state = LINK_STATE_UNKNOWN;
    }

    return 0;
}

////////////////////////////////////////////////////////////////////////////////
int usbhost_network_driver_link_get_state(usbhost_network_t *drv, uint32_t *state)
{
    assert(drv);
    assert(state);

    return usbhost_network_link_get_state(&drv->ifconfig, state);
}

////////////////////////////////////////////////////////////////////////////////
void usbhost_network_link_state_callback(void *arg)
{
    usbhost_network_t *drv = arg;
    uint32_t link_state = IFCONFIG_LINK_S_DOWN;
    assert(drv);

    usbhost_network_driver_link_get_state(drv, &link_state);

    ifconfig_link_state_callback(&drv->ifconfig, link_state);

}

////////////////////////////////////////////////////////////////////////////////
int usbhost_network_link_start(ifconfig_t *ifcfg)
{
    uint32_t crypt;

    struct ifnet *ifp = ((usbhost_network_t *)ifcfg->priv)->ifp;

    UHN_DPRINTF(("Attempting to bring up the link layer...\n"));

    if(ifp && ifp->if_init){
        if(usbhost_network_get_crypt(ifcfg, &crypt)!=0){
            return -1;
        }
        switch(crypt){
        case IFCONFIG_IEEE80211_CRYPT_OPEN:
            if(!usbhost_network_validate_crypt_open(ifcfg)){
                ifconfig_ieee80211_set_crypt(ifcfg, IFCONFIG_IEEE80211_CRYPT_OPEN, true);
            }
            break;
        case IFCONFIG_IEEE80211_CRYPT_WEP:
            if(!usbhost_network_validate_crypt_wep(ifcfg)){
                ifconfig_ieee80211_set_crypt(ifcfg, IFCONFIG_IEEE80211_CRYPT_WEP, true);
            }
            break;
        case IFCONFIG_IEEE80211_CRYPT_WPAPSK:
            if(!usbhost_network_validate_crypt_wpapsk(ifcfg)){
                ifconfig_ieee80211_set_crypt(ifcfg, IFCONFIG_IEEE80211_CRYPT_WPAPSK, true);
            }
            break;
        default:
            return -1;
        }
        return ifp->if_init(ifp);
    }
    return -1;
}

////////////////////////////////////////////////////////////////////////////////
int usbhost_network_link_stop(ifconfig_t *ifcfg)
{
    struct ifnet *ifp = ((usbhost_network_t *)ifcfg->priv)->ifp;
    if(ifp && ifp->if_stop){
        return ifp->if_stop(ifp, 0 /*disable*/);
    }
    return -1;
}

////////////////////////////////////////////////////////////////////////////////
int usbhost_network_config(usbhost_network_t *drv)
{
    const usbhost_network_cfg_instance_t *drv_cfg = &usbhost_network_instance_table[drv->instanceId];

    if(!drv->ifp) return -1;

    if(drv_cfg->if_mac_type == USBHOST_NETWORK_IF_MAC_TYPE_CUSTOM){
        // Set device MAC
        UHN_DPRINTF(("Custom device MAC Address not implimented yet!\n"));
    }

    if(drv_cfg->nw_ssid_type == USBHOST_NETWORK_NW_SSID_TYPE_CUSTOM){
        // Set SSID
        if(usbhost_network_set_ssid(&drv->ifconfig, drv_cfg->nw_ssid)!=0){
            UHN_DPRINTF(("Error setting SSID!\n"));
        }
        if(usbhost_network_set_passphrase(&drv->ifconfig, drv_cfg->nw_passphrase)!=0){
            UHN_DPRINTF(("Error setting pass phrase!\n"));
        }
        UHN_DPRINTF(("SSID set to: %s\n", drv_cfg->nw_ssid));
        UHN_DPRINTF(("PassPhrase set to: %s\n", drv_cfg->nw_passphrase));
    }


    if(drv_cfg->nw_auth_type == USBHOST_NETWORK_NW_AUTH_TYPE_WEP){
        // Enable WEP
        ifconfig_ieee80211_set_crypt(&drv->ifconfig, IFCONFIG_IEEE80211_CRYPT_WEP, false);
    } else if(drv_cfg->nw_auth_type == USBHOST_NETWORK_NW_AUTH_TYPE_WPA_PSK){
        // Enable WPA-PSK
        ifconfig_ieee80211_set_crypt(&drv->ifconfig, IFCONFIG_IEEE80211_CRYPT_WPAPSK, false);
    } else {
        UHN_DPRINTF(("Security: Open Network\n"));
        ifconfig_ieee80211_set_crypt(&drv->ifconfig, IFCONFIG_IEEE80211_CRYPT_OPEN, false);
    }

    if(drv_cfg->autostart){
        // We now attempt to bring up the wireless link.. this may take a while
        ifconfig_link_start(&drv->ifconfig);
    }

    return 0;
}

////////////////////////////////////////////////////////////////////////////////
static ifconfig_80211_t  usbhost_network_80211_ifconfig = { NULL ,                          // get_state
                                                            usbhost_network_set_ssid,       // set_ssid
                                                            usbhost_network_get_ssid,       // get_ssid
                                                            usbhost_network_set_channel,    // set_channel
                                                            usbhost_network_get_channel,    // get_channel
                                                            usbhost_network_set_passphrase, // set_passphrase
                                                            usbhost_network_get_passphrase, // get_passphrase
                                                            usbhost_network_set_wep_key,    // set_wep_key
                                                            usbhost_network_get_wep_key,    // get_wep_key
                                                            usbhost_network_set_wpapsk_key, // set_wpapsk_key
                                                            usbhost_network_get_wpapsk_key, // get_wpapsk_key
                                                            usbhost_network_set_crypt,      // set_crypt
                                                            usbhost_network_get_crypt       // get_crypt
                                                          };

////////////////////////////////////////////////////////////////////////////////
static ifconfig_phy_t   usbhost_network_phy_ifconfig =  {   usbhost_network_phy_get_state,     // get_state
                                                            usbhost_network_ifconfig_setmac,   // set_mac
                                                            usbhost_network_ifconfig_getmac    // get_mac
                                                        };

////////////////////////////////////////////////////////////////////////////////
static ifconfig_link_t   usbhost_network_link_ifconfig =  { usbhost_network_link_get_state, // get_state
                                                            usbhost_network_link_start,     // start
                                                            usbhost_network_link_stop,      // stop
                                                            NULL,                           // state_callback
                                                            NULL                            // state_callback_context
                                                         };

////////////////////////////////////////////////////////////////////////////////
static struct ifnet *usbhost_network_get_interface(void)
{
    struct ifnet *ifp;
    uint32_t i;
    uint32_t found=0;

    TAILQ_FOREACH(ifp, &ifnet, if_list) {
        for(found=i=0;i<USBHOST_NETWORK_INSTANCE_COUNT;i++){
            if(usbNetworkInstance[i].ifp == ifp ){
                found++;
                break;
            }
        }
        if(!found){
            UHN_DPRINTF(("Found free interface: %s\n", ifp->if_xname));
            return ifp;
        }
    }
    return (NULL);
}

////////////////////////////////////////////////////////////////////////////////
int usbhost_network_set_defaults(usbhost_network_t *drv)
{
    const usbhost_network_cfg_instance_t *drv_cfg = &usbhost_network_instance_table[drv->instanceId];

    if(drv->passphrase){
        free(drv->passphrase);
    }

    if(drv_cfg->nw_passphrase){
        drv->passphrase = strdup(drv_cfg->nw_passphrase);
    }

    return 0;
}

////////////////////////////////////////////////////////////////////////////////
ifconfig_t *usbhost_network_ifconfig(int id)
{
    // Check if already configured
    if((!is_configured_if(&usbNetworkInstance[id]))){
        usbhost_network_open(id);
    }

    // No phy for this interface :(
    if(!usbNetworkInstance[id].ifp) return NULL;

    return &usbNetworkInstance[id].ifconfig;
}

////////////////////////////////////////////////////////////////////////////////
extern void *usbhost_network_get_ifconfig(void *inst)
{
    usbhost_network_t *drv = inst;

    if(drv && drv->ifp){
        return &drv->ifconfig;
    }

    return NULL;
}

////////////////////////////////////////////////////////////////////////////////
usbhost_network_t *usbhost_network_open(int id)
{
    assert((id >= 0) && (id < USBHOST_NETWORK_INSTANCE_COUNT));

    // Check if already configured
    if(is_configured_if(&usbNetworkInstance[id])){
        return &usbNetworkInstance[id];
    }

    memset(&usbNetworkInstance[id], 0, sizeof(usbNetworkInstance[0]));

    usbNetworkInstance[id].ident = USBHOST_IDENT;

    // ifconfig interface
    usbNetworkInstance[id].get_ifconfig = usbhost_network_get_ifconfig;

    // Init ifconfig interface
    usbNetworkInstance[id].ifconfig.priv        = &usbNetworkInstance[id];
    usbNetworkInstance[id].ifconfig.ioctl       = usbhost_network_ifconfig_ioctl;

    usbNetworkInstance[id].ifconfig.if_80211    = &usbhost_network_80211_ifconfig;
    usbNetworkInstance[id].ifconfig.if_phy      = &usbhost_network_phy_ifconfig;
    usbNetworkInstance[id].ifconfig.if_link     = &usbhost_network_link_ifconfig;


    // Grab an interface
    usbNetworkInstance[id].ifp = usbhost_network_get_interface();
    usbNetworkInstance[id].instanceId = id;

    if(!usbNetworkInstance[id].ifp){
        //UHN_DPRINTF(("Could not find interface driver!\n"));
        return NULL;
    }

    // register interface status callback
    hook_establish(usbNetworkInstance[id].ifp->if_linkstatehooks, 0, usbhost_network_link_state_callback, &usbNetworkInstance[id]);

    // Set Initial Configuration and optionally start the interface
    usbhost_network_set_defaults(&usbNetworkInstance[id]);
    usbhost_network_config(&usbNetworkInstance[id]);

    return &usbNetworkInstance[id];
}

////////////////////////////////////////////////////////////////////////////////
bool usbhost_network_connect_test(void *devicedrv, usbhost_device_t *usbdevice)
{
    // Use the OpenBSD USB probe function and register driver if found
    if(usbd_probe_and_attach(NULL, usbdevice, usbdevice->parentport, usbdevice->devNum) != 0) return false;
    // Check that our driver was actually registered
    return true;
}

/* Flags given to config_detach(), and the ca_detach function. */
#define DETACH_FORCE    0x01        /* force detachment; hardware gone */
#define DETACH_QUIET    0x02        /* don't print a notice */

////////////////////////////////////////////////////////////////////////////////
void usbhost_network_disconnect(void *devicedrv, usbhost_device_t *usbdevice)
{
    // BL[FIXME] - This needs locking
    usbhost_network_t *inst = devicedrv;
    if(inst && inst->ifp){
        UHN_DPRINTF(("usbhost_network_disconnect(): %s\n", inst->ifp->if_xname));
        config_detach((struct device *)inst->ifp, DETACH_FORCE);
        inst->ifp = NULL;
    }

    return;
}

////////////////////////////////////////////////////////////////////////////////
static void usbhost_network_plugin_init_code(void)
{
    int i;
    usbhost_t *usbhost;

    for(i=0; i<USBHOST_NETWORK_INSTANCE_COUNT; i++){
        const usbhost_network_cfg_instance_t *restrict drv_cfg = &usbhost_network_instance_table[i];

        usbhost = usbhost_open(drv_cfg->usbhost);

        usbhost_registerdevicedriver(usbhost, &usbNetworkInstance[i], &usbhost_network_connect_test, &usbhost_network_disconnect);
    }
}

#if __POSIX_KERNEL__
////////////////////////////////////////////////////////////////////////////////
void *usbhost_network_plugin_init_thread(void *data)
{
    usbhost_network_plugin_init_code();
    return NULL;
}

////////////////////////////////////////////////////////////////////////////////
void usbhost_network_plugin_create_init_thread(void)
{
    pthread_t id;
    pthread_attr_t attr;
    struct sched_param sched_param;

    sched_param.sched_priority = POSIX_THREADS_MAIN_PRIORITY + 1;
    pthread_attr_init(&attr);
    pthread_attr_setschedparam(&attr, &sched_param);
    pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
    pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
    pthread_create(&id, &attr, usbhost_network_plugin_init_thread, NULL);

}

////////////////////////////////////////////////////////////////////////////////
extern void usbhost_network_plugin_init( void )
{
    posix_mainhook_install(usbhost_network_plugin_create_init_thread, 1);
    return;
}
#else
////////////////////////////////////////////////////////////////////////////////
extern void usbhost_network_plugin_init( void )
{
    usbhost_network_plugin_init_code();
}
#endif




























