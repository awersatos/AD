// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/uni9000/FTCP.v,v 1.5 2007/05/23 20:04:58 patrickp Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.13)
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Toggle Flip-Flop with Toggle Enable and Asynchronous Clear and Preset
// /___/   /\     Filename : FTCP.v
// \   \  /  \    Timestamp : Wed Mar  9 13:49:59 PST 2005
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/09/05 - Added INIT parameter.
//    05/23/07 - Changed timescale to 1 ps / 1 ps.

`timescale  1 ps / 1 ps

`celldefine

module FTCP (Q, C, CLR, PRE, T);

    parameter INIT = 1'b0;

    output Q;
    reg    q_out;

    input  C, CLR, PRE, T;

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

	always @(posedge C)
	    if (T)
		q_out = ~q_out;

    specify
	(posedge C => (Q -: Q)) = (1, 1);
	(posedge CLR => (Q +: 1'b0)) = (0, 0);
	(posedge PRE => (Q +: 1'b1)) = (0, 0);
    endspecify

endmodule

`endcelldefine
