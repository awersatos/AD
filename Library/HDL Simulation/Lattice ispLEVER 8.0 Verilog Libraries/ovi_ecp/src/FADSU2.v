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
// Simulation Library File for EC/XP
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mg/RCS/FADSU2.v,v 1.3 2005/05/19 20:08:33 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module FADSU2 (A0, A1, B0, B1, BCI, CON, BCO, S0, S1);
input  A0, A1, B0, B1, BCI, CON;
output BCO, S0, S1;


and INST10 (I3, BCI, I9);
and INST11 (I4, A0, BCI);
or INST12 (I6, I3, I4, I5);
xor INST13 (S0, A0, I9, BCI);
xnor INST14 (I9, CON, B0);

and INST2 (I5, I9, A0);
and INST30 (I27, I23, A1);
and INST31 (I25, I6, I23);
and INST32 (I26, A1, I6);
or INST33 (BCO, I25, I26, I27);
xor INST34 (S1, A1, I23, I6);
xnor INST35 (I23, CON, B1);


endmodule 

`endcelldefine
