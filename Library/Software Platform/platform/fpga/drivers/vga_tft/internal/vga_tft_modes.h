#ifndef _VGA_TFT_MODES_H
#define _VGA_TFT_MODES_H

//..............................................................................
// For TFT 240 x 320
#define HSYNC_TFT                   0x04000000          // Syncronization pulse length - 5   pixels
#define HPORCH_TFT                  0x00140000          // Back Porch length           - 21  pixels
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
