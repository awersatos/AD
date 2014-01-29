// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/uni9000/ILD.v,v 1.4 2007/05/23 20:04:58 patrickp Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 7.1i (H.19)
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Tranparent Input Data Latch
// /___/   /\     Filename : ILD.v
// \   \  /  \    Timestamp : Thu Mar 25 16:41:59 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    05/23/07 - Changed timescale to 1 ps / 1 ps.

`timescale  1 ps / 1 ps

`celldefine

module ILD (Q, D, G);


    output Q;
    reg    q_out;

    input  D, G;

    tri0 PRLD = glbl.PRLD;

    buf B1 (Q, q_out);

	always @(PRLD or D or G)
	    if (PRLD)
		q_out = 0;
	    else if (G)
		q_out = D;

    specify
	if (G)
	    (D +=> Q) = (0, 0);
	(posedge G => (Q +: D)) = (1, 1);
    endspecify

endmodule

`endcelldefine
