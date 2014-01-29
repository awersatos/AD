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
// Simulation Library File for ORCA2
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/CD4.v,v 1.2 2005/05/19 18:05:29 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Fri Jun 24 11:42:18 1994 */
/* module compiled from "lsl2db 3.6.4" run */

module CD4 (CI, PC0, PC1, PC2, PC3, CO, NC0, NC1, NC2, NC3);
input  CI, PC0, PC1, PC2, PC3;
output CO, NC0, NC1, NC2, NC3;
and INST11 (I4, PC0, CII);
or INST12 (I6, CII, I4, PC0);
xnor INST13 (NC0, PC0, CII);
and INST24 (I16, PC1, I6);
or INST25 (I18, I6, I16, PC1);
xnor INST26 (NC1, PC1, I6);
and INST37 (I29, PC2, I18);
or INST38 (I31, I18, I29, PC2);
xnor INST39 (NC2, PC2, I18);
and INST50 (I42, PC3, I31);
or INST51 (CO, I31, I42, PC3);
xnor INST52 (NC3, PC3, I31);
DELAY  INST990 (.A(CI), .Z(CII));

endmodule 

