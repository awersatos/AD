// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_TRI.v,v 1.5 2005/03/14 21:05:15 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.13)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  3-State Buffer
// /___/   /\     Filename : X_TRI.v
// \   \  /  \    Timestamp : Thu Mar 25 16:44:04 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Add LOC paramter;
// End Revision

`timescale 1 ps/1 ps

module X_TRI (O, CTL, I);

  parameter LOC = "UNPLACED";
  output O;
  input CTL, I;

  bufif1 (O, I, CTL);

  specify

	(I => O) = (0:0:0, 0:0:0);
	(CTL => O) = (0:0:0, 0:0:0,
                      0:0:0, 0:0:0,
                      0:0:0, 0:0:0);

	specparam PATHPULSE$ = 0;

  endspecify

endmodule
