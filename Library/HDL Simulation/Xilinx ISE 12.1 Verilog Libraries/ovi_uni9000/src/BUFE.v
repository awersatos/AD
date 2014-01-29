// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/uni9000/BUFE.v,v 1.4 2007/05/23 20:04:50 patrickp Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 7.1i (H.19)
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Internal 3-State Buffer with Active High Enable
// /___/   /\     Filename : BUFE.v
// \   \  /  \    Timestamp : Thu Mar 25 16:41:35 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    05/23/07 - Changed timescale to 1 ps / 1 ps.

`timescale  1 ps / 1 ps

`celldefine

module BUFE (O, I, E);


    output O;

    input  I, E;

	bufif1 T1 (O, I, E);

    specify
	(I *> O) = (0, 0);
	(E *> O) = (0, 0);
    endspecify

endmodule

`endcelldefine
