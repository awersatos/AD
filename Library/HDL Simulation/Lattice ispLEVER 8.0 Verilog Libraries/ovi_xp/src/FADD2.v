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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/FADD2.v,v 1.3 2005/05/19 19:06:23 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module FADD2 (A0, A1,  B0, B1, CI, 
       COUT0, COUT1, S0, S1);
input  A0, A1, B0, B1, CI;
output COUT0, COUT1, S0, S1;


and INST10 (I3, CI, B0);
and INST11 (I4, A0, CI);
or  INST12 (COUT0, I3, I4, I5);
xor INST13 (S0, A0, B0, CI);
and INST2  (I5, B0, A0);

and INST22 (I17, B1, A1);
and INST23 (I15, COUT0, B1);
and INST24 (I16, A1, COUT0);
or  INST25 (COUT1, I15, I16, I17);
xor INST66 (S1, A1, B1, COUT0);


endmodule

`endcelldefine
