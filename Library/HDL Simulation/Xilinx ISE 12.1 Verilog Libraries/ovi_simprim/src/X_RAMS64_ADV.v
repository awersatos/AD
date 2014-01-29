// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/rainier/X_RAMS64_ADV.v,v 1.4 2008/05/12 21:09:15 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1i (L.12)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Static Synchronous RAM 64-Deep by 1-Wide
// /___/   /\     Filename : X_RAMS64_ADV.v
// \   \  /  \    Timestamp : Thu Mar 25 16:44:04 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Add LOC paramter;
//    04/04/06 - add WE1 WE2. (CR 228516)
//    04/21/06 - Change X_RAMS64 to X_RAMS64_ADV (CR 230059).
//    05/07/08 - Add negative setup/hold support (CR468872)
// End Revision

`timescale 1 ps/1 ps

module X_RAMS64_ADV (O, ADR0, ADR1, ADR2, ADR3, ADR4, ADR5, CLK, I, WE, WE1, WE2);

  parameter INIT = 64'h0000000000000000;

  parameter LOC = "UNPLACED";
  output O;
  input ADR0, ADR1, ADR2, ADR3, ADR4, ADR5, CLK, I, WE, WE1, WE2;

  reg [63:0] mem;
  wire [5:0] ADR_dly;
  wire I_dly, CLK_dly, WE_dly, WE1_dly, WE2_dly;
  reg notifier;

  wire we_all;


  initial 
    mem = INIT;

  assign we_all = WE_dly & WE1_dly & WE2_dly;

  always @(posedge CLK_dly) 
    if (we_all == 1'b1)
      mem[ADR_dly] <= #100 I_dly;

   assign O = mem[ADR_dly];

  always @(notifier) 
    mem[ADR_dly] <= 1'bx;

  specify

	(CLK => O) = (0:0:0, 0:0:0);
	(ADR0 => O) = (0:0:0, 0:0:0);
	(ADR1 => O) = (0:0:0, 0:0:0);
	(ADR2 => O) = (0:0:0, 0:0:0);
	(ADR3 => O) = (0:0:0, 0:0:0);
	(ADR4 => O) = (0:0:0, 0:0:0);
	(ADR5 => O) = (0:0:0, 0:0:0);

	$setuphold (posedge CLK, posedge I &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,I_dly);
	$setuphold (posedge CLK, negedge I &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,I_dly);
	$setuphold (posedge CLK, posedge ADR0 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[0]);
	$setuphold (posedge CLK, negedge ADR0 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[0]);
	$setuphold (posedge CLK, posedge ADR1 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[1]);
	$setuphold (posedge CLK, negedge ADR1 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[1]);
	$setuphold (posedge CLK, posedge ADR2 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[2]);
	$setuphold (posedge CLK, negedge ADR2 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[2]);
	$setuphold (posedge CLK, posedge ADR3 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[3]);
	$setuphold (posedge CLK, negedge ADR3 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[3]);
	$setuphold (posedge CLK, posedge ADR4 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[4]);
	$setuphold (posedge CLK, negedge ADR4 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[4]);
	$setuphold (posedge CLK, posedge ADR5 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[5]);
	$setuphold (posedge CLK, negedge ADR5 &&& we_all, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[5]);
	$setuphold (posedge CLK, posedge WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE_dly);
	$setuphold (posedge CLK, negedge WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE_dly);
	$setuphold (posedge CLK, posedge WE1, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE1_dly);
	$setuphold (posedge CLK, negedge WE1, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE1_dly);
	$setuphold (posedge CLK, posedge WE2, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE2_dly);
	$setuphold (posedge CLK, negedge WE2, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE2_dly);

        $period (posedge CLK, 0:0:0, notifier);
      
	specparam PATHPULSE$ = 0;

  endspecify

endmodule
