// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_BUFGMUX_1.v,v 1.18 2009/08/22 00:02:08 harikr Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.3 (L.47)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Global Clock Mux Buffer with Output State 1
// /___/   /\     Filename : X_BUFGMUX_1.v
// \   \  /  \    Timestamp : Thu Mar 25 16:43:54 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/09/05 - Add LOC paramter; Remove GSR pin.
//    03/29/05 - Remove tri-state buffer, pull down, and use S to trigger the 
//                 always block for enable signals.
//    04/26/05 - Change setup/hold edge from positive to negative (207275).
//    06/28/05 - Update setup and hold check.
//    03/22/07 - Fix bug in q0_enable and q1_enable (CR 436519)
//    04/23/07 - Use === for I0 and I1 comparision (CR438265).
//    01/11/08 - Add CLK_SEL_TYPE attribute.
//    05/20/08 - Change code to the same as unisim model.(CR467336)
//    05/11/09 - Add period timing check (CR521102)
//    06/04/09 - Set initial path delay value to 0, same as vhdl (CR523346).
// End Revision

`timescale 1 ps/1 ps

module X_BUFGMUX_1 (O, I0, I1, S);

    parameter CLK_SEL_TYPE = "SYNC";
    parameter LOC = "UNPLACED";
    output O;
    input  I0, I1, S;

    reg q0_enable, q1_enable;
    reg q0, q1;
    wire q0_t, q1_t;
    wire i0_in, i1_in, s_in;
    reg clk_sel_in;
    reg notifier;

    tri0 GSR = glbl.GSR;

    buf B1 (i0_in, I0);
    buf B2 (i1_in, I1);
    buf B3 (s_in, S);
    bufif1 B4 (O, i0_in, q0_t);
    bufif1 B5 (O, i1_in, q1_t);
    pullup P1 (O);

    initial begin
        q0_enable = 1;
        q1_enable = 0;
        q0 = 1;
        q1 = 0;
        clk_sel_in = (CLK_SEL_TYPE == "ASYNC") ? 1 : 0;
    end
       assign q0_t = (clk_sel_in) ? ~S : q0;
       assign q1_t = (clk_sel_in) ? S : q1;

        always @(GSR or i0_in or s_in or q0_enable)
            if (GSR)
                q0 <= 1;
            else if (i0_in !== 0)
                q0 <= !s_in && q0_enable;
                                                                                   
        always @(GSR or i1_in or s_in or q1_enable)
            if (GSR)
                q1 <= 0;
            else if (i1_in !== 0)
                q1 <= s_in && q1_enable;

        always @(GSR or q1 or i0_in)
            if (GSR)
                q0_enable <= 1;
            else if (q1 === 1)
                q0_enable <= 0;
            else if (i0_in !== 1)
                q0_enable <= !q1;

        always @(GSR or q0 or i1_in)
            if (GSR)
                q1_enable <= 0;
            else if (q0 === 1)
                q1_enable <= 0;
            else if (i1_in !== 1)
                q1_enable <= !q0;

    specify

    ( I0 => O) = (0:0:0, 0:0:0);
    ( I1 => O) = (0:0:0, 0:0:0);
    ( S => O) = (0:0:0, 0:0:0);
    $period (posedge I0, 0:0:0, notifier);
    $period (posedge I1, 0:0:0, notifier);
    $setuphold (posedge I0, posedge S, 0:0:0, 0:0:0, notifier);
    $setuphold (posedge I1, negedge S, 0:0:0, 0:0:0, notifier);
	 specparam PATHPULSE$ = 0;

    endspecify

endmodule
