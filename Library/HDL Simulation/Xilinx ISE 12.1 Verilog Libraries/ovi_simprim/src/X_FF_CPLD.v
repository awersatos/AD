// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_FF_CPLD.v,v 1.2 2006/08/30 21:26:47 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2005 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 9.1i (J.27)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  D Flip-Flop with Asynchronous Clear and Preset and Clock Enable
// /___/   /\     Filename : X_FF_CPLD.v
// \   \  /  \    Timestamp : Thu Mar 11 16:43:55 PST 2005
//  \___\/\___\
//
// Revision:
//    08/09/06 - Initial version, Set has priority than RST.
//    08/30/06 - rename UDP name (CR 422696 ).
// End Revision

`timescale 1 ps/1 ps
 
module X_FF_CPLD (O, CE, CLK, I, RST, SET);

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

  buf O1 (O, o_reg);
    
  not (ni, I);
  not (nrst, RST);
  not (nset, SET);
  not (ngsr, GSR);
  xor (in_out, I, O);

  and (in_clk_enable, ngsr, nrst, nset, CE);
  and (ce_clk_enable, ngsr, nrst, nset, in_out);
  and (rst_clk_enable, ngsr, CE, I);
  and (set_clk_enable, ngsr, CE, nrst, ni);

  assign notifier1 = (XON == "FALSE") ?  1'bx : notifier;
  assign ce_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : ce_clk_enable; 
  assign in_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : in_clk_enable;
  assign rst_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : rst_clk_enable; 
  assign set_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : set_clk_enable;

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
  end

  always @(o_out)
      o_reg = o_out;
    
  ffsrcecpld (o_out, CLK, I, CE, set_int, rst_int, notifier1);

  specify

	(CLK => O) = (100:100:100, 100:100:100);
	(SET => O) = (0:0:0, 0:0:0);
	(RST => O) = (0:0:0, 0:0:0);

	$setuphold (posedge CLK, posedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier);
	$setuphold (posedge CLK, negedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier);
	$setuphold (posedge CLK, posedge I &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier);
	$setuphold (posedge CLK, negedge I &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier);

	$recrem (negedge RST, posedge CLK &&& (rst_clk_enable1!=0), 0:0:0, 0:0:0, notifier);
	$recrem (negedge SET, posedge CLK &&& (set_clk_enable1!=0), 0:0:0, 0:0:0, notifier);

	$period (posedge CLK &&& CE, 0:0:0, notifier);
	$width (posedge RST, 0:0:0, 0, notifier);
	$width (posedge SET, 0:0:0, 0, notifier);

	specparam PATHPULSE$ = 0;

  endspecify

endmodule


primitive ffsrcecpld (q, clk, d, ce, set, rst, notifier);

  output q; reg q;
  input clk, d, ce, set, rst, notifier;

  table

    //   clk    d     ce   set   rst   notifier    q     q+;

          ?     ?      ?    1     ?       ?    :   ?  :  1;
          ?     ?      ?    0     1       ?    :   ?  :  0;

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
