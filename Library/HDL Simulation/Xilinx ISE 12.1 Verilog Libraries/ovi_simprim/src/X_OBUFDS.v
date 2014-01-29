// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_OBUFDS.v,v 1.6 2005/07/21 23:37:03 fphillip Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.13)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Differential Signaling Output Buffer
// /___/   /\     Filename : X_OBUFDS.v
// \   \  /  \    Timestamp : Tue Mar  1 14:57:54 PST 2005
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/01/05 - Added global GTS.
//    03/01/05 - Added LOC parameter.
//    05/23/05 - Declared tri0 GTS.
//    07/21/05 - CR 212974 -- matched unisim parameters as requested by other tools
// End Revision

`timescale 1 ps/1 ps

module X_OBUFDS (O, OB, I);

    parameter LOC = " UNPLACED";
    parameter CAPACITANCE = "DONT_CARE";
    parameter IOSTANDARD = "DEFAULT";

    output O, OB;

    input  I;
    tri0 GTS = glbl.GTS;

    bufif0 (O, I, GTS);
    notif0 (OB, I, GTS);

    specify
	(I => O) = (0:0:0, 0:0:0);
	(I => OB) = (0:0:0, 0:0:0);
	specparam PATHPULSE$ = 0;
    endspecify

endmodule
