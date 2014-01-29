// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/uni9000/FTC.v,v 1.4 2007/05/23 20:04:58 patrickp Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 7.1i (H.19)
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Toggle Flip-Flop with Toggle Enable and Asynchronous Clear
// /___/   /\     Filename : FTC.v
// \   \  /  \    Timestamp : Thu Mar 25 16:41:56 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    05/23/07 - Changed timescale to 1 ps / 1 ps.

`timescale  1 ps / 1 ps

`celldefine

module FTC (Q, C, CLR, T);


    output Q;
    reg    q_out;

    input  C, CLR, T;

    tri0 PRLD = glbl.PRLD;

    buf B1 (Q, q_out);

	always @(PRLD or CLR)
	    if (PRLD || CLR)
		assign q_out = 0;
	    else
		deassign q_out;

	always @(posedge C)
	    if (T)
		q_out = ~q_out;

    specify
	(posedge C => (Q -: Q)) = (1, 1);
	(posedge CLR => (Q +: 1'b0)) = (0, 0);
    endspecify

endmodule

`endcelldefine
