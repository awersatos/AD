/*
 * USB mass storage class
 */

#include <assert.h>
#include <time.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>

#include <drv_cy7c68001.h>
#include <usb_msd.h>
#include <usb_msd_descr.h>
#include <blockio.h>
#include <util_endian.h>

#include <usb_msd_cfg.h>
#include <usb_msd_cfg_instance.h>
#include <drv_cy7c68001_cfg.h>
#include <drv_cy7c68001_cfg_instance.h>
#include <blockio_cfg.h>
#include <blockio_cfg_instance.h>

#define MIN(x,y)                            ((x) <= (y) ? (x) : (y))
#define MAX(x,y)                            ((x) >= (y) ? (x) : (y))


/* the Command Block Wrapper (CBW) type definition */
typedef struct
{
    uint32_t            dCBWSignature;
    uint32_t            dCBWTag;
    uint32_t            dCBWDataTransferLength;
    uint8_t             bmCBWFlags;
    uint8_t             bCBWLUN;
    uint8_t             bCBWCBLength;
    uint8_t             CBWCB[16];
} msd_cbw_t;

#define CBW_SIGNATURE                       0x43425355
#define CBW_SIZE                            31 /* size of msd_cbw_t */

/* the Command Status Wrapper (CSW) type definition */
typedef struct
{
    uint32_t            dCSWSignature;
    uint32_t            dCSWTag;
    uint32_t            dCSWDataResidue;
    uint8_t             bCSWStatus;
} msd_csw_t;

#define CSW_SIGNATURE                       0x53425355
#define CSW_SIZE                            13   /* size of msd_csw_t */
#define STATUS_PASSED                       0x00 /* successful transfer */
#define STATUS_FAILED                       0x01 /* failed transfer */
#define STATUS_PHASE_ERROR                  0x02 /* host-device conflict */

/* possible MSD states */
typedef enum
{
    MSD_DATA_IN,
    MSD_DATA_OUT,
    MSD_READ_CBW,
    MSD_WRITE_CSW,
    MSD_HANDLE_CMD
} msd_state_t;

/* block length for each data transfer */
#define BLOCKLEN_512                        0x0200

/* delay time for block driver flush after a write command */
#define FLUSH_DELAY_TIME                    (CLOCKS_PER_SEC * 3)

/* SCSI transparent command set sub-class code */
#define INQUIRY                             0x12
#define READ_FORMAT_CAPACITY                0x23
#define READ_CAPACITY                       0x25
#define READ_10                             0x28
#define WRITE_10                            0x2a
#define REQUEST_SENSE                       0x03
#define MODE_SENSE                          0x1a
#define PREVENT_ALLOW_MEDIUM_REMOVAL        0x1e
#define TEST_UNIT_READY                     0x00
#define VERIFY                              0x2f
#define STOP_START                          0x1b

/* sense key error codes */
#define S_NO_SENSE                          0x00
#define S_RECOVERED_ERROR                   0x01
#define S_NOT_READY                         0x02
#define S_MEDIUM_ERROR                      0x03
#define S_HARDWARE_ERROR                    0X04
#define S_ILLEGAL_REQUEST                   0x05
#define S_UNIT_ATTENTION                    0x06
#define S_DATA_PROTECT                      0x07
#define S_BLANK_CHECK                       0x08
#define S_VENDOR_SPECIFIC                   0x09
#define S_COPY_ABORTED                      0x0a
#define S_ABORTED_COMMAND                   0x0b
#define S_OBSOLETE                          0x0c
#define S_VOLUME_OVERFLOW                   0x0d
#define S_MISCOMPARE                        0x0e
#define S_CURRENT                           0x70
#define S_DEFERRED                          0x71

/* ASC ASCQ Codes for Sense Data (only those that we plan to use) */
/* with sense key Illegal request for a command not supported */
#define ASC_INVALID_COMMAND_OPCODE                          0x20
#define ASCQ_INVALID_COMMAND_OPCODE                         0x00

/* from SPC-3 Table 185
 * with sense key Illegal Request for test unit ready */
#define ASC_LOGICAL_UNIT_NOT_SUPPORTED                      0x25
#define ASCQ_LOGICAL_UNIT_NOT_SUPPORTED                     0x00

#define ASC_INVALID_FIELD_IN_COMMAND_PACKET                 0x24
#define ASCQ_INVALID_FIELD_IN_COMMAND_PACKET                0x00

/* when sense key Unit Attention */
#define ASC_NOT_READY_TO_READY_TRANSITION_MEDIA_CHANGED     0x28
#define ASCQ_NOT_READY_TO_READY_TRANSITION_MEDIA_CHANGED    0x00

#define ASC_POWER_ON_RESET_OR_BUS_DEVICE_RESET_OCCURRED     0x29
#define ASCQ_POWER_ON_RESET_OR_BUS_DEVICE_RESET_OCCURRED    0x00

#define ASC_COMMANDS_CLEARED_BY_ANOTHER_INITIATOR           0x2F
#define ASCQ_COMMANDS_CLEARED_BY_ANOTHER_INITIATOR          0x00

/* with sense key Not ready */
#define ASC_LOGICAL_UNIT_DOES_NOT_RESPOND                   0x05
#define ASCQ_LOGICAL_UNIT_DOES_NOT_RESPOND                  0x00

#define ASC_MEDIUM_NOT_PRESENT                              0x3a
#define ASCQ_MEDIUM_NOT_PRESENT                             0x00

#define ASC_LOGICAL_UNIT_NOT_READY_CAUSE_NOT_REPORTABLE     0x04
#define ASCQ_LOGICAL_UNIT_NOT_READY_CAUSE_NOT_REPORTABLE    0x00

#define ASC_LOGICAL_UNIT_IN_PROCESS                         0x04
#define ASCQ_LOGICAL_UNIT_IN_PROCESS                        0x01

#define ASC_LOGICAL_UNIT_NOT_READY_INIT_REQD                0x04
#define ASCQ_LOGICAL_UNIT_NOT_READY_INIT_REQD               0x02

#define ASC_LOGICAL_UNIT_NOT_READY_INTERVENTION_REQD        0x04
#define ASCQ_LOGICAL_UNIT_NOT_READY_INTERVENTION_REQD       0x03

#define ASC_LOGICAL_UNIT_NOT_READY_FORMATTING               0x04
#define ASCQ_LOGICAL_UNIT_NOT_READY_FORMATTING              0x04

#define ASC_LOGICAL_BLOCK_ADDRESS_OUT_OF_RANGE              0x21
#define ASCQ_LOGICAL_BLOCK_ADDRESS_OUT_OF_RANGE             0x00

#define ASC_WRITE_PROTECTED                                 0x27
#define ASCQ_WRITE_PROTECTED                                0x00

#define ASC_WRITE_FAULT                                     0x03
#define ASCQ_WRITE_FAULT                                    0x00

/* SCSI inquiry response */
typedef struct
{
    uint8_t                 Peripheral;
    uint8_t                 Removable;
    uint8_t                 Version;
    uint8_t                 ResponseDataFormat;
    uint8_t                 AdditionalLength;
    uint8_t                 SCCSTP;
    uint8_t                 BQUEETC;
    uint8_t                 CmdQue;
    char                    VendorID[8];
    char                    ProductID[16];
    char                    ProductRevision[4];
} inquiry_response_t;

/* SCSI request sense response */
typedef struct {
    uint8_t                 ResponseCode :7;
    uint8_t                 VALID :1;

    uint8_t                 Obsolete;

    uint8_t                 SenseKey :4;
    uint8_t                 Resv :1;
    uint8_t                 ILI :1;
    uint8_t                 EOM :1;
    uint8_t                 FILEMARK :1;

    uint32_t                Information;
    uint8_t                 AddSenseLen;
    uint32_t                CmdSpecificInfo;
    uint8_t                 ASC;
    uint8_t                 ASCQ;
    uint8_t                 FRUC;
    uint8_t                 SenseKeySpecific[3];
} request_sense_response_t;

typedef struct {
    int                         block_dev;
    bool                        block_dev_rdonly;
    posix_devctl_blockio_cfg_t  block_dev_cfg;
    clock_t                     flush_timestamp;
} blockio_settings_t;

struct _usb_msd_t {
    usb_t                       *usb_context;
    blockio_settings_t          blockio_info[BLOCKIO_INSTANCE_COUNT];
    int                         blockio_count;
    msd_state_t                 msd_state;
    msd_cbw_t                   msd_cbw;
    msd_csw_t                   msd_csw;
    uint8_t                     msd_buffer[BLOCKLEN_512];
    uint8_t *                   ptr_next_in_data;
    uint8_t *                   ptr_next_out_data;
    int                         msd_byte_count;
    request_sense_response_t    global_sense_data;
#if DEBUG_USB_MSD
    msd_state_t                 last_state;
    int                         debug_level;
#endif
};

static usb_msd_t usb_msd_table[USB_MSD_INSTANCE_COUNT];

static  inquiry_response_t          inquiry_response =
{
    0x00, 0x80, 0x04, 0x02, 0x20, 0x00, 0x00, 0x00, "Altium  ", "Nano Brick      ", "0001"
};

#if DEBUG_USB_MSD
/* show MSD state */
static void db_show_command(usb_msd_t *msd)
{
    if (msd->debug_level >= 2 && msd->last_state != msd->msd_state)
    {
        switch (msd->msd_state)
        {
            case MSD_DATA_IN:       printf("[DATA IN %08X]\n", msd->msd_cbw.dCBWDataTransferLength); break;
            case MSD_DATA_OUT:      printf("[DATA OUT %08X]\n", msd->msd_cbw.dCBWDataTransferLength); break;
            case MSD_READ_CBW:      printf("[READ CBW]\n"); break;
            case MSD_WRITE_CSW:     printf("[WRITE CSW %02X %08X]\n", msd->msd_csw.bCSWStatus, msd->msd_csw.dCSWDataResidue); break;
            case MSD_HANDLE_CMD:
                printf("[HANDLE CMD: %02X", msd->msd_cbw.CBWCB[0]);
                switch (msd->msd_cbw.CBWCB[0])
                {
                    case READ_10:
                    case WRITE_10:
                        /* show LBA and transfer length */
                        printf(" %08X %04X", little32(read_little32from8(&msd->msd_cbw.CBWCB[2])), little16(read_little16from8(&msd->msd_cbw.CBWCB[7])));
                        break;
                }
                printf("]\n");
                break;
        }
        msd->last_state = msd->msd_state;
    }
}
#endif /* DEBUG_USB_MSD */

void usb_msd_init(void)
{
    return;
}

/* handle USB class request */
static bool msd_handle_class_request(usb_setup_t* setup, uint8_t* result, int* length, void *data)
{
    bool    stall_request = true;
    usb_msd_t   *msd = data;

    switch (USB_REQTYPE_GET_REQUEST(setup))
    {
        case USB_FEATURE_MSD_MAX_LUN:
            result[0] = msd->blockio_count - 1; /* counted from 0 */
            *length = 1;
            stall_request = false;
            break;

        case USB_FEATURE_MSD_RESET:
            msd_reset(msd);
            *length = 0;
            stall_request = false;
            break;

        default:
            /* unhandled request => stall */
            break;
    }
    return stall_request;
}

/**
 * @brief   open the specified USB Mass Storage Device
 *
 * @param   id         id of the device to open
 *
 * @return  pointer to opened device or NULL when device could not be opened
 */
usb_msd_t *msd_open(int id)
{
    usb_msd_t                     *msd;
    const usb_msd_cfg_instance_t  *msd_cfg;
    int                            i;
#if (__POSIX_FILE_SYSTEM__)
    char scratch_path[PATH_MAX];
#endif

    assert((id >= 0) && (id < USB_MSD_INSTANCE_COUNT));

    msd = &usb_msd_table[id];
    if (msd->usb_context == NULL)
    {
        msd_cfg = &usb_msd_instance_table[id];
        for (i = 0; i < msd_cfg->blockio_size; i++)
        {
#if (__POSIX_FILE_SYSTEM__)
            sprintf(scratch_path, "/dev/%s", blockio_instance_table[msd_cfg->blockio[i]].name);
#endif
            msd->blockio_info[i].block_dev_rdonly = false;
#if (__POSIX_FILE_SYSTEM__)
            msd->blockio_info[i].block_dev = open(scratch_path, O_RDWR);
#else
            msd->blockio_info[i].block_dev = open(blockio_instance_table[msd_cfg->blockio[i]].name, O_RDWR);
#endif
            if (msd->blockio_info[i].block_dev < 0)
            {
                if (errno == EACCES)
                {
                    /* retry in read only mode */
#if (__POSIX_FILE_SYSTEM__)
                    msd->blockio_info[i].block_dev = open(scratch_path, O_RDONLY);
#else
                    msd->blockio_info[i].block_dev = open(blockio_instance_table[msd_cfg->blockio[i]].name, O_RDONLY);
#endif
                    if (msd->blockio_info[i].block_dev < 0)
                    {
#if DEBUG_USB_MSD
                        perror("open sdcard RDONLY:");
#endif
                    }
                    else
                    {
                        msd->blockio_info[i].block_dev_rdonly = true;
                    }
                }
                else
                {
#if DEBUG_USB_MSD
                    perror("open sdcard RDRW:");
#endif
                }
            }
            if (msd->blockio_info[i].block_dev >= 0)
            {
                posix_devctl(msd->blockio_info[i].block_dev, DEVCTL_BLOCKIO_CFG, &msd->blockio_info[i].block_dev_cfg, sizeof(msd->blockio_info[i].block_dev_cfg), NULL);
            }
        }
        msd->blockio_count = msd_cfg->blockio_size;
#if DEBUG_USB_MSD
        msd->last_state = MSD_DATA_IN;
        msd->debug_level = 2;
#endif
        msd_reset(msd);
        msd->usb_context = usb_open(msd_cfg->drv_cy7c68001, usb_msd_descr, usb_msd_descr_length);
        if (msd->usb_context != NULL)
            usb_set_class_request_handler(msd->usb_context, msd_handle_class_request, msd);
    }

    return msd->usb_context != NULL ? msd : NULL;
}


/**
 * @brief   reset the state of the specified open USB Mass Storage Device
 *
 * @param   msd     pointer to open USB Mass Storage Device
 *
 * @return  none
 */
void msd_reset(usb_msd_t *msd)
{
    msd->msd_state = MSD_READ_CBW;
}


/* check if a device is write protected */
static bool lun_is_write_protected(usb_msd_t *msd, uint8_t lun)
{
//    bool    write_protected = false;
//
//    if (block_drivers[lun].wp_func)
//    {
//        write_protected = (block_drivers[lun].wp_func)(NULL/*block_drivers[lun].block_driver*/);
//    }
//
//    return write_protected;
    return msd->blockio_info[lun].block_dev_rdonly;
}

/* read a CBW from the given endpoint */
static void msd_read_cbw(usb_msd_t *msd, uint8_t endpoint, msd_cbw_t* cbw, int* byte_count)
{
    if (usb_endpoint_ready(msd->usb_context, USB_MSD_OUT_EP))
    {
        int     i;

        cbw->dCBWSignature          = usb_read_endpoint_dword(msd->usb_context, endpoint);
        cbw->dCBWTag                = usb_read_endpoint_dword(msd->usb_context, endpoint);
        cbw->dCBWDataTransferLength = usb_read_endpoint_dword(msd->usb_context, endpoint);
        cbw->bmCBWFlags             = usb_read_endpoint_byte(msd->usb_context, endpoint);
        cbw->bCBWLUN                = usb_read_endpoint_byte(msd->usb_context, endpoint);
        cbw->bCBWCBLength           = usb_read_endpoint_byte(msd->usb_context, endpoint);
        for (i = 0; i < 16; i++)
        {
            cbw->CBWCB[i]           = usb_read_endpoint_byte(msd->usb_context, endpoint);
        }

        *byte_count = CBW_SIZE;
        msd->msd_state = MSD_HANDLE_CMD;
    }
}

/* write a CSW to the given endpoint */
static int msd_write_csw(usb_msd_t *msd, uint8_t endpoint, msd_csw_t* csw)
{
    usb_write_endpoint_dword(msd->usb_context, endpoint, csw->dCSWSignature);
    usb_write_endpoint_dword(msd->usb_context, endpoint, csw->dCSWTag);
    usb_write_endpoint_dword(msd->usb_context, endpoint, csw->dCSWDataResidue);
    usb_write_endpoint_byte(msd->usb_context, endpoint, csw->bCSWStatus);
    usb_endpoint_pktend(msd->usb_context, endpoint);
    return 13; /* number of bytes written */
}

/* write CSW to the designated endpoint and set the proper next state */
static void msd_send_csw(usb_msd_t *msd)
{
    if (usb_endpoint_ready(msd->usb_context, USB_MSD_IN_EP))
    {
        msd_write_csw(msd, USB_MSD_IN_EP, &msd->msd_csw);
        msd->msd_state = MSD_READ_CBW;
    }
}

/* write the given data to the designated endpoint */
static bool msd_send_data(usb_msd_t *msd, uint8_t* buffer, int length)
{
    bool    result = false;

    if (usb_endpoint_ready(msd->usb_context, USB_MSD_IN_EP))
    {
        usb_write_endpoint(msd->usb_context, USB_MSD_IN_EP, buffer, length);
        result = true;
    }
    return result;
}

/* handle data from device to host */
static void msd_data_in(usb_msd_t *msd)
{
    int     i, size;

    if ((msd->msd_csw.bCSWStatus == 0x00) && (msd->msd_csw.dCSWDataResidue >= USB_EPx_BUFFER_SIZE))
    {
        /* write next chunk of data to the EP buffer and adjust starting position
         * for next chunk */
        if (msd_send_data(msd, msd->ptr_next_in_data, USB_EPx_BUFFER_SIZE))
        {
            msd->msd_cbw.dCBWDataTransferLength -= USB_EPx_BUFFER_SIZE;
            msd->msd_csw.dCSWDataResidue -= USB_EPx_BUFFER_SIZE;
            msd->ptr_next_in_data += USB_EPx_BUFFER_SIZE;
        }
    }
    else
    {
        if (msd->msd_csw.bCSWStatus != 0x00)
        {
            /* some error has occurred */
            size = MIN(USB_EPx_BUFFER_SIZE, msd->msd_cbw.dCBWDataTransferLength);
            for (i = 0; i < size; i++)
            {
                /* prepare zero data */
                msd->msd_buffer[i] = 0;
            }
            if (msd->msd_cbw.dCBWDataTransferLength > USB_EPx_BUFFER_SIZE)
            {
                /* write next chunk */
                if (msd_send_data(msd, msd->msd_buffer, USB_EPx_BUFFER_SIZE))
                {
                    msd->msd_cbw.dCBWDataTransferLength -= USB_EPx_BUFFER_SIZE;
                    msd->msd_csw.dCSWDataResidue -= USB_EPx_BUFFER_SIZE;
                }
            }
            else
            {
                /* write remainder of data */
                if (msd_send_data(msd, msd->msd_buffer, msd->msd_cbw.dCBWDataTransferLength))
                {
                    msd->msd_csw.dCSWDataResidue = msd->msd_cbw.dCBWDataTransferLength = 0;
                }
            }
        }
        else
        {
            /* write remainder of data */
            if (msd_send_data(msd, msd->ptr_next_in_data, msd->msd_csw.dCSWDataResidue))
            {
                msd->msd_cbw.dCBWDataTransferLength -= msd->msd_csw.dCSWDataResidue;
                msd->msd_csw.dCSWDataResidue = msd->msd_cbw.dCBWDataTransferLength;
                msd->msd_cbw.dCBWDataTransferLength = 0;
            }
        }
    }
}

/* check if the CBW is valid */
static bool msd_cbw_is_valid(usb_msd_t *msd)
{
    return ((msd->msd_byte_count == CBW_SIZE) && (msd->msd_cbw.dCBWSignature == CBW_SIGNATURE));
}

/* check if the CBW has meaning */
static bool msd_cbw_is_meaningful(usb_msd_t *msd)
{
    return (   (msd->msd_cbw.bCBWLUN <= 0x0F)
            && (msd->msd_cbw.bCBWCBLength >= 0x01) && (msd->msd_cbw.bCBWCBLength <= 0x10)
            && ((msd->msd_cbw.bmCBWFlags == 0x00) || (msd->msd_cbw.bmCBWFlags == 0x80)));
}

/* prepare the CSW */
static void msd_prepare_csw(usb_msd_t *msd)
{
    msd->msd_csw.dCSWSignature = CSW_SIGNATURE;
    msd->msd_csw.dCSWTag = msd->msd_cbw.dCBWTag;
}

/* handle the SCSI inquiry response request */
static void msd_inquiry_handler(usb_msd_t *msd)
{
    int         i, size;
    uint8_t*    ptr;

    ptr  = (uint8_t *)&inquiry_response;
    size = sizeof(inquiry_response_t);
    for (i = 0; i < size; i++)
    {
        msd->msd_buffer[i] = ptr[i];
    }
    msd->msd_csw.dCSWDataResidue = size;
    msd->msd_csw.bCSWStatus = STATUS_PASSED;
}

/* reset all SCSI sense data */
static void msd_reset_sense_data(usb_msd_t *msd)
{
    msd->global_sense_data.ResponseCode = S_CURRENT;
    msd->global_sense_data.VALID = 0;
    msd->global_sense_data.Obsolete = 0x0;
    msd->global_sense_data.SenseKey = S_NO_SENSE;
    msd->global_sense_data.Resv = 0;
    msd->global_sense_data.ILI = 0;
    msd->global_sense_data.EOM = 0;
    msd->global_sense_data.FILEMARK = 0;
    msd->global_sense_data.Information = 0x00;
    msd->global_sense_data.AddSenseLen = 0x0a;
    msd->global_sense_data.CmdSpecificInfo = 0x0;
    msd->global_sense_data.ASC = 0x0;
    msd->global_sense_data.ASCQ = 0x0;
    msd->global_sense_data.FRUC = 0x0;
    msd->global_sense_data.SenseKeySpecific[0] = 0x0;
    msd->global_sense_data.SenseKeySpecific[1] = 0x0;
    msd->global_sense_data.SenseKeySpecific[2] = 0x0;
}

/* handle the SCSI read capacity request */
static void msd_read_capacity_handler(usb_msd_t *msd)
{
    uint8_t     lun;

    lun = msd->msd_cbw.bCBWLUN;
    write_little32to8(&msd->msd_buffer[0], little32(msd->blockio_info[lun].block_dev_cfg.blktotal - 1));
    write_little32to8(&msd->msd_buffer[4], little32(msd->blockio_info[lun].block_dev_cfg.blksize));
    msd->msd_csw.dCSWDataResidue = 0x08;
    msd->msd_csw.bCSWStatus = STATUS_PASSED;
}

/* handle the SCSI read request */
static void msd_read_handler(usb_msd_t *msd)
{
    uint32_t    lba;
    uint16_t    i, transfer_length;
    int         blocks;
    uint8_t     lun;

    lun             = msd->msd_cbw.bCBWLUN;
    lba             = little32(read_little32from8(&msd->msd_cbw.CBWCB[2]));
    transfer_length = little16(read_little16from8(&msd->msd_cbw.CBWCB[7]));

    msd->msd_csw.bCSWStatus = STATUS_PASSED;
    msd->msd_csw.dCSWDataResidue = 0;

    if (lba + transfer_length >= msd->blockio_info[lun].block_dev_cfg.blktotal)
    {
        msd->msd_csw.bCSWStatus = STATUS_FAILED;
        msd->global_sense_data.SenseKey = S_ILLEGAL_REQUEST;
        msd->global_sense_data.ASC = ASC_LOGICAL_BLOCK_ADDRESS_OUT_OF_RANGE;
        msd->global_sense_data.ASCQ = ASCQ_LOGICAL_BLOCK_ADDRESS_OUT_OF_RANGE;
    }
    else
    {
        for (i = 0; i < transfer_length; i++, lba++)
        {
            //blocks = bread(block_drivers[lun].id, msd_buffer, lba, 1);
            blocks = bread(msd->blockio_info[lun].block_dev, msd->msd_buffer, lba, 1);
            if (blocks == 1)
            {
                msd->msd_csw.bCSWStatus = STATUS_PASSED;
                msd->msd_csw.dCSWDataResidue = BLOCKLEN_512;
                msd->ptr_next_in_data = &msd->msd_buffer[0];
                while (msd->msd_csw.dCSWDataResidue > 0)
                {
                    /* TODO: handle idle loop here! */
                    msd_data_in(msd);
                }
                msd->msd_csw.dCSWDataResidue = 0;
            }
            else
            {
                msd->msd_csw.bCSWStatus = STATUS_FAILED;
                msd->msd_csw.dCSWDataResidue = 0x0;
                break;
            }
        }
    }
}

/* read a single EP-sized buffer from the designated endpoint */
static void msd_data_out(usb_msd_t *msd)
{
    int     length;

    if (usb_endpoint_ready(msd->usb_context, USB_MSD_OUT_EP))
    {
        length = usb_read_endpoint(msd->usb_context, USB_MSD_OUT_EP, msd->ptr_next_out_data, USB_EPx_BUFFER_SIZE);
        msd->msd_cbw.dCBWDataTransferLength -= length;
        msd->msd_csw.dCSWDataResidue -= length;
        msd->ptr_next_out_data += length;
    }
}

/* handle the SCSI write handler */
static void msd_write_handler(usb_msd_t *msd)
{
    uint32_t    lba;
    uint16_t    transfer_length;
    int         blocks;
    int         i;
    uint8_t     lun;

    lun             = msd->msd_cbw.bCBWLUN;
    lba             = little32(read_little32from8(&msd->msd_cbw.CBWCB[2]));
    transfer_length = little16(read_little16from8(&msd->msd_cbw.CBWCB[7]));

    msd->msd_csw.bCSWStatus = STATUS_PASSED;
    for (i = 0; i < transfer_length; i++, lba++)
    {
        msd->msd_csw.dCSWDataResidue = BLOCKLEN_512;
        msd->ptr_next_out_data = &msd->msd_buffer[0];
        /* read 512 bytes into buffer */
        while (msd->msd_csw.dCSWDataResidue > 0)
        {
            msd_data_out(msd);
        }
        if (lun_is_write_protected(msd, lun))
        {
            msd->global_sense_data.SenseKey = S_NOT_READY;
            msd->global_sense_data.ASC = ASC_WRITE_PROTECTED;
            msd->global_sense_data.ASCQ = ASCQ_WRITE_PROTECTED;
            msd->msd_csw.bCSWStatus = STATUS_FAILED;
            break;
        }
        else
        {
            blocks = bwrite(msd->blockio_info[lun].block_dev, msd->msd_buffer, lba, 1);
        }
        if (blocks != 1)
        {
            msd->global_sense_data.SenseKey = S_MEDIUM_ERROR;
            msd->global_sense_data.ASC = ASC_WRITE_FAULT;
            msd->global_sense_data.ASCQ = ASCQ_WRITE_FAULT;
            msd->msd_csw.bCSWStatus = STATUS_FAILED;
            break;
        }
    }
    if (transfer_length)
    {
        /* set the flush_timestamp time if not set already */
        if (msd->blockio_info[lun].flush_timestamp == 0)
        {
            msd->blockio_info[lun].flush_timestamp = clock() + FLUSH_DELAY_TIME;
        }
    }
}

/* handle SCSI request sense request */
static void msd_request_sense_handler(usb_msd_t *msd)
{
    /* As the bitfields used in the struct are not always treated as single
     * 8-bit fields, we have to copy the data manually */
    msd->msd_buffer[ 0] = (msd->global_sense_data.VALID << 7) | msd->global_sense_data.ResponseCode;
    msd->msd_buffer[ 1] = 0;
    msd->msd_buffer[ 2] = (msd->global_sense_data.FILEMARK << 7) | (msd->global_sense_data.EOM << 6) | (msd->global_sense_data.ILI << 5) | (msd->global_sense_data.Resv << 4) | msd->global_sense_data.SenseKey;
    msd->msd_buffer[ 3] = (msd->global_sense_data.Information >> 24) & 0xFF;
    msd->msd_buffer[ 4] = (msd->global_sense_data.Information >> 16) & 0xFF;
    msd->msd_buffer[ 5] = (msd->global_sense_data.Information >> 8) & 0xFF;
    msd->msd_buffer[ 6] = msd->global_sense_data.Information & 0xFF;
    msd->msd_buffer[ 7] = msd->global_sense_data.AddSenseLen;
    msd->msd_buffer[ 8] = (msd->global_sense_data.CmdSpecificInfo >> 24) & 0xFF;
    msd->msd_buffer[ 9] = (msd->global_sense_data.CmdSpecificInfo >> 16) & 0xFF;
    msd->msd_buffer[10] = (msd->global_sense_data.CmdSpecificInfo >> 8) & 0xFF;
    msd->msd_buffer[11] = msd->global_sense_data.CmdSpecificInfo & 0xFF;
    msd->msd_buffer[12] = msd->global_sense_data.ASC;
    msd->msd_buffer[13] = msd->global_sense_data.ASCQ;
    msd->msd_buffer[14] = msd->global_sense_data.FRUC;
    msd->msd_buffer[15] = msd->global_sense_data.SenseKeySpecific[0];
    msd->msd_buffer[16] = msd->global_sense_data.SenseKeySpecific[1];
    msd->msd_buffer[17] = msd->global_sense_data.SenseKeySpecific[2];
    msd->msd_csw.dCSWDataResidue = 0x12;
    msd->msd_csw.bCSWStatus = STATUS_PASSED;
}

/* handle SCSI mode sense request */
static void msd_mode_sense_handler(usb_msd_t *msd)
{
    uint8_t     lun = msd->msd_cbw.bCBWLUN;

    msd->msd_buffer[0] = 0x03;
    msd->msd_buffer[1] = 0x00;
    msd->msd_buffer[2] = 0x00;
    if (lun_is_write_protected(msd, lun))
    {
        msd->msd_buffer[2] |= 0x80;
    }
    msd->msd_buffer[3] = 0x00;
    msd->msd_csw.dCSWDataResidue = 4;
    msd->msd_csw.bCSWStatus = STATUS_PASSED;
}

/* handle SCSI medium removal request */
static void msd_medium_removal_handler(usb_msd_t *msd)
{
    uint8_t     lun = msd->msd_cbw.bCBWLUN;

#if 0
    /* disable this for now */
    if (msd_cbw.CBWCB[4] & 0x01 == 0x00)
    {
        msd_csw.bCSWStatus = STATUS_PASSED;
    }
    else
    {
        /* fail to disable Windows write caching */
        global_sense_data.SenseKey = S_ILLEGAL_REQUEST;
        global_sense_data.ASC = ASC_INVALID_FIELD_IN_COMMAND_PACKET;
        global_sense_data.ASCQ = ASCQ_INVALID_FIELD_IN_COMMAND_PACKET;
        msd_csw.bCSWStatus = STATUS_FAILED;
    }
#else /* !0 */
    if (msd->msd_cbw.CBWCB[4] & 0x01 == 0x00)
    {
        /* allow removal of media */
        if (msd->blockio_info[lun].block_dev >= 0)
        {
            bflush(msd->blockio_info[lun].block_dev, /*invalidate=*/0);
            msd->blockio_info[lun].flush_timestamp = 0;
        }
    }
    msd->msd_csw.bCSWStatus = STATUS_PASSED;
#endif /* 0 */
    msd->msd_csw.dCSWDataResidue = 0;
}

/* handle SCSI test unit ready request */
static void msd_test_unit_ready_handler(usb_msd_t *msd)
{
    uint8_t     lun = msd->msd_cbw.bCBWLUN;

    msd_reset_sense_data(msd);
    if (msd->blockio_info[lun].block_dev >= 0)
    {
        msd->msd_csw.bCSWStatus = STATUS_PASSED;
    }
    else
    {
        msd->global_sense_data.SenseKey = S_UNIT_ATTENTION;
        msd->global_sense_data.ASC = ASC_MEDIUM_NOT_PRESENT;
        msd->global_sense_data.ASCQ = ASCQ_MEDIUM_NOT_PRESENT;
        msd->msd_csw.bCSWStatus = STATUS_FAILED;
    }
    msd->msd_csw.dCSWDataResidue = 0;
}

/* handle SCSI verify request */
static void msd_verify_handler(usb_msd_t *msd)
{
    msd->msd_csw.bCSWStatus = STATUS_PASSED;
    msd->msd_csw.dCSWDataResidue = 0;
}

/* handle SCSI stop/start request */
static void msd_stop_start_handler(usb_msd_t *msd)
{
    msd->msd_csw.bCSWStatus = STATUS_PASSED;
    msd->msd_csw.dCSWDataResidue = 0;
}

/* handle a SCSI request */
static void msd_handle_command(usb_msd_t *msd)
{
    uint8_t     lun = msd->msd_cbw.bCBWLUN;

    if (msd->msd_cbw.CBWCB[0] != INQUIRY && lun >= msd->blockio_count)
    {
        msd->msd_csw.bCSWStatus = STATUS_FAILED;
        msd->global_sense_data.SenseKey = S_ILLEGAL_REQUEST;
        msd->global_sense_data.ASC = ASC_LOGICAL_UNIT_NOT_SUPPORTED;
        msd->global_sense_data.ASCQ = ASCQ_LOGICAL_UNIT_NOT_SUPPORTED;
    }
    else
    {
        switch (msd->msd_cbw.CBWCB[0])
        {
            case INQUIRY:
                msd_inquiry_handler(msd);
                break;
            case READ_CAPACITY:
                if (msd->blockio_info[lun].block_dev >= 0)
                {
                    msd_read_capacity_handler(msd);
                }
                else
                {
                    msd->msd_csw.bCSWStatus = STATUS_FAILED;
                    msd->global_sense_data.SenseKey = S_NOT_READY;
                    msd->global_sense_data.ASC = ASC_MEDIUM_NOT_PRESENT;
                    msd->global_sense_data.ASCQ = ASCQ_MEDIUM_NOT_PRESENT;
                }
                break;
            case READ_10:
                if (msd->blockio_info[lun].block_dev >= 0)
                {
                    msd_read_handler(msd);
                }
                else
                {
                    msd->msd_csw.bCSWStatus = STATUS_FAILED;
                    msd->global_sense_data.SenseKey = S_NOT_READY;
                    msd->global_sense_data.ASC = ASC_MEDIUM_NOT_PRESENT;
                    msd->global_sense_data.ASCQ = ASCQ_MEDIUM_NOT_PRESENT;
                }
                break;
            case WRITE_10:
                if (msd->blockio_info[lun].block_dev >= 0)
                {
                    msd_write_handler(msd);
                }
                else
                {
                    msd->msd_csw.bCSWStatus = STATUS_FAILED;
                    msd->global_sense_data.SenseKey = S_NOT_READY;
                    msd->global_sense_data.ASC = ASC_MEDIUM_NOT_PRESENT;
                    msd->global_sense_data.ASCQ = ASCQ_MEDIUM_NOT_PRESENT;
                }
                break;
            case REQUEST_SENSE:
                msd_request_sense_handler(msd);
                break;
            case MODE_SENSE:
                msd_mode_sense_handler(msd);
                break;
            case PREVENT_ALLOW_MEDIUM_REMOVAL:
                msd_medium_removal_handler(msd);
                break;
            case TEST_UNIT_READY:
                msd_test_unit_ready_handler(msd);
                break;
            case VERIFY:
                msd_verify_handler(msd);
                break;
            case STOP_START:
                msd_stop_start_handler(msd);
                break;
            default:
                msd->global_sense_data.SenseKey = S_ILLEGAL_REQUEST;
                msd->global_sense_data.ASC = ASC_INVALID_COMMAND_OPCODE;
                msd->global_sense_data.ASCQ = ASCQ_INVALID_COMMAND_OPCODE;
                msd->msd_csw.bCSWStatus = STATUS_FAILED;
                msd->msd_csw.dCSWDataResidue = 0x00;
                break;
        }
    }
    msd->ptr_next_in_data = &msd->msd_buffer[0];
}

/**
 * @brief   handle a USB mass storage request for the specified device
 *          this routine must be called frequently to handle requests of
 *          the connected host
 *
 * @param   msd     pointer to open USB Mass Storage Device
 *
 * @return  none
 */
void msd_handle_request(usb_msd_t *msd)
{
    uint8_t     lun;

    /* check if the block and USB drivers are initialized */
    if (msd->usb_context)
    {
        usb_handle_request(msd->usb_context);
        lun = msd->msd_cbw.bCBWLUN;
#if DEBUG_USB_MSD
        db_show_command(msd);
#endif
        switch (msd->msd_state)
        {
            case MSD_READ_CBW:
                /* read new CBW and set next state */
                msd_read_cbw(msd, USB_MSD_OUT_EP, &msd->msd_cbw, &msd->msd_byte_count);
                break;

            case MSD_WRITE_CSW:
                /* write CSW and set next state */
                msd_send_csw(msd);
                break;

            case MSD_DATA_IN:
                /* send data to host */
                if (msd->msd_cbw.dCBWDataTransferLength == 0)
                {
                    /* no more data to send */
                    msd->msd_state = MSD_WRITE_CSW;
                }
                else
                {
                    /* data available to send */
                    msd_data_in(msd);
                }
                break;

            case MSD_DATA_OUT:
                /* receive data from host */
                if (msd->msd_cbw.dCBWDataTransferLength == 0)
                {
                    /* all data received */
                    if (msd->msd_csw.bCSWStatus == 0x00 && msd->msd_csw.dCSWDataResidue != 0)
                    {
                        /* more data is available */
                        msd->msd_csw.bCSWStatus = STATUS_PHASE_ERROR;
                    }
                    msd->msd_state = MSD_WRITE_CSW;
                }
                break;

            case MSD_HANDLE_CMD:
                /* process the CBW */
                if (msd_cbw_is_valid(msd))
                {
                    if (msd_cbw_is_meaningful(msd))
                    {
                        msd_prepare_csw(msd);
                        if (msd->msd_cbw.dCBWDataTransferLength == 0 || msd->msd_cbw.bmCBWFlags == 0x80)
                        {
                            /* device to host */
                            msd->msd_state = MSD_DATA_IN;
                        }
                        else if (msd->msd_cbw.bmCBWFlags == 0x00)
                        {
                            /* host to device */
                            msd->msd_state = MSD_DATA_OUT;
                        }
                        msd_handle_command(msd);
                    }
                }
                break;
        }

        if (msd->blockio_info[lun].block_dev >= 0 && msd->blockio_info[lun].flush_timestamp != 0 && (clock() > msd->blockio_info[lun].flush_timestamp))
        {
            bflush(msd->blockio_info[lun].block_dev, /*invalidate=*/0);
            msd->blockio_info[lun].flush_timestamp = 0;
        }
    }
}

