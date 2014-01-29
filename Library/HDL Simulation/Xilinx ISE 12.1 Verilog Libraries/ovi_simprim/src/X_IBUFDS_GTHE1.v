///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2007 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.3i
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                   Differential Signaling Input Buffer for GTs
// /___/   /\     Filename : X_IBUFDS_GTHE1.v
// \   \  /  \    Timestamp : Tue Jun  2 10:50:23 PDT 2009
//  \___\/\___\
//
// Revision:
//    06/02/09 - Initial version.
// End Revision

`timescale  1 ps / 1 ps

module X_IBUFDS_GTHE1 (O, I, IB);


    parameter LOC = "UNPLACED";

    output O; 

    input I; 
    input IB; 

// Output signals 
    reg  o_out;

    reg notifier;

    tri0  GSR = glbl.GSR;


    always @(I or IB)
        if (I == 1'b1 && IB == 1'b0)
            o_out = I;
        else if (I == 1'b0 && IB == 1'b1)
            o_out = I;
        else if (I == 1'bx || I == 1'bz || IB == 1'bx || IB == 1'bz)
            o_out = 1'bx;


    assign O  = o_out;

    specify

        (I => O) = (0:0:0, 0:0:0);
        (IB => O) = (0:0:0, 0:0:0);

       specparam PATHPULSE$ = 0;

    endspecify


endmodule // X_IBUFDS_GTHE1
