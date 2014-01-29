// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_OR9.v,v 1.5 2005/03/14 21:05:15 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.13)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  9-input OR Gate
// /___/   /\     Filename : X_OR9.v
// \   \  /  \    Timestamp : Thu Mar 25 16:43:58 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Add LOC paramter;
// End Revision

`timescale 1 ps/1 ps

module X_OR9 (O, I0, I1, I2, I3, I4, I5, I6, I7, I8);

  parameter LOC = "UNPLACED";
  output O;
  input I0, I1, I2, I3, I4, I5, I6, I7, I8;

  or (O, I0, I1, I2, I3, I4, I5, I6, I7, I8);

  specify

	(I0 => O) = (0:0:0, 0:0:0);
	(I1 => O) = (0:0:0, 0:0:0);
	(I2 => O) = (0:0:0, 0:0:0);
	(I3 => O) = (0:0:0, 0:0:0);
	(I4 => O) = (0:0:0, 0:0:0);
	(I5 => O) = (0:0:0, 0:0:0);
	(I6 => O) = (0:0:0, 0:0:0);
	(I7 => O) = (0:0:0, 0:0:0);
	(I8 => O) = (0:0:0, 0:0:0);

	specparam PATHPULSE$ = 0;

  endspecify

endmodule
