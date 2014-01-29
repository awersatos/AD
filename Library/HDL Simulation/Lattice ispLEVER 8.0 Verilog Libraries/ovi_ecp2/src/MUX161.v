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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/MUX161.v,v 1.2 2005/05/19 19:06:49 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module MUX161 (D0, D1, D2, D3, D4, D5, D6, D7, 
              D8, D9, D10, D11, D12, D13, D14, D15, SD1, SD2, SD3, SD4, Z);
  input  D0, D1, D2, D3, D4, D5, D6, D7, SD1, SD2, SD3, SD4;
  input  D8, D9, D10, D11, D12, D13, D14, D15;
  output Z;
  reg    Zb;
  wire  D0b, D1b, D2b, D3b, D4b, D5b, D6b, D7b, SD1b, SD2b, SD3b, SD4b;
  wire  D8b, D9b, D10b, D11b, D12b, D13b, D14b, D15b;
  wire [3:0] dselect;
  wire [15:0] dinput;

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

    function mux8x1 ;
       input [7:0] din;
       input [2:0] dsel;
       reg   mux81_1, mux81_2;
       begin
        case (dsel[2])
           1'b0  : mux8x1 = mux41(din[3:0], dsel[1:0]);
           1'b1  : mux8x1 = mux41(din[7:4], dsel[1:0]);
           default begin
                   mux81_1 = mux41(din[3:0], dsel[1:0]);
                   mux81_2 = mux41(din[7:4], dsel[1:0]);
                   mux8x1   = DataSame(mux81_1,mux81_2);
                   end
         endcase
       end
    endfunction

    function mux16x1 ;
       input [15:0] din;
       input [3:0] dsel;
       reg   mux161_1, mux161_2;
       begin
        case (dsel[3])
           1'b0  : mux16x1 = mux8x1(din[7:0], dsel[2:0]);
           1'b1  : mux16x1 = mux8x1(din[15:8], dsel[2:0]);
           default begin
                   mux161_1 = mux8x1(din[7:0], dsel[2:0]);
                   mux161_2 = mux8x1(din[15:8], dsel[2:0]);
                   mux16x1   = DataSame(mux161_1,mux161_2);
                   end
         endcase
       end
    endfunction

    assign dselect = {SD4b, SD3b, SD2b, SD1b};
    assign dinput = {D15b, D14b, D13b, D12b, D11b, D10b, D9b, D8b, D7b, D6b, D5b, D4b, D3b, D2b, D1b, D0b};

    always @ (dselect or dinput)
    begin
       Zb = mux16x1((dinput), (dselect));
    end
 
   buf  (D0b, D0);
   buf  (D1b, D1);
   buf  (D2b, D2);
   buf  (D3b, D3);
   buf  (D4b, D4);
   buf  (D5b, D5);
   buf  (D6b, D6);
   buf  (D7b, D7);
   buf  (D8b, D8);
   buf  (D9b, D9);
   buf  (D10b, D10);
   buf  (D11b, D11);
   buf  (D12b, D12);
   buf  (D13b, D13);
   buf  (D14b, D14);
   buf  (D15b, D15);
   buf  (SD1b, SD1);
   buf  (SD2b, SD2);
   buf  (SD3b, SD3);
   buf  (SD4b, SD4);
   buf  (Z, Zb);


endmodule

`endcelldefine
