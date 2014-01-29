// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2005 by Lattice Semiconductor Corporation
// --------------------------------------------------------------------
//
//
//                     Lattice Semiconductor Corporation
//                     5555 NE Moore Court
//                     Hillsboro, OR 97214
//                     U.S.A.
//
//                     TEL: 1-800-Lattice  (USA and Canada)
//                          1-408-826-6000 (other locations)
//
//                     web: http://www.latticesemi.com/
//                     email: techsupport@latticesemi.com
//
// --------------------------------------------------------------------
//
// Simulation Library File for EC/XP
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mg/RCS/DQSBUFB.v,v 1.5 2005/06/29 20:55:54 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module DQSBUFB(DQSI,CLK,READ,DQSDEL,DQSO,DDRCLKPOL,DQSC,PRMBDET);
   input DQSI,CLK,READ,DQSDEL;
   output DQSO,DDRCLKPOL,DQSC,PRMBDET;

   parameter DEL_ADJ = "PLUS";
   parameter DEL_VAL = "0";

   reg DDRCLKPOL_int, CLKP;
   reg DQSO_int, DQSC_int, DQSO_int1, PRMBDET_int, DQSO_int0;
   wire DQSO_int2, DQSO_int3;
   realtime  quarter_period;
   realtime  clk_last_rising_edge;
   integer clk_rising_edge_count;
   wire DQSIB, CLKB, READB, DQSDELB;

   buf (DQSIB, DQSI);
   buf (CLKB, CLK);
   buf (READB, READ);
   buf (DQSDELB, DQSDEL);
   buf inst_buf0 (DDRCLKPOL, DDRCLKPOL_int);
   buf inst_buf1 (PRMBDET, PRMBDET_int);
   buf inst_buf2 (DQSO, DQSO_int2);
   buf inst_buf3 (DQSC, DQSC_int);

   nor inst0 (C, READB, A);
   nor inst1 (A, C, D);
   nor inst2 (B, D, E);
   nor inst3 (D, B, READB, PRMBDET_int);
   nor inst4 (E, C, PRMBDET_int);

   initial
   begin
     quarter_period = 0.0;
     clk_rising_edge_count = 0.0;
   end

   always @(DQSIB)
   begin
      if (DQSIB === 1'bX)
         PRMBDET_int <= 1'b1;
      else
         PRMBDET_int <= DQSIB;
   end

   always @(negedge D)
   begin
      DDRCLKPOL_int <= CLKB;
   end

   always @(CLKB or DDRCLKPOL_int)
   begin
      if (DDRCLKPOL_int == 1'b0)
         CLKP <= CLKB;
      else if (DDRCLKPOL_int == 1'b1)
         CLKP <= ~CLKB;
   end

   always @(posedge CLKB) 
   begin
      clk_rising_edge_count <= clk_rising_edge_count + 1;
      clk_last_rising_edge = $realtime;
   end

   always @(negedge CLKB) 
   begin
      if (clk_rising_edge_count >= 1)
         quarter_period = ($realtime - clk_last_rising_edge)/2;
   end

   always @(DQSIB, DQSDELB)
   begin
      if (DQSDELB == 1'b1)
        begin
          DQSO_int <= #(quarter_period - 0.8) DQSIB;
          DQSC_int <= DQSIB;
        end
      else
        begin
          DQSO_int <= 1'b0;
          DQSC_int <= 1'b0;
        end
   end

   always @(posedge DQSO_int or posedge CLKP)
   begin
      if (CLKP == 1'b1)
         DQSO_int1 <= 1'b0;
      else
         DQSO_int1 <= 1'b1;
   end 

   always @(DQSO_int)
   begin
      DQSO_int0 <= DQSO_int;
   end

   or inst5 (DQSO_int3, DQSO_int1, DQSO_int0);
   assign #0.8 DQSO_int2 = DQSO_int3; 
endmodule

`endcelldefine


