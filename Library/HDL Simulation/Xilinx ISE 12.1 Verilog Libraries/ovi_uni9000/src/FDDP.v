// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/uni9000/FDDP.v,v 1.4 2007/05/23 20:04:56 patrickp Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 7.1i (H.19)
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Dual Edge Triggered D Flip-Flop with Asynchronous Preset
// /___/   /\     Filename : FDDP.v
// \   \  /  \    Timestamp : Thu Mar 25 16:41:54 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    05/23/07 - Changed timescale to 1 ps / 1 ps.

`timescale  1 ps / 1 ps

module FDDP (Q, C, D, PRE);

    parameter INIT = 1'b1;

    output Q;
    reg    q_out;

    input  C, D, PRE;

    tri0 PRLD = glbl.PRLD;

    buf B1 (Q, q_out);

	always @(PRLD or PRE)
	    if (PRLD)
		assign q_out = INIT;
	    else if (PRE)
		assign q_out = 1;
	    else
		deassign q_out;

	always @(posedge C or negedge C)
	    q_out <= D;

    specify
	(posedge PRE => (Q +: 1'b1)) = (0, 0);
	if (!PRE)
	    (posedge C => (Q +: D)) = (1, 1);
	if (!PRE)
	    (negedge C => (Q +: D)) = (1, 1);
    endspecify

endmodule
