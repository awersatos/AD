// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_LATCH_CPLD.v,v 1.3 2009/01/19 21:01:37 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.i (L.31)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Transparent Data Latch
// /___/   /\     Filename : X_LATCH_CPLD.v
// \   \  /  \    Timestamp : Thu Mar 25 16:43:55 PST 2004
//  \___\/\___\
//
// Revision:
//    08/09/06 - Initial version, SET has priority than RST.
//    08/30/06 - Rename UDP name (CR 422696).
//    01/19/09 - Add pulse width check for CLK low  time (CR503948)
// End Revision

`timescale 1 ps/1 ps
 
module X_LATCH_CPLD (O, CLK, I, RST, SET);

  parameter INIT = 1'b0;
  parameter LOC = "UNPLACED";
  parameter XON = "TRUE";
  parameter MSGON = "TRUE";

  output O;
  input CLK, I, RST, SET;

  wire nrst, nset, ngsr;
  reg notifier;
  wire notifier1;
  wire in_clk_enable, rst_clk_enable, set_clk_enable;
  wire in_clk_enable1, rst_clk_enable1, set_clk_enable1;
  wire o_out;
  reg rst_int, set_int;
  reg o_reg = INIT;

  tri0 GSR = glbl.GSR;

  buf O1 (O, o_reg);
    
  always @(GSR or SET or RST) begin
      if (GSR) 
	  if (INIT) begin
	      set_int = 1;
	      rst_int = 0;
	  end
	  else begin
	      rst_int = 1;
	      set_int = 0;
	  end
      else begin
	  rst_int = RST;
	  set_int = SET;
      end
  end // always @ (GSR or SET or RST)
    
  always @(o_out)
      o_reg = o_out;
    
  not (nrst, RST);
  not (nset, SET);
  not (ngsr, GSR);

  and (in_clk_enable, nrst, nset, ngsr);
  and (rst_clk_enable, ngsr);
  and (set_clk_enable, ngsr, nrst);

  assign notifier1 = (XON == "FALSE") ?  1'bx : notifier;
  assign in_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : in_clk_enable;
  assign rst_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : rst_clk_enable; 
  assign set_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : set_clk_enable;

  latchsrcpld (o_out, CLK, I, set_int, rst_int, notifier1);

  specify

	(I => O) = (100:100:100, 100:100:100);
	(CLK => O) = (100:100:100, 100:100:100);
	(SET => O) = (0:0:0, 0:0:0);
	(RST => O) = (0:0:0, 0:0:0);

	$setuphold (negedge CLK, posedge I &&& in_clk_enable1, 0:0:0, 0:0:0, notifier);
	$setuphold (negedge CLK, negedge I &&& in_clk_enable1, 0:0:0, 0:0:0, notifier);

	$recrem (negedge RST, negedge CLK &&& (rst_clk_enable1!=0), 0:0:0, 0:0:0, notifier);
	$recrem (negedge SET, negedge CLK &&& (set_clk_enable1!=0), 0:0:0, 0:0:0, notifier);

	$width (posedge CLK, 0:0:0, 0, notifier);
	$width (negedge CLK, 0:0:0, 0, notifier);
	$width (posedge RST, 0:0:0, 0, notifier);
	$width (posedge SET, 0:0:0, 0, notifier);

	specparam PATHPULSE$ = 0;

  endspecify

endmodule


primitive latchsrcpld (q, clk, d, set, rst, notifier);

  output q; reg q;
  input clk, d, set, rst, notifier;

  table

    //   clk    d   set   rst  notifier   q     q+;

          1     0    0     0      ?   :   ?  :  0;
          1     1    0     0      ?   :   ?  :  1;
          0     ?    0     0      ?   :   ?  :  -;
          ?     0    0     ?      ?   :   0  :  -;
          ?     1    ?     0      ?   :   1  :  -;
          ?     ?    1     ?      ?   :   ?  :  1;
          ?     ?    0     1      ?   :   ?  :  0;
          0     ?    0     x      ?   :   0  :  0;
          1     0    0     x      ?   :   ?  :  0;
          0     ?    x     0      ?   :   1  :  1;
          1     1    x     0      ?   :   ?  :  1;
          ?     ?    ?     ?      *   :   ?  :  x;

  endtable

endprimitive
