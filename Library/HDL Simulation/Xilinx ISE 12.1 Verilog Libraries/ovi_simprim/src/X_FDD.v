// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_FDD.v,v 1.9 2009/08/22 00:02:08 harikr Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 9.1i (J.25)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Dual Edge Triggered D Flip-Flop
// /___/   /\     Filename : X_FDD.v
// \   \  /  \    Timestamp : Thu Mar 25 16:43:54 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Add LOC paramter, GSR;
//    08/04/06 - Add buf for output (CR235590).
//    07/22/09 - Fixed mismatch with unisim.(CR526845)
// End Revision

`timescale 1 ps/1 ps
 
module X_FDD (O, CE, CLK, I, RST, SET);

  parameter INIT = 1'b0;
  parameter LOC = "UNPLACED";

  output O;
  input CE, CLK, I, RST, SET;

  wire ni, nrst, nset, in_out;
  wire in_clk_enable, ce_clk_enable, rst_clk_enable, set_clk_enable;
  wire O_tmp1;
  reg O_tmp;
  reg notifier;

  tri0 GSR = glbl.GSR;

  always @(GSR )
  if (GSR)
    assign O_tmp = INIT;
  else 
    assign O_tmp = O_tmp1;


  initial
    O_tmp = INIT;

  not (ni, I);
  not (nrst, RST);
  not (nset, SET);
  xor (in_out, I, O);

  buf O1 (O, O_tmp);

  always @(O_tmp1)
     O_tmp = O_tmp1;

  and (in_clk_enable, nrst, nset, CE);
  and (ce_clk_enable, nrst, nset, in_out);
  and (rst_clk_enable, CE, I);
  and (set_clk_enable, CE, nrst, ni);

  ffsrced (O_tmp1, CLK, I, CE, SET, RST, notifier);

  specify

	(CLK => O) = (100:100:100, 100:100:100);
	(SET => O) = (0:0:0, 0:0:0);
	(RST => O) = (0:0:0, 0:0:0);

	$setuphold (posedge CLK, posedge CE &&& (ce_clk_enable!=0), 0:0:0, 0:0:0, notifier);
	$setuphold (posedge CLK, negedge CE &&& (ce_clk_enable!=0), 0:0:0, 0:0:0, notifier);
	$setuphold (negedge CLK, posedge CE &&& (ce_clk_enable!=0), 0:0:0, 0:0:0, notifier);
	$setuphold (negedge CLK, negedge CE &&& (ce_clk_enable!=0), 0:0:0, 0:0:0, notifier);
	$setuphold (posedge CLK, posedge I &&& (in_clk_enable!=0), 0:0:0, 0:0:0, notifier);
	$setuphold (posedge CLK, negedge I &&& (in_clk_enable!=0), 0:0:0, 0:0:0, notifier);
	$setuphold (negedge CLK, posedge I &&& (in_clk_enable!=0), 0:0:0, 0:0:0, notifier);
	$setuphold (negedge CLK, negedge I &&& (in_clk_enable!=0), 0:0:0, 0:0:0, notifier);

	$recrem (negedge RST, posedge CLK &&& (rst_clk_enable!=0), 0:0:0, 0:0:0, notifier);
	$recrem (negedge RST, negedge CLK &&& (rst_clk_enable!=0), 0:0:0, 0:0:0, notifier);
	$recrem (negedge SET, posedge CLK &&& (set_clk_enable!=0), 0:0:0, 0:0:0, notifier);
	$recrem (negedge SET, negedge CLK &&& (set_clk_enable!=0), 0:0:0, 0:0:0, notifier);

	$width (posedge CLK, 0:0:0, 0, notifier);
	$width (negedge CLK, 0:0:0, 0, notifier);
	$width (posedge RST, 0:0:0, 0, notifier);
	$width (posedge SET, 0:0:0, 0, notifier);

	specparam PATHPULSE$ = 0;

  endspecify

endmodule


primitive ffsrced (q, clk, d, ce, set, rst, notifier);

  output q; reg q;
  input clk, d, ce, set, rst, notifier;

  table

    //   clk    d     ce   set   rst   notifier    q     q+;

         (01)   0      1    0     0       ?    :   ?  :  0;
         (01)   1      1    0     0       ?    :   ?  :  1;
         (01)   x      1    0     0       ?    :   ?  :  x;
         (01)   0      x    0     0       ?    :   0  :  0;
         (01)   1      x    0     0       ?    :   1  :  1;

         (10)   0      1    0     0       ?    :   ?  :  0;
         (10)   1      1    0     0       ?    :   ?  :  1;
         (10)   x      1    0     0       ?    :   ?  :  x;
         (10)   0      x    0     0       ?    :   0  :  0;
         (10)   1      x    0     0       ?    :   1  :  1;

         (??)   ?      0    0     0       ?    :   ?  :  -;

          ?     ?      ?    1     0       ?    :   ?  :  1;
          ?     ?      ?    ?     1       ?    :   ?  :  0;
          ?     ?      ?    0     x       ?    :   0  :  0;
         (01)   0      1    0     x       ?    :   ?  :  0;
         (10)   0      1    0     x       ?    :   ?  :  0;
          ?     ?      ?    x     0       ?    :   1  :  1;
         (01)   1      1    x     0       ?    :   ?  :  1;
         (10)   1      1    x     0       ?    :   ?  :  1;

          ?    (??)    ?    0     0       ?    :   ?  :  -;
          ?     ?    (??)   0     0       ?    :   ?  :  -;
          ?     ?      ?   (?0)   ?       ?    :   ?  :  -;
          ?     ?      ?    ?    (?0)     ?    :   ?  :  -;

          ?     ?      ?    ?     ?       *    :   ?  :  x;

  endtable

endprimitive
