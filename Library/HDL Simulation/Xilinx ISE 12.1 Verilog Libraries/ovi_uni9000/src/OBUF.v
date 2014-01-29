// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/uni9000/OBUF.v,v 1.5 2008/05/02 00:31:59 vandanad Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 7.1i (H.19)
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Output Buffer
// /___/   /\     Filename : OBUF.v
// \   \  /  \    Timestamp : Thu Mar 25 16:42:07 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    05/23/07 - Changed timescale to 1 ps / 1 ps.
//    05/01/08 - Added slew parameter for CR 455679.

`timescale  1 ps / 1 ps

`celldefine

module OBUF (O, I);

  parameter SLEW = "SLOW";

    output O;
    reg    O;

    input  I;

    always @(I)
	if (I === 1'bz)
	   #100 O = 1'bz;
	else
	   #100 O = I;

    specify
    endspecify

endmodule

`endcelldefine
