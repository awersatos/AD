// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/blanc/X_AND2B1L.v,v 1.4 2009/08/22 00:02:06 harikr Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.i (L.40)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Latch used as 2-input AND Gate
// /___/   /\     Filename : X_AND2B1L.v
// \   \  /  \    Timestamp : Tue Feb 26 11:11:42 PST 2008
//  \___\/\___\
//
// Revision:
//    04/01/08 - Initial version.
//    04/14/09 - Invert SRI not DI (CR517897)
// End Revision

`timescale  1 ps / 1 ps

module X_AND2B1L (O, SRI, DI);

    parameter LOC = "UNPLACED";
    output O;

    input  SRI, DI;

    tri0 GSR = glbl.GSR;
    wire o_out, sri_b;


    assign O = (GSR) ? 0 : o_out;

    not A0 (sri_b, SRI);
    and A1 (o_out, sri_b, DI);

  specify
                                                                                 
        (DI => O) = (0:0:0, 0:0:0);
        (SRI => O) = (0:0:0, 0:0:0);
        specparam PATHPULSE$ = 0;
  endspecify
endmodule
