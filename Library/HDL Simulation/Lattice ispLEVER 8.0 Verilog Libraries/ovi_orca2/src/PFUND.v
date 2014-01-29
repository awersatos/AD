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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/PFUND.v,v 1.2 2005/05/19 18:06:23 pradeep Exp $ 
//
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.2.0.3 on Thu Sep  8 14:28:58 1994 */
/* module compiled from "lsl2db 4.0.3" run */

module PFUND (ALUT, BLUT, C0, Z);
input  ALUT, BLUT, C0;
output Z;
ND3 INST1 (.A(ALUTIN), .B(BLUTIN), .C(C0IN), .Z(Z));
BUF INST900 (.A(ALUT), .Z(ALUTIN));
BUF INST901 (.A(BLUT), .Z(BLUTIN));
BUF INST902 (.A(C0), .Z(C0IN));

endmodule

