// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_FF.v,v 1.16 2009/08/22 00:02:08 harikr Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2005 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.i (L.38)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  D Flip-Flop with Asynchronous Clear and Preset and Clock Enable
// /___/   /\     Filename : X_FF.v
// \   \  /  \    Timestamp : Thu Mar 11 16:43:55 PST 2005
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Added LOC parameter, global GSR signal and its functionality, and initialized outpus.
//    03/16/05 - Add XON MSGON to support asynchronous reg.
//    03/18/05 - Added global PRLD signal.
//    07/22/05 - Remove global PRLD signal (CR211419).
//    09/22/05 - Add GSR to timing check enable.  Fix I enable bug. (CR 217800)
//    07/05/06 - Change order of rst_int and set_int (CR212994).
//    07/19/06 - Add wire declaration for undeclared wire signals.
//    04/17/08 - Add negative setup/hold support (CR472013)
//    12/19/09 - Add pulse width check (CR501467)
//    03/30/09 - Add negative support for recrem (CR516975)
// End Revision

`timescale 1 ps/1 ps
 
module X_FF (O, CE, CLK, I, RST, SET);

  parameter INIT = 1'b0;
  parameter LOC = "UNPLACED";
  parameter XON = "TRUE";
  parameter MSGON = "TRUE";
    
  output O;
  input CE, CLK, I, RST, SET;

  tri0 GSR = glbl.GSR;
    
  wire ni, ngsr, nrst, nset, in_out;
  wire in_clk_enable, ce_clk_enable, rst_clk_enable, set_clk_enable;
  wire in_clk_enable1, ce_clk_enable1, rst_clk_enable1, set_clk_enable1;
  wire o_out;
  reg notifier;
  wire notifier1;
  reg o_reg = INIT;
  reg rst_int, set_int;
  wire I_dly, CLK_dly, CE_dly;
  wire RST_dly, SET_dly;

  buf O1 (O, o_reg);
    
  not (ni, I_dly);
  not (nrst, RST_dly);
  not (nset, SET_dly);
  not (ngsr, GSR);
  xor (in_out, I_dly, O);

  and (in_clk_enable, ngsr, nrst, nset, CE_dly);
  and (ce_clk_enable, ngsr, nrst, nset, in_out);
  and (rst_clk_enable, ngsr, CE_dly, I_dly);
  and (set_clk_enable, ngsr, CE_dly, nrst, ni);

  assign notifier1 = (XON == "FALSE") ?  1'bx : notifier;
  assign ce_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : ce_clk_enable; 
  assign in_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : in_clk_enable;
  assign rst_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : rst_clk_enable; 
  assign set_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : set_clk_enable;

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
	  set_int = SET_dly;
	  rst_int = RST_dly;
      end
  end

  always @(o_out)
      o_reg = o_out;
    
  ffsrce (o_out, CLK_dly, I_dly, CE_dly, set_int, rst_int, notifier1);

  specify

	(CLK => O) = (100:100:100, 100:100:100);
	(SET => O) = (0:0:0, 0:0:0);
	(RST => O) = (0:0:0, 0:0:0);

	$setuphold (posedge CLK, posedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,CLK_dly,CE_dly);
	$setuphold (posedge CLK, negedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,CLK_dly,CE_dly);
	$setuphold (posedge CLK, posedge I &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,CLK_dly,I_dly);
	$setuphold (posedge CLK, negedge I &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,CLK_dly,I_dly);

	$recrem (negedge RST, posedge CLK &&& (rst_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,RST_dly, CLK_dly);
	$recrem (negedge SET, posedge CLK &&& (set_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,SET_dly, CLK_dly);

	$period (posedge CLK &&& CE, 0:0:0, notifier);
	$width (posedge CLK &&& CE, 0:0:0, 0, notifier);
	$width (negedge CLK &&& CE, 0:0:0, 0, notifier);
	$width (posedge RST, 0:0:0, 0, notifier);
	$width (posedge SET, 0:0:0, 0, notifier);

	specparam PATHPULSE$ = 0;

  endspecify

endmodule


primitive ffsrce (q, clk, d, ce, set, rst, notifier);

  output q; reg q;
  input clk, d, ce, set, rst, notifier;

  table

    //   clk    d     ce   set   rst   notifier    q     q+;

          ?     ?      ?    1     0       ?    :   ?  :  1;
          ?     ?      ?    ?     1       ?    :   ?  :  0;

         (01)   0      1    0     0       ?    :   ?  :  0;
         (01)   1      1    0     0       ?    :   ?  :  1;
         (01)   x      1    0     0       ?    :   ?  :  x;
         (01)   0      x    0     0       ?    :   0  :  0;
         (01)   1      x    0     0       ?    :   1  :  1;

         (??)   ?      0    ?     ?       ?    :   ?  :  -;
         (1?)   ?      ?    ?     ?       ?    :   ?  :  -;
         (?0)   ?      ?    ?     ?       ?    :   ?  :  -;

         (01)   0      1    0     x       ?    :   ?  :  0;
         (01)   1      1    x     0       ?    :   ?  :  1;

          ?     ?      ?    0    (?x)     ?    :   0  :  0;
          ?     ?      ?   (?x)   0       ?    :   1  :  1;

         (?1)   1      ?    ?     0       ?    :   1  :  1;
         (?1)   0      ?    0     ?       ?    :   0  :  0;
         (0?)   1      ?    ?     0       ?    :   1  :  1;
         (0?)   0      ?    0     ?       ?    :   0  :  0;

          ?    (??)    ?    ?     ?       ?    :   ?  :  -;
          ?     ?    (??)   ?     ?       ?    :   ?  :  -;
          ?     ?      ?   (?0)   ?       ?    :   ?  :  -;

          ?     ?      ?    x    (?0)     ?    :   ?  :  x;
          ?     ?      ?    0    (?0)     ?    :   ?  :  -;

          ?     ?      ?    ?     ?       *    :   ?  :  x;

  endtable

endprimitive
