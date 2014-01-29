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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/LD8P3BX.v,v 1.2 2005/05/19 19:01:46 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

/* Created by DB2VERILOG Version 1.3.8.0 on Mon Sep 15 14:59:31 1997 */
/* module compiled from "lsl2db 4.4.5 (07/17/96)" run */

module LD8P3BX (D0, D1, D2, D3, D4, D5, D6, D7, CI, 
       SP, CK, SD, PD, CO, Q0, Q1, Q2, Q3, Q4, Q5, 
       Q6, Q7);
parameter DISABLED_GSR = 0;
defparam INST1.DISABLED_GSR = DISABLED_GSR;
defparam INST2.DISABLED_GSR = DISABLED_GSR;
input  D0, D1, D2, D3, D4, D5, D6, D7, CI, SP, CK, SD, PD;
output CO, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7;
LD4P3BX INST1 (.D0(D0), .D1(D1), .D2(D2), .D3(D3), .CI(CI),
      .SP(SP), .CK(CK), .SD(SD), .PD(PD), .CO(CO_INT),
      .Q0(Q0), .Q1(Q1), .Q2(Q2), .Q3(Q3));
LD4P3BX INST2 (.D0(D4), .D1(D5), .D2(D6), .D3(D7), .CI(
      CO_INT), .SP(SP), .CK(CK), .SD(SD), .PD(PD), .CO(CO),
      .Q0(Q4), .Q1(Q5), .Q2(Q6), .Q3(Q7));

endmodule

`endcelldefine
