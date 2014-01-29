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
// Simulation Library File for ORCA2A
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2a/RCS/FMULT41.v,v 1.2 2005/05/19 18:26:20 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps
`celldefine

/* Created by DB2VERILOG Version 1.3.0.3 on Tue Jan 23 16:49:52 1996 */
/* module compiled from "lsl2db 4.1.3" run */

module FMULT41 (A0, A1, A2, A3, B0, B1, B2, B3, 
       MULT, CI, CO, P0, P1, P2, P3);
input  A0, A1, A2, A3, B0, B1, B2, B3, MULT, CI;
output CO, P0, P1, P2, P3;
AND2 INST1 (.A(MULT), .B(B0), .Z(PP0));
AND2 \INST2.INST10 (.A(CI), .B(A0), .Z(\INST2.I3 ));
AND2 \INST2.INST11 (.A(PP0), .B(CI), .Z(\INST2.I4 ));
OR3 \INST2.INST12 (.A(\INST2.I3 ), .B(\INST2.I4 ), .C(
      \INST2.I5 ), .Z(CO0));
XOR3 \INST2.INST13 (.A(PP0), .B(A0), .C(CI), .Z(P0));
AND2 \INST2.INST2 (.A(A0), .B(PP0), .Z(\INST2.I5 ));
AND2 INST3 (.A(MULT), .B(B1), .Z(PP1));
AND2 \INST4.INST10 (.A(CO0), .B(A1), .Z(\INST4.I3 ));
AND2 \INST4.INST11 (.A(PP1), .B(CO0), .Z(\INST4.I4 ));
OR3 \INST4.INST12 (.A(\INST4.I3 ), .B(\INST4.I4 ), .C(
      \INST4.I5 ), .Z(CO1));
XOR3 \INST4.INST13 (.A(PP1), .B(A1), .C(CO0), .Z(P1));
AND2 \INST4.INST2 (.A(A1), .B(PP1), .Z(\INST4.I5 ));
AND2 INST5 (.A(MULT), .B(B2), .Z(PP2));
AND2 \INST6.INST10 (.A(CO1), .B(A2), .Z(\INST6.I3 ));
AND2 \INST6.INST11 (.A(PP2), .B(CO1), .Z(\INST6.I4 ));
OR3 \INST6.INST12 (.A(\INST6.I3 ), .B(\INST6.I4 ), .C(
      \INST6.I5 ), .Z(CO2));
XOR3 \INST6.INST13 (.A(PP2), .B(A2), .C(CO1), .Z(P2));
AND2 \INST6.INST2 (.A(A2), .B(PP2), .Z(\INST6.I5 ));
AND2 INST7 (.A(MULT), .B(B3), .Z(PP3));
AND2 \INST8.INST10 (.A(CO2), .B(A3), .Z(\INST8.I3 ));
AND2 \INST8.INST11 (.A(PP3), .B(CO2), .Z(\INST8.I4 ));
OR3 \INST8.INST12 (.A(\INST8.I3 ), .B(\INST8.I4 ), .C(
      \INST8.I5 ), .Z(CO));
XOR3 \INST8.INST13 (.A(PP3), .B(A3), .C(CO2), .Z(P3));
AND2 \INST8.INST2 (.A(A3), .B(PP3), .Z(\INST8.I5 ));

endmodule
`endcelldefine
