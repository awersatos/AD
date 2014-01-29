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

module SFIFOA (DI0, DI1, DI2, DI3, DI4, DI5, DI6, DI7, DI8,
         DI9, DI10, DI11, DI12, DI13, DI14, DI15, DI16, DI17,
         DI18, DI19, DI20, DI21, DI22, DI23, DI24, DI25, DI26,
         DI27, DI28, DI29, DI30, DI31, DI32, DI33, DI34, DI35,
         FULLI, CSW0, CSW1, EMPTYI, CSR0, CSR1, WE, RE, CLKW, CLKR, RST, RPRST,
         DO0, DO1, DO2, DO3, DO4, DO5, DO6, DO7, DO8,
         DO9, DO10, DO11, DO12, DO13, DO14, DO15, DO16, DO17,
         DO18, DO19, DO20, DO21, DO22, DO23, DO24, DO25, DO26,
         DO27, DO28, DO29, DO30, DO31, DO32, DO33, DO34, DO35,
         EF, AEF, AFF, FF);

   parameter  DATA_WIDTH_W = 18;
   parameter  DATA_WIDTH_R = 18;
   parameter  REGMODE = "NOREG";
   parameter  RESETMODE = "ASYNC";
   parameter  CSDECODE_W = 2'b00;
   parameter  CSDECODE_R = 2'b00;
   parameter  AEPOINTER = 15'b000000000000000;
   parameter  AEPOINTER1 = 15'b000000000000000;
   parameter  AFPOINTER = 15'b000000000000000;
   parameter  AFPOINTER1 = 15'b000000000000000;
   parameter  FULLPOINTER = 15'b000000000000000;
   parameter  FULLPOINTER1 = 15'b000000000000000;
   parameter GSR = "DISABLED";


input    DI0, DI1, DI2, DI3, DI4, DI5, DI6, DI7, DI8,
         DI9, DI10, DI11, DI12, DI13, DI14, DI15, DI16, DI17,
         DI18, DI19, DI20, DI21, DI22, DI23, DI24, DI25, DI26,
         DI27, DI28, DI29, DI30, DI31, DI32, DI33, DI34, DI35,
         FULLI, CSW0, CSW1, EMPTYI, CSR0, CSR1, WE, RE, CLKW, CLKR, RST, RPRST;
output   DO0, DO1, DO2, DO3, DO4, DO5, DO6, DO7, DO8,
         DO9, DO10, DO11, DO12, DO13, DO14, DO15, DO16, DO17,
         DO18, DO19, DO20, DO21, DO22, DO23, DO24, DO25, DO26,
         DO27, DO28, DO29, DO30, DO31, DO32, DO33, DO34, DO35,
         EF, AEF, AFF, FF;

   parameter  XON = 1'b0;
   parameter  CLKW_NEGEDGE = 1'b0;
   parameter  CLKR_NEGEDGE = 1'b0;
   parameter  CHECK_DI0 = 1'b0;
   parameter  CHECK_DI1 = 1'b0;
   parameter  CHECK_DI2 = 1'b0;
   parameter  CHECK_DI3 = 1'b0;
   parameter  CHECK_DI4 = 1'b0;
   parameter  CHECK_DI5 = 1'b0;
   parameter  CHECK_DI6 = 1'b0;
   parameter  CHECK_DI7 = 1'b0;
   parameter  CHECK_DI8 = 1'b0;
   parameter  CHECK_DI9 = 1'b0;
   parameter  CHECK_DI10 = 1'b0;
   parameter  CHECK_DI11 = 1'b0;
   parameter  CHECK_DI12 = 1'b0;
   parameter  CHECK_DI13 = 1'b0;
   parameter  CHECK_DI14 = 1'b0;
   parameter  CHECK_DI15 = 1'b0;
   parameter  CHECK_DI16 = 1'b0;
   parameter  CHECK_DI17 = 1'b0;
   parameter  CHECK_DI18 = 1'b0;
   parameter  CHECK_DI19 = 1'b0;
   parameter  CHECK_DI20 = 1'b0;
   parameter  CHECK_DI21 = 1'b0;
   parameter  CHECK_DI22 = 1'b0;
   parameter  CHECK_DI23 = 1'b0;
   parameter  CHECK_DI24 = 1'b0;
   parameter  CHECK_DI25 = 1'b0;
   parameter  CHECK_DI26 = 1'b0;
   parameter  CHECK_DI27 = 1'b0;
   parameter  CHECK_DI28 = 1'b0;
   parameter  CHECK_DI29 = 1'b0;
   parameter  CHECK_DI30 = 1'b0;
   parameter  CHECK_DI31 = 1'b0;
   parameter  CHECK_DI32 = 1'b0;
   parameter  CHECK_DI33 = 1'b0;
   parameter  CHECK_DI34 = 1'b0;
   parameter  CHECK_DI35 = 1'b0;
   parameter  CHECK_FULLI = 1'b0;
   parameter  CHECK_CSW0 = 1'b0;
   parameter  CHECK_CSW1 = 1'b0;
   parameter  CHECK_EMPTYI = 1'b0;
   parameter  CHECK_CSR0 = 1'b0;
   parameter  CHECK_CSR1 = 1'b0;
   parameter  CHECK_WE = 1'b0;
   parameter  CHECK_RE = 1'b0;
   parameter  CHECK_RST = 1'b0;
   parameter  CHECK_RPRST = 1'b0;

   wire check_di0, check_di1, check_di2, check_di3, check_di4, check_di5, check_di6, check_di7, check_di8;
   wire check_di9, check_di10, check_di11, check_di12, check_di13, check_di14, check_di15;
   wire check_di16, check_di17, check_di18, check_di19, check_di20;
   wire check_di21, check_di22, check_di23, check_di24, check_di25, check_di26, check_di27, check_di28;
   wire check_di29, check_di30, check_di31, check_di32, check_di33, check_di34, check_di35;
   wire check_fulli, check_csw0, check_csw1, check_emptyi, check_csr0, check_csr1, check_we;
   wire check_re, check_rst, check_rprst;

   assign check_di0_pos = CHECK_DI0 & (!CLKW_NEGEDGE);
   assign check_di1_pos = CHECK_DI1 & (!CLKW_NEGEDGE);
   assign check_di2_pos = CHECK_DI2 & (!CLKW_NEGEDGE);
   assign check_di3_pos = CHECK_DI3 & (!CLKW_NEGEDGE);
   assign check_di4_pos = CHECK_DI4 & (!CLKW_NEGEDGE);
   assign check_di5_pos = CHECK_DI5 & (!CLKW_NEGEDGE);
   assign check_di6_pos = CHECK_DI6 & (!CLKW_NEGEDGE);
   assign check_di7_pos = CHECK_DI7 & (!CLKW_NEGEDGE);
   assign check_di8_pos = CHECK_DI8 & (!CLKW_NEGEDGE);
   assign check_di9_pos = CHECK_DI9 & (!CLKW_NEGEDGE);
   assign check_di10_pos = CHECK_DI10 & (!CLKW_NEGEDGE);
   assign check_di11_pos = CHECK_DI11 & (!CLKW_NEGEDGE);
   assign check_di12_pos = CHECK_DI12 & (!CLKW_NEGEDGE);
   assign check_di13_pos = CHECK_DI13 & (!CLKW_NEGEDGE);
   assign check_di14_pos = CHECK_DI14 & (!CLKW_NEGEDGE);
   assign check_di15_pos = CHECK_DI15 & (!CLKW_NEGEDGE);
   assign check_di16_pos = CHECK_DI16 & (!CLKW_NEGEDGE);
   assign check_di17_pos = CHECK_DI17 & (!CLKW_NEGEDGE);
   assign check_di18_pos = CHECK_DI18 & (!CLKW_NEGEDGE);
   assign check_di19_pos = CHECK_DI19 & (!CLKW_NEGEDGE);
   assign check_di20_pos = CHECK_DI20 & (!CLKW_NEGEDGE);
   assign check_di21_pos = CHECK_DI21 & (!CLKW_NEGEDGE);
   assign check_di22_pos = CHECK_DI22 & (!CLKW_NEGEDGE);
   assign check_di23_pos = CHECK_DI23 & (!CLKW_NEGEDGE);
   assign check_di24_pos = CHECK_DI24 & (!CLKW_NEGEDGE);
   assign check_di25_pos = CHECK_DI25 & (!CLKW_NEGEDGE);
   assign check_di26_pos = CHECK_DI26 & (!CLKW_NEGEDGE);
   assign check_di27_pos = CHECK_DI27 & (!CLKW_NEGEDGE);
   assign check_di28_pos = CHECK_DI28 & (!CLKW_NEGEDGE);
   assign check_di29_pos = CHECK_DI29 & (!CLKW_NEGEDGE);
   assign check_di30_pos = CHECK_DI30 & (!CLKW_NEGEDGE);
   assign check_di31_pos = CHECK_DI31 & (!CLKW_NEGEDGE);
   assign check_di32_pos = CHECK_DI32 & (!CLKW_NEGEDGE);
   assign check_di33_pos = CHECK_DI33 & (!CLKW_NEGEDGE);
   assign check_di34_pos = CHECK_DI34 & (!CLKW_NEGEDGE);
   assign check_di35_pos = CHECK_DI35 & (!CLKW_NEGEDGE);
   assign check_re_pos = CHECK_RE & (!CLKR_NEGEDGE);
   assign check_we_pos = CHECK_WE & (!CLKW_NEGEDGE);
   assign check_csw0_pos = CHECK_CSW0 & (!CLKW_NEGEDGE);
   assign check_csw1_pos = CHECK_CSW1 & (!CLKW_NEGEDGE);
   assign check_fulli_pos = CHECK_FULLI & (!CLKW_NEGEDGE);
   assign check_rst_pos = CHECK_RST & (!CLKW_NEGEDGE);
   assign check_csr0_pos = CHECK_CSR0 & (!CLKR_NEGEDGE);
   assign check_csr1_pos = CHECK_CSR1 & (!CLKR_NEGEDGE);
   assign check_emptyi_pos = CHECK_EMPTYI & (!CLKR_NEGEDGE);
   assign check_rprst_pos = CHECK_RPRST & (!CLKR_NEGEDGE);

   assign check_di0_neg = CHECK_DI0 & (CLKW_NEGEDGE);
   assign check_di1_neg = CHECK_DI1 & (CLKW_NEGEDGE);
   assign check_di2_neg = CHECK_DI2 & (CLKW_NEGEDGE);
   assign check_di3_neg = CHECK_DI3 & (CLKW_NEGEDGE);
   assign check_di4_neg = CHECK_DI4 & (CLKW_NEGEDGE);
   assign check_di5_neg = CHECK_DI5 & (CLKW_NEGEDGE);
   assign check_di6_neg = CHECK_DI6 & (CLKW_NEGEDGE);
   assign check_di7_neg = CHECK_DI7 & (CLKW_NEGEDGE);
   assign check_di8_neg = CHECK_DI8 & (CLKW_NEGEDGE);
   assign check_di9_neg = CHECK_DI9 & (CLKW_NEGEDGE);
   assign check_di10_neg = CHECK_DI10 & (CLKW_NEGEDGE);
   assign check_di11_neg = CHECK_DI11 & (CLKW_NEGEDGE);
   assign check_di12_neg = CHECK_DI12 & (CLKW_NEGEDGE);
   assign check_di13_neg = CHECK_DI13 & (CLKW_NEGEDGE);
   assign check_di14_neg = CHECK_DI14 & (CLKW_NEGEDGE);
   assign check_di15_neg = CHECK_DI15 & (CLKW_NEGEDGE);
   assign check_di16_neg = CHECK_DI16 & (CLKW_NEGEDGE);
   assign check_di17_neg = CHECK_DI17 & (CLKW_NEGEDGE);
   assign check_di18_neg = CHECK_DI18 & (CLKW_NEGEDGE);
   assign check_di19_neg = CHECK_DI19 & (CLKW_NEGEDGE);
   assign check_di20_neg = CHECK_DI20 & (CLKW_NEGEDGE);
   assign check_di21_neg = CHECK_DI21 & (CLKW_NEGEDGE);
   assign check_di22_neg = CHECK_DI22 & (CLKW_NEGEDGE);
   assign check_di23_neg = CHECK_DI23 & (CLKW_NEGEDGE);
   assign check_di24_neg = CHECK_DI24 & (CLKW_NEGEDGE);
   assign check_di25_neg = CHECK_DI25 & (CLKW_NEGEDGE);
   assign check_di26_neg = CHECK_DI26 & (CLKW_NEGEDGE);
   assign check_di27_neg = CHECK_DI27 & (CLKW_NEGEDGE);
   assign check_di28_neg = CHECK_DI28 & (CLKW_NEGEDGE);
   assign check_di29_neg = CHECK_DI29 & (CLKW_NEGEDGE);
   assign check_di30_neg = CHECK_DI30 & (CLKW_NEGEDGE);
   assign check_di31_neg = CHECK_DI31 & (CLKW_NEGEDGE);
   assign check_di32_neg = CHECK_DI32 & (CLKW_NEGEDGE);
   assign check_di33_neg = CHECK_DI33 & (CLKW_NEGEDGE);
   assign check_di34_neg = CHECK_DI34 & (CLKW_NEGEDGE);
   assign check_di35_neg = CHECK_DI35 & (CLKW_NEGEDGE);
   assign check_re_neg = CHECK_RE & (CLKR_NEGEDGE);
   assign check_we_neg = CHECK_WE & (CLKW_NEGEDGE);
   assign check_csw0_neg = CHECK_CSW0 & (CLKW_NEGEDGE);
   assign check_csw1_neg = CHECK_CSW1 & (CLKW_NEGEDGE);
   assign check_fulli_neg = CHECK_FULLI & (CLKW_NEGEDGE);
   assign check_rst_neg = CHECK_RST & (CLKW_NEGEDGE);
   assign check_csr0_neg = CHECK_CSR0 & (CLKR_NEGEDGE);
   assign check_csr1_neg = CHECK_CSR1 & (CLKR_NEGEDGE);
   assign check_emptyi_neg = CHECK_EMPTYI & (CLKR_NEGEDGE);
   assign check_rprst_neg = CHECK_RPRST & (CLKR_NEGEDGE);

   defparam FIFO16KA_INST.DATA_WIDTH_W = DATA_WIDTH_W;
   defparam FIFO16KA_INST.DATA_WIDTH_R = DATA_WIDTH_R;
   defparam FIFO16KA_INST.REGMODE = REGMODE;
   defparam FIFO16KA_INST.RESETMODE = RESETMODE;
   defparam FIFO16KA_INST.CSDECODE_W = CSDECODE_W;
   defparam FIFO16KA_INST.CSDECODE_R = CSDECODE_R;
   defparam FIFO16KA_INST.AEPOINTER = AEPOINTER;
   defparam FIFO16KA_INST.AEPOINTER1 = AEPOINTER1;
   defparam FIFO16KA_INST.AFPOINTER = AFPOINTER;
   defparam FIFO16KA_INST.AFPOINTER1 = AFPOINTER1;
   defparam FIFO16KA_INST.FULLPOINTER = FULLPOINTER;
   defparam FIFO16KA_INST.FULLPOINTER1 = FULLPOINTER1;
   defparam FIFO16KA_INST.GSR = GSR;

   FIFO16KA FIFO16KA_INST (.DI0(DI0_dly),
                       .DI1(DI1_dly),
                       .DI2(DI2_dly),
                       .DI3(DI3_dly),
                       .DI4(DI4_dly),
                       .DI5(DI5_dly),
                       .DI6(DI6_dly),
                       .DI7(DI7_dly),
                       .DI8(DI8_dly),
                       .DI9(DI9_dly),
                       .DI10(DI10_dly),
                       .DI11(DI11_dly),
                       .DI12(DI12_dly),
                       .DI13(DI13_dly),
                       .DI14(DI14_dly),
                       .DI15(DI15_dly),
                       .DI16(DI16_dly),
                       .DI17(DI17_dly),
                       .DI18(DI18_dly),
                       .DI19(DI19_dly),
                       .DI20(DI20_dly),
                       .DI21(DI21_dly),
                       .DI22(DI22_dly),
                       .DI23(DI23_dly),
                       .DI24(DI24_dly),
                       .DI25(DI25_dly),
                       .DI26(DI26_dly),
                       .DI27(DI27_dly),
                       .DI28(DI28_dly),
                       .DI29(DI29_dly),
                       .DI30(DI30_dly),
                       .DI31(DI31_dly),
                       .DI32(DI32_dly),
                       .DI33(DI33_dly),
                       .DI34(DI34_dly),
                       .DI35(DI35_dly),
                       .FULLI(FULLI_dly),
                       .CSW0(CSW0_dly),
                       .CSW1(CSW1_dly),
                       .EMPTYI(EMPTYI_dly),
                       .CSR0(CSR0_dly),
                       .CSR1(CSR1_dly),
                       .WE(WE_dly),
                       .RE(RE_dly),
                       .CLKW(CLKW_dly),
                       .CLKR(CLKR_dly),
                       .RST(RST_dly),
                       .RPRST(RPRST_dly),
                       .DO0(DO0_dly),
                       .DO1(DO1_dly),
                       .DO2(DO2_dly),
                       .DO3(DO3_dly),
                       .DO4(DO4_dly),
                       .DO5(DO5_dly),
                       .DO6(DO6_dly),
                       .DO7(DO7_dly),
                       .DO8(DO8_dly),
                       .DO9(DO9_dly),
                       .DO10(DO10_dly),
                       .DO11(DO11_dly),
                       .DO12(DO12_dly),
                       .DO13(DO13_dly),
                       .DO14(DO14_dly),
                       .DO15(DO15_dly),
                       .DO16(DO16_dly),
                       .DO17(DO17_dly),
                       .DO18(DO18_dly),
                       .DO19(DO19_dly),
                       .DO20(DO20_dly),
                       .DO21(DO21_dly),
                       .DO22(DO22_dly),
                       .DO23(DO23_dly),
                       .DO24(DO24_dly),
                       .DO25(DO25_dly),
                       .DO26(DO26_dly),
                       .DO27(DO27_dly),
                       .DO28(DO28_dly),
                       .DO29(DO29_dly),
                       .DO30(DO30_dly),
                       .DO31(DO31_dly),
                       .DO32(DO32_dly),
                       .DO33(DO33_dly),
                       .DO34(DO34_dly),
                       .DO35(DO35_dly),
                       .EF(EF_dly),
                       .AEF(AEF_dly),
                       .FF(FF_dly),
                       .AFF(AFF_dly));

   buf (DO0, DO0_dly);
   buf (DO1, DO1_dly);
   buf (DO2, DO2_dly);
   buf (DO3, DO3_dly);
   buf (DO4, DO4_dly);
   buf (DO5, DO5_dly);
   buf (DO6, DO6_dly);
   buf (DO7, DO7_dly);
   buf (DO8, DO8_dly);
   buf (DO9, DO9_dly);
   buf (DO10, DO10_dly);
   buf (DO11, DO11_dly);
   buf (DO12, DO12_dly);
   buf (DO13, DO13_dly);
   buf (DO14, DO14_dly);
   buf (DO15, DO15_dly);
   buf (DO16, DO16_dly);
   buf (DO17, DO17_dly);
   buf (DO18, DO18_dly);
   buf (DO19, DO19_dly);
   buf (DO20, DO20_dly);
   buf (DO21, DO21_dly);
   buf (DO22, DO22_dly);
   buf (DO23, DO23_dly);
   buf (DO24, DO24_dly);
   buf (DO25, DO25_dly);
   buf (DO26, DO26_dly);
   buf (DO27, DO27_dly);
   buf (DO28, DO28_dly);
   buf (DO29, DO29_dly);
   buf (DO30, DO30_dly);
   buf (DO31, DO31_dly);
   buf (DO32, DO32_dly);
   buf (DO33, DO33_dly);
   buf (DO34, DO34_dly);
   buf (DO35, DO35_dly);
   buf (EF, EF_dly);
   buf (AEF, AEF_dly);
   buf (FF, FF_dly);
   buf (AFF, AFF_dly);

   specify

      (CLKR => DO0) = (0:0:0,0:0:0);
      (CLKR => DO1) = (0:0:0,0:0:0);
      (CLKR => DO2) = (0:0:0,0:0:0);
      (CLKR => DO3) = (0:0:0,0:0:0);
      (CLKR => DO4) = (0:0:0,0:0:0);
      (CLKR => DO5) = (0:0:0,0:0:0);
      (CLKR => DO6) = (0:0:0,0:0:0);
      (CLKR => DO7) = (0:0:0,0:0:0);
      (CLKR => DO8) = (0:0:0,0:0:0);
      (CLKR => DO9) = (0:0:0,0:0:0);
      (CLKR => DO10) = (0:0:0,0:0:0);
      (CLKR => DO11) = (0:0:0,0:0:0);
      (CLKR => DO12) = (0:0:0,0:0:0);
      (CLKR => DO13) = (0:0:0,0:0:0);
      (CLKR => DO14) = (0:0:0,0:0:0);
      (CLKR => DO15) = (0:0:0,0:0:0);
      (CLKR => DO16) = (0:0:0,0:0:0);
      (CLKR => DO17) = (0:0:0,0:0:0);
      (CLKR => DO18) = (0:0:0,0:0:0);
      (CLKR => DO19) = (0:0:0,0:0:0);
      (CLKR => DO20) = (0:0:0,0:0:0);
      (CLKR => DO21) = (0:0:0,0:0:0);
      (CLKR => DO22) = (0:0:0,0:0:0);
      (CLKR => DO23) = (0:0:0,0:0:0);
      (CLKR => DO24) = (0:0:0,0:0:0);
      (CLKR => DO25) = (0:0:0,0:0:0);
      (CLKR => DO26) = (0:0:0,0:0:0);
      (CLKR => DO27) = (0:0:0,0:0:0);
      (CLKR => DO28) = (0:0:0,0:0:0);
      (CLKR => DO29) = (0:0:0,0:0:0);
      (CLKR => DO30) = (0:0:0,0:0:0);
      (CLKR => DO31) = (0:0:0,0:0:0);
      (CLKR => DO32) = (0:0:0,0:0:0);
      (CLKR => DO33) = (0:0:0,0:0:0);
      (CLKR => DO34) = (0:0:0,0:0:0);
      (CLKR => DO35) = (0:0:0,0:0:0);

      (RST => DO0) = (0:0:0,0:0:0);
      (RST => DO1) = (0:0:0,0:0:0);
      (RST => DO2) = (0:0:0,0:0:0);
      (RST => DO3) = (0:0:0,0:0:0);
      (RST => DO4) = (0:0:0,0:0:0);
      (RST => DO5) = (0:0:0,0:0:0);
      (RST => DO6) = (0:0:0,0:0:0);
      (RST => DO7) = (0:0:0,0:0:0);
      (RST => DO8) = (0:0:0,0:0:0);
      (RST => DO9) = (0:0:0,0:0:0);
      (RST => DO10) = (0:0:0,0:0:0);
      (RST => DO11) = (0:0:0,0:0:0);
      (RST => DO12) = (0:0:0,0:0:0);
      (RST => DO13) = (0:0:0,0:0:0);
      (RST => DO14) = (0:0:0,0:0:0);
      (RST => DO15) = (0:0:0,0:0:0);
      (RST => DO16) = (0:0:0,0:0:0);
      (RST => DO17) = (0:0:0,0:0:0);
      (RST => DO18) = (0:0:0,0:0:0);
      (RST => DO19) = (0:0:0,0:0:0);
      (RST => DO20) = (0:0:0,0:0:0);
      (RST => DO21) = (0:0:0,0:0:0);
      (RST => DO22) = (0:0:0,0:0:0);
      (RST => DO23) = (0:0:0,0:0:0);
      (RST => DO24) = (0:0:0,0:0:0);
      (RST => DO25) = (0:0:0,0:0:0);
      (RST => DO26) = (0:0:0,0:0:0);
      (RST => DO27) = (0:0:0,0:0:0);
      (RST => DO28) = (0:0:0,0:0:0);
      (RST => DO29) = (0:0:0,0:0:0);
      (RST => DO30) = (0:0:0,0:0:0);
      (RST => DO31) = (0:0:0,0:0:0);
      (RST => DO32) = (0:0:0,0:0:0);
      (RST => DO33) = (0:0:0,0:0:0);
      (RST => DO34) = (0:0:0,0:0:0);
      (RST => DO35) = (0:0:0,0:0:0);

      (CLKR => EF) = (0:0:0,0:0:0);
      (CLKR => AEF) = (0:0:0,0:0:0);
      (CLKW => FF) = (0:0:0,0:0:0);
      (CLKW => AFF) = (0:0:0,0:0:0);
      (RST => FF) = (0:0:0,0:0:0);
      (RST => AFF) = (0:0:0,0:0:0);
      (RPRST => EF) = (0:0:0,0:0:0);
      (RPRST => AEF) = (0:0:0,0:0:0);

      $setuphold( posedge CLKW &&& check_di0_pos,  DI0, 0:0:0, 0:0:0,,,, CLKW_dly, DI0_dly) ;
      $setuphold( posedge CLKW &&& check_di1_pos,  DI1, 0:0:0, 0:0:0,,,, CLKW_dly, DI1_dly) ;
      $setuphold( posedge CLKW &&& check_di2_pos,  DI2, 0:0:0, 0:0:0,,,, CLKW_dly, DI2_dly) ;
      $setuphold( posedge CLKW &&& check_di3_pos,  DI3, 0:0:0, 0:0:0,,,, CLKW_dly, DI3_dly) ;
      $setuphold( posedge CLKW &&& check_di4_pos,  DI4, 0:0:0, 0:0:0,,,, CLKW_dly, DI4_dly) ;
      $setuphold( posedge CLKW &&& check_di5_pos,  DI5, 0:0:0, 0:0:0,,,, CLKW_dly, DI5_dly) ;
      $setuphold( posedge CLKW &&& check_di6_pos,  DI6, 0:0:0, 0:0:0,,,, CLKW_dly, DI6_dly) ;
      $setuphold( posedge CLKW &&& check_di7_pos,  DI7, 0:0:0, 0:0:0,,,, CLKW_dly, DI7_dly) ;
      $setuphold( posedge CLKW &&& check_di8_pos,  DI8, 0:0:0, 0:0:0,,,, CLKW_dly, DI8_dly) ;
      $setuphold( posedge CLKW &&& check_di9_pos,  DI9, 0:0:0, 0:0:0,,,, CLKW_dly, DI9_dly) ;
      $setuphold( posedge CLKW &&& check_di10_pos,  DI10, 0:0:0, 0:0:0,,,, CLKW_dly, DI10_dly) ;
      $setuphold( posedge CLKW &&& check_di11_pos,  DI11, 0:0:0, 0:0:0,,,, CLKW_dly, DI11_dly) ;
      $setuphold( posedge CLKW &&& check_di12_pos,  DI12, 0:0:0, 0:0:0,,,, CLKW_dly, DI12_dly) ;
      $setuphold( posedge CLKW &&& check_di13_pos,  DI13, 0:0:0, 0:0:0,,,, CLKW_dly, DI13_dly) ;
      $setuphold( posedge CLKW &&& check_di14_pos,  DI14, 0:0:0, 0:0:0,,,, CLKW_dly, DI14_dly) ;
      $setuphold( posedge CLKW &&& check_di15_pos,  DI15, 0:0:0, 0:0:0,,,, CLKW_dly, DI15_dly) ;
      $setuphold( posedge CLKW &&& check_di16_pos,  DI16, 0:0:0, 0:0:0,,,, CLKW_dly, DI16_dly) ;
      $setuphold( posedge CLKW &&& check_di17_pos,  DI17, 0:0:0, 0:0:0,,,, CLKW_dly, DI17_dly) ;
      $setuphold( posedge CLKW &&& check_di18_pos,  DI18, 0:0:0, 0:0:0,,,, CLKW_dly, DI18_dly) ;
      $setuphold( posedge CLKW &&& check_di19_pos,  DI19, 0:0:0, 0:0:0,,,, CLKW_dly, DI19_dly) ;
      $setuphold( posedge CLKW &&& check_di20_pos,  DI20, 0:0:0, 0:0:0,,,, CLKW_dly, DI20_dly) ;
      $setuphold( posedge CLKW &&& check_di21_pos,  DI21, 0:0:0, 0:0:0,,,, CLKW_dly, DI21_dly) ;
      $setuphold( posedge CLKW &&& check_di22_pos,  DI22, 0:0:0, 0:0:0,,,, CLKW_dly, DI22_dly) ;
      $setuphold( posedge CLKW &&& check_di23_pos,  DI23, 0:0:0, 0:0:0,,,, CLKW_dly, DI23_dly) ;
      $setuphold( posedge CLKW &&& check_di24_pos,  DI24, 0:0:0, 0:0:0,,,, CLKW_dly, DI24_dly) ;
      $setuphold( posedge CLKW &&& check_di25_pos,  DI25, 0:0:0, 0:0:0,,,, CLKW_dly, DI25_dly) ;
      $setuphold( posedge CLKW &&& check_di26_pos,  DI26, 0:0:0, 0:0:0,,,, CLKW_dly, DI26_dly) ;
      $setuphold( posedge CLKW &&& check_di27_pos,  DI27, 0:0:0, 0:0:0,,,, CLKW_dly, DI27_dly) ;
      $setuphold( posedge CLKW &&& check_di28_pos,  DI28, 0:0:0, 0:0:0,,,, CLKW_dly, DI28_dly) ;
      $setuphold( posedge CLKW &&& check_di29_pos,  DI29, 0:0:0, 0:0:0,,,, CLKW_dly, DI29_dly) ;
      $setuphold( posedge CLKW &&& check_di30_pos,  DI30, 0:0:0, 0:0:0,,,, CLKW_dly, DI30_dly) ;
      $setuphold( posedge CLKW &&& check_di31_pos,  DI31, 0:0:0, 0:0:0,,,, CLKW_dly, DI31_dly) ;
      $setuphold( posedge CLKW &&& check_di32_pos,  DI32, 0:0:0, 0:0:0,,,, CLKW_dly, DI32_dly) ;
      $setuphold( posedge CLKW &&& check_di33_pos,  DI33, 0:0:0, 0:0:0,,,, CLKW_dly, DI33_dly) ;
      $setuphold( posedge CLKW &&& check_di34_pos,  DI34, 0:0:0, 0:0:0,,,, CLKW_dly, DI34_dly) ;
      $setuphold( posedge CLKW &&& check_di35_pos,  DI35, 0:0:0, 0:0:0,,,, CLKW_dly, DI35_dly) ;
      $setuphold( posedge CLKW &&& check_we_pos,  WE, 0:0:0, 0:0:0,,,, CLKW_dly, WE_dly) ;
      $setuphold( posedge CLKW &&& check_csw0_pos,  CSW0, 0:0:0, 0:0:0,,,, CLKW_dly, CSW0_dly) ;
      $setuphold( posedge CLKW &&& check_csw1_pos,  CSW1, 0:0:0, 0:0:0,,,, CLKW_dly, CSW1_dly) ;
      $setuphold( posedge CLKW &&& check_fulli_pos,  FULLI, 0:0:0, 0:0:0,,,, CLKW_dly, FULLI_dly) ;
      $setuphold( posedge CLKW &&& check_rst_pos,  RST, 0:0:0, 0:0:0,,,, CLKW_dly, RST_dly) ;
      $setuphold( posedge CLKR &&& check_rprst_pos,  RPRST, 0:0:0, 0:0:0,,,, CLKR_dly, RPRST_dly) ;
      $setuphold( posedge CLKR &&& check_re_pos,  RE, 0:0:0, 0:0:0,,,, CLKR_dly, RE_dly) ;
      $setuphold( posedge CLKR &&& check_csr0_pos,  CSR0, 0:0:0, 0:0:0,,,, CLKR_dly, CSR0_dly) ;
      $setuphold( posedge CLKR &&& check_csr1_pos,  CSR1, 0:0:0, 0:0:0,,,, CLKR_dly, CSR1_dly) ;
      $setuphold( posedge CLKR &&& check_emptyi_pos,  EMPTYI, 0:0:0, 0:0:0,,,, CLKR_dly, EMPTYI_dly) ;

      $setuphold( negedge CLKW &&& check_di0_neg,  DI0, 0:0:0, 0:0:0,,,, CLKW_dly, DI0_dly) ;
      $setuphold( negedge CLKW &&& check_di1_neg,  DI1, 0:0:0, 0:0:0,,,, CLKW_dly, DI1_dly) ;
      $setuphold( negedge CLKW &&& check_di2_neg,  DI2, 0:0:0, 0:0:0,,,, CLKW_dly, DI2_dly) ;
      $setuphold( negedge CLKW &&& check_di3_neg,  DI3, 0:0:0, 0:0:0,,,, CLKW_dly, DI3_dly) ;
      $setuphold( negedge CLKW &&& check_di4_neg,  DI4, 0:0:0, 0:0:0,,,, CLKW_dly, DI4_dly) ;
      $setuphold( negedge CLKW &&& check_di5_neg,  DI5, 0:0:0, 0:0:0,,,, CLKW_dly, DI5_dly) ;
      $setuphold( negedge CLKW &&& check_di6_neg,  DI6, 0:0:0, 0:0:0,,,, CLKW_dly, DI6_dly) ;
      $setuphold( negedge CLKW &&& check_di7_neg,  DI7, 0:0:0, 0:0:0,,,, CLKW_dly, DI7_dly) ;
      $setuphold( negedge CLKW &&& check_di8_neg,  DI8, 0:0:0, 0:0:0,,,, CLKW_dly, DI8_dly) ;
      $setuphold( negedge CLKW &&& check_di9_neg,  DI9, 0:0:0, 0:0:0,,,, CLKW_dly, DI9_dly) ;
      $setuphold( negedge CLKW &&& check_di10_neg,  DI10, 0:0:0, 0:0:0,,,, CLKW_dly, DI10_dly) ;
      $setuphold( negedge CLKW &&& check_di11_neg,  DI11, 0:0:0, 0:0:0,,,, CLKW_dly, DI11_dly) ;
      $setuphold( negedge CLKW &&& check_di12_neg,  DI12, 0:0:0, 0:0:0,,,, CLKW_dly, DI12_dly) ;
      $setuphold( negedge CLKW &&& check_di13_neg,  DI13, 0:0:0, 0:0:0,,,, CLKW_dly, DI13_dly) ;
      $setuphold( negedge CLKW &&& check_di14_neg,  DI14, 0:0:0, 0:0:0,,,, CLKW_dly, DI14_dly) ;
      $setuphold( negedge CLKW &&& check_di15_neg,  DI15, 0:0:0, 0:0:0,,,, CLKW_dly, DI15_dly) ;
      $setuphold( negedge CLKW &&& check_di16_neg,  DI16, 0:0:0, 0:0:0,,,, CLKW_dly, DI16_dly) ;
      $setuphold( negedge CLKW &&& check_di17_neg,  DI17, 0:0:0, 0:0:0,,,, CLKW_dly, DI17_dly) ;
      $setuphold( negedge CLKW &&& check_di18_neg,  DI18, 0:0:0, 0:0:0,,,, CLKW_dly, DI18_dly) ;
      $setuphold( negedge CLKW &&& check_di19_neg,  DI19, 0:0:0, 0:0:0,,,, CLKW_dly, DI19_dly) ;
      $setuphold( negedge CLKW &&& check_di20_neg,  DI20, 0:0:0, 0:0:0,,,, CLKW_dly, DI20_dly) ;
      $setuphold( negedge CLKW &&& check_di21_neg,  DI21, 0:0:0, 0:0:0,,,, CLKW_dly, DI21_dly) ;
      $setuphold( negedge CLKW &&& check_di22_neg,  DI22, 0:0:0, 0:0:0,,,, CLKW_dly, DI22_dly) ;
      $setuphold( negedge CLKW &&& check_di23_neg,  DI23, 0:0:0, 0:0:0,,,, CLKW_dly, DI23_dly) ;
      $setuphold( negedge CLKW &&& check_di24_neg,  DI24, 0:0:0, 0:0:0,,,, CLKW_dly, DI24_dly) ;
      $setuphold( negedge CLKW &&& check_di25_neg,  DI25, 0:0:0, 0:0:0,,,, CLKW_dly, DI25_dly) ;
      $setuphold( negedge CLKW &&& check_di26_neg,  DI26, 0:0:0, 0:0:0,,,, CLKW_dly, DI26_dly) ;
      $setuphold( negedge CLKW &&& check_di27_neg,  DI27, 0:0:0, 0:0:0,,,, CLKW_dly, DI27_dly) ;
      $setuphold( negedge CLKW &&& check_di28_neg,  DI28, 0:0:0, 0:0:0,,,, CLKW_dly, DI28_dly) ;
      $setuphold( negedge CLKW &&& check_di29_neg,  DI29, 0:0:0, 0:0:0,,,, CLKW_dly, DI29_dly) ;
      $setuphold( negedge CLKW &&& check_di30_neg,  DI30, 0:0:0, 0:0:0,,,, CLKW_dly, DI30_dly) ;
      $setuphold( negedge CLKW &&& check_di31_neg,  DI31, 0:0:0, 0:0:0,,,, CLKW_dly, DI31_dly) ;
      $setuphold( negedge CLKW &&& check_di32_neg,  DI32, 0:0:0, 0:0:0,,,, CLKW_dly, DI32_dly) ;
      $setuphold( negedge CLKW &&& check_di33_neg,  DI33, 0:0:0, 0:0:0,,,, CLKW_dly, DI33_dly) ;
      $setuphold( negedge CLKW &&& check_di34_neg,  DI34, 0:0:0, 0:0:0,,,, CLKW_dly, DI34_dly) ;
      $setuphold( negedge CLKW &&& check_di35_neg,  DI35, 0:0:0, 0:0:0,,,, CLKW_dly, DI35_dly) ;
      $setuphold( negedge CLKW &&& check_we_neg,  WE, 0:0:0, 0:0:0,,,, CLKW_dly, WE_dly) ;
      $setuphold( negedge CLKW &&& check_csw0_neg,  CSW0, 0:0:0, 0:0:0,,,, CLKW_dly, CSW0_dly) ;
      $setuphold( negedge CLKW &&& check_csw1_neg,  CSW1, 0:0:0, 0:0:0,,,, CLKW_dly, CSW1_dly) ;
      $setuphold( negedge CLKW &&& check_fulli_neg,  FULLI, 0:0:0, 0:0:0,,,, CLKW_dly, FULLI_dly) ;
      $setuphold( negedge CLKW &&& check_rst_neg,  RST, 0:0:0, 0:0:0,,,, CLKW_dly, RST_dly) ;
      $setuphold( negedge CLKR &&& check_rprst_neg,  RPRST, 0:0:0, 0:0:0,,,, CLKR_dly, RPRST_dly) ;
      $setuphold( negedge CLKR &&& check_re_neg,  RE, 0:0:0, 0:0:0,,,, CLKR_dly, RE_dly) ;
      $setuphold( negedge CLKR &&& check_csr0_neg,  CSR0, 0:0:0, 0:0:0,,,, CLKR_dly, CSR0_dly) ;
      $setuphold( negedge CLKR &&& check_csr1_neg,  CSR1, 0:0:0, 0:0:0,,,, CLKR_dly, CSR1_dly) ;
      $setuphold( negedge CLKR &&& check_emptyi_neg,  EMPTYI, 0:0:0, 0:0:0,,,, CLKR_dly, EMPTYI_dly) ;

      $width (posedge CLKW, 0:0:0);
      $width (negedge CLKW, 0:0:0);
      $width (posedge CLKR, 0:0:0);
      $width (negedge CLKR, 0:0:0);
      $width (posedge RST, 0:0:0);
      $width (negedge RST, 0:0:0);
      $width (posedge RPRST, 0:0:0);
      $width (negedge RPRST, 0:0:0);
   endspecify

endmodule

