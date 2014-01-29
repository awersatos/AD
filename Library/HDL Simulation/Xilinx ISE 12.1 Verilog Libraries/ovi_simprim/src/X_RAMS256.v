// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/rainier/X_RAMS256.v,v 1.5 2008/05/12 21:09:15 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1i (L.12)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Static Synchronous RAM 256-Deep by 1-Wide
// /___/   /\     Filename : X_RAMS256.v
// \   \  /  \    Timestamp : Thu Mar 25 16:44:03 PST 2004
//  \___\/\___\
//
// Revision:
//    02/07/05 - Initial version.
//    01/07/06 - Add LOC parameter (CR 222733).
//    06/22/06 - Change initial to hex (CR 233085).
//    05/07/08 - Add negative setup/hold support (CR468872)
// End Revision

`timescale 1 ps/1 ps

module X_RAMS256 (O, ADR0, ADR1, ADR2, ADR3, ADR4, ADR5, ADR6, ADR7, CLK, I, WE);

  parameter INIT = 256'h0;
  parameter LOC = "UNPLACED";

  output O;
  input ADR0, ADR1, ADR2, ADR3, ADR4, ADR5, ADR6, ADR7, CLK, I, WE;

  reg [255:0] mem;
  wire [7:0] ADR_dly;
  wire CLK_dly, WE_dly, I_dly;

  reg notifier;


  initial 
    mem = INIT;

  always @(posedge CLK_dly) 
     if (WE_dly == 1'b1)
        mem[ADR_dly] <= #100 I_dly;


    assign O = mem[ADR_dly];


  always @(notifier) 
    mem[ADR_dly] = 1'bx;

  specify

	(CLK => O) = (0:0:0, 0:0:0);
	(ADR0 => O) = (0:0:0, 0:0:0);
	(ADR1 => O) = (0:0:0, 0:0:0);
	(ADR2 => O) = (0:0:0, 0:0:0);
	(ADR3 => O) = (0:0:0, 0:0:0);
	(ADR4 => O) = (0:0:0, 0:0:0);
	(ADR5 => O) = (0:0:0, 0:0:0);
	(ADR6 => O) = (0:0:0, 0:0:0);
	(ADR7 => O) = (0:0:0, 0:0:0);

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
	$setuphold (posedge CLK, posedge ADR4 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[4]);
	$setuphold (posedge CLK, negedge ADR4 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[4]);
	$setuphold (posedge CLK, posedge ADR5 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[5]);
	$setuphold (posedge CLK, negedge ADR5 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[5]);
	$setuphold (posedge CLK, posedge ADR6 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[6]);
	$setuphold (posedge CLK, negedge ADR6 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[6]);
	$setuphold (posedge CLK, posedge ADR7 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[7]);
	$setuphold (posedge CLK, negedge ADR7 &&& WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,ADR_dly[7]);
	$setuphold (posedge CLK, posedge WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE_dly);
	$setuphold (posedge CLK, negedge WE, 0:0:0, 0:0:0, notifier,,,CLK_dly,WE_dly);

        $period (posedge CLK &&& WE, 0:0:0, notifier);

	specparam PATHPULSE$ = 0;

  endspecify

endmodule
