// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_SUH.v,v 1.5 2005/03/14 21:05:15 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.13)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Setup Hold Timing Check
// /___/   /\     Filename : X_SUH.v
// \   \  /  \    Timestamp : Thu Mar 25 16:44:04 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Add LOC paramter;
// End Revision

`timescale 1 ps/1 ps
 
module X_SUH (I, CE, CLK);

  input I, CLK, CE;
  parameter LOC = "UNPLACED";

  specify

      $setuphold (posedge CLK, posedge CE, 0:0:0, 0:0:0);
      $setuphold (posedge CLK, negedge CE, 0:0:0, 0:0:0);
      $setuphold (negedge CLK, posedge CE, 0:0:0, 0:0:0);
      $setuphold (negedge CLK, negedge CE, 0:0:0, 0:0:0);

      $setuphold (posedge CLK, posedge I &&& CE, 0:0:0, 0:0:0);
      $setuphold (posedge CLK, negedge I &&& CE, 0:0:0, 0:0:0);
      $setuphold (negedge CLK, posedge I &&& CE, 0:0:0, 0:0:0);
      $setuphold (negedge CLK, negedge I &&& CE, 0:0:0, 0:0:0);

  endspecify

endmodule
