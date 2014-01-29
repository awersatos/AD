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
// Simulation Library File for ECP2
//
// $Header: /home/rlp/Orfdry/env_rcs/verilog/pkg/versclibs/data/ecp2/RCS/DQSBUFC.v,v 1.3 2005/08/30 19:36:26 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module DQSBUFC(DQSI,CLK,XCLK,READ,DQSDEL,DQSO,DDRCLKPOL,DQSC,PRMBDET, DQSXFER, DATAVALID);
   input DQSI,CLK,XCLK,READ,DQSDEL;
   output DQSO,DDRCLKPOL,DQSC,PRMBDET,DQSXFER, DATAVALID;

   parameter DQS_LI_DEL_ADJ = "PLUS";
   parameter DQS_LI_DEL_VAL = "4";
   parameter DQS_LO_DEL_ADJ = "PLUS";
   parameter DQS_LO_DEL_VAL = "4";

   wire DQSIB, CLKB, XCLKB, READB, DQSDELB;
   reg DDRCLKPOL_int, CLKP, DATAVALID_int;
   reg DQSO_int, DQSC_int, DQSO_int1, PRMBDET_int, DQSO_int0, DQSXFER_int;
   wire DQSO_int2, DQSO_int3;
   realtime  quarter_period, quarter_period_xclk;
   realtime  clk_last_rising_edge, clk_last_rising_edge_xclk;
   integer clk_rising_edge_count, clk_rising_edge_count_xclk;
   reg prmbdet_raw, prmbdet_clean, data_valid_pos, data_valid_neg1, data_valid_neg; 
   reg data_valid, pio_data_valid_un, re_detected_d;
   wire reset_data_valid_regs, reset_prmbdet_clean; 

   buf (DQSIB, DQSI);
   buf (CLKB, CLK);
   buf (XCLKB, XCLK);
   buf (READB, READ);
   buf (DQSDELB, DQSDEL);
   buf inst_buf0 (DDRCLKPOL, DDRCLKPOL_int);
   buf inst_buf1 (PRMBDET, PRMBDET_int);
   buf inst_buf2 (DQSO, DQSO_int2);
   buf inst_buf3 (DQSC, DQSC_int);
   buf inst_buf4 (DQSXFER, DQSXFER_int);
   buf inst_buf5 (DATAVALID, DATAVALID_int);

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

   initial
   begin
     re_detected_d = 1'b0;
     pio_data_valid_un = 1'b0;
     quarter_period = 0.0;
     clk_rising_edge_count = 0.0;
     quarter_period_xclk = 0.0;
     clk_rising_edge_count_xclk = 0.0;
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

   always @(posedge XCLKB)
   begin
      clk_rising_edge_count_xclk <= clk_rising_edge_count_xclk + 1;
      clk_last_rising_edge_xclk = $realtime;
   end

   always @(negedge XCLKB)
   begin
      if (clk_rising_edge_count_xclk >= 1)
         quarter_period_xclk = ($realtime - clk_last_rising_edge_xclk)/2;
   end

   always @(XCLKB)
   begin
      DQSXFER_int <= #(quarter_period_xclk) XCLKB;
   end

   always @(posedge PRMBDET_int or posedge READB) 
   begin
      if (READB == 1'b1)
         prmbdet_raw <= 1'b0;
      else
         prmbdet_raw <= 1'b1;
   end

assign reset_prmbdet_clean = ~ (prmbdet_raw | READB);

   always @(negedge DQSIB or posedge reset_prmbdet_clean)
   begin
      if (reset_prmbdet_clean == 1'b1)
         prmbdet_clean <= 1'b0;
      else
         prmbdet_clean <= prmbdet_raw;
   end

assign reset_data_valid_regs = ~prmbdet_clean & DQSIB;

   always @(posedge CLKB or posedge reset_data_valid_regs)
   begin
      if (reset_data_valid_regs == 1'b1)
      begin
         data_valid_pos <= 1'b0;
//         data_valid_neg1 <= 1'b0;
      end
      else
      begin
         data_valid_pos <= prmbdet_clean;
//         data_valid_neg1 <= data_valid_neg;
      end
   end

   always @(negedge CLKB or posedge reset_data_valid_regs)
   begin
      if (reset_data_valid_regs == 1'b1)
         data_valid_neg <= 1'b0;
      else
         data_valid_neg <= prmbdet_clean;
   end

   always @ (data_valid_neg or data_valid_pos or DDRCLKPOL_int)
   begin
      case (DDRCLKPOL_int)
           1'b0 :  data_valid = data_valid_pos;
           1'b1 :  data_valid = data_valid_neg;
           default data_valid = DataSame(data_valid_pos, data_valid_neg);
      endcase
   end

   always @(posedge CLKB)
   begin
//      re_detected_d <= data_valid;
      DATAVALID_int <= data_valid;
   end

//   always @ (data_valid or re_detected_d)
//   begin
//      pio_data_valid_un = data_valid & !re_detected_d;
//   end

endmodule

`endcelldefine


