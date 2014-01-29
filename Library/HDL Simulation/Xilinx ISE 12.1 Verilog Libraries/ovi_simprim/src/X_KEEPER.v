// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_KEEPER.v,v 1.5 2005/03/14 21:05:15 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.13)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Weak Keeper
// /___/   /\     Filename : X_KEEPER.v
// \   \  /  \    Timestamp : Thu Mar 25 16:43:55 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Add LOC paramter;
// End Revision

`timescale 1 ps/1 ps
 
module X_KEEPER (O);

  inout O;
  parameter LOC = "UNPLACED";
  wire  O_int;
  reg   I;

    always @(O_int)
        if (O_int)
            I <= 1;
        else
            I <= 0;

    buf (pull1, pull0) (O, I);
    buf (O_int, O);

  specify

      (O => O) = (0:0:0, 0:0:0);

  endspecify

endmodule
