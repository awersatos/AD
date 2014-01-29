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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/SGSR.v,v 1.6 2005/05/19 19:07:01 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps
`celldefine
module SGSR (GSR, CLK);
  input GSR, CLK;

reg GSRNET1;
reg GSRNET;

wire CLKb, GSRb;
buf (CLKb, CLK);
buf (GSRb, GSR);

always @ (posedge CLKb or negedge GSRb)
begin
   if (GSRb == 1'b0)
      GSRNET <= GSRb;
   else
      GSRNET <= GSRNET1;
end

always @ (posedge CLKb)
begin
      GSRNET1 <= GSRb;
end

endmodule
`endcelldefine

