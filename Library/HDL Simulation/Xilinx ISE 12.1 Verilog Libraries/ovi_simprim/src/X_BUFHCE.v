// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/blanc/X_BUFHCE.v,v 1.5 2008/10/21 20:27:37 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1i (L.24)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  H Clock Buffer with Active High Enable
// /___/   /\     Filename : X_BUFHCE.v
// \   \  /  \    Timestamp : 
//  \___\/\___\
//
// Revision:
//    04/08/08 - Initial version.
//    09/19/08 - Add GSR
//    10/19/08 - Recoding to same as BUFGCE according to hardware.
// End Revision

`timescale 1 ps/1 ps

module X_BUFHCE (O, CE, I);

  parameter integer INIT_OUT = 0;
  parameter LOC = "UNPLACED";
  output O;
  input CE;
  input I;

  reg notifier;
  wire del_I, delCE;
  wire  NCE, o_bufg_o, o_bufg1_o;

  X_BUFGMUX B1 (.I0(del_I),
        .I1(1'b0),
        .O(o_bufg_o),
        .S(NCE));
                                                                                  
  X_INV I1 (.I(delCE),
        .O(NCE));

  X_BUFGMUX_1 B2 (.I0(del_I),
        .I1(1'b1),
        .O(o_bufg1_o),
        .S(NCE));

  assign O = (INIT_OUT == 1) ? o_bufg1_o : o_bufg_o;

  specify
    $period (posedge I, 0:0:0, notifier);
    $setuphold (negedge I, negedge CE, 0:0:0, 0:0:0, notifier,,, del_I, delCE);
    $setuphold (negedge I, posedge CE, 0:0:0, 0:0:0, notifier,,, del_I, delCE);
    $setuphold (posedge I, negedge CE, 0:0:0, 0:0:0, notifier,,, del_I, delCE);
    $setuphold (posedge I, posedge CE, 0:0:0, 0:0:0, notifier,,, del_I, delCE);
    (I => O) = (100:100:100, 100:100:100);
    specparam PATHPULSE$ = 0;
  endspecify

endmodule
