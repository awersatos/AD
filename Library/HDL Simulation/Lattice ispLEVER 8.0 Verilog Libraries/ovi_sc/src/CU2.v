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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/CU2.v,v 1.4 2005/05/19 19:06:22 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Fri Jun 24 11:42:33 1994 */
/* module compiled from "lsl2db 3.6.4" run */

module CU2 (CI, PC0, PC1, CO, NC0, NC1);
input  CI, PC0, PC1;
output CO, NC0, NC1;
and INST11 (I6, PC0, CII);
xor INST13 (NC0, PC0, CII);
and INST24 (CO, PC1, I6);
xor INST26 (NC1, PC1, I6);
//DELAY  INST990 (.A(CI), .Z(CII));
buf  INST990 (CII, CI);

endmodule 

