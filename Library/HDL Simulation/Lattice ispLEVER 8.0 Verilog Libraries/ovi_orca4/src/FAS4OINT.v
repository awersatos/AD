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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/FAS4OINT.v,v 1.2 2005/05/19 19:01:11 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module FAS4OINT (A0, A1, A2, A3, B0, B1, B2, B3, BCI, 
       CON, OFL, S0, S1, S2, S3);
input  A0, A1, A2, A3, B0, B1, B2, B3, BCI, CON;
output OFL, S0, S1, S2, S3;
and  (I3, BCI, I9);
and  (I4, A0, BCI);
or   (I6, I3, I4, I5);
xor  (S0, A0, I9, BCI);
xnor (I9, CON, B0);
and  (I5, I9, A0);
and  (I27, I23, A1);
and  (I25, I6, I23);
and  (I26, A1, I6);
or   (I28, I25, I26, I27);
xor  (S1, A1, I23, I6);
xnor (I23, CON, B1);
and  (I43, I39, A2);
and  (I41, I28, I39);
and  (I42, A2, I28);
or   (I44, I41, I42, I43);
xor  (S2, A2, I39, I28);
xnor (I39, CON, B2);
and  (I59, I55, A3);
and  (I57, I44, I55);
and  (I58, A3, I44);
or   (BCO, I57, I58, I59);
xor  (S3, A3, I55, I44);
xnor (I55, CON, B3);
xor  (OFL, I44, BCO);
 
endmodule

`endcelldefine
