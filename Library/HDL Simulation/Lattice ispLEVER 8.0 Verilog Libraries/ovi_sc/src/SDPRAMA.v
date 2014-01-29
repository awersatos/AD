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
// Simulation Library File for SC
//
// $Header:
//
`timescale 1ns / 1ps

module SDPRAMA (M0, DPI, A0, B0, C0, D0, A1, B1, C1, D1, DI0, DI1, 
              CE, CLK, CLK2, LSR, F0, Q0, F1, Q1, DPO); 

input  M0, DPI, A0, B0, C0, D0, A1, B1, C1, D1, DI0, DI1;
input  CE, CLK, CLK2, LSR;
output F0, Q0, F1, Q1, DPO;

   parameter  GSR = "ENABLED";
   parameter  SRMODE = "ASYNC";    // "LSR_OVER_CE", "ASYNC"
   parameter  REGMODE = "FF";            // "FF", "LATCH"
   parameter  LSRMUX = "VLO";            // "SIG", "INV", "VLO", "VHI"
   parameter  CEMUX = "VLO";            // "SIG", "INV", "VLO", "VHI"
   parameter  CLKMUX = "VLO";            // "SIG", "INV", "VLO", "VHI"
   parameter  CLK2MUX = "VLO";            // "SIG", "INV", "VLO", "VHI"
   parameter  WCLKMUX = "CLKMUX";          // "CLKMUX", "CLK2MUX"
   parameter  RCLKMUX = "CLK2MUX";         // "CLKMUX", "CLK2MUX"
   parameter  REG1_REGSET = "RESET";     // "RESET", "SET"
   parameter  REG0_REGSET = "RESET";     // "RESET", "SET"
   parameter [63:0] initval = 64'h0000000000000000;

   parameter  XON = 1'b0;
   parameter  CHECK_DPI = 1'b0;
   parameter  CHECK_M0 = 1'b0;
   parameter  CHECK_A0 = 1'b0;
   parameter  CHECK_B0 = 1'b0;
   parameter  CHECK_C0 = 1'b0;
   parameter  CHECK_D0 = 1'b0;
   parameter  CHECK_A1 = 1'b0;
   parameter  CHECK_B1 = 1'b0;
   parameter  CHECK_C1 = 1'b0;
   parameter  CHECK_D1 = 1'b0;
   parameter  CHECK_DI1 = 1'b0;
   parameter  CHECK_DI0 = 1'b0;
   parameter  CHECK_CE = 1'b0;
   parameter  CHECK_LSR = 1'b0;

   wire check_dpi_posedge, check_m0_posedge, check_ce_posedge, check_lsr_posedge, check_di1_posedge, check_di0_posedge;
   wire check_a0_posedge, check_b0_posedge, check_c0_posedge, check_d0_posedge; 
   wire check_a1_posedge, check_b1_posedge, check_c1_posedge, check_d1_posedge;
   wire check_dpi_negedge, check_m0_negedge, check_ce_negedge, check_lsr_negedge, check_di1_negedge, check_di0_negedge;
   wire check_a0_negedge, check_b0_negedge, check_c0_negedge, check_d0_negedge; 
   wire check_a1_negedge, check_b1_negedge, check_c1_negedge, check_d1_negedge;
   wire check_dpi_posedge2, check_m0_posedge2, check_ce_posedge2, check_lsr_posedge2, check_di1_posedge2, check_di0_posedge2;
   wire check_a0_posedge2, check_b0_posedge2, check_c0_posedge2, check_d0_posedge2; 
   wire check_a1_posedge2, check_b1_posedge2, check_c1_posedge2, check_d1_posedge2;
   wire check_dpi_negedge2, check_m0_negedge2, check_ce_negedge2, check_lsr_negedge2, check_di1_negedge2, check_di0_negedge2;
   wire check_a0_negedge2, check_b0_negedge2, check_c0_negedge2, check_d0_negedge2; 
   wire check_a1_negedge2, check_b1_negedge2, check_c1_negedge2, check_d1_negedge2;
   wire wclk_eq_clk, wclk_eq_clk2, rclk_eq_clk, rclk_eq_clk2;
   wire SR1, SR, LSR_sig, CE_sig, CLK_sig, CLK2_sig, WCLK_sig, RCLK_sig;
   wire M0_dly, DPI_dly, WAD0_dly, WAD1_dly, WAD2_dly, WAD3_dly, RAD0_dly, RAD1_dly, RAD2_dly, RAD3_dly;
   wire LSR_dly, CE_dly, CLK_dly, CLK2_dly, DI1_dly, DI0_dly, DO0, DO1, QB0, QB1;
   reg SRN; 
   reg notifier_Q0, notifier_Q1, notify_DI1, notify_DI0;

   initial
   begin
      notify_DI1 = 0;
      notify_DI0 = 0;
      notifier_Q0 = 0;
      notifier_Q1 = 0;
   end

   always @ (notify_DI1)
   begin
      if (XON)
         notifier_Q1 = ~notifier_Q1;
   end

   always @ (notify_DI0)
   begin
      if (XON)
         notifier_Q0 = ~notifier_Q0;
   end

   wire check_di0 = CHECK_DI0;
   wire check_dpi = CHECK_DPI;
   wire check_m0 = CHECK_M0;
   wire check_a0 = CHECK_A0;
   wire check_b0 = CHECK_B0;
   wire check_c0 = CHECK_C0;
   wire check_d0 = CHECK_D0;
   wire check_a1 = CHECK_A1;
   wire check_b1 = CHECK_B1;
   wire check_c1 = CHECK_C1;
   wire check_d1 = CHECK_D1;
   wire check_di1 = CHECK_DI1;
   wire check_ce = CHECK_CE;
   wire check_lsr = CHECK_LSR;

   assign wclk_eq_clk = (WCLKMUX == "CLKMUX") ? 1'b1 : 1'b0;
   assign wclk_eq_clk2 = (WCLKMUX == "CLK2MUX") ? 1'b1 : 1'b0;
   assign rclk_eq_clk = (RCLKMUX == "CLKMUX") ? 1'b1 : 1'b0;
   assign rclk_eq_clk2 = (RCLKMUX == "CLK2MUX") ? 1'b1 : 1'b0;

/*
      function clkposedge;
        input a, b;
        begin
            clkposedge = a & ((b == "SIG") ? 1'b1 : 1'b0);
        end
      endfunction

      function clknegedge;
        input a, b;
        begin
            clknegedge = a & ((b == "INV") ? 1'b1 : 1'b0);
        end
      endfunction
*/

   assign check_di0_posedge = check_di0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_di0_negedge = check_di0 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_dpi_posedge = check_dpi & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_dpi_negedge = check_dpi & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_m0_posedge = check_m0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_m0_negedge = check_m0 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_a0_posedge = check_a0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_a0_negedge = check_a0 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_b0_posedge = check_b0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_b0_negedge = check_b0 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_c0_posedge = check_c0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_c0_negedge = check_c0 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_d0_posedge = check_d0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_d0_negedge = check_d0 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_a1_posedge = check_a1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_a1_negedge = check_a1 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_b1_posedge = check_b1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_b1_negedge = check_b1 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_c1_posedge = check_c1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_c1_negedge = check_c1 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_d1_posedge = check_d1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_d1_negedge = check_d1 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_di1_posedge = check_di1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_di1_negedge = check_di1 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_ce_posedge = check_ce & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ce_negedge = check_ce & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_lsr_posedge = check_lsr & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_lsr_negedge = check_lsr & ((CLKMUX == "INV") ? 1'b1 : 1'b0);

   assign check_di0_posedge2 = check_di0 & ((CLK2MUX == "SIG") ? 1'b1 : 1'b0);
   assign check_di0_negedge2 = check_di0 & ((CLK2MUX == "INV") ? 1'b1 : 1'b0);
   assign check_dpi_posedge2 = check_dpi & ((CLK2MUX == "SIG") ? 1'b1 : 1'b0);
   assign check_dpi_negedge2 = check_dpi & ((CLK2MUX == "INV") ? 1'b1 : 1'b0);
   assign check_m0_posedge2 = check_m0 & ((CLK2MUX == "SIG") ? 1'b1 : 1'b0);
   assign check_m0_negedge2 = check_m0 & ((CLK2MUX == "INV") ? 1'b1 : 1'b0);
   assign check_a0_posedge2 = check_a0 & ((CLK2MUX == "SIG") ? 1'b1 : 1'b0);
   assign check_a0_negedge2 = check_a0 & ((CLK2MUX == "INV") ? 1'b1 : 1'b0);
   assign check_b0_posedge2 = check_b0 & ((CLK2MUX == "SIG") ? 1'b1 : 1'b0);
   assign check_b0_negedge2 = check_b0 & ((CLK2MUX == "INV") ? 1'b1 : 1'b0);
   assign check_c0_posedge2 = check_c0 & ((CLK2MUX == "SIG") ? 1'b1 : 1'b0);
   assign check_c0_negedge2 = check_c0 & ((CLK2MUX == "INV") ? 1'b1 : 1'b0);
   assign check_d0_posedge2 = check_d0 & ((CLK2MUX == "SIG") ? 1'b1 : 1'b0);
   assign check_d0_negedge2 = check_d0 & ((CLK2MUX == "INV") ? 1'b1 : 1'b0);
   assign check_a1_posedge2 = check_a1 & ((CLK2MUX == "SIG") ? 1'b1 : 1'b0);
   assign check_a1_negedge2 = check_a1 & ((CLK2MUX == "INV") ? 1'b1 : 1'b0);
   assign check_b1_posedge2 = check_b1 & ((CLK2MUX == "SIG") ? 1'b1 : 1'b0);
   assign check_b1_negedge2 = check_b1 & ((CLK2MUX == "INV") ? 1'b1 : 1'b0);
   assign check_c1_posedge2 = check_c1 & ((CLK2MUX == "SIG") ? 1'b1 : 1'b0);
   assign check_c1_negedge2 = check_c1 & ((CLK2MUX == "INV") ? 1'b1 : 1'b0);
   assign check_d1_posedge2 = check_d1 & ((CLK2MUX == "SIG") ? 1'b1 : 1'b0);
   assign check_d1_negedge2 = check_d1 & ((CLK2MUX == "INV") ? 1'b1 : 1'b0);
   assign check_di1_posedge2 = check_di1 & ((CLK2MUX == "SIG") ? 1'b1 : 1'b0);
   assign check_di1_negedge2 = check_di1 & ((CLK2MUX == "INV") ? 1'b1 : 1'b0);
   assign check_ce_posedge2 = check_ce & ((CLK2MUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ce_negedge2 = check_ce & ((CLK2MUX == "INV") ? 1'b1 : 1'b0);
   assign check_lsr_posedge2 = check_lsr & ((CLK2MUX == "SIG") ? 1'b1 : 1'b0);
   assign check_lsr_negedge2 = check_lsr & ((CLK2MUX == "INV") ? 1'b1 : 1'b0);

/*
   assign check_dpi_posedge = clkposedge ((CHECK_DPI), (CLKMUX));
   assign check_m0_posedge = clkposedge ((CHECK_M0), (CLKMUX));
   assign check_di1_posedge = clkposedge ((CHECK_DI1), (CLKMUX));
   assign check_di0_posedge = clkposedge ((check_di0), (CLKMUX));
   assign check_ce_posedge = clkposedge ((CHECK_CE), (CLKMUX));
   assign check_lsr_posedge = clkposedge ((CHECK_LSR), (CLKMUX));
   assign check_a0_posedge = clkposedge ((CHECK_A0), (CLKMUX));
   assign check_b0_posedge = clkposedge ((CHECK_B0), (CLKMUX));
   assign check_c0_posedge = clkposedge ((CHECK_C0), (CLKMUX));
   assign check_d0_posedge = clkposedge ((CHECK_D0), (CLKMUX));
   assign check_a1_posedge = clkposedge ((CHECK_A1), (CLKMUX));
   assign check_b1_posedge = clkposedge ((CHECK_B1), (CLKMUX));
   assign check_c1_posedge = clkposedge ((CHECK_C1), (CLKMUX));
   assign check_d1_posedge = clkposedge ((CHECK_D1), (CLKMUX));

   assign check_dpi_negedge = clknegedge ((CHECK_DPI), (CLKMUX));
   assign check_m0_negedge = clknegedge ((CHECK_M0), (CLKMUX));
   assign check_di1_negedge = clknegedge ((CHECK_DI1), (CLKMUX));
   assign check_di0_negedge = clknegedge ((CHECK_DI0), (CLKMUX));
   assign check_ce_negedge = clknegedge ((CHECK_CE), (CLKMUX));
   assign check_lsr_negedge = clknegedge ((CHECK_LSR), (CLKMUX));
   assign check_a0_negedge = clknegedge ((CHECK_A0), (CLKMUX));
   assign check_b0_negedge = clknegedge ((CHECK_B0), (CLKMUX));
   assign check_c0_negedge = clknegedge ((CHECK_C0), (CLKMUX));
   assign check_d0_negedge = clknegedge ((CHECK_D0), (CLKMUX));
   assign check_a1_negedge = clknegedge ((CHECK_A1), (CLKMUX));
   assign check_b1_negedge = clknegedge ((CHECK_B1), (CLKMUX));
   assign check_c1_negedge = clknegedge ((CHECK_C1), (CLKMUX));
   assign check_d1_negedge = clknegedge ((CHECK_D1), (CLKMUX));

   assign check_dpi_posedge = CHECK_DPI & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_m0_posedge = CHECK_M0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_di1_posedge = CHECK_DI1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_di0_posedge = CHECK_DI0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ce_posedge = CHECK_CE & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_lsr_posedge = CHECK_LSR & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_a0_posedge = CHECK_A0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_b0_posedge = CHECK_B0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_c0_posedge = CHECK_C0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_d0_posedge = CHECK_D0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_a1_posedge = CHECK_A1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_b1_posedge = CHECK_B1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_c1_posedge = CHECK_C1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_d1_posedge = CHECK_D1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);

   assign check_dpi_negedge = CHECK_DPI & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_m0_negedge = CHECK_M0 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_di1_negedge = CHECK_DI1 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_di0_negedge = CHECK_DI0 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_ce_negedge = CHECK_CE & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_lsr_negedge = CHECK_LSR & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_a0_negedge = CHECK_A0 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_b0_negedge = CHECK_B0 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_c0_negedge = CHECK_C0 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_d0_negedge = CHECK_D0 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_a1_negedge = CHECK_A1 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_b1_negedge = CHECK_B1 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_c1_negedge = CHECK_C1 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_d1_negedge = CHECK_D1 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
*/
   buf (F1, DO1);
   buf (F0, DO0);
   buf (Q0, QB0);
   buf (Q1, QB1);
   buf (DPO, DPI_dly);
//   buf (DI0_dly, DI0);
//   buf (DI1_dly, DI1);

  tri1 GSR_sig = GSR_INST.GSRNET;
  tri1 PUR_sig = PUR_INST.PURNET;

  always @ (GSR_sig or PUR_sig ) begin
    if (GSR == "ENABLED") begin
      SRN = GSR_sig & PUR_sig ;
    end
    else if (GSR == "DISABLED")
      SRN = PUR_sig;
  end

  not (SR1, SRN);
  or INST1 (SR, LSR_sig, SR1);

   assign LSR_sig = (LSRMUX == "SIG") ? LSR_dly : (LSRMUX == "INV") ? ~LSR_dly : (LSRMUX == "VHI") ? 1'b1 : 1'b0;
   assign CE_sig = (CEMUX == "SIG") ? CE_dly : (CEMUX == "INV") ? ~CE_dly : (CEMUX == "VHI") ? 1'b1 : 1'b0;
   assign CLK_sig = (CLKMUX == "SIG") ? CLK_dly : (CLKMUX == "INV") ? ~CLK_dly : (CLKMUX == "VHI") ? 1'b1 : 1'b0;
   assign CLK2_sig = (CLK2MUX == "SIG") ? CLK2_dly : (CLK2MUX == "INV") ? ~CLK2_dly : (CLK2MUX == "VHI") ? 1'b1 : 1'b0;

   assign WCLK_sig = (WCLKMUX == "CLKMUX") ? CLK_sig : CLK2_sig;
   assign RCLK_sig = (RCLKMUX == "CLKMUX") ? CLK_sig : CLK2_sig;

   defparam DPR16X2_INST.initval = initval;

   DPR16X2 DPR16X2_INST (.DI0(M0_dly), 
                         .DI1(1'b0), 
                         .WAD0(WAD0_dly), 
                         .WAD1(WAD1_dly), 
                         .WAD2(WAD2_dly), 
                         .WAD3(WAD3_dly), 
                         .WRE(CE_sig), 
                         .WPE(LSR_sig),
                         .WCK(WCLK_sig), 
                         .RAD0(RAD0_dly), 
                         .RAD1(RAD1_dly), 
                         .RAD2(RAD2_dly), 
                         .RAD3(RAD3_dly), 
                         .WDO0(DO0), 
                         .RDO0(DO1),
                         .WDO1(),
                         .RDO1());


  generate
        if (REGMODE == "FF" && REG0_REGSET == "RESET")
        begin
           UDFDL5E_UDP_X INST6 (QB0, DI0_dly, RCLK_sig, 1'b1, SR1, notifier_Q0);
        end
        if (REGMODE == "FF" && REG0_REGSET == "SET")
        begin
           UDFDL7E_UDP_X INST7 (QB0, DI0_dly, RCLK_sig, 1'b1, SR1, notifier_Q0);
        end

        if (REGMODE == "FF" && REG1_REGSET == "RESET")
        begin
           UDFDL5E_UDP_X INST8 (QB1, DI1_dly, RCLK_sig, 1'b1, SR1, notifier_Q1);
        end
        if (REGMODE == "FF" && REG1_REGSET == "SET")
        begin
           UDFDL7E_UDP_X INST9 (QB1, DI1_dly, RCLK_sig, 1'b1, SR1, notifier_Q1);
        end
        
        if (REGMODE == "LATCH" && REG0_REGSET == "RESET")
        begin
           UDFDL4E_UDP_X INST10 (QB0, DI0_dly, RCLK_sig, 1'b1, SR1, notifier_Q0);
        end
        if (REGMODE == "LATCH" && REG0_REGSET == "SET")
        begin
           UDFDL6E_UDP_X INST11 (QB0, DI0_dly, RCLK_sig, 1'b1, SR1, notifier_Q0);
        end

        if (REGMODE == "LATCH" && REG1_REGSET == "RESET")
        begin
           UDFDL4E_UDP_X INST12 (QB1, DI1_dly, RCLK_sig, 1'b1, SR1, notifier_Q1);
        end
        if (REGMODE == "LATCH" && REG1_REGSET == "SET")
        begin
           UDFDL6E_UDP_X INST13 (QB1, DI1_dly, RCLK_sig, 1'b1, SR1, notifier_Q1);
        end

  endgenerate

   wire rclk_eq_clk_and_check_di0_posedge = (rclk_eq_clk & check_di0_posedge);
   wire rclk_eq_clk_and_check_di1_posedge = (rclk_eq_clk & check_di1_posedge);
   wire rclk_eq_clk_and_check_di0_negedge = (rclk_eq_clk & check_di0_negedge);
   wire rclk_eq_clk_and_check_di1_negedge = (rclk_eq_clk & check_di1_negedge);

   wire rclk_eq_clk2_and_check_di0_posedge2 = (rclk_eq_clk2 & check_di0_posedge2);
   wire rclk_eq_clk2_and_check_di1_posedge2 = (rclk_eq_clk2 & check_di1_posedge2);
   wire rclk_eq_clk2_and_check_di0_negedge2 = (rclk_eq_clk2 & check_di0_negedge2);
   wire rclk_eq_clk2_and_check_di1_negedge2 = (rclk_eq_clk2 & check_di1_negedge2);

   wire wclk_eq_clk_and_check_m0_posedge = (wclk_eq_clk & check_m0_posedge);
   wire wclk_eq_clk_and_check_dpi_posedge = (wclk_eq_clk & check_dpi_posedge);
   wire wclk_eq_clk_and_check_ce_posedge = (wclk_eq_clk & check_ce_posedge);
   wire wclk_eq_clk_and_check_lsr_posedge = (wclk_eq_clk & check_lsr_posedge);
   wire wclk_eq_clk_and_check_a0_posedge = (wclk_eq_clk & check_a0_posedge);
   wire wclk_eq_clk_and_check_b0_posedge = (wclk_eq_clk & check_b0_posedge);
   wire wclk_eq_clk_and_check_c0_posedge = (wclk_eq_clk & check_c0_posedge);
   wire wclk_eq_clk_and_check_d0_posedge = (wclk_eq_clk & check_d0_posedge);
   wire wclk_eq_clk_and_check_a1_posedge = (wclk_eq_clk & check_a1_posedge);
   wire wclk_eq_clk_and_check_b1_posedge = (wclk_eq_clk & check_b1_posedge);
   wire wclk_eq_clk_and_check_c1_posedge = (wclk_eq_clk & check_c1_posedge);
   wire wclk_eq_clk_and_check_d1_posedge = (wclk_eq_clk & check_d1_posedge);
   wire wclk_eq_clk_and_check_m0_negedge = (wclk_eq_clk & check_m0_negedge);
   wire wclk_eq_clk_and_check_dpi_negedge = (wclk_eq_clk & check_dpi_negedge);
   wire wclk_eq_clk_and_check_ce_negedge = (wclk_eq_clk & check_ce_negedge);
   wire wclk_eq_clk_and_check_lsr_negedge = (wclk_eq_clk & check_lsr_negedge);
   wire wclk_eq_clk_and_check_a0_negedge = (wclk_eq_clk & check_a0_negedge);
   wire wclk_eq_clk_and_check_b0_negedge = (wclk_eq_clk & check_b0_negedge);
   wire wclk_eq_clk_and_check_c0_negedge = (wclk_eq_clk & check_c0_negedge);
   wire wclk_eq_clk_and_check_d0_negedge = (wclk_eq_clk & check_d0_negedge);
   wire wclk_eq_clk_and_check_a1_negedge = (wclk_eq_clk & check_a1_negedge);
   wire wclk_eq_clk_and_check_b1_negedge = (wclk_eq_clk & check_b1_negedge);
   wire wclk_eq_clk_and_check_c1_negedge = (wclk_eq_clk & check_c1_negedge);
   wire wclk_eq_clk_and_check_d1_negedge = (wclk_eq_clk & check_d1_negedge);

   wire wclk_eq_clk2_and_check_m0_posedge2 = (wclk_eq_clk2 & check_m0_posedge2);
   wire wclk_eq_clk2_and_check_dpi_posedge2 = (wclk_eq_clk2 & check_dpi_posedge2);
   wire wclk_eq_clk2_and_check_ce_posedge2 = (wclk_eq_clk2 & check_ce_posedge2);
   wire wclk_eq_clk2_and_check_lsr_posedge2 = (wclk_eq_clk2 & check_lsr_posedge2);
   wire wclk_eq_clk2_and_check_a0_posedge2 = (wclk_eq_clk2 & check_a0_posedge2);
   wire wclk_eq_clk2_and_check_b0_posedge2 = (wclk_eq_clk2 & check_b0_posedge2);
   wire wclk_eq_clk2_and_check_c0_posedge2 = (wclk_eq_clk2 & check_c0_posedge2);
   wire wclk_eq_clk2_and_check_d0_posedge2 = (wclk_eq_clk2 & check_d0_posedge2);
   wire wclk_eq_clk2_and_check_a1_posedge2 = (wclk_eq_clk2 & check_a1_posedge2);
   wire wclk_eq_clk2_and_check_b1_posedge2 = (wclk_eq_clk2 & check_b1_posedge2);
   wire wclk_eq_clk2_and_check_c1_posedge2 = (wclk_eq_clk2 & check_c1_posedge2);
   wire wclk_eq_clk2_and_check_d1_posedge2 = (wclk_eq_clk2 & check_d1_posedge2);
   wire wclk_eq_clk2_and_check_m0_negedge2 = (wclk_eq_clk2 & check_m0_negedge2);
   wire wclk_eq_clk2_and_check_dpi_negedge2 = (wclk_eq_clk2 & check_dpi_negedge2);
   wire wclk_eq_clk2_and_check_ce_negedge2 = (wclk_eq_clk2 & check_ce_negedge2);
   wire wclk_eq_clk2_and_check_lsr_negedge2 = (wclk_eq_clk2 & check_lsr_negedge2);
   wire wclk_eq_clk2_and_check_a0_negedge2 = (wclk_eq_clk2 & check_a0_negedge2);
   wire wclk_eq_clk2_and_check_b0_negedge2 = (wclk_eq_clk2 & check_b0_negedge2);
   wire wclk_eq_clk2_and_check_c0_negedge2 = (wclk_eq_clk2 & check_c0_negedge2);
   wire wclk_eq_clk2_and_check_d0_negedge2 = (wclk_eq_clk2 & check_d0_negedge2);
   wire wclk_eq_clk2_and_check_a1_negedge2 = (wclk_eq_clk2 & check_a1_negedge2);
   wire wclk_eq_clk2_and_check_b1_negedge2 = (wclk_eq_clk2 & check_b1_negedge2);
   wire wclk_eq_clk2_and_check_c1_negedge2 = (wclk_eq_clk2 & check_c1_negedge2);
   wire wclk_eq_clk2_and_check_d1_negedge2 = (wclk_eq_clk2 & check_d1_negedge2);

   specify
      (CLK => Q0) = (0:0:0,0:0:0);
      (CLK => Q1) = (0:0:0,0:0:0);
      (CLK2 => Q0) = (0:0:0,0:0:0);
      (CLK2 => Q1) = (0:0:0,0:0:0);
      (DPI => DPO) = (0:0:0,0:0:0);
      (M0 => F1) = (0:0:0,0:0:0);
      (A0 => F1) = (0:0:0,0:0:0);
      (B0 => F1) = (0:0:0,0:0:0);
      (C0 => F1) = (0:0:0,0:0:0);
      (D0 => F1) = (0:0:0,0:0:0);
      (A1 => F1) = (0:0:0,0:0:0);
      (B1 => F1) = (0:0:0,0:0:0);
      (C1 => F1) = (0:0:0,0:0:0);
      (D1 => F1) = (0:0:0,0:0:0);
      (CE => F1) = (0:0:0,0:0:0);
      (LSR => F1) = (0:0:0,0:0:0);
      (CLK => F1) = (0:0:0,0:0:0);
      (CLK2 => F1) = (0:0:0,0:0:0);
      (M0 => F0) = (0:0:0,0:0:0);
      (A0 => F0) = (0:0:0,0:0:0);
      (B0 => F0) = (0:0:0,0:0:0);
      (C0 => F0) = (0:0:0,0:0:0);
      (D0 => F0) = (0:0:0,0:0:0);
      (A1 => F0) = (0:0:0,0:0:0);
      (B1 => F0) = (0:0:0,0:0:0);
      (C1 => F0) = (0:0:0,0:0:0);
      (D1 => F0) = (0:0:0,0:0:0);
      (CE => F0) = (0:0:0,0:0:0);
      (LSR => F0) = (0:0:0,0:0:0);
      (CLK => F0) = (0:0:0,0:0:0);
      (CLK2 => F0) = (0:0:0,0:0:0);

      $setuphold( posedge CLK &&& rclk_eq_clk_and_check_di0_posedge, DI0, 0:0:0, 0:0:0, notify_DI0,,, CLK_dly, DI0_dly) ;
      $setuphold( posedge CLK &&& rclk_eq_clk_and_check_di1_posedge, DI1, 0:0:0, 0:0:0, notify_DI1,,, CLK_dly, DI1_dly) ;
      $setuphold( negedge CLK &&& rclk_eq_clk_and_check_di0_negedge, DI0, 0:0:0, 0:0:0, notify_DI0,,, CLK_dly, DI0_dly) ;
      $setuphold( negedge CLK &&& rclk_eq_clk_and_check_di1_negedge, DI1, 0:0:0, 0:0:0, notify_DI1,,, CLK_dly, DI1_dly) ;

      $setuphold( posedge CLK2 &&& rclk_eq_clk2_and_check_di0_posedge2, DI0, 0:0:0, 0:0:0, notify_DI0,,, CLK2_dly, DI0_dly) ;
      $setuphold( posedge CLK2 &&& rclk_eq_clk2_and_check_di1_posedge2, DI1, 0:0:0, 0:0:0, notify_DI1,,, CLK2_dly, DI1_dly) ;
      $setuphold( negedge CLK2 &&& rclk_eq_clk2_and_check_di0_negedge2, DI0, 0:0:0, 0:0:0, notify_DI0,,, CLK2_dly, DI0_dly) ;
      $setuphold( negedge CLK2 &&& rclk_eq_clk2_and_check_di1_negedge2, DI1, 0:0:0, 0:0:0, notify_DI1,,, CLK2_dly, DI1_dly) ;

      $setuphold( posedge CLK &&& wclk_eq_clk_and_check_m0_posedge, M0, 0:0:0, 0:0:0,,,, CLK_dly, M0_dly) ;
      $setuphold( posedge CLK &&& wclk_eq_clk_and_check_dpi_posedge, DPI, 0:0:0, 0:0:0,,,, CLK_dly, DPI_dly) ;
      $setuphold( posedge CLK &&& wclk_eq_clk_and_check_ce_posedge, CE, 0:0:0, 0:0:0,,,, CLK_dly, CE_dly) ;
      $setuphold( posedge CLK &&& wclk_eq_clk_and_check_lsr_posedge, LSR, 0:0:0, 0:0:0,,,, CLK_dly, LSR_dly) ;
      $setuphold( posedge CLK &&& wclk_eq_clk_and_check_a0_posedge, A0, 0:0:0, 0:0:0,,,, CLK_dly, WAD0_dly) ;
      $setuphold( posedge CLK &&& wclk_eq_clk_and_check_b0_posedge, B0, 0:0:0, 0:0:0,,,, CLK_dly, WAD1_dly) ;
      $setuphold( posedge CLK &&& wclk_eq_clk_and_check_c0_posedge, C0, 0:0:0, 0:0:0,,,, CLK_dly, WAD2_dly) ;
      $setuphold( posedge CLK &&& wclk_eq_clk_and_check_d0_posedge, D0, 0:0:0, 0:0:0,,,, CLK_dly, WAD3_dly) ;
      $setuphold( posedge CLK &&& wclk_eq_clk_and_check_a1_posedge, A1, 0:0:0, 0:0:0,,,, CLK_dly, RAD0_dly) ;
      $setuphold( posedge CLK &&& wclk_eq_clk_and_check_b1_posedge, B1, 0:0:0, 0:0:0,,,, CLK_dly, RAD1_dly) ;
      $setuphold( posedge CLK &&& wclk_eq_clk_and_check_c1_posedge, C1, 0:0:0, 0:0:0,,,, CLK_dly, RAD2_dly) ;
      $setuphold( posedge CLK &&& wclk_eq_clk_and_check_d1_posedge, D1, 0:0:0, 0:0:0,,,, CLK_dly, RAD3_dly) ;
      $setuphold( negedge CLK &&& wclk_eq_clk_and_check_m0_negedge, M0, 0:0:0, 0:0:0,,,, CLK_dly, M0_dly) ;
      $setuphold( negedge CLK &&& wclk_eq_clk_and_check_dpi_negedge, DPI, 0:0:0, 0:0:0,,,, CLK_dly, DPI_dly) ;
      $setuphold( negedge CLK &&& wclk_eq_clk_and_check_ce_negedge, CE, 0:0:0, 0:0:0,,,, CLK_dly, CE_dly) ;
      $setuphold( negedge CLK &&& wclk_eq_clk_and_check_lsr_negedge, LSR, 0:0:0, 0:0:0,,,, CLK_dly, LSR_dly) ;
      $setuphold( negedge CLK &&& wclk_eq_clk_and_check_a0_negedge, A0, 0:0:0, 0:0:0,,,, CLK_dly, WAD0_dly) ;
      $setuphold( negedge CLK &&& wclk_eq_clk_and_check_b0_negedge, B0, 0:0:0, 0:0:0,,,, CLK_dly, WAD1_dly) ;
      $setuphold( negedge CLK &&& wclk_eq_clk_and_check_c0_negedge, C0, 0:0:0, 0:0:0,,,, CLK_dly, WAD2_dly) ;
      $setuphold( negedge CLK &&& wclk_eq_clk_and_check_d0_negedge, D0, 0:0:0, 0:0:0,,,, CLK_dly, WAD3_dly) ;
      $setuphold( negedge CLK &&& wclk_eq_clk_and_check_a1_negedge, A1, 0:0:0, 0:0:0,,,, CLK_dly, RAD0_dly) ;
      $setuphold( negedge CLK &&& wclk_eq_clk_and_check_b1_negedge, B1, 0:0:0, 0:0:0,,,, CLK_dly, RAD1_dly) ;
      $setuphold( negedge CLK &&& wclk_eq_clk_and_check_c1_negedge, C1, 0:0:0, 0:0:0,,,, CLK_dly, RAD2_dly) ;
      $setuphold( negedge CLK &&& wclk_eq_clk_and_check_d1_negedge, D1, 0:0:0, 0:0:0,,,, CLK_dly, RAD3_dly) ;

      $setuphold( posedge CLK2 &&& wclk_eq_clk2_and_check_m0_posedge2, M0, 0:0:0, 0:0:0,,,, CLK2_dly, M0_dly) ;
      $setuphold( posedge CLK2 &&& wclk_eq_clk2_and_check_dpi_posedge2, DPI, 0:0:0, 0:0:0,,,, CLK2_dly, DPI_dly) ;
      $setuphold( posedge CLK2 &&& wclk_eq_clk2_and_check_ce_posedge2, CE, 0:0:0, 0:0:0,,,, CLK2_dly, CE_dly) ;
      $setuphold( posedge CLK2 &&& wclk_eq_clk2_and_check_lsr_posedge2, LSR, 0:0:0, 0:0:0,,,, CLK2_dly, LSR_dly) ;
      $setuphold( posedge CLK2 &&& wclk_eq_clk2_and_check_a0_posedge2, A0, 0:0:0, 0:0:0,,,, CLK2_dly, WAD0_dly) ;
      $setuphold( posedge CLK2 &&& wclk_eq_clk2_and_check_b0_posedge2, B0, 0:0:0, 0:0:0,,,, CLK2_dly, WAD1_dly) ;
      $setuphold( posedge CLK2 &&& wclk_eq_clk2_and_check_c0_posedge2, C0, 0:0:0, 0:0:0,,,, CLK2_dly, WAD2_dly) ;
      $setuphold( posedge CLK2 &&& wclk_eq_clk2_and_check_d0_posedge2, D0, 0:0:0, 0:0:0,,,, CLK2_dly, WAD3_dly) ;
      $setuphold( posedge CLK2 &&& wclk_eq_clk2_and_check_a1_posedge2, A1, 0:0:0, 0:0:0,,,, CLK2_dly, RAD0_dly) ;
      $setuphold( posedge CLK2 &&& wclk_eq_clk2_and_check_b1_posedge2, B1, 0:0:0, 0:0:0,,,, CLK2_dly, RAD1_dly) ;
      $setuphold( posedge CLK2 &&& wclk_eq_clk2_and_check_c1_posedge2, C1, 0:0:0, 0:0:0,,,, CLK2_dly, RAD2_dly) ;
      $setuphold( posedge CLK2 &&& wclk_eq_clk2_and_check_d1_posedge2, D1, 0:0:0, 0:0:0,,,, CLK2_dly, RAD3_dly) ;
      $setuphold( negedge CLK2 &&& wclk_eq_clk2_and_check_m0_negedge2, M0, 0:0:0, 0:0:0,,,, CLK2_dly, M0_dly) ;
      $setuphold( negedge CLK2 &&& wclk_eq_clk2_and_check_dpi_negedge2, DPI, 0:0:0, 0:0:0,,,, CLK2_dly, DPI_dly) ;
      $setuphold( negedge CLK2 &&& wclk_eq_clk2_and_check_ce_negedge2, CE, 0:0:0, 0:0:0,,,, CLK2_dly, CE_dly) ;
      $setuphold( negedge CLK2 &&& wclk_eq_clk2_and_check_lsr_negedge2, LSR, 0:0:0, 0:0:0,,,, CLK2_dly, LSR_dly) ;
      $setuphold( negedge CLK2 &&& wclk_eq_clk2_and_check_a0_negedge2, A0, 0:0:0, 0:0:0,,,, CLK2_dly, WAD0_dly) ;
      $setuphold( negedge CLK2 &&& wclk_eq_clk2_and_check_b0_negedge2, B0, 0:0:0, 0:0:0,,,, CLK2_dly, WAD1_dly) ;
      $setuphold( negedge CLK2 &&& wclk_eq_clk2_and_check_c0_negedge2, C0, 0:0:0, 0:0:0,,,, CLK2_dly, WAD2_dly) ;
      $setuphold( negedge CLK2 &&& wclk_eq_clk2_and_check_d0_negedge2, D0, 0:0:0, 0:0:0,,,, CLK2_dly, WAD3_dly) ;
      $setuphold( negedge CLK2 &&& wclk_eq_clk2_and_check_a1_negedge2, A1, 0:0:0, 0:0:0,,,, CLK2_dly, RAD0_dly) ;
      $setuphold( negedge CLK2 &&& wclk_eq_clk2_and_check_b1_negedge2, B1, 0:0:0, 0:0:0,,,, CLK2_dly, RAD1_dly) ;
      $setuphold( negedge CLK2 &&& wclk_eq_clk2_and_check_c1_negedge2, C1, 0:0:0, 0:0:0,,,, CLK2_dly, RAD2_dly) ;
      $setuphold( negedge CLK2 &&& wclk_eq_clk2_and_check_d1_negedge2, D1, 0:0:0, 0:0:0,,,, CLK2_dly, RAD3_dly) ;

      $width (posedge CLK, 0:0:0);
      $width (negedge CLK, 0:0:0);
      $width (posedge CLK2, 0:0:0);
      $width (negedge CLK2, 0:0:0);
      $width (posedge LSR, 0:0:0);
      $width (negedge LSR, 0:0:0);
   endspecify

endmodule

