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
// Simulation Library File for ECP
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5ecp/RCS/FADSU4.v,v 1.2 2005/05/19 19:12:29 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module FADSU4 (A0, A1, A2, A3, B0, B1, B2, B3, BCI, CON, BCO, S0, S1, S2, S3);
input  A0, A1, A2, A3, B0, B1, B2, B3, BCI, CON;
output BCO, S0, S1, S2, S3;


and INST10 (I3, BCI, I9);
and INST11 (I4, A0, BCI);
or INST12 (I6, I3, I4, I5);
xor INST13 (S0, A0, I9, BCI);
xnor INST14 (I9, CON, B0);
and INST2 (I5, I9, A0);
and INST30 (I27, I23, A1);
and INST31 (I25, I6, I23);
and INST32 (I26, A1, I6);
or INST33 (I28, I25, I26, I27);
xor INST34 (S1, A1, I23, I6);
xnor INST35 (I23, CON, B1);
and INST46 (I43, I39, A2);
and INST47 (I41, I28, I39);
and INST48 (I42, A2, I28);
or INST49 (I44, I41, I42, I43);
xor INST50 (S2, A2, I39, I28);
xnor INST51 (I39, CON, B2);
and INST62 (I59, I55, A3);
and INST63 (I57, I44, I55);
and INST64 (I58, A3, I44);
or INST65 (BCO, I57, I58, I59);
xor INST66 (S3, A3, I55, I44);
xnor INST67 (I55, CON, B3);


endmodule 

`endcelldefine
