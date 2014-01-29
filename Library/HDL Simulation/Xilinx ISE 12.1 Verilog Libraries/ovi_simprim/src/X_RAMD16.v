// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_RAMD16.v,v 1.8 2008/05/12 21:44:06 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1i (L.12)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Static Dual Port Synchronous RAM 16-Deep by 1-Wide
// /___/   /\     Filename : X_RAMD16.v
// \   \  /  \    Timestamp : Thu Mar 25 16:44:03 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Add LOC paramter;
//    01/18/08 - Add support for negative setup/hold timing check (CR457308).
// End Revision

`timescale 1 ps/1 ps

module X_RAMD16 (O, CLK, I, RADR0, RADR1, RADR2, RADR3, WADR0, WADR1, WADR2, WADR3, WE);

  parameter INIT = 16'h0000;

  parameter LOC = "UNPLACED";
  output O;
  input CLK, I, RADR0, RADR1, RADR2, RADR3, WADR0, WADR1, WADR2, WADR3, WE;

  reg [15:0] mem;
  wire [3:0] WADR_dly;
  wire [3:0] radr;
  wire CLK_dly, WE_dly, I_dly;
  reg notifier;


  initial 
    mem = INIT;

  assign radr[3:0] = {RADR3, RADR2, RADR1, RADR0};

  always @(posedge CLK_dly) 
    if (WE_dly == 1'b1)
      mem[WADR_dly] <= #100 I_dly;

   assign O = mem[radr];

  always @(notifier) 
    mem[WADR_dly] = 1'bx;

  specify

	(CLK => O) = (0:0:0, 0:0:0);
	(RADR0 => O) = (0:0:0, 0:0:0);
	(RADR1 => O) = (0:0:0, 0:0:0);
	(RADR2 => O) = (0:0:0, 0:0:0);
	(RADR3 => O) = (0:0:0, 0:0:0);

	$setuphold (posedge CLK, posedge I &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,I_dly);
	$setuphold (posedge CLK, negedge I &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,I_dly);
	$setuphold (posedge CLK, posedge WADR0 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[0]);
	$setuphold (posedge CLK, negedge WADR0 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[0]);
	$setuphold (posedge CLK, posedge WADR1 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[1]);
	$setuphold (posedge CLK, negedge WADR1 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[1]);
	$setuphold (posedge CLK, posedge WADR2 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[2]);
	$setuphold (posedge CLK, negedge WADR2 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[2]);
	$setuphold (posedge CLK, posedge WADR3 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[3]);
	$setuphold (posedge CLK, negedge WADR3 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[3]);
	$setuphold (posedge CLK, posedge WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE_dly);
	$setuphold (posedge CLK, negedge WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE_dly);

        $period (posedge CLK &&& WE, 0:0:0, notifier);

	specparam PATHPULSE$ = 0;

  endspecify

endmodule
