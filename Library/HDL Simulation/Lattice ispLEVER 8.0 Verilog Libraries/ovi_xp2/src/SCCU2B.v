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

module SCCU2B (M1, A1, B1, C1, D1, DI1, DI0,
              A0, B0, C0, D0, FCI, M0, CE, CLK, LSR,
              FCO, F1, Q1, F0, Q0);

input  M1, A1, B1, C1, D1, DI1, DI0;
input  A0, B0, C0, D0, FCI, M0, CE, CLK, LSR;
output FCO, F1, Q1, F0, Q0;

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
   parameter [15:0] INIT0_INITVAL = 16'h0000;
   parameter [15:0] INIT1_INITVAL = 16'h0000;
   parameter CCU2_INJECT1_0 = "YES";
   parameter CCU2_INJECT1_1 = "YES";

   parameter  XON = 1'b0;
   parameter  CHECK_M1 = 1'b0;            
   parameter  CHECK_DI1 = 1'b0;            
   parameter  CHECK_DI0 = 1'b0;            
   parameter  CHECK_M0 = 1'b0;            
   parameter  CHECK_CE = 1'b0;            
   parameter  CHECK_LSR = 1'b0;            

   wire CI, COUT0, COUT1, S0, S1;
   reg SR, SRN, F0_buf, F1_buf, LSR_sig0;
   wire M0_sig, M1_sig, LSR_sig, CE_sig, CLK_sig, SR1, QB0, QB1;
   wire check_m1_posedge, check_m1_negedge, check_m0_posedge, check_m0_negedge;
   wire check_ce_posedge, check_ce_negedge, check_lsr_posedge, check_lsr_negedge;
   wire check_di1_posedge, check_di1_negedge, check_di0_posedge, check_di0_negedge;
   wire M1_dly, CLK_dly, A1_dly, B1_dly, C1_dly, D1_dly, DI1_dly, DI0_dly;
   wire A0_dly, B0_dly, C0_dly, D0_dly, M0_dly, FCI_dly, CE_dly, LSR_dly;
   reg notifier_Q0, notifier_Q1, notify_M1, notify_DI1, notify_DI0, notify_M0, notify_CE, notify_LSR;
   reg D0_sig, D1_sig;

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

   wire check_m1 = CHECK_M1;
   wire check_m0 = CHECK_M0;
   wire check_di1 = CHECK_DI1;
   wire check_di0 = CHECK_DI0;
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

   assign check_m1_posedge = clkposedge ((CHECK_M1), (CLKMUX));
   assign check_m1_negedge = clknegedge ((CHECK_M1), (CLKMUX));
   assign check_di1_posedge = clkposedge ((CHECK_DI1), (CLKMUX));
   assign check_di1_negedge = clknegedge ((CHECK_DI1), (CLKMUX));
   assign check_di0_posedge = clkposedge ((CHECK_DI0), (CLKMUX));
   assign check_di0_negedge = clknegedge ((CHECK_DI0), (CLKMUX));
   assign check_m0_posedge = clkposedge ((CHECK_M0), (CLKMUX));
   assign check_m0_negedge = clknegedge ((CHECK_M0), (CLKMUX));
   assign check_ce_posedge = clkposedge ((CHECK_CE), (CLKMUX));
   assign check_ce_negedge = clknegedge ((CHECK_CE), (CLKMUX));
   assign check_lsr_posedge = clkposedge ((CHECK_LSR), (CLKMUX));
   assign check_lsr_negedge = clknegedge ((CHECK_LSR), (CLKMUX));
*/

   buf (FCI_dly, FCI);
   buf (A1_dly, A1);
   buf (B1_dly, B1);
   buf (C1_dly, C1);
   buf (D1_dly, D1);
   buf (A0_dly, A0);
   buf (B0_dly, B0);
   buf (C0_dly, C0);
   buf (D0_dly, D0);

   buf (FCO, COUT1);
   buf (F1, S1);
   buf (F0, S0);
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

    function mux41 ;
      input [3:0] din;
      input [1:0] dsel;
      reg   mux41_1, mux41_2;
      begin
        case (dsel)
         2'b00 : mux41 = din[0];
         2'b01 : mux41 = din[1];
         2'b10 : mux41 = din[2];
         2'b11 : mux41 = din[3];
         2'b0x : mux41 = DataSame(din[0], din[1]);
         2'b1x : mux41 = DataSame(din[2], din[3]);
         2'bx0 : mux41 = DataSame(din[2], din[0]);
         2'bx1 : mux41 = DataSame(din[3], din[1]);
         default begin
                 mux41_1 = DataSame(din[1], din[0]);
                 mux41_2 = DataSame(din[3], din[2]);
                 mux41 = DataSame(mux41_1, mux41_2);
                 end
        endcase
      end
    endfunction

    function mux81 ;
       input [7:0] din;
       input [2:0] dsel;
       reg   mux81_1, mux81_2;
       begin
        case (dsel[2])
           1'b0  : mux81 = mux41(din[3:0], dsel[1:0]);
           1'b1  : mux81 = mux41(din[7:4], dsel[1:0]);
           default begin
                   mux81_1 = mux41(din[3:0], dsel[1:0]);
                   mux81_2 = mux41(din[7:4], dsel[1:0]);
                   mux81   = DataSame(mux81_1,mux81_2);
                   end
         endcase
       end
    endfunction

    function mux16x1 ;
       input [15:0] din;
       input [3:0] dselect;
       reg   mux16x1_1, mux16x1_2;
       begin
         case (dselect[3])
            1'b0  : mux16x1 = mux81(din[7:0], dselect[2:0]);
            1'b1  : mux16x1 = mux81(din[15:8], dselect[2:0]);
            default begin
                    mux16x1_1 = mux81(din[7:0], dselect[2:0]);
                    mux16x1_2 = mux81(din[15:8], dselect[2:0]);
                    mux16x1   = DataSame(mux16x1_1,mux16x1_2);
                    end
         endcase
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
 
   defparam CCU2B_INST.INIT0 = INIT0_INITVAL;
   defparam CCU2B_INST.INIT1 = INIT1_INITVAL;
   defparam CCU2B_INST.INJECT1_0 = CCU2_INJECT1_0;
   defparam CCU2B_INST.INJECT1_1 = CCU2_INJECT1_1;

   CCU2B CCU2B_INST (FCI_dly, A0_dly, B0_dly, C0_dly, D0_dly, A1_dly, B1_dly, C1_dly, D1_dly, S0, S1, COUT1);
 

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

      (CLK => Q1) = (0:0:0,0:0:0);
      (LSR => Q1) = (0:0:0,0:0:0);
      (CLK => Q0) = (0:0:0,0:0:0);
      (LSR => Q0) = (0:0:0,0:0:0);
      (A1 => F1) = (0:0:0,0:0:0);
      (B1 => F1) = (0:0:0,0:0:0);
      (C1 => F1) = (0:0:0,0:0:0);
      (D1 => F1) = (0:0:0,0:0:0);
      (A0 => F1) = (0:0:0,0:0:0);
      (B0 => F1) = (0:0:0,0:0:0);
      (C0 => F1) = (0:0:0,0:0:0);
      (D0 => F1) = (0:0:0,0:0:0);
      (FCI => F1) = (0:0:0,0:0:0);
      (A1 => F0) = (0:0:0,0:0:0);
      (B1 => F0) = (0:0:0,0:0:0);
      (C1 => F0) = (0:0:0,0:0:0);
      (D1 => F0) = (0:0:0,0:0:0);
      (A0 => F0) = (0:0:0,0:0:0);
      (B0 => F0) = (0:0:0,0:0:0);
      (C0 => F0) = (0:0:0,0:0:0);
      (D0 => F0) = (0:0:0,0:0:0);
      (FCI => F0) = (0:0:0,0:0:0);
      (A1 => FCO) = (0:0:0,0:0:0);
      (B1 => FCO) = (0:0:0,0:0:0);
      (C1 => FCO) = (0:0:0,0:0:0);
      (D1 => FCO) = (0:0:0,0:0:0);
      (A0 => FCO) = (0:0:0,0:0:0);
      (B0 => FCO) = (0:0:0,0:0:0);
      (C0 => FCO) = (0:0:0,0:0:0);
      (D0 => FCO) = (0:0:0,0:0:0);
      (FCI => FCO) = (0:0:0,0:0:0);

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

      $width (posedge CLK, 0:0:0);
      $width (negedge CLK, 0:0:0);
      $width (posedge LSR, 0:0:0);
      $width (negedge LSR, 0:0:0);
   endspecify

endmodule

