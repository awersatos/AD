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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/CB2.v,v 1.2 2005/05/19 19:06:20 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

module CB2 (CI, PC0, PC1, CON, CO, NC0, NC1);
input  CI, PC0, PC1, CON;
output CO, NC0, NC1;

and INST10 (I3, CII, CONN);
and INST11 (I4, PC0, CII);
and INST12 (I5, CONN, PC0);
or INST13 (I6, I3, I4, I5);
xor INST14 (NC0, PC0, CONN, CII);

and INST20 (I17, CONN, PC1);
and INST21 (I15, I6, CONN);
and INST22 (I16, PC1, I6);
or INST23 (CO, I15, I16, I17);
xor INST24 (NC1, PC1, CONN, I6);

not INST96 (CONN, CONI);
buf (CII, CI);
buf (CONI, CON);

endmodule 

