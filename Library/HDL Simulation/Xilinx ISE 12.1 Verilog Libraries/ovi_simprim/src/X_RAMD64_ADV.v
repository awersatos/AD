// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/rainier/X_RAMD64_ADV.v,v 1.2 2008/05/12 21:09:15 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1i (L.12)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Static Dual Port Synchronous RAM 64-Deep by 1-Wide
// /___/   /\     Filename : X_RAMD64_ADV.v
// \   \  /  \    Timestamp : Thu Mar 25 16:44:03 PST 2004
//  \___\/\___\
//
// Revision:
//    04/11/06 - Initial version.
//    05/07/08 - Add negative setup/hold support (CR468872)
// End Revision

`timescale 1 ps/1 ps

module X_RAMD64_ADV (O, CLK, I, RADR0, RADR1, RADR2, RADR3, RADR4, RADR5, WADR0, WADR1, WADR2, WADR3, WADR4, WADR5, WE, WE1, WE2);

  parameter INIT = 64'h0000000000000000;

  parameter LOC = "UNPLACED";
  output O;
  input CLK, I, RADR0, RADR1, RADR2, RADR3, RADR4, RADR5, WADR0, WADR1, WADR2, WADR3, WADR4, WADR5, WE, WE1, WE2;

  reg [63:0] mem;
  wire [5:0] WADR_dly;
  wire [5:0] radr;
  reg notifier;
  wire CLK_dly, I_dly; 
  wire we_all, WE_dly, WE1_dly, WE2_dly;

  initial 
    mem = INIT;

  assign we_all =  WE_dly & WE1_dly & WE2_dly;
  assign radr[5:0] = {RADR5, RADR4, RADR3, RADR2, RADR1, RADR0};

  always @(posedge CLK_dly) 
    if (we_all == 1'b1)
      mem[WADR_dly] <= #100 I_dly;

   assign O = mem[radr];

  always @(notifier) 
    mem[WADR_dly] <= 1'bx;

  specify

	(CLK => O) = (0:0:0, 0:0:0);
	(RADR0 => O) = (0:0:0, 0:0:0);
	(RADR1 => O) = (0:0:0, 0:0:0);
	(RADR2 => O) = (0:0:0, 0:0:0);
	(RADR3 => O) = (0:0:0, 0:0:0);
	(RADR4 => O) = (0:0:0, 0:0:0);
	(RADR5 => O) = (0:0:0, 0:0:0);

	$setuphold (posedge CLK, posedge I &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,I_dly);
	$setuphold (posedge CLK, negedge I &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,I_dly);
	$setuphold (posedge CLK, posedge WADR0 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[0]);
	$setuphold (posedge CLK, negedge WADR0 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[0]);
	$setuphold (posedge CLK, posedge WADR1 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[1]);
	$setuphold (posedge CLK, negedge WADR1 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[1]);
	$setuphold (posedge CLK, posedge WADR2 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[2]);
	$setuphold (posedge CLK, negedge WADR2 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[2]);
	$setuphold (posedge CLK, posedge WADR3 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[3]);
	$setuphold (posedge CLK, negedge WADR3 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[3]);
	$setuphold (posedge CLK, posedge WADR4 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[4]);
	$setuphold (posedge CLK, negedge WADR4 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[4]);
	$setuphold (posedge CLK, posedge WADR5 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[5]);
	$setuphold (posedge CLK, negedge WADR5 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,WADR_dly[5]);
	$setuphold (posedge CLK, posedge WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE_dly);
	$setuphold (posedge CLK, negedge WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE_dly);
	$setuphold (posedge CLK, posedge WE1, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE1_dly);
	$setuphold (posedge CLK, negedge WE1, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE1_dly);
	$setuphold (posedge CLK, posedge WE2, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE2_dly);
	$setuphold (posedge CLK, negedge WE2, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE2_dly);

        $period (posedge CLK &&& we_all, 0:0:0, notifier);

	specparam PATHPULSE$ = 0;

  endspecify

endmodule
