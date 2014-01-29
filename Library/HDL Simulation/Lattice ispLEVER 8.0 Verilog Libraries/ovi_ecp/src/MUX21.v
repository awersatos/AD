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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/MUX21.v,v 1.3 2005/05/19 19:06:50 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module MUX21 (D0, D1, SD, Z);
  input  D0, D1, SD;
  output Z;
  reg    Zb;
  wire D0b, D1b, SDb;

      function DataSame;
        input a, b;
        begin
          if (a === b)
            DataSame = a;
          else
            DataSame = 1'bx;
        end
      endfunction

      always @(D0b or D1b or SDb)
      begin
      case (SDb)
        1'b0 :  Zb = D0b;
        1'b1 :  Zb = D1b;
        default Zb = DataSame(D0b, D1b);
      endcase
      end

   buf  (D0b, D0);
   buf  (D1b, D1);
   buf  (SDb, SD);
   buf  (Z, Zb);


endmodule

`endcelldefine
