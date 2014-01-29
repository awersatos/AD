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

module SLUTA (M1, FXA, FXB, A1, B1, C1, D1, 
              A0, B0, C0, D0, M0, 
              OFX1, F1, OFX0, F0);

input  M1, FXA, FXB, A1, B1, C1, D1;
input  A0, B0, C0, D0, M0;
output OFX1, F1, OFX0, F0;

   parameter  M1MUX = "VLO";            // "SIG", "INV", "VLO", "VHI"
   parameter  M0MUX = "VLO";            // "SIG", "INV", "VLO", "VHI"
   parameter  LUT1_INITVAL = 16'h0000;            
   parameter  LUT0_INITVAL = 16'h0000;            

   parameter  XON = 1'b0;

   wire [15:0] mem0, mem1;
   reg F0_buf, F1_buf, OFX1_buf, OFX0_buf;
   wire M1_dly, FXA_dly, FXB_dly, A1_dly, B1_dly, C1_dly, D1_dly;
   wire A0_dly, B0_dly, C0_dly, D0_dly, M0_dly;
   wire [3:0] address0, address1;
   wire M0_sig, M1_sig;

   buf (FXA_dly, FXA);
   buf (FXB_dly, FXB);
   buf (A1_dly, A1);
   buf (B1_dly, B1);
   buf (C1_dly, C1);
   buf (D1_dly, D1);
   buf (A0_dly, A0);
   buf (B0_dly, B0);
   buf (C0_dly, C0);
   buf (D0_dly, D0);
   buf (M0_dly, M0);
   buf (M1_dly, M1);

   buf (OFX1, OFX1_buf);
   buf (OFX0, OFX0_buf);
   buf (F1, F1_buf);
   buf (F0, F0_buf);

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

// Initialization of memory
   assign mem1 = LUT1_INITVAL;
   assign mem0 = LUT0_INITVAL;

   assign address0 = {D0_dly, C0_dly, B0_dly, A0_dly};
   assign address1 = {D1_dly, C1_dly, B1_dly, A1_dly};

   always @(address0, mem0)
   begin
      F0_buf = mux16x1 ((mem0), (address0));
   end

   always @(address1, mem1)
   begin
      F1_buf = mux16x1 ((mem1), (address1));
   end

   assign M1_sig = (M1MUX == "SIG") ? M1_dly : (M1MUX == "INV") ? ~M1_dly : (M1MUX == "VHI") ? 1'b1 : 1'b0;
   assign M0_sig = (M0MUX == "SIG") ? M0_dly : (M0MUX == "INV") ? ~M0_dly : (M0MUX == "VHI") ? 1'b1 : 1'b0;
  
   always @(M1_sig or FXA_dly or FXB_dly)
   begin
      case (M1_sig)
        1'b0 :  OFX1_buf = FXA_dly;
        1'b1 :  OFX1_buf = FXB_dly;
        default OFX1_buf = DataSame(FXA_dly, FXB_dly);
      endcase
   end

   always @(M0_sig or F0_buf or F1_buf)
   begin
      case (M0_sig)
        1'b0 :  OFX0_buf = F0_buf;
        1'b1 :  OFX0_buf = F1_buf;
        default OFX0_buf = DataSame(F0_buf, F1_buf);
      endcase
   end

   specify

      (FXA => OFX1) = (0:0:0,0:0:0);
      (FXB => OFX1) = (0:0:0,0:0:0);
      (M1 => OFX1) = (0:0:0,0:0:0);
      (A1 => F1) = (0:0:0,0:0:0);
      (B1 => F1) = (0:0:0,0:0:0);
      (C1 => F1) = (0:0:0,0:0:0);
      (D1 => F1) = (0:0:0,0:0:0);
      (A1 => OFX0) = (0:0:0,0:0:0);
      (B1 => OFX0) = (0:0:0,0:0:0);
      (C1 => OFX0) = (0:0:0,0:0:0);
      (D1 => OFX0) = (0:0:0,0:0:0);
      (A0 => OFX0) = (0:0:0,0:0:0);
      (B0 => OFX0) = (0:0:0,0:0:0);
      (C0 => OFX0) = (0:0:0,0:0:0);
      (D0 => OFX0) = (0:0:0,0:0:0);
      (A0 => F0) = (0:0:0,0:0:0);
      (B0 => F0) = (0:0:0,0:0:0);
      (C0 => F0) = (0:0:0,0:0:0);
      (D0 => F0) = (0:0:0,0:0:0);
      (M0 => OFX0) = (0:0:0,0:0:0);

   endspecify

endmodule

