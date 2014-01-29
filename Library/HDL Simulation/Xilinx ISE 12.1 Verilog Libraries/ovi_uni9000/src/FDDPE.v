// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/uni9000/FDDPE.v,v 1.5 2008/12/18 17:55:35 vandanad Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 7.1i (H.19)
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Dual Edge Triggered D Flip-Flop with Asynchronous Preset and Clock Enable
// /___/   /\     Filename : FDDPE.v
// \   \  /  \    Timestamp : Thu Mar 25 16:41:55 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    05/23/07 - Changed timescale to 1 ps / 1 ps.
//    12/17/08 - 501161 - Added INIT.

`timescale  1 ps / 1 ps

module FDDPE (Q, C, CE, D, PRE);

  parameter INIT = 1'b1;

    output Q;
    reg    q_out;

    input  C, CE, D, PRE;

    tri0 PRLD = glbl.PRLD;

    buf B1 (Q, q_out);

	always @(PRLD or PRE)
	    if (PRLD)
		assign q_out = 1;
	    else if (PRE)
		assign q_out = 1;
	    else
		deassign q_out;

	always @(posedge C or negedge C)
	    if (CE)
		q_out = D;

    specify
	(posedge PRE => (Q +: 1'b1)) = (0, 0);
	if (!PRE && CE)
	    (posedge C => (Q +: D)) = (1, 1);
	if (!PRE && CE)
	    (negedge C => (Q +: D)) = (1, 1);
    endspecify

endmodule

