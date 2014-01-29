// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/rainier/X_SRLC32E.v,v 1.6 2010/01/06 00:50:27 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 12.i (M.43)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  32-Bit Shift Register Look-Up-Table with Carry and Clock Enable
// /___/   /\     Filename : X_SRLC32E.v
// \   \  /  \    Timestamp : Thu Mar 25 16:44:04 PST 2004
//  \___\/\___\
//
// Revision:
//    03/15/05 - Initial version.
//    01/07/06 - Add LOC parameter (CR 222733)
//    01/18/06 - Add timing path for A1, A2, A3, A4 (CR224341).
//    05/07/08 - Add negative setup/hold support (CR468872)
//    01/05/10 - change 16 bit to 32 bit in Description (CR541757)
// End Revision

`timescale 1 ps/1 ps

module X_SRLC32E (Q, Q31, A, CE, CLK, D);

  parameter INIT = 32'h00000000;
  parameter LOC = "UNPLACED";

  output Q;
  output Q31;

  input  [4:0] A;
  input  CE, CLK, D;

  reg  [31:0] data;
  wire CLK_dly, CE_dly, D_dly;
  reg notifier;


    initial
    begin
          assign  data = INIT;
          while (CLK_dly === 1'b1 || CLK_dly ===1'bX) 
            #10; 
          deassign data;
    end


  always @(posedge CLK_dly) 
    if (CE_dly == 1'b1) 
      data[31:0] <=  {data[30:0], D_dly};


    assign Q = data[A];
    assign Q31 = data[31];

  always @(notifier) 
    data[0] = 1'bx;

  specify

	(A[0] => Q) = (0:0:0, 0:0:0);
	(A[1] => Q) = (0:0:0, 0:0:0);
	(A[2] => Q) = (0:0:0, 0:0:0);
	(A[3] => Q) = (0:0:0, 0:0:0);
	(A[4] => Q) = (0:0:0, 0:0:0);
	(CLK => Q) = (0:0:0, 0:0:0);
	(CLK => Q31) = (0:0:0, 0:0:0);

	$setuphold (posedge CLK, posedge D &&& CE, 0:0:0, 0:0:0, notifier,,,CLK_dly,D_dly);
	$setuphold (posedge CLK, negedge D &&& CE, 0:0:0, 0:0:0, notifier,,,CLK_dly,D_dly);
	$setuphold (posedge CLK, posedge CE, 0:0:0, 0:0:0, notifier,,,CLK_dly,CE_dly);
	$setuphold (posedge CLK, negedge CE, 0:0:0, 0:0:0, notifier,,,CLK_dly,CE_dly);

        $period (posedge CLK, 0:0:0, notifier);
      
	specparam PATHPULSE$ = 0;

  endspecify

endmodule

