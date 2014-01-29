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

module SDPRAMB (M1, RAD0, RAD1, RAD2, RAD3, WD1, WD0, WAD0, WAD1, WAD2, WAD3, WRE, WCK, 
              M0, DI1, DI0, CE, CLK, LSR, F0, Q0, F1, Q1); 

input  M1, RAD0, RAD1, RAD2, RAD3, WD1, WD0, WAD0, WAD1, WAD2, WAD3, WRE, WCK;
input  M0, DI1, DI0, CE, CLK, LSR;
output F0, Q0, F1, Q1;

   parameter  GSR = "ENABLED";
   parameter  SRMODE = "LSR_OVER_CE";    // "LSR_OVER_CE", "ASYNC"
   parameter  M1MUX = "VLO";            // "SIG", "INV", "VLO", "VHI"
   parameter  M0MUX = "VLO";            // "SIG", "INV", "VLO", "VHI"
   parameter  LSRMUX = "VLO";            // "SIG", "INV", "VLO", "VHI"
   parameter  CEMUX = "VLO";            // "SIG", "INV", "VLO", "VHI"
   parameter  CLKMUX = "VLO";            // "SIG", "INV", "VLO", "VHI"
   parameter  REG1_SD = "VLO";            // "VLO", "VHI", "SIG"
   parameter  REG0_SD = "VLO";            // "VLO", "VHI", "SIG"
   parameter  REG1_REGSET = "RESET";     // "RESET", "SET"
   parameter  REG0_REGSET = "RESET";     // "RESET", "SET"
   parameter  LSRONMUX = "LSRMUX";     // "LSRMUX", "OFF"

   parameter  XON = 1'b0;
   parameter  CHECK_RAD0 = 1'b0;
   parameter  CHECK_RAD1 = 1'b0;
   parameter  CHECK_RAD2 = 1'b0;
   parameter  CHECK_RAD3 = 1'b0;
   parameter  CHECK_WD1 = 1'b0;
   parameter  CHECK_WD0 = 1'b0;
   parameter  CHECK_WAD0 = 1'b0;
   parameter  CHECK_WAD1 = 1'b0;
   parameter  CHECK_WAD2 = 1'b0;
   parameter  CHECK_WAD3 = 1'b0;
   parameter  CHECK_WRE = 1'b0;
   parameter  CHECK_CE = 1'b0;
   parameter  CHECK_LSR = 1'b0;
   parameter  CHECK_M1 = 1'b0;
   parameter  CHECK_DI1 = 1'b0;
   parameter  CHECK_DI0 = 1'b0;
   parameter  CHECK_M0 = 1'b0;

   wire check_m1_posedge, check_m0_posedge, check_ce_posedge, check_lsr_posedge, check_di1_posedge, check_di0_posedge;
   wire check_a0_posedge, check_b0_posedge, check_c0_posedge, check_d0_posedge; 
   wire check_a1_posedge, check_b1_posedge, check_c1_posedge, check_d1_posedge;
   wire check_m1_negedge, check_m0_negedge, check_ce_negedge, check_lsr_negedge, check_di1_negedge, check_di0_negedge;
   wire check_a0_negedge, check_b0_negedge, check_c0_negedge, check_d0_negedge; 
   wire check_a1_negedge, check_b1_negedge, check_c1_negedge, check_d1_negedge;
   wire SR1, CE_sig, CLK_sig, WAD0_dly, WAD1_dly, WAD2_dly, WAD3_dly;
   wire WD1_dly, WD0_dly, WCK_dly, WRE_dly, RAD0_dly, RAD1_dly, RAD2_dly, RAD3_dly;
   wire LSR_dly, CE_dly, CLK_dly, M1_dly, M0_dly, DI1_dly, DI0_dly;
   reg notifier_Q0, notifier_Q1, notify_M1, notify_DI1, notify_DI0, notify_M0, notify_CE, notify_LSR;
   reg SRN, SR, LSR_sig0;
   reg D0_sig, D1_sig;
   wire M0_sig, M1_sig, LSR_sig, DO1, DO0, QB1, QB0;

   initial
   begin
      notify_M1 = 0;
      notify_DI1 = 0;
      notify_DI0 = 0;
      notify_M0 = 0;
      notify_CE = 0;
      notify_LSR = 0;
      notifier_Q0 = 0;
      notifier_Q1 = 0;
   end

   always @ (notify_M1 or notify_DI1 or notify_CE or notify_LSR)
   begin
      if (XON)
         notifier_Q1 = ~notifier_Q1;
   end

   always @ (notify_M0 or notify_DI0 or notify_CE or notify_LSR)
   begin
      if (XON)
         notifier_Q0 = ~notifier_Q0;
   end

   wire check_di0 = CHECK_DI0;
   wire check_di1 = CHECK_DI1;
   wire check_m1 = CHECK_M1;
   wire check_m0 = CHECK_M0;
   wire check_ce = CHECK_CE;
   wire check_lsr = CHECK_LSR;
                                                                                            
   assign check_m1_posedge = check_m1 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_m1_negedge = check_m1 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
   assign check_m0_posedge = check_m0 & ((CLKMUX == "SIG") ? 1'b1 : 1'b0);
   assign check_m0_negedge = check_m0 & ((CLKMUX == "INV") ? 1'b1 : 1'b0);
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

   assign check_m0_posedge = clkposedge ((CHECK_M0), (CLKMUX));
   assign check_m1_posedge = clkposedge ((CHECK_M1), (CLKMUX));
   assign check_di1_posedge = clkposedge ((CHECK_DI1), (CLKMUX));
   assign check_di0_posedge = clkposedge ((CHECK_DI0), (CLKMUX));
   assign check_ce_posedge = clkposedge ((CHECK_CE), (CLKMUX));
   assign check_lsr_posedge = clkposedge ((CHECK_LSR), (CLKMUX));

   assign check_m0_negedge = clknegedge ((CHECK_M0), (CLKMUX));
   assign check_m1_negedge = clknegedge ((CHECK_M1), (CLKMUX));
   assign check_di1_negedge = clknegedge ((CHECK_DI1), (CLKMUX));
   assign check_di0_negedge = clknegedge ((CHECK_DI0), (CLKMUX));
   assign check_ce_negedge = clknegedge ((CHECK_CE), (CLKMUX));
   assign check_lsr_negedge = clknegedge ((CHECK_LSR), (CLKMUX));
*/
   wire check_wd1 = CHECK_WD1;
   wire check_wd0 = CHECK_WD0;
   wire check_wad0 = CHECK_WAD0;
   wire check_wad1 = CHECK_WAD1;
   wire check_wad2 = CHECK_WAD2;
   wire check_wad3 = CHECK_WAD3;
   wire check_wre = CHECK_WRE;
   wire check_rad0 = CHECK_RAD0;
   wire check_rad1 = CHECK_RAD1;
   wire check_rad2 = CHECK_RAD2;
   wire check_rad3 = CHECK_RAD3;
 
   buf (F1, DO1);
   buf (F0, DO0);
   buf (Q0, QB0);
   buf (Q1, QB1);

      function DataSame;
        input a, b;
        begin
          if (a === b)
            DataSame = a;
          else
            DataSame = 1'bx;
        end
      endfunction

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
//  or INST1 (SR, LSR_sig, SR1);

   always @(LSR_sig or SR1)
   begin
      if ((REG0_SD == "SIG") || (REG1_SD == "SIG"))
      begin
         SR = SR1;
         LSR_sig0 = 0;
      end
      else
      begin
         SR = LSR_sig | SR1;
         LSR_sig0 = LSR_sig;
      end
   end

   assign M1_sig = (M1MUX == "SIG") ? M1_dly : (M1MUX == "INV") ? ~M1_dly : (M1MUX == "VHI") ? 1'b1 : 1'b0;
   assign M0_sig = (M0MUX == "SIG") ? M0_dly : (M0MUX == "INV") ? ~M0_dly : (M0MUX == "VHI") ? 1'b1 : 1'b0;
   assign LSR_sig = (LSRMUX == "SIG") ? LSR_dly : (LSRMUX == "INV") ? ~LSR_dly : (LSRMUX == "VHI") ? 1'b1 : 1'b0;
   assign CE_sig = (CEMUX == "SIG") ? CE_dly : (CEMUX == "INV") ? ~CE_dly : (CEMUX == "VHI") ? 1'b1 : 1'b0;
   assign CLK_sig = (CLKMUX == "SIG") ? CLK_dly : (CLKMUX == "INV") ? ~CLK_dly : (CLKMUX == "VHI") ? 1'b1 : 1'b0;
//   assign LSR_sig = (LSRONMUX == "OFF") ? 1'b0 : LSR_SD_sig;
//   assign D0_sig = (REG0_SD == 1'b0) ? M0_sig : DI0_dly;
//   assign D1_sig = (REG1_SD == 1'b0) ? M1_sig : DI1_dly;

   always @(M0_sig or DI0_dly or LSR_sig)
   begin
      if (REG0_SD == "VLO")
         D0_sig = M0_sig;
      else if (REG0_SD == "VHI")
         D0_sig = DI0_dly;
      else if (REG0_SD == "SIG")
      begin
         case (LSR_sig)
           1'b0 :  D0_sig = M0_sig;
           1'b1 :  D0_sig = DI0_dly;
           default D0_sig = DataSame(M0_sig, DI0_dly);
         endcase
      end
   end

   always @(M1_sig or DI1_dly or LSR_sig)
   begin
      if (REG1_SD == "VLO")
         D1_sig = M1_sig;
      else if (REG1_SD == "VHI")
         D1_sig = DI1_dly;
      else if (REG1_SD == "SIG")
      begin
         case (LSR_sig)
           1'b0 :  D1_sig = M1_sig;
           1'b1 :  D1_sig = DI1_dly;
           default D1_sig = DataSame(M1_sig, DI1_dly);
         endcase
      end
   end

   DPR16X4A DPR16X4A_INST (.DI0(WD0_dly), 
                         .DI1(WD1_dly), 
                         .DI2(1'b0), 
                         .DI3(1'b0), 
                         .WAD0(WAD0_dly), 
                         .WAD1(WAD1_dly), 
                         .WAD2(WAD2_dly), 
                         .WAD3(WAD3_dly), 
                         .WRE(WRE_dly), 
                         .WCK(WCK_dly), 
                         .RAD0(RAD0_dly), 
                         .RAD1(RAD1_dly), 
                         .RAD2(RAD2_dly), 
                         .RAD3(RAD3_dly), 
                         .DO0(DO0), 
                         .DO1(DO1),
                         .DO2(),
                         .DO3());


  generate
    if (SRMODE == "ASYNC" && REG0_REGSET == "RESET")
    begin
              UDFDL5E_UDP_X INST6 (QB0, D0_sig, CLK_sig, CE_sig, SR, notifier_Q0);
    end
    if (SRMODE == "ASYNC" && REG0_REGSET == "SET")
    begin
              UDFDL7E_UDP_X INST7 (QB0, D0_sig, CLK_sig, CE_sig, SR, notifier_Q0);
    end

    if (SRMODE == "ASYNC" && REG1_REGSET == "RESET")
    begin
              UDFDL5E_UDP_X INST8 (QB1, D1_sig, CLK_sig, CE_sig, SR, notifier_Q1);
    end
    if (SRMODE == "ASYNC" && REG1_REGSET == "SET")
    begin
              UDFDL7E_UDP_X INST9 (QB1, D1_sig, CLK_sig, CE_sig, SR, notifier_Q1);
    end


    if (SRMODE == "LSR_OVER_CE" && REG0_REGSET == "RESET")
    begin
        UDFDL5SC_UDP_X INST10 (QB0, D0_sig, CLK_sig, CE_sig, LSR_sig0, SR1, notifier_Q0);
    end
    if (SRMODE == "LSR_OVER_CE" && REG0_REGSET == "SET")
    begin
        UDFDL7SP_UDP_X INST11 (QB0, D0_sig, CLK_sig, CE_sig, LSR_sig0, SR1, notifier_Q0);
    end

    if (SRMODE == "LSR_OVER_CE" && REG1_REGSET == "RESET")
    begin
        UDFDL5SC_UDP_X INST12 (QB1, D1_sig, CLK_sig, CE_sig, LSR_sig0, SR1, notifier_Q1);
    end
    if (SRMODE == "LSR_OVER_CE" && REG1_REGSET == "SET")
    begin
        UDFDL7SP_UDP_X INST13 (QB1, D1_sig, CLK_sig, CE_sig, LSR_sig0, SR1, notifier_Q1);
    end

  endgenerate

   specify

      (CLK => Q0) = (0:0:0,0:0:0);
      (CLK => Q1) = (0:0:0,0:0:0);
      (LSR => Q0) = (0:0:0,0:0:0);
      (LSR => Q1) = (0:0:0,0:0:0);
      (RAD0 => F1) = (0:0:0,0:0:0);
      (RAD1 => F1) = (0:0:0,0:0:0);
      (RAD2 => F1) = (0:0:0,0:0:0);
      (RAD3 => F1) = (0:0:0,0:0:0);
      (RAD0 => F0) = (0:0:0,0:0:0);
      (RAD1 => F0) = (0:0:0,0:0:0);
      (RAD2 => F0) = (0:0:0,0:0:0);
      (RAD3 => F0) = (0:0:0,0:0:0);
      (WCK => F0) = (0:0:0,0:0:0);
      (WCK => F1) = (0:0:0,0:0:0);

      $setuphold( posedge CLK &&& check_m1_posedge,  M1, 0:0:0, 0:0:0, notify_M1,,, CLK_dly, M1_dly) ;
      $setuphold( negedge CLK &&& check_m1_negedge,  M1, 0:0:0, 0:0:0, notify_M1,,, CLK_dly, M1_dly) ;
      $setuphold( posedge CLK &&& check_di1_posedge, DI1, 0:0:0, 0:0:0, notify_DI1,,, CLK_dly, DI1_dly) ;
      $setuphold( negedge CLK &&& check_di1_negedge, DI1, 0:0:0, 0:0:0, notify_DI1,,, CLK_dly, DI1_dly) ;
      $setuphold( posedge CLK &&& check_di0_posedge, DI0, 0:0:0, 0:0:0, notify_DI0,,, CLK_dly, DI0_dly) ;
      $setuphold( negedge CLK &&& check_di0_negedge, DI0, 0:0:0, 0:0:0, notify_DI0,,, CLK_dly, DI0_dly) ;
      $setuphold( posedge CLK &&& check_m0_posedge, M0, 0:0:0, 0:0:0, notify_M0,,, CLK_dly, M0_dly) ;
      $setuphold( negedge CLK &&& check_m0_negedge, M0, 0:0:0, 0:0:0, notify_M0,,, CLK_dly, M0_dly) ;
      $setuphold( posedge CLK &&& check_ce_posedge, CE, 0:0:0, 0:0:0, notify_CE,,, CLK_dly, CE_dly) ;
      $setuphold( negedge CLK &&& check_ce_negedge, CE, 0:0:0, 0:0:0, notify_CE,,, CLK_dly, CE_dly) ;
      $setuphold( posedge CLK &&& check_lsr_posedge, LSR, 0:0:0, 0:0:0, notify_LSR,,, CLK_dly, LSR_dly) ;
      $setuphold( negedge CLK &&& check_lsr_negedge, LSR, 0:0:0, 0:0:0, notify_LSR,,, CLK_dly, LSR_dly) ;

      $setuphold( posedge WCK &&& check_wd1, WD1, 0:0:0, 0:0:0,,,, WCK_dly, WD1_dly) ;
      $setuphold( posedge WCK &&& check_wd0, WD0, 0:0:0, 0:0:0,,,, WCK_dly, WD0_dly) ;
      $setuphold( posedge WCK &&& check_wad0, WAD0, 0:0:0, 0:0:0,,,, WCK_dly, WAD0_dly) ;
      $setuphold( posedge WCK &&& check_wad1, WAD1, 0:0:0, 0:0:0,,,, WCK_dly, WAD1_dly) ;
      $setuphold( posedge WCK &&& check_wad2, WAD2, 0:0:0, 0:0:0,,,, WCK_dly, WAD2_dly) ;
      $setuphold( posedge WCK &&& check_wad3, WAD3, 0:0:0, 0:0:0,,,, WCK_dly, WAD3_dly) ;
      $setuphold( posedge WCK &&& check_wre, WRE, 0:0:0, 0:0:0,,,, WCK_dly, WRE_dly) ;
      $setuphold( posedge WCK &&& check_rad0, RAD0, 0:0:0, 0:0:0,,,, WCK_dly, RAD0_dly) ;
      $setuphold( posedge WCK &&& check_rad1, RAD1, 0:0:0, 0:0:0,,,, WCK_dly, RAD1_dly) ;
      $setuphold( posedge WCK &&& check_rad2, RAD2, 0:0:0, 0:0:0,,,, WCK_dly, RAD2_dly) ;
      $setuphold( posedge WCK &&& check_rad3, RAD3, 0:0:0, 0:0:0,,,, WCK_dly, RAD3_dly) ;

      $width (posedge CLK, 0:0:0);
      $width (negedge CLK, 0:0:0);
      $width (posedge WCK, 0:0:0);
      $width (negedge WCK, 0:0:0);
      $width (posedge LSR, 0:0:0);
      $width (negedge LSR, 0:0:0);
   endspecify

endmodule

