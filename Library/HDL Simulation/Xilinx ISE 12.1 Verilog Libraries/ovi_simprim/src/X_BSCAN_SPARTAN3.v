///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2005 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.14)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Boundary Scan Logic Control Circuit for SPARTAN3
// /___/   /\     Filename : X_BSCAN_SPARTAN3.v
// \   \  /  \    Timestamp : Sat Mar 26 16:03:05 PST 2005
//  \___\/\___\
//
// Revision:
//    03/26/05 - Initial version.
//    04/22/05 - Added LOC parameter.
//    06/06/07 - Fixed timescale values
//    04/07/08 - CR 469973 -- Header Description fix
// End Revision

`timescale  1 ps / 1 ps


module X_BSCAN_SPARTAN3 (CAPTURE, DRCK1, DRCK2, RESET, SEL1, SEL2, SHIFT, TDI, UPDATE, TDO1, TDO2);

    input TDO1, TDO2;

    output CAPTURE, DRCK1, DRCK2, RESET, SEL1, SEL2, SHIFT, TDI, UPDATE;

    parameter LOC = "UNPLACED";

    pulldown (DRCK1);
    pulldown (DRCK2);
    pulldown (RESET);
    pulldown (SEL1);
    pulldown (SEL2);
    pulldown (SHIFT);
    pulldown (TDI);
    pulldown (UPDATE);


endmodule

