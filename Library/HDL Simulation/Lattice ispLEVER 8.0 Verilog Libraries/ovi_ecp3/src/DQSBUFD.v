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

module DQSBUFD(DQSI, SCLK, READ, ECLK, DQSDEL, ECLKW, RST, DYNDELPOL, DYNDELAY6, DYNDELAY5, DYNDELAY4,
               DYNDELAY3, DYNDELAY2, DYNDELAY1, DYNDELAY0, DQSW, DDRCLKPOL, PRMBDET, DATAVALID,
               DDRLAT, ECLKDQSR, DQCLK0, DQCLK1);
   input DQSI, SCLK, READ, DQSDEL, ECLK, ECLKW, RST;
   input DYNDELPOL, DYNDELAY6, DYNDELAY5, DYNDELAY4, DYNDELAY3, DYNDELAY2, DYNDELAY1, DYNDELAY0;
   output DQSW, DDRCLKPOL, PRMBDET, DATAVALID, DDRLAT, ECLKDQSR, DQCLK0, DQCLK1;

   parameter DYNDEL_TYPE = "NORMAL";
   parameter DYNDEL_VAL = 0;
   parameter DYNDEL_CNTL = "DYNAMIC";
   parameter NRZMODE = "DISABLED";

   realtime delta, cntl_delay, quarter_period, clk_last_rising_edge, eclk_quarter_period, eclk_last_rising_edge;
   integer DYNDELAY_int, clk_rising_edge_count, eclk_rising_edge_count;
   wire RSTB, DQSIB, SCLKB, ECLKB, ECLKWB, READB, DQSDELB, DYNDELPOLB;
   wire [6:0] DYNDELAYB;
   reg CLKP, ECLKWB_int1, DQSO_int, DQSO_int1, DQSO_int0, DDRLAT_int0, DDRLAT_int1;  
   reg ECLKWB_int, prmbdet_raw, prmbdet_clean, DDRCLKPOL_int1, ECLKB_int1;
   reg DATAVALID_int1, DATAVALID_int2, DATAVALID_int3, DATAVALID_int4;
   reg PRMBDET_int, DDRCLKPOL_int, DQSW_int, DDRLAT_int, DQCLK0_int, DATAVALID_int;
   reg DQCLK1_int, ECLKDQSR_int;
   reg last_D, last_DATAVALID_int5;
   reg DDRLAT_int01, DDRLAT_int2;
   wire lat1, lat2, lat3;
   reg mc1_nrz, DATAVALID_int_n, DATAVALID_int5, DATAVALID_int6;

   buf (RSTB, RST);
   buf (DQSIB, DQSI);
   buf (SCLKB, SCLK);
   buf (ECLKB, ECLK);
   buf (ECLKWB, ECLKW);
   buf (READB, READ);
   buf (DQSDELB, DQSDEL);
   buf (DYNDELPOLB, DYNDELPOL);
   buf (DYNDELAYB[6], DYNDELAY6);
   buf (DYNDELAYB[5], DYNDELAY5);
   buf (DYNDELAYB[4], DYNDELAY4);
   buf (DYNDELAYB[3], DYNDELAY3);
   buf (DYNDELAYB[2], DYNDELAY2);
   buf (DYNDELAYB[1], DYNDELAY1);
   buf (DYNDELAYB[0], DYNDELAY0);
   buf inst_buf0 (DDRCLKPOL, DDRCLKPOL_int);
   buf inst_buf1 (PRMBDET, PRMBDET_int);
   buf inst_buf2 (DQSW, DQSW_int);
   buf inst_buf3 (DDRLAT, DDRLAT_int);
   buf inst_buf4 (ECLKDQSR, ECLKDQSR_int);
   buf inst_buf5 (DATAVALID, DATAVALID_int);
   buf inst_buf6 (DQCLK0, DQCLK0_int);
   buf inst_buf7 (DQCLK1, DQCLK1_int);
   
initial
begin
   delta = 0.026;
   DYNDELAY_int = 0;
   cntl_delay = 0;
   quarter_period = 0.0;
   clk_rising_edge_count = 0.0;
   eclk_quarter_period = 0.0;
   eclk_rising_edge_count = 0.0;
   DQCLK1_int = 1'b1;
   DQCLK0_int = 1'b0;
   PRMBDET_int = 1'b0;
   DDRCLKPOL_int = 1'b0;
   DQSW_int = 1'b0;
   DDRLAT_int1 = 1'b0;
   DDRLAT_int2 = 1'b0;
   DDRLAT_int = 1'b0;
   DDRLAT_int0 = 1'b0;
   DDRLAT_int01 = 1'b0;
   DATAVALID_int = 1'b0;
   DATAVALID_int2 = 1'b0;
   DATAVALID_int3 = 1'b0;
   DATAVALID_int4 = 1'b0;
   DATAVALID_int5 = 1'b0;
   DATAVALID_int6 = 1'b0;
   DATAVALID_int_n = 1'b0;
   CLKP = 1'b0;
   ECLKWB_int1 = 1'b0;
   DQSO_int = 1'b0;
   DQSO_int1 = 1'b0;
   DQSO_int0 = 1'b0;
   ECLKDQSR_int = 1'b0;
   last_D = 1'b0;
   last_DATAVALID_int5 = 1'b0;

   if (NRZMODE == "DISABLED")
      mc1_nrz = 1'b0;
   else if (NRZMODE == "ENABLED")
      mc1_nrz = 1'b1;
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

   always @ (DATAVALID_int5)
   begin
      last_DATAVALID_int5 <= DATAVALID_int5;
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
         DDRCLKPOL_int <= ECLKB;
      end
   end

   always @(ECLKB or DDRCLKPOL_int)
   begin
      if (DDRCLKPOL_int == 1'b0)
         CLKP <= ECLKB;
      else if (DDRCLKPOL_int == 1'b1)
         CLKP <= ~ECLKB;
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

   always @(posedge ECLKB)
   begin
      eclk_rising_edge_count <= eclk_rising_edge_count + 1;
      eclk_last_rising_edge = $realtime;
   end

   always @(negedge ECLKB)
   begin
      if (eclk_rising_edge_count >= 1)
         eclk_quarter_period = ($realtime - eclk_last_rising_edge)/2;
   end

   always @(DQSIB, DQSDELB)
   begin
      if (DQSDELB == 1'b1)
        begin
          DQSO_int <= #(eclk_quarter_period - 0.156) DQSIB;   // cr42689
//          DQSO_int <= #(eclk_quarter_period) DQSIB;
        end
      else
        begin
          DQSO_int <= DQSIB;
        end
   end

   always @(DQSDELB, ECLKWB_int1)
   begin
      if (DQSDELB == 1'b1)
        begin
          DQSW_int <= #(eclk_quarter_period) ECLKWB_int1;
        end
      else
        begin
          DQSW_int <= ECLKWB_int1;
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

   assign #0.3 D_dly = D;     // delay is 300 ps 

   always @(posedge ECLKB or posedge D_dly)
   begin
      if (D_dly == 1'b1)
         DDRLAT_int0 <= 1'b1; 
      else
         DDRLAT_int0 <= 1'b0;
   end

   always @(ECLKB or posedge D_dly)  // pos latch
   begin
      if (D_dly == 1'b1)
         DDRLAT_int01 <= 1'b1;
      else if (ECLKB == 1'b1)
         DDRLAT_int01 <= 1'b0;
   end

   always @(DDRLAT_int0 or DDRLAT_int01 or DDRCLKPOL_int)  // pos latch
   begin
      if (DDRCLKPOL_int == 1'b1)
         DDRLAT_int1 <= DDRLAT_int0;
      else if (DDRCLKPOL_int == 1'b0)
         DDRLAT_int1 <= DDRLAT_int01;
   end

   always @(posedge ECLKB)
   begin
      if (DDRLAT_int1 == 1'b1)
         DDRLAT_int2 <= SCLKB;
   end

   always @(posedge ECLKB)
   begin
      if (DDRLAT_int1 == 1'b0)
         DDRLAT_int <= DDRLAT_int2;
   end

   always @(ECLKWB or DYNDELPOLB)
   begin
      if (DYNDELPOLB == 1'b0)
         ECLKWB_int <= ECLKWB;
      else if (DYNDELPOLB == 1'b1)
         ECLKWB_int <= ~ECLKWB;
   end

  always @(DYNDELAYB)
  begin
     DYNDELAY_int = DYNDELAYB;
  end

  always @(DYNDELAY_int)
  begin
        cntl_delay = (DYNDELAY_int * delta) + 0.140;
  end

  always @(ECLKWB_int or cntl_delay)
  begin
     ECLKWB_int1 <= #cntl_delay ECLKWB_int;
  end

  always @(negedge ECLKWB_int1 or posedge RSTB)
  begin
     if (RSTB == 1'b1)
        DQCLK0_int <= 1'b0;
     else
        DQCLK0_int <= ~DQCLK1_int;
  end

  always @(posedge ECLKWB_int1 or posedge RSTB)
  begin
     if (RSTB == 1'b1)
        DQCLK1_int <= 1'b1;
     else
        DQCLK1_int <= ~DQCLK1_int;
  end
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

   always @(DDRCLKPOL_int1 or ECLKB)
   begin
      if (DDRCLKPOL_int1 == 1'b0)
         ECLKB_int1 <= ECLKB;
      else
         ECLKB_int1 <= ~ECLKB;
   end

   always @(posedge ECLKB_int1 or posedge reset_data_valid_regs)
   begin
      if (reset_data_valid_regs == 1'b1)
         DATAVALID_int1 <= 1'b0;
      else
         DATAVALID_int1 <= prmbdet_clean;
   end

   always @(ECLKB or DATAVALID_int1)     // positive latch
   begin
      if (ECLKB == 1'b1)
         DATAVALID_int2 <= DATAVALID_int1;
   end

   always @(posedge ECLKB)
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

   always @(posedge SCLKB, posedge lat3)
   begin
      if (lat3 == 1'b1)
      begin
         DATAVALID_int5 <= 1'b0;
         DATAVALID_int_n <= 1'b1;
      end
      else
      begin
         DATAVALID_int5 <= DATAVALID_int4;
         DATAVALID_int_n <= ~DATAVALID_int4;
      end
   end
// new logic

   nor inst6 (lat1, DDRLAT_int, lat2);
   nor inst7 (lat2, DATAVALID_int_n, lat1);
   nor inst8 (lat3, DDRLAT_int, lat1, ~mc1_nrz);

   always @(DATAVALID_int5)
   begin
      if (DATAVALID_int5 === 1'b1 && last_DATAVALID_int5 === 1'b0)
         DATAVALID_int6 <= ~DATAVALID_int6;
   end

   always @(mc1_nrz or DATAVALID_int5 or DATAVALID_int6)
   begin
      if (mc1_nrz == 1'b0)
         DATAVALID_int <= DATAVALID_int5;
      else
         DATAVALID_int <= DATAVALID_int6;
   end


endmodule

`endcelldefine


