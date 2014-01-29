// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_FDDRCPE.v,v 1.8 2007/06/05 00:00:54 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 10.1i (K.17)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Dual Data Rate D Flip-Flop with Asynchronous Clear and Preset and Clock Enable
// /___/   /\     Filename : X_FDDRCPE.v
// \   \  /  \    Timestamp : Thu Mar 25 16:43:54 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Add LOC paramter, GSR;
//    06/04/07 - Add wire declaration to internal signal.
// End Revision

`timescale  1 ps / 1 ps

module X_FDDRCPE (Q, C0, C1, CE, CLR, D0, D1, PRE);

    parameter INIT = 1'b0;

  parameter LOC = "UNPLACED";
    output Q;
    reg notifier;
    reg    q_out;

    tri0 GSR = glbl.GSR;

    input  C0, C1, CE, CLR, D0, D1, PRE;

    wire pre_enable, ce_enable0, ce_enable1, in_enable;
    wire in_out0, in_out1, nclr, ngsr, npre;
    wire c0_in, c1_in, clr_in, gsr_in, pre_in;

    buf B1 (Q, q_out);
    buf B2 (c0_in, C0);
    buf B3 (c1_in, C1);
    buf B4 (clr_in, CLR);
    buf B5 (gsr_in, GSR);
    buf B6 (pre_in, PRE);

    initial
      q_out = 0;

	always @(gsr_in or clr_in or pre_in)
	    if (gsr_in)
		assign q_out = INIT;
	    else if (clr_in)
		assign q_out = 0;
	    else if (pre_in)
		assign q_out = 1;
	    else
		deassign q_out;

	always @(posedge c0_in)
	    if (CE)
		q_out <= D0;

	always @(posedge c1_in)
	    if (CE)
		q_out <= D1;


    not (nclr, CLR);
    not (npre, PRE);
    not (ngsr, GSR);
    xor (in_out0, D0, Q);
    xor (in_out1, D1, Q);

    and (pre_enable, ngsr, nclr);
    and (in_enable, ngsr, nclr, npre, CE);
    and (ce_enable0, ngsr, nclr, npre, in_out0);
    and (ce_enable1, ngsr, nclr, npre, in_out1);

    always @(notifier) begin
      deassign q_out;
      q_out <= 1'bx;
    end


    specify

	(C0 => Q) = (100:100:100, 100:100:100);
	(C1 => Q) = (100:100:100, 100:100:100);
	(CLR => Q) = (0:0:0, 0:0:0);
	(PRE => Q) = (0:0:0, 0:0:0);

	$setuphold (posedge C0, posedge CE &&& (ce_enable0!=0), 0:0:0, 0:0:0, notifier);
	$setuphold (posedge C1, posedge CE &&& (ce_enable1!=0), 0:0:0, 0:0:0, notifier);
	$setuphold (posedge C0, negedge CE &&& (ce_enable0!=0), 0:0:0, 0:0:0, notifier);
	$setuphold (posedge C1, negedge CE &&& (ce_enable1!=0), 0:0:0, 0:0:0, notifier);

	$setuphold (posedge C0, posedge D0 &&& (in_enable!=0), 0:0:0, 0:0:0, notifier);
	$setuphold (posedge C1, posedge D1 &&& (in_enable!=0), 0:0:0, 0:0:0, notifier);
	$setuphold (posedge C0, negedge D0 &&& (in_enable!=0), 0:0:0, 0:0:0, notifier);
	$setuphold (posedge C1, negedge D1 &&& (in_enable!=0), 0:0:0, 0:0:0, notifier);

	$recrem (negedge CLR, posedge C0 &&& (GSR==0), 0:0:0, 0:0:0, notifier);
	$recrem (negedge CLR, posedge C1 &&& (GSR==0), 0:0:0, 0:0:0, notifier);
	$recrem (negedge PRE, posedge C0 &&& (pre_enable!=0), 0:0:0, 0:0:0, notifier);
	$recrem (negedge PRE, posedge C1 &&& (pre_enable!=0), 0:0:0, 0:0:0, notifier);

	$width (posedge C0, 0:0:0, 0, notifier);
	$width (negedge C0, 0:0:0, 0, notifier);
	$width (posedge C1, 0:0:0, 0, notifier);
	$width (negedge C1, 0:0:0, 0, notifier);
	$width (posedge CLR, 0:0:0, 0, notifier);
	$width (posedge PRE, 0:0:0, 0, notifier);

	specparam PATHPULSE$ = 0;

    endspecify

endmodule




