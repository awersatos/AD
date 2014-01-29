// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_LATCHE.v,v 1.15 2009/08/22 00:02:08 harikr Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.i (L.38)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Transparent Data Latch with Gate Enable
// /___/   /\     Filename : X_LATCHE.v
// \   \  /  \    Timestamp : Thu Mar 25 16:43:55 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Add LOC paramter, GSR;
//    06/16/05 - Add all input to O_tmp block. (CR 209257).
//    07/22/05 - Remove global PRLD signal (CR211419).
//    09/21/05 - Fixed GSR, SET and RST. (CR 214953)
//    07/17/06 - Add XON MSGON to support asynchronous reg (CR 234530).
//    04/17/08 - Add negative setup/hold support (CR472013)
//    01/19/09 - Add pulse width check for CLK low  time (CR503948)
//    03/30/09 - Add negative recrem  support (CR516975)
// End Revision

`timescale 1 ps/1 ps
 
module X_LATCHE (O, CLK, GE, I, RST, SET);

  parameter INIT = 1'b0;
  parameter LOC = "UNPLACED";
  parameter XON = "TRUE";
  parameter MSGON = "TRUE";

  output O;
  input CLK, GE, I, RST, SET;

  wire CLK_dly, I_dly, GE_dly;
  wire RST_dly, SET_dly;
  wire nrst, nset, ngsr, in_out;
  wire in_clk_enable, ge_clk_enable, rst_clk_enable, set_clk_enable;
  wire in_clk_enable1, ge_clk_enable1, rst_clk_enable1, set_clk_enable1;
  wire o_out;
  reg o_reg = INIT;
  reg rst_int, set_int;
  reg notifier;
  wire notifier1;

  tri0 GSR = glbl.GSR;

  buf O1 (O, o_reg);
    
  always @(GSR or SET_dly or RST_dly) begin
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
	  rst_int = RST_dly;
	  set_int = SET_dly;
      end
  end // always @ (GSR or SET or RST)
    
  always @(o_out)
      o_reg = o_out;

  not (nrst, RST_dly);
  not (nset, SET_dly);
  not (ngsr, GSR);
  xor (in_out, I_dly, O);

  and (in_clk_enable, ngsr, nrst, nset, GE_dly);
  and (ge_clk_enable, ngsr, nrst, nset, in_out);
  and (rst_clk_enable, ngsr, GE_dly);
  and (set_clk_enable, ngsr, nrst, GE_dly);

  assign notifier1 = (XON == "FALSE") ?  1'bx : notifier;
  assign ge_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : ge_clk_enable; 
  assign in_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : in_clk_enable;
  assign rst_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : rst_clk_enable; 
  assign set_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : set_clk_enable;

  latchsre (o_out, CLK_dly, I_dly, set_int, rst_int, GE_dly, notifier1);

  specify

	(I => O) = (100:100:100, 100:100:100);
	(CLK => O) = (100:100:100, 100:100:100);
	(GE => O) = (100:100:100, 100:100:100);
	(SET => O) = (0:0:0, 0:0:0);
	(RST => O) = (0:0:0, 0:0:0);

	$setuphold (negedge CLK, posedge GE &&& ge_clk_enable1, 0:0:0, 0:0:0, notifier,,, CLK_dly, GE_dly);
	$setuphold (negedge CLK, negedge GE &&& ge_clk_enable1, 0:0:0, 0:0:0, notifier,,, CLK_dly, GE_dly);
	$setuphold (negedge CLK, posedge I &&& in_clk_enable1, 0:0:0, 0:0:0, notifier,,, CLK_dly, I_dly);
	$setuphold (negedge CLK, negedge I &&& in_clk_enable1, 0:0:0, 0:0:0, notifier,,, CLK_dly, I_dly);

	$recrem (negedge RST, negedge CLK &&& rst_clk_enable1, 0:0:0, 0:0:0, notifier,,,RST_dly,CLK_dly);
	$recrem (negedge SET, negedge CLK &&& set_clk_enable1, 0:0:0, 0:0:0, notifier,,,SET_dly,CLK_dly);

	$width (posedge CLK, 0:0:0, 0, notifier);
	$width (negedge CLK, 0:0:0, 0, notifier);
	$width (posedge GE, 0:0:0, 0, notifier);
	$width (posedge RST, 0:0:0, 0, notifier);
	$width (posedge SET, 0:0:0, 0, notifier);

	specparam PATHPULSE$ = 0;

  endspecify

endmodule


primitive latchsre (q, clk, d, set, rst, ge, notifier);

  output q; reg q;
  input clk, d, set, rst, ge, notifier;

  table

    //   clk    d   set   rst   ge  notifier   q     q+;

          1     0    0     0    1      ?   :   ?  :  0;
          1     1    0     0    1      ?   :   ?  :  1;

          0     ?    0     0    ?      ?   :   ?  :  -;
          ?     ?    0     0    0      ?   :   ?  :  -;
          ?     0    0     ?    ?      ?   :   0  :  -;
          ?     1    ?     0    ?      ?   :   1  :  -;

          ?     ?    1     0    ?      ?   :   ?  :  1;
          ?     ?    ?     1    ?      ?   :   ?  :  0;
          0     ?    0     x    ?      ?   :   0  :  0;
          ?     ?    0     x    0      ?   :   0  :  0;
          1     0    0     x    1      ?   :   ?  :  0;
          0     ?    x     0    ?      ?   :   1  :  1;
          ?     ?    x     0    0      ?   :   1  :  1;
          1     1    x     0    1      ?   :   ?  :  1;
          ?     ?    ?     ?    ?      *   :   ?  :  x;

  endtable

endprimitive
