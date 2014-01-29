// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_MUX2.v,v 1.5 2005/03/14 21:05:15 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.13)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  2-to-1 Multiplexer
// /___/   /\     Filename : X_MUX2.v
// \   \  /  \    Timestamp : Thu Mar 25 16:43:56 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Add LOC paramter;
// End Revision

`timescale 1 ps/1 ps

module X_MUX2 (O, IA, IB, SEL);

  output O;
  input IA, IB, SEL;

  parameter LOC = "UNPLACED";

  mux (O, IA, IB, SEL);

  specify

	(IA => O) = (0:0:0, 0:0:0);
	(IB => O) = (0:0:0, 0:0:0);
	(SEL => O) = (0:0:0, 0:0:0);
	specparam PATHPULSE$ = 0;

  endspecify

endmodule


primitive mux (out, ina, inb, sel);

  output out;
  input  ina, inb, sel;

  table

   //    ina   inb   sel   out;

          0     ?     0  :  0;
          1     ?     0  :  1;
          ?     0     1  :  0;
          ?     1     1  :  1;
          0     0     x  :  0;
          1     1     x  :  1;

  endtable

endprimitive
