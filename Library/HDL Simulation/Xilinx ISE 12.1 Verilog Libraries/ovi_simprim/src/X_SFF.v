// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_SFF.v,v 1.17 2009/08/22 00:02:08 harikr Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2005 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.i (L.43)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  
// /___/   /\     Filename : X_SFF.v
// \   \  /  \    Timestamp : Thu Mar 11 16:44:05 PST 2005
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Added LOC parameter, global GSR signal and its functionality, and initialized outpus.
//    03/18/05 - Added global PRLD signal.
//    05/09/05 - Fixed X_SFF table for CR#206720
//    07/22/05 - Remove global PRLD signal (CR211419).
//    07/05/06 - Change order of rst_int and set_int (CR212994).
//    07/17/06 - Disable timing check when GSR =1 (CR 218959).
//    07/17/06 - Add XON MSGON to support asynchronous reg.( 234530)
//    04/17/08 - Add negative setup/hold support (CR472013)
//    12/19/09 - Add pulse width check (CR501467)
//    03/30/09 - Add negative recrem  support (CR516975)
//    05/08/09 - fix bug in _clk_enable AND list (CR500591).
// End Revision

`timescale 1 ps/1 ps
 
module X_SFF (O, CE, CLK, I, RST, SET, SRST, SSET);

  parameter INIT = 1'b0;
  parameter LOC = "UNPLACED";
  parameter XON = "TRUE";
  parameter MSGON = "TRUE";
    
  output O;
  input CE, CLK, I, RST, SET, SRST, SSET;

  tri0 GSR = glbl.GSR;
    
  wire CE_dly, CLK_dly, I_dly, SRST_dly, SSET_dly;
  wire RST_dly, SET_dly;
  wire ngsr, ni, nrst, nset, nsrst, nsset, in_out;
  wire in_clk_enable, ce_clk_enable, rst_clk_enable, set_clk_enable;
  wire in_clk_enable1, ce_clk_enable1, rst_clk_enable1, set_clk_enable1;
  wire srst_clk_enable, sset_clk_enable;
  wire srst_clk_enable1, sset_clk_enable1;
  wire o_out;
  reg notifier;
  wire notifier1;
  reg o_reg = INIT;
  reg rst_int, set_int;

  buf O1 (O, o_reg);
    
  not (ngsr, GSR);
  not (ni, I_dly);
  not (nrst, RST_dly);
  not (nset, SET_dly);
  not (nsrst, SRST_dly);
  not (nsset, SSET_dly);
  xor (in_out, I_dly, O);
  
  and (in_clk_enable, ngsr, nrst, nset, nsrst, nsset, CE_dly);
  and (ce_clk_enable, ngsr, nrst, nset, nsrst, nsset, in_out);
  and (rst_clk_enable, ngsr);
  and (set_clk_enable, ngsr, nrst);
  and (srst_clk_enable, ngsr, nrst, nset);
  and (sset_clk_enable, ngsr, nrst, nset, nsrst);    

  assign notifier1 = (XON == "FALSE") ?  1'bx : notifier;
  assign ce_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : ce_clk_enable; 
  assign in_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : in_clk_enable;
  assign rst_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : rst_clk_enable; 
  assign set_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : set_clk_enable;
  assign srst_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : srst_clk_enable; 
  assign sset_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : sset_clk_enable;

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

  sffsrce (o_out, CLK_dly, I_dly, CE_dly, set_int, rst_int, SSET_dly, SRST_dly, notifier1);
    

  specify

	(CLK => O) = (100:100:100, 100:100:100);
	(SET => O) = (0:0:0, 0:0:0);
	(RST => O) = (0:0:0, 0:0:0);

	$setuphold (posedge CLK, posedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,, CLK_dly,  CE_dly);
	$setuphold (posedge CLK, negedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,, CLK_dly,  CE_dly);
	$setuphold (posedge CLK, posedge I &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,, CLK_dly, I_dly);
	$setuphold (posedge CLK, negedge I &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,, CLK_dly, I_dly);
	$setuphold (posedge CLK, posedge SRST &&& (srst_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,, CLK_dly, SRST_dly);
	$setuphold (posedge CLK, negedge SRST &&& (srst_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,, CLK_dly, SRST_dly);
	$setuphold (posedge CLK, posedge SSET &&& (sset_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,, CLK_dly, SSET_dly);
	$setuphold (posedge CLK, negedge SSET &&& (sset_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,, CLK_dly, SSET_dly);

	$recrem (negedge RST, posedge CLK &&& (rst_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,, RST_dly, CLK_dly);
	$recrem (negedge SET, posedge CLK &&& (set_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,, SET_dly, CLK_dly);

	$period (posedge CLK, 0:0:0, notifier);
   $width (posedge CLK &&& CE, 0:0:0, 0, notifier);
   $width (negedge CLK &&& CE, 0:0:0, 0, notifier);
	$width (posedge RST, 0:0:0, 0, notifier);
	$width (posedge SET, 0:0:0, 0, notifier);

	specparam PATHPULSE$ = 0;

  endspecify

endmodule


primitive sffsrce (q, clk, d, ce, set, rst, sset, srst, notifier);

  output q; reg q;
  input clk, d, ce, set, rst, sset, srst, notifier;

  table

    //   clk    d     ce   set   rst  sset srst notifier   q     q+;

          ?     ?     ?     1     0    ?    ?      ?   :   ?  :  1;
          ?     ?     ?     ?     1    ?    ?      ?   :   ?  :  0;

         (01)   ?     ?     0     0    ?    1      ?   :   ?  :  0;
         (01)   ?     ?     0     0    1    0      ?   :   ?  :  1;
         (x1)   ?     ?     0     0    ?    1      ?   :   0  :  0;
         (x1)   ?     ?     0     0    ?    1      ?   :   1  :  x;
         (x1)   ?     ?     0     0    1    0      ?   :   1  :  1;
         (x1)   ?     ?     0     0    1    0      ?   :   0  :  x;
         (0x)   ?     ?     0     0    ?    1      ?   :   0  :  0;
         (0x)   ?     ?     0     0    ?    1      ?   :   1  :  x;
         (0x)   ?     ?     0     0    1    0      ?   :   1  :  1;
         (0x)   ?     ?     0     0    1    0      ?   :   0  :  x;

         (01)   0     1     0     0    0    0      ?   :   ?  :  0;
         (01)   1     1     0     0    0    0      ?   :   ?  :  1;
         (01)   x     1     0     0    0    0      ?   :   ?  :  x;
         (01)   0     x     0     0    0    0      ?   :   0  :  0;
         (01)   1     x     0     0    0    0      ?   :   1  :  1;

         (??)   ?     0     0     0    0    0      ?   :   ?  :  -;
         (1?)   ?     ?     0     0    ?    ?      ?   :   ?  :  -;
         (?0)   ?     ?     0     0    ?    ?      ?   :   ?  :  -;

         (01)   ?     0     0     0    0    x      ?   :   0  :  0;
         (01)   0     1     0     0    0    x      ?   :   ?  :  0;
         (01)   ?     0     0     0    x    0      ?   :   1  :  1;
         (01)   1     1     0     0    x    0      ?   :   ?  :  1;

         (?1)   ?     0     0     0    0    x      ?   :   0  :  0;
         (?1)   ?     0     0     0    x    0      ?   :   1  :  1;
         (0?)   ?     0     0     0    0    x      ?   :   0  :  0;
         (0?)   ?     0     0     0    x    0      ?   :   1  :  1;

         (01)   0     ?     0     x    0    0      ?   :   0  :  0;
         (01)   ?     0     0     x    0    x      ?   :   0  :  0;
         (01)   0     ?     0     x    0    x      ?   :   0  :  0;
         (01)   ?     ?     0     x    ?    1      ?   :   ?  :  0;
         (01)   0     1     0     x    0    ?      ?   :   ?  :  0;

         (0?)   0     ?     0     x    0    0      ?   :   0  :  0;
         (0?)   ?     0     0     x    0    x      ?   :   0  :  0;
         (0?)   0     ?     0     x    0    x      ?   :   0  :  0;
         (0?)   ?     ?     0     x    ?    1      ?   :   0  :  0;
         (?1)   0     ?     0     x    0    0      ?   :   0  :  0;
         (?1)   ?     0     0     x    0    x      ?   :   0  :  0;
         (?1)   0     ?     0     x    0    x      ?   :   0  :  0;
         (?1)   ?     ?     0     x    ?    1      ?   :   0  :  0;

         (01)   1     ?     x     0    0    0      ?   :   1  :  1;
         (01)   ?     0     x     0    x    0      ?   :   1  :  1;
         (01)   1     ?     x     0    x    0      ?   :   1  :  1;
         (01)   ?     ?     x     0    1    0      ?   :   ?  :  1;
         (01)   1     1     x     0    ?    0      ?   :   ?  :  1;

         (0?)   1     ?     x     0    0    0      ?   :   1  :  1;
         (0?)   ?     0     x     0    x    0      ?   :   1  :  1;
         (0?)   1     ?     x     0    x    0      ?   :   1  :  1;
         (0?)   ?     ?     x     0    1    0      ?   :   1  :  1;
         (?1)   1     ?     x     0    0    0      ?   :   1  :  1;
         (?1)   ?     0     x     0    x    0      ?   :   1  :  1;
         (?1)   1     ?     x     0    x    0      ?   :   1  :  1;
         (?1)   ?     ?     x     0    1    0      ?   :   1  :  1;

          ?     ?     ?     0    (?x)  ?    ?      ?   :   0  :  0;
          ?     ?     ?    (?x)   0    ?    ?      ?   :   1  :  1;

         (?1)   1     ?     ?     0    ?    0      ?   :   1  :  1;
         (?1)   0     ?     0     ?    0    ?      ?   :   0  :  0;
         (0?)   1     ?     ?     0    ?    0      ?   :   1  :  1;
         (0?)   0     ?     0     ?    0    ?      ?   :   0  :  0;

          ?    (??)   ?     ?     ?    ?    ?      ?   :   ?  :  -;
          ?     ?    (??)   ?     ?    ?    ?      ?   :   ?  :  -;
          ?     ?     ?    (?0)   ?    ?    ?      ?   :   ?  :  -;
          ?     ?     ?     x    (?0)  ?    ?      ?   :   ?  :  x;
          ?     ?     ?     0    (?0)  ?    ?      ?   :   ?  :  -;
          ?     ?     ?     ?     ?   (??)  ?      ?   :   ?  :  -;
          ?     ?     ?     ?     ?    ?   (??)    ?   :   ?  :  -;

          ?     ?     ?     ?     ?    ?    ?      *   :   ?  :  x;

  endtable

endprimitive
