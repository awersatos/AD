// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/uni9000/KEEPER.v,v 1.2 2007/05/23 20:04:59 patrickp Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 9.1i (J.27)
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Weak Keeper
// /___/   /\     Filename : KEEPER.v
// \   \  /  \    Timestamp : Fri Sep  1 11:34:39 PDT 2006
//  \___\/\___\
//
// Revision:
//    09/01/06 - Initial version.
// End Revision
//    05/23/07 - Changed timescale to 1 ps / 1 ps.

`timescale  1 ps / 1 ps

module KEEPER (O);

    inout O;
    reg   in;

    always @(O)
	if (O)
	    in <= 1;
	else
	    in <= 0;

    buf (pull1, pull0) B1 (O, in);

endmodule
