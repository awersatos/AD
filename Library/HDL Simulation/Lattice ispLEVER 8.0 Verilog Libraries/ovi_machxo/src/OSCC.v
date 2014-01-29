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
// Simulation Library File for XO
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mj/RCS/OSCC.v,v 1.2 2005/05/19 20:01:23 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module OSCC (OSC);
  output OSC;

  reg OSCb;

  initial
  begin
     OSCb = 1'b0;
     forever begin
        #25 OSCb = ~OSCb;
     end
  end

  buf (OSC, OSCb);

endmodule 

`endcelldefine
