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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/PUR.v,v 1.3 2005/05/19 19:06:59 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps
`celldefine

module PUR (PUR);
  input PUR;
parameter RST_PULSE = 1;

reg PURNET;

initial
begin
 PURNET = 1'b0;
 #RST_PULSE
 PURNET = 1'b1;
end

endmodule
`endcelldefine
