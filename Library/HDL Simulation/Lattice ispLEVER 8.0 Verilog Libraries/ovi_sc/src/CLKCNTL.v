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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/CLKCNTL.v,v 1.2 2005/05/19 19:06:21 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module CLKCNTL(D, CE, CLK, Q);
   input D, CE, CLK;
   output Q;

  parameter CLKMODE = "ECLK";

   wire CEB, CLKB;

   reg QB;

buf (CEB, CE);
buf (CLKB, CLK);

always @ (negedge CLKB or posedge CEB)
begin
   if (CEB == 1'b1)
      QB <= 1'b1;
   else
      QB <= CEB;
end

buf (Q, (D & QB));

endmodule

`endcelldefine
