////////////////////////////////////////////////////////////////////////////////
// grey.c

#include <sys/bsdtypes.h>



int rn_refines(void *m_arg, void *n_arg)
{
    return 0;
}

int rtinit(struct ifaddr *ifa, int cmd, int flags)
{
    return 0;
}

void arp_ifinit(void *a, void *b)
{
}

void rtlabel_unref(u_int16_t id)
{
}

u_int32_t arc4random(void)
{
    return rand();
}

int copyout(const void *kaddr, void *udaddr, size_t len)
{
    memcpy(udaddr, kaddr, len);

    return 0;
}

//u_int32_t ether_crc32_le_update(u_int32_t crc, const u_int8_t *buf, size_t len)
//{
//    return 0;
//}

/*
 * Ethernet CRC32 polynomials (big- and little-endian verions).
 */
#define ETHER_CRC_POLY_LE       0xedb88320
#define ETHER_CRC_POLY_BE       0x04c11db6


uint32_t ether_crc32_le_update(uint32_t crc, const uint8_t *buf, size_t len)
{
        uint32_t c, carry;
        size_t i, j;

        for (i = 0; i < len; i++) {
                c = buf[i];
                for (j = 0; j < 8; j++) {
                        carry = ((crc & 0x01) ? 1 : 0) ^ (c & 0x01);
                        crc >>= 1;
                        c >>= 1;
                        if (carry)
                                crc = (crc ^ ETHER_CRC_POLY_LE);
                }
        }

        return (crc);
}

uint32_t ether_crc32_be_update(uint32_t crc, const uint8_t *buf, size_t len)
{
        uint32_t c, carry;
        size_t i, j;

        for (i = 0; i < len; i++) {
                c = buf[i];
                for (j = 0; j < 8; j++) {
                        carry = ((crc & 0x80000000U) ? 1 : 0) ^ (c & 0x01);
                        crc <<= 1;
                        c >>= 1;
                        if (carry)
                                crc = (crc ^ ETHER_CRC_POLY_BE) | carry;
                }
        }

        return (crc);
}


void ifafree(void *ifa)
{
}

void rt_ifannouncemsg(struct ifnet *ifp, int what)
{
}

int rtable_exists(u_int id)
{
    return 1;
}

int sysctl_int(void *oldp, size_t *oldlenp, void *newp, size_t newlen, int *valp)
{
    return 0;
}

void * rt_lookup(struct sockaddr *dst, struct sockaddr *mask, u_int tableid)
{
    return NULL;
}

int ether_ioctl(struct ifnet *ifp, struct arpcom *arp, u_long cmd, caddr_t data)
{
    return 0;
}

void rt_ifmsg(struct ifnet *ifp)
{
}

const char *rtlabel_id2name(u_int16_t id)
{
    return "FIXME";
}

////////////////////////////////////////////////////////////////////////////////
 /*
  * "Shutdown/startup hook" types, functions, and variables.
  */

 struct hook_desc_head startuphook_list =
     TAILQ_HEAD_INITIALIZER(startuphook_list);
 struct hook_desc_head shutdownhook_list =
     TAILQ_HEAD_INITIALIZER(shutdownhook_list);
 struct hook_desc_head mountroothook_list =
     TAILQ_HEAD_INITIALIZER(mountroothook_list);

 ///////////////////////////////////////////////////////////////////////////////
 void *hook_establish(struct hook_desc_head *head, int tail, void (*fn)(void *), void *arg)
 {
         struct hook_desc *hdp;

         //hdp = (struct hook_desc *)malloc(sizeof (*hdp), M_DEVBUF, M_NOWAIT);
         hdp = (struct hook_desc *)malloc(sizeof (*hdp));
         if (hdp == NULL)
                 return (NULL);

         hdp->hd_fn = fn;
         hdp->hd_arg = arg;
         if (tail)
                 TAILQ_INSERT_TAIL(head, hdp, hd_list);
         else
                 TAILQ_INSERT_HEAD(head, hdp, hd_list);

         return (hdp);
 }

 ///////////////////////////////////////////////////////////////////////////////
 void hook_disestablish(struct hook_desc_head *head, void *vhook)
 {
         struct hook_desc *hdp;

 #ifdef DIAGNOSTIC
         for (hdp = TAILQ_FIRST(head); hdp != NULL;
             hdp = TAILQ_NEXT(hdp, hd_list))
                 if (hdp == vhook)
                         break;
         if (hdp == NULL)
                 return;
 #endif
         hdp = vhook;
         TAILQ_REMOVE(head, hdp, hd_list);
         //free(hdp, M_DEVBUF);
         free(hdp);
 }

////////////////////////////////////////////////////////////////////////////////
void dohooks(struct hook_desc_head *head, int flags)
{
    struct hook_desc *hdp;

    if ((flags & HOOK_REMOVE) == 0) {
            TAILQ_FOREACH(hdp, head, hd_list) {
                    (*hdp->hd_fn)(hdp->hd_arg);
            }
    } else {
            while ((hdp = TAILQ_FIRST(head)) != NULL) {
                    TAILQ_REMOVE(head, hdp, hd_list);
                    (*hdp->hd_fn)(hdp->hd_arg);
                    if ((flags & HOOK_FREE) != 0)
                            //free(hdp, M_DEVBUF);
                            free(hdp);
            }
    }
}


void microtime(struct timeval *tv)
{
}

#define sintosa(x) 0

int copyoutstr(const void *kaddr, void *udaddr, size_t len, size_t *done)
{
    strncpy(udaddr, kaddr, len);
    *done = strlen(udaddr)+1;
    return 0;
}

int copyinstr(const void *udaddr, void *kaddr, size_t len, size_t *done)
{
    strncpy(kaddr, udaddr, len);
    *done = strlen(udaddr)+1;
    return 0;
}

int copyin(const void *uaddr, void *kaddr, size_t len)
{
    memcpy(kaddr, uaddr, len);
    return 0;
}


int sysctl_rdint(void *oldp, size_t *oldlenp, void *newp, int val)
{
    return 0;
}


int ether_delmulti(struct ifreq * ifr, struct arpcom *ac)
{
    return 0;
}

/*
 * bcmp -- vax cmpc3 instruction
 */
int
bcmp(b1, b2, length)
    const void *b1, *b2;
    register size_t length;
{
    register char *p1, *p2;

    if (length == 0)
        return(0);
    p1 = (char *)b1;
    p2 = (char *)b2;
    do
        if (*p1++ != *p2++)
            break;
    while (--length);
    return(length);
}

/*
 * Copy src to string dst of size siz.  At most siz-1 characters
 * will be copied.  Always NUL terminates (unless siz == 0).
 * Returns strlen(src); if retval >= siz, truncation occurred.
 */
size_t
strlcpy(char *dst, const char *src, size_t siz)
{
    char *d = dst;
    const char *s = src;
    size_t n = siz;

    /* Copy as many bytes as will fit */
    if (n != 0) {
        while (--n != 0) {
            if ((*d++ = *s++) == '\0')
                break;
        }
    }

    /* Not enough room in dst, add NUL and traverse rest of src */
    if (n == 0) {
        if (siz != 0)
            *d = '\0';      /* NUL-terminate dst */
        while (*s++)
            ;
    }

    return(s - src - 1);    /* count does not include NUL */
}

/*
 * Fill a buffer of arbitrary length with RC4-derived randomness.
 */
void arc4random_buf(void *buf, size_t n)
{
    uint8_t *p = buf;
    do{
        *p++ = (uint8_t)rand();
    }while(--n);
}

void rt_if_remove(struct ifnet *ifp)
{
}

/*
 * Add an Ethernet multicast address or range of addresses to the list for a
 * given interface.
 */
int ether_addmulti(struct ifreq *ifr, struct arpcom *ac)
{
    return 0;
}

int rtable_add(u_int id)
{
    return 0;
}

u_int16_t rtlabel_name2id(char *name)
{
    return 0;
}

void if_attachdomain1(struct ifnet *ifp)
{
}

int ether_output(struct ifnet *ifp0, struct mbuf *m0, struct sockaddr *dst, struct rtentry *rt0)
{
    return 0;
}

void device_register(struct device *dev, void *aux)
{
}

u_int32_t random(void)
{
    return rand();
}


































