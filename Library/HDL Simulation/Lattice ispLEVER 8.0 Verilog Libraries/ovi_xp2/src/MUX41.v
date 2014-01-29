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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/MUX41.v,v 1.3 2005/05/19 19:06:50 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module MUX41 (D0, D1, D2, D3, SD1, SD2, Z);
  input  D0, D1, D2, D3, SD1, SD2;
  output Z;
  reg    Zb;
  reg    same1, same2;
  wire  D0b, D1b, D2b, D3b, SD1b, SD2b;
  wire [1:0] dselect;
      function DataSame;
        input a, b;
        begin
          if (a === b)
            DataSame = a;
          else
            DataSame = 1'bx;
        end
      endfunction

    assign dselect = {SD2b, SD1b};

    always @(D0b or D1b or D2b or D3b or dselect)
      begin
        case (dselect)
         2'b00 : Zb = D0b;
         2'b01 : Zb = D1b;
         2'b10 : Zb = D2b;
         2'b11 : Zb = D3b;
         2'b0x : Zb = DataSame(D0b, D1b);
         2'b1x : Zb = DataSame(D2b, D3b);
         2'bx0 : Zb = DataSame(D2b, D0b);
         2'bx1 : Zb = DataSame(D3b, D1b);
         default begin
                 same1 = DataSame(D3b, D2b);
                 same2 = DataSame(D1b, D0b);
                 Zb = DataSame(same1,same2); 
                 end 
        endcase
      end

   buf  (D0b, D0);
   buf  (D1b, D1);
   buf  (D2b, D2);
   buf  (D3b, D3);
   buf  (SD1b, SD1);
   buf  (SD2b, SD2);
   buf  (Z, Zb);


endmodule

`endcelldefine
