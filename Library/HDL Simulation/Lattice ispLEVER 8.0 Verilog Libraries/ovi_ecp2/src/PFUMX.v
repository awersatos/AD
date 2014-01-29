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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/PFUMX.v,v 1.3 2005/05/19 19:06:59 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

/* Created by DB2VERILOG Version 1.2.0.3 on Thu Sep  8 14:27:06 1994 */
/* module compiled from "lsl2db 4.0.3" run */

`celldefine

module PFUMX (ALUT, BLUT, C0, Z);
input  ALUT, BLUT, C0;
output Z;

or   (Z, I3, I2);
not  (I4, C0IN);
and  (I2, I4, BLUTIN);
and  (I3, ALUTIN, C0IN);
buf  (ALUTIN, ALUT);
buf  (BLUTIN, BLUT);
buf  (C0IN, C0);


endmodule
`endcelldefine
