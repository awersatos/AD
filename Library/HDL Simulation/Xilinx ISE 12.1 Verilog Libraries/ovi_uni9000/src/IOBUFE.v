// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/uni9000/IOBUFE.v,v 1.4 2007/05/23 20:04:59 patrickp Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 7.1i (H.19)
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Bi-Directional Buffer
// /___/   /\     Filename : IOBUFE.v
// \   \  /  \    Timestamp : Thu Mar 25 16:41:59 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    05/23/07 - Changed timescale to 1 ps / 1 ps.

`timescale  1 ps / 1 ps

`celldefine

module IOBUFE (O, IO, I, E);

    output O;

    inout  IO;

    input  I, E;

    bufif1 E1 (IO, I, E);
    buf B1 (O, IO);

    specify
	(IO *> O) = (1,1);
	(I *> IO) = (1,1);
	(E *> IO) = (1,1);
    endspecify

endmodule

`endcelldefine
