/*****************************************************************************
|*  @file
|*
|*  Copyright:    Copyright (c) 2009, Altium
|*
|*  Description:  Device driver for ISP1760 USB Host Controller peripheral
|*                This driver is a reflection of technical information
|*                contained in the following documents.
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
|*
\*****************************************************************************/

#pragma optimize O1

#define ENABLE_ISO_SUPPORT      0

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

#include <genericlist.h>

#define htonl(value) value
#define ntohl(value) value

#define PM_CHUNK_SIZE_COUNT 3

#define PM_CHUNK_1_COUNT    32
#define PM_CHUNK_2_COUNT    20
#define PM_CHUNK_3_COUNT     4

#define PM_CHUNK_1_SIZE    256
#define PM_CHUNK_2_SIZE    1024
#define PM_CHUNK_3_SIZE    8192

#define URB_COMPLETE_NOTIFY (1 << 0)
#define URB_ENQUEUED        (1 << 1)
#define URB_TYPE_ATL        (1 << 2)
#define URB_TYPE_INT        (1 << 3)
#define URB_TYPE_ISO        (1 << 4)

typedef struct {
    uint32_t     idx_count;
    uint32_t     base_addr;
    uint8_t      base_idx;
    uint8_t      block_count[8];
    uint32_t     block_size[8];
    uint32_t     block_free[8];
} isp1760_payload_map_t;


typedef struct isp1760_qtd_s
{
    struct isp1760_qtd_s *hw_next;
    uint8_t packet_type;
    uint8_t toggle;
    void *data_buffer;
    GenericListHead_t qtd_list;
    usbhost_urb_t *urb;
    size_t length;
    uint32_t status;
#if ENABLE_ISO_SUPPORT
    uint32_t frame_number;
    uint32_t index;
    uint32_t ssplit;
    uint32_t csplit;
#endif
} isp1760_qtd_t;


typedef struct
{
    GenericListHead_t qtd_list;
#define DEFAULT_I_TDPS      1024
    uint16_t period;    
    usbhost_device_t *dev;
    uint32_t toggle;
    uint32_t ping;

#if ENABLE_ISO_SUPPORT
    uint32_t ssplit;
    uint32_t csplit;
#endif
} isp1760_qh_t;


typedef struct
{
    void *data_buffer;
    uint32_t payload;
#define PTD_FIRE_NEXT       (1 << 0)
#define PTD_URB_FINISHED    (1 << 1)
    usbhost_urb_t *urb;
    isp1760_qh_t *qh;
    isp1760_qtd_t *qtd;
} isp1760_inter_packet_info_t;


struct isp1760_s
{
    uintptr_t base_address;
    uint8_t interrupt0;

    uint32_t state;
    isp1760_payload_map_t payloadMap;

    isp1760_inter_packet_info_t atl_ints[32];
    isp1760_inter_packet_info_t int_ints[32];

    uint32_t hcs_params;
    uint32_t periodic_size;
    uint32_t i_thresh;
    uint32_t reset_done;
    uint32_t next_state_change;
    uint32_t dev_flags;
};

isp1760_t isp1760_drv_table[DRV_ISP1760_INSTANCE_COUNT];

typedef void (packet_enqueue_t) (isp1760_t * restrict drv, isp1760_qh_t * qh, isp1760_qtd_t * qtd);

static void isp1760_writecopymem(uint32_t * dst, uint32_t * src, size_t count, bool swap);
static void isp1760_readcopymem(uint32_t * dst, uint32_t * src, size_t count, bool swap);
static void isp1760_preinit(isp1760_t * restrict drv);

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

static void isp1760_payloadmap_init(isp1760_payload_map_t * pm)
{
    pm->idx_count = 3;

    pm->base_addr = ISP1760_PAYLOAD_MEMORY_MAP_OFFSET;

    pm->block_count[0] = PM_CHUNK_1_COUNT;
    pm->block_count[1] = PM_CHUNK_2_COUNT;
    pm->block_count[2] = PM_CHUNK_3_COUNT;

    pm->block_size[0] = PM_CHUNK_1_SIZE;
    pm->block_size[1] = PM_CHUNK_2_SIZE;
    pm->block_size[2] = PM_CHUNK_3_SIZE;

    pm->block_free[0] = 0xFFFFFFFF;
    pm->block_free[1] = 0xFFFFFFFF;
    pm->block_free[2] = 0xFFFFFFFF;
}

static uint32_t isp1760_payloadmap_alloc(uint32_t size, isp1760_payload_map_t *pm)
{
    uint32_t i;
    uint32_t chunk  = 0;
    uint32_t offset = 0;

    for(i=0;i<pm->idx_count;i++){
        if(size <= pm->block_size[i]){
            if(!pm->block_free[i]) continue;
            chunk = FFS32(pm->block_free[i]);
            if((chunk < pm->block_count[i])){
                pm->block_free[i] &= ~(1<<chunk);
                return pm->base_addr + offset + (chunk * pm->block_size[i]);
            } else {
                continue;
            }
        }
        offset += (pm->block_size[i] * pm->block_count[i]);
    }

    return 0xFFFFFFFF;
}

void isp1760_payloadmap_free(uint32_t mem, isp1760_payload_map_t *pm)
{
    uint32_t i;
    uint32_t chunk;

    if(mem < pm->base_addr) return;

    mem -= pm->base_addr;

    for(i=0;i<pm->idx_count;i++){
        if(mem < (pm->block_size[i] * pm->block_count[i])){
            chunk = mem / pm->block_size[i];
            pm->block_free[i] |= (1<<chunk);
            return;
        }
        mem -= (pm->block_size[i] * pm->block_count[i]);
    }
}

static void isp1760_readcopymem(uint32_t * dst, uint32_t * src, size_t count, bool swap)
{
    uint32_t val;
    uint8_t *buf;

    if (swap)
    {
        while (count >= 4)
        {
            *dst++ = little32(*src++);
            count -= 4;
        }

        if (!count)
            return;

        val = (*src);

        buf = (uint8_t *) dst;
        while (count--)
        {
            *buf++ = (uint8_t) val;
            val >>= 8;
        }
    }
    else
    {
        while (count >= 4)
        {
            *dst++ = (*src++);
            delay_ns(1000);
            count -= 4;
        }

        if (!count)
            return;

        val = (*src);
        val = little32(val);

        buf = (uint8_t *) dst;
        while (count--)
        {
            *buf++ = (uint8_t) val;
            val >>= 8;
        }
    }
}

static void isp1760_writecopymem(uint32_t * dst, uint32_t * src, size_t count, bool swap)
{
    if (swap)
    {
        while (count >= 4)
        {
            *dst++ = little32(*src++);
            count -= 4;
        }

        if (!count)
            return;

        *dst = little32(*src);
    }
    else
    {
        while (count >= 4)
        {
            *dst++ = (*src++);
            count -= 4;
        }

        if (!count)
            return;

        *dst = (*src);
    }
}

static uint32_t isp1760_base_to_internal(uint32_t base)
{
    return ((base - 0x400) >> 3);
}

static void isp1760_qhfree(isp1760_qh_t * qh)
{
    free(qh);
}

static isp1760_qh_t *isp1760_qhalloc(isp1760_t * restrict drv)
{
    isp1760_qh_t *qh;

    qh = calloc(sizeof(isp1760_qh_t), 1);
    if (!qh)
        return qh;

    INIT_LIST_HEAD(&qh->qtd_list);

    return qh;
}

static uint32_t isp1760_handshake(isp1760_t * restrict drv, volatile uint32_t *isp1760Reg, uint32_t mask, uint32_t done,
                                  int32_t usec)
{
    uint32_t result;

    do
    {
        result = *isp1760Reg;
        if (result == ~0)
            return -ENODEV;
        result &= mask;
        if (result == done)
            return 0;
        delay_us(1);
        usec--;
    }
    while (usec > 0);
    return -ETIMEDOUT;
}

static int32_t isp1760_resetehci(isp1760_t * restrict drv)
{
    int32_t retval;

    uint32_t command = ISP1760_USBCMD(drv->base_address);
    command |= ISP1760_CMD_RESET;
    ISP1760_USBCMD(drv->base_address) = command;

    drv->state = HC_STATE_HALT;

    retval = isp1760_handshake(drv, &ISP1760_USBCMD(drv->base_address), ISP1760_CMD_RESET, 0, 250 * 1000);
    return retval;
}

static void isp1760_init_regs(isp1760_t * restrict drv)
{
    ISP1760_BUFFER_STAT(drv->base_address) = 0x00000000;

    ISP1760_ATL_PTD_SKIP_MAP(drv->base_address) = ISP1760_NO_TRANSFER_ACTIVE;
    ISP1760_INT_PTD_SKIP_MAP(drv->base_address) = ISP1760_NO_TRANSFER_ACTIVE;
    ISP1760_ISO_PTD_SKIP_MAP(drv->base_address) = ISP1760_NO_TRANSFER_ACTIVE;

    ISP1760_ATL_PTD_DONE_MAP(drv->base_address) = ~ISP1760_NO_TRANSFER_ACTIVE;
    ISP1760_INT_PTD_DONE_MAP(drv->base_address) = ~ISP1760_NO_TRANSFER_ACTIVE;
    ISP1760_ISO_PTD_DONE_MAP(drv->base_address) = ~ISP1760_NO_TRANSFER_ACTIVE;
}

extern int32_t isp1760_reset(isp1760_t * restrict drv)
{
    static uint32_t scratch;
    uint32_t hwMode;
    isp1760_preinit(drv);

    hwMode = ISP1760_HW_DATA_BUS_32BIT;

    if (drv->dev_flags & ISP1760_FLAG_BUS_WIDTH_16)
        hwMode &= ~ISP1760_HW_DATA_BUS_32BIT;
    if (drv->dev_flags & ISP1760_FLAG_ANALOG_OC)
        hwMode |= ISP1760_HW_ANA_DIGI_OC;
    if (drv->dev_flags & ISP1760_FLAG_DACK_POL_HIGH)
        hwMode |= ISP1760_HW_DACK_POL_HIGH;
    if (drv->dev_flags & ISP1760_FLAG_DREQ_POL_HIGH)
        hwMode |= ISP1760_HW_DREQ_POL_HIGH;
    if (drv->dev_flags & ISP1760_FLAG_INTR_POL_HIGH)
        hwMode |= ISP1760_HW_INTR_HIGH_ACT;
    if (drv->dev_flags & ISP1760_FLAG_INTR_EDGE_TRIG)
        hwMode |= ISP1760_HW_INTR_EDGE_TRIG;

    ISP1760_MODE_CONTROL(drv->base_address) = hwMode;
    ISP1760_MODE_CONTROL(drv->base_address) = hwMode;

    ISP1760_SCRATCH(drv->base_address) = 0xFABB00B5;

    scratch = ISP1760_CHIP_ID(drv->base_address);
    scratch = ISP1760_SCRATCH(drv->base_address);

    if (scratch != 0xFABB00B5)
    {
#if DEBUG_DRV_ISP1760
        printf("isp1760: Scratch test failed.\n");
#endif
        return -ENODEV;
    }


    isp1760_init_regs(drv);


    ISP1760_MODE_CONTROL(drv->base_address) = hwMode | ISP1760_ALL_ATX_RESET;
    delay_ms(10);
    ISP1760_MODE_CONTROL(drv->base_address) = hwMode;

    ISP1760_INT(drv->base_address) = ISP1760_INTERRUPT_ENABLE_MASK;
    ISP1760_INT_ENABLE(drv->base_address) = ISP1760_INTERRUPT_ENABLE_MASK;

    if (!(drv->dev_flags & ISP1760_FLAG_ISP1761) && !(drv->dev_flags & ISP1760_FLAG_PORT1_DIS))
    {
        ISP1760_PORT1_CONTROL(drv->base_address) = ISP1760_PORT1_POWER | ISP1760_PORT1_INIT2;
        delay_us(10);
    }

    drv->hcs_params = ISP1760_HCSPARAMS(drv->base_address);

#if DEBUG_DRV_ISP1760
    printf("isp1760_init(): Completed Successfully.\n");
#endif

    return 0;
}

static void isp1760_init_maps(isp1760_t * restrict drv)
{
    ISP1760_ATL_PTD_LAST_PTD(drv->base_address) = 0x80000000;
    ISP1760_INT_PTD_LAST_PTD(drv->base_address) = 0x80000000;
    ISP1760_ISO_PTD_LAST_PTD(drv->base_address) = 0x00000001;
}

static void isp1760_enable_interrupts(isp1760_t * restrict drv)
{
    ISP1760_ATL_IRQ_MASK_AND(drv->base_address) = 0x00000000;
    ISP1760_ATL_IRQ_MASK_OR(drv->base_address) = 0x00000000;
    ISP1760_INT_IRQ_MASK_AND(drv->base_address) = 0x00000000;
    ISP1760_INT_IRQ_MASK_OR(drv->base_address) = 0x00000000;
    ISP1760_ISO_IRQ_MASK_AND(drv->base_address) = 0x00000000;
    ISP1760_ISO_IRQ_MASK_OR(drv->base_address) = 0xFFFFFFFF;
}

int32_t isp1760_start(isp1760_t * restrict drv)
{
    int32_t retval;
    uint32_t temp;
    uint32_t command;
    uint32_t chipid;

    drv->state = HC_STATE_RUNNING;

    isp1760_enable_interrupts(drv);

    temp = ISP1760_MODE_CONTROL(drv->base_address);
    ISP1760_MODE_CONTROL(drv->base_address) = temp | ISP1760_HW_GLOBAL_INTR_EN;

    command = ISP1760_USBCMD(drv->base_address);
    command &= ~(ISP1760_CMD_LRESET | ISP1760_CMD_RESET);
    command |= ISP1760_CMD_RUN;
    ISP1760_USBCMD(drv->base_address) = command;

    retval = isp1760_handshake(drv, &ISP1760_USBCMD(drv->base_address), ISP1760_CMD_RUN, ISP1760_CMD_RUN, 250 * 1000);
    if (retval)
        return retval;

    ISP1760_CONFIGFLAG(drv->base_address) = ISP1760_FLAG_CF;

    retval = isp1760_handshake(drv, &ISP1760_CONFIGFLAG(drv->base_address), ISP1760_FLAG_CF, ISP1760_FLAG_CF, 250 * 1000);

    if (retval)
        return retval;

    chipid = ISP1760_CHIP_ID(drv->base_address);

    isp1760_init_maps(drv);

    {
        uint32_t data;
        uint32_t PORTSC1;

        ISP1760_PORTSC1(drv->base_address) = 0x00001000;

        do
        {
            data = ISP1760_PORTSC1(drv->base_address);
        }
        while (!(data & 0x000000002));

        PORTSC1 = ISP1760_PORTSC1(drv->base_address);
        ISP1760_PORTSC1(drv->base_address) = PORTSC1 | 0x00000002;

        ISP1760_PORTSC1(drv->base_address) = 0x00001901;

        delay_ms(50);

        ISP1760_PORT1_CONTROL(drv->base_address) = 0x00000018;    
        ISP1760_PORT1_CONTROL(drv->base_address) = 0x00000098;    
        ISP1760_PORT1_CONTROL(drv->base_address) = 0x00800018;    

        PORTSC1 = ISP1760_PORTSC1(drv->base_address);
        ISP1760_PORTSC1(drv->base_address) = PORTSC1 & (~0x00000100);

    }

    return 0;
}

static void isp1760_transform_in_to_atl(isp1760_t * restrict drv, isp1760_qh_t * qh,
                                     isp1760_qtd_t * qtd, usbhost_urb_t * urb, uint32_t payload, isp1760_ptd_t * ptd)
{
    uint32_t dw0;
    uint32_t dw1;
    uint32_t dw2;
    uint32_t dw3;
    uint32_t max_packet;
    uint32_t multi;
    uint32_t pid_code;
    uint32_t rl = ISP1760_RL_COUNTER;
    uint32_t nak = ISP1760_NAK_COUNTER;
    uint32_t epNum;

    max_packet = little16(urb->ep->desc.wMaxPacketSize);

    multi = 1 + ((max_packet >> 11) & 0x3);
    max_packet &= 0x7ff;

    epNum = (urb->ep->desc.bEndpointAddress & 0x0F);

    dw0 = ISP1760_PTD_VALID;
    dw0 |= ISP1760_PTD_LENGTH(qtd->length);
    dw0 |= ISP1760_PTD_MAXPACKET(max_packet);
    dw0 |= ISP1760_PTD_ENDPOINT(epNum);
    dw1 = epNum >> 1;

    dw1 |= ISP1760_PTD_DEVICE_ADDR(urb->dev->devNum);

    pid_code = qtd->packet_type;
    dw1 |= ISP1760_PTD_PID_TOKEN(pid_code);

    if (USBHOST_ISBULKEP(urb->ep->desc.bmAttributes))
        dw1 |= ISP1760_PTD_TRANS_BULK;
    else if (USBHOST_ISINTEP(urb->ep->desc.bmAttributes))
        dw1 |= ISP1760_PTD_TRANS_INT;

    if (urb->dev->speed != USBHOST_SPEED_HIGH)
    {
        dw1 |= ISP1760_PTD_TRANS_SPLIT;
        if (urb->dev->speed == USBHOST_SPEED_LOW)
            dw1 |= ISP1760_PTD_SE_USB_LOSPEED;

        dw1 |= ISP1760_PTD_PORT_NUM(urb->dev->ttport);
        dw1 |= ISP1760_PTD_HUB_NUM(urb->dev->parent->devNum);

        if (USBHOST_ISINTEP(urb->ep->desc.bmAttributes) && (urb->dev->speed == USBHOST_SPEED_LOW))
            dw1 |= 2 << 16;

        dw3 = 0;
        rl = 0;
        nak = 0;

    }
    else
    {
        dw0 |= ISP1760_PTD_MULTI(multi);
        if (USBHOST_ISCONTROLEP(urb->ep->desc.bmAttributes) || USBHOST_ISBULKEP(urb->ep->desc.bmAttributes))
        {
            dw3 = qh->ping;
        }
        else
        {
            dw3 = 0;
        }
    }
    dw2 = 0;
    dw2 |= ISP1760_PTD_DATA_START_ADDR(isp1760_base_to_internal(payload));
    dw2 |= ISP1760_PTD_RL_CNT(rl);
    dw3 |= ISP1760_PTD_NAC_CNT(nak);

    if (USBHOST_ISCONTROLEP(urb->ep->desc.bmAttributes))
    {
        dw3 |= ISP1760_PTD_DATA_TOGGLE(qtd->toggle);
    }
    else
    {
        dw3 |= qh->toggle;
    }

    dw3 |= ISP1760_PTD_ACTIVE;
    dw3 |= ISP1760_PTD_CERR(ISP1760_ERR_COUNTER);

    memset(ptd, 0, sizeof(*ptd));

    ptd->dw0 = cpu_to_le32(dw0);
    ptd->dw1 = cpu_to_le32(dw1);
    ptd->dw2 = cpu_to_le32(dw2);
    ptd->dw3 = cpu_to_le32(dw3);

}

static void isp1760_transform_add_int(isp1760_t * restrict drv,
                                    isp1760_qh_t * qh,
                                    isp1760_qtd_t * qtd, usbhost_urb_t * urb, uint32_t payload, isp1760_ptd_t * ptd)
{
    uint32_t max_packet;
    uint32_t multi;
    uint32_t number_of_usofs;
    uint32_t i;
    uint32_t usofmask, usof;
    uint32_t period;

    max_packet = little16(urb->ep->desc.wMaxPacketSize);
    multi = 1 + ((max_packet >> 11) & 0x3);
    max_packet &= 0x7ff;

    max_packet = multi * max_packet;

    number_of_usofs = urb->xferBufSize / max_packet;
    if (urb->xferBufSize % max_packet)
        number_of_usofs += 1;

    usofmask = 1;
    usof = 0;
    for (i = 0; i < number_of_usofs; i++)
    {
        usof |= usofmask;
        usofmask <<= 1;
    }

    if (urb->dev->speed != USBHOST_SPEED_HIGH)
    {
        ptd->dw5 = cpu_to_le32(0x1c);

        if (qh->period >= 32)
            period = qh->period / 2;
        else
            period = qh->period;

    }
    else
    {

        if (qh->period >= 8)
            period = qh->period / 8;
        else
            period = qh->period;

        if (period >= 32)
            period = 16;

        if (qh->period >= 8)
        {
            period = (period << 3);
        }
        else
        {
            usof = 0x11;
        }
    }

    ptd->dw2 |= cpu_to_le32(period);
    ptd->dw4 = cpu_to_le32(usof);
}

static void isp1760_transform_in_to_int(isp1760_t * restrict drv,
                                     isp1760_qh_t * qh,
                                     isp1760_qtd_t * qtd, usbhost_urb_t * urb, uint32_t payload, isp1760_ptd_t * ptd)
{
    isp1760_transform_in_to_atl(drv, qh, qtd, urb, payload, ptd);
    isp1760_transform_add_int(drv, qh, qtd, urb, payload, ptd);
}

static int32_t isp1760_qtdfill(isp1760_qtd_t * qtd, void *databuffer, size_t len, uint32_t token)
{
    int count;

    qtd->data_buffer = databuffer;
    qtd->packet_type = ISP1760_GET_QTD_TOKEN_TYPE(token);
    qtd->toggle = ISP1760_GET_DATA_TOGGLE(token);

    if (len > ISP1760_HC_ATL_PL_SIZE)
        count = ISP1760_HC_ATL_PL_SIZE;
    else
        count = len;

    qtd->length = count;
    return count;
}

static int isp1760_check_error(isp1760_ptd_t * ptd)
{
    int32_t error = 0;
    uint32_t dw3;

    dw3 = le32_to_cpu(ptd->dw3);
    if (dw3 & ISP1760_DW3_SC_BIT)
    {
#if DEBUG_DRV_ISP1760
        printf("SC Set\n");
#endif
    }

    if (dw3 & ISP1760_DW3_HALT_BIT)
    {
#if DEBUG_DRV_ISP1760
        printf("Halt Bit Set\n");
#endif
        error = -EPIPE;
    }

    if (dw3 & ISP1760_DW3_ERROR_BIT)
    {
#if DEBUG_DRV_ISP1760
        printf("error bit is set in DW3\n");
#endif
        if (!error)
        {
            error = -EBUSY;
        }
    }

    if (dw3 & ISP1760_DW3_QTD_ACTIVE)
    {
#if DEBUG_DRV_ISP1760
        printf("transfer active bit is set DW3\n");
#endif
    }

    return error;
}

static void isp1760_enqueue_one_qtd(isp1760_qtd_t * qtd, isp1760_t * restrict drv, uint32_t payload)
{
    uint32_t token;

    token = qtd->packet_type;

    if (qtd->length && (qtd->length <= ISP1760_HC_ATL_PL_SIZE))
    {
        switch (token)
        {
        case ISP1760_IN_PID:
            break;
        case ISP1760_OUT_PID:
        case ISP1760_SETUP_PID:
            isp1760_writecopymem((uint32_t *) (drv->base_address + payload), qtd->data_buffer, qtd->length, true);
        }
    }
}

static void isp1760_enqueue_one_atl_qtd(uint32_t atl_regs, uint32_t payload, isp1760_t * restrict drv,
                                     isp1760_qh_t * qh, usbhost_urb_t * urb, uint32_t slot, isp1760_qtd_t * qtd)
{
    isp1760_ptd_t ptd;

    isp1760_transform_in_to_atl(drv, qh, qtd, urb, payload, &ptd);

    isp1760_writecopymem((uint32_t *) (drv->base_address + atl_regs), (uint32_t *) & ptd, sizeof(ptd), false);

    isp1760_enqueue_one_qtd(qtd, drv, payload);

    drv->atl_ints[slot].urb = urb;
    drv->atl_ints[slot].qh = qh;
    drv->atl_ints[slot].qtd = qtd;
    drv->atl_ints[slot].data_buffer = qtd->data_buffer;
    drv->atl_ints[slot].payload = payload;

    qtd->status |= URB_ENQUEUED | URB_TYPE_ATL;
    qtd->status |= slot << 16;
}

static void isp1760_enqueue_one_int_qtd(uint32_t int_regs, uint32_t payload, isp1760_t * restrict drv,
                                     isp1760_qh_t * qh, usbhost_urb_t * urb, uint32_t slot, isp1760_qtd_t * qtd)
{
    isp1760_ptd_t ptd;

    isp1760_transform_in_to_int(drv, qh, qtd, urb, payload, &ptd);


    isp1760_writecopymem((uint32_t *) (drv->base_address + int_regs), (uint32_t *) & ptd, sizeof(ptd), false);


    isp1760_enqueue_one_qtd(qtd, drv, payload);

    drv->int_ints[slot].urb = urb;
    drv->int_ints[slot].qh = qh;
    drv->int_ints[slot].qtd = qtd;
    drv->int_ints[slot].data_buffer = qtd->data_buffer;
    drv->int_ints[slot].payload = payload;

    qtd->status |= URB_ENQUEUED | URB_TYPE_INT;
    qtd->status |= slot << 16;
}

#if ENABLE_ISO_SUPPORT
static void isp1760_enqueueoneisoqtd(uint32_t int_regs, uint32_t payload, isp1760_t * restrict drv,
                                     isp1760_qh_t * qh, usbhost_urb_t * urb, uint32_t slot, isp1760_qtd_t * qtd)
{
    isp1760_ptd_t ptd;

    isp1760_transform_in_to_int(drv, qh, qtd, urb, payload, &ptd);
    isp1760_writecopymem((uint32_t *) (drv->base_address + int_regs), (uint32_t *) & ptd, sizeof(ptd), false);
    isp1760_enqueue_one_qtd(qtd, drv, payload);

    drv->int_ints[slot].urb = urb;
    drv->int_ints[slot].qh = qh;
    drv->int_ints[slot].qtd = qtd;
    drv->int_ints[slot].data_buffer = qtd->data_buffer;
    drv->int_ints[slot].payload = payload;

    qtd->status |= URB_ENQUEUED | URB_TYPE_ISO;
    qtd->status |= slot << 16;
}
#endif

static void isp1760_enqueue_an_atl_packet(isp1760_t * restrict drv, isp1760_qh_t * qh, isp1760_qtd_t * qtd)
{
    uint32_t skip_map, or_map;
    uint32_t queue_entry;
    uint32_t slot;
    uint32_t atl_regs, payload;
    uint32_t buffstatus;

    skip_map = ISP1760_ATL_PTD_SKIP_MAP(drv->base_address);


    slot = FFS32(skip_map);
    queue_entry = 1 << slot;

    atl_regs = ISP1760_ATL_MEMORY_MAP_OFFSET + slot * sizeof(isp1760_ptd_t);

    payload = isp1760_payloadmap_alloc(qtd->length, &drv->payloadMap);

    isp1760_enqueue_one_atl_qtd(atl_regs, payload, drv, qh, qtd->urb, slot, qtd);

    or_map = ISP1760_ATL_IRQ_MASK_OR(drv->base_address);
    or_map |= queue_entry;
    ISP1760_ATL_IRQ_MASK_OR(drv->base_address) = or_map;

    skip_map &= ~queue_entry;
    ISP1760_ATL_PTD_SKIP_MAP(drv->base_address) = skip_map;

    buffstatus = ISP1760_BUFFER_STAT(drv->base_address);
    buffstatus |= ISP1760_ATL_BUFFER;
    ISP1760_BUFFER_STAT(drv->base_address) = buffstatus;
}

static void isp1760_enqueue_an_int_packet(isp1760_t * restrict drv, isp1760_qh_t * qh, isp1760_qtd_t * qtd)
{
    uint32_t skip_map, or_map;
    uint32_t queue_entry;
    uint32_t slot;
    uint32_t int_regs, payload;
    uint32_t buffstatus;

    skip_map = ISP1760_INT_PTD_SKIP_MAP(drv->base_address);

    slot = FFS32(skip_map);
    queue_entry = 1 << slot;

    int_regs = ISP1760_INT_MEMORY_MAP_OFFSET + slot * sizeof(isp1760_ptd_t);

    payload = isp1760_payloadmap_alloc(qtd->length, &drv->payloadMap);

    isp1760_enqueue_one_int_qtd(int_regs, payload, drv, qh, qtd->urb, slot, qtd);

    or_map = ISP1760_INT_IRQ_MASK_OR(drv->base_address);
    or_map |= queue_entry;
    ISP1760_INT_IRQ_MASK_OR(drv->base_address) = or_map;

    skip_map &= ~queue_entry;
    ISP1760_INT_PTD_SKIP_MAP(drv->base_address) = skip_map;

    buffstatus = ISP1760_BUFFER_STAT(drv->base_address);
    buffstatus |= ISP1760_INT_BUFFER;

    ISP1760_BUFFER_STAT(drv->base_address) = buffstatus;

}

#if ENABLE_ISO_SUPPORT
static void isp1760_enqueue_an_iso_packet(isp1760_t * restrict drv, isp1760_qh_t * qh, isp1760_qtd_t * qtd)
{
    uint32_t skip_map, or_map, last_map;
    uint32_t queue_entry;
    uint32_t slot;
    uint32_t int_regs, payload;
    uint32_t buffstatus;

    skip_map = ISP1760_ISO_PTD_SKIP_MAP(drv->base_address);


    last_map = ISP1760_ISO_PTD_LAST_PTD(drv->base_address);

    slot = FFS32(skip_map);
    queue_entry = 1 << slot;

    int_regs = ISP1760_ISO_MEMORY_MAP + slot * sizeof(isp1760_ptd_t);

    payload = isp1760_payloadmap_alloc(qtd->length, &drv->payloadMap);

    isp1760_enqueueoneisoqtd(int_regs, payload, drv, qh, qtd->urb, slot, qtd);

    or_map = ISP1760_ISO_IRQ_MASK_OR(drv->base_address);
    or_map |= queue_entry;
    ISP1760_ISO_IRQ_MASK_OR(drv->base_address) = or_map;

    skip_map &= ~queue_entry;
    ISP1760_ISO_PTD_SKIP_MAP(drv->base_address) = skip_map;

    last_map |= queue_entry;
    ISP1760_ISO_PTD_LAST_PTD(drv->base_address) = last_map;

    buffstatus = ISP1760_BUFFER_STAT(drv->base_address);
    buffstatus |= ISP1760_ISO_BUFFER;

    ISP1760_BUFFER_STAT(drv->base_address) = buffstatus;

}
#endif

static int32_t isp1760_endpoint_attach_urb(isp1760_t * restrict drv, usbhost_urb_t *urb)
{
    int32_t retVal = 0;

    if(!urb->ep->enabled){
        retVal = -EPERM;
        goto done;
    }

    switch (drv->state)
    {
    case HC_STATE_RUNNING:
    case HC_STATE_RESUMING:
         urb->owner = URB_OWNER_HOST;
         break;
    default:
         retVal = -ESHUTDOWN;
         goto done;
    }

done:
    return retVal;
}

static int32_t isp1760_endpoint_detach_urb(usbhost_urb_t *urb)
{
    int32_t retVal = 0;
    urb->owner = URB_OWNER_CREATOR;
    return retVal;
}

static void isp1760_urb_done(isp1760_t * restrict drv, usbhost_urb_t * urb, int32_t status)
{
    if (urb->owner == URB_OWNER_HOST)
    {
        if (status == -EINPROGRESS)
            status = 0;
    }

    isp1760_endpoint_detach_urb(urb);
    spin_unlock(&drv->lock);
    urb->OnComplete(urb);
    spin_lock(&drv->lock);
}

static isp1760_qtd_t *isp1760_qtdalloc(void)
{
    isp1760_qtd_t *qtd;

    qtd = (isp1760_qtd_t *) calloc(sizeof(isp1760_qtd_t), 1);
    if (qtd)
    {
        INIT_LIST_HEAD(&qtd->qtd_list);
    }

    return qtd;
}

static void isp1760_qtdfree(isp1760_qtd_t * qtd)
{
    free(qtd);
}

static isp1760_qtd_t *isp1760_clean_this_qtd(isp1760_qtd_t * qtd)
{
    isp1760_qtd_t *tmp_qtd;

    tmp_qtd = qtd->hw_next;
    list_del(&qtd->qtd_list);
    isp1760_qtdfree(qtd);
    return tmp_qtd;
}

static isp1760_qtd_t *isp1760_cleanup_qtd_list(isp1760_qtd_t * qtd)
{
    isp1760_qtd_t *tmp_qtd;
    int32_t last_one;

    do
    {
        tmp_qtd = qtd->hw_next;
        last_one = qtd->status & URB_COMPLETE_NOTIFY;
        list_del(&qtd->qtd_list);
        isp1760_qtdfree(qtd);
        qtd = tmp_qtd;
    }
    while (!last_one && qtd);

    return qtd;
}

static void isp1760_do_atl_int(isp1760_t * restrict drv)
{
    isp1760_ptd_t ptd;
    usbhost_urb_t *urb = NULL;
    isp1760_qtd_t *qtd;
    isp1760_qh_t *qh;

    uint32_t done_map;
    uint32_t skip_map;
    uint32_t atl_regs_base;
    uint32_t atl_regs;
    uint32_t queue_entry;
    uint32_t payload;
    uint32_t length;
    uint32_t or_map;
    int32_t error;
    uint32_t rl;
    uint32_t nak_count;

    done_map = ISP1760_ATL_PTD_DONE_MAP(drv->base_address);
    skip_map = ISP1760_ATL_PTD_SKIP_MAP(drv->base_address);

    or_map = ISP1760_ATL_IRQ_MASK_OR(drv->base_address);
    or_map &= ~done_map;
    ISP1760_ATL_IRQ_MASK_OR(drv->base_address) = or_map;

    atl_regs_base = ISP1760_ATL_MEMORY_MAP_OFFSET;
    while (done_map)
    {
        uint32_t dw1;
        uint32_t dw2;
        uint32_t dw3;

        queue_entry = FFS32(done_map);
        done_map &= ~(1 << queue_entry);
        skip_map |= 1 << queue_entry;

        atl_regs = atl_regs_base + queue_entry * sizeof(isp1760_ptd_t);

        urb = drv->atl_ints[queue_entry].urb;
        qtd = drv->atl_ints[queue_entry].qtd;
        qh = drv->atl_ints[queue_entry].qh;
        payload = drv->atl_ints[queue_entry].payload;

        if (!qh)
        {
            continue;
        }

        ISP1760_MEMORY(drv->base_address) = atl_regs + ISP1760_MEM_BANK(0);
        ISP1760_MEMORY(drv->base_address) = payload + ISP1760_MEM_BANK(1);
        ISP1760_MEMORY(drv->base_address) = payload + ISP1760_MEM_BANK(1);

        isp1760_readcopymem((uint32_t *) & ptd, (uint32_t *) (drv->base_address + atl_regs + ISP1760_MEM_BANK(0)),
                            sizeof(isp1760_ptd_t), 0);


        dw1 = le32_to_cpu(ptd.dw1);
        dw2 = le32_to_cpu(ptd.dw2);
        dw3 = le32_to_cpu(ptd.dw3);

        rl = (dw2 >> 25) & 0x0f;
        nak_count = (dw3 >> 19) & 0xf;

        if ((dw3 & ISP1760_DW3_ERROR_BIT) && (dw3 & ISP1760_DW3_QTD_ACTIVE) && !(dw3 & ISP1760_DW3_HALT_BIT))
        {
            length = ISP1760_PTD_XFERRED_LENGTH(dw3);
        }

        if (!nak_count && (dw3 & ISP1760_DW3_QTD_ACTIVE))
        {


        }

        error = isp1760_check_error(&ptd);
        if (error)
        {
            if (error == -EPIPE)
            {
                drv->atl_ints[queue_entry].qh->toggle = 0;
                drv->atl_ints[queue_entry].qh->ping = 0;
            }
            urb->status = error;
        }
        else
        {
            if (USBHOST_ISBULKEP(urb->ep->desc.bmAttributes))
            {
                drv->atl_ints[queue_entry].qh->ping = dw3 & (1 << 26);
                drv->atl_ints[queue_entry].qh->toggle = dw3 & ( 1 << 25);
                if (dw3 & (1 << 26))
                {
                    __nop();
                }
            }
        }

        length = ISP1760_PTD_XFERRED_LENGTH(dw3);
        if (length)
        {
            switch (ISP1760_DW1_GET_PID(dw1))
            {
            case ISP1760_IN_PID:
                isp1760_readcopymem(drv->atl_ints[queue_entry].data_buffer,
                                    (uint32_t *) (drv->base_address + payload + ISP1760_MEM_BANK(1)), length, 1);
                /* fallthrough */
            case ISP1760_OUT_PID:
                urb->xferActual += length;
                /* fallthrough */
            case ISP1760_SETUP_PID:
                break;
            }
        }

        drv->atl_ints[queue_entry].data_buffer = NULL;
        drv->atl_ints[queue_entry].urb = NULL;
        drv->atl_ints[queue_entry].qtd = NULL;
        drv->atl_ints[queue_entry].qh = NULL;

        ISP1760_ATL_PTD_SKIP_MAP(drv->base_address) = skip_map;
        isp1760_payloadmap_free(payload, &drv->payloadMap);

        if (urb->status == -EPIPE || urb->status == -EBUSY)
        {
            qtd = isp1760_cleanup_qtd_list(qtd);
            isp1760_urb_done(drv, urb, urb->status);

        }
        else if (USBHOST_ISBULKEP(urb->ep->desc.bmAttributes) && (length < qtd->length))
        {
            if (urb->xferFlags & URB_SHORT_NOT_OK)
            {
                urb->status = -EREMOTEIO;
            }

            if (urb->status == -EINPROGRESS)
            {
                urb->status = 0;
            }

            qtd = isp1760_cleanup_qtd_list(qtd);

            isp1760_urb_done(drv, urb, urb->status);
        }
        else if (qtd->status & URB_COMPLETE_NOTIFY)
        {
            if (urb->status == -EINPROGRESS)
            {
                urb->status = 0;
            }

            qtd = isp1760_clean_this_qtd(qtd);
            isp1760_urb_done(drv, urb, urb->status);
        }
        else
        {
            qtd = isp1760_clean_this_qtd(qtd);
        }

        if (qtd)
        {
            isp1760_enqueue_an_atl_packet(drv, qh, qtd);
        }

        skip_map = ISP1760_ATL_PTD_SKIP_MAP(drv->base_address);
    }
}

static void isp1760_do_int_int(isp1760_t * restrict drv)
{
    isp1760_ptd_t ptd;
    usbhost_urb_t *urb = NULL;
    isp1760_qtd_t *qtd;
    isp1760_qh_t *qh;

    uint32_t done_map;
    uint32_t skip_map;
    uint32_t int_regs;
    uint32_t int_regs_base;
    uint32_t payload;
    uint32_t length;
    uint32_t or_map;
    uint32_t queue_entry;
    int32_t error;


    done_map = ISP1760_INT_PTD_DONE_MAP(drv->base_address);
    skip_map = ISP1760_INT_PTD_SKIP_MAP(drv->base_address);

    or_map = ISP1760_INT_IRQ_MASK_OR(drv->base_address);
    or_map &= ~done_map;
    ISP1760_INT_IRQ_MASK_OR(drv->base_address) = or_map;

    int_regs_base = ISP1760_INT_MEMORY_MAP_OFFSET;

    while (done_map)
    {
        uint32_t dw1;
        uint32_t dw3;

        queue_entry = FFS32(done_map);
        done_map &= ~(1 << queue_entry);
        skip_map |= 1 << queue_entry;

        int_regs = int_regs_base + queue_entry * sizeof(isp1760_ptd_t);
        urb = drv->int_ints[queue_entry].urb;
        qtd = drv->int_ints[queue_entry].qtd;
        qh = drv->int_ints[queue_entry].qh;
        payload = drv->int_ints[queue_entry].payload;

        if (!qh)
        {
            continue;
        }

        ISP1760_MEMORY(drv->base_address) = int_regs + ISP1760_MEM_BANK(0);
        ISP1760_MEMORY(drv->base_address) = payload + ISP1760_MEM_BANK(1);
        ISP1760_MEMORY(drv->base_address) = payload + ISP1760_MEM_BANK(1);
        isp1760_readcopymem((uint32_t *) & ptd, (uint32_t *) (drv->base_address + int_regs + ISP1760_MEM_BANK(0)),
                            sizeof(isp1760_ptd_t), 0);

        dw1 = le32_to_cpu(ptd.dw1);
        dw3 = le32_to_cpu(ptd.dw3);

        error = isp1760_check_error(&ptd);
        if (error)
        {
            urb->status = -EPIPE;
            drv->int_ints[queue_entry].qh->toggle = 0;
            drv->int_ints[queue_entry].qh->ping = 0;

        }
        else
        {
            drv->int_ints[queue_entry].qh->toggle = dw3 & (1 << 25);
            drv->int_ints[queue_entry].qh->ping = dw3 & (1 << 26);
        }

        if (urb->dev->speed != USBHOST_SPEED_HIGH)
            length = ISP1760_PTD_XFERRED_LENGTH_LO(dw3);
        else
            length = ISP1760_PTD_XFERRED_LENGTH(dw3);

        if (length)
        {
            switch (ISP1760_DW1_GET_PID(dw1))
            {
            case ISP1760_IN_PID:
                isp1760_readcopymem(drv->int_ints[queue_entry].data_buffer,
                                    (uint32_t *) (drv->base_address + payload + ISP1760_MEM_BANK(1)), length, 1);
                /* fallthrough */
            case ISP1760_OUT_PID:
                urb->xferActual += length;
                /* fallthrough */
            case ISP1760_SETUP_PID:
                break;
            }
        }

        drv->int_ints[queue_entry].data_buffer = NULL;
        drv->int_ints[queue_entry].urb = NULL;
        drv->int_ints[queue_entry].qtd = NULL;
        drv->int_ints[queue_entry].qh = NULL;

        ISP1760_INT_PTD_SKIP_MAP(drv->base_address) = skip_map;
        isp1760_payloadmap_free(payload, &drv->payloadMap);

        if (urb->status == -EPIPE)
        {
            qtd = isp1760_cleanup_qtd_list(qtd);
            isp1760_urb_done(drv, urb, urb->status);
        }
        else if (qtd->status & URB_COMPLETE_NOTIFY)
        {

            if (urb->status == -EINPROGRESS)
                urb->status = 0;

            qtd = isp1760_clean_this_qtd(qtd);
            isp1760_urb_done(drv, urb, urb->status);

        }
        else
        {
            qtd = isp1760_clean_this_qtd(qtd);
        }

        if (qtd)
            isp1760_enqueue_an_int_packet(drv, qh, qtd);

        skip_map = ISP1760_INT_PTD_SKIP_MAP(drv->base_address);
    }
}

static isp1760_qh_t *isp1760_qhmake(isp1760_t * restrict drv, usbhost_urb_t * urb)
{
    isp1760_qh_t *qh;
    int32_t is_input;
    int32_t type;

    qh = isp1760_qhalloc(drv);
    if (!qh)
        return qh;

    is_input = USBHOST_ISINEP(urb->ep->desc.bEndpointAddress);
    type = USBHOST_EPTYPE(urb->ep->desc.bmAttributes);

    if (type == USBHOST_XFER_TYPE_INT)
    {
        if (urb->dev->speed == USBHOST_SPEED_HIGH)
        {
            qh->period = urb->interval >> 3;
            if (qh->period == 0 && urb->interval != 1)
            {
                isp1760_qhfree(qh);
                return NULL;
            }
        }
        else
        {
            qh->period = urb->interval;
        }
    }

    qh->dev = urb->dev;

    return qh;
}

static isp1760_qh_t *isp1760_qhappendtds(isp1760_t * restrict drv,
                                         usbhost_urb_t * urb, GenericListHead_t * qtd_list, int32_t epnum, void **ptr)
{
    isp1760_qh_t *qh;
    isp1760_qtd_t *qtd;
    isp1760_qtd_t *prev_qtd;

    qh = (isp1760_qh_t *) * ptr;
    if (!qh)
    {
        qh = isp1760_qhmake(drv, urb);
        if (!qh)
            return qh;
        *ptr = qh;
    }

    qtd = list_entry(qtd_list->next, isp1760_qtd_t, qtd_list);

    if (!list_empty(&qh->qtd_list))
        prev_qtd = list_entry(qh->qtd_list.prev, isp1760_qtd_t, qtd_list);
    else
        prev_qtd = NULL;

    list_splice(qtd_list, qh->qtd_list.prev);
    if (prev_qtd)
    {
        prev_qtd->hw_next = qtd;
    }

    return qh;
}

static void isp1760_qtdlistfree(isp1760_t * restrict drv, usbhost_urb_t * urb, GenericListHead_t * qtd_list)
{
    GenericListHead_t *entry;
    GenericListHead_t *temp;

    list_for_each_safe(entry, temp, qtd_list)
    {
        isp1760_qtd_t *qtd;

        qtd = list_entry(entry, isp1760_qtd_t, qtd_list);
        list_del(&qtd->qtd_list);
        isp1760_qtdfree(qtd);
    }
}

static int32_t isp1760_prepareenqueue(isp1760_t * restrict drv,
                                      usbhost_urb_t * urb, GenericListHead_t * qtd_list, packet_enqueue_t * p)
{
    isp1760_qh_t *qh = NULL;
    isp1760_qtd_t *qtd;
    int32_t qh_busy;
    int32_t epnum;
    int32_t rc;

    qtd = list_entry(qtd_list->next, isp1760_qtd_t, qtd_list);
    epnum = urb->ep->desc.bEndpointAddress;

    spin_lock_irqsave(&drv->lock, flags);

    rc = isp1760_endpoint_attach_urb(drv, urb);
    if (rc)
    {
        goto done;
    }

    qh = urb->ep->hcPriv;
    if (qh)
    {
        qh_busy = !list_empty(&qh->qtd_list);
    }
    else
    {
        qh_busy = 0;
    }

    qh = isp1760_qhappendtds(drv, urb, qtd_list, epnum, &urb->ep->hcPriv);
    if (!qh)
    {
        rc = -ENOMEM;
        goto done;
    }

    if (!qh_busy)
    {
        p(drv, qh, qtd);
    }

  done:
    spin_unlock_irqrestore(&drv->lock, flags);
    if (!qh)
    {
        isp1760_qtdlistfree(drv, urb, qtd_list);
    }

    return rc;
}

static GenericListHead_t *isp1760_qhurbtransaction(isp1760_t * restrict drv, usbhost_urb_t * urb, GenericListHead_t * head)
{
    isp1760_qtd_t *qtd;
    isp1760_qtd_t *qtd_prev;
    void *buf;
    int32_t len;
    int32_t max_packet;
    int32_t is_input;
    uint32_t token;

    uint32_t currentDataFrame = 0;

    qtd = isp1760_qtdalloc();
    if (!qtd)
    {
        return NULL;
    }

    list_add_tail(&qtd->qtd_list, head);
    qtd->urb = urb;
    urb->status = -EINPROGRESS;

    token = 0;
    len = urb->xferBufSize;
    is_input = USBHOST_ISINEP(urb->ep->desc.bEndpointAddress);
    if (USBHOST_ISCONTROLEP(urb->ep->desc.bmAttributes))
    {
        isp1760_qtdfill(qtd, urb->setupPacket, sizeof(usbhost_controlrequest_t), token | ISP1760_SETUP_PID);

        token ^= ISP1760_DATA_TOGGLE;
        qtd_prev = qtd;
        qtd = isp1760_qtdalloc();
        if (!qtd)
        {
            goto cleanup;
        }
        qtd->urb = urb;
        qtd_prev->hw_next = qtd;
        list_add_tail(&qtd->qtd_list, head);

        if (len == 0)
        {
            token |= ISP1760_IN_PID;
        }
    }

    if (is_input)
    {
        token |= ISP1760_IN_PID;
    }
    else
    {
        token |= ISP1760_OUT_PID;
    }

    max_packet = little16(urb->ep->desc.wMaxPacketSize);

    for (;;)
    {

#if ENABLE_ISO_SUPPORT
        if (USB_ISISOEP(urb->ep->desc.bmAttributes))
        {
            buf = ((uint8_t *) urb->xferBuf) + urb->isoFrames[currentDataFrame].offset;
            len = urb->isoFrames[currentDataFrame].len;
            qtd->index = currentDataFrame;

            urb->isoFrames[currentDataFrame].actualLen = 0;
            urb->isoFrames[currentDataFrame].status = -EXDEV;
        }
        else
        {
            buf = urb->xferBuf;
        }
#else
        buf = urb->xferBuf;
#endif
        for (;;)
        {

            int32_t this_qtd_len;
            this_qtd_len = isp1760_qtdfill(qtd, buf, len, token);
            len -= this_qtd_len;
            buf = (void *) ((uint32_t) buf + this_qtd_len);

            if (!USBHOST_ISISOEP(urb->ep->desc.bmAttributes))
            {
                if ((max_packet & (this_qtd_len + (max_packet - 1))) == 0)
                    token ^= ISP1760_DATA_TOGGLE;
            }

#if ENABLE_ISO_SUPPORT
            if (len <= 0)
                break;
#else
            if (len <= 0)
                goto done;
#endif

            qtd_prev = qtd;
            qtd = isp1760_qtdalloc();
            if (!qtd)
                goto cleanup;
            qtd->urb = urb;
            qtd_prev->hw_next = qtd;
            list_add_tail(&qtd->qtd_list, head);

        }
#if ENABLE_ISO_SUPPORT
        if (!(++currentDataFrame < urb->isoFrameCount))
            break;
#endif
    }
 done:

    if (urb->xferBufSize != 0)
    {
        int one_more = 0;

        if (USBHOST_ISCONTROLEP(urb->ep->desc.bmAttributes))
        {
            one_more = 1;
            token ^= ISP1760_IN_PID;
            token |= ISP1760_DATA_TOGGLE;
        }
        else if (USBHOST_ISBULKEP(urb->ep->desc.bmAttributes)
                 && (urb->xferFlags & URB_ZERO_PACKET) && !(urb->xferBufSize % max_packet))
        {
            one_more = 1;
        }
        if (one_more)
        {
            qtd_prev = qtd;
            qtd = isp1760_qtdalloc();
            if (!qtd)
                goto cleanup;
            qtd->urb = urb;
            qtd_prev->hw_next = qtd;
            list_add_tail(&qtd->qtd_list, head);

            isp1760_qtdfill(qtd, NULL, 0, token);
        }
    }

    qtd->status = URB_COMPLETE_NOTIFY;
    return head;

  cleanup:
    isp1760_qtdlistfree(drv, urb, head);
    return NULL;
}

extern int32_t isp1760_enqueue_urb(isp1760_t * restrict drv, usbhost_urb_t * urb)
{
    GenericListHead_t td_list;
    packet_enqueue_t *pe;

    INIT_LIST_HEAD(&td_list);

    switch (USBHOST_EPTYPE(urb->ep->desc.bmAttributes))
    {
    case USBHOST_XFER_TYPE_CONTROL:
    case USBHOST_XFER_TYPE_BULK:

        if (!isp1760_qhurbtransaction(drv, urb, &td_list))
            return -ENOMEM;
        pe = isp1760_enqueue_an_atl_packet;
        break;

    case USBHOST_XFER_TYPE_INT:
        if (!isp1760_qhurbtransaction(drv, urb, &td_list))
            return -ENOMEM;
        pe = isp1760_enqueue_an_int_packet;
        break;

    case USBHOST_XFER_TYPE_ISO:
#if ENABLE_ISO_SUPPORT
        if (!isp1760_qhurbtransaction(drv, urb, &td_list))
            return -ENOMEM;
        pe = isp1760_enqueue_an_iso_packet;
        break;
#else
#if DEBUG_DRV_ISP1760
        printf("PIPE_ISOCHRONOUS ain't supported\n");
#endif
        return -1;
#endif

    default:
        return -EPIPE;
    }

    return isp1760_prepareenqueue(drv, urb, &td_list, pe);
}

extern int32_t isp1760_dequeue_urb(isp1760_t * restrict drv, usbhost_urb_t * urb, int32_t status)
{
    isp1760_inter_packet_info_t *ints;
    isp1760_ptd_t ptd;

    uint32_t i;
    uintptr_t reg_base;
    volatile uint32_t *or_reg;
    volatile uint32_t *skip_reg;

    switch (USBHOST_EPTYPE(urb->ep->desc.bmAttributes))
    {
    case USBHOST_XFER_TYPE_ISO:
        return -EPIPE;

    case USBHOST_XFER_TYPE_INT:
        ints = drv->int_ints;
        reg_base = ISP1760_INT_MEMORY_MAP_OFFSET;
        or_reg = &ISP1760_INT_IRQ_MASK_OR(drv->base_address);
        skip_reg = &ISP1760_INT_PTD_SKIP_MAP(drv->base_address);
        break;

    default:
        ints = drv->atl_ints;
        reg_base = ISP1760_ATL_MEMORY_MAP_OFFSET;
        or_reg = &ISP1760_ATL_IRQ_MASK_OR(drv->base_address);
        skip_reg = &ISP1760_ATL_PTD_SKIP_MAP(drv->base_address);
        break;
    }

    memset(&ptd, 0, sizeof(ptd));
    spin_lock_irqsave(&drv->lock, flags);

    for (i = 0; i < 32; i++)
    {
        if (ints->urb == urb)
        {
            uint32_t skip_map;
            uint32_t or_map;
            isp1760_qtd_t *qtd;

            skip_map = *skip_reg;
            skip_map |= 1 << i;
            *skip_reg = skip_map;

            or_map = *or_reg;
            or_map &= ~(1 << i);
            *or_reg = or_map;
            isp1760_writecopymem((uint32_t *) (drv->base_address + reg_base + i * sizeof(ptd)), (uint32_t *) & ptd, sizeof(ptd), false);

            qtd = ints->qtd;

            isp1760_cleanup_qtd_list(qtd);

            isp1760_payloadmap_free(ints->payload, &drv->payloadMap);

            ints->urb = NULL;
            ints->qh = NULL;
            ints->qtd = NULL;
            ints->data_buffer = NULL;
            ints->payload = 0;

            isp1760_urb_done(drv, urb, status);
            break;
        }
        ints++;
    }

    spin_unlock_irqrestore(&drv->lock, flags);
    return 0;
}

__INTERRUPT_NATIVE void isp1760_handler(void)
{
    isp1760_t * restrict drv;
    uint32_t imask;

    uint32_t currentIRQ = interrupt_get_current();
    drv = interrupt_native_context(currentIRQ);

    spin_lock(&drv->lock);

    if (!(drv->state & HC_STATE_RUNNING))
        goto leave;

    imask = ISP1760_INT(drv->base_address);
    if (!imask)
        goto leave;

    ISP1760_INT(drv->base_address) = imask;
    if (imask & ISP1760_INT_ATL_IRQ)
    {
        isp1760_do_atl_int(drv);
    }

    if (imask & ISP1760_INT_INT_IRQ)
    {
        isp1760_do_int_int(drv);
    }

#if ENABLE_ISO_SUPPORT
    if (imask & ISP1760_INT_ISO_IRQ)
    {
        isp1760_do_int_int(drv);
    }
#endif

  leave:
    spin_unlock(&drv->lock);
    interrupt_acknowledge(currentIRQ);
}

extern int32_t isp1760_stop(isp1760_t * restrict drv)
{
    uint32_t temp;

    spin_lock_irq(&drv->lock);
    isp1760_resetehci(drv);

    temp = ISP1760_MODE_CONTROL(drv->base_address);
    ISP1760_MODE_CONTROL(drv->base_address) = temp &= ~ISP1760_HW_GLOBAL_INTR_EN;
    spin_unlock_irq(&drv->lock);

    ISP1760_CONFIGFLAG(drv->base_address) = 0;
    return 0;
}

extern int32_t isp1760_shutdown(isp1760_t * restrict drv)
{
    uint32_t command;
    uint32_t temp;

    isp1760_stop(drv);
    temp = ISP1760_MODE_CONTROL(drv->base_address);
    ISP1760_MODE_CONTROL(drv->base_address) = temp &= ~ISP1760_HW_GLOBAL_INTR_EN;

    command = ISP1760_USBCMD(drv->base_address);
    command &= ~ISP1760_CMD_RUN;
    ISP1760_USBCMD(drv->base_address) = command;
    return 0;
}

static void isp1760_preinit(isp1760_t * restrict drv)
{
    uint32_t hcc_params;

    isp1760_payloadmap_init(&drv->payloadMap);

    drv->periodic_size = DEFAULT_I_TDPS;

    hcc_params = ISP1760_HCSPARAMS(drv->base_address);
    if (ISP1760_HCC_ISOC_CACHE(hcc_params))
        drv->i_thresh = 8;
    else
        drv->i_thresh = 2 + ISP1760_HCC_ISOC_THRES(hcc_params);
}

extern uint32_t isp1760_get_state(isp1760_t * restrict drv)
{
    return drv->state;
}

static void isp1760_reginit(isp1760_t *drv)
{

    if (ISP1760_USBCMD(drv->base_address) & ISP1760_USBCMD_RUNSTOP)
    {
        ISP1760_USBCMD(drv->base_address) &= ~ISP1760_USBCMD_RUNSTOP;
    }

    ISP1760_USBSTS(drv->base_address) = 0;
    ISP1760_USBSTS(drv->base_address) = ~ISP1760_USBSTS(drv->base_address);
    ISP1760_ATL_PTD_SKIP_MAP(drv->base_address) = 0xFFFFFFFF;
    ISP1760_INT_PTD_SKIP_MAP(drv->base_address) = 0xFFFFFFFF;
    ISP1760_ISO_PTD_SKIP_MAP(drv->base_address) = 0xFFFFFFFF;
    ISP1760_ATL_PTD_DONE_MAP(drv->base_address) = 0;
    ISP1760_INT_PTD_DONE_MAP(drv->base_address) = 0;
    ISP1760_ISO_PTD_DONE_MAP(drv->base_address) = 0;
    ISP1760_SW_RESET(drv->base_address) = ISP1760_SW_RESET_RESET_ALL;
    ISP1760_SW_RESET(drv->base_address) = ISP1760_SW_RESET_RESET_HC;
    while (ISP1760_SW_RESET(drv->base_address) & ISP1760_SW_RESET_RESET_HC);
    ISP1760_USBCMD(drv->base_address) |= ISP1760_USBCMD_HCRESET;
    while (ISP1760_USBCMD(drv->base_address) & ISP1760_USBCMD_HCRESET);

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
    isp1760_t *restrict drv = &isp1760_drv_table[id];
    drv_isp1760_cfg_instance_t *restrict drv_cfg = &drv_isp1760_instance_table[id];
    per_isp1760_cfg_instance_t *restrict per_isp1760_cfg = &per_isp1760_instance_table[drv_cfg->per_isp1760];
    per_usb_intercon_cfg_instance_t *restrict per_usb_intercon_cfg = &per_usb_intercon_instance_table[drv_cfg->per_usb_intercon];

    if (drv->base_address) return drv;

    assert(per_isp1760_cfg->baseaddress != 0);
    assert(per_usb_intercon_cfg->interrupt0 != -1);
    drv->base_address = per_isp1760_cfg->baseaddress;
    drv->interrupt0 = per_usb_intercon_cfg->interrupt0;

    isp1760_reginit(drv);

    interrupt_register_native(drv->interrupt0, (void *) drv, isp1760_handler);
    interrupt_configure(drv->interrupt0, LEVEL_LOW);
    interrupt_enable(drv->interrupt0);

    return drv;
}
