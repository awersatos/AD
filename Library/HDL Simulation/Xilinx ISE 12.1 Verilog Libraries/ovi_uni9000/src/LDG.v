// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/uni9000/LDG.v,v 1.5 2007/05/23 20:05:02 patrickp Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.13)
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Transparent Datagate Latch
// /___/   /\     Filename : LDG.v
// \   \  /  \    Timestamp : Wed Mar  9 13:49:59 PST 2005
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/09/05 - Added INIT parameter.
//    05/23/07 - Changed timescale to 1 ps / 1 ps.

`timescale  1 ps / 1 ps

`celldefine

module LDG (Q, D, G);

    parameter INIT = 1'b0;

    output Q;
    reg    q_out;

    input  D, G;

    tri0 PRLD = glbl.PRLD;

    buf B1 (Q, q_out);

	always @(PRLD or D or G)
	    if (PRLD)
		q_out = INIT;
	    else if (!G)
		q_out = D;

    specify
	if (!G)
	    (D +=> Q) = (0, 0);
	(negedge G => (Q +: D)) = (1, 1);
    endspecify

endmodule

`endcelldefine
