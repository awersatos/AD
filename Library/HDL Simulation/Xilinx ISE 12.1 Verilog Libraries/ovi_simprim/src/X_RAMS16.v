// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_RAMS16.v,v 1.7 2008/05/12 21:46:39 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1i (L.12)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Static Synchronous RAM 16-Deep by 1-Wide
// /___/   /\     Filename : X_RAMS16.v
// \   \  /  \    Timestamp : Thu Mar 25 16:44:04 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Add LOC paramter;
//    05/07/08 - Add negative setup/hold support (CR468872)
// End Revision

`timescale 1 ps/1 ps

module X_RAMS16 (O, ADR0, ADR1, ADR2, ADR3, CLK, I, WE);

  parameter INIT = 16'h0000;

  parameter LOC = "UNPLACED";
  output O;

  input ADR0, ADR1, ADR2, ADR3, CLK, I, WE;

  reg [15:0] mem;
  wire [3:0] ADR_dly;
  wire I_dly, CLK_dly, WE_dly;
  reg notifier;

  initial 
    mem = INIT;


  always @(posedge CLK_dly) 
    if (WE_dly == 1'b1)
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

	$setuphold (posedge CLK, posedge I &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,I_dly);
	$setuphold (posedge CLK, negedge I &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,I_dly);
	$setuphold (posedge CLK, posedge ADR0 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[0]);
	$setuphold (posedge CLK, negedge ADR0 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[0]);
	$setuphold (posedge CLK, posedge ADR1 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[1]);
	$setuphold (posedge CLK, negedge ADR1 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[1]);
	$setuphold (posedge CLK, posedge ADR2 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[2]);
	$setuphold (posedge CLK, negedge ADR2 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[2]);
	$setuphold (posedge CLK, posedge ADR3 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[3]);
	$setuphold (posedge CLK, negedge ADR3 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[3]);
	$setuphold (posedge CLK, posedge WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE_dly);
	$setuphold (posedge CLK, negedge WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE_dly);

        $period (posedge CLK &&& WE, 0:0:0, notifier);
      
	specparam PATHPULSE$ = 0;

  endspecify

endmodule
