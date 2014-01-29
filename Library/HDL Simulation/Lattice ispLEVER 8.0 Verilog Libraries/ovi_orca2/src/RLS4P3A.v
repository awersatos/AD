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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/RLS4P3A.v,v 1.3 2005/05/19 18:06:27 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue May 17 10:53:41 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module RLS4P3A (D, D0, D1, D2, D3, SP, CK, SD, Q0, Q1, Q2, Q3);
input  D, D0, D1, D2, D3, SP, CK, SD;
output Q0, Q1, Q2, Q3;
FL1P3AZ INST1 (.D0(D), .D1(D0), .SP(SP), .CK(CK), .SD(SD),
      .Q(Q0), .QN());
FL1P3AZ INST2 (.D0(Q0), .D1(D1), .SP(SP), .CK(CK), .SD(SD),
       .Q(Q1), .QN());
FL1P3AZ INST3 (.D0(Q1), .D1(D2), .SP(SP), .CK(CK), .SD(SD),
       .Q(Q2), .QN());
FL1P3AZ INST4 (.D0(Q2), .D1(D3), .SP(SP), .CK(CK), .SD(SD),
       .Q(Q3), .QN());

endmodule
`endcelldefine
