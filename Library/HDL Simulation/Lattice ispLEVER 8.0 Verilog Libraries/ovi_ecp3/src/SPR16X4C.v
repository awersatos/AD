// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2007 by Lattice Semiconductor Corporation
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

`resetall
`timescale 1 ns / 1 ps

`celldefine

module SPR16X4C (DI0, DI1, DI2, DI3, AD0, AD1, AD2, AD3, WRE, CK,
                 DO0, DO1, DO2, DO3);
 
  input AD0,AD1,AD2,AD3,DI0, DI1, DI2, DI3, CK, WRE;
  output DO0, DO1, DO2, DO3;

  parameter initval = "0x0000000000000000";

  integer i;
  reg wre_reg;
  reg [3:0] din_reg;
  reg [3:0] wadr_reg;
  reg [3:0] radr_reg;
  reg [3:0] MEM [15:0];
  reg [3:0] DOb;
  reg [143:0] pick_data;
  reg memchg;

  buf  (AD0b, AD0);
  buf  (AD1b, AD1);
  buf  (AD2b, AD2);
  buf  (AD3b, AD3);
  buf  (DI0b, DI0);
  buf  (DI1b, DI1);
  buf  (DI2b, DI2);
  buf  (DI3b, DI3);
  buf  (CKb, CK);
  buf  (WREb, WRE);

  buf  (DO0, DOb[0]);
  buf  (DO1, DOb[1]);
  buf  (DO2, DOb[2]);
  buf  (DO3, DOb[3]);

function [3:0] convert_hex;
input [7:0] int_str;
  begin

    if (int_str == "0")
      convert_hex = 4'b0000;
    else if (int_str == "1")
      convert_hex = 4'b0001;
    else if (int_str == "2")
      convert_hex = 4'b0010;
    else if (int_str == "3")
      convert_hex = 4'b0011;
    else if (int_str == "4")
      convert_hex = 4'b0100;
    else if (int_str == "5")
      convert_hex = 4'b0101;
    else if (int_str == "6")
      convert_hex = 4'b0110;
    else if (int_str == "7")
      convert_hex = 4'b0111;
    else if (int_str == "8")
      convert_hex = 4'b1000;
    else if (int_str == "9")
      convert_hex = 4'b1001;
    else if (int_str == "a" || int_str == "A")
      convert_hex = 4'b1010;
    else if (int_str == "b" || int_str == "B")
      convert_hex = 4'b1011;
    else if (int_str == "c" || int_str == "C")
      convert_hex = 4'b1100;
    else if (int_str == "d" || int_str == "D")
      convert_hex = 4'b1101;
    else if (int_str == "e" || int_str == "E")
      convert_hex = 4'b1110;
    else if (int_str == "f" || int_str == "F")
      convert_hex = 4'b1111;
    else
      convert_hex = 4'b0000;

  end
endfunction

  initial
  begin
     memchg = 1'b0;
     pick_data = initval; 
     for ( i = 0 ; i < 16; i = i + 1)
     begin
        MEM[i] = convert_hex(pick_data[7:0]);
        pick_data = (pick_data >> 8);
     end
  end

   // Latch the address and data in for writing
   // Registers are rising edge enabled
  always @ (posedge CKb) begin
       wre_reg <= WREb;
       din_reg <= {DI3b, DI2b, DI1b, DI0b};
       wadr_reg <= {AD3b, AD2b, AD1b, AD0b};
  end


  always @ (AD3b or AD2b or AD1b or AD0b) begin
     radr_reg = {AD3b, AD2b, AD1b, AD0b};
  end

  always @ (din_reg,wadr_reg,wre_reg) begin
     if (wre_reg === 1'b1) begin
        MEM[wadr_reg] = din_reg;
        memchg = ~memchg;
     end
  end

  always @ (radr_reg or memchg)
  begin
        DOb = MEM[radr_reg];
  end

endmodule

`endcelldefine

