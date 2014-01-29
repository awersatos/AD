#include <sys/bsdtypes.h>
#include <net/if.h>
#include <net/if_arp.h>
#include <netinet/if_ether.h>
#include <net/if_types.h>
#include <sys/mbuf.h>
#include <net/if_llc.h>


// Convert Ethernet address to printable (loggable) representation.
static char digits[] = "0123456789abcdef";
char *
ether_sprintf(ap)
    u_char *ap;
{
    int i;
    static char etherbuf[ETHER_ADDR_LEN * 3];
    char *cp = etherbuf;

    for (i = 0; i < ETHER_ADDR_LEN; i++) {
        *cp++ = digits[*ap >> 4];
        *cp++ = digits[*ap++ & 0xf];
        *cp++ = ':';
    }
    *--cp = 0;
    return (etherbuf);
}

/*
 * Perform common duties while attaching to interface list
 */
void
ether_ifattach(ifp)
    struct ifnet *ifp;
{

    /*
     * Any interface which provides a MAC address which is obviously
     * invalid gets whacked, so that users will notice.
     */
    if (ETHER_IS_MULTICAST(((struct arpcom *)ifp)->ac_enaddr)) {
        ((struct arpcom *)ifp)->ac_enaddr[0] = 0x00;
        ((struct arpcom *)ifp)->ac_enaddr[1] = 0xfe;
        ((struct arpcom *)ifp)->ac_enaddr[2] = 0xe1;
        ((struct arpcom *)ifp)->ac_enaddr[3] = 0xba;
        ((struct arpcom *)ifp)->ac_enaddr[4] = 0xd0;
        /*
         * XXX use of random() by anything except the scheduler is
         * normally invalid, but this is boot time, so pre-scheduler,
         * and the random subsystem is not alive yet
         */
        ((struct arpcom *)ifp)->ac_enaddr[5] = (u_char)random() & 0xff;
    }

    ifp->if_type = IFT_ETHER;
    ifp->if_addrlen = ETHER_ADDR_LEN;
    ifp->if_hdrlen = ETHER_HDR_LEN;
    ifp->if_mtu = ETHERMTU;
    ifp->if_output = ether_output;

    if (ifp->if_hardmtu == 0)
        ifp->if_hardmtu = ETHERMTU;

    if_alloc_sadl(ifp);
    bcopy((caddr_t)((struct arpcom *)ifp)->ac_enaddr, LLADDR(ifp->if_sadl), ifp->if_addrlen);
    LIST_INIT(&((struct arpcom *)ifp)->ac_multiaddrs);
#if NBPFILTER > 0
    bpfattach(&ifp->if_bpf, ifp, DLT_EN10MB, ETHER_HDR_LEN);
#endif
}

void
ether_ifdetach(ifp)
    struct ifnet *ifp;
{
    struct arpcom *ac = (struct arpcom *)ifp;
    struct ether_multi *enm;

    for (enm = LIST_FIRST(&ac->ac_multiaddrs);
        enm != LIST_END(&ac->ac_multiaddrs);
        enm = LIST_FIRST(&ac->ac_multiaddrs)) {
        LIST_REMOVE(enm, enm_list);
        free(enm);
        //free(enm, M_IFMADDR);
    }

#if 0
    /* moved to if_detach() */
    if_free_sadl(ifp);
#endif
}

/*
 * Process a received Ethernet packet;
 * the packet is in the mbuf chain m without
 * the ether header, which is provided separately.
 */
void
ether_input(ifp0, eh, m)
    struct ifnet *ifp0;
    struct ether_header *eh;
    struct mbuf *m;
{
    struct ifqueue *inq;
    u_int16_t etype;
    int s, llcfound = 0;
    struct llc *l;
    struct arpcom *ac;
    struct ifnet *ifp = ifp0;

    m_cluncount(m, 1);

    /* mark incomming routing domain */
    m->m_pkthdr.rdomain = ifp->if_rdomain;

    if (eh == NULL) {
        eh = mtod(m, struct ether_header *);
        m_adj(m, ETHER_HDR_LEN);
    }

#if 0
    if ((ifp->if_flags & IFF_UP) == 0) {
        m_freem(m);
        return;
    }
#endif

    if (ETHER_IS_MULTICAST(eh->ether_dhost)) {
        if ((ifp->if_flags & IFF_SIMPLEX) == 0) {
            struct ifaddr *ifa;
            struct sockaddr_dl *sdl = NULL;

            TAILQ_FOREACH(ifa, &ifp->if_addrlist, ifa_list) {
                if ((sdl =
                    (struct sockaddr_dl *)ifa->ifa_addr) &&
                    sdl->sdl_family == AF_LINK)
                    break;
            }
            /*
             * If this is not a simplex interface, drop the packet
             * if it came from us.
             */
            if (sdl && bcmp(LLADDR(sdl), eh->ether_shost,
                ETHER_ADDR_LEN) == 0) {
                m_freem(m);
                return;
            }
        }

        if (bcmp((caddr_t)etherbroadcastaddr, (caddr_t)eh->ether_dhost,
            sizeof(etherbroadcastaddr)) == 0)
            m->m_flags |= M_BCAST;
        else
            m->m_flags |= M_MCAST;
        ifp->if_imcasts++;

    }

    ifp->if_ibytes += m->m_pkthdr.len + sizeof(*eh);


    etype = ntohs(eh->ether_type);

// BL[SNIP] - WTF is this
#if 0
    if (!(netisr & (1 << NETISR_RND_DONE))) {
        add_net_randomness(etype);
        atomic_setbits_int(&netisr, (1 << NETISR_RND_DONE));
    }
#endif

    ac = (struct arpcom *)ifp;

    /*
     * If packet has been filtered by the bpf listener, drop it now
     */
    if (m->m_flags & M_FILDROP) {
        m_free(m);
        return;
    }

    /*
     * If packet is unicast and we're in promiscuous mode, make sure it
     * is for us.  Drop otherwise.
     */
    if ((m->m_flags & (M_BCAST|M_MCAST)) == 0 &&
        (ifp->if_flags & IFF_PROMISC)) {
        if (bcmp(ac->ac_enaddr, (caddr_t)eh->ether_dhost,
            ETHER_ADDR_LEN)) {
            m_freem(m);
            return;
        }
    }



    /*
     * Schedule softnet interrupt and enqueue packet within the same spl.
     */
    s = splnet();
decapsulate:

    switch (etype) {
    case ETHERTYPE_IP:
        DPRINTF(("ETHERTYPE_IP\n"));
        break;

    case ETHERTYPE_ARP:
        DPRINTF(("ETHERTYPE_ARP\n"));
        break;

    case ETHERTYPE_REVARP:
        DPRINTF(("ETHERTYPE_REVARP\n"));
        goto done;
    /*
     * Schedule IPv6 software interrupt for incoming IPv6 packet.
     */
    case ETHERTYPE_IPV6:
        DPRINTF(("ETHERTYPE_IPV6\n"));
        break;
    case ETHERTYPE_AT:
        DPRINTF(("ETHERTYPE_AT\n"));
        break;
    case ETHERTYPE_AARP:
        /* probably this should be done with a NETISR as well */
        /* XXX queue this */
        DPRINTF(("ETHERTYPE_AARP\n"));
        goto done;
    case ETHERTYPE_MPLS:
    case ETHERTYPE_MPLS_MCAST:
        DPRINTF(("ETHERTYPE_MPLS_MCAST\n"));
        break;
    default:
        if (llcfound || etype > ETHERMTU)
            goto dropanyway;
        llcfound = 1;
        l = mtod(m, struct llc *);
        switch (l->llc_dsap) {
        case LLC_SNAP_LSAP:
            if (l->llc_control == LLC_UI &&
                l->llc_dsap == LLC_SNAP_LSAP &&
                l->llc_ssap == LLC_SNAP_LSAP) {
                /* SNAP */
                if (m->m_pkthdr.len > etype)
                    m_adj(m, etype - m->m_pkthdr.len);
                m->m_data += 6;     /* XXX */
                m->m_len -= 6;      /* XXX */
                m->m_pkthdr.len -= 6;   /* XXX */
                M_PREPEND(m, sizeof(*eh), M_DONTWAIT);
                if (m == 0)
                    goto done;
                *mtod(m, struct ether_header *) = *eh;
                goto decapsulate;
            }
            goto dropanyway;
        dropanyway:
        default:
            m_freem(m);
            goto done;
        }
    }

    {

        IF_INPUT_ENQUEUE(&ifp->if_rcv, m);
        //IF_INPUT_ENQUEUE(&bsdInputQ, m);
        //pthread_cond_signal(&usbMacInputQ_cond);

    }

done:

    splx(s);
}


