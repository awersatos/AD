// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/blanc/X_OR2L.v,v 1.2 2009/02/19 20:45:45 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1 (L.33)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Latch used as 2-input OR Gate
// /___/   /\     Filename : X_OR2L.v
// \   \  /  \    Timestamp : Tue Feb 26 11:11:42 PST 2008
//  \___\/\___\
//
// Revision:
//    02/26/08 - Initial version.
//    04/01/08 - Add GSR.
//    02/19/09 - Order port name (CR509139)
// End Revision

`timescale  1 ps / 1 ps

module X_OR2L (O, DI, SRI);

    parameter LOC = "UNPLACED";
    output O;

    input  SRI, DI;
    
    tri0 GSR = glbl.GSR;

    wire o_out;

    assign O = (GSR) ? 0 : o_out;
    or O1 (o_out, SRI, DI);

  specify
                                                                                 
        (DI => O) = (0:0:0, 0:0:0);
        (SRI => O) = (0:0:0, 0:0:0);
        specparam PATHPULSE$ = 0;
                                                                                 
  endspecify
endmodule
