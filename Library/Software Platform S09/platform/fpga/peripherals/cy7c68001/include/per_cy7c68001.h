#ifndef _PER_CY7C68001_H
#define _PER_CY7C68001_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdbool.h>

// configuration registers
#define IFCONFIG                    0x01
#define FLAGSAB                     0x02
#define FLAGSCD                     0x03
#define POLAR                       0x04
#define REVID                       0x05
#define EP2CFG                      0x06
#define EP4CFG                      0x07
#define EP6CFG                      0x08
#define EP8CFG                      0x09
#define EP2PKTLENH                  0x0A
#define EP2PKTLENL                  0x0B
#define EP4PKTLENH                  0x0C
#define EP4PKTLENL                  0x0D
#define EP6PKTLENH                  0x0E
#define EP6PKTLENL                  0x0F
#define EP8PKTLENH                  0x10
#define EP8PKTLENL                  0x11
#define EP2PFH                      0x12
#define EP2PFL                      0x13
#define EP4PFH                      0x14
#define EP4PFL                      0x15
#define EP6PFH                      0x16
#define EP6PFL                      0x17
#define EP8PFH                      0x18
#define EP8PFL                      0x19
#define EP2ISOINPKTS                0x1A
#define EP4ISOINPKTS                0x1B
#define EP6ISOINPKTS                0x1C
#define EP8ISOINPKTS                0x1D
#define EP24FLAGS                   0x1E
#define EP68FLAGS                   0x1F
#define INPKTEND_FLUSH              0x20
#define USBFRAMEH                   0x2A
#define USBFRAMEL                   0x2B
#define MICROFRAME                  0x2C
#define FNADDR                      0x2D
#define INTENABLE                   0x2E
#define DESC                        0x30
#define EP0BUF                      0x31
#define SETUP                       0x32
#define EP0BC                       0x33
#define UNINDEXED_REG_LO            0x3A
#define UNINDEXED_REG_HI            0x3B
#define UNINDEXED_REG_DATA          0x3C
#define FIFOPINPOLAR                0xE609
#define TOGCTL                      0xE683

// address meanings
#define ADDRESS_FIFO2               0x00
#define ADDRESS_FIFO4               0x01
#define ADDRESS_FIFO6               0x02
#define ADDRESS_FIFO8               0x03
#define ADDRESS_COMMAND             0x04
#define ADDRESS_STATUS              0x08
#define ADDRESS_RESET               0x0F
#define ADDRESS_FLUSH               0x18
#define ADDRESS_CYCLES_RESET        0x10
#define ADDRESS_CYCLES_STROBELOW    0x11
#define ADDRESS_CYCLES_STROBEHIGH   0x12
#define ADDRESS_CYCLES_WRHIGH       0x13
#define ADDRESS_CYCLES_ADDRESSSETUP 0x14
#define ADDRESS_CYCLES_READSTATUS   0x15

#define STATUS_MASK_FLAGA           0x01
#define STATUS_MASK_FLAGB           0x02
#define STATUS_MASK_FLAGC           0x04
#define STATUS_MASK_READY           0x08

// read/write protocol helpers
#define COMMAND_READ_ADDRESS_BYTE(x)  (0xC0 | ((x) & 0x3F))
#define COMMAND_WRITE_ADDRESS_BYTE(x) (0x80 | ((x) & 0x3F))
#define COMMAND_WRITE_DATA_BYTE1(x)   (0x00 | (((x) >> 4) & 0x0F))
#define COMMAND_WRITE_DATA_BYTE2(x)   (0x00 | ((x) & 0x0F))

//..............................................................................
// EPxCFG Register 0x6-0x9
//..............................................................................
// VALID 1--- ---- Valid = 1
// DIR   -0-- ---- Out = 0 (default for EP2/4), In = 1 (default for EP6/8)
// TYPE  --10 ---- Invalid = 00, Isochronous = 01, Bulk = 10 (default), Interrupt = 11
// SIZE  ---- 0--- 512 Bytes = 0, 1024 Bytes = 1
// STALL ---- -0-- Stall = 1
// BUF   ---- --10 Quad = 00, Invalid = 01, Double = 10 (fixed internally for EP4/8), Triple = 11
//..............................................................................
// 0x    A    2
//..............................................................................
#define EPXCFG_IN                   0xE2
#define EPXCFG_IN_STALL             0xE6
#define EPXCFG_OUT                  0xA2
#define EPXCFG_OUT_STALL            0xA6

typedef struct cy7c68001_s cy7c68001_t;

extern cy7c68001_t      *cy7c68001_open(int id);
extern void             usb_init(cy7c68001_t *context, int length, unsigned char *descriptor);
extern void             usb_reset(cy7c68001_t *context);
extern void             usb_write_descriptor(cy7c68001_t *context, int length, unsigned char *data);
extern unsigned short   usb_read_register(cy7c68001_t *context, unsigned int register_num);
extern void             usb_write_register(cy7c68001_t *context, unsigned int register_num, unsigned short value);
extern bool             usb_set_got_setup(cy7c68001_t *context, bool val);
extern bool             usb_get_got_setup(cy7c68001_t *context);
extern bool             usb_set_ep0buf_ready(cy7c68001_t *per, bool val);
extern bool             usb_get_ep0buf_ready(cy7c68001_t *per);
extern bool             usb_set_got_out_data(cy7c68001_t *per, bool val);
extern bool             usb_get_got_out_data(cy7c68001_t *per);
extern unsigned short   usb_read_data(cy7c68001_t *context, unsigned int address);
extern void             usb_write_data(cy7c68001_t *context, unsigned int address, unsigned short value);
extern unsigned short   usb_read_low_level(cy7c68001_t *context, unsigned int address);
extern void             usb_flush(cy7c68001_t *context, unsigned int address);

/* USB register handling */
extern  void			usb_set_register_bit(cy7c68001_t *context, int register_num, unsigned short bitnum);
extern  void            usb_set_register_bitmask(cy7c68001_t *context, int register_num, unsigned short mask, unsigned short bits);
extern  void            usb_clear_register_bit(cy7c68001_t *context, int register_num, unsigned short bitnum);
extern  void            usb_clear_register_bitmask(cy7c68001_t *context, int register_num, unsigned short mask, unsigned short bits);

#ifdef  __cplusplus
}
#endif

#endif /* _PER_CY7C68001_H */

