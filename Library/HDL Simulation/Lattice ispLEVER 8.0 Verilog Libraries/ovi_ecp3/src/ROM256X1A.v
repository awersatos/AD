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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/ROM256X1A.v,v 1.4 2005/05/19 19:07:00 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module ROM256X1A ( AD0, AD1, AD2, AD3, AD4, AD5, AD6, AD7, DO0);

   input AD0, AD1, AD2, AD3, AD4, AD5, AD6, AD7;
   output DO0;
   wire AD0b, AD1b, AD2b, AD3b, AD4b, AD5b, AD6b, AD7b;

   parameter [255:0] initval = 256'h0000000000000000000000000000000000000000000000000000000000000000;

   wire [255:0] mem;
   integer log, k, i;
   wire [7:0] address;
   reg DO0b;

// functions of DataSame mux2 ... mux32 to implement rom32x1 supporting unknown
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

    function mux16 ;
       input [15:0] din;
       input [3:0] dselect;
       reg   mux16_1, mux16_2;
       begin
         case (dselect[3])
            1'b0  : mux16 = mux81(din[7:0], dselect[2:0]);
            1'b1  : mux16 = mux81(din[15:8], dselect[2:0]);
            default begin
                    mux16_1 = mux81(din[7:0], dselect[2:0]);
                    mux16_2 = mux81(din[15:8], dselect[2:0]);
                    mux16   = DataSame(mux16_1,mux16_2);
                    end
         endcase
       end
    endfunction

    function mux32 ;
       input [31:0] din;
       input [4:0] dselect;
       reg   mux32_1, mux32_2;
       begin
         case (dselect[4])
            1'b0  : mux32 = mux16(din[15:0], dselect[3:0]);
            1'b1  : mux32 = mux16(din[31:16], dselect[3:0]);
            default begin
                    mux32_1 = mux16(din[15:0], dselect[3:0]);
                    mux32_2 = mux16(din[31:16], dselect[3:0]);
                    mux32   = DataSame(mux32_1,mux32_2);
                    end
         endcase
       end
    endfunction

    function mux64 ;
       input [63:0] din;
       input [5:0] dselect;
       reg   mux64_1, mux64_2;
       begin
         case (dselect[5])
            1'b0  : mux64 = mux32(din[31:0], dselect[4:0]);
            1'b1  : mux64 = mux32(din[63:32], dselect[4:0]);
            default begin
                    mux64_1 = mux32(din[31:0], dselect[4:0]);
                    mux64_2 = mux32(din[63:32], dselect[4:0]);
                    mux64   = DataSame(mux64_1,mux64_2);
                    end
         endcase
       end
    endfunction

    function mux128 ;
       input [127:0] din;
       input [6:0] dselect;
       reg   mux128_1, mux128_2;
       begin
         case (dselect[6])
            1'b0  : mux128 = mux64(din[63:0], dselect[5:0]);
            1'b1  : mux128 = mux64(din[127:64], dselect[5:0]);
            default begin
                    mux128_1 = mux64(din[63:0], dselect[5:0]);
                    mux128_2 = mux64(din[127:64], dselect[5:0]);
                    mux128   = DataSame(mux128_1,mux128_2);
                    end
         endcase
       end
    endfunction

    function mux256 ;
       input [255:0] din;
       input [7:0] dselect;
       reg   mux256_1, mux256_2;
       begin
         case (dselect[7])
            1'b0  : mux256 = mux128(din[127:0], dselect[6:0]);
            1'b1  : mux256 = mux128(din[255:128], dselect[6:0]);
            default begin
                    mux256_1 = mux128(din[127:0], dselect[6:0]);
                    mux256_2 = mux128(din[255:128], dselect[6:0]);
                    mux256   = DataSame(mux256_1,mux256_2);
                    end
         endcase
       end
    endfunction

// Initialization of memory
    assign mem = initval;

    assign address = {AD7b, AD6b, AD5b, AD4b, AD3b, AD2b, AD1b, AD0b};

    always @(address, mem)
       begin
         DO0b = mux256 ((mem), (address));
       end

   buf  (AD0b, AD0);
   buf  (AD1b, AD1);
   buf  (AD2b, AD2);
   buf  (AD3b, AD3);
   buf  (AD4b, AD4);
   buf  (AD5b, AD5);
   buf  (AD6b, AD6);
   buf  (AD7b, AD7);
   buf  (DO0, DO0b);


endmodule

`endcelldefine


