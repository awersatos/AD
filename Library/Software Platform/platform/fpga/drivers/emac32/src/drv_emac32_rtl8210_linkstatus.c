#include "drv_emac32.h"
#include "drv_emac32_internal.h"

uint8_t rtl8201_linkstatus(emac32_t * restrict drv)
{
    uint8_t status = 0;
    uint16_t reg;

    reg = emac32_read_md(drv, 0);
    if (reg & RTL8201_SPD_SET)              status  = PHY_LINK_100MB;
    if (reg & RTL8201_DUPLEX_MODE)          status |= PHY_FULL_DUPLEX;
    reg = emac32_read_md(drv, 1);
    if (reg & RTL8201_AUTO_NEG_COMPLETE)    status |= PHY_AUTO_NEG_COMPLETE;
    if (reg & RTL8201_LINK_STATUS)          status |= PHY_VALID_LINK;
    if (reg & RTL8201_JABBER_DETECT)        status |= PHY_JABBER;

    return status;
}
