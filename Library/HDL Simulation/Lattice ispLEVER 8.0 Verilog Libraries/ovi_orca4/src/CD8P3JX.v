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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/CD8P3JX.v,v 1.2 2005/05/19 19:00:59 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

/* Created by DB2VERILOG Version 1.3.8.0 on Mon Sep 15 14:02:09 1997 */
/* module compiled from "lsl2db 4.4.5 (07/17/96)" run */

module CD8P3JX (CI, SP, CK, PD, CO, Q0, Q1, Q2, Q3, 
       Q4, Q5, Q6, Q7);
parameter DISABLED_GSR = 0;
defparam INST1.DISABLED_GSR = DISABLED_GSR;
defparam INST2.DISABLED_GSR = DISABLED_GSR;
input  CI, SP, CK, PD;
output CO, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7;
CD4P3JX INST1 (.CI(CI), .SP(SP), .CK(CK), .PD(PD), .CO(
      CO_INT), .Q0(Q0), .Q1(Q1), .Q2(Q2), .Q3(Q3));
CD4P3JX INST2 (.CI(CO_INT), .SP(SP), .CK(CK), .PD(PD),
      .CO(CO), .Q0(Q4), .Q1(Q5), .Q2(Q6), .Q3(Q7));

endmodule

`endcelldefine
