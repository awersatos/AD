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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/PFUMX.v,v 1.2 2005/05/19 18:06:23 pradeep Exp $ 
//
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.2.0.3 on Thu Sep  8 14:27:06 1994 */
/* module compiled from "lsl2db 4.0.3" run */

module PFUMX (ALUT, BLUT, C0, Z);
input  ALUT, BLUT, C0;
output Z;
OR2 INST11 (.A(I3), .B(I2), .Z(Z));
NOT INST5 (.A(C0IN), .Z(I4));
AND2 INST6 (.A(I4), .B(BLUTIN), .Z(I2));
AND2 INST7 (.A(ALUTIN), .B(C0IN), .Z(I3));
DELAY INST900 (.A(ALUT), .Z(ALUTIN));
DELAY INST901 (.A(BLUT), .Z(BLUTIN));
DELAY INST902 (.A(C0), .Z(C0IN));

endmodule

