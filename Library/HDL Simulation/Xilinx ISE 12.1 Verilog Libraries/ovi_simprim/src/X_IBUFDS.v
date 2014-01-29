// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_IBUFDS.v,v 1.7 2006/07/21 21:11:11 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 9.1i (J.25)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Differential Signaling Input Buffer
// /___/   /\     Filename : X_IBUFDS.v
// \   \  /  \    Timestamp : Thu Mar 25 16:43:55 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Add LOC paramter;
//    07/21/05 - CR 212974 -- matched unisim parameters as requested by other tools
//    07/19/06 - Add else to handle x case for o_out (CR 234718).
// End Revision

`timescale 1 ps/1 ps

module X_IBUFDS (O, I, IB);

  parameter LOC = "UNPLACED";
  parameter CAPACITANCE = "DONT_CARE";
  parameter DIFF_TERM = "FALSE";
  parameter IBUF_DELAY_VALUE = "0";
  parameter IFD_DELAY_VALUE = "AUTO";
  parameter IOSTANDARD = "DEFAULT";

    output O;

    input  I, IB;

    wire i_in, ib_in;
    reg o_out;

    buf b_I (i_in, I);
    buf b_IB (ib_in, IB);
    buf b_O (O, o_out);

    always @(i_in or ib_in) begin
	if (i_in == 1'b1 && ib_in == 1'b0)
	    o_out = i_in;
	else if (i_in == 1'b0 && ib_in == 1'b1)
	    o_out = i_in;
        else if (i_in == 1'bx || ib_in == 1'bx)
            o_out = 1'bx;
    end

    specify

	(I => O) = (0:0:0, 0:0:0);
	(IB => O) = (0:0:0, 0:0:0);

	specparam PATHPULSE$ = 0;

    endspecify

endmodule

