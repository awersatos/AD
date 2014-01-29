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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/FMULT41.v,v 1.3 2005/05/19 19:01:26 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module FMULT41 (A0, A1, A2, A3, B0, B1, B2, B3, 
       MULT, CI, CO, P0, P1, P2, P3);
input  A0, A1, A2, A3, B0, B1, B2, B3, MULT, CI;
output CO, P0, P1, P2, P3;

/*AND2 INST1 (.A(MULT), .B(B0), .Z(PP0));
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
AND2 \INST8.INST2 (.A(A3), .B(PP3), .Z(\INST8.I5 ));*/

and  (PP0, MULT, B0);
and  (I23, CI, A0);
and  (I24, PP0, CI);
or   (CO0, I23, I24, I25);
xor  (P0, PP0, A0, CI);
and  (I25, A0, PP0);
and  (PP1, MULT, B1);
and  (I43, CO0, A1);
and  (I44, PP1, CO0);
or   (CO1, I43, I44, I45);
xor  (P1, PP1, A1, CO0);
and  (I45, A1, PP1);
and  (PP2, MULT, B2);
and  (I63, CO1, A2);
and  (I64, PP2, CO1);
or   (CO2, I63, I64, I65);
xor  (P2, PP2, A2, CO1);
and  (I65, A2, PP2);
and  (PP3, MULT, B3);
and  (I83, CO2, A3);
and  (I84, PP3, CO2);
or   (CO, I83, I84, I85);
xor  (P3, PP3, A3, CO2);
and  (I85, A3, PP3);


endmodule

`endcelldefine
