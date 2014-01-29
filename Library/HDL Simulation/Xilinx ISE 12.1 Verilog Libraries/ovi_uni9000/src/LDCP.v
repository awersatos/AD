// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/uni9000/LDCP.v,v 1.2 2007/05/23 20:05:01 patrickp Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 9.1i (J.30)
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Transparent Data Latch with Asynchronous Clear and Preset
// /___/   /\     Filename : LDCP.v
// \   \  /  \    Timestamp : Wed Oct 18 14:01:05 PDT 2006
//  \___\/\___\
//
// Revision:
//    10/18/06 - Initial version.
// End Revision
//    05/23/07 - Changed timescale to 1 ps / 1 ps.

`timescale  1 ps / 1 ps

module LDCP (Q, CLR, D, G, PRE);

    parameter INIT = 1'b0;

    output Q;
    reg q_out;

    input  CLR, D, G, PRE;

    tri0 PRLD = glbl.PRLD;

    buf B1 (Q, q_out);
    
	always @(CLR or PRE or D or G or PRLD)
            if (PRLD)
                 q_out = INIT;
            else if (CLR)
		q_out = 0;
	    else if (PRE)
		q_out = 1;
	    else if (G)
		q_out = D;

    specify
	if (!CLR && !PRE && G)
	    (D +=> Q) = (100, 100);
	if (!CLR && !PRE)
	    (posedge G => (Q +: D)) = (100, 100);
	if (!CLR)
	    (posedge PRE => (Q +: 1'b1)) = (0, 0);
	(posedge CLR => (Q +: 1'b0)) = (0, 0);
    endspecify
endmodule
