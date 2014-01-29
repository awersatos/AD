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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/CLKDET.v,v 1.3 2005/05/19 19:06:22 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module CLKDET(CLK, RST, Q);
   input CLK, RST;
   output Q;

   wire CLKB, RSTB;

   reg QB;

   buf (CLKB, CLK);
   buf (RSTB, RST);

   buf (Q, QB);

// Shift Generation

always @ (posedge RSTB or posedge CLKB)
begin
   if (RSTB == 1'b1)
   begin
      QB <= 1'b0;
   end
   else
   begin
      QB <= 1'b1;
   end
end

endmodule

`endcelldefine
