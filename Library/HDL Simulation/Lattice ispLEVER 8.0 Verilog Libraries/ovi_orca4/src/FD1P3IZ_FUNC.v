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
// Simulation Library File for ORCA4
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/FD1P3IZ_FUNC.v,v 1.4 2005/05/19 19:01:14 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

/* Created by DB2VERILOG Version 1.0.1.1 on Tue Apr  5 13:47:25 1994 */
/* module compiled from "lsl2db 3.6.4" run */

module FD1P3IZ_FUNC (D, SP, CK, CD, SR, notifier, Q);
input  D, SP, CK, CD, SR, notifier;
output Q;
reg Q;
  wire QB;

or INST33 (I50, I36, I38);
and INST34 (I36, QB, I54);
and INST35 (I38, SP, I65, D);
not INST52 (I54, SP);
not INST57 (I65, CD);
UDFDL5_UDP_X INST6 (QB, I50, CK, I29, notifier);
not INST69 (I29, SR);

  always @ QB
  begin
      Q <= QB;
  end


endmodule

`endcelldefine
