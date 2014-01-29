////////////////////////////////////////////////////////////////////////////////
// swp_ifconfig.h

#ifndef __SWP_IFCONFIG_H
#define __SWP_IFCONFIG_H

#include <assert.h>
#include <stdint.h>

#ifdef  __cplusplus
extern "C" {
#endif

struct _ifconfig_t;

#define IFCONFIG_SIGNATURE  0x42454E4C

///////////////////////////////////////////////////////////////////////////////
#define IFCONFIG_IEEE80211_CRYPT_OPEN       0
#define IFCONFIG_IEEE80211_CRYPT_WEP        1
#define IFCONFIG_IEEE80211_CRYPT_WPAPSK     2

///////////////////////////////////////////////////////////////////////////////
#define IFCONFIG_IEEE80211_S_INIT  (1<<0)    // default state
#define IFCONFIG_IEEE80211_S_SCAN  (1<<1)    // scanning
#define IFCONFIG_IEEE80211_S_AUTH  (1<<2)    // try to authenticate
#define IFCONFIG_IEEE80211_S_ASSOC (1<<3)    // try to assoc
#define IFCONFIG_IEEE80211_S_RUN   (1<<4)    // associated

///////////////////////////////////////////////////////////////////////////////
typedef struct _ifconfig_80211_t {
    int (*get_state)        (struct _ifconfig_t *,       uint32_t *state                            );
    int (*set_ssid)         (struct _ifconfig_t *, const int8_t   *ssid                             );
    int (*get_ssid)         (struct _ifconfig_t *,       int8_t   **ssid                            );
    int (*set_channel)      (struct _ifconfig_t *,       int32_t   chan                             );
    int (*get_channel)      (struct _ifconfig_t *,       int32_t  *chan                             );
    int (*set_passphrase)   (struct _ifconfig_t *, const int8_t   *passphrase                       );
    int (*get_passphrase)   (struct _ifconfig_t *,       int8_t   **passphrase                      );
    int (*set_wep_key)      (struct _ifconfig_t *, const int8_t   *key, uint32_t idx                );
    int (*get_wep_key)      (struct _ifconfig_t *,       int8_t   **key, uint32_t idx               );
    int (*set_wpapsk_key)   (struct _ifconfig_t *, const int8_t   *key                              );
    int (*get_wpapsk_key)   (struct _ifconfig_t *,       int8_t   **key                             );
    int (*set_crypt)        (struct _ifconfig_t *,       uint32_t  crypt, uint32_t genKeys          );
    int (*get_crypt)        (struct _ifconfig_t *,       uint32_t *crypt                            );

}ifconfig_80211_t;

///////////////////////////////////////////////////////////////////////////////
#define IFCONFIG_PHY_S_AVAILABLE    (1<<0)

///////////////////////////////////////////////////////////////////////////////
typedef struct _ifconfig_phy_t {
    int (*get_state)    (struct _ifconfig_t *, uint32_t *state);
    int (*set_mac)      (struct _ifconfig_t *, const uint8_t *mac);
    int (*get_mac)      (struct _ifconfig_t *, uint8_t *mac);
}ifconfig_phy_t;

///////////////////////////////////////////////////////////////////////////////
#define IFCONFIG_S_UNKNOWN           (0<<0) // common invalid/unknown state
#define IFCONFIG_LINK_S_DOWN         (1<<0) // link is down
#define IFCONFIG_LINK_S_UP           (1<<1) // link is up

///////////////////////////////////////////////////////////////////////////////
typedef struct _ifconfig_link_t {
    int (*get_state)(struct _ifconfig_t *, uint32_t *);
    int (*start)    (struct _ifconfig_t *);
    int (*stop)     (struct _ifconfig_t *);

    void (*state_callback)(void *, uint32_t);
    void *state_callback_context;

}ifconfig_link_t;

///////////////////////////////////////////////////////////////////////////////
typedef struct _ifconfig_t {
    void *priv;
    int (*ioctl)(struct _ifconfig_t *, uint32_t, void *);

    ifconfig_phy_t      *if_phy;
    ifconfig_link_t     *if_link;
    ifconfig_80211_t    *if_80211;
}ifconfig_t;

////////////////////////////////////////////////////////////////////////////////
typedef struct _ifconfig_stub_t {
    uint32_t    signature;
    void      * (*get_ifconfig)(void *);
}ifconfig_stub_t;


///////////////////////////////////////////////////////////////////////////////
extern void *ifconfig_get_interface(void *);

extern int ifconfig_ioctl                       (ifconfig_t *, uint32_t, void *);

extern int ifconfig_link_get_state              (ifconfig_t *, uint32_t *);
extern int ifconfig_link_start                  (ifconfig_t *);
extern int ifconfig_link_stop                   (ifconfig_t *);

extern int ifconfig_link_state_callback         (ifconfig_t *, uint32_t state);
extern int ifconfig_link_set_state_callback     (ifconfig_t *, void (*state_callback)(void *, uint32_t), void *state_callback_context);


extern int ifconfig_phy_get_state               (ifconfig_t *, uint32_t *);
extern int ifconfig_phy_set_mac                 (ifconfig_t *, const void *);
extern int ifconfig_phy_get_mac                 (ifconfig_t *, void *);

extern int ifconfig_ieee80211_get_state         (ifconfig_t *, uint32_t *);

extern int ifconfig_ieee80211_set_ssid          (ifconfig_t *, const int8_t *ssid);
extern int ifconfig_ieee80211_get_ssid          (ifconfig_t *, int8_t **ssid);

extern int ifconfig_ieee80211_set_channel       (ifconfig_t *, int32_t chan);
extern int ifconfig_ieee80211_get_channel       (ifconfig_t *, int32_t *chan);

extern int ifconfig_ieee80211_set_passphrase    (ifconfig_t *, const int8_t *passphrase);
extern int ifconfig_ieee80211_get_passphrase    (ifconfig_t *, int8_t **passphrase);

extern int ifconfig_ieee80211_set_wep_key       (ifconfig_t *, const int8_t *key, uint32_t idx);
extern int ifconfig_ieee80211_get_wep_key       (ifconfig_t *, int8_t **key, uint32_t idx);

extern int ifconfig_ieee80211_set_wpapsk_key    (ifconfig_t *, const int8_t *key);
extern int ifconfig_ieee80211_get_wpapsk_key    (ifconfig_t *, int8_t **key);

extern int ifconfig_ieee80211_set_crypt         (ifconfig_t *, uint32_t  crypt, uint32_t genKeys);
extern int ifconfig_ieee80211_get_crypt         (ifconfig_t *, uint32_t *crypt);

#ifdef  __cplusplus
}
#endif

#endif // __SWP_IFCONFIG_H
