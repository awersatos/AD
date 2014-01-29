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
// Simulation Library File for ORCA4
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/MULT8X8.v,v 1.6 2005/05/19 19:01:51 pradeep Exp $ 
//
`timescale 1 ns / 1 ps

`celldefine

module MULT8X8 (A7, A6, A5, A4, A3, A2, A1, A0,
                B7, B6, B5, B4, B3, B2, B1, B0, CK, EN,
                P15, P14, P13, P12, P11, P10, P9, P8,
                P7, P6, P5, P4, P3, P2, P1, P0);
      


// PARAMETERS
parameter MULTMODE = "NOREG";

// INPUTS
input A7, A6, A5, A4, A3, A2, A1, A0;
input B7, B6, B5, B4, B3, B2, B1, B0, CK, EN;

// OUTPUTS
output P15, P14, P13, P12, P11, P10, P9, P8;
output P7, P6, P5, P4, P3, P2, P1, P0;

reg  en_reg;
reg  [7:0] ar_reg;
reg  [7:0] br_reg;
reg  [15:0] p_reg;
wire [7:0] ar_int;
wire [7:0] br_int;
wire [15:0] p_int;

  buf (ar_int[7], A7);
  buf (ar_int[6], A6);
  buf (ar_int[5], A5);
  buf (ar_int[4], A4);
  buf (ar_int[3], A3);
  buf (ar_int[2], A2);
  buf (ar_int[1], A1);
  buf (ar_int[0], A0);
  buf (br_int[7], B7);
  buf (br_int[6], B6);
  buf (br_int[5], B5);
  buf (br_int[4], B4);
  buf (br_int[3], B3);
  buf (br_int[2], B2);
  buf (br_int[1], B1);
  buf (br_int[0], B0);
  buf (ck_int, CK);
  buf (en_int, EN);

  buf (P15_OUT, p_reg[15]);
  buf (P14_OUT, p_reg[14]);
  buf (P13_OUT, p_reg[13]);
  buf (P12_OUT, p_reg[12]);
  buf (P11_OUT, p_reg[11]);
  buf (P10_OUT, p_reg[10]);
  buf (P9_OUT, p_reg[9]);
  buf (P8_OUT, p_reg[8]);
  buf (P7_OUT, p_reg[7]);
  buf (P6_OUT, p_reg[6]);
  buf (P5_OUT, p_reg[5]);
  buf (P4_OUT, p_reg[4]);
  buf (P3_OUT, p_reg[3]);
  buf (P2_OUT, p_reg[2]);
  buf (P1_OUT, p_reg[1]);
  buf (P0_OUT, p_reg[0]);
  buf (P15, P15_OUT);
  buf (P14, P14_OUT);
  buf (P13, P13_OUT);
  buf (P12, P12_OUT);
  buf (P11, P11_OUT);
  buf (P10, P10_OUT);
  buf (P9, P9_OUT);
  buf (P8, P8_OUT);
  buf (P7, P7_OUT);
  buf (P6, P6_OUT);
  buf (P5, P5_OUT);
  buf (P4, P4_OUT);
  buf (P3, P3_OUT);
  buf (P2, P2_OUT);
  buf (P1, P1_OUT);
  buf (P0, P0_OUT);

// Register Enable signal
  always @(posedge ck_int)
  begin
      if (MULTMODE == "IOREG")  
         en_reg <= en_int;
  end

// INREG and IOREG read operation

  always @(posedge ck_int)
  begin
      if (MULTMODE == "INREG" || MULTMODE == "IOREG") 
      begin
         if (en_int == 1'b1)
         begin
            ar_reg <= ar_int;
            br_reg <= br_int;
         end
      end
  end

  always @(ar_int  or br_int)
  begin
      if (MULTMODE == "NOREG" || MULTMODE == "OUTREG") 
      begin
         ar_reg <= ar_int;
         br_reg <= br_int;
      end
  end

  assign p_int = (ar_reg * br_reg);

// OUTREG and IOREG read operation

  always @(posedge ck_int)
  begin
       if (MULTMODE == "IOREG")
       begin
          if (en_reg == 1'b1)
          begin
             p_reg <= p_int;
          end
       end
       else if (MULTMODE == "OUTREG")
       begin
          if (en_int == 1'b1)
          begin
             p_reg <= p_int;
          end
       end
  end 

  always @(p_int)
  begin
      if (MULTMODE == "NOREG" || MULTMODE == "INREG")
      begin
         p_reg <= p_int;
      end
  end




endmodule

`endcelldefine


