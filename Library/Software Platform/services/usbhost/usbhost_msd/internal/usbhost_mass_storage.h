/*
 * usbhost_mass_storage.h
 */

// Basic functions to impliment
//  - Inquiry
//  - Read capacity
//  - Read
//  - Request sense
//  - Test unit ready
//  - Write

#include <stddef.h>
#include <stdlib.h>
#include <stdint.h>

#ifndef _USBHOST_MASS_STORAGE_H
#define _USBHOST_MASS_STORAGE_H

#include <usbhost_core.h>

/*
 * (copied from of http://www.lvr.com/mass_storage.htm)
 * The mass-storage bulk-only protocol defines how a USB host can send commands
 * and receive responses using the bulk transfers defined by the USB specification.
 * In the bulk-only protocol, each exchange of information requires two or three
 * USB transfers. In the first transfer, the host sends a command in a structure
 * called a Command Block Wrapper (CBW). Many CBWs are followed by a transfer
 * that contains data sent to the host or device. In the final transfer, the
 * device returns status in a structure called a Command Status Wrapper (CSW).
 */

////////////////////////////////////////////////////////////////////////////////
typedef struct __packed__ _scsi_cmd6_t {
        uint8_t     opcode;
#if __BIG_ENDIAN__
        uint8_t     misc : 5;
        uint8_t     lun  : 3;
#else
        uint8_t     lun  : 3;
        uint8_t     misc : 5;
#endif
        uint8_t     data[3];
        uint8_t     control;
} scsi_cmd6_t;

typedef struct __packed__ _scsi_inquiry_t {
        uint8_t     opcode;
#if __BIG_ENDIAN__
        uint8_t     reserved1 : 6;
        uint8_t     cmddt : 1;
        uint8_t     evpd : 1;
#else
        uint8_t     evpd : 1;
        uint8_t     cmddt : 1;
        uint8_t     reserved1 : 6;
#endif
        uint8_t     page_or_operation_code;
        uint8_t     reserved3;
        uint8_t     allocation_length;
        uint8_t     control;
} scsi_inquiry_t;

typedef struct __packed__ _scsi_inquiry_data_t {
#if __BIG_ENDIAN__
        uint8_t     peripheral_qualifier : 3;
        uint8_t     peripheral_device_type : 5;

        uint8_t     rmb : 1;
        uint8_t     reserved1 : 7;

        uint8_t     version;

        uint8_t     aerc : 1;
        uint8_t     obs3 : 1;
        uint8_t     normaca : 1;
        uint8_t     hisup : 1;
        uint8_t     response_data_format : 4;

        uint8_t     aditional_length;           /* (n-4) */

        uint8_t     sccs : 1;
        uint8_t     reserved5 : 7;

        uint8_t     bque : 1;
        uint8_t     encserv : 1;
        uint8_t     vs6_5 : 1;
        uint8_t     multip : 1;
        uint8_t     mchngr : 1;
        uint8_t     obs6_2 : 1;
        uint8_t     obs6_1 : 1;
        uint8_t     addr16 : 1;

        uint8_t     reladr : 1;
        uint8_t     obs7_6 : 1;
        uint8_t     wbus16 : 1;
        uint8_t     sync : 1;
        uint8_t     linked : 1;
        uint8_t     obs7_2 : 1;
        uint8_t     cmdque : 1;
        uint8_t     vs7_0 : 1;

        uint8_t     vendor[8];
        uint8_t     product[16];
        uint8_t     revision[4];
#else
        uint8_t     peripheral_device_type : 5;
        uint8_t     peripheral_qualifier : 3;
        uint8_t     reserved1 : 7;
        uint8_t     rmb : 1;
        uint8_t     version;
        uint8_t     response_data_format : 4;
        uint8_t     hisup : 1;
        uint8_t     normaca : 1;
        uint8_t     obs3 : 1;
        uint8_t     aerc : 1;
        uint8_t     aditional_length;           /* (n-4) */
        uint8_t     reserved5 : 7;
        uint8_t     sccs : 1;
        uint8_t     addr16 : 1;
        uint8_t     obs6_1 : 1;
        uint8_t     obs6_2 : 1;
        uint8_t     mchngr : 1;
        uint8_t     multip : 1;
        uint8_t     vs6_5 : 1;
        uint8_t     encserv : 1;
        uint8_t     bque : 1;
        uint8_t     vs7_0 : 1;
        uint8_t     cmdque : 1;
        uint8_t     obs7_2 : 1;
        uint8_t     linked : 1;
        uint8_t     sync : 1;
        uint8_t     wbus16 : 1;
        uint8_t     obs7_6 : 1;
        uint8_t     reladr : 1;
        uint8_t     vendor[8];
        uint8_t     product[16];
        uint8_t     revision[4];
#endif
} scsi_inquiry_data_t;

typedef struct __packed__ _scsi_report_luns_t {
    uint8_t     opcode;
    uint8_t     reserved1;
    uint8_t     reserved2;
    uint8_t     reserver3;
    uint8_t     reserver4;
    uint8_t     reserver5;
    uint32_t    length;
    uint8_t     reserver10;
    uint8_t     control;
} scsi_report_luns_t;

typedef struct __packed__ _scsi_read_capacity_t {
#if __BIG_ENDIAN__
    uint8_t     opcode;
    uint8_t     reserved1 : 6;
    uint8_t     longlba : 1;
    uint8_t     reladr : 1;
    uint32_t    lba;
    uint8_t     reserver6;
    uint8_t     reserver7;
    uint8_t     reserver8;
    uint8_t     control;
#else
    uint8_t     opcode;
    uint8_t     reladr : 1;
    uint8_t     longlba : 1;
    uint8_t     reserved1 : 6;
    uint32_t    lba;
    uint8_t     reserver6;
    uint8_t     reserver7;
    uint8_t     reserver8;
    uint8_t     control;
#endif
} scsi_read_capacity_t;

typedef struct __packed__ _scsi_read6_t {
#if __BIG_ENDIAN__
    uint32_t    opcode : 8;
    uint32_t    reserved1_5 : 3;
    uint32_t    lba : 21;
    uint8_t     length;
    uint8_t     control;
#else
    uint32_t    lba : 21;
    uint32_t    reserved1_5 : 3;
    uint32_t    opcode : 8;
    uint8_t     length;
    uint8_t     control;
#endif
} scsi_read6_t;

typedef struct __packed__ _scsi_read10_t {
#if __BIG_ENDIAN__
    uint8_t     opcode;
    uint8_t     reserved1_5 : 3;
    uint8_t     dpo : 1;
    uint8_t     fua : 1;
    uint8_t     reserved1_1 : 2;
    uint8_t     reladr : 1;
    uint32_t    lba;
    uint8_t     reserved6;
    uint16_t    length;
    uint8_t     control;
#else
    uint8_t     opcode;
    uint8_t     reladr : 1;
    uint8_t     reserved1_1 : 2;
    uint8_t     fua : 1;
    uint8_t     dpo : 1;
    uint8_t     reserved1_5 : 3;
    uint32_t    lba;
    uint8_t     reserved6;
    uint16_t    length;
    uint8_t     control;
#endif
} scsi_read10_t;

typedef struct __packed__ _scsi_read16_t {
#if __BIG_ENDIAN__
    uint8_t     opcode;
    uint8_t     reserved1_5 : 3;
    uint8_t     dpo : 1;
    uint8_t     fua : 1;
    uint8_t     reserved1_1 : 2;
    uint8_t     reladr : 1;
    uint64_t    lba;
    uint32_t    length;
    uint8_t     reserved14;
    uint8_t     control;
#else
    uint8_t     opcode;
    uint8_t     reladr : 1;
    uint8_t     reserved1_1 : 2;
    uint8_t     fua : 1;
    uint8_t     dpo : 1;
    uint8_t     reserved1_5 : 3;
    uint64_t    lba;
    uint32_t    length;
    uint8_t     reserved14;
    uint8_t     control;
#endif
} scsi_read16_t;

typedef struct __packed__ _scsi_write10_t {
#if __BIG_ENDIAN__
    uint8_t     opcode;
    uint8_t     reserved1_5 : 3;
    uint8_t     dpo : 1;
    uint8_t     fua : 1;
    uint8_t     ebp : 1;
    uint8_t     reserved1_1 : 1;
    uint8_t     reladr : 1;
    uint32_t    lba;
    uint8_t     reserved6;
    uint16_t    length;
    uint8_t     control;
#else
    uint8_t     opcode;
    uint8_t     reladr : 1;
    uint8_t     reserved1_1 : 1;
    uint8_t     ebp : 1;
    uint8_t     fua : 1;
    uint8_t     dpo : 1;
    uint8_t     reserved1_5 : 3;
    uint32_t    lba;
    uint8_t     reserved6;
    uint16_t    length;
    uint8_t     control;
#endif
} scsi_write10_t;

typedef struct __packed__ _scsi_short_read_capacity_data {
    uint32_t    returned_logical_block_address;
    uint32_t    block_lenght_in_bytes;
} scsi_short_read_capacity_data;

typedef struct __packed__ _scsi_long_read_capacity_data {
    uint64_t    returned_logical_block_address;
    uint32_t    block_lenght_in_bytes;
} scsi_long_read_capacity_data;

typedef struct __packed__ _scsi_request_sense_t {
#if __BIG_ENDIAN__
    uint8_t     opcode;
    uint8_t     reserved1_1:7;
    uint8_t     desc:1;
    uint8_t     reserved2;
    uint8_t     reserved3;
    uint8_t     length;
    uint8_t     control;
#else
    uint8_t     opcode;
    uint8_t     desc:1;
    uint8_t     reserved1_1:7;
    uint8_t     reserved2;
    uint8_t     reserved3;
    uint8_t     length;
    uint8_t     control;
#endif
} scsi_request_sense_t;

typedef struct __packed__ _scsi_sense_response_t {
#if __BIG_ENDIAN__
    uint8_t     valid:1;
    uint8_t     response_code:7;
    uint8_t     obsolete1;
    uint8_t     filemark:1;
    uint8_t     eom:1;                          /* end-of-medium */
    uint8_t     ili:1;                          /* incorrect length indicator */
    uint8_t     reserved2_4:1;
    uint8_t     sense_key:4;
    uint32_t    information;
    uint8_t     additional_sense_lenght;        /* (n-7) */
    uint32_t    command_specific_information;
    uint8_t     additioal_sense_code;
    uint32_t    additioal_sense_code_qualifier:8;
    uint32_t    sksv:1;                         /* sense-key specific valid */
    uint32_t    sense_key_specific:23;
//    uint8_t     additional_sense_bytes[];
#else
    uint8_t     response_code:7;
    uint8_t     valid:1;
    uint8_t     obsolete1;
    uint8_t     sense_key:4;
    uint8_t     reserved2_4:1;
    uint8_t     ili:1;                          /* incorrect length indicator */
    uint8_t     eom:1;                          /* end-of-medium */
    uint8_t     filemark:1;
    uint32_t    information;
    uint8_t     additional_sense_lenght;        /* (n-7) */
    uint32_t    command_specific_information;
    uint8_t     additional_sense_code;
    uint8_t     additional_sense_code_qualifier;
    uint32_t    sense_key_specific:23;
    uint32_t    sksv:1;                         /* sense-key specific valid */
    uint32_t    field_replaceable_unit_code:8;
//    uint8_t     additional_sense_bytes[];
#endif
} scsi_sense_response_t;

/* ILLEGAL REQUEST */
typedef struct __packed__ _scsi_sense_field_pointer {
#if __BIG_ENDIAN__
    uint8_t     bit_pointer:3;
    uint8_t     bpv:1;                          /* bit pointer valid */
    uint8_t     reserved15_54:2;
    uint8_t     cd:1;                           /* command or data */
    uint8_t     sksv:1;
    uint16_t    field_pointer;
#else
    uint8_t     sksv:1;
    uint8_t     cd:1;                           /* command or data */
    uint8_t     reserved15_54:2;
    uint8_t     bpv:1;                          /* bit pointer valid */
    uint8_t     bit_pointer:3;
    uint16_t    field_pointer;
#endif
} scsi_sense_field_pointer;

/* RECOVERED ERROR, HARDWARE ERROR or MEDIUM ERROR */
typedef struct __packed__ _scsi_sense_actual_retry_count {
#if __BIG_ENDIAN__
    uint8_t     reserved15_60:7;
    uint8_t     sksv:1;
    uint16_t    actual_retry_count;
#else
    uint8_t     sksv:1;
    uint8_t     reserved15_60:7;
    uint16_t    actual_retry_count;
#endif
} scsi_sense_actual_retry_count;

/* NOT READY or NO SENSE */
typedef struct __packed__ _scsi_sense_progress_indication {
#if __BIG_ENDIAN__
    uint8_t     reserved15_60:7;
    uint8_t     sksv:1;
    uint16_t    progress_indication;
#else
    uint8_t     sksv:1;
    uint8_t     reserved15_60:7;
    uint16_t    progress_indication;
#endif
} scsi_sense_progress_indication;

/* COPY ABORTED */
typedef struct __packed__ _scsi_sense_segment_pointer {
#if __BIG_ENDIAN__
    uint8_t     bit_pointer:3;
    uint8_t     bpv:1;                          /* bit pointer valid */
    uint8_t     reserved15_4:1;
    uint8_t     sd:1;                           /* segment descriptor */
    uint8_t     reserved15_6:1;
    uint8_t     sksv:1;
    uint16_t    segment_pointer;
#else
    uint8_t     sksv:1;
    uint8_t     reserved15_6:1;
    uint8_t     sd:1;                           /* segment descriptor */
    uint8_t     reserved15_4:1;
    uint8_t     bpv:1;                          /* bit pointer valid */
    uint8_t     bit_pointer:3;
    uint16_t    segment_pointer;
#endif
} scsi_sense_segment_pointer;

#define SCSI_SENSE_CURRENT_ERROR            0x70
#define SCSI_SENSE_DEFERRED_ERROR           0x71

#define SCSI_SENSE_KEY_NO_SENSE             0x00
#define SCSI_SENSE_KEY_RECOVERED_ERROR      0x01
#define SCSI_SENSE_KEY_NOT_READY            0x02
#define SCSI_SENSE_KEY_MEDIUM_ERROR         0x03
#define SCSI_SENSE_KEY_HARDWARE_ERROR       0x04
#define SCSI_SENSE_KEY_ILLEGAL_REQUEST      0x05
#define SCSI_SENSE_KEY_UNIT_ATTENTION       0x06
#define SCSI_SENSE_KEY_DATA_PROTECT         0x07
#define SCSI_SENSE_KEY_BLANK_CHECK          0x08
#define SCSI_SENSE_KEY_VENDOR_SPECIFIC      0x09
#define SCSI_SENSE_KEY_COPY_ABORTED         0x0A
#define SCSI_SENSE_KEY_ABORTED_COMMAND      0x0B
/* Obsolete                                 0x0C    */
#define SCSI_SENSE_KEY_VOLUME_OVERFLOW      0x0D
#define SCSI_SENSE_KEY_MISCOMPARE           0x0E
/* Reserved                                 0x0F    */

typedef struct __packed__ _scsi_mode_sense6_t {
#if __BIG_ENDIAN__
    uint8_t     opcode;
    uint8_t     reserved1_4:4;
    uint8_t     dbd:1;
    uint8_t     reserved1_0:3;
    uint8_t     pc:2;
    uint8_t     page_code:6;
    uint8_t     subpage_code;
    uint8_t     length;
    uint8_t     control;
#else
    uint8_t     opcode;
    uint8_t     reserved1_0:3;
    uint8_t     dbd:1;
    uint8_t     reserved1_4:4;
    uint8_t     page_code:6;
    uint8_t     pc:2;
    uint8_t     subpage_code;
    uint8_t     length;
    uint8_t     control;
#endif
} scsi_mode_sense6_t;

typedef struct __packed__ _scsi_test_unit_ready_t {
    uint8_t     opcode;
    uint8_t     reserved1;
    uint8_t     reserved2;
    uint8_t     reserved3;
    uint8_t     reserved4;
    uint8_t     control;
} scsi_test_unit_ready_t;

/*
 * Bulk-only Command Block Wrapper (CBW)
 */
typedef struct __packed__ _msd_cbw_t {
  uint32_t dSignature;
  uint32_t dTag;
  uint32_t dDataLength;
  uint8_t  bmFlags;
  uint8_t  bLUN;
  uint8_t  bCBLength;
  uint8_t  CB[16];
} msd_cbw_t;

/*
 * Bulk-only Command Status Wrapper (CSW)
 */
typedef struct __packed__ _msd_csw_t {
  uint32_t dSignature;
  uint32_t dTag;
  uint32_t dDataResidue;                /*@ */
  uint8_t  bStatus;                     /*@ bCSWStatus indicates the success or failure of the command. */
} msd_csw_t;

/*
 * Signature values for CBW and CSW
 */
#define MSD_CBW_SIGNATURE               0x43425355
#define MSD_CSW_SIGNATURE               0x53425355

/*
 * CSW Status Definitions
 */
#define MSD_CSW_PASSED                  0x00
#define MSD_CSW_FAILED                  0x01
#define MSD_CSW_PHASE_ERROR             0x02

/*
 * SCSI Block Commands - 2 (SBC-2)
 * 5.1 Commands for direct-access block devices
 *
 *      M       = Command implementation is mandatory.
 *      O       = Command implementation is optional.
 *      SPC-2   = SCSI-3 Primary Commands - 2
 *      SMC     = SCSI-3 Medium Changer Commands
 */
#define SCSI_FORMAT_UNIT                0x04    /* M    5.1.1 */
#define SCSI_INQUIRY                    0x12    /* M    SPC-2 */
#define SCSI_READ6                      0x08    /* M    5.1.6 */
#define SCSI_READ10                     0x28    /* M    5.1.7 */
#define SCSI_READ16                     0x88    /* M    5.1.9 */
#define SCSI_READ_CAPACITY              0x25    /* M    5.1.10 */
#define SCSI_RELEASE10                  0x57    /* M    SPC-2 */
#define SCSI_REQUEST_SENSE              0x03    /* M    SPC-2 */
#define SCSI_RESERVE10                  0x56    /* M    SPC-2 */
#define SCSI_SEND_DIAGNOSTIC            0x1D    /* M    SPC-2 */
#define SCSI_TEST_UNIT_READY            0x00    /* M    SPC-2 */

#define SCSI_CACHE10                    0x36    /* O    5.1.2 */
#define SCSI_CACHE16                    0x92    /* O    5.1.3 */
#define SCSI_LOG_SELECT                 0x4C    /* O    SPC-2 */
#define SCSI_LOG_SENSE                  0x4D    /* O    SPC-2 */
#define SCSI_MODE_SELECT6               0x15    /* O    SPC-2 */
#define SCSI_MODE_SELECT10              0x55    /* O    SPC-2 */
#define SCSI_MODE_SENSE6                0x1A    /* O    SPC-2 */
#define SCSI_MODE_SENSE10               0x5A    /* O    SPC-2 */
#define SCSI_MOVE_MEDIUM                0xA7    /* O    SMC */
#define SCSI_PERSISTENT_RESERVE_IN      0x5E    /* O1   SPC-2 */
#define SCSI_PERSISTENT_RESERVE_OUT     0x5F    /* O1   SPC-2 */
#define SCSI_PRE_FETCH10                0x34    /* O    5.1.4 */
#define SCSI_PRE_FETCH16                0x90    /* O    5.1.5 */
#define SCSI_MEDIUM_REMOVAL             0x1E    /* O    SPC-2 */
#define SCSI_READ12                     0xA8    /* O    5.1.8 */
#define SCSI_READ_BUFFER                0x3C    /* O    SPC-2 */
#define SCSI_READ_DEFECT_DATA10         0x37    /* O    5.1.11 */
#define SCSI_READ_DEFECT_DATA12         0xB7    /* O    5.1.12 */
#define SCSI_READ_ELEMENT_STATUS        0xB4    /* O    SMC */
#define SCSI_READ_LONG                  0x3E    /* O    5.1.13 */
#define SCSI_REASSIGN_BLOCKS            0x07    /* O    5.1.14 */
#define SCSI_REBUILD16                  0x81    /* O    5.1.15 */
#define SCSI_REBUILD32                  0x7F    /* O    5.1.16 */
#define SCSI_RECEIVE_DIAGNOSTIC_RESULTS 0x1C    /* O    SPC-2 */
#define SCSI_REGENERATE16               0x82    /* O    5.1.17 */
#define SCSI_REGENERATE32               0x7F    /* O    5.1.18 */
#define SCSI_RELEASE6                   0x17    /* O2   SPC-2 */
#define SCSI_REPORT_LUNS                0xA0    /* O    SPC-2 */
#define SCSI_RESERVE6                   0x16    /* O2   SPC-2 */
#define SCSI_SEEK10                     0x2B    /* O    5.1.19 */
#define SCSI_SET_LIMITS10               0x33    /* O    5.1.20 */
#define SCSI_SET_LIMITS12               0xB3    /* O    5.1.21 */
#define SCSI_START_STOP_UNIT            0x1B    /* O    5.1.22 */
#define SCSI_SYNCHRONIZE_CACHE10        0x35    /* O    5.1.23 */
#define SCSI_SYNCHRONIZE_CACHE16        0x91    /* O    5.1.24 */
#define SCSI_VERIFY10                   0x2F    /* O    5.1.25 */
#define SCSI_VERIFY12                   0xAF    /* O    5.1.26 */
#define SCSI_VERIFY16                   0x8F    /* O    5.1.27 */
#define SCSI_WRITE6                     0x0A    /* O    5.1.28 */
#define SCSI_WRITE10                    0x2A    /* O    5.1.29 */
#define SCSI_WRITE12                    0xAA    /* O    5.1.30 */
#define SCSI_WRITE16                    0x8A    /* O3   5.1.31 */
#define SCSI_WRITE_AND_VERIFY10         0x2E    /* O    5.1.32 */
#define SCSI_WRITE_AND_VERIFY12         0xAE    /* O    5.1.33 */
#define SCSI_WRITE_AND_VERIFY16         0x8E    /* O    5.1.34 */
#define SCSI_WRITE_BUFFER               0x3B    /* O    SPC-2 */
#define SCSI_WRITE_LONG                 0x3F    /* O    5.1.35 */
#define SCSI_WRITE_SAME10               0x41    /* O    5.1.36 */
#define SCSI_WRITE_SAME16               0x93    /* O    5.1.37 */
#define SCSI_XDREAD10                   0x52    /* O    5.1.38 */
#define SCSI_XDREAD32                   0x7F    /* O    5.1.39 */
#define SCSI_XDWRITE10                  0x50    /* O    5.1.40 */
#define SCSI_XDWRITE32                  0x7F    /* O    5.1.41 */
#define SCSI_XDWRITEREAD10              0x53    /* O    5.1.42 */
#define SCSI_XDWRITEREAD32              0x7F    /* O    5.1.43 */
#define SCSI_XDWRITE_EXTENDED16         0x80    /* O    5.1.44 */
#define SCSI_XDWRITE_EXTENDED32         0x7F    /* O    5.1.45 */
#define SCSI_XDWRITE_EXTENDED64         0x7F    /* O    5.1.46 */
#define SCSI_XPWRITE10                  0x51    /* O    5.1.46 */
#define SCSI_XPWRITE32                  0x7F    /* O    5.1.48 */


typedef struct _usbhost_msd_device_t usbhost_msd_device_t;

extern usbhost_msd_device_t *usbhost_msd_get_instance(usbhost_interface_t *intf);
extern void usbhost_msd_free_instance(usbhost_msd_device_t *inst);

extern int32_t usbhost_msd_test_unit_ready(usbhost_msd_device_t *dev);
extern int32_t usbhost_msd_request_sense(usbhost_msd_device_t *dev, uint8_t *response, size_t response_len);
extern int32_t usbhost_msd_mode_sense6(usbhost_msd_device_t *dev);
extern int32_t usbhost_msd_inquiry(usbhost_msd_device_t *dev);
extern int32_t usbhost_msd_report_luns(usbhost_msd_device_t *dev);
extern int32_t usbhost_msd_get_max_lun(usbhost_msd_device_t *dev);
extern int32_t usbhost_msd_read_capacity(usbhost_msd_device_t *dev, uint64_t *last_block, uint32_t *block_len);
extern int32_t usbhost_msd_read_capacity_long(usbhost_msd_device_t *dev, uint64_t *blocks, uint32_t *block_len);
extern int32_t usbhost_msd_read6(usbhost_msd_device_t *dev, uint32_t lba);
extern int32_t usbhost_msd_read10(usbhost_msd_device_t *dev, uint8_t *data, uint32_t lba, uint16_t blkcnt, uint32_t blksize);
extern int32_t usbhost_msd_read16(usbhost_msd_device_t *dev, uint64_t lba);
extern int32_t usbhost_msd_write10(usbhost_msd_device_t *dev, uint8_t *data, uint32_t lba, uint16_t blkcnt, uint32_t blksize);

#endif /* _USBHOST_MASS_STORAGE_H */

