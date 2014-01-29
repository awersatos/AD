/*****************************************************************************
|*
|*  Copyright:    Copyright (c) 2009, Altium
|*
|*  Description:  Device driver for ISP1760 USB Host Controller peripheral
|*                This driver is a reflection of technical information
|*                contained in the following documents. One important thing to
|*                remember is the fact the chip relies on an built in hub to
|*                communicate with low and full speed devices. The driver supposes
|*                pio mode memory transfers from isp1760 payload memory
|*
|*
|*  Reference:  ISP1760 Datasheet
|*                   - http://www.stericsson.com/technical_documents/ISP1760_5.pdf
|*              SP1760_1_Errata_070108
|*                   - http://download.analog.com/27516/forummessage/3/0/1/3017/ISP1760_1_Errata_070108.pdf
|*              AN10054 ISP1760/1 Frequently Asked Questions
|*                   - http://www.nxp.com/acrobat_download/applicationnotes/AN10054_4.pdf
|*              AN10037 Interfacing the ISP176x to the Intel PXA25x processor
|*                   - http://www.nxp.com/acrobat_download/applicationnotes/AN10037_4.pdf
|*              AN10042 ISP176x Linux Programming Guide
|*                   - http://www.nxp.com/acrobat_download/applicationnotes/AN10042_2.pdf
|*
\*****************************************************************************/

#include <stddef.h>
#include <stdlib.h>
#include <interrupts.h>
#include <timing.h>
#include <string.h>
#include <assert.h>

#include <stdbool.h>
#include <util_endian.h>

#if DEBUG_DRV_ISP1760
# include <stdio.h>
#endif

#include <drv_isp1760.h>
#include <drv_isp1760_cfg_instance.h>
#include <per_isp1760.h>
#include <usbhost_core.h>


// chunk / payload sizes cannot be chosen arbitrarely! We noticed many MSD
// devices cannot handle ptd sizes which are not a multiple of 512 bytes.
// Strange because USB spec mandates the payload size to be choosen freely by the host
// also not high speed usb devices cannot handle ptd sizes > ISP1760_DW3_NRBYTESTRANS_LOMSK
#define ISP1760_CHUNK_SIZE_COUNT 4

//#define ISP1760_CHUNK_1_COUNT    24
#define ISP1760_CHUNK_1_COUNT    8
//#define ISP1760_CHUNK_2_COUNT    16
#define ISP1760_CHUNK_2_COUNT    32

//#define ISP1760_CHUNK_3_COUNT    4
#define ISP1760_CHUNK_3_COUNT    4

//#define ISP1760_CHUNK_4_COUNT    3
#define ISP1760_CHUNK_4_COUNT    2

#define ISP1760_CHUNK_1_SIZE     (256)
#define ISP1760_CHUNK_2_SIZE     (1024)
#define ISP1760_CHUNK_3_SIZE     (3584)
#define ISP1760_CHUNK_4_SIZE     (8192)
#define ISP1760_MAX_PL_SIZE_LO   ISP1760_CHUNK_3_SIZE
#define ISP1760_MAX_PL_SIZE_HI   ISP1760_CHUNK_4_SIZE

#define ISP1760_MAX_ENQ_ISOPTD   (4)
#define ISP1760_PTD_COMPLETE     (1 << 0)
#define ISP1760_PTD_ENQUEUED     (1 << 1)
#define ISP1760_PTD_TYPE_ATL     (1 << 2)
#define ISP1760_PTD_TYPE_INT     (1 << 3)
#define ISP1760_PTD_TYPE_ISO     (1 << 4)


// maps endpoint type to ISP1760 transfer types/definitions (drv->xferdef)
#define ISP1760_XFERDEF(_bmAttributes)  ((_bmAttributes & 0x3)? ((_bmAttributes & 0x3) - 1) : 0x1)
#define ISP1760_XFERDEF_ISO      0x0
#define ISP1760_XFERDEF_ATL      0x1
#define ISP1760_XFERDEF_INT      0x2

#if __POSIX_KERNEL__
#define ISP1760_THREAD_SAFE 1
#include <kernel.h>
#else
#define ISP1760_THREAD_SAFE 0
#endif

typedef struct {
    uint32_t                base_addr;
    uint8_t                 base_idx;
    uint8_t                 chunk_count[ISP1760_CHUNK_SIZE_COUNT];
    uint32_t                chunk_size[ISP1760_CHUNK_SIZE_COUNT];
    uint32_t                chunk_free[ISP1760_CHUNK_SIZE_COUNT];
} isp1760_payload_map_t;

typedef struct isp1760_ptd_s
{
    struct isp1760_ptd_s    *next;         // pointer to the next ptd
    void                    *pldata;       // pointer into urb xferBuf that will become this ptd payload data
    uint32_t                pllen;         // payload data length
    uint32_t                ploffset;      // an offset into isp1760 payload memory where pldata will be stored
    uint8_t                 pid;
    bool                    toggle;        // toggle state
    usbhost_urb_t           *urb;          // pointer to originating urb
    uint32_t                status;
#if USBHOST_ISO_SUPPORT
    uint8_t                 framenumber;   // the ptd will be transceived in this uframe. <=> equals ISP1760 uframe[7..0] in DW2
    uint32_t                frameindex;    // this ptd transfers the urb->isoframes[frameindex] part of the urb
#endif
} isp1760_ptd_t;

typedef struct
{
    isp1760_ptd_t           *qptd[32];      // ptd's from drv->ptd[i] in the queue
    uint8_t                 nqptd;          // number of ptd's in the queue (max 32)
    int32_t                 since_ms[32];
    uint32_t                ptd_base;       // ptd base offset into ISP1760 memory
    volatile uint32_t       *donemap_reg;
    volatile uint32_t       *skipmap_reg;
    volatile uint32_t       *lastptd_reg;
    volatile uint32_t       *maskor_reg;
    volatile uint32_t       *maskand_reg;
} isp1760_xferdef_t;

struct isp1760_s
{
    uintptr_t               base_address;
    uint8_t                 interrupt0;
#if ISP1760_THREAD_SAFE
    pthread_t               handlerThreadId;
    pthread_mutex_t         lock;
    pthread_mutex_t         startup_mutex;
    pthread_cond_t          startup_cond;
#endif
    uint32_t                state;
    isp1760_ptd_t           ptd[UINT8_MAX + 1]; // available array of ptd's
    isp1760_xferdef_t       xferdef[3];         // xfer state info for each type (ATL / ISO / INT)
    uint8_t                 ptdit;              // ptd iterator
    uint8_t                 ptdfree;            // no. of free ptd's
    isp1760_payload_map_t   payloadmap;
};

isp1760_t isp1760_drv_table[DRV_ISP1760_INSTANCE_COUNT];

// This function returns the position of the first bit set in the uint32_t value
// The least significant bit is position 0 and the most significant position 31
// 31 is returned in case ther're no bits set. So code should check against zero
// before calling this function!
static uint32_t FFS32(uint32_t value)
{
    uint32_t fb;

    value &= -(int32_t)value;
    if (!(value & 0x55555555)) fb = 1; else fb = 0;
    if (!(value & 0x33333333)) fb |= 2;
    if (!(value & 0x0F0F0F0F)) fb |= 4;
    if (!(value & 0x00FF00FF)) fb |= 8;
    if (!(value & 0x0000FFFF)) fb |= 16;

    return fb;
}

/* isp1760 internally uses double word (8 bytes) granularity for its internal
 * memory. This Function converts from byte addressing to double word addressing
 * (divide by 8)incoorporating the PTD ISO offset)
 */
static uint32_t isp1760_base_to_internal(uint32_t base)
{
    return ((base - ISP1760_ISO_MEMORY_MAP_OFFSET) >> 3);
}

// 60kB of payload memory is devided into three blocks:
// one block with ISP1760_CHUNK_1_COUNT chunks of ISP1760_CHUNK_1_SIZE
// one block with ISP1760_CHUNK_2_COUNT chunks of ISP1760_CHUNK_1_SIZE
// and one block with ISP1760_CHUNK_3_COUNT chunks of ISP1760_CHUNK_1_SIZE
void isp1760_payloadmap_init(isp1760_t * restrict drv)
{
    isp1760_payload_map_t *pm = &drv->payloadmap;

    pm->base_addr = ISP1760_PAYLOAD_MEMORY_MAP_OFFSET;

    pm->chunk_count[0] = ISP1760_CHUNK_1_COUNT;
    pm->chunk_count[1] = ISP1760_CHUNK_2_COUNT;
    pm->chunk_count[2] = ISP1760_CHUNK_3_COUNT;
    pm->chunk_count[3] = ISP1760_CHUNK_4_COUNT;

    pm->chunk_size[0] = ISP1760_CHUNK_1_SIZE;
    pm->chunk_size[1] = ISP1760_CHUNK_2_SIZE;
    pm->chunk_size[2] = ISP1760_CHUNK_3_SIZE;
    pm->chunk_size[3] = ISP1760_CHUNK_4_SIZE;

    // all chunks are free (set all those bits to one)
    pm->chunk_free[0] = (1 << (ISP1760_CHUNK_1_COUNT - 1)) +  ((1 << (ISP1760_CHUNK_1_COUNT - 1)) - 1);
    pm->chunk_free[1] = (1 << (ISP1760_CHUNK_2_COUNT - 1)) +  ((1 << (ISP1760_CHUNK_2_COUNT - 1)) - 1);
    pm->chunk_free[2] = (1 << (ISP1760_CHUNK_3_COUNT - 1)) +  ((1 << (ISP1760_CHUNK_3_COUNT - 1)) - 1);
    pm->chunk_free[3] = (1 << (ISP1760_CHUNK_4_COUNT - 1)) +  ((1 << (ISP1760_CHUNK_4_COUNT - 1)) - 1);
}

// returns an offset in bytes into isp1760 payload memory able to accomodate the parsed size
// of payload data (size in bytes). This area is also marked "in use". 0xFFFFFFFF is returned
// when no memory found
uint32_t isp1760_payloadmap_alloc(isp1760_t * restrict drv, isp1760_ptd_t *ptd)
{
    isp1760_payload_map_t *pm = &drv->payloadmap;
    uint32_t i;
    uint32_t chunk  = 0;
    uint32_t offset = 0;
    uint32_t size = ptd->pllen;

    for(i=0; i < ISP1760_CHUNK_SIZE_COUNT; i++)
    {
        // if pm->chunk_free[i] == 0 none free
        if(pm->chunk_free[i] && (size <= pm->chunk_size[i]))
        {
            chunk = FFS32(pm->chunk_free[i]);
            if(chunk < pm->chunk_count[i])
            {
                // tag this chunk to be not free anymore
                pm->chunk_free[i] &= ~(1 << chunk);
                return pm->base_addr + offset + (chunk * pm->chunk_size[i]);
            }
        }
        offset += (pm->chunk_size[i] * pm->chunk_count[i]);
    }
    assert(0); // should not get here
    return 0xFFFFFFFF;
}

// mark payload memory chunk to be free
void isp1760_payloadmap_free(isp1760_t * restrict drv, isp1760_ptd_t *ptd)
{
    isp1760_payload_map_t *pm = &drv->payloadmap;
    uint32_t i;
    uint32_t chunk;
    uint32_t mem = ptd->ploffset - pm->base_addr;

    for(i=0; i < ISP1760_CHUNK_SIZE_COUNT; i++)
    {
        if(mem < (pm->chunk_size[i] * pm->chunk_count[i]))
        {
            chunk = mem / pm->chunk_size[i];
            pm->chunk_free[i] |= (1 << chunk);
            return;
        }
        mem -= (pm->chunk_size[i] * pm->chunk_count[i]);
    }
}

// Read the isp1760 using its prefetch buffers (memory bank register ISP1760_MEMORY(drv->base_address))
// This function doesn't increment the src address. This is done automatically by ISP1760 prefetch hardware.
// So make sure before calling this function the memory bank register is correctly setup.
// Also make sure src pointer is 4 byte aligned!
static void isp1760_read(void *dst, uintptr_t *src, size_t size)
{
    uint32_t *dst32 = (uint32_t *)dst;
    uint32_t *dst32end = dst32 + (size >> 2); // Divide size by 4
    uint32_t *src32 = (uint32_t *)src;
    uint32_t val;
    uint8_t *dst8 = (uint8_t *)dst32end;
    uint8_t *dst8end = dst8 + (size & 0x3); // Strip upper 30 bits

    assert(!((uintptr_t)src32 & 0x3)); // ISP1760 expects src to be 4 byte aligned
    while(dst32 != dst32end)
        *dst32++ = *src32;
    if(dst8 != dst8end)
    {
        val = *src32;
        uint8_t *val8 = (uint8_t *)&val;

        while (dst8 != dst8end)
            *dst8++ = *val8++;
    }
}

// This function is more or less just a normal memcpy function. However ISP1760
// writing is in blocks of 4 bytes. Also isp1760 requires dst address to be 4 byte aligned
static void isp1760_write(void *dst, void *src, size_t size)
{
    uint32_t *dst32 = (uint32_t *)dst;
    uint32_t *dst32end = dst32 + (size >> 2); /* Divide size by 4. */
    uint32_t *src32 = (uint32_t *)src;

    assert(!((uintptr_t)dst & 0x3)); // ISP1760 expects dst to be 4 byte aligned
    while(dst32 != dst32end)
        *dst32++ = *src32++;
    if(size & 0x3)
        *dst32++ = *src32;
}

// free all ptd's associated with the urb of the passed ptd. So this function
// will stop freeing ptd's after finding a ptd belonging to another urb. A pointer
// to this ptd is returned or NULL when there're no more ptd's in the list
inline static isp1760_ptd_t *isp1760_clean_urb(isp1760_t * restrict drv, isp1760_ptd_t *ptd)
{
    usbhost_urb_t *urb = ptd->urb;

    while (ptd && (ptd->urb == urb))
    {
        drv->ptdfree++;
        if (ptd->status & ISP1760_PTD_COMPLETE)
        {
            ptd->status = 0;
            ptd = ptd->next;
            break;
        }
        ptd->status = 0;
        ptd = ptd->next;
    }
    return ptd;
}

static void isp1760_urb_complete(isp1760_t * restrict drv, usbhost_urb_t *urb)
{
    assert(/*urb && */urb->OnComplete);
    if (urb->status == -EINPROGRESS)
        urb->status = 0;
    urb->complete = 0;
    isp1760_clean_urb(drv, urb->ptd_first);
#if ISP1760_THREAD_SAFE
    pthread_mutex_lock(&drv->lock);
#endif
    if(!(urb->xferflags & URB_BSD_COMPATIBILTY))
        ((hostusbhost_onurbcomplete_t)(urb->OnComplete))(urb);
    else
        ((hostusbhost_onurbcompletebsd_t)(urb->OnComplete))(urb, urb->completecontext, urb->status);
#if ISP1760_THREAD_SAFE
    pthread_mutex_unlock(&drv->lock);
#endif
}

static void isp1760_transform_in_to_hwptd(isp1760_t * restrict drv, isp1760_ptd_t *ptd, isp1760_hw_ptd_t *ptd_desc)
{
    uint32_t max_packet;
    uint32_t multi;
    uint32_t rl = ISP1760_RL_COUNTER;
    uint32_t nak = ISP1760_NAK_COUNTER;
    uint32_t epNum;
    usbhost_urb_t * urb = ptd->urb;

    max_packet = little16(urb->ep->desc.wMaxPacketSize);
    multi = 1 + ((max_packet >> 11) & 0x3);  // number of packets per uframe
    max_packet &= 0x7ff;   // maximum datasize of one packet
    epNum = urb->ep->desc.bEndpointAddress & 0x0F;

    SETBIT(ptd_desc->dw0, ISP1760_DW0_VALID);
    SETBITS(ptd_desc->dw0, ISP1760_DW0_NRBYTES, ptd->pllen);
    SETBITS(ptd_desc->dw0, ISP1760_DW0_MAXPACKET, max_packet);
    SETBITS(ptd_desc->dw0, ISP1760_DW0_ENDPT0, epNum);

    SETBITS(ptd_desc->dw1, ISP1760_DW1_ENDPT, epNum >> 1);
    SETBITS(ptd_desc->dw1, ISP1760_DW1_DEVICEADDRESS, urb->dev->devNum);
    SETBITS(ptd_desc->dw1, ISP1760_DW1_TOKEN, ptd->pid);
    SETBITS(ptd_desc->dw1, ISP1760_DW1_EPTYPE, USBHOST_EPXFERTYPE(urb->ep->desc.bmAttributes));

    // Generate ptd hub (low and full speed data) specific stuff -> split transactions
    if (urb->dev->speed != USBHOST_SPEED_HIGH)
    {
        SETBIT(ptd_desc->dw1, ISP1760_DW1_SPLIT);
        if (urb->dev->speed == USBHOST_SPEED_LOW)
            SETBIT(ptd_desc->dw1, ISP1760_DW1_SELOSPEED);
        SETBITS(ptd_desc->dw1, ISP1760_DW1_PORTNUMBER, urb->dev->ttport);
        SETBITS(ptd_desc->dw1, ISP1760_DW1_HUBADDRESS, urb->dev->parent->devNum);
        ptd_desc->dw5 = 0x04; // complete split in last uframe

        rl = 0;
        nak = 0;
    }
    else
    {
        SETBITS(ptd_desc->dw0, ISP1760_DW0_MULT, multi);
        if ((USBHOST_ISCONTROLEP(urb->ep->desc.bmAttributes) || USBHOST_ISBULKEP(urb->ep->desc.bmAttributes)) && urb->ep->ping)
            SETBIT(ptd_desc->dw3, ISP1760_DW3_PING);
    }
    SETBITS(ptd_desc->dw2, ISP1760_DW2_DATASTARTADDR, isp1760_base_to_internal(ptd->ploffset));

#if USBHOST_ISO_SUPPORT
    if(USBHOST_ISISOEP(urb->ep->desc.bmAttributes))
    {
        SETBITS(ptd_desc->dw2, ISP1760_DW2_UFRAME, ptd->framenumber);
        SETBITS(ptd_desc->dw4, ISP1760_DW4_USA, 0x01); //0xFF);
    }
    else
#endif
    {
        SETBITS(ptd_desc->dw2, ISP1760_DW2_RL, rl);

        SETBITS(ptd_desc->dw3, ISP1760_DW3_NAKCNT, nak);
        SETBITS(ptd_desc->dw3, ISP1760_DW3_CERR, ISP1760_ERR_COUNTER);
        if (USBHOST_ISCONTROLEP(urb->ep->desc.bmAttributes))
            SETBITS(ptd_desc->dw3, ISP1760_DW3_DT, ptd->toggle);
        else
            SETBITS(ptd_desc->dw3, ISP1760_DW3_DT, urb->ep->toggle);
    }
    if(USBHOST_ISINTEP(urb->ep->desc.bmAttributes))
    {
        SETBITS(ptd_desc->dw2, ISP1760_DW2_UFRAME, urb->ep->period);
        SETBITS(ptd_desc->dw4, ISP1760_DW4_USA, 0x01);
    }
    SETBIT(ptd_desc->dw3, ISP1760_DW3_ACTIVE);
}

inline static void isp1760_ptdfill(isp1760_ptd_t * ptd, usbhost_urb_t * urb, uint32_t status, uint8_t pid, void *pldata, size_t pllen, bool toggle)
{
    ptd->urb = urb;
    ptd->status = status;
    ptd->pid = pid;
    ptd->pldata = pldata;
    ptd->pllen = pllen;
    ptd->toggle = toggle;
}

static isp1760_ptd_t *isp1760_next_freeptd(isp1760_t * restrict drv)
{
    uint8_t endit = drv->ptdit;
    isp1760_ptd_t *ptd = NULL;

    assert(drv->ptdfree);
    do
    {
        if(!drv->ptd[drv->ptdit].status)
        {
            drv->ptdfree--;
            ptd = &drv->ptd[drv->ptdit];
            drv->ptdit++;
            break;
        }
        drv->ptdit++;
    } while(endit != drv->ptdit);
    return ptd;
}

// build a ptd list suitable for communication with the endpoint addressed by this urb. Eg. a setup stage is needed
// for control endpoints. But also one ore more output stages are required because one ptd can only accomodate
// ISP1760_HC_ATL_PL_SIZE bytes and we do need to xfer urb->xferbufsize bytes. Return a pointer to the first ptd of
// this urb
static isp1760_ptd_t *isp1760_urb_to_ptdlist(isp1760_t * restrict drv, usbhost_urb_t *urb)
{
    isp1760_ptd_t   *ptd = NULL;
    uint32_t        ptd_type;
    void            *buf;
    int32_t         len;
    int32_t         max_packet;
    uint8_t         pid = 0;
    bool            toggle = 0;
    int32_t         ptd_len;
    int32_t         sz_limit;

    if(!(urb->ep->enabled && ((drv->state == HC_STATE_RUNNING) || (drv->state == HC_STATE_RESUMING))))
        return NULL;

    urb->status = -EINPROGRESS;
    urb->complete = 0;
    // one ptd cannot accomodate the complete urb->xferbuf so build a ptd queue.
    // For ISO; data is located at an offset in urb->xferbuf
#if USBHOST_ISO_SUPPORT
    if (USBHOST_ISISOEP(urb->ep->desc.bmAttributes))
    {
        if (drv->ptdfree < urb->isoframecount)
            return NULL;
        for(uint32_t frameindex = 0; frameindex < urb->isoframecount; frameindex++)
        {
            /* Initialize the status and actual length of the packet transferred during this frame  */
            urb->isoframes[frameindex].actuallen = 0;
            urb->isoframes[frameindex].status = -EXDEV;
            buf = ((uint8_t *) urb->xferbuf) + urb->isoframes[frameindex].offset;
            len = urb->isoframes[frameindex].len;

            if (ptd)
            {
                ptd->next = isp1760_next_freeptd(drv);
                ptd = ptd->next;
            }
            else
            {
            ptd = isp1760_next_freeptd(drv);
                urb->ptd_first = ptd;
            }
            isp1760_ptdfill(ptd, urb, ISP1760_PTD_TYPE_ISO, ISP1760_DW1_TOKEN_IN, buf, len, 0);
            ptd->frameindex = frameindex;
        }
        ptd->next = NULL;
        ptd->status |= ISP1760_PTD_COMPLETE;
    } else
#endif
    {
        if (urb->dev->speed == USBHOST_SPEED_HIGH)
           sz_limit = ISP1760_MAX_PL_SIZE_HI;
        else
           sz_limit = ISP1760_MAX_PL_SIZE_LO;
        if (drv->ptdfree < ((urb->xferbufsize / sz_limit) + 3))
            return NULL;
        len = urb->xferbufsize;
        if (USBHOST_EPXFERTYPE(urb->ep->desc.bmAttributes) == USBHOST_EPXFERTYPE_INT)
            ptd_type = ISP1760_PTD_TYPE_INT;
        else
            ptd_type = ISP1760_PTD_TYPE_ATL;

        // create the first ptd
        ptd = isp1760_next_freeptd(drv);
        urb->ptd_first = ptd;

        // We need to start with a setup ptd for control endpoints
        if (USBHOST_ISCONTROLEP(urb->ep->desc.bmAttributes))
        {
            isp1760_ptdfill(ptd, urb, ptd_type, ISP1760_DW1_TOKEN_SETUP, urb->setuppacket, sizeof(usbhost_controlrequest_t), toggle);

            ptd->next = isp1760_next_freeptd(drv);
            ptd = ptd->next;
            toggle = 1;
            if (!len)
                pid = ISP1760_DW1_TOKEN_IN;
        }

        // make pid to match direction
        if (urb->ep->desc.bEndpointAddress & (1<<7))
            pid |= ISP1760_DW1_TOKEN_IN;
        else
            pid |= ISP1760_DW1_TOKEN_OUT;

        max_packet = little16(urb->ep->desc.wMaxPacketSize);

        buf = urb->xferbuf;
        for (;;)
        {
            if (len > sz_limit)
                ptd_len = sz_limit;
            else
                ptd_len = len;
            isp1760_ptdfill(ptd, urb, ptd_type, pid, buf, ptd_len, toggle);
            buf = (void *) ((uint32_t)buf + ptd_len);
            len -= ptd_len;

            // toggle if ptd_len is 0, <mp,2mp], <3mp,4mp], <5mp,6mp], etc
            if ((max_packet & (ptd_len + (max_packet - 1))) == 0)
                    toggle = !toggle;

            if (len <= 0)
                break;

            ptd->next = isp1760_next_freeptd(drv);
            ptd = ptd->next;
        }
        if (urb->xferbufsize != 0)
        {
            int one_more = 0;
            // Control endpoints also need a trailing output/input stage
            if (USBHOST_ISCONTROLEP(urb->ep->desc.bmAttributes))
            {
                one_more = 1;
                pid ^= ISP1760_DW1_TOKEN_IN;
                toggle = 1;
            }
            else if (USBHOST_ISBULKEP(urb->ep->desc.bmAttributes)
                     && (urb->xferflags & URB_ZERO_PACKET) && !(urb->xferbufsize % max_packet))
            {
                one_more = 1;
            }
            if (one_more)
            {
                ptd->next = isp1760_next_freeptd(drv);
                ptd = ptd->next;

                isp1760_ptdfill(ptd, urb, ptd_type, pid, NULL, 0, toggle);
            }
        }
        ptd->next = NULL;
        ptd->status |= ISP1760_PTD_COMPLETE;
    }
    return ptd;
}

// transform ptd in a ISP1760 compatible ptd and copy this ptd including its associated payload
// (ptd->pldata) into ISP1760 memory. The ISP170 is also told to start processing this ptd
static void isp1760_enqueue_ptd(isp1760_t * restrict drv, isp1760_ptd_t *ptd, isp1760_xferdef_t *xferdef)
{
    uint32_t                ptdid;
    uint32_t                ptdid_mapped = 0;
    uint32_t                skip_reg;
    uint32_t                or_reg;
    usbhost_host_endpoint_t *ep = ptd->urb->ep;

    /*
     * When this function is called from the interrupt handler to enqueue
     * a follow-up packet, the SKIP register gets written and read back
     * almost immediately. With ISP1761, this register requires a delay of
     * 195ns between a write and subsequent read (see section 14.1.3).
     */
    delay_ns(195);
    skip_reg = *(xferdef->skipmap_reg);
    or_reg = *(xferdef->maskor_reg);
    assert(skip_reg);
    while (ptd)
    {
        isp1760_hw_ptd_t        ptd_desc = {0};

        // get first available index to use for our ptd
        ptdid = FFS32(skip_reg);
        ptdid_mapped = 1 << ptdid;
        skip_reg &= ~ptdid_mapped;
        // completing this ptd must generate an interrupt.
        or_reg |= ptdid_mapped;

        // return an offset into the payload memory able to accomodate this ptd
        ptd->ploffset = isp1760_payloadmap_alloc(drv, ptd);
#if USBHOST_ISO_SUPPORT
        if (ptd->status & ISP1760_PTD_TYPE_ISO)
        {
            uint8_t start_uframe;

            if(ep->ptd_tail)
                start_uframe = ep->next_uframe;
            else   // We need an amount of time to enqueue the first ptd
                start_uframe = (ISP1760_FRINDEX(drv->base_address) & 0xff) + 32;
            ep->next_uframe = start_uframe + (ptd->urb->isoframecount << 3);
            ptd->framenumber = start_uframe + (ptd->frameindex << 3);
        }
#endif
        // build a valid isp1760 ptd from this ptd
        isp1760_transform_in_to_hwptd(drv, ptd, &ptd_desc);
        // write the ptd into the isp1760 ptd memory
        isp1760_write((uint32_t *) (drv->base_address + xferdef->ptd_base + ptdid * sizeof(isp1760_hw_ptd_t)), (uint32_t *) &ptd_desc, sizeof(isp1760_hw_ptd_t));
        // copy the payload of setup/out typed ptd's to isp1760 payload memory
        if (ptd->pllen && (ptd->pid != ISP1760_DW1_TOKEN_IN))
            isp1760_write((uint32_t *) (drv->base_address + ptd->ploffset), ptd->pldata, ptd->pllen);
        xferdef->qptd[ptdid] = ptd;
        ptd->status |= ISP1760_PTD_ENQUEUED;
        xferdef->nqptd++;
        ep->ptd_cur = ptd->next;
        if ((ptd->status & ISP1760_PTD_TYPE_ISO) && (xferdef->nqptd < ISP1760_MAX_ENQ_ISOPTD))
            ptd = ptd->next;
        else
            ptd = NULL;
    }
    if(ptdid_mapped)
    {
        // tell isp1760 to process (not skip and generate interrupt) these ptd's
        *(xferdef->maskor_reg) = or_reg;
        *(xferdef->skipmap_reg) = skip_reg;
    }
}

// take ownership of this urb. Add the ptd(list) to the queue head of this endpoint
// addressed by this urb (urb->ep) and enqueue the first ptd of the passed ptd(list)
// if this queue head is not already busy. If busy the ptd's will be enqueued by
// the interrupt handler
extern int32_t isp1760_enqueue_urb(isp1760_t * restrict drv, usbhost_urb_t * urb)
{
    isp1760_ptd_t *ptd_last;
    isp1760_xferdef_t *xferdef = &drv->xferdef[ISP1760_XFERDEF(urb->ep->desc.bmAttributes)];
    int32_t rc = 0;
#if ISP1760_THREAD_SAFE
    int err;
#endif
    // period will be mapped directly on dw2 uframe
    if (USBHOST_ISINTEP(urb->ep->desc.bmAttributes))
    {
        if (urb->dev->speed == USBHOST_SPEED_HIGH)
            urb->ep->period = urb->interval >> 1; //eg. urb-interval = 16usofs -> uframe[7:0]=8
        else
            urb->ep->period = urb->interval << 2;  //(8 * urb->interval) >> 1;
        if (urb->ep->period > 128) // hardware cannot handle periods larger than 32 (uframes > 128)
            urb->ep->period = 128;
    }

#ifndef USBHOST_ISO_SUPPORT
    if (USBHOST_ISISOEP(urb->ep->desc.bmAttributes))
        return -EPIPE;
#endif
#if ISP1760_THREAD_SAFE
    err = pthread_mutex_lock(&drv->lock);
    assert(!err);
#endif
    ptd_last = isp1760_urb_to_ptdlist(drv, urb);
    if (!ptd_last)
    {
#if ISP1760_THREAD_SAFE
        err = pthread_mutex_unlock(&drv->lock);
        assert(!err);
#endif
        return -ENOMEM;
    }
    // do not process interrupts anymore; they interfere with adding ptd's
    interrupt_disable(drv->interrupt0);
    // ptd_tail is set NULL by interrupt handler when no more ptd's in queue for this endpoint
    if (urb->ep->ptd_tail)    // add ptd at end of queue for this ep
    {
        ((isp1760_ptd_t *)urb->ep->ptd_tail)->next = urb->ptd_first;
        if (!urb->ep->ptd_cur)
            urb->ep->ptd_cur = urb->ptd_first;
        urb->ep->ptd_tail = ptd_last;
    }
    else // add ptd to the empty ep queue
    {
        urb->ep->ptd_cur = urb->ptd_first;
        urb->ep->ptd_tail = ptd_last;
        xferdef->nqptd = 0;
        isp1760_enqueue_ptd(drv, urb->ptd_first, xferdef);
    }
    interrupt_enable(drv->interrupt0);
#if ISP1760_THREAD_SAFE
    err = pthread_mutex_unlock(&drv->lock);
    assert(!err);
#endif
    return rc;
}

extern int32_t isp1760_abort_endpoint(isp1760_t * restrict drv, usbhost_host_endpoint_t *ep)
{
    isp1760_xferdef_t   *xferdef = &drv->xferdef[ISP1760_XFERDEF(ep->desc.bmAttributes)];
    uint32_t            i;

    // walk over all ptd's
    for (i = 0; i < 32; i++)
    {
        if (xferdef->qptd[i]->urb && xferdef->qptd[i]->urb->ep == ep)
        {
            xferdef->qptd[i]->urb->status = -1;
            isp1760_dequeue_urb(drv, xferdef->qptd[i]->urb);
        }
    }
    return 0;
}

// Free all ptd's and associated payload areas of the passed urb. Normally this is already done
// for you in the interrupt handler. Only in case of errors you would like to do it manually
extern int32_t isp1760_dequeue_urb(isp1760_t * restrict drv, usbhost_urb_t *urb)
{
    isp1760_xferdef_t   *xferdef;
    isp1760_hw_ptd_t    ptd_desc;
    uint32_t            i;
#if ISP1760_THREAD_SAFE
    int err;
#endif

    memset(&ptd_desc, 0, sizeof(ptd_desc));
    xferdef = &drv->xferdef[ISP1760_XFERDEF(urb->ep->desc.bmAttributes)];

#if ISP1760_THREAD_SAFE
    err = pthread_mutex_lock(&drv->lock);
    assert(!err);
#endif

    // walk over all ptd's
    for (i = 0; i < 32; i++)
    {
        if (xferdef->qptd[i]->urb == urb)
        {
            isp1760_ptd_t *ptd;

            *(xferdef->skipmap_reg) |= (1 << i);
            *(xferdef->maskor_reg) &= ~(1 << i);
            // free the ptd's and the payload associated with this urb
            ptd = isp1760_clean_urb(drv, xferdef->qptd[i]);
            isp1760_payloadmap_free(drv, xferdef->qptd[i]);
            xferdef->qptd[i] = NULL;
            if(urb->status != -1)
                urb->status = 0;
            // complete this urb (by running its urb->oncomplete handler)
            isp1760_urb_complete(drv, urb);
            // there can be other ptd's (ptd != NULL) for this endpoint belonging to another urb
            // enqueue such ptd else clear queue head
            if (ptd)
            {
                urb->ep->ptd_cur = ptd;
                isp1760_enqueue_ptd(drv, ptd, xferdef);
            }
            else
            {
                urb->ep->ptd_cur = NULL;
            }
            // ptd's found break
            break;
        }
        else
        {
            isp1760_ptd_t *ptd, *prev_ptd = xferdef->qptd[i];

            // this for loop will remove all ptd from a certain urb. Eg in the chain
            // ptd1(urb1)->ptd2(urb1)->ptd1(urb2)->ptd1(urb2)->ptd1(urb3) and deleting
            // urb2 the chain will become  ptd1(urb1)->ptd2(urb1)->ptd1(urb3)
            for (ptd = xferdef->qptd[i]->next; ptd; ptd = ptd->next)
            {
                if (ptd->urb == urb)
                {
                    prev_ptd->next = isp1760_clean_urb(drv, ptd);
                    if(urb->status != -1)
                        urb->status = 0;
                    isp1760_urb_complete(drv, urb);
                    break;
                }
                prev_ptd = ptd;
            }
            // ptd's found break
            if (ptd)
                break;
        }
    }
#if ISP1760_THREAD_SAFE
    err = pthread_mutex_unlock(&drv->lock);
    assert(!err);
#endif

    return 0;

}

static void isp1760_do_int(isp1760_t * restrict drv, isp1760_xferdef_t *xferdef)
{
    isp1760_hw_ptd_t        ptd_desc;
    usbhost_urb_t           *urbar[32];
    int                     nurbcompl = 0;
    usbhost_urb_t           *urb = NULL;
    isp1760_ptd_t           *ptd;
    uint32_t                ptd_regs;
    uint32_t                ptdid;
    uint32_t                pllen;
    uint32_t                done_map = 0;


/* After enqueing ptd's. Done ptd's will generate an interrupt
 * The done_map register will show you which ptd's are done. A typical done_map
 * with urb's having 4 ptd's is something like 0..0.U1P2.U1P1.U2P2.U2P1.U1P4.U1P3
 * (U=URB, P=PTD). With such a done_map this handler starts handling U1P3 than
 * U1P4 than U2P1 and so on. Consequence of this mechanism is:
 * - You cannot complete URB1 after handling U1P4 (you need to handle U1P1
 * and U1P2 first)
 * In the presence of errors things get really complicated because you must
 * finish all enqueued ptd's before completing the URB
 */
    for (ptdid = 0; ptdid < 32; ptdid++)
    {
        ptd = xferdef->qptd[ptdid];
        if (!ptd)
            continue;
        ptd_regs = xferdef->ptd_base + ptdid * sizeof(isp1760_hw_ptd_t);
        /* Initialize memory prefetch buffers (memory banks):
         * The time between an address written into ISP1760_MEMORY and a read from
         * that address (isp1760_read below) has to be at least tp13=90 ns.
         * see table 96 memory read timing diagram. 3*t_WHWL + 2*t_w11 =
         * 3*25ns + 2*17ns = 109ns. Also see faq 1.15
         * This is why we write ISP1760_MEM_BANK(1) twice below */
        ISP1760_MEMORY(drv->base_address) = ptd_regs + ISP1760_MEM_BANK(0);
        ISP1760_MEMORY(drv->base_address) = ptd->ploffset + ISP1760_MEM_BANK(1);
        ISP1760_MEMORY(drv->base_address) = ptd->ploffset + ISP1760_MEM_BANK(1);
        // this will read from ISP1760_MEM_BANK(0)
        isp1760_read(&ptd_desc,(void *)(drv->base_address + ptd_regs + ISP1760_MEM_BANK(0)),
                     sizeof(isp1760_hw_ptd_t));
        if(TSTBIT(ptd_desc.dw0, ISP1760_DW0_VALID))
            continue;
        done_map |= (1 << ptdid);
        urb = ptd->urb;
        assert(urb);

        // TODO: Handle RL in combination with ISP1760_DW3_ERROR properly
/*
        rl = (ptd_desc.dw2 >> 25) & 0x0f;
        nak_count = (ptd_desc.dw3 >> 19) & 0xf;

        // Transfer Error -> reload   (from pehci.c)
        if (TSTBIT(ptd_desc.dw3, ISP1760_DW3_ERROR) && TSTBIT(ptd_desc.dw3, ISP1760_DW3_ACTIVE) && !TSTBIT(ptd_desc.dw3, ISP1760_DW3_HALT))
        {
        }

        // From AN10054: If value x is placed in the NakCnt field, the OUT ptdid will be retried
        // x number of times by the hardware, before the active bit is cleared and an interrupt
        // is generated to inform the microprocessor. If nak count is zero and active bit is
        // reset, it means that device is naking and need to reload the same td
        if (rl && !nak_count && TSTBIT(ptd_desc.dw3, ISP1760_DW3_ACTIVE))
        {
            // make this ptd valid again
            ptd_desc.dw0 |= ISP1760_PTD_VALID;
            ptd_desc.dw3 |= ISP1760_PTD_NAC_CNT(ISP1760_NAK_COUNTER);
            // ptd_desc.dw3 |= ISP1760_PTD_CERR(ISP1760_ERR_COUNTER);
            ptd_desc.dw3 |= ISP1760_DW3_PTD_ACTIVE;
            // write the ptd into the isp1760 ptd memory
            isp1760_write((uint32_t *) (drv->base_address + atl_regs), (uint32_t *) &ptd_desc, sizeof(ptd_desc));
            // completing this ptd must generate an interrupt again.
            ISP1760_ATL_IRQ_MASK_OR(drv->base_address) |= 1 << ptd;
            // tell isp1760 not to skip this ptd anymore
            ISP1760_ATL_PTD_SKIP_MAP(drv->base_address) &= ~(1 << ptd);
            // also notify ISP1760 there're still ATL PTD's enqueud -> process it
            //ISP1760_BUFFER_STAT(drv->base_address) |= ISP1760_BUFFER_ATL;
            continue;
        }*/

        if (TSTBIT(ptd_desc.dw3, ISP1760_DW3_HALT))
        {
            if (urb->status == -EINPROGRESS)
                urb->complete = 1;
            urb->status = -EPIPE;
            urb->ep->ping = 0;
            urb->ep->toggle = 0;
        } else if (TSTBIT(ptd_desc.dw3, ISP1760_DW3_ERROR))
        {
            if (urb->status == -EINPROGRESS)
                urb->complete = 1;
            if(urb->status != -EPIPE)
                urb->status = -EBUSY;
        } else if(urb->status != -EPIPE) // no errors in past and present
        {
            if (urb->dev->speed == USBHOST_SPEED_HIGH)
                pllen = GETBITS(ptd_desc.dw3, ISP1760_DW3_NRBYTESTRANS, ISP1760_DW3_NRBYTESTRANS_HIMSK);
            else
                pllen = GETBITS(ptd_desc.dw3, ISP1760_DW3_NRBYTESTRANS, ISP1760_DW3_NRBYTESTRANS_LOMSK);
            if (pllen)
            {
                switch (GETBITS(ptd_desc.dw1, ISP1760_DW1_TOKEN, ISP1760_DW1_TOKEN_MSK))
                {
                case ISP1760_DW1_TOKEN_IN:
                    isp1760_read(ptd->pldata,(void *)(drv->base_address + ptd->ploffset + ISP1760_MEM_BANK(1)),
                                 pllen);
                    // fallthrough
                case ISP1760_DW1_TOKEN_OUT:
                    urb->xferactual += pllen;
                    // fallthrough
                case ISP1760_DW1_TOKEN_SETUP:
                    break;
                }
            }
#if USBHOST_ISO_SUPPORT
            if (ptd->status & ISP1760_PTD_TYPE_ISO)
            {
                urb->isoframes[ptd->frameindex].actuallen = pllen;
                urb->isoframes[ptd->frameindex].status = 0;
                if(TSTBITS(ptd_desc.dw4, ISP1760_DW4_STATUS0, ISP1760_DW4_STATUS_MSK)) // for now: we only use usof0
                {
                    urb->isoerrorcount++;
                    if(TSTBIT(ptd_desc.dw4, ISP1760_DW4_STATUS0 + ISP1760_DW4_STATUS_BABBLE))
                        urb->isoframes[ptd->frameindex].status = -EOVERFLOW;
                    else
                        urb->isoframes[ptd->frameindex].status = -EREMOTEIO;
                }
            }
#endif
            if (!USBHOST_ISISOEP(urb->ep->desc.bmAttributes))
            {
                urb->ep->ping = TSTBIT(ptd_desc.dw3, ISP1760_DW3_PING);
                urb->ep->toggle = TSTBIT(ptd_desc.dw3, ISP1760_DW3_DT);
            }
            // determine if we need to complete the urb
            if (USBHOST_ISBULKEP(urb->ep->desc.bmAttributes) && (pllen < ptd->pllen))
            {
                urb->complete = 1;
                if (urb->status == -EINPROGRESS)
                {
                    if(urb->xferflags & URB_SHORT_NOT_OK)
                        urb->status = -EREMOTEIO;
                }
            } else if (ptd->status & ISP1760_PTD_COMPLETE)
            {
                urb->complete = 1;
            }
        }
        urbar[nurbcompl++] = urb;
        ptd->status = 0;
        isp1760_payloadmap_free(drv, ptd);
        xferdef->qptd[ptdid] = NULL;
        xferdef->nqptd--;
    }
    if(done_map)
    {
        // skip the done ptd: the ptd is processed and can now be used by a new ptd
        *(xferdef->skipmap_reg) |= done_map;
        // Now we have handled done ptd's. Those ptd's do not need to generate an interrupt anymore
        *(xferdef->maskor_reg) &= ~done_map;
        for (int i = 0; i < nurbcompl; i++)
        {
            // TODO: How to handle halt (EPIPE) and error (EBUSY) properly
            if (urbar[i]->ep->ptd_cur && (urbar[i]->status != -EPIPE))
                isp1760_enqueue_ptd(drv, urbar[i]->ep->ptd_cur, xferdef);
            else
                urbar[i]->ep->ptd_tail = NULL;
            if (urbar[i]->complete)
                isp1760_urb_complete(drv, urbar[i]);
        }
    }
}

#if ISP1760_THREAD_SAFE
uint32_t isp1760_handler(uint32_t number, void *context)
{
    isp1760_t *drv = context;

    // make processor ready to receive another interrupt
    interrupt_acknowledge(drv->interrupt0);
    // reset all interrupt causes before scheduling new ptds.
    ISP1760_INT(drv->base_address) = 0x3EA;

    if (drv->state & HC_STATE_RUNNING)
            return INTERRUPT_NOTIFY;  // notify handler thread
    return INTERRUPT_HANDLED;
}

void* isp1760_handler_thread(void* arg)
{
    isp1760_t  *drv = arg;
    int err, cnt = 0;

    err = pthread_interrupt_associate(drv->interrupt0, isp1760_handler, arg);
    assert(!err);
    interrupt_enable(drv->interrupt0);
    err = pthread_mutex_lock(&drv->startup_mutex);
    assert(!err);
    err = pthread_cond_signal(&drv->startup_cond);
    assert(!err);
    err = pthread_mutex_unlock(&drv->startup_mutex);
    assert(!err);
    while(1)
    {
        // Wait for an interrupt to occur
        pthread_interrupt_timedwait(NULL);
        pthread_mutex_lock(&drv->lock);
        isp1760_do_int(drv, &drv->xferdef[ISP1760_XFERDEF_ATL]);
#if USBHOST_ISO_SUPPORT
        isp1760_do_int(drv, &drv->xferdef[ISP1760_XFERDEF_ISO]);
#endif
        isp1760_do_int(drv, &drv->xferdef[ISP1760_XFERDEF_INT]);
        pthread_mutex_unlock(&drv->lock);
    }
}
#else // not ISP1760_THREAD_SAFE

__INTERRUPT_NATIVE void isp1760_handler(void)
{
    uint32_t currentIRQ = interrupt_get_current();
    isp1760_t *drv = interrupt_native_context(currentIRQ);

    // make processor ready to receive another interrupt
    interrupt_acknowledge(currentIRQ);
    // reset all interrupt causes before scheduling new ptds.
    ISP1760_INT(drv->base_address) = 0x3EA;

    if (drv->state & HC_STATE_RUNNING)
    {
        isp1760_do_int(drv, &drv->xferdef[ISP1760_XFERDEF_ATL]);
#if USBHOST_ISO_SUPPORT
        isp1760_do_int(drv, &drv->xferdef[ISP1760_XFERDEF_ISO]);
#endif
        isp1760_do_int(drv, &drv->xferdef[ISP1760_XFERDEF_INT]);
    }
}
#endif // ISP1760_THREAD_SAFE

// Host controller initialization according AN10054 $3.1 Register initialization  (step 1 to 16)
extern int32_t isp1760_reset(isp1760_t * restrict drv)
{
    isp1760_payloadmap_init(drv);

    // AN10054 $3.1 Register initialization  (step 1 to 11)
    ISP1760_BUFFER_STAT(drv->base_address) = 0;
    ISP1760_ATL_PTD_SKIP_MAP(drv->base_address) = ISP1760_NO_TRANSFER_ACTIVE;
    ISP1760_INT_PTD_SKIP_MAP(drv->base_address) = ISP1760_NO_TRANSFER_ACTIVE;
    ISP1760_ISO_PTD_SKIP_MAP(drv->base_address) = ISP1760_NO_TRANSFER_ACTIVE;
    // DONE_MAP registers are reset using a read but writing 0 to them is also fine
    ISP1760_ATL_PTD_DONE_MAP(drv->base_address) = 0;
    ISP1760_INT_PTD_DONE_MAP(drv->base_address) = 0;
    ISP1760_ISO_PTD_DONE_MAP(drv->base_address) = 0;
    ISP1760_SW_RESET(drv->base_address) = ISP1760_SW_RESET_RESET_ALL;
    ISP1760_SW_RESET(drv->base_address) = ISP1760_SW_RESET_RESET_HC;
    ISP1760_USBCMD(drv->base_address) |= ISP1760_USBCMD_HCRESET;
    while (ISP1760_USBCMD(drv->base_address) & ISP1760_USBCMD_HCRESET);

    // AN10054 $3.1 Register initialization  (step 12 to 13)
    ISP1760_INT(drv->base_address) =  0x3EA; // reset all interrupt causes
    ISP1760_INT_ENABLE(drv->base_address) = ISP1760_INT_SOFITLINT;

    // AN10054 $3.1 Register initialization  (step 14 to 16)
    ISP1760_MODE_CONTROL(drv->base_address) |= ISP1760_ALL_ATX_RESET;
    delay_ms(10);
    ISP1760_MODE_CONTROL(drv->base_address) &= ~ISP1760_ALL_ATX_RESET;

    ISP1760_PORT1_CONTROL(drv->base_address) = (ISP1760_PORT1_INIT2 | ISP1760_PORT1_POWER);

    return 0;
}

// Host controller initialization according AN10054 $3.1 Register initialization  (step 17 to 36)
int32_t isp1760_start(isp1760_t * restrict drv)
{
    drv->state = HC_STATE_RUNNING;
    for (int i = 0; i < 3; i++)
    {
        drv->xferdef[i].nqptd = 0;
        for (int j = 0; j < 32; j++)
            drv->xferdef[i].qptd[j] = NULL;
    }

    // AN10054 $3.1 Register initialization  (step 17 - 22)
    ISP1760_ATL_IRQ_MASK_AND(drv->base_address) = 0;
    ISP1760_ATL_IRQ_MASK_OR(drv->base_address) = 0;
    ISP1760_INT_IRQ_MASK_AND(drv->base_address) = 0;
    ISP1760_INT_IRQ_MASK_OR(drv->base_address) = 0;
    ISP1760_ISO_IRQ_MASK_AND(drv->base_address) = 0;
    ISP1760_ISO_IRQ_MASK_OR(drv->base_address) = 0;

    // AN10054 $3.1 Register initialization  (step 23)
    ISP1760_MODE_CONTROL(drv->base_address) |= (ISP1760_HW_DATA_BUS_32BIT | ISP1760_HW_GLOBAL_INTR_EN);

    // AN10054 $3.1 Register initialization  (step 24 - 27)
    ISP1760_USBCMD(drv->base_address) = ISP1760_USBCMD_RS;
    while (!(ISP1760_USBCMD(drv->base_address) & ISP1760_USBCMD_RS));
    // now route the ports to EHCI
    ISP1760_CONFIGFLAG(drv->base_address) = ISP1760_CONFIGFLAG_CF;
    while (!(ISP1760_CONFIGFLAG(drv->base_address) & ISP1760_CONFIGFLAG_CF));

    // AN10054 $3.1 Register initialization  (step 28 - 30)
    ISP1760_ATL_PTD_LAST_PTD(drv->base_address) = 0x80000000; // use all 32 PTD's for scheduling
    ISP1760_INT_PTD_LAST_PTD(drv->base_address) = 0x80000000; // use all 32 PTD's for scheduling
    ISP1760_ISO_PTD_LAST_PTD(drv->base_address) = 0x80000000; // use all 32 PTD's for scheduling

    // start scheduling ptd's
#ifdef USBHOST_ISO_SUPPORT
    ISP1760_BUFFER_STAT(drv->base_address) = ISP1760_BUFFER_ATL | ISP1760_BUFFER_INT |ISP1760_BUFFER_ISO;
#else
    ISP1760_BUFFER_STAT(drv->base_address) = ISP1760_BUFFER_ATL | ISP1760_BUFFER_INT;
#endif
    // AN10054 $3.1 Register initialization  (step 31 - 33)
    ISP1760_PORTSC1(drv->base_address) = ISP1760_PORTSC1_POWER;
    while (!(ISP1760_PORTSC1(drv->base_address) & ISP1760_PORTSC1_CONCHANGED));
    // reset the connection status changed bit
    ISP1760_PORTSC1(drv->base_address) |= ISP1760_PORTSC1_CONCHANGED;

    // AN10054 $3.1 Register initialization  (step 34) However this step is wrong
    // you cannot write bit 0 and 11. According AN10037 it must be 0x1100 (power and reset)
    // Also the PORTSC1 register does only control the hub upstream port the individual device
    // downstream ports can be controlled using USB2.0 standard hub commands.
    ISP1760_PORTSC1(drv->base_address) = (ISP1760_PORTSC1_POWER | ISP1760_PORTSC1_RESET);
    // AN10054 $3.1 Register initialization  (step 35 - 36)
    delay_ms(50);
    ISP1760_PORTSC1(drv->base_address) &= ~ISP1760_PORTSC1_RESET;
    // at this point portsc1 (the hub upstream port) is enabled
    // reset and enabling the hub device/downstream ports is done at device enumeration
    return 0;
}

extern int32_t isp1760_stop(isp1760_t * restrict drv)
{
#if ISP1760_THREAD_SAFE
    int err;

    err = pthread_mutex_lock(&drv->lock);
    assert(!err);
#endif

    drv->state = HC_STATE_HALT;
    // reset host controller
    ISP1760_USBCMD(drv->base_address) |= ISP1760_USBCMD_HCRESET;
    while (ISP1760_USBCMD(drv->base_address) & ISP1760_USBCMD_HCRESET);
    // disable ISP176X interrupt generation
    ISP1760_MODE_CONTROL(drv->base_address) &= ~ISP1760_HW_GLOBAL_INTR_EN;
    // detach ports from EHCI
    ISP1760_CONFIGFLAG(drv->base_address) = 0;
#if ISP1760_THREAD_SAFE
    err = pthread_mutex_unlock(&drv->lock);
    assert(!err);
#endif

    return 0;
}

extern int32_t isp1760_shutdown(isp1760_t * restrict drv)
{
    isp1760_stop(drv);
    ISP1760_USBCMD(drv->base_address) &= ~ISP1760_USBCMD_RS;
    return 0;
}

/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the ISP1760 device driver, or if already
 * initialized it just returns the driver pointer.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful - NULL otherwise
 */
extern isp1760_t *isp1760_open(int id)
{
    assert((id >= 0) && (id < DRV_ISP1760_INSTANCE_COUNT));
    isp1760_t *drv = &isp1760_drv_table[id];

    if (drv->base_address == 0)
    {
#if ISP1760_THREAD_SAFE
        pthread_attr_t      attr;
        struct sched_param  sched_param;
        pthread_mutexattr_t mutexattr;
        int                 err;
#endif
        const drv_isp1760_cfg_instance_t *drv_cfg = &drv_isp1760_instance_table[id];
        const per_isp1760_cfg_instance_t *per_isp1760_cfg = &per_isp1760_instance_table[drv_cfg->per_isp1760];
        const per_usb_intercon_cfg_instance_t *per_usb_intercon_cfg = &per_usb_intercon_instance_table[drv_cfg->per_usb_intercon];

        assert(per_isp1760_cfg->baseaddress != 0);
        assert(per_usb_intercon_cfg->interrupt0 != -1);
        drv->interrupt0 = per_usb_intercon_cfg->interrupt0;
        drv->ptdfree = UINT8_MAX;

        // Shutdown needs the baseaddress set
        // base_address is also used as initialization flag
        // set it before enabling the interrupt later
        drv->base_address = per_isp1760_cfg->baseaddress;

#ifdef __LITTLE_ENDIAN__
        ISP1760_ENDIAN(drv->base_address) = ISP1760_LITTLE_ENDIAN;  // set little endian mode.
#else
        ISP1760_ENDIAN(drv->base_address) = ISP1760_BIG_ENDIAN;     // set big endian mode.
#endif

#if ISP1760_THREAD_SAFE
        /* inititaliz mutex (shutdown uses it) */
        pthread_mutexattr_init(&mutexattr);
        // needs to be recursive because urb might be requeued from complete routine
        err = pthread_mutexattr_settype(&mutexattr, PTHREAD_MUTEX_RECURSIVE);
        assert(!err);
        err = pthread_mutex_init(&drv->lock, &mutexattr);
        assert(!err);
#endif
        // Ensure the host is in the RESET state
        isp1760_shutdown(drv);

        ISP1760_MODE_CONTROL(drv->base_address) |= ISP1760_HW_GLOBAL_INTR_EN;

#ifdef ISP1760_HWTEST
        for(uint32_t i = 0; i < UINT32_MAX; i++)
        {
            ISP1760_SCRATCH(drv->base_address) = i;
            ISP1760_MODE_CONTROL(drv->base_address) |= ISP1760_HW_GLOBAL_INTR_EN;
            if (ISP1760_SCRATCH(drv->base_address) != i)
            {
                printf("HWTEST communication error");
                exit(-1);
            }
        }
        printf("HWTEST communication succeeded");
#endif

        drv->xferdef[ISP1760_XFERDEF_ISO].ptd_base = ISP1760_ISO_MEMORY_MAP_OFFSET;
        drv->xferdef[ISP1760_XFERDEF_ISO].donemap_reg = &ISP1760_ISO_PTD_DONE_MAP(drv->base_address);
        drv->xferdef[ISP1760_XFERDEF_ISO].skipmap_reg = &ISP1760_ISO_PTD_SKIP_MAP(drv->base_address);
        drv->xferdef[ISP1760_XFERDEF_ISO].lastptd_reg = &ISP1760_ISO_PTD_LAST_PTD(drv->base_address);
        drv->xferdef[ISP1760_XFERDEF_ISO].maskor_reg = &ISP1760_ISO_IRQ_MASK_OR(drv->base_address);
        drv->xferdef[ISP1760_XFERDEF_ISO].maskand_reg = &ISP1760_ISO_IRQ_MASK_AND(drv->base_address);
        drv->xferdef[ISP1760_XFERDEF_ATL].ptd_base = ISP1760_ATL_MEMORY_MAP_OFFSET;
        drv->xferdef[ISP1760_XFERDEF_ATL].donemap_reg = &ISP1760_ATL_PTD_DONE_MAP(drv->base_address);
        drv->xferdef[ISP1760_XFERDEF_ATL].skipmap_reg = &ISP1760_ATL_PTD_SKIP_MAP(drv->base_address);
        drv->xferdef[ISP1760_XFERDEF_ATL].lastptd_reg = &ISP1760_ATL_PTD_LAST_PTD(drv->base_address);
        drv->xferdef[ISP1760_XFERDEF_ATL].maskor_reg = &ISP1760_ATL_IRQ_MASK_OR(drv->base_address);
        drv->xferdef[ISP1760_XFERDEF_ATL].maskand_reg = &ISP1760_ATL_IRQ_MASK_AND(drv->base_address);
        drv->xferdef[ISP1760_XFERDEF_INT].ptd_base = ISP1760_INT_MEMORY_MAP_OFFSET;
        drv->xferdef[ISP1760_XFERDEF_INT].donemap_reg = &ISP1760_INT_PTD_DONE_MAP(drv->base_address);
        drv->xferdef[ISP1760_XFERDEF_INT].skipmap_reg = &ISP1760_INT_PTD_SKIP_MAP(drv->base_address);
        drv->xferdef[ISP1760_XFERDEF_INT].lastptd_reg = &ISP1760_INT_PTD_LAST_PTD(drv->base_address);
        drv->xferdef[ISP1760_XFERDEF_INT].maskor_reg = &ISP1760_INT_IRQ_MASK_OR(drv->base_address);
        drv->xferdef[ISP1760_XFERDEF_INT].maskand_reg = &ISP1760_INT_IRQ_MASK_AND(drv->base_address);

#if ISP1760_THREAD_SAFE
        interrupt_configure     (drv->interrupt0, LEVEL_HIGH);
        interrupt_register      (drv->interrupt0, drv, isp1760_handler);
        interrupt_set_posix     (drv->interrupt0, true);
        interrupt_acknowledge   (drv->interrupt0);

        sched_param.sched_priority = POSIX_THREADS_MAIN_PRIORITY + 26;
        pthread_attr_init           (&attr                          );
        pthread_attr_setschedparam  (&attr, &sched_param            );
        pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED  );
        pthread_attr_setschedpolicy (&attr, SCHED_FIFO              );
#if (__POSIX_THREAD_ATTR_NAME != 0)
        pthread_attr_setname        (&attr, ISP1760_THREAD_NAME     );
#endif

        err = pthread_cond_init(&drv->startup_cond, NULL);
        assert(!err);
        err = pthread_mutex_init(&drv->startup_mutex, NULL);
        assert(!err);
        err = pthread_mutex_lock(&drv->startup_mutex);
        assert(!err);
        if (pthread_create( &drv->handlerThreadId, &attr, isp1760_handler_thread, (void *)drv) != 0)
        {
            assert(0);
            return NULL;
        }
        err = pthread_cond_wait(&drv->startup_cond, &drv->startup_mutex);
        assert(!err);
        err = pthread_mutex_unlock(&drv->startup_mutex);
        assert(!err);
#else /* ISP1760_THREAD_SAFE */
        interrupt_register_native(drv->interrupt0, (void *)drv, isp1760_handler);
        interrupt_configure(drv->interrupt0, LEVEL_HIGH);
        interrupt_enable(drv->interrupt0);
#endif /* else ISP1760_THREAD_SAFE */
    }

    return drv;
}

extern int32_t isp1760_get_interrupt(isp1760_t *drv)
{
    return drv->interrupt0;
}

