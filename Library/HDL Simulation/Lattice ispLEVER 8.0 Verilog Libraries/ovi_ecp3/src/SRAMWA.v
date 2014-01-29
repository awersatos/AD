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
// $Header:
//
`timescale 1ns / 1ps

module SRAMWA (A1, B1, C1, D1, A0, B0, C0, D0, CLK, LSR,
              WDO0, WDO1, WDO2, WDO3, WADO0, WADO1, WADO2, WADO3, WCKO, WREO);

input  A1, B1, C1, D1, A0, B0, C0, D0, CLK, LSR;
output WDO0, WDO1, WDO2, WDO3, WADO0, WADO1, WADO2, WADO3, WCKO, WREO;

   parameter  LSRMUX = "VLO";            // "SIG", "INV", "VLO", "VHI"
   parameter  CLKMUX = "VLO";            // "SIG", "INV", "VLO", "VHI"

   parameter  XON = 1'b0;
   parameter  CHECK_LSR = 1'b0;

   wire A1_dly, B1_dly, C1_dly, D1_dly, A0_dly, B0_dly, C0_dly, D0_dly, CLK_dly, LSR_dly, CLK_sig, LSR_sig;
   wire check_lsr_posedge, check_lsr_negedge;

   buf (A1_dly, A1);
   buf (B1_dly, B1);
   buf (C1_dly, C1);
   buf (D1_dly, D1);
   buf (A0_dly, A0);
   buf (B0_dly, B0);
   buf (C0_dly, C0);
   buf (D0_dly, D0);
   buf (CLK_dly, CLK);
   buf (LSR_dly, LSR);

   buf (WDO0, A1_dly);
   buf (WDO1, B1_dly);
   buf (WDO2, C1_dly);
   buf (WDO3, D1_dly);
   buf (WADO0, A0_dly);
   buf (WADO1, B0_dly);
   buf (WADO2, C0_dly);
   buf (WADO3, D0_dly);
   buf (WCKO, CLK_sig);
   buf (WREO, LSR_sig);

   wire check_lsr = CHECK_LSR;
   assign check_lsr_posedge = check_lsr & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_lsr_negedge = check_lsr & ((CLKMUX == "INV") ? 1'b1 : 1'b0);

   assign LSR_sig = (LSRMUX == "SIG") ? LSR_dly : (LSRMUX == "INV") ? ~LSR_dly : (LSRMUX == "VHI") ? 1'b1 : 1'b0;
   assign CLK_sig = (CLKMUX == "SIG") ? CLK_dly : (CLKMUX == "INV") ? ~CLK_dly : (CLKMUX == "VHI") ? 1'b1 : 1'b0;
         
   specify

      (A1 => WDO0) = (0:0:0,0:0:0);
      (B1 => WDO1) = (0:0:0,0:0:0);
      (C1 => WDO2) = (0:0:0,0:0:0);
      (D1 => WDO3) = (0:0:0,0:0:0);
      (A0 => WADO0) = (0:0:0,0:0:0);
      (B0 => WADO1) = (0:0:0,0:0:0);
      (C0 => WADO2) = (0:0:0,0:0:0);
      (D0 => WADO3) = (0:0:0,0:0:0);
      (LSR => WREO) = (0:0:0,0:0:0);
      (CLK => WCKO) = (0:0:0,0:0:0);

      $setuphold( posedge CLK &&& check_lsr_posedge, LSR, 0:0:0, 0:0:0,,,, CLK_dly, LSR_dly) ;
      $setuphold( negedge CLK &&& check_lsr_negedge, LSR, 0:0:0, 0:0:0,,,, CLK_dly, LSR_dly) ;

      $width (posedge CLK, 0:0:0);
      $width (negedge CLK, 0:0:0);
      $width (posedge LSR, 0:0:0);
      $width (negedge LSR, 0:0:0);
   endspecify

endmodule

