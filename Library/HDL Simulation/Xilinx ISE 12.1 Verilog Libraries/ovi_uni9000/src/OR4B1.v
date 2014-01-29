// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/uni9000/OR4B1.v,v 1.4 2007/05/23 20:05:12 patrickp Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 7.1i (H.19)
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  4-input OR Gate
// /___/   /\     Filename : OR4B1.v
// \   \  /  \    Timestamp : Thu Mar 25 16:42:08 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    05/23/07 - Added wire declaration for internal signals.
//    05/23/07 - Changed timescale to 1 ps / 1 ps.

`timescale  1 ps / 1 ps

`celldefine

module OR4B1 (O, I0, I1, I2, I3);


    output O;

    input  I0, I1, I2, I3;

    wire i0_inv;

    not N0 (i0_inv, I0);
    or O1 (O, i0_inv, I1, I2, I3);

    specify
	(I0 *> O) = (0, 0);
	(I1 *> O) = (0, 0);
	(I2 *> O) = (0, 0);
	(I3 *> O) = (0, 0);
    endspecify

endmodule

`endcelldefine
