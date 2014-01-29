// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_OBUFT.v,v 1.4 2007/06/05 00:00:54 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 10.1i (K.17)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  3-State Output Buffer
// /___/   /\     Filename : X_OBUFT.v
// \   \  /  \    Timestamp : Tue Mar  1 14:57:54 PST 2005
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/01/05 - Added global GTS.
//    03/01/05 - Added LOC parameter.
//    05/23/05 - Declared tri0 GTS.
//    07/21/05 - CR 212974 -- matched unisim parameters as requested by other tools
//    06/04/07 - Add wire declaration to internal signal.
// End Revision

`timescale 1 ps/1 ps

module X_OBUFT (O, CTL, I);

    parameter LOC = " UNPLACED";
    parameter CAPACITANCE = "DONT_CARE";
    parameter DRIVE = 12;
    parameter IOSTANDARD = "DEFAULT";
    parameter SLEW = "SLOW";

    output O;
    input CTL, I;
    tri0 GTS = glbl.GTS;
    wire CTL_IN;

    or (CTL_IN, GTS, CTL);
    bufif0 (O, I, CTL_IN);

    specify
	(I => O) = (0:0:0, 0:0:0);
	(CTL => O) = (0:0:0, 0:0:0,
                      0:0:0, 0:0:0,
                      0:0:0, 0:0:0);
	specparam PATHPULSE$ = 0;
    endspecify

endmodule
