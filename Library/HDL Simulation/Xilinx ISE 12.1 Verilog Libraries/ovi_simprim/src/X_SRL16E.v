// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_SRL16E.v,v 1.8 2008/05/12 21:50:01 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1i (L.12)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  16-Bit Shift Register Look-Up-Table with Clock Enable
// /___/   /\     Filename : X_SRL16E.v
// \   \  /  \    Timestamp : Thu Mar 25 16:44:04 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Add LOC paramter;
//    05/07/08 - Add negative setup/hold support (CR468872)
// End Revision

`timescale 1 ps/1 ps

module X_SRL16E (Q, A0, A1, A2, A3, CE, CLK, D);

  parameter INIT = 16'h0000;

  parameter LOC = "UNPLACED";
  output Q;
  input  A0, A1, A2, A3, CE, CLK, D;

  reg  [15:0] data;
  wire [3:0]  addr;
  wire CLK_dly, D_dly, CE_dly;
  reg notifier;

    initial
    begin
          assign  data = INIT;
          while (CLK_dly === 1'b1 || CLK_dly ===1'bX) 
            #10; 
          deassign data;
    end

  assign addr[3:0] = {A3, A2, A1, A0};
     
  always @(posedge CLK_dly)
    if (CE_dly == 1'b1)
      {data[15:0]} <= #100 {data[14:0], D_dly};

    assign Q =  data[addr];

  always @(notifier) 
    data[0] <= 1'bx;

  specify

	(A0 => Q) = (0:0:0, 0:0:0);
	(A1 => Q) = (0:0:0, 0:0:0);
	(A2 => Q) = (0:0:0, 0:0:0);
	(A3 => Q) = (0:0:0, 0:0:0);
	(CLK => Q) = (0:0:0, 0:0:0);

	$setuphold (posedge CLK, posedge D &&& CE, 0:0:0, 0:0:0, notifier,,,CLK_dly,D_dly);
	$setuphold (posedge CLK, negedge D &&& CE, 0:0:0, 0:0:0, notifier,,,CLK_dly,D_dly);
	$setuphold (posedge CLK, posedge CE, 0:0:0, 0:0:0, notifier,,,CLK_dly,CE_dly);
	$setuphold (posedge CLK, negedge CE, 0:0:0, 0:0:0, notifier,,,CLK_dly,CE_dly);

        $period (posedge CLK, 0:0:0, notifier);

	specparam PATHPULSE$ = 0;

  endspecify

endmodule


