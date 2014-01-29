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

module SSPRAMA (M0, M1, AD0, AD1, AD2, AD3, DI0, DI1, 
              CE, CLK, LSR, F0, Q0, F1, Q1); 

input  M0, M1, AD0, AD1, AD2, AD3, DI0, DI1;
input  CE, CLK, LSR;
output F0, Q0, F1, Q1;

   parameter  GSR = "ENABLED";
   parameter  SRMODE = "ASYNC";    // "LSR_OVER_CE", "ASYNC"
   parameter  REGMODE = "FF";            // "FF", "LATCH"
   parameter  LSRMUX = "VLO";            // "SIG", "INV", "VLO", "VHI"
   parameter  CEMUX = "VLO";            // "SIG", "INV", "VLO", "VHI"
   parameter  CLKMUX = "VLO";            // "SIG", "INV", "VLO", "VHI"
   parameter  REG1_REGSET = "RESET";     // "RESET", "SET"
   parameter  REG0_REGSET = "RESET";     // "RESET", "SET"
   parameter [63:0] initval = 64'h0000000000000000;

   parameter  XON = 1'b0;
   parameter  CHECK_M1 = 1'b0;
   parameter  CHECK_M0 = 1'b0;
   parameter  CHECK_AD0 = 1'b0;
   parameter  CHECK_AD1 = 1'b0;
   parameter  CHECK_AD2 = 1'b0;
   parameter  CHECK_AD3 = 1'b0;
   parameter  CHECK_DI1 = 1'b0;
   parameter  CHECK_DI0 = 1'b0;
   parameter  CHECK_CE = 1'b0;
   parameter  CHECK_LSR = 1'b0;

   wire check_m1_posedge, check_m0_posedge, check_ce_posedge, check_lsr_posedge, check_di1_posedge, check_di0_posedge;
   wire check_ad0_posedge, check_ad1_posedge, check_ad2_posedge, check_ad3_posedge;
   wire check_m1_negedge, check_m0_negedge, check_ce_negedge, check_lsr_negedge, check_di1_negedge, check_di0_negedge;
   wire check_ad0_negedge, check_ad1_negedge, check_ad2_negedge, check_ad3_negedge;
   wire SR1, SR, LSR_sig, CE_sig, CLK_sig, M0_dly, M1_dly, AD0_dly, AD1_dly, AD2_dly, AD3_dly;
   wire LSR_dly, CE_dly, CLK_dly, DI1_dly, DI0_dly, DO0, DO1, QB0, QB1;
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

   wire check_m1 = CHECK_M1;
   wire check_m0 = CHECK_M0;
   wire check_ad0 = CHECK_AD0;
   wire check_ad1 = CHECK_AD1;
   wire check_ad2 = CHECK_AD2;
   wire check_ad3 = CHECK_AD3;
   wire check_di1 = CHECK_DI1;
   wire check_di0 = CHECK_DI0;
   wire check_ce = CHECK_CE;
   wire check_lsr = CHECK_LSR;

   assign check_m1_posedge = check_m1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_m1_negedge = check_m1 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_m0_posedge = check_m0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_m0_negedge = check_m0 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_ad0_posedge = check_ad0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ad0_negedge = check_ad0 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_ad1_posedge = check_ad1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ad1_negedge = check_ad1 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_ad2_posedge = check_ad2 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ad2_negedge = check_ad2 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_ad3_posedge = check_ad3 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ad3_negedge = check_ad3 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_di1_posedge = check_di1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_di1_negedge = check_di1 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_di0_posedge = check_di0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_di0_negedge = check_di0 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_ce_posedge = check_ce & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ce_negedge = check_ce & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_lsr_posedge = check_lsr & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_lsr_negedge = check_lsr & ((CLKMUX == "INV") ? 1'b1 : 1'b0);

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

   assign check_m1_posedge = clkposedge ((CHECK_M1), (CLKMUX));
   assign check_m0_posedge = clkposedge ((CHECK_M0), (CLKMUX));
   assign check_di1_posedge = clkposedge ((CHECK_DI1), (CLKMUX));
   assign check_di0_posedge = clkposedge ((CHECK_DI0), (CLKMUX));
   assign check_ce_posedge = clkposedge ((CHECK_CE), (CLKMUX));
   assign check_lsr_posedge = clkposedge ((CHECK_LSR), (CLKMUX));
   assign check_ad0_posedge = clkposedge ((CHECK_AD0), (CLKMUX));
   assign check_ad1_posedge = clkposedge ((CHECK_AD1), (CLKMUX));
   assign check_ad2_posedge = clkposedge ((CHECK_AD2), (CLKMUX));
   assign check_ad3_posedge = clkposedge ((CHECK_AD3), (CLKMUX));

   assign check_m1_negedge = clknegedge ((CHECK_M1), (CLKMUX));
   assign check_m0_negedge = clknegedge ((CHECK_M0), (CLKMUX));
   assign check_di1_negedge = clknegedge ((CHECK_DI1), (CLKMUX));
   assign check_di0_negedge = clknegedge ((CHECK_DI0), (CLKMUX));
   assign check_ce_negedge = clknegedge ((CHECK_CE), (CLKMUX));
   assign check_lsr_negedge = clknegedge ((CHECK_LSR), (CLKMUX));
   assign check_ad0_negedge = clknegedge ((CHECK_AD0), (CLKMUX));
   assign check_ad1_negedge = clknegedge ((CHECK_AD1), (CLKMUX));
   assign check_ad2_negedge = clknegedge ((CHECK_AD2), (CLKMUX));
   assign check_ad3_negedge = clknegedge ((CHECK_AD3), (CLKMUX));

   assign check_m1_posedge = CHECK_M1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_m0_posedge = CHECK_M0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_di1_posedge = CHECK_DI1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_di0_posedge = CHECK_DI0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ce_posedge = CHECK_CE & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_lsr_posedge = CHECK_LSR & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ad0_posedge = CHECK_AD0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ad1_posedge = CHECK_AD1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ad2_posedge = CHECK_AD2 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ad3_posedge = CHECK_AD3 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);

   assign check_m1_negedge = CHECK_M1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_m0_negedge = CHECK_M0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_di1_negedge = CHECK_DI1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_di0_negedge = CHECK_DI0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ce_negedge = CHECK_CE & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_lsr_negedge = CHECK_LSR & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ad0_negedge = CHECK_AD0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ad1_negedge = CHECK_AD1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ad2_negedge = CHECK_AD2 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_ad3_negedge = CHECK_AD3 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
*/

   buf (F1, DO1);
   buf (F0, DO0);
   buf (Q0, QB0);
   buf (Q1, QB1);
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

   defparam SPR16X2_INST.initval = initval;

   SPR16X2 SPR16X2_INST (M0_dly, M1_dly, AD0_dly, AD1_dly, AD2_dly, AD3_dly, CE_sig, LSR_sig,
                         CLK_sig, DO0, DO1);


  generate
        if (REGMODE == "FF" && REG0_REGSET == "RESET")
        begin
           UDFDL5SC_UDP_X INST6 (QB0, DI0_dly, CLK_sig, 1'b1, 1'b0, SR1, notifier_Q0);
        end
        if (REGMODE == "FF" && REG0_REGSET == "SET")
        begin
           UDFDL7SP_UDP_X INST7 (QB0, DI0_dly, CLK_sig, 1'b1, 1'b0, SR1, notifier_Q0);
        end

        if (REGMODE == "FF" && REG1_REGSET == "RESET")
        begin
           UDFDL5SC_UDP_X INST8 (QB1, DI1_dly, CLK_sig, 1'b1, 1'b0, SR1, notifier_Q1);
        end
        if (REGMODE == "FF" && REG1_REGSET == "SET")
        begin
           UDFDL7SP_UDP_X INST9 (QB1, DI1_dly, CLK_sig, 1'b1, 1'b0, SR1, notifier_Q1);
        end

        if (REGMODE == "LATCH" && REG0_REGSET == "RESET")
        begin
           UDFDL4SC_UDP_X INST10 (QB0, DI0_dly, CLK_sig, 1'b1, 1'b0, SR1, notifier_Q0);
        end
        if (REGMODE == "LATCH" && REG0_REGSET == "SET")
        begin
           UDFDL6SP_UDP_X INST11 (QB0, DI0_dly, CLK_sig, 1'b1, 1'b0, SR1, notifier_Q0);
        end

        if (REGMODE == "LATCH" && REG1_REGSET == "RESET")
        begin
           UDFDL4SC_UDP_X INST12 (QB1, DI1_dly, CLK_sig, 1'b1, 1'b0, SR1, notifier_Q1);
        end
        if (REGMODE == "LATCH" && REG1_REGSET == "SET")
        begin
           UDFDL6SP_UDP_X INST13 (QB1, DI1_dly, CLK_sig, 1'b1, 1'b0, SR1, notifier_Q1);
        end

  endgenerate

   specify

      (CLK => Q0) = (0:0:0,0:0:0);
      (CLK => Q1) = (0:0:0,0:0:0);
      (M0 => F1) = (0:0:0,0:0:0);
      (M1 => F1) = (0:0:0,0:0:0);
      (AD0 => F1) = (0:0:0,0:0:0);
      (AD1 => F1) = (0:0:0,0:0:0);
      (AD2 => F1) = (0:0:0,0:0:0);
      (AD3 => F1) = (0:0:0,0:0:0);
      (CE => F1) = (0:0:0,0:0:0);
      (LSR => F1) = (0:0:0,0:0:0);
      (CLK => F1) = (0:0:0,0:0:0);
      (M0 => F0) = (0:0:0,0:0:0);
      (M1 => F0) = (0:0:0,0:0:0);
      (AD0 => F0) = (0:0:0,0:0:0);
      (AD1 => F0) = (0:0:0,0:0:0);
      (AD2 => F0) = (0:0:0,0:0:0);
      (AD3 => F0) = (0:0:0,0:0:0);
      (CE => F0) = (0:0:0,0:0:0);
      (LSR => F0) = (0:0:0,0:0:0);
      (CLK => F0) = (0:0:0,0:0:0);

      $setuphold( posedge CLK &&& check_di0_posedge,  DI0, 0:0:0, 0:0:0, notify_DI0,,, CLK_dly, DI0_dly) ;
      $setuphold( posedge CLK &&& check_di1_posedge,  DI1, 0:0:0, 0:0:0, notify_DI1,,, CLK_dly, DI1_dly) ;
      $setuphold( posedge CLK &&& check_m1_posedge,  M1, 0:0:0, 0:0:0,,,, CLK_dly, M1_dly) ;
      $setuphold( posedge CLK &&& check_m0_posedge, M0, 0:0:0, 0:0:0,,,, CLK_dly, M0_dly) ;
      $setuphold( posedge CLK &&& check_ce_posedge, CE, 0:0:0, 0:0:0,,,, CLK_dly, CE_dly) ;
      $setuphold( posedge CLK &&& check_lsr_posedge, LSR, 0:0:0, 0:0:0,,,, CLK_dly, LSR_dly) ;
      $setuphold( posedge CLK &&& check_ad0_posedge, AD0, 0:0:0, 0:0:0,,,, CLK_dly, AD0_dly) ;
      $setuphold( posedge CLK &&& check_ad1_posedge, AD1, 0:0:0, 0:0:0,,,, CLK_dly, AD1_dly) ;
      $setuphold( posedge CLK &&& check_ad2_posedge, AD2, 0:0:0, 0:0:0,,,, CLK_dly, AD2_dly) ;
      $setuphold( posedge CLK &&& check_ad3_posedge, AD3, 0:0:0, 0:0:0,,,, CLK_dly, AD3_dly) ;
      $setuphold( negedge CLK &&& check_di0_negedge,  DI0, 0:0:0, 0:0:0, notify_DI0,,, CLK_dly, DI0_dly) ;
      $setuphold( negedge CLK &&& check_di1_negedge,  DI1, 0:0:0, 0:0:0, notify_DI1,,, CLK_dly, DI1_dly) ;
      $setuphold( negedge CLK &&& check_m1_negedge,  M1, 0:0:0, 0:0:0,,,, CLK_dly, M1_dly) ;
      $setuphold( negedge CLK &&& check_m0_negedge, M0, 0:0:0, 0:0:0,,,, CLK_dly, M0_dly) ;
      $setuphold( negedge CLK &&& check_ce_negedge, CE, 0:0:0, 0:0:0,,,, CLK_dly, CE_dly) ;
      $setuphold( negedge CLK &&& check_lsr_negedge, LSR, 0:0:0, 0:0:0,,,, CLK_dly, LSR_dly) ;
      $setuphold( negedge CLK &&& check_ad0_negedge, AD0, 0:0:0, 0:0:0,,,, CLK_dly, AD0_dly) ;
      $setuphold( negedge CLK &&& check_ad1_negedge, AD1, 0:0:0, 0:0:0,,,, CLK_dly, AD1_dly) ;
      $setuphold( negedge CLK &&& check_ad2_negedge, AD2, 0:0:0, 0:0:0,,,, CLK_dly, AD2_dly) ;
      $setuphold( negedge CLK &&& check_ad3_negedge, AD3, 0:0:0, 0:0:0,,,, CLK_dly, AD3_dly) ;

      $width (posedge CLK, 0:0:0);
      $width (negedge CLK, 0:0:0);
      $width (posedge LSR, 0:0:0);
      $width (negedge LSR, 0:0:0);
   endspecify

endmodule

