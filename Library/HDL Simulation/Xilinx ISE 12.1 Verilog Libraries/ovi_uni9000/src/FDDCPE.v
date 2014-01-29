// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/uni9000/FDDCPE.v,v 1.5 2008/12/18 17:55:35 vandanad Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 7.1i (H.19)
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Dual Edge Triggered D Flip-Flop with Asynchronous Clear and Preset and Clock Enable
// /___/   /\     Filename : FDDCPE.v
// \   \  /  \    Timestamp : Thu Mar 25 16:41:54 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    05/23/07 - Changed timescale to 1 ps / 1 ps.
//    12/17/08 - 501161 - Added INIT.

`timescale  1 ps / 1 ps

module FDDCPE (Q, C, CE, CLR, D, PRE);
  
  parameter INIT = 1'b0;
  
    output Q;
    reg    q_out;

    input  C, CE, CLR, D, PRE;

    tri0 PRLD = glbl.PRLD;

    buf B1 (Q, q_out);

	always @(PRLD or CLR or PRE)
	    if (PRLD)
		assign q_out = INIT;
	    else if (CLR)
		assign q_out = 0;
	    else if (PRE)
		assign q_out = 1;
	    else
		deassign q_out;

	always @(posedge C or negedge C)
	    if (CE)
		q_out = D;

    specify
	(posedge CLR => (Q +: 1'b0)) = (0, 0);
	if (!CLR)
	    (posedge PRE => (Q +: 1'b1)) = (0, 0);
	if (!CLR)
	    (negedge PRE => (Q +: 1'b1)) = (0, 0);
	if (!CLR && !PRE && CE)
	    (posedge C => (Q +: D)) = (1, 1);
	if (!CLR && !PRE && CE)
	    (negedge C => (Q +: D)) = (1, 1);
    endspecify

endmodule
