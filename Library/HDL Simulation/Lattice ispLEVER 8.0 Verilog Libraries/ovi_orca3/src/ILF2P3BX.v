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
// Simulation Library File for ORCA3
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/ILF2P3BX.v,v 1.7 2005/05/19 18:30:16 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module ILF2P3BX (D, SP, ECLK, SCLK, PD, Q);
  parameter DISABLED_GSR = 0;
  defparam INST2.DISABLED_GSR = DISABLED_GSR;
  input  D, SP, ECLK, SCLK, PD;
  output Q;
  not (ECLK_N, ECLK);
  FD1S1AQ INST1 (.D(D), .CK(ECLK_N), .Q(Q_INT));
  FD1P3BX INST2 (.D(Q_INT), .SP(SP), .CK(SCLK), .PD(PD),
                 .Q(Q), .QN());

endmodule

`endcelldefine
