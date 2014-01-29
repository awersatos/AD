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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/ILF2P3JX.v,v 1.5 2005/05/19 19:06:39 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module ILF2P3JX (D, SP, ECLK, SCLK, PD, Q);
  parameter GSR = "ENABLED";
  defparam INST2.GSR = GSR;
  input  D, SP, ECLK, SCLK, PD;
  output Q;

  wire Qb;

  not  (ECLK_N, ECLK);
  FD1S1AQ INST1 (.D(D), .CK(ECLK_N), .Q(Q_INT));
  FD1P3JX INST2 (.D(Q_INT), .SP(SP), .CK(SCLK), .PD(PD),
                 .Q(Qb));

  buf (Q, Qb);

endmodule

`endcelldefine
