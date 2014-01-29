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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/ROM16X1A.v,v 1.3 2005/05/19 19:07:00 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module ROM16X1A ( AD0, AD1, AD2, AD3, DO0);

   input AD0, AD1, AD2, AD3;
   output DO0;

   parameter [15:0] initval = 16'h0000;

   wire [15:0] mem;
   integer log, k, i;
   wire [3:0] address;
   wire  AD0b, AD1b, AD2b, AD3b;
   reg DO0b;

// functions of DataSame mux2 ... mux16 to implement rom16x1 supporting unknown.

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
    assign mem = initval;

    assign address = {AD3b, AD2b, AD1b, AD0b};

    always @(address, mem)
       begin
         DO0b = mux16x1 ((mem), (address));
       end

   buf  (AD0b, AD0);
   buf  (AD1b, AD1);
   buf  (AD2b, AD2);
   buf  (AD3b, AD3);
   buf  (DO0, DO0b);


endmodule

`endcelldefine

