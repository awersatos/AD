/*
 * usbhost_mass_storage.c
 */

#include <string.h>
#include <assert.h>
// Debug
#include <stdio.h>
#include <timing.h>

#include <util_endian.h>

#include "usbhost_mass_storage.h"
#include "usbhost_message.h"
#include <usbhost_core.h>

#define USB_REQ_BULK_ONLY_RESET     0xFF
#define USB_REQ_GET_MAX_LUN         0xFE

static void usbhost_msd_build_bulk_only_reset(usbhost_controlrequest_t *req, uint16_t intf);
static void usbhost_msd_build_get_max_lun(usbhost_controlrequest_t *req, uint16_t intf);

static int32_t usbhost_msd_clear_halt_epin(usbhost_msd_device_t *dev);
static int32_t usbhost_msd_clear_halt_epout(usbhost_msd_device_t *dev);

static bool usbhost_msd_csw_valid_and_meaningful(msd_csw_t *csw, uint32_t tag, uint32_t length);
static int32_t usbhost_msd_reset_recovery(usbhost_msd_device_t *dev, bool no_halt_clear);

struct _usbhost_msd_device_t {
    usbhost_interface_t         *intf;
    usbhost_host_endpoint_t     *epIN;
    usbhost_host_endpoint_t     *epOUT;
    uint8_t                     *xferBuf;
    uint32_t                    xferBufLen;
};

static uint32_t get_next_tag(void)
{
    static unsigned int next;
    return next++;
}

#if DEBUG_USBHOST_MSD
static char *csw_status_to_str(int err)
{
    switch (err)
    {
        case 0:
            return "Command Passed";
        case 1:
            return "Command Failed";
        case 2:
            return "Phase Error";
        case 3:
        case 4:
            return "Reserved (Obsolete)";
        default:
            return "Reserved";
    }
}
#endif

#define MSD_XFER_BUF_LEN 512
////////////////////////////////////////////////////////////////////////////////
usbhost_msd_device_t *usbhost_msd_get_instance(usbhost_interface_t *intf)
{
    usbhost_msd_device_t *inst = (usbhost_msd_device_t *)calloc(sizeof(usbhost_msd_device_t), 1);

    assert(intf != NULL && inst != NULL);

    inst->intf       = intf;

    if (intf->curIntf->endpoint[0].desc.bEndpointAddress & 0x80)
    {
        inst->epIN       = &intf->curIntf->endpoint[0];
    }
    else
    {
        inst->epOUT      = &intf->curIntf->endpoint[0];
    }

    if (intf->curIntf->endpoint[1].desc.bEndpointAddress & 0x80)
    {
        inst->epIN       = &intf->curIntf->endpoint[1];
    }
    else
    {
        inst->epOUT      = &intf->curIntf->endpoint[1];
    }

    if (inst->epOUT == NULL || inst->epIN == NULL)
    {
#if DEBUG_USBHOST_MSD
        printf("Error usbhost_msd_get_instance IN or OUT end point missing?\n");
#endif
    }

    inst->xferBuf    = (uint8_t *)calloc(MSD_XFER_BUF_LEN, 1);
    inst->xferBufLen = MSD_XFER_BUF_LEN;

    return inst;
}

void usbhost_msd_free_instance(usbhost_msd_device_t *inst)
{
    assert(inst != NULL && inst->xferBuf != NULL);

    free(inst->xferBuf);
    free(inst);
}

////////////////////////////////////////////////////////////////////////////////
static void usbhost_msd_build_bulk_only_reset(usbhost_controlrequest_t *req, uint16_t intf)
{
    req->bmRequestType = USBHOST_DIR_OUT | USBHOST_TYPE_CLASS | USBHOST_RECIP_INTERFACE;
    req->bRequest      = USB_REQ_BULK_ONLY_RESET;
    req->wValue        = little16(0x00);
    req->wIndex        = little16(intf);
    req->wLength       = little16(0x00);
}

////////////////////////////////////////////////////////////////////////////////
static void usbhost_msd_build_get_max_lun(usbhost_controlrequest_t *req, uint16_t intf)
{
    req->bmRequestType = USBHOST_DIR_IN | USBHOST_TYPE_CLASS | USBHOST_RECIP_INTERFACE;
    req->bRequest      = USB_REQ_GET_MAX_LUN;
    req->wValue        = little16(0x00);
    req->wIndex        = little16(intf);
    req->wLength       = little16(0x01);
}

static int32_t usbhost_msd_clear_halt_epin(usbhost_msd_device_t *dev)
{
    int32_t                     err;
    usbhost_controlrequest_t    req;

    usbhost_buildportfeaturecmd(USBHOST_FEATURE_CLR, dev->epIN->desc.bEndpointAddress, USBHOST_FS_ENDPOINT_HALT, &req);
    req.bmRequestType &= ~USBHOST_DIR_OUT; // for now clear out bit (should modify funtion/ or add new one)
    err = usbhost_docontrolrequest(dev->intf->dev, &req, NULL, 0);
    if (err != 0)
    {
#if DEBUG_USBHOST_MSD
        printf("Error control request to feature_clear IN end point\n");
#endif
    }
    return err;
}

static int32_t usbhost_msd_clear_halt_epout(usbhost_msd_device_t *dev)
{
    int32_t                     err;
    usbhost_controlrequest_t    req;

    usbhost_buildportfeaturecmd(USBHOST_FEATURE_CLR, dev->epOUT->desc.bEndpointAddress, USBHOST_FS_ENDPOINT_HALT, &req);
    err = usbhost_docontrolrequest(dev->intf->dev, &req, NULL, 0);
    if (err != 0)
    {
#if DEBUG_USBHOST_MSD
        printf("Error control request to feature_clear OUT end point\n");
#endif
    }
    return err;
}

/*
 * 6.3 Valid and Meaningful CSW
 *      The device generally communicates the results of its attempt to satisfy
 *      the host’s request through the CSW. The host performs two verifications
 *      on every CSW received. First, the host verifies that what was received
 *      is a valid CSW Next, the host determines if the data within the CSW is
 *      meaningful.
 *
 * 6.3.1 Valid CSW
 *      The host shall consider the CSW valid when:
 *          · the CSW is 13 (Dh) bytes in length,
 *          · and the dCSWSignature is equal to 53425355h,
 *          · the dCSWTag matches the dCBWTag from the corresponding CBW.
 *
 * 6.3.2 Meaningful CSW
 *      The host shall consider the contents of the CSW meaningful when:
 *          either the bCSWStatus value is 00h or 01h and the dCSWDataResidue
 *              is less than or equal to dCBWDataTransferLength.
 *          or the bCSWStatus value is 02h.
 */
static bool usbhost_msd_csw_valid_and_meaningful(msd_csw_t *csw, uint32_t tag, uint32_t length)
{
    if (csw->dSignature != little32(MSD_CSW_SIGNATURE) || csw->dTag != little32(tag))
    {
        return false;
    }
    if (csw->bStatus == 0 || csw->bStatus == 1)
    {
        if (little32(csw->dDataResidue) > length)
        {
            return false;
        }
        return true;
    }
    if (csw->bStatus != 2)
    {
        return false;
    }
    return true;
}

/*
 * For Reset Recovery the host shall issue in the following order:
 *      (a) a Bulk-Only Mass Storage Reset
 *      (b) a Clear Feature HALT to the Bulk-In endpoint
 *      (c) a Clear Feature HALT to the Bulk-Out endpoint
 */
static int32_t usbhost_msd_reset_recovery(usbhost_msd_device_t *dev, bool no_halt_clear)
{
    usbhost_controlrequest_t    req;
    int32_t                     err1, err2, err3;

    /* (a) a Bulk-Only Mass Storage Reset */
    usbhost_msd_build_bulk_only_reset(&req, dev->intf->curIntf->desc.bInterfaceNumber);
    err1 = usbhost_docontrolrequest(dev->intf->dev, &req, NULL, 0);
    if (err1)
    {
#if DEBUG_USBHOST_MSD
        printf("Error control request to reset bulk only\n");
#endif
        return err1;
    }

    /* (b) a Clear Feature HALT to the Bulk-In endpoint */
    err2 = usbhost_msd_clear_halt_epin(dev);
    if (err2)
    {
#if DEBUG_USBHOST_MSD
        printf("Error control request to feature_clear IN end point (attempt 1)\n");
#endif
    }

    /* (c) a Clear Feature HALT to the Bulk-Out endpoint */
    err3 = usbhost_msd_clear_halt_epout(dev);
    if (err3)
    {
#if DEBUG_USBHOST_MSD
        printf("Error control request to feature_clear OUT end point\n");
#endif
    }

    if (err2 == -EPIPE || err3 == -EPIPE)
    {
        usbhost_msd_build_bulk_only_reset(&req, dev->intf->curIntf->desc.bInterfaceNumber);
        err1 = usbhost_docontrolrequest(dev->intf->dev, &req, NULL, 0);
    }
    if (err2 == -EPIPE)
    {
        err2 = usbhost_msd_clear_halt_epin(dev);
    }
    if (err3 == -EPIPE)
    {
        err3 = usbhost_msd_clear_halt_epout(dev);
    }

    if (err2)
    {
        return err2;
    }
    return err3;
}

int32_t usbhost_msd_get_max_lun(usbhost_msd_device_t *dev)
{
    usbhost_controlrequest_t    req;
    int32_t                     err;
    int8_t                      maxLun;

    usbhost_msd_build_get_max_lun(&req, dev->intf->curIntf->desc.bInterfaceNumber);
    err = usbhost_docontrolrequest(dev->intf->dev, &req, &maxLun, 1);

#if DEBUG_USBHOST_MSD
    printf("Max LUN: %i\n", maxLun);
#endif
    return err;
}

////////////////////////////////////////////////////////////////////////////////
int32_t usbhost_msd_csw_status(usbhost_msd_device_t *dev, uint32_t tag, uint32_t length)
{
    int32_t     err;
    msd_csw_t   status;

    err = usbhost_dobulktransfer_timeout(dev->intf->dev, dev->epIN, &status, sizeof(status), 2000);
    if (err)
    {
#if DEBUG_USBHOST_MSD
        printf("Error usbhost_dobulktransfer in usbhost_msd_csw_status err %d\n", err);
#endif
        if (err == -EPIPE)
        {
            /* clear halt epin */
            usbhost_msd_clear_halt_epin(dev);
            /* retry */
            err = usbhost_dobulktransfer_timeout(dev->intf->dev, dev->epIN, &status, sizeof(status), 2000);
        }
        return err;
    }

    if (!usbhost_msd_csw_valid_and_meaningful(&status, tag, length) || status.bStatus == MSD_CSW_PHASE_ERROR)
    {
        usbhost_msd_reset_recovery(dev, true);
        return -1;
    }

    return status.bStatus;
}

/*
 *
 */
void usbhost_msd_on_complete_status(usbhost_urb_t *urb)
{
    usbhost_dobulktransferasync(urb->dev, urb->ep, urb->xferBuf, 13, urb);
}

/*
 *
 */
int32_t usbhost_msd_test_unit_ready(usbhost_msd_device_t *dev)
{
    int32_t                 err;
    uint32_t                tag;
    msd_cbw_t               cbw;
    scsi_test_unit_ready_t  *cmd;

    memset(&cbw, 0, sizeof(cbw));

    tag = get_next_tag();
    cbw.dSignature          = little32(MSD_CBW_SIGNATURE);
    cbw.dTag                = little32(tag);
    cbw.dDataLength         = 0;
    cbw.bmFlags             = 0;
    cbw.bLUN                = 0;
    cbw.bCBLength           = sizeof(scsi_test_unit_ready_t);

    cmd                     = (scsi_test_unit_ready_t *)cbw.CB;
    cmd->opcode             = SCSI_TEST_UNIT_READY;

    /* Do Request */
    do
    {
        err = usbhost_dobulktransfer(dev->intf->dev, dev->epOUT, &cbw, sizeof(cbw));
    } while (err == -EBUSY);
    if (err != 0)
    {
#if DEBUG_USBHOST_MSD
        printf("Error test unit ready request\n");
#endif
    }

    /* Get Status */
    err = usbhost_msd_csw_status(dev, tag, 0);
    if (err)
    {
#if DEBUG_USBHOST_MSD
        printf("Error test unit ready status %s\n", csw_status_to_str(err));
#endif
    }

    return err;
}

/*
 *
 */
int32_t usbhost_msd_request_sense(usbhost_msd_device_t *dev, uint8_t *response, size_t response_len)
{
    int32_t                 err;
    uint32_t                tag;
    uint32_t                length;
    msd_cbw_t               cbw;
    scsi_request_sense_t    *cmd;

    tag                     = get_next_tag();
    length                  = response_len;

    memset(&cbw, 0, sizeof(cbw));
    cbw.dSignature          = little32(MSD_CBW_SIGNATURE);
    cbw.dTag                = little32(tag);
    cbw.dDataLength         = little32(length);
    cbw.bmFlags             = 0x80;
    cbw.bLUN                = 0;
    cbw.bCBLength           = sizeof(scsi_request_sense_t);

    cmd                     = (scsi_request_sense_t *)cbw.CB;
    cmd->opcode             = SCSI_REQUEST_SENSE;
    cmd->length             = (uint8_t)length;      // 8 bit val

    /* Do Request */
    err = usbhost_dobulktransfer(dev->intf->dev, dev->epOUT, &cbw, sizeof(cbw));
    if (err)
    {
        return err;
    }

    /* Get Request Data */
    err = usbhost_dobulktransfer(dev->intf->dev, dev->epIN, response, length);
    if (err != 0)
    {
        return err;
    }

    /* Get Status */
    err = usbhost_msd_csw_status(dev, tag, length);
    if (err)
    {
#if DEBUG_USBHOST_MSD
        printf("Error test unit ready status %s\n", csw_status_to_str(err));
#endif
    }

    return err;
}

/*
 *
 */
int32_t usbhost_msd_inquiry(usbhost_msd_device_t *dev)
{
    int32_t                 err;
    uint32_t                tag;
    uint32_t                length;
    msd_cbw_t               cbw;
    scsi_inquiry_t          *cmd;
    scsi_inquiry_data_t     data;

    memset(&cbw, 0, sizeof(cbw));

    tag                     = get_next_tag();
    length                  = sizeof(scsi_inquiry_data_t);

    cbw.dSignature          = little32(MSD_CBW_SIGNATURE);
    cbw.dTag                = little32(tag);
    cbw.dDataLength         = little32(length); // This is return data size
    cbw.bmFlags             = 0x80;
    cbw.bLUN                = 0x00;
    cbw.bCBLength           = sizeof(scsi_inquiry_t);

    cmd                     = (scsi_inquiry_t *)cbw.CB;
    cmd->opcode             = SCSI_INQUIRY;
    cmd->allocation_length  = (uint8_t)sizeof(scsi_inquiry_data_t);

    // Do Request
    err = usbhost_dobulktransfer(dev->intf->dev, dev->epOUT, &cbw, sizeof(cbw));
    if (err)
    {
#if DEBUG_USBHOST_MSD
        printf("Error inquiry send request\n");
#endif
    }

    // Get Request Data
    memset(dev->xferBuf, -1, dev->xferBufLen);
    err = usbhost_dobulktransfer(dev->intf->dev, dev->epIN, dev->xferBuf, sizeof(data));
    if (err)
    {
#if DEBUG_USBHOST_MSD
        printf("Error inquiry receive result\n");
#endif
    }
    memcpy(&data, dev->xferBuf, sizeof(data));

    // Get Status
    err = usbhost_msd_csw_status(dev, tag, length);
    if (err)
    {
#if DEBUG_USBHOST_MSD
        printf("Error inquiry status %s\n", csw_status_to_str(err));
#endif
    }

    return err;
}

////////////////////////////////////////////////////////////////////////////////
int32_t usbhost_msd_report_luns(usbhost_msd_device_t *dev)
{
    uint32_t            tag;
    uint32_t            length;
    int32_t             err;
    msd_cbw_t           cbw;
    scsi_report_luns_t  *cmd;

    tag             = get_next_tag();
    length          = 16;
    cbw.dSignature  = little32(MSD_CBW_SIGNATURE);
    cbw.dTag        = little32(tag);
    cbw.dDataLength = little32(length);
    cbw.bmFlags     = 0x80;
    cbw.bLUN        = 0x00;
    cbw.bCBLength   = sizeof(*cmd);
    cmd             = (scsi_report_luns_t*)cbw.CB;

    cmd->opcode     = SCSI_REPORT_LUNS;
    cmd->length     = big32(length);
    cmd->control    = 0;

    err = usbhost_dobulktransfer(dev->intf->dev, dev->epOUT, &cbw, sizeof(cbw));
    memset(dev->xferBuf, -1, dev->xferBufLen);
    err = usbhost_dobulktransfer(dev->intf->dev, dev->epIN, dev->xferBuf, 16/*context->xferBufLen*/);
    if (err != 0)
    {
        usbhost_msd_reset_recovery(dev, false);
    }
    else
    {
        // Get Status
        err = usbhost_msd_csw_status(dev, tag, length);
        if (err)
        {
#if DEBUG_USBHOST_MSD
            printf("Error report luns status %s\n", csw_status_to_str(err));
#endif
        }
    }

    return err;
}

////////////////////////////////////////////////////////////////////////////////
int32_t usbhost_msd_read_capacity(usbhost_msd_device_t *dev, uint64_t *last_block, uint32_t *block_len)
{
    int32_t                 err;
    uint32_t                tag;
    uint32_t                length;
    msd_cbw_t               cbw;
    scsi_read_capacity_t    *cmd;

    memset(&cbw, 0, sizeof(cbw));

    tag = get_next_tag();
    length = sizeof(scsi_short_read_capacity_data);

    cbw.dSignature  = little32(MSD_CBW_SIGNATURE);
    cbw.dTag        = little32(tag);
    cbw.dDataLength = little32(length);
    cbw.bmFlags     = 0x80;
    cbw.bLUN        = 0x00;
    cbw.bCBLength   = sizeof(*cmd);

    cmd             = (scsi_read_capacity_t*)cbw.CB;
    cmd->opcode     = SCSI_READ_CAPACITY;

    err = usbhost_dobulktransfer(dev->intf->dev, dev->epOUT, &cbw, sizeof(cbw));
    if (err == 0)
    {
        memset(dev->xferBuf, -1, dev->xferBufLen);
        err = usbhost_dobulktransfer(dev->intf->dev, dev->epIN, dev->xferBuf, sizeof(scsi_short_read_capacity_data));
        if (err == 0)
        {
            *last_block = big32(*(uint32_t *)dev->xferBuf);
            *block_len = big32(*(uint32_t *)(dev->xferBuf + 4));
#if DEBUG_USBHOST_MSD
            printf("Number of blocks %u, blocksize %u\n", (uint32_t)*last_block, *block_len);
#endif
            // Get Status
            err = usbhost_msd_csw_status(dev, tag, length);
            if (err)
            {
#if DEBUG_USBHOST_MSD
                printf("Error read capacity status %s\n", csw_status_to_str(err));
#endif
            }
            if (*last_block == 0xffffffff)
            {
                err = usbhost_msd_read_capacity_long(dev, last_block, block_len);
            }
        }
    }

    return err;
}

int32_t usbhost_msd_read_capacity_long(usbhost_msd_device_t *dev, uint64_t *last_block, uint32_t *block_len)
{
    int32_t                 err;
    uint32_t                tag;
    uint32_t                length;
    msd_cbw_t               cbw;
    scsi_read_capacity_t    *cmd;

    memset(&cbw, 0, sizeof(cbw));

    tag             = get_next_tag();
    length          = 8;

    cbw.dSignature  = little32(MSD_CBW_SIGNATURE);
    cbw.dTag        = little32(tag);
    cbw.dDataLength = little32(length);
    cbw.bmFlags     = 0x80;
    cbw.bLUN        = 0x00;
    cbw.bCBLength   = sizeof(*cmd);

    cmd             = (scsi_read_capacity_t*)cbw.CB;
    cmd->opcode     = SCSI_READ_CAPACITY;
    cmd->longlba    = 1;

    err = usbhost_dobulktransfer(dev->intf->dev, dev->epOUT, &cbw, sizeof(cbw));

    memset(dev->xferBuf, -1, dev->xferBufLen);
    err = usbhost_dobulktransfer(dev->intf->dev, dev->epIN, dev->xferBuf, sizeof(scsi_long_read_capacity_data));
    if (err != 0)
    {
        usbhost_msd_reset_recovery(dev, false);
    }
    else
    {
        *last_block = big64(*(uint64_t *)dev->xferBuf);
        *block_len = big32(*(uint32_t *)(dev->xferBuf + 8));
#if DEBUG_USBHOST_MSD
        printf("Number of blocks %llu, blocksize %u\n", *last_block, *block_len);
#endif
        // Get Status
        err = usbhost_msd_csw_status(dev, tag, length);
        if (err)
        {
#if DEBUG_USBHOST_MSD
            printf("Error read capacity long status %s\n", csw_status_to_str(err));
#endif
        }
    }

    return err;
}


/*
 *
 */
int32_t usbhost_msd_read10(usbhost_msd_device_t *dev, uint8_t *data, uint32_t lba, uint16_t blkcnt, uint32_t blksize)
{
    static int32_t         err;
    uint32_t        tag;
    uint32_t        length;
    msd_cbw_t       cbw;
    scsi_read10_t   *cmd;

    tag             = get_next_tag();
    length          = blkcnt * blksize;

    memset(&cbw, 0, sizeof(cbw));
    cbw.dSignature  = little32(MSD_CBW_SIGNATURE);
    cbw.dTag        = little32(tag);
    cbw.dDataLength = little32(length);
    cbw.bmFlags     = 0x80;
    cbw.bLUN        = 0x00;
    cbw.bCBLength   = sizeof(*cmd);

    cmd = (scsi_read10_t*)cbw.CB;
    cmd->opcode     = SCSI_READ10;
    cmd->lba        = big32(lba);
    cmd->length     = big16(blkcnt);



    /* 1. The host shall send a valid and meaningful CBW. */
    do
    {
        err = usbhost_dobulktransfer(dev->intf->dev, dev->epOUT, &cbw, sizeof(cbw));
    } while (err == -EBUSY);

    if (err)
    {
#if DEBUG_USBHOST_MSD
        printf("Error usbhost_msd_read10  usbhost_dobulktransfer(epOUT)\n");
#endif
        if (err == -EPIPE || err == -EINPROGRESS) /* epipe = halt bit, einprogress = timed out */
        {
            usbhost_msd_reset_recovery(dev, !(err == -EPIPE));
        }
        return err;
    }

    /* 2. The host shall attempt to receive data from the device. */
    do
    {
        err = usbhost_dobulktransfer(dev->intf->dev, dev->epIN, data, length);
    } while (err == -EBUSY);
    if (err)
    {
#if DEBUG_USBHOST_MSD
        printf("Error usbhost_msd_read10  usbhost_dobulktransfer(epIN)\n");
#endif
        /* 3. On a STALL condition receiving data, then: */
        if (err == -EPIPE || err == -EINPROGRESS) /* epipe = halt bit, einprogress = timed out */
        {
            /* The host shall clear the Bulk-In pipe. */
            usbhost_msd_clear_halt_epin(dev);
        }
    }

    /* Get Status */
    err = usbhost_msd_csw_status(dev, tag, length);
    if (err)
    {
#if DEBUG_USBHOST_MSD
        printf("Error read10 status %s\n", csw_status_to_str(err));
#endif
        if (err == -EPIPE || err == -EINPROGRESS) /* epipe = halt bit, einprogress = timed out */
        {
            /*
             * 5. On a STALL condition receiving the CSW, then:
             *      The host shall clear the Bulk-In pipe.
             */
            usbhost_msd_clear_halt_epin(dev);
            /*      The host shall again attempt to receive the CSW. */
            err = usbhost_msd_csw_status(dev, tag, length);
        }
    }

    return err;
}


/*
 *
 * @param   dev     usbhost_msd device driver
 * @param   data    data to write to the blocks at 'lba' to lba+blkcnt-1
 * @param   blkcnt  number of blocks to write
 * @param   blksize size of the blocks
 *
 * @return   0 - ok
 *          -1 - error, errno might give indication of error
 */
int32_t usbhost_msd_write10(usbhost_msd_device_t *dev, uint8_t *data, uint32_t lba, uint16_t blkcnt, uint32_t blksize)
{
    int32_t         err;
    uint32_t        tag;
    uint32_t        length;
    msd_cbw_t       cbw;
    scsi_write10_t  *cmd;

    tag             = get_next_tag();
    length          = blkcnt * blksize;

    memset(&cbw, 0, sizeof(cbw));
    cbw.dSignature  = little32(MSD_CBW_SIGNATURE);
    cbw.dTag        = little32(tag);
    cbw.dDataLength = little32(length);
    cbw.bmFlags     = 0x00;
    cbw.bLUN        = 0x00;
    cbw.bCBLength   = sizeof(*cmd);

    cmd = (scsi_write10_t *)cbw.CB;
    cmd->opcode     = SCSI_WRITE10;
    cmd->lba        = big32(lba);
    cmd->length     = big16(blkcnt);

    do
    {
        err = usbhost_dobulktransfer(dev->intf->dev, dev->epOUT, &cbw, sizeof(cbw));
    } while (err == -EBUSY);

    if (err)
    {
#if DEBUG_USBHOST_MSD
        printf("Error usbhost_msd_write10 writing command to epOUT\n");
#endif
        if (err == -EPIPE || err == -EINPROGRESS) /* epipe = halt bit, einprogress = timed out */
        {
            usbhost_msd_reset_recovery(dev, !(err == -EPIPE));
        }
        return err;
    }

    do
    {
        err = usbhost_dobulktransfer(dev->intf->dev, dev->epOUT, data, length);
    } while (err == -EBUSY);
    if (err)
    {
#if DEBUG_USBHOST_MSD
        printf("Error usbhost_msd_write10 writing data to epOUT\n");
#endif
        if (err == -EPIPE || err == -EINPROGRESS) /* epipe = halt bit, einprogress = timed out */
        {
            /* The host shall clear the Bulk-Out pipe. */
            usbhost_msd_clear_halt_epout(dev);
        }
    }

    /* Get Status */
    err = usbhost_msd_csw_status(dev, tag, length);
    if (err)
    {
#if DEBUG_USBHOST_MSD
        printf("Error usbhost_msd_write10 status %s\n", csw_status_to_str(err));
#endif
        if (err == -EPIPE || err == -EINPROGRESS) /* epipe = halt bit, einprogress = timed out */
        {
            /* The host shall clear the Bulk-In pipe. */
            usbhost_msd_clear_halt_epout(dev);
            /* The host shall again attempt to receive the CSW. */
            err = usbhost_msd_csw_status(dev, tag, length);
        }
        return err;
    }

    return 0;
}

