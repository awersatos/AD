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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/ILF2P3IX.v,v 1.2 2005/05/19 19:01:35 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module ILF2P3IX (D, SP, ECLK, SCLK, CD, Q);
  parameter DISABLED_GSR = 0;
  defparam INST2.DISABLED_GSR = DISABLED_GSR;
  input  D, SP, ECLK, SCLK, CD;
  output Q;
  not (ECLK_N, ECLK);
  FD1S1AQ INST1 (.D(D), .CK(ECLK_N), .Q(Q_INT));
  FD1P3IX INST2 (.D(Q_INT), .SP(SP), .CK(SCLK), .CD(CD),
                 .Q(Q), .QN());

endmodule

`endcelldefine
