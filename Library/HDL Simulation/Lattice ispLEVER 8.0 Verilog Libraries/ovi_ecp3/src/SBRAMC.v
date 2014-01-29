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
`timescale 1ns / 1ps
module SBRAMC (DIA0, DIA1, DIA2, DIA3, DIA4, DIA5, DIA6, DIA7, DIA8,
         DIA9, DIA10, DIA11, DIA12, DIA13, DIA14, DIA15, DIA16, DIA17,
         ADA0, ADA1, ADA2, ADA3, ADA4, ADA5, ADA6, ADA7, ADA8,
         ADA9,  ADA10,  ADA11, ADA12, ADA13,
         CEA, OCEA, CLKA, WEA, CSA0, CSA1, CSA2, RSTA,
         DIB0, DIB1, DIB2, DIB3, DIB4, DIB5, DIB6, DIB7, DIB8,
         DIB9, DIB10, DIB11, DIB12, DIB13, DIB14, DIB15, DIB16, DIB17,
         ADB0, ADB1, ADB2, ADB3, ADB4, ADB5, ADB6, ADB7, ADB8,
         ADB9,  ADB10,  ADB11, ADB12, ADB13,
         CEB, OCEB, CLKB, WEB, CSB0, CSB1, CSB2, RSTB,
         DOA0, DOA1, DOA2, DOA3, DOA4, DOA5, DOA6, DOA7, DOA8,
         DOA9, DOA10, DOA11, DOA12, DOA13, DOA14, DOA15, DOA16, DOA17,
         DOB0, DOB1, DOB2, DOB3, DOB4, DOB5, DOB6, DOB7, DOB8,
         DOB9, DOB10, DOB11, DOB12, DOB13, DOB14, DOB15, DOB16, DOB17);

   parameter  DATA_WIDTH_A = 18;            //1, 2, 4, 9, 18, 36
   parameter  DATA_WIDTH_B = 18;            //1, 2, 4, 9, 18, 36
   parameter  REGMODE_A = "NOREG";          // "NOREG", "OUTREG"
   parameter  REGMODE_B = "NOREG";          // "NOREG", "OUTREG"
   parameter  CSDECODE_A = "0b000";          // "0b000", "0b001", "0b010"......."0b111"
   parameter  CSDECODE_B = "0b000";          // "0b000", "0b001", "0b010"......."0b111"
   parameter  WRITEMODE_A = "NORMAL";       // "NORMAL", "READBEFOREWRITE", "WRITETHROUGH"
   parameter  WRITEMODE_B = "NORMAL";       // "NORMAL", "READBEFOREWRITE", "WRITETHROUGH"
   parameter  GSR = "DISABLED";             //
 
parameter INITVAL_00 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_01 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_02 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_03 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_04 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_05 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_06 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_07 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_08 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_09 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_0A = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_0B = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_0C = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_0D = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_0E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_0F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_10 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_11 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_12 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_13 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_14 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_15 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_16 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_17 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_18 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_19 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_1A = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_1B = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_1C = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_1D = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_1E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_1F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_20 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_21 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_22 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_23 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_24 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_25 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_26 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_27 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_28 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_29 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_2A = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_2B = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_2C = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_2D = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_2E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_2F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_30 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_31 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_32 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_33 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_34 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_35 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_36 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_37 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_38 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_39 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_3A = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_3B = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_3C = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_3D = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_3E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
parameter INITVAL_3F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";

input    DIA0, DIA1, DIA2, DIA3, DIA4, DIA5, DIA6, DIA7, DIA8,
         DIA9, DIA10, DIA11, DIA12, DIA13, DIA14, DIA15, DIA16, DIA17,
         ADA0, ADA1, ADA2, ADA3, ADA4, ADA5, ADA6, ADA7, ADA8,
         ADA9,  ADA10,  ADA11, ADA12, ADA13,
         CEA, OCEA, CLKA, WEA, CSA0, CSA1, CSA2, RSTA,
         DIB0, DIB1, DIB2, DIB3, DIB4, DIB5, DIB6, DIB7, DIB8,
         DIB9, DIB10, DIB11, DIB12, DIB13, DIB14, DIB15, DIB16, DIB17,
         ADB0, ADB1, ADB2, ADB3, ADB4, ADB5, ADB6, ADB7, ADB8,
         ADB9,  ADB10,  ADB11, ADB12, ADB13,
         CEB, OCEB, CLKB, WEB, CSB0, CSB1, CSB2, RSTB;
output   DOA0, DOA1, DOA2, DOA3, DOA4, DOA5, DOA6, DOA7, DOA8,
         DOA9, DOA10, DOA11, DOA12, DOA13, DOA14, DOA15, DOA16, DOA17,
         DOB0, DOB1, DOB2, DOB3, DOB4, DOB5, DOB6, DOB7, DOB8,
         DOB9, DOB10, DOB11, DOB12, DOB13, DOB14, DOB15, DOB16, DOB17;

   parameter  XON = 1'b0;
   parameter  CLKA_NEGEDGE = 1'b0;
   parameter  CLKB_NEGEDGE = 1'b0;
   parameter  CHECK_DIA0 = 1'b0;
   parameter  CHECK_DIA1 = 1'b0;
   parameter  CHECK_DIA2 = 1'b0;
   parameter  CHECK_DIA3 = 1'b0;
   parameter  CHECK_DIA4 = 1'b0;
   parameter  CHECK_DIA5 = 1'b0;
   parameter  CHECK_DIA6 = 1'b0;
   parameter  CHECK_DIA7 = 1'b0;
   parameter  CHECK_DIA8 = 1'b0;
   parameter  CHECK_DIA9 = 1'b0;
   parameter  CHECK_DIA10 = 1'b0;
   parameter  CHECK_DIA11 = 1'b0;
   parameter  CHECK_DIA12 = 1'b0;
   parameter  CHECK_DIA13 = 1'b0;
   parameter  CHECK_DIA14 = 1'b0;
   parameter  CHECK_DIA15 = 1'b0;
   parameter  CHECK_DIA16 = 1'b0;
   parameter  CHECK_DIA17 = 1'b0;
   parameter  CHECK_ADA0 = 1'b0;
   parameter  CHECK_ADA1 = 1'b0;
   parameter  CHECK_ADA2 = 1'b0;
   parameter  CHECK_ADA3 = 1'b0;
   parameter  CHECK_ADA4 = 1'b0;
   parameter  CHECK_ADA5 = 1'b0;
   parameter  CHECK_ADA6 = 1'b0;
   parameter  CHECK_ADA7 = 1'b0;
   parameter  CHECK_ADA8 = 1'b0;
   parameter  CHECK_ADA9 = 1'b0;
   parameter  CHECK_ADA10 = 1'b0;
   parameter  CHECK_ADA11 = 1'b0;
   parameter  CHECK_ADA12 = 1'b0;
   parameter  CHECK_ADA13 = 1'b0;
   parameter  CHECK_CEA = 1'b0;
   parameter  CHECK_OCEA = 1'b0;
   parameter  CHECK_WEA = 1'b0;
   parameter  CHECK_CSA0 = 1'b0;
   parameter  CHECK_CSA1 = 1'b0;
   parameter  CHECK_CSA2 = 1'b0;
   parameter  CHECK_RSTA = 1'b0;

   parameter  CHECK_DIB0 = 1'b0;
   parameter  CHECK_DIB1 = 1'b0;
   parameter  CHECK_DIB2 = 1'b0;
   parameter  CHECK_DIB3 = 1'b0;
   parameter  CHECK_DIB4 = 1'b0;
   parameter  CHECK_DIB5 = 1'b0;
   parameter  CHECK_DIB6 = 1'b0;
   parameter  CHECK_DIB7 = 1'b0;
   parameter  CHECK_DIB8 = 1'b0;
   parameter  CHECK_DIB9 = 1'b0;
   parameter  CHECK_DIB10 = 1'b0;
   parameter  CHECK_DIB11 = 1'b0;
   parameter  CHECK_DIB12 = 1'b0;
   parameter  CHECK_DIB13 = 1'b0;
   parameter  CHECK_DIB14 = 1'b0;
   parameter  CHECK_DIB15 = 1'b0;
   parameter  CHECK_DIB16 = 1'b0;
   parameter  CHECK_DIB17 = 1'b0;
   parameter  CHECK_ADB0 = 1'b0;
   parameter  CHECK_ADB1 = 1'b0;
   parameter  CHECK_ADB2 = 1'b0;
   parameter  CHECK_ADB3 = 1'b0;
   parameter  CHECK_ADB4 = 1'b0;
   parameter  CHECK_ADB5 = 1'b0;
   parameter  CHECK_ADB6 = 1'b0;
   parameter  CHECK_ADB7 = 1'b0;
   parameter  CHECK_ADB8 = 1'b0;
   parameter  CHECK_ADB9 = 1'b0;
   parameter  CHECK_ADB10 = 1'b0;
   parameter  CHECK_ADB11 = 1'b0;
   parameter  CHECK_ADB12 = 1'b0;
   parameter  CHECK_ADB13 = 1'b0;
   parameter  CHECK_CEB = 1'b0;
   parameter  CHECK_OCEB = 1'b0;
   parameter  CHECK_WEB = 1'b0;
   parameter  CHECK_CSB0 = 1'b0;
   parameter  CHECK_CSB1 = 1'b0;
   parameter  CHECK_CSB2 = 1'b0;
   parameter  CHECK_RSTB = 1'b0;

   wire check_dia0, check_dia1, check_dia2, check_dia3, check_dia4, check_dia5, check_dia6, check_dia7, check_dia8;
   wire check_dia9, check_dia10, check_dia11, check_dia12, check_dia13, check_dia14, check_dia15;
   wire check_dia16, check_dia17;
   wire check_ada0, check_ada1, check_ada2, check_ada3, check_ada4, check_ada5, check_ada6, check_ada7;
   wire check_ada8, check_ada9, check_ada10, check_ada11, check_ada12, check_ada13;
   wire check_cea, check_ocea, check_wea, check_csa0, check_csa1, check_csa2, check_rsta; 
   wire check_dib0, check_dib1, check_dib2, check_dib3, check_dib4, check_dib5, check_dib6, check_dib7, check_dib8;
   wire check_dib9, check_dib10, check_dib11, check_dib12, check_dib13, check_dib14, check_dib15;
   wire check_dib16, check_dib17;
   wire check_adb0, check_adb1, check_adb2, check_adb3, check_adb4, check_adb5, check_adb6, check_adb7;
   wire check_adb8, check_adb9, check_adb10, check_adb11, check_adb12, check_adb13; 
   wire check_ceb, check_oceb, check_web, check_csb0, check_csb1, check_csb2, check_rstb;

   assign check_dia0_posedge = CHECK_DIA0 & (!CLKA_NEGEDGE);
   assign check_dia0_negedge = CHECK_DIA0 & (CLKA_NEGEDGE);
   assign check_dia1_posedge = CHECK_DIA1 & (!CLKA_NEGEDGE);
   assign check_dia1_negedge = CHECK_DIA1 & (CLKA_NEGEDGE);
   assign check_dia2_posedge = CHECK_DIA2 & (!CLKA_NEGEDGE);
   assign check_dia2_negedge = CHECK_DIA2 & (CLKA_NEGEDGE);
   assign check_dia3_posedge = CHECK_DIA3 & (!CLKA_NEGEDGE);
   assign check_dia3_negedge = CHECK_DIA3 & (CLKA_NEGEDGE);
   assign check_dia4_posedge = CHECK_DIA4 & (!CLKA_NEGEDGE);
   assign check_dia4_negedge = CHECK_DIA4 & (CLKA_NEGEDGE);
   assign check_dia5_posedge = CHECK_DIA5 & (!CLKA_NEGEDGE);
   assign check_dia5_negedge = CHECK_DIA5 & (CLKA_NEGEDGE);
   assign check_dia6_posedge = CHECK_DIA6 & (!CLKA_NEGEDGE);
   assign check_dia6_negedge = CHECK_DIA6 & (CLKA_NEGEDGE);
   assign check_dia7_posedge = CHECK_DIA7 & (!CLKA_NEGEDGE);
   assign check_dia7_negedge = CHECK_DIA7 & (CLKA_NEGEDGE);
   assign check_dia8_posedge = CHECK_DIA8 & (!CLKA_NEGEDGE);
   assign check_dia8_negedge = CHECK_DIA8 & (CLKA_NEGEDGE);
   assign check_dia9_posedge = CHECK_DIA9 & (!CLKA_NEGEDGE);
   assign check_dia9_negedge = CHECK_DIA9 & (CLKA_NEGEDGE);
   assign check_dia10_posedge = CHECK_DIA10 & (!CLKA_NEGEDGE);
   assign check_dia10_negedge = CHECK_DIA10 & (CLKA_NEGEDGE);
   assign check_dia11_posedge = CHECK_DIA11 & (!CLKA_NEGEDGE);
   assign check_dia11_negedge = CHECK_DIA11 & (CLKA_NEGEDGE);
   assign check_dia12_posedge = CHECK_DIA12 & (!CLKA_NEGEDGE);
   assign check_dia12_negedge = CHECK_DIA12 & (CLKA_NEGEDGE);
   assign check_dia13_posedge = CHECK_DIA13 & (!CLKA_NEGEDGE);
   assign check_dia13_negedge = CHECK_DIA13 & (CLKA_NEGEDGE);
   assign check_dia14_posedge = CHECK_DIA14 & (!CLKA_NEGEDGE);
   assign check_dia14_negedge = CHECK_DIA14 & (CLKA_NEGEDGE);
   assign check_dia15_posedge = CHECK_DIA15 & (!CLKA_NEGEDGE);
   assign check_dia15_negedge = CHECK_DIA15 & (CLKA_NEGEDGE);
   assign check_dia16_posedge = CHECK_DIA16 & (!CLKA_NEGEDGE);
   assign check_dia16_negedge = CHECK_DIA16 & (CLKA_NEGEDGE);
   assign check_dia17_posedge = CHECK_DIA17 & (!CLKA_NEGEDGE);
   assign check_dia17_negedge = CHECK_DIA17 & (CLKA_NEGEDGE);
   assign check_ada0_posedge = CHECK_ADA0 & (!CLKA_NEGEDGE);
   assign check_ada0_negedge = CHECK_ADA0 & (CLKA_NEGEDGE);
   assign check_ada1_posedge = CHECK_ADA1 & (!CLKA_NEGEDGE);
   assign check_ada1_negedge = CHECK_ADA1 & (CLKA_NEGEDGE);
   assign check_ada2_posedge = CHECK_ADA2 & (!CLKA_NEGEDGE);
   assign check_ada2_negedge = CHECK_ADA2 & (CLKA_NEGEDGE);
   assign check_ada3_posedge = CHECK_ADA3 & (!CLKA_NEGEDGE);
   assign check_ada3_negedge = CHECK_ADA3 & (CLKA_NEGEDGE);
   assign check_ada4_posedge = CHECK_ADA4 & (!CLKA_NEGEDGE);
   assign check_ada4_negedge = CHECK_ADA4 & (CLKA_NEGEDGE);
   assign check_ada5_posedge = CHECK_ADA5 & (!CLKA_NEGEDGE);
   assign check_ada5_negedge = CHECK_ADA5 & (CLKA_NEGEDGE);
   assign check_ada6_posedge = CHECK_ADA6 & (!CLKA_NEGEDGE);
   assign check_ada6_negedge = CHECK_ADA6 & (CLKA_NEGEDGE);
   assign check_ada7_posedge = CHECK_ADA7 & (!CLKA_NEGEDGE);
   assign check_ada7_negedge = CHECK_ADA7 & (CLKA_NEGEDGE);
   assign check_ada8_posedge = CHECK_ADA8 & (!CLKA_NEGEDGE);
   assign check_ada8_negedge = CHECK_ADA8 & (CLKA_NEGEDGE);
   assign check_ada9_posedge = CHECK_ADA9 & (!CLKA_NEGEDGE);
   assign check_ada9_negedge = CHECK_ADA9 & (CLKA_NEGEDGE);
   assign check_ada10_posedge = CHECK_ADA10 & (!CLKA_NEGEDGE);
   assign check_ada10_negedge = CHECK_ADA10 & (CLKA_NEGEDGE);
   assign check_ada11_posedge = CHECK_ADA11 & (!CLKA_NEGEDGE);
   assign check_ada11_negedge = CHECK_ADA11 & (CLKA_NEGEDGE);
   assign check_ada12_posedge = CHECK_ADA12 & (!CLKA_NEGEDGE);
   assign check_ada12_negedge = CHECK_ADA12 & (CLKA_NEGEDGE);
   assign check_ada13_posedge = CHECK_ADA13 & (!CLKA_NEGEDGE);
   assign check_ada13_negedge = CHECK_ADA13 & (CLKA_NEGEDGE);
   assign check_cea_posedge = CHECK_CEA & (!CLKA_NEGEDGE);
   assign check_cea_negedge = CHECK_CEA & (CLKA_NEGEDGE);
   assign check_ocea_posedge = CHECK_OCEA & (!CLKA_NEGEDGE);
   assign check_ocea_negedge = CHECK_OCEA & (CLKA_NEGEDGE);
   assign check_wea_posedge = CHECK_WEA & (!CLKA_NEGEDGE);
   assign check_wea_negedge = CHECK_WEA & (CLKA_NEGEDGE);
   assign check_csa0_posedge = CHECK_CSA0 & (!CLKA_NEGEDGE);
   assign check_csa0_negedge = CHECK_CSA0 & (CLKA_NEGEDGE);
   assign check_csa1_posedge = CHECK_CSA1 & (!CLKA_NEGEDGE);
   assign check_csa1_negedge = CHECK_CSA1 & (CLKA_NEGEDGE);
   assign check_csa2_posedge = CHECK_CSA2 & (!CLKA_NEGEDGE);
   assign check_csa2_negedge = CHECK_CSA2 & (CLKA_NEGEDGE);
   assign check_rsta_posedge = CHECK_RSTA & (!CLKA_NEGEDGE);
   assign check_rsta_negedge = CHECK_RSTA & (CLKA_NEGEDGE);

   assign check_dib0_posedge = CHECK_DIB0 & (!CLKB_NEGEDGE);
   assign check_dib0_negedge = CHECK_DIB0 & (CLKB_NEGEDGE);
   assign check_dib1_posedge = CHECK_DIB1 & (!CLKB_NEGEDGE);
   assign check_dib1_negedge = CHECK_DIB1 & (CLKB_NEGEDGE);
   assign check_dib2_posedge = CHECK_DIB2 & (!CLKB_NEGEDGE);
   assign check_dib2_negedge = CHECK_DIB2 & (CLKB_NEGEDGE);
   assign check_dib3_posedge = CHECK_DIB3 & (!CLKB_NEGEDGE);
   assign check_dib3_negedge = CHECK_DIB3 & (CLKB_NEGEDGE);
   assign check_dib4_posedge = CHECK_DIB4 & (!CLKB_NEGEDGE);
   assign check_dib4_negedge = CHECK_DIB4 & (CLKB_NEGEDGE);
   assign check_dib5_posedge = CHECK_DIB5 & (!CLKB_NEGEDGE);
   assign check_dib5_negedge = CHECK_DIB5 & (CLKB_NEGEDGE);
   assign check_dib6_posedge = CHECK_DIB6 & (!CLKB_NEGEDGE);
   assign check_dib6_negedge = CHECK_DIB6 & (CLKB_NEGEDGE);
   assign check_dib7_posedge = CHECK_DIB7 & (!CLKB_NEGEDGE);
   assign check_dib7_negedge = CHECK_DIB7 & (CLKB_NEGEDGE);
   assign check_dib8_posedge = CHECK_DIB8 & (!CLKB_NEGEDGE);
   assign check_dib8_negedge = CHECK_DIB8 & (CLKB_NEGEDGE);
   assign check_dib9_posedge = CHECK_DIB9 & (!CLKB_NEGEDGE);
   assign check_dib9_negedge = CHECK_DIB9 & (CLKB_NEGEDGE);
   assign check_dib10_posedge = CHECK_DIB10 & (!CLKB_NEGEDGE);
   assign check_dib10_negedge = CHECK_DIB10 & (CLKB_NEGEDGE);
   assign check_dib11_posedge = CHECK_DIB11 & (!CLKB_NEGEDGE);
   assign check_dib11_negedge = CHECK_DIB11 & (CLKB_NEGEDGE);
   assign check_dib12_posedge = CHECK_DIB12 & (!CLKB_NEGEDGE);
   assign check_dib12_negedge = CHECK_DIB12 & (CLKB_NEGEDGE);
   assign check_dib13_posedge = CHECK_DIB13 & (!CLKB_NEGEDGE);
   assign check_dib13_negedge = CHECK_DIB13 & (CLKB_NEGEDGE);
   assign check_dib14_posedge = CHECK_DIB14 & (!CLKB_NEGEDGE);
   assign check_dib14_negedge = CHECK_DIB14 & (CLKB_NEGEDGE);
   assign check_dib15_posedge = CHECK_DIB15 & (!CLKB_NEGEDGE);
   assign check_dib15_negedge = CHECK_DIB15 & (CLKB_NEGEDGE);
   assign check_dib16_posedge = CHECK_DIB16 & (!CLKB_NEGEDGE);
   assign check_dib16_negedge = CHECK_DIB16 & (CLKB_NEGEDGE);
   assign check_dib17_posedge = CHECK_DIB17 & (!CLKB_NEGEDGE);
   assign check_dib17_negedge = CHECK_DIB17 & (CLKB_NEGEDGE);
   assign check_adb0_posedge = CHECK_ADB0 & (!CLKB_NEGEDGE);
   assign check_adb0_negedge = CHECK_ADB0 & (CLKB_NEGEDGE);
   assign check_adb1_posedge = CHECK_ADB1 & (!CLKB_NEGEDGE);
   assign check_adb1_negedge = CHECK_ADB1 & (CLKB_NEGEDGE);
   assign check_adb2_posedge = CHECK_ADB2 & (!CLKB_NEGEDGE);
   assign check_adb2_negedge = CHECK_ADB2 & (CLKB_NEGEDGE);
   assign check_adb3_posedge = CHECK_ADB3 & (!CLKB_NEGEDGE);
   assign check_adb3_negedge = CHECK_ADB3 & (CLKB_NEGEDGE);
   assign check_adb4_posedge = CHECK_ADB4 & (!CLKB_NEGEDGE);
   assign check_adb4_negedge = CHECK_ADB4 & (CLKB_NEGEDGE);
   assign check_adb5_posedge = CHECK_ADB5 & (!CLKB_NEGEDGE);
   assign check_adb5_negedge = CHECK_ADB5 & (CLKB_NEGEDGE);
   assign check_adb6_posedge = CHECK_ADB6 & (!CLKB_NEGEDGE);
   assign check_adb6_negedge = CHECK_ADB6 & (CLKB_NEGEDGE);
   assign check_adb7_posedge = CHECK_ADB7 & (!CLKB_NEGEDGE);
   assign check_adb7_negedge = CHECK_ADB7 & (CLKB_NEGEDGE);
   assign check_adb8_posedge = CHECK_ADB8 & (!CLKB_NEGEDGE);
   assign check_adb8_negedge = CHECK_ADB8 & (CLKB_NEGEDGE);
   assign check_adb9_posedge = CHECK_ADB9 & (!CLKB_NEGEDGE);
   assign check_adb9_negedge = CHECK_ADB9 & (CLKB_NEGEDGE);
   assign check_adb10_posedge = CHECK_ADB10 & (!CLKB_NEGEDGE);
   assign check_adb10_negedge = CHECK_ADB10 & (CLKB_NEGEDGE);
   assign check_adb11_posedge = CHECK_ADB11 & (!CLKB_NEGEDGE);
   assign check_adb11_negedge = CHECK_ADB11 & (CLKB_NEGEDGE);
   assign check_adb12_posedge = CHECK_ADB12 & (!CLKB_NEGEDGE);
   assign check_adb12_negedge = CHECK_ADB12 & (CLKB_NEGEDGE);
   assign check_adb13_posedge = CHECK_ADB13 & (!CLKB_NEGEDGE);
   assign check_adb13_negedge = CHECK_ADB13 & (CLKB_NEGEDGE);
   assign check_ceb_posedge = CHECK_CEB & (!CLKB_NEGEDGE);
   assign check_ceb_negedge = CHECK_CEB & (CLKB_NEGEDGE);
   assign check_oceb_posedge = CHECK_OCEB & (!CLKB_NEGEDGE);
   assign check_oceb_negedge = CHECK_OCEB & (CLKB_NEGEDGE);
   assign check_web_posedge = CHECK_WEB & (!CLKB_NEGEDGE);
   assign check_web_negedge = CHECK_WEB & (CLKB_NEGEDGE);
   assign check_csb0_posedge = CHECK_CSB0 & (!CLKB_NEGEDGE);
   assign check_csb0_negedge = CHECK_CSB0 & (CLKB_NEGEDGE);
   assign check_csb1_posedge = CHECK_CSB1 & (!CLKB_NEGEDGE);
   assign check_csb1_negedge = CHECK_CSB1 & (CLKB_NEGEDGE);
   assign check_csb2_posedge = CHECK_CSB2 & (!CLKB_NEGEDGE);
   assign check_csb2_negedge = CHECK_CSB2 & (CLKB_NEGEDGE);
   assign check_rstb_posedge = CHECK_RSTB & (!CLKB_NEGEDGE);
   assign check_rstb_negedge = CHECK_RSTB & (CLKB_NEGEDGE);

   assign check_dib0_clka_posedge = CHECK_DIB0 & (!CLKA_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib0_clka_negedge = CHECK_DIB0 & (CLKA_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib1_clka_posedge = CHECK_DIB1 & (!CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib1_clka_negedge = CHECK_DIB1 & (CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib2_clka_posedge = CHECK_DIB2 & (!CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib2_clka_negedge = CHECK_DIB2 & (CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib3_clka_posedge = CHECK_DIB3 & (!CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib3_clka_negedge = CHECK_DIB3 & (CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib4_clka_posedge = CHECK_DIB4 & (!CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib4_clka_negedge = CHECK_DIB4 & (CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib5_clka_posedge = CHECK_DIB5 & (!CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib5_clka_negedge = CHECK_DIB5 & (CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib6_clka_posedge = CHECK_DIB6 & (!CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib6_clka_negedge = CHECK_DIB6 & (CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib7_clka_posedge = CHECK_DIB7 & (!CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib7_clka_negedge = CHECK_DIB7 & (CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib8_clka_posedge = CHECK_DIB8 & (!CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib8_clka_negedge = CHECK_DIB8 & (CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib9_clka_posedge = CHECK_DIB9 & (!CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib9_clka_negedge = CHECK_DIB9 & (CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib10_clka_posedge = CHECK_DIB10 & (!CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib10_clka_negedge = CHECK_DIB10 & (CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib11_clka_posedge = CHECK_DIB11 & (!CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib11_clka_negedge = CHECK_DIB11 & (CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib12_clka_posedge = CHECK_DIB12 & (!CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib12_clka_negedge = CHECK_DIB12 & (CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib13_clka_posedge = CHECK_DIB13 & (!CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib13_clka_negedge = CHECK_DIB13 & (CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib14_clka_posedge = CHECK_DIB14 & (!CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib14_clka_negedge = CHECK_DIB14 & (CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib15_clka_posedge = CHECK_DIB15 & (!CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib15_clka_negedge = CHECK_DIB15 & (CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib16_clka_posedge = CHECK_DIB16 & (!CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib16_clka_negedge = CHECK_DIB16 & (CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib17_clka_posedge = CHECK_DIB17 & (!CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);
   assign check_dib17_clka_negedge = CHECK_DIB17 & (CLKB_NEGEDGE) & ((DATA_WIDTH_A == 36) ? 1'b1 : 1'b0);

   buf (DOA0, DOA0_dly);
   buf (DOA1, DOA1_dly);
   buf (DOA2, DOA2_dly);
   buf (DOA3, DOA3_dly);
   buf (DOA4, DOA4_dly);
   buf (DOA5, DOA5_dly);
   buf (DOA6, DOA6_dly);
   buf (DOA7, DOA7_dly);
   buf (DOA8, DOA8_dly);
   buf (DOA9, DOA9_dly);
   buf (DOA10, DOA10_dly);
   buf (DOA11, DOA11_dly);
   buf (DOA12, DOA12_dly);
   buf (DOA13, DOA13_dly);
   buf (DOA14, DOA14_dly);
   buf (DOA15, DOA15_dly);
   buf (DOA16, DOA16_dly);
   buf (DOA17, DOA17_dly);
   buf (DOB0, DOB0_dly);
   buf (DOB1, DOB1_dly);
   buf (DOB2, DOB2_dly);
   buf (DOB3, DOB3_dly);
   buf (DOB4, DOB4_dly);
   buf (DOB5, DOB5_dly);
   buf (DOB6, DOB6_dly);
   buf (DOB7, DOB7_dly);
   buf (DOB8, DOB8_dly);
   buf (DOB9, DOB9_dly);
   buf (DOB10, DOB10_dly);
   buf (DOB11, DOB11_dly);
   buf (DOB12, DOB12_dly);
   buf (DOB13, DOB13_dly);
   buf (DOB14, DOB14_dly);
   buf (DOB15, DOB15_dly);
   buf (DOB16, DOB16_dly);
   buf (DOB17, DOB17_dly);


   defparam DP16KC_INST.DATA_WIDTH_A = DATA_WIDTH_A;
   defparam DP16KC_INST.DATA_WIDTH_B = DATA_WIDTH_B;
   defparam DP16KC_INST.REGMODE_A = REGMODE_A;
   defparam DP16KC_INST.REGMODE_B = REGMODE_B;
   defparam DP16KC_INST.CSDECODE_A = CSDECODE_A;
   defparam DP16KC_INST.CSDECODE_B = CSDECODE_B;
   defparam DP16KC_INST.WRITEMODE_A = WRITEMODE_A;
   defparam DP16KC_INST.WRITEMODE_B = WRITEMODE_B;
   defparam DP16KC_INST.GSR = GSR;

   defparam DP16KC_INST.INITVAL_00 = INITVAL_00;
   defparam DP16KC_INST.INITVAL_01 = INITVAL_01;
   defparam DP16KC_INST.INITVAL_02 = INITVAL_02;
   defparam DP16KC_INST.INITVAL_03 = INITVAL_03;
   defparam DP16KC_INST.INITVAL_04 = INITVAL_04;
   defparam DP16KC_INST.INITVAL_05 = INITVAL_05;
   defparam DP16KC_INST.INITVAL_06 = INITVAL_06;
   defparam DP16KC_INST.INITVAL_07 = INITVAL_07;
   defparam DP16KC_INST.INITVAL_08 = INITVAL_08;
   defparam DP16KC_INST.INITVAL_09 = INITVAL_09;
   defparam DP16KC_INST.INITVAL_0A = INITVAL_0A;
   defparam DP16KC_INST.INITVAL_0B = INITVAL_0B;
   defparam DP16KC_INST.INITVAL_0C = INITVAL_0C;
   defparam DP16KC_INST.INITVAL_0D = INITVAL_0D;
   defparam DP16KC_INST.INITVAL_0E = INITVAL_0E;
   defparam DP16KC_INST.INITVAL_0F = INITVAL_0F;
   defparam DP16KC_INST.INITVAL_10 = INITVAL_10;
   defparam DP16KC_INST.INITVAL_11 = INITVAL_11;
   defparam DP16KC_INST.INITVAL_12 = INITVAL_12;
   defparam DP16KC_INST.INITVAL_13 = INITVAL_13;
   defparam DP16KC_INST.INITVAL_14 = INITVAL_14;
   defparam DP16KC_INST.INITVAL_15 = INITVAL_15;
   defparam DP16KC_INST.INITVAL_16 = INITVAL_16;
   defparam DP16KC_INST.INITVAL_17 = INITVAL_17;
   defparam DP16KC_INST.INITVAL_18 = INITVAL_18;
   defparam DP16KC_INST.INITVAL_19 = INITVAL_19;
   defparam DP16KC_INST.INITVAL_1A = INITVAL_1A;
   defparam DP16KC_INST.INITVAL_1B = INITVAL_1B;
   defparam DP16KC_INST.INITVAL_1C = INITVAL_1C;
   defparam DP16KC_INST.INITVAL_1D = INITVAL_1D;
   defparam DP16KC_INST.INITVAL_1E = INITVAL_1E;
   defparam DP16KC_INST.INITVAL_1F = INITVAL_1F;
   defparam DP16KC_INST.INITVAL_20 = INITVAL_20;
   defparam DP16KC_INST.INITVAL_21 = INITVAL_21;
   defparam DP16KC_INST.INITVAL_22 = INITVAL_22;
   defparam DP16KC_INST.INITVAL_23 = INITVAL_23;
   defparam DP16KC_INST.INITVAL_24 = INITVAL_24;
   defparam DP16KC_INST.INITVAL_25 = INITVAL_25;
   defparam DP16KC_INST.INITVAL_26 = INITVAL_26;
   defparam DP16KC_INST.INITVAL_27 = INITVAL_27;
   defparam DP16KC_INST.INITVAL_28 = INITVAL_28;
   defparam DP16KC_INST.INITVAL_29 = INITVAL_29;
   defparam DP16KC_INST.INITVAL_2A = INITVAL_2A;
   defparam DP16KC_INST.INITVAL_2B = INITVAL_2B;
   defparam DP16KC_INST.INITVAL_2C = INITVAL_2C;
   defparam DP16KC_INST.INITVAL_2D = INITVAL_2D;
   defparam DP16KC_INST.INITVAL_2E = INITVAL_2E;
   defparam DP16KC_INST.INITVAL_2F = INITVAL_2F;
   defparam DP16KC_INST.INITVAL_30 = INITVAL_30;
   defparam DP16KC_INST.INITVAL_31 = INITVAL_31;
   defparam DP16KC_INST.INITVAL_32 = INITVAL_32;
   defparam DP16KC_INST.INITVAL_33 = INITVAL_33;
   defparam DP16KC_INST.INITVAL_34 = INITVAL_34;
   defparam DP16KC_INST.INITVAL_35 = INITVAL_35;
   defparam DP16KC_INST.INITVAL_36 = INITVAL_36;
   defparam DP16KC_INST.INITVAL_37 = INITVAL_37;
   defparam DP16KC_INST.INITVAL_38 = INITVAL_38;
   defparam DP16KC_INST.INITVAL_39 = INITVAL_39;
   defparam DP16KC_INST.INITVAL_3A = INITVAL_3A;
   defparam DP16KC_INST.INITVAL_3B = INITVAL_3B;
   defparam DP16KC_INST.INITVAL_3C = INITVAL_3C;
   defparam DP16KC_INST.INITVAL_3D = INITVAL_3D;
   defparam DP16KC_INST.INITVAL_3E = INITVAL_3E;
   defparam DP16KC_INST.INITVAL_3F = INITVAL_3F;

   DP16KC DP16KC_INST (.DIA0(DIA0_dly),
                       .DIA1(DIA1_dly),
                       .DIA2(DIA2_dly),
                       .DIA3(DIA3_dly),
                       .DIA4(DIA4_dly),
                       .DIA5(DIA5_dly),
                       .DIA6(DIA6_dly),
                       .DIA7(DIA7_dly),
                       .DIA8(DIA8_dly),
                       .DIA9(DIA9_dly),
                       .DIA10(DIA10_dly),
                       .DIA11(DIA11_dly),
                       .DIA12(DIA12_dly),
                       .DIA13(DIA13_dly),
                       .DIA14(DIA14_dly),
                       .DIA15(DIA15_dly),
                       .DIA16(DIA16_dly),
                       .DIA17(DIA17_dly),
                       .ADA0(ADA0_dly),
                       .ADA1(ADA1_dly),
                       .ADA2(ADA2_dly),
                       .ADA3(ADA3_dly),
                       .ADA4(ADA4_dly),
                       .ADA5(ADA5_dly),
                       .ADA6(ADA6_dly),
                       .ADA7(ADA7_dly),
                       .ADA8(ADA8_dly),
                       .ADA9(ADA9_dly),
                       .ADA10(ADA10_dly),
                       .ADA11(ADA11_dly),
                       .ADA12(ADA12_dly),
                       .ADA13(ADA13_dly),
                       .CEA(CEA_dly),
                       .OCEA(OCEA_dly),
                       .CLKA(CLKA_dly),
                       .WEA(WEA_dly),
                       .CSA0(CSA0_dly),
                       .CSA1(CSA1_dly),
                       .CSA2(CSA2_dly),
                       .RSTA(RSTA_dly),
                       .DIB0(DIB0_dly),
                       .DIB1(DIB1_dly),
                       .DIB2(DIB2_dly),
                       .DIB3(DIB3_dly),
                       .DIB4(DIB4_dly),
                       .DIB5(DIB5_dly),
                       .DIB6(DIB6_dly),
                       .DIB7(DIB7_dly),
                       .DIB8(DIB8_dly),
                       .DIB9(DIB9_dly),
                       .DIB10(DIB10_dly),
                       .DIB11(DIB11_dly),
                       .DIB12(DIB12_dly),
                       .DIB13(DIB13_dly),
                       .DIB14(DIB14_dly),
                       .DIB15(DIB15_dly),
                       .DIB16(DIB16_dly),
                       .DIB17(DIB17_dly),
                       .ADB0(ADB0_dly),
                       .ADB1(ADB1_dly),
                       .ADB2(ADB2_dly),
                       .ADB3(ADB3_dly),
                       .ADB4(ADB4_dly),
                       .ADB5(ADB5_dly),
                       .ADB6(ADB6_dly),
                       .ADB7(ADB7_dly),
                       .ADB8(ADB8_dly),
                       .ADB9(ADB9_dly),
                       .ADB10(ADB10_dly),
                       .ADB11(ADB11_dly),
                       .ADB12(ADB12_dly),
                       .ADB13(ADB13_dly),
                       .CEB(CEB_dly),
                       .OCEB(OCEB_dly),
                       .CLKB(CLKB_dly),
                       .WEB(WEB_dly),
                       .CSB0(CSB0_dly),
                       .CSB1(CSB1_dly),
                       .CSB2(CSB2_dly),
                       .RSTB(RSTB_dly),
                       .DOA0(DOA0_dly),
                       .DOA1(DOA1_dly),
                       .DOA2(DOA2_dly),
                       .DOA3(DOA3_dly),
                       .DOA4(DOA4_dly),
                       .DOA5(DOA5_dly),
                       .DOA6(DOA6_dly),
                       .DOA7(DOA7_dly),
                       .DOA8(DOA8_dly),
                       .DOA9(DOA9_dly),
                       .DOA10(DOA10_dly),
                       .DOA11(DOA11_dly),
                       .DOA12(DOA12_dly),
                       .DOA13(DOA13_dly),
                       .DOA14(DOA14_dly),
                       .DOA15(DOA15_dly),
                       .DOA16(DOA16_dly),
                       .DOA17(DOA17_dly),
                       .DOB0(DOB0_dly),
                       .DOB1(DOB1_dly),
                       .DOB2(DOB2_dly),
                       .DOB3(DOB3_dly),
                       .DOB4(DOB4_dly),
                       .DOB5(DOB5_dly),
                       .DOB6(DOB6_dly),
                       .DOB7(DOB7_dly),
                       .DOB8(DOB8_dly),
                       .DOB9(DOB9_dly),
                       .DOB10(DOB10_dly),
                       .DOB11(DOB11_dly),
                       .DOB12(DOB12_dly),
                       .DOB13(DOB13_dly),
                       .DOB14(DOB14_dly),
                       .DOB15(DOB15_dly),
                       .DOB16(DOB16_dly),
                       .DOB17(DOB17_dly));


   specify

      (CLKA => DOA0) = (0:0:0,0:0:0);
      (CLKA => DOA1) = (0:0:0,0:0:0);
      (CLKA => DOA2) = (0:0:0,0:0:0);
      (CLKA => DOA3) = (0:0:0,0:0:0);
      (CLKA => DOA4) = (0:0:0,0:0:0);
      (CLKA => DOA5) = (0:0:0,0:0:0);
      (CLKA => DOA6) = (0:0:0,0:0:0);
      (CLKA => DOA7) = (0:0:0,0:0:0);
      (CLKA => DOA8) = (0:0:0,0:0:0);
      (CLKA => DOA9) = (0:0:0,0:0:0);
      (CLKA => DOA10) = (0:0:0,0:0:0);
      (CLKA => DOA11) = (0:0:0,0:0:0);
      (CLKA => DOA12) = (0:0:0,0:0:0);
      (CLKA => DOA13) = (0:0:0,0:0:0);
      (CLKA => DOA14) = (0:0:0,0:0:0);
      (CLKA => DOA15) = (0:0:0,0:0:0);
      (CLKA => DOA16) = (0:0:0,0:0:0);
      (CLKA => DOA17) = (0:0:0,0:0:0);
      (CLKB => DOB0) = (0:0:0,0:0:0);
      (CLKB => DOB1) = (0:0:0,0:0:0);
      (CLKB => DOB2) = (0:0:0,0:0:0);
      (CLKB => DOB3) = (0:0:0,0:0:0);
      (CLKB => DOB4) = (0:0:0,0:0:0);
      (CLKB => DOB5) = (0:0:0,0:0:0);
      (CLKB => DOB6) = (0:0:0,0:0:0);
      (CLKB => DOB7) = (0:0:0,0:0:0);
      (CLKB => DOB8) = (0:0:0,0:0:0);
      (CLKB => DOB9) = (0:0:0,0:0:0);
      (CLKB => DOB10) = (0:0:0,0:0:0);
      (CLKB => DOB11) = (0:0:0,0:0:0);
      (CLKB => DOB12) = (0:0:0,0:0:0);
      (CLKB => DOB13) = (0:0:0,0:0:0);
      (CLKB => DOB14) = (0:0:0,0:0:0);
      (CLKB => DOB15) = (0:0:0,0:0:0);
      (CLKB => DOB16) = (0:0:0,0:0:0);
      (CLKB => DOB17) = (0:0:0,0:0:0);
      (CLKB => DOA0) = (0:0:0,0:0:0);
      (CLKB => DOA1) = (0:0:0,0:0:0);
      (CLKB => DOA2) = (0:0:0,0:0:0);
      (CLKB => DOA3) = (0:0:0,0:0:0);
      (CLKB => DOA4) = (0:0:0,0:0:0);
      (CLKB => DOA5) = (0:0:0,0:0:0);
      (CLKB => DOA6) = (0:0:0,0:0:0);
      (CLKB => DOA7) = (0:0:0,0:0:0);
      (CLKB => DOA8) = (0:0:0,0:0:0);
      (CLKB => DOA9) = (0:0:0,0:0:0);
      (CLKB => DOA10) = (0:0:0,0:0:0);
      (CLKB => DOA11) = (0:0:0,0:0:0);
      (CLKB => DOA12) = (0:0:0,0:0:0);
      (CLKB => DOA13) = (0:0:0,0:0:0);
      (CLKB => DOA14) = (0:0:0,0:0:0);
      (CLKB => DOA15) = (0:0:0,0:0:0);
      (CLKB => DOA16) = (0:0:0,0:0:0);
      (CLKB => DOA17) = (0:0:0,0:0:0);
      (RSTA => DOA0) = (0:0:0,0:0:0);
      (RSTA => DOA1) = (0:0:0,0:0:0);
      (RSTA => DOA2) = (0:0:0,0:0:0);
      (RSTA => DOA3) = (0:0:0,0:0:0);
      (RSTA => DOA4) = (0:0:0,0:0:0);
      (RSTA => DOA5) = (0:0:0,0:0:0);
      (RSTA => DOA6) = (0:0:0,0:0:0);
      (RSTA => DOA7) = (0:0:0,0:0:0);
      (RSTA => DOA8) = (0:0:0,0:0:0);
      (RSTA => DOA9) = (0:0:0,0:0:0);
      (RSTA => DOA10) = (0:0:0,0:0:0);
      (RSTA => DOA11) = (0:0:0,0:0:0);
      (RSTA => DOA12) = (0:0:0,0:0:0);
      (RSTA => DOA13) = (0:0:0,0:0:0);
      (RSTA => DOA14) = (0:0:0,0:0:0);
      (RSTA => DOA15) = (0:0:0,0:0:0);
      (RSTA => DOA16) = (0:0:0,0:0:0);
      (RSTA => DOA17) = (0:0:0,0:0:0);
      (RSTB => DOB0) = (0:0:0,0:0:0);
      (RSTB => DOB1) = (0:0:0,0:0:0);
      (RSTB => DOB2) = (0:0:0,0:0:0);
      (RSTB => DOB3) = (0:0:0,0:0:0);
      (RSTB => DOB4) = (0:0:0,0:0:0);
      (RSTB => DOB5) = (0:0:0,0:0:0);
      (RSTB => DOB6) = (0:0:0,0:0:0);
      (RSTB => DOB7) = (0:0:0,0:0:0);
      (RSTB => DOB8) = (0:0:0,0:0:0);
      (RSTB => DOB9) = (0:0:0,0:0:0);
      (RSTB => DOB10) = (0:0:0,0:0:0);
      (RSTB => DOB11) = (0:0:0,0:0:0);
      (RSTB => DOB12) = (0:0:0,0:0:0);
      (RSTB => DOB13) = (0:0:0,0:0:0);
      (RSTB => DOB14) = (0:0:0,0:0:0);
      (RSTB => DOB15) = (0:0:0,0:0:0);
      (RSTB => DOB16) = (0:0:0,0:0:0);
      (RSTB => DOB17) = (0:0:0,0:0:0);
      (RSTB => DOA0) = (0:0:0,0:0:0);
      (RSTB => DOA1) = (0:0:0,0:0:0);
      (RSTB => DOA2) = (0:0:0,0:0:0);
      (RSTB => DOA3) = (0:0:0,0:0:0);
      (RSTB => DOA4) = (0:0:0,0:0:0);
      (RSTB => DOA5) = (0:0:0,0:0:0);
      (RSTB => DOA6) = (0:0:0,0:0:0);
      (RSTB => DOA7) = (0:0:0,0:0:0);
      (RSTB => DOA8) = (0:0:0,0:0:0);
      (RSTB => DOA9) = (0:0:0,0:0:0);
      (RSTB => DOA10) = (0:0:0,0:0:0);
      (RSTB => DOA11) = (0:0:0,0:0:0);
      (RSTB => DOA12) = (0:0:0,0:0:0);
      (RSTB => DOA13) = (0:0:0,0:0:0);
      (RSTB => DOA14) = (0:0:0,0:0:0);
      (RSTB => DOA15) = (0:0:0,0:0:0);
      (RSTB => DOA16) = (0:0:0,0:0:0);
      (RSTB => DOA17) = (0:0:0,0:0:0);

      $setuphold( posedge CLKA &&& check_dia0_posedge,  DIA0, 0:0:0, 0:0:0,,,, CLKA_dly, DIA0_dly) ;
      $setuphold( posedge CLKA &&& check_dia1_posedge,  DIA1, 0:0:0, 0:0:0,,,, CLKA_dly, DIA1_dly) ;
      $setuphold( posedge CLKA &&& check_dia2_posedge,  DIA2, 0:0:0, 0:0:0,,,, CLKA_dly, DIA2_dly) ;
      $setuphold( posedge CLKA &&& check_dia3_posedge,  DIA3, 0:0:0, 0:0:0,,,, CLKA_dly, DIA3_dly) ;
      $setuphold( posedge CLKA &&& check_dia4_posedge,  DIA4, 0:0:0, 0:0:0,,,, CLKA_dly, DIA4_dly) ;
      $setuphold( posedge CLKA &&& check_dia5_posedge,  DIA5, 0:0:0, 0:0:0,,,, CLKA_dly, DIA5_dly) ;
      $setuphold( posedge CLKA &&& check_dia6_posedge,  DIA6, 0:0:0, 0:0:0,,,, CLKA_dly, DIA6_dly) ;
      $setuphold( posedge CLKA &&& check_dia7_posedge,  DIA7, 0:0:0, 0:0:0,,,, CLKA_dly, DIA7_dly) ;
      $setuphold( posedge CLKA &&& check_dia8_posedge,  DIA8, 0:0:0, 0:0:0,,,, CLKA_dly, DIA8_dly) ;
      $setuphold( posedge CLKA &&& check_dia9_posedge,  DIA9, 0:0:0, 0:0:0,,,, CLKA_dly, DIA9_dly) ;
      $setuphold( posedge CLKA &&& check_dia10_posedge,  DIA10, 0:0:0, 0:0:0,,,, CLKA_dly, DIA10_dly) ;
      $setuphold( posedge CLKA &&& check_dia11_posedge,  DIA11, 0:0:0, 0:0:0,,,, CLKA_dly, DIA11_dly) ;
      $setuphold( posedge CLKA &&& check_dia12_posedge,  DIA12, 0:0:0, 0:0:0,,,, CLKA_dly, DIA12_dly) ;
      $setuphold( posedge CLKA &&& check_dia13_posedge,  DIA13, 0:0:0, 0:0:0,,,, CLKA_dly, DIA13_dly) ;
      $setuphold( posedge CLKA &&& check_dia14_posedge,  DIA14, 0:0:0, 0:0:0,,,, CLKA_dly, DIA14_dly) ;
      $setuphold( posedge CLKA &&& check_dia15_posedge,  DIA15, 0:0:0, 0:0:0,,,, CLKA_dly, DIA15_dly) ;
      $setuphold( posedge CLKA &&& check_dia16_posedge,  DIA16, 0:0:0, 0:0:0,,,, CLKA_dly, DIA16_dly) ;
      $setuphold( posedge CLKA &&& check_dia17_posedge,  DIA17, 0:0:0, 0:0:0,,,, CLKA_dly, DIA17_dly) ;
      $setuphold( posedge CLKA &&& check_ada0_posedge,  ADA0, 0:0:0, 0:0:0,,,, CLKA_dly, ADA0_dly) ;
      $setuphold( posedge CLKA &&& check_ada1_posedge,  ADA1, 0:0:0, 0:0:0,,,, CLKA_dly, ADA1_dly) ;
      $setuphold( posedge CLKA &&& check_ada2_posedge,  ADA2, 0:0:0, 0:0:0,,,, CLKA_dly, ADA2_dly) ;
      $setuphold( posedge CLKA &&& check_ada3_posedge,  ADA3, 0:0:0, 0:0:0,,,, CLKA_dly, ADA3_dly) ;
      $setuphold( posedge CLKA &&& check_ada4_posedge,  ADA4, 0:0:0, 0:0:0,,,, CLKA_dly, ADA4_dly) ;
      $setuphold( posedge CLKA &&& check_ada5_posedge,  ADA5, 0:0:0, 0:0:0,,,, CLKA_dly, ADA5_dly) ;
      $setuphold( posedge CLKA &&& check_ada6_posedge,  ADA6, 0:0:0, 0:0:0,,,, CLKA_dly, ADA6_dly) ;
      $setuphold( posedge CLKA &&& check_ada7_posedge,  ADA7, 0:0:0, 0:0:0,,,, CLKA_dly, ADA7_dly) ;
      $setuphold( posedge CLKA &&& check_ada8_posedge,  ADA8, 0:0:0, 0:0:0,,,, CLKA_dly, ADA8_dly) ;
      $setuphold( posedge CLKA &&& check_ada9_posedge,  ADA9, 0:0:0, 0:0:0,,,, CLKA_dly, ADA9_dly) ;
      $setuphold( posedge CLKA &&& check_ada10_posedge,  ADA10, 0:0:0, 0:0:0,,,, CLKA_dly, ADA10_dly) ;
      $setuphold( posedge CLKA &&& check_ada11_posedge,  ADA11, 0:0:0, 0:0:0,,,, CLKA_dly, ADA11_dly) ;
      $setuphold( posedge CLKA &&& check_ada12_posedge,  ADA12, 0:0:0, 0:0:0,,,, CLKA_dly, ADA12_dly) ;
      $setuphold( posedge CLKA &&& check_ada13_posedge,  ADA13, 0:0:0, 0:0:0,,,, CLKA_dly, ADA13_dly) ;
      $setuphold( posedge CLKA &&& check_cea_posedge,  CEA, 0:0:0, 0:0:0,,,, CLKA_dly, CEA_dly) ;
      $setuphold( posedge CLKA &&& check_ocea_posedge,  OCEA, 0:0:0, 0:0:0,,,, CLKA_dly, OCEA_dly) ;
      $setuphold( posedge CLKA &&& check_wea_posedge,  WEA, 0:0:0, 0:0:0,,,, CLKA_dly, WEA_dly) ;
      $setuphold( posedge CLKA &&& check_csa0_posedge,  CSA0, 0:0:0, 0:0:0,,,, CLKA_dly, CSA0_dly) ;
      $setuphold( posedge CLKA &&& check_csa1_posedge,  CSA1, 0:0:0, 0:0:0,,,, CLKA_dly, CSA1_dly) ;
      $setuphold( posedge CLKA &&& check_csa2_posedge,  CSA2, 0:0:0, 0:0:0,,,, CLKA_dly, CSA2_dly) ;
      $setuphold( posedge CLKA &&& check_rsta_posedge,  RSTA, 0:0:0, 0:0:0,,,, CLKA_dly, RSTA_dly) ;

      $setuphold( negedge CLKA &&& check_dia0_negedge,  DIA0, 0:0:0, 0:0:0,,,, CLKA_dly, DIA0_dly) ;
      $setuphold( negedge CLKA &&& check_dia1_negedge,  DIA1, 0:0:0, 0:0:0,,,, CLKA_dly, DIA1_dly) ;
      $setuphold( negedge CLKA &&& check_dia2_negedge,  DIA2, 0:0:0, 0:0:0,,,, CLKA_dly, DIA2_dly) ;
      $setuphold( negedge CLKA &&& check_dia3_negedge,  DIA3, 0:0:0, 0:0:0,,,, CLKA_dly, DIA3_dly) ;
      $setuphold( negedge CLKA &&& check_dia4_negedge,  DIA4, 0:0:0, 0:0:0,,,, CLKA_dly, DIA4_dly) ;
      $setuphold( negedge CLKA &&& check_dia5_negedge,  DIA5, 0:0:0, 0:0:0,,,, CLKA_dly, DIA5_dly) ;
      $setuphold( negedge CLKA &&& check_dia6_negedge,  DIA6, 0:0:0, 0:0:0,,,, CLKA_dly, DIA6_dly) ;
      $setuphold( negedge CLKA &&& check_dia7_negedge,  DIA7, 0:0:0, 0:0:0,,,, CLKA_dly, DIA7_dly) ;
      $setuphold( negedge CLKA &&& check_dia8_negedge,  DIA8, 0:0:0, 0:0:0,,,, CLKA_dly, DIA8_dly) ;
      $setuphold( negedge CLKA &&& check_dia9_negedge,  DIA9, 0:0:0, 0:0:0,,,, CLKA_dly, DIA9_dly) ;
      $setuphold( negedge CLKA &&& check_dia10_negedge,  DIA10, 0:0:0, 0:0:0,,,, CLKA_dly, DIA10_dly) ;
      $setuphold( negedge CLKA &&& check_dia11_negedge,  DIA11, 0:0:0, 0:0:0,,,, CLKA_dly, DIA11_dly) ;
      $setuphold( negedge CLKA &&& check_dia12_negedge,  DIA12, 0:0:0, 0:0:0,,,, CLKA_dly, DIA12_dly) ;
      $setuphold( negedge CLKA &&& check_dia13_negedge,  DIA13, 0:0:0, 0:0:0,,,, CLKA_dly, DIA13_dly) ;
      $setuphold( negedge CLKA &&& check_dia14_negedge,  DIA14, 0:0:0, 0:0:0,,,, CLKA_dly, DIA14_dly) ;
      $setuphold( negedge CLKA &&& check_dia15_negedge,  DIA15, 0:0:0, 0:0:0,,,, CLKA_dly, DIA15_dly) ;
      $setuphold( negedge CLKA &&& check_dia16_negedge,  DIA16, 0:0:0, 0:0:0,,,, CLKA_dly, DIA16_dly) ;
      $setuphold( negedge CLKA &&& check_dia17_negedge,  DIA17, 0:0:0, 0:0:0,,,, CLKA_dly, DIA17_dly) ;
      $setuphold( negedge CLKA &&& check_ada0_negedge,  ADA0, 0:0:0, 0:0:0,,,, CLKA_dly, ADA0_dly) ;
      $setuphold( negedge CLKA &&& check_ada1_negedge,  ADA1, 0:0:0, 0:0:0,,,, CLKA_dly, ADA1_dly) ;
      $setuphold( negedge CLKA &&& check_ada2_negedge,  ADA2, 0:0:0, 0:0:0,,,, CLKA_dly, ADA2_dly) ;
      $setuphold( negedge CLKA &&& check_ada3_negedge,  ADA3, 0:0:0, 0:0:0,,,, CLKA_dly, ADA3_dly) ;
      $setuphold( negedge CLKA &&& check_ada4_negedge,  ADA4, 0:0:0, 0:0:0,,,, CLKA_dly, ADA4_dly) ;
      $setuphold( negedge CLKA &&& check_ada5_negedge,  ADA5, 0:0:0, 0:0:0,,,, CLKA_dly, ADA5_dly) ;
      $setuphold( negedge CLKA &&& check_ada6_negedge,  ADA6, 0:0:0, 0:0:0,,,, CLKA_dly, ADA6_dly) ;
      $setuphold( negedge CLKA &&& check_ada7_negedge,  ADA7, 0:0:0, 0:0:0,,,, CLKA_dly, ADA7_dly) ;
      $setuphold( negedge CLKA &&& check_ada8_negedge,  ADA8, 0:0:0, 0:0:0,,,, CLKA_dly, ADA8_dly) ;
      $setuphold( negedge CLKA &&& check_ada9_negedge,  ADA9, 0:0:0, 0:0:0,,,, CLKA_dly, ADA9_dly) ;
      $setuphold( negedge CLKA &&& check_ada10_negedge,  ADA10, 0:0:0, 0:0:0,,,, CLKA_dly, ADA10_dly) ;
      $setuphold( negedge CLKA &&& check_ada11_negedge,  ADA11, 0:0:0, 0:0:0,,,, CLKA_dly, ADA11_dly) ;
      $setuphold( negedge CLKA &&& check_ada12_negedge,  ADA12, 0:0:0, 0:0:0,,,, CLKA_dly, ADA12_dly) ;
      $setuphold( negedge CLKA &&& check_ada13_negedge,  ADA13, 0:0:0, 0:0:0,,,, CLKA_dly, ADA13_dly) ;
      $setuphold( negedge CLKA &&& check_cea_negedge,  CEA, 0:0:0, 0:0:0,,,, CLKA_dly, CEA_dly) ;
      $setuphold( negedge CLKA &&& check_ocea_negedge,  OCEA, 0:0:0, 0:0:0,,,, CLKA_dly, OCEA_dly) ;
      $setuphold( negedge CLKA &&& check_wea_negedge,  WEA, 0:0:0, 0:0:0,,,, CLKA_dly, WEA_dly) ;
      $setuphold( negedge CLKA &&& check_csa0_negedge,  CSA0, 0:0:0, 0:0:0,,,, CLKA_dly, CSA0_dly) ;
      $setuphold( negedge CLKA &&& check_csa1_negedge,  CSA1, 0:0:0, 0:0:0,,,, CLKA_dly, CSA1_dly) ;
      $setuphold( negedge CLKA &&& check_csa2_negedge,  CSA2, 0:0:0, 0:0:0,,,, CLKA_dly, CSA2_dly) ;
      $setuphold( negedge CLKA &&& check_rsta_negedge,  RSTA, 0:0:0, 0:0:0,,,, CLKA_dly, RSTA_dly) ;

      $setuphold( posedge CLKB &&& check_dib0_posedge,  DIB0, 0:0:0, 0:0:0,,,, CLKB_dly, DIB0_dly) ;
      $setuphold( posedge CLKB &&& check_dib1_posedge,  DIB1, 0:0:0, 0:0:0,,,, CLKB_dly, DIB1_dly) ;
      $setuphold( posedge CLKB &&& check_dib2_posedge,  DIB2, 0:0:0, 0:0:0,,,, CLKB_dly, DIB2_dly) ;
      $setuphold( posedge CLKB &&& check_dib3_posedge,  DIB3, 0:0:0, 0:0:0,,,, CLKB_dly, DIB3_dly) ;
      $setuphold( posedge CLKB &&& check_dib4_posedge,  DIB4, 0:0:0, 0:0:0,,,, CLKB_dly, DIB4_dly) ;
      $setuphold( posedge CLKB &&& check_dib5_posedge,  DIB5, 0:0:0, 0:0:0,,,, CLKB_dly, DIB5_dly) ;
      $setuphold( posedge CLKB &&& check_dib6_posedge,  DIB6, 0:0:0, 0:0:0,,,, CLKB_dly, DIB6_dly) ;
      $setuphold( posedge CLKB &&& check_dib7_posedge,  DIB7, 0:0:0, 0:0:0,,,, CLKB_dly, DIB7_dly) ;
      $setuphold( posedge CLKB &&& check_dib8_posedge,  DIB8, 0:0:0, 0:0:0,,,, CLKB_dly, DIB8_dly) ;
      $setuphold( posedge CLKB &&& check_dib9_posedge,  DIB9, 0:0:0, 0:0:0,,,, CLKB_dly, DIB9_dly) ;
      $setuphold( posedge CLKB &&& check_dib10_posedge,  DIB10, 0:0:0, 0:0:0,,,, CLKB_dly, DIB10_dly) ;
      $setuphold( posedge CLKB &&& check_dib11_posedge,  DIB11, 0:0:0, 0:0:0,,,, CLKB_dly, DIB11_dly) ;
      $setuphold( posedge CLKB &&& check_dib12_posedge,  DIB12, 0:0:0, 0:0:0,,,, CLKB_dly, DIB12_dly) ;
      $setuphold( posedge CLKB &&& check_dib13_posedge,  DIB13, 0:0:0, 0:0:0,,,, CLKB_dly, DIB13_dly) ;
      $setuphold( posedge CLKB &&& check_dib14_posedge,  DIB14, 0:0:0, 0:0:0,,,, CLKB_dly, DIB14_dly) ;
      $setuphold( posedge CLKB &&& check_dib15_posedge,  DIB15, 0:0:0, 0:0:0,,,, CLKB_dly, DIB15_dly) ;
      $setuphold( posedge CLKB &&& check_dib16_posedge,  DIB16, 0:0:0, 0:0:0,,,, CLKB_dly, DIB16_dly) ;
      $setuphold( posedge CLKB &&& check_dib17_posedge,  DIB17, 0:0:0, 0:0:0,,,, CLKB_dly, DIB17_dly) ;
      $setuphold( posedge CLKB &&& check_adb0_posedge,  ADB0, 0:0:0, 0:0:0,,,, CLKB_dly, ADB0_dly) ;
      $setuphold( posedge CLKB &&& check_adb1_posedge,  ADB1, 0:0:0, 0:0:0,,,, CLKB_dly, ADB1_dly) ;
      $setuphold( posedge CLKB &&& check_adb2_posedge,  ADB2, 0:0:0, 0:0:0,,,, CLKB_dly, ADB2_dly) ;
      $setuphold( posedge CLKB &&& check_adb3_posedge,  ADB3, 0:0:0, 0:0:0,,,, CLKB_dly, ADB3_dly) ;
      $setuphold( posedge CLKB &&& check_adb4_posedge,  ADB4, 0:0:0, 0:0:0,,,, CLKB_dly, ADB4_dly) ;
      $setuphold( posedge CLKB &&& check_adb5_posedge,  ADB5, 0:0:0, 0:0:0,,,, CLKB_dly, ADB5_dly) ;
      $setuphold( posedge CLKB &&& check_adb6_posedge,  ADB6, 0:0:0, 0:0:0,,,, CLKB_dly, ADB6_dly) ;
      $setuphold( posedge CLKB &&& check_adb7_posedge,  ADB7, 0:0:0, 0:0:0,,,, CLKB_dly, ADB7_dly) ;
      $setuphold( posedge CLKB &&& check_adb8_posedge,  ADB8, 0:0:0, 0:0:0,,,, CLKB_dly, ADB8_dly) ;
      $setuphold( posedge CLKB &&& check_adb9_posedge,  ADB9, 0:0:0, 0:0:0,,,, CLKB_dly, ADB9_dly) ;
      $setuphold( posedge CLKB &&& check_adb10_posedge,  ADB10, 0:0:0, 0:0:0,,,, CLKB_dly, ADB10_dly) ;
      $setuphold( posedge CLKB &&& check_adb11_posedge,  ADB11, 0:0:0, 0:0:0,,,, CLKB_dly, ADB11_dly) ;
      $setuphold( posedge CLKB &&& check_adb12_posedge,  ADB12, 0:0:0, 0:0:0,,,, CLKB_dly, ADB12_dly) ;
      $setuphold( posedge CLKB &&& check_adb13_posedge,  ADB13, 0:0:0, 0:0:0,,,, CLKB_dly, ADB13_dly) ;
      $setuphold( posedge CLKB &&& check_ceb_posedge,  CEB, 0:0:0, 0:0:0,,,, CLKB_dly, CEB_dly) ;
      $setuphold( posedge CLKB &&& check_oceb_posedge,  OCEB, 0:0:0, 0:0:0,,,, CLKB_dly, OCEB_dly) ;
      $setuphold( posedge CLKB &&& check_web_posedge,  WEB, 0:0:0, 0:0:0,,,, CLKB_dly, WEB_dly) ;
      $setuphold( posedge CLKB &&& check_csb0_posedge,  CSB0, 0:0:0, 0:0:0,,,, CLKB_dly, CSB0_dly) ;
      $setuphold( posedge CLKB &&& check_csb1_posedge,  CSB1, 0:0:0, 0:0:0,,,, CLKB_dly, CSB1_dly) ;
      $setuphold( posedge CLKB &&& check_csb2_posedge,  CSB2, 0:0:0, 0:0:0,,,, CLKB_dly, CSB2_dly) ;
      $setuphold( posedge CLKB &&& check_rstb_posedge,  RSTB, 0:0:0, 0:0:0,,,, CLKB_dly, RSTB_dly) ;

      $setuphold( negedge CLKB &&& check_dib0_negedge,  DIB0, 0:0:0, 0:0:0,,,, CLKB_dly, DIB0_dly) ;
      $setuphold( negedge CLKB &&& check_dib1_negedge,  DIB1, 0:0:0, 0:0:0,,,, CLKB_dly, DIB1_dly) ;
      $setuphold( negedge CLKB &&& check_dib2_negedge,  DIB2, 0:0:0, 0:0:0,,,, CLKB_dly, DIB2_dly) ;
      $setuphold( negedge CLKB &&& check_dib3_negedge,  DIB3, 0:0:0, 0:0:0,,,, CLKB_dly, DIB3_dly) ;
      $setuphold( negedge CLKB &&& check_dib4_negedge,  DIB4, 0:0:0, 0:0:0,,,, CLKB_dly, DIB4_dly) ;
      $setuphold( negedge CLKB &&& check_dib5_negedge,  DIB5, 0:0:0, 0:0:0,,,, CLKB_dly, DIB5_dly) ;
      $setuphold( negedge CLKB &&& check_dib6_negedge,  DIB6, 0:0:0, 0:0:0,,,, CLKB_dly, DIB6_dly) ;
      $setuphold( negedge CLKB &&& check_dib7_negedge,  DIB7, 0:0:0, 0:0:0,,,, CLKB_dly, DIB7_dly) ;
      $setuphold( negedge CLKB &&& check_dib8_negedge,  DIB8, 0:0:0, 0:0:0,,,, CLKB_dly, DIB8_dly) ;
      $setuphold( negedge CLKB &&& check_dib9_negedge,  DIB9, 0:0:0, 0:0:0,,,, CLKB_dly, DIB9_dly) ;
      $setuphold( negedge CLKB &&& check_dib10_negedge,  DIB10, 0:0:0, 0:0:0,,,, CLKB_dly, DIB10_dly) ;
      $setuphold( negedge CLKB &&& check_dib11_negedge,  DIB11, 0:0:0, 0:0:0,,,, CLKB_dly, DIB11_dly) ;
      $setuphold( negedge CLKB &&& check_dib12_negedge,  DIB12, 0:0:0, 0:0:0,,,, CLKB_dly, DIB12_dly) ;
      $setuphold( negedge CLKB &&& check_dib13_negedge,  DIB13, 0:0:0, 0:0:0,,,, CLKB_dly, DIB13_dly) ;
      $setuphold( negedge CLKB &&& check_dib14_negedge,  DIB14, 0:0:0, 0:0:0,,,, CLKB_dly, DIB14_dly) ;
      $setuphold( negedge CLKB &&& check_dib15_negedge,  DIB15, 0:0:0, 0:0:0,,,, CLKB_dly, DIB15_dly) ;
      $setuphold( negedge CLKB &&& check_dib16_negedge,  DIB16, 0:0:0, 0:0:0,,,, CLKB_dly, DIB16_dly) ;
      $setuphold( negedge CLKB &&& check_dib17_negedge,  DIB17, 0:0:0, 0:0:0,,,, CLKB_dly, DIB17_dly) ;
      $setuphold( negedge CLKB &&& check_adb0_negedge,  ADB0, 0:0:0, 0:0:0,,,, CLKB_dly, ADB0_dly) ;
      $setuphold( negedge CLKB &&& check_adb1_negedge,  ADB1, 0:0:0, 0:0:0,,,, CLKB_dly, ADB1_dly) ;
      $setuphold( negedge CLKB &&& check_adb2_negedge,  ADB2, 0:0:0, 0:0:0,,,, CLKB_dly, ADB2_dly) ;
      $setuphold( negedge CLKB &&& check_adb3_negedge,  ADB3, 0:0:0, 0:0:0,,,, CLKB_dly, ADB3_dly) ;
      $setuphold( negedge CLKB &&& check_adb4_negedge,  ADB4, 0:0:0, 0:0:0,,,, CLKB_dly, ADB4_dly) ;
      $setuphold( negedge CLKB &&& check_adb5_negedge,  ADB5, 0:0:0, 0:0:0,,,, CLKB_dly, ADB5_dly) ;
      $setuphold( negedge CLKB &&& check_adb6_negedge,  ADB6, 0:0:0, 0:0:0,,,, CLKB_dly, ADB6_dly) ;
      $setuphold( negedge CLKB &&& check_adb7_negedge,  ADB7, 0:0:0, 0:0:0,,,, CLKB_dly, ADB7_dly) ;
      $setuphold( negedge CLKB &&& check_adb8_negedge,  ADB8, 0:0:0, 0:0:0,,,, CLKB_dly, ADB8_dly) ;
      $setuphold( negedge CLKB &&& check_adb9_negedge,  ADB9, 0:0:0, 0:0:0,,,, CLKB_dly, ADB9_dly) ;
      $setuphold( negedge CLKB &&& check_adb10_negedge,  ADB10, 0:0:0, 0:0:0,,,, CLKB_dly, ADB10_dly) ;
      $setuphold( negedge CLKB &&& check_adb11_negedge,  ADB11, 0:0:0, 0:0:0,,,, CLKB_dly, ADB11_dly) ;
      $setuphold( negedge CLKB &&& check_adb12_negedge,  ADB12, 0:0:0, 0:0:0,,,, CLKB_dly, ADB12_dly) ;
      $setuphold( negedge CLKB &&& check_adb13_negedge,  ADB13, 0:0:0, 0:0:0,,,, CLKB_dly, ADB13_dly) ;
      $setuphold( negedge CLKB &&& check_ceb_negedge,  CEB, 0:0:0, 0:0:0,,,, CLKB_dly, CEB_dly) ;
      $setuphold( negedge CLKB &&& check_oceb_negedge,  OCEB, 0:0:0, 0:0:0,,,, CLKB_dly, OCEB_dly) ;
      $setuphold( negedge CLKB &&& check_web_negedge,  WEB, 0:0:0, 0:0:0,,,, CLKB_dly, WEB_dly) ;
      $setuphold( negedge CLKB &&& check_csb0_negedge,  CSB0, 0:0:0, 0:0:0,,,, CLKB_dly, CSB0_dly) ;
      $setuphold( negedge CLKB &&& check_csb1_negedge,  CSB1, 0:0:0, 0:0:0,,,, CLKB_dly, CSB1_dly) ;
      $setuphold( negedge CLKB &&& check_csb2_negedge,  CSB2, 0:0:0, 0:0:0,,,, CLKB_dly, CSB2_dly) ;
      $setuphold( negedge CLKB &&& check_rstb_negedge,  RSTB, 0:0:0, 0:0:0,,,, CLKB_dly, RSTB_dly) ;

      $setuphold( posedge CLKA &&& check_dib0_clka_posedge,  DIB0, 0:0:0, 0:0:0,,,, CLKA_dly, DIB0_dly) ;
      $setuphold( posedge CLKA &&& check_dib1_clka_posedge,  DIB1, 0:0:0, 0:0:0,,,, CLKA_dly, DIB1_dly) ;
      $setuphold( posedge CLKA &&& check_dib2_clka_posedge,  DIB2, 0:0:0, 0:0:0,,,, CLKA_dly, DIB2_dly) ;
      $setuphold( posedge CLKA &&& check_dib3_clka_posedge,  DIB3, 0:0:0, 0:0:0,,,, CLKA_dly, DIB3_dly) ;
      $setuphold( posedge CLKA &&& check_dib4_clka_posedge,  DIB4, 0:0:0, 0:0:0,,,, CLKA_dly, DIB4_dly) ;
      $setuphold( posedge CLKA &&& check_dib5_clka_posedge,  DIB5, 0:0:0, 0:0:0,,,, CLKA_dly, DIB5_dly) ;
      $setuphold( posedge CLKA &&& check_dib6_clka_posedge,  DIB6, 0:0:0, 0:0:0,,,, CLKA_dly, DIB6_dly) ;
      $setuphold( posedge CLKA &&& check_dib7_clka_posedge,  DIB7, 0:0:0, 0:0:0,,,, CLKA_dly, DIB7_dly) ;
      $setuphold( posedge CLKA &&& check_dib8_clka_posedge,  DIB8, 0:0:0, 0:0:0,,,, CLKA_dly, DIB8_dly) ;
      $setuphold( posedge CLKA &&& check_dib9_clka_posedge,  DIB9, 0:0:0, 0:0:0,,,, CLKA_dly, DIB9_dly) ;
      $setuphold( posedge CLKA &&& check_dib10_clka_posedge,  DIB10, 0:0:0, 0:0:0,,,, CLKA_dly, DIB10_dly) ;
      $setuphold( posedge CLKA &&& check_dib11_clka_posedge,  DIB11, 0:0:0, 0:0:0,,,, CLKA_dly, DIB11_dly) ;
      $setuphold( posedge CLKA &&& check_dib12_clka_posedge,  DIB12, 0:0:0, 0:0:0,,,, CLKA_dly, DIB12_dly) ;
      $setuphold( posedge CLKA &&& check_dib13_clka_posedge,  DIB13, 0:0:0, 0:0:0,,,, CLKA_dly, DIB13_dly) ;
      $setuphold( posedge CLKA &&& check_dib14_clka_posedge,  DIB14, 0:0:0, 0:0:0,,,, CLKA_dly, DIB14_dly) ;
      $setuphold( posedge CLKA &&& check_dib15_clka_posedge,  DIB15, 0:0:0, 0:0:0,,,, CLKA_dly, DIB15_dly) ;
      $setuphold( posedge CLKA &&& check_dib16_clka_posedge,  DIB16, 0:0:0, 0:0:0,,,, CLKA_dly, DIB16_dly) ;
      $setuphold( posedge CLKA &&& check_dib17_clka_posedge,  DIB17, 0:0:0, 0:0:0,,,, CLKA_dly, DIB17_dly) ;

      $setuphold( negedge CLKA &&& check_dib0_clka_negedge,  DIB0, 0:0:0, 0:0:0,,,, CLKA_dly, DIB0_dly) ;
      $setuphold( negedge CLKA &&& check_dib1_clka_negedge,  DIB1, 0:0:0, 0:0:0,,,, CLKA_dly, DIB1_dly) ;
      $setuphold( negedge CLKA &&& check_dib2_clka_negedge,  DIB2, 0:0:0, 0:0:0,,,, CLKA_dly, DIB2_dly) ;
      $setuphold( negedge CLKA &&& check_dib3_clka_negedge,  DIB3, 0:0:0, 0:0:0,,,, CLKA_dly, DIB3_dly) ;
      $setuphold( negedge CLKA &&& check_dib4_clka_negedge,  DIB4, 0:0:0, 0:0:0,,,, CLKA_dly, DIB4_dly) ;
      $setuphold( negedge CLKA &&& check_dib5_clka_negedge,  DIB5, 0:0:0, 0:0:0,,,, CLKA_dly, DIB5_dly) ;
      $setuphold( negedge CLKA &&& check_dib6_clka_negedge,  DIB6, 0:0:0, 0:0:0,,,, CLKA_dly, DIB6_dly) ;
      $setuphold( negedge CLKA &&& check_dib7_clka_negedge,  DIB7, 0:0:0, 0:0:0,,,, CLKA_dly, DIB7_dly) ;
      $setuphold( negedge CLKA &&& check_dib8_clka_negedge,  DIB8, 0:0:0, 0:0:0,,,, CLKA_dly, DIB8_dly) ;
      $setuphold( negedge CLKA &&& check_dib9_clka_negedge,  DIB9, 0:0:0, 0:0:0,,,, CLKA_dly, DIB9_dly) ;
      $setuphold( negedge CLKA &&& check_dib10_clka_negedge,  DIB10, 0:0:0, 0:0:0,,,, CLKA_dly, DIB10_dly) ;
      $setuphold( negedge CLKA &&& check_dib11_clka_negedge,  DIB11, 0:0:0, 0:0:0,,,, CLKA_dly, DIB11_dly) ;
      $setuphold( negedge CLKA &&& check_dib12_clka_negedge,  DIB12, 0:0:0, 0:0:0,,,, CLKA_dly, DIB12_dly) ;
      $setuphold( negedge CLKA &&& check_dib13_clka_negedge,  DIB13, 0:0:0, 0:0:0,,,, CLKA_dly, DIB13_dly) ;
      $setuphold( negedge CLKA &&& check_dib14_clka_negedge,  DIB14, 0:0:0, 0:0:0,,,, CLKA_dly, DIB14_dly) ;
      $setuphold( negedge CLKA &&& check_dib15_clka_negedge,  DIB15, 0:0:0, 0:0:0,,,, CLKA_dly, DIB15_dly) ;
      $setuphold( negedge CLKA &&& check_dib16_clka_negedge,  DIB16, 0:0:0, 0:0:0,,,, CLKA_dly, DIB16_dly) ;
      $setuphold( negedge CLKA &&& check_dib17_clka_negedge,  DIB17, 0:0:0, 0:0:0,,,, CLKA_dly, DIB17_dly) ;

      $width (posedge CLKA, 0:0:0);
      $width (negedge CLKA, 0:0:0);
      $width (posedge CLKB, 0:0:0);
      $width (negedge CLKB, 0:0:0);
      $width (posedge RSTA, 0:0:0);
      $width (negedge RSTA, 0:0:0);
      $width (posedge RSTB, 0:0:0);
      $width (negedge RSTB, 0:0:0);
   endspecify

endmodule

