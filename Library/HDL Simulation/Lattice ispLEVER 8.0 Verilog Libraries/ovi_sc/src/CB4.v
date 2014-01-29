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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/CB4.v,v 1.4 2005/05/19 19:06:20 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

module CB4 (CI, PC0, PC1, PC2, PC3, CON, CO, NC0, NC1, NC2, NC3);
input  CI, PC0, PC1, PC2, PC3, CON;
output CO, NC0, NC1, NC2, NC3;
and INST10 (I3, CII, CONN);
and INST11 (I4, PC0, CII);
or INST12 (I6, I3, I4, I5);
xor INST13 (NC0, PC0, CONN, CII);
and INST2 (I5, CONN, PC0);
and INST22 (I17, CONN, PC1);
and INST23 (I15, I6, CONN);
and INST24 (I16, PC1, I6);
or INST25 (I18, I15, I16, I17);
xor INST26 (NC1, PC1, CONN, I6);
and INST35 (I30, CONN, PC2);
and INST36 (I28, I18, CONN);
and INST37 (I29, PC2, I18);
or INST38 (I31, I28, I29, I30);
xor INST39 (NC2, PC2, CONN, I18);
and INST48 (I43, CONN, PC3);
and INST49 (I41, I31, CONN);
and INST50 (I42, PC3, I31);
or INST51 (CO, I41, I42, I43);
xor INST52 (NC3, PC3, CONN, I31);
not INST96 (CONN, CONI);
buf    (CII, CI);
buf    (CONI, CON);

endmodule

