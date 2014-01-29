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
// Simulation Library File for ECP3
//
// $Header:  
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module DQSBUFF(DQSI, SCLK, READ, DQSDEL,  
               DQSW, DDRCLKPOL, PRMBDET, DATAVALID, ECLKDQSR, DQCLK1);

   input DQSI, SCLK, READ, DQSDEL;
   output DQSW, DDRCLKPOL, PRMBDET, DATAVALID, ECLKDQSR, DQCLK1;

   realtime quarter_period, clk_last_rising_edge;
   integer clk_rising_edge_count;
   wire DQSIB, SCLKB, READB, DQSDELB;
   reg CLKP, ECLKWB_int1, DQSO_int, DQSO_int1, DQSO_int0, DDRLAT_int0, DDRLAT_int1;
   reg ECLKWB_int, prmbdet_raw, prmbdet_clean, DDRCLKPOL_int1, ECLKB_int1;
   reg DATAVALID_int1, DATAVALID_int2, DATAVALID_int3, DATAVALID_int4;
   reg PRMBDET_int, DDRCLKPOL_int, DQSW_int, DATAVALID_int;
   reg DDRLAT_int, SCLKB_int1, ECLKDQSR_int;
   reg last_D;

   buf (DQSIB, DQSI);
   buf (SCLKB, SCLK);
   buf (READB, READ);
   buf (DQSDELB, DQSDEL);
   buf inst_buf0 (DDRCLKPOL, DDRCLKPOL_int);
   buf inst_buf1 (PRMBDET, PRMBDET_int);
   buf inst_buf2 (DQSW, DQSW_int);
   buf inst_buf4 (ECLKDQSR, ECLKDQSR_int);
   buf inst_buf5 (DATAVALID, DATAVALID_int);

initial
begin
   quarter_period = 0.0;
   clk_rising_edge_count = 0.0;
   PRMBDET_int = 1'b0;
   DDRCLKPOL_int = 1'b0;
   DQSW_int = 1'b0;
   DATAVALID_int = 1'b0;
   CLKP = 1'b0;
   DDRLAT_int = 1'b0;
   DDRLAT_int1 = 1'b0;
   DQSO_int = 1'b1;
   DQSO_int1 = 1'b1;
   DQSO_int0 = 1'b1;
   prmbdet_raw = 1'b0;
   ECLKDQSR_int = 1'b1;
   last_D = 1'b0;
end

   nor inst0 (C, READB, A);
   nor inst1 (A, C, D);
   nor inst2 (B, D, E);
   nor inst3 (D, B, READB, PRMBDET_int);
   nor inst4 (E, C, PRMBDET_int);

      function DataSame;
        input a, b;
        begin
          if (a === b)
            DataSame = a;
          else
            DataSame = 1'bx;
        end
      endfunction

   always @ ( D)
   begin
      last_D <= D;
   end

   always @(DQSIB)
   begin
      if (DQSIB === 1'bX)
         PRMBDET_int <= 1'b1;
      else
         PRMBDET_int <= DQSIB;
   end

   always @(D)
   begin
      if (D === 1'b0 && last_D === 1'b1)
      begin
         DDRCLKPOL_int <= SCLK;
      end
   end


   always @(SCLKB or DDRCLKPOL_int)
   begin
      if (DDRCLKPOL_int == 1'b0)
         CLKP <= SCLKB;
      else if (DDRCLKPOL_int == 1'b1)
         CLKP <= ~SCLKB;
   end


   always @(posedge SCLKB)
   begin
      clk_rising_edge_count <= clk_rising_edge_count + 1;
      clk_last_rising_edge = $realtime;
   end

   always @(negedge SCLKB)
   begin
      if (clk_rising_edge_count >= 1)
         quarter_period = ($realtime - clk_last_rising_edge)/2;
   end

   always @(DQSIB, DQSDELB, SCLKB)
   begin
      if (DQSDELB == 1'b1)
        begin
          DQSO_int <= #(quarter_period - 0.156) DQSIB;
          DQSW_int <= #quarter_period SCLKB;
        end
      else
        begin
          DQSO_int <= DQSIB;
          DQSW_int <= SCLKB;
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

   always @(DQSO_int3 or DQSDELB)
   begin
      if (DQSDELB == 1'b1)
         ECLKDQSR_int <= #0.156 DQSO_int3;
      else
         ECLKDQSR_int <= DQSO_int3;
   end

//   assign #0.156 ECLKDQSR_int = DQSO_int3;
   assign DQCLK1 = SCLKB;

   always @(posedge SCLKB or posedge D)
   begin
      if (D == 1'b1)
         DDRLAT_int0 <= 1'b1;
      else
         DDRLAT_int0 <= 1'b0;
   end

   always @(posedge SCLKB)
   begin
      if (DDRLAT_int0 == 1'b1)
         DDRLAT_int1 <= SCLKB;
   end

//   always @(posedge SCLKB)       DDRLAT_int is always 1'b0 in DDR-MEM and DDR2-MEM mode
//   begin
//      DDRLAT_int <= DDRLAT_int1;
//   end

//--------------- datavalid ----------

   always @(posedge PRMBDET_int or posedge READB)
   begin
      if (READB == 1'b1)
         prmbdet_raw <= 1'b0;
      else
         prmbdet_raw <= 1'b1;
   end

   assign reset_prmbdet_clean = ~ (prmbdet_raw | READB);

   always @(negedge ECLKDQSR_int or posedge reset_prmbdet_clean)
   begin
      if (reset_prmbdet_clean == 1'b1)
         prmbdet_clean <= 1'b0;
      else
         prmbdet_clean <= prmbdet_raw;
   end

   assign reset_data_valid_regs = ~prmbdet_clean & prmbdet_raw;

   always @(ECLKDQSR_int or DDRCLKPOL_int)     // negative latch
   begin
      if (ECLKDQSR_int == 1'b0)
         DDRCLKPOL_int1 <= DDRCLKPOL_int;
   end

   always @(DDRCLKPOL_int1 or SCLKB)
   begin
      if (DDRCLKPOL_int1 == 1'b0)
         SCLKB_int1 <= SCLKB;
      else
         SCLKB_int1 <= ~SCLKB;
   end


   always @(posedge SCLKB_int1 or posedge reset_data_valid_regs)
   begin
      if (reset_data_valid_regs == 1'b1)
         DATAVALID_int1 <= 1'b0;
      else
         DATAVALID_int1 <= prmbdet_clean;
   end

   always @(SCLKB or DATAVALID_int1)     // positive latch
   begin
      if (SCLKB == 1'b1)
         DATAVALID_int2 <= DATAVALID_int1;
   end

   always @(posedge SCLKB)
   begin
      DATAVALID_int3 <= DATAVALID_int2;
   end

   always @(DDRLAT_int or DATAVALID_int2 or DATAVALID_int3)
   begin
      if (DDRLAT_int == 1'b0)
         DATAVALID_int4 <= DATAVALID_int2;
      else
         DATAVALID_int4 <= DATAVALID_int3;
   end

   always @(posedge SCLKB)
   begin
      DATAVALID_int <= DATAVALID_int4;
   end



endmodule

`endcelldefine


