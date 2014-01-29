#ifndef _VGA32_MODES_H
#define _VGA32_MODES_H


#define RES_1024x768        0x1
#define RES_800x600         0x2
#define RES_640x480         0x3
#define RES_640x480DIV      0x4
#define RES_640x480DIV_SUB  0x5
#define RES_PAL             0x6
#define RES_PAL_HALF        0x7
#define RES_NTSC            0x8
#define RES_NTSC_HALF       0x9
#define RES_TFT             0xA
#define RES_CUSTOM          0xB

#define LookUpTableBank0    0x0
#define LookUpTableBank1    0x1

#define VideoPage0          0x0
#define VideoPage1          0x1

/*************************************************************/
// VGA Control Register bits
// CTRL.0    - Video System Enable
//             1 - enabled
//             0 - disabled
// CTRL.3..1 - Unused
// CTRL.4    - Color LookUp Table Bank
//             1 - Active Color LookUp Table Bank 1
//             0 - Active Color LookUp Table Bank 0
// CTRL.6..5 - 00 - 8  bit per pixel mode
//             01 - 4  bit per pixel mode
//             10 - 2  bit per pixel mode
//             11 - 1  bit per pixel mode
// CTRL.7    - Pseudo Color Mode
//             0 - Black And White mode
//             1 - Color LookUp mode
// CTRL.8    - Horizontal Syncronization Output Polarity
//             0 - Sync pulse active high
//             1 - Sync pulse active low (most monitors)
// CTRL.9    - Vertical Syncronization Output Polarity
//             0 - Sync pulse active high
//             1 - Sync pulse active low (most monitors)
// CTRL.10   - Compsite Synchronization Output Polarity
//             0 - Sync pulse active high
//             1 - Sync pulse active low
// CTRL.11   - Blanking Syncronization Output Polarity
//             0 - Sync pulse active high
//             1 - Sync pulse active low
// CTRL.12   - CDIV enable
//             0 - 50MHz 800x600 or 25MHz 640x480
//             1 - 25MHz 800x600
// CTRL.31..13 - Unused
//..............................................................................


//..............................................................................
// VGA STAT Register bits
// STAT.3..0- Unused
// STAT.4   - Current Color LookUp Table bank
//            0 - Bank 0
//            0 - Bank 1
//..............................................................................


//..............................................................................
// VGA Configuration Registers
//..............................................................................
// HTIM - Horizontal Timing Register
// HTIM.31..24  - Horizontal Syncronization pulse LENGTH_ (in pixels - 1)
// HTIM.32..16  - Back Porch LENGTH_ (in pixels - 1)
// HTIM.15..0   - Visible area (in pixels - 1)
//..............................................................................
// VTIM - Vertical Timing Register
// VTIM.31..24  - Vertical Syncronization pulse length (in lines - 1)
// VTIM.23..16  - Back porch length (in lines - 1)
// VTIM.15..0   - Visible area (in lines - 1)
//..............................................................................
// HVLEN - Horizontal and Vertical total length definition register
// HVLEN.31..24 - Total number of pixels per line
// HVLEN.23..0  - Total number of lines per frame
//..............................................................................


//..............................................................................
// For 1024*768 @72 Hz
#define HSYNC_1024                  0x87000000          // Syncronization pulse length - 136  pixels
#define HPORCH_1024                 0x008F0000          // Back Porch length           - 144  pixels
#define HVISIBLE_1024               0x000003FF          // Visible area                - 1024 pixels
#define HTIM_1024                   (HSYNC_1024 | HPORCH_1024 | HVISIBLE_1024)

#define VSYNC_1024                  0x05000000          // Syncronization pulse length - 6   lines
#define VPORCH_1024                 0x001C0000          // Back porch length           - 29  lines
#define VVISIBLE_1024               0x000002FF          // Visible lines               - 768 lines
#define VTIM_1024                   (VSYNC_1024 | VPORCH_1024 | VVISIBLE_1024)

#define HLENGTH_1024                0x052F0000          // Total number of pixels per line - 1328
#define VLENGTH_1024                0x00000325          // Total number of lines per frame - 806
#define HVLEN_1024                  (HLENGTH_1024 | VLENGTH_1024)

//..............................................................................
// For 800*600 @72 Hz
#define HSYNC_800x600               0x78000000          // Syncronization pulse length - 120 pixels
#define HPORCH_800x600              0x00420000          // Back Porch length           - 67  pixels
#define HVISIBLE_800x600            0x0000031F          // Visible area                - 800 pixels
#define HTIM_800x600                (HSYNC_800x600 | HPORCH_800x600 | HVISIBLE_800x600)

#define VSYNC_800x600               0x05000000          // Syncronization pulse length - 6   lines
#define VPORCH_800x600              0x00180000          // Back porch length           - 25  lines
#define VVISIBLE_800x600            0x00000257          // Visible lines               - 600 lines
#define VTIM_800x600                (VSYNC_800x600 | VPORCH_800x600 | VVISIBLE_800x600)

#define HLENGTH_800x600             0x040F0000          // Total number of pixels per line - 1040
#define VLENGTH_800x600             0x0000029A          // Total number of lines per frame - 666
#define HVLEN_800x600               (HLENGTH_800x600 | VLENGTH_800x600)

//..............................................................................
// For 640*480 @72 Hz
#define HSYNC_640x480               0x27000000          // Syncronization pulse length - 40  pixels
#define HPORCH_640x480              0x00820000          // Back Porch length           - 125 pixels
#define HVISIBLE_640x480            0x0000027F          // Visible area                - 640 pixels
#define HTIM_640x480                (HSYNC_640x480 | HPORCH_640x480 | HVISIBLE_640x480)

#define VSYNC_640x480               0x02000000          // Syncronization pulse length - 3   lines
#define VPORCH_640x480              0x001D0000          // Back porch length           - 21  lines
#define VVISIBLE_640x480            0x000001DF          // Visible lines               - 480 lines
#define VTIM_640x480                (VSYNC_640x480 | VPORCH_640x480 | VVISIBLE_640x480)

#define HLENGTH_640x480             0x033F0000          // Total number of pixels per line - 832
#define VLENGTH_640x480             0x00000207          // Total number of lines per frame - 520
#define HVLEN_640x480               (HLENGTH_640x480 | VLENGTH_640x480)

//..............................................................................
// For 640*480 @72 Hz
#define HSYNC_640x480DIV            0x5F000000          // Syncronization pulse length - 40  pixels
#define HPORCH_640x480DIV           0x00320000          // Back Porch length           - 125 pixels
#define HVISIBLE_640x480DIV         0x0000027F          // Visible area                - 640 pixels
#define HTIM_640x480DIV             (HSYNC_640x480DIV | HPORCH_640x480DIV | HVISIBLE_640x480DIV)

#define VSYNC_640x480DIV            0x02000000          // Syncronization pulse length - 3   lines
#define VPORCH_640x480DIV           0x00210000          // Back porch length           - 21  lines
#define VVISIBLE_640x480DIV         0x000001DF          // Visible lines               - 480 lines
#define VTIM_640x480DIV             (VSYNC_640x480DIV | VPORCH_640x480DIV | VVISIBLE_640x480DIV)

#define HLENGTH_640x480DIV          0x031F0000          // Total number of pixels per line - 832
#define VLENGTH_640x480DIV          0x0000020C          // Total number of lines per frame - 520
#define HVLEN_640x480DIV            (HLENGTH_640x480DIV | VLENGTH_640x480DIV)

//..............................................................................
// 640*480 @72 Hz with only 240x240 visible
#define HSYNC_640x480DIV_SUB        0x5F000000          // Syncronization pulse length - 40  pixels
#define HPORCH_640x480DIV_SUB       (0x00320000 + 0x00C80000)   // Back Porch length           - 125 pixels plus rightshifted (640-240)/2=200
#define HVISIBLE_640x480DIV_SUB     0x000000EF          // Visible area                - 240 pixels
#define HTIM_640x480DIV_SUB         (HSYNC_640x480DIV_SUB | HPORCH_640x480DIV_SUB | HVISIBLE_640x480DIV_SUB)

#define VSYNC_640x480DIV_SUB        0x02000000          // Syncronization pulse length - 3   lines
#define VPORCH_640x480DIV_SUB       (0x00210000 + 0x00640000)   // Back porch length           - 21  lines  plus rightshifted (480-240)/2=100
#define VVISIBLE_640x480DIV_SUB     0x000000EF          // Visible lines               - 240 lines
#define VTIM_640x480DIV_SUB         (VSYNC_640x480DIV_SUB | VPORCH_640x480DIV_SUB | VVISIBLE_640x480DIV_SUB)

#define HLENGTH_640x480DIV_SUB      0x031F0000          // Total number of pixels per line - 832
#define VLENGTH_640x480DIV_SUB      0x0000020C          // Total number of lines per frame - 520
#define HVLEN_640x480DIV_SUB        (HLENGTH_640x480DIV_SUB | VLENGTH_640x480DIV_SUB)

//..............................................................................
// For PAL
#define HSYNC_PAL                   0x78000000          // Syncronization pulse length - 120 pixels
#define HPORCH_PAL                  0x00120000          // Back Porch length           - 18  pixels
#define HVISIBLE_PAL                0x000002CF          // Visible area                - 720 pixels
#define HTIM_PAL                    (HSYNC_PAL | HPORCH_PAL | HVISIBLE_PAL)

#define VSYNC_PAL                   0x05000000          // Syncronization pulse length - 6   lines
#define VPORCH_PAL                  0x00180000          // Back porch length           - 15  lines
#define VVISIBLE_PAL                0x00000237          // Visible lines               - 291 lines
#define VTIM_PAL                    (VSYNC_PAL | VPORCH_PAL | VVISIBLE_PAL)

#define HLENGTH_PAL                 0x035F0000          // Total number of pixels per line - 864
#define VLENGTH_PAL                 0x00000270          // Total number of lines per frame - 625
#define HVLEN_PAL                   (HLENGTH_PAL | VLENGTH_PAL)

//..............................................................................
// For NTSC
#define HSYNC_NTSC                  0x78000000          // Syncronization pulse length - 120 pixels
#define HPORCH_NTSC                 0x00120000          // Back Porch length           - 18  pixels
#define HVISIBLE_NTSC               0x000002CF          // Visible area                - 720 pixels
#define HTIM_NTSC                   (HSYNC_NTSC | HPORCH_NTSC | HVISIBLE_NTSC)

#define VSYNC_NTSC                  0x05000000          // Syncronization pulse length - 6   lines
#define VPORCH_NTSC                 0x00180000          // Back porch length           - 15  lines
#define VVISIBLE_NTSC               0x00000237          // Visible lines               - 291 lines
#define VTIM_NTSC                   (VSYNC_NTSC | VPORCH_NTSC | VVISIBLE_NTSC)

#define HLENGTH_NTSC                0x035F0000          // Total number of pixels per line - 864
#define VLENGTH_NTSC                0x00000270          // Total number of lines per frame - 625
#define HVLEN_NTSC                  (HLENGTH_NTSC | VLENGTH_NTSC)

//..............................................................................
// For TFT
#define HSYNC_TFT                   0x04000000          // Syncronization pulse length - 5   pixels
#define HPORCH_TFT                  0x00140000          // Back Porch length           - 20  pixels
#define HVISIBLE_TFT                0x000000EF          // Visible area                - 240 pixels
#define HTIM_TFT                    (HSYNC_TFT | HPORCH_TFT | HVISIBLE_TFT)

#define VSYNC_TFT                   0x01000000          // Syncronization pulse length - 2   lines
#define VPORCH_TFT                  0x00010000          // Back porch length           - 2   lines
#define VVISIBLE_TFT                0x0000013F          // Visible lines               - 320 lines
#define VTIM_TFT                    (VSYNC_TFT | VPORCH_TFT | VVISIBLE_TFT)

#define HLENGTH_TFT                 0x01100000          // Total number of pixels per line - 273
#define VLENGTH_TFT                 0x00000146          // Total number of lines per frame - 327
#define HVLEN_TFT                   (HLENGTH_TFT | VLENGTH_TFT)


#endif
