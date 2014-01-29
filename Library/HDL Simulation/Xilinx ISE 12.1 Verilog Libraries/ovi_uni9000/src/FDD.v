// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/uni9000/FDD.v,v 1.4 2007/05/23 20:04:57 patrickp Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 7.1i (H.19)
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Dual Edge Triggered D Flip-Flop
// /___/   /\     Filename : FDD.v
// \   \  /  \    Timestamp : Thu Mar 25 16:41:53 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    05/23/07 - Changed timescale to 1 ps / 1 ps.

`timescale  1 ps / 1 ps

module FDD (Q, C, D);

    parameter INIT = 1'b0;

    output Q;
    reg    q_out;

    input  C, D;

    tri0 PRLD = glbl.PRLD;

    buf B1 (Q, q_out);

	always @(PRLD)
	    if (PRLD)
		assign q_out = INIT;
	    else
		deassign q_out;

	always @(posedge C or negedge C)
	    q_out <= D;

    specify
	(posedge C => (Q +: D)) = (1, 1);
	(negedge C => (Q +: D)) = (1, 1); 
    endspecify

endmodule

