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
//                     U.S.A 
// 
//                     TEL: 1-800-Lattice (USA and Canada) 
//                          408-826-6000 (other locations) 
// 
//                     web: http://www.latticesemi.com/ 
//                     email: techsupport@latticesemi.com 
// 
// -------------------------------------------------------------------- 
// 
// Simulation Library File for ISP2K/8K
// 
// -------------------------------------------------------------------- 
// 
// Revision History : 
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:55:54 1994
`timescale 10 ps / 10 ps 
module ADDF1(
	Z0, CO, A0, B0, 
	CI);

	output Z0;
	output CO;
	input A0;
	input B0;
	input CI;

AND2 \$1I135  (.Z0(\$1N144 ), .A0(\$1N93 ), .A1(CI));
AND2 \$1I138  (.Z0(\$1N146 ), .A0(B0), .A1(\$1N142 ));
OR2 \$1I148  (.Z0(\$1N150 ), .A0(\$1N146 ), .A1(\$1N144 ));
XOR2 \$1I160  (.Z0(Z0), .A0(A0), .A1(\$1N150 ));
INV \$1I29  (.ZN0(\$1N93 ), .A0(B0));
INV \$1I30  (.ZN0(\$1N142 ), .A0(CI));
AND2 \$1I32  (.Z0(\$1N53 ), .A0(CI), .A1(B0));
AND2 \$1I33  (.Z0(\$1N55 ), .A0(CI), .A1(A0));
AND2 \$1I34  (.Z0(\$1N57 ), .A0(B0), .A1(A0));
OR3 \$1I38  (.Z0(CO), .A0(\$1N53 ), .A1(\$1N55 ), .A2(\$1N57 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:56:08 1994
`timescale 10 ps / 10 ps 
module ADDF16A(
	CO, Z0, Z1, Z10, 
	Z11, Z12, Z13, Z14, 
	Z15, Z2, Z3, Z4, 
	Z5, Z6, Z7, Z8, 
	Z9, A0, A1, A10, 
	A11, A12, A13, A14, 
	A15, A2, A3, A4, 
	A5, A6, A7, A8, 
	A9, B0, B1, B10, 
	B11, B12, B13, B14, 
	B15, B2, B3, B4, 
	B5, B6, B7, B8, 
	B9, CI);

	output CO;
	output Z0;
	output Z1;
	output Z10;
	output Z11;
	output Z12;
	output Z13;
	output Z14;
	output Z15;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	output Z8;
	output Z9;
	input A0;
	input A1;
	input A10;
	input A11;
	input A12;
	input A13;
	input A14;
	input A15;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input A8;
	input A9;
	input B0;
	input B1;
	input B10;
	input B11;
	input B12;
	input B13;
	input B14;
	input B15;
	input B2;
	input B3;
	input B4;
	input B5;
	input B6;
	input B7;
	input B8;
	input B9;
	input CI;

PG1 \$1I680  (.PGO1(\$1N445 ), .GI1(G345), .PI1(P345), .PGI1(\$1N704 ));
PG2 \$1I682  (.PGO2(\$1N510 ), .GI2(G678), .PI2(P678), .GI1(G345), 
	.PI1(P345), .PGI1(\$1N704 ));
PG3 \$1I683  (.PGO3(\$1N515 ), .GI3(G911), .PI3(P911), .GI2(G678), 
	.PI2(P678), .GI1(G345), .PI1(P345), .PGI1(\$1N704 ));
PG4 \$1I684  (.PGO4(\$1N652 ), .GI4(G1214), .PI4(P1214), .GI3(G911), 
	.PI3(P911), .GI2(G678), .PI2(P678), .GI1(G345), 
	.PI1(P345), .PGI1(\$1N704 ));
PG1 \$1I702  (.PGO1(\$1N704 ), .GI1(G012), .PI1(P012), .PGI1(CI));
F3ADD \$1I716  (.Z0(Z0), .Z1(Z1), .Z2(Z2), .G012(G012), 
	.P012(P012), .A0(A0), .A1(A1), .A2(A2), 
	.B0(B0), .B1(B1), .B2(B2), .CI(CI));
F3ADD \$1I718  (.Z0(Z3), .Z1(Z4), .Z2(Z5), .G012(G345), 
	.P012(P345), .A0(A3), .A1(A4), .A2(A5), 
	.B0(B3), .B1(B4), .B2(B5), .CI(\$1N704 ));
F3ADD \$1I719  (.Z0(Z6), .Z1(Z7), .Z2(Z8), .G012(G678), 
	.P012(P678), .A0(A6), .A1(A7), .A2(A8), 
	.B0(B6), .B1(B7), .B2(B8), .CI(\$1N445 ));
F3ADD \$1I720  (.Z0(Z9), .Z1(Z10), .Z2(Z11), .G012(G911), 
	.P012(P911), .A0(A9), .A1(A10), .A2(A11), 
	.B0(B9), .B1(B10), .B2(B11), .CI(\$1N510 ));
F3ADD \$1I721  (.Z0(Z12), .Z1(Z13), .Z2(Z14), .G012(G1214), 
	.P012(P1214), .A0(A12), .A1(A13), .A2(A14), 
	.B0(B12), .B1(B13), .B2(B14), .CI(\$1N515 ));
ADDF1 \$1I723  (.Z0(Z15), .CO(CO), .A0(A15), .B0(B15), 
	.CI(\$1N652 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:56:12 1994
`timescale 10 ps / 10 ps 
module ADDF2(
	Z0, Z1, CO, A0, 
	A1, B0, B1, CI);

	output Z0;
	output Z1;
	output CO;
	input A0;
	input A1;
	input B0;
	input B1;
	input CI;

INV \$1I180  (.ZN0(\~CI ), .A0(CI));
AND3 \$1I336  (.Z0(\$1N370 ), .A0(CI), .A1(A1), .A2(A0));
AND3 \$1I340  (.Z0(\$1N368 ), .A0(CI), .A1(A1), .A2(B0));
AND3 \$1I341  (.Z0(\$1N366 ), .A0(CI), .A1(A0), .A2(B1));
AND3 \$1I342  (.Z0(\$1N372 ), .A0(CI), .A1(B1), .A2(B0));
AND3 \$1I343  (.Z0(\$1N376 ), .A0(A1), .A1(A0), .A2(B0));
AND3 \$1I344  (.Z0(\$1N402 ), .A0(A0), .A1(B1), .A2(B0));
AND2 \$1I345  (.Z0(\$1N378 ), .A0(A1), .A1(B1));
OR7 \$1I401  (.Z0(CO), .A0(\$1N370 ), .A1(\$1N368 ), .A2(\$1N366 ), 
	.A3(\$1N372 ), .A4(\$1N376 ), .A5(\$1N402 ), .A6(\$1N378 ));
AND3 \$1I416  (.Z0(\$1N441 ), .A0(\~A0 ), .A1(B1), .A2(\~CI ));
AND3 \$1I417  (.Z0(\$1N443 ), .A0(B1), .A1(\~B0 ), .A2(\~CI ));
AND3 \$1I418  (.Z0(\$1N445 ), .A0(A0), .A1(\~B1 ), .A2(CI));
AND3 \$1I419  (.Z0(\$1N447 ), .A0(\~B1 ), .A1(B0), .A2(CI));
AND3 \$1I420  (.Z0(\$1N449 ), .A0(\~A0 ), .A1(B1), .A2(\~B0 ));
AND3 \$1I421  (.Z0(\$1N451 ), .A0(A0), .A1(\~B1 ), .A2(B0));
OR6 \$1I440  (.Z0(\$1N455 ), .A0(\$1N441 ), .A1(\$1N443 ), .A2(\$1N445 ), 
	.A3(\$1N447 ), .A4(\$1N449 ), .A5(\$1N451 ));
LXOR2 \$1I453  (.Z0(Z1), .A0(A1), .A1(\$1N455 ));
INV \$1I486  (.ZN0(\~B0 ), .A0(B0));
INV \$1I487  (.ZN0(\~B1 ), .A0(B1));
INV \$1I495  (.ZN0(\~A0 ), .A0(A0));
XOR2 \$1I537  (.Z0(Z0), .A0(A0), .A1(\$1N542 ));
AND2 \$1I539  (.Z0(\$1N546 ), .A0(CI), .A1(\~B0 ));
OR2 \$1I541  (.Z0(\$1N542 ), .A0(\$1N546 ), .A1(\$1N548 ));
AND2 \$1I544  (.Z0(\$1N548 ), .A0(\~CI ), .A1(B0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:56:17 1994
`timescale 10 ps / 10 ps 
module ADDF4(
	Z0, Z1, Z2, Z3, 
	CO, A0, A1, A2, 
	A3, B0, B1, B2, 
	B3, CI);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output CO;
	input A0;
	input A1;
	input A2;
	input A3;
	input B0;
	input B1;
	input B2;
	input B3;
	input CI;

ADDF2 \$1I45  (.Z0(Z0), .Z1(Z1), .CO(\$1N4 ), .A0(A0), 
	.A1(A1), .B0(B0), .B1(B1), .CI(CI));
ADDF2 \$1I46  (.Z0(Z2), .Z1(Z3), .CO(CO), .A0(A2), 
	.A1(A3), .B0(B2), .B1(B3), .CI(\$1N4 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:56:23 1994
`timescale 10 ps / 10 ps 
module ADDF8(
	Z0, Z1, Z2, Z3, 
	Z4, Z5, Z6, Z7, 
	CO, A0, A1, A2, 
	A3, A4, A5, A6, 
	A7, B0, B1, B2, 
	B3, B4, B5, B6, 
	B7, CI);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	output CO;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input B0;
	input B1;
	input B2;
	input B3;
	input B4;
	input B5;
	input B6;
	input B7;
	input CI;

XOR2 \$1I164  (.Z0(P7), .A0(A7), .A1(B7));
XOR2 \$1I165  (.Z0(P6), .A0(A6), .A1(B6));
XOR2 \$1I166  (.Z0(P5), .A0(A5), .A1(B5));
XOR2 \$1I167  (.Z0(P4), .A0(A4), .A1(B4));
XOR2 \$1I168  (.Z0(P3), .A0(A3), .A1(B3));
XOR2 \$1I169  (.Z0(P2), .A0(A2), .A1(B2));
XOR2 \$1I170  (.Z0(P1), .A0(A1), .A1(B1));
XOR2 \$1I171  (.Z0(P0), .A0(A0), .A1(B0));
AND2 \$1I172  (.Z0(G7), .A0(A7), .A1(B7));
AND2 \$1I173  (.Z0(G6), .A0(A6), .A1(B6));
AND2 \$1I174  (.Z0(G5), .A0(A5), .A1(B5));
AND2 \$1I175  (.Z0(G4), .A0(A4), .A1(B4));
AND2 \$1I176  (.Z0(G3), .A0(A3), .A1(B3));
AND2 \$1I177  (.Z0(G2), .A0(A2), .A1(B2));
AND2 \$1I178  (.Z0(G1), .A0(A1), .A1(B1));
AND2 \$1I179  (.Z0(G0), .A0(A0), .A1(B0));
AND8 \$2I1  (.Z0(\$2N67 ), .A0(G0), .A1(P1), .A2(P2), 
	.A3(P3), .A4(P4), .A5(P5), .A6(P6), 
	.A7(P7));
OR6 \$2I114  (.Z0(\$2N128 ), .A0(\$2N119 ), .A1(\$2N117 ), .A2(\$2N115 ), 
	.A3(\$2N121 ), .A4(\$2N123 ), .A5(G4));
LXOR2 \$2I126  (.Z0(Z5), .A0(\$2N128 ), .A1(P5));
AND7 \$2I13  (.Z0(\$2N65 ), .A0(G1), .A1(P2), .A2(P3), 
	.A3(P4), .A4(P5), .A5(P6), .A6(P7));
OR5 \$2I14  (.Z0(\$2N82 ), .A0(\$2N75 ), .A1(\$2N73 ), .A2(\$2N79 ), 
	.A3(\$2N77 ), .A4(G7));
AND2 \$2I144  (.Z0(\$2N149 ), .A0(G0), .A1(P1));
AND3 \$2I145  (.Z0(\$2N147 ), .A0(CI), .A1(P0), .A2(P1));
OR3 \$2I146  (.Z0(\$2N153 ), .A0(\$2N147 ), .A1(\$2N149 ), .A2(G1));
AND9 \$2I15  (.Z0(\$2N71 ), .A0(CI), .A1(P0), .A2(P1), 
	.A3(P2), .A4(P3), .A5(P4), .A6(P5), 
	.A7(P6), .A8(P7));
LXOR2 \$2I152  (.Z0(Z2), .A0(\$2N153 ), .A1(P2));
AND6 \$2I2  (.Z0(\$2N69 ), .A0(G2), .A1(P3), .A2(P4), 
	.A3(P5), .A4(P6), .A5(P7));
AND5 \$2I3  (.Z0(\$2N75 ), .A0(G3), .A1(P4), .A2(P5), 
	.A3(P6), .A4(P7));
AND2 \$2I4  (.Z0(\$2N77 ), .A0(G6), .A1(P7));
AND3 \$2I5  (.Z0(\$2N79 ), .A0(G5), .A1(P6), .A2(P7));
AND4 \$2I6  (.Z0(\$2N73 ), .A0(G4), .A1(P5), .A2(P6), 
	.A3(P7));
OR4 \$2I64  (.Z0(\$2N84 ), .A0(\$2N71 ), .A1(\$2N67 ), .A2(\$2N65 ), 
	.A3(\$2N69 ));
OR2 \$2I81  (.Z0(CO), .A0(\$2N84 ), .A1(\$2N82 ));
AND6 \$2I89  (.Z0(\$2N119 ), .A0(CI), .A1(P0), .A2(P1), 
	.A3(P2), .A4(P3), .A5(P4));
AND5 \$2I90  (.Z0(\$2N117 ), .A0(G0), .A1(P1), .A2(P2), 
	.A3(P3), .A4(P4));
AND4 \$2I91  (.Z0(\$2N115 ), .A0(G1), .A1(P2), .A2(P3), 
	.A3(P4));
AND3 \$2I92  (.Z0(\$2N121 ), .A0(G2), .A1(P3), .A2(P4));
AND2 \$2I93  (.Z0(\$2N123 ), .A0(G3), .A1(P4));
AND2 \$3I102  (.Z0(\$3N68 ), .A0(CI), .A1(P0));
OR2 \$3I103  (.Z0(\$3N63 ), .A0(\$3N68 ), .A1(G0));
OR2 \$3I32  (.Z0(\$3N54 ), .A0(\$3N34 ), .A1(\$3N33 ));
LXOR2 \$3I4  (.Z0(Z1), .A0(\$3N63 ), .A1(P1));
XOR2 \$3I72  (.Z0(Z0), .A0(CI), .A1(P0));
AND2 \$3I87  (.Z0(\$3N53 ), .A0(G5), .A1(P6));
AND3 \$3I88  (.Z0(\$3N50 ), .A0(G4), .A1(P5), .A2(P6));
AND4 \$3I89  (.Z0(\$3N51 ), .A0(G3), .A1(P4), .A2(P5), 
	.A3(P6));
AND5 \$3I90  (.Z0(\$3N48 ), .A0(G2), .A1(P3), .A2(P4), 
	.A3(P5), .A4(P6));
AND6 \$3I91  (.Z0(\$3N46 ), .A0(G1), .A1(P2), .A2(P3), 
	.A3(P4), .A4(P5), .A5(P6));
AND7 \$3I92  (.Z0(\$3N47 ), .A0(G0), .A1(P1), .A2(P2), 
	.A3(P3), .A4(P4), .A5(P5), .A6(P6));
AND8 \$3I93  (.Z0(\$3N49 ), .A0(CI), .A1(P0), .A2(P1), 
	.A3(P2), .A4(P3), .A5(P4), .A6(P5), 
	.A7(P6));
OR5 \$3I94  (.Z0(\$3N34 ), .A0(\$3N49 ), .A1(\$3N47 ), .A2(\$3N46 ), 
	.A3(\$3N48 ), .A4(\$3N51 ));
OR3 \$3I96  (.Z0(\$3N33 ), .A0(\$3N50 ), .A1(\$3N53 ), .A2(G6));
LXOR2 \$3I98  (.Z0(Z7), .A0(\$3N54 ), .A1(P7));
AND2 \$4I105  (.Z0(\$4N65 ), .A0(G2), .A1(P3));
AND3 \$4I106  (.Z0(\$4N64 ), .A0(G1), .A1(P2), .A2(P3));
AND4 \$4I107  (.Z0(\$4N67 ), .A0(G0), .A1(P1), .A2(P2), 
	.A3(P3));
AND5 \$4I108  (.Z0(\$4N68 ), .A0(CI), .A1(P0), .A2(P1), 
	.A3(P2), .A4(P3));
OR5 \$4I109  (.Z0(\$4N63 ), .A0(\$4N68 ), .A1(\$4N67 ), .A2(\$4N64 ), 
	.A3(\$4N65 ), .A4(G3));
LXOR2 \$4I117  (.Z0(Z3), .A0(\$4N115 ), .A1(P3));
AND2 \$4I136  (.Z0(\$4N140 ), .A0(G1), .A1(P2));
AND3 \$4I137  (.Z0(\$4N120 ), .A0(G0), .A1(P1), .A2(P2));
AND4 \$4I138  (.Z0(\$4N119 ), .A0(CI), .A1(P0), .A2(P1), 
	.A3(P2));
OR4 \$4I139  (.Z0(\$4N115 ), .A0(\$4N119 ), .A1(\$4N120 ), .A2(\$4N140 ), 
	.A3(G2));
OR2 \$4I32  (.Z0(\$4N99 ), .A0(\$4N34 ), .A1(\$4N33 ));
OR4 \$4I37  (.Z0(\$4N34 ), .A0(\$4N49 ), .A1(\$4N47 ), .A2(\$4N46 ), 
	.A3(\$4N48 ));
LXOR2 \$4I4  (.Z0(Z4), .A0(\$4N63 ), .A1(P4));
AND2 \$4I88  (.Z0(\$4N50 ), .A0(G4), .A1(P5));
AND3 \$4I91  (.Z0(\$4N51 ), .A0(G3), .A1(P4), .A2(P5));
AND4 \$4I92  (.Z0(\$4N48 ), .A0(G2), .A1(P3), .A2(P4), 
	.A3(P5));
AND5 \$4I93  (.Z0(\$4N46 ), .A0(G1), .A1(P2), .A2(P3), 
	.A3(P4), .A4(P5));
AND6 \$4I94  (.Z0(\$4N47 ), .A0(G0), .A1(P1), .A2(P2), 
	.A3(P3), .A4(P4), .A5(P5));
AND7 \$4I95  (.Z0(\$4N49 ), .A0(CI), .A1(P0), .A2(P1), 
	.A3(P2), .A4(P3), .A5(P4), .A6(P5));
OR3 \$4I96  (.Z0(\$4N33 ), .A0(\$4N51 ), .A1(\$4N50 ), .A2(G5));
LXOR2 \$4I98  (.Z0(Z6), .A0(\$4N99 ), .A1(P6));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:56:34 1994
`timescale 10 ps / 10 ps 
module ADDF8A(
	Z0, Z1, Z2, Z3, 
	Z4, Z5, Z6, Z7, 
	CO, A0, A1, A2, 
	A3, A4, A5, A6, 
	A7, B0, B1, B2, 
	B3, B4, B5, B6, 
	B7, CI);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	output CO;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input B0;
	input B1;
	input B2;
	input B3;
	input B4;
	input B5;
	input B6;
	input B7;
	input CI;

F3ADD \$1I428  (.Z0(Z0), .Z1(Z1), .Z2(Z2), .G012(G012), 
	.P012(P012), .A0(A0), .A1(A1), .A2(A2), 
	.B0(B0), .B1(B1), .B2(B2), .CI(CI));
PG1 \$1I430  (.PGO1(\$1N411 ), .GI1(G012), .PI1(P012), .PGI1(CI));
F3ADD \$1I431  (.Z0(Z3), .Z1(Z4), .Z2(Z5), .G012(G345), 
	.P012(P345), .A0(A3), .A1(A4), .A2(A5), 
	.B0(B3), .B1(B4), .B2(B5), .CI(\$1N411 ));
PG2 \$1I435  (.PGO2(\$1N421 ), .GI2(G345), .PI2(P345), .GI1(G012), 
	.PI1(P012), .PGI1(CI));
ADDF2 \$1I438  (.Z0(Z6), .Z1(Z7), .CO(CO), .A0(A6), 
	.A1(A7), .B0(B6), .B1(B7), .CI(\$1N421 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:56:37 1994
`timescale 10 ps / 10 ps 
module ADDH1(
	Z0, CO, A0, B0);

	output Z0;
	output CO;
	input A0;
	input B0;

AND2 \$1I12  (.Z0(\$1N22 ), .A0(\$1N46 ), .A1(B0));
AND2 \$1I13  (.Z0(\$1N26 ), .A0(\$1N42 ), .A1(A0));
AND2 \$1I14  (.Z0(CO), .A0(B0), .A1(A0));
OR2 \$1I25  (.Z0(Z0), .A0(\$1N22 ), .A1(\$1N26 ));
INV \$1I41  (.ZN0(\$1N42 ), .A0(B0));
INV \$1I45  (.ZN0(\$1N46 ), .A0(A0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:56:55 1994
`timescale 10 ps / 10 ps 
module ADDH16A(
	CO, Z0, Z1, Z10, 
	Z11, Z12, Z13, Z14, 
	Z15, Z2, Z3, Z4, 
	Z5, Z6, Z7, Z8, 
	Z9, A0, A1, A10, 
	A11, A12, A13, A14, 
	A15, A2, A3, A4, 
	A5, A6, A7, A8, 
	A9, B0, B1, B10, 
	B11, B12, B13, B14, 
	B15, B2, B3, B4, 
	B5, B6, B7, B8, 
	B9);

	output CO;
	output Z0;
	output Z1;
	output Z10;
	output Z11;
	output Z12;
	output Z13;
	output Z14;
	output Z15;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	output Z8;
	output Z9;
	input A0;
	input A1;
	input A10;
	input A11;
	input A12;
	input A13;
	input A14;
	input A15;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input A8;
	input A9;
	input B0;
	input B1;
	input B10;
	input B11;
	input B12;
	input B13;
	input B14;
	input B15;
	input B2;
	input B3;
	input B4;
	input B5;
	input B6;
	input B7;
	input B8;
	input B9;

F3ADD \$1I675  (.Z0(Z3), .Z1(Z4), .Z2(Z5), .G012(G345), 
	.P012(P345), .A0(A3), .A1(A4), .A2(A5), 
	.B0(B3), .B1(B4), .B2(B5), .CI(G012));
F3ADD \$1I677  (.Z0(Z9), .Z1(Z10), .Z2(Z11), .G012(G911), 
	.P012(P911), .A0(A9), .A1(A10), .A2(A11), 
	.B0(B9), .B1(B10), .B2(B11), .CI(\$1N510 ));
F3ADD \$1I679  (.Z0(Z12), .Z1(Z13), .Z2(Z14), .G012(G1214), 
	.P012(P1214), .A0(A12), .A1(A13), .A2(A14), 
	.B0(B12), .B1(B13), .B2(B14), .CI(\$1N515 ));
PG1 \$1I680  (.PGO1(\$1N445 ), .GI1(G345), .PI1(P345), .PGI1(G012));
F3ADD \$1I681  (.Z0(Z6), .Z1(Z7), .Z2(Z8), .G012(G678), 
	.P012(P678), .A0(A6), .A1(A7), .A2(A8), 
	.B0(B6), .B1(B7), .B2(B8), .CI(\$1N445 ));
PG2 \$1I682  (.PGO2(\$1N510 ), .GI2(G678), .PI2(P678), .GI1(G345), 
	.PI1(P345), .PGI1(G012));
PG3 \$1I683  (.PGO3(\$1N515 ), .GI3(G911), .PI3(P911), .GI2(G678), 
	.PI2(P678), .GI1(G345), .PI1(P345), .PGI1(G012));
PG4 \$1I684  (.PGO4(\$1N652 ), .GI4(G1214), .PI4(P1214), .GI3(G911), 
	.PI3(P911), .GI2(G678), .PI2(P678), .GI1(G345), 
	.PI1(P345), .PGI1(G012));
ADDH3 \$1I697  (.Z0(Z0), .Z1(Z1), .Z2(Z2), .CO(G012), 
	.A0(A0), .A1(A1), .A2(A2), .B0(B0), 
	.B1(B1), .B2(B2));
ADDF1 \$1I699  (.Z0(Z15), .CO(CO), .A0(A15), .B0(B15), 
	.CI(\$1N652 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:57:00 1994
`timescale 10 ps / 10 ps 
module ADDH2(
	Z0, Z1, CO, A0, 
	A1, B0, B1);

	output Z0;
	output Z1;
	output CO;
	input A0;
	input A1;
	input B0;
	input B1;

AND2 \$1I321  (.Z0(\$1N328 ), .A0(\~A0 ), .A1(B0));
AND2 \$1I322  (.Z0(\$1N327 ), .A0(A0), .A1(\~B0 ));
AND3 \$1I343  (.Z0(\$1N376 ), .A0(A1), .A1(A0), .A2(B0));
AND3 \$1I344  (.Z0(\$1N402 ), .A0(A0), .A1(B1), .A2(B0));
AND2 \$1I345  (.Z0(\$1N378 ), .A0(A1), .A1(B1));
OR3 \$1I401  (.Z0(CO), .A0(\$1N376 ), .A1(\$1N402 ), .A2(\$1N378 ));
OR2 \$1I517  (.Z0(Z0), .A0(\$1N328 ), .A1(\$1N327 ));
INV \$1I526  (.ZN0(\~B0 ), .A0(B0));
INV \$1I528  (.ZN0(\~B1 ), .A0(B1));
OR6 \$1I548  (.Z0(Z1), .A0(\$1N441 ), .A1(\$1N564 ), .A2(\$1N451 ), 
	.A3(\$1N577 ), .A4(\$1N579 ), .A5(\$1N581 ));
AND3 \$1I550  (.Z0(\$1N441 ), .A0(\~A1 ), .A1(B1), .A2(\~A0 ));
AND3 \$1I551  (.Z0(\$1N564 ), .A0(\~A1 ), .A1(B1), .A2(\~B0 ));
AND3 \$1I560  (.Z0(\$1N451 ), .A0(A1), .A1(\~B1 ), .A2(\~A0 ));
AND3 \$1I563  (.Z0(\$1N577 ), .A0(A1), .A1(\~B1 ), .A2(\~B0 ));
AND4 \$1I568  (.Z0(\$1N579 ), .A0(\~A1 ), .A1(\~B1 ), .A2(A0), 
	.A3(B0));
AND4 \$1I569  (.Z0(\$1N581 ), .A0(A1), .A1(B1), .A2(A0), 
	.A3(B0));
INV \$1I589  (.ZN0(\~A0 ), .A0(A0));
INV \$1I595  (.ZN0(\~A1 ), .A0(A1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:57:06 1994
`timescale 10 ps / 10 ps 
module ADDH3(
	Z0, Z1, Z2, CO, 
	A0, A1, A2, B0, 
	B1, B2);

	output Z0;
	output Z1;
	output Z2;
	output CO;
	input A0;
	input A1;
	input A2;
	input B0;
	input B1;
	input B2;

INV \$1I486  (.ZN0(\~B1 ), .A0(B1));
INV \$1I495  (.ZN0(\~A0 ), .A0(A0));
LXOR2 \$1I551  (.Z0(Z0), .A0(A0), .A1(B0));
LXOR2 \$1I581  (.Z0(Z1), .A0(A1), .A1(\$1N580 ));
AND3 \$1I582  (.Z0(\$1N576 ), .A0(A0), .A1(\~B1 ), .A2(B0));
AND4 \$1I601  (.Z0(\$1N639 ), .A0(A0), .A1(A1), .A2(A2), 
	.A3(B0));
AND3 \$1I606  (.Z0(\$1N637 ), .A0(A1), .A1(A2), .A2(B1));
AND4 \$1I610  (.Z0(\$1N635 ), .A0(A0), .A1(A2), .A2(B0), 
	.A3(B1));
AND2 \$1I615  (.Z0(\$1N633 ), .A0(A2), .A1(B2));
AND4 \$1I618  (.Z0(\$1N641 ), .A0(A0), .A1(A1), .A2(B0), 
	.A3(B2));
AND3 \$1I623  (.Z0(\$1N643 ), .A0(A1), .A1(B1), .A2(B2));
AND4 \$1I627  (.Z0(\$1N645 ), .A0(A0), .A1(B0), .A2(B1), 
	.A3(B2));
OR7 \$1I632  (.Z0(CO), .A0(\$1N639 ), .A1(\$1N637 ), .A2(\$1N635 ), 
	.A3(\$1N633 ), .A4(\$1N641 ), .A5(\$1N643 ), .A6(\$1N645 ));
INV \$1I668  (.ZN0(\~B0 ), .A0(B0));
INV \$1I672  (.ZN0(\~A1 ), .A0(A1));
AND2 \$1I677  (.Z0(\$1N575 ), .A0(\~A0 ), .A1(B1));
AND2 \$1I678  (.Z0(\$1N574 ), .A0(B1), .A1(\~B0 ));
OR3 \$1I681  (.Z0(\$1N580 ), .A0(\$1N575 ), .A1(\$1N574 ), .A2(\$1N576 ));
INV \$1I710  (.ZN0(\~B2 ), .A0(B2));
LXOR2 \$2I453  (.Z0(Z2), .A0(A2), .A1(\$2N694 ));
AND4 \$2I636  (.Z0(\$2N678 ), .A0(A0), .A1(B0), .A2(B1), 
	.A3(\~B2 ));
AND3 \$2I641  (.Z0(\$2N676 ), .A0(A1), .A1(B1), .A2(\~B2 ));
AND4 \$2I648  (.Z0(\$2N674 ), .A0(A0), .A1(A1), .A2(B0), 
	.A3(\~B2 ));
AND3 \$2I658  (.Z0(\$2N670 ), .A0(\~A1 ), .A1(\~B1 ), .A2(B2));
AND3 \$2I700  (.Z0(\$2N710 ), .A0(\~B0 ), .A1(\~B1 ), .A2(B2));
AND3 \$2I701  (.Z0(\$2N708 ), .A0(\~A0 ), .A1(\~B1 ), .A2(B2));
AND3 \$2I702  (.Z0(\$2N706 ), .A0(\~A1 ), .A1(\~B0 ), .A2(B2));
AND3 \$2I703  (.Z0(\$2N704 ), .A0(\~A0 ), .A1(\~A1 ), .A2(B2));
OR8 \$2I712  (.Z0(\$2N694 ), .A0(\$2N710 ), .A1(\$2N708 ), .A2(\$2N706 ), 
	.A3(\$2N704 ), .A4(\$2N678 ), .A5(\$2N676 ), .A6(\$2N674 ), 
	.A7(\$2N670 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:57:15 1994
`timescale 10 ps / 10 ps 
module ADDH4(
	Z0, Z1, Z2, Z3, 
	CO, A0, A1, A2, 
	A3, B0, B1, B2, 
	B3);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output CO;
	input A0;
	input A1;
	input A2;
	input A3;
	input B0;
	input B1;
	input B2;
	input B3;

ADDH2 \$1I1  (.Z0(Z0), .Z1(Z1), .CO(\$1N4 ), .A0(A0), 
	.A1(A1), .B0(B0), .B1(B1));
ADDF2 \$1I2  (.Z0(Z2), .Z1(Z3), .CO(CO), .A0(A2), 
	.A1(A3), .B0(B2), .B1(B3), .CI(\$1N4 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:57:22 1994
`timescale 10 ps / 10 ps 
module ADDH8(
	Z0, Z1, Z2, Z3, 
	Z4, Z5, Z6, Z7, 
	CO, A0, A1, A2, 
	A3, A4, A5, A6, 
	A7, B0, B1, B2, 
	B3, B4, B5, B6, 
	B7);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	output CO;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input B0;
	input B1;
	input B2;
	input B3;
	input B4;
	input B5;
	input B6;
	input B7;

XOR2 \$1I164  (.Z0(P7), .A0(A7), .A1(B7));
XOR2 \$1I165  (.Z0(P6), .A0(A6), .A1(B6));
XOR2 \$1I166  (.Z0(P5), .A0(A5), .A1(B5));
XOR2 \$1I167  (.Z0(P4), .A0(A4), .A1(B4));
XOR2 \$1I168  (.Z0(P3), .A0(A3), .A1(B3));
XOR2 \$1I169  (.Z0(P2), .A0(A2), .A1(B2));
XOR2 \$1I170  (.Z0(P1), .A0(A1), .A1(B1));
XOR2 \$1I171  (.Z0(Z0), .A0(A0), .A1(B0));
AND2 \$1I172  (.Z0(G7), .A0(A7), .A1(B7));
AND2 \$1I173  (.Z0(G6), .A0(A6), .A1(B6));
AND2 \$1I174  (.Z0(G5), .A0(A5), .A1(B5));
AND2 \$1I175  (.Z0(G4), .A0(A4), .A1(B4));
AND2 \$1I176  (.Z0(G3), .A0(A3), .A1(B3));
AND2 \$1I177  (.Z0(G2), .A0(A2), .A1(B2));
AND2 \$1I178  (.Z0(G1), .A0(A1), .A1(B1));
AND2 \$1I179  (.Z0(\$1N291 ), .A0(A0), .A1(B0));
LXOR2 \$1I304  (.Z0(Z1), .A0(P1), .A1(\$1N291 ));
AND9 \$2I1  (.Z0(\$2N67 ), .A0(A0), .A1(B0), .A2(P1), 
	.A3(P2), .A4(P3), .A5(P4), .A6(P5), 
	.A7(P6), .A8(P7));
OR5 \$2I114  (.Z0(\$2N128 ), .A0(\$2N117 ), .A1(\$2N115 ), .A2(\$2N121 ), 
	.A3(\$2N123 ), .A4(G4));
LXOR2 \$2I126  (.Z0(Z5), .A0(\$2N128 ), .A1(P5));
AND7 \$2I13  (.Z0(\$2N65 ), .A0(G1), .A1(P2), .A2(P3), 
	.A3(P4), .A4(P5), .A5(P6), .A6(P7));
OR4 \$2I14  (.Z0(\$2N82 ), .A0(\$2N73 ), .A1(\$2N79 ), .A2(\$2N77 ), 
	.A3(G7));
AND3 \$2I144  (.Z0(\$2N162 ), .A0(A0), .A1(B0), .A2(P1));
OR2 \$2I146  (.Z0(\$2N153 ), .A0(\$2N162 ), .A1(G1));
LXOR2 \$2I152  (.Z0(Z2), .A0(\$2N153 ), .A1(P2));
OR4 \$2I159  (.Z0(\$2N84 ), .A0(\$2N67 ), .A1(\$2N65 ), .A2(\$2N69 ), 
	.A3(\$2N75 ));
OR3 \$2I168  (.Z0(\$2N172 ), .A0(\$2N179 ), .A1(\$2N166 ), .A2(G2));
AND2 \$2I169  (.Z0(\$2N166 ), .A0(G1), .A1(P2));
LXOR2 \$2I170  (.Z0(Z3), .A0(\$2N172 ), .A1(P3));
AND4 \$2I178  (.Z0(\$2N179 ), .A0(A0), .A1(B0), .A2(P1), 
	.A3(P2));
AND6 \$2I2  (.Z0(\$2N69 ), .A0(G2), .A1(P3), .A2(P4), 
	.A3(P5), .A4(P6), .A5(P7));
AND5 \$2I3  (.Z0(\$2N75 ), .A0(G3), .A1(P4), .A2(P5), 
	.A3(P6), .A4(P7));
AND2 \$2I4  (.Z0(\$2N77 ), .A0(G6), .A1(P7));
AND3 \$2I5  (.Z0(\$2N79 ), .A0(G5), .A1(P6), .A2(P7));
AND4 \$2I6  (.Z0(\$2N73 ), .A0(G4), .A1(P5), .A2(P6), 
	.A3(P7));
OR2 \$2I81  (.Z0(CO), .A0(\$2N84 ), .A1(\$2N82 ));
AND6 \$2I90  (.Z0(\$2N117 ), .A0(A0), .A1(B0), .A2(P1), 
	.A3(P2), .A4(P3), .A5(P4));
AND4 \$2I91  (.Z0(\$2N115 ), .A0(G1), .A1(P2), .A2(P3), 
	.A3(P4));
AND3 \$2I92  (.Z0(\$2N121 ), .A0(G2), .A1(P3), .A2(P4));
AND2 \$2I93  (.Z0(\$2N123 ), .A0(G3), .A1(P4));
AND3 \$3I113  (.Z0(\$3N117 ), .A0(G3), .A1(P4), .A2(P5));
AND4 \$3I114  (.Z0(\$3N120 ), .A0(G2), .A1(P3), .A2(P4), 
	.A3(P5));
AND5 \$3I115  (.Z0(\$3N111 ), .A0(G1), .A1(P2), .A2(P3), 
	.A3(P4), .A4(P5));
AND2 \$3I116  (.Z0(\$3N112 ), .A0(G4), .A1(P5));
OR3 \$3I118  (.Z0(\$3N121 ), .A0(\$3N117 ), .A1(\$3N112 ), .A2(G5));
OR3 \$3I119  (.Z0(\$3N122 ), .A0(\$3N137 ), .A1(\$3N111 ), .A2(\$3N120 ));
OR2 \$3I123  (.Z0(\$3N110 ), .A0(\$3N122 ), .A1(\$3N121 ));
LXOR2 \$3I124  (.Z0(Z6), .A0(\$3N110 ), .A1(P6));
AND7 \$3I138  (.Z0(\$3N137 ), .A0(A0), .A1(B0), .A2(P1), 
	.A3(P2), .A4(P3), .A5(P4), .A6(P5));
AND5 \$3I142  (.Z0(\$3N159 ), .A0(A0), .A1(B0), .A2(P1), 
	.A3(P2), .A4(P3));
AND3 \$3I145  (.Z0(\$3N143 ), .A0(G1), .A1(P2), .A2(P3));
AND2 \$3I147  (.Z0(\$3N146 ), .A0(G2), .A1(P3));
OR4 \$3I148  (.Z0(\$3N151 ), .A0(\$3N159 ), .A1(\$3N143 ), .A2(\$3N146 ), 
	.A3(G3));
LXOR2 \$3I149  (.Z0(Z4), .A0(\$3N151 ), .A1(P4));
OR2 \$3I32  (.Z0(\$3N54 ), .A0(\$3N34 ), .A1(\$3N33 ));
AND2 \$3I87  (.Z0(\$3N53 ), .A0(G5), .A1(P6));
AND3 \$3I88  (.Z0(\$3N50 ), .A0(G4), .A1(P5), .A2(P6));
AND4 \$3I89  (.Z0(\$3N51 ), .A0(G3), .A1(P4), .A2(P5), 
	.A3(P6));
AND5 \$3I90  (.Z0(\$3N48 ), .A0(G2), .A1(P3), .A2(P4), 
	.A3(P5), .A4(P6));
AND6 \$3I91  (.Z0(\$3N46 ), .A0(G1), .A1(P2), .A2(P3), 
	.A3(P4), .A4(P5), .A5(P6));
AND8 \$3I92  (.Z0(\$3N47 ), .A0(A0), .A1(B0), .A2(P1), 
	.A3(P2), .A4(P3), .A5(P4), .A6(P5), 
	.A7(P6));
OR4 \$3I94  (.Z0(\$3N34 ), .A0(\$3N47 ), .A1(\$3N46 ), .A2(\$3N48 ), 
	.A3(\$3N51 ));
OR3 \$3I96  (.Z0(\$3N33 ), .A0(\$3N50 ), .A1(\$3N53 ), .A2(G6));
LXOR2 \$3I98  (.Z0(Z7), .A0(\$3N54 ), .A1(P7));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:57:33 1994
`timescale 10 ps / 10 ps 
module ADDH8A(
	CO, Z7, Z6, Z5, 
	Z4, Z3, Z2, Z1, 
	Z0, B7, B6, B5, 
	B4, B3, B2, B1, 
	B0, A7, A6, A5, 
	A4, A3, A2, A1, 
	A0);

	output CO;
	output Z7;
	output Z6;
	output Z5;
	output Z4;
	output Z3;
	output Z2;
	output Z1;
	output Z0;
	input B7;
	input B6;
	input B5;
	input B4;
	input B3;
	input B2;
	input B1;
	input B0;
	input A7;
	input A6;
	input A5;
	input A4;
	input A3;
	input A2;
	input A1;
	input A0;

F3ADD \$1I429  (.Z0(Z3), .Z1(Z4), .Z2(Z5), .G012(G345), 
	.P012(P345), .A0(A3), .A1(A4), .A2(A5), 
	.B0(B3), .B1(B4), .B2(B5), .CI(G012));
PG1 \$1I431  (.PGO1(\$1N421 ), .GI1(G345), .PI1(P345), .PGI1(G012));
ADDH3 \$1I432  (.Z0(Z0), .Z1(Z1), .Z2(Z2), .CO(G012), 
	.A0(A0), .A1(A1), .A2(A2), .B0(B0), 
	.B1(B1), .B2(B2));
ADDF2 \$1I435  (.Z0(Z6), .Z1(Z7), .CO(CO), .A0(A6), 
	.A1(A7), .B0(B6), .B1(B7), .CI(\$1N421 ));
endmodule
/*
* Translated from EDIF description AND10                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 34  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  AND10 lib :  AND10                          *
*/
/*
* Library AND10                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell AND10"                                                                *
*/
`timescale 10 ps / 10 ps
module AND10 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;

    output  Z0;



    and
        \$1I1  (\$1N37 , A0, A1, A2, A3, A4, A5, A6, A7);
    and
        \$1I36  (Z0, \$1N37 , A8, A9);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description AND11                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 34  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  AND11 lib :  AND11                          *
*/
/*
* Library AND11                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell AND11"                                                                *
*/
`timescale 10 ps / 10 ps
module AND11 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;

    output  Z0;



    and
        \$1I1  (\$1N37 , A0, A1, A2, A3, A4, A5, A6, A7);
    and
        \$1I36  (Z0, \$1N37 , A8, A9, A10);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description AND12                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 34  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  AND12 lib :  AND12                          *
*/
/*
* Library AND12                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell AND12"                                                                *
*/
`timescale 10 ps / 10 ps
module AND12 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;

    output  Z0;



    and
        \$1I1  (\$1N39 , A0, A1, A2, A3, A4, A5, A6, A7);
    and
        \$1I35  (Z0, \$1N39 , A8, A9, A10, A11);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description AND13                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 34  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  AND13 lib :  AND13                          *
*/
/*
* Library AND13                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell AND13"                                                                *
*/
`timescale 10 ps / 10 ps
module AND13 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;

    output  Z0;



    and
        \$1I1  (\$1N39 , A0, A1, A2, A3, A4, A5, A6, A7);
    and
        \$1I35  (Z0, \$1N39 , A8, A9, A10, A11, A12);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description AND14                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 34  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  AND14 lib :  AND14                          *
*/
/*
* Library AND14                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell AND14"                                                                *
*/
`timescale 10 ps / 10 ps
module AND14 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;

    output  Z0;



    and
        \$1I1  (\$1N39 , A0, A1, A2, A3, A4, A5, A6, A7);
    and
        \$1I35  (Z0, \$1N39 , A8, A9, A10, A11, A12, A13);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description AND15                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 34  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  AND15 lib :  AND15                          *
*/
/*
* Library AND15                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell AND15"                                                                *
*/
`timescale 10 ps / 10 ps
module AND15 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;

    output  Z0;



    and
        \$1I1  (\$1N39 , A0, A1, A2, A3, A4, A5, A6, A7);
    and
        \$1I35  (Z0, \$1N39 , A8, A9, A10, A11, A12, A13, A14);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description AND16                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 34  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  AND16 lib :  AND16                          *
*/
/*
* Library AND16                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell AND16"                                                                *
*/
`timescale 10 ps / 10 ps
module AND16 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15)
      ;

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;

    output  Z0;



    and
        \$1I1  (\$1N36 , A0, A1, A2, A3, A4, A5, A6, A7);
    and
        \$1I35  (Z0, \$1N36 , \$1N49 );
    and
        \$1I40  (\$1N49 , A8, A9, A10, A11, A12, A13, A14, A15);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description AND17                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 35  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  AND17 lib :  AND17                          *
*/
/*
* Library AND17                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell AND17"                                                                *
*/
`timescale 10 ps / 10 ps
module AND17 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, 
      A15, A16);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;

    output  Z0;



    and
        \$1I1  (\$1N36 , A0, A1, A2, A3, A4, A5, A6, A7);
    and
        \$1I35  (Z0, \$1N36 , A8, \$1N49 );
    and
        \$1I40  (\$1N49 , A9, A10, A11, A12, A13, A14, A15, A16);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description AND18                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 35  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  AND18 lib :  AND18                          *
*/
/*
* Library AND18                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell AND18"                                                                *
*/
`timescale 10 ps / 10 ps
module AND18 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, 
      A15, A16, A17);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;

    output  Z0;



    and
        \$1I1  (\$1N36 , A0, A1, A2, A3, A4, A5, A6, A7);
    and
        \$1I35  (Z0, \$1N36 , A8, A9, \$1N49 );
    and
        \$1I40  (\$1N49 , A10, A11, A12, A13, A14, A15, A16, A17);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description AND2                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 35  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  AND2 lib :  AND2                            *
*/
/*
* Library AND2                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell AND2"                                                                 *
*/

`timescale 10 ps / 10 ps 

module AND2 (Z0, A0, A1);

    input  A0;
    input  A1;

    output  Z0;



    and
        \$1I1  (Z0, A0, A1);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description AND3                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 35  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  AND3 lib :  AND3                            *
*/
/*
* Library AND3                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell AND3"                                                                 *
*/

`timescale 10 ps / 10 ps
module AND3 (Z0, A0, A1, A2);

    input  A0;
    input  A1;
    input  A2;

    output  Z0;



    and
        \$1I1  (Z0, A0, A1, A2);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description AND4                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 35  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  AND4 lib :  AND4                            *
*/
/*
* Library AND4                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell AND4"                                                                 *
*/

`timescale 10 ps / 10 ps
module AND4 (Z0, A0, A1, A2, A3);

    input  A0;
    input  A1;
    input  A2;
    input  A3;

    output  Z0;



    and
        \$1I1  (Z0, A0, A1, A2, A3);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description AND5                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 35  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  AND5 lib :  AND5                            *
*/
/*
* Library AND5                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell AND5"                                                                 *
*/

`timescale 10 ps / 10 ps
module AND5 (Z0, A0, A1, A2, A3, A4);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;

    output  Z0;



    and
        \$1I1  (Z0, A0, A1, A2, A3, A4);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description AND6                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 35  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  AND6 lib :  AND6                            *
*/
/*
* Library AND6                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell AND6"                                                                 *
*/

`timescale 10 ps / 10 ps
module AND6 (Z0, A0, A1, A2, A3, A4, A5);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;

    output  Z0;



    and
        \$1I1  (Z0, A0, A1, A2, A3, A4, A5);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description AND7                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 35  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  AND7 lib :  AND7                            *
*/
/*
* Library AND7                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell AND7"                                                                 *
*/

`timescale 10 ps / 10 ps
module AND7 (Z0, A0, A1, A2, A3, A4, A5, A6);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;

    output  Z0;



    and
        \$1I1  (Z0, A0, A1, A2, A3, A4, A5, A6);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description AND8                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 35  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  AND8 lib :  AND8                            *
*/
/*
* Library AND8                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell AND8"                                                                 *
*/

`timescale 10 ps / 10 ps
module AND8 (Z0, A0, A1, A2, A3, A4, A5, A6, A7);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;

    output  Z0;



    and
        \$1I1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description AND9                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 35  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  AND9 lib :  AND9                            *
*/
/*
* Library AND9                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell AND9"                                                                 *
*/
`timescale 10 ps / 10 ps
module AND9 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;

    output  Z0;



    and
        \$1I1  (\$1N36 , A0, A1, A2, A3, A4, A5, A6, A7);
    and
        \$1I35  (Z0, \$1N36 , A8);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:11 1994
`timescale 10 ps / 10 ps 
module BI11(
	Z0, XB0, A0, OE);

	output Z0;
	inout XB0;
	input A0;
	input OE;

XBIDI1 \$1I1  (.Z0(Z0), .XB0(XB0), .A0(A0), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:14 1994
`timescale 10 ps / 10 ps 
module BI14(
	Z0, Z1, Z2, Z3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	OE);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input OE;

BI11 \$1I15  (.Z0(Z3), .XB0(XB3), .A0(A3), .OE(OE));
BI11 \$1I24  (.Z0(Z2), .XB0(XB2), .A0(A2), .OE(OE));
BI11 \$1I33  (.Z0(Z1), .XB0(XB1), .A0(A1), .OE(OE));
BI11 \$1I42  (.Z0(Z0), .XB0(XB0), .A0(A0), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:17 1994
`timescale 10 ps / 10 ps 
module BI18(
	Z0, Z1, Z2, Z3, 
	Z4, Z5, Z6, Z7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	OE);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input OE;

BI11 \$1I15  (.Z0(Z3), .XB0(XB3), .A0(A3), .OE(OE));
BI11 \$1I24  (.Z0(Z2), .XB0(XB2), .A0(A2), .OE(OE));
BI11 \$1I33  (.Z0(Z1), .XB0(XB1), .A0(A1), .OE(OE));
BI11 \$1I42  (.Z0(Z0), .XB0(XB0), .A0(A0), .OE(OE));
BI11 \$1I49  (.Z0(Z4), .XB0(XB4), .A0(A4), .OE(OE));
BI11 \$1I56  (.Z0(Z5), .XB0(XB5), .A0(A5), .OE(OE));
BI11 \$1I63  (.Z0(Z6), .XB0(XB6), .A0(A6), .OE(OE));
BI11 \$1I64  (.Z0(Z7), .XB0(XB7), .A0(A7), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:18 1994
`timescale 10 ps / 10 ps 
module BI21(
	Z0, XB0, A0, OE);

	output Z0;
	inout XB0;
	input A0;
	input OE;

XBIDI1 \$1I1  (.Z0(Z0), .XB0(XB0), .A0(\$1N4 ), .OE(OE));
XINV \$1I8  (.ZN0(\$1N4 ), .A0(A0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:21 1994
`timescale 10 ps / 10 ps 
module BI24(
	Z0, Z1, Z2, Z3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	OE);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input OE;

BI21 \$1I15  (.Z0(Z3), .XB0(XB3), .A0(A3), .OE(OE));
BI21 \$1I24  (.Z0(Z2), .XB0(XB2), .A0(A2), .OE(OE));
BI21 \$1I33  (.Z0(Z1), .XB0(XB1), .A0(A1), .OE(OE));
BI21 \$1I42  (.Z0(Z0), .XB0(XB0), .A0(A0), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:24 1994
`timescale 10 ps / 10 ps 
module BI28(
	Z0, Z1, Z2, Z3, 
	Z4, Z5, Z6, Z7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	OE);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input OE;

BI21 \$1I15  (.Z0(Z3), .XB0(XB3), .A0(A3), .OE(OE));
BI21 \$1I24  (.Z0(Z2), .XB0(XB2), .A0(A2), .OE(OE));
BI21 \$1I33  (.Z0(Z1), .XB0(XB1), .A0(A1), .OE(OE));
BI21 \$1I42  (.Z0(Z0), .XB0(XB0), .A0(A0), .OE(OE));
BI21 \$1I49  (.Z0(Z4), .XB0(XB4), .A0(A4), .OE(OE));
BI21 \$1I56  (.Z0(Z5), .XB0(XB5), .A0(A5), .OE(OE));
BI21 \$1I63  (.Z0(Z6), .XB0(XB6), .A0(A6), .OE(OE));
BI21 \$1I64  (.Z0(Z7), .XB0(XB7), .A0(A7), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:26 1994
`timescale 10 ps / 10 ps 
module BI31(
	Z0, XB0, A0, OE);

	output Z0;
	inout XB0;
	input A0;
	input OE;

XBIDI1 \$1I1  (.Z0(Z0), .XB0(XB0), .A0(A0), .OE(\$1N3 ));
XINV \$1I8  (.ZN0(\$1N3 ), .A0(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:29 1994
`timescale 10 ps / 10 ps 
module BI34(
	Z0, Z1, Z2, Z3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	OE);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input OE;

BI31 \$1I15  (.Z0(Z3), .XB0(XB3), .A0(A3), .OE(OE));
BI31 \$1I24  (.Z0(Z2), .XB0(XB2), .A0(A2), .OE(OE));
BI31 \$1I33  (.Z0(Z1), .XB0(XB1), .A0(A1), .OE(OE));
BI31 \$1I42  (.Z0(Z0), .XB0(XB0), .A0(A0), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:32 1994
`timescale 10 ps / 10 ps 
module BI38(
	Z0, Z1, Z2, Z3, 
	Z4, Z5, Z6, Z7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	OE);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input OE;

BI31 \$1I15  (.Z0(Z3), .XB0(XB3), .A0(A3), .OE(OE));
BI31 \$1I24  (.Z0(Z2), .XB0(XB2), .A0(A2), .OE(OE));
BI31 \$1I33  (.Z0(Z1), .XB0(XB1), .A0(A1), .OE(OE));
BI31 \$1I42  (.Z0(Z0), .XB0(XB0), .A0(A0), .OE(OE));
BI31 \$1I49  (.Z0(Z4), .XB0(XB4), .A0(A4), .OE(OE));
BI31 \$1I56  (.Z0(Z5), .XB0(XB5), .A0(A5), .OE(OE));
BI31 \$1I63  (.Z0(Z6), .XB0(XB6), .A0(A6), .OE(OE));
BI31 \$1I64  (.Z0(Z7), .XB0(XB7), .A0(A7), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:33 1994
`timescale 10 ps / 10 ps 
module BI41(
	Z0, XB0, A0, OE);

	output Z0;
	inout XB0;
	input A0;
	input OE;

XBIDI1 \$1I1  (.Z0(Z0), .XB0(XB0), .A0(\$1N4 ), .OE(\$1N3 ));
XINV \$1I10  (.ZN0(\$1N3 ), .A0(OE));
XINV \$1I8  (.ZN0(\$1N4 ), .A0(A0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:36 1994
`timescale 10 ps / 10 ps 
module BI44(
	Z0, Z1, Z2, Z3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	OE);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input OE;

BI41 \$1I15  (.Z0(Z3), .XB0(XB3), .A0(A3), .OE(OE));
BI41 \$1I24  (.Z0(Z2), .XB0(XB2), .A0(A2), .OE(OE));
BI41 \$1I33  (.Z0(Z1), .XB0(XB1), .A0(A1), .OE(OE));
BI41 \$1I42  (.Z0(Z0), .XB0(XB0), .A0(A0), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:39 1994
`timescale 10 ps / 10 ps 
module BI48(
	Z0, Z1, Z2, Z3, 
	Z4, Z5, Z6, Z7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	OE);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input OE;

BI41 \$1I15  (.Z0(Z3), .XB0(XB3), .A0(A3), .OE(OE));
BI41 \$1I24  (.Z0(Z2), .XB0(XB2), .A0(A2), .OE(OE));
BI41 \$1I33  (.Z0(Z1), .XB0(XB1), .A0(A1), .OE(OE));
BI41 \$1I42  (.Z0(Z0), .XB0(XB0), .A0(A0), .OE(OE));
BI41 \$1I49  (.Z0(Z4), .XB0(XB4), .A0(A4), .OE(OE));
BI41 \$1I56  (.Z0(Z5), .XB0(XB5), .A0(A5), .OE(OE));
BI41 \$1I63  (.Z0(Z6), .XB0(XB6), .A0(A6), .OE(OE));
BI41 \$1I64  (.Z0(Z7), .XB0(XB7), .A0(A7), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:41 1994
`timescale 10 ps / 10 ps 
module BIID11(
	Q0, XB0, A0, CLK, 
	OE);

	output Q0;
	inout XB0;
	input A0;
	input CLK;
	input OE;

XDFF1 \$1I1  (.Q0(Q0), .D0(\$1N7 ), .CLK(CLK));
XBIDI1 \$1I2  (.Z0(\$1N7 ), .XB0(XB0), .A0(A0), .OE(OE));
endmodule
`timescale 10 ps / 10 ps
module BIID11E(
	A0, CLK, EN, OE, Q0, XB0);


	input A0;
	input CLK;
	input EN;
	input OE;
	output Q0;
	inout XB0;



XBIDI1 \$1I2  (.Z0 (\$1N7 ), .XB0 (XB0), .A0 (A0), 
	.OE (OE));
XDFF1E \$1I20  (.Q0 (Q0), .D0 (\$1N7 ), .CLK (CLK), 
	.EN (EN));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:45 1994
`timescale 10 ps / 10 ps 
module BIID14(
	Q0, Q1, Q2, Q3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	CLK, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input CLK;
	input OE;

BIID11 \$1I20  (.Q0(Q3), .XB0(XB3), .A0(A3), .CLK(CLK), 
	.OE(OE));
BIID11 \$1I28  (.Q0(Q2), .XB0(XB2), .A0(A2), .CLK(CLK), 
	.OE(OE));
BIID11 \$1I39  (.Q0(Q1), .XB0(XB1), .A0(A1), .CLK(CLK), 
	.OE(OE));
BIID11 \$1I50  (.Q0(Q0), .XB0(XB0), .A0(A0), .CLK(CLK), 
	.OE(OE));
endmodule
`timescale 10 ps / 10 ps
module BIID14E(
	A0, A1, A2, A3, CLK, EN, OE, Q0, Q1, Q2, Q3, XB0, XB1, XB2, XB3);


	input A0;
	input A1;
	input A2;
	input A3;
	input CLK;
	input EN;
	input OE;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;



BIID11E \$1I60  (.Q0 (Q3), .XB0 (XB3), .A0 (A3), 
	.CLK (CLK), .EN (EN), .OE (OE));
BIID11E \$1I59  (.Q0 (Q2), .XB0 (XB2), .A0 (A2), 
	.CLK (CLK), .EN (EN), .OE (OE));
BIID11E \$1I58  (.Q0 (Q1), .XB0 (XB1), .A0 (A1), 
	.CLK (CLK), .EN (EN), .OE (OE));
BIID11E \$1I57  (.Q0 (Q0), .XB0 (XB0), .A0 (A0), 
	.CLK (CLK), .EN (EN), .OE (OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:49 1994
`timescale 10 ps / 10 ps 
module BIID18(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	CLK, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input CLK;
	input OE;

BIID11 \$1I20  (.Q0(Q7), .XB0(XB7), .A0(A7), .CLK(CLK), 
	.OE(OE));
BIID11 \$1I28  (.Q0(Q6), .XB0(XB6), .A0(A6), .CLK(CLK), 
	.OE(OE));
BIID11 \$1I39  (.Q0(Q5), .XB0(XB5), .A0(A5), .CLK(CLK), 
	.OE(OE));
BIID11 \$1I50  (.Q0(Q4), .XB0(XB4), .A0(A4), .CLK(CLK), 
	.OE(OE));
BIID11 \$1I62  (.Q0(Q0), .XB0(XB0), .A0(A0), .CLK(CLK), 
	.OE(OE));
BIID11 \$1I70  (.Q0(Q1), .XB0(XB1), .A0(A1), .CLK(CLK), 
	.OE(OE));
BIID11 \$1I81  (.Q0(Q3), .XB0(XB3), .A0(A3), .CLK(CLK), 
	.OE(OE));
BIID11 \$1I86  (.Q0(Q2), .XB0(XB2), .A0(A2), .CLK(CLK), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:51 1994
`timescale 10 ps / 10 ps 
module BIID21(
	Q0, XB0, A0, CLK, 
	OE);

	output Q0;
	inout XB0;
	input A0;
	input CLK;
	input OE;

XDFF1 \$1I1  (.Q0(Q0), .D0(\$1N7 ), .CLK(CLK));
XINV \$1I16  (.ZN0(\$1N10 ), .A0(A0));
XBIDI1 \$1I2  (.Z0(\$1N7 ), .XB0(XB0), .A0(\$1N10 ), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:55 1994
`timescale 10 ps / 10 ps 
module BIID24(
	Q0, Q1, Q2, Q3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	CLK, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input CLK;
	input OE;

BIID21 \$1I20  (.Q0(Q3), .XB0(XB3), .A0(A3), .CLK(CLK), 
	.OE(OE));
BIID21 \$1I28  (.Q0(Q2), .XB0(XB2), .A0(A2), .CLK(CLK), 
	.OE(OE));
BIID21 \$1I39  (.Q0(Q1), .XB0(XB1), .A0(A1), .CLK(CLK), 
	.OE(OE));
BIID21 \$1I50  (.Q0(Q0), .XB0(XB0), .A0(A0), .CLK(CLK), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:58:59 1994
`timescale 10 ps / 10 ps 
module BIID28(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	CLK, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input CLK;
	input OE;

BIID21 \$1I20  (.Q0(Q7), .XB0(XB7), .A0(A7), .CLK(CLK), 
	.OE(OE));
BIID21 \$1I28  (.Q0(Q6), .XB0(XB6), .A0(A6), .CLK(CLK), 
	.OE(OE));
BIID21 \$1I39  (.Q0(Q5), .XB0(XB5), .A0(A5), .CLK(CLK), 
	.OE(OE));
BIID21 \$1I50  (.Q0(Q4), .XB0(XB4), .A0(A4), .CLK(CLK), 
	.OE(OE));
BIID21 \$1I62  (.Q0(Q0), .XB0(XB0), .A0(A0), .CLK(CLK), 
	.OE(OE));
BIID21 \$1I70  (.Q0(Q1), .XB0(XB1), .A0(A1), .CLK(CLK), 
	.OE(OE));
BIID21 \$1I81  (.Q0(Q3), .XB0(XB3), .A0(A3), .CLK(CLK), 
	.OE(OE));
BIID21 \$1I86  (.Q0(Q2), .XB0(XB2), .A0(A2), .CLK(CLK), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:01 1994
`timescale 10 ps / 10 ps 
module BIID31(
	Q0, XB0, A0, CLK, 
	OE);

	output Q0;
	inout XB0;
	input A0;
	input CLK;
	input OE;

XDFF1 \$1I1  (.Q0(Q0), .D0(\$1N7 ), .CLK(CLK));
XINV \$1I16  (.ZN0(\$1N9 ), .A0(OE));
XBIDI1 \$1I2  (.Z0(\$1N7 ), .XB0(XB0), .A0(A0), .OE(\$1N9 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:04 1994
`timescale 10 ps / 10 ps 
module BIID34(
	Q0, Q1, Q2, Q3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	CLK, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input CLK;
	input OE;

BIID31 \$1I20  (.Q0(Q3), .XB0(XB3), .A0(A3), .CLK(CLK), 
	.OE(OE));
BIID31 \$1I28  (.Q0(Q2), .XB0(XB2), .A0(A2), .CLK(CLK), 
	.OE(OE));
BIID31 \$1I39  (.Q0(Q1), .XB0(XB1), .A0(A1), .CLK(CLK), 
	.OE(OE));
BIID31 \$1I50  (.Q0(Q0), .XB0(XB0), .A0(A0), .CLK(CLK), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:07 1994
`timescale 10 ps / 10 ps 
module BIID38(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	CLK, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input CLK;
	input OE;

BIID31 \$1I20  (.Q0(Q7), .XB0(XB7), .A0(A7), .CLK(CLK), 
	.OE(OE));
BIID31 \$1I28  (.Q0(Q6), .XB0(XB6), .A0(A6), .CLK(CLK), 
	.OE(OE));
BIID31 \$1I39  (.Q0(Q5), .XB0(XB5), .A0(A5), .CLK(CLK), 
	.OE(OE));
BIID31 \$1I50  (.Q0(Q4), .XB0(XB4), .A0(A4), .CLK(CLK), 
	.OE(OE));
BIID31 \$1I62  (.Q0(Q0), .XB0(XB0), .A0(A0), .CLK(CLK), 
	.OE(OE));
BIID31 \$1I70  (.Q0(Q1), .XB0(XB1), .A0(A1), .CLK(CLK), 
	.OE(OE));
BIID31 \$1I81  (.Q0(Q3), .XB0(XB3), .A0(A3), .CLK(CLK), 
	.OE(OE));
BIID31 \$1I86  (.Q0(Q2), .XB0(XB2), .A0(A2), .CLK(CLK), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:09 1994
`timescale 10 ps / 10 ps 
module BIID41(
	Q0, XB0, A0, CLK, 
	OE);

	output Q0;
	inout XB0;
	input A0;
	input CLK;
	input OE;

XDFF1 \$1I1  (.Q0(Q0), .D0(\$1N7 ), .CLK(CLK));
XINV \$1I16  (.ZN0(\$1N10 ), .A0(A0));
XINV \$1I18  (.ZN0(\$1N9 ), .A0(OE));
XBIDI1 \$1I2  (.Z0(\$1N7 ), .XB0(XB0), .A0(\$1N10 ), .OE(\$1N9 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:12 1994
`timescale 10 ps / 10 ps 
module BIID44(
	Q0, Q1, Q2, Q3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	CLK, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input CLK;
	input OE;

BIID41 \$1I20  (.Q0(Q3), .XB0(XB3), .A0(A3), .CLK(CLK), 
	.OE(OE));
BIID41 \$1I28  (.Q0(Q2), .XB0(XB2), .A0(A2), .CLK(CLK), 
	.OE(OE));
BIID41 \$1I39  (.Q0(Q1), .XB0(XB1), .A0(A1), .CLK(CLK), 
	.OE(OE));
BIID41 \$1I50  (.Q0(Q0), .XB0(XB0), .A0(A0), .CLK(CLK), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:15 1994
`timescale 10 ps / 10 ps 
module BIID48(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	CLK, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input CLK;
	input OE;

BIID41 \$1I20  (.Q0(Q7), .XB0(XB7), .A0(A7), .CLK(CLK), 
	.OE(OE));
BIID41 \$1I28  (.Q0(Q6), .XB0(XB6), .A0(A6), .CLK(CLK), 
	.OE(OE));
BIID41 \$1I39  (.Q0(Q5), .XB0(XB5), .A0(A5), .CLK(CLK), 
	.OE(OE));
BIID41 \$1I50  (.Q0(Q4), .XB0(XB4), .A0(A4), .CLK(CLK), 
	.OE(OE));
BIID41 \$1I62  (.Q0(Q0), .XB0(XB0), .A0(A0), .CLK(CLK), 
	.OE(OE));
BIID41 \$1I70  (.Q0(Q1), .XB0(XB1), .A0(A1), .CLK(CLK), 
	.OE(OE));
BIID41 \$1I81  (.Q0(Q3), .XB0(XB3), .A0(A3), .CLK(CLK), 
	.OE(OE));
BIID41 \$1I86  (.Q0(Q2), .XB0(XB2), .A0(A2), .CLK(CLK), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:16 1994
`timescale 10 ps / 10 ps 
module BIID51(
	Q0, XB0, A0, CLK, 
	OE);

	output Q0;
	inout XB0;
	input A0;
	input CLK;
	input OE;

XDFF1 \$1I1  (.Q0(Q0), .D0(\$1N7 ), .CLK(\$1N15 ));
XINV \$1I16  (.ZN0(\$1N15 ), .A0(CLK));
XBIDI1 \$1I2  (.Z0(\$1N7 ), .XB0(XB0), .A0(A0), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:19 1994
`timescale 10 ps / 10 ps 
module BIID54(
	Q0, Q1, Q2, Q3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	CLK, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input CLK;
	input OE;

BIID51 \$1I20  (.Q0(Q3), .XB0(XB3), .A0(A3), .CLK(CLK), 
	.OE(OE));
BIID51 \$1I28  (.Q0(Q2), .XB0(XB2), .A0(A2), .CLK(CLK), 
	.OE(OE));
BIID51 \$1I39  (.Q0(Q1), .XB0(XB1), .A0(A1), .CLK(CLK), 
	.OE(OE));
BIID51 \$1I50  (.Q0(Q0), .XB0(XB0), .A0(A0), .CLK(CLK), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:22 1994
`timescale 10 ps / 10 ps 
module BIID58(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	CLK, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input CLK;
	input OE;

BIID51 \$1I20  (.Q0(Q7), .XB0(XB7), .A0(A7), .CLK(CLK), 
	.OE(OE));
BIID51 \$1I28  (.Q0(Q6), .XB0(XB6), .A0(A6), .CLK(CLK), 
	.OE(OE));
BIID51 \$1I39  (.Q0(Q5), .XB0(XB5), .A0(A5), .CLK(CLK), 
	.OE(OE));
BIID51 \$1I50  (.Q0(Q4), .XB0(XB4), .A0(A4), .CLK(CLK), 
	.OE(OE));
BIID51 \$1I62  (.Q0(Q0), .XB0(XB0), .A0(A0), .CLK(CLK), 
	.OE(OE));
BIID51 \$1I70  (.Q0(Q1), .XB0(XB1), .A0(A1), .CLK(CLK), 
	.OE(OE));
BIID51 \$1I81  (.Q0(Q3), .XB0(XB3), .A0(A3), .CLK(CLK), 
	.OE(OE));
BIID51 \$1I86  (.Q0(Q2), .XB0(XB2), .A0(A2), .CLK(CLK), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:24 1994
`timescale 10 ps / 10 ps 
module BIID61(
	Q0, XB0, A0, CLK, 
	OE);

	output Q0;
	inout XB0;
	input A0;
	input CLK;
	input OE;

XDFF1 \$1I1  (.Q0(Q0), .D0(\$1N7 ), .CLK(\$1N17 ));
XINV \$1I16  (.ZN0(\$1N10 ), .A0(A0));
XINV \$1I18  (.ZN0(\$1N17 ), .A0(CLK));
XBIDI1 \$1I2  (.Z0(\$1N7 ), .XB0(XB0), .A0(\$1N10 ), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:27 1994
`timescale 10 ps / 10 ps 
module BIID64(
	Q0, Q1, Q2, Q3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	CLK, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input CLK;
	input OE;

BIID61 \$1I20  (.Q0(Q3), .XB0(XB3), .A0(A3), .CLK(CLK), 
	.OE(OE));
BIID61 \$1I28  (.Q0(Q2), .XB0(XB2), .A0(A2), .CLK(CLK), 
	.OE(OE));
BIID61 \$1I39  (.Q0(Q1), .XB0(XB1), .A0(A1), .CLK(CLK), 
	.OE(OE));
BIID61 \$1I50  (.Q0(Q0), .XB0(XB0), .A0(A0), .CLK(CLK), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:30 1994
`timescale 10 ps / 10 ps 
module BIID68(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	CLK, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input CLK;
	input OE;

BIID61 \$1I20  (.Q0(Q7), .XB0(XB7), .A0(A7), .CLK(CLK), 
	.OE(OE));
BIID61 \$1I28  (.Q0(Q6), .XB0(XB6), .A0(A6), .CLK(CLK), 
	.OE(OE));
BIID61 \$1I39  (.Q0(Q5), .XB0(XB5), .A0(A5), .CLK(CLK), 
	.OE(OE));
BIID61 \$1I50  (.Q0(Q4), .XB0(XB4), .A0(A4), .CLK(CLK), 
	.OE(OE));
BIID61 \$1I62  (.Q0(Q0), .XB0(XB0), .A0(A0), .CLK(CLK), 
	.OE(OE));
BIID61 \$1I70  (.Q0(Q1), .XB0(XB1), .A0(A1), .CLK(CLK), 
	.OE(OE));
BIID61 \$1I81  (.Q0(Q3), .XB0(XB3), .A0(A3), .CLK(CLK), 
	.OE(OE));
BIID61 \$1I86  (.Q0(Q2), .XB0(XB2), .A0(A2), .CLK(CLK), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:32 1994
`timescale 10 ps / 10 ps 
module BIID71(
	Q0, XB0, A0, CLK, 
	OE);

	output Q0;
	inout XB0;
	input A0;
	input CLK;
	input OE;

XDFF1 \$1I1  (.Q0(Q0), .D0(\$1N7 ), .CLK(\$1N17 ));
XINV \$1I16  (.ZN0(\$1N9 ), .A0(OE));
XINV \$1I18  (.ZN0(\$1N17 ), .A0(CLK));
XBIDI1 \$1I2  (.Z0(\$1N7 ), .XB0(XB0), .A0(A0), .OE(\$1N9 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:35 1994
`timescale 10 ps / 10 ps 
module BIID74(
	Q0, Q1, Q2, Q3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	CLK, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input CLK;
	input OE;

BIID71 \$1I20  (.Q0(Q3), .XB0(XB3), .A0(A3), .CLK(CLK), 
	.OE(OE));
BIID71 \$1I28  (.Q0(Q2), .XB0(XB2), .A0(A2), .CLK(CLK), 
	.OE(OE));
BIID71 \$1I39  (.Q0(Q1), .XB0(XB1), .A0(A1), .CLK(CLK), 
	.OE(OE));
BIID71 \$1I50  (.Q0(Q0), .XB0(XB0), .A0(A0), .CLK(CLK), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:38 1994
`timescale 10 ps / 10 ps 
module BIID78(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	CLK, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input CLK;
	input OE;

BIID71 \$1I20  (.Q0(Q7), .XB0(XB7), .A0(A7), .CLK(CLK), 
	.OE(OE));
BIID71 \$1I28  (.Q0(Q6), .XB0(XB6), .A0(A6), .CLK(CLK), 
	.OE(OE));
BIID71 \$1I39  (.Q0(Q5), .XB0(XB5), .A0(A5), .CLK(CLK), 
	.OE(OE));
BIID71 \$1I50  (.Q0(Q4), .XB0(XB4), .A0(A4), .CLK(CLK), 
	.OE(OE));
BIID71 \$1I62  (.Q0(Q0), .XB0(XB0), .A0(A0), .CLK(CLK), 
	.OE(OE));
BIID71 \$1I70  (.Q0(Q1), .XB0(XB1), .A0(A1), .CLK(CLK), 
	.OE(OE));
BIID71 \$1I81  (.Q0(Q3), .XB0(XB3), .A0(A3), .CLK(CLK), 
	.OE(OE));
BIID71 \$1I86  (.Q0(Q2), .XB0(XB2), .A0(A2), .CLK(CLK), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:40 1994
`timescale 10 ps / 10 ps 
module BIID81(
	Q0, XB0, A0, CLK, 
	OE);

	output Q0;
	inout XB0;
	input A0;
	input CLK;
	input OE;

XDFF1 \$1I1  (.Q0(Q0), .D0(\$1N7 ), .CLK(\$1N17 ));
XINV \$1I16  (.ZN0(\$1N10 ), .A0(A0));
XINV \$1I18  (.ZN0(\$1N17 ), .A0(CLK));
XBIDI1 \$1I2  (.Z0(\$1N7 ), .XB0(XB0), .A0(\$1N10 ), .OE(\$1N9 ));
XINV \$1I20  (.ZN0(\$1N9 ), .A0(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:42 1994
`timescale 10 ps / 10 ps 
module BIID84(
	Q0, Q1, Q2, Q3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	CLK, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input CLK;
	input OE;

BIID81 \$1I20  (.Q0(Q3), .XB0(XB3), .A0(A3), .CLK(CLK), 
	.OE(OE));
BIID81 \$1I28  (.Q0(Q2), .XB0(XB2), .A0(A2), .CLK(CLK), 
	.OE(OE));
BIID81 \$1I39  (.Q0(Q1), .XB0(XB1), .A0(A1), .CLK(CLK), 
	.OE(OE));
BIID81 \$1I50  (.Q0(Q0), .XB0(XB0), .A0(A0), .CLK(CLK), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:45 1994
`timescale 10 ps / 10 ps 
module BIID88(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	CLK, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input CLK;
	input OE;

BIID81 \$1I20  (.Q0(Q7), .XB0(XB7), .A0(A7), .CLK(CLK), 
	.OE(OE));
BIID81 \$1I28  (.Q0(Q6), .XB0(XB6), .A0(A6), .CLK(CLK), 
	.OE(OE));
BIID81 \$1I39  (.Q0(Q5), .XB0(XB5), .A0(A5), .CLK(CLK), 
	.OE(OE));
BIID81 \$1I50  (.Q0(Q4), .XB0(XB4), .A0(A4), .CLK(CLK), 
	.OE(OE));
BIID81 \$1I62  (.Q0(Q0), .XB0(XB0), .A0(A0), .CLK(CLK), 
	.OE(OE));
BIID81 \$1I70  (.Q0(Q1), .XB0(XB1), .A0(A1), .CLK(CLK), 
	.OE(OE));
BIID81 \$1I81  (.Q0(Q3), .XB0(XB3), .A0(A3), .CLK(CLK), 
	.OE(OE));
BIID81 \$1I86  (.Q0(Q2), .XB0(XB2), .A0(A2), .CLK(CLK), 
	.OE(OE));
endmodule
`timescale 10 ps / 10 ps
module BIID91(
	A0, CD, CLK, OE, Q0, XB0);


	input A0;
	input CD;
	input CLK;
	input OE;
	output Q0;
	inout XB0;



XBIDI1 \$1I2  (.Z0 (\$1N7 ), .XB0 (XB0), .A0 (A0), 
	.OE (OE));
XDFF2 \$1I1  (.Q0 (Q0), .D0 (\$1N7 ), .CLK (CLK), 
	.CD (CD));
endmodule
`timescale 10 ps / 10 ps
module BIID91E(
	A0, CD, CLK, EN, OE, Q0, XB0);


	input A0;
	input CD;
	input CLK;
	input EN;
	input OE;
	output Q0;
	inout XB0;



XDFF2E \$1I30  (.Q0 (Q0), .D0 (\$1N7 ), .CLK (CLK), 
	.CD (CD), .EN (EN));
XBIDI1 \$1I2  (.Z0 (\$1N7 ), .XB0 (XB0), .A0 (A0), 
	.OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIID94(
	A0, A1, A2, A3, CD, CLK, OE, Q0, Q1, Q2, Q3, XB0, XB1, XB2, XB3);


	input A0;
	input A1;
	input A2;
	input A3;
	input CD;
	input CLK;
	input OE;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;



BIID91 \$1I60  (.Q0 (Q2), .XB0 (XB2), .A0 (A2), 
	.CLK (CLK), .OE (OE), .CD (CD));
BIID91 \$1I59  (.Q0 (Q1), .XB0 (XB1), .A0 (A1), 
	.CLK (CLK), .OE (OE), .CD (CD));
BIID91 \$1I58  (.Q0 (Q0), .XB0 (XB0), .A0 (A0), 
	.CLK (CLK), .OE (OE), .CD (CD));
BIID91 \$1I57  (.Q0 (Q3), .XB0 (XB3), .A0 (A3), 
	.CLK (CLK), .OE (OE), .CD (CD));
endmodule
`timescale 10 ps / 10 ps
module BIID94E(
	A0, A1, A2, A3, CD, CLK, EN, OE, Q0, Q1, Q2, Q3, XB0, XB1, XB2, XB3);


	input A0;
	input A1;
	input A2;
	input A3;
	input CD;
	input CLK;
	input EN;
	input OE;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;



BIID91E \$1I70  (.Q0 (Q3), .XB0 (XB3), .A0 (A3), 
	.CLK (CLK), .EN (EN), .OE (OE), 
	.CD (CD));
BIID91E \$1I67  (.Q0 (Q0), .XB0 (XB0), .A0 (A0), 
	.CLK (CLK), .EN (EN), .OE (OE), 
	.CD (CD));
BIID91E \$1I68  (.Q0 (Q1), .XB0 (XB1), .A0 (A1), 
	.CLK (CLK), .EN (EN), .OE (OE), 
	.CD (CD));
BIID91E \$1I69  (.Q0 (Q2), .XB0 (XB2), .A0 (A2), 
	.CLK (CLK), .EN (EN), .OE (OE), 
	.CD (CD));
endmodule
`timescale 10 ps / 10 ps
module BIIDA1(
	A0, CLK, OE, SD, Q0, XB0);


	input A0;
	input CLK;
	input OE;
	input SD;
	output Q0;
	inout XB0;



XBIDI1 \$1I2  (.Z0 (\$1N7 ), .XB0 (XB0), .A0 (A0), 
	.OE (OE));
XDFF3 \$1I1  (.Q0 (Q0), .D0 (\$1N7 ), .CLK (CLK), 
	.SD (SD));
endmodule
`timescale 10 ps / 10 ps
module BIIDA1E(
	A0, CLK, EN, OE, SD, Q0, XB0);


	input A0;
	input CLK;
	input EN;
	input OE;
	input SD;
	output Q0;
	inout XB0;



XDFF3E \$1I32  (.Q0 (Q0), .D0 (\$1N7 ), .CLK (CLK), 
	.SD (SD), .EN (EN));
XBIDI1 \$1I2  (.Z0 (\$1N7 ), .XB0 (XB0), .A0 (A0), 
	.OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIIDA4(
	A0, A1, A2, A3, CLK, OE, SD, Q0, Q1, Q2, Q3, XB0, XB1, XB2, XB3);


	input A0;
	input A1;
	input A2;
	input A3;
	input CLK;
	input OE;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;



BIIDA1 \$1I222  (.Q0 (Q3), .XB0 (XB3), .A0 (A3), 
	.CLK (CLK), .SD (SD), .OE (OE));
BIIDA1 \$1I221  (.Q0 (Q2), .XB0 (XB2), .A0 (A2), 
	.CLK (CLK), .SD (SD), .OE (OE));
BIIDA1 \$1I220  (.Q0 (Q1), .XB0 (XB1), .A0 (A1), 
	.CLK (CLK), .SD (SD), .OE (OE));
BIIDA1 \$1I219  (.Q0 (Q0), .XB0 (XB0), .A0 (A0), 
	.CLK (CLK), .SD (SD), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIIDA4E(
	A0, A1, A2, A3, CLK, EN, OE, SD, Q0, Q1, Q2, Q3, XB0, XB1, XB2, XB3);


	input A0;
	input A1;
	input A2;
	input A3;
	input CLK;
	input EN;
	input OE;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;



BIIDA1E \$1I218  (.Q0 (Q3), .XB0 (XB3), .A0 (A3), 
	.CLK (CLK), .EN (EN), .OE (OE), 
	.SD (SD));
BIIDA1E \$1I217  (.Q0 (Q2), .XB0 (XB2), .A0 (A2), 
	.CLK (CLK), .EN (EN), .OE (OE), 
	.SD (SD));
BIIDA1E \$1I216  (.Q0 (Q1), .XB0 (XB1), .A0 (A1), 
	.CLK (CLK), .EN (EN), .OE (OE), 
	.SD (SD));
BIIDA1E \$1I215  (.Q0 (Q0), .XB0 (XB0), .A0 (A0), 
	.CLK (CLK), .EN (EN), .OE (OE), 
	.SD (SD));
endmodule
`timescale 10 ps / 10 ps
module BIIDB1(
	A0, CD, CLK, OE, SD, Q0, XB0);


	input A0;
	input CD;
	input CLK;
	input OE;
	input SD;
	output Q0;
	inout XB0;



XDFF4 \$1I1  (.Q0 (Q0), .D0 (\$1N7 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
XBIDI1 \$1I2  (.Z0 (\$1N7 ), .XB0 (XB0), .A0 (A0), 
	.OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIIDB1E(
	A0, CD, CLK, EN, OE, SD, Q0, XB0);


	input A0;
	input CD;
	input CLK;
	input EN;
	input OE;
	input SD;
	output Q0;
	inout XB0;



XDFF4E \$1I35  (.Q0 (Q0), .D0 (\$1N7 ), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
XBIDI1 \$1I2  (.Z0 (\$1N7 ), .XB0 (XB0), .A0 (A0), 
	.OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIIDB4(
	A0, A1, A2, A3, CD, CLK, OE, SD, Q0, Q1, Q2, Q3, XB0, XB1, XB2, XB3);


	input A0;
	input A1;
	input A2;
	input A3;
	input CD;
	input CLK;
	input OE;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;



BIIDB1 \$1I218  (.Q0 (Q3), .XB0 (XB3), .A0 (A3), 
	.CLK (CLK), .OE (OE), .CD (CD), 
	.SD (SD));
BIIDB1 \$1I217  (.Q0 (Q2), .XB0 (XB2), .A0 (A2), 
	.CLK (CLK), .OE (OE), .CD (CD), 
	.SD (SD));
BIIDB1 \$1I216  (.Q0 (Q1), .XB0 (XB1), .A0 (A1), 
	.CLK (CLK), .OE (OE), .CD (CD), 
	.SD (SD));
BIIDB1 \$1I215  (.Q0 (Q0), .XB0 (XB0), .A0 (A0), 
	.CLK (CLK), .OE (OE), .CD (CD), 
	.SD (SD));
endmodule
`timescale 10 ps / 10 ps
module BIIDB4E(
	A0, A1, A2, A3, CD, CLK, EN, OE, SD, Q0, Q1, Q2, Q3, XB0, XB1, XB2, XB3);


	input A0;
	input A1;
	input A2;
	input A3;
	input CD;
	input CLK;
	input EN;
	input OE;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;



BIIDB1E \$1I128  (.Q0 (Q2), .XB0 (XB2), .A0 (A2), 
	.CLK (CLK), .EN (EN), .OE (OE), 
	.CD (CD), .SD (SD));
BIIDB1E \$1I126  (.Q0 (Q0), .XB0 (XB0), .A0 (A0), 
	.CLK (CLK), .EN (EN), .OE (OE), 
	.CD (CD), .SD (SD));
BIIDB1E \$1I127  (.Q0 (Q1), .XB0 (XB1), .A0 (A1), 
	.CLK (CLK), .EN (EN), .OE (OE), 
	.CD (CD), .SD (SD));
BIIDB1E \$1I129  (.Q0 (Q3), .XB0 (XB3), .A0 (A3), 
	.CLK (CLK), .EN (EN), .OE (OE), 
	.CD (CD), .SD (SD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:47 1994
`timescale 10 ps / 10 ps 
module BIIL11(
	Q0, XB0, A0, G, 
	OE);

	output Q0;
	inout XB0;
	input A0;
	input G;
	input OE;

XDL1 \$1I15  (.Q0(Q0), .D0(\$1N7 ), .G(G));
XBIDI1 \$1I2  (.Z0(\$1N7 ), .XB0(XB0), .A0(A0), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:50 1994
`timescale 10 ps / 10 ps 
module BIIL14(
	Q0, Q1, Q2, Q3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	G, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input G;
	input OE;

BIIL11 \$1I20  (.Q0(Q3), .XB0(XB3), .A0(A3), .G(G), 
	.OE(OE));
BIIL11 \$1I28  (.Q0(Q2), .XB0(XB2), .A0(A2), .G(G), 
	.OE(OE));
BIIL11 \$1I39  (.Q0(Q1), .XB0(XB1), .A0(A1), .G(G), 
	.OE(OE));
BIIL11 \$1I50  (.Q0(Q0), .XB0(XB0), .A0(A0), .G(G), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:52 1994
`timescale 10 ps / 10 ps 
module BIIL18(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	G, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input G;
	input OE;

BIIL11 \$1I20  (.Q0(Q7), .XB0(XB7), .A0(A7), .G(G), 
	.OE(OE));
BIIL11 \$1I28  (.Q0(Q6), .XB0(XB6), .A0(A6), .G(G), 
	.OE(OE));
BIIL11 \$1I39  (.Q0(Q5), .XB0(XB5), .A0(A5), .G(G), 
	.OE(OE));
BIIL11 \$1I50  (.Q0(Q4), .XB0(XB4), .A0(A4), .G(G), 
	.OE(OE));
BIIL11 \$1I62  (.Q0(Q0), .XB0(XB0), .A0(A0), .G(G), 
	.OE(OE));
BIIL11 \$1I70  (.Q0(Q1), .XB0(XB1), .A0(A1), .G(G), 
	.OE(OE));
BIIL11 \$1I81  (.Q0(Q3), .XB0(XB3), .A0(A3), .G(G), 
	.OE(OE));
BIIL11 \$1I86  (.Q0(Q2), .XB0(XB2), .A0(A2), .G(G), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:54 1994
`timescale 10 ps / 10 ps 
module BIIL21(
	Q0, XB0, A0, G, 
	OE);

	output Q0;
	inout XB0;
	input A0;
	input G;
	input OE;

XDL1 \$1I1  (.Q0(Q0), .D0(\$1N7 ), .G(G));
XINV \$1I16  (.ZN0(\$1N10 ), .A0(A0));
XBIDI1 \$1I2  (.Z0(\$1N7 ), .XB0(XB0), .A0(\$1N10 ), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:57 1994
`timescale 10 ps / 10 ps 
module BIIL24(
	Q0, Q1, Q2, Q3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	G, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input G;
	input OE;

BIIL21 \$1I20  (.Q0(Q3), .XB0(XB3), .A0(A3), .G(G), 
	.OE(OE));
BIIL21 \$1I28  (.Q0(Q2), .XB0(XB2), .A0(A2), .G(G), 
	.OE(OE));
BIIL21 \$1I39  (.Q0(Q1), .XB0(XB1), .A0(A1), .G(G), 
	.OE(OE));
BIIL21 \$1I50  (.Q0(Q0), .XB0(XB0), .A0(A0), .G(G), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 15:59:59 1994
`timescale 10 ps / 10 ps 
module BIIL28(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	G, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input G;
	input OE;

BIIL21 \$1I20  (.Q0(Q7), .XB0(XB7), .A0(A7), .G(G), 
	.OE(OE));
BIIL21 \$1I28  (.Q0(Q6), .XB0(XB6), .A0(A6), .G(G), 
	.OE(OE));
BIIL21 \$1I39  (.Q0(Q5), .XB0(XB5), .A0(A5), .G(G), 
	.OE(OE));
BIIL21 \$1I50  (.Q0(Q4), .XB0(XB4), .A0(A4), .G(G), 
	.OE(OE));
BIIL21 \$1I62  (.Q0(Q0), .XB0(XB0), .A0(A0), .G(G), 
	.OE(OE));
BIIL21 \$1I70  (.Q0(Q1), .XB0(XB1), .A0(A1), .G(G), 
	.OE(OE));
BIIL21 \$1I81  (.Q0(Q3), .XB0(XB3), .A0(A3), .G(G), 
	.OE(OE));
BIIL21 \$1I86  (.Q0(Q2), .XB0(XB2), .A0(A2), .G(G), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:01 1994
`timescale 10 ps / 10 ps 
module BIIL31(
	Q0, XB0, A0, G, 
	OE);

	output Q0;
	inout XB0;
	input A0;
	input G;
	input OE;

XDL1 \$1I1  (.Q0(Q0), .D0(\$1N7 ), .G(G));
XINV \$1I16  (.ZN0(\$1N9 ), .A0(OE));
XBIDI1 \$1I2  (.Z0(\$1N7 ), .XB0(XB0), .A0(A0), .OE(\$1N9 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:04 1994
`timescale 10 ps / 10 ps 
module BIIL34(
	Q0, Q1, Q2, Q3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	G, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input G;
	input OE;

BIIL31 \$1I20  (.Q0(Q3), .XB0(XB3), .A0(A3), .G(G), 
	.OE(OE));
BIIL31 \$1I28  (.Q0(Q2), .XB0(XB2), .A0(A2), .G(G), 
	.OE(OE));
BIIL31 \$1I39  (.Q0(Q1), .XB0(XB1), .A0(A1), .G(G), 
	.OE(OE));
BIIL31 \$1I50  (.Q0(Q0), .XB0(XB0), .A0(A0), .G(G), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:07 1994
`timescale 10 ps / 10 ps 
module BIIL38(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	G, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input G;
	input OE;

BIIL31 \$1I20  (.Q0(Q7), .XB0(XB7), .A0(A7), .G(G), 
	.OE(OE));
BIIL31 \$1I28  (.Q0(Q6), .XB0(XB6), .A0(A6), .G(G), 
	.OE(OE));
BIIL31 \$1I39  (.Q0(Q5), .XB0(XB5), .A0(A5), .G(G), 
	.OE(OE));
BIIL31 \$1I50  (.Q0(Q4), .XB0(XB4), .A0(A4), .G(G), 
	.OE(OE));
BIIL31 \$1I62  (.Q0(Q0), .XB0(XB0), .A0(A0), .G(G), 
	.OE(OE));
BIIL31 \$1I70  (.Q0(Q1), .XB0(XB1), .A0(A1), .G(G), 
	.OE(OE));
BIIL31 \$1I81  (.Q0(Q3), .XB0(XB3), .A0(A3), .G(G), 
	.OE(OE));
BIIL31 \$1I86  (.Q0(Q2), .XB0(XB2), .A0(A2), .G(G), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:08 1994
`timescale 10 ps / 10 ps 
module BIIL41(
	Q0, XB0, A0, G, 
	OE);

	output Q0;
	inout XB0;
	input A0;
	input G;
	input OE;

XDL1 \$1I1  (.Q0(Q0), .D0(\$1N7 ), .G(G));
XINV \$1I16  (.ZN0(\$1N10 ), .A0(A0));
XINV \$1I18  (.ZN0(\$1N9 ), .A0(OE));
XBIDI1 \$1I2  (.Z0(\$1N7 ), .XB0(XB0), .A0(\$1N10 ), .OE(\$1N9 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:11 1994
`timescale 10 ps / 10 ps 
module BIIL44(
	Q0, Q1, Q2, Q3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	G, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input G;
	input OE;

BIIL41 \$1I20  (.Q0(Q3), .XB0(XB3), .A0(A3), .G(G), 
	.OE(OE));
BIIL41 \$1I28  (.Q0(Q2), .XB0(XB2), .A0(A2), .G(G), 
	.OE(OE));
BIIL41 \$1I39  (.Q0(Q1), .XB0(XB1), .A0(A1), .G(G), 
	.OE(OE));
BIIL41 \$1I50  (.Q0(Q0), .XB0(XB0), .A0(A0), .G(G), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:14 1994
`timescale 10 ps / 10 ps 
module BIIL48(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	G, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input G;
	input OE;

BIIL41 \$1I20  (.Q0(Q7), .XB0(XB7), .A0(A7), .G(G), 
	.OE(OE));
BIIL41 \$1I28  (.Q0(Q6), .XB0(XB6), .A0(A6), .G(G), 
	.OE(OE));
BIIL41 \$1I39  (.Q0(Q5), .XB0(XB5), .A0(A5), .G(G), 
	.OE(OE));
BIIL41 \$1I50  (.Q0(Q4), .XB0(XB4), .A0(A4), .G(G), 
	.OE(OE));
BIIL41 \$1I62  (.Q0(Q0), .XB0(XB0), .A0(A0), .G(G), 
	.OE(OE));
BIIL41 \$1I70  (.Q0(Q1), .XB0(XB1), .A0(A1), .G(G), 
	.OE(OE));
BIIL41 \$1I81  (.Q0(Q3), .XB0(XB3), .A0(A3), .G(G), 
	.OE(OE));
BIIL41 \$1I86  (.Q0(Q2), .XB0(XB2), .A0(A2), .G(G), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:16 1994
`timescale 10 ps / 10 ps 
module BIIL51(
	Q0, XB0, A0, G, 
	OE);

	output Q0;
	inout XB0;
	input A0;
	input G;
	input OE;

XDL1 \$1I1  (.Q0(Q0), .D0(\$1N7 ), .G(\$1N15 ));
XINV \$1I16  (.ZN0(\$1N15 ), .A0(G));
XBIDI1 \$1I2  (.Z0(\$1N7 ), .XB0(XB0), .A0(A0), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:19 1994
`timescale 10 ps / 10 ps 
module BIIL54(
	Q0, Q1, Q2, Q3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	G, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input G;
	input OE;

BIIL51 \$1I20  (.Q0(Q3), .XB0(XB3), .A0(A3), .G(G), 
	.OE(OE));
BIIL51 \$1I28  (.Q0(Q2), .XB0(XB2), .A0(A2), .G(G), 
	.OE(OE));
BIIL51 \$1I39  (.Q0(Q1), .XB0(XB1), .A0(A1), .G(G), 
	.OE(OE));
BIIL51 \$1I50  (.Q0(Q0), .XB0(XB0), .A0(A0), .G(G), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:21 1994
`timescale 10 ps / 10 ps 
module BIIL58(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	G, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input G;
	input OE;

BIIL51 \$1I20  (.Q0(Q7), .XB0(XB7), .A0(A7), .G(G), 
	.OE(OE));
BIIL51 \$1I28  (.Q0(Q6), .XB0(XB6), .A0(A6), .G(G), 
	.OE(OE));
BIIL51 \$1I39  (.Q0(Q5), .XB0(XB5), .A0(A5), .G(G), 
	.OE(OE));
BIIL51 \$1I50  (.Q0(Q4), .XB0(XB4), .A0(A4), .G(G), 
	.OE(OE));
BIIL51 \$1I62  (.Q0(Q0), .XB0(XB0), .A0(A0), .G(G), 
	.OE(OE));
BIIL51 \$1I70  (.Q0(Q1), .XB0(XB1), .A0(A1), .G(G), 
	.OE(OE));
BIIL51 \$1I81  (.Q0(Q3), .XB0(XB3), .A0(A3), .G(G), 
	.OE(OE));
BIIL51 \$1I86  (.Q0(Q2), .XB0(XB2), .A0(A2), .G(G), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:23 1994
`timescale 10 ps / 10 ps 
module BIIL61(
	Q0, XB0, A0, G, 
	OE);

	output Q0;
	inout XB0;
	input A0;
	input G;
	input OE;

XDL1 \$1I1  (.Q0(Q0), .D0(\$1N7 ), .G(\$1N17 ));
XINV \$1I16  (.ZN0(\$1N10 ), .A0(A0));
XINV \$1I18  (.ZN0(\$1N17 ), .A0(G));
XBIDI1 \$1I2  (.Z0(\$1N7 ), .XB0(XB0), .A0(\$1N10 ), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:26 1994
`timescale 10 ps / 10 ps 
module BIIL64(
	Q0, Q1, Q2, Q3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	G, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input G;
	input OE;

BIIL61 \$1I20  (.Q0(Q3), .XB0(XB3), .A0(A3), .G(G), 
	.OE(OE));
BIIL61 \$1I28  (.Q0(Q2), .XB0(XB2), .A0(A2), .G(G), 
	.OE(OE));
BIIL61 \$1I39  (.Q0(Q1), .XB0(XB1), .A0(A1), .G(G), 
	.OE(OE));
BIIL61 \$1I50  (.Q0(Q0), .XB0(XB0), .A0(A0), .G(G), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:28 1994
`timescale 10 ps / 10 ps 
module BIIL68(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	G, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input G;
	input OE;

BIIL61 \$1I20  (.Q0(Q7), .XB0(XB7), .A0(A7), .G(G), 
	.OE(OE));
BIIL61 \$1I28  (.Q0(Q6), .XB0(XB6), .A0(A6), .G(G), 
	.OE(OE));
BIIL61 \$1I39  (.Q0(Q5), .XB0(XB5), .A0(A5), .G(G), 
	.OE(OE));
BIIL61 \$1I50  (.Q0(Q4), .XB0(XB4), .A0(A4), .G(G), 
	.OE(OE));
BIIL61 \$1I62  (.Q0(Q0), .XB0(XB0), .A0(A0), .G(G), 
	.OE(OE));
BIIL61 \$1I70  (.Q0(Q1), .XB0(XB1), .A0(A1), .G(G), 
	.OE(OE));
BIIL61 \$1I81  (.Q0(Q3), .XB0(XB3), .A0(A3), .G(G), 
	.OE(OE));
BIIL61 \$1I86  (.Q0(Q2), .XB0(XB2), .A0(A2), .G(G), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:30 1994
`timescale 10 ps / 10 ps 
module BIIL71(
	Q0, XB0, A0, G, 
	OE);

	output Q0;
	inout XB0;
	input A0;
	input G;
	input OE;

XDL1 \$1I1  (.Q0(Q0), .D0(\$1N7 ), .G(\$1N17 ));
XINV \$1I16  (.ZN0(\$1N9 ), .A0(OE));
XINV \$1I18  (.ZN0(\$1N17 ), .A0(G));
XBIDI1 \$1I2  (.Z0(\$1N7 ), .XB0(XB0), .A0(A0), .OE(\$1N9 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:33 1994
`timescale 10 ps / 10 ps 
module BIIL74(
	Q0, Q1, Q2, Q3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	G, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input G;
	input OE;

BIIL71 \$1I20  (.Q0(Q3), .XB0(XB3), .A0(A3), .G(G), 
	.OE(OE));
BIIL71 \$1I28  (.Q0(Q2), .XB0(XB2), .A0(A2), .G(G), 
	.OE(OE));
BIIL71 \$1I39  (.Q0(Q1), .XB0(XB1), .A0(A1), .G(G), 
	.OE(OE));
BIIL71 \$1I50  (.Q0(Q0), .XB0(XB0), .A0(A0), .G(G), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:36 1994
`timescale 10 ps / 10 ps 
module BIIL78(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	G, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input G;
	input OE;

BIIL71 \$1I20  (.Q0(Q7), .XB0(XB7), .A0(A7), .G(G), 
	.OE(OE));
BIIL71 \$1I28  (.Q0(Q6), .XB0(XB6), .A0(A6), .G(G), 
	.OE(OE));
BIIL71 \$1I39  (.Q0(Q5), .XB0(XB5), .A0(A5), .G(G), 
	.OE(OE));
BIIL71 \$1I50  (.Q0(Q4), .XB0(XB4), .A0(A4), .G(G), 
	.OE(OE));
BIIL71 \$1I62  (.Q0(Q0), .XB0(XB0), .A0(A0), .G(G), 
	.OE(OE));
BIIL71 \$1I70  (.Q0(Q1), .XB0(XB1), .A0(A1), .G(G), 
	.OE(OE));
BIIL71 \$1I81  (.Q0(Q3), .XB0(XB3), .A0(A3), .G(G), 
	.OE(OE));
BIIL71 \$1I86  (.Q0(Q2), .XB0(XB2), .A0(A2), .G(G), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:38 1994
`timescale 10 ps / 10 ps 
module BIIL81(
	Q0, XB0, A0, G, 
	OE);

	output Q0;
	inout XB0;
	input A0;
	input G;
	input OE;

XDL1 \$1I1  (.Q0(Q0), .D0(\$1N7 ), .G(\$1N17 ));
XINV \$1I16  (.ZN0(\$1N10 ), .A0(A0));
XINV \$1I18  (.ZN0(\$1N17 ), .A0(G));
XBIDI1 \$1I2  (.Z0(\$1N7 ), .XB0(XB0), .A0(\$1N10 ), .OE(\$1N9 ));
XINV \$1I20  (.ZN0(\$1N9 ), .A0(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:40 1994
`timescale 10 ps / 10 ps 
module BIIL84(
	Q0, Q1, Q2, Q3, 
	XB0, XB1, XB2, XB3, 
	A0, A1, A2, A3, 
	G, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	input A0;
	input A1;
	input A2;
	input A3;
	input G;
	input OE;

BIIL81 \$1I20  (.Q0(Q3), .XB0(XB3), .A0(A3), .G(G), 
	.OE(OE));
BIIL81 \$1I28  (.Q0(Q2), .XB0(XB2), .A0(A2), .G(G), 
	.OE(OE));
BIIL81 \$1I39  (.Q0(Q1), .XB0(XB1), .A0(A1), .G(G), 
	.OE(OE));
BIIL81 \$1I50  (.Q0(Q0), .XB0(XB0), .A0(A0), .G(G), 
	.OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:43 1994
`timescale 10 ps / 10 ps 
module BIIL88(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XB0, XB1, XB2, XB3, 
	XB4, XB5, XB6, XB7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	G, OE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	inout XB4;
	inout XB5;
	inout XB6;
	inout XB7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input G;
	input OE;

BIIL81 \$1I20  (.Q0(Q7), .XB0(XB7), .A0(A7), .G(G), 
	.OE(OE));
BIIL81 \$1I28  (.Q0(Q6), .XB0(XB6), .A0(A6), .G(G), 
	.OE(OE));
BIIL81 \$1I39  (.Q0(Q5), .XB0(XB5), .A0(A5), .G(G), 
	.OE(OE));
BIIL81 \$1I50  (.Q0(Q4), .XB0(XB4), .A0(A4), .G(G), 
	.OE(OE));
BIIL81 \$1I62  (.Q0(Q0), .XB0(XB0), .A0(A0), .G(G), 
	.OE(OE));
BIIL81 \$1I70  (.Q0(Q1), .XB0(XB1), .A0(A1), .G(G), 
	.OE(OE));
BIIL81 \$1I81  (.Q0(Q3), .XB0(XB3), .A0(A3), .G(G), 
	.OE(OE));
BIIL81 \$1I86  (.Q0(Q2), .XB0(XB2), .A0(A2), .G(G), 
	.OE(OE));
endmodule
`timescale 10 ps / 10 ps
module BIIL91(
	A0, CD, G, OE, Q0, XB0);


	input A0;
	input CD;
	input G;
	input OE;
	output Q0;
	inout XB0;



XBIDI1 \$1I2  (.Z0 (\$1N7 ), .XB0 (XB0), .A0 (A0), 
	.OE (OE));
XDL2 \$1I15  (.Q0 (Q0), .D0 (\$1N7 ), .G (G), 
	.CD (CD));
endmodule
`timescale 10 ps / 10 ps
module BIIL94(
	A0, A1, A2, A3, CD, G, OE, Q0, Q1, Q2, Q3, XB0, XB1, XB2, XB3);


	input A0;
	input A1;
	input A2;
	input A3;
	input CD;
	input G;
	input OE;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;



BIIL91 \$1I39  (.Q0 (Q1), .XB0 (XB1), .A0 (A1), 
	.G (G), .OE (OE), .CD (CD));
BIIL91 \$1I28  (.Q0 (Q2), .XB0 (XB2), .A0 (A2), 
	.G (G), .OE (OE), .CD (CD));
BIIL91 \$1I20  (.Q0 (Q3), .XB0 (XB3), .A0 (A3), 
	.G (G), .OE (OE), .CD (CD));
BIIL91 \$1I50  (.Q0 (Q0), .XB0 (XB0), .A0 (A0), 
	.G (G), .OE (OE), .CD (CD));
endmodule
`timescale 10 ps / 10 ps
module BIILA1(
	A0, G, OE, SD, Q0, XB0);


	input A0;
	input G;
	input OE;
	input SD;
	output Q0;
	inout XB0;



XBIDI1 \$1I2  (.Z0 (\$1N7 ), .XB0 (XB0), .A0 (A0), 
	.OE (OE));
XDL3 \$1I15  (.Q0 (Q0), .D0 (\$1N7 ), .G (G), 
	.SD (SD));
endmodule
`timescale 10 ps / 10 ps
module BIILA4(
	A0, A1, A2, A3, G, OE, SD, Q0, Q1, Q2, Q3, XB0, XB1, XB2, XB3);


	input A0;
	input A1;
	input A2;
	input A3;
	input G;
	input OE;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;



BIILA1 \$1I39  (.Q0 (Q1), .XB0 (XB1), .A0 (A1), 
	.G (G), .OE (OE), .SD (SD));
BIILA1 \$1I28  (.Q0 (Q2), .XB0 (XB2), .A0 (A2), 
	.G (G), .OE (OE), .SD (SD));
BIILA1 \$1I20  (.Q0 (Q3), .XB0 (XB3), .A0 (A3), 
	.G (G), .OE (OE), .SD (SD));
BIILA1 \$1I50  (.Q0 (Q0), .XB0 (XB0), .A0 (A0), 
	.G (G), .OE (OE), .SD (SD));
endmodule
`timescale 10 ps / 10 ps
module BIILB1(
	A0, CD, G, OE, SD, Q0, XB0);


	input A0;
	input CD;
	input G;
	input OE;
	input SD;
	output Q0;
	inout XB0;



XDL4 \$1I15  (.Q0 (Q0), .D0 (\$1N7 ), .G (G), 
	.SD (SD), .CD (CD));
XBIDI1 \$1I2  (.Z0 (\$1N7 ), .XB0 (XB0), .A0 (A0), 
	.OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIILB4(
	A0, A1, A2, A3, CD, G, OE, SD, Q0, Q1, Q2, Q3, XB0, XB1, XB2, XB3);


	input A0;
	input A1;
	input A2;
	input A3;
	input CD;
	input G;
	input OE;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;



BIILB1 \$1I39  (.Q0 (Q1), .XB0 (XB1), .A0 (A1), 
	.G (G), .OE (OE), .SD (SD), 
	.CD (CD));
BIILB1 \$1I28  (.Q0 (Q2), .XB0 (XB2), .A0 (A2), 
	.G (G), .OE (OE), .SD (SD), 
	.CD (CD));
BIILB1 \$1I20  (.Q0 (Q3), .XB0 (XB3), .A0 (A3), 
	.G (G), .OE (OE), .SD (SD), 
	.CD (CD));
BIILB1 \$1I50  (.Q0 (Q0), .XB0 (XB0), .A0 (A0), 
	.G (G), .OE (OE), .SD (SD), 
	.CD (CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:46 1994
`timescale 10 ps / 10 ps 
module BIN27(
	Z0, Z1, Z2, Z3, 
	Z4, Z5, Z6, A0, 
	A1, A2, A3, EN);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	input A0;
	input A1;
	input A2;
	input A3;
	input EN;

INV \$1I150  (.ZN0(\~A0 ), .A0(A0));
INV \$1I151  (.ZN0(\~A1 ), .A0(A1));
INV \$1I152  (.ZN0(\~A2 ), .A0(A2));
AND3 \$1I18  (.Z0(\$1N377 ), .A0(EN), .A1(A1), .A2(\~A0 ));
INV \$1I295  (.ZN0(\~A3 ), .A0(A3));
AND3 \$1I319  (.Z0(\$1N510 ), .A0(EN), .A1(A3), .A2(\~A2 ));
AND4 \$1I349  (.Z0(\$1N383 ), .A0(EN), .A1(\~A3 ), .A2(A2), 
	.A3(A0));
AND3 \$1I350  (.Z0(\$1N381 ), .A0(EN), .A1(A2), .A2(A1));
AND3 \$1I352  (.Z0(\$1N379 ), .A0(EN), .A1(\~A3 ), .A2(A1));
AND4 \$1I365  (.Z0(\$1N385 ), .A0(EN), .A1(A3), .A2(\~A2 ), 
	.A3(\~A1 ));
AND4 \$1I366  (.Z0(\$1N387 ), .A0(EN), .A1(\~A2 ), .A2(\~A1 ), 
	.A3(\~A0 ));
OR6 \$1I376  (.Z0(Z0), .A0(\$1N377 ), .A1(\$1N379 ), .A2(\$1N381 ), 
	.A3(\$1N383 ), .A4(\$1N385 ), .A5(\$1N387 ));
AND3 \$1I419  (.Z0(\$1N452 ), .A0(EN), .A1(\~A3 ), .A2(\~A2 ));
AND4 \$1I420  (.Z0(\$1N450 ), .A0(EN), .A1(\~A3 ), .A2(A1), 
	.A3(A0));
AND4 \$1I421  (.Z0(\$1N448 ), .A0(EN), .A1(A3), .A2(\~A1 ), 
	.A3(A0));
AND4 \$1I422  (.Z0(\$1N454 ), .A0(EN), .A1(\~A3 ), .A2(\~A1 ), 
	.A3(\~A0 ));
AND4 \$1I423  (.Z0(\$1N456 ), .A0(EN), .A1(A3), .A2(\~A2 ), 
	.A3(\~A0 ));
OR5 \$1I424  (.Z0(Z1), .A0(\$1N452 ), .A1(\$1N450 ), .A2(\$1N448 ), 
	.A3(\$1N454 ), .A4(\$1N456 ));
AND3 \$1I472  (.Z0(\$1N508 ), .A0(EN), .A1(\~A1 ), .A2(A0));
AND3 \$1I473  (.Z0(\$1N506 ), .A0(EN), .A1(\~A3 ), .A2(A2));
AND3 \$1I474  (.Z0(\$1N514 ), .A0(EN), .A1(\~A3 ), .A2(A0));
AND3 \$1I475  (.Z0(\$1N512 ), .A0(EN), .A1(\~A3 ), .A2(\~A1 ));
OR5 \$1I476  (.Z0(Z2), .A0(\$1N510 ), .A1(\$1N508 ), .A2(\$1N506 ), 
	.A3(\$1N512 ), .A4(\$1N514 ));
AND3 \$1I528  (.Z0(\$1N558 ), .A0(EN), .A1(A3), .A2(\~A1 ));
AND4 \$1I530  (.Z0(\$1N556 ), .A0(EN), .A1(A2), .A2(\~A1 ), 
	.A3(A0));
AND4 \$1I531  (.Z0(\$1N554 ), .A0(EN), .A1(A2), .A2(A1), 
	.A3(\~A0 ));
AND4 \$1I532  (.Z0(\$1N560 ), .A0(EN), .A1(\~A2 ), .A2(A1), 
	.A3(A0));
AND4 \$1I533  (.Z0(\$1N562 ), .A0(EN), .A1(\~A3 ), .A2(\~A2 ), 
	.A3(\~A0 ));
OR5 \$1I539  (.Z0(Z3), .A0(\$1N558 ), .A1(\$1N556 ), .A2(\$1N554 ), 
	.A3(\$1N560 ), .A4(\$1N562 ));
AND3 \$1I575  (.Z0(\$1N607 ), .A0(EN), .A1(A1), .A2(\~A0 ));
AND3 \$1I576  (.Z0(\$1N605 ), .A0(EN), .A1(A3), .A2(A2));
AND3 \$1I577  (.Z0(\$1N603 ), .A0(EN), .A1(A3), .A2(A1));
AND4 \$1I578  (.Z0(\$1N609 ), .A0(EN), .A1(\~A2 ), .A2(\~A1 ), 
	.A3(\~A0 ));
OR4 \$1I580  (.Z0(Z4), .A0(\$1N607 ), .A1(\$1N605 ), .A2(\$1N603 ), 
	.A3(\$1N609 ));
AND3 \$1I611  (.Z0(\$1N646 ), .A0(EN), .A1(A3), .A2(\~A2 ));
AND3 \$1I612  (.Z0(\$1N644 ), .A0(EN), .A1(A3), .A2(A1));
AND4 \$1I613  (.Z0(\$1N642 ), .A0(EN), .A1(\~A3 ), .A2(A2), 
	.A3(\~A1 ));
AND4 \$1I614  (.Z0(\$1N648 ), .A0(EN), .A1(A2), .A2(A1), 
	.A3(\~A0 ));
AND4 \$1I615  (.Z0(\$1N650 ), .A0(EN), .A1(\~A2 ), .A2(\~A1 ), 
	.A3(\~A0 ));
OR5 \$1I617  (.Z0(Z5), .A0(\$1N646 ), .A1(\$1N644 ), .A2(\$1N642 ), 
	.A3(\$1N648 ), .A4(\$1N650 ));
AND3 \$1I652  (.Z0(\$1N678 ), .A0(EN), .A1(A1), .A2(\~A0 ));
AND2 \$1I653  (.Z0(\$1N676 ), .A0(EN), .A1(A3));
AND3 \$1I654  (.Z0(\$1N674 ), .A0(EN), .A1(A2), .A2(\~A1 ));
AND4 \$1I655  (.Z0(\$1N680 ), .A0(EN), .A1(\~A2 ), .A2(A1), 
	.A3(A0));
OR4 \$1I668  (.Z0(Z6), .A0(\$1N678 ), .A1(\$1N676 ), .A2(\$1N674 ), 
	.A3(\$1N680 ));
endmodule
`timescale 10 ps / 10 ps
module BIOD11(
	CLK, D0, OE, XB0, Z0);


	input CLK;
	input D0;
	input OE;
	inout XB0;
	output Z0;



XDFF1 \$1I1  (.Q0 (\$1N20 ), .D0 (D0), .CLK (CLK));
XBIDI1 \$1I2  (.Z0 (Z0), .XB0 (XB0), .A0 (\$1N20 ), 
	.OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIOD11E(
	CLK, D0, EN, OE, XB0, Z0);


	input CLK;
	input D0;
	input EN;
	input OE;
	inout XB0;
	output Z0;



XBIDI1 \$1I2  (.Z0 (Z0), .XB0 (XB0), .A0 (\$1N20 ), 
	.OE (OE));
XDFF1E \$1I30  (.Q0 (\$1N20 ), .D0 (D0), .CLK (CLK), 
	.EN (EN));
endmodule
`timescale 10 ps / 10 ps
module BIOD14(
	CLK, D0, D1, D2, D3, OE, XB0, XB1, XB2, XB3, Z0, Z1, Z2, Z3);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input OE;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	output Z0;
	output Z1;
	output Z2;
	output Z3;



BIOD11 \$1I279  (.Z0 (Z3), .XB0 (XB3), .D0 (D3), 
	.CLK (CLK), .OE (OE));
BIOD11 \$1I278  (.Z0 (Z2), .XB0 (XB2), .D0 (D2), 
	.CLK (CLK), .OE (OE));
BIOD11 \$1I277  (.Z0 (Z1), .XB0 (XB1), .D0 (D1), 
	.CLK (CLK), .OE (OE));
BIOD11 \$1I276  (.Z0 (Z0), .XB0 (XB0), .D0 (D0), 
	.CLK (CLK), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIOD14E(
	CLK, D0, D1, D2, D3, EN, OE, XB0, XB1, XB2, XB3, Z0, Z1, Z2, Z3);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input OE;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	output Z0;
	output Z1;
	output Z2;
	output Z3;



BIOD11E \$1I275  (.Z0 (Z3), .XB0 (XB3), .D0 (D3), 
	.EN (EN), .CLK (CLK), .OE (OE));
BIOD11E \$1I274  (.Z0 (Z2), .XB0 (XB2), .D0 (D2), 
	.EN (EN), .CLK (CLK), .OE (OE));
BIOD11E \$1I273  (.Z0 (Z1), .XB0 (XB1), .D0 (D1), 
	.EN (EN), .CLK (CLK), .OE (OE));
BIOD11E \$1I272  (.Z0 (Z0), .XB0 (XB0), .D0 (D0), 
	.EN (EN), .CLK (CLK), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIOD21(
	CD, CLK, D0, OE, XB0, Z0);


	input CD;
	input CLK;
	input D0;
	input OE;
	inout XB0;
	output Z0;



XDFF2 \$1I38  (.Q0 (\$1N20 ), .D0 (D0), .CLK (CLK), 
	.CD (CD));
XBIDI1 \$1I2  (.Z0 (Z0), .XB0 (XB0), .A0 (\$1N20 ), 
	.OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIOD21E(
	CD, CLK, D0, EN, OE, XB0, Z0);


	input CD;
	input CLK;
	input D0;
	input EN;
	input OE;
	inout XB0;
	output Z0;



XBIDI1 \$1I2  (.Z0 (Z0), .XB0 (XB0), .A0 (\$1N20 ), 
	.OE (OE));
XDFF2E \$1I38  (.Q0 (\$1N20 ), .D0 (D0), .CLK (CLK), 
	.CD (CD), .EN (EN));
endmodule
`timescale 10 ps / 10 ps
module BIOD24(
	CD, CLK, D0, D1, D2, D3, OE, XB0, XB1, XB2, XB3, Z0, Z1, Z2, Z3);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input OE;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	output Z0;
	output Z1;
	output Z2;
	output Z3;



BIOD21 \$1I275  (.Z0 (Z3), .XB0 (XB3), .D0 (D3), 
	.CD (CD), .CLK (CLK), .OE (OE));
BIOD21 \$1I274  (.Z0 (Z2), .XB0 (XB2), .D0 (D2), 
	.CD (CD), .CLK (CLK), .OE (OE));
BIOD21 \$1I273  (.Z0 (Z1), .XB0 (XB1), .D0 (D1), 
	.CD (CD), .CLK (CLK), .OE (OE));
BIOD21 \$1I272  (.Z0 (Z0), .XB0 (XB0), .D0 (D0), 
	.CD (CD), .CLK (CLK), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIOD24E(
	CD, CLK, D0, D1, D2, D3, EN, OE, XB0, XB1, XB2, XB3, Z0, Z1, Z2, Z3);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input OE;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	output Z0;
	output Z1;
	output Z2;
	output Z3;



BIOD21E \$1I271  (.Z0 (Z3), .XB0 (XB3), .D0 (D3), 
	.CD (CD), .EN (EN), .CLK (CLK), 
	.OE (OE));
BIOD21E \$1I270  (.Z0 (Z2), .XB0 (XB2), .D0 (D2), 
	.CD (CD), .EN (EN), .CLK (CLK), 
	.OE (OE));
BIOD21E \$1I269  (.Z0 (Z1), .XB0 (XB1), .D0 (D1), 
	.CD (CD), .EN (EN), .CLK (CLK), 
	.OE (OE));
BIOD21E \$1I268  (.Z0 (Z0), .XB0 (XB0), .D0 (D0), 
	.CD (CD), .EN (EN), .CLK (CLK), 
	.OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIOD31(
	CLK, D0, OE, SD, XB0, Z0);


	input CLK;
	input D0;
	input OE;
	input SD;
	inout XB0;
	output Z0;



XDFF3 \$1I38  (.Q0 (\$1N20 ), .D0 (D0), .CLK (CLK), 
	.SD (SD));
XBIDI1 \$1I2  (.Z0 (Z0), .XB0 (XB0), .A0 (\$1N20 ), 
	.OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIOD31E(
	CLK, D0, EN, OE, SD, XB0, Z0);


	input CLK;
	input D0;
	input EN;
	input OE;
	input SD;
	inout XB0;
	output Z0;



XBIDI1 \$1I2  (.Z0 (Z0), .XB0 (XB0), .A0 (\$1N20 ), 
	.OE (OE));
XDFF3E \$1I38  (.Q0 (\$1N20 ), .D0 (D0), .CLK (CLK), 
	.SD (SD), .EN (EN));
endmodule
`timescale 10 ps / 10 ps
module BIOD34(
	CLK, D0, D1, D2, D3, OE, SD, XB0, XB1, XB2, XB3, Z0, Z1, Z2, Z3);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input OE;
	input SD;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	output Z0;
	output Z1;
	output Z2;
	output Z3;



BIOD31 \$1I275  (.Z0 (Z3), .XB0 (XB3), .D0 (D3), 
	.SD (SD), .CLK (CLK), .OE (OE));
BIOD31 \$1I274  (.Z0 (Z2), .XB0 (XB2), .D0 (D2), 
	.SD (SD), .CLK (CLK), .OE (OE));
BIOD31 \$1I273  (.Z0 (Z1), .XB0 (XB1), .D0 (D1), 
	.SD (SD), .CLK (CLK), .OE (OE));
BIOD31 \$1I272  (.Z0 (Z0), .XB0 (XB0), .D0 (D0), 
	.SD (SD), .CLK (CLK), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIOD34E(
	CLK, D0, D1, D2, D3, EN, OE, SD, XB0, XB1, XB2, XB3, Z0, Z1, Z2, Z3);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input OE;
	input SD;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	output Z0;
	output Z1;
	output Z2;
	output Z3;



BIOD31E \$1I271  (.Z0 (Z3), .XB0 (XB3), .D0 (D3), 
	.SD (SD), .EN (EN), .CLK (CLK), 
	.OE (OE));
BIOD31E \$1I270  (.Z0 (Z2), .XB0 (XB2), .D0 (D2), 
	.SD (SD), .EN (EN), .CLK (CLK), 
	.OE (OE));
BIOD31E \$1I269  (.Z0 (Z1), .XB0 (XB1), .D0 (D1), 
	.SD (SD), .EN (EN), .CLK (CLK), 
	.OE (OE));
BIOD31E \$1I268  (.Z0 (Z0), .XB0 (XB0), .D0 (D0), 
	.SD (SD), .EN (EN), .CLK (CLK), 
	.OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIOD41(
	CD, CLK, D0, OE, SD, XB0, Z0);


	input CD;
	input CLK;
	input D0;
	input OE;
	input SD;
	inout XB0;
	output Z0;



XBIDI1 \$1I2  (.Z0 (Z0), .XB0 (XB0), .A0 (\$1N20 ), 
	.OE (OE));
XDFF4 \$1I38  (.Q0 (\$1N20 ), .D0 (D0), .CLK (CLK), 
	.SD (SD), .CD (CD));
endmodule
`timescale 10 ps / 10 ps
module BIOD41E(
	CD, CLK, D0, EN, OE, SD, XB0, Z0);


	input CD;
	input CLK;
	input D0;
	input EN;
	input OE;
	input SD;
	inout XB0;
	output Z0;



XDFF4E \$1I38  (.Q0 (\$1N20 ), .D0 (D0), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
XBIDI1 \$1I2  (.Z0 (Z0), .XB0 (XB0), .A0 (\$1N20 ), 
	.OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIOD44(
	CD, CLK, D0, D1, D2, D3, OE, SD, XB0, XB1, XB2, XB3, Z0, Z1, Z2, Z3);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input OE;
	input SD;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	output Z0;
	output Z1;
	output Z2;
	output Z3;



BIOD41 \$1I271  (.Z0 (Z3), .XB0 (XB3), .D0 (D3), 
	.CD (CD), .SD (SD), .CLK (CLK), 
	.OE (OE));
BIOD41 \$1I270  (.Z0 (Z2), .XB0 (XB2), .D0 (D2), 
	.CD (CD), .SD (SD), .CLK (CLK), 
	.OE (OE));
BIOD41 \$1I269  (.Z0 (Z1), .XB0 (XB1), .D0 (D1), 
	.CD (CD), .SD (SD), .CLK (CLK), 
	.OE (OE));
BIOD41 \$1I268  (.Z0 (Z0), .XB0 (XB0), .D0 (D0), 
	.CD (CD), .SD (SD), .CLK (CLK), 
	.OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIOD44E(
	CD, CLK, D0, D1, D2, D3, EN, OE, SD, XB0, XB1, XB2, XB3, Z0, Z1, Z2, Z3);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input OE;
	input SD;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	output Z0;
	output Z1;
	output Z2;
	output Z3;



BIOD41E \$1I215  (.Z0 (Z3), .XB0 (XB3), .D0 (D3), 
	.CD (CD), .SD (SD), .EN (EN), 
	.CLK (CLK), .OE (OE));
BIOD41E \$1I212  (.Z0 (Z0), .XB0 (XB0), .D0 (D0), 
	.CD (CD), .SD (SD), .EN (EN), 
	.CLK (CLK), .OE (OE));
BIOD41E \$1I214  (.Z0 (Z2), .XB0 (XB2), .D0 (D2), 
	.CD (CD), .SD (SD), .EN (EN), 
	.CLK (CLK), .OE (OE));
BIOD41E \$1I213  (.Z0 (Z1), .XB0 (XB1), .D0 (D1), 
	.CD (CD), .SD (SD), .EN (EN), 
	.CLK (CLK), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIOL11(
	D0, G, OE, XB0, Z0);


	input D0;
	input G;
	input OE;
	inout XB0;
	output Z0;



XBIDI1 \$1I2  (.Z0 (Z0), .XB0 (XB0), .A0 (\$1N20 ), 
	.OE (OE));
XDL1 \$1I30  (.Q0 (\$1N20 ), .D0 (D0), .G (G));
endmodule
`timescale 10 ps / 10 ps
module BIOL14(
	D0, D1, D2, D3, G, OE, XB0, XB1, XB2, XB3, Z0, Z1, Z2, Z3);


	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	input OE;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	output Z0;
	output Z1;
	output Z2;
	output Z3;



BIOL11 \$1I279  (.Z0 (Z3), .XB0 (XB3), .D0 (D3), 
	.G (G), .OE (OE));
BIOL11 \$1I278  (.Z0 (Z2), .XB0 (XB2), .D0 (D2), 
	.G (G), .OE (OE));
BIOL11 \$1I277  (.Z0 (Z1), .XB0 (XB1), .D0 (D1), 
	.G (G), .OE (OE));
BIOL11 \$1I276  (.Z0 (Z0), .XB0 (XB0), .D0 (D0), 
	.G (G), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIOL21(
	CD, D0, G, OE, XB0, Z0);


	input CD;
	input D0;
	input G;
	input OE;
	inout XB0;
	output Z0;



XDL2 \$1I31  (.Q0 (\$1N20 ), .D0 (D0), .G (G), 
	.CD (CD));
XBIDI1 \$1I2  (.Z0 (Z0), .XB0 (XB0), .A0 (\$1N20 ), 
	.OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIOL24(
	CD, D0, D1, D2, D3, G, OE, XB0, XB1, XB2, XB3, Z0, Z1, Z2, Z3);


	input CD;
	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	input OE;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	output Z0;
	output Z1;
	output Z2;
	output Z3;



BIOL21 \$1I279  (.Z0 (Z3), .XB0 (XB3), .D0 (D3), 
	.CD (CD), .G (G), .OE (OE));
BIOL21 \$1I278  (.Z0 (Z2), .XB0 (XB2), .D0 (D2), 
	.CD (CD), .G (G), .OE (OE));
BIOL21 \$1I277  (.Z0 (Z1), .XB0 (XB1), .D0 (D1), 
	.CD (CD), .G (G), .OE (OE));
BIOL21 \$1I276  (.Z0 (Z0), .XB0 (XB0), .D0 (D0), 
	.CD (CD), .G (G), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIOL31(
	D0, G, OE, SD, XB0, Z0);


	input D0;
	input G;
	input OE;
	input SD;
	inout XB0;
	output Z0;



XBIDI1 \$1I2  (.Z0 (Z0), .XB0 (XB0), .A0 (\$1N20 ), 
	.OE (OE));
XDL3 \$1I37  (.Q0 (\$1N20 ), .D0 (D0), .G (G), 
	.SD (SD));
endmodule
`timescale 10 ps / 10 ps
module BIOL34(
	D0, D1, D2, D3, G, OE, SD, XB0, XB1, XB2, XB3, Z0, Z1, Z2, Z3);


	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	input OE;
	input SD;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	output Z0;
	output Z1;
	output Z2;
	output Z3;



BIOL31 \$1I279  (.Z0 (Z3), .XB0 (XB3), .D0 (D3), 
	.SD (SD), .G (G), .OE (OE));
BIOL31 \$1I278  (.Z0 (Z2), .XB0 (XB2), .D0 (D2), 
	.SD (SD), .G (G), .OE (OE));
BIOL31 \$1I277  (.Z0 (Z1), .XB0 (XB1), .D0 (D1), 
	.SD (SD), .G (G), .OE (OE));
BIOL31 \$1I276  (.Z0 (Z0), .XB0 (XB0), .D0 (D0), 
	.SD (SD), .G (G), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIOL41(
	CD, D0, G, OE, SD, XB0, Z0);


	input CD;
	input D0;
	input G;
	input OE;
	input SD;
	inout XB0;
	output Z0;



XDL4 \$1I37  (.Q0 (\$1N20 ), .D0 (D0), .G (G), 
	.SD (SD), .CD (CD));
XBIDI1 \$1I2  (.Z0 (Z0), .XB0 (XB0), .A0 (\$1N20 ), 
	.OE (OE));
endmodule
`timescale 10 ps / 10 ps
module BIOL44(
	CD, D0, D1, D2, D3, G, OE, SD, XB0, XB1, XB2, XB3, Z0, Z1, Z2, Z3);


	input CD;
	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	input OE;
	input SD;
	inout XB0;
	inout XB1;
	inout XB2;
	inout XB3;
	output Z0;
	output Z1;
	output Z2;
	output Z3;



BIOL41 \$1I275  (.Z0 (Z3), .XB0 (XB3), .D0 (D3), 
	.CD (CD), .SD (SD), .G (G), 
	.OE (OE));
BIOL41 \$1I274  (.Z0 (Z2), .XB0 (XB2), .D0 (D2), 
	.CD (CD), .SD (SD), .G (G), 
	.OE (OE));
BIOL41 \$1I273  (.Z0 (Z1), .XB0 (XB1), .D0 (D1), 
	.CD (CD), .SD (SD), .G (G), 
	.OE (OE));
BIOL41 \$1I272  (.Z0 (Z0), .XB0 (XB0), .D0 (D0), 
	.CD (CD), .SD (SD), .G (G), 
	.OE (OE));
endmodule
/*
* Translated from EDIF description BUF                                        *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 36  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  BUF lib :  BUF                              *
*/
/*
* Library BUF                                                                 *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell BUF"                                                                  *
*/
`timescale 10 ps / 10 ps
module BUF (Z0, A0);

    input  A0;

    output  Z0;



    buf
        I1  (Z0, A0);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:50 1994
`timescale 10 ps / 10 ps 
module CBD11(
	Q0, CAO, CAI, CLK, 
	CD);

	output Q0;
	output CAO;
	input CAI;
	input CLK;
	input CD;

FD21 \$1I1  (.Q0(\$1N1224 ), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
INV \$1I1121  (.ZN0(\$1N1232 ), .A0(\$1N1224 ));
AND2 \$1I1178  (.Z0(CAO), .A0(\$1N1232 ), .A1(CAI));
BUF \$1I1238  (.Z0(Q0), .A0(\$1N1224 ));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1224 ), .A1(CAI));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:53 1994
`timescale 10 ps / 10 ps 
module CBD12(
	Q0, Q1, CAO, CAI, 
	CLK, CD);

	output Q0;
	output Q1;
	output CAO;
	input CAI;
	input CLK;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
INV \$1I1121  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I1124  (.ZN0(\~QI1 ), .A0(QI1));
AND3 \$1I1178  (.Z0(CAO), .A0(\~QI0 ), .A1(\~QI1 ), .A2(CAI));
AND2 \$1I1199  (.Z0(\$1N365 ), .A0(\~QI0 ), .A1(CAI));
BUF \$1I1233  (.Z0(Q1), .A0(QI1));
BUF \$1I1234  (.Z0(Q0), .A0(QI0));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(QI0), .A1(CAI));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(QI1), .A1(\$1N365 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:55 1994
`timescale 10 ps / 10 ps 
module CBD14(
	Q0, Q1, Q2, Q3, 
	CAO, CAI, CLK, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output CAO;
	input CAI;
	input CLK;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
INV \$1I1121  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I1124  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I1127  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I1130  (.ZN0(\~QI3 ), .A0(QI3));
AND2 \$1I1199  (.Z0(\$1N365 ), .A0(\~QI0 ), .A1(CAI));
AND3 \$1I1200  (.Z0(\$1N419 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(CAI));
AND4 \$1I1201  (.Z0(\$1N473 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(CAI));
AND5 \$1I1221  (.Z0(CAO), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(CAI));
BUF \$1I1233  (.Z0(Q3), .A0(QI3));
BUF \$1I1234  (.Z0(Q2), .A0(QI2));
BUF \$1I1235  (.Z0(Q1), .A0(QI1));
BUF \$1I1236  (.Z0(Q0), .A0(QI0));
FD21 \$1I155  (.Q0(QI2), .D0(\$1N915 ), .CLK(CLK), .CD(CD));
FD21 \$1I175  (.Q0(QI3), .D0(\$1N921 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(QI0), .A1(CAI));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(QI1), .A1(\$1N365 ));
LXOR2 \$1I400  (.Z0(\$1N915 ), .A0(QI2), .A1(\$1N419 ));
LXOR2 \$1I454  (.Z0(\$1N921 ), .A0(QI3), .A1(\$1N473 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:00:58 1994
`timescale 10 ps / 10 ps 
module CBD18(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	CAO, CAI, CLK, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output CAO;
	input CAI;
	input CLK;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
INV \$1I1121  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I1124  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I1127  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I1130  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I1133  (.ZN0(\~QI4 ), .A0(QI4));
INV \$1I1136  (.ZN0(\~QI5 ), .A0(QI5));
INV \$1I1139  (.ZN0(\~QI6 ), .A0(QI6));
INV \$1I1142  (.ZN0(\~QI7 ), .A0(QI7));
AND2 \$1I1199  (.Z0(\$1N365 ), .A0(\~QI0 ), .A1(CAI));
AND3 \$1I1200  (.Z0(\$1N419 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(CAI));
AND4 \$1I1201  (.Z0(\$1N473 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(CAI));
AND5 \$1I1202  (.Z0(\$1N719 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(CAI));
AND6 \$1I1203  (.Z0(\$1N769 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(CAI));
AND7 \$1I1204  (.Z0(\$1N813 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(CAI));
AND8 \$1I1205  (.Z0(\$1N854 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(CAI));
AND9 \$1I1207  (.Z0(CAO), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(CAI));
BUF \$1I1244  (.Z0(Q7), .A0(QI7));
BUF \$1I1253  (.Z0(Q0), .A0(QI0));
BUF \$1I1255  (.Z0(Q6), .A0(QI6));
BUF \$1I1258  (.Z0(Q1), .A0(QI1));
BUF \$1I1260  (.Z0(Q5), .A0(QI5));
BUF \$1I1262  (.Z0(Q2), .A0(QI2));
BUF \$1I1264  (.Z0(Q4), .A0(QI4));
BUF \$1I1266  (.Z0(Q3), .A0(QI3));
FD21 \$1I155  (.Q0(QI2), .D0(\$1N915 ), .CLK(CLK), .CD(CD));
FD21 \$1I175  (.Q0(QI3), .D0(\$1N921 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(QI0), .A1(CAI));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(QI1), .A1(\$1N365 ));
LXOR2 \$1I400  (.Z0(\$1N915 ), .A0(QI2), .A1(\$1N419 ));
LXOR2 \$1I454  (.Z0(\$1N921 ), .A0(QI3), .A1(\$1N473 ));
LXOR2 \$1I721  (.Z0(\$1N924 ), .A0(QI4), .A1(\$1N719 ));
FD21 \$1I723  (.Q0(QI4), .D0(\$1N924 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I771  (.Z0(\$1N929 ), .A0(QI5), .A1(\$1N769 ));
FD21 \$1I773  (.Q0(QI5), .D0(\$1N929 ), .CLK(CLK), .CD(CD));
FD21 \$1I809  (.Q0(QI6), .D0(\$1N930 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I811  (.Z0(\$1N930 ), .A0(QI6), .A1(\$1N813 ));
LXOR2 \$1I856  (.Z0(\$1N935 ), .A0(QI7), .A1(\$1N854 ));
FD21 \$1I858  (.Q0(QI7), .D0(\$1N935 ), .CLK(CLK), .CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:01 1994
`timescale 10 ps / 10 ps 
module CBD21(
	Q0, CAO, CAI, CLK, 
	EN, CD);

	output Q0;
	output CAO;
	input CAI;
	input CLK;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(\$1N1209 ), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
INV \$1I1121  (.ZN0(\~Q0 ), .A0(\$1N1209 ));
AND3 \$1I1178  (.Z0(CAO), .A0(\~Q0 ), .A1(CAI), .A2(EN));
AND2 \$1I1181  (.Z0(\$1N226 ), .A0(CAI), .A1(EN));
BUF \$1I1217  (.Z0(Q0), .A0(\$1N1209 ));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1209 ), .A1(\$1N226 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:03 1994
`timescale 10 ps / 10 ps 
module CBD22(
	Q0, Q1, CAO, CAI, 
	CLK, EN, CD);

	output Q0;
	output Q1;
	output CAO;
	input CAI;
	input CLK;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
INV \$1I1121  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I1124  (.ZN0(\~QI1 ), .A0(QI1));
AND4 \$1I1178  (.Z0(CAO), .A0(\~QI0 ), .A1(\~QI1 ), .A2(CAI), 
	.A3(EN));
AND2 \$1I1181  (.Z0(\$1N226 ), .A0(CAI), .A1(EN));
AND3 \$1I1182  (.Z0(\$1N365 ), .A0(\~QI0 ), .A1(CAI), .A2(EN));
BUF \$1I1218  (.Z0(Q1), .A0(QI1));
BUF \$1I1219  (.Z0(Q0), .A0(QI0));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(QI0), .A1(\$1N226 ));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(QI1), .A1(\$1N365 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:05 1994
`timescale 10 ps / 10 ps 
module CBD24(
	Q0, Q1, Q2, Q3, 
	CAO, CAI, CLK, EN, 
	CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output CAO;
	input CAI;
	input CLK;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
INV \$1I1121  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I1124  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I1127  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I1130  (.ZN0(\~QI3 ), .A0(QI3));
AND2 \$1I1181  (.Z0(\$1N226 ), .A0(CAI), .A1(EN));
AND3 \$1I1182  (.Z0(\$1N365 ), .A0(\~QI0 ), .A1(CAI), .A2(EN));
AND4 \$1I1183  (.Z0(\$1N419 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(CAI), 
	.A3(EN));
AND5 \$1I1185  (.Z0(\$1N473 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(CAI), .A4(EN));
AND6 \$1I1203  (.Z0(CAO), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(CAI), .A5(EN));
BUF \$1I1228  (.Z0(Q3), .A0(QI3));
BUF \$1I1230  (.Z0(Q2), .A0(QI2));
BUF \$1I1232  (.Z0(Q1), .A0(QI1));
BUF \$1I1235  (.Z0(Q0), .A0(QI0));
FD21 \$1I155  (.Q0(QI2), .D0(\$1N915 ), .CLK(CLK), .CD(CD));
FD21 \$1I175  (.Q0(QI3), .D0(\$1N921 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(QI0), .A1(\$1N226 ));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(QI1), .A1(\$1N365 ));
LXOR2 \$1I400  (.Z0(\$1N915 ), .A0(QI2), .A1(\$1N419 ));
LXOR2 \$1I454  (.Z0(\$1N921 ), .A0(QI3), .A1(\$1N473 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:08 1994
`timescale 10 ps / 10 ps 
module CBD28(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	CAO, CAI, CLK, EN, 
	CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output CAO;
	input CAI;
	input CLK;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
INV \$1I1121  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I1124  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I1127  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I1130  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I1133  (.ZN0(\~QI4 ), .A0(QI4));
INV \$1I1136  (.ZN0(\~QI5 ), .A0(QI5));
INV \$1I1139  (.ZN0(\~QI6 ), .A0(QI6));
INV \$1I1142  (.ZN0(\~QI7 ), .A0(QI7));
AND2 \$1I1181  (.Z0(\$1N226 ), .A0(CAI), .A1(EN));
AND3 \$1I1182  (.Z0(\$1N365 ), .A0(\~QI0 ), .A1(CAI), .A2(EN));
AND4 \$1I1183  (.Z0(\$1N419 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(CAI), 
	.A3(EN));
AND5 \$1I1185  (.Z0(\$1N473 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(CAI), .A4(EN));
AND6 \$1I1186  (.Z0(\$1N719 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(CAI), .A5(EN));
AND7 \$1I1187  (.Z0(\$1N769 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(CAI), .A6(EN));
AND8 \$1I1190  (.Z0(\$1N813 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(CAI), 
	.A7(EN));
AND9 \$1I1191  (.Z0(\$1N854 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(CAI), .A8(EN));
AND10 \$1I1196  (.Z0(CAO), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(CAI), .A9(EN));
BUF \$1I1239  (.Z0(Q7), .A0(QI7));
BUF \$1I1241  (.Z0(Q6), .A0(QI6));
BUF \$1I1249  (.Z0(Q5), .A0(QI5));
BUF \$1I1250  (.Z0(Q4), .A0(QI4));
BUF \$1I1251  (.Z0(Q3), .A0(QI3));
BUF \$1I1252  (.Z0(Q2), .A0(QI2));
BUF \$1I1253  (.Z0(Q1), .A0(QI1));
BUF \$1I1255  (.Z0(Q0), .A0(QI0));
FD21 \$1I155  (.Q0(QI2), .D0(\$1N915 ), .CLK(CLK), .CD(CD));
FD21 \$1I175  (.Q0(QI3), .D0(\$1N921 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(QI0), .A1(\$1N226 ));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(QI1), .A1(\$1N365 ));
LXOR2 \$1I400  (.Z0(\$1N915 ), .A0(QI2), .A1(\$1N419 ));
LXOR2 \$1I454  (.Z0(\$1N921 ), .A0(QI3), .A1(\$1N473 ));
LXOR2 \$1I721  (.Z0(\$1N924 ), .A0(QI4), .A1(\$1N719 ));
FD21 \$1I723  (.Q0(QI4), .D0(\$1N924 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I771  (.Z0(\$1N929 ), .A0(QI5), .A1(\$1N769 ));
FD21 \$1I773  (.Q0(QI5), .D0(\$1N929 ), .CLK(CLK), .CD(CD));
FD21 \$1I809  (.Q0(QI6), .D0(\$1N930 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I811  (.Z0(\$1N930 ), .A0(QI6), .A1(\$1N813 ));
LXOR2 \$1I856  (.Z0(\$1N935 ), .A0(QI7), .A1(\$1N854 ));
FD21 \$1I858  (.Q0(QI7), .D0(\$1N935 ), .CLK(CLK), .CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:11 1994
`timescale 10 ps / 10 ps 
module CBD31(
	Q0, CAO, D0, CAI, 
	CLK, PS, LD, EN, 
	CD);

	output Q0;
	output CAO;
	input D0;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(\$1N1215 ), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
AND3 \$1I1031  (.Z0(\$1N1004 ), .A0(\$1N1215 ), .A1(\$1N501 ), .A2(\$1N827 ));
AND2 \$1I1032  (.Z0(\$1N224 ), .A0(D0), .A1(LD));
AND3 \$1I1033  (.Z0(\$1N226 ), .A0(\$1N501 ), .A1(CAI), .A2(EN));
INV \$1I1121  (.ZN0(\$1N1209 ), .A0(\$1N1215 ));
AND3 \$1I1178  (.Z0(CAO), .A0(\$1N1209 ), .A1(EN), .A2(CAI));
INV \$1I1222  (.ZN0(\$1N501 ), .A0(LD));
BUF \$1I1234  (.Z0(Q0), .A0(\$1N1215 ));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N224 ), .A1(\$1N226 ), .A2(PS));
INV \$1I949  (.ZN0(\$1N827 ), .A0(PS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:13 1994
`timescale 10 ps / 10 ps 
module CBD32(
	Q0, Q1, CAO, D0, 
	D1, CAI, CLK, PS, 
	LD, EN, CD);

	output Q0;
	output Q1;
	output CAO;
	input D0;
	input D1;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
AND3 \$1I1031  (.Z0(\$1N1004 ), .A0(QI0), .A1(\$1N501 ), .A2(\$1N827 ));
AND2 \$1I1032  (.Z0(\$1N224 ), .A0(D0), .A1(LD));
AND3 \$1I1033  (.Z0(\$1N226 ), .A0(\$1N501 ), .A1(CAI), .A2(EN));
AND2 \$1I1034  (.Z0(\$1N354 ), .A0(D1), .A1(LD));
AND4 \$1I1081  (.Z0(\$1N1083 ), .A0(\~QI0 ), .A1(CAI), .A2(\$1N501 ), 
	.A3(EN));
OR3 \$1I1082  (.Z0(\$1N365 ), .A0(\$1N354 ), .A1(\$1N1083 ), .A2(PS));
AND3 \$1I1110  (.Z0(\$1N357 ), .A0(QI1), .A1(\$1N501 ), .A2(\$1N827 ));
INV \$1I1121  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I1124  (.ZN0(\~QI1 ), .A0(QI1));
AND4 \$1I1178  (.Z0(CAO), .A0(\~QI0 ), .A1(\~QI1 ), .A2(EN), 
	.A3(CAI));
INV \$1I1236  (.ZN0(\$1N501 ), .A0(LD));
BUF \$1I1239  (.Z0(Q1), .A0(QI1));
BUF \$1I1240  (.Z0(Q0), .A0(QI0));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N224 ), .A1(\$1N226 ), .A2(PS));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(\$1N357 ), .A1(\$1N365 ));
INV \$1I949  (.ZN0(\$1N827 ), .A0(PS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:16 1994
`timescale 10 ps / 10 ps 
module CBD34(
	Q0, Q1, Q2, Q3, 
	CAO, D0, D1, D2, 
	D3, CAI, CLK, PS, 
	LD, EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
AND3 \$1I1031  (.Z0(\$1N1004 ), .A0(QI0), .A1(\$1N501 ), .A2(\$1N827 ));
AND2 \$1I1032  (.Z0(\$1N224 ), .A0(D0), .A1(LD));
AND3 \$1I1033  (.Z0(\$1N226 ), .A0(\$1N501 ), .A1(CAI), .A2(EN));
AND2 \$1I1034  (.Z0(\$1N354 ), .A0(D1), .A1(LD));
AND3 \$1I1037  (.Z0(\$1N398 ), .A0(QI2), .A1(\$1N501 ), .A2(\$1N827 ));
AND2 \$1I1038  (.Z0(\$1N395 ), .A0(D2), .A1(LD));
AND3 \$1I1047  (.Z0(\$1N452 ), .A0(QI3), .A1(\$1N501 ), .A2(\$1N827 ));
AND2 \$1I1048  (.Z0(\$1N450 ), .A0(D3), .A1(LD));
AND4 \$1I1081  (.Z0(\$1N1083 ), .A0(\~QI0 ), .A1(CAI), .A2(\$1N501 ), 
	.A3(EN));
OR3 \$1I1082  (.Z0(\$1N365 ), .A0(\$1N354 ), .A1(\$1N1083 ), .A2(PS));
OR3 \$1I1087  (.Z0(\$1N419 ), .A0(\$1N395 ), .A1(\$1N433 ), .A2(PS));
OR3 \$1I1088  (.Z0(\$1N473 ), .A0(\$1N450 ), .A1(\$1N481 ), .A2(PS));
AND5 \$1I1089  (.Z0(\$1N433 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\$1N501 ), 
	.A3(CAI), .A4(EN));
AND6 \$1I1090  (.Z0(\$1N481 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\$1N501 ), .A4(CAI), .A5(EN));
AND3 \$1I1110  (.Z0(\$1N357 ), .A0(QI1), .A1(\$1N501 ), .A2(\$1N827 ));
INV \$1I1121  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I1124  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I1127  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I1130  (.ZN0(\~QI3 ), .A0(QI3));
AND6 \$1I1213  (.Z0(CAO), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(EN), .A5(CAI));
INV \$1I1225  (.ZN0(\$1N827 ), .A0(PS));
BUF \$1I1258  (.Z0(Q3), .A0(QI3));
BUF \$1I1260  (.Z0(Q2), .A0(QI2));
BUF \$1I1262  (.Z0(Q1), .A0(QI1));
BUF \$1I1264  (.Z0(Q0), .A0(QI0));
FD21 \$1I155  (.Q0(QI2), .D0(\$1N915 ), .CLK(CLK), .CD(CD));
FD21 \$1I175  (.Q0(QI3), .D0(\$1N921 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N224 ), .A1(\$1N226 ), .A2(PS));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(\$1N357 ), .A1(\$1N365 ));
INV \$1I38  (.ZN0(\$1N501 ), .A0(LD));
LXOR2 \$1I400  (.Z0(\$1N915 ), .A0(\$1N398 ), .A1(\$1N419 ));
LXOR2 \$1I454  (.Z0(\$1N921 ), .A0(\$1N452 ), .A1(\$1N473 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:22 1994
`timescale 10 ps / 10 ps 
module CBD38(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	CAO, D0, D1, D2, 
	D3, D4, D5, D6, 
	D7, CAI, CLK, PS, 
	LD, EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
AND3 \$1I1031  (.Z0(\$1N1004 ), .A0(QI0), .A1(\$1N501 ), .A2(\$1N827 ));
AND2 \$1I1032  (.Z0(\$1N224 ), .A0(D0), .A1(LD));
AND3 \$1I1033  (.Z0(\$1N226 ), .A0(\$1N501 ), .A1(CAI), .A2(EN));
AND2 \$1I1034  (.Z0(\$1N354 ), .A0(D1), .A1(LD));
AND3 \$1I1037  (.Z0(\$1N398 ), .A0(QI2), .A1(\$1N501 ), .A2(\$1N827 ));
AND2 \$1I1038  (.Z0(\$1N395 ), .A0(D2), .A1(LD));
AND3 \$1I1047  (.Z0(\$1N452 ), .A0(QI3), .A1(\$1N501 ), .A2(\$1N827 ));
AND2 \$1I1048  (.Z0(\$1N450 ), .A0(D3), .A1(LD));
AND4 \$1I1081  (.Z0(\$1N1083 ), .A0(\~QI0 ), .A1(CAI), .A2(\$1N501 ), 
	.A3(EN));
OR3 \$1I1082  (.Z0(\$1N365 ), .A0(\$1N354 ), .A1(\$1N1083 ), .A2(PS));
OR3 \$1I1087  (.Z0(\$1N419 ), .A0(\$1N395 ), .A1(\$1N433 ), .A2(PS));
OR3 \$1I1088  (.Z0(\$1N473 ), .A0(\$1N450 ), .A1(\$1N481 ), .A2(PS));
AND5 \$1I1089  (.Z0(\$1N433 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\$1N501 ), 
	.A3(CAI), .A4(EN));
AND6 \$1I1090  (.Z0(\$1N481 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\$1N501 ), .A4(CAI), .A5(EN));
AND3 \$1I1110  (.Z0(\$1N357 ), .A0(QI1), .A1(\$1N501 ), .A2(\$1N827 ));
INV \$1I1121  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I1124  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I1127  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I1130  (.ZN0(\~QI3 ), .A0(QI3));
AND10 \$1I1178  (.Z0(CAO), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(CAI), .A9(EN));
INV \$1I1203  (.ZN0(\$1N827 ), .A0(PS));
BUF \$1I1244  (.Z0(Q7), .A0(QI7));
BUF \$1I1246  (.Z0(Q6), .A0(QI6));
BUF \$1I1248  (.Z0(Q5), .A0(QI5));
BUF \$1I1254  (.Z0(Q4), .A0(QI4));
BUF \$1I1256  (.Z0(Q3), .A0(QI3));
BUF \$1I1258  (.Z0(Q2), .A0(QI2));
BUF \$1I1260  (.Z0(Q1), .A0(QI1));
BUF \$1I1261  (.Z0(Q0), .A0(QI0));
FD21 \$1I155  (.Q0(QI2), .D0(\$1N915 ), .CLK(CLK), .CD(CD));
FD21 \$1I175  (.Q0(QI3), .D0(\$1N921 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N224 ), .A1(\$1N226 ), .A2(PS));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(\$1N357 ), .A1(\$1N365 ));
INV \$1I38  (.ZN0(\$1N501 ), .A0(LD));
LXOR2 \$1I400  (.Z0(\$1N915 ), .A0(\$1N398 ), .A1(\$1N419 ));
LXOR2 \$1I454  (.Z0(\$1N921 ), .A0(\$1N452 ), .A1(\$1N473 ));
AND3 \$2I1051  (.Z0(\$2N720 ), .A0(QI4), .A1(\$2N501 ), .A2(\$2N827 ));
AND2 \$2I1057  (.Z0(\$2N724 ), .A0(D4), .A1(LD));
AND3 \$2I1060  (.Z0(\$2N770 ), .A0(QI5), .A1(\$2N501 ), .A2(\$2N827 ));
AND2 \$2I1061  (.Z0(\$2N774 ), .A0(D5), .A1(LD));
AND3 \$2I1069  (.Z0(\$2N812 ), .A0(QI6), .A1(\$2N501 ), .A2(\$2N827 ));
AND2 \$2I1070  (.Z0(\$2N808 ), .A0(D6), .A1(LD));
AND3 \$2I1077  (.Z0(\$2N855 ), .A0(QI7), .A1(\$2N501 ), .A2(\$2N827 ));
AND2 \$2I1078  (.Z0(\$2N859 ), .A0(D7), .A1(LD));
AND7 \$2I1091  (.Z0(\$2N725 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\$2N501 ), .A5(CAI), .A6(EN));
OR3 \$2I1092  (.Z0(\$2N719 ), .A0(\$2N724 ), .A1(\$2N725 ), .A2(PS));
OR3 \$2I1093  (.Z0(\$2N769 ), .A0(\$2N774 ), .A1(\$2N780 ), .A2(PS));
AND8 \$2I1094  (.Z0(\$2N780 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\$2N501 ), .A6(CAI), 
	.A7(EN));
OR3 \$2I1095  (.Z0(\$2N813 ), .A0(\$2N808 ), .A1(\$2N1097 ), .A2(PS));
AND9 \$2I1096  (.Z0(\$2N1097 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\$2N501 ), 
	.A7(CAI), .A8(EN));
AND10 \$2I1099  (.Z0(\$2N1101 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\$2N501 ), .A8(CAI), .A9(EN));
OR3 \$2I1100  (.Z0(\$2N854 ), .A0(\$2N859 ), .A1(\$2N1101 ), .A2(PS));
INV \$2I1133  (.ZN0(\~QI4 ), .A0(QI4));
INV \$2I1136  (.ZN0(\~QI5 ), .A0(QI5));
INV \$2I1139  (.ZN0(\~QI6 ), .A0(QI6));
INV \$2I1142  (.ZN0(\~QI7 ), .A0(QI7));
INV \$2I1205  (.ZN0(\$2N827 ), .A0(PS));
INV \$2I38  (.ZN0(\$2N501 ), .A0(LD));
LXOR2 \$2I721  (.Z0(\$2N924 ), .A0(\$2N720 ), .A1(\$2N719 ));
FD21 \$2I723  (.Q0(QI4), .D0(\$2N924 ), .CLK(CLK), .CD(CD));
LXOR2 \$2I771  (.Z0(\$2N929 ), .A0(\$2N770 ), .A1(\$2N769 ));
FD21 \$2I773  (.Q0(QI5), .D0(\$2N929 ), .CLK(CLK), .CD(CD));
FD21 \$2I809  (.Q0(QI6), .D0(\$2N930 ), .CLK(CLK), .CD(CD));
LXOR2 \$2I811  (.Z0(\$2N930 ), .A0(\$2N812 ), .A1(\$2N813 ));
LXOR2 \$2I856  (.Z0(\$2N935 ), .A0(\$2N855 ), .A1(\$2N854 ));
FD21 \$2I858  (.Q0(QI7), .D0(\$2N935 ), .CLK(CLK), .CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:25 1994
`timescale 10 ps / 10 ps 
module CBD41(
	Q0, CAO, D0, CAI, 
	CLK, PS, LD, EN, 
	CS);

	output Q0;
	output CAO;
	input D0;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CS;

FD11 \$1I1  (.Q0(\$1N1305 ), .D0(\$1N904 ), .CLK(CLK));
INV \$1I1121  (.ZN0(\$1N1276 ), .A0(\$1N1305 ));
AND3 \$1I1178  (.Z0(CAO), .A0(\$1N1276 ), .A1(CAI), .A2(EN));
AND4 \$1I1198  (.Z0(\$1N1004 ), .A0(\$1N1305 ), .A1(\$1N501 ), .A2(\$1N837 ), 
	.A3(\$1N827 ));
AND3 \$1I1200  (.Z0(\$1N1205 ), .A0(D0), .A1(LD), .A2(\$1N837 ));
AND4 \$1I1212  (.Z0(\$1N1213 ), .A0(\$1N501 ), .A1(CAI), .A2(EN), 
	.A3(\$1N837 ));
INV \$1I1314  (.ZN0(\$1N837 ), .A0(CS));
INV \$1I1317  (.ZN0(\$1N501 ), .A0(LD));
BUF \$1I1328  (.Z0(Q0), .A0(\$1N1305 ));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N1205 ), .A1(\$1N1213 ), .A2(PS));
INV \$1I949  (.ZN0(\$1N827 ), .A0(PS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:27 1994
`timescale 10 ps / 10 ps 
module CBD42(
	Q0, Q1, CAO, D0, 
	D1, CAI, CLK, PS, 
	LD, EN, CS);

	output Q0;
	output Q1;
	output CAO;
	input D0;
	input D1;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CS;

FD11 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK));
FD11 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK));
OR3 \$1I1082  (.Z0(\$1N365 ), .A0(\$1N1305 ), .A1(\$1N1233 ), .A2(PS));
INV \$1I1121  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I1124  (.ZN0(\~QI1 ), .A0(QI1));
AND4 \$1I1178  (.Z0(CAO), .A0(\~QI0 ), .A1(\~QI1 ), .A2(CAI), 
	.A3(EN));
AND4 \$1I1198  (.Z0(\$1N1004 ), .A0(QI0), .A1(\$1N501 ), .A2(\$1N837 ), 
	.A3(\$1N827 ));
AND3 \$1I1200  (.Z0(\$1N1303 ), .A0(D0), .A1(LD), .A2(\$1N837 ));
AND4 \$1I1212  (.Z0(\$1N1213 ), .A0(\$1N501 ), .A1(CAI), .A2(EN), 
	.A3(\$1N837 ));
AND4 \$1I1219  (.Z0(\$1N1224 ), .A0(QI1), .A1(\$1N501 ), .A2(\$1N837 ), 
	.A3(\$1N827 ));
AND3 \$1I1222  (.Z0(\$1N1305 ), .A0(D1), .A1(LD), .A2(\$1N837 ));
AND5 \$1I1231  (.Z0(\$1N1233 ), .A0(\~QI0 ), .A1(CAI), .A2(\$1N501 ), 
	.A3(EN), .A4(\$1N837 ));
INV \$1I1315  (.ZN0(\$1N837 ), .A0(CS));
BUF \$1I1330  (.Z0(Q1), .A0(QI1));
BUF \$1I1331  (.Z0(Q0), .A0(QI0));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N1303 ), .A1(\$1N1213 ), .A2(PS));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(\$1N1224 ), .A1(\$1N365 ));
INV \$1I38  (.ZN0(\$1N501 ), .A0(LD));
INV \$1I949  (.ZN0(\$1N827 ), .A0(PS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:31 1994
`timescale 10 ps / 10 ps 
module CBD44(
	Q0, Q1, Q2, Q3, 
	CAO, D0, D1, D2, 
	D3, CAI, CLK, PS, 
	LD, EN, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CS;

FD11 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK));
FD11 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK));
OR3 \$1I1082  (.Z0(\$1N365 ), .A0(\$1N1295 ), .A1(\$1N1233 ), .A2(PS));
OR3 \$1I1087  (.Z0(\$1N419 ), .A0(\$1N1297 ), .A1(\$1N433 ), .A2(PS));
OR3 \$1I1088  (.Z0(\$1N473 ), .A0(\$1N1309 ), .A1(\$1N481 ), .A2(PS));
INV \$1I1121  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I1124  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I1127  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I1130  (.ZN0(\~QI3 ), .A0(QI3));
AND4 \$1I1198  (.Z0(\$1N1004 ), .A0(QI0), .A1(\$1N501 ), .A2(\$1N837 ), 
	.A3(\$1N827 ));
AND3 \$1I1200  (.Z0(\$1N1293 ), .A0(D0), .A1(LD), .A2(\$1N837 ));
AND4 \$1I1212  (.Z0(\$1N1213 ), .A0(\$1N501 ), .A1(CAI), .A2(EN), 
	.A3(\$1N837 ));
AND4 \$1I1219  (.Z0(\$1N1224 ), .A0(QI1), .A1(\$1N501 ), .A2(\$1N837 ), 
	.A3(\$1N827 ));
AND3 \$1I1222  (.Z0(\$1N1295 ), .A0(D1), .A1(LD), .A2(\$1N837 ));
AND5 \$1I1231  (.Z0(\$1N1233 ), .A0(\~QI0 ), .A1(CAI), .A2(\$1N501 ), 
	.A3(EN), .A4(\$1N837 ));
AND3 \$1I1238  (.Z0(\$1N1297 ), .A0(D2), .A1(LD), .A2(\$1N837 ));
AND4 \$1I1239  (.Z0(\$1N398 ), .A0(QI2), .A1(\$1N501 ), .A2(\$1N827 ), 
	.A3(\$1N837 ));
AND6 \$1I1240  (.Z0(\$1N433 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\$1N501 ), 
	.A3(CAI), .A4(EN), .A5(\$1N837 ));
AND4 \$1I1247  (.Z0(\$1N452 ), .A0(QI3), .A1(\$1N501 ), .A2(\$1N827 ), 
	.A3(\$1N837 ));
AND3 \$1I1248  (.Z0(\$1N1309 ), .A0(D3), .A1(LD), .A2(\$1N837 ));
AND7 \$1I1273  (.Z0(\$1N481 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\$1N501 ), .A4(CAI), .A5(EN), .A6(\$1N837 ));
AND6 \$1I1300  (.Z0(CAO), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(CAI), .A5(EN));
INV \$1I1325  (.ZN0(\$1N837 ), .A0(CS));
INV \$1I1328  (.ZN0(\$1N827 ), .A0(PS));
BUF \$1I1347  (.Z0(Q3), .A0(QI3));
BUF \$1I1348  (.Z0(Q2), .A0(QI2));
BUF \$1I1349  (.Z0(Q1), .A0(QI1));
BUF \$1I1350  (.Z0(Q0), .A0(QI0));
FD11 \$1I155  (.Q0(QI2), .D0(\$1N915 ), .CLK(CLK));
FD11 \$1I175  (.Q0(QI3), .D0(\$1N921 ), .CLK(CLK));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N1293 ), .A1(\$1N1213 ), .A2(PS));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(\$1N1224 ), .A1(\$1N365 ));
INV \$1I38  (.ZN0(\$1N501 ), .A0(LD));
LXOR2 \$1I400  (.Z0(\$1N915 ), .A0(\$1N398 ), .A1(\$1N419 ));
LXOR2 \$1I454  (.Z0(\$1N921 ), .A0(\$1N452 ), .A1(\$1N473 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:36 1994
`timescale 10 ps / 10 ps 
module CBD48(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	CAO, D0, D1, D2, 
	D3, D4, D5, D6, 
	D7, CAI, CLK, PS, 
	LD, EN, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CS;

FD11 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK));
FD11 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK));
OR3 \$1I1082  (.Z0(\$1N365 ), .A0(\$1N1295 ), .A1(\$1N1233 ), .A2(PS));
OR3 \$1I1087  (.Z0(\$1N419 ), .A0(\$1N1297 ), .A1(\$1N433 ), .A2(PS));
OR3 \$1I1088  (.Z0(\$1N473 ), .A0(\$1N1309 ), .A1(\$1N481 ), .A2(PS));
INV \$1I1121  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I1124  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I1127  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I1130  (.ZN0(\~QI3 ), .A0(QI3));
AND4 \$1I1198  (.Z0(\$1N1004 ), .A0(QI0), .A1(\$1N501 ), .A2(\$1N837 ), 
	.A3(\$1N827 ));
AND3 \$1I1200  (.Z0(\$1N1293 ), .A0(D0), .A1(LD), .A2(\$1N837 ));
AND4 \$1I1212  (.Z0(\$1N1213 ), .A0(\$1N501 ), .A1(CAI), .A2(EN), 
	.A3(\$1N837 ));
AND4 \$1I1219  (.Z0(\$1N1224 ), .A0(QI1), .A1(\$1N501 ), .A2(\$1N837 ), 
	.A3(\$1N827 ));
AND3 \$1I1222  (.Z0(\$1N1295 ), .A0(D1), .A1(LD), .A2(\$1N837 ));
AND5 \$1I1231  (.Z0(\$1N1233 ), .A0(\~QI0 ), .A1(CAI), .A2(\$1N501 ), 
	.A3(EN), .A4(\$1N837 ));
AND3 \$1I1238  (.Z0(\$1N1297 ), .A0(D2), .A1(LD), .A2(\$1N837 ));
AND4 \$1I1239  (.Z0(\$1N398 ), .A0(QI2), .A1(\$1N501 ), .A2(\$1N827 ), 
	.A3(\$1N837 ));
AND6 \$1I1240  (.Z0(\$1N433 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\$1N501 ), 
	.A3(CAI), .A4(EN), .A5(\$1N837 ));
AND4 \$1I1247  (.Z0(\$1N452 ), .A0(QI3), .A1(\$1N501 ), .A2(\$1N827 ), 
	.A3(\$1N837 ));
AND3 \$1I1248  (.Z0(\$1N1309 ), .A0(D3), .A1(LD), .A2(\$1N837 ));
AND7 \$1I1273  (.Z0(\$1N481 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\$1N501 ), .A4(CAI), .A5(EN), .A6(\$1N837 ));
INV \$1I1325  (.ZN0(\$1N837 ), .A0(CS));
INV \$1I1328  (.ZN0(\$1N827 ), .A0(PS));
AND10 \$1I1355  (.Z0(CAO), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(CAI), .A9(EN));
BUF \$1I1364  (.Z0(Q7), .A0(QI7));
BUF \$1I1365  (.Z0(Q6), .A0(QI6));
BUF \$1I1366  (.Z0(Q5), .A0(QI5));
BUF \$1I1367  (.Z0(Q4), .A0(QI4));
BUF \$1I1368  (.Z0(Q3), .A0(QI3));
BUF \$1I1369  (.Z0(Q2), .A0(QI2));
BUF \$1I1370  (.Z0(Q1), .A0(QI1));
BUF \$1I1371  (.Z0(Q0), .A0(QI0));
FD11 \$1I155  (.Q0(QI2), .D0(\$1N915 ), .CLK(CLK));
FD11 \$1I175  (.Q0(QI3), .D0(\$1N921 ), .CLK(CLK));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N1293 ), .A1(\$1N1213 ), .A2(PS));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(\$1N1224 ), .A1(\$1N365 ));
INV \$1I38  (.ZN0(\$1N501 ), .A0(LD));
LXOR2 \$1I400  (.Z0(\$1N915 ), .A0(\$1N398 ), .A1(\$1N419 ));
LXOR2 \$1I454  (.Z0(\$1N921 ), .A0(\$1N452 ), .A1(\$1N473 ));
OR3 \$2I1092  (.Z0(\$2N719 ), .A0(\$2N724 ), .A1(\$2N725 ), .A2(PS));
OR3 \$2I1093  (.Z0(\$2N769 ), .A0(\$2N774 ), .A1(\$2N780 ), .A2(PS));
OR3 \$2I1095  (.Z0(\$2N813 ), .A0(\$2N808 ), .A1(\$2N1097 ), .A2(PS));
OR3 \$2I1100  (.Z0(\$2N854 ), .A0(\$2N1290 ), .A1(\$2N1101 ), .A2(PS));
INV \$2I1133  (.ZN0(\~QI4 ), .A0(QI4));
INV \$2I1136  (.ZN0(\~QI5 ), .A0(QI5));
INV \$2I1139  (.ZN0(\~QI6 ), .A0(QI6));
INV \$2I1142  (.ZN0(\~QI7 ), .A0(QI7));
AND4 \$2I1251  (.Z0(\$2N720 ), .A0(QI4), .A1(\$2N501 ), .A2(\$2N827 ), 
	.A3(\$2N837 ));
AND3 \$2I1252  (.Z0(\$2N724 ), .A0(D4), .A1(LD), .A2(\$2N837 ));
AND4 \$2I1255  (.Z0(\$2N770 ), .A0(QI5), .A1(\$2N501 ), .A2(\$2N827 ), 
	.A3(\$2N837 ));
AND3 \$2I1256  (.Z0(\$2N774 ), .A0(D5), .A1(LD), .A2(\$2N837 ));
AND4 \$2I1259  (.Z0(\$2N812 ), .A0(QI6), .A1(\$2N501 ), .A2(\$2N827 ), 
	.A3(\$2N837 ));
AND3 \$2I1260  (.Z0(\$2N808 ), .A0(D6), .A1(LD), .A2(\$2N837 ));
AND4 \$2I1263  (.Z0(\$2N855 ), .A0(QI7), .A1(\$2N501 ), .A2(\$2N827 ), 
	.A3(\$2N837 ));
AND3 \$2I1264  (.Z0(\$2N1290 ), .A0(D7), .A1(LD), .A2(\$2N837 ));
AND11 \$2I1268  (.Z0(\$2N1101 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\$2N501 ), .A8(CAI), .A9(EN), .A10(\$2N837 ));
AND10 \$2I1269  (.Z0(\$2N1097 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\$2N501 ), 
	.A7(CAI), .A8(EN), .A9(\$2N837 ));
AND9 \$2I1270  (.Z0(\$2N780 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\$2N501 ), .A6(CAI), 
	.A7(EN), .A8(\$2N837 ));
AND8 \$2I1274  (.Z0(\$2N725 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\$2N501 ), .A5(CAI), .A6(EN), 
	.A7(\$2N837 ));
INV \$2I1296  (.ZN0(\$2N837 ), .A0(CS));
INV \$2I1300  (.ZN0(\$2N827 ), .A0(PS));
INV \$2I38  (.ZN0(\$2N501 ), .A0(LD));
LXOR2 \$2I721  (.Z0(\$2N924 ), .A0(\$2N720 ), .A1(\$2N719 ));
FD11 \$2I723  (.Q0(QI4), .D0(\$2N924 ), .CLK(CLK));
LXOR2 \$2I771  (.Z0(\$2N929 ), .A0(\$2N770 ), .A1(\$2N769 ));
FD11 \$2I773  (.Q0(QI5), .D0(\$2N929 ), .CLK(CLK));
FD11 \$2I809  (.Q0(QI6), .D0(\$2N930 ), .CLK(CLK));
LXOR2 \$2I811  (.Z0(\$2N930 ), .A0(\$2N812 ), .A1(\$2N813 ));
LXOR2 \$2I856  (.Z0(\$2N935 ), .A0(\$2N855 ), .A1(\$2N854 ));
FD11 \$2I858  (.Q0(QI7), .D0(\$2N935 ), .CLK(CLK));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:41 1994
`timescale 10 ps / 10 ps 
module CBD516(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	Q8, Q9, Q10, Q11, 
	Q12, Q13, Q14, Q15, 
	CLK, EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output Q8;
	output Q9;
	output Q10;
	output Q11;
	output Q12;
	output Q13;
	output Q14;
	output Q15;
	input CLK;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N14 ), .CLK(CLK), .CD(CD));
AND4 \$1I101  (.Z0(\$1N94 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(EN));
INV \$1I108  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I112  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I115  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I118  (.ZN0(\~QI3 ), .A0(QI3));
LXOR2 \$1I13  (.Z0(\$1N14 ), .A0(QI0), .A1(EN));
LXOR2 \$1I17  (.Z0(\$1N16 ), .A0(QI1), .A1(\$1N58 ));
LXOR2 \$1I19  (.Z0(\$1N18 ), .A0(QI2), .A1(\$1N66 ));
FD21 \$1I2  (.Q0(QI1), .D0(\$1N16 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I21  (.Z0(\$1N20 ), .A0(QI3), .A1(\$1N94 ));
BUF \$1I215  (.Z0(Q15), .A0(QI15));
BUF \$1I216  (.Z0(Q14), .A0(QI14));
BUF \$1I217  (.Z0(Q13), .A0(QI13));
BUF \$1I218  (.Z0(Q12), .A0(QI12));
BUF \$1I219  (.Z0(Q11), .A0(QI11));
BUF \$1I220  (.Z0(Q10), .A0(QI10));
BUF \$1I221  (.Z0(Q9), .A0(QI9));
BUF \$1I222  (.Z0(Q8), .A0(QI8));
BUF \$1I223  (.Z0(Q7), .A0(QI7));
BUF \$1I224  (.Z0(Q6), .A0(QI6));
BUF \$1I225  (.Z0(Q5), .A0(QI5));
BUF \$1I226  (.Z0(Q4), .A0(QI4));
BUF \$1I227  (.Z0(Q3), .A0(QI3));
BUF \$1I228  (.Z0(Q2), .A0(QI2));
BUF \$1I229  (.Z0(Q1), .A0(QI1));
BUF \$1I230  (.Z0(Q0), .A0(QI0));
FD21 \$1I3  (.Q0(QI2), .D0(\$1N18 ), .CLK(CLK), .CD(CD));
FD21 \$1I4  (.Q0(QI3), .D0(\$1N20 ), .CLK(CLK), .CD(CD));
AND2 \$1I60  (.Z0(\$1N58 ), .A0(\~QI0 ), .A1(EN));
AND3 \$1I81  (.Z0(\$1N66 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(EN));
FD21 \$2I11  (.Q0(QI5), .D0(\$2N10 ), .CLK(CLK), .CD(CD));
FD21 \$2I13  (.Q0(QI6), .D0(\$2N15 ), .CLK(CLK), .CD(CD));
FD21 \$2I14  (.Q0(QI4), .D0(\$2N12 ), .CLK(CLK), .CD(CD));
LXOR2 \$2I37  (.Z0(\$2N4 ), .A0(QI7), .A1(\$2N28 ));
LXOR2 \$2I38  (.Z0(\$2N15 ), .A0(QI6), .A1(\$2N27 ));
LXOR2 \$2I39  (.Z0(\$2N10 ), .A0(QI5), .A1(\$2N26 ));
LXOR2 \$2I40  (.Z0(\$2N12 ), .A0(QI4), .A1(\$2N33 ));
AND5 \$2I42  (.Z0(\$2N33 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(EN));
FD21 \$2I5  (.Q0(QI7), .D0(\$2N4 ), .CLK(CLK), .CD(CD));
AND6 \$2I50  (.Z0(\$2N26 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(EN));
AND7 \$2I55  (.Z0(\$2N27 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(EN));
AND8 \$2I60  (.Z0(\$2N28 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(EN));
INV \$2I78  (.ZN0(\~QI4 ), .A0(QI4));
INV \$2I82  (.ZN0(\~QI5 ), .A0(QI5));
INV \$2I85  (.ZN0(\~QI6 ), .A0(QI6));
INV \$2I88  (.ZN0(\~QI7 ), .A0(QI7));
FD21 \$3I15  (.Q0(QI8), .D0(\$3N30 ), .CLK(CLK), .CD(CD));
FD21 \$3I16  (.Q0(QI10), .D0(\$3N29 ), .CLK(CLK), .CD(CD));
FD21 \$3I17  (.Q0(QI9), .D0(\$3N31 ), .CLK(CLK), .CD(CD));
FD21 \$3I18  (.Q0(QI11), .D0(\$3N34 ), .CLK(CLK), .CD(CD));
LXOR2 \$3I3  (.Z0(\$3N30 ), .A0(QI8), .A1(\$3N2 ));
LXOR2 \$3I4  (.Z0(\$3N31 ), .A0(QI9), .A1(\$3N23 ));
AND9 \$3I44  (.Z0(\$3N2 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(EN));
LXOR2 \$3I5  (.Z0(\$3N29 ), .A0(QI10), .A1(\$3N22 ));
AND10 \$3I50  (.Z0(\$3N23 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(\~QI8 ), .A9(EN));
AND11 \$3I56  (.Z0(\$3N22 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(\~QI8 ), .A9(\~QI9 ), .A10(EN));
LXOR2 \$3I6  (.Z0(\$3N34 ), .A0(QI11), .A1(\$3N21 ));
AND12 \$3I62  (.Z0(\$3N21 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(\~QI8 ), .A9(\~QI9 ), .A10(\~QI10 ), 
	.A11(EN));
INV \$3I71  (.ZN0(\~QI8 ), .A0(QI8));
INV \$3I77  (.ZN0(\~QI9 ), .A0(QI9));
INV \$3I80  (.ZN0(\~QI10 ), .A0(QI10));
INV \$3I83  (.ZN0(\~QI11 ), .A0(QI11));
INV \$4I102  (.ZN0(\~QI14 ), .A0(QI14));
LXOR2 \$4I16  (.Z0(\$4N15 ), .A0(QI14), .A1(\$4N13 ));
FD21 \$4I2  (.Q0(QI15), .D0(\$4N6 ), .CLK(CLK), .CD(CD));
FD21 \$4I20  (.Q0(QI13), .D0(\$4N29 ), .CLK(CLK), .CD(CD));
FD21 \$4I21  (.Q0(QI12), .D0(\$4N30 ), .CLK(CLK), .CD(CD));
LXOR2 \$4I27  (.Z0(\$4N29 ), .A0(QI13), .A1(\$4N34 ));
LXOR2 \$4I28  (.Z0(\$4N30 ), .A0(QI12), .A1(\$4N19 ));
FD21 \$4I36  (.Q0(QI14), .D0(\$4N15 ), .CLK(CLK), .CD(CD));
LXOR2 \$4I4  (.Z0(\$4N6 ), .A0(QI15), .A1(\$4N10 ));
AND12 \$4I44  (.Z0(\$4N55 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(\~QI8 ), .A9(\~QI9 ), .A10(\~QI10 ), 
	.A11(\~QI11 ));
AND2 \$4I53  (.Z0(\$4N19 ), .A0(\$4N55 ), .A1(EN));
AND12 \$4I57  (.Z0(\$4N64 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(\~QI8 ), .A9(\~QI9 ), .A10(\~QI10 ), 
	.A11(\~QI11 ));
AND3 \$4I61  (.Z0(\$4N34 ), .A0(\$4N64 ), .A1(\~QI12 ), .A2(EN));
AND12 \$4I66  (.Z0(\$4N72 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(\~QI8 ), .A9(\~QI9 ), .A10(\~QI10 ), 
	.A11(\~QI11 ));
AND4 \$4I69  (.Z0(\$4N13 ), .A0(\$4N72 ), .A1(\~QI12 ), .A2(\~QI13 ), 
	.A3(EN));
AND16 \$4I84  (.Z0(\$4N10 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(\~QI8 ), .A9(\~QI9 ), .A10(\~QI10 ), 
	.A11(\~QI11 ), .A12(\~QI12 ), .A13(\~QI13 ), .A14(\~QI14 ), 
	.A15(EN));
INV \$4I93  (.ZN0(\~QI12 ), .A0(QI12));
INV \$4I99  (.ZN0(\~QI13 ), .A0(QI13));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:47 1994
`timescale 10 ps / 10 ps 
module CBD616(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	Q8, Q9, Q10, Q11, 
	Q12, Q13, Q14, Q15, 
	CAO, CLK, EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output Q8;
	output Q9;
	output Q10;
	output Q11;
	output Q12;
	output Q13;
	output Q14;
	output Q15;
	output CAO;
	input CLK;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N14 ), .CLK(CLK), .CD(CD));
AND4 \$1I101  (.Z0(\$1N94 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(EN));
INV \$1I108  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I112  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I115  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I118  (.ZN0(\~QI3 ), .A0(QI3));
AND2 \$1I129  (.Z0(CAO), .A0(\$1N131 ), .A1(EN));
LXOR2 \$1I13  (.Z0(\$1N14 ), .A0(QI0), .A1(EN));
AND16 \$1I132  (.Z0(\$1N131 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(\~QI8 ), .A9(\~QI9 ), .A10(\~QI10 ), 
	.A11(\~QI11 ), .A12(\~QI12 ), .A13(\~QI13 ), .A14(\~QI14 ), 
	.A15(\~QI15 ));
LXOR2 \$1I17  (.Z0(\$1N16 ), .A0(QI1), .A1(\$1N58 ));
LXOR2 \$1I19  (.Z0(\$1N18 ), .A0(QI2), .A1(\$1N66 ));
FD21 \$1I2  (.Q0(QI1), .D0(\$1N16 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I21  (.Z0(\$1N20 ), .A0(QI3), .A1(\$1N94 ));
BUF \$1I215  (.Z0(Q15), .A0(QI15));
BUF \$1I216  (.Z0(Q14), .A0(QI14));
BUF \$1I217  (.Z0(Q13), .A0(QI13));
BUF \$1I218  (.Z0(Q12), .A0(QI12));
BUF \$1I219  (.Z0(Q11), .A0(QI11));
BUF \$1I220  (.Z0(Q10), .A0(QI10));
BUF \$1I221  (.Z0(Q9), .A0(QI9));
BUF \$1I222  (.Z0(Q8), .A0(QI8));
BUF \$1I223  (.Z0(Q7), .A0(QI7));
BUF \$1I224  (.Z0(Q6), .A0(QI6));
BUF \$1I225  (.Z0(Q5), .A0(QI5));
BUF \$1I226  (.Z0(Q4), .A0(QI4));
BUF \$1I227  (.Z0(Q3), .A0(QI3));
BUF \$1I228  (.Z0(Q2), .A0(QI2));
BUF \$1I229  (.Z0(Q1), .A0(QI1));
BUF \$1I230  (.Z0(Q0), .A0(QI0));
FD21 \$1I3  (.Q0(QI2), .D0(\$1N18 ), .CLK(CLK), .CD(CD));
FD21 \$1I4  (.Q0(QI3), .D0(\$1N20 ), .CLK(CLK), .CD(CD));
AND2 \$1I60  (.Z0(\$1N58 ), .A0(\~QI0 ), .A1(EN));
AND3 \$1I81  (.Z0(\$1N66 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(EN));
FD21 \$2I11  (.Q0(QI5), .D0(\$2N10 ), .CLK(CLK), .CD(CD));
FD21 \$2I13  (.Q0(QI6), .D0(\$2N15 ), .CLK(CLK), .CD(CD));
FD21 \$2I14  (.Q0(QI4), .D0(\$2N12 ), .CLK(CLK), .CD(CD));
LXOR2 \$2I37  (.Z0(\$2N4 ), .A0(QI7), .A1(\$2N28 ));
LXOR2 \$2I38  (.Z0(\$2N15 ), .A0(QI6), .A1(\$2N27 ));
LXOR2 \$2I39  (.Z0(\$2N10 ), .A0(QI5), .A1(\$2N26 ));
LXOR2 \$2I40  (.Z0(\$2N12 ), .A0(QI4), .A1(\$2N33 ));
AND5 \$2I42  (.Z0(\$2N33 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(EN));
FD21 \$2I5  (.Q0(QI7), .D0(\$2N4 ), .CLK(CLK), .CD(CD));
AND6 \$2I50  (.Z0(\$2N26 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(EN));
AND7 \$2I55  (.Z0(\$2N27 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(EN));
AND8 \$2I60  (.Z0(\$2N28 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(EN));
INV \$2I78  (.ZN0(\~QI4 ), .A0(QI4));
INV \$2I82  (.ZN0(\~QI5 ), .A0(QI5));
INV \$2I85  (.ZN0(\~QI6 ), .A0(QI6));
INV \$2I88  (.ZN0(\~QI7 ), .A0(QI7));
FD21 \$3I15  (.Q0(QI8), .D0(\$3N30 ), .CLK(CLK), .CD(CD));
FD21 \$3I16  (.Q0(QI10), .D0(\$3N29 ), .CLK(CLK), .CD(CD));
FD21 \$3I17  (.Q0(QI9), .D0(\$3N31 ), .CLK(CLK), .CD(CD));
FD21 \$3I18  (.Q0(QI11), .D0(\$3N34 ), .CLK(CLK), .CD(CD));
LXOR2 \$3I3  (.Z0(\$3N30 ), .A0(QI8), .A1(\$3N2 ));
LXOR2 \$3I4  (.Z0(\$3N31 ), .A0(QI9), .A1(\$3N23 ));
AND9 \$3I44  (.Z0(\$3N2 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(EN));
LXOR2 \$3I5  (.Z0(\$3N29 ), .A0(QI10), .A1(\$3N22 ));
AND10 \$3I50  (.Z0(\$3N23 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(\~QI8 ), .A9(EN));
AND11 \$3I56  (.Z0(\$3N22 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(\~QI8 ), .A9(\~QI9 ), .A10(EN));
LXOR2 \$3I6  (.Z0(\$3N34 ), .A0(QI11), .A1(\$3N21 ));
AND12 \$3I62  (.Z0(\$3N21 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(\~QI8 ), .A9(\~QI9 ), .A10(\~QI10 ), 
	.A11(EN));
INV \$3I71  (.ZN0(\~QI8 ), .A0(QI8));
INV \$3I77  (.ZN0(\~QI9 ), .A0(QI9));
INV \$3I80  (.ZN0(\~QI10 ), .A0(QI10));
INV \$3I83  (.ZN0(\~QI11 ), .A0(QI11));
INV \$4I102  (.ZN0(\~QI14 ), .A0(QI14));
LXOR2 \$4I16  (.Z0(\$4N15 ), .A0(QI14), .A1(\$4N13 ));
INV \$4I163  (.ZN0(\~QI15 ), .A0(QI15));
FD21 \$4I2  (.Q0(QI15), .D0(\$4N6 ), .CLK(CLK), .CD(CD));
FD21 \$4I20  (.Q0(QI13), .D0(\$4N29 ), .CLK(CLK), .CD(CD));
FD21 \$4I21  (.Q0(QI12), .D0(\$4N30 ), .CLK(CLK), .CD(CD));
LXOR2 \$4I27  (.Z0(\$4N29 ), .A0(QI13), .A1(\$4N34 ));
LXOR2 \$4I28  (.Z0(\$4N30 ), .A0(QI12), .A1(\$4N19 ));
FD21 \$4I36  (.Q0(QI14), .D0(\$4N15 ), .CLK(CLK), .CD(CD));
LXOR2 \$4I4  (.Z0(\$4N6 ), .A0(QI15), .A1(\$4N10 ));
AND12 \$4I44  (.Z0(\$4N55 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(\~QI8 ), .A9(\~QI9 ), .A10(\~QI10 ), 
	.A11(\~QI11 ));
AND2 \$4I53  (.Z0(\$4N19 ), .A0(\$4N55 ), .A1(EN));
AND12 \$4I57  (.Z0(\$4N64 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(\~QI8 ), .A9(\~QI9 ), .A10(\~QI10 ), 
	.A11(\~QI11 ));
AND3 \$4I61  (.Z0(\$4N34 ), .A0(\$4N64 ), .A1(\~QI12 ), .A2(EN));
AND12 \$4I66  (.Z0(\$4N72 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(\~QI8 ), .A9(\~QI9 ), .A10(\~QI10 ), 
	.A11(\~QI11 ));
AND4 \$4I69  (.Z0(\$4N13 ), .A0(\$4N72 ), .A1(\~QI12 ), .A2(\~QI13 ), 
	.A3(EN));
AND16 \$4I84  (.Z0(\$4N10 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(\~QI8 ), .A9(\~QI9 ), .A10(\~QI10 ), 
	.A11(\~QI11 ), .A12(\~QI12 ), .A13(\~QI13 ), .A14(\~QI14 ), 
	.A15(EN));
INV \$4I93  (.ZN0(\~QI12 ), .A0(QI12));
INV \$4I99  (.ZN0(\~QI13 ), .A0(QI13));
endmodule
`timescale 10 ps / 10 ps
module CBD84(
	CAI, CAO, CLK, EN, SD, Q0, Q1, Q2, Q3);


	input CAI;
	output CAO;
	input CLK;
	input EN;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



FDC1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD));
BUF \$1I1163  (.Z0 (Q3), .A0 (QI3));
AND5 \$1I1136  (.Z0 (\$1N473 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (CAI), .A4 (EN));
AND3 \$1I1134  (.Z0 (\$1N365 ), .A0 (\~QI0 ), .A1 (CAI), 
	.A2 (EN));
AND4 \$1I1135  (.Z0 (\$1N419 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (CAI), .A3 (EN));
AND2 \$1I1133  (.Z0 (\$1N226 ), .A0 (CAI), .A1 (EN));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (QI0), .A1 (\$1N226 ));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (QI1), .A1 (\$1N365 ));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (QI2), .A1 (\$1N419 ));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (QI3), .A1 (\$1N473 ));
AND6 \$1I1144  (.Z0 (CAO), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (CAI), 
	.A5 (EN));
BUF \$1I1166  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1164  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1165  (.Z0 (Q0), .A0 (QI0));
FDC1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD));
INV \$1I1203  (.ZN0 (\~QI1 ), .A0 (QI1));
INV \$1I1204  (.ZN0 (\~QI2 ), .A0 (QI2));
INV \$1I1205  (.ZN0 (\~QI3 ), .A0 (QI3));
INV \$1I1202  (.ZN0 (\~QI0 ), .A0 (QI0));
endmodule
`timescale 10 ps / 10 ps
module CBD88(
	CAI, CAO, CLK, EN, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CAI;
	output CAO;
	input CLK;
	input EN;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



FDC1 \$1I858  (.Q0 (QI7), .D0 (\$1N935 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I809  (.Q0 (QI6), .D0 (\$1N930 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I723  (.Q0 (QI4), .D0 (\$1N924 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I773  (.Q0 (QI5), .D0 (\$1N929 ), .CLK (CLK), 
	.SD (SD));
LXOR2 \$1I856  (.Z0 (\$1N935 ), .A0 (QI7), .A1 (\$1N854 ));
LXOR2 \$1I811  (.Z0 (\$1N930 ), .A0 (QI6), .A1 (\$1N813 ));
LXOR2 \$1I771  (.Z0 (\$1N929 ), .A0 (QI5), .A1 (\$1N769 ));
LXOR2 \$1I721  (.Z0 (\$1N924 ), .A0 (QI4), .A1 (\$1N719 ));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (QI3), .A1 (\$1N473 ));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (QI2), .A1 (\$1N419 ));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (QI1), .A1 (\$1N365 ));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (QI0), .A1 (\$1N226 ));
AND3 \$1I1134  (.Z0 (\$1N365 ), .A0 (\~QI0 ), .A1 (CAI), 
	.A2 (EN));
AND4 \$1I1135  (.Z0 (\$1N419 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (CAI), .A3 (EN));
AND5 \$1I1136  (.Z0 (\$1N473 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (CAI), .A4 (EN));
AND6 \$1I1137  (.Z0 (\$1N719 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (CAI), 
	.A5 (EN));
AND7 \$1I1138  (.Z0 (\$1N769 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (CAI), .A6 (EN));
AND8 \$1I1139  (.Z0 (\$1N813 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (CAI), .A7 (EN));
AND9 \$1I1140  (.Z0 (\$1N854 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (CAI), 
	.A8 (EN));
AND10 \$1I1120  (.Z0 (CAO), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\~QI7 ), 
	.A8 (CAI), .A9 (EN));
AND2 \$1I1133  (.Z0 (\$1N226 ), .A0 (CAI), .A1 (EN));
BUF \$1I1224  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1232  (.Z0 (Q3), .A0 (QI3));
BUF \$1I1228  (.Z0 (Q4), .A0 (QI4));
BUF \$1I1220  (.Z0 (Q5), .A0 (QI5));
BUF \$1I1194  (.Z0 (Q6), .A0 (QI6));
BUF \$1I1190  (.Z0 (Q7), .A0 (QI7));
BUF \$1I1211  (.Z0 (Q0), .A0 (QI0));
BUF \$1I1215  (.Z0 (Q1), .A0 (QI1));
FDC1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD));
INV \$1I1288  (.ZN0 (\~QI0 ), .A0 (QI0));
INV \$1I1292  (.ZN0 (\~QI1 ), .A0 (QI1));
INV \$1I1293  (.ZN0 (\~QI2 ), .A0 (QI2));
INV \$1I1294  (.ZN0 (\~QI3 ), .A0 (QI3));
INV \$1I1295  (.ZN0 (\~QI4 ), .A0 (QI4));
INV \$1I1296  (.ZN0 (\~QI5 ), .A0 (QI5));
INV \$1I1297  (.ZN0 (\~QI6 ), .A0 (QI6));
INV \$1I1298  (.ZN0 (\~QI7 ), .A0 (QI7));
endmodule
`timescale 10 ps / 10 ps
module CBD94(
	CAI, CAO, CD, CLK, EN, SD, Q0, Q1, Q2, Q3);


	input CAI;
	output CAO;
	input CD;
	input CLK;
	input EN;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



FDE1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
BUF \$1I1163  (.Z0 (Q3), .A0 (QI3));
AND5 \$1I1136  (.Z0 (\$1N473 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (CAI), .A4 (EN));
AND3 \$1I1134  (.Z0 (\$1N365 ), .A0 (\~QI0 ), .A1 (CAI), 
	.A2 (EN));
AND4 \$1I1135  (.Z0 (\$1N419 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (CAI), .A3 (EN));
AND2 \$1I1133  (.Z0 (\$1N226 ), .A0 (CAI), .A1 (EN));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (QI0), .A1 (\$1N226 ));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (QI1), .A1 (\$1N365 ));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (QI2), .A1 (\$1N419 ));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (QI3), .A1 (\$1N473 ));
AND6 \$1I1144  (.Z0 (CAO), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (CAI), 
	.A5 (EN));
BUF \$1I1166  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1164  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1165  (.Z0 (Q0), .A0 (QI0));
INV \$1I1201  (.ZN0 (\~QI0 ), .A0 (QI0));
INV \$1I1202  (.ZN0 (\~QI1 ), .A0 (QI1));
INV \$1I1203  (.ZN0 (\~QI2 ), .A0 (QI2));
INV \$1I1204  (.ZN0 (\~QI3 ), .A0 (QI3));
endmodule
`timescale 10 ps / 10 ps
module CBD98(
	CAI, CAO, CD, CLK, EN, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CAI;
	output CAO;
	input CD;
	input CLK;
	input EN;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



FDE1 \$1I858  (.Q0 (QI7), .D0 (\$1N935 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I809  (.Q0 (QI6), .D0 (\$1N930 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I723  (.Q0 (QI4), .D0 (\$1N924 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I773  (.Q0 (QI5), .D0 (\$1N929 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
LXOR2 \$1I856  (.Z0 (\$1N935 ), .A0 (QI7), .A1 (\$1N854 ));
LXOR2 \$1I811  (.Z0 (\$1N930 ), .A0 (QI6), .A1 (\$1N813 ));
LXOR2 \$1I771  (.Z0 (\$1N929 ), .A0 (QI5), .A1 (\$1N769 ));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (QI3), .A1 (\$1N473 ));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (QI2), .A1 (\$1N419 ));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (QI1), .A1 (\$1N365 ));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (QI0), .A1 (\$1N226 ));
AND3 \$1I1134  (.Z0 (\$1N365 ), .A0 (\~QI0 ), .A1 (CAI), 
	.A2 (EN));
AND4 \$1I1135  (.Z0 (\$1N419 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (CAI), .A3 (EN));
AND6 \$1I1137  (.Z0 (\$1N719 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (CAI), 
	.A5 (EN));
AND7 \$1I1138  (.Z0 (\$1N769 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (CAI), .A6 (EN));
AND8 \$1I1139  (.Z0 (\$1N813 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (CAI), .A7 (EN));
AND2 \$1I1133  (.Z0 (\$1N226 ), .A0 (CAI), .A1 (EN));
BUF \$1I1224  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1232  (.Z0 (Q3), .A0 (QI3));
BUF \$1I1228  (.Z0 (Q4), .A0 (QI4));
BUF \$1I1220  (.Z0 (Q5), .A0 (QI5));
BUF \$1I1194  (.Z0 (Q6), .A0 (QI6));
BUF \$1I1190  (.Z0 (Q7), .A0 (QI7));
BUF \$1I1211  (.Z0 (Q0), .A0 (QI0));
BUF \$1I1215  (.Z0 (Q1), .A0 (QI1));
FDE1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND5 \$1I1136  (.Z0 (\$1N473 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (CAI), .A4 (EN));
LXOR2 \$1I721  (.Z0 (\$1N924 ), .A0 (QI4), .A1 (\$1N719 ));
FDE1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND10 \$1I1120  (.Z0 (CAO), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\~QI7 ), 
	.A8 (CAI), .A9 (EN));
AND9 \$1I1140  (.Z0 (\$1N854 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (CAI), 
	.A8 (EN));
INV \$1I1307  (.ZN0 (\~QI0 ), .A0 (QI0));
INV \$1I1308  (.ZN0 (\~QI1 ), .A0 (QI1));
INV \$1I1309  (.ZN0 (\~QI2 ), .A0 (QI2));
INV \$1I1311  (.ZN0 (\~QI4 ), .A0 (QI4));
INV \$1I1312  (.ZN0 (\~QI5 ), .A0 (QI5));
INV \$1I1313  (.ZN0 (\~QI6 ), .A0 (QI6));
INV \$1I1314  (.ZN0 (\~QI7 ), .A0 (QI7));
INV \$1I1310  (.ZN0 (\~QI3 ), .A0 (QI3));
endmodule
`timescale 10 ps / 10 ps
module CBDA16(
	CAI, CAO, CD, CLK, D0, D1, D10, D11, D12, D13, D14, D15, D2, D3, D4, D5, D6, D7, D8, D9, EN, LD, SD, Q0, Q1, Q10, Q11, Q12, Q13, Q14, Q15, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9);


	input CAI;
	output CAO;
	input CD;
	input CLK;
	input D0;
	input D1;
	input D10;
	input D11;
	input D12;
	input D13;
	input D14;
	input D15;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input D8;
	input D9;
	input EN;
	input LD;
	input SD;
	output Q0;
	output Q1;
	output Q10;
	output Q11;
	output Q12;
	output Q13;
	output Q14;
	output Q15;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output Q8;
	output Q9;



FDE1 \$1I1396  (.Q0 (QI4), .D0 (\$1N1391 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND2 \$1I1399  (.Z0 (\$1N1390 ), .A0 (D4), .A1 (LD));
BUF \$1I1275  (.Z0 (Q13), .A0 (QI13));
BUF \$1I1271  (.Z0 (Q14), .A0 (QI14));
BUF \$1I1261  (.Z0 (Q15), .A0 (QI15));
BUF \$1I1277  (.Z0 (Q12), .A0 (QI12));
BUF \$1I1262  (.Z0 (Q11), .A0 (QI11));
BUF \$1I1305  (.Z0 (Q10), .A0 (QI10));
BUF \$1I1265  (.Z0 (Q9), .A0 (QI9));
BUF \$1I1267  (.Z0 (Q8), .A0 (QI8));
BUF \$1I1281  (.Z0 (Q7), .A0 (QI7));
BUF \$1I1304  (.Z0 (Q5), .A0 (QI5));
BUF \$1I1289  (.Z0 (Q6), .A0 (QI6));
BUF \$1I1300  (.Z0 (Q0), .A0 (QI0));
BUF \$1I1299  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1285  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1296  (.Z0 (Q3), .A0 (QI3));
INV \$1I38  (.ZN0 (\$1N501 ), .A0 (LD));
AND6 \$1I1090  (.Z0 (\$1N481 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\$1N501 ), .A4 (CAI), 
	.A5 (EN));
AND2 \$1I1048  (.Z0 (\$1N450 ), .A0 (D3), .A1 (LD));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (\$1N452 ), .A1 (\$1N473 ));
AND2 \$1I1038  (.Z0 (\$1N395 ), .A0 (D2), .A1 (LD));
AND5 \$1I1089  (.Z0 (\$1N433 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\$1N501 ), .A3 (CAI), .A4 (EN));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (\$1N398 ), .A1 (\$1N419 ));
OR2 \$1I1258  (.Z0 (\$1N312 ), .A0 (\$1N224 ), .A1 (\$1N226 ));
OR2 \$1I1375  (.Z0 (\$1N365 ), .A0 (\$1N354 ), .A1 (\$1N1083 ));
AND2 \$1I1034  (.Z0 (\$1N354 ), .A0 (D1), .A1 (LD));
AND4 \$1I1081  (.Z0 (\$1N1083 ), .A0 (\~QI0 ), .A1 (CAI), 
	.A2 (\$1N501 ), .A3 (EN));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (\$1N357 ), .A1 (\$1N365 ));
AND3 \$1I1033  (.Z0 (\$1N226 ), .A0 (\$1N501 ), .A1 (CAI), 
	.A2 (EN));
AND2 \$1I1032  (.Z0 (\$1N224 ), .A0 (D0), .A1 (LD));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (\$1N1004 ), .A1 (\$1N312 ));
AND2 \$1I1257  (.Z0 (\$1N1004 ), .A0 (QI0), .A1 (\$1N501 ));
BUF \$1I1294  (.Z0 (Q4), .A0 (QI4));
AND2 \$1I1374  (.Z0 (\$1N357 ), .A0 (QI1), .A1 (\$1N501 ));
AND2 \$1I1376  (.Z0 (\$1N398 ), .A0 (QI2), .A1 (\$1N501 ));
OR2 \$1I1377  (.Z0 (\$1N419 ), .A0 (\$1N395 ), .A1 (\$1N433 ));
AND2 \$1I1378  (.Z0 (\$1N452 ), .A0 (QI3), .A1 (\$1N501 ));
OR2 \$1I1379  (.Z0 (\$1N473 ), .A0 (\$1N450 ), .A1 (\$1N481 ));
AND7 \$1I1408  (.Z0 (\$1N1392 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\$1N501 ), 
	.A5 (CAI), .A6 (EN));
LXOR2 \$1I1395  (.Z0 (\$1N1391 ), .A0 (\$1N1394 ), .A1 (\$1N1400 ));
AND2 \$1I1389  (.Z0 (\$1N1394 ), .A0 (QI4), .A1 (\$1N501 ));
OR2 \$1I1388  (.Z0 (\$1N1400 ), .A0 (\$1N1390 ), .A1 (\$1N1392 ));
FDE1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND18 \$1I1255  (.Z0 (CAO), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\~QI7 ), 
	.A8 (\~QI8 ), .A9 (\~QI9 ), .A10 (\~QI10 ), 
	.A11 (\~QI11 ), .A12 (\~QI12 ), .A13 (\~QI13 ), 
	.A14 (\~QI14 ), .A15 (\~QI15 ), .A16 (CAI), 
	.A17 (EN));
FDE1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
INV \$1I1457  (.ZN0 (\~QI3 ), .A0 (QI3));
INV \$1I1456  (.ZN0 (\~QI2 ), .A0 (QI2));
INV \$1I1454  (.ZN0 (\~QI0 ), .A0 (QI0));
INV \$1I1455  (.ZN0 (\~QI1 ), .A0 (QI1));
INV \$1I1458  (.ZN0 (\~QI4 ), .A0 (QI4));
INV \$2I193  (.ZN0 (\~QI7 ), .A0 (QI7));
INV \$2I191  (.ZN0 (\~QI5 ), .A0 (QI5));
FDE1 \$2I44  (.Q0 (QI7), .D0 (\$2N30 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$2I46  (.Q0 (QI6), .D0 (\$2N7 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$2I170  (.Q0 (QI8), .D0 (\$2N159 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$2I47  (.Q0 (QI5), .D0 (\$2N36 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND10 \$2I1  (.Z0 (\$2N2 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\$2N4 ), 
	.A8 (CAI), .A9 (EN));
LXOR2 \$2I71  (.Z0 (\$2N36 ), .A0 (\$2N35 ), .A1 (\$2N72 ));
AND2 \$2I66  (.Z0 (\$2N31 ), .A0 (D7), .A1 (LD));
LXOR2 \$2I63  (.Z0 (\$2N30 ), .A0 (\$2N29 ), .A1 (\$2N64 ));
AND2 \$2I6  (.Z0 (\$2N10 ), .A0 (D6), .A1 (LD));
AND9 \$2I9  (.Z0 (\$2N70 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\$2N4 ), .A7 (CAI), 
	.A8 (EN));
LXOR2 \$2I67  (.Z0 (\$2N7 ), .A0 (\$2N8 ), .A1 (\$2N68 ));
AND2 \$2I34  (.Z0 (\$2N28 ), .A0 (D5), .A1 (LD));
AND8 \$2I27  (.Z0 (\$2N74 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\$2N4 ), .A6 (CAI), .A7 (EN));
INV \$2I100  (.ZN0 (\$2N4 ), .A0 (LD));
AND2 \$2I143  (.Z0 (\$2N35 ), .A0 (QI5), .A1 (\$2N4 ));
OR2 \$2I144  (.Z0 (\$2N72 ), .A0 (\$2N28 ), .A1 (\$2N74 ));
AND2 \$2I145  (.Z0 (\$2N8 ), .A0 (QI6), .A1 (\$2N4 ));
OR2 \$2I146  (.Z0 (\$2N68 ), .A0 (\$2N10 ), .A1 (\$2N70 ));
AND2 \$2I147  (.Z0 (\$2N29 ), .A0 (QI7), .A1 (\$2N4 ));
OR2 \$2I148  (.Z0 (\$2N64 ), .A0 (\$2N31 ), .A1 (\$2N2 ));
AND11 \$2I172  (.Z0 (\$2N171 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\~QI7 ), 
	.A8 (\$2N4 ), .A9 (CAI), .A10 (EN));
AND2 \$2I165  (.Z0 (\$2N158 ), .A0 (D8), .A1 (LD));
LXOR2 \$2I162  (.Z0 (\$2N159 ), .A0 (\$2N161 ), .A1 (\$2N166 ));
AND2 \$2I157  (.Z0 (\$2N161 ), .A0 (QI8), .A1 (\$2N4 ));
OR2 \$2I156  (.Z0 (\$2N166 ), .A0 (\$2N158 ), .A1 (\$2N171 ));
INV \$2I194  (.ZN0 (\~QI8 ), .A0 (QI8));
INV \$2I192  (.ZN0 (\~QI6 ), .A0 (QI6));
INV \$3I183  (.ZN0 (\~QI10 ), .A0 (QI10));
FDE1 \$3I47  (.Q0 (QI9), .D0 (\$3N36 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$3I44  (.Q0 (QI11), .D0 (\$3N30 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND12 \$3I154  (.Z0 (\$3N74 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\~QI7 ), 
	.A8 (\~QI8 ), .A9 (\$3N4 ), .A10 (CAI), 
	.A11 (EN));
AND2 \$3I145  (.Z0 (\$3N8 ), .A0 (QI10), .A1 (\$3N4 ));
LXOR2 \$3I71  (.Z0 (\$3N36 ), .A0 (\$3N35 ), .A1 (\$3N72 ));
AND2 \$3I143  (.Z0 (\$3N35 ), .A0 (QI9), .A1 (\$3N4 ));
AND2 \$3I66  (.Z0 (\$3N31 ), .A0 (D11), .A1 (LD));
AND2 \$3I6  (.Z0 (\$3N10 ), .A0 (D10), .A1 (LD));
LXOR2 \$3I67  (.Z0 (\$3N7 ), .A0 (\$3N8 ), .A1 (\$3N68 ));
AND2 \$3I34  (.Z0 (\$3N28 ), .A0 (D9), .A1 (LD));
INV \$3I100  (.ZN0 (\$3N4 ), .A0 (LD));
OR2 \$3I144  (.Z0 (\$3N72 ), .A0 (\$3N28 ), .A1 (\$3N74 ));
OR2 \$3I146  (.Z0 (\$3N68 ), .A0 (\$3N10 ), .A1 (\$3N70 ));
OR2 \$3I148  (.Z0 (\$3N64 ), .A0 (\$3N31 ), .A1 (\$3N2 ));
AND2 \$3I147  (.Z0 (\$3N29 ), .A0 (QI11), .A1 (\$3N4 ));
LXOR2 \$3I63  (.Z0 (\$3N30 ), .A0 (\$3N29 ), .A1 (\$3N64 ));
AND13 \$3I160  (.Z0 (\$3N70 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\~QI7 ), 
	.A8 (\~QI8 ), .A9 (\~QI9 ), .A10 (\$3N4 ), 
	.A11 (CAI), .A12 (EN));
AND14 \$3I166  (.Z0 (\$3N2 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\~QI7 ), 
	.A8 (\~QI8 ), .A9 (\~QI9 ), .A10 (\~QI10 ), 
	.A11 (\$3N4 ), .A12 (CAI), .A13 (EN));
FDE1 \$3I46  (.Q0 (QI10), .D0 (\$3N7 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
INV \$3I182  (.ZN0 (\~QI9 ), .A0 (QI9));
INV \$3I184  (.ZN0 (\~QI11 ), .A0 (QI11));
INV \$4I192  (.ZN0 (\~QI12 ), .A0 (QI12));
FDE1 \$4I47  (.Q0 (QI13), .D0 (\$4N36 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$4I48  (.Q0 (QI12), .D0 (\$4N40 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
LXOR2 \$4I71  (.Z0 (\$4N36 ), .A0 (\$4N35 ), .A1 (\$4N72 ));
AND2 \$4I143  (.Z0 (\$4N35 ), .A0 (QI13), .A1 (\$4N184 ));
AND2 \$4I34  (.Z0 (\$4N28 ), .A0 (D13), .A1 (LD));
AND2 \$4I37  (.Z0 (\$4N38 ), .A0 (D12), .A1 (LD));
LXOR2 \$4I75  (.Z0 (\$4N40 ), .A0 (\$4N39 ), .A1 (\$4N76 ));
INV \$4I100  (.ZN0 (\$4N184 ), .A0 (LD));
AND2 \$4I140  (.Z0 (\$4N39 ), .A0 (QI12), .A1 (\$4N184 ));
OR2 \$4I141  (.Z0 (\$4N76 ), .A0 (\$4N38 ), .A1 (\$4N78 ));
AND15 \$4I171  (.Z0 (\$4N78 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\~QI7 ), 
	.A8 (\~QI8 ), .A9 (\~QI9 ), .A10 (\~QI10 ), 
	.A11 (\~QI11 ), .A12 (\$4N184 ), .A13 (CAI), 
	.A14 (EN));
OR2 \$4I144  (.Z0 (\$4N72 ), .A0 (\$4N28 ), .A1 (\$4N74 ));
AND16 \$4I176  (.Z0 (\$4N74 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\~QI7 ), 
	.A8 (\~QI8 ), .A9 (\~QI9 ), .A10 (\~QI10 ), 
	.A11 (\~QI11 ), .A12 (\~QI12 ), .A13 (\$4N184 ), 
	.A14 (CAI), .A15 (EN));
INV \$4I193  (.ZN0 (\~QI13 ), .A0 (QI13));
INV \$5I208  (.ZN0 (\~QI15 ), .A0 (QI15));
FDE1 \$5I46  (.Q0 (QI14), .D0 (\$5N7 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$5I44  (.Q0 (QI15), .D0 (\$5N30 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND18 \$5I192  (.Z0 (\$5N2 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\~QI7 ), 
	.A8 (\~QI8 ), .A9 (\~QI9 ), .A10 (\~QI10 ), 
	.A11 (\~QI11 ), .A12 (\~QI12 ), .A13 (\~QI13 ), 
	.A14 (\~QI14 ), .A15 (\$5N4 ), .A16 (CAI), 
	.A17 (EN));
LXOR2 \$5I67  (.Z0 (\$5N7 ), .A0 (\$5N8 ), .A1 (\$5N68 ));
AND2 \$5I145  (.Z0 (\$5N8 ), .A0 (QI14), .A1 (\$5N4 ));
AND2 \$5I6  (.Z0 (\$5N10 ), .A0 (D14), .A1 (LD));
INV \$5I100  (.ZN0 (\$5N4 ), .A0 (LD));
OR2 \$5I146  (.Z0 (\$5N68 ), .A0 (\$5N10 ), .A1 (\$5N70 ));
OR2 \$5I148  (.Z0 (\$5N64 ), .A0 (\$5N31 ), .A1 (\$5N2 ));
LXOR2 \$5I63  (.Z0 (\$5N30 ), .A0 (\$5N29 ), .A1 (\$5N64 ));
AND2 \$5I66  (.Z0 (\$5N31 ), .A0 (D15), .A1 (LD));
AND2 \$5I147  (.Z0 (\$5N29 ), .A0 (QI15), .A1 (\$5N4 ));
AND17 \$5I186  (.Z0 (\$5N70 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\~QI7 ), 
	.A8 (\~QI8 ), .A9 (\~QI9 ), .A10 (\~QI10 ), 
	.A11 (\~QI11 ), .A12 (\~QI12 ), .A13 (\~QI13 ), 
	.A14 (\$5N4 ), .A15 (CAI), .A16 (EN));
INV \$5I207  (.ZN0 (\~QI14 ), .A0 (QI14));
endmodule
`timescale 10 ps / 10 ps
module CBDA4(
	CAI, CAO, CD, CLK, D0, D1, D2, D3, EN, LD, SD, Q0, Q1, Q2, Q3);


	input CAI;
	output CAO;
	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input LD;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



INV \$1I1199  (.ZN0 (\~QI3 ), .A0 (QI3));
INV \$1I1198  (.ZN0 (\~QI2 ), .A0 (QI2));
INV \$1I1197  (.ZN0 (\~QI1 ), .A0 (QI1));
INV \$1I1196  (.ZN0 (\~QI0 ), .A0 (QI0));
AND3 \$1I1179  (.Z0 (\$1N226 ), .A0 (\$1N501 ), .A1 (CAI), 
	.A2 (EN));
FDE1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
BUF \$1I1166  (.Z0 (Q0), .A0 (QI0));
BUF \$1I1162  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1158  (.Z0 (Q2), .A0 (QI2));
AND6 \$1I1120  (.Z0 (CAO), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (CAI), 
	.A5 (EN));
BUF \$1I1154  (.Z0 (Q3), .A0 (QI3));
AND2 \$1I1032  (.Z0 (\$1N224 ), .A0 (D0), .A1 (LD));
AND2 \$1I1034  (.Z0 (\$1N354 ), .A0 (D1), .A1 (LD));
AND2 \$1I1048  (.Z0 (\$1N450 ), .A0 (D3), .A1 (LD));
INV \$1I38  (.ZN0 (\$1N501 ), .A0 (LD));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (\$1N1004 ), .A1 (\$1N312 ));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (\$1N398 ), .A1 (\$1N419 ));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (\$1N452 ), .A1 (\$1N473 ));
OR2 \$1I1082  (.Z0 (\$1N365 ), .A0 (\$1N354 ), .A1 (\$1N1083 ));
OR2 \$1I1087  (.Z0 (\$1N419 ), .A0 (\$1N395 ), .A1 (\$1N433 ));
OR2 \$1I1088  (.Z0 (\$1N473 ), .A0 (\$1N450 ), .A1 (\$1N481 ));
OR2 \$1I298  (.Z0 (\$1N312 ), .A0 (\$1N224 ), .A1 (\$1N226 ));
AND2 \$1I1047  (.Z0 (\$1N452 ), .A0 (QI3), .A1 (\$1N501 ));
AND2 \$1I1037  (.Z0 (\$1N398 ), .A0 (QI2), .A1 (\$1N501 ));
AND2 \$1I1038  (.Z0 (\$1N395 ), .A0 (D2), .A1 (LD));
AND2 \$1I1110  (.Z0 (\$1N357 ), .A0 (QI1), .A1 (\$1N501 ));
AND2 \$1I1031  (.Z0 (\$1N1004 ), .A0 (QI0), .A1 (\$1N501 ));
AND4 \$1I1081  (.Z0 (\$1N1083 ), .A0 (\~QI0 ), .A1 (CAI), 
	.A2 (\$1N501 ), .A3 (EN));
AND5 \$1I1089  (.Z0 (\$1N433 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\$1N501 ), .A3 (CAI), .A4 (EN));
AND6 \$1I1090  (.Z0 (\$1N481 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\$1N501 ), .A4 (CAI), 
	.A5 (EN));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (\$1N357 ), .A1 (\$1N365 ));
endmodule
`timescale 10 ps / 10 ps
module CBDA8(
	CAI, CAO, CD, CLK, D0, D1, D2, D3, D4, D5, D6, D7, EN, LD, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CAI;
	output CAO;
	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input EN;
	input LD;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



INV \$1I1252  (.ZN0 (\~QI3 ), .A0 (QI3));
INV \$1I1251  (.ZN0 (\~QI2 ), .A0 (QI2));
INV \$1I1250  (.ZN0 (\~QI1 ), .A0 (QI1));
INV \$1I1249  (.ZN0 (\~QI0 ), .A0 (QI0));
FDE1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND2 \$1I1226  (.Z0 (\$1N452 ), .A0 (QI3), .A1 (\$1N501 ));
AND2 \$1I1224  (.Z0 (\$1N357 ), .A0 (QI1), .A1 (\$1N501 ));
OR2 \$1I1222  (.Z0 (\$1N473 ), .A0 (\$1N450 ), .A1 (\$1N481 ));
OR2 \$1I1221  (.Z0 (\$1N419 ), .A0 (\$1N395 ), .A1 (\$1N433 ));
OR2 \$1I1220  (.Z0 (\$1N365 ), .A0 (\$1N354 ), .A1 (\$1N1083 ));
OR2 \$1I1219  (.Z0 (\$1N312 ), .A0 (\$1N224 ), .A1 (\$1N226 ));
BUF \$1I1215  (.Z0 (Q0), .A0 (QI0));
BUF \$1I1214  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1210  (.Z0 (Q3), .A0 (QI3));
BUF \$1I1208  (.Z0 (Q4), .A0 (QI4));
BUF \$1I1202  (.Z0 (Q5), .A0 (QI5));
AND2 \$1I1038  (.Z0 (\$1N395 ), .A0 (D2), .A1 (LD));
AND2 \$1I1048  (.Z0 (\$1N450 ), .A0 (D3), .A1 (LD));
AND4 \$1I1081  (.Z0 (\$1N1083 ), .A0 (\~QI0 ), .A1 (CAI), 
	.A2 (\$1N501 ), .A3 (EN));
AND2 \$1I1032  (.Z0 (\$1N224 ), .A0 (D0), .A1 (LD));
AND5 \$1I1089  (.Z0 (\$1N433 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\$1N501 ), .A3 (CAI), .A4 (EN));
AND3 \$1I1033  (.Z0 (\$1N226 ), .A0 (\$1N501 ), .A1 (CAI), 
	.A2 (EN));
AND10 \$1I1120  (.Z0 (CAO), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\~QI7 ), 
	.A8 (CAI), .A9 (EN));
INV \$1I38  (.ZN0 (\$1N501 ), .A0 (LD));
AND6 \$1I1090  (.Z0 (\$1N481 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\$1N501 ), .A4 (CAI), 
	.A5 (EN));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (\$1N1004 ), .A1 (\$1N312 ));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (\$1N357 ), .A1 (\$1N365 ));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (\$1N398 ), .A1 (\$1N419 ));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (\$1N452 ), .A1 (\$1N473 ));
BUF \$1I1197  (.Z0 (Q7), .A0 (QI7));
BUF \$1I1199  (.Z0 (Q6), .A0 (QI6));
BUF \$1I1212  (.Z0 (Q2), .A0 (QI2));
AND2 \$1I1223  (.Z0 (\$1N1004 ), .A0 (QI0), .A1 (\$1N501 ));
FDE1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND2 \$1I1225  (.Z0 (\$1N398 ), .A0 (QI2), .A1 (\$1N501 ));
AND2 \$1I1034  (.Z0 (\$1N354 ), .A0 (D1), .A1 (LD));
FDE1 \$2I44  (.Q0 (QI7), .D0 (\$2N30 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$2I46  (.Q0 (QI6), .D0 (\$2N7 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$2I47  (.Q0 (QI5), .D0 (\$2N36 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$2I48  (.Q0 (QI4), .D0 (\$2N40 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND2 \$2I146  (.Z0 (\$2N29 ), .A0 (QI7), .A1 (\$2N4 ));
AND2 \$2I145  (.Z0 (\$2N8 ), .A0 (QI6), .A1 (\$2N4 ));
AND2 \$2I144  (.Z0 (\$2N35 ), .A0 (QI5), .A1 (\$2N4 ));
AND2 \$2I143  (.Z0 (\$2N39 ), .A0 (QI4), .A1 (\$2N4 ));
OR2 \$2I142  (.Z0 (\$2N64 ), .A0 (\$2N31 ), .A1 (\$2N2 ));
OR2 \$2I141  (.Z0 (\$2N68 ), .A0 (\$2N10 ), .A1 (\$2N70 ));
OR2 \$2I140  (.Z0 (\$2N72 ), .A0 (\$2N28 ), .A1 (\$2N74 ));
OR2 \$2I139  (.Z0 (\$2N76 ), .A0 (\$2N38 ), .A1 (\$2N78 ));
INV \$2I100  (.ZN0 (\$2N4 ), .A0 (LD));
AND2 \$2I66  (.Z0 (\$2N31 ), .A0 (D7), .A1 (LD));
AND2 \$2I37  (.Z0 (\$2N38 ), .A0 (D4), .A1 (LD));
AND2 \$2I34  (.Z0 (\$2N28 ), .A0 (D5), .A1 (LD));
AND8 \$2I27  (.Z0 (\$2N74 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\$2N4 ), .A6 (CAI), .A7 (EN));
AND7 \$2I23  (.Z0 (\$2N78 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\$2N4 ), 
	.A5 (CAI), .A6 (EN));
AND9 \$2I9  (.Z0 (\$2N70 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\$2N4 ), .A7 (CAI), 
	.A8 (EN));
AND2 \$2I6  (.Z0 (\$2N10 ), .A0 (D6), .A1 (LD));
LXOR2 \$2I63  (.Z0 (\$2N30 ), .A0 (\$2N29 ), .A1 (\$2N64 ));
LXOR2 \$2I67  (.Z0 (\$2N7 ), .A0 (\$2N8 ), .A1 (\$2N68 ));
LXOR2 \$2I71  (.Z0 (\$2N36 ), .A0 (\$2N35 ), .A1 (\$2N72 ));
LXOR2 \$2I75  (.Z0 (\$2N40 ), .A0 (\$2N39 ), .A1 (\$2N76 ));
AND10 \$2I1  (.Z0 (\$2N2 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\$2N4 ), 
	.A8 (CAI), .A9 (EN));
INV \$2I156  (.ZN0 (\~QI4 ), .A0 (QI4));
INV \$2I157  (.ZN0 (\~QI5 ), .A0 (QI5));
INV \$2I158  (.ZN0 (\~QI6 ), .A0 (QI6));
INV \$2I159  (.ZN0 (\~QI7 ), .A0 (QI7));
endmodule
`timescale 10 ps / 10 ps
module CBDB4(
	CAI, CAO, CLK, CS, D0, D1, D2, D3, EN, LD, SD, Q0, Q1, Q2, Q3);


	input CAI;
	output CAO;
	input CLK;
	input CS;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input LD;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



AND3 \$1I1138  (.Z0 (\$1N452 ), .A0 (QI3), .A1 (\$1N501 ), 
	.A2 (\$1N820 ));
AND3 \$1I1137  (.Z0 (\$1N398 ), .A0 (QI2), .A1 (\$1N501 ), 
	.A2 (\$1N820 ));
AND3 \$1I1136  (.Z0 (\$1N357 ), .A0 (QI1), .A1 (\$1N501 ), 
	.A2 (\$1N820 ));
AND3 \$1I1135  (.Z0 (\$1N1004 ), .A0 (QI0), .A1 (\$1N501 ), 
	.A2 (\$1N820 ));
OR2 \$1I1132  (.Z0 (\$1N365 ), .A0 (\$1N354 ), .A1 (\$1N355 ));
OR2 \$1I1131  (.Z0 (\$1N312 ), .A0 (\$1N224 ), .A1 (\$1N226 ));
FDC1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD));
INV \$1I1102  (.ZN0 (\$1N820 ), .A0 (CS));
AND7 \$1I1044  (.Z0 (\$1N481 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\$1N501 ), .A4 (CAI), 
	.A5 (EN), .A6 (\$1N820 ));
AND3 \$1I459  (.Z0 (\$1N450 ), .A0 (D3), .A1 (LD), 
	.A2 (\$1N820 ));
AND5 \$1I523  (.Z0 (\$1N355 ), .A0 (\~QI0 ), .A1 (CAI), 
	.A2 (\$1N501 ), .A3 (EN), .A4 (\$1N820 ));
AND3 \$1I359  (.Z0 (\$1N354 ), .A0 (D1), .A1 (LD), 
	.A2 (\$1N820 ));
AND4 \$1I209  (.Z0 (\$1N226 ), .A0 (\$1N501 ), .A1 (CAI), 
	.A2 (EN), .A3 (\$1N820 ));
AND3 \$1I204  (.Z0 (\$1N224 ), .A0 (D0), .A1 (LD), 
	.A2 (\$1N820 ));
INV \$1I38  (.ZN0 (\$1N501 ), .A0 (LD));
AND3 \$1I397  (.Z0 (\$1N395 ), .A0 (D2), .A1 (LD), 
	.A2 (\$1N820 ));
AND6 \$1I1036  (.Z0 (\$1N1041 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (CAI), .A3 (\$1N501 ), .A4 (EN), 
	.A5 (\$1N820 ));
AND6 \$1I1078  (.Z0 (CAO), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (CAI), 
	.A5 (EN));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (\$1N452 ), .A1 (\$1N473 ));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (\$1N398 ), .A1 (\$1N419 ));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (\$1N357 ), .A1 (\$1N365 ));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (\$1N1004 ), .A1 (\$1N312 ));
BUF \$1I1115  (.Z0 (Q3), .A0 (QI3));
BUF \$1I1120  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1124  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1116  (.Z0 (Q0), .A0 (QI0));
OR2 \$1I1133  (.Z0 (\$1N419 ), .A0 (\$1N395 ), .A1 (\$1N1041 ));
OR2 \$1I1134  (.Z0 (\$1N473 ), .A0 (\$1N450 ), .A1 (\$1N481 ));
INV \$1I1149  (.ZN0 (\~QI3 ), .A0 (QI3));
INV \$1I1148  (.ZN0 (\~QI2 ), .A0 (QI2));
INV \$1I1147  (.ZN0 (\~QI1 ), .A0 (QI1));
INV \$1I1146  (.ZN0 (\~QI0 ), .A0 (QI0));
endmodule
`timescale 10 ps / 10 ps
module CBDB8(
	CAI, CAO, CLK, CS, D0, D1, D2, D3, D4, D5, D6, D7, EN, LD, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CAI;
	output CAO;
	input CLK;
	input CS;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input EN;
	input LD;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



FDC1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD));
AND3 \$1I1141  (.Z0 (\$1N452 ), .A0 (QI3), .A1 (\$1N501 ), 
	.A2 (\$1N820 ));
AND3 \$1I1140  (.Z0 (\$1N398 ), .A0 (QI2), .A1 (\$1N501 ), 
	.A2 (\$1N820 ));
AND3 \$1I1139  (.Z0 (\$1N357 ), .A0 (QI1), .A1 (\$1N501 ), 
	.A2 (\$1N820 ));
OR2 \$1I1137  (.Z0 (\$1N312 ), .A0 (\$1N224 ), .A1 (\$1N226 ));
OR2 \$1I1136  (.Z0 (\$1N365 ), .A0 (\$1N354 ), .A1 (\$1N355 ));
OR2 \$1I1135  (.Z0 (\$1N419 ), .A0 (\$1N395 ), .A1 (\$1N1041 ));
OR2 \$1I1134  (.Z0 (\$1N473 ), .A0 (\$1N450 ), .A1 (\$1N481 ));
BUF \$1I1132  (.Z0 (Q0), .A0 (QI0));
BUF \$1I1129  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1127  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1125  (.Z0 (Q3), .A0 (QI3));
BUF \$1I1123  (.Z0 (Q4), .A0 (QI4));
BUF \$1I1119  (.Z0 (Q5), .A0 (QI5));
AND6 \$1I1036  (.Z0 (\$1N1041 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (CAI), .A3 (\$1N501 ), .A4 (EN), 
	.A5 (\$1N820 ));
AND3 \$1I397  (.Z0 (\$1N395 ), .A0 (D2), .A1 (LD), 
	.A2 (\$1N820 ));
AND3 \$1I459  (.Z0 (\$1N450 ), .A0 (D3), .A1 (LD), 
	.A2 (\$1N820 ));
AND5 \$1I523  (.Z0 (\$1N355 ), .A0 (\~QI0 ), .A1 (CAI), 
	.A2 (\$1N501 ), .A3 (EN), .A4 (\$1N820 ));
AND4 \$1I209  (.Z0 (\$1N226 ), .A0 (\$1N501 ), .A1 (CAI), 
	.A2 (EN), .A3 (\$1N820 ));
AND3 \$1I204  (.Z0 (\$1N224 ), .A0 (D0), .A1 (LD), 
	.A2 (\$1N820 ));
AND7 \$1I1044  (.Z0 (\$1N481 ), .A0 (\~QI0 ), .A1 (\~QI2 ), 
	.A2 (\~QI1 ), .A3 (\$1N501 ), .A4 (CAI), 
	.A5 (EN), .A6 (\$1N820 ));
AND3 \$1I359  (.Z0 (\$1N354 ), .A0 (D1), .A1 (LD), 
	.A2 (\$1N820 ));
INV \$1I1093  (.ZN0 (\$1N820 ), .A0 (CS));
INV \$1I38  (.ZN0 (\$1N501 ), .A0 (LD));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (\$1N1004 ), .A1 (\$1N312 ));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (\$1N357 ), .A1 (\$1N365 ));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (\$1N398 ), .A1 (\$1N419 ));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (\$1N452 ), .A1 (\$1N473 ));
BUF \$1I1117  (.Z0 (Q7), .A0 (QI7));
AND3 \$1I1138  (.Z0 (\$1N1004 ), .A0 (QI0), .A1 (\$1N501 ), 
	.A2 (\$1N820 ));
BUF \$1I1118  (.Z0 (Q6), .A0 (QI6));
AND10 \$1I1064  (.Z0 (CAO), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\~QI7 ), 
	.A8 (CAI), .A9 (EN));
INV \$1I1151  (.ZN0 (\~QI3 ), .A0 (QI3));
INV \$1I1149  (.ZN0 (\~QI1 ), .A0 (QI1));
INV \$1I1148  (.ZN0 (\~QI0 ), .A0 (QI0));
INV \$1I1150  (.ZN0 (\~QI2 ), .A0 (QI2));
INV \$2I1114  (.ZN0 (\~QI7 ), .A0 (QI7));
INV \$2I1112  (.ZN0 (\~QI5 ), .A0 (QI5));
INV \$2I1111  (.ZN0 (\~QI4 ), .A0 (QI4));
AND3 \$2I1091  (.Z0 (\$2N855 ), .A0 (QI7), .A1 (\$2N501 ), 
	.A2 (\$2N820 ));
AND3 \$2I1090  (.Z0 (\$2N812 ), .A0 (QI6), .A1 (\$2N501 ), 
	.A2 (\$2N820 ));
AND3 \$2I1089  (.Z0 (\$2N770 ), .A0 (QI5), .A1 (\$2N501 ), 
	.A2 (\$2N820 ));
AND3 \$2I1088  (.Z0 (\$2N720 ), .A0 (QI4), .A1 (\$2N501 ), 
	.A2 (\$2N820 ));
OR2 \$2I1087  (.Z0 (\$2N854 ), .A0 (\$2N859 ), .A1 (\$2N1054 ));
OR2 \$2I1086  (.Z0 (\$2N813 ), .A0 (\$2N808 ), .A1 (\$2N795 ));
OR2 \$2I1085  (.Z0 (\$2N769 ), .A0 (\$2N774 ), .A1 (\$2N780 ));
OR2 \$2I1084  (.Z0 (\$2N719 ), .A0 (\$2N724 ), .A1 (\$2N725 ));
FDC1 \$2I723  (.Q0 (QI4), .D0 (\$2N924 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$2I773  (.Q0 (QI5), .D0 (\$2N929 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$2I858  (.Q0 (QI7), .D0 (\$2N935 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$2I809  (.Q0 (QI6), .D0 (\$2N930 ), .CLK (CLK), 
	.SD (SD));
AND3 \$2I806  (.Z0 (\$2N808 ), .A0 (D6), .A1 (LD), 
	.A2 (\$2N820 ));
AND3 \$2I776  (.Z0 (\$2N774 ), .A0 (D5), .A1 (LD), 
	.A2 (\$2N820 ));
AND9 \$2I1050  (.Z0 (\$2N780 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\$2N501 ), .A6 (CAI), .A7 (EN), 
	.A8 (\$2N820 ));
AND3 \$2I861  (.Z0 (\$2N859 ), .A0 (D7), .A1 (LD), 
	.A2 (\$2N820 ));
AND3 \$2I727  (.Z0 (\$2N724 ), .A0 (D4), .A1 (LD), 
	.A2 (\$2N820 ));
AND10 \$2I1051  (.Z0 (\$2N795 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\$2N501 ), .A7 (CAI), 
	.A8 (EN), .A9 (\$2N820 ));
AND11 \$2I1052  (.Z0 (\$2N1054 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\$2N501 ), 
	.A8 (CAI), .A9 (EN), .A10 (\$2N820 ));
INV \$2I1072  (.ZN0 (\$2N820 ), .A0 (CS));
INV \$2I38  (.ZN0 (\$2N501 ), .A0 (LD));
LXOR2 \$2I721  (.Z0 (\$2N924 ), .A0 (\$2N720 ), .A1 (\$2N719 ));
LXOR2 \$2I771  (.Z0 (\$2N929 ), .A0 (\$2N770 ), .A1 (\$2N769 ));
LXOR2 \$2I811  (.Z0 (\$2N930 ), .A0 (\$2N812 ), .A1 (\$2N813 ));
LXOR2 \$2I856  (.Z0 (\$2N935 ), .A0 (\$2N855 ), .A1 (\$2N854 ));
AND8 \$2I1049  (.Z0 (\$2N725 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\$2N501 ), 
	.A5 (CAI), .A6 (EN), .A7 (\$2N820 ));
INV \$2I1113  (.ZN0 (\~QI6 ), .A0 (QI6));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:50 1994
`timescale 10 ps / 10 ps 
module CBU11(
	Q0, CAO, CAI, CLK, 
	CD);

	output Q0;
	output CAO;
	input CAI;
	input CLK;
	input CD;

FD21 \$1I1  (.Q0(\$1N357 ), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
AND2 \$1I1120  (.Z0(CAO), .A0(\$1N357 ), .A1(CAI));
BUF \$1I1172  (.Z0(Q0), .A0(\$1N357 ));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N357 ), .A1(CAI));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:52 1994
`timescale 10 ps / 10 ps 
module CBU12(
	Q0, Q1, CAO, CAI, 
	CLK, CD);

	output Q0;
	output Q1;
	output CAO;
	input CAI;
	input CLK;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
AND3 \$1I1120  (.Z0(CAO), .A0(QI0), .A1(QI1), .A2(CAI));
AND2 \$1I1134  (.Z0(\$1N365 ), .A0(QI0), .A1(CAI));
BUF \$1I1168  (.Z0(Q1), .A0(QI1));
BUF \$1I1169  (.Z0(Q0), .A0(QI0));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(QI0), .A1(CAI));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(QI1), .A1(\$1N365 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:54 1994
`timescale 10 ps / 10 ps 
module CBU14(
	Q0, Q1, Q2, Q3, 
	CAO, CAI, CLK, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output CAO;
	input CAI;
	input CLK;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
AND5 \$1I1120  (.Z0(CAO), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(CAI));
AND2 \$1I1134  (.Z0(\$1N365 ), .A0(QI0), .A1(CAI));
AND3 \$1I1142  (.Z0(\$1N419 ), .A0(QI0), .A1(QI1), .A2(CAI));
AND4 \$1I1143  (.Z0(\$1N473 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(CAI));
BUF \$1I1175  (.Z0(Q3), .A0(QI3));
BUF \$1I1176  (.Z0(Q2), .A0(QI2));
BUF \$1I1177  (.Z0(Q1), .A0(QI1));
BUF \$1I1178  (.Z0(Q0), .A0(QI0));
FD21 \$1I155  (.Q0(QI2), .D0(\$1N915 ), .CLK(CLK), .CD(CD));
FD21 \$1I175  (.Q0(QI3), .D0(\$1N921 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(QI0), .A1(CAI));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(QI1), .A1(\$1N365 ));
LXOR2 \$1I400  (.Z0(\$1N915 ), .A0(QI2), .A1(\$1N419 ));
LXOR2 \$1I454  (.Z0(\$1N921 ), .A0(QI3), .A1(\$1N473 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:57 1994
`timescale 10 ps / 10 ps 
module CBU18(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	CAO, CAI, CLK, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output CAO;
	input CAI;
	input CLK;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
AND2 \$1I1134  (.Z0(\$1N365 ), .A0(QI0), .A1(CAI));
AND3 \$1I1142  (.Z0(\$1N419 ), .A0(QI0), .A1(QI1), .A2(CAI));
AND4 \$1I1143  (.Z0(\$1N473 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(CAI));
AND5 \$1I1144  (.Z0(\$1N719 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(CAI));
AND6 \$1I1145  (.Z0(\$1N769 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(CAI));
AND7 \$1I1146  (.Z0(\$1N813 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(CAI));
AND8 \$1I1147  (.Z0(\$1N854 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(CAI));
AND9 \$1I1158  (.Z0(CAO), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(CAI));
BUF \$1I1204  (.Z0(Q0), .A0(QI0));
BUF \$1I1211  (.Z0(Q7), .A0(QI7));
BUF \$1I1212  (.Z0(Q6), .A0(QI6));
BUF \$1I1214  (.Z0(Q4), .A0(QI4));
BUF \$1I1215  (.Z0(Q5), .A0(QI5));
BUF \$1I1216  (.Z0(Q3), .A0(QI3));
BUF \$1I1217  (.Z0(Q1), .A0(QI1));
BUF \$1I1218  (.Z0(Q2), .A0(QI2));
FD21 \$1I155  (.Q0(QI2), .D0(\$1N915 ), .CLK(CLK), .CD(CD));
FD21 \$1I175  (.Q0(QI3), .D0(\$1N921 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(QI0), .A1(CAI));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(QI1), .A1(\$1N365 ));
LXOR2 \$1I400  (.Z0(\$1N915 ), .A0(QI2), .A1(\$1N419 ));
LXOR2 \$1I454  (.Z0(\$1N921 ), .A0(QI3), .A1(\$1N473 ));
LXOR2 \$1I721  (.Z0(\$1N924 ), .A0(QI4), .A1(\$1N719 ));
FD21 \$1I723  (.Q0(QI4), .D0(\$1N924 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I771  (.Z0(\$1N929 ), .A0(QI5), .A1(\$1N769 ));
FD21 \$1I773  (.Q0(QI5), .D0(\$1N929 ), .CLK(CLK), .CD(CD));
FD21 \$1I809  (.Q0(QI6), .D0(\$1N930 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I811  (.Z0(\$1N930 ), .A0(QI6), .A1(\$1N813 ));
LXOR2 \$1I856  (.Z0(\$1N935 ), .A0(QI7), .A1(\$1N854 ));
FD21 \$1I858  (.Q0(QI7), .D0(\$1N935 ), .CLK(CLK), .CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:01:59 1994
`timescale 10 ps / 10 ps 
module CBU21(
	Q0, CAO, CAI, CLK, 
	EN, CD);

	output Q0;
	output CAO;
	input CAI;
	input CLK;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(\$1N357 ), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
AND2 \$1I1133  (.Z0(\$1N226 ), .A0(CAI), .A1(EN));
AND3 \$1I1144  (.Z0(CAO), .A0(\$1N357 ), .A1(CAI), .A2(EN));
BUF \$1I1162  (.Z0(Q0), .A0(\$1N357 ));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N357 ), .A1(\$1N226 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:02:01 1994
`timescale 10 ps / 10 ps 
module CBU22(
	Q0, Q1, CAO, CAI, 
	CLK, EN, CD);

	output Q0;
	output Q1;
	output CAO;
	input CAI;
	input CLK;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
AND2 \$1I1133  (.Z0(\$1N226 ), .A0(CAI), .A1(EN));
AND3 \$1I1134  (.Z0(\$1N365 ), .A0(QI0), .A1(CAI), .A2(EN));
AND4 \$1I1144  (.Z0(CAO), .A0(QI0), .A1(QI1), .A2(CAI), 
	.A3(EN));
BUF \$1I1160  (.Z0(Q1), .A0(QI1));
BUF \$1I1161  (.Z0(Q0), .A0(QI0));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(QI0), .A1(\$1N226 ));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(QI1), .A1(\$1N365 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:02:04 1994
`timescale 10 ps / 10 ps 
module CBU24(
	Q0, Q1, Q2, Q3, 
	CAO, CAI, CLK, EN, 
	CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output CAO;
	input CAI;
	input CLK;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
AND2 \$1I1133  (.Z0(\$1N226 ), .A0(CAI), .A1(EN));
AND3 \$1I1134  (.Z0(\$1N365 ), .A0(QI0), .A1(CAI), .A2(EN));
AND4 \$1I1135  (.Z0(\$1N419 ), .A0(QI0), .A1(QI1), .A2(CAI), 
	.A3(EN));
AND5 \$1I1136  (.Z0(\$1N473 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(CAI), .A4(EN));
AND6 \$1I1144  (.Z0(CAO), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(CAI), .A5(EN));
BUF \$1I1163  (.Z0(Q3), .A0(QI3));
BUF \$1I1164  (.Z0(Q1), .A0(QI1));
BUF \$1I1165  (.Z0(Q0), .A0(QI0));
BUF \$1I1166  (.Z0(Q2), .A0(QI2));
FD21 \$1I155  (.Q0(QI2), .D0(\$1N915 ), .CLK(CLK), .CD(CD));
FD21 \$1I175  (.Q0(QI3), .D0(\$1N921 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(QI0), .A1(\$1N226 ));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(QI1), .A1(\$1N365 ));
LXOR2 \$1I400  (.Z0(\$1N915 ), .A0(QI2), .A1(\$1N419 ));
LXOR2 \$1I454  (.Z0(\$1N921 ), .A0(QI3), .A1(\$1N473 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:02:07 1994
`timescale 10 ps / 10 ps 
module CBU28(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	CAO, CAI, CLK, EN, 
	CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output CAO;
	input CAI;
	input CLK;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
AND10 \$1I1120  (.Z0(CAO), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(CAI), .A9(EN));
AND2 \$1I1133  (.Z0(\$1N226 ), .A0(CAI), .A1(EN));
AND3 \$1I1134  (.Z0(\$1N365 ), .A0(QI0), .A1(CAI), .A2(EN));
AND4 \$1I1135  (.Z0(\$1N419 ), .A0(QI0), .A1(QI1), .A2(CAI), 
	.A3(EN));
AND5 \$1I1136  (.Z0(\$1N473 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(CAI), .A4(EN));
AND6 \$1I1137  (.Z0(\$1N719 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(CAI), .A5(EN));
AND7 \$1I1138  (.Z0(\$1N769 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(CAI), .A6(EN));
AND8 \$1I1139  (.Z0(\$1N813 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(CAI), 
	.A7(EN));
AND9 \$1I1140  (.Z0(\$1N854 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(CAI), .A8(EN));
BUF \$1I1190  (.Z0(Q7), .A0(QI7));
BUF \$1I1194  (.Z0(Q6), .A0(QI6));
BUF \$1I1211  (.Z0(Q0), .A0(QI0));
BUF \$1I1215  (.Z0(Q1), .A0(QI1));
BUF \$1I1220  (.Z0(Q5), .A0(QI5));
BUF \$1I1224  (.Z0(Q2), .A0(QI2));
BUF \$1I1228  (.Z0(Q4), .A0(QI4));
BUF \$1I1232  (.Z0(Q3), .A0(QI3));
FD21 \$1I155  (.Q0(QI2), .D0(\$1N915 ), .CLK(CLK), .CD(CD));
FD21 \$1I175  (.Q0(QI3), .D0(\$1N921 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(QI0), .A1(\$1N226 ));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(QI1), .A1(\$1N365 ));
LXOR2 \$1I400  (.Z0(\$1N915 ), .A0(QI2), .A1(\$1N419 ));
LXOR2 \$1I454  (.Z0(\$1N921 ), .A0(QI3), .A1(\$1N473 ));
LXOR2 \$1I721  (.Z0(\$1N924 ), .A0(QI4), .A1(\$1N719 ));
FD21 \$1I723  (.Q0(QI4), .D0(\$1N924 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I771  (.Z0(\$1N929 ), .A0(QI5), .A1(\$1N769 ));
FD21 \$1I773  (.Q0(QI5), .D0(\$1N929 ), .CLK(CLK), .CD(CD));
FD21 \$1I809  (.Q0(QI6), .D0(\$1N930 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I811  (.Z0(\$1N930 ), .A0(QI6), .A1(\$1N813 ));
LXOR2 \$1I856  (.Z0(\$1N935 ), .A0(QI7), .A1(\$1N854 ));
FD21 \$1I858  (.Q0(QI7), .D0(\$1N935 ), .CLK(CLK), .CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:02:09 1994
`timescale 10 ps / 10 ps 
module CBU31(
	Q0, CAO, D0, CAI, 
	CLK, PS, LD, EN, 
	CD);

	output Q0;
	output CAO;
	input D0;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(\$1N837 ), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
AND3 \$1I1031  (.Z0(\$1N1004 ), .A0(\$1N837 ), .A1(\$1N501 ), .A2(\$1N827 ));
AND2 \$1I1032  (.Z0(\$1N224 ), .A0(D0), .A1(LD));
AND3 \$1I1033  (.Z0(\$1N226 ), .A0(\$1N501 ), .A1(CAI), .A2(EN));
AND3 \$1I1120  (.Z0(CAO), .A0(\$1N837 ), .A1(CAI), .A2(EN));
INV \$1I1145  (.ZN0(\$1N501 ), .A0(LD));
BUF \$1I1153  (.Z0(Q0), .A0(\$1N837 ));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N224 ), .A1(\$1N226 ), .A2(PS));
INV \$1I949  (.ZN0(\$1N827 ), .A0(PS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:02:12 1994
`timescale 10 ps / 10 ps 
module CBU32(
	Q0, Q1, CAO, D0, 
	D1, CAI, CLK, PS, 
	LD, EN, CD);

	output Q0;
	output Q1;
	output CAO;
	input D0;
	input D1;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
AND3 \$1I1031  (.Z0(\$1N1004 ), .A0(QI0), .A1(\$1N501 ), .A2(\$1N827 ));
AND2 \$1I1032  (.Z0(\$1N224 ), .A0(D0), .A1(LD));
AND3 \$1I1033  (.Z0(\$1N226 ), .A0(\$1N501 ), .A1(CAI), .A2(EN));
AND2 \$1I1034  (.Z0(\$1N354 ), .A0(D1), .A1(LD));
AND4 \$1I1081  (.Z0(\$1N1083 ), .A0(QI0), .A1(CAI), .A2(\$1N501 ), 
	.A3(EN));
OR3 \$1I1082  (.Z0(\$1N365 ), .A0(\$1N354 ), .A1(\$1N1083 ), .A2(PS));
AND3 \$1I1110  (.Z0(\$1N357 ), .A0(QI1), .A1(\$1N501 ), .A2(\$1N827 ));
AND4 \$1I1120  (.Z0(CAO), .A0(QI0), .A1(QI1), .A2(CAI), 
	.A3(EN));
INV \$1I1132  (.ZN0(\$1N827 ), .A0(PS));
BUF \$1I1153  (.Z0(Q1), .A0(QI1));
BUF \$1I1154  (.Z0(Q0), .A0(QI0));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N224 ), .A1(\$1N226 ), .A2(PS));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(\$1N357 ), .A1(\$1N365 ));
INV \$1I38  (.ZN0(\$1N501 ), .A0(LD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:02:15 1994
`timescale 10 ps / 10 ps 
module CBU34(
	Q0, Q1, Q2, Q3, 
	CAO, D0, D1, D2, 
	D3, CAI, CLK, PS, 
	LD, EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
AND3 \$1I1031  (.Z0(\$1N1004 ), .A0(QI0), .A1(\$1N501 ), .A2(\$1N827 ));
AND2 \$1I1032  (.Z0(\$1N224 ), .A0(D0), .A1(LD));
AND3 \$1I1033  (.Z0(\$1N226 ), .A0(\$1N501 ), .A1(CAI), .A2(EN));
AND2 \$1I1034  (.Z0(\$1N354 ), .A0(D1), .A1(LD));
AND3 \$1I1037  (.Z0(\$1N398 ), .A0(QI2), .A1(\$1N501 ), .A2(\$1N827 ));
AND2 \$1I1038  (.Z0(\$1N395 ), .A0(D2), .A1(LD));
AND3 \$1I1047  (.Z0(\$1N452 ), .A0(QI3), .A1(\$1N501 ), .A2(\$1N827 ));
AND2 \$1I1048  (.Z0(\$1N450 ), .A0(D3), .A1(LD));
AND4 \$1I1081  (.Z0(\$1N1083 ), .A0(QI0), .A1(CAI), .A2(\$1N501 ), 
	.A3(EN));
OR3 \$1I1082  (.Z0(\$1N365 ), .A0(\$1N354 ), .A1(\$1N1083 ), .A2(PS));
OR3 \$1I1087  (.Z0(\$1N419 ), .A0(\$1N395 ), .A1(\$1N433 ), .A2(PS));
OR3 \$1I1088  (.Z0(\$1N473 ), .A0(\$1N450 ), .A1(\$1N481 ), .A2(PS));
AND5 \$1I1089  (.Z0(\$1N433 ), .A0(QI0), .A1(QI1), .A2(\$1N501 ), 
	.A3(CAI), .A4(EN));
AND6 \$1I1090  (.Z0(\$1N481 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(\$1N501 ), .A4(CAI), .A5(EN));
AND3 \$1I1110  (.Z0(\$1N357 ), .A0(QI1), .A1(\$1N501 ), .A2(\$1N827 ));
AND6 \$1I1120  (.Z0(CAO), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(CAI), .A5(EN));
INV \$1I1144  (.ZN0(\$1N827 ), .A0(PS));
BUF \$1I1154  (.Z0(Q3), .A0(QI3));
BUF \$1I1158  (.Z0(Q2), .A0(QI2));
BUF \$1I1162  (.Z0(Q1), .A0(QI1));
BUF \$1I1166  (.Z0(Q0), .A0(QI0));
FD21 \$1I155  (.Q0(QI2), .D0(\$1N915 ), .CLK(CLK), .CD(CD));
FD21 \$1I175  (.Q0(QI3), .D0(\$1N921 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N224 ), .A1(\$1N226 ), .A2(PS));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(\$1N357 ), .A1(\$1N365 ));
INV \$1I38  (.ZN0(\$1N501 ), .A0(LD));
LXOR2 \$1I400  (.Z0(\$1N915 ), .A0(\$1N398 ), .A1(\$1N419 ));
LXOR2 \$1I454  (.Z0(\$1N921 ), .A0(\$1N452 ), .A1(\$1N473 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:02:20 1994
`timescale 10 ps / 10 ps 
module CBU38(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	CAO, D0, D1, D2, 
	D3, D4, D5, D6, 
	D7, CAI, CLK, PS, 
	LD, EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
AND3 \$1I1031  (.Z0(\$1N1004 ), .A0(QI0), .A1(\$1N501 ), .A2(\$1N827 ));
AND2 \$1I1032  (.Z0(\$1N224 ), .A0(D0), .A1(LD));
AND3 \$1I1033  (.Z0(\$1N226 ), .A0(\$1N501 ), .A1(CAI), .A2(EN));
AND2 \$1I1034  (.Z0(\$1N354 ), .A0(D1), .A1(LD));
AND3 \$1I1037  (.Z0(\$1N398 ), .A0(QI2), .A1(\$1N501 ), .A2(\$1N827 ));
AND2 \$1I1038  (.Z0(\$1N395 ), .A0(D2), .A1(LD));
AND3 \$1I1047  (.Z0(\$1N452 ), .A0(QI3), .A1(\$1N501 ), .A2(\$1N827 ));
AND2 \$1I1048  (.Z0(\$1N450 ), .A0(D3), .A1(LD));
AND4 \$1I1081  (.Z0(\$1N1083 ), .A0(QI0), .A1(CAI), .A2(\$1N501 ), 
	.A3(EN));
OR3 \$1I1082  (.Z0(\$1N365 ), .A0(\$1N354 ), .A1(\$1N1083 ), .A2(PS));
OR3 \$1I1087  (.Z0(\$1N419 ), .A0(\$1N395 ), .A1(\$1N433 ), .A2(PS));
OR3 \$1I1088  (.Z0(\$1N473 ), .A0(\$1N450 ), .A1(\$1N481 ), .A2(PS));
AND5 \$1I1089  (.Z0(\$1N433 ), .A0(QI0), .A1(QI1), .A2(\$1N501 ), 
	.A3(CAI), .A4(EN));
AND6 \$1I1090  (.Z0(\$1N481 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(\$1N501 ), .A4(CAI), .A5(EN));
AND3 \$1I1110  (.Z0(\$1N357 ), .A0(QI1), .A1(\$1N501 ), .A2(\$1N827 ));
AND10 \$1I1120  (.Z0(CAO), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(CAI), .A9(EN));
INV \$1I1155  (.ZN0(\$1N827 ), .A0(PS));
BUF \$1I1197  (.Z0(Q7), .A0(QI7));
BUF \$1I1199  (.Z0(Q6), .A0(QI6));
BUF \$1I1202  (.Z0(Q5), .A0(QI5));
BUF \$1I1208  (.Z0(Q4), .A0(QI4));
BUF \$1I1210  (.Z0(Q3), .A0(QI3));
BUF \$1I1212  (.Z0(Q2), .A0(QI2));
BUF \$1I1214  (.Z0(Q1), .A0(QI1));
BUF \$1I1215  (.Z0(Q0), .A0(QI0));
FD21 \$1I155  (.Q0(QI2), .D0(\$1N915 ), .CLK(CLK), .CD(CD));
FD21 \$1I175  (.Q0(QI3), .D0(\$1N921 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N224 ), .A1(\$1N226 ), .A2(PS));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(\$1N357 ), .A1(\$1N365 ));
INV \$1I38  (.ZN0(\$1N501 ), .A0(LD));
LXOR2 \$1I400  (.Z0(\$1N915 ), .A0(\$1N398 ), .A1(\$1N419 ));
LXOR2 \$1I454  (.Z0(\$1N921 ), .A0(\$1N452 ), .A1(\$1N473 ));
AND10 \$2I1  (.Z0(\$2N2 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(\$2N4 ), .A8(CAI), .A9(EN));
INV \$2I100  (.ZN0(\$2N4 ), .A0(LD));
INV \$2I101  (.ZN0(\$2N102 ), .A0(PS));
AND3 \$2I125  (.Z0(\$2N39 ), .A0(QI4), .A1(\$2N4 ), .A2(\$2N102 ));
AND3 \$2I127  (.Z0(\$2N35 ), .A0(QI5), .A1(\$2N4 ), .A2(\$2N102 ));
AND3 \$2I128  (.Z0(\$2N8 ), .A0(QI6), .A1(\$2N4 ), .A2(\$2N102 ));
AND3 \$2I129  (.Z0(\$2N29 ), .A0(QI7), .A1(\$2N4 ), .A2(\$2N102 ));
AND7 \$2I23  (.Z0(\$2N78 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(\$2N4 ), .A5(CAI), .A6(EN));
AND8 \$2I27  (.Z0(\$2N74 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(\$2N4 ), .A6(CAI), 
	.A7(EN));
AND2 \$2I34  (.Z0(\$2N28 ), .A0(D5), .A1(LD));
AND2 \$2I37  (.Z0(\$2N38 ), .A0(D4), .A1(LD));
FD21 \$2I44  (.Q0(QI7), .D0(\$2N30 ), .CLK(CLK), .CD(CD));
FD21 \$2I46  (.Q0(QI6), .D0(\$2N7 ), .CLK(CLK), .CD(CD));
FD21 \$2I47  (.Q0(QI5), .D0(\$2N36 ), .CLK(CLK), .CD(CD));
FD21 \$2I48  (.Q0(QI4), .D0(\$2N40 ), .CLK(CLK), .CD(CD));
AND2 \$2I6  (.Z0(\$2N10 ), .A0(D6), .A1(LD));
LXOR2 \$2I63  (.Z0(\$2N30 ), .A0(\$2N29 ), .A1(\$2N64 ));
OR3 \$2I65  (.Z0(\$2N64 ), .A0(\$2N31 ), .A1(\$2N2 ), .A2(PS));
AND2 \$2I66  (.Z0(\$2N31 ), .A0(D7), .A1(LD));
LXOR2 \$2I67  (.Z0(\$2N7 ), .A0(\$2N8 ), .A1(\$2N68 ));
OR3 \$2I69  (.Z0(\$2N68 ), .A0(\$2N10 ), .A1(\$2N70 ), .A2(PS));
LXOR2 \$2I71  (.Z0(\$2N36 ), .A0(\$2N35 ), .A1(\$2N72 ));
OR3 \$2I73  (.Z0(\$2N72 ), .A0(\$2N28 ), .A1(\$2N74 ), .A2(PS));
LXOR2 \$2I75  (.Z0(\$2N40 ), .A0(\$2N39 ), .A1(\$2N76 ));
OR3 \$2I77  (.Z0(\$2N76 ), .A0(\$2N38 ), .A1(\$2N78 ), .A2(PS));
AND9 \$2I9  (.Z0(\$2N70 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(\$2N4 ), 
	.A7(CAI), .A8(EN));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:02:22 1994
`timescale 10 ps / 10 ps 
module CBU41(
	Q0, CAO, D0, CAI, 
	CLK, PS, LD, EN, 
	CS);

	output Q0;
	output CAO;
	input D0;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CS;

FD11 \$1I1  (.Q0(\$1N1018 ), .D0(\$1N904 ), .CLK(CLK));
AND3 \$1I1078  (.Z0(CAO), .A0(\$1N1018 ), .A1(CAI), .A2(EN));
INV \$1I1096  (.ZN0(\$1N501 ), .A0(LD));
INV \$1I1099  (.ZN0(\$1N820 ), .A0(CS));
BUF \$1I1107  (.Z0(Q0), .A0(\$1N1018 ));
AND3 \$1I204  (.Z0(\$1N224 ), .A0(D0), .A1(LD), .A2(\$1N820 ));
AND4 \$1I209  (.Z0(\$1N226 ), .A0(\$1N501 ), .A1(CAI), .A2(EN), 
	.A3(\$1N820 ));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N224 ), .A1(\$1N226 ), .A2(PS));
AND4 \$1I3  (.Z0(\$1N1004 ), .A0(\$1N1018 ), .A1(\$1N501 ), .A2(\$1N820 ), 
	.A3(\$1N827 ));
INV \$1I949  (.ZN0(\$1N827 ), .A0(PS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:02:25 1994
`timescale 10 ps / 10 ps 
module CBU42(
	Q0, Q1, CAO, D0, 
	D1, CAI, CLK, PS, 
	LD, EN, CS);

	output Q0;
	output Q1;
	output CAO;
	input D0;
	input D1;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CS;

FD11 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK));
FD11 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK));
AND4 \$1I1078  (.Z0(CAO), .A0(QI0), .A1(QI1), .A2(CAI), 
	.A3(EN));
INV \$1I1094  (.ZN0(\$1N820 ), .A0(CS));
INV \$1I1096  (.ZN0(\$1N827 ), .A0(PS));
BUF \$1I1105  (.Z0(Q1), .A0(QI1));
BUF \$1I1106  (.Z0(Q0), .A0(QI0));
AND3 \$1I204  (.Z0(\$1N224 ), .A0(D0), .A1(LD), .A2(\$1N820 ));
AND4 \$1I209  (.Z0(\$1N226 ), .A0(\$1N501 ), .A1(CAI), .A2(EN), 
	.A3(\$1N820 ));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N224 ), .A1(\$1N226 ), .A2(PS));
AND4 \$1I3  (.Z0(\$1N1004 ), .A0(QI0), .A1(\$1N501 ), .A2(\$1N820 ), 
	.A3(\$1N827 ));
AND4 \$1I343  (.Z0(\$1N357 ), .A0(QI1), .A1(\$1N501 ), .A2(\$1N820 ), 
	.A3(\$1N827 ));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(\$1N357 ), .A1(\$1N365 ));
AND3 \$1I359  (.Z0(\$1N354 ), .A0(D1), .A1(LD), .A2(\$1N820 ));
INV \$1I38  (.ZN0(\$1N501 ), .A0(LD));
AND5 \$1I523  (.Z0(\$1N355 ), .A0(QI0), .A1(CAI), .A2(\$1N501 ), 
	.A3(EN), .A4(\$1N820 ));
OR3 \$1I534  (.Z0(\$1N365 ), .A0(\$1N354 ), .A1(\$1N355 ), .A2(PS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:02:28 1994
`timescale 10 ps / 10 ps 
module CBU44(
	Q0, Q1, Q2, Q3, 
	CAO, D0, D1, D2, 
	D3, CAI, CLK, PS, 
	LD, EN, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CS;

FD11 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK));
FD11 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK));
AND6 \$1I1036  (.Z0(\$1N1041 ), .A0(QI0), .A1(QI1), .A2(CAI), 
	.A3(\$1N501 ), .A4(EN), .A5(\$1N820 ));
OR3 \$1I1043  (.Z0(\$1N473 ), .A0(\$1N450 ), .A1(\$1N481 ), .A2(PS));
AND7 \$1I1044  (.Z0(\$1N481 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(\$1N501 ), .A4(CAI), .A5(EN), .A6(\$1N820 ));
AND6 \$1I1078  (.Z0(CAO), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(CAI), .A5(EN));
INV \$1I1102  (.ZN0(\$1N820 ), .A0(CS));
INV \$1I1106  (.ZN0(\$1N827 ), .A0(PS));
BUF \$1I1115  (.Z0(Q3), .A0(QI3));
BUF \$1I1116  (.Z0(Q0), .A0(QI0));
BUF \$1I1120  (.Z0(Q2), .A0(QI2));
BUF \$1I1124  (.Z0(Q1), .A0(QI1));
FD11 \$1I155  (.Q0(QI2), .D0(\$1N915 ), .CLK(CLK));
FD11 \$1I175  (.Q0(QI3), .D0(\$1N921 ), .CLK(CLK));
AND3 \$1I204  (.Z0(\$1N224 ), .A0(D0), .A1(LD), .A2(\$1N820 ));
AND4 \$1I209  (.Z0(\$1N226 ), .A0(\$1N501 ), .A1(CAI), .A2(EN), 
	.A3(\$1N820 ));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N224 ), .A1(\$1N226 ), .A2(PS));
AND4 \$1I3  (.Z0(\$1N1004 ), .A0(QI0), .A1(\$1N501 ), .A2(\$1N820 ), 
	.A3(\$1N827 ));
AND4 \$1I343  (.Z0(\$1N357 ), .A0(QI1), .A1(\$1N501 ), .A2(\$1N820 ), 
	.A3(\$1N827 ));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(\$1N357 ), .A1(\$1N365 ));
AND3 \$1I359  (.Z0(\$1N354 ), .A0(D1), .A1(LD), .A2(\$1N820 ));
INV \$1I38  (.ZN0(\$1N501 ), .A0(LD));
AND3 \$1I397  (.Z0(\$1N395 ), .A0(D2), .A1(LD), .A2(\$1N820 ));
LXOR2 \$1I400  (.Z0(\$1N915 ), .A0(\$1N398 ), .A1(\$1N419 ));
AND4 \$1I401  (.Z0(\$1N398 ), .A0(QI2), .A1(\$1N501 ), .A2(\$1N820 ), 
	.A3(\$1N827 ));
LXOR2 \$1I454  (.Z0(\$1N921 ), .A0(\$1N452 ), .A1(\$1N473 ));
AND3 \$1I459  (.Z0(\$1N450 ), .A0(D3), .A1(LD), .A2(\$1N820 ));
AND4 \$1I460  (.Z0(\$1N452 ), .A0(QI3), .A1(\$1N501 ), .A2(\$1N820 ), 
	.A3(\$1N827 ));
AND5 \$1I523  (.Z0(\$1N355 ), .A0(QI0), .A1(CAI), .A2(\$1N501 ), 
	.A3(EN), .A4(\$1N820 ));
OR3 \$1I534  (.Z0(\$1N365 ), .A0(\$1N354 ), .A1(\$1N355 ), .A2(PS));
OR3 \$1I578  (.Z0(\$1N419 ), .A0(\$1N395 ), .A1(\$1N1041 ), .A2(PS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:02:33 1994
`timescale 10 ps / 10 ps 
module CBU48(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	CAO, D0, D1, D2, 
	D3, D4, D5, D6, 
	D7, CAI, CLK, PS, 
	LD, EN, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CS;

FD11 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK));
FD11 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK));
AND6 \$1I1036  (.Z0(\$1N1041 ), .A0(QI0), .A1(QI1), .A2(CAI), 
	.A3(\$1N501 ), .A4(EN), .A5(\$1N820 ));
OR3 \$1I1043  (.Z0(\$1N473 ), .A0(\$1N450 ), .A1(\$1N481 ), .A2(PS));
AND7 \$1I1044  (.Z0(\$1N481 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(\$1N501 ), .A4(CAI), .A5(EN), .A6(\$1N820 ));
AND10 \$1I1064  (.Z0(CAO), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(CAI), .A9(EN));
INV \$1I1093  (.ZN0(\$1N820 ), .A0(CS));
INV \$1I1098  (.ZN0(\$1N827 ), .A0(PS));
BUF \$1I1117  (.Z0(Q7), .A0(QI7));
BUF \$1I1118  (.Z0(Q6), .A0(QI6));
BUF \$1I1119  (.Z0(Q5), .A0(QI5));
BUF \$1I1123  (.Z0(Q4), .A0(QI4));
BUF \$1I1125  (.Z0(Q3), .A0(QI3));
BUF \$1I1127  (.Z0(Q2), .A0(QI2));
BUF \$1I1129  (.Z0(Q1), .A0(QI1));
BUF \$1I1132  (.Z0(Q0), .A0(QI0));
FD11 \$1I155  (.Q0(QI2), .D0(\$1N915 ), .CLK(CLK));
FD11 \$1I175  (.Q0(QI3), .D0(\$1N921 ), .CLK(CLK));
AND3 \$1I204  (.Z0(\$1N224 ), .A0(D0), .A1(LD), .A2(\$1N820 ));
AND4 \$1I209  (.Z0(\$1N226 ), .A0(\$1N501 ), .A1(CAI), .A2(EN), 
	.A3(\$1N820 ));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N224 ), .A1(\$1N226 ), .A2(PS));
AND4 \$1I3  (.Z0(\$1N1004 ), .A0(QI0), .A1(\$1N501 ), .A2(\$1N820 ), 
	.A3(\$1N827 ));
AND4 \$1I343  (.Z0(\$1N357 ), .A0(QI1), .A1(\$1N501 ), .A2(\$1N820 ), 
	.A3(\$1N827 ));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(\$1N357 ), .A1(\$1N365 ));
AND3 \$1I359  (.Z0(\$1N354 ), .A0(D1), .A1(LD), .A2(\$1N820 ));
INV \$1I38  (.ZN0(\$1N501 ), .A0(LD));
AND3 \$1I397  (.Z0(\$1N395 ), .A0(D2), .A1(LD), .A2(\$1N820 ));
LXOR2 \$1I400  (.Z0(\$1N915 ), .A0(\$1N398 ), .A1(\$1N419 ));
AND4 \$1I401  (.Z0(\$1N398 ), .A0(QI2), .A1(\$1N501 ), .A2(\$1N820 ), 
	.A3(\$1N827 ));
LXOR2 \$1I454  (.Z0(\$1N921 ), .A0(\$1N452 ), .A1(\$1N473 ));
AND3 \$1I459  (.Z0(\$1N450 ), .A0(D3), .A1(LD), .A2(\$1N820 ));
AND4 \$1I460  (.Z0(\$1N452 ), .A0(QI3), .A1(\$1N501 ), .A2(\$1N820 ), 
	.A3(\$1N827 ));
AND5 \$1I523  (.Z0(\$1N355 ), .A0(QI0), .A1(CAI), .A2(\$1N501 ), 
	.A3(EN), .A4(\$1N820 ));
OR3 \$1I534  (.Z0(\$1N365 ), .A0(\$1N354 ), .A1(\$1N355 ), .A2(PS));
OR3 \$1I578  (.Z0(\$1N419 ), .A0(\$1N395 ), .A1(\$1N1041 ), .A2(PS));
AND8 \$2I1049  (.Z0(\$2N725 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(\$2N501 ), .A5(CAI), .A6(EN), 
	.A7(\$2N820 ));
AND9 \$2I1050  (.Z0(\$2N780 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(\$2N501 ), .A6(CAI), 
	.A7(EN), .A8(\$2N820 ));
AND10 \$2I1051  (.Z0(\$2N795 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(\$2N501 ), 
	.A7(CAI), .A8(EN), .A9(\$2N820 ));
AND11 \$2I1052  (.Z0(\$2N1054 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(\$2N501 ), .A8(CAI), .A9(EN), .A10(\$2N820 ));
OR3 \$2I1053  (.Z0(\$2N854 ), .A0(\$2N859 ), .A1(\$2N1054 ), .A2(PS));
OR3 \$2I1066  (.Z0(\$2N719 ), .A0(\$2N724 ), .A1(\$2N725 ), .A2(PS));
INV \$2I1072  (.ZN0(\$2N820 ), .A0(CS));
INV \$2I38  (.ZN0(\$2N501 ), .A0(LD));
LXOR2 \$2I721  (.Z0(\$2N924 ), .A0(\$2N720 ), .A1(\$2N719 ));
FD11 \$2I723  (.Q0(QI4), .D0(\$2N924 ), .CLK(CLK));
AND3 \$2I727  (.Z0(\$2N724 ), .A0(D4), .A1(LD), .A2(\$2N820 ));
AND4 \$2I730  (.Z0(\$2N720 ), .A0(QI4), .A1(\$2N501 ), .A2(\$2N820 ), 
	.A3(\$2N827 ));
LXOR2 \$2I771  (.Z0(\$2N929 ), .A0(\$2N770 ), .A1(\$2N769 ));
FD11 \$2I773  (.Q0(QI5), .D0(\$2N929 ), .CLK(CLK));
OR3 \$2I775  (.Z0(\$2N769 ), .A0(\$2N774 ), .A1(\$2N780 ), .A2(PS));
AND3 \$2I776  (.Z0(\$2N774 ), .A0(D5), .A1(LD), .A2(\$2N820 ));
AND4 \$2I777  (.Z0(\$2N770 ), .A0(QI5), .A1(\$2N501 ), .A2(\$2N820 ), 
	.A3(\$2N827 ));
AND3 \$2I806  (.Z0(\$2N808 ), .A0(D6), .A1(LD), .A2(\$2N820 ));
OR3 \$2I807  (.Z0(\$2N813 ), .A0(\$2N808 ), .A1(\$2N795 ), .A2(PS));
FD11 \$2I809  (.Q0(QI6), .D0(\$2N930 ), .CLK(CLK));
LXOR2 \$2I811  (.Z0(\$2N930 ), .A0(\$2N812 ), .A1(\$2N813 ));
AND4 \$2I821  (.Z0(\$2N812 ), .A0(QI6), .A1(\$2N501 ), .A2(\$2N820 ), 
	.A3(\$2N827 ));
LXOR2 \$2I856  (.Z0(\$2N935 ), .A0(\$2N855 ), .A1(\$2N854 ));
FD11 \$2I858  (.Q0(QI7), .D0(\$2N935 ), .CLK(CLK));
AND3 \$2I861  (.Z0(\$2N859 ), .A0(D7), .A1(LD), .A2(\$2N820 ));
AND4 \$2I867  (.Z0(\$2N855 ), .A0(QI7), .A1(\$2N501 ), .A2(\$2N820 ), 
	.A3(\$2N827 ));
INV \$2I949  (.ZN0(\$2N827 ), .A0(PS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:02:38 1994
`timescale 10 ps / 10 ps 
module CBU516(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	Q8, Q9, Q10, Q11, 
	Q12, Q13, Q14, Q15, 
	CLK, EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output Q8;
	output Q9;
	output Q10;
	output Q11;
	output Q12;
	output Q13;
	output Q14;
	output Q15;
	input CLK;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N14 ), .CLK(CLK), .CD(CD));
AND4 \$1I101  (.Z0(\$1N94 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(EN));
LXOR2 \$1I13  (.Z0(\$1N14 ), .A0(QI0), .A1(EN));
LXOR2 \$1I17  (.Z0(\$1N16 ), .A0(QI1), .A1(\$1N58 ));
LXOR2 \$1I19  (.Z0(\$1N18 ), .A0(QI2), .A1(\$1N66 ));
BUF \$1I192  (.Z0(Q15), .A0(QI15));
BUF \$1I193  (.Z0(Q14), .A0(QI14));
BUF \$1I194  (.Z0(Q13), .A0(QI13));
BUF \$1I195  (.Z0(Q12), .A0(QI12));
BUF \$1I196  (.Z0(Q11), .A0(QI11));
BUF \$1I197  (.Z0(Q10), .A0(QI10));
BUF \$1I198  (.Z0(Q9), .A0(QI9));
BUF \$1I199  (.Z0(Q8), .A0(QI8));
FD21 \$1I2  (.Q0(QI1), .D0(\$1N16 ), .CLK(CLK), .CD(CD));
BUF \$1I200  (.Z0(Q7), .A0(QI7));
BUF \$1I201  (.Z0(Q6), .A0(QI6));
BUF \$1I202  (.Z0(Q5), .A0(QI5));
BUF \$1I203  (.Z0(Q4), .A0(QI4));
BUF \$1I204  (.Z0(Q3), .A0(QI3));
BUF \$1I205  (.Z0(Q2), .A0(QI2));
BUF \$1I206  (.Z0(Q1), .A0(QI1));
BUF \$1I207  (.Z0(Q0), .A0(QI0));
LXOR2 \$1I21  (.Z0(\$1N20 ), .A0(QI3), .A1(\$1N94 ));
FD21 \$1I3  (.Q0(QI2), .D0(\$1N18 ), .CLK(CLK), .CD(CD));
FD21 \$1I4  (.Q0(QI3), .D0(\$1N20 ), .CLK(CLK), .CD(CD));
AND2 \$1I60  (.Z0(\$1N58 ), .A0(QI0), .A1(EN));
AND3 \$1I81  (.Z0(\$1N66 ), .A0(QI0), .A1(QI1), .A2(EN));
FD21 \$2I11  (.Q0(QI5), .D0(\$2N10 ), .CLK(CLK), .CD(CD));
FD21 \$2I13  (.Q0(QI6), .D0(\$2N15 ), .CLK(CLK), .CD(CD));
FD21 \$2I14  (.Q0(QI4), .D0(\$2N12 ), .CLK(CLK), .CD(CD));
LXOR2 \$2I37  (.Z0(\$2N4 ), .A0(QI7), .A1(\$2N28 ));
LXOR2 \$2I38  (.Z0(\$2N15 ), .A0(QI6), .A1(\$2N27 ));
LXOR2 \$2I39  (.Z0(\$2N10 ), .A0(QI5), .A1(\$2N26 ));
LXOR2 \$2I40  (.Z0(\$2N12 ), .A0(QI4), .A1(\$2N33 ));
AND5 \$2I42  (.Z0(\$2N33 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(EN));
FD21 \$2I5  (.Q0(QI7), .D0(\$2N4 ), .CLK(CLK), .CD(CD));
AND6 \$2I50  (.Z0(\$2N26 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(EN));
AND7 \$2I55  (.Z0(\$2N27 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(EN));
AND8 \$2I60  (.Z0(\$2N28 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(EN));
FD21 \$3I15  (.Q0(QI8), .D0(\$3N30 ), .CLK(CLK), .CD(CD));
FD21 \$3I16  (.Q0(QI10), .D0(\$3N29 ), .CLK(CLK), .CD(CD));
FD21 \$3I17  (.Q0(QI9), .D0(\$3N31 ), .CLK(CLK), .CD(CD));
FD21 \$3I18  (.Q0(QI11), .D0(\$3N34 ), .CLK(CLK), .CD(CD));
LXOR2 \$3I3  (.Z0(\$3N30 ), .A0(QI8), .A1(\$3N2 ));
LXOR2 \$3I4  (.Z0(\$3N31 ), .A0(QI9), .A1(\$3N23 ));
AND9 \$3I44  (.Z0(\$3N2 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(EN));
LXOR2 \$3I5  (.Z0(\$3N29 ), .A0(QI10), .A1(\$3N22 ));
AND10 \$3I50  (.Z0(\$3N23 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(EN));
AND11 \$3I56  (.Z0(\$3N22 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(EN));
LXOR2 \$3I6  (.Z0(\$3N34 ), .A0(QI11), .A1(\$3N21 ));
AND12 \$3I62  (.Z0(\$3N21 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(QI10), 
	.A11(EN));
LXOR2 \$4I16  (.Z0(\$4N15 ), .A0(QI14), .A1(\$4N13 ));
FD21 \$4I2  (.Q0(QI15), .D0(\$4N6 ), .CLK(CLK), .CD(CD));
FD21 \$4I20  (.Q0(QI13), .D0(\$4N29 ), .CLK(CLK), .CD(CD));
FD21 \$4I21  (.Q0(QI12), .D0(\$4N30 ), .CLK(CLK), .CD(CD));
LXOR2 \$4I27  (.Z0(\$4N29 ), .A0(QI13), .A1(\$4N34 ));
LXOR2 \$4I28  (.Z0(\$4N30 ), .A0(QI12), .A1(\$4N19 ));
FD21 \$4I36  (.Q0(QI14), .D0(\$4N15 ), .CLK(CLK), .CD(CD));
LXOR2 \$4I4  (.Z0(\$4N6 ), .A0(QI15), .A1(\$4N10 ));
AND12 \$4I44  (.Z0(\$4N55 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(QI10), 
	.A11(QI11));
AND2 \$4I53  (.Z0(\$4N19 ), .A0(\$4N55 ), .A1(EN));
AND12 \$4I57  (.Z0(\$4N64 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(QI10), 
	.A11(QI11));
AND3 \$4I61  (.Z0(\$4N34 ), .A0(\$4N64 ), .A1(QI12), .A2(EN));
AND12 \$4I66  (.Z0(\$4N72 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(QI10), 
	.A11(QI11));
AND4 \$4I69  (.Z0(\$4N13 ), .A0(\$4N72 ), .A1(QI12), .A2(QI13), 
	.A3(EN));
AND16 \$4I84  (.Z0(\$4N10 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(QI10), 
	.A11(QI11), .A12(QI12), .A13(QI13), .A14(QI14), 
	.A15(EN));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:02:44 1994
`timescale 10 ps / 10 ps 
module CBU616(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	Q8, Q9, Q10, Q11, 
	Q12, Q13, Q14, Q15, 
	CAO, CLK, EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output Q8;
	output Q9;
	output Q10;
	output Q11;
	output Q12;
	output Q13;
	output Q14;
	output Q15;
	output CAO;
	input CLK;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N14 ), .CLK(CLK), .CD(CD));
AND4 \$1I101  (.Z0(\$1N94 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(EN));
AND16 \$1I108  (.Z0(\$1N110 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(QI10), 
	.A11(QI11), .A12(QI12), .A13(QI13), .A14(QI14), 
	.A15(QI15));
AND2 \$1I109  (.Z0(CAO), .A0(\$1N110 ), .A1(EN));
LXOR2 \$1I13  (.Z0(\$1N14 ), .A0(QI0), .A1(EN));
LXOR2 \$1I17  (.Z0(\$1N16 ), .A0(QI1), .A1(\$1N58 ));
LXOR2 \$1I19  (.Z0(\$1N18 ), .A0(QI2), .A1(\$1N66 ));
BUF \$1I192  (.Z0(Q15), .A0(QI15));
BUF \$1I193  (.Z0(Q14), .A0(QI14));
BUF \$1I194  (.Z0(Q13), .A0(QI13));
BUF \$1I195  (.Z0(Q12), .A0(QI12));
BUF \$1I196  (.Z0(Q11), .A0(QI11));
BUF \$1I197  (.Z0(Q10), .A0(QI10));
BUF \$1I198  (.Z0(Q9), .A0(QI9));
BUF \$1I199  (.Z0(Q8), .A0(QI8));
FD21 \$1I2  (.Q0(QI1), .D0(\$1N16 ), .CLK(CLK), .CD(CD));
BUF \$1I200  (.Z0(Q7), .A0(QI7));
BUF \$1I201  (.Z0(Q6), .A0(QI6));
BUF \$1I202  (.Z0(Q5), .A0(QI5));
BUF \$1I203  (.Z0(Q4), .A0(QI4));
BUF \$1I204  (.Z0(Q3), .A0(QI3));
BUF \$1I205  (.Z0(Q2), .A0(QI2));
BUF \$1I206  (.Z0(Q1), .A0(QI1));
BUF \$1I207  (.Z0(Q0), .A0(QI0));
LXOR2 \$1I21  (.Z0(\$1N20 ), .A0(QI3), .A1(\$1N94 ));
FD21 \$1I3  (.Q0(QI2), .D0(\$1N18 ), .CLK(CLK), .CD(CD));
FD21 \$1I4  (.Q0(QI3), .D0(\$1N20 ), .CLK(CLK), .CD(CD));
AND2 \$1I60  (.Z0(\$1N58 ), .A0(QI0), .A1(EN));
AND3 \$1I81  (.Z0(\$1N66 ), .A0(QI0), .A1(QI1), .A2(EN));
FD21 \$2I11  (.Q0(QI5), .D0(\$2N10 ), .CLK(CLK), .CD(CD));
FD21 \$2I13  (.Q0(QI6), .D0(\$2N15 ), .CLK(CLK), .CD(CD));
FD21 \$2I14  (.Q0(QI4), .D0(\$2N12 ), .CLK(CLK), .CD(CD));
LXOR2 \$2I37  (.Z0(\$2N4 ), .A0(QI7), .A1(\$2N28 ));
LXOR2 \$2I38  (.Z0(\$2N15 ), .A0(QI6), .A1(\$2N27 ));
LXOR2 \$2I39  (.Z0(\$2N10 ), .A0(QI5), .A1(\$2N26 ));
LXOR2 \$2I40  (.Z0(\$2N12 ), .A0(QI4), .A1(\$2N33 ));
AND5 \$2I42  (.Z0(\$2N33 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(EN));
FD21 \$2I5  (.Q0(QI7), .D0(\$2N4 ), .CLK(CLK), .CD(CD));
AND6 \$2I50  (.Z0(\$2N26 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(EN));
AND7 \$2I55  (.Z0(\$2N27 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(EN));
AND8 \$2I60  (.Z0(\$2N28 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(EN));
FD21 \$3I15  (.Q0(QI8), .D0(\$3N30 ), .CLK(CLK), .CD(CD));
FD21 \$3I16  (.Q0(QI10), .D0(\$3N29 ), .CLK(CLK), .CD(CD));
FD21 \$3I17  (.Q0(QI9), .D0(\$3N31 ), .CLK(CLK), .CD(CD));
FD21 \$3I18  (.Q0(QI11), .D0(\$3N34 ), .CLK(CLK), .CD(CD));
LXOR2 \$3I3  (.Z0(\$3N30 ), .A0(QI8), .A1(\$3N2 ));
LXOR2 \$3I4  (.Z0(\$3N31 ), .A0(QI9), .A1(\$3N23 ));
AND9 \$3I44  (.Z0(\$3N2 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(EN));
LXOR2 \$3I5  (.Z0(\$3N29 ), .A0(QI10), .A1(\$3N22 ));
AND10 \$3I50  (.Z0(\$3N23 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(EN));
AND11 \$3I56  (.Z0(\$3N22 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(EN));
LXOR2 \$3I6  (.Z0(\$3N34 ), .A0(QI11), .A1(\$3N21 ));
AND12 \$3I62  (.Z0(\$3N21 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(QI10), 
	.A11(EN));
LXOR2 \$4I16  (.Z0(\$4N15 ), .A0(QI14), .A1(\$4N13 ));
FD21 \$4I2  (.Q0(QI15), .D0(\$4N6 ), .CLK(CLK), .CD(CD));
FD21 \$4I20  (.Q0(QI13), .D0(\$4N29 ), .CLK(CLK), .CD(CD));
FD21 \$4I21  (.Q0(QI12), .D0(\$4N30 ), .CLK(CLK), .CD(CD));
LXOR2 \$4I27  (.Z0(\$4N29 ), .A0(QI13), .A1(\$4N34 ));
LXOR2 \$4I28  (.Z0(\$4N30 ), .A0(QI12), .A1(\$4N19 ));
FD21 \$4I36  (.Q0(QI14), .D0(\$4N15 ), .CLK(CLK), .CD(CD));
LXOR2 \$4I4  (.Z0(\$4N6 ), .A0(QI15), .A1(\$4N10 ));
AND12 \$4I44  (.Z0(\$4N55 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(QI10), 
	.A11(QI11));
AND2 \$4I53  (.Z0(\$4N19 ), .A0(\$4N55 ), .A1(EN));
AND12 \$4I57  (.Z0(\$4N64 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(QI10), 
	.A11(QI11));
AND3 \$4I61  (.Z0(\$4N34 ), .A0(\$4N64 ), .A1(QI12), .A2(EN));
AND12 \$4I66  (.Z0(\$4N72 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(QI10), 
	.A11(QI11));
AND4 \$4I69  (.Z0(\$4N13 ), .A0(\$4N72 ), .A1(QI12), .A2(QI13), 
	.A3(EN));
AND16 \$4I84  (.Z0(\$4N10 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(QI10), 
	.A11(QI11), .A12(QI12), .A13(QI13), .A14(QI14), 
	.A15(EN));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:02:52 1994
`timescale 10 ps / 10 ps 
module CBU716(
	CAO, Q0, Q1, Q10, 
	Q11, Q12, Q13, Q14, 
	Q15, Q2, Q3, Q4, 
	Q5, Q6, Q7, Q8, 
	Q9, CAI, CD, CLK, 
	D0, D1, D10, D11, 
	D12, D13, D14, D15, 
	D2, D3, D4, D5, 
	D6, D7, D8, D9, 
	EN, LD);

	output CAO;
	output Q0;
	output Q1;
	output Q10;
	output Q11;
	output Q12;
	output Q13;
	output Q14;
	output Q15;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output Q8;
	output Q9;
	input CAI;
	input CD;
	input CLK;
	input D0;
	input D1;
	input D10;
	input D11;
	input D12;
	input D13;
	input D14;
	input D15;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input D8;
	input D9;
	input EN;
	input LD;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
AND2 \$1I1032  (.Z0(\$1N224 ), .A0(D0), .A1(LD));
AND3 \$1I1033  (.Z0(\$1N226 ), .A0(\$1N501 ), .A1(CAI), .A2(EN));
AND2 \$1I1034  (.Z0(\$1N354 ), .A0(D1), .A1(LD));
AND2 \$1I1038  (.Z0(\$1N395 ), .A0(D2), .A1(LD));
AND2 \$1I1048  (.Z0(\$1N450 ), .A0(D3), .A1(LD));
AND4 \$1I1081  (.Z0(\$1N1083 ), .A0(QI0), .A1(CAI), .A2(\$1N501 ), 
	.A3(EN));
AND5 \$1I1089  (.Z0(\$1N433 ), .A0(QI0), .A1(QI1), .A2(\$1N501 ), 
	.A3(CAI), .A4(EN));
AND6 \$1I1090  (.Z0(\$1N481 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(\$1N501 ), .A4(CAI), .A5(EN));
AND18 \$1I1255  (.Z0(CAO), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(QI10), 
	.A11(QI11), .A12(QI12), .A13(QI13), .A14(QI14), 
	.A15(QI15), .A16(CAI), .A17(EN));
AND2 \$1I1257  (.Z0(\$1N1004 ), .A0(QI0), .A1(\$1N501 ));
OR2 \$1I1258  (.Z0(\$1N312 ), .A0(\$1N224 ), .A1(\$1N226 ));
BUF \$1I1261  (.Z0(Q15), .A0(QI15));
BUF \$1I1262  (.Z0(Q11), .A0(QI11));
BUF \$1I1265  (.Z0(Q9), .A0(QI9));
BUF \$1I1267  (.Z0(Q8), .A0(QI8));
BUF \$1I1271  (.Z0(Q14), .A0(QI14));
BUF \$1I1275  (.Z0(Q13), .A0(QI13));
BUF \$1I1277  (.Z0(Q12), .A0(QI12));
BUF \$1I1281  (.Z0(Q7), .A0(QI7));
BUF \$1I1285  (.Z0(Q2), .A0(QI2));
BUF \$1I1289  (.Z0(Q6), .A0(QI6));
BUF \$1I1294  (.Z0(Q4), .A0(QI4));
BUF \$1I1296  (.Z0(Q3), .A0(QI3));
BUF \$1I1299  (.Z0(Q1), .A0(QI1));
BUF \$1I1300  (.Z0(Q0), .A0(QI0));
BUF \$1I1304  (.Z0(Q5), .A0(QI5));
BUF \$1I1305  (.Z0(Q10), .A0(QI10));
AND2 \$1I1374  (.Z0(\$1N357 ), .A0(QI1), .A1(\$1N501 ));
OR2 \$1I1375  (.Z0(\$1N365 ), .A0(\$1N354 ), .A1(\$1N1083 ));
AND2 \$1I1376  (.Z0(\$1N398 ), .A0(QI2), .A1(\$1N501 ));
OR2 \$1I1377  (.Z0(\$1N419 ), .A0(\$1N395 ), .A1(\$1N433 ));
AND2 \$1I1378  (.Z0(\$1N452 ), .A0(QI3), .A1(\$1N501 ));
OR2 \$1I1379  (.Z0(\$1N473 ), .A0(\$1N450 ), .A1(\$1N481 ));
OR2 \$1I1388  (.Z0(\$1N1400 ), .A0(\$1N1390 ), .A1(\$1N1392 ));
AND2 \$1I1389  (.Z0(\$1N1394 ), .A0(QI4), .A1(\$1N501 ));
LXOR2 \$1I1395  (.Z0(\$1N1391 ), .A0(\$1N1394 ), .A1(\$1N1400 ));
FD21 \$1I1396  (.Q0(QI4), .D0(\$1N1391 ), .CLK(CLK), .CD(CD));
AND2 \$1I1399  (.Z0(\$1N1390 ), .A0(D4), .A1(LD));
AND7 \$1I1408  (.Z0(\$1N1392 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(\$1N501 ), .A5(CAI), .A6(EN));
FD21 \$1I155  (.Q0(QI2), .D0(\$1N915 ), .CLK(CLK), .CD(CD));
FD21 \$1I175  (.Q0(QI3), .D0(\$1N921 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(\$1N357 ), .A1(\$1N365 ));
INV \$1I38  (.ZN0(\$1N501 ), .A0(LD));
LXOR2 \$1I400  (.Z0(\$1N915 ), .A0(\$1N398 ), .A1(\$1N419 ));
LXOR2 \$1I454  (.Z0(\$1N921 ), .A0(\$1N452 ), .A1(\$1N473 ));
AND10 \$2I1  (.Z0(\$2N2 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(\$2N4 ), .A8(CAI), .A9(EN));
INV \$2I100  (.ZN0(\$2N4 ), .A0(LD));
AND2 \$2I143  (.Z0(\$2N35 ), .A0(QI5), .A1(\$2N4 ));
OR2 \$2I144  (.Z0(\$2N72 ), .A0(\$2N28 ), .A1(\$2N74 ));
AND2 \$2I145  (.Z0(\$2N8 ), .A0(QI6), .A1(\$2N4 ));
OR2 \$2I146  (.Z0(\$2N68 ), .A0(\$2N10 ), .A1(\$2N70 ));
AND2 \$2I147  (.Z0(\$2N29 ), .A0(QI7), .A1(\$2N4 ));
OR2 \$2I148  (.Z0(\$2N64 ), .A0(\$2N31 ), .A1(\$2N2 ));
OR2 \$2I156  (.Z0(\$2N166 ), .A0(\$2N158 ), .A1(\$2N171 ));
AND2 \$2I157  (.Z0(\$2N161 ), .A0(QI8), .A1(\$2N4 ));
LXOR2 \$2I162  (.Z0(\$2N159 ), .A0(\$2N161 ), .A1(\$2N166 ));
AND2 \$2I165  (.Z0(\$2N158 ), .A0(D8), .A1(LD));
FD21 \$2I170  (.Q0(QI8), .D0(\$2N159 ), .CLK(CLK), .CD(CD));
AND11 \$2I172  (.Z0(\$2N171 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(\$2N4 ), .A9(CAI), .A10(EN));
AND8 \$2I27  (.Z0(\$2N74 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(\$2N4 ), .A6(CAI), 
	.A7(EN));
AND2 \$2I34  (.Z0(\$2N28 ), .A0(D5), .A1(LD));
FD21 \$2I44  (.Q0(QI7), .D0(\$2N30 ), .CLK(CLK), .CD(CD));
FD21 \$2I46  (.Q0(QI6), .D0(\$2N7 ), .CLK(CLK), .CD(CD));
FD21 \$2I47  (.Q0(QI5), .D0(\$2N36 ), .CLK(CLK), .CD(CD));
AND2 \$2I6  (.Z0(\$2N10 ), .A0(D6), .A1(LD));
LXOR2 \$2I63  (.Z0(\$2N30 ), .A0(\$2N29 ), .A1(\$2N64 ));
AND2 \$2I66  (.Z0(\$2N31 ), .A0(D7), .A1(LD));
LXOR2 \$2I67  (.Z0(\$2N7 ), .A0(\$2N8 ), .A1(\$2N68 ));
LXOR2 \$2I71  (.Z0(\$2N36 ), .A0(\$2N35 ), .A1(\$2N72 ));
AND9 \$2I9  (.Z0(\$2N70 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(\$2N4 ), 
	.A7(CAI), .A8(EN));
INV \$3I100  (.ZN0(\$3N4 ), .A0(LD));
AND2 \$3I143  (.Z0(\$3N35 ), .A0(QI9), .A1(\$3N4 ));
OR2 \$3I144  (.Z0(\$3N72 ), .A0(\$3N28 ), .A1(\$3N74 ));
AND2 \$3I145  (.Z0(\$3N8 ), .A0(QI10), .A1(\$3N4 ));
OR2 \$3I146  (.Z0(\$3N68 ), .A0(\$3N10 ), .A1(\$3N70 ));
AND2 \$3I147  (.Z0(\$3N29 ), .A0(QI11), .A1(\$3N4 ));
OR2 \$3I148  (.Z0(\$3N64 ), .A0(\$3N31 ), .A1(\$3N2 ));
AND12 \$3I154  (.Z0(\$3N74 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(\$3N4 ), .A10(CAI), 
	.A11(EN));
AND13 \$3I160  (.Z0(\$3N70 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(\$3N4 ), 
	.A11(CAI), .A12(EN));
AND14 \$3I166  (.Z0(\$3N2 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(QI10), 
	.A11(\$3N4 ), .A12(CAI), .A13(EN));
AND2 \$3I34  (.Z0(\$3N28 ), .A0(D9), .A1(LD));
FD21 \$3I44  (.Q0(QI11), .D0(\$3N30 ), .CLK(CLK), .CD(CD));
FD21 \$3I46  (.Q0(QI10), .D0(\$3N7 ), .CLK(CLK), .CD(CD));
FD21 \$3I47  (.Q0(QI9), .D0(\$3N36 ), .CLK(CLK), .CD(CD));
AND2 \$3I6  (.Z0(\$3N10 ), .A0(D10), .A1(LD));
LXOR2 \$3I63  (.Z0(\$3N30 ), .A0(\$3N29 ), .A1(\$3N64 ));
AND2 \$3I66  (.Z0(\$3N31 ), .A0(D11), .A1(LD));
LXOR2 \$3I67  (.Z0(\$3N7 ), .A0(\$3N8 ), .A1(\$3N68 ));
LXOR2 \$3I71  (.Z0(\$3N36 ), .A0(\$3N35 ), .A1(\$3N72 ));
INV \$4I100  (.ZN0(\$4N184 ), .A0(LD));
AND2 \$4I140  (.Z0(\$4N39 ), .A0(QI12), .A1(\$4N184 ));
OR2 \$4I141  (.Z0(\$4N76 ), .A0(\$4N38 ), .A1(\$4N78 ));
AND2 \$4I143  (.Z0(\$4N35 ), .A0(QI13), .A1(\$4N184 ));
OR2 \$4I144  (.Z0(\$4N72 ), .A0(\$4N28 ), .A1(\$4N74 ));
AND15 \$4I171  (.Z0(\$4N78 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(QI10), 
	.A11(QI11), .A12(\$4N184 ), .A13(CAI), .A14(EN));
AND16 \$4I176  (.Z0(\$4N74 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(QI10), 
	.A11(QI11), .A12(QI12), .A13(\$4N184 ), .A14(CAI), 
	.A15(EN));
AND2 \$4I34  (.Z0(\$4N28 ), .A0(D13), .A1(LD));
AND2 \$4I37  (.Z0(\$4N38 ), .A0(D12), .A1(LD));
FD21 \$4I47  (.Q0(QI13), .D0(\$4N36 ), .CLK(CLK), .CD(CD));
FD21 \$4I48  (.Q0(QI12), .D0(\$4N40 ), .CLK(CLK), .CD(CD));
LXOR2 \$4I71  (.Z0(\$4N36 ), .A0(\$4N35 ), .A1(\$4N72 ));
LXOR2 \$4I75  (.Z0(\$4N40 ), .A0(\$4N39 ), .A1(\$4N76 ));
INV \$5I100  (.ZN0(\$5N4 ), .A0(LD));
AND2 \$5I145  (.Z0(\$5N8 ), .A0(QI14), .A1(\$5N4 ));
OR2 \$5I146  (.Z0(\$5N68 ), .A0(\$5N10 ), .A1(\$5N70 ));
AND2 \$5I147  (.Z0(\$5N29 ), .A0(QI15), .A1(\$5N4 ));
OR2 \$5I148  (.Z0(\$5N64 ), .A0(\$5N31 ), .A1(\$5N2 ));
AND17 \$5I186  (.Z0(\$5N70 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(QI10), 
	.A11(QI11), .A12(QI12), .A13(QI13), .A14(\$5N4 ), 
	.A15(CAI), .A16(EN));
AND18 \$5I192  (.Z0(\$5N2 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(QI8), .A9(QI9), .A10(QI10), 
	.A11(QI11), .A12(QI12), .A13(QI13), .A14(QI14), 
	.A15(\$5N4 ), .A16(CAI), .A17(EN));
FD21 \$5I44  (.Q0(QI15), .D0(\$5N30 ), .CLK(CLK), .CD(CD));
FD21 \$5I46  (.Q0(QI14), .D0(\$5N7 ), .CLK(CLK), .CD(CD));
AND2 \$5I6  (.Z0(\$5N10 ), .A0(D14), .A1(LD));
LXOR2 \$5I63  (.Z0(\$5N30 ), .A0(\$5N29 ), .A1(\$5N64 ));
AND2 \$5I66  (.Z0(\$5N31 ), .A0(D15), .A1(LD));
LXOR2 \$5I67  (.Z0(\$5N7 ), .A0(\$5N8 ), .A1(\$5N68 ));
endmodule
`timescale 10 ps / 10 ps
module CBU84(
	CAI, CAO, CLK, EN, SD, Q0, Q1, Q2, Q3);


	input CAI;
	output CAO;
	input CLK;
	input EN;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



FDC1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD));
BUF \$1I1163  (.Z0 (Q3), .A0 (QI3));
AND5 \$1I1136  (.Z0 (\$1N473 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (CAI), .A4 (EN));
AND3 \$1I1134  (.Z0 (\$1N365 ), .A0 (QI0), .A1 (CAI), 
	.A2 (EN));
AND4 \$1I1135  (.Z0 (\$1N419 ), .A0 (QI0), .A1 (QI1), 
	.A2 (CAI), .A3 (EN));
AND2 \$1I1133  (.Z0 (\$1N226 ), .A0 (CAI), .A1 (EN));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (QI0), .A1 (\$1N226 ));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (QI1), .A1 (\$1N365 ));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (QI2), .A1 (\$1N419 ));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (QI3), .A1 (\$1N473 ));
AND6 \$1I1144  (.Z0 (CAO), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (CAI), 
	.A5 (EN));
BUF \$1I1166  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1164  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1165  (.Z0 (Q0), .A0 (QI0));
endmodule
`timescale 10 ps / 10 ps
module CBU88(
	CAI, CAO, CLK, EN, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CAI;
	output CAO;
	input CLK;
	input EN;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



FDC1 \$1I858  (.Q0 (QI7), .D0 (\$1N935 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I809  (.Q0 (QI6), .D0 (\$1N930 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I723  (.Q0 (QI4), .D0 (\$1N924 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I773  (.Q0 (QI5), .D0 (\$1N929 ), .CLK (CLK), 
	.SD (SD));
LXOR2 \$1I856  (.Z0 (\$1N935 ), .A0 (QI7), .A1 (\$1N854 ));
LXOR2 \$1I811  (.Z0 (\$1N930 ), .A0 (QI6), .A1 (\$1N813 ));
LXOR2 \$1I771  (.Z0 (\$1N929 ), .A0 (QI5), .A1 (\$1N769 ));
LXOR2 \$1I721  (.Z0 (\$1N924 ), .A0 (QI4), .A1 (\$1N719 ));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (QI3), .A1 (\$1N473 ));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (QI2), .A1 (\$1N419 ));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (QI1), .A1 (\$1N365 ));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (QI0), .A1 (\$1N226 ));
AND3 \$1I1134  (.Z0 (\$1N365 ), .A0 (QI0), .A1 (CAI), 
	.A2 (EN));
AND4 \$1I1135  (.Z0 (\$1N419 ), .A0 (QI0), .A1 (QI1), 
	.A2 (CAI), .A3 (EN));
AND5 \$1I1136  (.Z0 (\$1N473 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (CAI), .A4 (EN));
AND6 \$1I1137  (.Z0 (\$1N719 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (CAI), 
	.A5 (EN));
AND7 \$1I1138  (.Z0 (\$1N769 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (CAI), .A6 (EN));
AND8 \$1I1139  (.Z0 (\$1N813 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (CAI), .A7 (EN));
AND9 \$1I1140  (.Z0 (\$1N854 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (CAI), 
	.A8 (EN));
AND10 \$1I1120  (.Z0 (CAO), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (QI7), 
	.A8 (CAI), .A9 (EN));
AND2 \$1I1133  (.Z0 (\$1N226 ), .A0 (CAI), .A1 (EN));
BUF \$1I1224  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1232  (.Z0 (Q3), .A0 (QI3));
BUF \$1I1228  (.Z0 (Q4), .A0 (QI4));
BUF \$1I1220  (.Z0 (Q5), .A0 (QI5));
BUF \$1I1194  (.Z0 (Q6), .A0 (QI6));
BUF \$1I1190  (.Z0 (Q7), .A0 (QI7));
BUF \$1I1211  (.Z0 (Q0), .A0 (QI0));
BUF \$1I1215  (.Z0 (Q1), .A0 (QI1));
FDC1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD));
endmodule
`timescale 10 ps / 10 ps
module CBU94(
	CAI, CAO, CD, CLK, EN, SD, Q0, Q1, Q2, Q3);


	input CAI;
	output CAO;
	input CD;
	input CLK;
	input EN;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



FDE1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
BUF \$1I1163  (.Z0 (Q3), .A0 (QI3));
AND5 \$1I1136  (.Z0 (\$1N473 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (CAI), .A4 (EN));
AND3 \$1I1134  (.Z0 (\$1N365 ), .A0 (QI0), .A1 (CAI), 
	.A2 (EN));
AND4 \$1I1135  (.Z0 (\$1N419 ), .A0 (QI0), .A1 (QI1), 
	.A2 (CAI), .A3 (EN));
AND2 \$1I1133  (.Z0 (\$1N226 ), .A0 (CAI), .A1 (EN));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (QI0), .A1 (\$1N226 ));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (QI1), .A1 (\$1N365 ));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (QI2), .A1 (\$1N419 ));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (QI3), .A1 (\$1N473 ));
AND6 \$1I1144  (.Z0 (CAO), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (CAI), 
	.A5 (EN));
BUF \$1I1166  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1164  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1165  (.Z0 (Q0), .A0 (QI0));
endmodule
`timescale 10 ps / 10 ps
module CBU98(
	CAI, CAO, CD, CLK, EN, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CAI;
	output CAO;
	input CD;
	input CLK;
	input EN;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



FDE1 \$1I858  (.Q0 (QI7), .D0 (\$1N935 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I809  (.Q0 (QI6), .D0 (\$1N930 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I723  (.Q0 (QI4), .D0 (\$1N924 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I773  (.Q0 (QI5), .D0 (\$1N929 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
LXOR2 \$1I856  (.Z0 (\$1N935 ), .A0 (QI7), .A1 (\$1N854 ));
LXOR2 \$1I811  (.Z0 (\$1N930 ), .A0 (QI6), .A1 (\$1N813 ));
LXOR2 \$1I771  (.Z0 (\$1N929 ), .A0 (QI5), .A1 (\$1N769 ));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (QI3), .A1 (\$1N473 ));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (QI2), .A1 (\$1N419 ));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (QI1), .A1 (\$1N365 ));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (QI0), .A1 (\$1N226 ));
AND3 \$1I1134  (.Z0 (\$1N365 ), .A0 (QI0), .A1 (CAI), 
	.A2 (EN));
AND4 \$1I1135  (.Z0 (\$1N419 ), .A0 (QI0), .A1 (QI1), 
	.A2 (CAI), .A3 (EN));
AND6 \$1I1137  (.Z0 (\$1N719 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (CAI), 
	.A5 (EN));
AND7 \$1I1138  (.Z0 (\$1N769 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (CAI), .A6 (EN));
AND8 \$1I1139  (.Z0 (\$1N813 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (CAI), .A7 (EN));
AND9 \$1I1140  (.Z0 (\$1N854 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (CAI), 
	.A8 (EN));
AND2 \$1I1133  (.Z0 (\$1N226 ), .A0 (CAI), .A1 (EN));
BUF \$1I1224  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1232  (.Z0 (Q3), .A0 (QI3));
BUF \$1I1228  (.Z0 (Q4), .A0 (QI4));
BUF \$1I1220  (.Z0 (Q5), .A0 (QI5));
BUF \$1I1194  (.Z0 (Q6), .A0 (QI6));
BUF \$1I1190  (.Z0 (Q7), .A0 (QI7));
BUF \$1I1211  (.Z0 (Q0), .A0 (QI0));
BUF \$1I1215  (.Z0 (Q1), .A0 (QI1));
FDE1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND5 \$1I1136  (.Z0 (\$1N473 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (CAI), .A4 (EN));
LXOR2 \$1I721  (.Z0 (\$1N924 ), .A0 (QI4), .A1 (\$1N719 ));
FDE1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND10 \$1I1120  (.Z0 (CAO), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (QI7), 
	.A8 (CAI), .A9 (EN));
endmodule
`timescale 10 ps / 10 ps
module CBUA16(
	CAI, CAO, CD, CLK, D0, D1, D10, D11, D12, D13, D14, D15, D2, D3, D4, D5, D6, D7, D8, D9, EN, LD, Q0, Q1, Q10, Q11, Q12, Q13, Q14, Q15, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, SD);


	input CAI;
	output CAO;
	input CD;
	input CLK;
	input D0;
	input D1;
	input D10;
	input D11;
	input D12;
	input D13;
	input D14;
	input D15;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input D8;
	input D9;
	input EN;
	input LD;
	output Q0;
	output Q1;
	output Q10;
	output Q11;
	output Q12;
	output Q13;
	output Q14;
	output Q15;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output Q8;
	output Q9;
	input SD;



FDE1 \$1I1396  (.Q0 (QI4), .D0 (\$1N1391 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND2 \$1I1399  (.Z0 (\$1N1390 ), .A0 (D4), .A1 (LD));
BUF \$1I1275  (.Z0 (Q13), .A0 (QI13));
BUF \$1I1271  (.Z0 (Q14), .A0 (QI14));
BUF \$1I1261  (.Z0 (Q15), .A0 (QI15));
BUF \$1I1277  (.Z0 (Q12), .A0 (QI12));
BUF \$1I1262  (.Z0 (Q11), .A0 (QI11));
BUF \$1I1305  (.Z0 (Q10), .A0 (QI10));
BUF \$1I1265  (.Z0 (Q9), .A0 (QI9));
BUF \$1I1267  (.Z0 (Q8), .A0 (QI8));
BUF \$1I1281  (.Z0 (Q7), .A0 (QI7));
BUF \$1I1304  (.Z0 (Q5), .A0 (QI5));
BUF \$1I1289  (.Z0 (Q6), .A0 (QI6));
BUF \$1I1300  (.Z0 (Q0), .A0 (QI0));
BUF \$1I1299  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1285  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1296  (.Z0 (Q3), .A0 (QI3));
INV \$1I38  (.ZN0 (\$1N501 ), .A0 (LD));
AND6 \$1I1090  (.Z0 (\$1N481 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (\$1N501 ), .A4 (CAI), 
	.A5 (EN));
AND2 \$1I1048  (.Z0 (\$1N450 ), .A0 (D3), .A1 (LD));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (\$1N452 ), .A1 (\$1N473 ));
AND2 \$1I1038  (.Z0 (\$1N395 ), .A0 (D2), .A1 (LD));
AND5 \$1I1089  (.Z0 (\$1N433 ), .A0 (QI0), .A1 (QI1), 
	.A2 (\$1N501 ), .A3 (CAI), .A4 (EN));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (\$1N398 ), .A1 (\$1N419 ));
OR2 \$1I1258  (.Z0 (\$1N312 ), .A0 (\$1N224 ), .A1 (\$1N226 ));
OR2 \$1I1375  (.Z0 (\$1N365 ), .A0 (\$1N354 ), .A1 (\$1N1083 ));
AND2 \$1I1034  (.Z0 (\$1N354 ), .A0 (D1), .A1 (LD));
AND4 \$1I1081  (.Z0 (\$1N1083 ), .A0 (QI0), .A1 (CAI), 
	.A2 (\$1N501 ), .A3 (EN));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (\$1N357 ), .A1 (\$1N365 ));
AND3 \$1I1033  (.Z0 (\$1N226 ), .A0 (\$1N501 ), .A1 (CAI), 
	.A2 (EN));
AND2 \$1I1032  (.Z0 (\$1N224 ), .A0 (D0), .A1 (LD));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (\$1N1004 ), .A1 (\$1N312 ));
AND2 \$1I1257  (.Z0 (\$1N1004 ), .A0 (QI0), .A1 (\$1N501 ));
BUF \$1I1294  (.Z0 (Q4), .A0 (QI4));
AND2 \$1I1374  (.Z0 (\$1N357 ), .A0 (QI1), .A1 (\$1N501 ));
AND2 \$1I1376  (.Z0 (\$1N398 ), .A0 (QI2), .A1 (\$1N501 ));
OR2 \$1I1377  (.Z0 (\$1N419 ), .A0 (\$1N395 ), .A1 (\$1N433 ));
AND2 \$1I1378  (.Z0 (\$1N452 ), .A0 (QI3), .A1 (\$1N501 ));
OR2 \$1I1379  (.Z0 (\$1N473 ), .A0 (\$1N450 ), .A1 (\$1N481 ));
AND7 \$1I1408  (.Z0 (\$1N1392 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (\$1N501 ), 
	.A5 (CAI), .A6 (EN));
LXOR2 \$1I1395  (.Z0 (\$1N1391 ), .A0 (\$1N1394 ), .A1 (\$1N1400 ));
AND2 \$1I1389  (.Z0 (\$1N1394 ), .A0 (QI4), .A1 (\$1N501 ));
OR2 \$1I1388  (.Z0 (\$1N1400 ), .A0 (\$1N1390 ), .A1 (\$1N1392 ));
FDE1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND18 \$1I1255  (.Z0 (CAO), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (QI7), 
	.A8 (QI8), .A9 (QI9), .A10 (QI10), 
	.A11 (QI11), .A12 (QI12), .A13 (QI13), 
	.A14 (QI14), .A15 (QI15), .A16 (CAI), 
	.A17 (EN));
FDE1 \$2I44  (.Q0 (QI7), .D0 (\$2N30 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$2I46  (.Q0 (QI6), .D0 (\$2N7 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$2I170  (.Q0 (QI8), .D0 (\$2N159 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$2I47  (.Q0 (QI5), .D0 (\$2N36 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND10 \$2I1  (.Z0 (\$2N2 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (\$2N4 ), 
	.A8 (CAI), .A9 (EN));
LXOR2 \$2I71  (.Z0 (\$2N36 ), .A0 (\$2N35 ), .A1 (\$2N72 ));
AND2 \$2I66  (.Z0 (\$2N31 ), .A0 (D7), .A1 (LD));
LXOR2 \$2I63  (.Z0 (\$2N30 ), .A0 (\$2N29 ), .A1 (\$2N64 ));
AND2 \$2I6  (.Z0 (\$2N10 ), .A0 (D6), .A1 (LD));
AND9 \$2I9  (.Z0 (\$2N70 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (\$2N4 ), .A7 (CAI), 
	.A8 (EN));
LXOR2 \$2I67  (.Z0 (\$2N7 ), .A0 (\$2N8 ), .A1 (\$2N68 ));
AND2 \$2I34  (.Z0 (\$2N28 ), .A0 (D5), .A1 (LD));
AND8 \$2I27  (.Z0 (\$2N74 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (\$2N4 ), .A6 (CAI), .A7 (EN));
INV \$2I100  (.ZN0 (\$2N4 ), .A0 (LD));
AND2 \$2I143  (.Z0 (\$2N35 ), .A0 (QI5), .A1 (\$2N4 ));
OR2 \$2I144  (.Z0 (\$2N72 ), .A0 (\$2N28 ), .A1 (\$2N74 ));
AND2 \$2I145  (.Z0 (\$2N8 ), .A0 (QI6), .A1 (\$2N4 ));
OR2 \$2I146  (.Z0 (\$2N68 ), .A0 (\$2N10 ), .A1 (\$2N70 ));
AND2 \$2I147  (.Z0 (\$2N29 ), .A0 (QI7), .A1 (\$2N4 ));
OR2 \$2I148  (.Z0 (\$2N64 ), .A0 (\$2N31 ), .A1 (\$2N2 ));
AND11 \$2I172  (.Z0 (\$2N171 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (QI7), 
	.A8 (\$2N4 ), .A9 (CAI), .A10 (EN));
AND2 \$2I165  (.Z0 (\$2N158 ), .A0 (D8), .A1 (LD));
LXOR2 \$2I162  (.Z0 (\$2N159 ), .A0 (\$2N161 ), .A1 (\$2N166 ));
AND2 \$2I157  (.Z0 (\$2N161 ), .A0 (QI8), .A1 (\$2N4 ));
OR2 \$2I156  (.Z0 (\$2N166 ), .A0 (\$2N158 ), .A1 (\$2N171 ));
FDE1 \$3I47  (.Q0 (QI9), .D0 (\$3N36 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$3I44  (.Q0 (QI11), .D0 (\$3N30 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND12 \$3I154  (.Z0 (\$3N74 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (QI7), 
	.A8 (QI8), .A9 (\$3N4 ), .A10 (CAI), 
	.A11 (EN));
AND2 \$3I145  (.Z0 (\$3N8 ), .A0 (QI10), .A1 (\$3N4 ));
LXOR2 \$3I71  (.Z0 (\$3N36 ), .A0 (\$3N35 ), .A1 (\$3N72 ));
AND2 \$3I143  (.Z0 (\$3N35 ), .A0 (QI9), .A1 (\$3N4 ));
AND2 \$3I66  (.Z0 (\$3N31 ), .A0 (D11), .A1 (LD));
AND2 \$3I6  (.Z0 (\$3N10 ), .A0 (D10), .A1 (LD));
LXOR2 \$3I67  (.Z0 (\$3N7 ), .A0 (\$3N8 ), .A1 (\$3N68 ));
AND2 \$3I34  (.Z0 (\$3N28 ), .A0 (D9), .A1 (LD));
INV \$3I100  (.ZN0 (\$3N4 ), .A0 (LD));
OR2 \$3I144  (.Z0 (\$3N72 ), .A0 (\$3N28 ), .A1 (\$3N74 ));
OR2 \$3I146  (.Z0 (\$3N68 ), .A0 (\$3N10 ), .A1 (\$3N70 ));
OR2 \$3I148  (.Z0 (\$3N64 ), .A0 (\$3N31 ), .A1 (\$3N2 ));
AND2 \$3I147  (.Z0 (\$3N29 ), .A0 (QI11), .A1 (\$3N4 ));
LXOR2 \$3I63  (.Z0 (\$3N30 ), .A0 (\$3N29 ), .A1 (\$3N64 ));
AND13 \$3I160  (.Z0 (\$3N70 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (QI7), 
	.A8 (QI8), .A9 (QI9), .A10 (\$3N4 ), 
	.A11 (CAI), .A12 (EN));
AND14 \$3I166  (.Z0 (\$3N2 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (QI7), 
	.A8 (QI8), .A9 (QI9), .A10 (QI10), 
	.A11 (\$3N4 ), .A12 (CAI), .A13 (EN));
FDE1 \$3I46  (.Q0 (QI10), .D0 (\$3N7 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$4I47  (.Q0 (QI13), .D0 (\$4N36 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$4I48  (.Q0 (QI12), .D0 (\$4N40 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
LXOR2 \$4I71  (.Z0 (\$4N36 ), .A0 (\$4N35 ), .A1 (\$4N72 ));
AND2 \$4I143  (.Z0 (\$4N35 ), .A0 (QI13), .A1 (\$4N184 ));
AND2 \$4I34  (.Z0 (\$4N28 ), .A0 (D13), .A1 (LD));
AND2 \$4I37  (.Z0 (\$4N38 ), .A0 (D12), .A1 (LD));
LXOR2 \$4I75  (.Z0 (\$4N40 ), .A0 (\$4N39 ), .A1 (\$4N76 ));
INV \$4I100  (.ZN0 (\$4N184 ), .A0 (LD));
AND2 \$4I140  (.Z0 (\$4N39 ), .A0 (QI12), .A1 (\$4N184 ));
OR2 \$4I141  (.Z0 (\$4N76 ), .A0 (\$4N38 ), .A1 (\$4N78 ));
AND15 \$4I171  (.Z0 (\$4N78 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (QI7), 
	.A8 (QI8), .A9 (QI9), .A10 (QI10), 
	.A11 (QI11), .A12 (\$4N184 ), .A13 (CAI), 
	.A14 (EN));
AND16 \$4I176  (.Z0 (\$4N74 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (QI7), 
	.A8 (QI8), .A9 (QI9), .A10 (QI10), 
	.A11 (QI11), .A12 (QI12), .A13 (\$4N184 ), 
	.A14 (CAI), .A15 (EN));
OR2 \$4I144  (.Z0 (\$4N72 ), .A0 (\$4N28 ), .A1 (\$4N74 ));
FDE1 \$5I46  (.Q0 (QI14), .D0 (\$5N7 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$5I44  (.Q0 (QI15), .D0 (\$5N30 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND18 \$5I192  (.Z0 (\$5N2 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (QI7), 
	.A8 (QI8), .A9 (QI9), .A10 (QI10), 
	.A11 (QI11), .A12 (QI12), .A13 (QI13), 
	.A14 (QI14), .A15 (\$5N4 ), .A16 (CAI), 
	.A17 (EN));
AND17 \$5I186  (.Z0 (\$5N70 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (QI7), 
	.A8 (QI8), .A9 (QI9), .A10 (QI10), 
	.A11 (QI11), .A12 (QI12), .A13 (QI13), 
	.A14 (\$5N4 ), .A15 (CAI), .A16 (EN));
LXOR2 \$5I67  (.Z0 (\$5N7 ), .A0 (\$5N8 ), .A1 (\$5N68 ));
AND2 \$5I145  (.Z0 (\$5N8 ), .A0 (QI14), .A1 (\$5N4 ));
AND2 \$5I6  (.Z0 (\$5N10 ), .A0 (D14), .A1 (LD));
INV \$5I100  (.ZN0 (\$5N4 ), .A0 (LD));
OR2 \$5I146  (.Z0 (\$5N68 ), .A0 (\$5N10 ), .A1 (\$5N70 ));
OR2 \$5I148  (.Z0 (\$5N64 ), .A0 (\$5N31 ), .A1 (\$5N2 ));
LXOR2 \$5I63  (.Z0 (\$5N30 ), .A0 (\$5N29 ), .A1 (\$5N64 ));
AND2 \$5I66  (.Z0 (\$5N31 ), .A0 (D15), .A1 (LD));
AND2 \$5I147  (.Z0 (\$5N29 ), .A0 (QI15), .A1 (\$5N4 ));
endmodule
`timescale 10 ps / 10 ps
module CBUA4(
	CAI, CAO, CD, CLK, D0, D1, D2, D3, EN, LD, SD, Q0, Q1, Q2, Q3);


	input CAI;
	output CAO;
	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input LD;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



AND3 \$1I1179  (.Z0 (\$1N226 ), .A0 (\$1N501 ), .A1 (CAI), 
	.A2 (EN));
FDE1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
BUF \$1I1166  (.Z0 (Q0), .A0 (QI0));
BUF \$1I1162  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1158  (.Z0 (Q2), .A0 (QI2));
AND6 \$1I1120  (.Z0 (CAO), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (CAI), 
	.A5 (EN));
BUF \$1I1154  (.Z0 (Q3), .A0 (QI3));
AND2 \$1I1032  (.Z0 (\$1N224 ), .A0 (D0), .A1 (LD));
AND2 \$1I1034  (.Z0 (\$1N354 ), .A0 (D1), .A1 (LD));
AND4 \$1I1081  (.Z0 (\$1N1083 ), .A0 (QI0), .A1 (CAI), 
	.A2 (\$1N501 ), .A3 (EN));
AND2 \$1I1048  (.Z0 (\$1N450 ), .A0 (D3), .A1 (LD));
AND6 \$1I1090  (.Z0 (\$1N481 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (\$1N501 ), .A4 (CAI), 
	.A5 (EN));
INV \$1I38  (.ZN0 (\$1N501 ), .A0 (LD));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (\$1N1004 ), .A1 (\$1N312 ));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (\$1N398 ), .A1 (\$1N419 ));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (\$1N452 ), .A1 (\$1N473 ));
OR2 \$1I1082  (.Z0 (\$1N365 ), .A0 (\$1N354 ), .A1 (\$1N1083 ));
OR2 \$1I1087  (.Z0 (\$1N419 ), .A0 (\$1N395 ), .A1 (\$1N433 ));
OR2 \$1I1088  (.Z0 (\$1N473 ), .A0 (\$1N450 ), .A1 (\$1N481 ));
OR2 \$1I298  (.Z0 (\$1N312 ), .A0 (\$1N224 ), .A1 (\$1N226 ));
AND2 \$1I1047  (.Z0 (\$1N452 ), .A0 (QI3), .A1 (\$1N501 ));
AND5 \$1I1089  (.Z0 (\$1N433 ), .A0 (QI0), .A1 (QI1), 
	.A2 (\$1N501 ), .A3 (CAI), .A4 (EN));
AND2 \$1I1037  (.Z0 (\$1N398 ), .A0 (QI2), .A1 (\$1N501 ));
AND2 \$1I1038  (.Z0 (\$1N395 ), .A0 (D2), .A1 (LD));
AND2 \$1I1110  (.Z0 (\$1N357 ), .A0 (QI1), .A1 (\$1N501 ));
AND2 \$1I1031  (.Z0 (\$1N1004 ), .A0 (QI0), .A1 (\$1N501 ));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (\$1N357 ), .A1 (\$1N365 ));
endmodule
`timescale 10 ps / 10 ps
module CBUA8(
	CAI, CAO, CD, CLK, D0, D1, D2, D3, D4, D5, D6, D7, EN, LD, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CAI;
	output CAO;
	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input EN;
	input LD;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



FDE1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND2 \$1I1226  (.Z0 (\$1N452 ), .A0 (QI3), .A1 (\$1N501 ));
AND2 \$1I1225  (.Z0 (\$1N398 ), .A0 (QI2), .A1 (\$1N501 ));
AND2 \$1I1224  (.Z0 (\$1N357 ), .A0 (QI1), .A1 (\$1N501 ));
OR2 \$1I1222  (.Z0 (\$1N473 ), .A0 (\$1N450 ), .A1 (\$1N481 ));
OR2 \$1I1221  (.Z0 (\$1N419 ), .A0 (\$1N395 ), .A1 (\$1N433 ));
OR2 \$1I1220  (.Z0 (\$1N365 ), .A0 (\$1N354 ), .A1 (\$1N1083 ));
OR2 \$1I1219  (.Z0 (\$1N312 ), .A0 (\$1N224 ), .A1 (\$1N226 ));
BUF \$1I1215  (.Z0 (Q0), .A0 (QI0));
BUF \$1I1214  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1210  (.Z0 (Q3), .A0 (QI3));
BUF \$1I1208  (.Z0 (Q4), .A0 (QI4));
BUF \$1I1202  (.Z0 (Q5), .A0 (QI5));
AND2 \$1I1034  (.Z0 (\$1N354 ), .A0 (D1), .A1 (LD));
AND2 \$1I1038  (.Z0 (\$1N395 ), .A0 (D2), .A1 (LD));
AND2 \$1I1048  (.Z0 (\$1N450 ), .A0 (D3), .A1 (LD));
AND4 \$1I1081  (.Z0 (\$1N1083 ), .A0 (QI0), .A1 (CAI), 
	.A2 (\$1N501 ), .A3 (EN));
AND2 \$1I1032  (.Z0 (\$1N224 ), .A0 (D0), .A1 (LD));
AND5 \$1I1089  (.Z0 (\$1N433 ), .A0 (QI0), .A1 (QI1), 
	.A2 (\$1N501 ), .A3 (CAI), .A4 (EN));
AND3 \$1I1033  (.Z0 (\$1N226 ), .A0 (\$1N501 ), .A1 (CAI), 
	.A2 (EN));
AND10 \$1I1120  (.Z0 (CAO), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (QI7), 
	.A8 (CAI), .A9 (EN));
INV \$1I38  (.ZN0 (\$1N501 ), .A0 (LD));
AND6 \$1I1090  (.Z0 (\$1N481 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (\$1N501 ), .A4 (CAI), 
	.A5 (EN));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (\$1N1004 ), .A1 (\$1N312 ));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (\$1N357 ), .A1 (\$1N365 ));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (\$1N398 ), .A1 (\$1N419 ));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (\$1N452 ), .A1 (\$1N473 ));
BUF \$1I1197  (.Z0 (Q7), .A0 (QI7));
BUF \$1I1199  (.Z0 (Q6), .A0 (QI6));
BUF \$1I1212  (.Z0 (Q2), .A0 (QI2));
AND2 \$1I1223  (.Z0 (\$1N1004 ), .A0 (QI0), .A1 (\$1N501 ));
FDE1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$2I44  (.Q0 (QI7), .D0 (\$2N30 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$2I46  (.Q0 (QI6), .D0 (\$2N7 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$2I47  (.Q0 (QI5), .D0 (\$2N36 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$2I48  (.Q0 (QI4), .D0 (\$2N40 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND2 \$2I146  (.Z0 (\$2N29 ), .A0 (QI7), .A1 (\$2N4 ));
AND2 \$2I145  (.Z0 (\$2N8 ), .A0 (QI6), .A1 (\$2N4 ));
AND2 \$2I144  (.Z0 (\$2N35 ), .A0 (QI5), .A1 (\$2N4 ));
AND2 \$2I143  (.Z0 (\$2N39 ), .A0 (QI4), .A1 (\$2N4 ));
OR2 \$2I142  (.Z0 (\$2N64 ), .A0 (\$2N31 ), .A1 (\$2N2 ));
OR2 \$2I141  (.Z0 (\$2N68 ), .A0 (\$2N10 ), .A1 (\$2N70 ));
OR2 \$2I140  (.Z0 (\$2N72 ), .A0 (\$2N28 ), .A1 (\$2N74 ));
OR2 \$2I139  (.Z0 (\$2N76 ), .A0 (\$2N38 ), .A1 (\$2N78 ));
INV \$2I100  (.ZN0 (\$2N4 ), .A0 (LD));
AND2 \$2I66  (.Z0 (\$2N31 ), .A0 (D7), .A1 (LD));
AND2 \$2I37  (.Z0 (\$2N38 ), .A0 (D4), .A1 (LD));
AND2 \$2I34  (.Z0 (\$2N28 ), .A0 (D5), .A1 (LD));
AND8 \$2I27  (.Z0 (\$2N74 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (\$2N4 ), .A6 (CAI), .A7 (EN));
AND7 \$2I23  (.Z0 (\$2N78 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (\$2N4 ), 
	.A5 (CAI), .A6 (EN));
AND9 \$2I9  (.Z0 (\$2N70 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (\$2N4 ), .A7 (CAI), 
	.A8 (EN));
AND2 \$2I6  (.Z0 (\$2N10 ), .A0 (D6), .A1 (LD));
AND10 \$2I1  (.Z0 (\$2N2 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (\$2N4 ), 
	.A8 (CAI), .A9 (EN));
LXOR2 \$2I63  (.Z0 (\$2N30 ), .A0 (\$2N29 ), .A1 (\$2N64 ));
LXOR2 \$2I67  (.Z0 (\$2N7 ), .A0 (\$2N8 ), .A1 (\$2N68 ));
LXOR2 \$2I71  (.Z0 (\$2N36 ), .A0 (\$2N35 ), .A1 (\$2N72 ));
LXOR2 \$2I75  (.Z0 (\$2N40 ), .A0 (\$2N39 ), .A1 (\$2N76 ));
endmodule
`timescale 10 ps / 10 ps
module CBUB4(
	CAI, CAO, CLK, CS, D0, D1, D2, D3, EN, LD, SD, Q0, Q1, Q2, Q3);


	input CAI;
	output CAO;
	input CLK;
	input CS;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input LD;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



AND3 \$1I1138  (.Z0 (\$1N452 ), .A0 (QI3), .A1 (\$1N501 ), 
	.A2 (\$1N820 ));
AND3 \$1I1137  (.Z0 (\$1N398 ), .A0 (QI2), .A1 (\$1N501 ), 
	.A2 (\$1N820 ));
AND3 \$1I1136  (.Z0 (\$1N357 ), .A0 (QI1), .A1 (\$1N501 ), 
	.A2 (\$1N820 ));
AND3 \$1I1135  (.Z0 (\$1N1004 ), .A0 (QI0), .A1 (\$1N501 ), 
	.A2 (\$1N820 ));
OR2 \$1I1132  (.Z0 (\$1N365 ), .A0 (\$1N354 ), .A1 (\$1N355 ));
OR2 \$1I1131  (.Z0 (\$1N312 ), .A0 (\$1N224 ), .A1 (\$1N226 ));
FDC1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD));
INV \$1I1102  (.ZN0 (\$1N820 ), .A0 (CS));
AND7 \$1I1044  (.Z0 (\$1N481 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (\$1N501 ), .A4 (CAI), 
	.A5 (EN), .A6 (\$1N820 ));
AND3 \$1I459  (.Z0 (\$1N450 ), .A0 (D3), .A1 (LD), 
	.A2 (\$1N820 ));
AND5 \$1I523  (.Z0 (\$1N355 ), .A0 (QI0), .A1 (CAI), 
	.A2 (\$1N501 ), .A3 (EN), .A4 (\$1N820 ));
AND3 \$1I359  (.Z0 (\$1N354 ), .A0 (D1), .A1 (LD), 
	.A2 (\$1N820 ));
AND4 \$1I209  (.Z0 (\$1N226 ), .A0 (\$1N501 ), .A1 (CAI), 
	.A2 (EN), .A3 (\$1N820 ));
AND3 \$1I204  (.Z0 (\$1N224 ), .A0 (D0), .A1 (LD), 
	.A2 (\$1N820 ));
INV \$1I38  (.ZN0 (\$1N501 ), .A0 (LD));
AND3 \$1I397  (.Z0 (\$1N395 ), .A0 (D2), .A1 (LD), 
	.A2 (\$1N820 ));
AND6 \$1I1036  (.Z0 (\$1N1041 ), .A0 (QI0), .A1 (QI1), 
	.A2 (CAI), .A3 (\$1N501 ), .A4 (EN), 
	.A5 (\$1N820 ));
AND6 \$1I1078  (.Z0 (CAO), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (CAI), 
	.A5 (EN));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (\$1N452 ), .A1 (\$1N473 ));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (\$1N398 ), .A1 (\$1N419 ));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (\$1N357 ), .A1 (\$1N365 ));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (\$1N1004 ), .A1 (\$1N312 ));
BUF \$1I1115  (.Z0 (Q3), .A0 (QI3));
BUF \$1I1120  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1124  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1116  (.Z0 (Q0), .A0 (QI0));
OR2 \$1I1133  (.Z0 (\$1N419 ), .A0 (\$1N395 ), .A1 (\$1N1041 ));
OR2 \$1I1134  (.Z0 (\$1N473 ), .A0 (\$1N450 ), .A1 (\$1N481 ));
endmodule
`timescale 10 ps / 10 ps
module CBUB8(
	CAI, CAO, CLK, CS, D0, D1, D2, D3, D4, D5, D6, D7, EN, LD, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CAI;
	output CAO;
	input CLK;
	input CS;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input EN;
	input LD;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



FDC1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I175  (.Q0 (QI3), .D0 (\$1N921 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I155  (.Q0 (QI2), .D0 (\$1N915 ), .CLK (CLK), 
	.SD (SD));
AND3 \$1I1141  (.Z0 (\$1N452 ), .A0 (QI3), .A1 (\$1N501 ), 
	.A2 (\$1N820 ));
AND3 \$1I1140  (.Z0 (\$1N398 ), .A0 (QI2), .A1 (\$1N501 ), 
	.A2 (\$1N820 ));
AND3 \$1I1139  (.Z0 (\$1N357 ), .A0 (QI1), .A1 (\$1N501 ), 
	.A2 (\$1N820 ));
OR2 \$1I1137  (.Z0 (\$1N312 ), .A0 (\$1N224 ), .A1 (\$1N226 ));
OR2 \$1I1136  (.Z0 (\$1N365 ), .A0 (\$1N354 ), .A1 (\$1N355 ));
OR2 \$1I1135  (.Z0 (\$1N419 ), .A0 (\$1N395 ), .A1 (\$1N1041 ));
OR2 \$1I1134  (.Z0 (\$1N473 ), .A0 (\$1N450 ), .A1 (\$1N481 ));
BUF \$1I1132  (.Z0 (Q0), .A0 (QI0));
BUF \$1I1129  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1127  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1125  (.Z0 (Q3), .A0 (QI3));
BUF \$1I1123  (.Z0 (Q4), .A0 (QI4));
BUF \$1I1119  (.Z0 (Q5), .A0 (QI5));
BUF \$1I1118  (.Z0 (Q6), .A0 (QI6));
AND6 \$1I1036  (.Z0 (\$1N1041 ), .A0 (QI0), .A1 (QI1), 
	.A2 (CAI), .A3 (\$1N501 ), .A4 (EN), 
	.A5 (\$1N820 ));
AND3 \$1I397  (.Z0 (\$1N395 ), .A0 (D2), .A1 (LD), 
	.A2 (\$1N820 ));
AND3 \$1I459  (.Z0 (\$1N450 ), .A0 (D3), .A1 (LD), 
	.A2 (\$1N820 ));
AND5 \$1I523  (.Z0 (\$1N355 ), .A0 (QI0), .A1 (CAI), 
	.A2 (\$1N501 ), .A3 (EN), .A4 (\$1N820 ));
AND4 \$1I209  (.Z0 (\$1N226 ), .A0 (\$1N501 ), .A1 (CAI), 
	.A2 (EN), .A3 (\$1N820 ));
AND3 \$1I204  (.Z0 (\$1N224 ), .A0 (D0), .A1 (LD), 
	.A2 (\$1N820 ));
AND7 \$1I1044  (.Z0 (\$1N481 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (\$1N501 ), .A4 (CAI), 
	.A5 (EN), .A6 (\$1N820 ));
AND3 \$1I359  (.Z0 (\$1N354 ), .A0 (D1), .A1 (LD), 
	.A2 (\$1N820 ));
INV \$1I1093  (.ZN0 (\$1N820 ), .A0 (CS));
INV \$1I38  (.ZN0 (\$1N501 ), .A0 (LD));
AND10 \$1I1064  (.Z0 (CAO), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (QI7), 
	.A8 (CAI), .A9 (EN));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (\$1N1004 ), .A1 (\$1N312 ));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (\$1N357 ), .A1 (\$1N365 ));
LXOR2 \$1I400  (.Z0 (\$1N915 ), .A0 (\$1N398 ), .A1 (\$1N419 ));
LXOR2 \$1I454  (.Z0 (\$1N921 ), .A0 (\$1N452 ), .A1 (\$1N473 ));
BUF \$1I1117  (.Z0 (Q7), .A0 (QI7));
AND3 \$1I1138  (.Z0 (\$1N1004 ), .A0 (QI0), .A1 (\$1N501 ), 
	.A2 (\$1N820 ));
AND3 \$2I1091  (.Z0 (\$2N855 ), .A0 (QI7), .A1 (\$2N501 ), 
	.A2 (\$2N820 ));
AND3 \$2I1090  (.Z0 (\$2N812 ), .A0 (QI6), .A1 (\$2N501 ), 
	.A2 (\$2N820 ));
AND3 \$2I1089  (.Z0 (\$2N770 ), .A0 (QI5), .A1 (\$2N501 ), 
	.A2 (\$2N820 ));
AND3 \$2I1088  (.Z0 (\$2N720 ), .A0 (QI4), .A1 (\$2N501 ), 
	.A2 (\$2N820 ));
OR2 \$2I1087  (.Z0 (\$2N854 ), .A0 (\$2N859 ), .A1 (\$2N1054 ));
OR2 \$2I1086  (.Z0 (\$2N813 ), .A0 (\$2N808 ), .A1 (\$2N795 ));
OR2 \$2I1085  (.Z0 (\$2N769 ), .A0 (\$2N774 ), .A1 (\$2N780 ));
OR2 \$2I1084  (.Z0 (\$2N719 ), .A0 (\$2N724 ), .A1 (\$2N725 ));
FDC1 \$2I723  (.Q0 (QI4), .D0 (\$2N924 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$2I773  (.Q0 (QI5), .D0 (\$2N929 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$2I858  (.Q0 (QI7), .D0 (\$2N935 ), .CLK (CLK), 
	.SD (SD));
FDC1 \$2I809  (.Q0 (QI6), .D0 (\$2N930 ), .CLK (CLK), 
	.SD (SD));
AND8 \$2I1049  (.Z0 (\$2N725 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (\$2N501 ), 
	.A5 (CAI), .A6 (EN), .A7 (\$2N820 ));
AND3 \$2I806  (.Z0 (\$2N808 ), .A0 (D6), .A1 (LD), 
	.A2 (\$2N820 ));
AND3 \$2I776  (.Z0 (\$2N774 ), .A0 (D5), .A1 (LD), 
	.A2 (\$2N820 ));
AND9 \$2I1050  (.Z0 (\$2N780 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (\$2N501 ), .A6 (CAI), .A7 (EN), 
	.A8 (\$2N820 ));
AND3 \$2I861  (.Z0 (\$2N859 ), .A0 (D7), .A1 (LD), 
	.A2 (\$2N820 ));
AND3 \$2I727  (.Z0 (\$2N724 ), .A0 (D4), .A1 (LD), 
	.A2 (\$2N820 ));
AND10 \$2I1051  (.Z0 (\$2N795 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (\$2N501 ), .A7 (CAI), 
	.A8 (EN), .A9 (\$2N820 ));
AND11 \$2I1052  (.Z0 (\$2N1054 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (\$2N501 ), 
	.A8 (CAI), .A9 (EN), .A10 (\$2N820 ));
INV \$2I1072  (.ZN0 (\$2N820 ), .A0 (CS));
INV \$2I38  (.ZN0 (\$2N501 ), .A0 (LD));
LXOR2 \$2I721  (.Z0 (\$2N924 ), .A0 (\$2N720 ), .A1 (\$2N719 ));
LXOR2 \$2I771  (.Z0 (\$2N929 ), .A0 (\$2N770 ), .A1 (\$2N769 ));
LXOR2 \$2I811  (.Z0 (\$2N930 ), .A0 (\$2N812 ), .A1 (\$2N813 ));
LXOR2 \$2I856  (.Z0 (\$2N935 ), .A0 (\$2N855 ), .A1 (\$2N854 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:02:55 1994
`timescale 10 ps / 10 ps 
module CBUD1(
	Q0, CAO, D0, CAI, 
	CLK, PS, LD, EN, 
	DNUP, CD, CS);

	output Q0;
	output CAO;
	input D0;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input DNUP;
	input CD;
	input CS;

OR3 \$1I1065  (.Z0(\$1N1132 ), .A0(\$1N1125 ), .A1(\$1N1134 ), .A2(PS));
LXOR2 \$1I1066  (.Z0(\$1N1112 ), .A0(\$1N1064 ), .A1(\$1N1132 ));
OR2 \$1I1083  (.Z0(CAO), .A0(\$1N1139 ), .A1(\$1N1140 ));
AND4 \$1I1085  (.Z0(\$1N1140 ), .A0(\$1N1091 ), .A1(CAI), .A2(EN), 
	.A3(DNUP));
AND4 \$1I1090  (.Z0(\$1N1139 ), .A0(\$1N1089 ), .A1(CAI), .A2(EN), 
	.A3(UP));
INV \$1I1094  (.ZN0(\$1N1091 ), .A0(\$1N1089 ));
FD21 \$1I1095  (.Q0(\$1N1089 ), .D0(\$1N1112 ), .CLK(CLK), .CD(CD));
INV \$1I1107  (.ZN0(\$1N1106 ), .A0(PS));
AND4 \$1I1115  (.Z0(\$1N1064 ), .A0(\$1N1089 ), .A1(\$1N1103 ), .A2(\$1N1102 ), 
	.A3(\$1N1106 ));
AND3 \$1I1126  (.Z0(\$1N1125 ), .A0(D0), .A1(LD), .A2(\$1N1102 ));
AND4 \$1I1127  (.Z0(\$1N1134 ), .A0(\$1N1103 ), .A1(CAI), .A2(EN), 
	.A3(\$1N1102 ));
INV \$1I1138  (.ZN0(UP), .A0(DNUP));
INV \$1I1165  (.ZN0(\$1N1102 ), .A0(CS));
INV \$1I1168  (.ZN0(\$1N1103 ), .A0(LD));
BUF \$1I1183  (.Z0(Q0), .A0(\$1N1089 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:02:58 1994
`timescale 10 ps / 10 ps 
module CBUD2(
	Q0, Q1, CAO, D0, 
	D1, CAI, CLK, PS, 
	LD, EN, DNUP, CD, 
	CS);

	output Q0;
	output Q1;
	output CAO;
	input D0;
	input D1;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input DNUP;
	input CD;
	input CS;

LXOR2 \$1I1063  (.Z0(\$1N1111 ), .A0(\$1N1062 ), .A1(\$1N1108 ));
OR3 \$1I1065  (.Z0(\$1N1132 ), .A0(\$1N1125 ), .A1(\$1N1134 ), .A2(PS));
LXOR2 \$1I1066  (.Z0(\$1N1112 ), .A0(\$1N1064 ), .A1(\$1N1132 ));
OR4 \$1I1067  (.Z0(\$1N1108 ), .A0(\$1N1073 ), .A1(\$1N1075 ), .A2(\$1N1074 ), 
	.A3(PS));
OR2 \$1I1083  (.Z0(CAO), .A0(\$1N1139 ), .A1(\$1N1140 ));
AND5 \$1I1085  (.Z0(\$1N1140 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(CAI), 
	.A3(EN), .A4(DNUP));
INV \$1I1094  (.ZN0(\~QI0 ), .A0(QI0));
FD21 \$1I1095  (.Q0(QI0), .D0(\$1N1112 ), .CLK(CLK), .CD(CD));
FD21 \$1I1096  (.Q0(QI1), .D0(\$1N1111 ), .CLK(CLK), .CD(CD));
INV \$1I1101  (.ZN0(\~QI1 ), .A0(QI1));
AND4 \$1I1115  (.Z0(\$1N1064 ), .A0(QI0), .A1(\$1N1103 ), .A2(\$1N1102 ), 
	.A3(\$1N1106 ));
AND4 \$1I1118  (.Z0(\$1N1062 ), .A0(QI1), .A1(\$1N1103 ), .A2(\$1N1102 ), 
	.A3(\$1N1106 ));
AND3 \$1I1126  (.Z0(\$1N1125 ), .A0(D0), .A1(LD), .A2(\$1N1102 ));
AND4 \$1I1127  (.Z0(\$1N1134 ), .A0(\$1N1103 ), .A1(CAI), .A2(EN), 
	.A3(\$1N1102 ));
AND3 \$1I1129  (.Z0(\$1N1073 ), .A0(D1), .A1(LD), .A2(\$1N1102 ));
AND6 \$1I1130  (.Z0(\$1N1075 ), .A0(QI0), .A1(CAI), .A2(\$1N1103 ), 
	.A3(EN), .A4(\$1N1102 ), .A5(UP));
AND6 \$1I1131  (.Z0(\$1N1074 ), .A0(\~QI0 ), .A1(CAI), .A2(\$1N1103 ), 
	.A3(EN), .A4(\$1N1102 ), .A5(DNUP));
INV \$1I1135  (.ZN0(\$1N1103 ), .A0(LD));
INV \$1I1159  (.ZN0(\$1N1102 ), .A0(CS));
INV \$1I1161  (.ZN0(\$1N1106 ), .A0(PS));
INV \$1I1164  (.ZN0(UP), .A0(DNUP));
AND5 \$1I1179  (.Z0(\$1N1139 ), .A0(QI0), .A1(QI1), .A2(CAI), 
	.A3(EN), .A4(UP));
BUF \$1I1189  (.Z0(Q0), .A0(QI0));
BUF \$1I1190  (.Z0(Q1), .A0(QI1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:03:02 1994
`timescale 10 ps / 10 ps 
module CBUD4(
	Q0, Q1, Q2, Q3, 
	CAO, D0, D1, D2, 
	D3, CAI, CLK, PS, 
	LD, EN, DNUP, CD, 
	CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input DNUP;
	input CD;
	input CS;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
OR2 \$1I1054  (.Z0(CAO), .A0(\$1N1053 ), .A1(\$1N1052 ));
INV \$1I1080  (.ZN0(\$1N1027 ), .A0(CS));
INV \$1I1084  (.ZN0(\$1N827 ), .A0(PS));
INV \$1I1096  (.ZN0(UP), .A0(DNUP));
AND7 \$1I1140  (.Z0(\$1N1052 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(CAI), .A5(EN), .A6(DNUP));
AND7 \$1I1141  (.Z0(\$1N1053 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(CAI), .A5(EN), .A6(UP));
BUF \$1I1146  (.Z0(Q3), .A0(QI3));
BUF \$1I1147  (.Z0(Q2), .A0(QI2));
BUF \$1I1148  (.Z0(Q1), .A0(QI1));
BUF \$1I1149  (.Z0(Q0), .A0(QI0));
AND3 \$1I204  (.Z0(\$1N224 ), .A0(D0), .A1(LD), .A2(\$1N1027 ));
AND4 \$1I209  (.Z0(\$1N226 ), .A0(\$1N501 ), .A1(CAI), .A2(EN), 
	.A3(\$1N1027 ));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N224 ), .A1(\$1N226 ), .A2(PS));
AND4 \$1I3  (.Z0(\$1N1004 ), .A0(QI0), .A1(\$1N501 ), .A2(\$1N1027 ), 
	.A3(\$1N827 ));
AND4 \$1I343  (.Z0(\$1N357 ), .A0(QI1), .A1(\$1N501 ), .A2(\$1N1027 ), 
	.A3(\$1N827 ));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(\$1N357 ), .A1(\$1N365 ));
AND3 \$1I359  (.Z0(\$1N354 ), .A0(D1), .A1(LD), .A2(\$1N1027 ));
INV \$1I38  (.ZN0(\$1N501 ), .A0(LD));
AND6 \$1I523  (.Z0(\$1N355 ), .A0(QI0), .A1(CAI), .A2(\$1N501 ), 
	.A3(EN), .A4(\$1N1027 ), .A5(UP));
AND6 \$1I527  (.Z0(\$1N536 ), .A0(\~QI0 ), .A1(CAI), .A2(\$1N501 ), 
	.A3(EN), .A4(\$1N1027 ), .A5(DNUP));
OR4 \$1I534  (.Z0(\$1N365 ), .A0(\$1N354 ), .A1(\$1N355 ), .A2(\$1N536 ), 
	.A3(PS));
INV \$1I539  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I550  (.ZN0(\~QI1 ), .A0(QI1));
INV \$2I1080  (.ZN0(\$2N1027 ), .A0(CS));
INV \$2I1084  (.ZN0(\$2N827 ), .A0(PS));
FD21 \$2I155  (.Q0(QI2), .D0(\$2N915 ), .CLK(CLK), .CD(CD));
FD21 \$2I175  (.Q0(QI3), .D0(\$2N921 ), .CLK(CLK), .CD(CD));
INV \$2I38  (.ZN0(\$2N501 ), .A0(LD));
AND3 \$2I397  (.Z0(\$2N395 ), .A0(D2), .A1(LD), .A2(\$2N1027 ));
LXOR2 \$2I400  (.Z0(\$2N915 ), .A0(\$2N398 ), .A1(\$2N419 ));
AND4 \$2I401  (.Z0(\$2N398 ), .A0(QI2), .A1(\$2N501 ), .A2(\$2N1027 ), 
	.A3(\$2N827 ));
LXOR2 \$2I454  (.Z0(\$2N921 ), .A0(\$2N452 ), .A1(\$2N473 ));
AND3 \$2I459  (.Z0(\$2N450 ), .A0(D3), .A1(LD), .A2(\$2N1027 ));
AND4 \$2I460  (.Z0(\$2N452 ), .A0(QI3), .A1(\$2N501 ), .A2(\$2N1027 ), 
	.A3(\$2N827 ));
INV \$2I553  (.ZN0(\~QI2 ), .A0(QI2));
INV \$2I559  (.ZN0(\~QI3 ), .A0(QI3));
AND7 \$2I562  (.Z0(\$2N433 ), .A0(QI0), .A1(QI1), .A2(\$2N501 ), 
	.A3(CAI), .A4(EN), .A5(\$2N1027 ), .A6(UP));
AND7 \$2I563  (.Z0(\$2N581 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\$2N501 ), 
	.A3(CAI), .A4(EN), .A5(\$2N1027 ), .A6(DNUP));
OR4 \$2I578  (.Z0(\$2N419 ), .A0(\$2N395 ), .A1(\$2N433 ), .A2(\$2N581 ), 
	.A3(PS));
AND8 \$2I587  (.Z0(\$2N481 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(\$2N501 ), .A4(CAI), .A5(EN), .A6(\$2N1027 ), 
	.A7(UP));
AND8 \$2I593  (.Z0(\$2N595 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\$2N501 ), .A4(CAI), .A5(EN), .A6(\$2N1027 ), 
	.A7(DNUP));
OR4 \$2I594  (.Z0(\$2N473 ), .A0(\$2N450 ), .A1(\$2N481 ), .A2(\$2N595 ), 
	.A3(PS));
endmodule
`timescale 10 ps / 10 ps
module CBUD4S(
	CAI, CAO, CD, CLK, CS, D0, D1, D2, D3, DNUP, EN, LD, SD, Q0, Q1, Q2, Q3);


	input CAI;
	output CAO;
	input CD;
	input CLK;
	input CS;
	input D0;
	input D1;
	input D2;
	input D3;
	input DNUP;
	input EN;
	input LD;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



OR3 \$1I1163  (.Z0 (\$1N365 ), .A0 (\$1N354 ), .A1 (\$1N355 ), 
	.A2 (\$1N536 ));
OR2 \$1I1162  (.Z0 (\$1N312 ), .A0 (\$1N224 ), .A1 (\$1N226 ));
AND3 \$1I1155  (.Z0 (\$1N1004 ), .A0 (QI0), .A1 (\$1N501 ), 
	.A2 (\$1N1027 ));
AND3 \$1I1154  (.Z0 (\$1N357 ), .A0 (QI1), .A1 (\$1N501 ), 
	.A2 (\$1N1027 ));
FDE1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
BUF \$1I1146  (.Z0 (Q3), .A0 (QI3));
BUF \$1I1149  (.Z0 (Q0), .A0 (QI0));
BUF \$1I1148  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1147  (.Z0 (Q2), .A0 (QI2));
AND3 \$1I204  (.Z0 (\$1N224 ), .A0 (D0), .A1 (LD), 
	.A2 (\$1N1027 ));
AND3 \$1I359  (.Z0 (\$1N354 ), .A0 (D1), .A1 (LD), 
	.A2 (\$1N1027 ));
AND6 \$1I523  (.Z0 (\$1N355 ), .A0 (QI0), .A1 (CAI), 
	.A2 (\$1N501 ), .A3 (EN), .A4 (\$1N1027 ), 
	.A5 (UP));
INV \$1I550  (.ZN0 (\~QI1 ), .A0 (QI1));
INV \$1I38  (.ZN0 (\$1N501 ), .A0 (LD));
INV \$1I539  (.ZN0 (\~QI0 ), .A0 (QI0));
AND4 \$1I209  (.Z0 (\$1N226 ), .A0 (\$1N501 ), .A1 (CAI), 
	.A2 (EN), .A3 (\$1N1027 ));
AND6 \$1I527  (.Z0 (\$1N536 ), .A0 (\~QI0 ), .A1 (CAI), 
	.A2 (\$1N501 ), .A3 (EN), .A4 (\$1N1027 ), 
	.A5 (DNUP));
INV \$1I1080  (.ZN0 (\$1N1027 ), .A0 (CS));
INV \$1I1096  (.ZN0 (UP), .A0 (DNUP));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (\$1N357 ), .A1 (\$1N365 ));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (\$1N1004 ), .A1 (\$1N312 ));
AND7 \$1I1141  (.Z0 (\$1N1053 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (CAI), 
	.A5 (EN), .A6 (UP));
AND7 \$1I1140  (.Z0 (\$1N1052 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (CAI), 
	.A5 (EN), .A6 (DNUP));
OR2 \$1I1054  (.Z0 (CAO), .A0 (\$1N1053 ), .A1 (\$1N1052 ));
OR3 \$2I1131  (.Z0 (\$2N473 ), .A0 (\$2N450 ), .A1 (\$2N481 ), 
	.A2 (\$2N595 ));
OR3 \$2I1130  (.Z0 (\$2N419 ), .A0 (\$2N395 ), .A1 (\$2N433 ), 
	.A2 (\$2N581 ));
AND3 \$2I1127  (.Z0 (\$2N452 ), .A0 (QI3), .A1 (\$2N501 ), 
	.A2 (\$2N1027 ));
AND3 \$2I1126  (.Z0 (\$2N398 ), .A0 (QI2), .A1 (\$2N501 ), 
	.A2 (\$2N1027 ));
FDE1 \$2I155  (.Q0 (QI2), .D0 (\$2N915 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$2I175  (.Q0 (QI3), .D0 (\$2N921 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
LXOR2 \$2I454  (.Z0 (\$2N921 ), .A0 (\$2N452 ), .A1 (\$2N473 ));
LXOR2 \$2I400  (.Z0 (\$2N915 ), .A0 (\$2N398 ), .A1 (\$2N419 ));
AND3 \$2I397  (.Z0 (\$2N395 ), .A0 (D2), .A1 (LD), 
	.A2 (\$2N1027 ));
AND8 \$2I593  (.Z0 (\$2N595 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\$2N501 ), .A4 (CAI), 
	.A5 (EN), .A6 (\$2N1027 ), .A7 (DNUP));
AND8 \$2I587  (.Z0 (\$2N481 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (\$2N501 ), .A4 (CAI), 
	.A5 (EN), .A6 (\$2N1027 ), .A7 (UP));
AND3 \$2I459  (.Z0 (\$2N450 ), .A0 (D3), .A1 (LD), 
	.A2 (\$2N1027 ));
AND7 \$2I562  (.Z0 (\$2N433 ), .A0 (QI0), .A1 (QI1), 
	.A2 (\$2N501 ), .A3 (CAI), .A4 (EN), 
	.A5 (\$2N1027 ), .A6 (UP));
INV \$2I553  (.ZN0 (\~QI2 ), .A0 (QI2));
INV \$2I559  (.ZN0 (\~QI3 ), .A0 (QI3));
INV \$2I1080  (.ZN0 (\$2N1027 ), .A0 (CS));
AND7 \$2I563  (.Z0 (\$2N581 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\$2N501 ), .A3 (CAI), .A4 (EN), 
	.A5 (\$2N1027 ), .A6 (DNUP));
INV \$2I38  (.ZN0 (\$2N501 ), .A0 (LD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:03:09 1994
`timescale 10 ps / 10 ps 
module CBUD8(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	CAO, D0, D1, D2, 
	D3, D4, D5, D6, 
	D7, CAI, CLK, PS, 
	LD, EN, DNUP, CD, 
	CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input DNUP;
	input CD;
	input CS;

FD21 \$1I1  (.Q0(QI0), .D0(\$1N904 ), .CLK(CLK), .CD(CD));
FD21 \$1I1020  (.Q0(QI1), .D0(\$1N912 ), .CLK(CLK), .CD(CD));
OR2 \$1I1054  (.Z0(CAO), .A0(\$1N1053 ), .A1(\$1N1052 ));
AND11 \$1I1055  (.Z0(\$1N1053 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(QI7), .A8(CAI), .A9(EN), .A10(UP));
AND11 \$1I1056  (.Z0(\$1N1052 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\~QI7 ), .A8(CAI), .A9(EN), .A10(DNUP));
INV \$1I1080  (.ZN0(\$1N1027 ), .A0(CS));
INV \$1I1084  (.ZN0(\$1N827 ), .A0(PS));
INV \$1I1096  (.ZN0(UP), .A0(DNUP));
BUF \$1I1148  (.Z0(Q7), .A0(QI7));
BUF \$1I1149  (.Z0(Q6), .A0(QI6));
BUF \$1I1150  (.Z0(Q5), .A0(QI5));
BUF \$1I1151  (.Z0(Q4), .A0(QI4));
BUF \$1I1152  (.Z0(Q3), .A0(QI3));
BUF \$1I1153  (.Z0(Q2), .A0(QI2));
BUF \$1I1154  (.Z0(Q1), .A0(QI1));
BUF \$1I1155  (.Z0(Q0), .A0(QI0));
AND3 \$1I204  (.Z0(\$1N224 ), .A0(D0), .A1(LD), .A2(\$1N1027 ));
AND4 \$1I209  (.Z0(\$1N226 ), .A0(\$1N501 ), .A1(CAI), .A2(EN), 
	.A3(\$1N1027 ));
LXOR2 \$1I295  (.Z0(\$1N904 ), .A0(\$1N1004 ), .A1(\$1N312 ));
OR3 \$1I298  (.Z0(\$1N312 ), .A0(\$1N224 ), .A1(\$1N226 ), .A2(PS));
AND4 \$1I3  (.Z0(\$1N1004 ), .A0(QI0), .A1(\$1N501 ), .A2(\$1N1027 ), 
	.A3(\$1N827 ));
AND4 \$1I343  (.Z0(\$1N357 ), .A0(QI1), .A1(\$1N501 ), .A2(\$1N1027 ), 
	.A3(\$1N827 ));
LXOR2 \$1I353  (.Z0(\$1N912 ), .A0(\$1N357 ), .A1(\$1N365 ));
AND3 \$1I359  (.Z0(\$1N354 ), .A0(D1), .A1(LD), .A2(\$1N1027 ));
INV \$1I38  (.ZN0(\$1N501 ), .A0(LD));
AND6 \$1I523  (.Z0(\$1N355 ), .A0(QI0), .A1(CAI), .A2(\$1N501 ), 
	.A3(EN), .A4(\$1N1027 ), .A5(UP));
AND6 \$1I527  (.Z0(\$1N536 ), .A0(\~QI0 ), .A1(CAI), .A2(\$1N501 ), 
	.A3(EN), .A4(\$1N1027 ), .A5(DNUP));
OR4 \$1I534  (.Z0(\$1N365 ), .A0(\$1N354 ), .A1(\$1N355 ), .A2(\$1N536 ), 
	.A3(PS));
INV \$1I539  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I550  (.ZN0(\~QI1 ), .A0(QI1));
INV \$2I1080  (.ZN0(\$2N1027 ), .A0(CS));
INV \$2I1084  (.ZN0(\$2N827 ), .A0(PS));
FD21 \$2I155  (.Q0(QI2), .D0(\$2N915 ), .CLK(CLK), .CD(CD));
FD21 \$2I175  (.Q0(QI3), .D0(\$2N921 ), .CLK(CLK), .CD(CD));
INV \$2I38  (.ZN0(\$2N501 ), .A0(LD));
AND3 \$2I397  (.Z0(\$2N395 ), .A0(D2), .A1(LD), .A2(\$2N1027 ));
LXOR2 \$2I400  (.Z0(\$2N915 ), .A0(\$2N398 ), .A1(\$2N419 ));
AND4 \$2I401  (.Z0(\$2N398 ), .A0(QI2), .A1(\$2N501 ), .A2(\$2N1027 ), 
	.A3(\$2N827 ));
LXOR2 \$2I454  (.Z0(\$2N921 ), .A0(\$2N452 ), .A1(\$2N473 ));
AND3 \$2I459  (.Z0(\$2N450 ), .A0(D3), .A1(LD), .A2(\$2N1027 ));
AND4 \$2I460  (.Z0(\$2N452 ), .A0(QI3), .A1(\$2N501 ), .A2(\$2N1027 ), 
	.A3(\$2N827 ));
INV \$2I553  (.ZN0(\~QI2 ), .A0(QI2));
INV \$2I559  (.ZN0(\~QI3 ), .A0(QI3));
AND7 \$2I562  (.Z0(\$2N433 ), .A0(QI0), .A1(QI1), .A2(\$2N501 ), 
	.A3(CAI), .A4(EN), .A5(\$2N1027 ), .A6(UP));
AND7 \$2I563  (.Z0(\$2N581 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\$2N501 ), 
	.A3(CAI), .A4(EN), .A5(\$2N1027 ), .A6(DNUP));
OR4 \$2I578  (.Z0(\$2N419 ), .A0(\$2N395 ), .A1(\$2N433 ), .A2(\$2N581 ), 
	.A3(PS));
AND8 \$2I587  (.Z0(\$2N481 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(\$2N501 ), .A4(CAI), .A5(EN), .A6(\$2N1027 ), 
	.A7(UP));
AND8 \$2I593  (.Z0(\$2N595 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\$2N501 ), .A4(CAI), .A5(EN), .A6(\$2N1027 ), 
	.A7(DNUP));
OR4 \$2I594  (.Z0(\$2N473 ), .A0(\$2N450 ), .A1(\$2N481 ), .A2(\$2N595 ), 
	.A3(PS));
INV \$3I1100  (.ZN0(\$3N501 ), .A0(LD));
INV \$3I1128  (.ZN0(\$3N7 ), .A0(CS));
INV \$3I1133  (.ZN0(\$3N827 ), .A0(PS));
INV \$3I718  (.ZN0(\~QI4 ), .A0(QI4));
LXOR2 \$3I721  (.Z0(\$3N924 ), .A0(\$3N720 ), .A1(\$3N719 ));
FD21 \$3I723  (.Q0(QI4), .D0(\$3N924 ), .CLK(CLK), .CD(CD));
OR4 \$3I726  (.Z0(\$3N719 ), .A0(\$3N724 ), .A1(\$3N725 ), .A2(\$3N717 ), 
	.A3(PS));
AND3 \$3I727  (.Z0(\$3N724 ), .A0(D4), .A1(LD), .A2(\$3N7 ));
AND4 \$3I730  (.Z0(\$3N720 ), .A0(QI4), .A1(\$3N501 ), .A2(\$3N7 ), 
	.A3(\$3N827 ));
AND9 \$3I745  (.Z0(\$3N725 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(\$3N501 ), .A5(CAI), .A6(EN), 
	.A7(\$3N7 ), .A8(UP));
AND9 \$3I750  (.Z0(\$3N717 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\$3N501 ), .A5(CAI), .A6(EN), 
	.A7(\$3N7 ), .A8(DNUP));
INV \$3I768  (.ZN0(\~QI5 ), .A0(QI5));
LXOR2 \$3I771  (.Z0(\$3N929 ), .A0(\$3N1123 ), .A1(\$3N769 ));
FD21 \$3I773  (.Q0(QI5), .D0(\$3N929 ), .CLK(CLK), .CD(CD));
OR4 \$3I775  (.Z0(\$3N769 ), .A0(\$3N774 ), .A1(\$3N780 ), .A2(\$3N762 ), 
	.A3(PS));
AND3 \$3I776  (.Z0(\$3N774 ), .A0(D5), .A1(LD), .A2(\$3N7 ));
AND4 \$3I777  (.Z0(\$3N1123 ), .A0(QI5), .A1(\$3N501 ), .A2(\$3N7 ), 
	.A3(\$3N827 ));
AND10 \$3I785  (.Z0(\$3N780 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(\$3N501 ), .A6(CAI), 
	.A7(EN), .A8(\$3N7 ), .A9(UP));
AND10 \$3I792  (.Z0(\$3N762 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\$3N501 ), .A6(CAI), 
	.A7(EN), .A8(\$3N7 ), .A9(DNUP));
INV \$4I1100  (.ZN0(\$4N501 ), .A0(LD));
INV \$4I1129  (.ZN0(\$4N7 ), .A0(CS));
INV \$4I1131  (.ZN0(\$4N827 ), .A0(PS));
AND3 \$4I806  (.Z0(\$4N808 ), .A0(D6), .A1(LD), .A2(\$4N7 ));
OR4 \$4I807  (.Z0(\$4N813 ), .A0(\$4N808 ), .A1(\$4N795 ), .A2(\$4N793 ), 
	.A3(PS));
FD21 \$4I809  (.Q0(QI6), .D0(\$4N930 ), .CLK(CLK), .CD(CD));
LXOR2 \$4I811  (.Z0(\$4N930 ), .A0(\$4N812 ), .A1(\$4N813 ));
INV \$4I814  (.ZN0(\~QI6 ), .A0(QI6));
AND4 \$4I821  (.Z0(\$4N812 ), .A0(QI6), .A1(\$4N501 ), .A2(\$4N7 ), 
	.A3(\$4N827 ));
AND11 \$4I824  (.Z0(\$4N795 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(\$4N501 ), 
	.A7(CAI), .A8(EN), .A9(\$4N7 ), .A10(UP));
AND11 \$4I832  (.Z0(\$4N793 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\$4N501 ), 
	.A7(CAI), .A8(EN), .A9(\$4N7 ), .A10(DNUP));
INV \$4I853  (.ZN0(\~QI7 ), .A0(QI7));
LXOR2 \$4I856  (.Z0(\$4N935 ), .A0(\$4N855 ), .A1(\$4N854 ));
FD21 \$4I858  (.Q0(QI7), .D0(\$4N935 ), .CLK(CLK), .CD(CD));
OR4 \$4I860  (.Z0(\$4N854 ), .A0(\$4N859 ), .A1(\$4N848 ), .A2(\$4N847 ), 
	.A3(PS));
AND3 \$4I861  (.Z0(\$4N859 ), .A0(D7), .A1(LD), .A2(\$4N7 ));
AND4 \$4I867  (.Z0(\$4N855 ), .A0(QI7), .A1(\$4N501 ), .A2(\$4N7 ), 
	.A3(\$4N827 ));
AND12 \$4I868  (.Z0(\$4N848 ), .A0(QI0), .A1(QI1), .A2(QI2), 
	.A3(QI3), .A4(QI4), .A5(QI5), .A6(QI6), 
	.A7(\$4N501 ), .A8(CAI), .A9(EN), .A10(\$4N7 ), 
	.A11(UP));
AND12 \$4I870  (.Z0(\$4N847 ), .A0(\~QI0 ), .A1(\~QI1 ), .A2(\~QI2 ), 
	.A3(\~QI3 ), .A4(\~QI4 ), .A5(\~QI5 ), .A6(\~QI6 ), 
	.A7(\$4N501 ), .A8(CAI), .A9(EN), .A10(\$4N7 ), 
	.A11(DNUP));
endmodule
`timescale 10 ps / 10 ps
module CBUD8S(
	CAI, CAO, CD, CLK, CS, D0, D1, D2, D3, D4, D5, D6, D7, DNUP, EN, LD, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CAI;
	output CAO;
	input CD;
	input CLK;
	input CS;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input DNUP;
	input EN;
	input LD;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



OR2 \$1I1169  (.Z0 (\$1N312 ), .A0 (\$1N224 ), .A1 (\$1N226 ));
OR3 \$1I1168  (.Z0 (\$1N365 ), .A0 (\$1N354 ), .A1 (\$1N355 ), 
	.A2 (\$1N536 ));
AND3 \$1I1167  (.Z0 (\$1N357 ), .A0 (QI1), .A1 (\$1N501 ), 
	.A2 (\$1N1027 ));
AND3 \$1I1166  (.Z0 (\$1N1004 ), .A0 (QI0), .A1 (\$1N501 ), 
	.A2 (\$1N1027 ));
FDE1 \$1I1  (.Q0 (QI0), .D0 (\$1N904 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I1020  (.Q0 (QI1), .D0 (\$1N912 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
BUF \$1I1155  (.Z0 (Q0), .A0 (QI0));
BUF \$1I1153  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1152  (.Z0 (Q3), .A0 (QI3));
BUF \$1I1151  (.Z0 (Q4), .A0 (QI4));
BUF \$1I1150  (.Z0 (Q5), .A0 (QI5));
BUF \$1I1149  (.Z0 (Q6), .A0 (QI6));
BUF \$1I1148  (.Z0 (Q7), .A0 (QI7));
AND3 \$1I204  (.Z0 (\$1N224 ), .A0 (D0), .A1 (LD), 
	.A2 (\$1N1027 ));
AND3 \$1I359  (.Z0 (\$1N354 ), .A0 (D1), .A1 (LD), 
	.A2 (\$1N1027 ));
AND6 \$1I523  (.Z0 (\$1N355 ), .A0 (QI0), .A1 (CAI), 
	.A2 (\$1N501 ), .A3 (EN), .A4 (\$1N1027 ), 
	.A5 (UP));
INV \$1I38  (.ZN0 (\$1N501 ), .A0 (LD));
INV \$1I539  (.ZN0 (\~QI0 ), .A0 (QI0));
AND4 \$1I209  (.Z0 (\$1N226 ), .A0 (\$1N501 ), .A1 (CAI), 
	.A2 (EN), .A3 (\$1N1027 ));
AND6 \$1I527  (.Z0 (\$1N536 ), .A0 (\~QI0 ), .A1 (CAI), 
	.A2 (\$1N501 ), .A3 (EN), .A4 (\$1N1027 ), 
	.A5 (DNUP));
INV \$1I1080  (.ZN0 (\$1N1027 ), .A0 (CS));
INV \$1I1096  (.ZN0 (UP), .A0 (DNUP));
LXOR2 \$1I353  (.Z0 (\$1N912 ), .A0 (\$1N357 ), .A1 (\$1N365 ));
LXOR2 \$1I295  (.Z0 (\$1N904 ), .A0 (\$1N1004 ), .A1 (\$1N312 ));
AND11 \$1I1055  (.Z0 (\$1N1053 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (QI7), 
	.A8 (CAI), .A9 (EN), .A10 (UP));
AND11 \$1I1056  (.Z0 (\$1N1052 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\~QI7 ), 
	.A8 (CAI), .A9 (EN), .A10 (DNUP));
OR2 \$1I1054  (.Z0 (CAO), .A0 (\$1N1053 ), .A1 (\$1N1052 ));
BUF \$1I1154  (.Z0 (Q1), .A0 (QI1));
INV \$1I550  (.ZN0 (\~QI1 ), .A0 (QI1));
OR3 \$2I1128  (.Z0 (\$2N419 ), .A0 (\$2N395 ), .A1 (\$2N433 ), 
	.A2 (\$2N581 ));
OR3 \$2I1127  (.Z0 (\$2N473 ), .A0 (\$2N450 ), .A1 (\$2N481 ), 
	.A2 (\$2N595 ));
AND3 \$2I1126  (.Z0 (\$2N398 ), .A0 (QI2), .A1 (\$2N501 ), 
	.A2 (\$2N1027 ));
AND3 \$2I1125  (.Z0 (\$2N452 ), .A0 (QI3), .A1 (\$2N501 ), 
	.A2 (\$2N1027 ));
FDE1 \$2I155  (.Q0 (QI2), .D0 (\$2N915 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$2I175  (.Q0 (QI3), .D0 (\$2N921 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND3 \$2I397  (.Z0 (\$2N395 ), .A0 (D2), .A1 (LD), 
	.A2 (\$2N1027 ));
AND8 \$2I593  (.Z0 (\$2N595 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\$2N501 ), .A4 (CAI), 
	.A5 (EN), .A6 (\$2N1027 ), .A7 (DNUP));
AND8 \$2I587  (.Z0 (\$2N481 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (\$2N501 ), .A4 (CAI), 
	.A5 (EN), .A6 (\$2N1027 ), .A7 (UP));
AND3 \$2I459  (.Z0 (\$2N450 ), .A0 (D3), .A1 (LD), 
	.A2 (\$2N1027 ));
AND7 \$2I562  (.Z0 (\$2N433 ), .A0 (QI0), .A1 (QI1), 
	.A2 (\$2N501 ), .A3 (CAI), .A4 (EN), 
	.A5 (\$2N1027 ), .A6 (UP));
INV \$2I553  (.ZN0 (\~QI2 ), .A0 (QI2));
INV \$2I559  (.ZN0 (\~QI3 ), .A0 (QI3));
INV \$2I1080  (.ZN0 (\$2N1027 ), .A0 (CS));
AND7 \$2I563  (.Z0 (\$2N581 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\$2N501 ), .A3 (CAI), .A4 (EN), 
	.A5 (\$2N1027 ), .A6 (DNUP));
INV \$2I38  (.ZN0 (\$2N501 ), .A0 (LD));
LXOR2 \$2I454  (.Z0 (\$2N921 ), .A0 (\$2N452 ), .A1 (\$2N473 ));
LXOR2 \$2I400  (.Z0 (\$2N915 ), .A0 (\$2N398 ), .A1 (\$2N419 ));
OR3 \$3I1142  (.Z0 (\$3N719 ), .A0 (\$3N724 ), .A1 (\$3N725 ), 
	.A2 (\$3N717 ));
OR3 \$3I1141  (.Z0 (\$3N769 ), .A0 (\$3N774 ), .A1 (\$3N780 ), 
	.A2 (\$3N762 ));
AND3 \$3I1140  (.Z0 (\$3N720 ), .A0 (QI4), .A1 (\$3N501 ), 
	.A2 (\$3N7 ));
AND3 \$3I1138  (.Z0 (\$3N1123 ), .A0 (QI5), .A1 (\$3N501 ), 
	.A2 (\$3N7 ));
FDE1 \$3I723  (.Q0 (QI4), .D0 (\$3N924 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$3I773  (.Q0 (QI5), .D0 (\$3N929 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND9 \$3I745  (.Z0 (\$3N725 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (\$3N501 ), 
	.A5 (CAI), .A6 (EN), .A7 (\$3N7 ), 
	.A8 (UP));
AND9 \$3I750  (.Z0 (\$3N717 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\$3N501 ), 
	.A5 (CAI), .A6 (EN), .A7 (\$3N7 ), 
	.A8 (DNUP));
AND3 \$3I776  (.Z0 (\$3N774 ), .A0 (D5), .A1 (LD), 
	.A2 (\$3N7 ));
AND10 \$3I785  (.Z0 (\$3N780 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (\$3N501 ), .A6 (CAI), .A7 (EN), 
	.A8 (\$3N7 ), .A9 (UP));
AND10 \$3I792  (.Z0 (\$3N762 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\$3N501 ), .A6 (CAI), .A7 (EN), 
	.A8 (\$3N7 ), .A9 (DNUP));
INV \$3I718  (.ZN0 (\~QI4 ), .A0 (QI4));
AND3 \$3I727  (.Z0 (\$3N724 ), .A0 (D4), .A1 (LD), 
	.A2 (\$3N7 ));
INV \$3I768  (.ZN0 (\~QI5 ), .A0 (QI5));
INV \$3I1128  (.ZN0 (\$3N7 ), .A0 (CS));
INV \$3I1100  (.ZN0 (\$3N501 ), .A0 (LD));
LXOR2 \$3I721  (.Z0 (\$3N924 ), .A0 (\$3N720 ), .A1 (\$3N719 ));
LXOR2 \$3I771  (.Z0 (\$3N929 ), .A0 (\$3N1123 ), .A1 (\$3N769 ));
OR3 \$4I1144  (.Z0 (\$4N813 ), .A0 (\$4N808 ), .A1 (\$4N795 ), 
	.A2 (\$4N793 ));
OR3 \$4I1143  (.Z0 (\$4N854 ), .A0 (\$4N859 ), .A1 (\$4N848 ), 
	.A2 (\$4N847 ));
AND3 \$4I1142  (.Z0 (\$4N812 ), .A0 (QI6), .A1 (\$4N501 ), 
	.A2 (\$4N7 ));
AND3 \$4I1141  (.Z0 (\$4N855 ), .A0 (QI7), .A1 (\$4N501 ), 
	.A2 (\$4N7 ));
FDE1 \$4I858  (.Q0 (QI7), .D0 (\$4N935 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$4I809  (.Q0 (QI6), .D0 (\$4N930 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
LXOR2 \$4I856  (.Z0 (\$4N935 ), .A0 (\$4N855 ), .A1 (\$4N854 ));
LXOR2 \$4I811  (.Z0 (\$4N930 ), .A0 (\$4N812 ), .A1 (\$4N813 ));
INV \$4I1129  (.ZN0 (\$4N7 ), .A0 (CS));
INV \$4I1100  (.ZN0 (\$4N501 ), .A0 (LD));
INV \$4I853  (.ZN0 (\~QI7 ), .A0 (QI7));
INV \$4I814  (.ZN0 (\~QI6 ), .A0 (QI6));
AND3 \$4I861  (.Z0 (\$4N859 ), .A0 (D7), .A1 (LD), 
	.A2 (\$4N7 ));
AND11 \$4I832  (.Z0 (\$4N793 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\$4N501 ), .A7 (CAI), 
	.A8 (EN), .A9 (\$4N7 ), .A10 (DNUP));
AND11 \$4I824  (.Z0 (\$4N795 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (\$4N501 ), .A7 (CAI), 
	.A8 (EN), .A9 (\$4N7 ), .A10 (UP));
AND3 \$4I806  (.Z0 (\$4N808 ), .A0 (D6), .A1 (LD), 
	.A2 (\$4N7 ));
AND12 \$4I868  (.Z0 (\$4N848 ), .A0 (QI0), .A1 (QI1), 
	.A2 (QI2), .A3 (QI3), .A4 (QI4), 
	.A5 (QI5), .A6 (QI6), .A7 (\$4N501 ), 
	.A8 (CAI), .A9 (EN), .A10 (\$4N7 ), 
	.A11 (UP));
AND12 \$4I870  (.Z0 (\$4N847 ), .A0 (\~QI0 ), .A1 (\~QI1 ), 
	.A2 (\~QI2 ), .A3 (\~QI3 ), .A4 (\~QI4 ), 
	.A5 (\~QI5 ), .A6 (\~QI6 ), .A7 (\$4N501 ), 
	.A8 (CAI), .A9 (EN), .A10 (\$4N7 ), 
	.A11 (DNUP));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:03:12 1994
`timescale 10 ps / 10 ps 
module CDD14(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CLK, LD, EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CLK;
	input LD;
	input EN;
	input CD;

AND4 \$1I1000  (.Z0(\$1N1019 ), .A0(QI1), .A1(\~QI0 ), .A2(\$1N673 ), 
	.A3(EN));
AND5 \$1I1003  (.Z0(\$1N1017 ), .A0(\~QI3 ), .A1(QI2), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN));
AND5 \$1I1007  (.Z0(\$1N1021 ), .A0(QI3), .A1(\~QI2 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN));
AND4 \$1I1013  (.Z0(\$1N1023 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN));
OR5 \$1I1016  (.Z0(\$1N935 ), .A0(LOAD1), .A1(\$1N1019 ), .A2(\$1N1017 ), 
	.A3(\$1N1021 ), .A4(\$1N1023 ));
AND2 \$1I1025  (.Z0(HOLD2), .A0(QI2), .A1(\$1N673 ));
AND4 \$1I1032  (.Z0(\$1N822 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN));
AND2 \$1I1035  (.Z0(HOLD3), .A0(QI3), .A1(\$1N673 ));
AND5 \$1I1036  (.Z0(\$1N1051 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN));
AND4 \$1I1040  (.Z0(\$1N1049 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN));
AND4 \$1I1046  (.Z0(\$1N1053 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN));
OR4 \$1I1048  (.Z0(\$1N895 ), .A0(LOAD3), .A1(\$1N1051 ), .A2(\$1N1049 ), 
	.A3(\$1N1053 ));
BUF \$1I1075  (.Z0(Q3), .A0(QI3));
BUF \$1I1076  (.Z0(Q2), .A0(QI2));
BUF \$1I1077  (.Z0(Q1), .A0(QI1));
BUF \$1I1078  (.Z0(Q0), .A0(QI0));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N935 ));
LXOR2 \$1I504  (.Z0(\$1N562 ), .A0(HOLD2), .A1(\$1N546 ));
LXOR2 \$1I518  (.Z0(\$1N568 ), .A0(HOLD3), .A1(\$1N895 ));
INV \$1I578  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I579  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I581  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
FD21 \$1I942  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK), .CD(CD));
FD21 \$1I943  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK), .CD(CD));
FD21 \$1I944  (.Q0(QI2), .D0(\$1N562 ), .CLK(CLK), .CD(CD));
FD21 \$1I945  (.Q0(QI3), .D0(\$1N568 ), .CLK(CLK), .CD(CD));
AND2 \$1I951  (.Z0(LOAD0), .A0(D0), .A1(LD));
AND3 \$1I952  (.Z0(\$1N995 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN));
AND4 \$1I953  (.Z0(\$1N993 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN));
AND2 \$1I955  (.Z0(LOAD1), .A0(D1), .A1(LD));
AND2 \$1I960  (.Z0(LOAD2), .A0(D2), .A1(LD));
AND5 \$1I961  (.Z0(\$1N824 ), .A0(QI3), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN));
AND5 \$1I962  (.Z0(\$1N966 ), .A0(QI2), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN));
AND2 \$1I972  (.Z0(LOAD3), .A0(D3), .A1(LD));
OR4 \$1I981  (.Z0(\$1N546 ), .A0(LOAD2), .A1(\$1N824 ), .A2(\$1N966 ), 
	.A3(\$1N822 ));
AND2 \$1I985  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ));
AND4 \$1I987  (.Z0(\$1N997 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN));
OR4 \$1I992  (.Z0(\$1N522 ), .A0(LOAD0), .A1(\$1N995 ), .A2(\$1N993 ), 
	.A3(\$1N997 ));
AND2 \$1I999  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:03:18 1994
`timescale 10 ps / 10 ps 
module CDD18(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	CLK, LD, EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CLK;
	input LD;
	input EN;
	input CD;

AND4 \$1I1000  (.Z0(\$1N1019 ), .A0(QI1), .A1(\~QI0 ), .A2(\$1N673 ), 
	.A3(EN));
AND5 \$1I1003  (.Z0(\$1N1017 ), .A0(\~QI3 ), .A1(QI2), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN));
AND5 \$1I1007  (.Z0(\$1N1021 ), .A0(QI3), .A1(\~QI2 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN));
AND4 \$1I1013  (.Z0(\$1N1023 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN));
OR5 \$1I1016  (.Z0(\$1N935 ), .A0(LOAD1), .A1(\$1N1019 ), .A2(\$1N1017 ), 
	.A3(\$1N1021 ), .A4(\$1N1023 ));
AND2 \$1I1025  (.Z0(HOLD2), .A0(QI2), .A1(\$1N673 ));
AND4 \$1I1032  (.Z0(\$1N822 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN));
AND2 \$1I1035  (.Z0(HOLD3), .A0(QI3), .A1(\$1N673 ));
AND5 \$1I1036  (.Z0(\$1N1051 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN));
AND4 \$1I1040  (.Z0(\$1N1049 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN));
AND4 \$1I1046  (.Z0(\$1N1053 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN));
OR4 \$1I1048  (.Z0(\$1N895 ), .A0(LOAD3), .A1(\$1N1051 ), .A2(\$1N1049 ), 
	.A3(\$1N1053 ));
BUF \$1I1084  (.Z0(Q7), .A0(QI7));
BUF \$1I1085  (.Z0(Q6), .A0(QI6));
BUF \$1I1086  (.Z0(Q5), .A0(QI5));
BUF \$1I1087  (.Z0(Q4), .A0(QI4));
BUF \$1I1088  (.Z0(Q3), .A0(QI3));
BUF \$1I1089  (.Z0(Q2), .A0(QI2));
BUF \$1I1090  (.Z0(Q1), .A0(QI1));
BUF \$1I1091  (.Z0(Q0), .A0(QI0));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N935 ));
LXOR2 \$1I504  (.Z0(\$1N562 ), .A0(HOLD2), .A1(\$1N546 ));
LXOR2 \$1I518  (.Z0(\$1N568 ), .A0(HOLD3), .A1(\$1N895 ));
INV \$1I578  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I579  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I581  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
FD21 \$1I942  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK), .CD(CD));
FD21 \$1I943  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK), .CD(CD));
FD21 \$1I944  (.Q0(QI2), .D0(\$1N562 ), .CLK(CLK), .CD(CD));
FD21 \$1I945  (.Q0(QI3), .D0(\$1N568 ), .CLK(CLK), .CD(CD));
AND2 \$1I951  (.Z0(LOAD0), .A0(D0), .A1(LD));
AND3 \$1I952  (.Z0(\$1N995 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN));
AND4 \$1I953  (.Z0(\$1N993 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN));
AND2 \$1I955  (.Z0(LOAD1), .A0(D1), .A1(LD));
AND2 \$1I960  (.Z0(LOAD2), .A0(D2), .A1(LD));
AND5 \$1I961  (.Z0(\$1N824 ), .A0(QI3), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN));
AND5 \$1I962  (.Z0(\$1N966 ), .A0(QI2), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN));
AND2 \$1I972  (.Z0(LOAD3), .A0(D3), .A1(LD));
OR4 \$1I981  (.Z0(\$1N546 ), .A0(LOAD2), .A1(\$1N824 ), .A2(\$1N966 ), 
	.A3(\$1N822 ));
AND2 \$1I985  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ));
AND4 \$1I987  (.Z0(\$1N997 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN));
OR4 \$1I992  (.Z0(\$1N522 ), .A0(LOAD0), .A1(\$1N995 ), .A2(\$1N993 ), 
	.A3(\$1N997 ));
AND2 \$1I999  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ));
AND9 \$2I1004  (.Z0(\$2N953 ), .A0(\~QI7 ), .A1(QI6), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$2N1069 ), .A8(EN));
AND5 \$2I1133  (.Z0(\$2N1146 ), .A0(QI7), .A1(QI6), .A2(QI4), 
	.A3(\$2N1069 ), .A4(EN));
AND5 \$2I1134  (.Z0(\$2N1149 ), .A0(QI7), .A1(QI5), .A2(QI4), 
	.A3(\$2N1069 ), .A4(EN));
OR5 \$2I1145  (.Z0(\$2N522 ), .A0(\$2N526 ), .A1(\$2N528 ), .A2(\$2N530 ), 
	.A3(\$2N1146 ), .A4(\$2N1149 ));
AND4 \$2I1151  (.Z0(\$2N1157 ), .A0(QI7), .A1(QI5), .A2(\$2N1069 ), 
	.A3(EN));
AND8 \$2I1168  (.Z0(\$2N1199 ), .A0(QI5), .A1(\~QI4 ), .A2(\~QI3 ), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(\~QI0 ), .A6(\$2N1069 ), 
	.A7(EN));
AND9 \$2I1187  (.Z0(\$2N1197 ), .A0(QI7), .A1(\~QI6 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$2N1069 ), .A8(EN));
OR5 \$2I1195  (.Z0(\$2N951 ), .A0(\$2N955 ), .A1(\$2N1199 ), .A2(\$2N953 ), 
	.A3(\$2N1197 ), .A4(\$2N1157 ));
FD21 \$2I361  (.Q0(QI4), .D0(\$2N524 ), .CLK(CLK), .CD(CD));
LXOR2 \$2I487  (.Z0(\$2N524 ), .A0(HOLD4), .A1(\$2N522 ));
FD21 \$2I495  (.Q0(QI5), .D0(\$2N536 ), .CLK(CLK), .CD(CD));
LXOR2 \$2I496  (.Z0(\$2N536 ), .A0(HOLD5), .A1(\$2N951 ));
INV \$2I580  (.ZN0(\~QI5 ), .A0(QI5));
INV \$2I581  (.ZN0(\~QI4 ), .A0(QI4));
INV \$2I672  (.ZN0(\$2N1069 ), .A0(LD));
AND2 \$2I912  (.Z0(\$2N526 ), .A0(D4), .A1(LD));
AND2 \$2I916  (.Z0(\$2N955 ), .A0(D5), .A1(LD));
AND2 \$2I981  (.Z0(HOLD4), .A0(QI4), .A1(\$2N1069 ));
AND2 \$2I982  (.Z0(HOLD5), .A0(QI5), .A1(\$2N1069 ));
AND7 \$2I994  (.Z0(\$2N528 ), .A0(\~QI7 ), .A1(\~QI3 ), .A2(\~QI2 ), 
	.A3(\~QI1 ), .A4(\~QI0 ), .A5(\$2N1069 ), .A6(EN));
AND8 \$2I999  (.Z0(\$2N530 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(\~QI3 ), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(\~QI0 ), .A6(\$2N1069 ), 
	.A7(EN));
AND9 \$3I1011  (.Z0(\$3N1132 ), .A0(QI7), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$3N673 ), .A8(EN));
AND9 \$3I1020  (.Z0(\$3N1095 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$3N673 ), .A8(EN));
AND4 \$3I1069  (.Z0(\$3N1075 ), .A0(QI7), .A1(QI6), .A2(\$3N673 ), 
	.A3(EN));
AND4 \$3I1078  (.Z0(\$3N1091 ), .A0(QI7), .A1(QI6), .A2(\$3N673 ), 
	.A3(EN));
AND4 \$3I1079  (.Z0(\$3N1093 ), .A0(QI7), .A1(QI5), .A2(\$3N673 ), 
	.A3(EN));
AND9 \$3I1121  (.Z0(\$3N1134 ), .A0(QI6), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$3N673 ), .A8(EN));
OR4 \$3I1131  (.Z0(\$3N546 ), .A0(\$3N946 ), .A1(\$3N1132 ), .A2(\$3N1134 ), 
	.A3(\$3N1075 ));
OR4 \$3I1141  (.Z0(\$3N939 ), .A0(\$3N931 ), .A1(\$3N1095 ), .A2(\$3N1091 ), 
	.A3(\$3N1093 ));
LXOR2 \$3I504  (.Z0(\$3N562 ), .A0(HOLD6), .A1(\$3N546 ));
FD21 \$3I505  (.Q0(QI6), .D0(\$3N562 ), .CLK(CLK), .CD(CD));
FD21 \$3I517  (.Q0(QI7), .D0(\$3N568 ), .CLK(CLK), .CD(CD));
LXOR2 \$3I518  (.Z0(\$3N568 ), .A0(HOLD7), .A1(\$3N939 ));
INV \$3I578  (.ZN0(\~QI7 ), .A0(QI7));
INV \$3I579  (.ZN0(\~QI6 ), .A0(QI6));
INV \$3I672  (.ZN0(\$3N673 ), .A0(LD));
AND2 \$3I920  (.Z0(\$3N946 ), .A0(D6), .A1(LD));
AND2 \$3I925  (.Z0(\$3N931 ), .A0(D7), .A1(LD));
AND2 \$3I984  (.Z0(HOLD6), .A0(QI6), .A1(\$3N673 ));
AND2 \$3I989  (.Z0(HOLD7), .A0(QI7), .A1(\$3N673 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:03:22 1994
`timescale 10 ps / 10 ps 
module CDD24(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CLK, LD, EN, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CLK;
	input LD;
	input EN;
	input CS;

OR5 \$1I1016  (.Z0(\$1N935 ), .A0(LOAD1), .A1(\$1N1019 ), .A2(\$1N1017 ), 
	.A3(\$1N1021 ), .A4(\$1N1023 ));
OR4 \$1I1048  (.Z0(\$1N895 ), .A0(LOAD3), .A1(\$1N1051 ), .A2(\$1N1049 ), 
	.A3(\$1N1053 ));
INV \$1I1056  (.ZN0(\$1N1058 ), .A0(CS));
AND3 \$1I1059  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ), .A2(\$1N1058 ));
AND3 \$1I1061  (.Z0(LOAD0), .A0(D0), .A1(LD), .A2(\$1N1058 ));
AND4 \$1I1063  (.Z0(\$1N995 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN), 
	.A3(\$1N1058 ));
AND5 \$1I1065  (.Z0(\$1N993 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1058 ));
AND5 \$1I1067  (.Z0(\$1N997 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1058 ));
AND3 \$1I1069  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ), .A2(\$1N1058 ));
AND3 \$1I1071  (.Z0(LOAD1), .A0(D1), .A1(LD), .A2(\$1N1058 ));
AND5 \$1I1073  (.Z0(\$1N1019 ), .A0(QI1), .A1(\~QI0 ), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1058 ));
AND6 \$1I1075  (.Z0(\$1N1017 ), .A0(\~QI3 ), .A1(QI2), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(\$1N1058 ));
AND6 \$1I1077  (.Z0(\$1N1021 ), .A0(QI3), .A1(\~QI2 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(\$1N1058 ));
AND5 \$1I1079  (.Z0(\$1N1023 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1058 ));
AND3 \$1I1081  (.Z0(HOLD2), .A0(QI2), .A1(\$1N673 ), .A2(\$1N1058 ));
AND3 \$1I1083  (.Z0(LOAD2), .A0(D2), .A1(LD), .A2(\$1N1058 ));
AND6 \$1I1085  (.Z0(\$1N824 ), .A0(QI3), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(\$1N1058 ));
AND6 \$1I1087  (.Z0(\$1N966 ), .A0(QI2), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(\$1N1058 ));
AND5 \$1I1089  (.Z0(\$1N822 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1058 ));
AND3 \$1I1091  (.Z0(HOLD3), .A0(QI3), .A1(\$1N673 ), .A2(\$1N1058 ));
AND3 \$1I1093  (.Z0(LOAD3), .A0(D3), .A1(LD), .A2(\$1N1058 ));
AND6 \$1I1096  (.Z0(\$1N1051 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(\$1N1058 ));
AND5 \$1I1098  (.Z0(\$1N1049 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1058 ));
AND5 \$1I1100  (.Z0(\$1N1053 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1058 ));
BUF \$1I1121  (.Z0(Q3), .A0(QI3));
BUF \$1I1122  (.Z0(Q2), .A0(QI2));
BUF \$1I1123  (.Z0(Q1), .A0(QI1));
BUF \$1I1124  (.Z0(Q0), .A0(QI0));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N935 ));
LXOR2 \$1I504  (.Z0(\$1N562 ), .A0(HOLD2), .A1(\$1N546 ));
LXOR2 \$1I518  (.Z0(\$1N568 ), .A0(HOLD3), .A1(\$1N895 ));
INV \$1I578  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I579  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I581  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
FD11 \$1I942  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK));
FD11 \$1I943  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK));
FD11 \$1I944  (.Q0(QI2), .D0(\$1N562 ), .CLK(CLK));
FD11 \$1I945  (.Q0(QI3), .D0(\$1N568 ), .CLK(CLK));
OR4 \$1I981  (.Z0(\$1N546 ), .A0(LOAD2), .A1(\$1N824 ), .A2(\$1N966 ), 
	.A3(\$1N822 ));
OR4 \$1I992  (.Z0(\$1N522 ), .A0(LOAD0), .A1(\$1N995 ), .A2(\$1N993 ), 
	.A3(\$1N997 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:03:28 1994
`timescale 10 ps / 10 ps 
module CDD28(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	CLK, LD, EN, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CLK;
	input LD;
	input EN;
	input CS;

OR5 \$1I1016  (.Z0(\$1N935 ), .A0(LOAD1), .A1(\$1N1019 ), .A2(\$1N1017 ), 
	.A3(\$1N1021 ), .A4(\$1N1023 ));
OR4 \$1I1048  (.Z0(\$1N895 ), .A0(LOAD3), .A1(\$1N1051 ), .A2(\$1N1049 ), 
	.A3(\$1N1053 ));
INV \$1I1056  (.ZN0(\$1N1058 ), .A0(CS));
AND3 \$1I1059  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ), .A2(\$1N1058 ));
AND3 \$1I1061  (.Z0(LOAD0), .A0(D0), .A1(LD), .A2(\$1N1058 ));
AND4 \$1I1063  (.Z0(\$1N995 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN), 
	.A3(\$1N1058 ));
AND5 \$1I1065  (.Z0(\$1N993 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1058 ));
AND5 \$1I1067  (.Z0(\$1N997 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1058 ));
AND3 \$1I1069  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ), .A2(\$1N1058 ));
AND3 \$1I1071  (.Z0(LOAD1), .A0(D1), .A1(LD), .A2(\$1N1058 ));
AND5 \$1I1073  (.Z0(\$1N1019 ), .A0(QI1), .A1(\~QI0 ), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1058 ));
AND6 \$1I1075  (.Z0(\$1N1017 ), .A0(\~QI3 ), .A1(QI2), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(\$1N1058 ));
AND6 \$1I1077  (.Z0(\$1N1021 ), .A0(QI3), .A1(\~QI2 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(\$1N1058 ));
AND5 \$1I1079  (.Z0(\$1N1023 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1058 ));
AND3 \$1I1081  (.Z0(HOLD2), .A0(QI2), .A1(\$1N673 ), .A2(\$1N1058 ));
AND3 \$1I1083  (.Z0(LOAD2), .A0(D2), .A1(LD), .A2(\$1N1058 ));
AND6 \$1I1085  (.Z0(\$1N824 ), .A0(QI3), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(\$1N1058 ));
AND6 \$1I1087  (.Z0(\$1N966 ), .A0(QI2), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(\$1N1058 ));
AND5 \$1I1089  (.Z0(\$1N822 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1058 ));
AND3 \$1I1091  (.Z0(HOLD3), .A0(QI3), .A1(\$1N673 ), .A2(\$1N1058 ));
AND3 \$1I1093  (.Z0(LOAD3), .A0(D3), .A1(LD), .A2(\$1N1058 ));
AND6 \$1I1096  (.Z0(\$1N1051 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(\$1N1058 ));
AND5 \$1I1098  (.Z0(\$1N1049 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1058 ));
AND5 \$1I1100  (.Z0(\$1N1053 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1058 ));
BUF \$1I1130  (.Z0(Q7), .A0(QI7));
BUF \$1I1131  (.Z0(Q6), .A0(QI6));
BUF \$1I1132  (.Z0(Q5), .A0(QI5));
BUF \$1I1133  (.Z0(Q4), .A0(QI4));
BUF \$1I1134  (.Z0(Q3), .A0(QI3));
BUF \$1I1135  (.Z0(Q2), .A0(QI2));
BUF \$1I1136  (.Z0(Q1), .A0(QI1));
BUF \$1I1137  (.Z0(Q0), .A0(QI0));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N935 ));
LXOR2 \$1I504  (.Z0(\$1N562 ), .A0(HOLD2), .A1(\$1N546 ));
LXOR2 \$1I518  (.Z0(\$1N568 ), .A0(HOLD3), .A1(\$1N895 ));
INV \$1I578  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I579  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I581  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
FD11 \$1I942  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK));
FD11 \$1I943  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK));
FD11 \$1I944  (.Q0(QI2), .D0(\$1N562 ), .CLK(CLK));
FD11 \$1I945  (.Q0(QI3), .D0(\$1N568 ), .CLK(CLK));
OR4 \$1I981  (.Z0(\$1N546 ), .A0(LOAD2), .A1(\$1N824 ), .A2(\$1N966 ), 
	.A3(\$1N822 ));
OR4 \$1I992  (.Z0(\$1N522 ), .A0(LOAD0), .A1(\$1N995 ), .A2(\$1N993 ), 
	.A3(\$1N997 ));
OR5 \$2I1145  (.Z0(\$2N522 ), .A0(\$2N526 ), .A1(\$2N528 ), .A2(\$2N530 ), 
	.A3(\$2N1146 ), .A4(\$2N1149 ));
OR5 \$2I1195  (.Z0(\$2N951 ), .A0(\$2N955 ), .A1(\$2N1199 ), .A2(\$2N953 ), 
	.A3(\$2N1197 ), .A4(\$2N1157 ));
INV \$2I1203  (.ZN0(\$2N1201 ), .A0(CS));
AND3 \$2I1204  (.Z0(HOLD4), .A0(QI4), .A1(\$2N1069 ), .A2(\$2N1201 ));
AND3 \$2I1206  (.Z0(\$2N526 ), .A0(D4), .A1(LD), .A2(\$2N1201 ));
AND8 \$2I1208  (.Z0(\$2N528 ), .A0(\~QI7 ), .A1(\~QI3 ), .A2(\~QI2 ), 
	.A3(\~QI1 ), .A4(\~QI0 ), .A5(\$2N1069 ), .A6(EN), 
	.A7(\$2N1201 ));
AND9 \$2I1210  (.Z0(\$2N530 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(\~QI3 ), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(\~QI0 ), .A6(\$2N1069 ), 
	.A7(EN), .A8(\$2N1201 ));
AND6 \$2I1212  (.Z0(\$2N1146 ), .A0(QI7), .A1(QI6), .A2(QI4), 
	.A3(\$2N1069 ), .A4(EN), .A5(\$2N1201 ));
AND6 \$2I1214  (.Z0(\$2N1149 ), .A0(QI7), .A1(QI5), .A2(QI4), 
	.A3(\$2N1069 ), .A4(EN), .A5(\$2N1201 ));
AND3 \$2I1216  (.Z0(HOLD5), .A0(QI5), .A1(\$2N1069 ), .A2(\$2N1201 ));
AND3 \$2I1218  (.Z0(\$2N955 ), .A0(D5), .A1(LD), .A2(\$2N1201 ));
AND9 \$2I1220  (.Z0(\$2N1199 ), .A0(QI5), .A1(\~QI4 ), .A2(\~QI3 ), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(\~QI0 ), .A6(\$2N1069 ), 
	.A7(EN), .A8(\$2N1201 ));
AND10 \$2I1222  (.Z0(\$2N953 ), .A0(\~QI7 ), .A1(QI6), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$2N1069 ), .A8(EN), .A9(\$2N1201 ));
AND10 \$2I1224  (.Z0(\$2N1197 ), .A0(QI7), .A1(\~QI6 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$2N1069 ), .A8(EN), .A9(\$2N1201 ));
AND5 \$2I1226  (.Z0(\$2N1157 ), .A0(QI7), .A1(QI5), .A2(\$2N1069 ), 
	.A3(EN), .A4(\$2N1201 ));
FD11 \$2I361  (.Q0(QI4), .D0(\$2N524 ), .CLK(CLK));
LXOR2 \$2I487  (.Z0(\$2N524 ), .A0(HOLD4), .A1(\$2N522 ));
FD11 \$2I495  (.Q0(QI5), .D0(\$2N536 ), .CLK(CLK));
LXOR2 \$2I496  (.Z0(\$2N536 ), .A0(HOLD5), .A1(\$2N951 ));
INV \$2I580  (.ZN0(\~QI5 ), .A0(QI5));
INV \$2I581  (.ZN0(\~QI4 ), .A0(QI4));
INV \$2I672  (.ZN0(\$2N1069 ), .A0(LD));
OR4 \$3I1131  (.Z0(\$3N546 ), .A0(\$3N946 ), .A1(\$3N1132 ), .A2(\$3N1134 ), 
	.A3(\$3N1075 ));
OR4 \$3I1141  (.Z0(\$3N939 ), .A0(\$3N931 ), .A1(\$3N1095 ), .A2(\$3N1091 ), 
	.A3(\$3N1093 ));
INV \$3I1144  (.ZN0(\$3N1142 ), .A0(CS));
AND3 \$3I1145  (.Z0(HOLD6), .A0(QI6), .A1(\$3N673 ), .A2(\$3N1142 ));
AND3 \$3I1147  (.Z0(\$3N946 ), .A0(D6), .A1(LD), .A2(\$3N1142 ));
AND10 \$3I1149  (.Z0(\$3N1132 ), .A0(QI7), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$3N673 ), .A8(EN), .A9(\$3N1142 ));
AND10 \$3I1151  (.Z0(\$3N1134 ), .A0(QI6), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$3N673 ), .A8(EN), .A9(\$3N1142 ));
AND5 \$3I1153  (.Z0(\$3N1075 ), .A0(QI7), .A1(QI6), .A2(\$3N673 ), 
	.A3(EN), .A4(\$3N1142 ));
AND3 \$3I1155  (.Z0(HOLD7), .A0(QI7), .A1(\$3N673 ), .A2(\$3N1142 ));
AND3 \$3I1157  (.Z0(\$3N931 ), .A0(D7), .A1(LD), .A2(\$3N1142 ));
AND10 \$3I1159  (.Z0(\$3N1095 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$3N673 ), .A8(EN), .A9(\$3N1142 ));
AND5 \$3I1161  (.Z0(\$3N1091 ), .A0(QI7), .A1(QI6), .A2(\$3N673 ), 
	.A3(EN), .A4(\$3N1142 ));
AND5 \$3I1163  (.Z0(\$3N1093 ), .A0(QI7), .A1(QI5), .A2(\$3N673 ), 
	.A3(EN), .A4(\$3N1142 ));
LXOR2 \$3I504  (.Z0(\$3N562 ), .A0(HOLD6), .A1(\$3N546 ));
FD11 \$3I505  (.Q0(QI6), .D0(\$3N562 ), .CLK(CLK));
FD11 \$3I517  (.Q0(QI7), .D0(\$3N568 ), .CLK(CLK));
LXOR2 \$3I518  (.Z0(\$3N568 ), .A0(HOLD7), .A1(\$3N939 ));
INV \$3I578  (.ZN0(\~QI7 ), .A0(QI7));
INV \$3I579  (.ZN0(\~QI6 ), .A0(QI6));
INV \$3I672  (.ZN0(\$3N673 ), .A0(LD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:03:32 1994
`timescale 10 ps / 10 ps 
module CDD34(
	Q0, Q1, Q2, Q3, 
	CAO, D0, D1, D2, 
	D3, CAI, CLK, LD, 
	EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input CAI;
	input CLK;
	input LD;
	input EN;
	input CD;

OR5 \$1I1016  (.Z0(\$1N935 ), .A0(LOAD1), .A1(\$1N1019 ), .A2(\$1N1017 ), 
	.A3(\$1N1021 ), .A4(\$1N1023 ));
AND2 \$1I1025  (.Z0(HOLD2), .A0(QI2), .A1(\$1N673 ));
AND2 \$1I1035  (.Z0(HOLD3), .A0(QI3), .A1(\$1N673 ));
OR4 \$1I1048  (.Z0(\$1N895 ), .A0(LOAD3), .A1(\$1N1051 ), .A2(\$1N1049 ), 
	.A3(\$1N1053 ));
AND4 \$1I1057  (.Z0(\$1N995 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(CAI), 
	.A3(EN));
AND5 \$1I1059  (.Z0(\$1N993 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(CAI), .A4(EN));
AND5 \$1I1061  (.Z0(\$1N997 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(CAI), .A4(EN));
AND5 \$1I1063  (.Z0(\$1N1019 ), .A0(QI1), .A1(\~QI0 ), .A2(\$1N673 ), 
	.A3(CAI), .A4(EN));
AND6 \$1I1065  (.Z0(\$1N1017 ), .A0(\~QI3 ), .A1(QI2), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(CAI), .A5(EN));
AND6 \$1I1067  (.Z0(\$1N1021 ), .A0(QI3), .A1(\~QI2 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(CAI), .A5(EN));
AND5 \$1I1069  (.Z0(\$1N1023 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(CAI), .A4(EN));
AND6 \$1I1071  (.Z0(\$1N824 ), .A0(QI3), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(CAI), .A5(EN));
AND6 \$1I1073  (.Z0(\$1N966 ), .A0(QI2), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(CAI), .A5(EN));
AND5 \$1I1075  (.Z0(\$1N822 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(CAI), .A4(EN));
AND6 \$1I1077  (.Z0(\$1N1051 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(CAI), .A5(EN));
AND5 \$1I1079  (.Z0(\$1N1049 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(CAI), .A4(EN));
AND5 \$1I1081  (.Z0(\$1N1053 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(CAI), .A4(EN));
AND6 \$1I1084  (.Z0(CAO), .A0(\~QI3 ), .A1(\~QI2 ), .A2(\~QI1 ), 
	.A3(\~QI0 ), .A4(CAI), .A5(EN));
BUF \$1I1114  (.Z0(Q0), .A0(QI0));
BUF \$1I1115  (.Z0(Q1), .A0(QI1));
BUF \$1I1116  (.Z0(Q2), .A0(QI2));
BUF \$1I1117  (.Z0(Q3), .A0(QI3));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N935 ));
LXOR2 \$1I504  (.Z0(\$1N562 ), .A0(HOLD2), .A1(\$1N546 ));
LXOR2 \$1I518  (.Z0(\$1N568 ), .A0(HOLD3), .A1(\$1N895 ));
INV \$1I578  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I579  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I581  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
FD21 \$1I942  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK), .CD(CD));
FD21 \$1I943  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK), .CD(CD));
FD21 \$1I944  (.Q0(QI2), .D0(\$1N562 ), .CLK(CLK), .CD(CD));
FD21 \$1I945  (.Q0(QI3), .D0(\$1N568 ), .CLK(CLK), .CD(CD));
AND2 \$1I951  (.Z0(LOAD0), .A0(D0), .A1(LD));
AND2 \$1I955  (.Z0(LOAD1), .A0(D1), .A1(LD));
AND2 \$1I960  (.Z0(LOAD2), .A0(D2), .A1(LD));
AND2 \$1I972  (.Z0(LOAD3), .A0(D3), .A1(LD));
OR4 \$1I981  (.Z0(\$1N546 ), .A0(LOAD2), .A1(\$1N824 ), .A2(\$1N966 ), 
	.A3(\$1N822 ));
AND2 \$1I985  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ));
OR4 \$1I992  (.Z0(\$1N522 ), .A0(LOAD0), .A1(\$1N995 ), .A2(\$1N993 ), 
	.A3(\$1N997 ));
AND2 \$1I999  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:03:38 1994
`timescale 10 ps / 10 ps 
module CDD38(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	CAO, D0, D1, D2, 
	D3, D4, D5, D6, 
	D7, CAI, CLK, LD, 
	EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CAI;
	input CLK;
	input LD;
	input EN;
	input CD;

OR5 \$1I1016  (.Z0(\$1N935 ), .A0(LOAD1), .A1(\$1N1019 ), .A2(\$1N1017 ), 
	.A3(\$1N1021 ), .A4(\$1N1023 ));
AND2 \$1I1025  (.Z0(HOLD2), .A0(QI2), .A1(\$1N673 ));
AND2 \$1I1035  (.Z0(HOLD3), .A0(QI3), .A1(\$1N673 ));
OR4 \$1I1048  (.Z0(\$1N895 ), .A0(LOAD3), .A1(\$1N1051 ), .A2(\$1N1049 ), 
	.A3(\$1N1053 ));
AND4 \$1I1057  (.Z0(\$1N995 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(CAI), 
	.A3(EN));
AND5 \$1I1059  (.Z0(\$1N993 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(CAI), .A4(EN));
AND5 \$1I1061  (.Z0(\$1N997 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(CAI), .A4(EN));
AND5 \$1I1063  (.Z0(\$1N1019 ), .A0(QI1), .A1(\~QI0 ), .A2(\$1N673 ), 
	.A3(CAI), .A4(EN));
AND6 \$1I1065  (.Z0(\$1N1017 ), .A0(\~QI3 ), .A1(QI2), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(CAI), .A5(EN));
AND6 \$1I1067  (.Z0(\$1N1021 ), .A0(QI3), .A1(\~QI2 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(CAI), .A5(EN));
AND5 \$1I1069  (.Z0(\$1N1023 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(CAI), .A4(EN));
AND6 \$1I1071  (.Z0(\$1N824 ), .A0(QI3), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(CAI), .A5(EN));
AND6 \$1I1073  (.Z0(\$1N966 ), .A0(QI2), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(CAI), .A5(EN));
AND5 \$1I1075  (.Z0(\$1N822 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(CAI), .A4(EN));
AND6 \$1I1077  (.Z0(\$1N1051 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(CAI), .A5(EN));
AND5 \$1I1079  (.Z0(\$1N1049 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(CAI), .A4(EN));
AND5 \$1I1081  (.Z0(\$1N1053 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(CAI), .A4(EN));
AND10 \$1I1084  (.Z0(CAO), .A0(\~QI7 ), .A1(\~QI6 ), .A2(\~QI5 ), 
	.A3(\~QI4 ), .A4(\~QI3 ), .A5(\~QI2 ), .A6(\~QI1 ), 
	.A7(\~QI0 ), .A8(CAI), .A9(EN));
BUF \$1I1144  (.Z0(Q0), .A0(QI0));
BUF \$1I1145  (.Z0(Q1), .A0(QI1));
BUF \$1I1146  (.Z0(Q2), .A0(QI2));
BUF \$1I1147  (.Z0(Q3), .A0(QI3));
BUF \$1I1148  (.Z0(Q4), .A0(QI4));
BUF \$1I1149  (.Z0(Q5), .A0(QI5));
BUF \$1I1150  (.Z0(Q6), .A0(QI6));
BUF \$1I1151  (.Z0(Q7), .A0(QI7));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N935 ));
LXOR2 \$1I504  (.Z0(\$1N562 ), .A0(HOLD2), .A1(\$1N546 ));
LXOR2 \$1I518  (.Z0(\$1N568 ), .A0(HOLD3), .A1(\$1N895 ));
INV \$1I578  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I579  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I581  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
FD21 \$1I942  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK), .CD(CD));
FD21 \$1I943  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK), .CD(CD));
FD21 \$1I944  (.Q0(QI2), .D0(\$1N562 ), .CLK(CLK), .CD(CD));
FD21 \$1I945  (.Q0(QI3), .D0(\$1N568 ), .CLK(CLK), .CD(CD));
AND2 \$1I951  (.Z0(LOAD0), .A0(D0), .A1(LD));
AND2 \$1I955  (.Z0(LOAD1), .A0(D1), .A1(LD));
AND2 \$1I960  (.Z0(LOAD2), .A0(D2), .A1(LD));
AND2 \$1I972  (.Z0(LOAD3), .A0(D3), .A1(LD));
OR4 \$1I981  (.Z0(\$1N546 ), .A0(LOAD2), .A1(\$1N824 ), .A2(\$1N966 ), 
	.A3(\$1N822 ));
AND2 \$1I985  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ));
OR4 \$1I992  (.Z0(\$1N522 ), .A0(LOAD0), .A1(\$1N995 ), .A2(\$1N993 ), 
	.A3(\$1N997 ));
AND2 \$1I999  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ));
OR5 \$2I1145  (.Z0(\$2N522 ), .A0(\$2N526 ), .A1(\$2N528 ), .A2(\$2N530 ), 
	.A3(\$2N1146 ), .A4(\$2N1149 ));
OR5 \$2I1195  (.Z0(\$2N951 ), .A0(\$2N955 ), .A1(\$2N1199 ), .A2(\$2N953 ), 
	.A3(\$2N1197 ), .A4(\$2N1157 ));
AND8 \$2I1202  (.Z0(\$2N528 ), .A0(\~QI7 ), .A1(\~QI3 ), .A2(\~QI2 ), 
	.A3(\~QI1 ), .A4(\~QI0 ), .A5(\$2N1069 ), .A6(EN), 
	.A7(CAI));
AND9 \$2I1204  (.Z0(\$2N530 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(\~QI3 ), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(\~QI0 ), .A6(\$2N1069 ), 
	.A7(EN), .A8(CAI));
AND6 \$2I1206  (.Z0(\$2N1146 ), .A0(QI7), .A1(QI6), .A2(QI4), 
	.A3(\$2N1069 ), .A4(EN), .A5(CAI));
AND6 \$2I1208  (.Z0(\$2N1149 ), .A0(QI7), .A1(QI5), .A2(QI4), 
	.A3(\$2N1069 ), .A4(EN), .A5(CAI));
AND9 \$2I1210  (.Z0(\$2N1199 ), .A0(QI5), .A1(\~QI4 ), .A2(\~QI3 ), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(\~QI0 ), .A6(\$2N1069 ), 
	.A7(EN), .A8(CAI));
AND10 \$2I1212  (.Z0(\$2N953 ), .A0(\~QI7 ), .A1(QI6), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$2N1069 ), .A8(EN), .A9(CAI));
AND10 \$2I1214  (.Z0(\$2N1197 ), .A0(QI7), .A1(\~QI6 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$2N1069 ), .A8(EN), .A9(CAI));
AND5 \$2I1216  (.Z0(\$2N1157 ), .A0(QI7), .A1(QI5), .A2(\$2N1069 ), 
	.A3(EN), .A4(CAI));
FD21 \$2I361  (.Q0(QI4), .D0(\$2N524 ), .CLK(CLK), .CD(CD));
LXOR2 \$2I487  (.Z0(\$2N524 ), .A0(HOLD4), .A1(\$2N522 ));
FD21 \$2I495  (.Q0(QI5), .D0(\$2N536 ), .CLK(CLK), .CD(CD));
LXOR2 \$2I496  (.Z0(\$2N536 ), .A0(HOLD5), .A1(\$2N951 ));
INV \$2I580  (.ZN0(\~QI5 ), .A0(QI5));
INV \$2I581  (.ZN0(\~QI4 ), .A0(QI4));
INV \$2I672  (.ZN0(\$2N1069 ), .A0(LD));
AND2 \$2I912  (.Z0(\$2N526 ), .A0(D4), .A1(LD));
AND2 \$2I916  (.Z0(\$2N955 ), .A0(D5), .A1(LD));
AND2 \$2I981  (.Z0(HOLD4), .A0(QI4), .A1(\$2N1069 ));
AND2 \$2I982  (.Z0(HOLD5), .A0(QI5), .A1(\$2N1069 ));
OR4 \$3I1131  (.Z0(\$3N546 ), .A0(\$3N946 ), .A1(\$3N1132 ), .A2(\$3N1134 ), 
	.A3(\$3N1075 ));
OR4 \$3I1141  (.Z0(\$3N939 ), .A0(\$3N931 ), .A1(\$3N1095 ), .A2(\$3N1091 ), 
	.A3(\$3N1093 ));
AND10 \$3I1149  (.Z0(\$3N1132 ), .A0(QI7), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$3N673 ), .A8(EN), .A9(CAI));
AND10 \$3I1151  (.Z0(\$3N1134 ), .A0(QI6), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$3N673 ), .A8(EN), .A9(CAI));
AND5 \$3I1153  (.Z0(\$3N1075 ), .A0(QI7), .A1(QI6), .A2(\$3N673 ), 
	.A3(EN), .A4(CAI));
AND10 \$3I1155  (.Z0(\$3N1095 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$3N673 ), .A8(EN), .A9(CAI));
AND5 \$3I1157  (.Z0(\$3N1091 ), .A0(QI7), .A1(QI6), .A2(\$3N673 ), 
	.A3(EN), .A4(CAI));
AND5 \$3I1159  (.Z0(\$3N1093 ), .A0(QI7), .A1(QI5), .A2(\$3N673 ), 
	.A3(EN), .A4(CAI));
LXOR2 \$3I504  (.Z0(\$3N562 ), .A0(HOLD6), .A1(\$3N546 ));
FD21 \$3I505  (.Q0(QI6), .D0(\$3N562 ), .CLK(CLK), .CD(CD));
FD21 \$3I517  (.Q0(QI7), .D0(\$3N568 ), .CLK(CLK), .CD(CD));
LXOR2 \$3I518  (.Z0(\$3N568 ), .A0(HOLD7), .A1(\$3N939 ));
INV \$3I578  (.ZN0(\~QI7 ), .A0(QI7));
INV \$3I579  (.ZN0(\~QI6 ), .A0(QI6));
INV \$3I672  (.ZN0(\$3N673 ), .A0(LD));
AND2 \$3I920  (.Z0(\$3N946 ), .A0(D6), .A1(LD));
AND2 \$3I925  (.Z0(\$3N931 ), .A0(D7), .A1(LD));
AND2 \$3I984  (.Z0(HOLD6), .A0(QI6), .A1(\$3N673 ));
AND2 \$3I989  (.Z0(HOLD7), .A0(QI7), .A1(\$3N673 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:03:42 1994
`timescale 10 ps / 10 ps 
module CDD44(
	Q0, Q1, Q2, Q3, 
	CAO, D0, D1, D2, 
	D3, CAI, CLK, LD, 
	EN, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input CAI;
	input CLK;
	input LD;
	input EN;
	input CS;

OR5 \$1I1016  (.Z0(\$1N935 ), .A0(LOAD1), .A1(\$1N1019 ), .A2(\$1N1017 ), 
	.A3(\$1N1021 ), .A4(\$1N1023 ));
OR4 \$1I1048  (.Z0(\$1N895 ), .A0(LOAD3), .A1(\$1N1051 ), .A2(\$1N1049 ), 
	.A3(\$1N1053 ));
AND6 \$1I1084  (.Z0(CAO), .A0(\~QI3 ), .A1(\~QI2 ), .A2(\~QI1 ), 
	.A3(\~QI0 ), .A4(EN), .A5(CAI));
INV \$1I1092  (.ZN0(\$1N1093 ), .A0(CS));
AND3 \$1I1095  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ), .A2(\$1N1093 ));
AND3 \$1I1097  (.Z0(LOAD0), .A0(D0), .A1(LD), .A2(\$1N1093 ));
AND5 \$1I1099  (.Z0(\$1N995 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN), 
	.A3(CAI), .A4(\$1N1093 ));
AND6 \$1I1101  (.Z0(\$1N993 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1093 ));
AND6 \$1I1103  (.Z0(\$1N997 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1093 ));
AND3 \$1I1105  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ), .A2(\$1N1093 ));
AND3 \$1I1107  (.Z0(LOAD1), .A0(D1), .A1(LD), .A2(\$1N1093 ));
AND6 \$1I1110  (.Z0(\$1N1019 ), .A0(QI1), .A1(\~QI0 ), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1093 ));
AND7 \$1I1112  (.Z0(\$1N1017 ), .A0(\~QI3 ), .A1(QI2), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(\$1N1093 ));
AND7 \$1I1114  (.Z0(\$1N1021 ), .A0(QI3), .A1(\~QI2 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(\$1N1093 ));
AND6 \$1I1116  (.Z0(\$1N1023 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1093 ));
AND3 \$1I1118  (.Z0(HOLD2), .A0(QI2), .A1(\$1N673 ), .A2(\$1N1093 ));
AND3 \$1I1120  (.Z0(LOAD2), .A0(D2), .A1(LD), .A2(\$1N1093 ));
AND7 \$1I1122  (.Z0(\$1N824 ), .A0(QI3), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(\$1N1093 ));
AND7 \$1I1124  (.Z0(\$1N966 ), .A0(QI2), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(\$1N1093 ));
AND6 \$1I1126  (.Z0(\$1N822 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1093 ));
AND3 \$1I1128  (.Z0(HOLD3), .A0(QI3), .A1(\$1N673 ), .A2(\$1N1093 ));
AND3 \$1I1130  (.Z0(LOAD3), .A0(D3), .A1(LD), .A2(\$1N1093 ));
AND7 \$1I1132  (.Z0(\$1N1051 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(\$1N1093 ));
AND6 \$1I1134  (.Z0(\$1N1049 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1093 ));
AND6 \$1I1136  (.Z0(\$1N1053 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1093 ));
BUF \$1I1159  (.Z0(Q0), .A0(QI0));
BUF \$1I1160  (.Z0(Q1), .A0(QI1));
BUF \$1I1161  (.Z0(Q2), .A0(QI2));
BUF \$1I1162  (.Z0(Q3), .A0(QI3));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N935 ));
LXOR2 \$1I504  (.Z0(\$1N562 ), .A0(HOLD2), .A1(\$1N546 ));
LXOR2 \$1I518  (.Z0(\$1N568 ), .A0(HOLD3), .A1(\$1N895 ));
INV \$1I578  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I579  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I581  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
FD11 \$1I942  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK));
FD11 \$1I943  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK));
FD11 \$1I944  (.Q0(QI2), .D0(\$1N562 ), .CLK(CLK));
FD11 \$1I945  (.Q0(QI3), .D0(\$1N568 ), .CLK(CLK));
OR4 \$1I981  (.Z0(\$1N546 ), .A0(LOAD2), .A1(\$1N824 ), .A2(\$1N966 ), 
	.A3(\$1N822 ));
OR4 \$1I992  (.Z0(\$1N522 ), .A0(LOAD0), .A1(\$1N995 ), .A2(\$1N993 ), 
	.A3(\$1N997 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:03:48 1994
`timescale 10 ps / 10 ps 
module CDD48(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	CAO, D0, D1, D2, 
	D3, D4, D5, D6, 
	D7, CAI, CLK, LD, 
	EN, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CAI;
	input CLK;
	input LD;
	input EN;
	input CS;

OR5 \$1I1016  (.Z0(\$1N935 ), .A0(LOAD1), .A1(\$1N1019 ), .A2(\$1N1017 ), 
	.A3(\$1N1021 ), .A4(\$1N1023 ));
OR4 \$1I1048  (.Z0(\$1N895 ), .A0(LOAD3), .A1(\$1N1051 ), .A2(\$1N1049 ), 
	.A3(\$1N1053 ));
AND10 \$1I1084  (.Z0(CAO), .A0(\~QI7 ), .A1(\~QI6 ), .A2(\~QI5 ), 
	.A3(\~QI4 ), .A4(\~QI3 ), .A5(\~QI2 ), .A6(\~QI1 ), 
	.A7(\~QI0 ), .A8(EN), .A9(CAI));
INV \$1I1092  (.ZN0(\$1N1093 ), .A0(CS));
AND3 \$1I1095  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ), .A2(\$1N1093 ));
AND3 \$1I1097  (.Z0(LOAD0), .A0(D0), .A1(LD), .A2(\$1N1093 ));
AND5 \$1I1099  (.Z0(\$1N995 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN), 
	.A3(CAI), .A4(\$1N1093 ));
AND6 \$1I1101  (.Z0(\$1N993 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1093 ));
AND6 \$1I1103  (.Z0(\$1N997 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1093 ));
AND3 \$1I1105  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ), .A2(\$1N1093 ));
AND3 \$1I1107  (.Z0(LOAD1), .A0(D1), .A1(LD), .A2(\$1N1093 ));
AND6 \$1I1110  (.Z0(\$1N1019 ), .A0(QI1), .A1(\~QI0 ), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1093 ));
AND7 \$1I1112  (.Z0(\$1N1017 ), .A0(\~QI3 ), .A1(QI2), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(\$1N1093 ));
AND7 \$1I1114  (.Z0(\$1N1021 ), .A0(QI3), .A1(\~QI2 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(\$1N1093 ));
AND6 \$1I1116  (.Z0(\$1N1023 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1093 ));
AND3 \$1I1118  (.Z0(HOLD2), .A0(QI2), .A1(\$1N673 ), .A2(\$1N1093 ));
AND3 \$1I1120  (.Z0(LOAD2), .A0(D2), .A1(LD), .A2(\$1N1093 ));
AND7 \$1I1122  (.Z0(\$1N824 ), .A0(QI3), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(\$1N1093 ));
AND7 \$1I1124  (.Z0(\$1N966 ), .A0(QI2), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(\$1N1093 ));
AND6 \$1I1126  (.Z0(\$1N822 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1093 ));
AND3 \$1I1128  (.Z0(HOLD3), .A0(QI3), .A1(\$1N673 ), .A2(\$1N1093 ));
AND3 \$1I1130  (.Z0(LOAD3), .A0(D3), .A1(LD), .A2(\$1N1093 ));
AND7 \$1I1132  (.Z0(\$1N1051 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(\$1N1093 ));
AND6 \$1I1134  (.Z0(\$1N1049 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1093 ));
AND6 \$1I1136  (.Z0(\$1N1053 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1093 ));
BUF \$1I1179  (.Z0(Q0), .A0(QI0));
BUF \$1I1180  (.Z0(Q1), .A0(QI1));
BUF \$1I1181  (.Z0(Q2), .A0(QI2));
BUF \$1I1182  (.Z0(Q3), .A0(QI3));
BUF \$1I1183  (.Z0(Q4), .A0(QI4));
BUF \$1I1184  (.Z0(Q5), .A0(QI5));
BUF \$1I1185  (.Z0(Q6), .A0(QI6));
BUF \$1I1186  (.Z0(Q7), .A0(QI7));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N935 ));
LXOR2 \$1I504  (.Z0(\$1N562 ), .A0(HOLD2), .A1(\$1N546 ));
LXOR2 \$1I518  (.Z0(\$1N568 ), .A0(HOLD3), .A1(\$1N895 ));
INV \$1I578  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I579  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I581  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
FD11 \$1I942  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK));
FD11 \$1I943  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK));
FD11 \$1I944  (.Q0(QI2), .D0(\$1N562 ), .CLK(CLK));
FD11 \$1I945  (.Q0(QI3), .D0(\$1N568 ), .CLK(CLK));
OR4 \$1I981  (.Z0(\$1N546 ), .A0(LOAD2), .A1(\$1N824 ), .A2(\$1N966 ), 
	.A3(\$1N822 ));
OR4 \$1I992  (.Z0(\$1N522 ), .A0(LOAD0), .A1(\$1N995 ), .A2(\$1N993 ), 
	.A3(\$1N997 ));
OR5 \$2I1145  (.Z0(\$2N522 ), .A0(\$2N526 ), .A1(\$2N528 ), .A2(\$2N530 ), 
	.A3(\$2N1146 ), .A4(\$2N1149 ));
OR5 \$2I1195  (.Z0(\$2N951 ), .A0(\$2N955 ), .A1(\$2N1199 ), .A2(\$2N953 ), 
	.A3(\$2N1197 ), .A4(\$2N1157 ));
INV \$2I1219  (.ZN0(\$2N1218 ), .A0(CS));
AND3 \$2I1221  (.Z0(HOLD4), .A0(QI4), .A1(\$2N1069 ), .A2(\$2N1218 ));
AND3 \$2I1223  (.Z0(\$2N526 ), .A0(D4), .A1(LD), .A2(\$2N1218 ));
AND9 \$2I1225  (.Z0(\$2N528 ), .A0(\~QI7 ), .A1(\~QI3 ), .A2(\~QI2 ), 
	.A3(\~QI1 ), .A4(\~QI0 ), .A5(\$2N1069 ), .A6(EN), 
	.A7(CAI), .A8(\$2N1218 ));
AND10 \$2I1227  (.Z0(\$2N530 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(\~QI3 ), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(\~QI0 ), .A6(\$2N1069 ), 
	.A7(EN), .A8(CAI), .A9(\$2N1218 ));
AND7 \$2I1229  (.Z0(\$2N1146 ), .A0(QI7), .A1(QI6), .A2(QI4), 
	.A3(\$2N1069 ), .A4(EN), .A5(CAI), .A6(\$2N1218 ));
AND7 \$2I1231  (.Z0(\$2N1149 ), .A0(QI7), .A1(QI5), .A2(QI4), 
	.A3(\$2N1069 ), .A4(EN), .A5(CAI), .A6(\$2N1218 ));
AND3 \$2I1233  (.Z0(HOLD5), .A0(QI5), .A1(\$2N1069 ), .A2(\$2N1218 ));
AND3 \$2I1235  (.Z0(\$2N955 ), .A0(D5), .A1(LD), .A2(\$2N1218 ));
AND10 \$2I1237  (.Z0(\$2N1199 ), .A0(QI5), .A1(\~QI4 ), .A2(\~QI3 ), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(\~QI0 ), .A6(\$2N1069 ), 
	.A7(EN), .A8(CAI), .A9(\$2N1218 ));
AND11 \$2I1239  (.Z0(\$2N953 ), .A0(\~QI7 ), .A1(QI6), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$2N1069 ), .A8(EN), .A9(CAI), .A10(\$2N1218 ));
AND11 \$2I1241  (.Z0(\$2N1197 ), .A0(QI7), .A1(\~QI6 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$2N1069 ), .A8(EN), .A9(CAI), .A10(\$2N1218 ));
AND6 \$2I1243  (.Z0(\$2N1157 ), .A0(QI7), .A1(QI5), .A2(\$2N1069 ), 
	.A3(EN), .A4(CAI), .A5(\$2N1218 ));
FD11 \$2I361  (.Q0(QI4), .D0(\$2N524 ), .CLK(CLK));
LXOR2 \$2I487  (.Z0(\$2N524 ), .A0(HOLD4), .A1(\$2N522 ));
FD11 \$2I495  (.Q0(QI5), .D0(\$2N536 ), .CLK(CLK));
LXOR2 \$2I496  (.Z0(\$2N536 ), .A0(HOLD5), .A1(\$2N951 ));
INV \$2I580  (.ZN0(\~QI5 ), .A0(QI5));
INV \$2I581  (.ZN0(\~QI4 ), .A0(QI4));
INV \$2I672  (.ZN0(\$2N1069 ), .A0(LD));
OR4 \$3I1131  (.Z0(\$3N546 ), .A0(\$3N946 ), .A1(\$3N1132 ), .A2(\$3N1134 ), 
	.A3(\$3N1075 ));
OR4 \$3I1141  (.Z0(\$3N939 ), .A0(\$3N931 ), .A1(\$3N1095 ), .A2(\$3N1091 ), 
	.A3(\$3N1093 ));
INV \$3I1161  (.ZN0(\$3N1162 ), .A0(CS));
AND3 \$3I1164  (.Z0(HOLD6), .A0(QI6), .A1(\$3N673 ), .A2(\$3N1162 ));
AND3 \$3I1166  (.Z0(\$3N946 ), .A0(D6), .A1(LD), .A2(\$3N1162 ));
AND11 \$3I1168  (.Z0(\$3N1132 ), .A0(QI7), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$3N673 ), .A8(EN), .A9(CAI), .A10(\$3N1162 ));
AND11 \$3I1170  (.Z0(\$3N1134 ), .A0(QI6), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$3N673 ), .A8(EN), .A9(CAI), .A10(\$3N1162 ));
AND6 \$3I1172  (.Z0(\$3N1075 ), .A0(QI7), .A1(QI6), .A2(\$3N673 ), 
	.A3(EN), .A4(CAI), .A5(\$3N1162 ));
AND3 \$3I1175  (.Z0(HOLD7), .A0(QI7), .A1(\$3N673 ), .A2(\$3N1162 ));
AND3 \$3I1177  (.Z0(\$3N931 ), .A0(D7), .A1(LD), .A2(\$3N1162 ));
AND11 \$3I1179  (.Z0(\$3N1095 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$3N673 ), .A8(EN), .A9(CAI), .A10(\$3N1162 ));
AND6 \$3I1181  (.Z0(\$3N1091 ), .A0(QI7), .A1(QI6), .A2(\$3N673 ), 
	.A3(EN), .A4(CAI), .A5(\$3N1162 ));
AND6 \$3I1183  (.Z0(\$3N1093 ), .A0(QI7), .A1(QI5), .A2(\$3N673 ), 
	.A3(EN), .A4(CAI), .A5(\$3N1162 ));
LXOR2 \$3I504  (.Z0(\$3N562 ), .A0(HOLD6), .A1(\$3N546 ));
FD11 \$3I505  (.Q0(QI6), .D0(\$3N562 ), .CLK(CLK));
FD11 \$3I517  (.Q0(QI7), .D0(\$3N568 ), .CLK(CLK));
LXOR2 \$3I518  (.Z0(\$3N568 ), .A0(HOLD7), .A1(\$3N939 ));
INV \$3I578  (.ZN0(\~QI7 ), .A0(QI7));
INV \$3I579  (.ZN0(\~QI6 ), .A0(QI6));
INV \$3I672  (.ZN0(\$3N673 ), .A0(LD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:03:52 1994
`timescale 10 ps / 10 ps 
module CDU14(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CLK, LD, EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CLK;
	input LD;
	input EN;
	input CD;

AND4 \$1I1003  (.Z0(\$1N1012 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN));
OR4 \$1I1008  (.Z0(\$1N522 ), .A0(\$1N526 ), .A1(\$1N1010 ), .A2(\$1N530 ), 
	.A3(\$1N1012 ));
AND4 \$1I1014  (.Z0(\$1N1022 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN));
OR3 \$1I1019  (.Z0(\$1N951 ), .A0(\$1N1020 ), .A1(\$1N953 ), .A2(\$1N1022 ));
AND4 \$1I1025  (.Z0(\$1N1031 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN));
OR3 \$1I1030  (.Z0(\$1N546 ), .A0(\$1N946 ), .A1(\$1N987 ), .A2(\$1N1031 ));
AND5 \$1I1033  (.Z0(\$1N1056 ), .A0(QI2), .A1(QI1), .A2(QI0), 
	.A3(\$1N673 ), .A4(EN));
AND4 \$1I1035  (.Z0(\$1N1050 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN));
AND4 \$1I1039  (.Z0(\$1N1052 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN));
AND4 \$1I1040  (.Z0(\$1N1054 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN));
OR5 \$1I1049  (.Z0(\$1N939 ), .A0(\$1N931 ), .A1(\$1N1056 ), .A2(\$1N1050 ), 
	.A3(\$1N1052 ), .A4(\$1N1054 ));
BUF \$1I1079  (.Z0(Q3), .A0(QI3));
BUF \$1I1080  (.Z0(Q2), .A0(QI2));
BUF \$1I1081  (.Z0(Q1), .A0(QI1));
BUF \$1I1082  (.Z0(Q0), .A0(QI0));
FD21 \$1I361  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
FD21 \$1I495  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N951 ));
LXOR2 \$1I504  (.Z0(\$1N562 ), .A0(HOLD2), .A1(\$1N546 ));
FD21 \$1I505  (.Q0(QI2), .D0(\$1N562 ), .CLK(CLK), .CD(CD));
FD21 \$1I517  (.Q0(QI3), .D0(\$1N568 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I518  (.Z0(\$1N568 ), .A0(HOLD3), .A1(\$1N939 ));
INV \$1I578  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I579  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
AND2 \$1I912  (.Z0(\$1N526 ), .A0(D0), .A1(LD));
AND3 \$1I913  (.Z0(\$1N1010 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN));
AND4 \$1I914  (.Z0(\$1N530 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN));
AND2 \$1I916  (.Z0(\$1N1020 ), .A0(D1), .A1(LD));
AND4 \$1I917  (.Z0(\$1N953 ), .A0(\~QI3 ), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN));
AND2 \$1I920  (.Z0(\$1N946 ), .A0(D2), .A1(LD));
AND2 \$1I925  (.Z0(\$1N931 ), .A0(D3), .A1(LD));
AND2 \$1I981  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ));
AND2 \$1I982  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ));
AND2 \$1I984  (.Z0(HOLD2), .A0(QI2), .A1(\$1N673 ));
AND5 \$1I985  (.Z0(\$1N987 ), .A0(\~QI3 ), .A1(QI1), .A2(QI0), 
	.A3(\$1N673 ), .A4(EN));
AND2 \$1I989  (.Z0(HOLD3), .A0(QI3), .A1(\$1N673 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:03:58 1994
`timescale 10 ps / 10 ps 
module CDU18(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	CLK, LD, EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CLK;
	input LD;
	input EN;
	input CD;

AND4 \$1I1003  (.Z0(\$1N1012 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN));
OR4 \$1I1008  (.Z0(\$1N522 ), .A0(\$1N526 ), .A1(\$1N1010 ), .A2(\$1N530 ), 
	.A3(\$1N1012 ));
AND4 \$1I1014  (.Z0(\$1N1022 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN));
OR3 \$1I1019  (.Z0(\$1N951 ), .A0(\$1N1020 ), .A1(\$1N953 ), .A2(\$1N1022 ));
AND4 \$1I1025  (.Z0(\$1N1031 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN));
OR3 \$1I1030  (.Z0(\$1N546 ), .A0(\$1N946 ), .A1(\$1N987 ), .A2(\$1N1031 ));
AND5 \$1I1033  (.Z0(\$1N1056 ), .A0(QI2), .A1(QI1), .A2(QI0), 
	.A3(\$1N673 ), .A4(EN));
AND4 \$1I1035  (.Z0(\$1N1050 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN));
AND4 \$1I1039  (.Z0(\$1N1052 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN));
AND4 \$1I1040  (.Z0(\$1N1054 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN));
OR5 \$1I1049  (.Z0(\$1N939 ), .A0(\$1N931 ), .A1(\$1N1056 ), .A2(\$1N1050 ), 
	.A3(\$1N1052 ), .A4(\$1N1054 ));
BUF \$1I1089  (.Z0(Q7), .A0(QI7));
BUF \$1I1090  (.Z0(Q6), .A0(QI6));
BUF \$1I1091  (.Z0(Q5), .A0(QI5));
BUF \$1I1092  (.Z0(Q4), .A0(QI4));
BUF \$1I1093  (.Z0(Q3), .A0(QI3));
BUF \$1I1094  (.Z0(Q2), .A0(QI2));
BUF \$1I1095  (.Z0(Q1), .A0(QI1));
BUF \$1I1096  (.Z0(Q0), .A0(QI0));
FD21 \$1I361  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
FD21 \$1I495  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N951 ));
LXOR2 \$1I504  (.Z0(\$1N562 ), .A0(HOLD2), .A1(\$1N546 ));
FD21 \$1I505  (.Q0(QI2), .D0(\$1N562 ), .CLK(CLK), .CD(CD));
FD21 \$1I517  (.Q0(QI3), .D0(\$1N568 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I518  (.Z0(\$1N568 ), .A0(HOLD3), .A1(\$1N939 ));
INV \$1I578  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I579  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
AND2 \$1I912  (.Z0(\$1N526 ), .A0(D0), .A1(LD));
AND3 \$1I913  (.Z0(\$1N1010 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN));
AND4 \$1I914  (.Z0(\$1N530 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN));
AND2 \$1I916  (.Z0(\$1N1020 ), .A0(D1), .A1(LD));
AND4 \$1I917  (.Z0(\$1N953 ), .A0(\~QI3 ), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN));
AND2 \$1I920  (.Z0(\$1N946 ), .A0(D2), .A1(LD));
AND2 \$1I925  (.Z0(\$1N931 ), .A0(D3), .A1(LD));
AND2 \$1I981  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ));
AND2 \$1I982  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ));
AND2 \$1I984  (.Z0(HOLD2), .A0(QI2), .A1(\$1N673 ));
AND5 \$1I985  (.Z0(\$1N987 ), .A0(\~QI3 ), .A1(QI1), .A2(QI0), 
	.A3(\$1N673 ), .A4(EN));
AND2 \$1I989  (.Z0(HOLD3), .A0(QI3), .A1(\$1N673 ));
AND8 \$2I1004  (.Z0(\$2N953 ), .A0(\~QI7 ), .A1(QI4), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$2N1069 ), 
	.A7(EN));
AND5 \$2I1133  (.Z0(\$2N1146 ), .A0(QI7), .A1(QI6), .A2(QI4), 
	.A3(\$2N1069 ), .A4(EN));
AND5 \$2I1134  (.Z0(\$2N1149 ), .A0(QI7), .A1(QI5), .A2(QI4), 
	.A3(\$2N1069 ), .A4(EN));
OR5 \$2I1145  (.Z0(\$2N522 ), .A0(\$2N526 ), .A1(\$2N528 ), .A2(\$2N530 ), 
	.A3(\$2N1146 ), .A4(\$2N1149 ));
AND4 \$2I1151  (.Z0(\$2N1157 ), .A0(QI7), .A1(QI5), .A2(\$2N1069 ), 
	.A3(EN));
OR3 \$2I1156  (.Z0(\$2N951 ), .A0(\$2N955 ), .A1(\$2N953 ), .A2(\$2N1157 ));
FD21 \$2I361  (.Q0(QI4), .D0(\$2N524 ), .CLK(CLK), .CD(CD));
LXOR2 \$2I487  (.Z0(\$2N524 ), .A0(HOLD4), .A1(\$2N522 ));
FD21 \$2I495  (.Q0(QI5), .D0(\$2N536 ), .CLK(CLK), .CD(CD));
LXOR2 \$2I496  (.Z0(\$2N536 ), .A0(HOLD5), .A1(\$2N951 ));
INV \$2I580  (.ZN0(\~QI5 ), .A0(QI5));
INV \$2I672  (.ZN0(\$2N1069 ), .A0(LD));
AND2 \$2I912  (.Z0(\$2N526 ), .A0(D4), .A1(LD));
AND2 \$2I916  (.Z0(\$2N955 ), .A0(D5), .A1(LD));
AND2 \$2I981  (.Z0(HOLD4), .A0(QI4), .A1(\$2N1069 ));
AND2 \$2I982  (.Z0(HOLD5), .A0(QI5), .A1(\$2N1069 ));
AND7 \$2I994  (.Z0(\$2N528 ), .A0(\~QI7 ), .A1(QI3), .A2(\~QI2 ), 
	.A3(\~QI1 ), .A4(QI0), .A5(\$2N1069 ), .A6(EN));
AND8 \$2I999  (.Z0(\$2N530 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$2N1069 ), 
	.A7(EN));
AND9 \$3I1011  (.Z0(\$3N987 ), .A0(\~QI7 ), .A1(QI5), .A2(QI4), 
	.A3(QI3), .A4(\~QI2 ), .A5(\~QI1 ), .A6(QI0), 
	.A7(\$3N673 ), .A8(EN));
AND9 \$3I1020  (.Z0(\$3N1095 ), .A0(QI6), .A1(QI5), .A2(QI4), 
	.A3(QI3), .A4(\~QI2 ), .A5(\~QI1 ), .A6(QI0), 
	.A7(\$3N673 ), .A8(EN));
AND4 \$3I1069  (.Z0(\$3N1075 ), .A0(QI7), .A1(QI6), .A2(\$3N673 ), 
	.A3(EN));
OR3 \$3I1074  (.Z0(\$3N546 ), .A0(\$3N946 ), .A1(\$3N987 ), .A2(\$3N1075 ));
AND4 \$3I1078  (.Z0(\$3N1091 ), .A0(QI7), .A1(QI6), .A2(\$3N673 ), 
	.A3(EN));
AND4 \$3I1079  (.Z0(\$3N1093 ), .A0(QI7), .A1(QI5), .A2(\$3N673 ), 
	.A3(EN));
OR5 \$3I1088  (.Z0(\$3N939 ), .A0(\$3N931 ), .A1(\$3N1095 ), .A2(\$3N1089 ), 
	.A3(\$3N1091 ), .A4(\$3N1093 ));
LXOR2 \$3I504  (.Z0(\$3N562 ), .A0(HOLD6), .A1(\$3N546 ));
FD21 \$3I505  (.Q0(QI6), .D0(\$3N562 ), .CLK(CLK), .CD(CD));
FD21 \$3I517  (.Q0(QI7), .D0(\$3N568 ), .CLK(CLK), .CD(CD));
LXOR2 \$3I518  (.Z0(\$3N568 ), .A0(HOLD7), .A1(\$3N939 ));
INV \$3I578  (.ZN0(\~QI7 ), .A0(QI7));
INV \$3I579  (.ZN0(\~QI6 ), .A0(QI6));
INV \$3I672  (.ZN0(\$3N673 ), .A0(LD));
AND2 \$3I920  (.Z0(\$3N946 ), .A0(D6), .A1(LD));
AND2 \$3I925  (.Z0(\$3N931 ), .A0(D7), .A1(LD));
AND8 \$3I927  (.Z0(\$3N1089 ), .A0(QI7), .A1(QI4), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$3N673 ), 
	.A7(EN));
AND2 \$3I984  (.Z0(HOLD6), .A0(QI6), .A1(\$3N673 ));
AND2 \$3I989  (.Z0(HOLD7), .A0(QI7), .A1(\$3N673 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:04:02 1994
`timescale 10 ps / 10 ps 
module CDU24(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CLK, LD, EN, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CLK;
	input LD;
	input EN;
	input CS;

OR4 \$1I1008  (.Z0(\$1N522 ), .A0(\$1N526 ), .A1(\$1N1010 ), .A2(\$1N530 ), 
	.A3(\$1N1012 ));
OR3 \$1I1019  (.Z0(\$1N951 ), .A0(\$1N1020 ), .A1(\$1N953 ), .A2(\$1N1022 ));
OR3 \$1I1030  (.Z0(\$1N546 ), .A0(\$1N946 ), .A1(\$1N987 ), .A2(\$1N1031 ));
OR5 \$1I1049  (.Z0(\$1N939 ), .A0(\$1N931 ), .A1(\$1N1056 ), .A2(\$1N1050 ), 
	.A3(\$1N1052 ), .A4(\$1N1054 ));
INV \$1I1059  (.ZN0(\$1N1060 ), .A0(CS));
AND3 \$1I1061  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ), .A2(\$1N1060 ));
AND3 \$1I1063  (.Z0(\$1N526 ), .A0(D0), .A1(LD), .A2(\$1N1060 ));
AND4 \$1I1065  (.Z0(\$1N1010 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN), 
	.A3(\$1N1060 ));
AND5 \$1I1067  (.Z0(\$1N530 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1060 ));
AND5 \$1I1069  (.Z0(\$1N1012 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1060 ));
AND3 \$1I1071  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ), .A2(\$1N1060 ));
AND3 \$1I1073  (.Z0(\$1N1020 ), .A0(D1), .A1(LD), .A2(\$1N1060 ));
AND5 \$1I1075  (.Z0(\$1N953 ), .A0(\~QI3 ), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1060 ));
AND5 \$1I1077  (.Z0(\$1N1022 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1060 ));
AND3 \$1I1079  (.Z0(HOLD2), .A0(QI2), .A1(\$1N673 ), .A2(\$1N1060 ));
AND3 \$1I1081  (.Z0(\$1N946 ), .A0(D2), .A1(LD), .A2(\$1N1060 ));
AND6 \$1I1083  (.Z0(\$1N987 ), .A0(\~QI3 ), .A1(QI1), .A2(QI0), 
	.A3(\$1N673 ), .A4(EN), .A5(\$1N1060 ));
AND5 \$1I1085  (.Z0(\$1N1031 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1060 ));
AND3 \$1I1087  (.Z0(HOLD3), .A0(QI3), .A1(\$1N673 ), .A2(\$1N1060 ));
AND3 \$1I1089  (.Z0(\$1N931 ), .A0(D3), .A1(LD), .A2(\$1N1060 ));
AND6 \$1I1091  (.Z0(\$1N1056 ), .A0(QI2), .A1(QI1), .A2(QI0), 
	.A3(\$1N673 ), .A4(EN), .A5(\$1N1060 ));
AND5 \$1I1093  (.Z0(\$1N1050 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1060 ));
AND5 \$1I1095  (.Z0(\$1N1052 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1060 ));
AND5 \$1I1097  (.Z0(\$1N1054 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1060 ));
BUF \$1I1125  (.Z0(Q3), .A0(QI3));
BUF \$1I1126  (.Z0(Q2), .A0(QI2));
BUF \$1I1127  (.Z0(Q1), .A0(QI1));
BUF \$1I1128  (.Z0(Q0), .A0(QI0));
FD11 \$1I361  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
FD11 \$1I495  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N951 ));
LXOR2 \$1I504  (.Z0(\$1N562 ), .A0(HOLD2), .A1(\$1N546 ));
FD11 \$1I505  (.Q0(QI2), .D0(\$1N562 ), .CLK(CLK));
FD11 \$1I517  (.Q0(QI3), .D0(\$1N568 ), .CLK(CLK));
LXOR2 \$1I518  (.Z0(\$1N568 ), .A0(HOLD3), .A1(\$1N939 ));
INV \$1I578  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I579  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:04:07 1994
`timescale 10 ps / 10 ps 
module CDU28(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	CLK, LD, EN, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CLK;
	input LD;
	input EN;
	input CS;

OR4 \$1I1008  (.Z0(\$1N522 ), .A0(\$1N526 ), .A1(\$1N1010 ), .A2(\$1N530 ), 
	.A3(\$1N1012 ));
OR3 \$1I1019  (.Z0(\$1N951 ), .A0(\$1N1020 ), .A1(\$1N953 ), .A2(\$1N1022 ));
OR3 \$1I1030  (.Z0(\$1N546 ), .A0(\$1N946 ), .A1(\$1N987 ), .A2(\$1N1031 ));
OR5 \$1I1049  (.Z0(\$1N939 ), .A0(\$1N931 ), .A1(\$1N1056 ), .A2(\$1N1050 ), 
	.A3(\$1N1052 ), .A4(\$1N1054 ));
INV \$1I1059  (.ZN0(\$1N1060 ), .A0(CS));
AND3 \$1I1061  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ), .A2(\$1N1060 ));
AND3 \$1I1063  (.Z0(\$1N526 ), .A0(D0), .A1(LD), .A2(\$1N1060 ));
AND4 \$1I1065  (.Z0(\$1N1010 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN), 
	.A3(\$1N1060 ));
AND5 \$1I1067  (.Z0(\$1N530 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1060 ));
AND5 \$1I1069  (.Z0(\$1N1012 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1060 ));
AND3 \$1I1071  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ), .A2(\$1N1060 ));
AND3 \$1I1073  (.Z0(\$1N1020 ), .A0(D1), .A1(LD), .A2(\$1N1060 ));
AND5 \$1I1075  (.Z0(\$1N953 ), .A0(\~QI3 ), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1060 ));
AND5 \$1I1077  (.Z0(\$1N1022 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1060 ));
AND3 \$1I1079  (.Z0(HOLD2), .A0(QI2), .A1(\$1N673 ), .A2(\$1N1060 ));
AND3 \$1I1081  (.Z0(\$1N946 ), .A0(D2), .A1(LD), .A2(\$1N1060 ));
AND6 \$1I1083  (.Z0(\$1N987 ), .A0(\~QI3 ), .A1(QI1), .A2(QI0), 
	.A3(\$1N673 ), .A4(EN), .A5(\$1N1060 ));
AND5 \$1I1085  (.Z0(\$1N1031 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1060 ));
AND3 \$1I1087  (.Z0(HOLD3), .A0(QI3), .A1(\$1N673 ), .A2(\$1N1060 ));
AND3 \$1I1089  (.Z0(\$1N931 ), .A0(D3), .A1(LD), .A2(\$1N1060 ));
AND6 \$1I1091  (.Z0(\$1N1056 ), .A0(QI2), .A1(QI1), .A2(QI0), 
	.A3(\$1N673 ), .A4(EN), .A5(\$1N1060 ));
AND5 \$1I1093  (.Z0(\$1N1050 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1060 ));
AND5 \$1I1095  (.Z0(\$1N1052 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1060 ));
AND5 \$1I1097  (.Z0(\$1N1054 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N1060 ));
BUF \$1I1134  (.Z0(Q7), .A0(QI7));
BUF \$1I1135  (.Z0(Q6), .A0(QI6));
BUF \$1I1136  (.Z0(Q5), .A0(QI5));
BUF \$1I1137  (.Z0(Q4), .A0(QI4));
BUF \$1I1138  (.Z0(Q3), .A0(QI3));
BUF \$1I1139  (.Z0(Q2), .A0(QI2));
BUF \$1I1140  (.Z0(Q1), .A0(QI1));
BUF \$1I1141  (.Z0(Q0), .A0(QI0));
FD11 \$1I361  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
FD11 \$1I495  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N951 ));
LXOR2 \$1I504  (.Z0(\$1N562 ), .A0(HOLD2), .A1(\$1N546 ));
FD11 \$1I505  (.Q0(QI2), .D0(\$1N562 ), .CLK(CLK));
FD11 \$1I517  (.Q0(QI3), .D0(\$1N568 ), .CLK(CLK));
LXOR2 \$1I518  (.Z0(\$1N568 ), .A0(HOLD3), .A1(\$1N939 ));
INV \$1I578  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I579  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
OR5 \$2I1145  (.Z0(\$2N522 ), .A0(\$2N526 ), .A1(\$2N528 ), .A2(\$2N530 ), 
	.A3(\$2N1146 ), .A4(\$2N1149 ));
OR3 \$2I1156  (.Z0(\$2N951 ), .A0(\$2N955 ), .A1(\$2N953 ), .A2(\$2N1157 ));
INV \$2I1160  (.ZN0(\$2N1161 ), .A0(CS));
AND3 \$2I1163  (.Z0(HOLD4), .A0(QI4), .A1(\$2N1069 ), .A2(\$2N1161 ));
AND3 \$2I1165  (.Z0(\$2N526 ), .A0(D4), .A1(LD), .A2(\$2N1161 ));
AND8 \$2I1167  (.Z0(\$2N528 ), .A0(\~QI7 ), .A1(QI3), .A2(\~QI2 ), 
	.A3(\~QI1 ), .A4(QI0), .A5(\$2N1069 ), .A6(EN), 
	.A7(\$2N1161 ));
AND9 \$2I1170  (.Z0(\$2N530 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$2N1069 ), 
	.A7(EN), .A8(\$2N1161 ));
AND6 \$2I1172  (.Z0(\$2N1146 ), .A0(QI7), .A1(QI6), .A2(QI4), 
	.A3(\$2N1069 ), .A4(EN), .A5(\$2N1161 ));
AND6 \$2I1174  (.Z0(\$2N1149 ), .A0(QI7), .A1(QI5), .A2(QI4), 
	.A3(\$2N1069 ), .A4(EN), .A5(\$2N1161 ));
AND3 \$2I1176  (.Z0(HOLD5), .A0(QI5), .A1(\$2N1069 ), .A2(\$2N1161 ));
AND3 \$2I1178  (.Z0(\$2N955 ), .A0(D5), .A1(LD), .A2(\$2N1161 ));
AND9 \$2I1180  (.Z0(\$2N953 ), .A0(\~QI7 ), .A1(QI4), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$2N1069 ), 
	.A7(EN), .A8(\$2N1161 ));
AND5 \$2I1182  (.Z0(\$2N1157 ), .A0(QI7), .A1(QI5), .A2(\$2N1069 ), 
	.A3(EN), .A4(\$2N1161 ));
FD11 \$2I361  (.Q0(QI4), .D0(\$2N524 ), .CLK(CLK));
LXOR2 \$2I487  (.Z0(\$2N524 ), .A0(HOLD4), .A1(\$2N522 ));
FD11 \$2I495  (.Q0(QI5), .D0(\$2N536 ), .CLK(CLK));
LXOR2 \$2I496  (.Z0(\$2N536 ), .A0(HOLD5), .A1(\$2N951 ));
INV \$2I580  (.ZN0(\~QI5 ), .A0(QI5));
INV \$2I672  (.ZN0(\$2N1069 ), .A0(LD));
OR3 \$3I1074  (.Z0(\$3N546 ), .A0(\$3N946 ), .A1(\$3N987 ), .A2(\$3N1075 ));
OR5 \$3I1088  (.Z0(\$3N939 ), .A0(\$3N931 ), .A1(\$3N1095 ), .A2(\$3N1089 ), 
	.A3(\$3N1091 ), .A4(\$3N1093 ));
INV \$3I1099  (.ZN0(\$3N1098 ), .A0(CS));
AND3 \$3I1100  (.Z0(HOLD6), .A0(QI6), .A1(\$3N673 ), .A2(\$3N1098 ));
AND3 \$3I1102  (.Z0(\$3N946 ), .A0(D6), .A1(LD), .A2(\$3N1098 ));
AND10 \$3I1104  (.Z0(\$3N987 ), .A0(\~QI7 ), .A1(QI5), .A2(QI4), 
	.A3(QI3), .A4(\~QI2 ), .A5(\~QI1 ), .A6(QI0), 
	.A7(\$3N673 ), .A8(EN), .A9(\$3N1098 ));
AND5 \$3I1106  (.Z0(\$3N1075 ), .A0(QI7), .A1(QI6), .A2(\$3N673 ), 
	.A3(EN), .A4(\$3N1098 ));
AND3 \$3I1108  (.Z0(HOLD7), .A0(QI7), .A1(\$3N673 ), .A2(\$3N1098 ));
AND3 \$3I1110  (.Z0(\$3N931 ), .A0(D7), .A1(LD), .A2(\$3N1098 ));
AND10 \$3I1112  (.Z0(\$3N1095 ), .A0(QI6), .A1(QI5), .A2(QI4), 
	.A3(QI3), .A4(\~QI2 ), .A5(\~QI1 ), .A6(QI0), 
	.A7(\$3N673 ), .A8(EN), .A9(\$3N1098 ));
AND9 \$3I1114  (.Z0(\$3N1089 ), .A0(QI7), .A1(QI4), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$3N673 ), 
	.A7(EN), .A8(\$3N1098 ));
AND5 \$3I1116  (.Z0(\$3N1091 ), .A0(QI7), .A1(QI6), .A2(\$3N673 ), 
	.A3(EN), .A4(\$3N1098 ));
AND5 \$3I1118  (.Z0(\$3N1093 ), .A0(QI7), .A1(QI5), .A2(\$3N673 ), 
	.A3(EN), .A4(\$3N1098 ));
LXOR2 \$3I504  (.Z0(\$3N562 ), .A0(HOLD6), .A1(\$3N546 ));
FD11 \$3I505  (.Q0(QI6), .D0(\$3N562 ), .CLK(CLK));
FD11 \$3I517  (.Q0(QI7), .D0(\$3N568 ), .CLK(CLK));
LXOR2 \$3I518  (.Z0(\$3N568 ), .A0(HOLD7), .A1(\$3N939 ));
INV \$3I578  (.ZN0(\~QI7 ), .A0(QI7));
INV \$3I579  (.ZN0(\~QI6 ), .A0(QI6));
INV \$3I672  (.ZN0(\$3N673 ), .A0(LD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:04:11 1994
`timescale 10 ps / 10 ps 
module CDU34(
	Q0, Q1, Q2, Q3, 
	CAO, D0, D1, D2, 
	D3, CAI, CLK, LD, 
	EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input CAI;
	input CLK;
	input LD;
	input EN;
	input CD;

OR4 \$1I1008  (.Z0(\$1N522 ), .A0(\$1N526 ), .A1(\$1N1010 ), .A2(\$1N530 ), 
	.A3(\$1N1012 ));
OR3 \$1I1019  (.Z0(\$1N951 ), .A0(\$1N1020 ), .A1(\$1N953 ), .A2(\$1N1022 ));
OR3 \$1I1030  (.Z0(\$1N546 ), .A0(\$1N946 ), .A1(\$1N987 ), .A2(\$1N1031 ));
OR5 \$1I1049  (.Z0(\$1N939 ), .A0(\$1N931 ), .A1(\$1N1056 ), .A2(\$1N1050 ), 
	.A3(\$1N1052 ), .A4(\$1N1054 ));
AND4 \$1I1059  (.Z0(\$1N1010 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN), 
	.A3(CAI));
AND5 \$1I1061  (.Z0(\$1N530 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI));
AND5 \$1I1063  (.Z0(\$1N1012 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI));
AND5 \$1I1065  (.Z0(\$1N953 ), .A0(\~QI3 ), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI));
AND5 \$1I1067  (.Z0(\$1N1022 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI));
AND6 \$1I1069  (.Z0(\$1N987 ), .A0(\~QI3 ), .A1(QI1), .A2(QI0), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI));
AND5 \$1I1071  (.Z0(\$1N1031 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI));
AND6 \$1I1073  (.Z0(\$1N1056 ), .A0(QI2), .A1(QI1), .A2(QI0), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI));
AND5 \$1I1075  (.Z0(\$1N1050 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI));
AND5 \$1I1077  (.Z0(\$1N1052 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI));
AND5 \$1I1079  (.Z0(\$1N1054 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI));
AND6 \$1I1081  (.Z0(CAO), .A0(QI3), .A1(\~QI2 ), .A2(\~QI1 ), 
	.A3(QI0), .A4(EN), .A5(CAI));
BUF \$1I1116  (.Z0(Q3), .A0(QI3));
BUF \$1I1117  (.Z0(Q2), .A0(QI2));
BUF \$1I1118  (.Z0(Q1), .A0(QI1));
BUF \$1I1119  (.Z0(Q0), .A0(QI0));
FD21 \$1I361  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
FD21 \$1I495  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N951 ));
LXOR2 \$1I504  (.Z0(\$1N562 ), .A0(HOLD2), .A1(\$1N546 ));
FD21 \$1I505  (.Q0(QI2), .D0(\$1N562 ), .CLK(CLK), .CD(CD));
FD21 \$1I517  (.Q0(QI3), .D0(\$1N568 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I518  (.Z0(\$1N568 ), .A0(HOLD3), .A1(\$1N939 ));
INV \$1I578  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I579  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
AND2 \$1I912  (.Z0(\$1N526 ), .A0(D0), .A1(LD));
AND2 \$1I916  (.Z0(\$1N1020 ), .A0(D1), .A1(LD));
AND2 \$1I920  (.Z0(\$1N946 ), .A0(D2), .A1(LD));
AND2 \$1I925  (.Z0(\$1N931 ), .A0(D3), .A1(LD));
AND2 \$1I981  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ));
AND2 \$1I982  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ));
AND2 \$1I984  (.Z0(HOLD2), .A0(QI2), .A1(\$1N673 ));
AND2 \$1I989  (.Z0(HOLD3), .A0(QI3), .A1(\$1N673 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:04:17 1994
`timescale 10 ps / 10 ps 
module CDU38(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	CAO, D0, D1, D2, 
	D3, D4, D5, D6, 
	D7, CAI, CLK, LD, 
	EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CAI;
	input CLK;
	input LD;
	input EN;
	input CD;

OR4 \$1I1008  (.Z0(\$1N522 ), .A0(\$1N526 ), .A1(\$1N1010 ), .A2(\$1N530 ), 
	.A3(\$1N1012 ));
OR3 \$1I1019  (.Z0(\$1N951 ), .A0(\$1N1020 ), .A1(\$1N953 ), .A2(\$1N1022 ));
OR3 \$1I1030  (.Z0(\$1N546 ), .A0(\$1N946 ), .A1(\$1N987 ), .A2(\$1N1031 ));
OR5 \$1I1049  (.Z0(\$1N939 ), .A0(\$1N931 ), .A1(\$1N1056 ), .A2(\$1N1050 ), 
	.A3(\$1N1052 ), .A4(\$1N1054 ));
AND4 \$1I1059  (.Z0(\$1N1010 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN), 
	.A3(CAI));
AND5 \$1I1061  (.Z0(\$1N530 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI));
AND5 \$1I1063  (.Z0(\$1N1012 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI));
AND5 \$1I1065  (.Z0(\$1N953 ), .A0(\~QI3 ), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI));
AND5 \$1I1067  (.Z0(\$1N1022 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI));
AND6 \$1I1069  (.Z0(\$1N987 ), .A0(\~QI3 ), .A1(QI1), .A2(QI0), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI));
AND5 \$1I1071  (.Z0(\$1N1031 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI));
AND6 \$1I1073  (.Z0(\$1N1056 ), .A0(QI2), .A1(QI1), .A2(QI0), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI));
AND5 \$1I1075  (.Z0(\$1N1050 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI));
AND5 \$1I1077  (.Z0(\$1N1052 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI));
AND5 \$1I1079  (.Z0(\$1N1054 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI));
AND10 \$1I1081  (.Z0(CAO), .A0(QI7), .A1(\~QI6 ), .A2(\~QI5 ), 
	.A3(QI4), .A4(QI3), .A5(\~QI2 ), .A6(\~QI1 ), 
	.A7(QI0), .A8(EN), .A9(CAI));
BUF \$1I1132  (.Z0(Q7), .A0(QI7));
BUF \$1I1133  (.Z0(Q6), .A0(QI6));
BUF \$1I1134  (.Z0(Q5), .A0(QI5));
BUF \$1I1135  (.Z0(Q4), .A0(QI4));
BUF \$1I1136  (.Z0(Q3), .A0(QI3));
BUF \$1I1137  (.Z0(Q2), .A0(QI2));
BUF \$1I1138  (.Z0(Q1), .A0(QI1));
BUF \$1I1139  (.Z0(Q0), .A0(QI0));
FD21 \$1I361  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
FD21 \$1I495  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N951 ));
LXOR2 \$1I504  (.Z0(\$1N562 ), .A0(HOLD2), .A1(\$1N546 ));
FD21 \$1I505  (.Q0(QI2), .D0(\$1N562 ), .CLK(CLK), .CD(CD));
FD21 \$1I517  (.Q0(QI3), .D0(\$1N568 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I518  (.Z0(\$1N568 ), .A0(HOLD3), .A1(\$1N939 ));
INV \$1I578  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I579  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
AND2 \$1I912  (.Z0(\$1N526 ), .A0(D0), .A1(LD));
AND2 \$1I916  (.Z0(\$1N1020 ), .A0(D1), .A1(LD));
AND2 \$1I920  (.Z0(\$1N946 ), .A0(D2), .A1(LD));
AND2 \$1I925  (.Z0(\$1N931 ), .A0(D3), .A1(LD));
AND2 \$1I981  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ));
AND2 \$1I982  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ));
AND2 \$1I984  (.Z0(HOLD2), .A0(QI2), .A1(\$1N673 ));
AND2 \$1I989  (.Z0(HOLD3), .A0(QI3), .A1(\$1N673 ));
OR5 \$2I1145  (.Z0(\$2N522 ), .A0(\$2N526 ), .A1(\$2N528 ), .A2(\$2N530 ), 
	.A3(\$2N1146 ), .A4(\$2N1149 ));
OR3 \$2I1156  (.Z0(\$2N951 ), .A0(\$2N955 ), .A1(\$2N953 ), .A2(\$2N1157 ));
AND8 \$2I1161  (.Z0(\$2N528 ), .A0(\~QI7 ), .A1(QI3), .A2(\~QI2 ), 
	.A3(\~QI1 ), .A4(QI0), .A5(\$2N1069 ), .A6(EN), 
	.A7(CAI));
AND9 \$2I1163  (.Z0(\$2N530 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$2N1069 ), 
	.A7(EN), .A8(CAI));
AND6 \$2I1165  (.Z0(\$2N1146 ), .A0(QI7), .A1(QI6), .A2(QI4), 
	.A3(\$2N1069 ), .A4(EN), .A5(CAI));
AND6 \$2I1167  (.Z0(\$2N1149 ), .A0(QI7), .A1(QI5), .A2(QI4), 
	.A3(\$2N1069 ), .A4(EN), .A5(CAI));
AND9 \$2I1169  (.Z0(\$2N953 ), .A0(\~QI7 ), .A1(QI4), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$2N1069 ), 
	.A7(EN), .A8(CAI));
AND5 \$2I1170  (.Z0(\$2N1157 ), .A0(QI7), .A1(QI5), .A2(\$2N1069 ), 
	.A3(EN), .A4(CAI));
FD21 \$2I361  (.Q0(QI4), .D0(\$2N524 ), .CLK(CLK), .CD(CD));
LXOR2 \$2I487  (.Z0(\$2N524 ), .A0(HOLD4), .A1(\$2N522 ));
FD21 \$2I495  (.Q0(QI5), .D0(\$2N536 ), .CLK(CLK), .CD(CD));
LXOR2 \$2I496  (.Z0(\$2N536 ), .A0(HOLD5), .A1(\$2N951 ));
INV \$2I580  (.ZN0(\~QI5 ), .A0(QI5));
INV \$2I672  (.ZN0(\$2N1069 ), .A0(LD));
AND2 \$2I912  (.Z0(\$2N526 ), .A0(D4), .A1(LD));
AND2 \$2I916  (.Z0(\$2N955 ), .A0(D5), .A1(LD));
AND2 \$2I981  (.Z0(HOLD4), .A0(QI4), .A1(\$2N1069 ));
AND2 \$2I982  (.Z0(HOLD5), .A0(QI5), .A1(\$2N1069 ));
OR3 \$3I1074  (.Z0(\$3N546 ), .A0(\$3N946 ), .A1(\$3N987 ), .A2(\$3N1075 ));
OR5 \$3I1088  (.Z0(\$3N939 ), .A0(\$3N931 ), .A1(\$3N1095 ), .A2(\$3N1089 ), 
	.A3(\$3N1091 ), .A4(\$3N1093 ));
AND10 \$3I1098  (.Z0(\$3N987 ), .A0(\~QI7 ), .A1(QI5), .A2(QI4), 
	.A3(QI3), .A4(\~QI2 ), .A5(\~QI1 ), .A6(QI0), 
	.A7(\$3N673 ), .A8(EN), .A9(CAI));
AND5 \$3I1100  (.Z0(\$3N1075 ), .A0(QI7), .A1(QI6), .A2(\$3N673 ), 
	.A3(EN), .A4(CAI));
AND10 \$3I1102  (.Z0(\$3N1095 ), .A0(QI6), .A1(QI5), .A2(QI4), 
	.A3(QI3), .A4(\~QI2 ), .A5(\~QI1 ), .A6(QI0), 
	.A7(\$3N673 ), .A8(EN), .A9(CAI));
AND9 \$3I1104  (.Z0(\$3N1089 ), .A0(QI7), .A1(QI4), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$3N673 ), 
	.A7(EN), .A8(CAI));
AND5 \$3I1106  (.Z0(\$3N1091 ), .A0(QI7), .A1(QI6), .A2(\$3N673 ), 
	.A3(EN), .A4(CAI));
AND5 \$3I1108  (.Z0(\$3N1093 ), .A0(QI7), .A1(QI5), .A2(\$3N673 ), 
	.A3(EN), .A4(CAI));
LXOR2 \$3I504  (.Z0(\$3N562 ), .A0(HOLD6), .A1(\$3N546 ));
FD21 \$3I505  (.Q0(QI6), .D0(\$3N562 ), .CLK(CLK), .CD(CD));
FD21 \$3I517  (.Q0(QI7), .D0(\$3N568 ), .CLK(CLK), .CD(CD));
LXOR2 \$3I518  (.Z0(\$3N568 ), .A0(HOLD7), .A1(\$3N939 ));
INV \$3I578  (.ZN0(\~QI7 ), .A0(QI7));
INV \$3I579  (.ZN0(\~QI6 ), .A0(QI6));
INV \$3I672  (.ZN0(\$3N673 ), .A0(LD));
AND2 \$3I920  (.Z0(\$3N946 ), .A0(D6), .A1(LD));
AND2 \$3I925  (.Z0(\$3N931 ), .A0(D7), .A1(LD));
AND2 \$3I984  (.Z0(HOLD6), .A0(QI6), .A1(\$3N673 ));
AND2 \$3I989  (.Z0(HOLD7), .A0(QI7), .A1(\$3N673 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:04:21 1994
`timescale 10 ps / 10 ps 
module CDU44(
	Q0, Q1, Q2, Q3, 
	CAO, D0, D1, D2, 
	D3, CAI, CLK, LD, 
	EN, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input CAI;
	input CLK;
	input LD;
	input EN;
	input CS;

OR4 \$1I1008  (.Z0(\$1N522 ), .A0(\$1N526 ), .A1(\$1N1010 ), .A2(\$1N530 ), 
	.A3(\$1N1012 ));
OR3 \$1I1019  (.Z0(\$1N951 ), .A0(\$1N1020 ), .A1(\$1N953 ), .A2(\$1N1022 ));
OR3 \$1I1030  (.Z0(\$1N546 ), .A0(\$1N946 ), .A1(\$1N987 ), .A2(\$1N1031 ));
OR5 \$1I1049  (.Z0(\$1N939 ), .A0(\$1N931 ), .A1(\$1N1056 ), .A2(\$1N1050 ), 
	.A3(\$1N1052 ), .A4(\$1N1054 ));
AND6 \$1I1081  (.Z0(CAO), .A0(QI3), .A1(\~QI2 ), .A2(\~QI1 ), 
	.A3(QI0), .A4(EN), .A5(CAI));
INV \$1I1090  (.ZN0(\$1N1089 ), .A0(CS));
AND3 \$1I1097  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ), .A2(\$1N1089 ));
AND3 \$1I1099  (.Z0(\$1N526 ), .A0(D0), .A1(LD), .A2(\$1N1089 ));
AND5 \$1I1101  (.Z0(\$1N1010 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN), 
	.A3(CAI), .A4(\$1N1089 ));
AND6 \$1I1103  (.Z0(\$1N530 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1089 ));
AND6 \$1I1106  (.Z0(\$1N1012 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1089 ));
AND3 \$1I1108  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ), .A2(\$1N1089 ));
AND3 \$1I1110  (.Z0(\$1N1020 ), .A0(D1), .A1(LD), .A2(\$1N1089 ));
AND6 \$1I1112  (.Z0(\$1N953 ), .A0(\~QI3 ), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1089 ));
AND6 \$1I1114  (.Z0(\$1N1022 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1089 ));
AND3 \$1I1116  (.Z0(HOLD2), .A0(QI2), .A1(\$1N673 ), .A2(\$1N1089 ));
AND3 \$1I1118  (.Z0(\$1N946 ), .A0(D2), .A1(LD), .A2(\$1N1089 ));
AND7 \$1I1120  (.Z0(\$1N987 ), .A0(\~QI3 ), .A1(QI1), .A2(QI0), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(\$1N1089 ));
AND6 \$1I1122  (.Z0(\$1N1031 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1089 ));
AND3 \$1I1124  (.Z0(HOLD3), .A0(QI3), .A1(\$1N673 ), .A2(\$1N1089 ));
AND3 \$1I1126  (.Z0(\$1N931 ), .A0(D3), .A1(LD), .A2(\$1N1089 ));
AND7 \$1I1128  (.Z0(\$1N1056 ), .A0(QI2), .A1(QI1), .A2(QI0), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(\$1N1089 ));
AND6 \$1I1130  (.Z0(\$1N1050 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1089 ));
AND6 \$1I1132  (.Z0(\$1N1052 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1089 ));
AND6 \$1I1134  (.Z0(\$1N1054 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1089 ));
BUF \$1I1162  (.Z0(Q3), .A0(QI3));
BUF \$1I1163  (.Z0(Q2), .A0(QI2));
BUF \$1I1164  (.Z0(Q1), .A0(QI1));
BUF \$1I1165  (.Z0(Q0), .A0(QI0));
FD11 \$1I361  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
FD11 \$1I495  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N951 ));
LXOR2 \$1I504  (.Z0(\$1N562 ), .A0(HOLD2), .A1(\$1N546 ));
FD11 \$1I505  (.Q0(QI2), .D0(\$1N562 ), .CLK(CLK));
FD11 \$1I517  (.Q0(QI3), .D0(\$1N568 ), .CLK(CLK));
LXOR2 \$1I518  (.Z0(\$1N568 ), .A0(HOLD3), .A1(\$1N939 ));
INV \$1I578  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I579  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:04:27 1994
`timescale 10 ps / 10 ps 
module CDU48(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	CAO, D0, D1, D2, 
	D3, D4, D5, D6, 
	D7, CAI, CLK, LD, 
	EN, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CAI;
	input CLK;
	input LD;
	input EN;
	input CS;

OR4 \$1I1008  (.Z0(\$1N522 ), .A0(\$1N526 ), .A1(\$1N1010 ), .A2(\$1N530 ), 
	.A3(\$1N1012 ));
OR3 \$1I1019  (.Z0(\$1N951 ), .A0(\$1N1020 ), .A1(\$1N953 ), .A2(\$1N1022 ));
OR3 \$1I1030  (.Z0(\$1N546 ), .A0(\$1N946 ), .A1(\$1N987 ), .A2(\$1N1031 ));
OR5 \$1I1049  (.Z0(\$1N939 ), .A0(\$1N931 ), .A1(\$1N1056 ), .A2(\$1N1050 ), 
	.A3(\$1N1052 ), .A4(\$1N1054 ));
AND10 \$1I1081  (.Z0(CAO), .A0(QI7), .A1(\~QI6 ), .A2(\~QI5 ), 
	.A3(QI4), .A4(QI3), .A5(\~QI2 ), .A6(\~QI1 ), 
	.A7(QI0), .A8(EN), .A9(CAI));
INV \$1I1090  (.ZN0(\$1N1089 ), .A0(CS));
AND3 \$1I1097  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ), .A2(\$1N1089 ));
AND3 \$1I1099  (.Z0(\$1N526 ), .A0(D0), .A1(LD), .A2(\$1N1089 ));
AND5 \$1I1101  (.Z0(\$1N1010 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN), 
	.A3(CAI), .A4(\$1N1089 ));
AND6 \$1I1103  (.Z0(\$1N530 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1089 ));
AND6 \$1I1106  (.Z0(\$1N1012 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1089 ));
AND3 \$1I1108  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ), .A2(\$1N1089 ));
AND3 \$1I1110  (.Z0(\$1N1020 ), .A0(D1), .A1(LD), .A2(\$1N1089 ));
AND6 \$1I1112  (.Z0(\$1N953 ), .A0(\~QI3 ), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1089 ));
AND6 \$1I1114  (.Z0(\$1N1022 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1089 ));
AND3 \$1I1116  (.Z0(HOLD2), .A0(QI2), .A1(\$1N673 ), .A2(\$1N1089 ));
AND3 \$1I1118  (.Z0(\$1N946 ), .A0(D2), .A1(LD), .A2(\$1N1089 ));
AND7 \$1I1120  (.Z0(\$1N987 ), .A0(\~QI3 ), .A1(QI1), .A2(QI0), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(\$1N1089 ));
AND6 \$1I1122  (.Z0(\$1N1031 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1089 ));
AND3 \$1I1124  (.Z0(HOLD3), .A0(QI3), .A1(\$1N673 ), .A2(\$1N1089 ));
AND3 \$1I1126  (.Z0(\$1N931 ), .A0(D3), .A1(LD), .A2(\$1N1089 ));
AND7 \$1I1128  (.Z0(\$1N1056 ), .A0(QI2), .A1(QI1), .A2(QI0), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(\$1N1089 ));
AND6 \$1I1130  (.Z0(\$1N1050 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1089 ));
AND6 \$1I1132  (.Z0(\$1N1052 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1089 ));
AND6 \$1I1134  (.Z0(\$1N1054 ), .A0(QI3), .A1(QI2), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N1089 ));
BUF \$1I1170  (.Z0(Q7), .A0(QI7));
BUF \$1I1171  (.Z0(Q6), .A0(QI6));
BUF \$1I1172  (.Z0(Q5), .A0(QI5));
BUF \$1I1173  (.Z0(Q4), .A0(QI4));
BUF \$1I1174  (.Z0(Q3), .A0(QI3));
BUF \$1I1175  (.Z0(Q2), .A0(QI2));
BUF \$1I1176  (.Z0(Q1), .A0(QI1));
BUF \$1I1177  (.Z0(Q0), .A0(QI0));
FD11 \$1I361  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
FD11 \$1I495  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N951 ));
LXOR2 \$1I504  (.Z0(\$1N562 ), .A0(HOLD2), .A1(\$1N546 ));
FD11 \$1I505  (.Q0(QI2), .D0(\$1N562 ), .CLK(CLK));
FD11 \$1I517  (.Q0(QI3), .D0(\$1N568 ), .CLK(CLK));
LXOR2 \$1I518  (.Z0(\$1N568 ), .A0(HOLD3), .A1(\$1N939 ));
INV \$1I578  (.ZN0(\~QI3 ), .A0(QI3));
INV \$1I579  (.ZN0(\~QI2 ), .A0(QI2));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
OR5 \$2I1145  (.Z0(\$2N522 ), .A0(\$2N526 ), .A1(\$2N528 ), .A2(\$2N530 ), 
	.A3(\$2N1146 ), .A4(\$2N1149 ));
OR3 \$2I1156  (.Z0(\$2N951 ), .A0(\$2N955 ), .A1(\$2N953 ), .A2(\$2N1157 ));
INV \$2I1175  (.ZN0(\$2N1174 ), .A0(CS));
AND3 \$2I1177  (.Z0(HOLD4), .A0(QI4), .A1(\$2N1069 ), .A2(\$2N1174 ));
AND3 \$2I1179  (.Z0(\$2N526 ), .A0(D4), .A1(LD), .A2(\$2N1174 ));
AND9 \$2I1181  (.Z0(\$2N528 ), .A0(\~QI7 ), .A1(QI3), .A2(\~QI2 ), 
	.A3(\~QI1 ), .A4(QI0), .A5(\$2N1069 ), .A6(EN), 
	.A7(CAI), .A8(\$2N1174 ));
AND10 \$2I1183  (.Z0(\$2N530 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$2N1069 ), 
	.A7(EN), .A8(CAI), .A9(\$2N1174 ));
AND7 \$2I1185  (.Z0(\$2N1146 ), .A0(QI7), .A1(QI6), .A2(QI4), 
	.A3(\$2N1069 ), .A4(EN), .A5(CAI), .A6(\$2N1174 ));
AND7 \$2I1187  (.Z0(\$2N1149 ), .A0(QI7), .A1(QI5), .A2(QI4), 
	.A3(\$2N1069 ), .A4(EN), .A5(CAI), .A6(\$2N1174 ));
AND3 \$2I1189  (.Z0(HOLD5), .A0(QI5), .A1(\$2N1069 ), .A2(\$2N1174 ));
AND3 \$2I1191  (.Z0(\$2N955 ), .A0(D5), .A1(LD), .A2(\$2N1174 ));
AND10 \$2I1193  (.Z0(\$2N953 ), .A0(\~QI7 ), .A1(QI4), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$2N1069 ), 
	.A7(EN), .A8(CAI), .A9(\$2N1174 ));
AND6 \$2I1195  (.Z0(\$2N1157 ), .A0(QI7), .A1(QI5), .A2(\$2N1069 ), 
	.A3(EN), .A4(CAI), .A5(\$2N1174 ));
FD11 \$2I361  (.Q0(QI4), .D0(\$2N524 ), .CLK(CLK));
LXOR2 \$2I487  (.Z0(\$2N524 ), .A0(HOLD4), .A1(\$2N522 ));
FD11 \$2I495  (.Q0(QI5), .D0(\$2N536 ), .CLK(CLK));
LXOR2 \$2I496  (.Z0(\$2N536 ), .A0(HOLD5), .A1(\$2N951 ));
INV \$2I580  (.ZN0(\~QI5 ), .A0(QI5));
INV \$2I672  (.ZN0(\$2N1069 ), .A0(LD));
OR3 \$3I1074  (.Z0(\$3N546 ), .A0(\$3N946 ), .A1(\$3N987 ), .A2(\$3N1075 ));
OR5 \$3I1088  (.Z0(\$3N939 ), .A0(\$3N931 ), .A1(\$3N1095 ), .A2(\$3N1089 ), 
	.A3(\$3N1091 ), .A4(\$3N1093 ));
INV \$3I1112  (.ZN0(\$3N1113 ), .A0(CS));
AND3 \$3I1114  (.Z0(HOLD6), .A0(QI6), .A1(\$3N673 ), .A2(\$3N1113 ));
AND3 \$3I1116  (.Z0(\$3N946 ), .A0(D6), .A1(LD), .A2(\$3N1113 ));
AND11 \$3I1118  (.Z0(\$3N987 ), .A0(\~QI7 ), .A1(QI5), .A2(QI4), 
	.A3(QI3), .A4(\~QI2 ), .A5(\~QI1 ), .A6(QI0), 
	.A7(\$3N673 ), .A8(EN), .A9(CAI), .A10(\$3N1113 ));
AND6 \$3I1120  (.Z0(\$3N1075 ), .A0(QI7), .A1(QI6), .A2(\$3N673 ), 
	.A3(EN), .A4(CAI), .A5(\$3N1113 ));
AND3 \$3I1122  (.Z0(HOLD7), .A0(QI7), .A1(\$3N673 ), .A2(\$3N1113 ));
AND3 \$3I1124  (.Z0(\$3N931 ), .A0(D7), .A1(LD), .A2(\$3N1113 ));
AND11 \$3I1127  (.Z0(\$3N1095 ), .A0(QI6), .A1(QI5), .A2(QI4), 
	.A3(QI3), .A4(\~QI2 ), .A5(\~QI1 ), .A6(QI0), 
	.A7(\$3N673 ), .A8(EN), .A9(CAI), .A10(\$3N1113 ));
AND10 \$3I1129  (.Z0(\$3N1089 ), .A0(QI7), .A1(QI4), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$3N673 ), 
	.A7(EN), .A8(CAI), .A9(\$3N1113 ));
AND6 \$3I1131  (.Z0(\$3N1091 ), .A0(QI7), .A1(QI6), .A2(\$3N673 ), 
	.A3(EN), .A4(CAI), .A5(\$3N1113 ));
AND6 \$3I1133  (.Z0(\$3N1093 ), .A0(QI7), .A1(QI5), .A2(\$3N673 ), 
	.A3(EN), .A4(CAI), .A5(\$3N1113 ));
LXOR2 \$3I504  (.Z0(\$3N562 ), .A0(HOLD6), .A1(\$3N546 ));
FD11 \$3I505  (.Q0(QI6), .D0(\$3N562 ), .CLK(CLK));
FD11 \$3I517  (.Q0(QI7), .D0(\$3N568 ), .CLK(CLK));
LXOR2 \$3I518  (.Z0(\$3N568 ), .A0(HOLD7), .A1(\$3N939 ));
INV \$3I578  (.ZN0(\~QI7 ), .A0(QI7));
INV \$3I579  (.ZN0(\~QI6 ), .A0(QI6));
INV \$3I672  (.ZN0(\$3N673 ), .A0(LD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:04:32 1994
`timescale 10 ps / 10 ps 
module CDUD4(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CLK, LD, EN, DNUP, 
	CD, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CLK;
	input LD;
	input EN;
	input DNUP;
	input CD;
	input CS;

AND5 \$1I1002  (.Z0(\$1N1011 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N582 ));
OR4 \$1I1006  (.Z0(\$1N522 ), .A0(LOAD0), .A1(\$1N1007 ), .A2(\$1N1009 ), 
	.A3(\$1N1011 ));
AND3 \$1I1013  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ), .A2(\$1N582 ));
AND5 \$1I1030  (.Z0(\$1N870 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N582 ));
BUF \$1I1051  (.Z0(Q3), .A0(QI3));
BUF \$1I1052  (.Z0(Q2), .A0(QI2));
BUF \$1I1053  (.Z0(Q1), .A0(QI1));
BUF \$1I1054  (.Z0(Q0), .A0(QI0));
AND3 \$1I277  (.Z0(LOAD1), .A0(D1), .A1(LD), .A2(\$1N582 ));
FD21 \$1I361  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK), .CD(CD));
AND3 \$1I362  (.Z0(LOAD0), .A0(D0), .A1(LD), .A2(\$1N582 ));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
AND4 \$1I488  (.Z0(\$1N1007 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN), 
	.A3(\$1N582 ));
AND5 \$1I489  (.Z0(\$1N1009 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N582 ));
FD21 \$1I495  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N886 ));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I581  (.ZN0(\~QI0 ), .A0(QI0));
AND6 \$1I636  (.Z0(\$1N540 ), .A0(\~QI3 ), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N724 ), .A5(\$1N582 ));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
INV \$1I750  (.ZN0(\$1N582 ), .A0(CS));
AND6 \$1I838  (.Z0(\$1N542 ), .A0(QI1), .A1(\~QI0 ), .A2(\$1N673 ), 
	.A3(EN), .A4(DNUP), .A5(\$1N582 ));
AND7 \$1I839  (.Z0(\$1N544 ), .A0(\~QI3 ), .A1(QI2), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(DNUP), .A6(\$1N582 ));
AND7 \$1I840  (.Z0(\$1N868 ), .A0(QI3), .A1(\~QI2 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(DNUP), .A6(\$1N582 ));
INV \$1I875  (.ZN0(\$1N724 ), .A0(DNUP));
OR6 \$1I880  (.Z0(\$1N886 ), .A0(LOAD1), .A1(\$1N540 ), .A2(\$1N542 ), 
	.A3(\$1N544 ), .A4(\$1N868 ), .A5(\$1N870 ));
AND3 \$1I988  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ), .A2(\$1N582 ));
INV \$2I11  (.ZN0(\$2N74 ), .A0(LD));
AND7 \$2I110  (.Z0(\$2N119 ), .A0(QI2), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$2N74 ), .A4(EN), .A5(DNUP), .A6(\$2N77 ));
AND5 \$2I115  (.Z0(\$2N121 ), .A0(QI3), .A1(QI2), .A2(\$2N74 ), 
	.A3(EN), .A4(\$2N77 ));
OR5 \$2I118  (.Z0(\$2N3 ), .A0(LOAD2), .A1(\$2N46 ), .A2(\$2N102 ), 
	.A3(\$2N119 ), .A4(\$2N121 ));
INV \$2I12  (.ZN0(\$2N77 ), .A0(CS));
AND3 \$2I123  (.Z0(HOLD3), .A0(QI3), .A1(\$2N74 ), .A2(\$2N77 ));
AND5 \$2I136  (.Z0(\$2N72 ), .A0(QI3), .A1(QI2), .A2(\$2N74 ), 
	.A3(EN), .A4(\$2N77 ));
AND5 \$2I137  (.Z0(\$2N78 ), .A0(QI3), .A1(QI1), .A2(\$2N74 ), 
	.A3(EN), .A4(\$2N77 ));
INV \$2I14  (.ZN0(\$2N69 ), .A0(DNUP));
AND3 \$2I41  (.Z0(LOAD2), .A0(D2), .A1(LD), .A2(\$2N77 ));
AND7 \$2I42  (.Z0(\$2N46 ), .A0(\~QI3 ), .A1(QI1), .A2(QI0), 
	.A3(\$2N74 ), .A4(EN), .A5(\$2N69 ), .A6(\$2N77 ));
OR6 \$2I5  (.Z0(\$2N79 ), .A0(\$2N148 ), .A1(\$2N150 ), .A2(\$2N152 ), 
	.A3(\$2N70 ), .A4(\$2N72 ), .A5(\$2N78 ));
AND7 \$2I50  (.Z0(\$2N102 ), .A0(QI3), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$2N74 ), .A4(EN), .A5(DNUP), .A6(\$2N77 ));
AND3 \$2I62  (.Z0(\$2N148 ), .A0(D3), .A1(LD), .A2(\$2N77 ));
AND7 \$2I65  (.Z0(\$2N150 ), .A0(QI2), .A1(QI1), .A2(QI0), 
	.A3(\$2N74 ), .A4(EN), .A5(\$2N69 ), .A6(\$2N77 ));
AND6 \$2I71  (.Z0(\$2N152 ), .A0(QI3), .A1(QI0), .A2(\$2N74 ), 
	.A3(EN), .A4(\$2N69 ), .A5(\$2N77 ));
AND7 \$2I73  (.Z0(\$2N70 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$2N74 ), .A4(EN), .A5(DNUP), .A6(\$2N77 ));
LXOR2 \$2I81  (.Z0(\$2N4 ), .A0(HOLD3), .A1(\$2N79 ));
LXOR2 \$2I83  (.Z0(\$2N84 ), .A0(HOLD2), .A1(\$2N3 ));
FD21 \$2I89  (.Q0(QI2), .D0(\$2N84 ), .CLK(CLK), .CD(CD));
INV \$2I90  (.ZN0(\~QI2 ), .A0(QI2));
INV \$2I92  (.ZN0(\~QI3 ), .A0(QI3));
FD21 \$2I94  (.Q0(QI3), .D0(\$2N4 ), .CLK(CLK), .CD(CD));
AND3 \$2I96  (.Z0(HOLD2), .A0(QI2), .A1(\$2N74 ), .A2(\$2N77 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:04:36 1994
`timescale 10 ps / 10 ps 
module CDUD4C(
	Q0, Q1, Q2, Q3, 
	CAO, D0, D1, D2, 
	D3, CAI, CLK, LD, 
	EN, DNUP, CD, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input CAI;
	input CLK;
	input LD;
	input EN;
	input DNUP;
	input CD;
	input CS;

OR4 \$1I1006  (.Z0(\$1N522 ), .A0(LOAD0), .A1(\$1N1007 ), .A2(\$1N1009 ), 
	.A3(\$1N1011 ));
AND3 \$1I1013  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ), .A2(\$1N582 ));
AND5 \$1I1037  (.Z0(\$1N1007 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN), 
	.A3(CAI), .A4(\$1N582 ));
AND6 \$1I1039  (.Z0(\$1N1009 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N582 ));
AND6 \$1I1041  (.Z0(\$1N1011 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N582 ));
AND7 \$1I1043  (.Z0(\$1N540 ), .A0(\~QI3 ), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N724 ), .A6(\$1N582 ));
AND7 \$1I1045  (.Z0(\$1N542 ), .A0(QI1), .A1(\~QI0 ), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(DNUP), .A6(\$1N582 ));
AND8 \$1I1047  (.Z0(\$1N544 ), .A0(\~QI3 ), .A1(QI2), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(DNUP), 
	.A7(\$1N582 ));
AND8 \$1I1049  (.Z0(\$1N868 ), .A0(QI3), .A1(\~QI2 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(DNUP), 
	.A7(\$1N582 ));
AND6 \$1I1051  (.Z0(\$1N870 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N582 ));
AND7 \$1I1062  (.Z0(\$1N1067 ), .A0(\~QI3 ), .A1(\~QI2 ), .A2(\~QI1 ), 
	.A3(\~QI0 ), .A4(EN), .A5(CAI), .A6(DNUP));
AND7 \$1I1063  (.Z0(\$1N1065 ), .A0(QI3), .A1(\~QI2 ), .A2(\~QI1 ), 
	.A3(QI0), .A4(EN), .A5(CAI), .A6(\$1N724 ));
OR2 \$1I1064  (.Z0(CAO), .A0(\$1N1067 ), .A1(\$1N1065 ));
BUF \$1I1104  (.Z0(Q0), .A0(QI0));
BUF \$1I1105  (.Z0(Q1), .A0(QI1));
BUF \$1I1106  (.Z0(Q2), .A0(QI2));
BUF \$1I1107  (.Z0(Q3), .A0(QI3));
AND3 \$1I277  (.Z0(LOAD1), .A0(D1), .A1(LD), .A2(\$1N582 ));
FD21 \$1I361  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK), .CD(CD));
AND3 \$1I362  (.Z0(LOAD0), .A0(D0), .A1(LD), .A2(\$1N582 ));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
FD21 \$1I495  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N886 ));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I581  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
INV \$1I750  (.ZN0(\$1N582 ), .A0(CS));
INV \$1I875  (.ZN0(\$1N724 ), .A0(DNUP));
OR6 \$1I880  (.Z0(\$1N886 ), .A0(LOAD1), .A1(\$1N540 ), .A2(\$1N542 ), 
	.A3(\$1N544 ), .A4(\$1N868 ), .A5(\$1N870 ));
AND3 \$1I988  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ), .A2(\$1N582 ));
INV \$2I11  (.ZN0(\$2N74 ), .A0(LD));
OR5 \$2I118  (.Z0(\$2N3 ), .A0(LOAD2), .A1(\$2N46 ), .A2(\$2N102 ), 
	.A3(\$2N119 ), .A4(\$2N121 ));
INV \$2I12  (.ZN0(\$2N77 ), .A0(CS));
AND3 \$2I123  (.Z0(HOLD3), .A0(QI3), .A1(\$2N74 ), .A2(\$2N77 ));
INV \$2I14  (.ZN0(\$2N69 ), .A0(DNUP));
AND8 \$2I155  (.Z0(\$2N46 ), .A0(\~QI3 ), .A1(QI1), .A2(QI0), 
	.A3(\$2N74 ), .A4(EN), .A5(CAI), .A6(\$2N69 ), 
	.A7(\$2N77 ));
AND8 \$2I157  (.Z0(\$2N102 ), .A0(QI3), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$2N74 ), .A4(EN), .A5(CAI), .A6(DNUP), 
	.A7(\$2N77 ));
AND8 \$2I159  (.Z0(\$2N119 ), .A0(QI2), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$2N74 ), .A4(EN), .A5(CAI), .A6(DNUP), 
	.A7(\$2N77 ));
AND6 \$2I161  (.Z0(\$2N121 ), .A0(QI3), .A1(QI2), .A2(\$2N74 ), 
	.A3(EN), .A4(CAI), .A5(\$2N77 ));
AND8 \$2I163  (.Z0(\$2N150 ), .A0(QI2), .A1(QI1), .A2(QI0), 
	.A3(\$2N74 ), .A4(EN), .A5(CAI), .A6(\$2N69 ), 
	.A7(\$2N77 ));
AND7 \$2I165  (.Z0(\$2N152 ), .A0(QI3), .A1(QI0), .A2(\$2N74 ), 
	.A3(EN), .A4(CAI), .A5(\$2N69 ), .A6(\$2N77 ));
AND8 \$2I167  (.Z0(\$2N70 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$2N74 ), .A4(EN), .A5(CAI), .A6(DNUP), 
	.A7(\$2N77 ));
AND6 \$2I169  (.Z0(\$2N72 ), .A0(QI3), .A1(QI2), .A2(\$2N74 ), 
	.A3(EN), .A4(CAI), .A5(\$2N77 ));
AND6 \$2I171  (.Z0(\$2N78 ), .A0(QI3), .A1(QI1), .A2(\$2N74 ), 
	.A3(EN), .A4(CAI), .A5(\$2N77 ));
AND3 \$2I41  (.Z0(LOAD2), .A0(D2), .A1(LD), .A2(\$2N77 ));
OR6 \$2I5  (.Z0(\$2N79 ), .A0(\$2N148 ), .A1(\$2N150 ), .A2(\$2N152 ), 
	.A3(\$2N70 ), .A4(\$2N72 ), .A5(\$2N78 ));
AND3 \$2I62  (.Z0(\$2N148 ), .A0(D3), .A1(LD), .A2(\$2N77 ));
LXOR2 \$2I81  (.Z0(\$2N4 ), .A0(HOLD3), .A1(\$2N79 ));
LXOR2 \$2I83  (.Z0(\$2N84 ), .A0(HOLD2), .A1(\$2N3 ));
FD21 \$2I89  (.Q0(QI2), .D0(\$2N84 ), .CLK(CLK), .CD(CD));
INV \$2I90  (.ZN0(\~QI2 ), .A0(QI2));
INV \$2I92  (.ZN0(\~QI3 ), .A0(QI3));
FD21 \$2I94  (.Q0(QI3), .D0(\$2N4 ), .CLK(CLK), .CD(CD));
AND3 \$2I96  (.Z0(HOLD2), .A0(QI2), .A1(\$2N74 ), .A2(\$2N77 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:04:44 1994
`timescale 10 ps / 10 ps 
module CDUD8(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	CLK, LD, EN, DNUP, 
	CD, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CLK;
	input LD;
	input EN;
	input DNUP;
	input CD;
	input CS;

AND5 \$1I1002  (.Z0(\$1N1011 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N582 ));
OR4 \$1I1006  (.Z0(\$1N522 ), .A0(LOAD0), .A1(\$1N1007 ), .A2(\$1N1009 ), 
	.A3(\$1N1011 ));
AND3 \$1I1013  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ), .A2(\$1N582 ));
AND5 \$1I1030  (.Z0(\$1N870 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N582 ));
BUF \$1I1059  (.Z0(Q7), .A0(QI7));
BUF \$1I1060  (.Z0(Q6), .A0(QI6));
BUF \$1I1061  (.Z0(Q5), .A0(QI5));
BUF \$1I1062  (.Z0(Q4), .A0(QI4));
BUF \$1I1063  (.Z0(Q3), .A0(QI3));
BUF \$1I1064  (.Z0(Q2), .A0(QI2));
BUF \$1I1065  (.Z0(Q1), .A0(QI1));
BUF \$1I1066  (.Z0(Q0), .A0(QI0));
AND3 \$1I277  (.Z0(LOAD1), .A0(D1), .A1(LD), .A2(\$1N582 ));
FD21 \$1I361  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK), .CD(CD));
AND3 \$1I362  (.Z0(LOAD0), .A0(D0), .A1(LD), .A2(\$1N582 ));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
AND4 \$1I488  (.Z0(\$1N1007 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN), 
	.A3(\$1N582 ));
AND5 \$1I489  (.Z0(\$1N1009 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N582 ));
FD21 \$1I495  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N886 ));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I581  (.ZN0(\~QI0 ), .A0(QI0));
AND6 \$1I636  (.Z0(\$1N540 ), .A0(\~QI3 ), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(\$1N724 ), .A5(\$1N582 ));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
INV \$1I750  (.ZN0(\$1N582 ), .A0(CS));
AND6 \$1I838  (.Z0(\$1N542 ), .A0(QI1), .A1(\~QI0 ), .A2(\$1N673 ), 
	.A3(EN), .A4(DNUP), .A5(\$1N582 ));
AND7 \$1I839  (.Z0(\$1N544 ), .A0(\~QI3 ), .A1(QI2), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(DNUP), .A6(\$1N582 ));
AND7 \$1I840  (.Z0(\$1N868 ), .A0(QI3), .A1(\~QI2 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(DNUP), .A6(\$1N582 ));
INV \$1I875  (.ZN0(\$1N724 ), .A0(DNUP));
OR6 \$1I880  (.Z0(\$1N886 ), .A0(LOAD1), .A1(\$1N540 ), .A2(\$1N542 ), 
	.A3(\$1N544 ), .A4(\$1N868 ), .A5(\$1N870 ));
AND3 \$1I988  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ), .A2(\$1N582 ));
INV \$2I11  (.ZN0(\$2N74 ), .A0(LD));
AND7 \$2I110  (.Z0(\$2N119 ), .A0(QI2), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$2N74 ), .A4(EN), .A5(DNUP), .A6(\$2N77 ));
AND5 \$2I115  (.Z0(\$2N121 ), .A0(QI3), .A1(QI2), .A2(\$2N74 ), 
	.A3(EN), .A4(\$2N77 ));
OR5 \$2I118  (.Z0(\$2N3 ), .A0(LOAD2), .A1(\$2N46 ), .A2(\$2N102 ), 
	.A3(\$2N119 ), .A4(\$2N121 ));
INV \$2I12  (.ZN0(\$2N77 ), .A0(CS));
AND3 \$2I123  (.Z0(HOLD3), .A0(QI3), .A1(\$2N74 ), .A2(\$2N77 ));
AND5 \$2I136  (.Z0(\$2N72 ), .A0(QI3), .A1(QI2), .A2(\$2N74 ), 
	.A3(EN), .A4(\$2N77 ));
AND5 \$2I137  (.Z0(\$2N78 ), .A0(QI3), .A1(QI1), .A2(\$2N74 ), 
	.A3(EN), .A4(\$2N77 ));
INV \$2I14  (.ZN0(\$2N69 ), .A0(DNUP));
AND3 \$2I41  (.Z0(LOAD2), .A0(D2), .A1(LD), .A2(\$2N77 ));
AND7 \$2I42  (.Z0(\$2N46 ), .A0(\~QI3 ), .A1(QI1), .A2(QI0), 
	.A3(\$2N74 ), .A4(EN), .A5(\$2N69 ), .A6(\$2N77 ));
OR6 \$2I5  (.Z0(\$2N79 ), .A0(\$2N148 ), .A1(\$2N150 ), .A2(\$2N152 ), 
	.A3(\$2N70 ), .A4(\$2N72 ), .A5(\$2N78 ));
AND7 \$2I50  (.Z0(\$2N102 ), .A0(QI3), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$2N74 ), .A4(EN), .A5(DNUP), .A6(\$2N77 ));
AND3 \$2I62  (.Z0(\$2N148 ), .A0(D3), .A1(LD), .A2(\$2N77 ));
AND7 \$2I65  (.Z0(\$2N150 ), .A0(QI2), .A1(QI1), .A2(QI0), 
	.A3(\$2N74 ), .A4(EN), .A5(\$2N69 ), .A6(\$2N77 ));
AND6 \$2I71  (.Z0(\$2N152 ), .A0(QI3), .A1(QI0), .A2(\$2N74 ), 
	.A3(EN), .A4(\$2N69 ), .A5(\$2N77 ));
AND7 \$2I73  (.Z0(\$2N70 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$2N74 ), .A4(EN), .A5(DNUP), .A6(\$2N77 ));
LXOR2 \$2I81  (.Z0(\$2N4 ), .A0(HOLD3), .A1(\$2N79 ));
LXOR2 \$2I83  (.Z0(\$2N84 ), .A0(HOLD2), .A1(\$2N3 ));
FD21 \$2I89  (.Q0(QI2), .D0(\$2N84 ), .CLK(CLK), .CD(CD));
INV \$2I90  (.ZN0(\~QI2 ), .A0(QI2));
INV \$2I92  (.ZN0(\~QI3 ), .A0(QI3));
FD21 \$2I94  (.Q0(QI3), .D0(\$2N4 ), .CLK(CLK), .CD(CD));
AND3 \$2I96  (.Z0(HOLD2), .A0(QI2), .A1(\$2N74 ), .A2(\$2N77 ));
AND3 \$3I291  (.Z0(LOAD4), .A0(D4), .A1(LD), .A2(\$3N577 ));
AND9 \$3I292  (.Z0(\$3N314 ), .A0(\~QI7 ), .A1(QI3), .A2(\~QI2 ), 
	.A3(\~QI1 ), .A4(QI0), .A5(\$3N519 ), .A6(EN), 
	.A7(\$3N625 ), .A8(\$3N577 ));
AND10 \$3I293  (.Z0(\$3N311 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$3N519 ), 
	.A7(EN), .A8(\$3N625 ), .A9(\$3N577 ));
AND9 \$3I294  (.Z0(\$3N320 ), .A0(\~QI7 ), .A1(\~QI3 ), .A2(\~QI2 ), 
	.A3(\~QI1 ), .A4(\~QI0 ), .A5(\$3N519 ), .A6(EN), 
	.A7(DNUP), .A8(\$3N577 ));
AND10 \$3I295  (.Z0(\$3N322 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(\~QI3 ), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(\~QI0 ), .A6(\$3N519 ), 
	.A7(EN), .A8(DNUP), .A9(\$3N577 ));
OR7 \$3I385  (.Z0(\$3N404 ), .A0(LOAD4), .A1(\$3N314 ), .A2(\$3N311 ), 
	.A3(\$3N320 ), .A4(\$3N322 ), .A5(\$3N677 ), .A6(\$3N679 ));
LXOR2 \$3I410  (.Z0(\$3N416 ), .A0(HOLD4), .A1(\$3N404 ));
FD21 \$3I415  (.Q0(QI4), .D0(\$3N416 ), .CLK(CLK), .CD(CD));
INV \$3I418  (.ZN0(\~QI4 ), .A0(QI4));
INV \$3I517  (.ZN0(\$3N519 ), .A0(LD));
INV \$3I583  (.ZN0(\$3N577 ), .A0(CS));
INV \$3I626  (.ZN0(\$3N625 ), .A0(DNUP));
AND3 \$3I645  (.Z0(HOLD4), .A0(QI4), .A1(\$3N519 ), .A2(\$3N577 ));
AND6 \$3I663  (.Z0(\$3N677 ), .A0(QI7), .A1(QI6), .A2(QI4), 
	.A3(\$3N519 ), .A4(EN), .A5(\$3N577 ));
AND6 \$3I664  (.Z0(\$3N679 ), .A0(QI7), .A1(QI5), .A2(QI4), 
	.A3(\$3N519 ), .A4(EN), .A5(\$3N577 ));
AND3 \$4I707  (.Z0(LOAD5), .A0(D5), .A1(LD), .A2(\$4N883 ));
AND10 \$4I708  (.Z0(\$4N741 ), .A0(\~QI7 ), .A1(QI4), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$4N832 ), 
	.A7(EN), .A8(\$4N922 ), .A9(\$4N883 ));
AND10 \$4I709  (.Z0(\$4N727 ), .A0(QI5), .A1(\~QI4 ), .A2(\~QI3 ), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(\~QI0 ), .A6(\$4N832 ), 
	.A7(EN), .A8(DNUP), .A9(\$4N883 ));
AND11 \$4I710  (.Z0(\$4N745 ), .A0(\~QI7 ), .A1(QI6), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$4N832 ), .A8(EN), .A9(DNUP), .A10(\$4N883 ));
AND11 \$4I711  (.Z0(\$4N747 ), .A0(QI7), .A1(\~QI6 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$4N832 ), .A8(EN), .A9(DNUP), .A10(\$4N883 ));
LXOR2 \$4I731  (.Z0(\$4N735 ), .A0(HOLD5), .A1(\$4N733 ));
FD21 \$4I732  (.Q0(QI5), .D0(\$4N735 ), .CLK(CLK), .CD(CD));
INV \$4I762  (.ZN0(\~QI5 ), .A0(QI5));
INV \$4I830  (.ZN0(\$4N832 ), .A0(LD));
INV \$4I879  (.ZN0(\$4N883 ), .A0(CS));
INV \$4I902  (.ZN0(\$4N922 ), .A0(DNUP));
AND3 \$4I914  (.Z0(HOLD5), .A0(QI5), .A1(\$4N832 ), .A2(\$4N883 ));
AND5 \$4I946  (.Z0(\$4N953 ), .A0(QI7), .A1(QI5), .A2(\$4N832 ), 
	.A3(EN), .A4(\$4N883 ));
OR6 \$4I952  (.Z0(\$4N733 ), .A0(LOAD5), .A1(\$4N741 ), .A2(\$4N727 ), 
	.A3(\$4N745 ), .A4(\$4N747 ), .A5(\$4N953 ));
AND3 \$5I707  (.Z0(LOAD6), .A0(D6), .A1(LD), .A2(\$5N883 ));
AND11 \$5I708  (.Z0(\$5N741 ), .A0(\~QI7 ), .A1(QI5), .A2(QI4), 
	.A3(QI3), .A4(\~QI2 ), .A5(\~QI1 ), .A6(QI0), 
	.A7(\$5N832 ), .A8(EN), .A9(\$5N973 ), .A10(\$5N883 ));
AND11 \$5I709  (.Z0(\$5N727 ), .A0(QI7), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$5N832 ), .A8(EN), .A9(DNUP), .A10(\$5N883 ));
AND11 \$5I710  (.Z0(\$5N745 ), .A0(QI6), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$5N832 ), .A8(EN), .A9(DNUP), .A10(\$5N883 ));
LXOR2 \$5I731  (.Z0(\$5N735 ), .A0(HOLD6), .A1(\$5N733 ));
FD21 \$5I732  (.Q0(QI6), .D0(\$5N735 ), .CLK(CLK), .CD(CD));
INV \$5I762  (.ZN0(\~QI6 ), .A0(QI6));
INV \$5I830  (.ZN0(\$5N832 ), .A0(LD));
INV \$5I879  (.ZN0(\$5N883 ), .A0(CS));
INV \$5I956  (.ZN0(\$5N973 ), .A0(DNUP));
AND3 \$5I965  (.Z0(HOLD6), .A0(QI6), .A1(\$5N832 ), .A2(\$5N883 ));
AND5 \$5I982  (.Z0(\$5N986 ), .A0(QI7), .A1(QI6), .A2(\$5N832 ), 
	.A3(EN), .A4(\$5N883 ));
OR5 \$5I985  (.Z0(\$5N733 ), .A0(LOAD6), .A1(\$5N741 ), .A2(\$5N727 ), 
	.A3(\$5N745 ), .A4(\$5N986 ));
AND3 \$6I716  (.Z0(LOAD7), .A0(D7), .A1(LD), .A2(\$6N888 ));
AND11 \$6I717  (.Z0(\$6N737 ), .A0(QI6), .A1(QI5), .A2(QI4), 
	.A3(QI3), .A4(\~QI2 ), .A5(\~QI1 ), .A6(QI0), 
	.A7(\$6N840 ), .A8(EN), .A9(\$6N927 ), .A10(\$6N888 ));
AND10 \$6I718  (.Z0(\$6N735 ), .A0(QI7), .A1(QI4), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$6N840 ), 
	.A7(EN), .A8(\$6N927 ), .A9(\$6N888 ));
AND11 \$6I719  (.Z0(\$6N741 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$6N840 ), .A8(EN), .A9(DNUP), .A10(\$6N888 ));
LXOR2 \$6I733  (.Z0(\$6N751 ), .A0(HOLD7), .A1(\$6N749 ));
FD21 \$6I734  (.Q0(QI7), .D0(\$6N751 ), .CLK(CLK), .CD(CD));
INV \$6I769  (.ZN0(\~QI7 ), .A0(QI7));
INV \$6I837  (.ZN0(\$6N840 ), .A0(LD));
INV \$6I867  (.ZN0(\$6N927 ), .A0(DNUP));
INV \$6I887  (.ZN0(\$6N888 ), .A0(CS));
AND3 \$6I913  (.Z0(HOLD7), .A0(QI7), .A1(\$6N840 ), .A2(\$6N888 ));
AND5 \$6I931  (.Z0(\$6N743 ), .A0(QI7), .A1(QI6), .A2(\$6N840 ), 
	.A3(EN), .A4(\$6N888 ));
AND5 \$6I936  (.Z0(\$6N939 ), .A0(QI7), .A1(QI5), .A2(\$6N840 ), 
	.A3(EN), .A4(\$6N888 ));
OR6 \$6I938  (.Z0(\$6N749 ), .A0(LOAD7), .A1(\$6N737 ), .A2(\$6N735 ), 
	.A3(\$6N741 ), .A4(\$6N743 ), .A5(\$6N939 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:04:52 1994
`timescale 10 ps / 10 ps 
module CDUD8C(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	CAO, D0, D1, D2, 
	D3, D4, D5, D6, 
	D7, CAI, CLK, LD, 
	EN, DNUP, CD, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	output CAO;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CAI;
	input CLK;
	input LD;
	input EN;
	input DNUP;
	input CD;
	input CS;

OR4 \$1I1006  (.Z0(\$1N522 ), .A0(LOAD0), .A1(\$1N1007 ), .A2(\$1N1009 ), 
	.A3(\$1N1011 ));
AND3 \$1I1013  (.Z0(HOLD1), .A0(QI1), .A1(\$1N673 ), .A2(\$1N582 ));
AND5 \$1I1037  (.Z0(\$1N1007 ), .A0(\~QI3 ), .A1(\$1N673 ), .A2(EN), 
	.A3(CAI), .A4(\$1N582 ));
AND6 \$1I1039  (.Z0(\$1N1009 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N582 ));
AND6 \$1I1041  (.Z0(\$1N1011 ), .A0(QI3), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N582 ));
AND7 \$1I1043  (.Z0(\$1N540 ), .A0(\~QI3 ), .A1(QI0), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N724 ), .A6(\$1N582 ));
AND7 \$1I1045  (.Z0(\$1N542 ), .A0(QI1), .A1(\~QI0 ), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(DNUP), .A6(\$1N582 ));
AND8 \$1I1047  (.Z0(\$1N544 ), .A0(\~QI3 ), .A1(QI2), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(DNUP), 
	.A7(\$1N582 ));
AND8 \$1I1049  (.Z0(\$1N868 ), .A0(QI3), .A1(\~QI2 ), .A2(\~QI0 ), 
	.A3(\$1N673 ), .A4(EN), .A5(CAI), .A6(DNUP), 
	.A7(\$1N582 ));
AND6 \$1I1051  (.Z0(\$1N870 ), .A0(QI3), .A1(QI1), .A2(\$1N673 ), 
	.A3(EN), .A4(CAI), .A5(\$1N582 ));
AND11 \$1I1062  (.Z0(\$1N1067 ), .A0(\~QI7 ), .A1(\~QI6 ), .A2(\~QI5 ), 
	.A3(\~QI4 ), .A4(\~QI3 ), .A5(\~QI2 ), .A6(\~QI1 ), 
	.A7(\~QI0 ), .A8(EN), .A9(CAI), .A10(DNUP));
AND11 \$1I1063  (.Z0(\$1N1065 ), .A0(QI7), .A1(\~QI6 ), .A2(\~QI5 ), 
	.A3(QI4), .A4(QI3), .A5(\~QI2 ), .A6(\~QI1 ), 
	.A7(QI0), .A8(EN), .A9(CAI), .A10(\$1N724 ));
OR2 \$1I1064  (.Z0(CAO), .A0(\$1N1067 ), .A1(\$1N1065 ));
BUF \$1I1120  (.Z0(Q0), .A0(QI0));
BUF \$1I1121  (.Z0(Q1), .A0(QI1));
BUF \$1I1122  (.Z0(Q2), .A0(QI2));
BUF \$1I1123  (.Z0(Q3), .A0(QI3));
BUF \$1I1124  (.Z0(Q4), .A0(QI4));
BUF \$1I1125  (.Z0(Q5), .A0(QI5));
BUF \$1I1126  (.Z0(Q6), .A0(QI6));
BUF \$1I1127  (.Z0(Q7), .A0(QI7));
AND3 \$1I277  (.Z0(LOAD1), .A0(D1), .A1(LD), .A2(\$1N582 ));
FD21 \$1I361  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK), .CD(CD));
AND3 \$1I362  (.Z0(LOAD0), .A0(D0), .A1(LD), .A2(\$1N582 ));
LXOR2 \$1I487  (.Z0(\$1N524 ), .A0(HOLD0), .A1(\$1N522 ));
FD21 \$1I495  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK), .CD(CD));
LXOR2 \$1I496  (.Z0(\$1N536 ), .A0(HOLD1), .A1(\$1N886 ));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I581  (.ZN0(\~QI0 ), .A0(QI0));
INV \$1I672  (.ZN0(\$1N673 ), .A0(LD));
INV \$1I750  (.ZN0(\$1N582 ), .A0(CS));
INV \$1I875  (.ZN0(\$1N724 ), .A0(DNUP));
OR6 \$1I880  (.Z0(\$1N886 ), .A0(LOAD1), .A1(\$1N540 ), .A2(\$1N542 ), 
	.A3(\$1N544 ), .A4(\$1N868 ), .A5(\$1N870 ));
AND3 \$1I988  (.Z0(HOLD0), .A0(QI0), .A1(\$1N673 ), .A2(\$1N582 ));
INV \$2I11  (.ZN0(\$2N74 ), .A0(LD));
OR5 \$2I118  (.Z0(\$2N3 ), .A0(LOAD2), .A1(\$2N46 ), .A2(\$2N102 ), 
	.A3(\$2N119 ), .A4(\$2N121 ));
INV \$2I12  (.ZN0(\$2N77 ), .A0(CS));
AND3 \$2I123  (.Z0(HOLD3), .A0(QI3), .A1(\$2N74 ), .A2(\$2N77 ));
INV \$2I14  (.ZN0(\$2N69 ), .A0(DNUP));
AND8 \$2I155  (.Z0(\$2N46 ), .A0(\~QI3 ), .A1(QI1), .A2(QI0), 
	.A3(\$2N74 ), .A4(EN), .A5(CAI), .A6(\$2N69 ), 
	.A7(\$2N77 ));
AND8 \$2I157  (.Z0(\$2N102 ), .A0(QI3), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$2N74 ), .A4(EN), .A5(CAI), .A6(DNUP), 
	.A7(\$2N77 ));
AND8 \$2I159  (.Z0(\$2N119 ), .A0(QI2), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$2N74 ), .A4(EN), .A5(CAI), .A6(DNUP), 
	.A7(\$2N77 ));
AND6 \$2I161  (.Z0(\$2N121 ), .A0(QI3), .A1(QI2), .A2(\$2N74 ), 
	.A3(EN), .A4(CAI), .A5(\$2N77 ));
AND8 \$2I163  (.Z0(\$2N150 ), .A0(QI2), .A1(QI1), .A2(QI0), 
	.A3(\$2N74 ), .A4(EN), .A5(CAI), .A6(\$2N69 ), 
	.A7(\$2N77 ));
AND7 \$2I165  (.Z0(\$2N152 ), .A0(QI3), .A1(QI0), .A2(\$2N74 ), 
	.A3(EN), .A4(CAI), .A5(\$2N69 ), .A6(\$2N77 ));
AND8 \$2I167  (.Z0(\$2N70 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$2N74 ), .A4(EN), .A5(CAI), .A6(DNUP), 
	.A7(\$2N77 ));
AND6 \$2I169  (.Z0(\$2N72 ), .A0(QI3), .A1(QI2), .A2(\$2N74 ), 
	.A3(EN), .A4(CAI), .A5(\$2N77 ));
AND6 \$2I171  (.Z0(\$2N78 ), .A0(QI3), .A1(QI1), .A2(\$2N74 ), 
	.A3(EN), .A4(CAI), .A5(\$2N77 ));
AND3 \$2I41  (.Z0(LOAD2), .A0(D2), .A1(LD), .A2(\$2N77 ));
OR6 \$2I5  (.Z0(\$2N79 ), .A0(\$2N148 ), .A1(\$2N150 ), .A2(\$2N152 ), 
	.A3(\$2N70 ), .A4(\$2N72 ), .A5(\$2N78 ));
AND3 \$2I62  (.Z0(\$2N148 ), .A0(D3), .A1(LD), .A2(\$2N77 ));
LXOR2 \$2I81  (.Z0(\$2N4 ), .A0(HOLD3), .A1(\$2N79 ));
LXOR2 \$2I83  (.Z0(\$2N84 ), .A0(HOLD2), .A1(\$2N3 ));
FD21 \$2I89  (.Q0(QI2), .D0(\$2N84 ), .CLK(CLK), .CD(CD));
INV \$2I90  (.ZN0(\~QI2 ), .A0(QI2));
INV \$2I92  (.ZN0(\~QI3 ), .A0(QI3));
FD21 \$2I94  (.Q0(QI3), .D0(\$2N4 ), .CLK(CLK), .CD(CD));
AND3 \$2I96  (.Z0(HOLD2), .A0(QI2), .A1(\$2N74 ), .A2(\$2N77 ));
AND3 \$3I291  (.Z0(LOAD4), .A0(D4), .A1(LD), .A2(\$3N577 ));
OR7 \$3I385  (.Z0(\$3N404 ), .A0(LOAD4), .A1(\$3N314 ), .A2(\$3N311 ), 
	.A3(\$3N320 ), .A4(\$3N322 ), .A5(\$3N677 ), .A6(\$3N679 ));
LXOR2 \$3I410  (.Z0(\$3N416 ), .A0(HOLD4), .A1(\$3N404 ));
FD21 \$3I415  (.Q0(QI4), .D0(\$3N416 ), .CLK(CLK), .CD(CD));
INV \$3I418  (.ZN0(\~QI4 ), .A0(QI4));
INV \$3I517  (.ZN0(\$3N519 ), .A0(LD));
INV \$3I583  (.ZN0(\$3N577 ), .A0(CS));
INV \$3I626  (.ZN0(\$3N625 ), .A0(DNUP));
AND3 \$3I645  (.Z0(HOLD4), .A0(QI4), .A1(\$3N519 ), .A2(\$3N577 ));
AND10 \$3I682  (.Z0(\$3N314 ), .A0(\~QI7 ), .A1(QI3), .A2(\~QI2 ), 
	.A3(\~QI1 ), .A4(QI0), .A5(\$3N519 ), .A6(EN), 
	.A7(CAI), .A8(\$3N625 ), .A9(\$3N577 ));
AND11 \$3I684  (.Z0(\$3N311 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$3N519 ), 
	.A7(EN), .A8(CAI), .A9(\$3N625 ), .A10(\$3N577 ));
AND10 \$3I686  (.Z0(\$3N320 ), .A0(\~QI7 ), .A1(\~QI3 ), .A2(\~QI2 ), 
	.A3(\~QI1 ), .A4(\~QI0 ), .A5(\$3N519 ), .A6(EN), 
	.A7(CAI), .A8(DNUP), .A9(\$3N577 ));
AND11 \$3I688  (.Z0(\$3N322 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(\~QI3 ), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(\~QI0 ), .A6(\$3N519 ), 
	.A7(EN), .A8(CAI), .A9(DNUP), .A10(\$3N577 ));
AND7 \$3I690  (.Z0(\$3N677 ), .A0(QI7), .A1(QI6), .A2(QI4), 
	.A3(\$3N519 ), .A4(EN), .A5(CAI), .A6(\$3N577 ));
AND7 \$3I692  (.Z0(\$3N679 ), .A0(QI7), .A1(QI5), .A2(QI4), 
	.A3(\$3N519 ), .A4(EN), .A5(CAI), .A6(\$3N577 ));
AND3 \$4I707  (.Z0(LOAD5), .A0(D5), .A1(LD), .A2(\$4N883 ));
LXOR2 \$4I731  (.Z0(\$4N735 ), .A0(HOLD5), .A1(\$4N733 ));
FD21 \$4I732  (.Q0(QI5), .D0(\$4N735 ), .CLK(CLK), .CD(CD));
INV \$4I762  (.ZN0(\~QI5 ), .A0(QI5));
INV \$4I830  (.ZN0(\$4N832 ), .A0(LD));
INV \$4I879  (.ZN0(\$4N883 ), .A0(CS));
INV \$4I902  (.ZN0(\$4N922 ), .A0(DNUP));
AND3 \$4I914  (.Z0(HOLD5), .A0(QI5), .A1(\$4N832 ), .A2(\$4N883 ));
OR6 \$4I952  (.Z0(\$4N733 ), .A0(LOAD5), .A1(\$4N741 ), .A2(\$4N727 ), 
	.A3(\$4N745 ), .A4(\$4N747 ), .A5(\$4N953 ));
AND11 \$4I956  (.Z0(\$4N741 ), .A0(\~QI7 ), .A1(QI4), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$4N832 ), 
	.A7(EN), .A8(CAI), .A9(\$4N922 ), .A10(\$4N883 ));
AND11 \$4I958  (.Z0(\$4N727 ), .A0(QI5), .A1(\~QI4 ), .A2(\~QI3 ), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(\~QI0 ), .A6(\$4N832 ), 
	.A7(EN), .A8(CAI), .A9(DNUP), .A10(\$4N883 ));
AND12 \$4I960  (.Z0(\$4N745 ), .A0(\~QI7 ), .A1(QI6), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$4N832 ), .A8(EN), .A9(CAI), .A10(DNUP), 
	.A11(\$4N883 ));
AND12 \$4I962  (.Z0(\$4N747 ), .A0(QI7), .A1(\~QI6 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$4N832 ), .A8(EN), .A9(CAI), .A10(DNUP), 
	.A11(\$4N883 ));
AND6 \$4I964  (.Z0(\$4N953 ), .A0(QI7), .A1(QI5), .A2(\$4N832 ), 
	.A3(EN), .A4(CAI), .A5(\$4N883 ));
AND3 \$5I707  (.Z0(LOAD6), .A0(D6), .A1(LD), .A2(\$5N883 ));
LXOR2 \$5I731  (.Z0(\$5N735 ), .A0(HOLD6), .A1(\$5N733 ));
FD21 \$5I732  (.Q0(QI6), .D0(\$5N735 ), .CLK(CLK), .CD(CD));
INV \$5I762  (.ZN0(\~QI6 ), .A0(QI6));
INV \$5I830  (.ZN0(\$5N832 ), .A0(LD));
INV \$5I879  (.ZN0(\$5N883 ), .A0(CS));
INV \$5I956  (.ZN0(\$5N973 ), .A0(DNUP));
AND3 \$5I965  (.Z0(HOLD6), .A0(QI6), .A1(\$5N832 ), .A2(\$5N883 ));
OR5 \$5I985  (.Z0(\$5N733 ), .A0(LOAD6), .A1(\$5N741 ), .A2(\$5N727 ), 
	.A3(\$5N745 ), .A4(\$5N986 ));
AND12 \$5I989  (.Z0(\$5N741 ), .A0(\~QI7 ), .A1(QI5), .A2(QI4), 
	.A3(QI3), .A4(\~QI2 ), .A5(\~QI1 ), .A6(QI0), 
	.A7(\$5N832 ), .A8(EN), .A9(CAI), .A10(\$5N973 ), 
	.A11(\$5N883 ));
AND12 \$5I991  (.Z0(\$5N727 ), .A0(QI7), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$5N832 ), .A8(EN), .A9(CAI), .A10(DNUP), 
	.A11(\$5N883 ));
AND12 \$5I993  (.Z0(\$5N745 ), .A0(QI6), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$5N832 ), .A8(EN), .A9(CAI), .A10(DNUP), 
	.A11(\$5N883 ));
AND6 \$5I995  (.Z0(\$5N986 ), .A0(QI7), .A1(QI6), .A2(\$5N832 ), 
	.A3(EN), .A4(CAI), .A5(\$5N883 ));
AND3 \$6I716  (.Z0(LOAD7), .A0(D7), .A1(LD), .A2(\$6N888 ));
LXOR2 \$6I733  (.Z0(\$6N751 ), .A0(HOLD7), .A1(\$6N749 ));
FD21 \$6I734  (.Q0(QI7), .D0(\$6N751 ), .CLK(CLK), .CD(CD));
INV \$6I769  (.ZN0(\~QI7 ), .A0(QI7));
INV \$6I837  (.ZN0(\$6N840 ), .A0(LD));
INV \$6I867  (.ZN0(\$6N927 ), .A0(DNUP));
INV \$6I887  (.ZN0(\$6N888 ), .A0(CS));
AND3 \$6I913  (.Z0(HOLD7), .A0(QI7), .A1(\$6N840 ), .A2(\$6N888 ));
OR6 \$6I938  (.Z0(\$6N749 ), .A0(LOAD7), .A1(\$6N737 ), .A2(\$6N735 ), 
	.A3(\$6N741 ), .A4(\$6N743 ), .A5(\$6N939 ));
AND12 \$6I942  (.Z0(\$6N737 ), .A0(QI6), .A1(QI5), .A2(QI4), 
	.A3(QI3), .A4(\~QI2 ), .A5(\~QI1 ), .A6(QI0), 
	.A7(\$6N840 ), .A8(EN), .A9(CAI), .A10(\$6N927 ), 
	.A11(\$6N888 ));
AND11 \$6I944  (.Z0(\$6N735 ), .A0(QI7), .A1(QI4), .A2(QI3), 
	.A3(\~QI2 ), .A4(\~QI1 ), .A5(QI0), .A6(\$6N840 ), 
	.A7(EN), .A8(CAI), .A9(\$6N927 ), .A10(\$6N888 ));
AND12 \$6I946  (.Z0(\$6N741 ), .A0(\~QI6 ), .A1(\~QI5 ), .A2(\~QI4 ), 
	.A3(\~QI3 ), .A4(\~QI2 ), .A5(\~QI1 ), .A6(\~QI0 ), 
	.A7(\$6N840 ), .A8(EN), .A9(CAI), .A10(DNUP), 
	.A11(\$6N888 ));
AND6 \$6I948  (.Z0(\$6N743 ), .A0(QI7), .A1(QI6), .A2(\$6N840 ), 
	.A3(EN), .A4(CAI), .A5(\$6N888 ));
AND6 \$6I950  (.Z0(\$6N939 ), .A0(QI7), .A1(QI5), .A2(\$6N840 ), 
	.A3(EN), .A4(CAI), .A5(\$6N888 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:04:56 1994
`timescale 10 ps / 10 ps 
module CGD14(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CLK, PS, LD, EN, 
	CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CD;

AND5 \$1I1014  (.Z0(\$1N1177 ), .A0(QI3), .A1(\~QI2 ), .A2(QI0), 
	.A3(\$1N1230 ), .A4(EN));
OR7 \$1I1129  (.Z0(\$1N524 ), .A0(HOLD0), .A1(LOAD0), .A2(\$1N1010 ), 
	.A3(\$1N530 ), .A4(\$1N1012 ), .A5(\$1N1113 ), .A6(PS));
AND3 \$1I1148  (.Z0(HOLD0), .A0(QI0), .A1(\$1N1230 ), .A2(\$1N1079 ));
AND2 \$1I1149  (.Z0(LOAD0), .A0(D0), .A1(LD));
AND5 \$1I1150  (.Z0(\$1N1010 ), .A0(\~QI3 ), .A1(\~QI2 ), .A2(QI1), 
	.A3(\$1N1230 ), .A4(EN));
AND5 \$1I1151  (.Z0(\$1N530 ), .A0(\~QI3 ), .A1(QI2), .A2(\~QI1 ), 
	.A3(\$1N1230 ), .A4(EN));
AND5 \$1I1152  (.Z0(\$1N1012 ), .A0(QI3), .A1(QI2), .A2(QI1), 
	.A3(\$1N1230 ), .A4(EN));
AND5 \$1I1153  (.Z0(\$1N1113 ), .A0(QI3), .A1(\~QI2 ), .A2(\~QI1 ), 
	.A3(\$1N1230 ), .A4(EN));
AND3 \$1I1157  (.Z0(HOLD1), .A0(QI1), .A1(\$1N1230 ), .A2(\$1N1079 ));
AND2 \$1I1158  (.Z0(LOAD1), .A0(D1), .A1(LD));
AND5 \$1I1161  (.Z0(\$1N1171 ), .A0(\~QI3 ), .A1(QI2), .A2(QI0), 
	.A3(\$1N1230 ), .A4(EN));
OR6 \$1I1170  (.Z0(\$1N536 ), .A0(HOLD1), .A1(LOAD1), .A2(\$1N1173 ), 
	.A3(\$1N1171 ), .A4(\$1N1177 ), .A5(PS));
INV \$1I1241  (.ZN0(\$1N1230 ), .A0(LD));
INV \$1I1242  (.ZN0(\$1N1079 ), .A0(EN));
BUF \$1I1255  (.Z0(Q3), .A0(QI3));
BUF \$1I1256  (.Z0(Q2), .A0(QI2));
BUF \$1I1257  (.Z0(Q1), .A0(QI1));
BUF \$1I1258  (.Z0(Q0), .A0(QI0));
FD21 \$1I361  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK), .CD(CD));
FD21 \$1I495  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK), .CD(CD));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I581  (.ZN0(\~QI0 ), .A0(QI0));
AND4 \$1I917  (.Z0(\$1N1173 ), .A0(QI1), .A1(\~QI0 ), .A2(\$1N1230 ), 
	.A3(EN));
INV \$2I100  (.ZN0(\$2N71 ), .A0(LD));
INV \$2I101  (.ZN0(\$2N66 ), .A0(EN));
OR6 \$2I2  (.Z0(\$2N24 ), .A0(HOLD3), .A1(LOAD3), .A2(\$2N1 ), 
	.A3(\$2N74 ), .A4(\$2N77 ), .A5(PS));
INV \$2I25  (.ZN0(\~QI3 ), .A0(QI3));
AND5 \$2I26  (.Z0(\$2N6 ), .A0(QI3), .A1(QI1), .A2(\~QI0 ), 
	.A3(\$2N71 ), .A4(EN));
AND2 \$2I27  (.Z0(LOAD2), .A0(D2), .A1(LD));
INV \$2I33  (.ZN0(\~QI2 ), .A0(QI2));
AND4 \$2I56  (.Z0(\$2N5 ), .A0(QI2), .A1(\~QI1 ), .A2(\$2N71 ), 
	.A3(EN));
OR6 \$2I59  (.Z0(\$2N60 ), .A0(HOLD2), .A1(LOAD2), .A2(\$2N6 ), 
	.A3(\$2N5 ), .A4(\$2N4 ), .A5(PS));
AND3 \$2I61  (.Z0(HOLD3), .A0(QI3), .A1(\$2N71 ), .A2(\$2N66 ));
AND2 \$2I64  (.Z0(LOAD3), .A0(D3), .A1(LD));
AND5 \$2I67  (.Z0(\$2N1 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$2N71 ), .A4(EN));
AND4 \$2I68  (.Z0(\$2N74 ), .A0(QI3), .A1(QI0), .A2(\$2N71 ), 
	.A3(EN));
AND4 \$2I69  (.Z0(\$2N77 ), .A0(QI3), .A1(QI1), .A2(\$2N71 ), 
	.A3(EN));
AND4 \$2I7  (.Z0(\$2N4 ), .A0(QI2), .A1(QI0), .A2(\$2N71 ), 
	.A3(EN));
AND3 \$2I8  (.Z0(HOLD2), .A0(QI2), .A1(\$2N71 ), .A2(\$2N66 ));
FD21 \$2I86  (.Q0(QI2), .D0(\$2N60 ), .CLK(CLK), .CD(CD));
FD21 \$2I87  (.Q0(QI3), .D0(\$2N24 ), .CLK(CLK), .CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:01 1994
`timescale 10 ps / 10 ps 
module CGD24(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CLK, PS, LD, EN, 
	CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CS;

OR7 \$1I1129  (.Z0(\$1N524 ), .A0(HOLD0), .A1(LOAD0), .A2(\$1N1010 ), 
	.A3(\$1N530 ), .A4(\$1N1253 ), .A5(\$1N1255 ), .A6(PS));
OR6 \$1I1170  (.Z0(\$1N536 ), .A0(HOLD1), .A1(LOAD1), .A2(\$1N1173 ), 
	.A3(\$1N1171 ), .A4(\$1N1177 ), .A5(PS));
INV \$1I1241  (.ZN0(\$1N1230 ), .A0(LD));
INV \$1I1242  (.ZN0(\$1N1079 ), .A0(EN));
AND4 \$1I1249  (.Z0(HOLD0), .A0(QI0), .A1(\$1N1230 ), .A2(\$1N1079 ), 
	.A3(\$1N1265 ));
AND3 \$1I1250  (.Z0(LOAD0), .A0(D0), .A1(LD), .A2(\$1N1265 ));
AND6 \$1I1251  (.Z0(\$1N1010 ), .A0(\~QI3 ), .A1(\~QI2 ), .A2(QI1), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ));
AND6 \$1I1252  (.Z0(\$1N530 ), .A0(\~QI3 ), .A1(QI2), .A2(\~QI1 ), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ));
AND6 \$1I1258  (.Z0(\$1N1253 ), .A0(QI3), .A1(QI2), .A2(QI1), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ));
AND6 \$1I1259  (.Z0(\$1N1255 ), .A0(QI3), .A1(\~QI2 ), .A2(\~QI1 ), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ));
AND4 \$1I1260  (.Z0(HOLD1), .A0(QI1), .A1(\$1N1230 ), .A2(\$1N1079 ), 
	.A3(\$1N1265 ));
AND3 \$1I1261  (.Z0(LOAD1), .A0(D1), .A1(LD), .A2(\$1N1265 ));
AND5 \$1I1262  (.Z0(\$1N1173 ), .A0(QI1), .A1(\~QI0 ), .A2(\$1N1230 ), 
	.A3(EN), .A4(\$1N1265 ));
AND6 \$1I1263  (.Z0(\$1N1171 ), .A0(\~QI3 ), .A1(QI2), .A2(QI0), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ));
AND6 \$1I1264  (.Z0(\$1N1177 ), .A0(QI3), .A1(\~QI2 ), .A2(QI0), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ));
INV \$1I1274  (.ZN0(\$1N1265 ), .A0(CS));
BUF \$1I1290  (.Z0(Q3), .A0(QI3));
BUF \$1I1291  (.Z0(Q2), .A0(QI2));
BUF \$1I1292  (.Z0(Q1), .A0(QI1));
BUF \$1I1293  (.Z0(Q0), .A0(QI0));
FD11 \$1I361  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK));
FD11 \$1I495  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I581  (.ZN0(\~QI0 ), .A0(QI0));
INV \$2I100  (.ZN0(\$2N71 ), .A0(LD));
INV \$2I101  (.ZN0(\$2N66 ), .A0(EN));
AND4 \$2I111  (.Z0(HOLD2), .A0(QI2), .A1(\$2N71 ), .A2(\$2N66 ), 
	.A3(\$2N125 ));
AND3 \$2I112  (.Z0(LOAD2), .A0(D2), .A1(LD), .A2(\$2N125 ));
AND6 \$2I113  (.Z0(\$2N6 ), .A0(QI3), .A1(QI1), .A2(\~QI0 ), 
	.A3(\$2N71 ), .A4(EN), .A5(\$2N125 ));
AND5 \$2I116  (.Z0(\$2N5 ), .A0(QI2), .A1(\~QI1 ), .A2(\$2N71 ), 
	.A3(EN), .A4(\$2N125 ));
AND5 \$2I117  (.Z0(\$2N4 ), .A0(QI2), .A1(QI0), .A2(\$2N71 ), 
	.A3(EN), .A4(\$2N125 ));
AND4 \$2I118  (.Z0(HOLD3), .A0(QI3), .A1(\$2N71 ), .A2(\$2N66 ), 
	.A3(\$2N125 ));
AND3 \$2I119  (.Z0(LOAD3), .A0(D3), .A1(LD), .A2(\$2N125 ));
AND6 \$2I120  (.Z0(\$2N1 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$2N71 ), .A4(EN), .A5(\$2N125 ));
AND5 \$2I123  (.Z0(\$2N74 ), .A0(QI3), .A1(QI0), .A2(\$2N71 ), 
	.A3(EN), .A4(\$2N125 ));
AND5 \$2I124  (.Z0(\$2N77 ), .A0(QI3), .A1(QI1), .A2(\$2N71 ), 
	.A3(EN), .A4(\$2N125 ));
INV \$2I133  (.ZN0(\$2N125 ), .A0(CS));
OR6 \$2I2  (.Z0(\$2N24 ), .A0(HOLD3), .A1(LOAD3), .A2(\$2N1 ), 
	.A3(\$2N74 ), .A4(\$2N77 ), .A5(PS));
INV \$2I25  (.ZN0(\~QI3 ), .A0(QI3));
INV \$2I33  (.ZN0(\~QI2 ), .A0(QI2));
OR6 \$2I59  (.Z0(\$2N60 ), .A0(HOLD2), .A1(LOAD2), .A2(\$2N6 ), 
	.A3(\$2N5 ), .A4(\$2N4 ), .A5(PS));
FD11 \$2I86  (.Q0(QI2), .D0(\$2N60 ), .CLK(CLK));
FD11 \$2I87  (.Q0(QI3), .D0(\$2N24 ), .CLK(CLK));
endmodule
`timescale 10 ps / 10 ps
module CGD34(
	CD, CLK, D0, D1, D2, D3, EN, LD, SD, Q0, Q1, Q2, Q3);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input LD;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



OR5 \$1I1271  (.Z0 (\$1N536 ), .A0 (HOLD1), .A1 (LOAD1), 
	.A2 (\$1N1173 ), .A3 (\$1N1171 ), .A4 (\$1N1177 ));
OR6 \$1I1270  (.Z0 (\$1N524 ), .A0 (HOLD0), .A1 (LOAD0), 
	.A2 (\$1N1010 ), .A3 (\$1N530 ), .A4 (\$1N1012 ), 
	.A5 (\$1N1113 ));
FDE1 \$1I361  (.Q0 (QI0), .D0 (\$1N524 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I495  (.Q0 (QI1), .D0 (\$1N536 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
BUF \$1I1255  (.Z0 (Q3), .A0 (QI3));
BUF \$1I1256  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1257  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1258  (.Z0 (Q0), .A0 (QI0));
AND5 \$1I1150  (.Z0 (\$1N1010 ), .A0 (\~QI3 ), .A1 (\~QI2 ), 
	.A2 (QI1), .A3 (\$1N1230 ), .A4 (EN));
INV \$1I1241  (.ZN0 (\$1N1230 ), .A0 (LD));
AND5 \$1I1014  (.Z0 (\$1N1177 ), .A0 (QI3), .A1 (\~QI2 ), 
	.A2 (QI0), .A3 (\$1N1230 ), .A4 (EN));
AND4 \$1I917  (.Z0 (\$1N1173 ), .A0 (QI1), .A1 (\~QI0 ), 
	.A2 (\$1N1230 ), .A3 (EN));
AND2 \$1I1158  (.Z0 (LOAD1), .A0 (D1), .A1 (LD));
AND2 \$1I1149  (.Z0 (LOAD0), .A0 (D0), .A1 (LD));
INV \$1I580  (.ZN0 (\~QI1 ), .A0 (QI1));
INV \$1I581  (.ZN0 (\~QI0 ), .A0 (QI0));
AND3 \$1I1148  (.Z0 (HOLD0), .A0 (QI0), .A1 (\$1N1230 ), 
	.A2 (\$1N1079 ));
AND5 \$1I1151  (.Z0 (\$1N530 ), .A0 (\~QI3 ), .A1 (QI2), 
	.A2 (\~QI1 ), .A3 (\$1N1230 ), .A4 (EN));
AND5 \$1I1152  (.Z0 (\$1N1012 ), .A0 (QI3), .A1 (QI2), 
	.A2 (QI1), .A3 (\$1N1230 ), .A4 (EN));
AND5 \$1I1153  (.Z0 (\$1N1113 ), .A0 (QI3), .A1 (\~QI2 ), 
	.A2 (\~QI1 ), .A3 (\$1N1230 ), .A4 (EN));
AND3 \$1I1157  (.Z0 (HOLD1), .A0 (QI1), .A1 (\$1N1230 ), 
	.A2 (\$1N1079 ));
AND5 \$1I1161  (.Z0 (\$1N1171 ), .A0 (\~QI3 ), .A1 (QI2), 
	.A2 (QI0), .A3 (\$1N1230 ), .A4 (EN));
INV \$1I1242  (.ZN0 (\$1N1079 ), .A0 (EN));
OR5 \$2I118  (.Z0 (\$2N24 ), .A0 (HOLD3), .A1 (LOAD3), 
	.A2 (\$2N1 ), .A3 (\$2N74 ), .A4 (\$2N77 ));
OR5 \$2I117  (.Z0 (\$2N60 ), .A0 (HOLD2), .A1 (LOAD2), 
	.A2 (\$2N6 ), .A3 (\$2N5 ), .A4 (\$2N4 ));
FDE1 \$2I86  (.Q0 (QI2), .D0 (\$2N60 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$2I87  (.Q0 (QI3), .D0 (\$2N24 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
INV \$2I101  (.ZN0 (\$2N66 ), .A0 (EN));
AND4 \$2I7  (.Z0 (\$2N4 ), .A0 (QI2), .A1 (QI0), 
	.A2 (\$2N71 ), .A3 (EN));
AND3 \$2I8  (.Z0 (HOLD2), .A0 (QI2), .A1 (\$2N71 ), 
	.A2 (\$2N66 ));
INV \$2I25  (.ZN0 (\~QI3 ), .A0 (QI3));
AND5 \$2I26  (.Z0 (\$2N6 ), .A0 (QI3), .A1 (QI1), 
	.A2 (\~QI0 ), .A3 (\$2N71 ), .A4 (EN));
AND2 \$2I27  (.Z0 (LOAD2), .A0 (D2), .A1 (LD));
INV \$2I33  (.ZN0 (\~QI2 ), .A0 (QI2));
AND4 \$2I56  (.Z0 (\$2N5 ), .A0 (QI2), .A1 (\~QI1 ), 
	.A2 (\$2N71 ), .A3 (EN));
AND3 \$2I61  (.Z0 (HOLD3), .A0 (QI3), .A1 (\$2N71 ), 
	.A2 (\$2N66 ));
AND2 \$2I64  (.Z0 (LOAD3), .A0 (D3), .A1 (LD));
AND5 \$2I67  (.Z0 (\$2N1 ), .A0 (\~QI2 ), .A1 (\~QI1 ), 
	.A2 (\~QI0 ), .A3 (\$2N71 ), .A4 (EN));
AND4 \$2I68  (.Z0 (\$2N74 ), .A0 (QI3), .A1 (QI0), 
	.A2 (\$2N71 ), .A3 (EN));
AND4 \$2I69  (.Z0 (\$2N77 ), .A0 (QI3), .A1 (QI1), 
	.A2 (\$2N71 ), .A3 (EN));
INV \$2I100  (.ZN0 (\$2N71 ), .A0 (LD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:04 1994
`timescale 10 ps / 10 ps 
module CGU14(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CLK, PS, LD, EN, 
	CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CD;

AND5 \$1I1014  (.Z0(\$1N1177 ), .A0(QI3), .A1(QI2), .A2(QI0), 
	.A3(\$1N1230 ), .A4(EN));
OR7 \$1I1129  (.Z0(\$1N524 ), .A0(HOLD0), .A1(LOAD0), .A2(\$1N1010 ), 
	.A3(\$1N530 ), .A4(\$1N1012 ), .A5(\$1N1113 ), .A6(PS));
AND3 \$1I1148  (.Z0(HOLD0), .A0(QI0), .A1(\$1N1230 ), .A2(\$1N1079 ));
AND2 \$1I1149  (.Z0(LOAD0), .A0(D0), .A1(LD));
AND5 \$1I1150  (.Z0(\$1N1010 ), .A0(\~QI3 ), .A1(\~QI2 ), .A2(\~QI1 ), 
	.A3(\$1N1230 ), .A4(EN));
AND5 \$1I1151  (.Z0(\$1N530 ), .A0(\~QI3 ), .A1(QI2), .A2(QI1), 
	.A3(\$1N1230 ), .A4(EN));
AND5 \$1I1152  (.Z0(\$1N1012 ), .A0(QI3), .A1(QI2), .A2(\~QI1 ), 
	.A3(\$1N1230 ), .A4(EN));
AND5 \$1I1153  (.Z0(\$1N1113 ), .A0(QI3), .A1(\~QI2 ), .A2(QI1), 
	.A3(\$1N1230 ), .A4(EN));
AND3 \$1I1157  (.Z0(HOLD1), .A0(QI1), .A1(\$1N1230 ), .A2(\$1N1079 ));
AND2 \$1I1158  (.Z0(LOAD1), .A0(D1), .A1(LD));
AND5 \$1I1161  (.Z0(\$1N1171 ), .A0(\~QI3 ), .A1(\~QI2 ), .A2(QI0), 
	.A3(\$1N1230 ), .A4(EN));
OR6 \$1I1170  (.Z0(\$1N536 ), .A0(HOLD1), .A1(LOAD1), .A2(\$1N1173 ), 
	.A3(\$1N1171 ), .A4(\$1N1177 ), .A5(PS));
INV \$1I1241  (.ZN0(\$1N1230 ), .A0(LD));
INV \$1I1242  (.ZN0(\$1N1079 ), .A0(EN));
BUF \$1I1249  (.Z0(Q3), .A0(QI3));
BUF \$1I1250  (.Z0(Q2), .A0(QI2));
BUF \$1I1251  (.Z0(Q1), .A0(QI1));
BUF \$1I1252  (.Z0(Q0), .A0(QI0));
FD21 \$1I361  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK), .CD(CD));
FD21 \$1I495  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK), .CD(CD));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I581  (.ZN0(\~QI0 ), .A0(QI0));
AND4 \$1I917  (.Z0(\$1N1173 ), .A0(QI1), .A1(\~QI0 ), .A2(\$1N1230 ), 
	.A3(EN));
INV \$2I100  (.ZN0(\$2N71 ), .A0(LD));
INV \$2I101  (.ZN0(\$2N66 ), .A0(EN));
OR6 \$2I2  (.Z0(\$2N24 ), .A0(HOLD3), .A1(LOAD3), .A2(\$2N1 ), 
	.A3(\$2N74 ), .A4(\$2N77 ), .A5(PS));
INV \$2I25  (.ZN0(\~QI3 ), .A0(QI3));
AND5 \$2I26  (.Z0(\$2N6 ), .A0(\~QI3 ), .A1(QI1), .A2(\~QI0 ), 
	.A3(\$2N71 ), .A4(EN));
AND2 \$2I27  (.Z0(LOAD2), .A0(D2), .A1(LD));
INV \$2I33  (.ZN0(\~QI2 ), .A0(QI2));
AND4 \$2I56  (.Z0(\$2N5 ), .A0(QI2), .A1(\~QI1 ), .A2(\$2N71 ), 
	.A3(EN));
OR6 \$2I59  (.Z0(\$2N60 ), .A0(HOLD2), .A1(LOAD2), .A2(\$2N6 ), 
	.A3(\$2N5 ), .A4(\$2N4 ), .A5(PS));
AND3 \$2I61  (.Z0(HOLD3), .A0(QI3), .A1(\$2N71 ), .A2(\$2N66 ));
AND2 \$2I64  (.Z0(LOAD3), .A0(D3), .A1(LD));
AND5 \$2I67  (.Z0(\$2N1 ), .A0(QI2), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$2N71 ), .A4(EN));
AND4 \$2I68  (.Z0(\$2N74 ), .A0(QI3), .A1(QI0), .A2(\$2N71 ), 
	.A3(EN));
AND4 \$2I69  (.Z0(\$2N77 ), .A0(QI3), .A1(QI1), .A2(\$2N71 ), 
	.A3(EN));
AND4 \$2I7  (.Z0(\$2N4 ), .A0(QI2), .A1(QI0), .A2(\$2N71 ), 
	.A3(EN));
AND3 \$2I8  (.Z0(HOLD2), .A0(QI2), .A1(\$2N71 ), .A2(\$2N66 ));
FD21 \$2I86  (.Q0(QI2), .D0(\$2N60 ), .CLK(CLK), .CD(CD));
FD21 \$2I87  (.Q0(QI3), .D0(\$2N24 ), .CLK(CLK), .CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:09 1994
`timescale 10 ps / 10 ps 
module CGU24(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CLK, PS, LD, EN, 
	CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CS;

OR7 \$1I1129  (.Z0(\$1N524 ), .A0(HOLD0), .A1(LOAD0), .A2(\$1N1010 ), 
	.A3(\$1N530 ), .A4(\$1N1253 ), .A5(\$1N1255 ), .A6(PS));
OR6 \$1I1170  (.Z0(\$1N536 ), .A0(HOLD1), .A1(LOAD1), .A2(\$1N1173 ), 
	.A3(\$1N1171 ), .A4(\$1N1177 ), .A5(PS));
INV \$1I1241  (.ZN0(\$1N1230 ), .A0(LD));
INV \$1I1242  (.ZN0(\$1N1079 ), .A0(EN));
AND4 \$1I1249  (.Z0(HOLD0), .A0(QI0), .A1(\$1N1230 ), .A2(\$1N1079 ), 
	.A3(\$1N1265 ));
AND3 \$1I1250  (.Z0(LOAD0), .A0(D0), .A1(LD), .A2(\$1N1265 ));
AND6 \$1I1251  (.Z0(\$1N1010 ), .A0(\~QI3 ), .A1(\~QI2 ), .A2(\~QI1 ), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ));
AND6 \$1I1252  (.Z0(\$1N530 ), .A0(\~QI3 ), .A1(QI2), .A2(QI1), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ));
AND6 \$1I1258  (.Z0(\$1N1253 ), .A0(QI3), .A1(QI2), .A2(\~QI1 ), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ));
AND6 \$1I1259  (.Z0(\$1N1255 ), .A0(QI3), .A1(\~QI2 ), .A2(QI1), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ));
AND4 \$1I1260  (.Z0(HOLD1), .A0(QI1), .A1(\$1N1230 ), .A2(\$1N1079 ), 
	.A3(\$1N1265 ));
AND3 \$1I1261  (.Z0(LOAD1), .A0(D1), .A1(LD), .A2(\$1N1265 ));
AND5 \$1I1262  (.Z0(\$1N1173 ), .A0(QI1), .A1(\~QI0 ), .A2(\$1N1230 ), 
	.A3(EN), .A4(\$1N1265 ));
AND6 \$1I1263  (.Z0(\$1N1171 ), .A0(\~QI3 ), .A1(\~QI2 ), .A2(QI0), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ));
AND6 \$1I1264  (.Z0(\$1N1177 ), .A0(QI3), .A1(QI2), .A2(QI0), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ));
INV \$1I1274  (.ZN0(\$1N1265 ), .A0(CS));
BUF \$1I1283  (.Z0(Q3), .A0(QI3));
BUF \$1I1284  (.Z0(Q2), .A0(QI2));
BUF \$1I1285  (.Z0(Q1), .A0(QI1));
BUF \$1I1286  (.Z0(Q0), .A0(QI0));
FD11 \$1I361  (.Q0(QI0), .D0(\$1N524 ), .CLK(CLK));
FD11 \$1I495  (.Q0(QI1), .D0(\$1N536 ), .CLK(CLK));
INV \$1I580  (.ZN0(\~QI1 ), .A0(QI1));
INV \$1I581  (.ZN0(\~QI0 ), .A0(QI0));
INV \$2I100  (.ZN0(\$2N71 ), .A0(LD));
INV \$2I101  (.ZN0(\$2N66 ), .A0(EN));
AND4 \$2I111  (.Z0(HOLD2), .A0(QI2), .A1(\$2N71 ), .A2(\$2N66 ), 
	.A3(\$2N125 ));
AND3 \$2I112  (.Z0(LOAD2), .A0(D2), .A1(LD), .A2(\$2N125 ));
AND6 \$2I113  (.Z0(\$2N6 ), .A0(\~QI3 ), .A1(QI1), .A2(\~QI0 ), 
	.A3(\$2N71 ), .A4(EN), .A5(\$2N125 ));
AND5 \$2I116  (.Z0(\$2N5 ), .A0(QI2), .A1(\~QI1 ), .A2(\$2N71 ), 
	.A3(EN), .A4(\$2N125 ));
AND5 \$2I117  (.Z0(\$2N4 ), .A0(QI2), .A1(QI0), .A2(\$2N71 ), 
	.A3(EN), .A4(\$2N125 ));
AND4 \$2I118  (.Z0(HOLD3), .A0(QI3), .A1(\$2N71 ), .A2(\$2N66 ), 
	.A3(\$2N125 ));
AND3 \$2I119  (.Z0(LOAD3), .A0(D3), .A1(LD), .A2(\$2N125 ));
AND6 \$2I120  (.Z0(\$2N1 ), .A0(QI2), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$2N71 ), .A4(EN), .A5(\$2N125 ));
AND5 \$2I123  (.Z0(\$2N74 ), .A0(QI3), .A1(QI0), .A2(\$2N71 ), 
	.A3(EN), .A4(\$2N125 ));
AND5 \$2I124  (.Z0(\$2N77 ), .A0(QI3), .A1(QI1), .A2(\$2N71 ), 
	.A3(EN), .A4(\$2N125 ));
INV \$2I133  (.ZN0(\$2N125 ), .A0(CS));
OR6 \$2I2  (.Z0(\$2N24 ), .A0(HOLD3), .A1(LOAD3), .A2(\$2N1 ), 
	.A3(\$2N74 ), .A4(\$2N77 ), .A5(PS));
INV \$2I25  (.ZN0(\~QI3 ), .A0(QI3));
INV \$2I33  (.ZN0(\~QI2 ), .A0(QI2));
OR6 \$2I59  (.Z0(\$2N60 ), .A0(HOLD2), .A1(LOAD2), .A2(\$2N6 ), 
	.A3(\$2N5 ), .A4(\$2N4 ), .A5(PS));
FD11 \$2I86  (.Q0(QI2), .D0(\$2N60 ), .CLK(CLK));
FD11 \$2I87  (.Q0(QI3), .D0(\$2N24 ), .CLK(CLK));
endmodule
`timescale 10 ps / 10 ps
module CGU34(
	CD, CLK, D0, D1, D2, D3, EN, LD, SD, Q0, Q1, Q2, Q3);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input LD;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



OR5 \$1I1264  (.Z0 (\$1N536 ), .A0 (HOLD1), .A1 (LOAD1), 
	.A2 (\$1N1173 ), .A3 (\$1N1171 ), .A4 (\$1N1177 ));
FDE1 \$1I361  (.Q0 (QI0), .D0 (\$1N524 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I495  (.Q0 (QI1), .D0 (\$1N536 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
INV \$1I1241  (.ZN0 (\$1N1230 ), .A0 (LD));
AND5 \$1I1014  (.Z0 (\$1N1177 ), .A0 (QI3), .A1 (QI2), 
	.A2 (QI0), .A3 (\$1N1230 ), .A4 (EN));
AND4 \$1I917  (.Z0 (\$1N1173 ), .A0 (QI1), .A1 (\~QI0 ), 
	.A2 (\$1N1230 ), .A3 (EN));
AND2 \$1I1158  (.Z0 (LOAD1), .A0 (D1), .A1 (LD));
AND5 \$1I1150  (.Z0 (\$1N1010 ), .A0 (\~QI3 ), .A1 (\~QI2 ), 
	.A2 (\~QI1 ), .A3 (\$1N1230 ), .A4 (EN));
AND2 \$1I1149  (.Z0 (LOAD0), .A0 (D0), .A1 (LD));
INV \$1I580  (.ZN0 (\~QI1 ), .A0 (QI1));
INV \$1I581  (.ZN0 (\~QI0 ), .A0 (QI0));
AND3 \$1I1148  (.Z0 (HOLD0), .A0 (QI0), .A1 (\$1N1230 ), 
	.A2 (\$1N1079 ));
AND5 \$1I1151  (.Z0 (\$1N530 ), .A0 (\~QI3 ), .A1 (QI2), 
	.A2 (QI1), .A3 (\$1N1230 ), .A4 (EN));
AND5 \$1I1152  (.Z0 (\$1N1012 ), .A0 (QI3), .A1 (QI2), 
	.A2 (\~QI1 ), .A3 (\$1N1230 ), .A4 (EN));
AND5 \$1I1153  (.Z0 (\$1N1113 ), .A0 (QI3), .A1 (\~QI2 ), 
	.A2 (QI1), .A3 (\$1N1230 ), .A4 (EN));
AND3 \$1I1157  (.Z0 (HOLD1), .A0 (QI1), .A1 (\$1N1230 ), 
	.A2 (\$1N1079 ));
AND5 \$1I1161  (.Z0 (\$1N1171 ), .A0 (\~QI3 ), .A1 (\~QI2 ), 
	.A2 (QI0), .A3 (\$1N1230 ), .A4 (EN));
INV \$1I1242  (.ZN0 (\$1N1079 ), .A0 (EN));
BUF \$1I1252  (.Z0 (Q0), .A0 (QI0));
BUF \$1I1251  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1250  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1249  (.Z0 (Q3), .A0 (QI3));
OR6 \$1I1263  (.Z0 (\$1N524 ), .A0 (HOLD0), .A1 (LOAD0), 
	.A2 (\$1N1010 ), .A3 (\$1N530 ), .A4 (\$1N1012 ), 
	.A5 (\$1N1113 ));
OR5 \$2I115  (.Z0 (\$2N24 ), .A0 (HOLD3), .A1 (LOAD3), 
	.A2 (\$2N1 ), .A3 (\$2N74 ), .A4 (\$2N77 ));
FDE1 \$2I86  (.Q0 (QI2), .D0 (\$2N60 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$2I87  (.Q0 (QI3), .D0 (\$2N24 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
INV \$2I101  (.ZN0 (\$2N66 ), .A0 (EN));
AND4 \$2I7  (.Z0 (\$2N4 ), .A0 (QI2), .A1 (QI0), 
	.A2 (\$2N71 ), .A3 (EN));
AND3 \$2I8  (.Z0 (HOLD2), .A0 (QI2), .A1 (\$2N71 ), 
	.A2 (\$2N66 ));
AND5 \$2I26  (.Z0 (\$2N6 ), .A0 (\~QI3 ), .A1 (QI1), 
	.A2 (\~QI0 ), .A3 (\$2N71 ), .A4 (EN));
AND2 \$2I27  (.Z0 (LOAD2), .A0 (D2), .A1 (LD));
INV \$2I33  (.ZN0 (\~QI2 ), .A0 (QI2));
AND4 \$2I56  (.Z0 (\$2N5 ), .A0 (QI2), .A1 (\~QI1 ), 
	.A2 (\$2N71 ), .A3 (EN));
AND3 \$2I61  (.Z0 (HOLD3), .A0 (QI3), .A1 (\$2N71 ), 
	.A2 (\$2N66 ));
AND2 \$2I64  (.Z0 (LOAD3), .A0 (D3), .A1 (LD));
AND5 \$2I67  (.Z0 (\$2N1 ), .A0 (QI2), .A1 (\~QI1 ), 
	.A2 (\~QI0 ), .A3 (\$2N71 ), .A4 (EN));
AND4 \$2I68  (.Z0 (\$2N74 ), .A0 (QI3), .A1 (QI0), 
	.A2 (\$2N71 ), .A3 (EN));
AND4 \$2I69  (.Z0 (\$2N77 ), .A0 (QI3), .A1 (QI1), 
	.A2 (\$2N71 ), .A3 (EN));
INV \$2I100  (.ZN0 (\$2N71 ), .A0 (LD));
INV \$2I25  (.ZN0 (\~QI3 ), .A0 (QI3));
OR5 \$2I116  (.Z0 (\$2N60 ), .A0 (HOLD2), .A1 (LOAD2), 
	.A2 (\$2N6 ), .A3 (\$2N5 ), .A4 (\$2N4 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:13 1994
`timescale 10 ps / 10 ps 
module CGUD4(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CLK, PS, LD, EN, 
	DNUP, CD, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CLK;
	input PS;
	input LD;
	input EN;
	input DNUP;
	input CD;
	input CS;

OR7 \$1I1129  (.Z0(\$1N1347 ), .A0(HOLD0), .A1(LOAD0), .A2(\$1N1010 ), 
	.A3(\$1N530 ), .A4(\$1N1253 ), .A5(\$1N1255 ), .A6(PS));
INV \$1I1242  (.ZN0(\$1N1079 ), .A0(EN));
AND4 \$1I1249  (.Z0(HOLD0), .A0(QI0), .A1(\$1N1230 ), .A2(\$1N1079 ), 
	.A3(\$1N1265 ));
AND3 \$1I1250  (.Z0(LOAD0), .A0(D0), .A1(LD), .A2(\$1N1265 ));
AND7 \$1I1292  (.Z0(\$1N1010 ), .A0(\~QI3 ), .A1(\~QI2 ), .A2(\~QI1 ), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ), .A6(\$1N1354 ));
AND7 \$1I1293  (.Z0(\$1N530 ), .A0(\~QI3 ), .A1(QI2), .A2(QI1), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ), .A6(\$1N1354 ));
AND7 \$1I1294  (.Z0(\$1N1253 ), .A0(QI3), .A1(QI2), .A2(\~QI1 ), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ), .A6(\$1N1354 ));
AND7 \$1I1295  (.Z0(\$1N1255 ), .A0(QI3), .A1(\~QI2 ), .A2(QI1), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ), .A6(\$1N1354 ));
INV \$1I1322  (.ZN0(\$1N1230 ), .A0(LD));
INV \$1I1326  (.ZN0(\$1N1265 ), .A0(CS));
AND7 \$1I1333  (.Z0(\$1N1344 ), .A0(\~QI3 ), .A1(\~QI2 ), .A2(QI1), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ), .A6(DNUP));
AND7 \$1I1334  (.Z0(\$1N1340 ), .A0(\~QI3 ), .A1(QI2), .A2(\~QI1 ), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ), .A6(DNUP));
AND7 \$1I1335  (.Z0(\$1N1338 ), .A0(QI3), .A1(QI2), .A2(QI1), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ), .A6(DNUP));
AND7 \$1I1336  (.Z0(\$1N1342 ), .A0(QI3), .A1(\~QI2 ), .A2(\~QI1 ), 
	.A3(\$1N1230 ), .A4(EN), .A5(\$1N1265 ), .A6(DNUP));
OR4 \$1I1337  (.Z0(\$1N1349 ), .A0(\$1N1344 ), .A1(\$1N1340 ), .A2(\$1N1338 ), 
	.A3(\$1N1342 ));
OR2 \$1I1346  (.Z0(\$1N1352 ), .A0(\$1N1347 ), .A1(\$1N1349 ));
INV \$1I1358  (.ZN0(\$1N1354 ), .A0(DNUP));
BUF \$1I1369  (.Z0(Q3), .A0(QI3));
BUF \$1I1370  (.Z0(Q2), .A0(QI2));
BUF \$1I1371  (.Z0(Q1), .A0(QI1));
BUF \$1I1372  (.Z0(Q0), .A0(QI0));
FD21 \$1I361  (.Q0(QI0), .D0(\$1N1352 ), .CLK(CLK), .CD(CD));
INV \$1I581  (.ZN0(\~QI0 ), .A0(QI0));
INV \$2I101  (.ZN0(\$2N99 ), .A0(DNUP));
FD21 \$2I11  (.Q0(QI1), .D0(\$2N97 ), .CLK(CLK), .CD(CD));
INV \$2I2  (.ZN0(\~QI1 ), .A0(QI1));
AND5 \$2I22  (.Z0(\$2N21 ), .A0(QI1), .A1(\~QI0 ), .A2(\$2N17 ), 
	.A3(EN), .A4(\$2N8 ));
AND4 \$2I24  (.Z0(HOLD1), .A0(QI1), .A1(\$2N17 ), .A2(\$2N9 ), 
	.A3(\$2N8 ));
INV \$2I34  (.ZN0(\$2N9 ), .A0(EN));
AND3 \$2I52  (.Z0(LOAD1), .A0(D1), .A1(LD), .A2(\$2N8 ));
INV \$2I60  (.ZN0(\$2N8 ), .A0(CS));
INV \$2I61  (.ZN0(\$2N17 ), .A0(LD));
AND7 \$2I74  (.Z0(\$2N20 ), .A0(\~QI3 ), .A1(\~QI2 ), .A2(QI0), 
	.A3(\$2N17 ), .A4(EN), .A5(\$2N8 ), .A6(\$2N99 ));
AND7 \$2I75  (.Z0(\$2N86 ), .A0(QI3), .A1(QI2), .A2(QI0), 
	.A3(\$2N17 ), .A4(EN), .A5(\$2N8 ), .A6(\$2N99 ));
OR4 \$2I77  (.Z0(\$2N93 ), .A0(HOLD1), .A1(LOAD1), .A2(PS), 
	.A3(\$2N21 ));
AND7 \$2I81  (.Z0(\$2N87 ), .A0(\~QI3 ), .A1(QI2), .A2(QI0), 
	.A3(\$2N17 ), .A4(EN), .A5(\$2N8 ), .A6(DNUP));
AND7 \$2I82  (.Z0(\$2N89 ), .A0(QI3), .A1(\~QI2 ), .A2(QI0), 
	.A3(\$2N17 ), .A4(EN), .A5(\$2N8 ), .A6(DNUP));
OR4 \$2I84  (.Z0(\$2N95 ), .A0(\$2N20 ), .A1(\$2N86 ), .A2(\$2N87 ), 
	.A3(\$2N89 ));
OR2 \$2I92  (.Z0(\$2N97 ), .A0(\$2N93 ), .A1(\$2N95 ));
INV \$3I101  (.ZN0(\$3N66 ), .A0(EN));
AND4 \$3I111  (.Z0(HOLD2), .A0(QI2), .A1(\$3N71 ), .A2(\$3N66 ), 
	.A3(\$3N125 ));
AND3 \$3I112  (.Z0(LOAD2), .A0(D2), .A1(LD), .A2(\$3N125 ));
AND5 \$3I116  (.Z0(\$3N5 ), .A0(QI2), .A1(\~QI1 ), .A2(\$3N71 ), 
	.A3(EN), .A4(\$3N125 ));
AND5 \$3I117  (.Z0(\$3N4 ), .A0(QI2), .A1(QI0), .A2(\$3N71 ), 
	.A3(EN), .A4(\$3N125 ));
OR7 \$3I141  (.Z0(\$3N60 ), .A0(HOLD2), .A1(LOAD2), .A2(\$3N6 ), 
	.A3(\$3N147 ), .A4(\$3N5 ), .A5(\$3N4 ), .A6(PS));
AND7 \$3I142  (.Z0(\$3N6 ), .A0(\~QI3 ), .A1(QI1), .A2(\~QI0 ), 
	.A3(\$3N71 ), .A4(EN), .A5(\$3N125 ), .A6(\$3N150 ));
AND7 \$3I146  (.Z0(\$3N147 ), .A0(QI3), .A1(QI1), .A2(\~QI0 ), 
	.A3(\$3N71 ), .A4(EN), .A5(\$3N125 ), .A6(DNUP));
AND4 \$3I158  (.Z0(HOLD3), .A0(QI3), .A1(\$3N71 ), .A2(\$3N66 ), 
	.A3(\$3N125 ));
AND7 \$3I159  (.Z0(\$3N190 ), .A0(\~QI2 ), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$3N71 ), .A4(EN), .A5(\$3N125 ), .A6(DNUP));
INV \$3I169  (.ZN0(\$3N125 ), .A0(CS));
OR7 \$3I173  (.Z0(\$3N182 ), .A0(HOLD3), .A1(LOAD3), .A2(\$3N175 ), 
	.A3(\$3N190 ), .A4(\$3N172 ), .A5(\$3N171 ), .A6(PS));
AND7 \$3I174  (.Z0(\$3N175 ), .A0(QI2), .A1(\~QI1 ), .A2(\~QI0 ), 
	.A3(\$3N71 ), .A4(EN), .A5(\$3N125 ), .A6(\$3N150 ));
AND5 \$3I176  (.Z0(\$3N172 ), .A0(QI3), .A1(QI0), .A2(\$3N71 ), 
	.A3(EN), .A4(\$3N125 ));
INV \$3I177  (.ZN0(\$3N71 ), .A0(LD));
AND5 \$3I179  (.Z0(\$3N171 ), .A0(QI3), .A1(QI1), .A2(\$3N71 ), 
	.A3(EN), .A4(\$3N125 ));
AND3 \$3I180  (.Z0(LOAD3), .A0(D3), .A1(LD), .A2(\$3N125 ));
INV \$3I181  (.ZN0(\~QI3 ), .A0(QI3));
FD21 \$3I192  (.Q0(QI3), .D0(\$3N182 ), .CLK(CLK), .CD(CD));
INV \$3I205  (.ZN0(\$3N150 ), .A0(DNUP));
INV \$3I33  (.ZN0(\~QI2 ), .A0(QI2));
FD21 \$3I86  (.Q0(QI2), .D0(\$3N60 ), .CLK(CLK), .CD(CD));
endmodule
`timescale 10 ps / 10 ps
module CGUD4S(
	CD, CLK, CS, D0, D1, D2, D3, DNUP, EN, LD, SD, Q0, Q1, Q2, Q3);


	input CD;
	input CLK;
	input CS;
	input D0;
	input D1;
	input D2;
	input D3;
	input DNUP;
	input EN;
	input LD;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



OR6 \$1I1383  (.Z0 (\$1N1347 ), .A0 (HOLD0), .A1 (LOAD0), 
	.A2 (\$1N1010 ), .A3 (\$1N530 ), .A4 (\$1N1253 ), 
	.A5 (\$1N1255 ));
FDE1 \$1I361  (.Q0 (QI0), .D0 (\$1N1352 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
INV \$1I1326  (.ZN0 (\$1N1265 ), .A0 (CS));
OR2 \$1I1346  (.Z0 (\$1N1352 ), .A0 (\$1N1347 ), .A1 (\$1N1349 ));
OR4 \$1I1337  (.Z0 (\$1N1349 ), .A0 (\$1N1344 ), .A1 (\$1N1340 ), 
	.A2 (\$1N1338 ), .A3 (\$1N1342 ));
INV \$1I1322  (.ZN0 (\$1N1230 ), .A0 (LD));
INV \$1I1242  (.ZN0 (\$1N1079 ), .A0 (EN));
AND7 \$1I1294  (.Z0 (\$1N1253 ), .A0 (QI3), .A1 (QI2), 
	.A2 (\~QI1 ), .A3 (\$1N1230 ), .A4 (EN), 
	.A5 (\$1N1265 ), .A6 (\$1N1354 ));
AND7 \$1I1293  (.Z0 (\$1N530 ), .A0 (\~QI3 ), .A1 (QI2), 
	.A2 (QI1), .A3 (\$1N1230 ), .A4 (EN), 
	.A5 (\$1N1265 ), .A6 (\$1N1354 ));
AND7 \$1I1292  (.Z0 (\$1N1010 ), .A0 (\~QI3 ), .A1 (\~QI2 ), 
	.A2 (\~QI1 ), .A3 (\$1N1230 ), .A4 (EN), 
	.A5 (\$1N1265 ), .A6 (\$1N1354 ));
AND3 \$1I1250  (.Z0 (LOAD0), .A0 (D0), .A1 (LD), 
	.A2 (\$1N1265 ));
AND4 \$1I1249  (.Z0 (HOLD0), .A0 (QI0), .A1 (\$1N1230 ), 
	.A2 (\$1N1079 ), .A3 (\$1N1265 ));
AND7 \$1I1333  (.Z0 (\$1N1344 ), .A0 (\~QI3 ), .A1 (\~QI2 ), 
	.A2 (QI1), .A3 (\$1N1230 ), .A4 (EN), 
	.A5 (\$1N1265 ), .A6 (DNUP));
AND7 \$1I1334  (.Z0 (\$1N1340 ), .A0 (\~QI3 ), .A1 (QI2), 
	.A2 (\~QI1 ), .A3 (\$1N1230 ), .A4 (EN), 
	.A5 (\$1N1265 ), .A6 (DNUP));
AND7 \$1I1335  (.Z0 (\$1N1338 ), .A0 (QI3), .A1 (QI2), 
	.A2 (QI1), .A3 (\$1N1230 ), .A4 (EN), 
	.A5 (\$1N1265 ), .A6 (DNUP));
AND7 \$1I1336  (.Z0 (\$1N1342 ), .A0 (QI3), .A1 (\~QI2 ), 
	.A2 (\~QI1 ), .A3 (\$1N1230 ), .A4 (EN), 
	.A5 (\$1N1265 ), .A6 (DNUP));
INV \$1I581  (.ZN0 (\~QI0 ), .A0 (QI0));
INV \$1I1358  (.ZN0 (\$1N1354 ), .A0 (DNUP));
BUF \$1I1372  (.Z0 (Q0), .A0 (QI0));
BUF \$1I1371  (.Z0 (Q1), .A0 (QI1));
BUF \$1I1370  (.Z0 (Q2), .A0 (QI2));
BUF \$1I1369  (.Z0 (Q3), .A0 (QI3));
AND7 \$1I1295  (.Z0 (\$1N1255 ), .A0 (QI3), .A1 (\~QI2 ), 
	.A2 (QI1), .A3 (\$1N1230 ), .A4 (EN), 
	.A5 (\$1N1265 ), .A6 (\$1N1354 ));
FDE1 \$2I11  (.Q0 (QI1), .D0 (\$2N97 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
AND7 \$2I82  (.Z0 (\$2N89 ), .A0 (QI3), .A1 (\~QI2 ), 
	.A2 (QI0), .A3 (\$2N17 ), .A4 (EN), 
	.A5 (\$2N8 ), .A6 (DNUP));
INV \$2I101  (.ZN0 (\$2N99 ), .A0 (DNUP));
OR2 \$2I92  (.Z0 (\$2N97 ), .A0 (\$2N93 ), .A1 (\$2N95 ));
OR4 \$2I84  (.Z0 (\$2N95 ), .A0 (\$2N20 ), .A1 (\$2N86 ), 
	.A2 (\$2N87 ), .A3 (\$2N89 ));
INV \$2I60  (.ZN0 (\$2N8 ), .A0 (CS));
INV \$2I61  (.ZN0 (\$2N17 ), .A0 (LD));
AND7 \$2I75  (.Z0 (\$2N86 ), .A0 (QI3), .A1 (QI2), 
	.A2 (QI0), .A3 (\$2N17 ), .A4 (EN), 
	.A5 (\$2N8 ), .A6 (\$2N99 ));
AND5 \$2I22  (.Z0 (\$2N21 ), .A0 (QI1), .A1 (\~QI0 ), 
	.A2 (\$2N17 ), .A3 (EN), .A4 (\$2N8 ));
AND7 \$2I74  (.Z0 (\$2N20 ), .A0 (\~QI3 ), .A1 (\~QI2 ), 
	.A2 (QI0), .A3 (\$2N17 ), .A4 (EN), 
	.A5 (\$2N8 ), .A6 (\$2N99 ));
INV \$2I34  (.ZN0 (\$2N9 ), .A0 (EN));
AND3 \$2I52  (.Z0 (LOAD1), .A0 (D1), .A1 (LD), 
	.A2 (\$2N8 ));
AND4 \$2I24  (.Z0 (HOLD1), .A0 (QI1), .A1 (\$2N17 ), 
	.A2 (\$2N9 ), .A3 (\$2N8 ));
INV \$2I2  (.ZN0 (\~QI1 ), .A0 (QI1));
AND7 \$2I81  (.Z0 (\$2N87 ), .A0 (\~QI3 ), .A1 (QI2), 
	.A2 (QI0), .A3 (\$2N17 ), .A4 (EN), 
	.A5 (\$2N8 ), .A6 (DNUP));
OR3 \$2I110  (.Z0 (\$2N93 ), .A0 (HOLD1), .A1 (LOAD1), 
	.A2 (\$2N21 ));
OR6 \$3I213  (.Z0 (\$3N60 ), .A0 (HOLD2), .A1 (LOAD2), 
	.A2 (\$3N6 ), .A3 (\$3N147 ), .A4 (\$3N5 ), 
	.A5 (\$3N4 ));
FDE1 \$3I86  (.Q0 (QI2), .D0 (\$3N60 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$3I192  (.Q0 (QI3), .D0 (\$3N182 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
INV \$3I169  (.ZN0 (\$3N125 ), .A0 (CS));
INV \$3I177  (.ZN0 (\$3N71 ), .A0 (LD));
INV \$3I101  (.ZN0 (\$3N66 ), .A0 (EN));
AND5 \$3I179  (.Z0 (\$3N171 ), .A0 (QI3), .A1 (QI1), 
	.A2 (\$3N71 ), .A3 (EN), .A4 (\$3N125 ));
AND5 \$3I176  (.Z0 (\$3N172 ), .A0 (QI3), .A1 (QI0), 
	.A2 (\$3N71 ), .A3 (EN), .A4 (\$3N125 ));
AND4 \$3I111  (.Z0 (HOLD2), .A0 (QI2), .A1 (\$3N71 ), 
	.A2 (\$3N66 ), .A3 (\$3N125 ));
AND7 \$3I142  (.Z0 (\$3N6 ), .A0 (\~QI3 ), .A1 (QI1), 
	.A2 (\~QI0 ), .A3 (\$3N71 ), .A4 (EN), 
	.A5 (\$3N125 ), .A6 (\$3N150 ));
AND5 \$3I116  (.Z0 (\$3N5 ), .A0 (QI2), .A1 (\~QI1 ), 
	.A2 (\$3N71 ), .A3 (EN), .A4 (\$3N125 ));
AND5 \$3I117  (.Z0 (\$3N4 ), .A0 (QI2), .A1 (QI0), 
	.A2 (\$3N71 ), .A3 (EN), .A4 (\$3N125 ));
AND3 \$3I112  (.Z0 (LOAD2), .A0 (D2), .A1 (LD), 
	.A2 (\$3N125 ));
INV \$3I33  (.ZN0 (\~QI2 ), .A0 (QI2));
INV \$3I181  (.ZN0 (\~QI3 ), .A0 (QI3));
AND3 \$3I180  (.Z0 (LOAD3), .A0 (D3), .A1 (LD), 
	.A2 (\$3N125 ));
AND7 \$3I174  (.Z0 (\$3N175 ), .A0 (QI2), .A1 (\~QI1 ), 
	.A2 (\~QI0 ), .A3 (\$3N71 ), .A4 (EN), 
	.A5 (\$3N125 ), .A6 (\$3N150 ));
AND7 \$3I159  (.Z0 (\$3N190 ), .A0 (\~QI2 ), .A1 (\~QI1 ), 
	.A2 (\~QI0 ), .A3 (\$3N71 ), .A4 (EN), 
	.A5 (\$3N125 ), .A6 (DNUP));
AND4 \$3I158  (.Z0 (HOLD3), .A0 (QI3), .A1 (\$3N71 ), 
	.A2 (\$3N66 ), .A3 (\$3N125 ));
INV \$3I205  (.ZN0 (\$3N150 ), .A0 (DNUP));
OR6 \$3I212  (.Z0 (\$3N182 ), .A0 (HOLD3), .A1 (LOAD3), 
	.A2 (\$3N175 ), .A3 (\$3N190 ), .A4 (\$3N172 ), 
	.A5 (\$3N171 ));
AND7 \$3I146  (.Z0 (\$3N147 ), .A0 (QI3), .A1 (QI1), 
	.A2 (\~QI0 ), .A3 (\$3N71 ), .A4 (EN), 
	.A5 (\$3N125 ), .A6 (DNUP));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:16 1994
`timescale 10 ps / 10 ps 
module CMP2(
	EQ, A0, A1, B0, 
	B1);

	output EQ;
	input A0;
	input A1;
	input B0;
	input B1;

AND2 \$1I19  (.Z0(\$1N28 ), .A0(\$1N92 ), .A1(B1));
AND2 \$1I20  (.Z0(\$1N26 ), .A0(A1), .A1(\$1N78 ));
AND2 \$1I21  (.Z0(\$1N24 ), .A0(\$1N90 ), .A1(B0));
AND2 \$1I22  (.Z0(\$1N30 ), .A0(A0), .A1(\$1N71 ));
NOR4 \$1I23  (.ZN0(EQ), .A0(\$1N30 ), .A1(\$1N24 ), .A2(\$1N26 ), 
	.A3(\$1N28 ));
INV \$1I70  (.ZN0(\$1N71 ), .A0(B0));
INV \$1I74  (.ZN0(\$1N78 ), .A0(B1));
INV \$1I86  (.ZN0(\$1N90 ), .A0(A0));
INV \$1I87  (.ZN0(\$1N92 ), .A0(A1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:18 1994
`timescale 10 ps / 10 ps 
module CMP4(
	EQ, A0, A1, A2, 
	A3, B0, B1, B2, 
	B3);

	output EQ;
	input A0;
	input A1;
	input A2;
	input A3;
	input B0;
	input B1;
	input B2;
	input B3;

AND2 \$1I100  (.Z0(\$1N117 ), .A0(A2), .A1(\$1N110 ));
AND2 \$1I101  (.Z0(\$1N119 ), .A0(\$1N95 ), .A1(B2));
INV \$1I104  (.ZN0(\$1N110 ), .A0(B2));
AND2 \$1I106  (.Z0(\$1N123 ), .A0(\$1N96 ), .A1(B3));
INV \$1I112  (.ZN0(\$1N95 ), .A0(A2));
INV \$1I113  (.ZN0(\$1N96 ), .A0(A3));
NOR8 \$1I114  (.ZN0(EQ), .A0(\$1N30 ), .A1(\$1N24 ), .A2(\$1N26 ), 
	.A3(\$1N28 ), .A4(\$1N117 ), .A5(\$1N119 ), .A6(\$1N121 ), 
	.A7(\$1N123 ));
AND2 \$1I19  (.Z0(\$1N28 ), .A0(\$1N92 ), .A1(B1));
AND2 \$1I20  (.Z0(\$1N26 ), .A0(A1), .A1(\$1N78 ));
AND2 \$1I21  (.Z0(\$1N24 ), .A0(\$1N90 ), .A1(B0));
AND2 \$1I22  (.Z0(\$1N30 ), .A0(A0), .A1(\$1N71 ));
INV \$1I70  (.ZN0(\$1N71 ), .A0(B0));
INV \$1I74  (.ZN0(\$1N78 ), .A0(B1));
INV \$1I86  (.ZN0(\$1N90 ), .A0(A0));
INV \$1I87  (.ZN0(\$1N92 ), .A0(A1));
AND2 \$1I94  (.Z0(\$1N121 ), .A0(A3), .A1(\$1N111 ));
INV \$1I99  (.ZN0(\$1N111 ), .A0(B3));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:21 1994
`timescale 10 ps / 10 ps 
module CMP8(
	EQ, A0, A1, A2, 
	A3, A4, A5, A6, 
	A7, B0, B1, B2, 
	B3, B4, B5, B6, 
	B7);

	output EQ;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input B0;
	input B1;
	input B2;
	input B3;
	input B4;
	input B5;
	input B6;
	input B7;

AND2 \$1I100  (.Z0(\$1N202 ), .A0(A2), .A1(\$1N110 ));
AND2 \$1I101  (.Z0(\$1N200 ), .A0(\$1N95 ), .A1(B2));
INV \$1I104  (.ZN0(\$1N110 ), .A0(B2));
AND2 \$1I106  (.Z0(\$1N184 ), .A0(\$1N96 ), .A1(B3));
INV \$1I112  (.ZN0(\$1N95 ), .A0(A2));
INV \$1I113  (.ZN0(\$1N96 ), .A0(A3));
AND2 \$1I135  (.Z0(\$1N190 ), .A0(A5), .A1(\$1N152 ));
INV \$1I140  (.ZN0(\$1N152 ), .A0(B5));
AND2 \$1I141  (.Z0(\$1N183 ), .A0(A4), .A1(\$1N151 ));
AND2 \$1I142  (.Z0(\$1N188 ), .A0(\$1N136 ), .A1(B4));
INV \$1I145  (.ZN0(\$1N151 ), .A0(B4));
AND2 \$1I147  (.Z0(\$1N192 ), .A0(\$1N137 ), .A1(B5));
INV \$1I153  (.ZN0(\$1N136 ), .A0(A4));
INV \$1I154  (.ZN0(\$1N137 ), .A0(A5));
INV \$1I155  (.ZN0(\$1N172 ), .A0(A7));
INV \$1I156  (.ZN0(\$1N173 ), .A0(A6));
AND2 \$1I162  (.Z0(\$1N195 ), .A0(\$1N172 ), .A1(B7));
INV \$1I164  (.ZN0(\$1N158 ), .A0(B6));
AND2 \$1I167  (.Z0(\$1N177 ), .A0(\$1N173 ), .A1(B6));
AND2 \$1I168  (.Z0(\$1N176 ), .A0(A6), .A1(\$1N158 ));
INV \$1I169  (.ZN0(\$1N157 ), .A0(B7));
AND2 \$1I174  (.Z0(\$1N196 ), .A0(A7), .A1(\$1N157 ));
NOR16 \$1I180  (.ZN0(EQ), .A0(\$1N30 ), .A1(\$1N24 ), .A2(\$1N26 ), 
	.A3(\$1N28 ), .A4(\$1N202 ), .A5(\$1N200 ), .A6(\$1N187 ), 
	.A7(\$1N184 ), .A8(\$1N183 ), .A9(\$1N188 ), .A10(\$1N190 ), 
	.A11(\$1N192 ), .A12(\$1N176 ), .A13(\$1N177 ), .A14(\$1N196 ), 
	.A15(\$1N195 ));
AND2 \$1I19  (.Z0(\$1N28 ), .A0(\$1N92 ), .A1(B1));
AND2 \$1I20  (.Z0(\$1N26 ), .A0(A1), .A1(\$1N78 ));
AND2 \$1I21  (.Z0(\$1N24 ), .A0(\$1N90 ), .A1(B0));
AND2 \$1I22  (.Z0(\$1N30 ), .A0(A0), .A1(\$1N71 ));
INV \$1I70  (.ZN0(\$1N71 ), .A0(B0));
INV \$1I74  (.ZN0(\$1N78 ), .A0(B1));
INV \$1I86  (.ZN0(\$1N90 ), .A0(A0));
INV \$1I87  (.ZN0(\$1N92 ), .A0(A1));
AND2 \$1I94  (.Z0(\$1N187 ), .A0(A3), .A1(\$1N111 ));
INV \$1I99  (.ZN0(\$1N111 ), .A0(B3));
endmodule

`timescale 100ps/10ps
primitive D_LATCH (Q, D, G, RB);


    output Q; 
    reg    Q;                               
    input  D,
           G,                                       // Gate- active high
           RB;                                      // Clear-active low

    table
     //  D      G     RB       : Qt  :   Qt+1

         ?      0      1       :  ?  :    -   ;     // latch state 

         0      1      1       :  ?  :    0   ;     // latch data
         1      1      1       :  ?  :    1   ;            

         1      x      1       :  1  :    1   ;     // Reducing pessimism.
         0      x      1       :  0  :    0   ;     // Reducing pessimism
       
         ?      n      1       :  ?  :    -   ; 

         ?      ?      0       :  ?  :    0   ;      // Clear

         0      1      x       :  ?  :    0   ;      // Reducing pessimism.
         0      ?      x       :  0  :    0   ;      // Reducing pessimism.
         
         ?      0      x       :  0  :    0   ;      // Reducing pessimism 
   
      endtable

endprimitive


`timescale 100ps/10ps
primitive D_LATCH3 (Q, D, G, SB);


    output Q; 
    reg    Q;                               
    input  D,
           G,                                       // Gate- active high
           SB;                                      // Clear-active low

    table
     //  D      G     SB       : Qt  :   Qt+1

         ?      0      1       :  ?  :    -   ;     // latch state 

         0      1      1       :  ?  :    0   ;     // latch data
         1      1      1       :  ?  :    1   ;            

         1      x      1       :  1  :    1   ;     // Reducing pessimism.
         0      x      1       :  0  :    0   ;     // Reducing pessimism
       
         ?      n      1       :  ?  :    -   ; 

         ?      ?      0       :  ?  :    1   ;      // Set

         1      1      x       :  ?  :    1   ;      // Reducing pessimism.
         1      ?      x       :  1  :    1   ;      // Reducing pessimism.
         
         ?      0      x       :  1  :    1   ;      // Reducing pessimism 
   
      endtable

endprimitive


`timescale 100ps/10ps
primitive D_LATCH4 (Q, D, G, RB, SB);


    output Q; 
    reg    Q;                               
    input  D,
           G,                                       // Gate- active high
           RB,                                      // Clear-active low
           SB;                                      // Set-active low
    table
     //  D      G     RB     SB      : Qt  :   Qt+1

         ?      0      1      1      :  ?  :    -   ;     // latch state 

         0      1      1      1      :  ?  :    0   ;     // latch data
         1      1      1      1      :  ?  :    1   ;            

         1      x      1      1      :  1  :    1   ;     // Reducing pessimism.
         0      x      1      1      :  0  :    0   ;     // Reducing pessimism
       
         ?      n      1      1      :  ?  :    -   ;     // ignore negative edges on g

         ?      ?      0      ?      :  ?  :    0   ;      // Clear over set
         ?      ?      1      0      :  ?  :    1   ;      // Set

         0      1      x      1      :  ?  :    0   ;      // Reducing pessimism.
         0      ?      x      1      :  0  :    0   ;      // Reducing pessimism.
         1      1      1      x      :  ?  :    1   ;      // Reducing pessimism.
         1      ?      1      x      :  1  :    1   ;      // Reducing pessimism.
         
         ?      0      x      1      :  0  :    0   ;      // Reducing pessimism 
         ?      0      1      x      :  1  :    1   ;      // Reducing pessimism
   
      endtable

endprimitive

// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:23 1994
`timescale 10 ps / 10 ps 
module DEC2(
	Z0, Z1, S0);

	output Z0;
	output Z1;
	input S0;

INV \$1I1  (.ZN0(Z0), .A0(S0));
BUF \$1I13  (.Z0(Z1), .A0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:24 1994
`timescale 10 ps / 10 ps 
module DEC2E(
	Z0, Z1, EN, S0);

	output Z0;
	output Z1;
	input EN;
	input S0;

AND2 \$1I1  (.Z0(Z0), .A0(EN), .A1(\$1N14 ));
INV \$1I13  (.ZN0(\$1N14 ), .A0(S0));
AND2 \$1I5  (.Z0(Z1), .A0(EN), .A1(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:26 1994
`timescale 10 ps / 10 ps 
module DEC3(
	Z0, Z1, Z2, S0, 
	S1);

	output Z0;
	output Z1;
	output Z2;
	input S0;
	input S1;

AND2 \$1I2  (.Z0(Z0), .A0(\$1N9 ), .A1(\$1N7 ));
INV \$1I26  (.ZN0(\$1N7 ), .A0(S1));
AND2 \$1I3  (.Z0(Z1), .A0(S0), .A1(\$1N7 ));
AND2 \$1I4  (.Z0(Z2), .A0(\$1N9 ), .A1(S1));
INV \$1I5  (.ZN0(\$1N9 ), .A0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:28 1994
`timescale 10 ps / 10 ps 
module DEC3E(
	Z0, Z1, Z2, EN, 
	S0, S1);

	output Z0;
	output Z1;
	output Z2;
	input EN;
	input S0;
	input S1;

AND3 \$1I2  (.Z0(Z0), .A0(EN), .A1(\$1N9 ), .A2(\$1N7 ));
AND3 \$1I3  (.Z0(Z1), .A0(EN), .A1(S0), .A2(\$1N7 ));
INV \$1I31  (.ZN0(\$1N7 ), .A0(S1));
AND3 \$1I4  (.Z0(Z2), .A0(EN), .A1(\$1N9 ), .A2(S1));
INV \$1I5  (.ZN0(\$1N9 ), .A0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:30 1994
`timescale 10 ps / 10 ps 
module DEC4(
	Z0, Z1, Z2, Z3, 
	S0, S1);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input S0;
	input S1;

AND2 \$1I2  (.Z0(Z0), .A0(\$1N9 ), .A1(\$1N7 ));
AND2 \$1I24  (.Z0(Z3), .A0(S0), .A1(S1));
AND2 \$1I3  (.Z0(Z1), .A0(S0), .A1(\$1N7 ));
INV \$1I33  (.ZN0(\$1N7 ), .A0(S1));
AND2 \$1I4  (.Z0(Z2), .A0(\$1N9 ), .A1(S1));
INV \$1I5  (.ZN0(\$1N9 ), .A0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:32 1994
`timescale 10 ps / 10 ps 
module DEC4E(
	Z0, Z1, Z2, Z3, 
	EN, S0, S1);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input EN;
	input S0;
	input S1;

AND3 \$1I2  (.Z0(Z0), .A0(EN), .A1(\$1N9 ), .A2(\$1N7 ));
AND3 \$1I24  (.Z0(Z3), .A0(EN), .A1(S0), .A2(S1));
AND3 \$1I3  (.Z0(Z1), .A0(EN), .A1(S0), .A2(\$1N7 ));
INV \$1I39  (.ZN0(\$1N7 ), .A0(S1));
AND3 \$1I4  (.Z0(Z2), .A0(EN), .A1(\$1N9 ), .A2(S1));
INV \$1I5  (.ZN0(\$1N9 ), .A0(S0));
endmodule

  `timescale 10 ps / 10 ps
  primitive DFF_FD (Q, D, CP, R);



    output Q;  
    input  D, CP, R;
    reg    Q; 
    

    table
 
    //  D   CP      R   :   Qt  :   Qt+1

        1   (01)    0   :   ?   :   1;  // clocked data
        0   (01)    0   :   ?   :   0;

        0   (01)    x   :   ?   :   0;  // pessimism
        0    ?      x   :   0   :   0;  // pessimism

        1    0      x   :   0   :   0;  // pessimism
        1    x    (?x)  :   0   :   0;  // pessimism
        1    1    (?x)  :   0   :   0;  // pessimism

        x    0      x   :   0   :   0;  // pessimism
        x    x    (?x)  :   0   :   0;  // pessimism
        x    1    (?x)  :   0   :   0;  // pessimism
                                                           
        1   (x1)    0   :   1   :   1;  // reducing pessimism
        0   (x1)    0   :   0   :   0;                          
        1   (0x)    0   :   1   :   1;  
        0   (0x)    0   :   0   :   0;  


        ?   ?       1   :   ?   :   0;  // asynchronous clear

        ?   (?0)    ?   :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   :   ?   :   -;  // ignore falling clock
        *    ?      ?   :   ?   :   -;  // ignore the edges on data

        ?    ?    (?0)  :   ?   :   -;  // ignore the edges on clear 


    endtable
endprimitive



  `timescale 10 ps / 10 ps
  primitive DFF_FD1E (Q, D, CP, EN, R);



    output Q;  
    input  D, CP, EN, R;
    reg    Q; 
    

    table
 
    //  D   CP     EN       R   :   Qt  :   Qt+1

        1   (01)    1       0   :   ?   :   1;  // clocked data
        0   (01)    1       0   :   ?   :   0;
        ?    ?      0       0   :   ?   :   -;  // disable
	 //  the following is redundant in Cadence's Verilog-XL
    //  ?    *      0       0   :   ?   :   -;  

        0   (01)    1       x   :   ?   :   0;  // pessimism
        0    ?      ?       x   :   0   :   0;  // pessimism

        1    0      ?       x   :   0   :   0;  // pessimism
        1    x      ?     (?x)  :   0   :   0;  // pessimism
        1    1      ?     (?x)  :   0   :   0;  // pessimism

        x    0      ?       x   :   0   :   0;  // pessimism
        x    x      ?     (?x)  :   0   :   0;  // pessimism
        x    1      ?     (?x)  :   0   :   0;  // pessimism
                                                           
        1   (x1)    ?       0   :   1   :   1;  // reducing pessimism
        0   (x1)    ?       0   :   0   :   0;                          
        1   (0x)    ?       0   :   1   :   1;  
        0   (0x)    ?       0   :   0   :   0;  


        ?   ?       ?       1   :   ?   :   0;  // asynchronous clear

        ?   (?0)    ?       ?   :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?       ?   :   ?   :   -;  // ignore falling clock
        *    ?      ?       ?   :   ?   :   -;  // ignore the edges on data

        ?    ?      ?     (?0)  :   ?   :   -;  // ignore the edges on clear 
        ?    ?      *       ?   :   ?   :   -;  // ignore the edges on enable


    endtable
endprimitive



  `timescale 10 ps / 10 ps
  primitive DFF_FDC (Q, D, CP, S);



    output Q;  
    input  D, CP, S;
    reg    Q; 
    

    table
 
    //  D   CP      S   :   Qt  :   Qt+1

        1   (01)    0   :   ?   :   1;  // clocked data
        0   (01)    0   :   ?   :   0;

        1   (01)    x   :   ?   :   1;  // pessimism
        1    ?      x   :   1   :   1;  // pessimism
	 //  redundant according to Cadence's Verilog-XL
    //    1    0      x   :   1   :   1;  // pessimism
    //    1    x    (?x)  :   1   :   1;  // pessimism
    //    1    1    (?x)  :   1   :   1;  // pessimism

        x    0      x   :   1   :   1;  // pessimism
        x    x    (?x)  :   1   :   1;  // pessimism
        x    1    (?x)  :   1   :   1;  // pessimism
                                                           
        1   (x1)    0   :   1   :   1;  // reducing pessimism
        0   (x1)    0   :   0   :   0;                          
        1   (0x)    0   :   1   :   1;  
        0   (0x)    0   :   0   :   0;  


        ?   ?       1   :   ?   :   1;  // asynchronous set

        ?   (?0)    ?   :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   :   ?   :   -;  // ignore falling clock
        *    ?      ?   :   ?   :   -;  // ignore the edges on data

        ?    ?    (?0)  :   ?   :   -;  // ignore the edges on clear 


    endtable
endprimitive



  `timescale 10 ps / 10 ps
  primitive DFF_FDCE (Q, D, CP, EN, S);



    output Q;  
    input  D, CP, EN, S;
    reg    Q; 
    

    table
 
    //  D   CP     EN       S   :   Qt  :   Qt+1

        1   (01)    1       0   :   ?   :   1;  // clocked data
        0   (01)    1       0   :   ?   :   0;
        ?    ?      0       0   :   ?   :   -;  // disable
	 // redundant according to Cadence's Verilog-XL
    //    ?    *      0       0   :   ?   :   -; 

        1   (01)    1       x   :   ?   :   1;  // pessimism
        1    ?      ?       x   :   1   :   1;  // pessimism
	 // redundant according to Cadence's Verilog-XL
    //    1    0      ?       x   :   1   :   1;  // pessimism
    //    1    x      ?     (?x)  :   1   :   1;  // pessimism
    //    1    1      ?     (?x)  :   1   :   1;  // pessimism

        x    0      ?       x   :   1   :   1;  // pessimism
        x    x      ?     (?x)  :   1   :   1;  // pessimism
        x    1      ?     (?x)  :   1   :   1;  // pessimism
                                                           
        1   (x1)    ?       0   :   1   :   1;  // reducing pessimism
        0   (x1)    ?       0   :   0   :   0;                          
        1   (0x)    ?       0   :   1   :   1;  
        0   (0x)    ?       0   :   0   :   0;  


        ?    ?      ?       1   :   ?   :   1;  // asynchronous set

        ?   (?0)    ?       ?   :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?       ?   :   ?   :   -;  // ignore falling clock
        *    ?      ?       ?   :   ?   :   -;  // ignore the edges on data

        ?    ?      ?     (?0)  :   ?   :   -;  // ignore the edges on clear 
        ?    ?      *       ?   :   ?   :   -;  // ignore the edges on enable


    endtable
endprimitive



  `timescale 10 ps / 10 ps
  primitive DFF_FDE (Q, D, CP, R, S);



    output Q;  
    input  D, CP, R, S;
    reg    Q; 
    

    table
 
    //  D   CP      R      S   :   Qt  :   Qt+1

	1   (01)    0      0   :   ?   :   1;  // clocked data
	0   (01)    0      0   :   ?   :   0;

	0   (01)    x      0   :   ?   :   0;  // pessimism
	1   (01)    0      x   :   ?   :   1;  // pessimism
	0    ?      x      0   :   0   :   0;  // pessimism
	1    ?      0      x   :   1   :   1;  // pessimism

	1    0      x      0   :   0   :   0;  // pessimism
	1    x    (?x)     0   :   0   :   0;  // pessimism
	1    1    (?x)     0   :   0   :   0;  // pessimism
	0    0      0      x   :   1   :   1;  // pessimism
	0    x      0    (?x)  :   1   :   1;  // pessimism
// redundant according to Cadence's Verilog-XL
//      0    0      0    (?x)  :   1   :   1;  // pessimism


	x    0      x      0   :   0   :   0;  // pessimism
	x    x    (?x)     0   :   0   :   0;  // pessimism
	x    1    (?x)     0   :   0   :   0;  // pessimism
	x    0      0      x   :   1   :   1;  // pessimism
	x    x      0    (?x)  :   1   :   1;  // pessimism
	x    1      0    (?x)  :   1   :   1;  // pessimism
							   
	1   (x1)    0      0   :   1   :   1;  // reducing pessimism
	0   (x1)    0      0   :   0   :   0;                          
	1   (0x)    0      0   :   1   :   1;  
	0   (0x)    0      0   :   0   :   0;  


	?   ?       1      ?   :   ?   :   0;  // asynchronous clear over set
	?   ?       0      1   :   ?   :   1;  // asynchronous set

	?   (?0)    ?      ?   :   ?   :   -;  // ignore falling clock
	?   (1x)    ?      ?   :   ?   :   -;  // ignore falling clock
	*    ?      ?      ?   :   ?   :   -;  // ignore the edges on data

	?    ?    (?0)     ?   :   ?   :   -;  // ignore the edges on clear 
	?    ?      ?    (?0)  :   ?   :   -;  // ignore the edges on set

    endtable
endprimitive



  `timescale 10 ps / 10 ps
  primitive DFF_FDEE (Q, D, CP, EN, R, S);



    output Q;  
    input  D, CP, EN, R, S;
    reg    Q; 
    

    table
 
    //  D   CP     EN      R      S   :   Qt  :   Qt+1

	1   (01)    1      0      0   :   ?   :   1;  // clocked data
	0   (01)    1      0      0   :   ?   :   0;
	?    ?      0      0      0   :   ?   :   -;  // disable
	 //  redundant according to Cadence's Verilog-XL
//        ?    *      0      0      0   :   ?   :   -;  

	0   (01)    1      x      0   :   ?   :   0;  // pessimism
	1   (01)    1      0      x   :   ?   :   1;  // pessimism
	0    ?      ?      x      0   :   0   :   0;  // pessimism
	1    ?      ?      0      x   :   1   :   1;  // pessimism

	1    0      ?      x      0   :   0   :   0;  // pessimism
	1    x      ?    (?x)     0   :   0   :   0;  // pessimism
	1    1      ?    (?x)     0   :   0   :   0;  // pessimism
	0    0      ?      0      x   :   1   :   1;  // pessimism
	0    x      ?      0    (?x)  :   1   :   1;  // pessimism
	 //  redundant according to Cadence's Verilog-XL
    //    0    0      ?      0    (?x)  :   1   :   1;  // pessimism


	x    0      ?      x      0   :   0   :   0;  // pessimism
	x    x      ?    (?x)     0   :   0   :   0;  // pessimism
	x    1      ?    (?x)     0   :   0   :   0;  // pessimism
	x    0      ?      0      x   :   1   :   1;  // pessimism
	x    x      ?      0    (?x)  :   1   :   1;  // pessimism
	x    1      ?      0    (?x)  :   1   :   1;  // pessimism
							   
	1   (x1)    ?      0      0   :   1   :   1;  // reducing pessimism
	0   (x1)    ?      0      0   :   0   :   0;                          
	1   (0x)    ?      0      0   :   1   :   1;  
	0   (0x)    ?      0      0   :   0   :   0;  


	?   ?       ?      1      ?   :   ?   :   0;  // asynchronous clear over set
	?   ?       ?      0      1   :   ?   :   1;  // asynchronous set

	?   (?0)    ?      ?      ?   :   ?   :   -;  // ignore falling clock
	?   (1x)    ?      ?      ?   :   ?   :   -;  // ignore falling clock
	*    ?      ?      ?      ?   :   ?   :   -;  // ignore the edges on data

	?    ?      ?    (?0)     ?   :   ?   :   -;  // ignore the edges on clear 
	?    ?      ?      ?    (?0)  :   ?   :   -;  // ignore the edges on set
	?    ?      *      ?      ?   :   ?   :   -;  // ignore the edges on enable


    endtable
endprimitive



`timescale 10 ps / 10 ps
primitive DFF_IO  (Q, D, CP, RB);


    output Q;  
    input  D, CP, RB;
    reg    Q; 
    


    table
 
    //  D   CP      RB  :   Qt  :   Qt+1

        1   (01)    1   :   ?   :   1;  // clocked data
        0   (01)    1   :   ?   :   0;

        0   (01)    x   :   ?   :   0;  // pessimism

        0    ?      x   :   0   :   0;  // pessimism
                       
        1    0      x   :   0   :   0;  // pessimism
        1    x    (?x)  :   0   :   0;  // pessimism
        1    1    (?x)  :   0   :   0;  // pessimism
                       
        x    0      x   :   0   :   0;  // pessimism
        x    x    (?x)  :   0   :   0;  // pessimism
        x    1    (?x)  :   0   :   0;  // pessimism

        1   (x1)    1   :   1   :   1;  // reducing pessimism
        0   (x1)    1   :   0   :   0;                          
        1   (0x)    1   :   1   :   1;  
        0   (0x)    1   :   0   :   0;  


        ?   ?       0   :   ?   :   0;  // asynchronous clear

        ?   (?0)    ?   :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   :   ?   :   -;  // ignore falling clock
        *    ?      ?   :   ?   :   -;  // ignore the edges on data

        ?    ?    (?1)  :   ?   :   -;  // ignore the edges on clear 


    endtable
endprimitive



`timescale 10 ps / 10 ps
primitive DFF_IO1E  (Q, D, CP, EN, RB);


    output Q;  
    input  D, CP, EN, RB;
    reg    Q; 
    


    table
 
    //  D   CP      EN      RB  :   Qt  :   Qt+1

        1   (01)    1       1   :   ?   :   1;  // clocked data
        0   (01)    1       1   :   ?   :   0;
        ?   ?       0       1   :   ?   :   -;  // disable

        0   (01)    1       x   :   ?   :   0;  // pessimism

        0    ?      ?       x   :   0   :   0;  // pessimism
                       
        1    0      ?       x   :   0   :   0;  // pessimism
        1    x      ?     (?x)  :   0   :   0;  // pessimism
        1    1      ?     (?x)  :   0   :   0;  // pessimism
                       
        x    0      ?       x   :   0   :   0;  // pessimism
        x    x      ?     (?x)  :   0   :   0;  // pessimism
        x    1      ?     (?x)  :   0   :   0;  // pessimism

        1   (x1)    ?       1   :   1   :   1;  // reducing pessimism
        0   (x1)    ?       1   :   0   :   0;                          
        1   (0x)    ?       1   :   1   :   1;  
        0   (0x)    ?       1   :   0   :   0;  


        ?   ?       ?       0   :   ?   :   0;  // asynchronous clear

        ?   (?0)    ?       ?   :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?       ?   :   ?   :   -;  // ignore falling clock
        *    ?      ?       ?   :   ?   :   -;  // ignore the edges on data

        ?    ?      ?     (?1)  :   ?   :   -;  // ignore the edges on clear 
        ?    ?      *       ?   :   ?   :   -;  // ignore the edges on enable


    endtable
endprimitive



`timescale 10 ps / 10 ps
primitive DFF_IO3 (Q, D, CP, SB);


    output Q;  
    input  D, CP, SB;
    reg    Q; 
    


    table
 
    //  D   CP      SB  :   Qt  :   Qt+1

        1   (01)    1   :   ?   :   1;  // clocked data
        0   (01)    1   :   ?   :   0;

        1   (01)    x   :   ?   :   1;  // pessimism
        1    ?      x   :   1   :   1;  // pessimism
        
        0    0      x   :   1   :   1;  // pessimism
        0    x    (?x)  :   1   :   1;  // pessimism
        0    1    (?x)  :   1   :   1;  // pessimism
                       
        x    0      x   :   1   :   1;  // pessimism
        x    x    (?x)  :   1   :   1;  // pessimism
        x    1    (?x)  :   1   :   1;  // pessimism

        1   (x1)    1   :   1   :   1;  // reducing pessimism
        0   (x1)    1   :   0   :   0;                          
        1   (0x)    1   :   1   :   1;  
        0   (0x)    1   :   0   :   0;  


        ?   ?       0   :   ?   :   1;  // asynchronous set

        ?   (?0)    ?   :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   :   ?   :   -;  // ignore falling clock
        *    ?      ?   :   ?   :   -;  // ignore the edges on data

        ?    ?    (?1)  :   ?   :   -;  // ignore the edges on set 


    endtable
endprimitive



`timescale 10 ps / 10 ps
primitive DFF_IO3E  (Q, D, CP, EN, SB);


    output Q;  
    input  D, CP, EN, SB;
    reg    Q; 
    


    table
 
    //  D   CP      EN      SB  :   Qt  :   Qt+1

        1   (01)    1       1   :   ?   :   1;  // clocked data
        0   (01)    1       1   :   ?   :   0;
        ?   ?       0       1   :   ?   :   -;  // disable

        1   (01)    1       x   :   ?   :   1;  // pessimism

        1    ?      ?       x   :   1   :   1;  // pessimism
                       
        0    0      ?       x   :   1   :   1;  // pessimism
        0    x      ?     (?x)  :   1   :   1;  // pessimism
        0    1      ?     (?x)  :   1   :   1;  // pessimism
                       
        x    0      ?       x   :   1   :   1;  // pessimism
        x    x      ?     (?x)  :   1   :   1;  // pessimism
        x    1      ?     (?x)  :   1   :   1;  // pessimism

        1   (x1)    ?       1   :   1   :   1;  // reducing pessimism
        0   (x1)    ?       1   :   0   :   0;                          
        1   (0x)    ?       1   :   1   :   1;  
        0   (0x)    ?       1   :   0   :   0;  


        ?   ?       ?       0   :   ?   :   1;  // asynchronous set

        ?   (?0)    ?       ?   :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?       ?   :   ?   :   -;  // ignore falling clock
        *    ?      ?       ?   :   ?   :   -;  // ignore the edges on data

        ?    ?      ?     (?1)  :   ?   :   -;  // ignore the edges on set 
        ?    ?      *       ?   :   ?   :   -;  // ignore the edges on enable


    endtable
endprimitive



  `timescale 10 ps / 10 ps
  primitive DFF_IO4 (Q, D, CP, RB, SB);



    output Q;  
    input  D, CP, RB, SB;
    reg    Q; 
    

    table
 
    //  D   CP     RB     SB   :   Qt  :   Qt+1

        1   (01)    1      1   :   ?   :   1;  // clocked data
        0   (01)    1      1   :   ?   :   0;

        0   (01)    x      1   :   ?   :   0;  // pessimism
        1   (01)    1      x   :   ?   :   1;  // pessimism
        0    ?      x      1   :   0   :   0;  // pessimism
        1    ?      1      x   :   1   :   1;  // pessimism

        1    0      x      1   :   0   :   0;  // pessimism
        1    x    (?x)     1   :   0   :   0;  // pessimism
        1    1    (?x)     1   :   0   :   0;  // pessimism
        0    1      1      x   :   1   :   1;  // pessimism
        0    x      1    (?x)  :   1   :   1;  // pessimism
        0    0      1    (?x)  :   1   :   1;  // pessimism


        x    0      x      1   :   0   :   0;  // pessimism
        x    x    (?x)     1   :   0   :   0;  // pessimism
        x    1    (?x)     1   :   0   :   0;  // pessimism
        x    0      1      x   :   1   :   1;  // pessimism
        x    x      1    (?x)  :   1   :   1;  // pessimism
        x    1      1    (?x)  :   1   :   1;  // pessimism
                                                           
        1   (x1)    1      1   :   1   :   1;  // reducing pessimism
        0   (x1)    1      1   :   0   :   0;                          
        1   (0x)    1      1   :   1   :   1;  
        0   (0x)    1      1   :   0   :   0;  


        ?   ?       0      ?   :   ?   :   0;  // asynchronous clear over set
        ?   ?       1      0   :   ?   :   1;  // asynchronous set

        ?   (?0)    ?      ?   :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?      ?   :   ?   :   -;  // ignore falling clock
        *    ?      ?      ?   :   ?   :   -;  // ignore the edges on data

        ?    ?    (?1)     ?   :   ?   :   -;  // ignore the edges on clear 
        ?    ?      ?    (?1)  :   ?   :   -;  // ignore the edges on set


    endtable
endprimitive



  `timescale 10 ps / 10 ps


  primitive DFF_IO4E (Q, D, CP, EN, RB, SB);

    output Q;  
    input  D, CP, EN, RB, SB;
    reg    Q; 

    table
    //  D   CP     EN     RB     SB   :   Qt  :   Qt+1
        1   (01)    1      1      1   :   ?   :   1;  // clocked data
        0   (01)    1      1      1   :   ?   :   0;
        ?    ?      0      1      1   :   ?   :   -;  // disable

        0   (01)    1      x      1   :   ?   :   0;  // pessimism
        1   (01)    1      1      x   :   ?   :   1;  // pessimism
        0    ?      ?      x      1   :   0   :   0;  // pessimism
        1    ?      ?      1      x   :   1   :   1;  // pessimism

        1    0      ?      x      1   :   0   :   0;  // pessimism
        1    x      ?    (?x)     1   :   0   :   0;  // pessimism
        1    1      ?    (?x)     1   :   0   :   0;  // pessimism
        0    1      ?      1      x   :   1   :   1;  // pessimism
        0    x      ?      1    (?x)  :   1   :   1;  // pessimism
        0    0      ?      1    (?x)  :   1   :   1;  // pessimism

        x    0      ?      x      1   :   0   :   0;  // pessimism
        x    x      ?    (?x)     1   :   0   :   0;  // pessimism
        x    1      ?    (?x)     1   :   0   :   0;  // pessimism
        x    0      ?      1      x   :   1   :   1;  // pessimism
        x    x      ?      1    (?x)  :   1   :   1;  // pessimism
        x    1      ?      1    (?x)  :   1   :   1;  // pessimism

        1   (x1)    ?      1      1   :   1   :   1;  // reducing pessimism
        0   (x1)    ?      1      1   :   0   :   0;                          
        1   (0x)    ?      1      1   :   1   :   1;  
        0   (0x)    ?      1      1   :   0   :   0;  

        ?   ?       ?      0      ?   :   ?   :   0;  // asynchronous clear over set
        ?   ?       ?      1      0   :   ?   :   1;  // asynchronous set

        ?   (?0)    ?      ?      ?   :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?      ?      ?   :   ?   :   -;  // ignore falling clock
        *    ?      ?      ?      ?   :   ?   :   -;  // ignore the edges on data

        ?    ?      ?    (?1)     ?   :   ?   :   -;  // ignore the edges on clear 
        ?    ?      ?      ?    (?1)  :   ?   :   -;  // ignore the edges on set
        ?    ?      *      ?      ?   :   ?   :   -;  // ignore the edges on enable

    endtable
endprimitive
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:35 1994
`timescale 10 ps / 10 ps 
module DMUX2(
	Z0, Z1, A0, S0);

	output Z0;
	output Z1;
	input A0;
	input S0;

AND2 \$1I1  (.Z0(Z0), .A0(A0), .A1(\$1N4 ));
AND2 \$1I2  (.Z0(Z1), .A0(A0), .A1(S0));
INV \$1I3  (.ZN0(\$1N4 ), .A0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:38 1994
`timescale 10 ps / 10 ps 
module DMUX22(
	Y0, Y1, Z0, Z1, 
	A0, A1, S0);

	output Y0;
	output Y1;
	output Z0;
	output Z1;
	input A0;
	input A1;
	input S0;

DMUX2 \$1I114  (.Z0(Y0), .Z1(Z0), .A0(A0), .S0(S0));
DMUX2 \$1I116  (.Z0(Y1), .Z1(Z1), .A0(A1), .S0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:42 1994
`timescale 10 ps / 10 ps 
module DMUX22E(
	Y0, Y1, Z0, Z1, 
	A0, A1, EN, S0);

	output Y0;
	output Y1;
	output Z0;
	output Z1;
	input A0;
	input A1;
	input EN;
	input S0;

DMUX2E \$1I150  (.Z0(Y0), .Z1(Z0), .A0(A0), .EN(EN), 
	.S0(S0));
DMUX2E \$1I163  (.Z0(Y1), .Z1(Z1), .A0(A1), .EN(EN), 
	.S0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:45 1994
`timescale 10 ps / 10 ps 
module DMUX24(
	W0, W1, X0, X1, 
	Y0, Y1, Z0, Z1, 
	A0, A1, S0, S1);

	output W0;
	output W1;
	output X0;
	output X1;
	output Y0;
	output Y1;
	output Z0;
	output Z1;
	input A0;
	input A1;
	input S0;
	input S1;

DMUX4 \$1I150  (.Z0(W0), .Z1(X0), .Z2(Y0), .Z3(Z0), 
	.A0(A0), .S0(S0), .S1(S1));
DMUX4 \$1I166  (.Z0(W1), .Z1(X1), .Z2(Y1), .Z3(Z1), 
	.A0(A1), .S0(S0), .S1(S1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:48 1994
`timescale 10 ps / 10 ps 
module DMUX24E(
	W0, W1, X0, X1, 
	Y0, Y1, Z0, Z1, 
	A0, A1, EN, S0, 
	S1);

	output W0;
	output W1;
	output X0;
	output X1;
	output Y0;
	output Y1;
	output Z0;
	output Z1;
	input A0;
	input A1;
	input EN;
	input S0;
	input S1;

DMUX4E \$1I113  (.Z0(W0), .Z1(X0), .Z2(Y0), .Z3(Z0), 
	.A0(A0), .EN(EN), .S0(S0), .S1(S1));
DMUX4E \$1I114  (.Z0(W1), .Z1(X1), .Z2(Y1), .Z3(Z1), 
	.A0(A1), .EN(EN), .S0(S0), .S1(S1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:50 1994
`timescale 10 ps / 10 ps 
module DMUX2E(
	Z0, Z1, A0, EN, 
	S0);

	output Z0;
	output Z1;
	input A0;
	input EN;
	input S0;

AND3 \$1I1  (.Z0(Z0), .A0(EN), .A1(A0), .A2(\$1N4 ));
AND3 \$1I2  (.Z0(Z1), .A0(EN), .A1(A0), .A2(S0));
INV \$1I3  (.ZN0(\$1N4 ), .A0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:53 1994
`timescale 10 ps / 10 ps 
module DMUX4(
	Z0, Z1, Z2, Z3, 
	A0, S0, S1);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input A0;
	input S0;
	input S1;

AND3 \$1I1  (.Z0(Z0), .A0(A0), .A1(\$1N28 ), .A2(\$1N31 ));
AND3 \$1I10  (.Z0(Z1), .A0(A0), .A1(S0), .A2(\$1N31 ));
AND3 \$1I12  (.Z0(Z2), .A0(A0), .A1(\$1N28 ), .A2(S1));
AND3 \$1I14  (.Z0(Z3), .A0(A0), .A1(S0), .A2(S1));
INV \$1I27  (.ZN0(\$1N28 ), .A0(S0));
INV \$1I45  (.ZN0(\$1N31 ), .A0(S1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:55 1994
`timescale 10 ps / 10 ps 
module DMUX42(
	Y0, Y1, Y2, Y3, 
	Z0, Z1, Z2, Z3, 
	A0, A1, A2, A3, 
	S0);

	output Y0;
	output Y1;
	output Y2;
	output Y3;
	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input A0;
	input A1;
	input A2;
	input A3;
	input S0;

DMUX2 \$1I114  (.Z0(Y0), .Z1(Z0), .A0(A0), .S0(S0));
DMUX2 \$1I116  (.Z0(Y1), .Z1(Z1), .A0(A1), .S0(S0));
DMUX2 \$1I120  (.Z0(Y3), .Z1(Z3), .A0(A3), .S0(S0));
DMUX2 \$1I135  (.Z0(Y2), .Z1(Z2), .A0(A2), .S0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:05:58 1994
`timescale 10 ps / 10 ps 
module DMUX42E(
	Y0, Y1, Y2, Y3, 
	Z0, Z1, Z2, Z3, 
	A0, A1, A2, A3, 
	EN, S0);

	output Y0;
	output Y1;
	output Y2;
	output Y3;
	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input A0;
	input A1;
	input A2;
	input A3;
	input EN;
	input S0;

DMUX2E \$1I150  (.Z0(Y0), .Z1(Z0), .A0(A0), .EN(EN), 
	.S0(S0));
DMUX2E \$1I163  (.Z0(Y1), .Z1(Z1), .A0(A1), .EN(EN), 
	.S0(S0));
DMUX2E \$1I178  (.Z0(Y3), .Z1(Z3), .A0(A3), .EN(EN), 
	.S0(S0));
DMUX2E \$1I185  (.Z0(Y2), .Z1(Z2), .A0(A2), .EN(EN), 
	.S0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:01 1994
`timescale 10 ps / 10 ps 
module DMUX44(
	W0, W1, W2, W3, 
	X0, X1, X2, X3, 
	Y0, Y1, Y2, Y3, 
	Z0, Z1, Z2, Z3, 
	A0, A1, A2, A3, 
	S0, S1);

	output W0;
	output W1;
	output W2;
	output W3;
	output X0;
	output X1;
	output X2;
	output X3;
	output Y0;
	output Y1;
	output Y2;
	output Y3;
	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input A0;
	input A1;
	input A2;
	input A3;
	input S0;
	input S1;

DMUX4 \$1I150  (.Z0(W0), .Z1(X0), .Z2(Y0), .Z3(Z0), 
	.A0(A0), .S0(S0), .S1(S1));
DMUX4 \$1I166  (.Z0(W1), .Z1(X1), .Z2(Y1), .Z3(Z1), 
	.A0(A1), .S0(S0), .S1(S1));
DMUX4 \$1I183  (.Z0(W3), .Z1(X3), .Z2(Y3), .Z3(Z3), 
	.A0(A3), .S0(S0), .S1(S1));
DMUX4 \$1I193  (.Z0(W2), .Z1(X2), .Z2(Y2), .Z3(Z2), 
	.A0(A2), .S0(S0), .S1(S1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:04 1994
`timescale 10 ps / 10 ps 
module DMUX44E(
	W0, W1, W2, W3, 
	X0, X1, X2, X3, 
	Y0, Y1, Y2, Y3, 
	Z0, Z1, Z2, Z3, 
	A0, A1, A2, A3, 
	EN, S0, S1);

	output W0;
	output W1;
	output W2;
	output W3;
	output X0;
	output X1;
	output X2;
	output X3;
	output Y0;
	output Y1;
	output Y2;
	output Y3;
	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input A0;
	input A1;
	input A2;
	input A3;
	input EN;
	input S0;
	input S1;

DMUX4E \$1I113  (.Z0(W0), .Z1(X0), .Z2(Y0), .Z3(Z0), 
	.A0(A0), .EN(EN), .S0(S0), .S1(S1));
DMUX4E \$1I114  (.Z0(W1), .Z1(X1), .Z2(Y1), .Z3(Z1), 
	.A0(A1), .EN(EN), .S0(S0), .S1(S1));
DMUX4E \$1I165  (.Z0(W2), .Z1(X2), .Z2(Y2), .Z3(Z2), 
	.A0(A2), .EN(EN), .S0(S0), .S1(S1));
DMUX4E \$1I166  (.Z0(W3), .Z1(X3), .Z2(Y3), .Z3(Z3), 
	.A0(A3), .EN(EN), .S0(S0), .S1(S1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:07 1994
`timescale 10 ps / 10 ps 
module DMUX4E(
	Z0, Z1, Z2, Z3, 
	A0, EN, S0, S1);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input A0;
	input EN;
	input S0;
	input S1;

AND4 \$1I1  (.Z0(Z0), .A0(EN), .A1(A0), .A2(\$1N28 ), 
	.A3(\$1N31 ));
AND4 \$1I10  (.Z0(Z1), .A0(EN), .A1(A0), .A2(S0), 
	.A3(\$1N31 ));
AND4 \$1I12  (.Z0(Z2), .A0(EN), .A1(A0), .A2(\$1N28 ), 
	.A3(S1));
AND4 \$1I14  (.Z0(Z3), .A0(EN), .A1(A0), .A2(S0), 
	.A3(S1));
INV \$1I27  (.ZN0(\$1N28 ), .A0(S0));
INV \$1I48  (.ZN0(\$1N31 ), .A0(S1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:10 1994
`timescale 10 ps / 10 ps 
module DMUX82(
	Y0, Y1, Y2, Y3, 
	Y4, Y5, Y6, Y7, 
	Z0, Z1, Z2, Z3, 
	Z4, Z5, Z6, Z7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	S0);

	output Y0;
	output Y1;
	output Y2;
	output Y3;
	output Y4;
	output Y5;
	output Y6;
	output Y7;
	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input S0;

DMUX2 \$1I150  (.Z0(Y0), .Z1(Z0), .A0(A0), .S0(S0));
DMUX2 \$1I163  (.Z0(Y1), .Z1(Z1), .A0(A1), .S0(S0));
DMUX2 \$1I178  (.Z0(Y3), .Z1(Z3), .A0(A3), .S0(S0));
DMUX2 \$1I185  (.Z0(Y2), .Z1(Z2), .A0(A2), .S0(S0));
DMUX2 \$1I212  (.Z0(Y7), .Z1(Z7), .A0(A7), .S0(S0));
DMUX2 \$1I219  (.Z0(Y6), .Z1(Z6), .A0(A6), .S0(S0));
DMUX2 \$1I227  (.Z0(Y4), .Z1(Z4), .A0(A4), .S0(S0));
DMUX2 \$1I234  (.Z0(Y5), .Z1(Z5), .A0(A5), .S0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:14 1994
`timescale 10 ps / 10 ps 
module DMUX82E(
	Y0, Y1, Y2, Y3, 
	Y4, Y5, Y6, Y7, 
	Z0, Z1, Z2, Z3, 
	Z4, Z5, Z6, Z7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	EN, S0);

	output Y0;
	output Y1;
	output Y2;
	output Y3;
	output Y4;
	output Y5;
	output Y6;
	output Y7;
	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input EN;
	input S0;

DMUX2E \$1I150  (.Z0(Y0), .Z1(Z0), .A0(A0), .EN(EN), 
	.S0(S0));
DMUX2E \$1I163  (.Z0(Y1), .Z1(Z1), .A0(A1), .EN(EN), 
	.S0(S0));
DMUX2E \$1I178  (.Z0(Y3), .Z1(Z3), .A0(A3), .EN(EN), 
	.S0(S0));
DMUX2E \$1I185  (.Z0(Y2), .Z1(Z2), .A0(A2), .EN(EN), 
	.S0(S0));
DMUX2E \$1I212  (.Z0(Y7), .Z1(Z7), .A0(A7), .EN(EN), 
	.S0(S0));
DMUX2E \$1I219  (.Z0(Y6), .Z1(Z6), .A0(A6), .EN(EN), 
	.S0(S0));
DMUX2E \$1I227  (.Z0(Y4), .Z1(Z4), .A0(A4), .EN(EN), 
	.S0(S0));
DMUX2E \$1I234  (.Z0(Y5), .Z1(Z5), .A0(A5), .EN(EN), 
	.S0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:19 1994
`timescale 10 ps / 10 ps 
module F3ADD(
	Z0, Z1, Z2, G012, 
	P012, A0, A1, A2, 
	B0, B1, B2, CI);

	output Z0;
	output Z1;
	output Z2;
	output G012;
	output P012;
	input A0;
	input A1;
	input A2;
	input B0;
	input B1;
	input B2;
	input CI;

INV \$1I180  (.ZN0(\~CI ), .A0(CI));
INV \$1I486  (.ZN0(\~B1 ), .A0(B1));
INV \$1I487  (.ZN0(\~B2 ), .A0(B2));
INV \$1I495  (.ZN0(\~A0 ), .A0(A0));
AND2 \$1I544  (.Z0(\$1N547 ), .A0(\~B0 ), .A1(CI));
AND2 \$1I545  (.Z0(\$1N549 ), .A0(B0), .A1(\~CI ));
OR2 \$1I546  (.Z0(\$1N552 ), .A0(\$1N547 ), .A1(\$1N549 ));
LXOR2 \$1I551  (.Z0(Z0), .A0(A0), .A1(\$1N552 ));
AND3 \$1I567  (.Z0(\$1N577 ), .A0(\~A0 ), .A1(B1), .A2(\~B0 ));
AND3 \$1I568  (.Z0(\$1N573 ), .A0(\~B1 ), .A1(B0), .A2(CI));
AND3 \$1I569  (.Z0(\$1N572 ), .A0(A0), .A1(\~B1 ), .A2(CI));
AND3 \$1I570  (.Z0(\$1N574 ), .A0(B1), .A1(\~B0 ), .A2(\~CI ));
AND3 \$1I571  (.Z0(\$1N575 ), .A0(\~A0 ), .A1(B1), .A2(\~CI ));
OR6 \$1I578  (.Z0(\$1N580 ), .A0(\$1N575 ), .A1(\$1N574 ), .A2(\$1N572 ), 
	.A3(\$1N573 ), .A4(\$1N577 ), .A5(\$1N576 ));
LXOR2 \$1I581  (.Z0(Z1), .A0(A1), .A1(\$1N580 ));
AND3 \$1I582  (.Z0(\$1N576 ), .A0(A0), .A1(\~B1 ), .A2(B0));
AND4 \$1I601  (.Z0(\$1N639 ), .A0(A0), .A1(A1), .A2(A2), 
	.A3(B0));
AND3 \$1I606  (.Z0(\$1N637 ), .A0(A1), .A1(A2), .A2(B1));
AND4 \$1I610  (.Z0(\$1N635 ), .A0(A0), .A1(A2), .A2(B0), 
	.A3(B1));
AND2 \$1I615  (.Z0(\$1N633 ), .A0(A2), .A1(B2));
AND4 \$1I618  (.Z0(\$1N641 ), .A0(A0), .A1(A1), .A2(B0), 
	.A3(B2));
AND3 \$1I623  (.Z0(\$1N643 ), .A0(A1), .A1(B1), .A2(B2));
AND4 \$1I627  (.Z0(\$1N645 ), .A0(A0), .A1(B0), .A2(B1), 
	.A3(B2));
OR7 \$1I632  (.Z0(G012), .A0(\$1N639 ), .A1(\$1N637 ), .A2(\$1N635 ), 
	.A3(\$1N633 ), .A4(\$1N641 ), .A5(\$1N643 ), .A6(\$1N645 ));
AND2 \$1I649  (.Z0(\$1N664 ), .A0(\~A0 ), .A1(\~B0 ));
AND2 \$1I650  (.Z0(\$1N661 ), .A0(\~A1 ), .A1(\~B1 ));
AND2 \$1I651  (.Z0(\$1N662 ), .A0(\~A2 ), .A1(\~B2 ));
NOR3 \$1I660  (.ZN0(P012), .A0(\$1N664 ), .A1(\$1N661 ), .A2(\$1N662 ));
INV \$1I668  (.ZN0(\~B0 ), .A0(B0));
INV \$1I672  (.ZN0(\~A1 ), .A0(A1));
INV \$1I675  (.ZN0(\~A2 ), .A0(A2));
LXOR2 \$2I453  (.Z0(Z2), .A0(A2), .A1(\$2N694 ));
AND4 \$2I596  (.Z0(\$2N693 ), .A0(\~B0 ), .A1(\~B1 ), .A2(B2), 
	.A3(\~CI ));
AND4 \$2I597  (.Z0(\$2N696 ), .A0(\~A0 ), .A1(\~B1 ), .A2(B2), 
	.A3(\~CI ));
AND4 \$2I598  (.Z0(\$2N690 ), .A0(\~A1 ), .A1(\~B0 ), .A2(B2), 
	.A3(\~CI ));
AND4 \$2I599  (.Z0(\$2N688 ), .A0(\~A0 ), .A1(\~A1 ), .A2(B2), 
	.A3(\~CI ));
AND4 \$2I600  (.Z0(\$2N686 ), .A0(B0), .A1(B1), .A2(\~B2 ), 
	.A3(CI));
AND4 \$2I601  (.Z0(\$2N684 ), .A0(A0), .A1(B1), .A2(\~B2 ), 
	.A3(CI));
AND4 \$2I602  (.Z0(\$2N682 ), .A0(A1), .A1(B0), .A2(\~B2 ), 
	.A3(CI));
AND4 \$2I603  (.Z0(\$2N680 ), .A0(A0), .A1(A1), .A2(\~B2 ), 
	.A3(CI));
AND4 \$2I636  (.Z0(\$2N678 ), .A0(A0), .A1(B0), .A2(B1), 
	.A3(\~B2 ));
AND3 \$2I641  (.Z0(\$2N676 ), .A0(A1), .A1(B1), .A2(\~B2 ));
AND4 \$2I648  (.Z0(\$2N674 ), .A0(A0), .A1(A1), .A2(B0), 
	.A3(\~B2 ));
AND4 \$2I649  (.Z0(\$2N672 ), .A0(\~A0 ), .A1(\~B0 ), .A2(\~B1 ), 
	.A3(B2));
AND3 \$2I658  (.Z0(\$2N670 ), .A0(\~A1 ), .A1(\~B1 ), .A2(B2));
AND4 \$2I659  (.Z0(\$2N668 ), .A0(\~A0 ), .A1(\~A1 ), .A2(\~B0 ), 
	.A3(B2));
OR12 \$2I667  (.Z0(\$2N698 ), .A0(\$2N690 ), .A1(\$2N688 ), .A2(\$2N686 ), 
	.A3(\$2N684 ), .A4(\$2N682 ), .A5(\$2N680 ), .A6(\$2N678 ), 
	.A7(\$2N676 ), .A8(\$2N674 ), .A9(\$2N672 ), .A10(\$2N670 ), 
	.A11(\$2N668 ));
OR3 \$2I692  (.Z0(\$2N694 ), .A0(\$2N693 ), .A1(\$2N696 ), .A2(\$2N698 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:24 1994
`timescale 10 ps / 10 ps 
module F3SUB(
	Z0, Z1, Z2, G012, 
	P012, A0, A1, A2, 
	B0, B1, B2, BI);

	output Z0;
	output Z1;
	output Z2;
	output G012;
	output P012;
	input A0;
	input A1;
	input A2;
	input B0;
	input B1;
	input B2;
	input BI;

INV \$1I180  (.ZN0(\~BI ), .A0(BI));
INV \$1I486  (.ZN0(\~B1 ), .A0(B1));
INV \$1I487  (.ZN0(\~B2 ), .A0(B2));
INV \$1I495  (.ZN0(\~A0 ), .A0(A0));
AND2 \$1I544  (.Z0(\$1N547 ), .A0(\~B0 ), .A1(BI));
AND2 \$1I545  (.Z0(\$1N549 ), .A0(B0), .A1(\~BI ));
OR2 \$1I546  (.Z0(\$1N552 ), .A0(\$1N547 ), .A1(\$1N549 ));
LXOR2 \$1I551  (.Z0(Z0), .A0(A0), .A1(\$1N552 ));
AND3 \$1I567  (.Z0(\$1N577 ), .A0(A0), .A1(B1), .A2(\~B0 ));
AND3 \$1I568  (.Z0(\$1N573 ), .A0(\~B1 ), .A1(B0), .A2(BI));
AND3 \$1I569  (.Z0(\$1N572 ), .A0(\~A0 ), .A1(\~B1 ), .A2(BI));
AND3 \$1I570  (.Z0(\$1N574 ), .A0(B1), .A1(\~B0 ), .A2(\~BI ));
AND3 \$1I571  (.Z0(\$1N575 ), .A0(A0), .A1(B1), .A2(\~BI ));
OR6 \$1I578  (.Z0(\$1N580 ), .A0(\$1N575 ), .A1(\$1N574 ), .A2(\$1N572 ), 
	.A3(\$1N573 ), .A4(\$1N577 ), .A5(\$1N576 ));
LXOR2 \$1I581  (.Z0(Z1), .A0(A1), .A1(\$1N580 ));
AND3 \$1I582  (.Z0(\$1N576 ), .A0(\~A0 ), .A1(\~B1 ), .A2(B0));
AND4 \$1I601  (.Z0(\$1N639 ), .A0(\~A0 ), .A1(B0), .A2(B1), 
	.A3(B2));
AND3 \$1I606  (.Z0(\$1N637 ), .A0(\~A1 ), .A1(B1), .A2(B2));
AND4 \$1I610  (.Z0(\$1N635 ), .A0(\~A0 ), .A1(\~A2 ), .A2(B0), 
	.A3(B1));
AND2 \$1I615  (.Z0(\$1N633 ), .A0(\~A2 ), .A1(B2));
AND4 \$1I618  (.Z0(\$1N641 ), .A0(\~A0 ), .A1(\~A1 ), .A2(B0), 
	.A3(B2));
AND3 \$1I623  (.Z0(\$1N643 ), .A0(\~A1 ), .A1(\~A2 ), .A2(B1));
AND4 \$1I627  (.Z0(\$1N645 ), .A0(\~A0 ), .A1(\~A1 ), .A2(\~A2 ), 
	.A3(B0));
OR7 \$1I632  (.Z0(G012), .A0(\$1N639 ), .A1(\$1N637 ), .A2(\$1N635 ), 
	.A3(\$1N633 ), .A4(\$1N641 ), .A5(\$1N643 ), .A6(\$1N645 ));
AND2 \$1I649  (.Z0(\$1N664 ), .A0(A0), .A1(\~B0 ));
AND2 \$1I650  (.Z0(\$1N661 ), .A0(A1), .A1(\~B1 ));
AND2 \$1I651  (.Z0(\$1N662 ), .A0(A2), .A1(\~B2 ));
NOR3 \$1I660  (.ZN0(P012), .A0(\$1N664 ), .A1(\$1N661 ), .A2(\$1N662 ));
INV \$1I668  (.ZN0(\~B0 ), .A0(B0));
INV \$1I672  (.ZN0(\~A1 ), .A0(A1));
INV \$1I675  (.ZN0(\~A2 ), .A0(A2));
LXOR2 \$2I453  (.Z0(Z2), .A0(A2), .A1(\$2N694 ));
AND4 \$2I596  (.Z0(\$2N693 ), .A0(A0), .A1(A1), .A2(B2), 
	.A3(\~BI ));
AND4 \$2I597  (.Z0(\$2N696 ), .A0(\~A0 ), .A1(\~A1 ), .A2(\~B2 ), 
	.A3(BI));
AND4 \$2I598  (.Z0(\$2N690 ), .A0(A0), .A1(A1), .A2(\~B0 ), 
	.A3(B2));
AND4 \$2I599  (.Z0(\$2N688 ), .A0(A1), .A1(\~B0 ), .A2(B2), 
	.A3(\~BI ));
AND4 \$2I600  (.Z0(\$2N686 ), .A0(\~A0 ), .A1(\~A1 ), .A2(B0), 
	.A3(\~B2 ));
AND4 \$2I601  (.Z0(\$2N684 ), .A0(\~A1 ), .A1(B0), .A2(\~B2 ), 
	.A3(BI));
AND4 \$2I602  (.Z0(\$2N682 ), .A0(A0), .A1(\~B1 ), .A2(B2), 
	.A3(\~BI ));
AND4 \$2I603  (.Z0(\$2N680 ), .A0(A0), .A1(\~B0 ), .A2(\~B1 ), 
	.A3(B2));
AND4 \$2I636  (.Z0(\$2N678 ), .A0(\~B0 ), .A1(\~B1 ), .A2(B2), 
	.A3(\~BI ));
AND3 \$2I641  (.Z0(\$2N676 ), .A0(\~A1 ), .A1(\~B2 ), .A2(B1));
AND4 \$2I648  (.Z0(\$2N674 ), .A0(\~A0 ), .A1(B1), .A2(\~B2 ), 
	.A3(BI));
AND4 \$2I649  (.Z0(\$2N672 ), .A0(\~A0 ), .A1(B0), .A2(B1), 
	.A3(\~B2 ));
AND3 \$2I658  (.Z0(\$2N670 ), .A0(A1), .A1(\~B1 ), .A2(B2));
AND4 \$2I659  (.Z0(\$2N668 ), .A0(B0), .A1(B1), .A2(\~B2 ), 
	.A3(BI));
OR12 \$2I667  (.Z0(\$2N698 ), .A0(\$2N690 ), .A1(\$2N688 ), .A2(\$2N686 ), 
	.A3(\$2N684 ), .A4(\$2N682 ), .A5(\$2N680 ), .A6(\$2N678 ), 
	.A7(\$2N676 ), .A8(\$2N674 ), .A9(\$2N672 ), .A10(\$2N670 ), 
	.A11(\$2N668 ));
OR3 \$2I692  (.Z0(\$2N694 ), .A0(\$2N693 ), .A1(\$2N696 ), .A2(\$2N698 ));
endmodule

/**************
*     FD11    *
***************/

`timescale 10 ps / 10 ps
module FD11 (Q0, D0, CLK);


  input   D0, CLK;
  output  Q0;
  supply1 reset;

  not  blk0 (t1, reset); 
  DFF_FD blk2 (Q0, D0, CLK, t1);  


    
endmodule

/**************
*     FD11E   *
***************/

`timescale 10 ps / 10 ps
module FD11E (Q0, D0, CLK, EN);


  input   D0, CLK, EN;
  output  Q0;
  supply1 reset;

  not  blk0 (t1, reset); 
  DFF_FD1E blk2 (Q0, D0, CLK, EN, t1);  


    
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:28 1994
`timescale 10 ps / 10 ps 
module FD14(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CLK);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CLK;

FD11 \$1I181  (.Q0(Q3), .D0(D3), .CLK(CLK));
FD11 \$1I182  (.Q0(Q2), .D0(D2), .CLK(CLK));
FD11 \$1I183  (.Q0(Q1), .D0(D1), .CLK(CLK));
FD11 \$1I184  (.Q0(Q0), .D0(D0), .CLK(CLK));
endmodule
`timescale 10 ps / 10 ps
module FD14E(
	CLK, D0, D1, D2, D3, EN, Q0, Q1, Q2, Q3);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



FD11E \$1I217  (.Q0 (Q3), .D0 (D3), .CLK (CLK), 
	.EN (EN));
FD11E \$1I216  (.Q0 (Q2), .D0 (D2), .CLK (CLK), 
	.EN (EN));
FD11E \$1I214  (.Q0 (Q0), .D0 (D0), .CLK (CLK), 
	.EN (EN));
FD11E \$1I215  (.Q0 (Q1), .D0 (D1), .CLK (CLK), 
	.EN (EN));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:30 1994
`timescale 10 ps / 10 ps 
module FD18(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	CLK);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CLK;

FD11 \$1I181  (.Q0(Q3), .D0(D3), .CLK(CLK));
FD11 \$1I182  (.Q0(Q2), .D0(D2), .CLK(CLK));
FD11 \$1I183  (.Q0(Q1), .D0(D1), .CLK(CLK));
FD11 \$1I184  (.Q0(Q0), .D0(D0), .CLK(CLK));
FD11 \$1I246  (.Q0(Q4), .D0(D4), .CLK(CLK));
FD11 \$1I247  (.Q0(Q5), .D0(D5), .CLK(CLK));
FD11 \$1I248  (.Q0(Q6), .D0(D6), .CLK(CLK));
FD11 \$1I249  (.Q0(Q7), .D0(D7), .CLK(CLK));
endmodule
`timescale 10 ps / 10 ps
module FD18E(
	CLK, D0, D1, D2, D3, D4, D5, D6, D7, EN, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input EN;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



FD11E \$1I268  (.Q0 (Q4), .D0 (D4), .CLK (CLK), 
	.EN (EN));
FD11E \$1I267  (.Q0 (Q5), .D0 (D5), .CLK (CLK), 
	.EN (EN));
FD11E \$1I266  (.Q0 (Q6), .D0 (D6), .CLK (CLK), 
	.EN (EN));
FD11E \$1I265  (.Q0 (Q7), .D0 (D7), .CLK (CLK), 
	.EN (EN));
FD11E \$1I264  (.Q0 (Q3), .D0 (D3), .CLK (CLK), 
	.EN (EN));
FD11E \$1I263  (.Q0 (Q2), .D0 (D2), .CLK (CLK), 
	.EN (EN));
FD11E \$1I262  (.Q0 (Q1), .D0 (D1), .CLK (CLK), 
	.EN (EN));
FD11E \$1I261  (.Q0 (Q0), .D0 (D0), .CLK (CLK), 
	.EN (EN));
endmodule

/**************
*     FD21    *
***************/


`timescale 10 ps / 10 ps
module FD21 (Q0, D0, CLK, CD);

  input   CLK, D0, CD;
  output  Q0;
  supply1 reset;

  not  blk0 (t1, reset);
  or   blk1 (t2, t1, CD);

  DFF_FD blk2 (Q0, D0, CLK, t2);   

 
     
endmodule

/**************
*     FD21E   *
***************/


`timescale 10 ps / 10 ps
module FD21E (Q0, D0, CLK, EN, CD);

  input   CLK, D0, EN, CD;
  output  Q0;
  supply1 reset;

  not  blk0 (t1, reset);
  or   blk1 (t2, t1, CD);

  DFF_FD1E blk2 (Q0, D0, CLK, EN, t2);   

 
     
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:34 1994
`timescale 10 ps / 10 ps 
module FD24(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CLK, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CLK;
	input CD;

FD21 \$1I181  (.Q0(Q3), .D0(D3), .CLK(CLK), .CD(CD));
FD21 \$1I182  (.Q0(Q2), .D0(D2), .CLK(CLK), .CD(CD));
FD21 \$1I183  (.Q0(Q1), .D0(D1), .CLK(CLK), .CD(CD));
FD21 \$1I184  (.Q0(Q0), .D0(D0), .CLK(CLK), .CD(CD));
endmodule
`timescale 10 ps / 10 ps
module FD24E(
	CD, CLK, D0, D1, D2, D3, EN, Q0, Q1, Q2, Q3);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



FD21E \$1I221  (.Q0 (Q3), .D0 (D3), .CLK (CLK), 
	.EN (EN), .CD (CD));
FD21E \$1I220  (.Q0 (Q2), .D0 (D2), .CLK (CLK), 
	.EN (EN), .CD (CD));
FD21E \$1I219  (.Q0 (Q1), .D0 (D1), .CLK (CLK), 
	.EN (EN), .CD (CD));
FD21E \$1I218  (.Q0 (Q0), .D0 (D0), .CLK (CLK), 
	.EN (EN), .CD (CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:37 1994
`timescale 10 ps / 10 ps 
module FD28(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	CLK, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CLK;
	input CD;

FD21 \$1I181  (.Q0(Q3), .D0(D3), .CLK(CLK), .CD(CD));
FD21 \$1I182  (.Q0(Q2), .D0(D2), .CLK(CLK), .CD(CD));
FD21 \$1I183  (.Q0(Q1), .D0(D1), .CLK(CLK), .CD(CD));
FD21 \$1I184  (.Q0(Q0), .D0(D0), .CLK(CLK), .CD(CD));
FD21 \$1I242  (.Q0(Q6), .D0(D6), .CLK(CLK), .CD(CD));
FD21 \$1I243  (.Q0(Q5), .D0(D5), .CLK(CLK), .CD(CD));
FD21 \$1I248  (.Q0(Q4), .D0(D4), .CLK(CLK), .CD(CD));
FD21 \$1I257  (.Q0(Q7), .D0(D7), .CLK(CLK), .CD(CD));
endmodule
`timescale 10 ps / 10 ps
module FD28E(
	CD, CLK, D0, D1, D2, D3, D4, D5, D6, D7, EN, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input EN;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



FD21E \$1I268  (.Q0 (Q7), .D0 (D7), .CLK (CLK), 
	.EN (EN), .CD (CD));
FD21E \$1I267  (.Q0 (Q6), .D0 (D6), .CLK (CLK), 
	.EN (EN), .CD (CD));
FD21E \$1I266  (.Q0 (Q5), .D0 (D5), .CLK (CLK), 
	.EN (EN), .CD (CD));
FD21E \$1I265  (.Q0 (Q4), .D0 (D4), .CLK (CLK), 
	.EN (EN), .CD (CD));
FD21E \$1I264  (.Q0 (Q3), .D0 (D3), .CLK (CLK), 
	.EN (EN), .CD (CD));
FD21E \$1I263  (.Q0 (Q2), .D0 (D2), .CLK (CLK), 
	.EN (EN), .CD (CD));
FD21E \$1I262  (.Q0 (Q1), .D0 (D1), .CLK (CLK), 
	.EN (EN), .CD (CD));
FD21E \$1I261  (.Q0 (Q0), .D0 (D0), .CLK (CLK), 
	.EN (EN), .CD (CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:40 1994
`timescale 10 ps / 10 ps 
module FD31(
	Q0, D0, CLK, PS);

	output Q0;
	input D0;
	input CLK;
	input PS;

FD11 \$1I2  (.Q0(Q0), .D0(\$1N4 ), .CLK(CLK));
OR2 \$1I3  (.Z0(\$1N4 ), .A0(D0), .A1(PS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:43 1994
`timescale 10 ps / 10 ps 
module FD34(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CLK, PS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CLK;
	input PS;

FD31 \$1I181  (.Q0(Q3), .D0(D3), .CLK(CLK), .PS(PS));
FD31 \$1I182  (.Q0(Q2), .D0(D2), .CLK(CLK), .PS(PS));
FD31 \$1I183  (.Q0(Q1), .D0(D1), .CLK(CLK), .PS(PS));
FD31 \$1I184  (.Q0(Q0), .D0(D0), .CLK(CLK), .PS(PS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:46 1994
`timescale 10 ps / 10 ps 
module FD38(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	CLK, PS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CLK;
	input PS;

FD31 \$1I181  (.Q0(Q7), .D0(D7), .CLK(CLK), .PS(PS));
FD31 \$1I182  (.Q0(Q6), .D0(D6), .CLK(CLK), .PS(PS));
FD31 \$1I183  (.Q0(Q5), .D0(D5), .CLK(CLK), .PS(PS));
FD31 \$1I184  (.Q0(Q4), .D0(D4), .CLK(CLK), .PS(PS));
FD31 \$1I239  (.Q0(Q2), .D0(D2), .CLK(CLK), .PS(PS));
FD31 \$1I252  (.Q0(Q3), .D0(D3), .CLK(CLK), .PS(PS));
FD31 \$1I253  (.Q0(Q1), .D0(D1), .CLK(CLK), .PS(PS));
FD31 \$1I254  (.Q0(Q0), .D0(D0), .CLK(CLK), .PS(PS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:48 1994
`timescale 10 ps / 10 ps 
module FD41(
	Q0, D0, CLK, PS, 
	CD);

	output Q0;
	input D0;
	input CLK;
	input PS;
	input CD;

FD21 \$1I2  (.Q0(Q0), .D0(\$1N4 ), .CLK(CLK), .CD(CD));
OR2 \$1I3  (.Z0(\$1N4 ), .A0(D0), .A1(PS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:51 1994
`timescale 10 ps / 10 ps 
module FD44(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CLK, PS, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CLK;
	input PS;
	input CD;

FD41 \$1I181  (.Q0(Q3), .D0(D3), .CLK(CLK), .PS(PS), 
	.CD(CD));
FD41 \$1I182  (.Q0(Q2), .D0(D2), .CLK(CLK), .PS(PS), 
	.CD(CD));
FD41 \$1I183  (.Q0(Q1), .D0(D1), .CLK(CLK), .PS(PS), 
	.CD(CD));
FD41 \$1I184  (.Q0(Q0), .D0(D0), .CLK(CLK), .PS(PS), 
	.CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:55 1994
`timescale 10 ps / 10 ps 
module FD48(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	CLK, PS, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CLK;
	input PS;
	input CD;

FD41 \$1I181  (.Q0(Q3), .D0(D3), .CLK(CLK), .PS(PS), 
	.CD(CD));
FD41 \$1I182  (.Q0(Q2), .D0(D2), .CLK(CLK), .PS(PS), 
	.CD(CD));
FD41 \$1I183  (.Q0(Q1), .D0(D1), .CLK(CLK), .PS(PS), 
	.CD(CD));
FD41 \$1I184  (.Q0(Q0), .D0(D0), .CLK(CLK), .PS(PS), 
	.CD(CD));
FD41 \$1I250  (.Q0(Q7), .D0(D7), .CLK(CLK), .PS(PS), 
	.CD(CD));
FD41 \$1I260  (.Q0(Q6), .D0(D6), .CLK(CLK), .PS(PS), 
	.CD(CD));
FD41 \$1I261  (.Q0(Q5), .D0(D5), .CLK(CLK), .PS(PS), 
	.CD(CD));
FD41 \$1I262  (.Q0(Q4), .D0(D4), .CLK(CLK), .PS(PS), 
	.CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:06:58 1994
`timescale 10 ps / 10 ps 
module FD51(
	Q0, D0, CLK, PS, 
	CS);

	output Q0;
	input D0;
	input CLK;
	input PS;
	input CS;

OR2 \$1I11  (.Z0(\$1N14 ), .A0(\$1N12 ), .A1(PS));
INV \$1I17  (.ZN0(\$1N18 ), .A0(CS));
FD11 \$1I2  (.Q0(Q0), .D0(\$1N14 ), .CLK(CLK));
AND2 \$1I3  (.Z0(\$1N12 ), .A0(D0), .A1(\$1N18 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:07:01 1994
`timescale 10 ps / 10 ps 
module FD54(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CLK, PS, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CLK;
	input PS;
	input CS;

FD51 \$1I181  (.Q0(Q3), .D0(D3), .CLK(CLK), .PS(PS), 
	.CS(CS));
FD51 \$1I182  (.Q0(Q2), .D0(D2), .CLK(CLK), .PS(PS), 
	.CS(CS));
FD51 \$1I183  (.Q0(Q1), .D0(D1), .CLK(CLK), .PS(PS), 
	.CS(CS));
FD51 \$1I184  (.Q0(Q0), .D0(D0), .CLK(CLK), .PS(PS), 
	.CS(CS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:07:05 1994
`timescale 10 ps / 10 ps 
module FD58(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	CLK, PS, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CLK;
	input PS;
	input CS;

FD51 \$1I181  (.Q0(Q3), .D0(D3), .CLK(CLK), .PS(PS), 
	.CS(CS));
FD51 \$1I182  (.Q0(Q2), .D0(D2), .CLK(CLK), .PS(PS), 
	.CS(CS));
FD51 \$1I183  (.Q0(Q1), .D0(D1), .CLK(CLK), .PS(PS), 
	.CS(CS));
FD51 \$1I184  (.Q0(Q0), .D0(D0), .CLK(CLK), .PS(PS), 
	.CS(CS));
FD51 \$1I250  (.Q0(Q7), .D0(D7), .CLK(CLK), .PS(PS), 
	.CS(CS));
FD51 \$1I260  (.Q0(Q6), .D0(D6), .CLK(CLK), .PS(PS), 
	.CS(CS));
FD51 \$1I261  (.Q0(Q5), .D0(D5), .CLK(CLK), .PS(PS), 
	.CS(CS));
FD51 \$1I262  (.Q0(Q4), .D0(D4), .CLK(CLK), .PS(PS), 
	.CS(CS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:07:08 1994
`timescale 10 ps / 10 ps 
module FD61(
	Q0, D0, TI0, CLK, 
	TE);

	output Q0;
	input D0;
	input TI0;
	input CLK;
	input TE;

AND2 \$1I16  (.Z0(\$1N7 ), .A0(\$1N22 ), .A1(D0));
AND2 \$1I17  (.Z0(\$1N8 ), .A0(TI0), .A1(TE));
FD11 \$1I2  (.Q0(Q0), .D0(\$1N4 ), .CLK(CLK));
INV \$1I21  (.ZN0(\$1N22 ), .A0(TE));
OR2 \$1I3  (.Z0(\$1N4 ), .A0(\$1N8 ), .A1(\$1N7 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:07:12 1994
`timescale 10 ps / 10 ps 
module FD64(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	TI0, TI1, TI2, TI3, 
	CLK, TE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input CLK;
	input TE;

FD61 \$1I181  (.Q0(Q3), .D0(D3), .TI0(TI3), .CLK(CLK), 
	.TE(TE));
FD61 \$1I182  (.Q0(Q2), .D0(D2), .TI0(TI2), .CLK(CLK), 
	.TE(TE));
FD61 \$1I183  (.Q0(Q1), .D0(D1), .TI0(TI1), .CLK(CLK), 
	.TE(TE));
FD61 \$1I184  (.Q0(Q0), .D0(D0), .TI0(TI0), .CLK(CLK), 
	.TE(TE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:07:16 1994
`timescale 10 ps / 10 ps 
module FD68(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	TI0, TI1, TI2, TI3, 
	TI4, TI5, TI6, TI7, 
	CLK, TE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input TI4;
	input TI5;
	input TI6;
	input TI7;
	input CLK;
	input TE;

FD61 \$1I181  (.Q0(Q3), .D0(D3), .TI0(TI3), .CLK(CLK), 
	.TE(TE));
FD61 \$1I182  (.Q0(Q2), .D0(D2), .TI0(TI2), .CLK(CLK), 
	.TE(TE));
FD61 \$1I183  (.Q0(Q1), .D0(D1), .TI0(TI1), .CLK(CLK), 
	.TE(TE));
FD61 \$1I184  (.Q0(Q0), .D0(D0), .TI0(TI0), .CLK(CLK), 
	.TE(TE));
FD61 \$1I242  (.Q0(Q6), .D0(D6), .TI0(TI6), .CLK(CLK), 
	.TE(TE));
FD61 \$1I243  (.Q0(Q5), .D0(D5), .TI0(TI5), .CLK(CLK), 
	.TE(TE));
FD61 \$1I248  (.Q0(Q4), .D0(D4), .TI0(TI4), .CLK(CLK), 
	.TE(TE));
FD61 \$1I257  (.Q0(Q7), .D0(D7), .TI0(TI7), .CLK(CLK), 
	.TE(TE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:07:19 1994
`timescale 10 ps / 10 ps 
module FD71(
	Q0, D0, TI0, CLK, 
	CD, TE);

	output Q0;
	input D0;
	input TI0;
	input CLK;
	input CD;
	input TE;

AND2 \$1I16  (.Z0(\$1N7 ), .A0(\$1N22 ), .A1(D0));
AND2 \$1I17  (.Z0(\$1N8 ), .A0(TI0), .A1(TE));
FD21 \$1I2  (.Q0(Q0), .D0(\$1N4 ), .CLK(CLK), .CD(CD));
INV \$1I21  (.ZN0(\$1N22 ), .A0(TE));
OR2 \$1I3  (.Z0(\$1N4 ), .A0(\$1N8 ), .A1(\$1N7 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:07:22 1994
`timescale 10 ps / 10 ps 
module FD74(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	TI0, TI1, TI2, TI3, 
	CLK, CD, TE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input CLK;
	input CD;
	input TE;

FD71 \$1I181  (.Q0(Q3), .D0(D3), .TI0(TI3), .CLK(CLK), 
	.CD(CD), .TE(TE));
FD71 \$1I182  (.Q0(Q2), .D0(D2), .TI0(TI2), .CLK(CLK), 
	.CD(CD), .TE(TE));
FD71 \$1I183  (.Q0(Q1), .D0(D1), .TI0(TI1), .CLK(CLK), 
	.CD(CD), .TE(TE));
FD71 \$1I184  (.Q0(Q0), .D0(D0), .TI0(TI0), .CLK(CLK), 
	.CD(CD), .TE(TE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:07:26 1994
`timescale 10 ps / 10 ps 
module FD78(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	TI0, TI1, TI2, TI3, 
	TI4, TI5, TI6, TI7, 
	CLK, CD, TE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input TI4;
	input TI5;
	input TI6;
	input TI7;
	input CLK;
	input CD;
	input TE;

FD71 \$1I181  (.Q0(Q3), .D0(D3), .TI0(TI3), .CLK(CLK), 
	.CD(CD), .TE(TE));
FD71 \$1I182  (.Q0(Q2), .D0(D2), .TI0(TI2), .CLK(CLK), 
	.CD(CD), .TE(TE));
FD71 \$1I183  (.Q0(Q1), .D0(D1), .TI0(TI1), .CLK(CLK), 
	.CD(CD), .TE(TE));
FD71 \$1I184  (.Q0(Q0), .D0(D0), .TI0(TI0), .CLK(CLK), 
	.CD(CD), .TE(TE));
FD71 \$1I242  (.Q0(Q6), .D0(D6), .TI0(TI6), .CLK(CLK), 
	.CD(CD), .TE(TE));
FD71 \$1I243  (.Q0(Q5), .D0(D5), .TI0(TI5), .CLK(CLK), 
	.CD(CD), .TE(TE));
FD71 \$1I248  (.Q0(Q4), .D0(D4), .TI0(TI4), .CLK(CLK), 
	.CD(CD), .TE(TE));
FD71 \$1I257  (.Q0(Q7), .D0(D7), .TI0(TI7), .CLK(CLK), 
	.CD(CD), .TE(TE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:07:29 1994
`timescale 10 ps / 10 ps 
module FD81(
	Q0, D0, TI0, CLK, 
	PS, TE);

	output Q0;
	input D0;
	input TI0;
	input CLK;
	input PS;
	input TE;

AND2 \$1I16  (.Z0(\$1N7 ), .A0(\$1N22 ), .A1(D0));
AND2 \$1I17  (.Z0(\$1N8 ), .A0(TI0), .A1(TE));
FD11 \$1I2  (.Q0(Q0), .D0(\$1N4 ), .CLK(CLK));
INV \$1I21  (.ZN0(\$1N22 ), .A0(TE));
OR3 \$1I31  (.Z0(\$1N4 ), .A0(\$1N8 ), .A1(\$1N7 ), .A2(PS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:07:32 1994
`timescale 10 ps / 10 ps 
module FD84(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	TI0, TI1, TI2, TI3, 
	CLK, PS, TE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input CLK;
	input PS;
	input TE;

FD81 \$1I239  (.Q0(Q2), .D0(D2), .TI0(TI2), .CLK(CLK), 
	.PS(PS), .TE(TE));
FD81 \$1I252  (.Q0(Q3), .D0(D3), .TI0(TI3), .CLK(CLK), 
	.PS(PS), .TE(TE));
FD81 \$1I253  (.Q0(Q1), .D0(D1), .TI0(TI1), .CLK(CLK), 
	.PS(PS), .TE(TE));
FD81 \$1I254  (.Q0(Q0), .D0(D0), .TI0(TI0), .CLK(CLK), 
	.PS(PS), .TE(TE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:07:36 1994
`timescale 10 ps / 10 ps 
module FD88(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	TI0, TI1, TI2, TI3, 
	TI4, TI5, TI6, TI7, 
	CLK, PS, TE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input TI4;
	input TI5;
	input TI6;
	input TI7;
	input CLK;
	input PS;
	input TE;

FD81 \$1I181  (.Q0(Q7), .D0(D7), .TI0(TI7), .CLK(CLK), 
	.PS(PS), .TE(TE));
FD81 \$1I182  (.Q0(Q6), .D0(D6), .TI0(TI6), .CLK(CLK), 
	.PS(PS), .TE(TE));
FD81 \$1I183  (.Q0(Q5), .D0(D5), .TI0(TI5), .CLK(CLK), 
	.PS(PS), .TE(TE));
FD81 \$1I184  (.Q0(Q4), .D0(D4), .TI0(TI4), .CLK(CLK), 
	.PS(PS), .TE(TE));
FD81 \$1I239  (.Q0(Q2), .D0(D2), .TI0(TI2), .CLK(CLK), 
	.PS(PS), .TE(TE));
FD81 \$1I252  (.Q0(Q3), .D0(D3), .TI0(TI3), .CLK(CLK), 
	.PS(PS), .TE(TE));
FD81 \$1I253  (.Q0(Q1), .D0(D1), .TI0(TI1), .CLK(CLK), 
	.PS(PS), .TE(TE));
FD81 \$1I254  (.Q0(Q0), .D0(D0), .TI0(TI0), .CLK(CLK), 
	.PS(PS), .TE(TE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:07:39 1994
`timescale 10 ps / 10 ps 
module FD91(
	Q0, D0, TI0, CLK, 
	PS, CD, TE);

	output Q0;
	input D0;
	input TI0;
	input CLK;
	input PS;
	input CD;
	input TE;

AND2 \$1I16  (.Z0(\$1N7 ), .A0(\$1N22 ), .A1(D0));
AND2 \$1I17  (.Z0(\$1N8 ), .A0(TI0), .A1(TE));
FD21 \$1I2  (.Q0(Q0), .D0(\$1N4 ), .CLK(CLK), .CD(CD));
INV \$1I21  (.ZN0(\$1N22 ), .A0(TE));
OR3 \$1I31  (.Z0(\$1N4 ), .A0(\$1N8 ), .A1(\$1N7 ), .A2(PS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:07:43 1994
`timescale 10 ps / 10 ps 
module FD94(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	TI0, TI1, TI2, TI3, 
	CLK, PS, CD, TE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input CLK;
	input PS;
	input CD;
	input TE;

FD91 \$1I181  (.Q0(Q3), .D0(D3), .TI0(TI3), .CLK(CLK), 
	.PS(PS), .CD(CD), .TE(TE));
FD91 \$1I182  (.Q0(Q2), .D0(D2), .TI0(TI2), .CLK(CLK), 
	.PS(PS), .CD(CD), .TE(TE));
FD91 \$1I183  (.Q0(Q1), .D0(D1), .TI0(TI1), .CLK(CLK), 
	.PS(PS), .CD(CD), .TE(TE));
FD91 \$1I184  (.Q0(Q0), .D0(D0), .TI0(TI0), .CLK(CLK), 
	.PS(PS), .CD(CD), .TE(TE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:07:47 1994
`timescale 10 ps / 10 ps 
module FD98(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	TI0, TI1, TI2, TI3, 
	TI4, TI5, TI6, TI7, 
	CLK, PS, CD, TE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input TI4;
	input TI5;
	input TI6;
	input TI7;
	input CLK;
	input PS;
	input CD;
	input TE;

FD91 \$1I181  (.Q0(Q3), .D0(D3), .TI0(TI3), .CLK(CLK), 
	.PS(PS), .CD(CD), .TE(TE));
FD91 \$1I182  (.Q0(Q2), .D0(D2), .TI0(TI2), .CLK(CLK), 
	.PS(PS), .CD(CD), .TE(TE));
FD91 \$1I183  (.Q0(Q1), .D0(D1), .TI0(TI1), .CLK(CLK), 
	.PS(PS), .CD(CD), .TE(TE));
FD91 \$1I184  (.Q0(Q0), .D0(D0), .TI0(TI0), .CLK(CLK), 
	.PS(PS), .CD(CD), .TE(TE));
FD91 \$1I250  (.Q0(Q7), .D0(D7), .TI0(TI7), .CLK(CLK), 
	.PS(PS), .CD(CD), .TE(TE));
FD91 \$1I260  (.Q0(Q6), .D0(D6), .TI0(TI6), .CLK(CLK), 
	.PS(PS), .CD(CD), .TE(TE));
FD91 \$1I261  (.Q0(Q5), .D0(D5), .TI0(TI5), .CLK(CLK), 
	.PS(PS), .CD(CD), .TE(TE));
FD91 \$1I262  (.Q0(Q4), .D0(D4), .TI0(TI4), .CLK(CLK), 
	.PS(PS), .CD(CD), .TE(TE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:07:49 1994
`timescale 10 ps / 10 ps 
module FDA1(
	Q0, D0, TI0, CLK, 
	PS, CS, TE);

	output Q0;
	input D0;
	input TI0;
	input CLK;
	input PS;
	input CS;
	input TE;

FD11 \$1I2  (.Q0(Q0), .D0(\$1N4 ), .CLK(CLK));
INV \$1I21  (.ZN0(\$1N22 ), .A0(TE));
OR3 \$1I31  (.Z0(\$1N4 ), .A0(\$1N8 ), .A1(\$1N7 ), .A2(PS));
AND3 \$1I34  (.Z0(\$1N7 ), .A0(\$1N22 ), .A1(D0), .A2(\$1N37 ));
AND3 \$1I35  (.Z0(\$1N8 ), .A0(TI0), .A1(TE), .A2(\$1N37 ));
INV \$1I36  (.ZN0(\$1N37 ), .A0(CS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:07:53 1994
`timescale 10 ps / 10 ps 
module FDA4(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	TI0, TI1, TI2, TI3, 
	CLK, PS, CS, TE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input CLK;
	input PS;
	input CS;
	input TE;

FDA1 \$1I181  (.Q0(Q3), .D0(D3), .TI0(TI3), .CLK(CLK), 
	.PS(PS), .CS(CS), .TE(TE));
FDA1 \$1I182  (.Q0(Q2), .D0(D2), .TI0(TI2), .CLK(CLK), 
	.PS(PS), .CS(CS), .TE(TE));
FDA1 \$1I183  (.Q0(Q1), .D0(D1), .TI0(TI1), .CLK(CLK), 
	.PS(PS), .CS(CS), .TE(TE));
FDA1 \$1I184  (.Q0(Q0), .D0(D0), .TI0(TI0), .CLK(CLK), 
	.PS(PS), .CS(CS), .TE(TE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:07:58 1994
`timescale 10 ps / 10 ps 
module FDA8(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	TI0, TI1, TI2, TI3, 
	TI4, TI5, TI6, TI7, 
	CLK, PS, CS, TE);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input TI4;
	input TI5;
	input TI6;
	input TI7;
	input CLK;
	input PS;
	input CS;
	input TE;

FDA1 \$1I181  (.Q0(Q3), .D0(D3), .TI0(TI3), .CLK(CLK), 
	.PS(PS), .CS(CS), .TE(TE));
FDA1 \$1I182  (.Q0(Q2), .D0(D2), .TI0(TI2), .CLK(CLK), 
	.PS(PS), .CS(CS), .TE(TE));
FDA1 \$1I183  (.Q0(Q1), .D0(D1), .TI0(TI1), .CLK(CLK), 
	.PS(PS), .CS(CS), .TE(TE));
FDA1 \$1I184  (.Q0(Q0), .D0(D0), .TI0(TI0), .CLK(CLK), 
	.PS(PS), .CS(CS), .TE(TE));
FDA1 \$1I250  (.Q0(Q7), .D0(D7), .TI0(TI7), .CLK(CLK), 
	.PS(PS), .CS(CS), .TE(TE));
FDA1 \$1I260  (.Q0(Q6), .D0(D6), .TI0(TI6), .CLK(CLK), 
	.PS(PS), .CS(CS), .TE(TE));
FDA1 \$1I261  (.Q0(Q5), .D0(D5), .TI0(TI5), .CLK(CLK), 
	.PS(PS), .CS(CS), .TE(TE));
FDA1 \$1I262  (.Q0(Q4), .D0(D4), .TI0(TI4), .CLK(CLK), 
	.PS(PS), .CS(CS), .TE(TE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Wed Mar 30 13:32:21 1994
`timescale 10 ps / 10 ps 
module FDB1(
	Q0, D0, CLK, SD);

	output Q0;
	input D0;
	input CLK;
	input SD;

FD21 \$1I1  (.Q0(\$1N14 ), .D0(\$1N10 ), .CLK(CLK), .CD(SD));
INV \$1I2  (.ZN0(Q0), .A0(\$1N14 ));
INV \$1I3  (.ZN0(\$1N10 ), .A0(D0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Wed Mar 30 13:32:31 1994
`timescale 10 ps / 10 ps 
module FDB4(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CLK, SD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CLK;
	input SD;

FDB1 \$1I181  (.Q0(Q3), .D0(D3), .CLK(CLK), .SD(SD));
FDB1 \$1I182  (.Q0(Q2), .D0(D2), .CLK(CLK), .SD(SD));
FDB1 \$1I183  (.Q0(Q1), .D0(D1), .CLK(CLK), .SD(SD));
FDB1 \$1I184  (.Q0(Q0), .D0(D0), .CLK(CLK), .SD(SD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Wed Mar 30 13:32:41 1994
`timescale 10 ps / 10 ps 
module FDB8(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	CLK, SD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CLK;
	input SD;

FDB1 \$1I181  (.Q0(Q3), .D0(D3), .CLK(CLK), .SD(SD));
FDB1 \$1I182  (.Q0(Q2), .D0(D2), .CLK(CLK), .SD(SD));
FDB1 \$1I183  (.Q0(Q1), .D0(D1), .CLK(CLK), .SD(SD));
FDB1 \$1I184  (.Q0(Q0), .D0(D0), .CLK(CLK), .SD(SD));
FDB1 \$1I242  (.Q0(Q6), .D0(D6), .CLK(CLK), .SD(SD));
FDB1 \$1I243  (.Q0(Q5), .D0(D5), .CLK(CLK), .SD(SD));
FDB1 \$1I248  (.Q0(Q4), .D0(D4), .CLK(CLK), .SD(SD));
FDB1 \$1I257  (.Q0(Q7), .D0(D7), .CLK(CLK), .SD(SD));
endmodule

/**************
*     FDC1    *
***************/


`timescale 10 ps / 10 ps
module FDC1 (Q0, D0, CLK, SD);

  input   CLK, D0, SD;
  output  Q0;
  supply1 reset;

  not  blk0 (t1, reset);
  or   blk1 (t2, t1, SD);

  DFF_FDC blk2 (Q0, D0, CLK, t2);   

 
     
endmodule

/**************
*     FDC1E    *
***************/


`timescale 10 ps / 10 ps
module FDC1E (Q0, D0, CLK, EN, SD);

  input   CLK, D0, EN, SD;
  output  Q0;
  supply1 reset;

  not  blk0 (t1, reset);
  or   blk1 (t2, t1, SD);

  DFF_FDCE blk2 (Q0, D0, CLK, EN, t2);   

 
     
endmodule
`timescale 10 ps / 10 ps
module FDC4(
	CLK, D0, D1, D2, D3, SD, Q0, Q1, Q2, Q3);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



FDC1 \$1I225  (.Q0 (Q3), .D0 (D3), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I224  (.Q0 (Q2), .D0 (D2), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I223  (.Q0 (Q1), .D0 (D1), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I222  (.Q0 (Q0), .D0 (D0), .CLK (CLK), 
	.SD (SD));
endmodule
`timescale 10 ps / 10 ps
module FDC4E(
	CLK, D0, D1, D2, D3, EN, SD, Q0, Q1, Q2, Q3);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



FDC1E \$1I221  (.Q0 (Q3), .D0 (D3), .CLK (CLK), 
	.SD (SD), .EN (EN));
FDC1E \$1I220  (.Q0 (Q2), .D0 (D2), .CLK (CLK), 
	.SD (SD), .EN (EN));
FDC1E \$1I219  (.Q0 (Q1), .D0 (D1), .CLK (CLK), 
	.SD (SD), .EN (EN));
FDC1E \$1I218  (.Q0 (Q0), .D0 (D0), .CLK (CLK), 
	.SD (SD), .EN (EN));
endmodule
`timescale 10 ps / 10 ps
module FDC8(
	CLK, D0, D1, D2, D3, D4, D5, D6, D7, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



FDC1 \$1I280  (.Q0 (Q7), .D0 (D7), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I279  (.Q0 (Q6), .D0 (D6), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I278  (.Q0 (Q5), .D0 (D5), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I277  (.Q0 (Q4), .D0 (D4), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I276  (.Q0 (Q3), .D0 (D3), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I275  (.Q0 (Q2), .D0 (D2), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I274  (.Q0 (Q1), .D0 (D1), .CLK (CLK), 
	.SD (SD));
FDC1 \$1I273  (.Q0 (Q0), .D0 (D0), .CLK (CLK), 
	.SD (SD));
endmodule
`timescale 10 ps / 10 ps
module FDC8E(
	CLK, D0, D1, D2, D3, D4, D5, D6, D7, EN, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input EN;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



FDC1E \$1I268  (.Q0 (Q4), .D0 (D4), .CLK (CLK), 
	.SD (SD), .EN (EN));
FDC1E \$1I267  (.Q0 (Q5), .D0 (D5), .CLK (CLK), 
	.SD (SD), .EN (EN));
FDC1E \$1I266  (.Q0 (Q6), .D0 (D6), .CLK (CLK), 
	.SD (SD), .EN (EN));
FDC1E \$1I265  (.Q0 (Q7), .D0 (D7), .CLK (CLK), 
	.SD (SD), .EN (EN));
FDC1E \$1I264  (.Q0 (Q3), .D0 (D3), .CLK (CLK), 
	.SD (SD), .EN (EN));
FDC1E \$1I263  (.Q0 (Q2), .D0 (D2), .CLK (CLK), 
	.SD (SD), .EN (EN));
FDC1E \$1I262  (.Q0 (Q1), .D0 (D1), .CLK (CLK), 
	.SD (SD), .EN (EN));
FDC1E \$1I261  (.Q0 (Q0), .D0 (D0), .CLK (CLK), 
	.SD (SD), .EN (EN));
endmodule

/**************
*     FDE1    *
***************/


`timescale 10 ps / 10 ps
module FDE1 (Q0, D0, CLK, CD, SD);

  input   CLK, D0, CD, SD;
  output  Q0;

  /**********************
  supply1 reset;

  not  blk0 (t1, reset);
  or   blk1 (t2, t1, SD);
  **********************/

  DFF_FDE blk2 (Q0, D0, CLK, CD, SD);   

 
     
endmodule

/**************
*     FDE1E   *
***************/


`timescale 10 ps / 10 ps
module FDE1E (Q0, D0, CLK, EN, CD, SD);

  input   CLK, D0, EN, CD, SD;
  output  Q0;

  /**********************
  supply1 reset;

  not  blk0 (t1, reset);
  or   blk1 (t2, t1, SD);
  **********************/

  DFF_FDEE blk1 (Q0, D0, CLK, EN, CD, SD);   

 
     
endmodule
`timescale 10 ps / 10 ps
module FDE4(
	CD, CLK, D0, D1, D2, D3, SD, Q0, Q1, Q2, Q3);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



FDE1 \$1I221  (.Q0 (Q3), .D0 (D3), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I220  (.Q0 (Q2), .D0 (D2), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I219  (.Q0 (Q1), .D0 (D1), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I218  (.Q0 (Q0), .D0 (D0), .CLK (CLK), 
	.SD (SD), .CD (CD));
endmodule
`timescale 10 ps / 10 ps
module FDE4E(
	CD, CLK, D0, D1, D2, D3, EN, SD, Q0, Q1, Q2, Q3);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



FDE1E \$1I225  (.Q0 (Q3), .D0 (D3), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
FDE1E \$1I224  (.Q0 (Q2), .D0 (D2), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
FDE1E \$1I223  (.Q0 (Q1), .D0 (D1), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
FDE1E \$1I222  (.Q0 (Q0), .D0 (D0), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
endmodule
`timescale 10 ps / 10 ps
module FDE8(
	CD, CLK, D0, D1, D2, D3, D4, D5, D6, D7, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



FDE1 \$1I268  (.Q0 (Q7), .D0 (D7), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I267  (.Q0 (Q6), .D0 (D6), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I266  (.Q0 (Q5), .D0 (D5), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I265  (.Q0 (Q4), .D0 (D4), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I264  (.Q0 (Q3), .D0 (D3), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I263  (.Q0 (Q2), .D0 (D2), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I262  (.Q0 (Q1), .D0 (D1), .CLK (CLK), 
	.SD (SD), .CD (CD));
FDE1 \$1I261  (.Q0 (Q0), .D0 (D0), .CLK (CLK), 
	.SD (SD), .CD (CD));
endmodule
`timescale 10 ps / 10 ps
module FDE8E(
	CD, CLK, D0, D1, D2, D3, D4, D5, D6, D7, EN, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input EN;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



FDE1E \$1I259  (.Q0 (Q5), .D0 (D5), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
FDE1E \$1I258  (.Q0 (Q6), .D0 (D6), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
FDE1E \$1I254  (.Q0 (Q0), .D0 (D0), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
FDE1E \$1I260  (.Q0 (Q4), .D0 (D4), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
FDE1E \$1I257  (.Q0 (Q7), .D0 (D7), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
FDE1E \$1I256  (.Q0 (Q2), .D0 (D2), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
FDE1E \$1I253  (.Q0 (Q3), .D0 (D3), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
FDE1E \$1I255  (.Q0 (Q1), .D0 (D1), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:00 1994
`timescale 10 ps / 10 ps 
module FJK11(
	Q0, J0, K0, CLK);

	output Q0;
	input J0;
	input K0;
	input CLK;

FD11 \$1I56  (.Q0(\$1N94 ), .D0(\$1N80 ), .CLK(CLK));
NAND2 \$1I58  (.ZN0(\$1N67 ), .A0(\$1N71 ), .A1(J0));
OR2 \$1I59  (.Z0(\$1N69 ), .A0(\$1N71 ), .A1(K0));
NAND2 \$1I60  (.ZN0(\$1N80 ), .A0(\$1N67 ), .A1(\$1N69 ));
INV \$1I72  (.ZN0(\$1N71 ), .A0(\$1N94 ));
BUF \$1I91  (.Z0(Q0), .A0(\$1N94 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:02 1994
`timescale 10 ps / 10 ps 
module FJK21(
	Q0, J0, K0, CLK, 
	CD);

	output Q0;
	input J0;
	input K0;
	input CLK;
	input CD;

FD21 \$1I56  (.Q0(\$1N77 ), .D0(\$1N80 ), .CLK(CLK), .CD(CD));
NAND2 \$1I58  (.ZN0(\$1N67 ), .A0(\$1N71 ), .A1(J0));
OR2 \$1I59  (.Z0(\$1N69 ), .A0(\$1N71 ), .A1(K0));
NAND2 \$1I60  (.ZN0(\$1N80 ), .A0(\$1N67 ), .A1(\$1N69 ));
INV \$1I72  (.ZN0(\$1N71 ), .A0(\$1N77 ));
BUF \$1I93  (.Z0(Q0), .A0(\$1N77 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:05 1994
`timescale 10 ps / 10 ps 
module FJK31(
	Q0, J0, K0, TI0, 
	CLK, TE);

	output Q0;
	input J0;
	input K0;
	input TI0;
	input CLK;
	input TE;

INV \$1I100  (.ZN0(\$1N101 ), .A0(TE));
BUF \$1I108  (.Z0(Q0), .A0(\$1N77 ));
FD11 \$1I56  (.Q0(\$1N77 ), .D0(\$1N92 ), .CLK(CLK));
NAND2 \$1I58  (.ZN0(\$1N67 ), .A0(\$1N71 ), .A1(J0));
OR2 \$1I59  (.Z0(\$1N69 ), .A0(\$1N71 ), .A1(K0));
NAND2 \$1I60  (.ZN0(\$1N80 ), .A0(\$1N67 ), .A1(\$1N69 ));
INV \$1I72  (.ZN0(\$1N71 ), .A0(\$1N77 ));
OR2 \$1I91  (.Z0(\$1N92 ), .A0(\$1N96 ), .A1(\$1N97 ));
AND2 \$1I94  (.Z0(\$1N97 ), .A0(TI0), .A1(TE));
AND2 \$1I95  (.Z0(\$1N96 ), .A0(\$1N80 ), .A1(\$1N101 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:07 1994
`timescale 10 ps / 10 ps 
module FJK41(
	Q0, J0, K0, TI0, 
	CLK, CD, TE);

	output Q0;
	input J0;
	input K0;
	input TI0;
	input CLK;
	input CD;
	input TE;

INV \$1I100  (.ZN0(\$1N101 ), .A0(TE));
BUF \$1I110  (.Z0(Q0), .A0(\$1N77 ));
FD21 \$1I56  (.Q0(\$1N77 ), .D0(\$1N92 ), .CLK(CLK), .CD(CD));
NAND2 \$1I58  (.ZN0(\$1N67 ), .A0(\$1N71 ), .A1(J0));
OR2 \$1I59  (.Z0(\$1N69 ), .A0(\$1N71 ), .A1(K0));
NAND2 \$1I60  (.ZN0(\$1N80 ), .A0(\$1N67 ), .A1(\$1N69 ));
INV \$1I72  (.ZN0(\$1N71 ), .A0(\$1N77 ));
OR2 \$1I91  (.Z0(\$1N92 ), .A0(\$1N96 ), .A1(\$1N97 ));
AND2 \$1I94  (.Z0(\$1N97 ), .A0(TI0), .A1(TE));
AND2 \$1I95  (.Z0(\$1N96 ), .A0(\$1N80 ), .A1(\$1N101 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:09 1994
`timescale 10 ps / 10 ps 
module FJK51(
	Q0, J0, K0, CLK, 
	PS, CD);

	output Q0;
	input J0;
	input K0;
	input CLK;
	input PS;
	input CD;

FD21 \$1I52  (.Q0(\$1N68 ), .D0(\$1N87 ), .CLK(CLK), .CD(CD));
NAND2 \$1I56  (.ZN0(\$1N85 ), .A0(\$1N61 ), .A1(\$1N63 ));
NAND2 \$1I59  (.ZN0(\$1N61 ), .A0(\$1N72 ), .A1(J0));
OR2 \$1I60  (.Z0(\$1N63 ), .A0(\$1N72 ), .A1(K0));
INV \$1I73  (.ZN0(\$1N72 ), .A0(\$1N68 ));
OR2 \$1I84  (.Z0(\$1N87 ), .A0(\$1N85 ), .A1(PS));
BUF \$1I98  (.Z0(Q0), .A0(\$1N68 ));
endmodule
`timescale 10 ps / 10 ps
module FJK61(
	CLK, J0, K0, SD, Q0);


	input CLK;
	input J0;
	input K0;
	input SD;
	output Q0;



FDC1 \$1I56  (.Q0 (\$1N77 ), .D0 (\$1N80 ), .CLK (CLK), 
	.SD (SD));
OR2 \$1I59  (.Z0 (\$1N69 ), .A0 (\$1N71 ), .A1 (K0));
NAND2 \$1I58  (.ZN0 (\$1N67 ), .A0 (\$1N71 ), .A1 (J0));
NAND2 \$1I60  (.ZN0 (\$1N80 ), .A0 (\$1N67 ), .A1 (\$1N69 ));
INV \$1I72  (.ZN0 (\$1N71 ), .A0 (\$1N77 ));
BUF \$1I93  (.Z0 (Q0), .A0 (\$1N77 ));
endmodule
`timescale 10 ps / 10 ps
module FJK64(
	CLK, J0, J1, J2, J3, K0, K1, K2, K3, SD, Q0, Q1, Q2, Q3);


	input CLK;
	input J0;
	input J1;
	input J2;
	input J3;
	input K0;
	input K1;
	input K2;
	input K3;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



FJK61 \$1I99  (.Q0 (Q0), .J0 (J0), .K0 (K0), 
	.CLK (CLK), .SD (SD));
FJK61 \$1I100  (.Q0 (Q1), .J0 (J1), .K0 (K1), 
	.CLK (CLK), .SD (SD));
FJK61 \$1I101  (.Q0 (Q2), .J0 (J2), .K0 (K2), 
	.CLK (CLK), .SD (SD));
FJK61 \$1I102  (.Q0 (Q3), .J0 (J3), .K0 (K3), 
	.CLK (CLK), .SD (SD));
endmodule
`timescale 10 ps / 10 ps
module FJK68(
	CLK, J0, J1, J2, J3, J4, J5, J6, J7, K0, K1, K2, K3, K4, K5, K6, K7, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CLK;
	input J0;
	input J1;
	input J2;
	input J3;
	input J4;
	input J5;
	input J6;
	input J7;
	input K0;
	input K1;
	input K2;
	input K3;
	input K4;
	input K5;
	input K6;
	input K7;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



FJK61 \$1I160  (.Q0 (Q4), .J0 (J4), .K0 (K4), 
	.CLK (CLK), .SD (SD));
FJK61 \$1I161  (.Q0 (Q5), .J0 (J5), .K0 (K5), 
	.CLK (CLK), .SD (SD));
FJK61 \$1I162  (.Q0 (Q6), .J0 (J6), .K0 (K6), 
	.CLK (CLK), .SD (SD));
FJK61 \$1I163  (.Q0 (Q7), .J0 (J7), .K0 (K7), 
	.CLK (CLK), .SD (SD));
FJK61 \$1I99  (.Q0 (Q0), .J0 (J0), .K0 (K0), 
	.CLK (CLK), .SD (SD));
FJK61 \$1I100  (.Q0 (Q1), .J0 (J1), .K0 (K1), 
	.CLK (CLK), .SD (SD));
FJK61 \$1I101  (.Q0 (Q2), .J0 (J2), .K0 (K2), 
	.CLK (CLK), .SD (SD));
FJK61 \$1I102  (.Q0 (Q3), .J0 (J3), .K0 (K3), 
	.CLK (CLK), .SD (SD));
endmodule
`timescale 10 ps / 10 ps
module FJK71(
	CD, CLK, J0, K0, SD, Q0);


	input CD;
	input CLK;
	input J0;
	input K0;
	input SD;
	output Q0;



FDE1 \$1I102  (.Q0 (\$1N77 ), .D0 (\$1N80 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
OR2 \$1I59  (.Z0 (\$1N69 ), .A0 (\$1N71 ), .A1 (K0));
NAND2 \$1I58  (.ZN0 (\$1N67 ), .A0 (\$1N71 ), .A1 (J0));
NAND2 \$1I60  (.ZN0 (\$1N80 ), .A0 (\$1N67 ), .A1 (\$1N69 ));
INV \$1I72  (.ZN0 (\$1N71 ), .A0 (\$1N77 ));
BUF \$1I93  (.Z0 (Q0), .A0 (\$1N77 ));
endmodule
`timescale 10 ps / 10 ps
module FJK71E(
	CD, CLK, EN, J0, K0, SD, Q0);


	input CD;
	input CLK;
	input EN;
	input J0;
	input K0;
	input SD;
	output Q0;



FDE1E \$1I105  (.Q0 (\$1N77 ), .D0 (\$1N80 ), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
NAND2 \$1I58  (.ZN0 (\$1N67 ), .A0 (\$1N71 ), .A1 (J0));
NAND2 \$1I60  (.ZN0 (\$1N80 ), .A0 (\$1N67 ), .A1 (\$1N69 ));
INV \$1I72  (.ZN0 (\$1N71 ), .A0 (\$1N77 ));
BUF \$1I93  (.Z0 (Q0), .A0 (\$1N77 ));
OR2 \$1I59  (.Z0 (\$1N69 ), .A0 (\$1N71 ), .A1 (K0));
endmodule
`timescale 10 ps / 10 ps
module FJK74(
	CD, CLK, J0, J1, J2, J3, K0, K1, K2, K3, SD, Q0, Q1, Q2, Q3);


	input CD;
	input CLK;
	input J0;
	input J1;
	input J2;
	input J3;
	input K0;
	input K1;
	input K2;
	input K3;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



FJK71 \$1I150  (.Q0 (Q3), .J0 (J3), .K0 (K3), 
	.CLK (CLK), .CD (CD), .SD (SD));
FJK71 \$1I148  (.Q0 (Q1), .J0 (J1), .K0 (K1), 
	.CLK (CLK), .CD (CD), .SD (SD));
FJK71 \$1I147  (.Q0 (Q0), .J0 (J0), .K0 (K0), 
	.CLK (CLK), .CD (CD), .SD (SD));
FJK71 \$1I149  (.Q0 (Q2), .J0 (J2), .K0 (K2), 
	.CLK (CLK), .CD (CD), .SD (SD));
endmodule
`timescale 10 ps / 10 ps
module FJK74E(
	CD, CLK, EN, J0, J1, J2, J3, K0, K1, K2, K3, SD, Q0, Q1, Q2, Q3);


	input CD;
	input CLK;
	input EN;
	input J0;
	input J1;
	input J2;
	input J3;
	input K0;
	input K1;
	input K2;
	input K3;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



FJK71E \$1I184  (.Q0 (Q3), .J0 (J3), .K0 (K3), 
	.CLK (CLK), .CD (CD), .SD (SD), 
	.EN (EN));
FJK71E \$1I159  (.Q0 (Q0), .J0 (J0), .K0 (K0), 
	.CLK (CLK), .CD (CD), .SD (SD), 
	.EN (EN));
FJK71E \$1I165  (.Q0 (Q1), .J0 (J1), .K0 (K1), 
	.CLK (CLK), .CD (CD), .SD (SD), 
	.EN (EN));
FJK71E \$1I177  (.Q0 (Q2), .J0 (J2), .K0 (K2), 
	.CLK (CLK), .CD (CD), .SD (SD), 
	.EN (EN));
endmodule
`timescale 10 ps / 10 ps
module FJK78(
	CD, CLK, J0, J1, J2, J3, J4, J5, J6, J7, K0, K1, K2, K3, K4, K5, K6, K7, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CD;
	input CLK;
	input J0;
	input J1;
	input J2;
	input J3;
	input J4;
	input J5;
	input J6;
	input J7;
	input K0;
	input K1;
	input K2;
	input K3;
	input K4;
	input K5;
	input K6;
	input K7;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



FJK71 \$1I159  (.Q0 (Q7), .J0 (J7), .K0 (K7), 
	.CLK (CLK), .CD (CD), .SD (SD));
FJK71 \$1I160  (.Q0 (Q5), .J0 (J5), .K0 (K5), 
	.CLK (CLK), .CD (CD), .SD (SD));
FJK71 \$1I161  (.Q0 (Q4), .J0 (J4), .K0 (K4), 
	.CLK (CLK), .CD (CD), .SD (SD));
FJK71 \$1I188  (.Q0 (Q6), .J0 (J6), .K0 (K6), 
	.CLK (CLK), .CD (CD), .SD (SD));
FJK71 \$1I150  (.Q0 (Q3), .J0 (J3), .K0 (K3), 
	.CLK (CLK), .CD (CD), .SD (SD));
FJK71 \$1I148  (.Q0 (Q1), .J0 (J1), .K0 (K1), 
	.CLK (CLK), .CD (CD), .SD (SD));
FJK71 \$1I147  (.Q0 (Q0), .J0 (J0), .K0 (K0), 
	.CLK (CLK), .CD (CD), .SD (SD));
FJK71 \$1I149  (.Q0 (Q2), .J0 (J2), .K0 (K2), 
	.CLK (CLK), .CD (CD), .SD (SD));
endmodule
`timescale 10 ps / 10 ps
module FJK78E(
	CD, CLK, EN, J0, J1, J2, J3, J4, J5, J6, J7, K0, K1, K2, K3, K4, K5, K6, K7, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CD;
	input CLK;
	input EN;
	input J0;
	input J1;
	input J2;
	input J3;
	input J4;
	input J5;
	input J6;
	input J7;
	input K0;
	input K1;
	input K2;
	input K3;
	input K4;
	input K5;
	input K6;
	input K7;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



FJK71E \$1I227  (.Q0 (Q7), .J0 (J7), .K0 (K7), 
	.CLK (CLK), .CD (CD), .SD (SD), 
	.EN (EN));
FJK71E \$1I236  (.Q0 (Q4), .J0 (J4), .K0 (K4), 
	.CLK (CLK), .CD (CD), .SD (SD), 
	.EN (EN));
FJK71E \$1I238  (.Q0 (Q5), .J0 (J5), .K0 (K5), 
	.CLK (CLK), .CD (CD), .SD (SD), 
	.EN (EN));
FJK71E \$1I239  (.Q0 (Q6), .J0 (J6), .K0 (K6), 
	.CLK (CLK), .CD (CD), .SD (SD), 
	.EN (EN));
FJK71E \$1I184  (.Q0 (Q3), .J0 (J3), .K0 (K3), 
	.CLK (CLK), .CD (CD), .SD (SD), 
	.EN (EN));
FJK71E \$1I159  (.Q0 (Q0), .J0 (J0), .K0 (K0), 
	.CLK (CLK), .CD (CD), .SD (SD), 
	.EN (EN));
FJK71E \$1I165  (.Q0 (Q1), .J0 (J1), .K0 (K1), 
	.CLK (CLK), .CD (CD), .SD (SD), 
	.EN (EN));
FJK71E \$1I177  (.Q0 (Q2), .J0 (J2), .K0 (K2), 
	.CLK (CLK), .CD (CD), .SD (SD), 
	.EN (EN));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:11 1994
`timescale 10 ps / 10 ps 
module FT11(
	Q0, D0, CLK, CD);

	output Q0;
	input D0;
	input CLK;
	input CD;

FD21 \$1I1  (.Q0(\$1N5 ), .D0(\$1N3 ), .CLK(CLK), .CD(CD));
BUF \$1I18  (.Z0(Q0), .A0(\$1N5 ));
XOR2 \$1I2  (.Z0(\$1N3 ), .A0(\$1N5 ), .A1(D0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:14 1994
`timescale 10 ps / 10 ps 
module FT21(
	Q0, D0, CLK, PS, 
	CS);

	output Q0;
	input D0;
	input CLK;
	input PS;
	input CS;

FD11 \$1I1  (.Q0(\$1N18 ), .D0(\$1N5 ), .CLK(CLK));
XOR2 \$1I2  (.Z0(\$1N9 ), .A0(\$1N18 ), .A1(D0));
INV \$1I24  (.ZN0(\$1N12 ), .A0(CS));
AND2 \$1I3  (.Z0(\$1N7 ), .A0(\$1N9 ), .A1(\$1N12 ));
BUF \$1I30  (.Z0(Q0), .A0(\$1N18 ));
OR2 \$1I4  (.Z0(\$1N5 ), .A0(\$1N7 ), .A1(PS));
endmodule

/**************
*     FTI21   *
***************/


`timescale 10 ps / 10 ps
module FTI21 (Q0, T0, CLK, CD);

  input   CLK, T0, CD;
  output  Q0;
  supply1 reset;

  not  blk0 (t1, reset);
  or   blk1 (t2, t1, CD);

  TFF_FD1 blk2 (Q0, T0, CLK, t2);   

 
     
endmodule

/**************
*    FTI21E   *
***************/


`timescale 10 ps / 10 ps
module FTI21E (Q0, T0, CLK, EN, CD);

  input   CLK, T0, EN, CD;
  output  Q0;
  supply1 reset;

  not  blk0 (t1, reset);
  or   blk1 (t2, t1, CD);

  TFF_FD1E blk2 (Q0, T0, CLK, EN, t2);   

 
     
endmodule

/**************
*     FTI31   *
***************/


`timescale 10 ps / 10 ps
module FTI31 (Q0, T0, CLK, SD);

  input   CLK, T0, SD;
  output  Q0;
  supply1 reset;

  not  blk0 (t1, reset);
  or   blk1 (t2, t1, SD);

  TFF_FD3 blk2 (Q0, T0, CLK, t2);   

 
     
endmodule

/**************


*    FTI31E   *


***************/

`timescale 10 ps / 10 ps

module FTI31E (Q0, T0, CLK, EN, SD);

  input   CLK, T0, EN, SD;
  output  Q0;
  supply1 reset;

  not  blk0 (t1, reset);
  or   blk1 (t2, t1, SD);

  TFF_FD3E blk2 (Q0, T0, CLK, EN, t2);   

endmodule

/**************
*     FTI41   *
***************/


`timescale 10 ps / 10 ps
module FTI41 (Q0, T0, CLK, CD, SD);

  input   CLK, T0, CD, SD;
  output  Q0;
  /*************
  supply1 reset;
  **************/


  TFF_FD4 blk1 (Q0, T0, CLK, CD, SD);   

 
     
endmodule

/**************

*    FTI41E   *

***************/

`timescale 10 ps / 10 ps

module FTI41E (Q0, T0, CLK, EN, CD, SD);

  input   CLK, T0, EN, CD, SD;
  output  Q0;

  /*************

  supply1 reset;

  **************/

  TFF_FD4E blk1 (Q0, T0, CLK, EN, CD, SD);   

endmodule

// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:16 1994
`timescale 10 ps / 10 ps 
module IB11(
	Z0, XI0);

	output Z0;
	input XI0;

XINPUT \$1I45  (.Z0(Z0), .XI0(XI0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:18 1994
`timescale 10 ps / 10 ps 
module ID11(
	Q0, XI0, CLK);

	output Q0;
	input XI0;
	input CLK;

XDFF1 \$1I117  (.Q0(Q0), .D0(\$1N119 ), .CLK(CLK));
XINPUT \$1I118  (.Z0(\$1N119 ), .XI0(XI0));
endmodule
`timescale 10 ps / 10 ps
module ID11E(
	CLK, EN, Q0, XI0);


	input CLK;
	input EN;
	output Q0;
	input XI0;



XDFF1E \$1I134  (.Q0 (Q0), .D0 (\$1N119 ), .CLK (CLK), 
	.EN (EN));
XINPUT \$1I118  (.Z0 (\$1N119 ), .XI0 (XI0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:20 1994
`timescale 10 ps / 10 ps 
module ID14(
	Q0, Q1, Q2, Q3, 
	XI0, XI1, XI2, XI3, 
	CLK);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input XI0;
	input XI1;
	input XI2;
	input XI3;
	input CLK;

ID11 \$1I128  (.Q0(Q3), .XI0(XI3), .CLK(CLK));
ID11 \$1I129  (.Q0(Q2), .XI0(XI2), .CLK(CLK));
ID11 \$1I130  (.Q0(Q1), .XI0(XI1), .CLK(CLK));
ID11 \$1I131  (.Q0(Q0), .XI0(XI0), .CLK(CLK));
endmodule
`timescale 10 ps / 10 ps
module ID14E(
	CLK, EN, Q0, Q1, Q2, Q3, XI0, XI1, XI2, XI3);


	input CLK;
	input EN;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input XI0;
	input XI1;
	input XI2;
	input XI3;



ID11E \$1I153  (.Q0 (Q3), .XI0 (XI3), .CLK (CLK), 
	.EN (EN));
ID11E \$1I152  (.Q0 (Q2), .XI0 (XI2), .CLK (CLK), 
	.EN (EN));
ID11E \$1I151  (.Q0 (Q1), .XI0 (XI1), .CLK (CLK), 
	.EN (EN));
ID11E \$1I150  (.Q0 (Q0), .XI0 (XI0), .CLK (CLK), 
	.EN (EN));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:23 1994
`timescale 10 ps / 10 ps 
module ID18(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XI0, XI1, XI2, XI3, 
	XI4, XI5, XI6, XI7, 
	CLK);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input XI0;
	input XI1;
	input XI2;
	input XI3;
	input XI4;
	input XI5;
	input XI6;
	input XI7;
	input CLK;

ID11 \$1I128  (.Q0(Q3), .XI0(XI3), .CLK(CLK));
ID11 \$1I129  (.Q0(Q2), .XI0(XI2), .CLK(CLK));
ID11 \$1I130  (.Q0(Q1), .XI0(XI1), .CLK(CLK));
ID11 \$1I131  (.Q0(Q0), .XI0(XI0), .CLK(CLK));
ID11 \$1I162  (.Q0(Q4), .XI0(XI4), .CLK(CLK));
ID11 \$1I163  (.Q0(Q5), .XI0(XI5), .CLK(CLK));
ID11 \$1I164  (.Q0(Q6), .XI0(XI6), .CLK(CLK));
ID11 \$1I165  (.Q0(Q7), .XI0(XI7), .CLK(CLK));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:25 1994
`timescale 10 ps / 10 ps 
module ID21(
	Q0, XI0, CLK);

	output Q0;
	input XI0;
	input CLK;

XDFF1 \$1I117  (.Q0(Q0), .D0(\$1N119 ), .CLK(\$1N126 ));
XINPUT \$1I118  (.Z0(\$1N119 ), .XI0(XI0));
XINV \$1I127  (.ZN0(\$1N126 ), .A0(CLK));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:28 1994
`timescale 10 ps / 10 ps 
module ID24(
	Q0, Q1, Q2, Q3, 
	XI0, XI1, XI2, XI3, 
	CLK);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input XI0;
	input XI1;
	input XI2;
	input XI3;
	input CLK;

ID21 \$1I128  (.Q0(Q3), .XI0(XI3), .CLK(CLK));
ID21 \$1I129  (.Q0(Q2), .XI0(XI2), .CLK(CLK));
ID21 \$1I130  (.Q0(Q1), .XI0(XI1), .CLK(CLK));
ID21 \$1I131  (.Q0(Q0), .XI0(XI0), .CLK(CLK));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:31 1994
`timescale 10 ps / 10 ps 
module ID28(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XI0, XI1, XI2, XI3, 
	XI4, XI5, XI6, XI7, 
	CLK);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input XI0;
	input XI1;
	input XI2;
	input XI3;
	input XI4;
	input XI5;
	input XI6;
	input XI7;
	input CLK;

ID21 \$1I128  (.Q0(Q3), .XI0(XI3), .CLK(CLK));
ID21 \$1I129  (.Q0(Q2), .XI0(XI2), .CLK(CLK));
ID21 \$1I130  (.Q0(Q1), .XI0(XI1), .CLK(CLK));
ID21 \$1I131  (.Q0(Q0), .XI0(XI0), .CLK(CLK));
ID21 \$1I162  (.Q0(Q4), .XI0(XI4), .CLK(CLK));
ID21 \$1I163  (.Q0(Q5), .XI0(XI5), .CLK(CLK));
ID21 \$1I164  (.Q0(Q6), .XI0(XI6), .CLK(CLK));
ID21 \$1I165  (.Q0(Q7), .XI0(XI7), .CLK(CLK));
endmodule
`timescale 10 ps / 10 ps
module ID31(
	CD, CLK, Q0, XI0);


	input CD;
	input CLK;
	output Q0;
	input XI0;



XINPUT \$1I118  (.Z0 (\$1N119 ), .XI0 (XI0));
XDFF2 \$1I117  (.Q0 (Q0), .D0 (\$1N119 ), .CLK (CLK), 
	.CD (CD));
endmodule
`timescale 10 ps / 10 ps
module ID31E(
	CD, CLK, EN, Q0, XI0);


	input CD;
	input CLK;
	input EN;
	output Q0;
	input XI0;



XDFF2E \$1I130  (.Q0 (Q0), .D0 (\$1N119 ), .CLK (CLK), 
	.CD (CD), .EN (EN));
XINPUT \$1I118  (.Z0 (\$1N119 ), .XI0 (XI0));
endmodule
`timescale 10 ps / 10 ps
module ID34(
	CD, CLK, Q0, Q1, Q2, Q3, XI0, XI1, XI2, XI3);


	input CD;
	input CLK;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input XI0;
	input XI1;
	input XI2;
	input XI3;



ID31 \$1I153  (.Q0 (Q3), .XI0 (XI3), .CLK (CLK), 
	.CD (CD));
ID31 \$1I152  (.Q0 (Q2), .XI0 (XI2), .CLK (CLK), 
	.CD (CD));
ID31 \$1I151  (.Q0 (Q1), .XI0 (XI1), .CLK (CLK), 
	.CD (CD));
ID31 \$1I150  (.Q0 (Q0), .XI0 (XI0), .CLK (CLK), 
	.CD (CD));
endmodule
`timescale 10 ps / 10 ps
module ID34E(
	CD, CLK, EN, Q0, Q1, Q2, Q3, XI0, XI1, XI2, XI3);


	input CD;
	input CLK;
	input EN;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input XI0;
	input XI1;
	input XI2;
	input XI3;



ID31E \$1I153  (.Q0 (Q3), .XI0 (XI3), .CLK (CLK), 
	.CD (CD), .EN (EN));
ID31E \$1I152  (.Q0 (Q2), .XI0 (XI2), .CLK (CLK), 
	.CD (CD), .EN (EN));
ID31E \$1I151  (.Q0 (Q1), .XI0 (XI1), .CLK (CLK), 
	.CD (CD), .EN (EN));
ID31E \$1I150  (.Q0 (Q0), .XI0 (XI0), .CLK (CLK), 
	.CD (CD), .EN (EN));
endmodule
`timescale 10 ps / 10 ps
module ID41(
	CLK, Q0, SD, XI0);


	input CLK;
	output Q0;
	input SD;
	input XI0;



XDFF3 \$1I130  (.Q0 (Q0), .D0 (\$1N119 ), .CLK (CLK), 
	.SD (SD));
XINPUT \$1I118  (.Z0 (\$1N119 ), .XI0 (XI0));
endmodule
`timescale 10 ps / 10 ps
module ID41E(
	CLK, EN, Q0, SD, XI0);


	input CLK;
	input EN;
	output Q0;
	input SD;
	input XI0;



XINPUT \$1I118  (.Z0 (\$1N119 ), .XI0 (XI0));
XDFF3E \$1I134  (.Q0 (Q0), .D0 (\$1N119 ), .CLK (CLK), 
	.SD (SD), .EN (EN));
endmodule
`timescale 10 ps / 10 ps
module ID44(
	CLK, Q0, Q1, Q2, Q3, SD, XI0, XI1, XI2, XI3);


	input CLK;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input SD;
	input XI0;
	input XI1;
	input XI2;
	input XI3;



ID41 \$1I153  (.Q0 (Q3), .XI0 (XI3), .CLK (CLK), 
	.SD (SD));
ID41 \$1I152  (.Q0 (Q2), .XI0 (XI2), .CLK (CLK), 
	.SD (SD));
ID41 \$1I151  (.Q0 (Q1), .XI0 (XI1), .CLK (CLK), 
	.SD (SD));
ID41 \$1I150  (.Q0 (Q0), .XI0 (XI0), .CLK (CLK), 
	.SD (SD));
endmodule
`timescale 10 ps / 10 ps
module ID44E(
	CLK, EN, Q0, Q1, Q2, Q3, SD, XI0, XI1, XI2, XI3);


	input CLK;
	input EN;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input SD;
	input XI0;
	input XI1;
	input XI2;
	input XI3;



ID41E \$1I153  (.Q0 (Q3), .XI0 (XI3), .CLK (CLK), 
	.SD (SD), .EN (EN));
ID41E \$1I152  (.Q0 (Q2), .XI0 (XI2), .CLK (CLK), 
	.SD (SD), .EN (EN));
ID41E \$1I151  (.Q0 (Q1), .XI0 (XI1), .CLK (CLK), 
	.SD (SD), .EN (EN));
ID41E \$1I150  (.Q0 (Q0), .XI0 (XI0), .CLK (CLK), 
	.SD (SD), .EN (EN));
endmodule
`timescale 10 ps / 10 ps
module ID51(
	CD, CLK, Q0, SD, XI0);


	input CD;
	input CLK;
	output Q0;
	input SD;
	input XI0;



XDFF4 \$1I117  (.Q0 (Q0), .D0 (\$1N119 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
XINPUT \$1I118  (.Z0 (\$1N119 ), .XI0 (XI0));
endmodule
`timescale 10 ps / 10 ps
module ID51E(
	CD, CLK, EN, Q0, SD, XI0);


	input CD;
	input CLK;
	input EN;
	output Q0;
	input SD;
	input XI0;



XDFF4E \$1I138  (.Q0 (Q0), .D0 (\$1N119 ), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
XINPUT \$1I118  (.Z0 (\$1N119 ), .XI0 (XI0));
endmodule
`timescale 10 ps / 10 ps
module ID54(
	CD, CLK, Q0, Q1, Q2, Q3, SD, XI0, XI1, XI2, XI3);


	input CD;
	input CLK;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input SD;
	input XI0;
	input XI1;
	input XI2;
	input XI3;



ID51 \$1I153  (.Q0 (Q3), .XI0 (XI3), .CLK (CLK), 
	.CD (CD), .SD (SD));
ID51 \$1I152  (.Q0 (Q2), .XI0 (XI2), .CLK (CLK), 
	.CD (CD), .SD (SD));
ID51 \$1I151  (.Q0 (Q1), .XI0 (XI1), .CLK (CLK), 
	.CD (CD), .SD (SD));
ID51 \$1I150  (.Q0 (Q0), .XI0 (XI0), .CLK (CLK), 
	.CD (CD), .SD (SD));
endmodule
`timescale 10 ps / 10 ps
module ID54E(
	CD, CLK, EN, Q0, Q1, Q2, Q3, SD, XI0, XI1, XI2, XI3);


	input CD;
	input CLK;
	input EN;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input SD;
	input XI0;
	input XI1;
	input XI2;
	input XI3;



ID51E \$1I153  (.Q0 (Q3), .XI0 (XI3), .CLK (CLK), 
	.CD (CD), .SD (SD), .EN (EN));
ID51E \$1I152  (.Q0 (Q2), .XI0 (XI2), .CLK (CLK), 
	.CD (CD), .SD (SD), .EN (EN));
ID51E \$1I151  (.Q0 (Q1), .XI0 (XI1), .CLK (CLK), 
	.CD (CD), .SD (SD), .EN (EN));
ID51E \$1I150  (.Q0 (Q0), .XI0 (XI0), .CLK (CLK), 
	.CD (CD), .SD (SD), .EN (EN));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:33 1994
`timescale 10 ps / 10 ps 
module IL11(
	Q0, XI0, G);

	output Q0;
	input XI0;
	input G;

XDL1 \$1I242  (.Q0(Q0), .D0(\$1N244 ), .G(G));
XINPUT \$1I243  (.Z0(\$1N244 ), .XI0(XI0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:36 1994
`timescale 10 ps / 10 ps 
module IL14(
	Q0, Q1, Q2, Q3, 
	XI0, XI1, XI2, XI3, 
	G);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input XI0;
	input XI1;
	input XI2;
	input XI3;
	input G;

IL11 \$1I128  (.Q0(Q3), .XI0(XI3), .G(G));
IL11 \$1I129  (.Q0(Q2), .XI0(XI2), .G(G));
IL11 \$1I130  (.Q0(Q1), .XI0(XI1), .G(G));
IL11 \$1I131  (.Q0(Q0), .XI0(XI0), .G(G));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:38 1994
`timescale 10 ps / 10 ps 
module IL18(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XI0, XI1, XI2, XI3, 
	XI4, XI5, XI6, XI7, 
	G);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input XI0;
	input XI1;
	input XI2;
	input XI3;
	input XI4;
	input XI5;
	input XI6;
	input XI7;
	input G;

IL11 \$1I128  (.Q0(Q3), .XI0(XI3), .G(G));
IL11 \$1I129  (.Q0(Q2), .XI0(XI2), .G(G));
IL11 \$1I130  (.Q0(Q1), .XI0(XI1), .G(G));
IL11 \$1I131  (.Q0(Q0), .XI0(XI0), .G(G));
IL11 \$1I162  (.Q0(Q4), .XI0(XI4), .G(G));
IL11 \$1I163  (.Q0(Q5), .XI0(XI5), .G(G));
IL11 \$1I164  (.Q0(Q6), .XI0(XI6), .G(G));
IL11 \$1I165  (.Q0(Q7), .XI0(XI7), .G(G));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:41 1994
`timescale 10 ps / 10 ps 
module IL21(
	Q0, XI0, G);

	output Q0;
	input XI0;
	input G;

XDL1 \$1I242  (.Q0(Q0), .D0(\$1N244 ), .G(\$1N250 ));
XINPUT \$1I243  (.Z0(\$1N244 ), .XI0(XI0));
XINV \$1I251  (.ZN0(\$1N250 ), .A0(G));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:43 1994
`timescale 10 ps / 10 ps 
module IL24(
	Q0, Q1, Q2, Q3, 
	XI0, XI1, XI2, XI3, 
	G);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input XI0;
	input XI1;
	input XI2;
	input XI3;
	input G;

IL21 \$1I128  (.Q0(Q3), .XI0(XI3), .G(G));
IL21 \$1I129  (.Q0(Q2), .XI0(XI2), .G(G));
IL21 \$1I130  (.Q0(Q1), .XI0(XI1), .G(G));
IL21 \$1I131  (.Q0(Q0), .XI0(XI0), .G(G));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:47 1994
`timescale 10 ps / 10 ps 
module IL28(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	XI0, XI1, XI2, XI3, 
	XI4, XI5, XI6, XI7, 
	G);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input XI0;
	input XI1;
	input XI2;
	input XI3;
	input XI4;
	input XI5;
	input XI6;
	input XI7;
	input G;

IL21 \$1I128  (.Q0(Q3), .XI0(XI3), .G(G));
IL21 \$1I129  (.Q0(Q2), .XI0(XI2), .G(G));
IL21 \$1I130  (.Q0(Q1), .XI0(XI1), .G(G));
IL21 \$1I131  (.Q0(Q0), .XI0(XI0), .G(G));
IL21 \$1I162  (.Q0(Q4), .XI0(XI4), .G(G));
IL21 \$1I163  (.Q0(Q5), .XI0(XI5), .G(G));
IL21 \$1I164  (.Q0(Q6), .XI0(XI6), .G(G));
IL21 \$1I165  (.Q0(Q7), .XI0(XI7), .G(G));
endmodule
`timescale 10 ps / 10 ps
module IL31(
	CD, G, Q0, XI0);


	input CD;
	input G;
	output Q0;
	input XI0;



XDL2 \$1I253  (.Q0 (Q0), .D0 (\$1N244 ), .G (G), 
	.CD (CD));
XINPUT \$1I243  (.Z0 (\$1N244 ), .XI0 (XI0));
endmodule
`timescale 10 ps / 10 ps
module IL34(
	CD, G, Q0, Q1, Q2, Q3, XI0, XI1, XI2, XI3);


	input CD;
	input G;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input XI0;
	input XI1;
	input XI2;
	input XI3;



IL31 \$1I130  (.Q0 (Q1), .XI0 (XI1), .G (G), 
	.CD (CD));
IL31 \$1I129  (.Q0 (Q2), .XI0 (XI2), .G (G), 
	.CD (CD));
IL31 \$1I128  (.Q0 (Q3), .XI0 (XI3), .G (G), 
	.CD (CD));
IL31 \$1I131  (.Q0 (Q0), .XI0 (XI0), .G (G), 
	.CD (CD));
endmodule
`timescale 10 ps / 10 ps
module IL41(
	G, Q0, SD, XI0);


	input G;
	output Q0;
	input SD;
	input XI0;



XDL3 \$1I257  (.Q0 (Q0), .D0 (\$1N244 ), .G (G), 
	.SD (SD));
XINPUT \$1I243  (.Z0 (\$1N244 ), .XI0 (XI0));
endmodule
`timescale 10 ps / 10 ps
module IL44(
	G, Q0, Q1, Q2, Q3, SD, XI0, XI1, XI2, XI3);


	input G;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input SD;
	input XI0;
	input XI1;
	input XI2;
	input XI3;



IL41 \$1I130  (.Q0 (Q1), .XI0 (XI1), .G (G), 
	.SD (SD));
IL41 \$1I129  (.Q0 (Q2), .XI0 (XI2), .G (G), 
	.SD (SD));
IL41 \$1I128  (.Q0 (Q3), .XI0 (XI3), .G (G), 
	.SD (SD));
IL41 \$1I131  (.Q0 (Q0), .XI0 (XI0), .G (G), 
	.SD (SD));
endmodule
`timescale 10 ps / 10 ps
module IL51(
	CD, G, Q0, SD, XI0);


	input CD;
	input G;
	output Q0;
	input SD;
	input XI0;



XDL4 \$1I257  (.Q0 (Q0), .D0 (\$1N244 ), .G (G), 
	.SD (SD), .CD (CD));
XINPUT \$1I243  (.Z0 (\$1N244 ), .XI0 (XI0));
endmodule
`timescale 10 ps / 10 ps
module IL54(
	CD, G, Q0, Q1, Q2, Q3, SD, XI0, XI1, XI2, XI3);


	input CD;
	input G;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input SD;
	input XI0;
	input XI1;
	input XI2;
	input XI3;



IL51 \$1I130  (.Q0 (Q1), .XI0 (XI1), .G (G), 
	.CD (CD), .SD (SD));
IL51 \$1I129  (.Q0 (Q2), .XI0 (XI2), .G (G), 
	.CD (CD), .SD (SD));
IL51 \$1I128  (.Q0 (Q3), .XI0 (XI3), .G (G), 
	.CD (CD), .SD (SD));
IL51 \$1I131  (.Q0 (Q0), .XI0 (XI0), .G (G), 
	.CD (CD), .SD (SD));
endmodule
/*
* Translated from EDIF description INV                                        *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 41  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  INV lib :  INV                              *
*/
/*
* Library INV                                                                 *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell INV"                                                                  *
*/
`timescale 10 ps / 10 ps
module INV (ZN0, A0);

    input  A0;

    output  ZN0;



    not
        \$1I1  (ZN0, A0);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule

/***********
*   IT11   *
***********/

`timescale 10 ps / 10 ps

module IT11 (O0, A0, OE);

    input  A0;
    input  OE;

    output  O0;

    bufif1
        I1  (O0, A0, OE);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,OE *> 
    )
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
`timescale 10 ps / 10 ps
module IT14(
	A0, A1, A2, A3, O0, O1, O2, O3, OE);


	input A0;
	input A1;
	input A2;
	input A3;
	output O0;
	output O1;
	output O2;
	output O3;
	input OE;



IT11 \$1I26  (.O0 (O0), .A0 (A0), .OE (OE));
IT11 \$1I28  (.O0 (O2), .A0 (A2), .OE (OE));
IT11 \$1I29  (.O0 (O3), .A0 (A3), .OE (OE));
IT11 \$1I27  (.O0 (O1), .A0 (A1), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module IT18(
	A0, A1, A2, A3, A4, A5, A6, A7, O0, O1, O2, O3, O4, O5, O6, O7, OE);


	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	output O0;
	output O1;
	output O2;
	output O3;
	output O4;
	output O5;
	output O6;
	output O7;
	input OE;



IT11 \$1I70  (.O0 (O4), .A0 (A4), .OE (OE));
IT11 \$1I71  (.O0 (O6), .A0 (A6), .OE (OE));
IT11 \$1I72  (.O0 (O7), .A0 (A7), .OE (OE));
IT11 \$1I73  (.O0 (O5), .A0 (A5), .OE (OE));
IT11 \$1I26  (.O0 (O0), .A0 (A0), .OE (OE));
IT11 \$1I28  (.O0 (O2), .A0 (A2), .OE (OE));
IT11 \$1I29  (.O0 (O3), .A0 (A3), .OE (OE));
IT11 \$1I27  (.O0 (O1), .A0 (A1), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module IT21(
	A0, O0, OE);


	input A0;
	output O0;
	input OE;



IT11 \$1I27  (.O0 (O0), .A0 (A0), .OE (\$1N31 ));
INV \$1I28  (.ZN0 (\$1N31 ), .A0 (OE));
endmodule
`timescale 10 ps / 10 ps
module IT24(
	A0, A1, A2, A3, O0, O1, O2, O3, OE);


	input A0;
	input A1;
	input A2;
	input A3;
	output O0;
	output O1;
	output O2;
	output O3;
	input OE;



IT21 \$1I62  (.O0 (O1), .A0 (A1), .OE (OE));
IT21 \$1I61  (.O0 (O0), .A0 (A0), .OE (OE));
IT21 \$1I63  (.O0 (O2), .A0 (A2), .OE (OE));
IT21 \$1I64  (.O0 (O3), .A0 (A3), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module IT28(
	A0, A1, A2, A3, A4, A5, A6, A7, O0, O1, O2, O3, O4, O5, O6, O7, OE);


	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	output O0;
	output O1;
	output O2;
	output O3;
	output O4;
	output O5;
	output O6;
	output O7;
	input OE;



IT21 \$1I90  (.O0 (O7), .A0 (A7), .OE (OE));
IT21 \$1I88  (.O0 (O5), .A0 (A5), .OE (OE));
IT21 \$1I87  (.O0 (O4), .A0 (A4), .OE (OE));
IT21 \$1I86  (.O0 (O3), .A0 (A3), .OE (OE));
IT21 \$1I85  (.O0 (O2), .A0 (A2), .OE (OE));
IT21 \$1I84  (.O0 (O1), .A0 (A1), .OE (OE));
IT21 \$1I83  (.O0 (O0), .A0 (A0), .OE (OE));
IT21 \$1I89  (.O0 (O6), .A0 (A6), .OE (OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:50 1994
`timescale 10 ps / 10 ps 
module LD11(
	Q0, D0, G);

	output Q0;
	input D0;
	input G;

OR3 \$1I186  (.Z0(\$1N6 ), .A0(\$1N166 ), .A1(\$1N159 ), .A2(\$1N188 ));

/*
  SHFE \$1I220  (.REF(G), .DATA(D0));
*/

AND2 \$1I254  (.Z0(\$1N166 ), .A0(\$1N6 ), .A1(D0));
AND2 \$1I257  (.Z0(\$1N188 ), .A0(D0), .A1(G));
AND2 \$1I258  (.Z0(\$1N159 ), .A0(\$1N6 ), .A1(\$1N261 ));
INV \$1I260  (.ZN0(\$1N261 ), .A0(G));
/*
  PW \$1I267  (.PULSE(G));
*/
BUF \$1I270  (.Z0(Q0), .A0(\$1N6 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:54 1994
`timescale 10 ps / 10 ps 
module LD14(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	G);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input G;

LD11 \$1I181  (.Q0(Q3), .D0(D3), .G(G));
LD11 \$1I182  (.Q0(Q2), .D0(D2), .G(G));
LD11 \$1I183  (.Q0(Q1), .D0(D1), .G(G));
LD11 \$1I184  (.Q0(Q0), .D0(D0), .G(G));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:08:58 1994
`timescale 10 ps / 10 ps 
module LD18(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	G);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input G;

LD11 \$1I181  (.Q0(Q3), .D0(D3), .G(G));
LD11 \$1I182  (.Q0(Q2), .D0(D2), .G(G));
LD11 \$1I183  (.Q0(Q1), .D0(D1), .G(G));
LD11 \$1I184  (.Q0(Q0), .D0(D0), .G(G));
LD11 \$1I246  (.Q0(Q4), .D0(D4), .G(G));
LD11 \$1I247  (.Q0(Q5), .D0(D5), .G(G));
LD11 \$1I248  (.Q0(Q6), .D0(D6), .G(G));
LD11 \$1I249  (.Q0(Q7), .D0(D7), .G(G));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:00 1994
`timescale 10 ps / 10 ps 
module LD21(
	Q0, D0, G, CD);

	output Q0;
	input D0;
	input G;
	input CD;

OR3 \$1I186  (.Z0(\$1N6 ), .A0(\$1N166 ), .A1(\$1N159 ), .A2(\$1N188 ));
AND3 \$1I266  (.Z0(\$1N166 ), .A0(\$1N6 ), .A1(\$1N223 ), .A2(D0));
AND3 \$1I267  (.Z0(\$1N159 ), .A0(\$1N6 ), .A1(\$1N223 ), .A2(\$1N276 ));
AND3 \$1I268  (.Z0(\$1N188 ), .A0(D0), .A1(\$1N223 ), .A2(G));
INV \$1I274  (.ZN0(\$1N223 ), .A0(CD));
INV \$1I275  (.ZN0(\$1N276 ), .A0(G));
/*
  SHFE \$1I286  (.REF(G), .DATA(D0));
  PW \$1I287  (.PULSE(G));
  SHFE \$1I290  (.REF(\$1N223 ), .DATA(G));
  PW \$1I292  (.PULSE(\$1N223 ));
*/
BUF \$1I295  (.Z0(Q0), .A0(\$1N6 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:03 1994
`timescale 10 ps / 10 ps 
module LD24(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	G, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	input CD;

LD21 \$1I181  (.Q0(Q3), .D0(D3), .G(G), .CD(CD));
LD21 \$1I182  (.Q0(Q2), .D0(D2), .G(G), .CD(CD));
LD21 \$1I183  (.Q0(Q1), .D0(D1), .G(G), .CD(CD));
LD21 \$1I184  (.Q0(Q0), .D0(D0), .G(G), .CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:07 1994
`timescale 10 ps / 10 ps 
module LD28(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	G, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input G;
	input CD;

LD21 \$1I181  (.Q0(Q3), .D0(D3), .G(G), .CD(CD));
LD21 \$1I182  (.Q0(Q2), .D0(D2), .G(G), .CD(CD));
LD21 \$1I183  (.Q0(Q1), .D0(D1), .G(G), .CD(CD));
LD21 \$1I184  (.Q0(Q0), .D0(D0), .G(G), .CD(CD));
LD21 \$1I242  (.Q0(Q6), .D0(D6), .G(G), .CD(CD));
LD21 \$1I243  (.Q0(Q5), .D0(D5), .G(G), .CD(CD));
LD21 \$1I248  (.Q0(Q4), .D0(D4), .G(G), .CD(CD));
LD21 \$1I257  (.Q0(Q7), .D0(D7), .G(G), .CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:09 1994
`timescale 10 ps / 10 ps 
module LD31(
	Q0, D0, G, PD);

	output Q0;
	input D0;
	input G;
	input PD;

OR4 \$1I249  (.Z0(\$1N6 ), .A0(\$1N166 ), .A1(\$1N159 ), .A2(\$1N188 ), 
	.A3(PD));
AND2 \$1I279  (.Z0(\$1N166 ), .A0(\$1N6 ), .A1(D0));
AND2 \$1I280  (.Z0(\$1N159 ), .A0(\$1N6 ), .A1(\$1N283 ));
AND2 \$1I281  (.Z0(\$1N188 ), .A0(D0), .A1(G));
INV \$1I282  (.ZN0(\$1N283 ), .A0(G));
/*
  PW \$1I291  (.PULSE(G));
  PW \$1I292  (.PULSE(PD));
  SHFE \$1I295  (.REF(G), .DATA(D0));
  SHFE \$1I297  (.REF(PD), .DATA(G));
*/
BUF \$1I301  (.Z0(Q0), .A0(\$1N6 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:11 1994
`timescale 10 ps / 10 ps 
module LD34(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	G, PD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	input PD;

LD31 \$1I181  (.Q0(Q3), .D0(D3), .G(G), .PD(PD));
LD31 \$1I182  (.Q0(Q2), .D0(D2), .G(G), .PD(PD));
LD31 \$1I183  (.Q0(Q1), .D0(D1), .G(G), .PD(PD));
LD31 \$1I184  (.Q0(Q0), .D0(D0), .G(G), .PD(PD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:14 1994
`timescale 10 ps / 10 ps 
module LD38(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	G, PD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input G;
	input PD;

LD31 \$1I181  (.Q0(Q7), .D0(D7), .G(G), .PD(PD));
LD31 \$1I182  (.Q0(Q6), .D0(D6), .G(G), .PD(PD));
LD31 \$1I183  (.Q0(Q5), .D0(D5), .G(G), .PD(PD));
LD31 \$1I184  (.Q0(Q4), .D0(D4), .G(G), .PD(PD));
LD31 \$1I239  (.Q0(Q2), .D0(D2), .G(G), .PD(PD));
LD31 \$1I252  (.Q0(Q3), .D0(D3), .G(G), .PD(PD));
LD31 \$1I253  (.Q0(Q1), .D0(D1), .G(G), .PD(PD));
LD31 \$1I254  (.Q0(Q0), .D0(D0), .G(G), .PD(PD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:17 1994
`timescale 10 ps / 10 ps 
module LD41(
	Q0, D0, G, PD, 
	CD);

	output Q0;
	input D0;
	input G;
	input PD;
	input CD;

INV \$1I226  (.ZN0(\$1N223 ), .A0(CD));
AND3 \$1I277  (.Z0(\$1N166 ), .A0(\$1N6 ), .A1(\$1N223 ), .A2(D0));
AND3 \$1I278  (.Z0(\$1N159 ), .A0(\$1N6 ), .A1(\$1N223 ), .A2(\$1N293 ));
AND3 \$1I279  (.Z0(\$1N188 ), .A0(D0), .A1(\$1N223 ), .A2(G));
AND2 \$1I284  (.Z0(\$1N288 ), .A0(\$1N223 ), .A1(PD));
OR4 \$1I287  (.Z0(\$1N6 ), .A0(\$1N166 ), .A1(\$1N159 ), .A2(\$1N188 ), 
	.A3(\$1N288 ));
INV \$1I292  (.ZN0(\$1N293 ), .A0(G));
/*
  PW \$1I300  (.PULSE(G));
  PW \$1I301  (.PULSE(PD));
  PW \$1I302  (.PULSE(\$1N223 ));
  SHFE \$1I306  (.REF(\$1N223 ), .DATA(G));
  SHFE \$1I309  (.REF(PD), .DATA(G));
  SHFE \$1I311  (.REF(G), .DATA(D0));
*/
BUF \$1I314  (.Z0(Q0), .A0(\$1N6 ));

/*
SHFE \$1I318  (.REF(\$1N223 ), .DATA(PD));
*/
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:20 1994
`timescale 10 ps / 10 ps 
module LD44(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	G, PD, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	input PD;
	input CD;

LD41 \$1I181  (.Q0(Q3), .D0(D3), .G(G), .PD(PD), 
	.CD(CD));
LD41 \$1I182  (.Q0(Q2), .D0(D2), .G(G), .PD(PD), 
	.CD(CD));
LD41 \$1I183  (.Q0(Q1), .D0(D1), .G(G), .PD(PD), 
	.CD(CD));
LD41 \$1I184  (.Q0(Q0), .D0(D0), .G(G), .PD(PD), 
	.CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:24 1994
`timescale 10 ps / 10 ps 
module LD48(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	G, PD, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input G;
	input PD;
	input CD;

LD41 \$1I181  (.Q0(Q3), .D0(D3), .G(G), .PD(PD), 
	.CD(CD));
LD41 \$1I182  (.Q0(Q2), .D0(D2), .G(G), .PD(PD), 
	.CD(CD));
LD41 \$1I183  (.Q0(Q1), .D0(D1), .G(G), .PD(PD), 
	.CD(CD));
LD41 \$1I184  (.Q0(Q0), .D0(D0), .G(G), .PD(PD), 
	.CD(CD));
LD41 \$1I250  (.Q0(Q7), .D0(D7), .G(G), .PD(PD), 
	.CD(CD));
LD41 \$1I260  (.Q0(Q6), .D0(D6), .G(G), .PD(PD), 
	.CD(CD));
LD41 \$1I261  (.Q0(Q5), .D0(D5), .G(G), .PD(PD), 
	.CD(CD));
LD41 \$1I262  (.Q0(Q4), .D0(D4), .G(G), .PD(PD), 
	.CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:26 1994
`timescale 10 ps / 10 ps 
module LD51(
	Q0, D0, G, PD, 
	CD);

	output Q0;
	input D0;
	input G;
	input PD;
	input CD;

INV \$1I226  (.ZN0(\$1N223 ), .A0(CD));
OR4 \$1I249  (.Z0(\$1N6 ), .A0(\$1N166 ), .A1(\$1N159 ), .A2(\$1N188 ), 
	.A3(PD));
AND3 \$1I274  (.Z0(\$1N166 ), .A0(\$1N6 ), .A1(\$1N223 ), .A2(D0));
AND3 \$1I275  (.Z0(\$1N159 ), .A0(\$1N6 ), .A1(\$1N223 ), .A2(\$1N278 ));
AND3 \$1I276  (.Z0(\$1N188 ), .A0(D0), .A1(\$1N223 ), .A2(G));
INV \$1I277  (.ZN0(\$1N278 ), .A0(G));

/*
PW \$1I290  (.PULSE(\$1N223 ));
PW \$1I291  (.PULSE(PD));
PW \$1I292  (.PULSE(G));
SHFE \$1I293  (.REF(\$1N223 ), .DATA(G));
SHFE \$1I296  (.REF(PD), .DATA(G));
SHFE \$1I298  (.REF(G), .DATA(D0));
*/

BUF \$1I299  (.Z0(Q0), .A0(\$1N6 ));

/*
SHFE \$1I303  (.REF(\$1N223 ), .DATA(PD));
*/
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:29 1994
`timescale 10 ps / 10 ps 
module LD54(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	G, PD, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	input PD;
	input CD;

LD51 \$1I181  (.Q0(Q3), .D0(D3), .G(G), .PD(PD), 
	.CD(CD));
LD51 \$1I182  (.Q0(Q2), .D0(D2), .G(G), .PD(PD), 
	.CD(CD));
LD51 \$1I183  (.Q0(Q1), .D0(D1), .G(G), .PD(PD), 
	.CD(CD));
LD51 \$1I184  (.Q0(Q0), .D0(D0), .G(G), .PD(PD), 
	.CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:32 1994
`timescale 10 ps / 10 ps 
module LD58(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	G, PD, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input G;
	input PD;
	input CD;

LD51 \$1I181  (.Q0(Q3), .D0(D3), .G(G), .PD(PD), 
	.CD(CD));
LD51 \$1I182  (.Q0(Q2), .D0(D2), .G(G), .PD(PD), 
	.CD(CD));
LD51 \$1I183  (.Q0(Q1), .D0(D1), .G(G), .PD(PD), 
	.CD(CD));
LD51 \$1I184  (.Q0(Q0), .D0(D0), .G(G), .PD(PD), 
	.CD(CD));
LD51 \$1I250  (.Q0(Q7), .D0(D7), .G(G), .PD(PD), 
	.CD(CD));
LD51 \$1I260  (.Q0(Q6), .D0(D6), .G(G), .PD(PD), 
	.CD(CD));
LD51 \$1I261  (.Q0(Q5), .D0(D5), .G(G), .PD(PD), 
	.CD(CD));
LD51 \$1I262  (.Q0(Q4), .D0(D4), .G(G), .PD(PD), 
	.CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:35 1994
`timescale 10 ps / 10 ps 
module LD61(
	Q0, D0, TI0, G, 
	TG);

	output Q0;
	input D0;
	input TI0;
	input G;
	input TG;

/*
  SHFE \$1I220  (.REF(G), .DATA(D0));
*/

AND2 \$1I257  (.Z0(\$1N188 ), .A0(D0), .A1(G));
INV \$1I260  (.ZN0(\$1N290 ), .A0(G));

/*
PW \$1I267  (.PULSE(G));
*/

BUF \$1I270  (.Z0(Q0), .A0(\$1N6 ));
OR5 \$1I274  (.Z0(\$1N6 ), .A0(\$1N166 ), .A1(\$1N285 ), .A2(\$1N159 ), 
	.A3(\$1N276 ), .A4(\$1N188 ));
AND2 \$1I275  (.Z0(\$1N276 ), .A0(TI0), .A1(TG));
AND3 \$1I281  (.Z0(\$1N159 ), .A0(\$1N6 ), .A1(\$1N290 ), .A2(\$1N288 ));
AND3 \$1I282  (.Z0(\$1N285 ), .A0(\$1N6 ), .A1(\$1N290 ), .A2(TI0));
AND3 \$1I284  (.Z0(\$1N166 ), .A0(\$1N6 ), .A1(\$1N288 ), .A2(D0));
INV \$1I287  (.ZN0(\$1N288 ), .A0(TG));

/*
PW \$1I305  (.PULSE(TG));
SHFE \$1I306  (.REF(TG), .DATA(TI0));
*/


endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:39 1994
`timescale 10 ps / 10 ps 
module LD64(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	TI0, TI1, TI2, TI3, 
	G, TG);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input G;
	input TG;

LD61 \$1I181  (.Q0(Q3), .D0(D3), .TI0(TI3), .G(G), 
	.TG(TG));
LD61 \$1I182  (.Q0(Q2), .D0(D2), .TI0(TI2), .G(G), 
	.TG(TG));
LD61 \$1I183  (.Q0(Q1), .D0(D1), .TI0(TI1), .G(G), 
	.TG(TG));
LD61 \$1I184  (.Q0(Q0), .D0(D0), .TI0(TI0), .G(G), 
	.TG(TG));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:42 1994
`timescale 10 ps / 10 ps 
module LD68(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	TI0, TI1, TI2, TI3, 
	TI4, TI5, TI6, TI7, 
	G, TG);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input TI4;
	input TI5;
	input TI6;
	input TI7;
	input G;
	input TG;

LD61 \$1I181  (.Q0(Q3), .D0(D3), .TI0(TI3), .G(G), 
	.TG(TG));
LD61 \$1I182  (.Q0(Q2), .D0(D2), .TI0(TI2), .G(G), 
	.TG(TG));
LD61 \$1I183  (.Q0(Q1), .D0(D1), .TI0(TI1), .G(G), 
	.TG(TG));
LD61 \$1I184  (.Q0(Q0), .D0(D0), .TI0(TI0), .G(G), 
	.TG(TG));
LD61 \$1I242  (.Q0(Q6), .D0(D6), .TI0(TI6), .G(G), 
	.TG(TG));
LD61 \$1I243  (.Q0(Q5), .D0(D5), .TI0(TI5), .G(G), 
	.TG(TG));
LD61 \$1I248  (.Q0(Q4), .D0(D4), .TI0(TI4), .G(G), 
	.TG(TG));
LD61 \$1I257  (.Q0(Q7), .D0(D7), .TI0(TI7), .G(G), 
	.TG(TG));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:45 1994
`timescale 10 ps / 10 ps 
module LD71(
	Q0, D0, TI0, G, 
	CD, TG);

	output Q0;
	input D0;
	input TI0;
	input G;
	input CD;
	input TG;

AND3 \$1I268  (.Z0(\$1N188 ), .A0(D0), .A1(\$1N223 ), .A2(G));
INV \$1I274  (.ZN0(\$1N223 ), .A0(CD));
INV \$1I275  (.ZN0(\$1N276 ), .A0(G));

/*
SHFE \$1I286  (.REF(G), .DATA(D0));
PW \$1I287  (.PULSE(G));
SHFE \$1I290  (.REF(\$1N223 ), .DATA(G));
PW \$1I292  (.PULSE(\$1N223 ));
*/

BUF \$1I295  (.Z0(Q0), .A0(\$1N6 ));
OR5 \$1I300  (.Z0(\$1N6 ), .A0(\$1N166 ), .A1(\$1N309 ), .A2(\$1N159 ), 
	.A3(\$1N311 ), .A4(\$1N188 ));
AND3 \$1I301  (.Z0(\$1N311 ), .A0(\$1N223 ), .A1(TI0), .A2(TG));
AND4 \$1I306  (.Z0(\$1N159 ), .A0(\$1N6 ), .A1(\$1N223 ), .A2(\$1N276 ), 
	.A3(\$1N315 ));
AND4 \$1I307  (.Z0(\$1N309 ), .A0(\$1N6 ), .A1(\$1N223 ), .A2(\$1N276 ), 
	.A3(TI0));
AND4 \$1I308  (.Z0(\$1N166 ), .A0(\$1N6 ), .A1(\$1N223 ), .A2(\$1N315 ), 
	.A3(D0));
INV \$1I316  (.ZN0(\$1N315 ), .A0(TG));

/*
PW \$1I323  (.PULSE(TG));
SHFE \$1I324  (.REF(TG), .DATA(TI0));
SHFE \$1I326  (.REF(\$1N223 ), .DATA(TG));
*/

endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:49 1994
`timescale 10 ps / 10 ps 
module LD74(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	TI0, TI1, TI2, TI3, 
	G, CD, TG);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input G;
	input CD;
	input TG;

LD71 \$1I181  (.Q0(Q3), .D0(D3), .TI0(TI3), .G(G), 
	.CD(CD), .TG(TG));
LD71 \$1I182  (.Q0(Q2), .D0(D2), .TI0(TI2), .G(G), 
	.CD(CD), .TG(TG));
LD71 \$1I183  (.Q0(Q1), .D0(D1), .TI0(TI1), .G(G), 
	.CD(CD), .TG(TG));
LD71 \$1I184  (.Q0(Q0), .D0(D0), .TI0(TI0), .G(G), 
	.CD(CD), .TG(TG));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:53 1994
`timescale 10 ps / 10 ps 
module LD78(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	TI0, TI1, TI2, TI3, 
	TI4, TI5, TI6, TI7, 
	G, CD, TG);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input TI4;
	input TI5;
	input TI6;
	input TI7;
	input G;
	input CD;
	input TG;

LD71 \$1I181  (.Q0(Q3), .D0(D3), .TI0(TI3), .G(G), 
	.CD(CD), .TG(TG));
LD71 \$1I182  (.Q0(Q2), .D0(D2), .TI0(TI2), .G(G), 
	.CD(CD), .TG(TG));
LD71 \$1I183  (.Q0(Q1), .D0(D1), .TI0(TI1), .G(G), 
	.CD(CD), .TG(TG));
LD71 \$1I184  (.Q0(Q0), .D0(D0), .TI0(TI0), .G(G), 
	.CD(CD), .TG(TG));
LD71 \$1I242  (.Q0(Q6), .D0(D6), .TI0(TI6), .G(G), 
	.CD(CD), .TG(TG));
LD71 \$1I243  (.Q0(Q5), .D0(D5), .TI0(TI5), .G(G), 
	.CD(CD), .TG(TG));
LD71 \$1I248  (.Q0(Q4), .D0(D4), .TI0(TI4), .G(G), 
	.CD(CD), .TG(TG));
LD71 \$1I257  (.Q0(Q7), .D0(D7), .TI0(TI7), .G(G), 
	.CD(CD), .TG(TG));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:56 1994
`timescale 10 ps / 10 ps 
module LD81(
	Q0, D0, TI0, G, 
	PD, TG);

	output Q0;
	input D0;
	input TI0;
	input G;
	input PD;
	input TG;

AND2 \$1I281  (.Z0(\$1N188 ), .A0(D0), .A1(G));
INV \$1I282  (.ZN0(\$1N283 ), .A0(G));

/*
PW \$1I291  (.PULSE(G));
PW \$1I292  (.PULSE(PD));
SHFE \$1I295  (.REF(G), .DATA(D0));
SHFE \$1I297  (.REF(PD), .DATA(G));
*/

BUF \$1I301  (.Z0(Q0), .A0(\$1N6 ));
AND2 \$1I305  (.Z0(\$1N307 ), .A0(TI0), .A1(TG));
OR6 \$1I306  (.Z0(\$1N6 ), .A0(\$1N166 ), .A1(\$1N159 ), .A2(\$1N315 ), 
	.A3(\$1N307 ), .A4(\$1N188 ), .A5(PD));
AND3 \$1I314  (.Z0(\$1N315 ), .A0(\$1N6 ), .A1(\$1N283 ), .A2(\$1N327 ));
AND3 \$1I317  (.Z0(\$1N159 ), .A0(\$1N6 ), .A1(\$1N283 ), .A2(TI0));
AND3 \$1I322  (.Z0(\$1N166 ), .A0(\$1N6 ), .A1(\$1N327 ), .A2(D0));
INV \$1I326  (.ZN0(\$1N327 ), .A0(TG));

/*
PW \$1I332  (.PULSE(TG));
SHFE \$1I333  (.REF(TG), .DATA(TI0));
SHFE \$1I335  (.REF(PD), .DATA(TG));
*/

endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:09:59 1994
`timescale 10 ps / 10 ps 
module LD84(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	TI0, TI1, TI2, TI3, 
	G, PD, TG);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input G;
	input PD;
	input TG;

LD81 \$1I239  (.Q0(Q2), .D0(D2), .TI0(TI2), .G(G), 
	.PD(PD), .TG(TG));
LD81 \$1I252  (.Q0(Q3), .D0(D3), .TI0(TI3), .G(G), 
	.PD(PD), .TG(TG));
LD81 \$1I253  (.Q0(Q1), .D0(D1), .TI0(TI1), .G(G), 
	.PD(PD), .TG(TG));
LD81 \$1I254  (.Q0(Q0), .D0(D0), .TI0(TI0), .G(G), 
	.PD(PD), .TG(TG));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:10:03 1994
`timescale 10 ps / 10 ps 
module LD88(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	TI0, TI1, TI2, TI3, 
	TI4, TI5, TI6, TI7, 
	G, PD, TG);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input TI4;
	input TI5;
	input TI6;
	input TI7;
	input G;
	input PD;
	input TG;

LD81 \$1I181  (.Q0(Q7), .D0(D7), .TI0(TI7), .G(G), 
	.PD(PD), .TG(TG));
LD81 \$1I182  (.Q0(Q6), .D0(D6), .TI0(TI6), .G(G), 
	.PD(PD), .TG(TG));
LD81 \$1I183  (.Q0(Q5), .D0(D5), .TI0(TI5), .G(G), 
	.PD(PD), .TG(TG));
LD81 \$1I184  (.Q0(Q4), .D0(D4), .TI0(TI4), .G(G), 
	.PD(PD), .TG(TG));
LD81 \$1I239  (.Q0(Q2), .D0(D2), .TI0(TI2), .G(G), 
	.PD(PD), .TG(TG));
LD81 \$1I252  (.Q0(Q3), .D0(D3), .TI0(TI3), .G(G), 
	.PD(PD), .TG(TG));
LD81 \$1I253  (.Q0(Q1), .D0(D1), .TI0(TI1), .G(G), 
	.PD(PD), .TG(TG));
LD81 \$1I254  (.Q0(Q0), .D0(D0), .TI0(TI0), .G(G), 
	.PD(PD), .TG(TG));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:10:06 1994
`timescale 10 ps / 10 ps 
module LD91(
	Q0, D0, TI0, G, 
	PD, CD, TG);

	output Q0;
	input D0;
	input TI0;
	input G;
	input PD;
	input CD;
	input TG;

INV \$1I226  (.ZN0(\$1N223 ), .A0(CD));
AND3 \$1I279  (.Z0(\$1N188 ), .A0(D0), .A1(\$1N223 ), .A2(G));
AND2 \$1I284  (.Z0(\$1N288 ), .A0(\$1N223 ), .A1(PD));
INV \$1I292  (.ZN0(\$1N293 ), .A0(G));

/*
PW \$1I300  (.PULSE(G));
PW \$1I301  (.PULSE(PD));
PW \$1I302  (.PULSE(\$1N223 ));
SHFE \$1I306  (.REF(\$1N223 ), .DATA(G));
SHFE \$1I309  (.REF(PD), .DATA(G));
SHFE \$1I311  (.REF(G), .DATA(D0));
*/

BUF \$1I314  (.Z0(Q0), .A0(\$1N6 ));

/*
  SHFE \$1I318  (.REF(\$1N223 ), .DATA(PD));
*/

OR6 \$1I322  (.Z0(\$1N6 ), .A0(\$1N347 ), .A1(\$1N338 ), .A2(\$1N332 ), 
	.A3(\$1N324 ), .A4(\$1N188 ), .A5(\$1N288 ));
AND3 \$1I323  (.Z0(\$1N324 ), .A0(TI0), .A1(\$1N223 ), .A2(TG));
AND4 \$1I331  (.Z0(\$1N332 ), .A0(\$1N6 ), .A1(\$1N223 ), .A2(\$1N293 ), 
	.A3(\$1N349 ));
AND4 \$1I336  (.Z0(\$1N338 ), .A0(\$1N6 ), .A1(\$1N223 ), .A2(\$1N293 ), 
	.A3(TI0));
INV \$1I340  (.ZN0(\$1N349 ), .A0(TG));
AND4 \$1I345  (.Z0(\$1N347 ), .A0(\$1N6 ), .A1(\$1N223 ), .A2(\$1N349 ), 
	.A3(D0));

/*
SHFE \$1I357  (.REF(TG), .DATA(TI0));
PW \$1I358  (.PULSE(TG));
SHFE \$1I362  (.REF(\$1N223 ), .DATA(TG));
SHFE \$1I365  (.REF(PD), .DATA(TG));
*/

endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:10:10 1994
`timescale 10 ps / 10 ps 
module LD94(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	TI0, TI1, TI2, TI3, 
	G, PD, CD, TG);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input G;
	input PD;
	input CD;
	input TG;

LD91 \$1I181  (.Q0(Q3), .D0(D3), .TI0(TI3), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LD91 \$1I182  (.Q0(Q2), .D0(D2), .TI0(TI2), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LD91 \$1I183  (.Q0(Q1), .D0(D1), .TI0(TI1), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LD91 \$1I184  (.Q0(Q0), .D0(D0), .TI0(TI0), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:10:13 1994
`timescale 10 ps / 10 ps 
module LD98(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	TI0, TI1, TI2, TI3, 
	TI4, TI5, TI6, TI7, 
	G, PD, CD, TG);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input TI4;
	input TI5;
	input TI6;
	input TI7;
	input G;
	input PD;
	input CD;
	input TG;

LD91 \$1I181  (.Q0(Q3), .D0(D3), .TI0(TI3), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LD91 \$1I182  (.Q0(Q2), .D0(D2), .TI0(TI2), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LD91 \$1I183  (.Q0(Q1), .D0(D1), .TI0(TI1), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LD91 \$1I184  (.Q0(Q0), .D0(D0), .TI0(TI0), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LD91 \$1I250  (.Q0(Q7), .D0(D7), .TI0(TI7), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LD91 \$1I260  (.Q0(Q6), .D0(D6), .TI0(TI6), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LD91 \$1I261  (.Q0(Q5), .D0(D5), .TI0(TI5), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LD91 \$1I262  (.Q0(Q4), .D0(D4), .TI0(TI4), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:10:16 1994
`timescale 10 ps / 10 ps 
module LDA1(
	Q0, D0, TI0, G, 
	PD, CD, TG);

	output Q0;
	input D0;
	input TI0;
	input G;
	input PD;
	input CD;
	input TG;

INV \$1I226  (.ZN0(\$1N223 ), .A0(CD));
AND3 \$1I279  (.Z0(\$1N188 ), .A0(D0), .A1(\$1N223 ), .A2(G));
INV \$1I292  (.ZN0(\$1N293 ), .A0(G));

/*
PW \$1I300  (.PULSE(G));
PW \$1I301  (.PULSE(PD));
PW \$1I302  (.PULSE(\$1N223 ));
SHFE \$1I306  (.REF(\$1N223 ), .DATA(G));
SHFE \$1I309  (.REF(PD), .DATA(G));
SHFE \$1I311  (.REF(G), .DATA(D0));
*/

BUF \$1I314  (.Z0(Q0), .A0(\$1N6 ));

/*
SHFE \$1I318  (.REF(\$1N223 ), .DATA(PD));
*/

OR6 \$1I322  (.Z0(\$1N6 ), .A0(\$1N347 ), .A1(\$1N338 ), .A2(\$1N332 ), 
	.A3(\$1N324 ), .A4(\$1N188 ), .A5(PD));
AND3 \$1I323  (.Z0(\$1N324 ), .A0(TI0), .A1(\$1N223 ), .A2(TG));
AND4 \$1I331  (.Z0(\$1N332 ), .A0(\$1N6 ), .A1(\$1N223 ), .A2(\$1N293 ), 
	.A3(\$1N349 ));
AND4 \$1I336  (.Z0(\$1N338 ), .A0(\$1N6 ), .A1(\$1N223 ), .A2(\$1N293 ), 
	.A3(TI0));
INV \$1I340  (.ZN0(\$1N349 ), .A0(TG));
AND4 \$1I345  (.Z0(\$1N347 ), .A0(\$1N6 ), .A1(\$1N223 ), .A2(\$1N349 ), 
	.A3(D0));

/*
SHFE \$1I357  (.REF(TG), .DATA(TI0));
PW \$1I358  (.PULSE(TG));
SHFE \$1I362  (.REF(PD), .DATA(TI0));
SHFE \$1I365  (.REF(\$1N223 ), .DATA(TI0));
*/

endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:10:20 1994
`timescale 10 ps / 10 ps 
module LDA4(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	TI0, TI1, TI2, TI3, 
	G, PD, CD, TG);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input G;
	input PD;
	input CD;
	input TG;

LDA1 \$1I181  (.Q0(Q3), .D0(D3), .TI0(TI3), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LDA1 \$1I182  (.Q0(Q2), .D0(D2), .TI0(TI2), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LDA1 \$1I183  (.Q0(Q1), .D0(D1), .TI0(TI1), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LDA1 \$1I184  (.Q0(Q0), .D0(D0), .TI0(TI0), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:10:24 1994
`timescale 10 ps / 10 ps 
module LDA8(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	TI0, TI1, TI2, TI3, 
	TI4, TI5, TI6, TI7, 
	G, PD, CD, TG);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input TI0;
	input TI1;
	input TI2;
	input TI3;
	input TI4;
	input TI5;
	input TI6;
	input TI7;
	input G;
	input PD;
	input CD;
	input TG;

LDA1 \$1I181  (.Q0(Q3), .D0(D3), .TI0(TI3), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LDA1 \$1I182  (.Q0(Q2), .D0(D2), .TI0(TI2), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LDA1 \$1I183  (.Q0(Q1), .D0(D1), .TI0(TI1), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LDA1 \$1I184  (.Q0(Q0), .D0(D0), .TI0(TI0), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LDA1 \$1I250  (.Q0(Q7), .D0(D7), .TI0(TI7), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LDA1 \$1I260  (.Q0(Q6), .D0(D6), .TI0(TI6), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LDA1 \$1I261  (.Q0(Q5), .D0(D5), .TI0(TI5), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
LDA1 \$1I262  (.Q0(Q4), .D0(D4), .TI0(TI4), .G(G), 
	.PD(PD), .CD(CD), .TG(TG));
endmodule

/**************
*     LDI11   *
***************/


`timescale 10 ps / 10 ps
module LDI11 (Q0, D0, G);

  input  D0, G;
  output  Q0;
  supply1 reset;

  D_LATCH  blk1 (Q0, D0, G, reset);


    
endmodule
`timescale 10 ps / 10 ps
module LDI14(
	D0, D1, D2, D3, G, Q0, Q1, Q2, Q3);


	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



LDI11 \$1I150  (.Q0 (Q3), .D0 (D3), .G (G));
LDI11 \$1I149  (.Q0 (Q2), .D0 (D2), .G (G));
LDI11 \$1I148  (.Q0 (Q1), .D0 (D1), .G (G));
LDI11 \$1I147  (.Q0 (Q0), .D0 (D0), .G (G));
endmodule
`timescale 10 ps / 10 ps
module LDI18(
	D0, D1, D2, D3, D4, D5, D6, D7, G, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input G;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



LDI11 \$1I186  (.Q0 (Q7), .D0 (D7), .G (G));
LDI11 \$1I185  (.Q0 (Q6), .D0 (D6), .G (G));
LDI11 \$1I184  (.Q0 (Q5), .D0 (D5), .G (G));
LDI11 \$1I183  (.Q0 (Q4), .D0 (D4), .G (G));
LDI11 \$1I182  (.Q0 (Q3), .D0 (D3), .G (G));
LDI11 \$1I181  (.Q0 (Q2), .D0 (D2), .G (G));
LDI11 \$1I180  (.Q0 (Q1), .D0 (D1), .G (G));
LDI11 \$1I179  (.Q0 (Q0), .D0 (D0), .G (G));
endmodule

/**************
*     LDI21   *
***************/


`timescale 10 ps / 10 ps
module LDI21 (Q0, D0, G, CD);

  input  D0, G, CD;
  output  Q0;
  supply1 reset;

  not blk0(t1, CD);
  and blk1(t2, reset, t1);
  D_LATCH  blk2(Q0, D0, G, t2);


    
endmodule
`timescale 10 ps / 10 ps
module LDI24(
	CD, D0, D1, D2, D3, G, Q0, Q1, Q2, Q3);


	input CD;
	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



LDI21 \$1I161  (.Q0 (Q3), .D0 (D3), .G (G), 
	.CD (CD));
LDI21 \$1I160  (.Q0 (Q2), .D0 (D2), .G (G), 
	.CD (CD));
LDI21 \$1I159  (.Q0 (Q1), .D0 (D1), .G (G), 
	.CD (CD));
LDI21 \$1I158  (.Q0 (Q0), .D0 (D0), .G (G), 
	.CD (CD));
endmodule
`timescale 10 ps / 10 ps
module LDI28(
	CD, D0, D1, D2, D3, D4, D5, D6, D7, G, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CD;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input G;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



LDI21 \$1I201  (.Q0 (Q7), .D0 (D7), .G (G), 
	.CD (CD));
LDI21 \$1I200  (.Q0 (Q6), .D0 (D6), .G (G), 
	.CD (CD));
LDI21 \$1I199  (.Q0 (Q5), .D0 (D5), .G (G), 
	.CD (CD));
LDI21 \$1I198  (.Q0 (Q4), .D0 (D4), .G (G), 
	.CD (CD));
LDI21 \$1I196  (.Q0 (Q2), .D0 (D2), .G (G), 
	.CD (CD));
LDI21 \$1I195  (.Q0 (Q1), .D0 (D1), .G (G), 
	.CD (CD));
LDI21 \$1I194  (.Q0 (Q0), .D0 (D0), .G (G), 
	.CD (CD));
LDI21 \$1I197  (.Q0 (Q3), .D0 (D3), .G (G), 
	.CD (CD));
endmodule

/**************
*     LDI31   *
***************/


`timescale 10 ps / 10 ps
module LDI31 (Q0, D0, G, SD);

  input  D0, G, SD;
  output  Q0;
  supply1 reset;

  not blk0(t1, SD);
  and blk1(t2, reset, t1);
  D_LATCH3  blk2(Q0, D0, G, t2);


    
endmodule
`timescale 10 ps / 10 ps
module LDI34(
	D0, D1, D2, D3, G, SD, Q0, Q1, Q2, Q3);


	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



LDI31 \$1I161  (.Q0 (Q3), .D0 (D3), .G (G), 
	.SD (SD));
LDI31 \$1I160  (.Q0 (Q2), .D0 (D2), .G (G), 
	.SD (SD));
LDI31 \$1I159  (.Q0 (Q1), .D0 (D1), .G (G), 
	.SD (SD));
LDI31 \$1I158  (.Q0 (Q0), .D0 (D0), .G (G), 
	.SD (SD));
endmodule
`timescale 10 ps / 10 ps
module LDI38(
	D0, D1, D2, D3, D4, D5, D6, D7, G, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input G;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



LDI31 \$1I201  (.Q0 (Q7), .D0 (D7), .G (G), 
	.SD (SD));
LDI31 \$1I200  (.Q0 (Q6), .D0 (D6), .G (G), 
	.SD (SD));
LDI31 \$1I199  (.Q0 (Q5), .D0 (D5), .G (G), 
	.SD (SD));
LDI31 \$1I198  (.Q0 (Q4), .D0 (D4), .G (G), 
	.SD (SD));
LDI31 \$1I197  (.Q0 (Q3), .D0 (D3), .G (G), 
	.SD (SD));
LDI31 \$1I196  (.Q0 (Q2), .D0 (D2), .G (G), 
	.SD (SD));
LDI31 \$1I195  (.Q0 (Q1), .D0 (D1), .G (G), 
	.SD (SD));
LDI31 \$1I194  (.Q0 (Q0), .D0 (D0), .G (G), 
	.SD (SD));
endmodule

/**************
*     LDI41   *
***************/


`timescale 10 ps / 10 ps
module LDI41 (Q0, D0, G, CD, SD);

  input  D0, G, CD, SD;
  output  Q0;
  /*
  supply1 reset;
  */
  not blk0(t0, CD);
  not blk1(t1, SD);

  D_LATCH4  blk2(Q0, D0, G, t0,t1);


    
endmodule
`timescale 10 ps / 10 ps
module LDI44(
	CD, D0, D1, D2, D3, G, SD, Q0, Q1, Q2, Q3);


	input CD;
	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;



LDI41 \$1I161  (.Q0 (Q3), .D0 (D3), .G (G), 
	.SD (SD), .CD (CD));
LDI41 \$1I160  (.Q0 (Q2), .D0 (D2), .G (G), 
	.SD (SD), .CD (CD));
LDI41 \$1I159  (.Q0 (Q1), .D0 (D1), .G (G), 
	.SD (SD), .CD (CD));
LDI41 \$1I158  (.Q0 (Q0), .D0 (D0), .G (G), 
	.SD (SD), .CD (CD));
endmodule
`timescale 10 ps / 10 ps
module LDI48(
	CD, D0, D1, D2, D3, D4, D5, D6, D7, G, SD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7);


	input CD;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input G;
	input SD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;



LDI41 \$1I201  (.Q0 (Q7), .D0 (D7), .G (G), 
	.SD (SD), .CD (CD));
LDI41 \$1I200  (.Q0 (Q6), .D0 (D6), .G (G), 
	.SD (SD), .CD (CD));
LDI41 \$1I199  (.Q0 (Q5), .D0 (D5), .G (G), 
	.SD (SD), .CD (CD));
LDI41 \$1I198  (.Q0 (Q4), .D0 (D4), .G (G), 
	.SD (SD), .CD (CD));
LDI41 \$1I197  (.Q0 (Q3), .D0 (D3), .G (G), 
	.SD (SD), .CD (CD));
LDI41 \$1I196  (.Q0 (Q2), .D0 (D2), .G (G), 
	.SD (SD), .CD (CD));
LDI41 \$1I195  (.Q0 (Q1), .D0 (D1), .G (G), 
	.SD (SD), .CD (CD));
LDI41 \$1I194  (.Q0 (Q0), .D0 (D0), .G (G), 
	.SD (SD), .CD (CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:10:26 1994
`timescale 10 ps / 10 ps 
module LSR1(
	Q0, S0, R0);

	output Q0;
	input S0;
	input R0;

NAND2 \$1I1  (.ZN0(\$1N5 ), .A0(S0), .A1(\$1N11 ));
NAND2 \$1I2  (.ZN0(\$1N11 ), .A0(R0), .A1(\$1N5 ));
BUF \$1I30  (.Z0(Q0), .A0(\$1N5 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:10:28 1994
`timescale 10 ps / 10 ps 
module LSR2(
	Q0, S0, S1, R0, 
	R1);

	output Q0;
	input S0;
	input S1;
	input R0;
	input R1;

OR2 \$1I1  (.Z0(\$1N5 ), .A0(S0), .A1(S1));
NAND2 \$1I2  (.ZN0(\$1N16 ), .A0(\$1N5 ), .A1(\$1N13 ));
NAND2 \$1I3  (.ZN0(\$1N13 ), .A0(\$1N31 ), .A1(\$1N16 ));
BUF \$1I33  (.Z0(Q0), .A0(\$1N16 ));
OR2 \$1I4  (.Z0(\$1N31 ), .A0(R0), .A1(R1));
endmodule
/*
* Translated from EDIF description LXOR2                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 42  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  LXOR2 lib :  LXOR2                          *
*/
/*
* Library LXOR2                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell LXOR2"                                                                *
*/
`timescale 10 ps / 10 ps
module LXOR2 (Z0, A0, A1);

    input  A0;
    input  A1;

    output  Z0;



    xor
        \$1I1  (Z0, A0, A1);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:10:32 1994
`timescale 10 ps / 10 ps 
module MAG2(
	GT, EQ, LT, A0, 
	A1, B0, B1, GTI, 
	EQI, LTI);

	output GT;
	output EQ;
	output LT;
	input A0;
	input A1;
	input B0;
	input B1;
	input GTI;
	input EQI;
	input LTI;

INV \$1I311  (.ZN0(\~A0 ), .A0(A0));
INV \$1I312  (.ZN0(\~A1 ), .A0(A1));
INV \$1I321  (.ZN0(\~B0 ), .A0(B0));
INV \$1I322  (.ZN0(\~B1 ), .A0(B1));
AND7 \$1I331  (.Z0(\$1N354 ), .A0(\~A1 ), .A1(\~A0 ), .A2(\~B1 ), 
	.A3(\~B0 ), .A4(\$1N475 ), .A5(EQI), .A6(\$1N473 ));
AND7 \$1I332  (.Z0(\$1N348 ), .A0(\~A1 ), .A1(A0), .A2(\~B1 ), 
	.A3(B0), .A4(\$1N475 ), .A5(EQI), .A6(\$1N473 ));
AND7 \$1I333  (.Z0(\$1N350 ), .A0(A1), .A1(\~A0 ), .A2(B1), 
	.A3(\~B0 ), .A4(\$1N475 ), .A5(EQI), .A6(\$1N473 ));
AND7 \$1I334  (.Z0(\$1N352 ), .A0(A1), .A1(A0), .A2(B1), 
	.A3(B0), .A4(\$1N475 ), .A5(EQI), .A6(\$1N473 ));
OR4 \$1I347  (.Z0(EQ), .A0(\$1N354 ), .A1(\$1N348 ), .A2(\$1N350 ), 
	.A3(\$1N352 ));
AND3 \$1I374  (.Z0(\$1N396 ), .A0(\$1N475 ), .A1(\$1N455 ), .A2(GTI));
AND3 \$1I407  (.Z0(\$1N404 ), .A0(LTI), .A1(\$1N455 ), .A2(\$1N473 ));
AND6 \$1I409  (.Z0(\$1N415 ), .A0(\~A1 ), .A1(\~A0 ), .A2(B0), 
	.A3(\$1N475 ), .A4(EQI), .A5(\$1N473 ));
AND6 \$1I410  (.Z0(\$1N406 ), .A0(\~A0 ), .A1(B1), .A2(B0), 
	.A3(\$1N475 ), .A4(EQI), .A5(\$1N473 ));
INV \$1I423  (.ZN0(\$1N473 ), .A0(GTI));
INV \$1I424  (.ZN0(\$1N455 ), .A0(EQI));
INV \$1I425  (.ZN0(\$1N475 ), .A0(LTI));
AND5 \$1I468  (.Z0(\$1N394 ), .A0(A1), .A1(\~B1 ), .A2(\$1N475 ), 
	.A3(EQI), .A4(\$1N473 ));
AND6 \$1I469  (.Z0(\$1N392 ), .A0(A0), .A1(\~B1 ), .A2(\~B0 ), 
	.A3(\$1N475 ), .A4(EQI), .A5(\$1N473 ));
AND6 \$1I471  (.Z0(\$1N398 ), .A0(A1), .A1(A0), .A2(\~B0 ), 
	.A3(\$1N475 ), .A4(EQI), .A5(\$1N473 ));
OR4 \$1I477  (.Z0(GT), .A0(\$1N396 ), .A1(\$1N394 ), .A2(\$1N392 ), 
	.A3(\$1N398 ));
AND5 \$1I478  (.Z0(\$1N405 ), .A0(\~A1 ), .A1(B1), .A2(\$1N475 ), 
	.A3(EQI), .A4(\$1N473 ));
OR4 \$1I480  (.Z0(LT), .A0(\$1N404 ), .A1(\$1N405 ), .A2(\$1N415 ), 
	.A3(\$1N406 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:10:38 1994
`timescale 10 ps / 10 ps 
module MAG4(
	GT, EQ, LT, A0, 
	A1, A2, A3, B0, 
	B1, B2, B3, GTI, 
	EQI, LTI);

	output GT;
	output EQ;
	output LT;
	input A0;
	input A1;
	input A2;
	input A3;
	input B0;
	input B1;
	input B2;
	input B3;
	input GTI;
	input EQI;
	input LTI;

INV \$1I241  (.ZN0(\$1N238 ), .A0(LTI));
INV \$1I243  (.ZN0(\$1N235 ), .A0(GTI));
AND11 \$1I266  (.Z0(\$1N355 ), .A0(\~A3 ), .A1(\~A2 ), .A2(\~A1 ), 
	.A3(\~A0 ), .A4(\~B3 ), .A5(\~B2 ), .A6(\~B1 ), 
	.A7(\~B0 ), .A8(\$1N238 ), .A9(EQI), .A10(\$1N235 ));
AND11 \$1I280  (.Z0(\$1N354 ), .A0(\~A3 ), .A1(\~A2 ), .A2(\~A1 ), 
	.A3(A0), .A4(\~B3 ), .A5(\~B2 ), .A6(\~B1 ), 
	.A7(B0), .A8(\$1N238 ), .A9(EQI), .A10(\$1N235 ));
AND11 \$1I292  (.Z0(\$1N353 ), .A0(\~A3 ), .A1(\~A2 ), .A2(A1), 
	.A3(\~A0 ), .A4(\~B3 ), .A5(\~B2 ), .A6(B1), 
	.A7(\~B0 ), .A8(\$1N238 ), .A9(EQI), .A10(\$1N235 ));
AND11 \$1I293  (.Z0(\$1N356 ), .A0(\~A3 ), .A1(\~A2 ), .A2(A1), 
	.A3(A0), .A4(\~B3 ), .A5(\~B2 ), .A6(B1), 
	.A7(B0), .A8(\$1N238 ), .A9(EQI), .A10(\$1N235 ));
AND11 \$1I316  (.Z0(\$1N357 ), .A0(\~A3 ), .A1(A2), .A2(\~A1 ), 
	.A3(\~A0 ), .A4(\~B3 ), .A5(B2), .A6(\~B1 ), 
	.A7(\~B0 ), .A8(\$1N238 ), .A9(EQI), .A10(\$1N235 ));
AND11 \$1I328  (.Z0(\$1N358 ), .A0(\~A3 ), .A1(A2), .A2(\~A1 ), 
	.A3(A0), .A4(\~B3 ), .A5(B2), .A6(\~B1 ), 
	.A7(B0), .A8(\$1N238 ), .A9(EQI), .A10(\$1N235 ));
AND11 \$1I344  (.Z0(\$1N405 ), .A0(A3), .A1(\~A2 ), .A2(A1), 
	.A3(A0), .A4(B3), .A5(\~B2 ), .A6(B1), 
	.A7(B0), .A8(\$1N238 ), .A9(EQI), .A10(\$1N235 ));
AND11 \$1I345  (.Z0(\$1N408 ), .A0(A3), .A1(\~A2 ), .A2(A1), 
	.A3(\~A0 ), .A4(B3), .A5(\~B2 ), .A6(B1), 
	.A7(\~B0 ), .A8(\$1N238 ), .A9(EQI), .A10(\$1N235 ));
AND11 \$1I346  (.Z0(\$1N410 ), .A0(A3), .A1(\~A2 ), .A2(\~A1 ), 
	.A3(A0), .A4(B3), .A5(\~B2 ), .A6(\~B1 ), 
	.A7(B0), .A8(\$1N238 ), .A9(EQI), .A10(\$1N235 ));
AND11 \$1I347  (.Z0(\$1N414 ), .A0(\~A3 ), .A1(A2), .A2(A1), 
	.A3(A0), .A4(\~B3 ), .A5(B2), .A6(B1), 
	.A7(B0), .A8(\$1N238 ), .A9(EQI), .A10(\$1N235 ));
AND11 \$1I348  (.Z0(\$1N416 ), .A0(\~A3 ), .A1(A2), .A2(A1), 
	.A3(\~A0 ), .A4(\~B3 ), .A5(B2), .A6(B1), 
	.A7(\~B0 ), .A8(\$1N238 ), .A9(EQI), .A10(\$1N235 ));
AND11 \$1I352  (.Z0(\$1N412 ), .A0(A3), .A1(\~A2 ), .A2(\~A1 ), 
	.A3(\~A0 ), .A4(B3), .A5(\~B2 ), .A6(\~B1 ), 
	.A7(\~B0 ), .A8(\$1N238 ), .A9(EQI), .A10(\$1N235 ));
AND11 \$1I387  (.Z0(\$1N452 ), .A0(A3), .A1(A2), .A2(A1), 
	.A3(A0), .A4(B3), .A5(B2), .A6(B1), 
	.A7(B0), .A8(\$1N238 ), .A9(EQI), .A10(\$1N235 ));
AND11 \$1I390  (.Z0(\$1N443 ), .A0(A3), .A1(A2), .A2(\~A1 ), 
	.A3(\~A0 ), .A4(B3), .A5(B2), .A6(\~B1 ), 
	.A7(\~B0 ), .A8(\$1N238 ), .A9(EQI), .A10(\$1N235 ));
AND11 \$1I391  (.Z0(\$1N441 ), .A0(A3), .A1(A2), .A2(\~A1 ), 
	.A3(A0), .A4(B3), .A5(B2), .A6(\~B1 ), 
	.A7(B0), .A8(\$1N238 ), .A9(EQI), .A10(\$1N235 ));
AND11 \$1I392  (.Z0(\$1N439 ), .A0(A3), .A1(A2), .A2(A1), 
	.A3(\~A0 ), .A4(B3), .A5(B2), .A6(B1), 
	.A7(\~B0 ), .A8(\$1N238 ), .A9(EQI), .A10(\$1N235 ));
OR7 \$1I398  (.Z0(\$1N446 ), .A0(\$1N405 ), .A1(\$1N355 ), .A2(\$1N354 ), 
	.A3(\$1N353 ), .A4(\$1N356 ), .A5(\$1N357 ), .A6(\$1N358 ));
OR5 \$1I407  (.Z0(\$1N448 ), .A0(\$1N416 ), .A1(\$1N414 ), .A2(\$1N412 ), 
	.A3(\$1N410 ), .A4(\$1N408 ));
OR4 \$1I436  (.Z0(\$1N450 ), .A0(\$1N443 ), .A1(\$1N441 ), .A2(\$1N439 ), 
	.A3(\$1N452 ));
INV \$1I499  (.ZN0(\~B3 ), .A0(B3));
INV \$1I500  (.ZN0(\~B2 ), .A0(B2));
INV \$1I501  (.ZN0(\~B1 ), .A0(B1));
INV \$1I502  (.ZN0(\~B0 ), .A0(B0));
INV \$1I515  (.ZN0(\~A1 ), .A0(A1));
INV \$1I516  (.ZN0(\~A0 ), .A0(A0));
INV \$1I517  (.ZN0(\~A2 ), .A0(A2));
INV \$1I518  (.ZN0(\~A3 ), .A0(A3));
OR3 \$1I538  (.Z0(EQ), .A0(\$1N450 ), .A1(\$1N448 ), .A2(\$1N446 ));
AND7 \$2I103  (.Z0(\$2N144 ), .A0(A2), .A1(A1), .A2(\~B3 ), 
	.A3(\~B1 ), .A4(\$2N21 ), .A5(EQI), .A6(\$2N19 ));
AND7 \$2I104  (.Z0(\$2N140 ), .A0(A3), .A1(A1), .A2(\~B2 ), 
	.A3(\~B1 ), .A4(\$2N21 ), .A5(EQI), .A6(\$2N19 ));
AND7 \$2I105  (.Z0(\$2N142 ), .A0(A3), .A1(A2), .A2(A1), 
	.A3(\~B1 ), .A4(\$2N21 ), .A5(EQI), .A6(\$2N19 ));
AND6 \$2I116  (.Z0(\$2N159 ), .A0(A2), .A1(\~B3 ), .A2(\~B2 ), 
	.A3(\$2N21 ), .A4(EQI), .A5(\$2N19 ));
AND6 \$2I119  (.Z0(\$2N157 ), .A0(A3), .A1(A2), .A2(\~B2 ), 
	.A3(\$2N21 ), .A4(EQI), .A5(\$2N19 ));
AND5 \$2I122  (.Z0(\$2N155 ), .A0(A3), .A1(\~B3 ), .A2(\$2N21 ), 
	.A3(EQI), .A4(\$2N19 ));
OR7 \$2I124  (.Z0(\$2N169 ), .A0(\$2N137 ), .A1(\$2N135 ), .A2(\$2N133 ), 
	.A3(\$2N131 ), .A4(\$2N129 ), .A5(\$2N125 ), .A6(\$2N127 ));
OR5 \$2I139  (.Z0(\$2N165 ), .A0(\$2N148 ), .A1(\$2N146 ), .A2(\$2N144 ), 
	.A3(\$2N140 ), .A4(\$2N142 ));
AND3 \$2I150  (.Z0(\$2N161 ), .A0(GTI), .A1(\$2N13 ), .A2(\$2N21 ));
OR4 \$2I154  (.Z0(\$2N171 ), .A0(\$2N161 ), .A1(\$2N159 ), .A2(\$2N157 ), 
	.A3(\$2N155 ));
INV \$2I16  (.ZN0(\$2N21 ), .A0(LTI));
OR3 \$2I164  (.Z0(GT), .A0(\$2N171 ), .A1(\$2N165 ), .A2(\$2N169 ));
INV \$2I17  (.ZN0(\$2N13 ), .A0(EQI));
INV \$2I18  (.ZN0(\$2N19 ), .A0(GTI));
AND8 \$2I22  (.Z0(\$2N137 ), .A0(A0), .A1(\~B3 ), .A2(\~B2 ), 
	.A3(\~B1 ), .A4(\~B0 ), .A5(\$2N21 ), .A6(EQI), 
	.A7(\$2N19 ));
AND8 \$2I32  (.Z0(\$2N135 ), .A0(A1), .A1(A0), .A2(\~B3 ), 
	.A3(\~B2 ), .A4(\~B0 ), .A5(\$2N21 ), .A6(EQI), 
	.A7(\$2N19 ));
AND8 \$2I43  (.Z0(\$2N133 ), .A0(A2), .A1(A0), .A2(\~B3 ), 
	.A3(\~B1 ), .A4(\~B0 ), .A5(\$2N21 ), .A6(EQI), 
	.A7(\$2N19 ));
AND8 \$2I49  (.Z0(\$2N131 ), .A0(A3), .A1(A0), .A2(\~B2 ), 
	.A3(\~B1 ), .A4(\~B0 ), .A5(\$2N21 ), .A6(EQI), 
	.A7(\$2N19 ));
AND8 \$2I60  (.Z0(\$2N129 ), .A0(A2), .A1(A1), .A2(A0), 
	.A3(\~B3 ), .A4(\~B0 ), .A5(\$2N21 ), .A6(EQI), 
	.A7(\$2N19 ));
AND8 \$2I75  (.Z0(\$2N125 ), .A0(A3), .A1(A1), .A2(A0), 
	.A3(\~B2 ), .A4(\~B0 ), .A5(\$2N21 ), .A6(EQI), 
	.A7(\$2N19 ));
AND8 \$2I84  (.Z0(\$2N127 ), .A0(A3), .A1(A2), .A2(A0), 
	.A3(\~B1 ), .A4(\~B0 ), .A5(\$2N21 ), .A6(EQI), 
	.A7(\$2N19 ));
AND7 \$2I93  (.Z0(\$2N146 ), .A0(A1), .A1(\~B3 ), .A2(\~B2 ), 
	.A3(\~B1 ), .A4(\$2N21 ), .A5(EQI), .A6(\$2N19 ));
AND8 \$2I95  (.Z0(\$2N148 ), .A0(A3), .A1(A2), .A2(A1), 
	.A3(A0), .A4(\~B0 ), .A5(\$2N21 ), .A6(EQI), 
	.A7(\$2N19 ));
AND8 \$3I104  (.Z0(\$3N188 ), .A0(\~A3 ), .A1(\~A0 ), .A2(B2), 
	.A3(B1), .A4(B0), .A5(\$3N17 ), .A6(EQI), 
	.A7(\$3N15 ));
AND8 \$3I113  (.Z0(\$3N190 ), .A0(\~A2 ), .A1(\~A0 ), .A2(B3), 
	.A3(B1), .A4(B0), .A5(\$3N17 ), .A6(EQI), 
	.A7(\$3N15 ));
AND8 \$3I131  (.Z0(\$3N192 ), .A0(\~A1 ), .A1(\~A0 ), .A2(B3), 
	.A3(B2), .A4(B0), .A5(\$3N17 ), .A6(EQI), 
	.A7(\$3N15 ));
AND8 \$3I161  (.Z0(\$3N195 ), .A0(\~A0 ), .A1(B3), .A2(B2), 
	.A3(B1), .A4(B0), .A5(\$3N17 ), .A6(EQI), 
	.A7(\$3N15 ));
AND7 \$3I168  (.Z0(\$3N197 ), .A0(\~A3 ), .A1(\~A2 ), .A2(\~A1 ), 
	.A3(B1), .A4(\$3N17 ), .A5(EQI), .A6(\$3N15 ));
AND7 \$3I169  (.Z0(\$3N199 ), .A0(\~A3 ), .A1(\~A1 ), .A2(B2), 
	.A3(B1), .A4(\$3N17 ), .A5(EQI), .A6(\$3N15 ));
AND7 \$3I170  (.Z0(\$3N201 ), .A0(\~A2 ), .A1(\~A1 ), .A2(B3), 
	.A3(B1), .A4(\$3N17 ), .A5(EQI), .A6(\$3N15 ));
AND7 \$3I171  (.Z0(\$3N203 ), .A0(\~A1 ), .A1(B3), .A2(B2), 
	.A3(B1), .A4(\$3N17 ), .A5(EQI), .A6(\$3N15 ));
OR7 \$3I172  (.Z0(\$3N231 ), .A0(\$3N173 ), .A1(\$3N175 ), .A2(\$3N184 ), 
	.A3(\$3N186 ), .A4(\$3N188 ), .A5(\$3N190 ), .A6(\$3N192 ));
OR5 \$3I194  (.Z0(\$3N227 ), .A0(\$3N195 ), .A1(\$3N197 ), .A2(\$3N199 ), 
	.A3(\$3N201 ), .A4(\$3N203 ));
AND3 \$3I210  (.Z0(\$3N224 ), .A0(\$3N15 ), .A1(\$3N3 ), .A2(LTI));
AND6 \$3I214  (.Z0(\$3N222 ), .A0(\~A3 ), .A1(\~A2 ), .A2(B2), 
	.A3(\$3N17 ), .A4(EQI), .A5(\$3N15 ));
AND6 \$3I215  (.Z0(\$3N220 ), .A0(\~A2 ), .A1(B3), .A2(B2), 
	.A3(\$3N17 ), .A4(EQI), .A5(\$3N15 ));
AND5 \$3I216  (.Z0(\$3N218 ), .A0(\~A3 ), .A1(B3), .A2(\$3N17 ), 
	.A3(EQI), .A4(\$3N15 ));
OR4 \$3I217  (.Z0(\$3N229 ), .A0(\$3N224 ), .A1(\$3N222 ), .A2(\$3N220 ), 
	.A3(\$3N218 ));
OR3 \$3I226  (.Z0(LT), .A0(\$3N229 ), .A1(\$3N227 ), .A2(\$3N231 ));
AND8 \$3I52  (.Z0(\$3N173 ), .A0(\~A3 ), .A1(\~A2 ), .A2(\~A1 ), 
	.A3(\~A0 ), .A4(B0), .A5(\$3N17 ), .A6(EQI), 
	.A7(\$3N15 ));
INV \$3I6  (.ZN0(\$3N17 ), .A0(LTI));
INV \$3I7  (.ZN0(\$3N3 ), .A0(EQI));
AND8 \$3I72  (.Z0(\$3N175 ), .A0(\~A3 ), .A1(\~A2 ), .A2(\~A0 ), 
	.A3(B1), .A4(B0), .A5(\$3N17 ), .A6(EQI), 
	.A7(\$3N15 ));
INV \$3I8  (.ZN0(\$3N15 ), .A0(GTI));
AND8 \$3I86  (.Z0(\$3N184 ), .A0(\~A3 ), .A1(\~A1 ), .A2(\~A0 ), 
	.A3(B2), .A4(B0), .A5(\$3N17 ), .A6(EQI), 
	.A7(\$3N15 ));
AND8 \$3I95  (.Z0(\$3N186 ), .A0(\~A2 ), .A1(\~A1 ), .A2(\~A0 ), 
	.A3(B3), .A4(B0), .A5(\$3N17 ), .A6(EQI), 
	.A7(\$3N15 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:10:45 1994
`timescale 10 ps / 10 ps 
module MAG8(
	GT, EQ, LT, A0, 
	A1, A2, A3, A4, 
	A5, A6, A7, B0, 
	B1, B2, B3, B4, 
	B5, B6, B7, GTI, 
	EQI, LTI);

	output GT;
	output EQ;
	output LT;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input B0;
	input B1;
	input B2;
	input B3;
	input B4;
	input B5;
	input B6;
	input B7;
	input GTI;
	input EQI;
	input LTI;

MAG4 \$1I14  (.GT(\$1N16 ), .EQ(\$1N18 ), .LT(\$1N20 ), .A0(A4), 
	.A1(A5), .A2(A6), .A3(A7), .B0(B4), 
	.B1(B5), .B2(B6), .B3(B7), .GTI(GTI), 
	.EQI(EQI), .LTI(LTI));
MAG4 \$1I15  (.GT(GT), .EQ(EQ), .LT(LT), .A0(A0), 
	.A1(A1), .A2(A2), .A3(A3), .B0(B0), 
	.B1(B1), .B2(B2), .B3(B3), .GTI(\$1N16 ), 
	.EQI(\$1N18 ), .LTI(\$1N20 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:10:49 1994
`timescale 10 ps / 10 ps 
module MULT24(
	Z0, Z1, Z2, Z3, 
	Z4, Z5, A0, A1, 
	B0, B1, B2, B3);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	input A0;
	input A1;
	input B0;
	input B1;
	input B2;
	input B3;

AND2 \$1I340  (.Z0(Z0), .A0(A0), .A1(B0));
INV \$1I495  (.ZN0(\~A1 ), .A0(A1));
AND3 \$1I533  (.Z0(\$1N575 ), .A0(A1), .A1(B0), .A2(\~B1 ));
INV \$1I537  (.ZN0(\~A0 ), .A0(A0));
AND3 \$1I545  (.Z0(\$1N569 ), .A0(A0), .A1(\~B0 ), .A2(B1));
AND3 \$1I550  (.Z0(\$1N571 ), .A0(A0), .A1(\~A1 ), .A2(B1));
AND3 \$1I564  (.Z0(\$1N573 ), .A0(\~A0 ), .A1(A1), .A2(B0));
OR4 \$1I568  (.Z0(Z1), .A0(\$1N575 ), .A1(\$1N569 ), .A2(\$1N571 ), 
	.A3(\$1N573 ));
AND4 \$1I582  (.Z0(\$1N606 ), .A0(A1), .A1(\~B0 ), .A2(B1), 
	.A3(\~B2 ));
AND3 \$1I594  (.Z0(\$1N604 ), .A0(\~A0 ), .A1(A1), .A2(B1));
AND3 \$1I598  (.Z0(\$1N602 ), .A0(A0), .A1(\~B1 ), .A2(B2));
AND3 \$1I599  (.Z0(\$1N608 ), .A0(A0), .A1(\~A1 ), .A2(B2));
AND3 \$1I600  (.Z0(\$1N610 ), .A0(A0), .A1(B0), .A2(B2));
OR5 \$1I601  (.Z0(Z2), .A0(\$1N606 ), .A1(\$1N604 ), .A2(\$1N602 ), 
	.A3(\$1N608 ), .A4(\$1N610 ));
INV \$1I677  (.ZN0(\~B2 ), .A0(B2));
INV \$1I678  (.ZN0(\~B3 ), .A0(B3));
INV \$1I680  (.ZN0(\~B0 ), .A0(B0));
INV \$1I681  (.ZN0(\~B1 ), .A0(B1));
AND3 \$2I688  (.Z0(\$2N788 ), .A0(\~A0 ), .A1(A1), .A2(B3));
AND4 \$2I690  (.Z0(\$2N784 ), .A0(A1), .A1(\~B1 ), .A2(\~B2 ), 
	.A3(B3));
AND4 \$2I691  (.Z0(\$2N790 ), .A0(A1), .A1(\~B0 ), .A2(\~B2 ), 
	.A3(B3));
AND4 \$2I692  (.Z0(\$2N794 ), .A0(A0), .A1(A1), .A2(B2), 
	.A3(B3));
AND5 \$2I701  (.Z0(\$2N786 ), .A0(A0), .A1(A1), .A2(B1), 
	.A3(B2), .A4(\~B3 ));
AND5 \$2I719  (.Z0(\$2N792 ), .A0(A0), .A1(A1), .A2(B0), 
	.A3(B1), .A4(B3));
AND3 \$2I730  (.Z0(\$2N736 ), .A0(\~A0 ), .A1(\~B2 ), .A2(B3));
AND4 \$2I731  (.Z0(\$2N728 ), .A0(A0), .A1(A1), .A2(\~B1 ), 
	.A3(B2));
AND5 \$2I732  (.Z0(\$2N737 ), .A0(A1), .A1(B0), .A2(B1), 
	.A3(\~B2 ), .A4(B3));
AND4 \$2I733  (.Z0(\$2N729 ), .A0(\~A0 ), .A1(A1), .A2(B2), 
	.A3(\~B3 ));
AND3 \$2I734  (.Z0(\$2N735 ), .A0(\~A0 ), .A1(\~A1 ), .A2(B3));
AND6 \$2I740  (.Z0(\$2N738 ), .A0(A0), .A1(A1), .A2(B0), 
	.A3(B1), .A4(\~B2 ), .A5(\~B3 ));
OR6 \$2I741  (.Z0(\$2N739 ), .A0(\$2N738 ), .A1(\$2N737 ), .A2(\$2N728 ), 
	.A3(\$2N729 ), .A4(\$2N735 ), .A5(\$2N736 ));
LXOR2 \$2I747  (.Z0(Z3), .A0(B3), .A1(\$2N739 ));
OR4 \$2I782  (.Z0(Z4), .A0(\$2N788 ), .A1(\$2N786 ), .A2(\$2N784 ), 
	.A3(\$2N790 ));
OR2 \$2I783  (.Z0(Z5), .A0(\$2N794 ), .A1(\$2N792 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:10:57 1994
`timescale 10 ps / 10 ps 
module MULT44(
	Z0, Z1, Z2, Z3, 
	Z4, Z5, Z6, Z7, 
	A0, A1, A2, A3, 
	B0, B1, B2, B3);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	input A0;
	input A1;
	input A2;
	input A3;
	input B0;
	input B1;
	input B2;
	input B3;

wire L0;
assign Z0 = L0;
wire L1;
assign Z1 = L1;
MULT24 \$1I760  (.Z0(L0), .Z1(L1), .Z2(L2), .Z3(L3), 
	.Z4(L4), .Z5(L5), .A0(A0), .A1(A1), 
	.B0(B0), .B1(B1), .B2(B2), .B3(B3));
MULT24 \$1I761  (.Z0(H0), .Z1(H1), .Z2(H2), .Z3(H3), 
	.Z4(\$1N856 ), .Z5(\$1N737 ), .A0(A2), .A1(A3), 
	.B0(B0), .B1(B1), .B2(B2), .B3(B3));
LXOR2 \$1I763  (.Z0(Z2), .A0(L2), .A1(H0));
F3ADD \$1I766  (.Z0(Z3), .Z1(Z4), .Z2(Z5), .G012(G345), 
	.P012(P345), .A0(L3), .A1(L4), .A2(L5), 
	.B0(H1), .B1(H2), .B2(H3), .CI(G012));
PG1 \$1I776  (.PGO1(C5), .GI1(G345), .PI1(P345), .PGI1(G012));
LXOR2 \$1I788  (.Z0(Z6), .A0(\$1N856 ), .A1(C5));
AND2 \$1I793  (.Z0(\$1N844 ), .A0(\$1N737 ), .A1(\$1N795 ));
AND3 \$1I802  (.Z0(\$1N842 ), .A0(\$1N736 ), .A1(\$1N856 ), .A2(C5));
INV \$1I810  (.ZN0(\$1N736 ), .A0(\$1N737 ));
INV \$1I812  (.ZN0(\$1N795 ), .A0(C5));
AND2 \$1I820  (.Z0(\$1N839 ), .A0(\$1N853 ), .A1(\$1N737 ));
OR3 \$1I840  (.Z0(Z7), .A0(\$1N839 ), .A1(\$1N842 ), .A2(\$1N844 ));
AND2 \$1I849  (.Z0(G012), .A0(H0), .A1(L2));
INV \$1I854  (.ZN0(\$1N853 ), .A0(\$1N856 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:00 1994
`timescale 10 ps / 10 ps 
module MUX16(
	Z0, A0, A1, A2, 
	A3, A4, A5, A6, 
	A7, A8, A9, A10, 
	A11, A12, A13, A14, 
	A15, S0, S1, S2, 
	S3);

	output Z0;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input A8;
	input A9;
	input A10;
	input A11;
	input A12;
	input A13;
	input A14;
	input A15;
	input S0;
	input S1;
	input S2;
	input S3;

OR16 \$1I198  (.Z0(Z0), .A0(\$1N347 ), .A1(\$1N345 ), .A2(\$1N338 ), 
	.A3(\$1N336 ), .A4(\$1N334 ), .A5(\$1N322 ), .A6(\$1N320 ), 
	.A7(\$1N318 ), .A8(\$1N319 ), .A9(\$1N324 ), .A10(\$1N326 ), 
	.A11(\$1N328 ), .A12(\$1N330 ), .A13(\$1N332 ), .A14(\$1N340 ), 
	.A15(\$1N343 ));
INV \$1I251  (.ZN0(\$1N253 ), .A0(S3));
INV \$1I265  (.ZN0(\$1N266 ), .A0(S2));
INV \$1I283  (.ZN0(\$1N284 ), .A0(S1));
INV \$1I307  (.ZN0(\$1N308 ), .A0(S0));
AND5 \$1I349  (.Z0(\$1N343 ), .A0(A15), .A1(S0), .A2(S1), 
	.A3(S2), .A4(S3));
AND5 \$1I350  (.Z0(\$1N340 ), .A0(A14), .A1(\$1N308 ), .A2(S1), 
	.A3(S2), .A4(S3));
AND5 \$1I351  (.Z0(\$1N332 ), .A0(A13), .A1(S0), .A2(\$1N284 ), 
	.A3(S2), .A4(S3));
AND5 \$1I352  (.Z0(\$1N330 ), .A0(A12), .A1(\$1N308 ), .A2(\$1N284 ), 
	.A3(S2), .A4(S3));
AND5 \$1I353  (.Z0(\$1N328 ), .A0(A11), .A1(S0), .A2(S1), 
	.A3(\$1N266 ), .A4(S3));
AND5 \$1I354  (.Z0(\$1N326 ), .A0(A10), .A1(\$1N308 ), .A2(S1), 
	.A3(\$1N266 ), .A4(S3));
AND5 \$1I355  (.Z0(\$1N324 ), .A0(A9), .A1(S0), .A2(\$1N284 ), 
	.A3(\$1N266 ), .A4(S3));
AND5 \$1I356  (.Z0(\$1N319 ), .A0(A8), .A1(\$1N308 ), .A2(\$1N284 ), 
	.A3(\$1N266 ), .A4(S3));
AND5 \$1I357  (.Z0(\$1N318 ), .A0(A7), .A1(S0), .A2(S1), 
	.A3(S2), .A4(\$1N253 ));
AND5 \$1I358  (.Z0(\$1N320 ), .A0(A6), .A1(\$1N308 ), .A2(S1), 
	.A3(S2), .A4(\$1N253 ));
AND5 \$1I359  (.Z0(\$1N322 ), .A0(A5), .A1(S0), .A2(\$1N284 ), 
	.A3(S2), .A4(\$1N253 ));
AND5 \$1I360  (.Z0(\$1N334 ), .A0(A4), .A1(\$1N308 ), .A2(\$1N284 ), 
	.A3(S2), .A4(\$1N253 ));
AND5 \$1I361  (.Z0(\$1N336 ), .A0(A3), .A1(S0), .A2(S1), 
	.A3(\$1N266 ), .A4(\$1N253 ));
AND5 \$1I362  (.Z0(\$1N338 ), .A0(A2), .A1(\$1N308 ), .A2(S1), 
	.A3(\$1N266 ), .A4(\$1N253 ));
AND5 \$1I363  (.Z0(\$1N345 ), .A0(A1), .A1(S0), .A2(\$1N284 ), 
	.A3(\$1N266 ), .A4(\$1N253 ));
AND5 \$1I364  (.Z0(\$1N347 ), .A0(A0), .A1(\$1N308 ), .A2(\$1N284 ), 
	.A3(\$1N266 ), .A4(\$1N253 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:03 1994
`timescale 10 ps / 10 ps 
module MUX16E(
	Z0, A0, A1, A2, 
	A3, A4, A5, A6, 
	A7, A8, A9, A10, 
	A11, A12, A13, A14, 
	A15, EN, S0, S1, 
	S2, S3);

	output Z0;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input A8;
	input A9;
	input A10;
	input A11;
	input A12;
	input A13;
	input A14;
	input A15;
	input EN;
	input S0;
	input S1;
	input S2;
	input S3;

AND6 \$1I182  (.Z0(\$1N343 ), .A0(A15), .A1(S0), .A2(S1), 
	.A3(S2), .A4(S3), .A5(EN));
AND6 \$1I183  (.Z0(\$1N340 ), .A0(A14), .A1(\$1N308 ), .A2(S1), 
	.A3(S2), .A4(S3), .A5(EN));
AND6 \$1I184  (.Z0(\$1N332 ), .A0(A13), .A1(S0), .A2(\$1N284 ), 
	.A3(S2), .A4(S3), .A5(EN));
AND6 \$1I185  (.Z0(\$1N330 ), .A0(A12), .A1(\$1N308 ), .A2(\$1N284 ), 
	.A3(S2), .A4(S3), .A5(EN));
AND6 \$1I186  (.Z0(\$1N328 ), .A0(A11), .A1(S0), .A2(S1), 
	.A3(\$1N266 ), .A4(S3), .A5(EN));
AND6 \$1I187  (.Z0(\$1N326 ), .A0(A10), .A1(\$1N308 ), .A2(S1), 
	.A3(\$1N266 ), .A4(S3), .A5(EN));
AND6 \$1I188  (.Z0(\$1N324 ), .A0(A9), .A1(S0), .A2(\$1N284 ), 
	.A3(\$1N266 ), .A4(S3), .A5(EN));
AND6 \$1I189  (.Z0(\$1N319 ), .A0(A8), .A1(\$1N308 ), .A2(\$1N284 ), 
	.A3(\$1N266 ), .A4(S3), .A5(EN));
AND6 \$1I190  (.Z0(\$1N318 ), .A0(A7), .A1(S0), .A2(S1), 
	.A3(S2), .A4(\$1N253 ), .A5(EN));
AND6 \$1I191  (.Z0(\$1N320 ), .A0(A6), .A1(\$1N308 ), .A2(S1), 
	.A3(S2), .A4(\$1N253 ), .A5(EN));
AND6 \$1I192  (.Z0(\$1N322 ), .A0(A5), .A1(S0), .A2(\$1N284 ), 
	.A3(S2), .A4(\$1N253 ), .A5(EN));
AND6 \$1I193  (.Z0(\$1N334 ), .A0(A4), .A1(\$1N308 ), .A2(\$1N284 ), 
	.A3(S2), .A4(\$1N253 ), .A5(EN));
AND6 \$1I194  (.Z0(\$1N336 ), .A0(A3), .A1(S0), .A2(S1), 
	.A3(\$1N266 ), .A4(\$1N253 ), .A5(EN));
AND6 \$1I195  (.Z0(\$1N338 ), .A0(A2), .A1(\$1N308 ), .A2(S1), 
	.A3(\$1N266 ), .A4(\$1N253 ), .A5(EN));
AND6 \$1I196  (.Z0(\$1N345 ), .A0(A1), .A1(S0), .A2(\$1N284 ), 
	.A3(\$1N266 ), .A4(\$1N253 ), .A5(EN));
AND6 \$1I197  (.Z0(\$1N347 ), .A0(A0), .A1(\$1N308 ), .A2(\$1N284 ), 
	.A3(\$1N266 ), .A4(\$1N253 ), .A5(EN));
OR16 \$1I198  (.Z0(Z0), .A0(\$1N347 ), .A1(\$1N345 ), .A2(\$1N338 ), 
	.A3(\$1N336 ), .A4(\$1N334 ), .A5(\$1N322 ), .A6(\$1N320 ), 
	.A7(\$1N318 ), .A8(\$1N319 ), .A9(\$1N324 ), .A10(\$1N326 ), 
	.A11(\$1N328 ), .A12(\$1N330 ), .A13(\$1N332 ), .A14(\$1N340 ), 
	.A15(\$1N343 ));
INV \$1I251  (.ZN0(\$1N253 ), .A0(S3));
INV \$1I265  (.ZN0(\$1N266 ), .A0(S2));
INV \$1I283  (.ZN0(\$1N284 ), .A0(S1));
INV \$1I307  (.ZN0(\$1N308 ), .A0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:05 1994
`timescale 10 ps / 10 ps 
module MUX2(
	Z0, A0, A1, S0);

	output Z0;
	input A0;
	input A1;
	input S0;

AND2 \$1I25  (.Z0(\$1N6 ), .A0(A0), .A1(\$1N22 ));
AND2 \$1I31  (.Z0(\$1N8 ), .A0(A1), .A1(S0));
OR2 \$1I35  (.Z0(Z0), .A0(\$1N6 ), .A1(\$1N8 ));
INV \$1I38  (.ZN0(\$1N22 ), .A0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:07 1994
`timescale 10 ps / 10 ps 
module MUX22(
	Z0, Z1, A0, A1, 
	B0, B1, S0);

	output Z0;
	output Z1;
	input A0;
	input A1;
	input B0;
	input B1;
	input S0;

MUX2 \$1I71  (.Z0(Z1), .A0(A1), .A1(B1), .S0(S0));
MUX2 \$1I72  (.Z0(Z0), .A0(A0), .A1(B0), .S0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:10 1994
`timescale 10 ps / 10 ps 
module MUX22E(
	Z0, Z1, A0, A1, 
	B0, B1, EN, S0);

	output Z0;
	output Z1;
	input A0;
	input A1;
	input B0;
	input B1;
	input EN;
	input S0;

MUX2E \$1I71  (.Z0(Z1), .A0(A1), .A1(B1), .EN(EN), 
	.S0(S0));
MUX2E \$1I72  (.Z0(Z0), .A0(A0), .A1(B0), .EN(EN), 
	.S0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:12 1994
`timescale 10 ps / 10 ps 
module MUX24(
	Z0, Z1, A0, A1, 
	B0, B1, C0, C1, 
	D0, D1, S0, S1);

	output Z0;
	output Z1;
	input A0;
	input A1;
	input B0;
	input B1;
	input C0;
	input C1;
	input D0;
	input D1;
	input S0;
	input S1;

MUX4 \$1I186  (.Z0(Z0), .A0(A0), .A1(B0), .A2(C0), 
	.A3(D0), .S0(S0), .S1(S1));
MUX4 \$1I187  (.Z0(Z1), .A0(A1), .A1(B1), .A2(C1), 
	.A3(D1), .S0(S0), .S1(S1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:15 1994
`timescale 10 ps / 10 ps 
module MUX24E(
	Z0, Z1, A0, A1, 
	B0, B1, C0, C1, 
	D0, D1, EN, S0, 
	S1);

	output Z0;
	output Z1;
	input A0;
	input A1;
	input B0;
	input B1;
	input C0;
	input C1;
	input D0;
	input D1;
	input EN;
	input S0;
	input S1;

MUX4E \$1I186  (.Z0(Z0), .A0(A0), .A1(B0), .A2(C0), 
	.A3(D0), .EN(EN), .S0(S0), .S1(S1));
MUX4E \$1I187  (.Z0(Z1), .A0(A1), .A1(B1), .A2(C1), 
	.A3(D1), .EN(EN), .S0(S0), .S1(S1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:17 1994
`timescale 10 ps / 10 ps 
module MUX2E(
	Z0, A0, A1, EN, 
	S0);

	output Z0;
	input A0;
	input A1;
	input EN;
	input S0;

OR2 \$1I35  (.Z0(Z0), .A0(\$1N6 ), .A1(\$1N8 ));
AND3 \$1I43  (.Z0(\$1N6 ), .A0(A0), .A1(\$1N22 ), .A2(EN));
AND3 \$1I44  (.Z0(\$1N8 ), .A0(A1), .A1(S0), .A2(EN));
INV \$1I47  (.ZN0(\$1N22 ), .A0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:19 1994
`timescale 10 ps / 10 ps 
module MUX4(
	Z0, A0, A1, A2, 
	A3, S0, S1);

	output Z0;
	input A0;
	input A1;
	input A2;
	input A3;
	input S0;
	input S1;

OR4 \$1I14  (.Z0(Z0), .A0(\$1N23 ), .A1(\$1N25 ), .A2(\$1N27 ), 
	.A3(\$1N29 ));
AND3 \$1I18  (.Z0(\$1N23 ), .A0(A0), .A1(\$1N40 ), .A2(\$1N42 ));
AND3 \$1I19  (.Z0(\$1N25 ), .A0(A1), .A1(S0), .A2(\$1N42 ));
AND3 \$1I20  (.Z0(\$1N27 ), .A0(A2), .A1(\$1N40 ), .A2(S1));
AND3 \$1I21  (.Z0(\$1N29 ), .A0(A3), .A1(S0), .A2(S1));
INV \$1I76  (.ZN0(\$1N42 ), .A0(S1));
INV \$1I79  (.ZN0(\$1N40 ), .A0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:22 1994
`timescale 10 ps / 10 ps 
module MUX42(
	Z0, Z1, Z2, Z3, 
	A0, A1, A2, A3, 
	B0, B1, B2, B3, 
	S0);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input A0;
	input A1;
	input A2;
	input A3;
	input B0;
	input B1;
	input B2;
	input B3;
	input S0;

MUX2 \$1I71  (.Z0(Z1), .A0(A1), .A1(B1), .S0(S0));
MUX2 \$1I72  (.Z0(Z0), .A0(A0), .A1(B0), .S0(S0));
MUX2 \$1I88  (.Z0(Z3), .A0(A3), .A1(B3), .S0(S0));
MUX2 \$1I89  (.Z0(Z2), .A0(A2), .A1(B2), .S0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:25 1994
`timescale 10 ps / 10 ps 
module MUX42E(
	Z0, Z1, Z2, Z3, 
	A0, A1, A2, A3, 
	B0, B1, B2, B3, 
	EN, S0);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input A0;
	input A1;
	input A2;
	input A3;
	input B0;
	input B1;
	input B2;
	input B3;
	input EN;
	input S0;

MUX2E \$1I71  (.Z0(Z1), .A0(A1), .A1(B1), .EN(EN), 
	.S0(S0));
MUX2E \$1I72  (.Z0(Z0), .A0(A0), .A1(B0), .EN(EN), 
	.S0(S0));
MUX2E \$1I91  (.Z0(Z3), .A0(A3), .A1(B3), .EN(EN), 
	.S0(S0));
MUX2E \$1I92  (.Z0(Z2), .A0(A2), .A1(B2), .EN(EN), 
	.S0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:28 1994
`timescale 10 ps / 10 ps 
module MUX44(
	Z0, Z1, Z2, Z3, 
	A0, A1, A2, A3, 
	B0, B1, B2, B3, 
	C0, C1, C2, C3, 
	D0, D1, D2, D3, 
	S0, S1);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input A0;
	input A1;
	input A2;
	input A3;
	input B0;
	input B1;
	input B2;
	input B3;
	input C0;
	input C1;
	input C2;
	input C3;
	input D0;
	input D1;
	input D2;
	input D3;
	input S0;
	input S1;

MUX4 \$1I186  (.Z0(Z0), .A0(A0), .A1(B0), .A2(C0), 
	.A3(D0), .S0(S0), .S1(S1));
MUX4 \$1I187  (.Z0(Z1), .A0(A1), .A1(B1), .A2(C1), 
	.A3(D1), .S0(S0), .S1(S1));
MUX4 \$1I224  (.Z0(Z3), .A0(A3), .A1(B3), .A2(C3), 
	.A3(D3), .S0(S0), .S1(S1));
MUX4 \$1I225  (.Z0(Z2), .A0(A2), .A1(B2), .A2(C2), 
	.A3(D2), .S0(S0), .S1(S1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:32 1994
`timescale 10 ps / 10 ps 
module MUX44A(
	Z0, Z1, Z2, Z3, 
	A0, A1, A2, A3, 
	B0, B1, B2, B3, 
	C0, C1, C2, C3, 
	D0, D1, D2, D3, 
	S0, S1);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input A0;
	input A1;
	input A2;
	input A3;
	input B0;
	input B1;
	input B2;
	input B3;
	input C0;
	input C1;
	input C2;
	input C3;
	input D0;
	input D1;
	input D2;
	input D3;
	input S0;
	input S1;

MUX4 \$1I186  (.Z0(Z0), .A0(A0), .A1(B0), .A2(C0), 
	.A3(D0), .S0(S0), .S1(S1));
MUX4 \$1I187  (.Z0(Z1), .A0(A1), .A1(B1), .A2(C1), 
	.A3(D1), .S0(S0), .S1(S1));
MUX4 \$1I224  (.Z0(Z3), .A0(A3), .A1(B3), .A2(C3), 
	.A3(D3), .S0(S0), .S1(S1));
MUX4 \$1I225  (.Z0(Z2), .A0(A2), .A1(B2), .A2(C2), 
	.A3(D2), .S0(S0), .S1(S1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:35 1994
`timescale 10 ps / 10 ps 
module MUX44AE(
	Z0, Z1, Z2, Z3, 
	A0, A1, A2, A3, 
	B0, B1, B2, B3, 
	C0, C1, C2, C3, 
	D0, D1, D2, D3, 
	EN, S0, S1);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input A0;
	input A1;
	input A2;
	input A3;
	input B0;
	input B1;
	input B2;
	input B3;
	input C0;
	input C1;
	input C2;
	input C3;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input S0;
	input S1;

MUX4E \$1I186  (.Z0(Z0), .A0(A0), .A1(B0), .A2(C0), 
	.A3(D0), .EN(EN), .S0(S0), .S1(S1));
MUX4E \$1I187  (.Z0(Z1), .A0(A1), .A1(B1), .A2(C1), 
	.A3(D1), .EN(EN), .S0(S0), .S1(S1));
MUX4E \$1I230  (.Z0(Z3), .A0(A3), .A1(B3), .A2(C3), 
	.A3(D3), .EN(EN), .S0(S0), .S1(S1));
MUX4E \$1I231  (.Z0(Z2), .A0(A2), .A1(B2), .A2(C2), 
	.A3(D2), .EN(EN), .S0(S0), .S1(S1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:38 1994
`timescale 10 ps / 10 ps 
module MUX44E(
	Z0, Z1, Z2, Z3, 
	A0, A1, A2, A3, 
	B0, B1, B2, B3, 
	C0, C1, C2, C3, 
	D0, D1, D2, D3, 
	EN, S0, S1);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input A0;
	input A1;
	input A2;
	input A3;
	input B0;
	input B1;
	input B2;
	input B3;
	input C0;
	input C1;
	input C2;
	input C3;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input S0;
	input S1;

MUX4E \$1I186  (.Z0(Z0), .A0(A0), .A1(B0), .A2(C0), 
	.A3(D0), .EN(EN), .S0(S0), .S1(S1));
MUX4E \$1I187  (.Z0(Z1), .A0(A1), .A1(B1), .A2(C1), 
	.A3(D1), .EN(EN), .S0(S0), .S1(S1));
MUX4E \$1I230  (.Z0(Z3), .A0(A3), .A1(B3), .A2(C3), 
	.A3(D3), .EN(EN), .S0(S0), .S1(S1));
MUX4E \$1I231  (.Z0(Z2), .A0(A2), .A1(B2), .A2(C2), 
	.A3(D2), .EN(EN), .S0(S0), .S1(S1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:40 1994
`timescale 10 ps / 10 ps 
module MUX4E(
	Z0, A0, A1, A2, 
	A3, EN, S0, S1);

	output Z0;
	input A0;
	input A1;
	input A2;
	input A3;
	input EN;
	input S0;
	input S1;

OR4 \$1I102  (.Z0(Z0), .A0(\$1N101 ), .A1(\$1N99 ), .A2(\$1N100 ), 
	.A3(\$1N97 ));
INV \$1I107  (.ZN0(\$1N121 ), .A0(S1));
INV \$1I108  (.ZN0(\$1N122 ), .A0(S0));
AND4 \$1I150  (.Z0(\$1N97 ), .A0(A3), .A1(S0), .A2(S1), 
	.A3(EN));
AND4 \$1I152  (.Z0(\$1N100 ), .A0(A2), .A1(\$1N122 ), .A2(S1), 
	.A3(EN));
AND4 \$1I153  (.Z0(\$1N99 ), .A0(A1), .A1(S0), .A2(\$1N121 ), 
	.A3(EN));
AND4 \$1I154  (.Z0(\$1N101 ), .A0(A0), .A1(\$1N122 ), .A2(\$1N121 ), 
	.A3(EN));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:42 1994
`timescale 10 ps / 10 ps 
module MUX8(
	Z0, A0, A1, A2, 
	A3, A4, A5, A6, 
	A7, S0, S1, S2);

	output Z0;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input S0;
	input S1;
	input S2;

OR8 \$1I1  (.Z0(Z0), .A0(\$1N22 ), .A1(\$1N24 ), .A2(\$1N26 ), 
	.A3(\$1N28 ), .A4(\$1N30 ), .A5(\$1N37 ), .A6(\$1N35 ), 
	.A7(\$1N33 ));
AND4 \$1I10  (.Z0(\$1N22 ), .A0(A0), .A1(\$1N101 ), .A2(\$1N103 ), 
	.A3(\$1N105 ));
AND4 \$1I11  (.Z0(\$1N24 ), .A0(A1), .A1(S0), .A2(\$1N103 ), 
	.A3(\$1N105 ));
AND4 \$1I12  (.Z0(\$1N26 ), .A0(A2), .A1(\$1N101 ), .A2(S1), 
	.A3(\$1N105 ));
AND4 \$1I13  (.Z0(\$1N28 ), .A0(A3), .A1(S0), .A2(S1), 
	.A3(\$1N105 ));
AND4 \$1I14  (.Z0(\$1N30 ), .A0(A4), .A1(\$1N101 ), .A2(\$1N103 ), 
	.A3(S2));
AND4 \$1I140  (.Z0(\$1N33 ), .A0(A7), .A1(S0), .A2(S1), 
	.A3(S2));
AND4 \$1I142  (.Z0(\$1N35 ), .A0(A6), .A1(\$1N101 ), .A2(S1), 
	.A3(S2));
INV \$1I147  (.ZN0(\$1N101 ), .A0(S0));
AND4 \$1I15  (.Z0(\$1N37 ), .A0(A5), .A1(S0), .A2(\$1N103 ), 
	.A3(S2));
INV \$1I18  (.ZN0(\$1N105 ), .A0(S2));
INV \$1I21  (.ZN0(\$1N103 ), .A0(S1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:45 1994
`timescale 10 ps / 10 ps 
module MUX82(
	Z0, Z1, Z2, Z3, 
	Z4, Z5, Z6, Z7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	B0, B1, B2, B3, 
	B4, B5, B6, B7, 
	S0);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input B0;
	input B1;
	input B2;
	input B3;
	input B4;
	input B5;
	input B6;
	input B7;
	input S0;

MUX2 \$1I202  (.Z0(Z0), .A0(A0), .A1(B0), .S0(S0));
MUX2 \$1I210  (.Z0(Z1), .A0(A1), .A1(B1), .S0(S0));
MUX2 \$1I211  (.Z0(Z2), .A0(A2), .A1(B2), .S0(S0));
MUX2 \$1I212  (.Z0(Z3), .A0(A3), .A1(B3), .S0(S0));
MUX2 \$1I213  (.Z0(Z4), .A0(A4), .A1(B4), .S0(S0));
MUX2 \$1I214  (.Z0(Z5), .A0(A5), .A1(B5), .S0(S0));
MUX2 \$1I215  (.Z0(Z6), .A0(A6), .A1(B6), .S0(S0));
MUX2 \$1I216  (.Z0(Z7), .A0(A7), .A1(B7), .S0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:48 1994
`timescale 10 ps / 10 ps 
module MUX82E(
	Z0, Z1, Z2, Z3, 
	Z4, Z5, Z6, Z7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	B0, B1, B2, B3, 
	B4, B5, B6, B7, 
	EN, S0);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input B0;
	input B1;
	input B2;
	input B3;
	input B4;
	input B5;
	input B6;
	input B7;
	input EN;
	input S0;

MUX2E \$1I202  (.Z0(Z0), .A0(A0), .A1(B0), .EN(EN), 
	.S0(S0));
MUX2E \$1I210  (.Z0(Z1), .A0(A1), .A1(B1), .EN(EN), 
	.S0(S0));
MUX2E \$1I211  (.Z0(Z2), .A0(A2), .A1(B2), .EN(EN), 
	.S0(S0));
MUX2E \$1I212  (.Z0(Z3), .A0(A3), .A1(B3), .EN(EN), 
	.S0(S0));
MUX2E \$1I213  (.Z0(Z4), .A0(A4), .A1(B4), .EN(EN), 
	.S0(S0));
MUX2E \$1I214  (.Z0(Z5), .A0(A5), .A1(B5), .EN(EN), 
	.S0(S0));
MUX2E \$1I215  (.Z0(Z6), .A0(A6), .A1(B6), .EN(EN), 
	.S0(S0));
MUX2E \$1I216  (.Z0(Z7), .A0(A7), .A1(B7), .EN(EN), 
	.S0(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:50 1994
`timescale 10 ps / 10 ps 
module MUX8E(
	Z0, A0, A1, A2, 
	A3, A4, A5, A6, 
	A7, EN, S0, S1, 
	S2);

	output Z0;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input EN;
	input S0;
	input S1;
	input S2;

OR8 \$1I1  (.Z0(Z0), .A0(\$1N22 ), .A1(\$1N24 ), .A2(\$1N26 ), 
	.A3(\$1N28 ), .A4(\$1N30 ), .A5(\$1N37 ), .A6(\$1N35 ), 
	.A7(\$1N33 ));
INV \$1I147  (.ZN0(\$1N101 ), .A0(S0));
AND5 \$1I165  (.Z0(\$1N33 ), .A0(A7), .A1(S0), .A2(S1), 
	.A3(S2), .A4(EN));
AND5 \$1I168  (.Z0(\$1N35 ), .A0(A6), .A1(\$1N101 ), .A2(S1), 
	.A3(S2), .A4(EN));
AND5 \$1I170  (.Z0(\$1N37 ), .A0(A5), .A1(S0), .A2(\$1N103 ), 
	.A3(S2), .A4(EN));
AND5 \$1I172  (.Z0(\$1N30 ), .A0(A4), .A1(\$1N101 ), .A2(\$1N103 ), 
	.A3(S2), .A4(EN));
AND5 \$1I174  (.Z0(\$1N28 ), .A0(A3), .A1(S0), .A2(S1), 
	.A3(\$1N105 ), .A4(EN));
AND5 \$1I176  (.Z0(\$1N26 ), .A0(A2), .A1(\$1N101 ), .A2(S1), 
	.A3(\$1N105 ), .A4(EN));
AND5 \$1I178  (.Z0(\$1N24 ), .A0(A1), .A1(S0), .A2(\$1N103 ), 
	.A3(\$1N105 ), .A4(EN));
INV \$1I18  (.ZN0(\$1N105 ), .A0(S2));
AND5 \$1I180  (.Z0(\$1N22 ), .A0(A0), .A1(\$1N101 ), .A2(\$1N103 ), 
	.A3(\$1N105 ), .A4(EN));
INV \$1I21  (.ZN0(\$1N103 ), .A0(S1));
endmodule
/*
* Translated from EDIF description NAND10                                     *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NAND10 lib :  NAND10                        *
*/
/*
* Library NAND10                                                              *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NAND10"                                                               *
*/
`timescale 10 ps / 10 ps
module NAND10 (ZN0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;

    output  ZN0;



    and
        \$1I1  (\$1N37 , A0, A1, A2, A3, A4, A5, A6, A7);
    nand
        \$1I36  (ZN0, \$1N37 , A8, A9);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NAND11                                     *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NAND11 lib :  NAND11                        *
*/
/*
* Library NAND11                                                              *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NAND11"                                                               *
*/
`timescale 10 ps / 10 ps
module NAND11 (ZN0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;

    output  ZN0;



    and
        \$1I1  (\$1N37 , A0, A1, A2, A3, A4, A5, A6, A7);
    nand
        \$1I36  (ZN0, \$1N37 , A8, A9, A10);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NAND12                                     *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NAND12 lib :  NAND12                        *
*/
/*
* Library NAND12                                                              *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NAND12"                                                               *
*/
`timescale 10 ps / 10 ps
module NAND12 (ZN0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;

    output  ZN0;



    and
        \$1I1  (\$1N39 , A0, A1, A2, A3, A4, A5, A6, A7);
    nand
        \$1I35  (ZN0, \$1N39 , A8, A9, A10, A11);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NAND16                                     *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NAND16 lib :  NAND16                        *
*/
/*
* Library NAND16                                                              *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NAND16"                                                               *
*/
`timescale 10 ps / 10 ps
module NAND16 (ZN0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, 
       A15);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;

    output  ZN0;



    and
        \$1I1  (\$1N36 , A0, A1, A2, A3, A4, A5, A6, A7);
    nand
        \$1I35  (ZN0, \$1N36 , \$1N49 );
    and
        \$1I40  (\$1N49 , A8, A9, A10, A11, A12, A13, A14, A15);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NAND2                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NAND2 lib :  NAND2                          *
*/
/*
* Library NAND2                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NAND2"                                                                *
*/
`timescale 10 ps / 10 ps
module NAND2 (ZN0, A0, A1);

    input  A0;
    input  A1;

    output  ZN0;



    nand
        \$1I1  (ZN0, A0, A1);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NAND3                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NAND3 lib :  NAND3                          *
*/
/*
* Library NAND3                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NAND3"                                                                *
*/
`timescale 10 ps / 10 ps
module NAND3 (ZN0, A0, A1, A2);

    input  A0;
    input  A1;
    input  A2;

    output  ZN0;



    nand
        \$1I1  (ZN0, A0, A1, A2);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NAND4                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NAND4 lib :  NAND4                          *
*/
/*
* Library NAND4                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NAND4"                                                                *
*/
`timescale 10 ps / 10 ps
module NAND4 (ZN0, A0, A1, A2, A3);

    input  A0;
    input  A1;
    input  A2;
    input  A3;

    output  ZN0;



    nand
        \$1I1  (ZN0, A0, A1, A2, A3);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NAND5                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NAND5 lib :  NAND5                          *
*/
/*
* Library NAND5                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NAND5"                                                                *
*/
`timescale 10 ps / 10 ps
module NAND5 (ZN0, A0, A1, A2, A3, A4);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;

    output  ZN0;



    nand
        \$1I1  (ZN0, A0, A1, A2, A3, A4);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NAND6                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NAND6 lib :  NAND6                          *
*/
/*
* Library NAND6                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NAND6"                                                                *
*/
`timescale 10 ps / 10 ps
module NAND6 (ZN0, A0, A1, A2, A3, A4, A5);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;

    output  ZN0;



    nand
        \$1I1  (ZN0, A0, A1, A2, A3, A4, A5);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NAND7                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NAND7 lib :  NAND7                          *
*/
/*
* Library NAND7                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NAND7"                                                                *
*/
`timescale 10 ps / 10 ps
module NAND7 (ZN0, A0, A1, A2, A3, A4, A5, A6);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;

    output  ZN0;



    nand
        \$1I1  (ZN0, A0, A1, A2, A3, A4, A5, A6);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NAND8                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NAND8 lib :  NAND8                          *
*/
/*
* Library NAND8                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NAND8"                                                                *
*/
`timescale 10 ps / 10 ps
module NAND8 (ZN0, A0, A1, A2, A3, A4, A5, A6, A7);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;

    output  ZN0;



    nand
        \$1I1  (ZN0, A0, A1, A2, A3, A4, A5, A6, A7);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NAND9                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NAND9 lib :  NAND9                          *
*/
/*
* Library NAND9                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NAND9"                                                                *
*/
`timescale 10 ps / 10 ps
module NAND9 (ZN0, A0, A1, A2, A3, A4, A5, A6, A7, A8);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;

    output  ZN0;



    and
        \$1I1  (\$1N36 , A0, A1, A2, A3, A4, A5, A6, A7);
    nand
        \$1I35  (ZN0, \$1N36 , A8);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NOR10                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NOR10 lib :  NOR10                          *
*/
/*
* Library NOR10                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NOR10"                                                                *
*/
`timescale 10 ps / 10 ps
module NOR10 (ZN0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;

    output  ZN0;



    or
        \$1I1  (\$1N14 , A0, A1, A2, A3, A4, A5, A6, A7);
    nor
        \$1I13  (ZN0, \$1N14 , A8, A9);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NOR11                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NOR11 lib :  NOR11                          *
*/
/*
* Library NOR11                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NOR11"                                                                *
*/
`timescale 10 ps / 10 ps
module NOR11 (ZN0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;

    output  ZN0;



    or
        \$1I10  (\$1N9 , A0, A1, A2, A3, A4, A5, A6, A7);
    nor
        \$1I11  (ZN0, \$1N9 , A8, A9, A10);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NOR12                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NOR12 lib :  NOR12                          *
*/
/*
* Library NOR12                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NOR12"                                                                *
*/
`timescale 10 ps / 10 ps
module NOR12 (ZN0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;

    output  ZN0;



    or
        \$1I1  (\$1N12 , A0, A1, A2, A3, A4, A5, A6, A7);
    nor
        \$1I11  (ZN0, \$1N12 , A8, A9, A10, A11);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NOR16                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NOR16 lib :  NOR16                          *
*/
/*
* Library NOR16                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NOR16"                                                                *
*/
`timescale 10 ps / 10 ps
module NOR16 (ZN0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, 
      A15);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;

    output  ZN0;



    or
        \$1I1  (\$1N12 , A0, A1, A2, A3, A4, A5, A6, A7);
    nor
        \$1I11  (ZN0, \$1N12 , \$1N17 );
    or
        \$1I16  (\$1N17 , A8, A9, A10, A11, A12, A13, A14, A15);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NOR2                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NOR2 lib :  NOR2                            *
*/
/*
* Library NOR2                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NOR2"                                                                 *
*/
`timescale 10 ps / 10 ps
module NOR2 (ZN0, A0, A1);

    input  A0;
    input  A1;

    output  ZN0;



    nor
        \$1I1  (ZN0, A0, A1);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NOR3                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NOR3 lib :  NOR3                            *
*/
/*
* Library NOR3                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NOR3"                                                                 *
*/
`timescale 10 ps / 10 ps
module NOR3 (ZN0, A0, A1, A2);

    input  A0;
    input  A1;
    input  A2;

    output  ZN0;



    nor
        \$1I1  (ZN0, A0, A1, A2);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NOR4                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NOR4 lib :  NOR4                            *
*/
/*
* Library NOR4                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NOR4"                                                                 *
*/
`timescale 10 ps / 10 ps
module NOR4 (ZN0, A0, A1, A2, A3);

    input  A0;
    input  A1;
    input  A2;
    input  A3;

    output  ZN0;



    nor
        \$1I1  (ZN0, A0, A1, A2, A3);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NOR5                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NOR5 lib :  NOR5                            *
*/
/*
* Library NOR5                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NOR5"                                                                 *
*/
`timescale 10 ps / 10 ps
module NOR5 (ZN0, A0, A1, A2, A3, A4);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;

    output  ZN0;



    nor
        \$1I1  (ZN0, A0, A1, A2, A3, A4);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NOR6                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NOR6 lib :  NOR6                            *
*/
/*
* Library NOR6                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NOR6"                                                                 *
*/
`timescale 10 ps / 10 ps
module NOR6 (ZN0, A0, A1, A2, A3, A4, A5);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;

    output  ZN0;



    nor
        \$1I1  (ZN0, A0, A1, A2, A3, A4, A5);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NOR7                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NOR7 lib :  NOR7                            *
*/
/*
* Library NOR7                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NOR7"                                                                 *
*/
`timescale 10 ps / 10 ps
module NOR7 (ZN0, A0, A1, A2, A3, A4, A5, A6);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;

    output  ZN0;



    nor
        \$1I1  (ZN0, A0, A1, A2, A3, A4, A5, A6);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NOR8                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NOR8 lib :  NOR8                            *
*/
/*
* Library NOR8                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NOR8"                                                                 *
*/
`timescale 10 ps / 10 ps
module NOR8 (ZN0, A0, A1, A2, A3, A4, A5, A6, A7);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;

    output  ZN0;



    nor
        \$1I1  (ZN0, A0, A1, A2, A3, A4, A5, A6, A7);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description NOR9                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  NOR9 lib :  NOR9                            *
*/
/*
* Library NOR9                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell NOR9"                                                                 *
*/
`timescale 10 ps / 10 ps
module NOR9 (ZN0, A0, A1, A2, A3, A4, A5, A6, A7, A8);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;

    output  ZN0;



    or
        \$1I1  (\$1N12 , A0, A1, A2, A3, A4, A5, A6, A7);
    nor
        \$1I11  (ZN0, \$1N12 , A8);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:52 1994
`timescale 10 ps / 10 ps 
module OB11(
	XO0, A0);

	output XO0;
	input A0;

XOUTPUT \$1I42  (.XO0(XO0), .A0(A0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:54 1994
`timescale 10 ps / 10 ps 
module OB21(
	XO0, A0);

	output XO0;
	input A0;

XOUTPUT \$1I42  (.XO0(XO0), .A0(\$1N48 ));
XINV \$1I49  (.ZN0(\$1N48 ), .A0(A0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:11:57 1994
`timescale 10 ps / 10 ps 
module OB24(
	XO0, XO1, XO2, XO3, 
	A0, A1, A2, A3);

	output XO0;
	output XO1;
	output XO2;
	output XO3;
	input A0;
	input A1;
	input A2;
	input A3;

OB21 \$1I150  (.XO0(XO3), .A0(A3));
OB21 \$1I154  (.XO0(XO2), .A0(A2));
OB21 \$1I155  (.XO0(XO1), .A0(A1));
OB21 \$1I156  (.XO0(XO0), .A0(A0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:00 1994
`timescale 10 ps / 10 ps 
module OB28(
	XO0, XO1, XO2, XO3, 
	XO4, XO5, XO6, XO7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7);

	output XO0;
	output XO1;
	output XO2;
	output XO3;
	output XO4;
	output XO5;
	output XO6;
	output XO7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;

OB21 \$1I150  (.XO0(XO6), .A0(A6));
OB21 \$1I154  (.XO0(XO4), .A0(A4));
OB21 \$1I155  (.XO0(XO2), .A0(A2));
OB21 \$1I156  (.XO0(XO0), .A0(A0));
OB21 \$1I157  (.XO0(XO1), .A0(A1));
OB21 \$1I158  (.XO0(XO3), .A0(A3));
OB21 \$1I159  (.XO0(XO5), .A0(A5));
OB21 \$1I160  (.XO0(XO7), .A0(A7));
endmodule
`timescale 10 ps / 10 ps
module OD11(
	CLK, D0, XQ0);


	input CLK;
	input D0;
	output XQ0;



XDFF1 \$1I25  (.Q0 (XQ0), .D0 (D0), .CLK (CLK));
endmodule
`timescale 10 ps / 10 ps
module OD11E(
	CLK, D0, EN, XQ0);


	input CLK;
	input D0;
	input EN;
	output XQ0;



XDFF1E \$1I37  (.Q0 (XQ0), .D0 (D0), .CLK (CLK), 
	.EN (EN));
endmodule
`timescale 10 ps / 10 ps
module OD14(
	CLK, D0, D1, D2, D3, XQ0, XQ1, XQ2, XQ3);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	output XQ0;
	output XQ1;
	output XQ2;
	output XQ3;



OD11 \$1I130  (.XQ0 (XQ1), .D0 (D1), .CLK (CLK));
OD11 \$1I129  (.XQ0 (XQ2), .D0 (D2), .CLK (CLK));
OD11 \$1I128  (.XQ0 (XQ3), .D0 (D3), .CLK (CLK));
OD11 \$1I131  (.XQ0 (XQ0), .D0 (D0), .CLK (CLK));
endmodule
`timescale 10 ps / 10 ps
module OD14E(
	CLK, D0, D1, D2, D3, EN, XQ0, XQ1, XQ2, XQ3);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	output XQ0;
	output XQ1;
	output XQ2;
	output XQ3;



OD11E \$1I155  (.XQ0 (XQ3), .D0 (D3), .CLK (CLK), 
	.EN (EN));
OD11E \$1I154  (.XQ0 (XQ2), .D0 (D2), .CLK (CLK), 
	.EN (EN));
OD11E \$1I153  (.XQ0 (XQ1), .D0 (D1), .CLK (CLK), 
	.EN (EN));
OD11E \$1I152  (.XQ0 (XQ0), .D0 (D0), .CLK (CLK), 
	.EN (EN));
endmodule
`timescale 10 ps / 10 ps
module OD21(
	CLK, D0, XQ0);


	input CLK;
	input D0;
	output XQ0;



INV \$1I37  (.ZN0 (\$1N38 ), .A0 (CLK));
XDFF1 \$1I25  (.Q0 (XQ0), .D0 (D0), .CLK (\$1N38 ));
endmodule
`timescale 10 ps / 10 ps
module OD24(
	CLK, D0, D1, D2, D3, XQ0, XQ1, XQ2, XQ3);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	output XQ0;
	output XQ1;
	output XQ2;
	output XQ3;



OD21 \$1I131  (.XQ0 (XQ0), .D0 (D0), .CLK (CLK));
OD21 \$1I130  (.XQ0 (XQ1), .D0 (D1), .CLK (CLK));
OD21 \$1I129  (.XQ0 (XQ2), .D0 (D2), .CLK (CLK));
OD21 \$1I128  (.XQ0 (XQ3), .D0 (D3), .CLK (CLK));
endmodule
`timescale 10 ps / 10 ps
module OD31(
	CD, CLK, D0, XQ0);


	input CD;
	input CLK;
	input D0;
	output XQ0;



XDFF2 \$1I25  (.Q0 (XQ0), .D0 (D0), .CLK (CLK), 
	.CD (CD));
endmodule
`timescale 10 ps / 10 ps
module OD31E(
	CD, CLK, D0, EN, XQ0);


	input CD;
	input CLK;
	input D0;
	input EN;
	output XQ0;



XDFF2E \$1I25  (.Q0 (XQ0), .D0 (D0), .CLK (CLK), 
	.CD (CD), .EN (EN));
endmodule
`timescale 10 ps / 10 ps
module OD34(
	CD, CLK, D0, D1, D2, D3, XQ0, XQ1, XQ2, XQ3);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	output XQ0;
	output XQ1;
	output XQ2;
	output XQ3;



OD31 \$1I131  (.XQ0 (XQ0), .D0 (D0), .CLK (CLK), 
	.CD (CD));
OD31 \$1I130  (.XQ0 (XQ1), .D0 (D1), .CLK (CLK), 
	.CD (CD));
OD31 \$1I129  (.XQ0 (XQ2), .D0 (D2), .CLK (CLK), 
	.CD (CD));
OD31 \$1I128  (.XQ0 (XQ3), .D0 (D3), .CLK (CLK), 
	.CD (CD));
endmodule
`timescale 10 ps / 10 ps
module OD34E(
	CD, CLK, D0, D1, D2, D3, EN, XQ0, XQ1, XQ2, XQ3);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	output XQ0;
	output XQ1;
	output XQ2;
	output XQ3;



OD31E \$1I160  (.XQ0 (XQ3), .D0 (D3), .CLK (CLK), 
	.CD (CD), .EN (EN));
OD31E \$1I159  (.XQ0 (XQ2), .D0 (D2), .CLK (CLK), 
	.CD (CD), .EN (EN));
OD31E \$1I158  (.XQ0 (XQ1), .D0 (D1), .CLK (CLK), 
	.CD (CD), .EN (EN));
OD31E \$1I157  (.XQ0 (XQ0), .D0 (D0), .CLK (CLK), 
	.CD (CD), .EN (EN));
endmodule
`timescale 10 ps / 10 ps
module OD41(
	CLK, D0, SD, XQ0);


	input CLK;
	input D0;
	input SD;
	output XQ0;



XDFF3 \$1I25  (.Q0 (XQ0), .D0 (D0), .CLK (CLK), 
	.SD (SD));
endmodule
`timescale 10 ps / 10 ps
module OD41E(
	CLK, D0, EN, SD, XQ0);


	input CLK;
	input D0;
	input EN;
	input SD;
	output XQ0;



XDFF3E \$1I25  (.Q0 (XQ0), .D0 (D0), .CLK (CLK), 
	.SD (SD), .EN (EN));
endmodule
`timescale 10 ps / 10 ps
module OD44(
	CLK, D0, D1, D2, D3, SD, XQ0, XQ1, XQ2, XQ3);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input SD;
	output XQ0;
	output XQ1;
	output XQ2;
	output XQ3;



OD41 \$1I131  (.XQ0 (XQ0), .D0 (D0), .CLK (CLK), 
	.SD (SD));
OD41 \$1I130  (.XQ0 (XQ1), .D0 (D1), .CLK (CLK), 
	.SD (SD));
OD41 \$1I129  (.XQ0 (XQ2), .D0 (D2), .CLK (CLK), 
	.SD (SD));
OD41 \$1I128  (.XQ0 (XQ3), .D0 (D3), .CLK (CLK), 
	.SD (SD));
endmodule
`timescale 10 ps / 10 ps
module OD44E(
	CLK, D0, D1, D2, D3, EN, SD, XQ0, XQ1, XQ2, XQ3);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input SD;
	output XQ0;
	output XQ1;
	output XQ2;
	output XQ3;



OD41E \$1I161  (.XQ0 (XQ3), .D0 (D3), .CLK (CLK), 
	.SD (SD), .EN (EN));
OD41E \$1I160  (.XQ0 (XQ2), .D0 (D2), .CLK (CLK), 
	.SD (SD), .EN (EN));
OD41E \$1I158  (.XQ0 (XQ1), .D0 (D1), .CLK (CLK), 
	.SD (SD), .EN (EN));
OD41E \$1I157  (.XQ0 (XQ0), .D0 (D0), .CLK (CLK), 
	.SD (SD), .EN (EN));
endmodule
`timescale 10 ps / 10 ps
module OD51(
	CD, CLK, D0, SD, XQ0);


	input CD;
	input CLK;
	input D0;
	input SD;
	output XQ0;



XDFF4 \$1I25  (.Q0 (XQ0), .D0 (D0), .CLK (CLK), 
	.SD (SD), .CD (CD));
endmodule
`timescale 10 ps / 10 ps
module OD51E(
	CD, CLK, D0, EN, SD, XQ0);


	input CD;
	input CLK;
	input D0;
	input EN;
	input SD;
	output XQ0;



XDFF4E \$1I25  (.Q0 (XQ0), .D0 (D0), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
endmodule
`timescale 10 ps / 10 ps
module OD54(
	CD, CLK, D0, D1, D2, D3, SD, XQ0, XQ1, XQ2, XQ3);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input SD;
	output XQ0;
	output XQ1;
	output XQ2;
	output XQ3;



OD51 \$1I131  (.XQ0 (XQ0), .D0 (D0), .CLK (CLK), 
	.SD (SD), .CD (CD));
OD51 \$1I130  (.XQ0 (XQ1), .D0 (D1), .CLK (CLK), 
	.SD (SD), .CD (CD));
OD51 \$1I129  (.XQ0 (XQ2), .D0 (D2), .CLK (CLK), 
	.SD (SD), .CD (CD));
OD51 \$1I128  (.XQ0 (XQ3), .D0 (D3), .CLK (CLK), 
	.SD (SD), .CD (CD));
endmodule
`timescale 10 ps / 10 ps
module OD54E(
	CD, CLK, D0, D1, D2, D3, EN, SD, XQ0, XQ1, XQ2, XQ3);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input SD;
	output XQ0;
	output XQ1;
	output XQ2;
	output XQ3;



OD51E \$1I165  (.XQ0 (XQ3), .D0 (D3), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
OD51E \$1I164  (.XQ0 (XQ2), .D0 (D2), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
OD51E \$1I163  (.XQ0 (XQ1), .D0 (D1), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
OD51E \$1I162  (.XQ0 (XQ0), .D0 (D0), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
endmodule
`timescale 10 ps / 10 ps
module ODT11(
	CLK, D0, OE, XO0);


	input CLK;
	input D0;
	input OE;
	output XO0;



XTRI1 \$1I26  (.XO0 (XO0), .A0 (\$1N27 ), .OE (OE));
XDFF1 \$1I25  (.Q0 (\$1N27 ), .D0 (D0), .CLK (CLK));
endmodule
`timescale 10 ps / 10 ps
module ODT11E(
	CLK, D0, EN, OE, XO0);


	input CLK;
	input D0;
	input EN;
	input OE;
	output XO0;



XTRI1 \$1I26  (.XO0 (XO0), .A0 (\$1N27 ), .OE (OE));
XDFF1E \$1I37  (.Q0 (\$1N27 ), .D0 (D0), .CLK (CLK), 
	.EN (EN));
endmodule
`timescale 10 ps / 10 ps
module ODT14(
	CLK, D0, D1, D2, D3, OE, XO0, XO1, XO2, XO3);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input OE;
	output XO0;
	output XO1;
	output XO2;
	output XO3;



ODT11 \$1I165  (.XO0 (XO3), .D0 (D3), .CLK (CLK), 
	.OE (OE));
ODT11 \$1I164  (.XO0 (XO2), .D0 (D2), .CLK (CLK), 
	.OE (OE));
ODT11 \$1I163  (.XO0 (XO1), .D0 (D1), .CLK (CLK), 
	.OE (OE));
ODT11 \$1I162  (.XO0 (XO0), .D0 (D0), .CLK (CLK), 
	.OE (OE));
endmodule
`timescale 10 ps / 10 ps
module ODT14E(
	CLK, D0, D1, D2, D3, EN, OE, XO0, XO1, XO2, XO3);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input OE;
	output XO0;
	output XO1;
	output XO2;
	output XO3;



ODT11E \$1I198  (.XO0 (XO3), .D0 (D3), .CLK (CLK), 
	.EN (EN), .OE (OE));
ODT11E \$1I197  (.XO0 (XO2), .D0 (D2), .CLK (CLK), 
	.EN (EN), .OE (OE));
ODT11E \$1I196  (.XO0 (XO1), .D0 (D1), .CLK (CLK), 
	.EN (EN), .OE (OE));
ODT11E \$1I195  (.XO0 (XO0), .D0 (D0), .CLK (CLK), 
	.EN (EN), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module ODT21(
	CD, CLK, D0, OE, XO0);


	input CD;
	input CLK;
	input D0;
	input OE;
	output XO0;



XTRI1 \$1I26  (.XO0 (XO0), .A0 (\$1N27 ), .OE (OE));
XDFF2 \$1I25  (.Q0 (\$1N27 ), .D0 (D0), .CLK (CLK), 
	.CD (CD));
endmodule
`timescale 10 ps / 10 ps
module ODT21E(
	CD, CLK, D0, EN, OE, XO0);


	input CD;
	input CLK;
	input D0;
	input EN;
	input OE;
	output XO0;



XDFF2E \$1I37  (.Q0 (\$1N27 ), .D0 (D0), .CLK (CLK), 
	.CD (CD), .EN (EN));
XTRI1 \$1I26  (.XO0 (XO0), .A0 (\$1N27 ), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module ODT24(
	CD, CLK, D0, D1, D2, D3, OE, XO0, XO1, XO2, XO3);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input OE;
	output XO0;
	output XO1;
	output XO2;
	output XO3;



ODT21 \$1I162  (.XO0 (XO0), .D0 (D0), .CLK (CLK), 
	.CD (CD), .OE (OE));
ODT21 \$1I163  (.XO0 (XO1), .D0 (D1), .CLK (CLK), 
	.CD (CD), .OE (OE));
ODT21 \$1I164  (.XO0 (XO2), .D0 (D2), .CLK (CLK), 
	.CD (CD), .OE (OE));
ODT21 \$1I165  (.XO0 (XO3), .D0 (D3), .CLK (CLK), 
	.CD (CD), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module ODT24E(
	CD, CLK, D0, D1, D2, D3, EN, OE, XO0, XO1, XO2, XO3);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input OE;
	output XO0;
	output XO1;
	output XO2;
	output XO3;



ODT21E \$1I195  (.XO0 (XO0), .D0 (D0), .CLK (CLK), 
	.EN (EN), .CD (CD), .OE (OE));
ODT21E \$1I196  (.XO0 (XO1), .D0 (D1), .CLK (CLK), 
	.EN (EN), .CD (CD), .OE (OE));
ODT21E \$1I197  (.XO0 (XO2), .D0 (D2), .CLK (CLK), 
	.EN (EN), .CD (CD), .OE (OE));
ODT21E \$1I198  (.XO0 (XO3), .D0 (D3), .CLK (CLK), 
	.EN (EN), .CD (CD), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module ODT31(
	CLK, D0, OE, SD, XO0);


	input CLK;
	input D0;
	input OE;
	input SD;
	output XO0;



XTRI1 \$1I26  (.XO0 (XO0), .A0 (\$1N27 ), .OE (OE));
XDFF3 \$1I25  (.Q0 (\$1N27 ), .D0 (D0), .CLK (CLK), 
	.SD (SD));
endmodule
`timescale 10 ps / 10 ps
module ODT31E(
	CLK, D0, EN, OE, SD, XO0);


	input CLK;
	input D0;
	input EN;
	input OE;
	input SD;
	output XO0;



XTRI1 \$1I26  (.XO0 (XO0), .A0 (\$1N27 ), .OE (OE));
XDFF3E \$1I37  (.Q0 (\$1N27 ), .D0 (D0), .CLK (CLK), 
	.SD (SD), .EN (EN));
endmodule
`timescale 10 ps / 10 ps
module ODT34(
	CLK, D0, D1, D2, D3, OE, SD, XO0, XO1, XO2, XO3);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input OE;
	input SD;
	output XO0;
	output XO1;
	output XO2;
	output XO3;



ODT31 \$1I162  (.XO0 (XO0), .D0 (D0), .CLK (CLK), 
	.SD (SD), .OE (OE));
ODT31 \$1I163  (.XO0 (XO1), .D0 (D1), .CLK (CLK), 
	.SD (SD), .OE (OE));
ODT31 \$1I164  (.XO0 (XO2), .D0 (D2), .CLK (CLK), 
	.SD (SD), .OE (OE));
ODT31 \$1I165  (.XO0 (XO3), .D0 (D3), .CLK (CLK), 
	.SD (SD), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module ODT34E(
	CLK, D0, D1, D2, D3, EN, OE, SD, XO0, XO1, XO2, XO3);


	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input OE;
	input SD;
	output XO0;
	output XO1;
	output XO2;
	output XO3;



ODT31E \$1I204  (.XO0 (XO3), .D0 (D3), .CLK (CLK), 
	.EN (EN), .SD (SD), .OE (OE));
ODT31E \$1I203  (.XO0 (XO2), .D0 (D2), .CLK (CLK), 
	.EN (EN), .SD (SD), .OE (OE));
ODT31E \$1I202  (.XO0 (XO1), .D0 (D1), .CLK (CLK), 
	.EN (EN), .SD (SD), .OE (OE));
ODT31E \$1I201  (.XO0 (XO0), .D0 (D0), .CLK (CLK), 
	.EN (EN), .SD (SD), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module ODT41(
	CD, CLK, D0, OE, SD, XO0);


	input CD;
	input CLK;
	input D0;
	input OE;
	input SD;
	output XO0;



XDFF4 \$1I25  (.Q0 (\$1N27 ), .D0 (D0), .CLK (CLK), 
	.SD (SD), .CD (CD));
XTRI1 \$1I26  (.XO0 (XO0), .A0 (\$1N27 ), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module ODT41E(
	CD, CLK, D0, EN, OE, SD, XO0);


	input CD;
	input CLK;
	input D0;
	input EN;
	input OE;
	input SD;
	output XO0;



XDFF4E \$1I37  (.Q0 (\$1N27 ), .D0 (D0), .CLK (CLK), 
	.SD (SD), .CD (CD), .EN (EN));
XTRI1 \$1I26  (.XO0 (XO0), .A0 (\$1N27 ), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module ODT44(
	CD, CLK, D0, D1, D2, D3, OE, SD, XO0, XO1, XO2, XO3);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input OE;
	input SD;
	output XO0;
	output XO1;
	output XO2;
	output XO3;



ODT41 \$1I162  (.XO0 (XO0), .D0 (D0), .CLK (CLK), 
	.SD (SD), .CD (CD), .OE (OE));
ODT41 \$1I163  (.XO0 (XO1), .D0 (D1), .CLK (CLK), 
	.SD (SD), .CD (CD), .OE (OE));
ODT41 \$1I164  (.XO0 (XO2), .D0 (D2), .CLK (CLK), 
	.SD (SD), .CD (CD), .OE (OE));
ODT41 \$1I165  (.XO0 (XO3), .D0 (D3), .CLK (CLK), 
	.SD (SD), .CD (CD), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module ODT44E(
	CD, CLK, D0, D1, D2, D3, EN, OE, SD, XO0, XO1, XO2, XO3);


	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input OE;
	input SD;
	output XO0;
	output XO1;
	output XO2;
	output XO3;



ODT41E \$1I201  (.XO0 (XO0), .D0 (D0), .CLK (CLK), 
	.EN (EN), .SD (SD), .CD (CD), 
	.OE (OE));
ODT41E \$1I202  (.XO0 (XO1), .D0 (D1), .CLK (CLK), 
	.EN (EN), .SD (SD), .CD (CD), 
	.OE (OE));
ODT41E \$1I203  (.XO0 (XO2), .D0 (D2), .CLK (CLK), 
	.EN (EN), .SD (SD), .CD (CD), 
	.OE (OE));
ODT41E \$1I204  (.XO0 (XO3), .D0 (D3), .CLK (CLK), 
	.EN (EN), .SD (SD), .CD (CD), 
	.OE (OE));
endmodule
`timescale 10 ps / 10 ps
module OL11(
	D0, G, XQ0);


	input D0;
	input G;
	output XQ0;



XDL1 \$1I25  (.Q0 (XQ0), .D0 (D0), .G (G));
endmodule
`timescale 10 ps / 10 ps
module OL14(
	D0, D1, D2, D3, G, XQ0, XQ1, XQ2, XQ3);


	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	output XQ0;
	output XQ1;
	output XQ2;
	output XQ3;



OL11 \$1I131  (.XQ0 (XQ0), .D0 (D0), .G (G));
OL11 \$1I130  (.XQ0 (XQ1), .D0 (D1), .G (G));
OL11 \$1I129  (.XQ0 (XQ2), .D0 (D2), .G (G));
OL11 \$1I128  (.XQ0 (XQ3), .D0 (D3), .G (G));
endmodule
`timescale 10 ps / 10 ps
module OL21(
	D0, G, XQ0);


	input D0;
	input G;
	output XQ0;



XDL1 \$1I25  (.Q0 (XQ0), .D0 (D0), .G (\$1N38 ));
INV \$1I37  (.ZN0 (\$1N38 ), .A0 (G));
endmodule
`timescale 10 ps / 10 ps
module OL24(
	D0, D1, D2, D3, G, XQ0, XQ1, XQ2, XQ3);


	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	output XQ0;
	output XQ1;
	output XQ2;
	output XQ3;



OL21 \$1I131  (.XQ0 (XQ0), .D0 (D0), .G (G));
OL21 \$1I130  (.XQ0 (XQ1), .D0 (D1), .G (G));
OL21 \$1I129  (.XQ0 (XQ2), .D0 (D2), .G (G));
OL21 \$1I128  (.XQ0 (XQ3), .D0 (D3), .G (G));
endmodule
`timescale 10 ps / 10 ps
module OL31(
	CD, D0, G, XQ0);


	input CD;
	input D0;
	input G;
	output XQ0;



XDL2 \$1I25  (.Q0 (XQ0), .D0 (D0), .G (G), 
	.CD (CD));
endmodule
`timescale 10 ps / 10 ps
module OL34(
	CD, D0, D1, D2, D3, G, XQ0, XQ1, XQ2, XQ3);


	input CD;
	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	output XQ0;
	output XQ1;
	output XQ2;
	output XQ3;



OL31 \$1I131  (.XQ0 (XQ0), .D0 (D0), .G (G), 
	.CD (CD));
OL31 \$1I130  (.XQ0 (XQ1), .D0 (D1), .G (G), 
	.CD (CD));
OL31 \$1I129  (.XQ0 (XQ2), .D0 (D2), .G (G), 
	.CD (CD));
OL31 \$1I128  (.XQ0 (XQ3), .D0 (D3), .G (G), 
	.CD (CD));
endmodule
`timescale 10 ps / 10 ps
module OL41(
	D0, G, SD, XQ0);


	input D0;
	input G;
	input SD;
	output XQ0;



XDL3 \$1I25  (.Q0 (XQ0), .D0 (D0), .G (G), 
	.SD (SD));
endmodule
`timescale 10 ps / 10 ps
module OL44(
	D0, D1, D2, D3, G, SD, XQ0, XQ1, XQ2, XQ3);


	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	input SD;
	output XQ0;
	output XQ1;
	output XQ2;
	output XQ3;



OL41 \$1I131  (.XQ0 (XQ0), .D0 (D0), .G (G), 
	.SD (SD));
OL41 \$1I130  (.XQ0 (XQ1), .D0 (D1), .G (G), 
	.SD (SD));
OL41 \$1I129  (.XQ0 (XQ2), .D0 (D2), .G (G), 
	.SD (SD));
OL41 \$1I128  (.XQ0 (XQ3), .D0 (D3), .G (G), 
	.SD (SD));
endmodule
`timescale 10 ps / 10 ps
module OL51(
	CD, D0, G, SD, XQ0);


	input CD;
	input D0;
	input G;
	input SD;
	output XQ0;



XDL4 \$1I25  (.Q0 (XQ0), .D0 (D0), .G (G), 
	.SD (SD), .CD (CD));
endmodule
`timescale 10 ps / 10 ps
module OL54(
	CD, D0, D1, D2, D3, G, SD, XQ0, XQ1, XQ2, XQ3);


	input CD;
	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	input SD;
	output XQ0;
	output XQ1;
	output XQ2;
	output XQ3;



OL51 \$1I130  (.XQ0 (XQ1), .D0 (D1), .G (G), 
	.SD (SD), .CD (CD));
OL51 \$1I129  (.XQ0 (XQ2), .D0 (D2), .G (G), 
	.SD (SD), .CD (CD));
OL51 \$1I128  (.XQ0 (XQ3), .D0 (D3), .G (G), 
	.SD (SD), .CD (CD));
OL51 \$1I131  (.XQ0 (XQ0), .D0 (D0), .G (G), 
	.SD (SD), .CD (CD));
endmodule
`timescale 10 ps / 10 ps
module OLT11(
	D0, G, OE, XO0);


	input D0;
	input G;
	input OE;
	output XO0;



XTRI1 \$1I26  (.XO0 (XO0), .A0 (\$1N27 ), .OE (OE));
XDL1 \$1I25  (.Q0 (\$1N27 ), .D0 (D0), .G (G));
endmodule
`timescale 10 ps / 10 ps
module OLT14(
	D0, D1, D2, D3, G, OE, XO0, XO1, XO2, XO3);


	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	input OE;
	output XO0;
	output XO1;
	output XO2;
	output XO3;



OLT11 \$1I162  (.XO0 (XO0), .D0 (D0), .G (G), 
	.OE (OE));
OLT11 \$1I163  (.XO0 (XO1), .D0 (D1), .G (G), 
	.OE (OE));
OLT11 \$1I164  (.XO0 (XO2), .D0 (D2), .G (G), 
	.OE (OE));
OLT11 \$1I165  (.XO0 (XO3), .D0 (D3), .G (G), 
	.OE (OE));
endmodule
`timescale 10 ps / 10 ps
module OLT21(
	CD, D0, G, OE, XO0);


	input CD;
	input D0;
	input G;
	input OE;
	output XO0;



XDL2 \$1I25  (.Q0 (\$1N27 ), .D0 (D0), .G (G), 
	.CD (CD));
XTRI1 \$1I26  (.XO0 (XO0), .A0 (\$1N27 ), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module OLT24(
	CD, D0, D1, D2, D3, G, OE, XO0, XO1, XO2, XO3);


	input CD;
	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	input OE;
	output XO0;
	output XO1;
	output XO2;
	output XO3;



OLT21 \$1I162  (.XO0 (XO0), .D0 (D0), .G (G), 
	.CD (CD), .OE (OE));
OLT21 \$1I163  (.XO0 (XO1), .D0 (D1), .G (G), 
	.CD (CD), .OE (OE));
OLT21 \$1I164  (.XO0 (XO2), .D0 (D2), .G (G), 
	.CD (CD), .OE (OE));
OLT21 \$1I165  (.XO0 (XO3), .D0 (D3), .G (G), 
	.CD (CD), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module OLT31(
	D0, G, OE, SD, XO0);


	input D0;
	input G;
	input OE;
	input SD;
	output XO0;



XDL3 \$1I25  (.Q0 (\$1N27 ), .D0 (D0), .G (G), 
	.SD (SD));
XTRI1 \$1I26  (.XO0 (XO0), .A0 (\$1N27 ), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module OLT34(
	D0, D1, D2, D3, G, OE, SD, XO0, XO1, XO2, XO3);


	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	input OE;
	input SD;
	output XO0;
	output XO1;
	output XO2;
	output XO3;



OLT31 \$1I162  (.XO0 (XO0), .D0 (D0), .G (G), 
	.SD (SD), .OE (OE));
OLT31 \$1I163  (.XO0 (XO1), .D0 (D1), .G (G), 
	.SD (SD), .OE (OE));
OLT31 \$1I164  (.XO0 (XO2), .D0 (D2), .G (G), 
	.SD (SD), .OE (OE));
OLT31 \$1I165  (.XO0 (XO3), .D0 (D3), .G (G), 
	.SD (SD), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module OLT41(
	CD, D0, G, OE, SD, XO0);


	input CD;
	input D0;
	input G;
	input OE;
	input SD;
	output XO0;



XDL4 \$1I25  (.Q0 (\$1N27 ), .D0 (D0), .G (G), 
	.SD (SD), .CD (CD));
XTRI1 \$1I26  (.XO0 (XO0), .A0 (\$1N27 ), .OE (OE));
endmodule
`timescale 10 ps / 10 ps
module OLT44(
	CD, D0, D1, D2, D3, G, OE, SD, XO0, XO1, XO2, XO3);


	input CD;
	input D0;
	input D1;
	input D2;
	input D3;
	input G;
	input OE;
	input SD;
	output XO0;
	output XO1;
	output XO2;
	output XO3;



OLT41 \$1I162  (.XO0 (XO0), .D0 (D0), .G (G), 
	.SD (SD), .CD (CD), .OE (OE));
OLT41 \$1I163  (.XO0 (XO1), .D0 (D1), .G (G), 
	.SD (SD), .CD (CD), .OE (OE));
OLT41 \$1I164  (.XO0 (XO2), .D0 (D2), .G (G), 
	.SD (SD), .CD (CD), .OE (OE));
OLT41 \$1I165  (.XO0 (XO3), .D0 (D3), .G (G), 
	.SD (SD), .CD (CD), .OE (OE));
endmodule
/*
* Translated from EDIF description OR10                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  OR10 lib :  OR10                            *
*/
/*
* Library OR10                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell OR10"                                                                 *
*/
`timescale 10 ps / 10 ps
module OR10 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;

    output  Z0;



    or
        \$1I1  (\$1N14 , A0, A1, A2, A3, A4, A5, A6, A7);
    or
        \$1I13  (Z0, \$1N14 , A8, A9);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description OR11                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  OR11 lib :  OR11                            *
*/
/*
* Library OR11                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell OR11"                                                                 *
*/
`timescale 10 ps / 10 ps
module OR11 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;

    output  Z0;



    or
        \$1I10  (\$1N9 , A0, A1, A2, A3, A4, A5, A6, A7);
    or
        \$1I11  (Z0, \$1N9 , A8, A9, A10);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description OR12                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  OR12 lib :  OR12                            *
*/
/*
* Library OR12                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell OR12"                                                                 *
*/
`timescale 10 ps / 10 ps
module OR12 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;

    output  Z0;



    or
        \$1I1  (\$1N12 , A0, A1, A2, A3, A4, A5, A6, A7);
    or
        \$1I11  (Z0, \$1N12 , A8, A9, A10, A11);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description OR16                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  OR16 lib :  OR16                            *
*/
/*
* Library OR16                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell OR16"                                                                 *
*/
`timescale 10 ps / 10 ps
module OR16 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15)
     ;

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;

    output  Z0;



    or
        \$1I1  (\$1N12 , A0, A1, A2, A3, A4, A5, A6, A7);
    or
        \$1I11  (Z0, \$1N12 , \$1N17 );
    or
        \$1I16  (\$1N17 , A8, A9, A10, A11, A12, A13, A14, A15);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description OR2                                        *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  OR2 lib :  OR2                              *
*/
/*
* Library OR2                                                                 *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell OR2"                                                                  *
*/
`timescale 10 ps / 10 ps
module OR2 (Z0, A0, A1);

    input  A0;
    input  A1;

    output  Z0;



    or
        \$1I1  (Z0, A0, A1);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description OR3                                        *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  OR3 lib :  OR3                              *
*/
/*
* Library OR3                                                                 *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell OR3"                                                                  *
*/
`timescale 10 ps / 10 ps
module OR3 (Z0, A0, A1, A2);

    input  A0;
    input  A1;
    input  A2;

    output  Z0;



    or
        \$1I1  (Z0, A0, A1, A2);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description OR4                                        *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  OR4 lib :  OR4                              *
*/
/*
* Library OR4                                                                 *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell OR4"                                                                  *
*/
`timescale 10 ps / 10 ps
module OR4 (Z0, A0, A1, A2, A3);

    input  A0;
    input  A1;
    input  A2;
    input  A3;

    output  Z0;



    or
        \$1I1  (Z0, A0, A1, A2, A3);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description OR5                                        *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  OR5 lib :  OR5                              *
*/
/*
* Library OR5                                                                 *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell OR5"                                                                  *
*/
`timescale 10 ps / 10 ps
module OR5 (Z0, A0, A1, A2, A3, A4);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;

    output  Z0;



    or
        \$1I1  (Z0, A0, A1, A2, A3, A4);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description OR6                                        *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  OR6 lib :  OR6                              *
*/
/*
* Library OR6                                                                 *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell OR6"                                                                  *
*/
`timescale 10 ps / 10 ps
module OR6 (Z0, A0, A1, A2, A3, A4, A5);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;

    output  Z0;



    or
        \$1I1  (Z0, A0, A1, A2, A3, A4, A5);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description OR7                                        *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  OR7 lib :  OR7                              *
*/
/*
* Library OR7                                                                 *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell OR7"                                                                  *
*/
`timescale 10 ps / 10 ps
module OR7 (Z0, A0, A1, A2, A3, A4, A5, A6);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;

    output  Z0;



    or
        \$1I1  (Z0, A0, A1, A2, A3, A4, A5, A6);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description OR8                                        *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  OR8 lib :  OR8                              *
*/
/*
* Library OR8                                                                 *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell OR8"                                                                  *
*/
`timescale 10 ps / 10 ps
module OR8 (Z0, A0, A1, A2, A3, A4, A5, A6, A7);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;

    output  Z0;



    or
        \$1I1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description OR9                                        *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 43  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  OR9 lib :  OR9                              *
*/
/*
* Library OR9                                                                 *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell OR9"                                                                  *
*/
`timescale 10 ps / 10 ps
module OR9 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;

    output  Z0;



    or
        \$1I1  (\$1N12 , A0, A1, A2, A3, A4, A5, A6, A7);
    or
        \$1I11  (Z0, \$1N12 , A8);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:02 1994
`timescale 10 ps / 10 ps 
module OT11(
	XO0, A0, OE);

	output XO0;
	input A0;
	input OE;

XTRI1 \$1I14  (.XO0(XO0), .A0(A0), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:04 1994
`timescale 10 ps / 10 ps 
module OT14(
	XO0, XO1, XO2, XO3, 
	A0, A1, A2, A3, 
	OE);

	output XO0;
	output XO1;
	output XO2;
	output XO3;
	input A0;
	input A1;
	input A2;
	input A3;
	input OE;

OT11 \$1I150  (.XO0(XO3), .A0(A3), .OE(OE));
OT11 \$1I154  (.XO0(XO2), .A0(A2), .OE(OE));
OT11 \$1I155  (.XO0(XO1), .A0(A1), .OE(OE));
OT11 \$1I156  (.XO0(XO0), .A0(A0), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:07 1994
`timescale 10 ps / 10 ps 
module OT18(
	XO0, XO1, XO2, XO3, 
	XO4, XO5, XO6, XO7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	OE);

	output XO0;
	output XO1;
	output XO2;
	output XO3;
	output XO4;
	output XO5;
	output XO6;
	output XO7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input OE;

OT11 \$1I150  (.XO0(XO3), .A0(A3), .OE(OE));
OT11 \$1I154  (.XO0(XO2), .A0(A2), .OE(OE));
OT11 \$1I155  (.XO0(XO1), .A0(A1), .OE(OE));
OT11 \$1I156  (.XO0(XO0), .A0(A0), .OE(OE));
OT11 \$1I162  (.XO0(XO4), .A0(A4), .OE(OE));
OT11 \$1I163  (.XO0(XO5), .A0(A5), .OE(OE));
OT11 \$1I164  (.XO0(XO6), .A0(A6), .OE(OE));
OT11 \$1I166  (.XO0(XO7), .A0(A7), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:08 1994
`timescale 10 ps / 10 ps 
module OT21(
	XO0, A0, OE);

	output XO0;
	input A0;
	input OE;

XTRI1 \$1I14  (.XO0(XO0), .A0(\$1N22 ), .OE(OE));
XINV \$1I23  (.ZN0(\$1N22 ), .A0(A0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:11 1994
`timescale 10 ps / 10 ps 
module OT24(
	XO0, XO1, XO2, XO3, 
	A0, A1, A2, A3, 
	OE);

	output XO0;
	output XO1;
	output XO2;
	output XO3;
	input A0;
	input A1;
	input A2;
	input A3;
	input OE;

OT21 \$1I150  (.XO0(XO3), .A0(A3), .OE(OE));
OT21 \$1I154  (.XO0(XO2), .A0(A2), .OE(OE));
OT21 \$1I155  (.XO0(XO1), .A0(A1), .OE(OE));
OT21 \$1I156  (.XO0(XO0), .A0(A0), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:13 1994
`timescale 10 ps / 10 ps 
module OT28(
	XO0, XO1, XO2, XO3, 
	XO4, XO5, XO6, XO7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	OE);

	output XO0;
	output XO1;
	output XO2;
	output XO3;
	output XO4;
	output XO5;
	output XO6;
	output XO7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input OE;

OT21 \$1I150  (.XO0(XO3), .A0(A3), .OE(OE));
OT21 \$1I154  (.XO0(XO2), .A0(A2), .OE(OE));
OT21 \$1I155  (.XO0(XO1), .A0(A1), .OE(OE));
OT21 \$1I156  (.XO0(XO0), .A0(A0), .OE(OE));
OT21 \$1I162  (.XO0(XO4), .A0(A4), .OE(OE));
OT21 \$1I163  (.XO0(XO5), .A0(A5), .OE(OE));
OT21 \$1I164  (.XO0(XO6), .A0(A6), .OE(OE));
OT21 \$1I166  (.XO0(XO7), .A0(A7), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:15 1994
`timescale 10 ps / 10 ps 
module OT31(
	XO0, A0, OE);

	output XO0;
	input A0;
	input OE;

XTRI1 \$1I14  (.XO0(XO0), .A0(A0), .OE(\$1N21 ));
XINV \$1I23  (.ZN0(\$1N21 ), .A0(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:18 1994
`timescale 10 ps / 10 ps 
module OT34(
	XO0, XO1, XO2, XO3, 
	A0, A1, A2, A3, 
	OE);

	output XO0;
	output XO1;
	output XO2;
	output XO3;
	input A0;
	input A1;
	input A2;
	input A3;
	input OE;

OT31 \$1I150  (.XO0(XO3), .A0(A3), .OE(OE));
OT31 \$1I154  (.XO0(XO2), .A0(A2), .OE(OE));
OT31 \$1I155  (.XO0(XO1), .A0(A1), .OE(OE));
OT31 \$1I156  (.XO0(XO0), .A0(A0), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:20 1994
`timescale 10 ps / 10 ps 
module OT38(
	XO0, XO1, XO2, XO3, 
	XO4, XO5, XO6, XO7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	OE);

	output XO0;
	output XO1;
	output XO2;
	output XO3;
	output XO4;
	output XO5;
	output XO6;
	output XO7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input OE;

OT31 \$1I150  (.XO0(XO3), .A0(A3), .OE(OE));
OT31 \$1I154  (.XO0(XO2), .A0(A2), .OE(OE));
OT31 \$1I155  (.XO0(XO1), .A0(A1), .OE(OE));
OT31 \$1I156  (.XO0(XO0), .A0(A0), .OE(OE));
OT31 \$1I162  (.XO0(XO4), .A0(A4), .OE(OE));
OT31 \$1I163  (.XO0(XO5), .A0(A5), .OE(OE));
OT31 \$1I164  (.XO0(XO6), .A0(A6), .OE(OE));
OT31 \$1I166  (.XO0(XO7), .A0(A7), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:22 1994
`timescale 10 ps / 10 ps 
module OT41(
	XO0, A0, OE);

	output XO0;
	input A0;
	input OE;

XTRI1 \$1I14  (.XO0(XO0), .A0(\$1N24 ), .OE(\$1N21 ));
XINV \$1I23  (.ZN0(\$1N21 ), .A0(OE));
XINV \$1I25  (.ZN0(\$1N24 ), .A0(A0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:25 1994
`timescale 10 ps / 10 ps 
module OT44(
	XO0, XO1, XO2, XO3, 
	A0, A1, A2, A3, 
	OE);

	output XO0;
	output XO1;
	output XO2;
	output XO3;
	input A0;
	input A1;
	input A2;
	input A3;
	input OE;

OT41 \$1I150  (.XO0(XO3), .A0(A3), .OE(OE));
OT41 \$1I154  (.XO0(XO2), .A0(A2), .OE(OE));
OT41 \$1I155  (.XO0(XO1), .A0(A1), .OE(OE));
OT41 \$1I156  (.XO0(XO0), .A0(A0), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:27 1994
`timescale 10 ps / 10 ps 
module OT48(
	XO0, XO1, XO2, XO3, 
	XO4, XO5, XO6, XO7, 
	A0, A1, A2, A3, 
	A4, A5, A6, A7, 
	OE);

	output XO0;
	output XO1;
	output XO2;
	output XO3;
	output XO4;
	output XO5;
	output XO6;
	output XO7;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input OE;

OT41 \$1I150  (.XO0(XO3), .A0(A3), .OE(OE));
OT41 \$1I154  (.XO0(XO2), .A0(A2), .OE(OE));
OT41 \$1I155  (.XO0(XO1), .A0(A1), .OE(OE));
OT41 \$1I156  (.XO0(XO0), .A0(A0), .OE(OE));
OT41 \$1I162  (.XO0(XO4), .A0(A4), .OE(OE));
OT41 \$1I163  (.XO0(XO5), .A0(A5), .OE(OE));
OT41 \$1I164  (.XO0(XO6), .A0(A6), .OE(OE));
OT41 \$1I166  (.XO0(XO7), .A0(A7), .OE(OE));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:29 1994
`timescale 10 ps / 10 ps 
module PG1(
	PGO1, GI1, PI1, PGI1);

	output PGO1;
	input GI1;
	input PI1;
	input PGI1;

AND2 \$1I534  (.Z0(\$1N536 ), .A0(PI1), .A1(PGI1));
OR2 \$1I535  (.Z0(PGO1), .A0(GI1), .A1(\$1N536 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:32 1994
`timescale 10 ps / 10 ps 
module PG2(
	PGO2, GI2, PI2, GI1, 
	PI1, PGI1);

	output PGO2;
	input GI2;
	input PI2;
	input GI1;
	input PI1;
	input PGI1;

OR3 \$1I540  (.Z0(PGO2), .A0(GI2), .A1(\$1N555 ), .A2(\$1N557 ));
AND3 \$1I541  (.Z0(\$1N557 ), .A0(PI2), .A1(PI1), .A2(PGI1));
AND2 \$1I542  (.Z0(\$1N555 ), .A0(PI2), .A1(GI1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:34 1994
`timescale 10 ps / 10 ps 
module PG3(
	PGO3, GI3, PI3, GI2, 
	PI2, GI1, PI1, PGI1);

	output PGO3;
	input GI3;
	input PI3;
	input GI2;
	input PI2;
	input GI1;
	input PI1;
	input PGI1;

OR4 \$1I565  (.Z0(PGO3), .A0(GI3), .A1(\$1N578 ), .A2(\$1N580 ), 
	.A3(\$1N582 ));
AND2 \$1I566  (.Z0(\$1N578 ), .A0(PI3), .A1(GI2));
AND3 \$1I568  (.Z0(\$1N580 ), .A0(PI3), .A1(PI2), .A2(GI1));
AND4 \$1I569  (.Z0(\$1N582 ), .A0(PI3), .A1(PI2), .A2(PI1), 
	.A3(PGI1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:37 1994
`timescale 10 ps / 10 ps 
module PG4(
	PGO4, GI4, PI4, GI3, 
	PI3, GI2, PI2, GI1, 
	PI1, PGI1);

	output PGO4;
	input GI4;
	input PI4;
	input GI3;
	input PI3;
	input GI2;
	input PI2;
	input GI1;
	input PI1;
	input PGI1;

OR5 \$1I585  (.Z0(PGO4), .A0(GI4), .A1(\$1N605 ), .A2(\$1N607 ), 
	.A3(\$1N609 ), .A4(\$1N611 ));
AND2 \$1I587  (.Z0(\$1N605 ), .A0(PI4), .A1(GI3));
AND3 \$1I588  (.Z0(\$1N607 ), .A0(PI4), .A1(PI3), .A2(GI2));
AND4 \$1I589  (.Z0(\$1N609 ), .A0(PI4), .A1(PI3), .A2(PI2), 
	.A3(GI1));
AND5 \$1I590  (.Z0(\$1N611 ), .A0(PI4), .A1(PI3), .A2(PI2), 
	.A3(PI1), .A4(PGI1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:40 1994
`timescale 10 ps / 10 ps 
module PREN10(
	Z0, Z1, Z2, Z3, 
	S0, S1, S2, S3, 
	S4, S5, S6, S7, 
	S8);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input S0;
	input S1;
	input S2;
	input S3;
	input S4;
	input S5;
	input S6;
	input S7;
	input S8;

OR2 \$1I176  (.Z0(Z3), .A0(S8), .A1(S7));
OR4 \$1I183  (.Z0(Z2), .A0(\$1N195 ), .A1(\$1N201 ), .A2(\$1N199 ), 
	.A3(\$1N197 ));
INV \$1I186  (.ZN0(\$1N203 ), .A0(S8));
INV \$1I187  (.ZN0(\$1N208 ), .A0(S7));
AND3 \$1I190  (.Z0(\$1N197 ), .A0(\$1N203 ), .A1(\$1N208 ), .A2(S3));
AND3 \$1I191  (.Z0(\$1N199 ), .A0(\$1N203 ), .A1(\$1N208 ), .A2(S4));
AND3 \$1I192  (.Z0(\$1N201 ), .A0(\$1N203 ), .A1(\$1N208 ), .A2(S5));
AND3 \$1I193  (.Z0(\$1N195 ), .A0(\$1N203 ), .A1(\$1N208 ), .A2(S6));
AND3 \$1I222  (.Z0(\$1N223 ), .A0(\$1N203 ), .A1(\$1N208 ), .A2(S5));
AND3 \$1I224  (.Z0(\$1N225 ), .A0(\$1N203 ), .A1(\$1N208 ), .A2(S6));
OR4 \$1I226  (.Z0(Z1), .A0(\$1N225 ), .A1(\$1N223 ), .A2(\$1N241 ), 
	.A3(\$1N243 ));
AND5 \$1I239  (.Z0(\$1N241 ), .A0(\$1N203 ), .A1(\$1N208 ), .A2(\$1N250 ), 
	.A3(\$1N255 ), .A4(S2));
AND5 \$1I240  (.Z0(\$1N243 ), .A0(\$1N203 ), .A1(\$1N208 ), .A2(\$1N250 ), 
	.A3(\$1N255 ), .A4(S1));
INV \$1I249  (.ZN0(\$1N250 ), .A0(S4));
INV \$1I253  (.ZN0(\$1N255 ), .A0(S3));
OR5 \$1I264  (.Z0(Z0), .A0(S8), .A1(\$1N272 ), .A2(\$1N275 ), 
	.A3(\$1N277 ), .A4(\$1N279 ));
AND2 \$1I266  (.Z0(\$1N272 ), .A0(\$1N208 ), .A1(S6));
AND3 \$1I267  (.Z0(\$1N275 ), .A0(\$1N208 ), .A1(\$1N218 ), .A2(S4));
AND4 \$1I268  (.Z0(\$1N277 ), .A0(\$1N208 ), .A1(\$1N218 ), .A2(\$1N255 ), 
	.A3(S2));
AND5 \$1I269  (.Z0(\$1N279 ), .A0(\$1N208 ), .A1(\$1N218 ), .A2(\$1N255 ), 
	.A3(\$1N301 ), .A4(S0));
INV \$1I288  (.ZN0(\$1N218 ), .A0(S5));
INV \$1I300  (.ZN0(\$1N301 ), .A0(S1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:43 1994
`timescale 10 ps / 10 ps 
module PREN10E(
	Z0, Z1, Z2, Z3, 
	S0, S1, S2, S3, 
	S4, S5, S6, S7, 
	S8, EN);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input S0;
	input S1;
	input S2;
	input S3;
	input S4;
	input S5;
	input S6;
	input S7;
	input S8;
	input EN;

OR2 \$1I176  (.Z0(Z3), .A0(\$1N308 ), .A1(\$1N310 ));
OR4 \$1I183  (.Z0(Z2), .A0(\$1N195 ), .A1(\$1N201 ), .A2(\$1N199 ), 
	.A3(\$1N197 ));
INV \$1I186  (.ZN0(\$1N203 ), .A0(S8));
INV \$1I187  (.ZN0(\$1N208 ), .A0(S7));
OR4 \$1I226  (.Z0(Z1), .A0(\$1N225 ), .A1(\$1N223 ), .A2(\$1N241 ), 
	.A3(\$1N243 ));
INV \$1I249  (.ZN0(\$1N250 ), .A0(S4));
INV \$1I253  (.ZN0(\$1N255 ), .A0(S3));
OR5 \$1I264  (.Z0(Z0), .A0(\$1N177 ), .A1(\$1N272 ), .A2(\$1N275 ), 
	.A3(\$1N277 ), .A4(\$1N279 ));
INV \$1I288  (.ZN0(\$1N218 ), .A0(S5));
INV \$1I300  (.ZN0(\$1N301 ), .A0(S1));
AND2 \$1I306  (.Z0(\$1N308 ), .A0(S8), .A1(EN));
AND2 \$1I307  (.Z0(\$1N310 ), .A0(S7), .A1(EN));
AND4 \$1I316  (.Z0(\$1N195 ), .A0(\$1N203 ), .A1(\$1N208 ), .A2(S6), 
	.A3(EN));
AND4 \$1I318  (.Z0(\$1N201 ), .A0(\$1N203 ), .A1(\$1N208 ), .A2(S5), 
	.A3(EN));
AND4 \$1I320  (.Z0(\$1N199 ), .A0(\$1N203 ), .A1(\$1N208 ), .A2(S4), 
	.A3(EN));
AND4 \$1I322  (.Z0(\$1N197 ), .A0(\$1N203 ), .A1(\$1N208 ), .A2(S3), 
	.A3(EN));
AND4 \$1I324  (.Z0(\$1N225 ), .A0(\$1N203 ), .A1(\$1N208 ), .A2(S6), 
	.A3(EN));
AND4 \$1I326  (.Z0(\$1N223 ), .A0(\$1N203 ), .A1(\$1N208 ), .A2(S5), 
	.A3(EN));
AND6 \$1I328  (.Z0(\$1N241 ), .A0(\$1N203 ), .A1(\$1N208 ), .A2(\$1N250 ), 
	.A3(\$1N255 ), .A4(S2), .A5(EN));
AND6 \$1I330  (.Z0(\$1N243 ), .A0(\$1N203 ), .A1(\$1N208 ), .A2(\$1N250 ), 
	.A3(\$1N255 ), .A4(S1), .A5(EN));
AND2 \$1I333  (.Z0(\$1N177 ), .A0(S8), .A1(EN));
AND3 \$1I337  (.Z0(\$1N272 ), .A0(\$1N208 ), .A1(S6), .A2(EN));
AND4 \$1I340  (.Z0(\$1N275 ), .A0(\$1N208 ), .A1(\$1N218 ), .A2(S4), 
	.A3(EN));
AND5 \$1I342  (.Z0(\$1N277 ), .A0(\$1N208 ), .A1(\$1N218 ), .A2(\$1N255 ), 
	.A3(S2), .A4(EN));
AND6 \$1I343  (.Z0(\$1N279 ), .A0(\$1N208 ), .A1(\$1N218 ), .A2(\$1N255 ), 
	.A3(\$1N301 ), .A4(S0), .A5(EN));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:47 1994
`timescale 10 ps / 10 ps 
module PREN16(
	Z0, Z1, Z2, Z3, 
	S0, S1, S2, S3, 
	S4, S5, S6, S7, 
	S8, S9, S10, S11, 
	S12, S13, S14);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input S0;
	input S1;
	input S2;
	input S3;
	input S4;
	input S5;
	input S6;
	input S7;
	input S8;
	input S9;
	input S10;
	input S11;
	input S12;
	input S13;
	input S14;

INV \$1I168  (.ZN0(\~S13 ), .A0(S13));
INV \$1I174  (.ZN0(\~S12 ), .A0(S12));
INV \$1I177  (.ZN0(\~S11 ), .A0(S11));
INV \$1I180  (.ZN0(\~S10 ), .A0(S10));
INV \$1I183  (.ZN0(\~S9 ), .A0(S9));
INV \$1I186  (.ZN0(\~S8 ), .A0(S8));
INV \$1I189  (.ZN0(\~S7 ), .A0(S7));
INV \$1I195  (.ZN0(\~S5 ), .A0(S5));
INV \$1I198  (.ZN0(\~S4 ), .A0(S4));
INV \$1I201  (.ZN0(\~S3 ), .A0(S3));
INV \$1I207  (.ZN0(\~S1 ), .A0(S1));
OR8 \$1I208  (.Z0(Z3), .A0(S14), .A1(S13), .A2(S12), 
	.A3(S11), .A4(S10), .A5(S9), .A6(S8), 
	.A7(S7));
OR8 \$1I218  (.Z0(Z2), .A0(S14), .A1(S13), .A2(S12), 
	.A3(S11), .A4(\$1N245 ), .A5(\$1N247 ), .A6(\$1N249 ), 
	.A7(\$1N251 ));
AND5 \$1I219  (.Z0(\$1N245 ), .A0(\~S10 ), .A1(\~S9 ), .A2(\~S8 ), 
	.A3(\~S7 ), .A4(S6));
AND5 \$1I228  (.Z0(\$1N247 ), .A0(\~S10 ), .A1(\~S9 ), .A2(\~S8 ), 
	.A3(\~S7 ), .A4(S5));
AND5 \$1I234  (.Z0(\$1N249 ), .A0(\~S10 ), .A1(\~S9 ), .A2(\~S8 ), 
	.A3(\~S7 ), .A4(S4));
AND5 \$1I241  (.Z0(\$1N251 ), .A0(\~S10 ), .A1(\~S9 ), .A2(\~S8 ), 
	.A3(\~S7 ), .A4(S3));
AND7 \$2I10  (.Z0(\$2N4 ), .A0(\~S13 ), .A1(\~S11 ), .A2(\~S9 ), 
	.A3(\~S7 ), .A4(\~S5 ), .A5(\~S3 ), .A6(S2));
AND6 \$2I11  (.Z0(\$2N5 ), .A0(\~S13 ), .A1(\~S11 ), .A2(\~S9 ), 
	.A3(\~S7 ), .A4(\~S5 ), .A5(S4));
AND5 \$2I12  (.Z0(\$2N6 ), .A0(\~S13 ), .A1(\~S11 ), .A2(\~S9 ), 
	.A3(\~S7 ), .A4(S6));
AND4 \$2I13  (.Z0(\$2N7 ), .A0(\~S13 ), .A1(\~S11 ), .A2(\~S9 ), 
	.A3(S8));
AND3 \$2I14  (.Z0(\$2N8 ), .A0(\~S13 ), .A1(\~S11 ), .A2(S10));
AND7 \$2I21  (.Z0(\$2N15 ), .A0(\~S12 ), .A1(\~S11 ), .A2(\~S8 ), 
	.A3(\~S7 ), .A4(\~S4 ), .A5(\~S3 ), .A6(S1));
AND3 \$2I22  (.Z0(\$2N19 ), .A0(\~S12 ), .A1(\~S11 ), .A2(S9));
AND5 \$2I23  (.Z0(\$2N18 ), .A0(\~S12 ), .A1(\~S11 ), .A2(\~S8 ), 
	.A3(\~S7 ), .A4(S6));
AND7 \$2I24  (.Z0(\$2N16 ), .A0(\~S12 ), .A1(\~S11 ), .A2(\~S8 ), 
	.A3(\~S7 ), .A4(\~S4 ), .A5(\~S3 ), .A6(S2));
AND5 \$2I25  (.Z0(\$2N17 ), .A0(\~S12 ), .A1(\~S11 ), .A2(\~S8 ), 
	.A3(\~S7 ), .A4(S5));
OR8 \$2I26  (.Z0(Z1), .A0(S14), .A1(S13), .A2(\$2N20 ), 
	.A3(\$2N19 ), .A4(\$2N18 ), .A5(\$2N17 ), .A6(\$2N16 ), 
	.A7(\$2N15 ));
AND3 \$2I27  (.Z0(\$2N20 ), .A0(\~S12 ), .A1(\~S11 ), .A2(S10));
AND2 \$2I28  (.Z0(\$2N29 ), .A0(\~S13 ), .A1(S12));
OR8 \$2I30  (.Z0(Z0), .A0(S14), .A1(\$2N29 ), .A2(\$2N8 ), 
	.A3(\$2N7 ), .A4(\$2N6 ), .A5(\$2N5 ), .A6(\$2N4 ), 
	.A7(\$2N3 ));
AND8 \$2I9  (.Z0(\$2N3 ), .A0(\~S13 ), .A1(\~S11 ), .A2(\~S9 ), 
	.A3(\~S7 ), .A4(\~S5 ), .A5(\~S3 ), .A6(\~S1 ), 
	.A7(S0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:51 1994
`timescale 10 ps / 10 ps 
module PREN16E(
	Z0, Z1, Z2, Z3, 
	S0, S1, S2, S3, 
	S4, S5, S6, S7, 
	S8, S9, S10, S11, 
	S12, S13, S14, EN);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	input S0;
	input S1;
	input S2;
	input S3;
	input S4;
	input S5;
	input S6;
	input S7;
	input S8;
	input S9;
	input S10;
	input S11;
	input S12;
	input S13;
	input S14;
	input EN;

INV \$1I168  (.ZN0(\~S13 ), .A0(S13));
INV \$1I174  (.ZN0(\~S12 ), .A0(S12));
INV \$1I177  (.ZN0(\~S11 ), .A0(S11));
INV \$1I180  (.ZN0(\~S10 ), .A0(S10));
INV \$1I183  (.ZN0(\~S9 ), .A0(S9));
INV \$1I186  (.ZN0(\~S8 ), .A0(S8));
INV \$1I189  (.ZN0(\~S7 ), .A0(S7));
INV \$1I195  (.ZN0(\~S5 ), .A0(S5));
INV \$1I198  (.ZN0(\~S4 ), .A0(S4));
INV \$1I201  (.ZN0(\~S3 ), .A0(S3));
INV \$1I207  (.ZN0(\~S1 ), .A0(S1));
AND2 \$1I376  (.Z0(\$1N400 ), .A0(S14), .A1(EN));
AND2 \$1I377  (.Z0(\$1N398 ), .A0(S13), .A1(EN));
AND2 \$1I378  (.Z0(\$1N396 ), .A0(S12), .A1(EN));
AND2 \$1I380  (.Z0(\$1N388 ), .A0(S11), .A1(EN));
AND2 \$1I381  (.Z0(\$1N386 ), .A0(S10), .A1(EN));
AND2 \$1I382  (.Z0(\$1N390 ), .A0(S9), .A1(EN));
AND2 \$1I383  (.Z0(\$1N392 ), .A0(S8), .A1(EN));
AND2 \$1I384  (.Z0(\$1N394 ), .A0(S7), .A1(EN));
OR8 \$1I385  (.Z0(Z3), .A0(\$1N400 ), .A1(\$1N398 ), .A2(\$1N396 ), 
	.A3(\$1N388 ), .A4(\$1N386 ), .A5(\$1N390 ), .A6(\$1N392 ), 
	.A7(\$1N394 ));
AND2 \$1I412  (.Z0(\$1N429 ), .A0(S11), .A1(EN));
AND2 \$1I413  (.Z0(\$1N431 ), .A0(S12), .A1(EN));
AND2 \$1I414  (.Z0(\$1N433 ), .A0(S13), .A1(EN));
AND2 \$1I415  (.Z0(\$1N435 ), .A0(S14), .A1(EN));
AND6 \$1I420  (.Z0(\$1N437 ), .A0(\~S10 ), .A1(\~S9 ), .A2(\~S8 ), 
	.A3(\~S7 ), .A4(S6), .A5(EN));
AND6 \$1I422  (.Z0(\$1N439 ), .A0(\~S10 ), .A1(\~S9 ), .A2(\~S8 ), 
	.A3(\~S7 ), .A4(S5), .A5(EN));
AND6 \$1I424  (.Z0(\$1N441 ), .A0(\~S10 ), .A1(\~S9 ), .A2(\~S8 ), 
	.A3(\~S7 ), .A4(S4), .A5(EN));
AND6 \$1I426  (.Z0(\$1N443 ), .A0(\~S10 ), .A1(\~S9 ), .A2(\~S8 ), 
	.A3(\~S7 ), .A4(S3), .A5(EN));
OR8 \$1I428  (.Z0(Z2), .A0(\$1N435 ), .A1(\$1N433 ), .A2(\$1N431 ), 
	.A3(\$1N429 ), .A4(\$1N437 ), .A5(\$1N439 ), .A6(\$1N441 ), 
	.A7(\$1N443 ));
AND9 \$2I100  (.Z0(\$2N28 ), .A0(\~S13 ), .A1(\~S11 ), .A2(\~S9 ), 
	.A3(\~S7 ), .A4(\~S5 ), .A5(\~S3 ), .A6(\~S1 ), 
	.A7(S0), .A8(EN));
AND8 \$2I101  (.Z0(\$2N27 ), .A0(\~S13 ), .A1(\~S11 ), .A2(\~S9 ), 
	.A3(\~S7 ), .A4(\~S5 ), .A5(\~S3 ), .A6(S2), 
	.A7(EN));
AND7 \$2I104  (.Z0(\$2N26 ), .A0(\~S13 ), .A1(\~S11 ), .A2(\~S9 ), 
	.A3(\~S7 ), .A4(\~S5 ), .A5(S4), .A6(EN));
AND6 \$2I106  (.Z0(\$2N25 ), .A0(\~S13 ), .A1(\~S11 ), .A2(\~S9 ), 
	.A3(\~S7 ), .A4(S6), .A5(EN));
AND5 \$2I109  (.Z0(\$2N24 ), .A0(\~S13 ), .A1(\~S11 ), .A2(\~S9 ), 
	.A3(S8), .A4(EN));
AND4 \$2I111  (.Z0(\$2N23 ), .A0(\~S13 ), .A1(\~S11 ), .A2(S10), 
	.A3(EN));
AND3 \$2I113  (.Z0(\$2N3 ), .A0(\~S13 ), .A1(S12), .A2(EN));
AND2 \$2I115  (.Z0(\$2N117 ), .A0(S14), .A1(EN));
OR8 \$2I2  (.Z0(Z0), .A0(\$2N117 ), .A1(\$2N3 ), .A2(\$2N23 ), 
	.A3(\$2N24 ), .A4(\$2N25 ), .A5(\$2N26 ), .A6(\$2N27 ), 
	.A7(\$2N28 ));
AND2 \$2I67  (.Z0(\$2N90 ), .A0(S14), .A1(EN));
AND2 \$2I68  (.Z0(\$2N88 ), .A0(S13), .A1(EN));
AND4 \$2I69  (.Z0(\$2N86 ), .A0(\~S12 ), .A1(\~S11 ), .A2(S10), 
	.A3(EN));
AND4 \$2I73  (.Z0(\$2N84 ), .A0(\~S12 ), .A1(\~S11 ), .A2(S9), 
	.A3(EN));
AND6 \$2I75  (.Z0(\$2N92 ), .A0(\~S12 ), .A1(\~S11 ), .A2(\~S8 ), 
	.A3(\~S7 ), .A4(S6), .A5(EN));
AND6 \$2I77  (.Z0(\$2N94 ), .A0(\~S12 ), .A1(\~S11 ), .A2(\~S8 ), 
	.A3(\~S7 ), .A4(S5), .A5(EN));
AND8 \$2I79  (.Z0(\$2N96 ), .A0(\~S12 ), .A1(\~S11 ), .A2(\~S8 ), 
	.A3(\~S7 ), .A4(\~S4 ), .A5(\~S3 ), .A6(S2), 
	.A7(EN));
AND8 \$2I81  (.Z0(\$2N98 ), .A0(\~S12 ), .A1(\~S11 ), .A2(\~S8 ), 
	.A3(\~S7 ), .A4(\~S4 ), .A5(\~S3 ), .A6(S1), 
	.A7(EN));
OR8 \$2I83  (.Z0(Z1), .A0(\$2N90 ), .A1(\$2N88 ), .A2(\$2N86 ), 
	.A3(\$2N84 ), .A4(\$2N92 ), .A5(\$2N94 ), .A6(\$2N96 ), 
	.A7(\$2N98 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:53 1994
`timescale 10 ps / 10 ps 
module PREN8(
	Z0, Z1, Z2, S0, 
	S1, S2, S3, S4, 
	S5, S6);

	output Z0;
	output Z1;
	output Z2;
	input S0;
	input S1;
	input S2;
	input S3;
	input S4;
	input S5;
	input S6;

AND4 \$1I138  (.Z0(\$1N145 ), .A0(\$1N96 ), .A1(\$1N116 ), .A2(\$1N121 ), 
	.A3(S0));
OR4 \$1I144  (.Z0(Z0), .A0(S6), .A1(\$1N149 ), .A2(\$1N147 ), 
	.A3(\$1N145 ));
INV \$1I153  (.ZN0(\$1N121 ), .A0(S1));
OR4 \$1I158  (.Z0(Z1), .A0(S6), .A1(S5), .A2(\$1N159 ), 
	.A3(\$1N189 ));
AND3 \$1I162  (.Z0(\$1N189 ), .A0(\$1N93 ), .A1(S1), .A2(\$1N116 ));
OR4 \$1I172  (.Z0(Z2), .A0(S6), .A1(S5), .A2(S4), 
	.A3(S3));
INV \$1I173  (.ZN0(\$1N116 ), .A0(S3));
INV \$1I176  (.ZN0(\$1N93 ), .A0(S4));
AND3 \$1I194  (.Z0(\$1N159 ), .A0(\$1N93 ), .A1(S2), .A2(\$1N116 ));
AND3 \$1I71  (.Z0(\$1N147 ), .A0(\$1N96 ), .A1(\$1N116 ), .A2(S2));
AND2 \$1I72  (.Z0(\$1N149 ), .A0(\$1N96 ), .A1(S4));
INV \$1I82  (.ZN0(\$1N96 ), .A0(S5));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:55 1994
`timescale 10 ps / 10 ps 
module PREN8E(
	Z0, Z1, Z2, S0, 
	S1, S2, S3, S4, 
	S5, S6, EN);

	output Z0;
	output Z1;
	output Z2;
	input S0;
	input S1;
	input S2;
	input S3;
	input S4;
	input S5;
	input S6;
	input EN;

OR4 \$1I144  (.Z0(Z0), .A0(\$1N264 ), .A1(\$1N274 ), .A2(\$1N276 ), 
	.A3(\$1N278 ));
INV \$1I153  (.ZN0(\$1N121 ), .A0(S1));
OR4 \$1I158  (.Z0(Z1), .A0(\$1N240 ), .A1(\$1N244 ), .A2(\$1N258 ), 
	.A3(\$1N260 ));
OR4 \$1I172  (.Z0(Z2), .A0(\$1N238 ), .A1(\$1N234 ), .A2(\$1N232 ), 
	.A3(\$1N236 ));
INV \$1I173  (.ZN0(\$1N116 ), .A0(S3));
INV \$1I176  (.ZN0(\$1N93 ), .A0(S4));
AND2 \$1I217  (.Z0(\$1N236 ), .A0(EN), .A1(S3));
AND2 \$1I221  (.Z0(\$1N232 ), .A0(EN), .A1(S4));
AND2 \$1I222  (.Z0(\$1N234 ), .A0(EN), .A1(S5));
AND2 \$1I223  (.Z0(\$1N238 ), .A0(EN), .A1(S6));
AND2 \$1I243  (.Z0(\$1N240 ), .A0(EN), .A1(S6));
AND2 \$1I247  (.Z0(\$1N244 ), .A0(EN), .A1(S5));
AND4 \$1I249  (.Z0(\$1N258 ), .A0(\$1N93 ), .A1(S2), .A2(\$1N116 ), 
	.A3(EN));
AND4 \$1I250  (.Z0(\$1N260 ), .A0(\$1N93 ), .A1(S1), .A2(\$1N116 ), 
	.A3(EN));
AND2 \$1I267  (.Z0(\$1N264 ), .A0(EN), .A1(S6));
AND3 \$1I268  (.Z0(\$1N274 ), .A0(\$1N96 ), .A1(S4), .A2(EN));
AND4 \$1I270  (.Z0(\$1N276 ), .A0(\$1N96 ), .A1(\$1N116 ), .A2(S2), 
	.A3(EN));
AND5 \$1I271  (.Z0(\$1N278 ), .A0(\$1N96 ), .A1(\$1N116 ), .A2(\$1N121 ), 
	.A3(S0), .A4(EN));
INV \$1I82  (.ZN0(\$1N96 ), .A0(S5));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:12:57 1994
`timescale 10 ps / 10 ps 
module SRR11(
	Q0, CAI, CLK, CD);

	output Q0;
	input CAI;
	input CLK;
	input CD;

FD21 \$1I1  (.Q0(Q0), .D0(CAI), .CLK(CLK), .CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:13:00 1994
`timescale 10 ps / 10 ps 
module SRR14(
	Q0, Q1, Q2, Q3, 
	CAI, CLK, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input CAI;
	input CLK;
	input CD;

BUF \$1I106  (.Z0(Q0), .A0(\$1N81 ));
BUF \$1I108  (.Z0(Q1), .A0(\$1N83 ));
BUF \$1I109  (.Z0(Q2), .A0(\$1N84 ));
SRR11 \$1I77  (.Q0(Q3), .CAI(\$1N84 ), .CLK(CLK), .CD(CD));
SRR11 \$1I78  (.Q0(\$1N84 ), .CAI(\$1N83 ), .CLK(CLK), .CD(CD));
SRR11 \$1I79  (.Q0(\$1N83 ), .CAI(\$1N81 ), .CLK(CLK), .CD(CD));
SRR11 \$1I80  (.Q0(\$1N81 ), .CAI(CAI), .CLK(CLK), .CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:13:03 1994
`timescale 10 ps / 10 ps 
module SRR18(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	CAI, CLK, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input CAI;
	input CLK;
	input CD;

SRR11 \$1I141  (.Q0(\$1N145 ), .CAI(\$1N104 ), .CLK(CLK), .CD(CD));
SRR11 \$1I142  (.Q0(Q7), .CAI(\$1N158 ), .CLK(CLK), .CD(CD));
SRR11 \$1I143  (.Q0(\$1N158 ), .CAI(\$1N157 ), .CLK(CLK), .CD(CD));
SRR11 \$1I144  (.Q0(\$1N157 ), .CAI(\$1N145 ), .CLK(CLK), .CD(CD));
BUF \$1I160  (.Z0(Q0), .A0(\$1N81 ));
BUF \$1I161  (.Z0(Q1), .A0(\$1N83 ));
BUF \$1I162  (.Z0(Q2), .A0(\$1N84 ));
BUF \$1I163  (.Z0(Q3), .A0(\$1N104 ));
BUF \$1I164  (.Z0(Q4), .A0(\$1N145 ));
BUF \$1I165  (.Z0(Q5), .A0(\$1N157 ));
BUF \$1I166  (.Z0(Q6), .A0(\$1N158 ));
SRR11 \$1I77  (.Q0(\$1N104 ), .CAI(\$1N84 ), .CLK(CLK), .CD(CD));
SRR11 \$1I78  (.Q0(\$1N84 ), .CAI(\$1N83 ), .CLK(CLK), .CD(CD));
SRR11 \$1I79  (.Q0(\$1N83 ), .CAI(\$1N81 ), .CLK(CLK), .CD(CD));
SRR11 \$1I80  (.Q0(\$1N81 ), .CAI(CAI), .CLK(CLK), .CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:13:05 1994
`timescale 10 ps / 10 ps 
module SRR21(
	Q0, CAI, CLK, EN, 
	CD);

	output Q0;
	input CAI;
	input CLK;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(\$1N5 ), .D0(\$1N29 ), .CLK(CLK), .CD(CD));
AND2 \$1I24  (.Z0(\$1N31 ), .A0(CAI), .A1(EN));
AND2 \$1I25  (.Z0(\$1N33 ), .A0(\$1N5 ), .A1(\$1N35 ));
INV \$1I26  (.ZN0(\$1N35 ), .A0(EN));
OR2 \$1I28  (.Z0(\$1N29 ), .A0(\$1N31 ), .A1(\$1N33 ));
BUF \$1I47  (.Z0(Q0), .A0(\$1N5 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:13:07 1994
`timescale 10 ps / 10 ps 
module SRR24(
	Q0, Q1, Q2, Q3, 
	CAI, CLK, EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input CAI;
	input CLK;
	input EN;
	input CD;

BUF \$1I111  (.Z0(Q0), .A0(\$1N81 ));
BUF \$1I112  (.Z0(Q1), .A0(\$1N83 ));
BUF \$1I113  (.Z0(Q2), .A0(\$1N84 ));
SRR21 \$1I77  (.Q0(Q3), .CAI(\$1N84 ), .CLK(CLK), .EN(EN), 
	.CD(CD));
SRR21 \$1I78  (.Q0(\$1N84 ), .CAI(\$1N83 ), .CLK(CLK), .EN(EN), 
	.CD(CD));
SRR21 \$1I79  (.Q0(\$1N83 ), .CAI(\$1N81 ), .CLK(CLK), .EN(EN), 
	.CD(CD));
SRR21 \$1I80  (.Q0(\$1N81 ), .CAI(CAI), .CLK(CLK), .EN(EN), 
	.CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:13:11 1994
`timescale 10 ps / 10 ps 
module SRR28(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	CAI, CLK, EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input CAI;
	input CLK;
	input EN;
	input CD;

SRR21 \$1I141  (.Q0(\$1N145 ), .CAI(\$1N104 ), .CLK(CLK), .EN(EN), 
	.CD(CD));
SRR21 \$1I142  (.Q0(Q7), .CAI(\$1N158 ), .CLK(CLK), .EN(EN), 
	.CD(CD));
SRR21 \$1I143  (.Q0(\$1N158 ), .CAI(\$1N157 ), .CLK(CLK), .EN(EN), 
	.CD(CD));
SRR21 \$1I144  (.Q0(\$1N157 ), .CAI(\$1N145 ), .CLK(CLK), .EN(EN), 
	.CD(CD));
BUF \$1I170  (.Z0(Q0), .A0(\$1N81 ));
BUF \$1I175  (.Z0(Q1), .A0(\$1N83 ));
BUF \$1I178  (.Z0(Q2), .A0(\$1N84 ));
BUF \$1I181  (.Z0(Q3), .A0(\$1N104 ));
BUF \$1I184  (.Z0(Q4), .A0(\$1N145 ));
BUF \$1I187  (.Z0(Q5), .A0(\$1N157 ));
BUF \$1I190  (.Z0(Q6), .A0(\$1N158 ));
SRR21 \$1I77  (.Q0(\$1N104 ), .CAI(\$1N84 ), .CLK(CLK), .EN(EN), 
	.CD(CD));
SRR21 \$1I78  (.Q0(\$1N84 ), .CAI(\$1N83 ), .CLK(CLK), .EN(EN), 
	.CD(CD));
SRR21 \$1I79  (.Q0(\$1N83 ), .CAI(\$1N81 ), .CLK(CLK), .EN(EN), 
	.CD(CD));
SRR21 \$1I80  (.Q0(\$1N81 ), .CAI(CAI), .CLK(CLK), .EN(EN), 
	.CD(CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:13:13 1994
`timescale 10 ps / 10 ps 
module SRR31(
	Q0, D0, CAI, CLK, 
	PS, LD, EN, CD);

	output Q0;
	input D0;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CD;

FD21 \$1I1  (.Q0(\$1N5 ), .D0(\$1N29 ), .CLK(CLK), .CD(CD));
AND3 \$1I45  (.Z0(\$1N62 ), .A0(\$1N5 ), .A1(\$1N42 ), .A2(\$1N54 ));
AND3 \$1I47  (.Z0(\$1N60 ), .A0(EN), .A1(\$1N42 ), .A2(CAI));
AND2 \$1I48  (.Z0(\$1N64 ), .A0(LD), .A1(D0));
OR4 \$1I49  (.Z0(\$1N29 ), .A0(\$1N62 ), .A1(\$1N60 ), .A2(\$1N64 ), 
	.A3(PS));
INV \$1I72  (.ZN0(\$1N42 ), .A0(LD));
INV \$1I77  (.ZN0(\$1N54 ), .A0(EN));
BUF \$1I81  (.Z0(Q0), .A0(\$1N5 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:13:16 1994
`timescale 10 ps / 10 ps 
module SRR34(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CAI, CLK, PS, LD, 
	EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CD;

SRR31 \$1I111  (.Q0(Q3), .D0(D3), .CAI(\$1N84 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CD(CD));
SRR31 \$1I113  (.Q0(\$1N84 ), .D0(D2), .CAI(\$1N83 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CD(CD));
SRR31 \$1I115  (.Q0(\$1N83 ), .D0(D1), .CAI(\$1N81 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CD(CD));
SRR31 \$1I117  (.Q0(\$1N81 ), .D0(D0), .CAI(CAI), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CD(CD));
BUF \$1I133  (.Z0(Q2), .A0(\$1N84 ));
BUF \$1I138  (.Z0(Q1), .A0(\$1N83 ));
BUF \$1I141  (.Z0(Q0), .A0(\$1N81 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:13:19 1994
`timescale 10 ps / 10 ps 
module SRR38(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	CAI, CLK, PS, LD, 
	EN, CD);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CD;

SRR31 \$1I111  (.Q0(\$1N104 ), .D0(D3), .CAI(\$1N84 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CD(CD));
SRR31 \$1I113  (.Q0(\$1N84 ), .D0(D2), .CAI(\$1N83 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CD(CD));
SRR31 \$1I115  (.Q0(\$1N83 ), .D0(D1), .CAI(\$1N81 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CD(CD));
SRR31 \$1I117  (.Q0(\$1N81 ), .D0(D0), .CAI(CAI), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CD(CD));
SRR31 \$1I150  (.Q0(\$1N160 ), .D0(D4), .CAI(\$1N104 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CD(CD));
SRR31 \$1I152  (.Q0(\$1N159 ), .D0(D5), .CAI(\$1N160 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CD(CD));
SRR31 \$1I153  (.Q0(\$1N157 ), .D0(D6), .CAI(\$1N159 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CD(CD));
SRR31 \$1I154  (.Q0(Q7), .D0(D7), .CAI(\$1N157 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CD(CD));
BUF \$1I166  (.Z0(Q6), .A0(\$1N157 ));
BUF \$1I170  (.Z0(Q5), .A0(\$1N159 ));
BUF \$1I173  (.Z0(Q4), .A0(\$1N160 ));
BUF \$1I176  (.Z0(Q0), .A0(\$1N81 ));
BUF \$1I177  (.Z0(Q1), .A0(\$1N83 ));
BUF \$1I178  (.Z0(Q2), .A0(\$1N84 ));
BUF \$1I186  (.Z0(Q3), .A0(\$1N104 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:13:21 1994
`timescale 10 ps / 10 ps 
module SRR41(
	Q0, D0, CAI, CLK, 
	PS, LD, EN, CS);

	output Q0;
	input D0;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CS;

FD11 \$1I1  (.Q0(\$1N5 ), .D0(\$1N29 ), .CLK(CLK));
OR4 \$1I49  (.Z0(\$1N29 ), .A0(\$1N62 ), .A1(\$1N60 ), .A2(\$1N64 ), 
	.A3(PS));
INV \$1I72  (.ZN0(\$1N42 ), .A0(LD));
INV \$1I77  (.ZN0(\$1N54 ), .A0(EN));
AND4 \$1I81  (.Z0(\$1N62 ), .A0(\$1N5 ), .A1(\$1N42 ), .A2(\$1N54 ), 
	.A3(\$1N84 ));
AND4 \$1I82  (.Z0(\$1N60 ), .A0(EN), .A1(\$1N42 ), .A2(\$1N84 ), 
	.A3(CAI));
AND3 \$1I83  (.Z0(\$1N64 ), .A0(LD), .A1(\$1N84 ), .A2(D0));
INV \$1I87  (.ZN0(\$1N84 ), .A0(CS));
BUF \$1I91  (.Z0(Q0), .A0(\$1N5 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:13:25 1994
`timescale 10 ps / 10 ps 
module SRR44(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CAI, CLK, PS, LD, 
	EN, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CS;

SRR41 \$1I111  (.Q0(Q3), .D0(D3), .CAI(\$1N84 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CS(CS));
SRR41 \$1I113  (.Q0(\$1N84 ), .D0(D2), .CAI(\$1N83 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CS(CS));
SRR41 \$1I115  (.Q0(\$1N83 ), .D0(D1), .CAI(\$1N81 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CS(CS));
SRR41 \$1I117  (.Q0(\$1N81 ), .D0(D0), .CAI(CAI), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CS(CS));
BUF \$1I133  (.Z0(Q0), .A0(\$1N81 ));
BUF \$1I138  (.Z0(Q1), .A0(\$1N83 ));
BUF \$1I141  (.Z0(Q2), .A0(\$1N84 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:13:28 1994
`timescale 10 ps / 10 ps 
module SRR48(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	CAI, CLK, PS, LD, 
	EN, CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CAI;
	input CLK;
	input PS;
	input LD;
	input EN;
	input CS;

SRR41 \$1I111  (.Q0(\$1N104 ), .D0(D3), .CAI(\$1N84 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CS(CS));
SRR41 \$1I113  (.Q0(\$1N84 ), .D0(D2), .CAI(\$1N83 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CS(CS));
SRR41 \$1I115  (.Q0(\$1N83 ), .D0(D1), .CAI(\$1N81 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CS(CS));
SRR41 \$1I117  (.Q0(\$1N81 ), .D0(D0), .CAI(CAI), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CS(CS));
SRR41 \$1I150  (.Q0(\$1N160 ), .D0(D4), .CAI(\$1N104 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CS(CS));
SRR41 \$1I152  (.Q0(\$1N159 ), .D0(D5), .CAI(\$1N160 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CS(CS));
SRR41 \$1I153  (.Q0(\$1N157 ), .D0(D6), .CAI(\$1N159 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CS(CS));
SRR41 \$1I154  (.Q0(Q7), .D0(D7), .CAI(\$1N157 ), .CLK(CLK), 
	.PS(PS), .LD(LD), .EN(EN), .CS(CS));
BUF \$1I166  (.Z0(Q4), .A0(\$1N160 ));
BUF \$1I171  (.Z0(Q5), .A0(\$1N159 ));
BUF \$1I174  (.Z0(Q6), .A0(\$1N157 ));
BUF \$1I176  (.Z0(Q0), .A0(\$1N81 ));
BUF \$1I181  (.Z0(Q1), .A0(\$1N83 ));
BUF \$1I184  (.Z0(Q2), .A0(\$1N84 ));
BUF \$1I187  (.Z0(Q3), .A0(\$1N104 ));
endmodule
`timescale 10 ps / 10 ps
module SRR51(
	CAI, CD, CLK, D0, EN, LD, Q0, SD);


	input CAI;
	input CD;
	input CLK;
	input D0;
	input EN;
	input LD;
	output Q0;
	input SD;



OR3 \$1I35  (.Z0 (\$1N27 ), .A0 (\$1N22 ), .A1 (\$1N26 ), 
	.A2 (\$1N21 ));
INV \$1I13  (.ZN0 (\$1N28 ), .A0 (EN));
INV \$1I14  (.ZN0 (\$1N15 ), .A0 (LD));
AND2 \$1I18  (.Z0 (\$1N21 ), .A0 (LD), .A1 (D0));
AND3 \$1I19  (.Z0 (\$1N26 ), .A0 (EN), .A1 (\$1N15 ), 
	.A2 (CAI));
AND3 \$1I20  (.Z0 (\$1N22 ), .A0 (\$1N32 ), .A1 (\$1N15 ), 
	.A2 (\$1N28 ));
FDE1 \$1I25  (.Q0 (\$1N32 ), .D0 (\$1N27 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
BUF \$1I2  (.Z0 (Q0), .A0 (\$1N32 ));
endmodule
`timescale 10 ps / 10 ps
module SRR54(
	CAI, CD, CLK, D0, D1, D2, D3, EN, LD, Q0, Q1, Q2, Q3, SD);


	input CAI;
	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input LD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input SD;



SRR51 \$1I47  (.Q0 (\$1N6 ), .D0 (D1), .CAI (\$1N3 ), 
	.CLK (CLK), .SD (SD), .LD (LD), 
	.EN (EN), .CD (CD));
SRR51 \$1I48  (.Q0 (\$1N37 ), .D0 (D2), .CAI (\$1N6 ), 
	.CLK (CLK), .SD (SD), .LD (LD), 
	.EN (EN), .CD (CD));
SRR51 \$1I49  (.Q0 (Q3), .D0 (D3), .CAI (\$1N37 ), 
	.CLK (CLK), .SD (SD), .LD (LD), 
	.EN (EN), .CD (CD));
BUF \$1I2  (.Z0 (Q0), .A0 (\$1N3 ));
BUF \$1I5  (.Z0 (Q1), .A0 (\$1N6 ));
BUF \$1I38  (.Z0 (Q2), .A0 (\$1N37 ));
SRR51 \$1I46  (.Q0 (\$1N3 ), .D0 (D0), .CAI (CAI), 
	.CLK (CLK), .SD (SD), .LD (LD), 
	.EN (EN), .CD (CD));
endmodule
`timescale 10 ps / 10 ps
module SRR58(
	CAI, CD, CLK, D0, D1, D2, D3, D4, D5, D6, D7, EN, LD, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, SD);


	input CAI;
	input CD;
	input CLK;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input EN;
	input LD;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input SD;



SRR51 \$1I50  (.Q0 (\$1N9 ), .D0 (D4), .CAI (\$1N65 ), 
	.CLK (CLK), .SD (SD), .LD (LD), 
	.EN (EN), .CD (CD));
SRR51 \$1I48  (.Q0 (\$1N12 ), .D0 (D5), .CAI (\$1N9 ), 
	.CLK (CLK), .SD (SD), .LD (LD), 
	.EN (EN), .CD (CD));
SRR51 \$1I36  (.Q0 (\$1N59 ), .D0 (D1), .CAI (\$1N58 ), 
	.CLK (CLK), .SD (SD), .LD (LD), 
	.EN (EN), .CD (CD));
SRR51 \$1I37  (.Q0 (\$1N60 ), .D0 (D2), .CAI (\$1N59 ), 
	.CLK (CLK), .SD (SD), .LD (LD), 
	.EN (EN), .CD (CD));
SRR51 \$1I47  (.Q0 (\$1N55 ), .D0 (D6), .CAI (\$1N12 ), 
	.CLK (CLK), .SD (SD), .LD (LD), 
	.EN (EN), .CD (CD));
SRR51 \$1I46  (.Q0 (Q7), .D0 (D7), .CAI (\$1N55 ), 
	.CLK (CLK), .SD (SD), .LD (LD), 
	.EN (EN), .CD (CD));
SRR51 \$1I38  (.Q0 (\$1N65 ), .D0 (D3), .CAI (\$1N60 ), 
	.CLK (CLK), .SD (SD), .LD (LD), 
	.EN (EN), .CD (CD));
BUF \$1I5  (.Z0 (Q2), .A0 (\$1N60 ));
BUF \$1I6  (.Z0 (Q1), .A0 (\$1N59 ));
BUF \$1I7  (.Z0 (Q4), .A0 (\$1N9 ));
BUF \$1I10  (.Z0 (Q5), .A0 (\$1N12 ));
BUF \$1I57  (.Z0 (Q6), .A0 (\$1N55 ));
BUF \$1I64  (.Z0 (Q0), .A0 (\$1N58 ));
BUF \$1I66  (.Z0 (Q3), .A0 (\$1N65 ));
SRR51 \$1I35  (.Q0 (\$1N58 ), .D0 (D0), .CAI (CAI), 
	.CLK (CLK), .SD (SD), .LD (LD), 
	.EN (EN), .CD (CD));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:13:31 1994
`timescale 10 ps / 10 ps 
module SRRL1(
	Q0, D0, CAIR, CAIL, 
	CLK, PS, LD, EN, 
	RL, CD, CS);

	output Q0;
	input D0;
	input CAIR;
	input CAIL;
	input CLK;
	input PS;
	input LD;
	input EN;
	input RL;
	input CD;
	input CS;

AND4 \$1I106  (.Z0(\$1N107 ), .A0(\$1N5 ), .A1(\$1N42 ), .A2(\$1N54 ), 
	.A3(\$1N90 ));
OR5 \$1I113  (.Z0(\$1N118 ), .A0(\$1N107 ), .A1(\$1N109 ), .A2(\$1N111 ), 
	.A3(\$1N115 ), .A4(PS));
INV \$1I123  (.ZN0(\$1N100 ), .A0(RL));
INV \$1I128  (.ZN0(\$1N90 ), .A0(CS));
INV \$1I132  (.ZN0(\$1N42 ), .A0(LD));
INV \$1I136  (.ZN0(\$1N54 ), .A0(EN));
BUF \$1I143  (.Z0(Q0), .A0(\$1N5 ));
AND3 \$1I69  (.Z0(\$1N115 ), .A0(LD), .A1(\$1N90 ), .A2(D0));
FD21 \$1I84  (.Q0(\$1N5 ), .D0(\$1N118 ), .CLK(CLK), .CD(CD));
AND5 \$1I92  (.Z0(\$1N109 ), .A0(EN), .A1(\$1N42 ), .A2(\$1N90 ), 
	.A3(RL), .A4(CAIR));
AND5 \$1I99  (.Z0(\$1N111 ), .A0(EN), .A1(\$1N42 ), .A2(\$1N90 ), 
	.A3(\$1N100 ), .A4(CAIL));
endmodule
`timescale 10 ps / 10 ps
module SRRL1S(
	CAIL, CAIR, CD, CLK, CS, D0, EN, LD, PS, Q0, RL, SD);


	input CAIL;
	input CAIR;
	input CD;
	input CLK;
	input CS;
	input D0;
	input EN;
	input LD;
	input PS;
	output Q0;
	input RL;
	input SD;



FDE1 \$1I84  (.Q0 (\$1N5 ), .D0 (\$1N118 ), .CLK (CLK), 
	.SD (SD), .CD (CD));
BUF \$1I143  (.Z0 (Q0), .A0 (\$1N5 ));
OR5 \$1I113  (.Z0 (\$1N118 ), .A0 (\$1N107 ), .A1 (\$1N109 ), 
	.A2 (\$1N111 ), .A3 (\$1N115 ), .A4 (PS));
INV \$1I128  (.ZN0 (\$1N90 ), .A0 (CS));
INV \$1I123  (.ZN0 (\$1N100 ), .A0 (RL));
AND5 \$1I99  (.Z0 (\$1N111 ), .A0 (EN), .A1 (\$1N42 ), 
	.A2 (\$1N90 ), .A3 (\$1N100 ), .A4 (CAIL));
AND5 \$1I92  (.Z0 (\$1N109 ), .A0 (EN), .A1 (\$1N42 ), 
	.A2 (\$1N90 ), .A3 (RL), .A4 (CAIR));
AND3 \$1I69  (.Z0 (\$1N115 ), .A0 (LD), .A1 (\$1N90 ), 
	.A2 (D0));
INV \$1I132  (.ZN0 (\$1N42 ), .A0 (LD));
INV \$1I136  (.ZN0 (\$1N54 ), .A0 (EN));
AND4 \$1I106  (.Z0 (\$1N107 ), .A0 (\$1N5 ), .A1 (\$1N42 ), 
	.A2 (\$1N54 ), .A3 (\$1N90 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:13:34 1994
`timescale 10 ps / 10 ps 
module SRRL4(
	Q0, Q1, Q2, Q3, 
	D0, D1, D2, D3, 
	CAIR, CAIL, CLK, PS, 
	LD, EN, RL, CD, 
	CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input D0;
	input D1;
	input D2;
	input D3;
	input CAIR;
	input CAIL;
	input CLK;
	input PS;
	input LD;
	input EN;
	input RL;
	input CD;
	input CS;

SRRL1 \$1I278  (.Q0(\$1N271 ), .D0(D0), .CAIR(CAIR), .CAIL(\$1N5 ), 
	.CLK(CLK), .PS(PS), .LD(LD), .EN(EN), 
	.RL(RL), .CD(CD), .CS(CS));
SRRL1 \$1I279  (.Q0(\$1N5 ), .D0(D1), .CAIR(\$1N271 ), .CAIL(\$1N270 ), 
	.CLK(CLK), .PS(PS), .LD(LD), .EN(EN), 
	.RL(RL), .CD(CD), .CS(CS));
SRRL1 \$1I280  (.Q0(\$1N270 ), .D0(D2), .CAIR(\$1N5 ), .CAIL(\$1N269 ), 
	.CLK(CLK), .PS(PS), .LD(LD), .EN(EN), 
	.RL(RL), .CD(CD), .CS(CS));
SRRL1 \$1I281  (.Q0(\$1N269 ), .D0(D3), .CAIR(\$1N270 ), .CAIL(CAIL), 
	.CLK(CLK), .PS(PS), .LD(LD), .EN(EN), 
	.RL(RL), .CD(CD), .CS(CS));
BUF \$1I334  (.Z0(Q0), .A0(\$1N271 ));
BUF \$1I339  (.Z0(Q1), .A0(\$1N5 ));
BUF \$1I342  (.Z0(Q2), .A0(\$1N270 ));
BUF \$1I345  (.Z0(Q3), .A0(\$1N269 ));
endmodule
`timescale 10 ps / 10 ps
module SRRL4S(
	CAIL, CAIR, CD, CLK, CS, D0, D1, D2, D3, EN, LD, PS, Q0, Q1, Q2, Q3, RL, SD);


	input CAIL;
	input CAIR;
	input CD;
	input CLK;
	input CS;
	input D0;
	input D1;
	input D2;
	input D3;
	input EN;
	input LD;
	input PS;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	input RL;
	input SD;



SRRL1S \$1I279  (.Q0 (\$1N5 ), .D0 (D1), .CAIR (\$1N271 ), 
	.CAIL (\$1N270 ), .CLK (CLK), .SD (SD), 
	.PS (PS), .LD (LD), .EN (EN), 
	.RL (RL), .CD (CD), .CS (CS));
SRRL1S \$1I280  (.Q0 (\$1N270 ), .D0 (D2), .CAIR (\$1N5 ), 
	.CAIL (\$1N269 ), .CLK (CLK), .SD (SD), 
	.PS (PS), .LD (LD), .EN (EN), 
	.RL (RL), .CD (CD), .CS (CS));
SRRL1S \$1I281  (.Q0 (\$1N269 ), .D0 (D3), .CAIR (\$1N270 ), 
	.CAIL (CAIL), .CLK (CLK), .SD (SD), 
	.PS (PS), .LD (LD), .EN (EN), 
	.RL (RL), .CD (CD), .CS (CS));
BUF \$1I339  (.Z0 (Q1), .A0 (\$1N5 ));
BUF \$1I334  (.Z0 (Q0), .A0 (\$1N271 ));
BUF \$1I342  (.Z0 (Q2), .A0 (\$1N270 ));
BUF \$1I345  (.Z0 (Q3), .A0 (\$1N269 ));
SRRL1S \$1I278  (.Q0 (\$1N271 ), .D0 (D0), .CAIR (CAIR), 
	.CAIL (\$1N5 ), .CLK (CLK), .SD (SD), 
	.PS (PS), .LD (LD), .EN (EN), 
	.RL (RL), .CD (CD), .CS (CS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:13:38 1994
`timescale 10 ps / 10 ps 
module SRRL8(
	Q0, Q1, Q2, Q3, 
	Q4, Q5, Q6, Q7, 
	D0, D1, D2, D3, 
	D4, D5, D6, D7, 
	CAIR, CAIL, CLK, PS, 
	LD, EN, RL, CD, 
	CS);

	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input CAIR;
	input CAIL;
	input CLK;
	input PS;
	input LD;
	input EN;
	input RL;
	input CD;
	input CS;

SRRL1 \$1I278  (.Q0(\$1N271 ), .D0(D0), .CAIR(CAIR), .CAIL(\$1N5 ), 
	.CLK(CLK), .PS(PS), .LD(LD), .EN(EN), 
	.RL(RL), .CD(CD), .CS(CS));
SRRL1 \$1I279  (.Q0(\$1N5 ), .D0(D1), .CAIR(\$1N271 ), .CAIL(\$1N270 ), 
	.CLK(CLK), .PS(PS), .LD(LD), .EN(EN), 
	.RL(RL), .CD(CD), .CS(CS));
SRRL1 \$1I280  (.Q0(\$1N270 ), .D0(D2), .CAIR(\$1N5 ), .CAIL(\$1N269 ), 
	.CLK(CLK), .PS(PS), .LD(LD), .EN(EN), 
	.RL(RL), .CD(CD), .CS(CS));
SRRL1 \$1I281  (.Q0(\$1N269 ), .D0(D3), .CAIR(\$1N270 ), .CAIL(\$1N105 ), 
	.CLK(CLK), .PS(PS), .LD(LD), .EN(EN), 
	.RL(RL), .CD(CD), .CS(CS));
SRRL1 \$1I344  (.Q0(\$1N105 ), .D0(D4), .CAIR(\$1N269 ), .CAIL(\$1N371 ), 
	.CLK(CLK), .PS(PS), .LD(LD), .EN(EN), 
	.RL(RL), .CD(CD), .CS(CS));
SRRL1 \$1I345  (.Q0(\$1N371 ), .D0(D5), .CAIR(\$1N105 ), .CAIL(\$1N333 ), 
	.CLK(CLK), .PS(PS), .LD(LD), .EN(EN), 
	.RL(RL), .CD(CD), .CS(CS));
SRRL1 \$1I346  (.Q0(\$1N333 ), .D0(D6), .CAIR(\$1N371 ), .CAIL(\$1N359 ), 
	.CLK(CLK), .PS(PS), .LD(LD), .EN(EN), 
	.RL(RL), .CD(CD), .CS(CS));
SRRL1 \$1I354  (.Q0(\$1N359 ), .D0(D7), .CAIR(\$1N333 ), .CAIL(CAIL), 
	.CLK(CLK), .PS(PS), .LD(LD), .EN(EN), 
	.RL(RL), .CD(CD), .CS(CS));
BUF \$1I373  (.Z0(Q7), .A0(\$1N359 ));
BUF \$1I374  (.Z0(Q6), .A0(\$1N333 ));
BUF \$1I381  (.Z0(Q4), .A0(\$1N105 ));
BUF \$1I382  (.Z0(Q5), .A0(\$1N371 ));
BUF \$1I389  (.Z0(Q0), .A0(\$1N271 ));
BUF \$1I390  (.Z0(Q1), .A0(\$1N5 ));
BUF \$1I397  (.Z0(Q3), .A0(\$1N269 ));
BUF \$1I398  (.Z0(Q2), .A0(\$1N270 ));
endmodule
`timescale 10 ps / 10 ps
module SRRL8S(
	CAIL, CAIR, CD, CLK, CS, D0, D1, D2, D3, D4, D5, D6, D7, EN, LD, PS, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, RL, SD);


	input CAIL;
	input CAIR;
	input CD;
	input CLK;
	input CS;
	input D0;
	input D1;
	input D2;
	input D3;
	input D4;
	input D5;
	input D6;
	input D7;
	input EN;
	input LD;
	input PS;
	output Q0;
	output Q1;
	output Q2;
	output Q3;
	output Q4;
	output Q5;
	output Q6;
	output Q7;
	input RL;
	input SD;



SRRL1S \$1I279  (.Q0 (\$1N5 ), .D0 (D1), .CAIR (\$1N271 ), 
	.CAIL (\$1N270 ), .CLK (CLK), .SD (SD), 
	.PS (PS), .LD (LD), .EN (EN), 
	.RL (RL), .CD (CD), .CS (CS));
SRRL1S \$1I280  (.Q0 (\$1N270 ), .D0 (D2), .CAIR (\$1N5 ), 
	.CAIL (\$1N269 ), .CLK (CLK), .SD (SD), 
	.PS (PS), .LD (LD), .EN (EN), 
	.RL (RL), .CD (CD), .CS (CS));
SRRL1S \$1I281  (.Q0 (\$1N269 ), .D0 (D3), .CAIR (\$1N270 ), 
	.CAIL (\$1N105 ), .CLK (CLK), .SD (SD), 
	.PS (PS), .LD (LD), .EN (EN), 
	.RL (RL), .CD (CD), .CS (CS));
SRRL1S \$1I344  (.Q0 (\$1N105 ), .D0 (D4), .CAIR (\$1N269 ), 
	.CAIL (\$1N371 ), .CLK (CLK), .SD (SD), 
	.PS (PS), .LD (LD), .EN (EN), 
	.RL (RL), .CD (CD), .CS (CS));
SRRL1S \$1I345  (.Q0 (\$1N371 ), .D0 (D5), .CAIR (\$1N105 ), 
	.CAIL (\$1N333 ), .CLK (CLK), .SD (SD), 
	.PS (PS), .LD (LD), .EN (EN), 
	.RL (RL), .CD (CD), .CS (CS));
SRRL1S \$1I346  (.Q0 (\$1N333 ), .D0 (D6), .CAIR (\$1N371 ), 
	.CAIL (\$1N359 ), .CLK (CLK), .SD (SD), 
	.PS (PS), .LD (LD), .EN (EN), 
	.RL (RL), .CD (CD), .CS (CS));
SRRL1S \$1I354  (.Q0 (\$1N359 ), .D0 (D7), .CAIR (\$1N333 ), 
	.CAIL (CAIL), .CLK (CLK), .SD (SD), 
	.PS (PS), .LD (LD), .EN (EN), 
	.RL (RL), .CD (CD), .CS (CS));
BUF \$1I374  (.Z0 (Q6), .A0 (\$1N333 ));
BUF \$1I373  (.Z0 (Q7), .A0 (\$1N359 ));
BUF \$1I381  (.Z0 (Q4), .A0 (\$1N105 ));
BUF \$1I382  (.Z0 (Q5), .A0 (\$1N371 ));
BUF \$1I389  (.Z0 (Q0), .A0 (\$1N271 ));
BUF \$1I390  (.Z0 (Q1), .A0 (\$1N5 ));
BUF \$1I397  (.Z0 (Q3), .A0 (\$1N269 ));
BUF \$1I398  (.Z0 (Q2), .A0 (\$1N270 ));
SRRL1S \$1I278  (.Q0 (\$1N271 ), .D0 (D0), .CAIR (CAIR), 
	.CAIL (\$1N5 ), .CLK (CLK), .SD (SD), 
	.PS (PS), .LD (LD), .EN (EN), 
	.RL (RL), .CD (CD), .CS (CS));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:13:41 1994
`timescale 10 ps / 10 ps 
module SUBF1(
	Z0, BO, A0, B0, 
	BI);

	output Z0;
	output BO;
	input A0;
	input B0;
	input BI;

XOR2 \$1I134  (.Z0(Z0), .A0(A0), .A1(\$1N155 ));
AND2 \$1I135  (.Z0(\$1N153 ), .A0(\$1N93 ), .A1(BI));
AND2 \$1I138  (.Z0(\$1N148 ), .A0(B0), .A1(\$1N142 ));
OR2 \$1I151  (.Z0(\$1N155 ), .A0(\$1N148 ), .A1(\$1N153 ));
INV \$1I28  (.ZN0(\$1N42 ), .A0(A0));
INV \$1I29  (.ZN0(\$1N93 ), .A0(B0));
INV \$1I30  (.ZN0(\$1N142 ), .A0(BI));
AND2 \$1I32  (.Z0(\$1N53 ), .A0(BI), .A1(B0));
AND2 \$1I33  (.Z0(\$1N55 ), .A0(BI), .A1(\$1N42 ));
AND2 \$1I34  (.Z0(\$1N57 ), .A0(B0), .A1(\$1N42 ));
OR3 \$1I38  (.Z0(BO), .A0(\$1N53 ), .A1(\$1N55 ), .A2(\$1N57 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:13:53 1994
`timescale 10 ps / 10 ps 
module SUBF16A(
	BO, Z0, Z1, Z10, 
	Z11, Z12, Z13, Z14, 
	Z15, Z2, Z3, Z4, 
	Z5, Z6, Z7, Z8, 
	Z9, A0, A1, A10, 
	A11, A12, A13, A14, 
	A15, A2, A3, A4, 
	A5, A6, A7, A8, 
	A9, B0, B1, B10, 
	B11, B12, B13, B14, 
	B15, B2, B3, B4, 
	B5, B6, B7, B8, 
	B9, BI);

	output BO;
	output Z0;
	output Z1;
	output Z10;
	output Z11;
	output Z12;
	output Z13;
	output Z14;
	output Z15;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	output Z8;
	output Z9;
	input A0;
	input A1;
	input A10;
	input A11;
	input A12;
	input A13;
	input A14;
	input A15;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input A8;
	input A9;
	input B0;
	input B1;
	input B10;
	input B11;
	input B12;
	input B13;
	input B14;
	input B15;
	input B2;
	input B3;
	input B4;
	input B5;
	input B6;
	input B7;
	input B8;
	input B9;
	input BI;

PG1 \$1I680  (.PGO1(\$1N445 ), .GI1(G345), .PI1(P345), .PGI1(\$1N704 ));
PG2 \$1I682  (.PGO2(\$1N510 ), .GI2(G678), .PI2(P678), .GI1(G345), 
	.PI1(P345), .PGI1(\$1N704 ));
PG3 \$1I683  (.PGO3(\$1N515 ), .GI3(G911), .PI3(P911), .GI2(G678), 
	.PI2(P678), .GI1(G345), .PI1(P345), .PGI1(\$1N704 ));
PG4 \$1I684  (.PGO4(\$1N652 ), .GI4(G1214), .PI4(P1214), .GI3(G911), 
	.PI3(P911), .GI2(G678), .PI2(P678), .GI1(G345), 
	.PI1(P345), .PGI1(\$1N704 ));
PG1 \$1I702  (.PGO1(\$1N704 ), .GI1(G012), .PI1(P012), .PGI1(BI));
F3SUB \$1I710  (.Z0(Z0), .Z1(Z1), .Z2(Z2), .G012(G012), 
	.P012(P012), .A0(A0), .A1(A1), .A2(A2), 
	.B0(B0), .B1(B1), .B2(B2), .BI(BI));
F3SUB \$1I711  (.Z0(Z3), .Z1(Z4), .Z2(Z5), .G012(G345), 
	.P012(P345), .A0(A3), .A1(A4), .A2(A5), 
	.B0(B3), .B1(B4), .B2(B5), .BI(\$1N704 ));
F3SUB \$1I712  (.Z0(Z6), .Z1(Z7), .Z2(Z8), .G012(G678), 
	.P012(P678), .A0(A6), .A1(A7), .A2(A8), 
	.B0(B6), .B1(B7), .B2(B8), .BI(\$1N445 ));
F3SUB \$1I713  (.Z0(Z9), .Z1(Z10), .Z2(Z11), .G012(G911), 
	.P012(P911), .A0(A9), .A1(A10), .A2(A11), 
	.B0(B9), .B1(B10), .B2(B11), .BI(\$1N510 ));
F3SUB \$1I714  (.Z0(Z12), .Z1(Z13), .Z2(Z14), .G012(G1214), 
	.P012(P1214), .A0(A12), .A1(A13), .A2(A14), 
	.B0(B12), .B1(B13), .B2(B14), .BI(\$1N515 ));
SUBF1 \$1I716  (.Z0(Z15), .BO(BO), .A0(A15), .B0(B15), 
	.BI(\$1N652 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:13:56 1994
`timescale 10 ps / 10 ps 
module SUBF2(
	Z0, Z1, BO, A0, 
	A1, B0, B1, BI);

	output Z0;
	output Z1;
	output BO;
	input A0;
	input A1;
	input B0;
	input B1;
	input BI;

INV \$1I180  (.ZN0(\~BI ), .A0(BI));
AND3 \$1I336  (.Z0(\$1N370 ), .A0(BI), .A1(\~A1 ), .A2(\~A0 ));
AND3 \$1I340  (.Z0(\$1N368 ), .A0(BI), .A1(\~A1 ), .A2(B0));
AND3 \$1I341  (.Z0(\$1N366 ), .A0(BI), .A1(\~A0 ), .A2(B1));
AND3 \$1I342  (.Z0(\$1N372 ), .A0(BI), .A1(B1), .A2(B0));
AND3 \$1I343  (.Z0(\$1N376 ), .A0(\~A1 ), .A1(\~A0 ), .A2(B0));
AND3 \$1I344  (.Z0(\$1N402 ), .A0(\~A0 ), .A1(B1), .A2(B0));
AND2 \$1I345  (.Z0(\$1N378 ), .A0(\~A1 ), .A1(B1));
OR7 \$1I401  (.Z0(BO), .A0(\$1N370 ), .A1(\$1N368 ), .A2(\$1N366 ), 
	.A3(\$1N372 ), .A4(\$1N376 ), .A5(\$1N402 ), .A6(\$1N378 ));
AND3 \$1I416  (.Z0(\$1N441 ), .A0(A0), .A1(B1), .A2(\~BI ));
AND3 \$1I417  (.Z0(\$1N443 ), .A0(B1), .A1(\~B0 ), .A2(\~BI ));
AND3 \$1I418  (.Z0(\$1N445 ), .A0(\~A0 ), .A1(\~B1 ), .A2(BI));
AND3 \$1I419  (.Z0(\$1N447 ), .A0(\~B1 ), .A1(B0), .A2(BI));
AND3 \$1I420  (.Z0(\$1N449 ), .A0(A0), .A1(B1), .A2(\~B0 ));
AND3 \$1I421  (.Z0(\$1N451 ), .A0(\~A0 ), .A1(\~B1 ), .A2(B0));
OR6 \$1I440  (.Z0(\$1N455 ), .A0(\$1N441 ), .A1(\$1N443 ), .A2(\$1N445 ), 
	.A3(\$1N447 ), .A4(\$1N449 ), .A5(\$1N451 ));
LXOR2 \$1I453  (.Z0(Z1), .A0(A1), .A1(\$1N455 ));
INV \$1I486  (.ZN0(\~B0 ), .A0(B0));
INV \$1I487  (.ZN0(\~B1 ), .A0(B1));
INV \$1I544  (.ZN0(\~A1 ), .A0(A1));
INV \$1I545  (.ZN0(\~A0 ), .A0(A0));
XOR2 \$1I563  (.Z0(Z0), .A0(A0), .A1(\$1N565 ));
OR2 \$1I564  (.Z0(\$1N565 ), .A0(\$1N574 ), .A1(\$1N577 ));
AND2 \$1I572  (.Z0(\$1N574 ), .A0(\~B0 ), .A1(BI));
AND2 \$1I573  (.Z0(\$1N577 ), .A0(\~BI ), .A1(B0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:14:00 1994
`timescale 10 ps / 10 ps 
module SUBF4(
	Z0, Z1, Z2, Z3, 
	BO, A0, A1, A2, 
	A3, B0, B1, B2, 
	B3, BI);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output BO;
	input A0;
	input A1;
	input A2;
	input A3;
	input B0;
	input B1;
	input B2;
	input B3;
	input BI;

SUBF2 \$1I45  (.Z0(Z0), .Z1(Z1), .BO(\$1N4 ), .A0(A0), 
	.A1(A1), .B0(B0), .B1(B1), .BI(BI));
SUBF2 \$1I46  (.Z0(Z2), .Z1(Z3), .BO(BO), .A0(A2), 
	.A1(A3), .B0(B2), .B1(B3), .BI(\$1N4 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:14:08 1994
`timescale 10 ps / 10 ps 
module SUBF8(
	Z0, Z1, Z2, Z3, 
	Z4, Z5, Z6, Z7, 
	BO, A0, A1, A2, 
	A3, A4, A5, A6, 
	A7, B0, B1, B2, 
	B3, B4, B5, B6, 
	B7, BI);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	output BO;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input B0;
	input B1;
	input B2;
	input B3;
	input B4;
	input B5;
	input B6;
	input B7;
	input BI;

XOR2 \$1I164  (.Z0(P7), .A0(A7), .A1(B7));
XOR2 \$1I165  (.Z0(P6), .A0(A6), .A1(B6));
XOR2 \$1I166  (.Z0(P5), .A0(A5), .A1(B5));
XOR2 \$1I167  (.Z0(P4), .A0(A4), .A1(B4));
XOR2 \$1I168  (.Z0(P3), .A0(A3), .A1(B3));
XOR2 \$1I169  (.Z0(P2), .A0(A2), .A1(B2));
XOR2 \$1I170  (.Z0(P1), .A0(A1), .A1(B1));
XOR2 \$1I171  (.Z0(P0), .A0(A0), .A1(B0));
AND2 \$1I172  (.Z0(G7), .A0(\$1N334 ), .A1(B7));
AND2 \$1I173  (.Z0(G6), .A0(\$1N332 ), .A1(B6));
AND2 \$1I174  (.Z0(G5), .A0(\$1N326 ), .A1(B5));
AND2 \$1I175  (.Z0(G4), .A0(\$1N324 ), .A1(B4));
AND2 \$1I176  (.Z0(G3), .A0(\$1N322 ), .A1(B3));
AND2 \$1I177  (.Z0(G2), .A0(\$1N320 ), .A1(B2));
AND2 \$1I178  (.Z0(G1), .A0(\$1N318 ), .A1(B1));
AND2 \$1I179  (.Z0(G0), .A0(\$1N316 ), .A1(B0));
INV \$1I303  (.ZN0(\$1N316 ), .A0(A0));
INV \$1I306  (.ZN0(\$1N318 ), .A0(A1));
INV \$1I307  (.ZN0(\$1N320 ), .A0(A2));
INV \$1I308  (.ZN0(\$1N322 ), .A0(A3));
INV \$1I309  (.ZN0(\$1N324 ), .A0(A4));
INV \$1I310  (.ZN0(\$1N326 ), .A0(A5));
INV \$1I328  (.ZN0(\$1N332 ), .A0(A6));
INV \$1I329  (.ZN0(\$1N334 ), .A0(A7));
AND8 \$2I1  (.Z0(\$2N67 ), .A0(G0), .A1(\$2N50 ), .A2(\$2N47 ), 
	.A3(\$2N43 ), .A4(\$2N38 ), .A5(\$2N32 ), .A6(\$2N25 ), 
	.A7(\$2N16 ));
OR6 \$2I114  (.Z0(\$2N128 ), .A0(\$2N119 ), .A1(\$2N117 ), .A2(\$2N115 ), 
	.A3(\$2N121 ), .A4(\$2N123 ), .A5(G4));
LXOR2 \$2I126  (.Z0(Z5), .A0(\$2N128 ), .A1(P5));
AND7 \$2I13  (.Z0(\$2N65 ), .A0(G1), .A1(\$2N47 ), .A2(\$2N43 ), 
	.A3(\$2N38 ), .A4(\$2N32 ), .A5(\$2N25 ), .A6(\$2N16 ));
OR5 \$2I14  (.Z0(\$2N82 ), .A0(\$2N75 ), .A1(\$2N73 ), .A2(\$2N79 ), 
	.A3(\$2N77 ), .A4(G7));
AND2 \$2I144  (.Z0(\$2N149 ), .A0(G0), .A1(\$2N138 ));
AND3 \$2I145  (.Z0(\$2N147 ), .A0(BI), .A1(\$2N140 ), .A2(\$2N138 ));
OR3 \$2I146  (.Z0(\$2N153 ), .A0(\$2N147 ), .A1(\$2N149 ), .A2(G1));
AND9 \$2I15  (.Z0(\$2N71 ), .A0(BI), .A1(\$2N190 ), .A2(\$2N50 ), 
	.A3(\$2N47 ), .A4(\$2N43 ), .A5(\$2N38 ), .A6(\$2N32 ), 
	.A7(\$2N25 ), .A8(\$2N16 ));
LXOR2 \$2I152  (.Z0(Z2), .A0(\$2N153 ), .A1(P2));
INV \$2I158  (.ZN0(\$2N16 ), .A0(P7));
INV \$2I162  (.ZN0(\$2N25 ), .A0(P6));
INV \$2I163  (.ZN0(\$2N32 ), .A0(P5));
INV \$2I164  (.ZN0(\$2N38 ), .A0(P4));
INV \$2I165  (.ZN0(\$2N43 ), .A0(P3));
INV \$2I179  (.ZN0(\$2N47 ), .A0(P2));
INV \$2I180  (.ZN0(\$2N50 ), .A0(P1));
INV \$2I181  (.ZN0(\$2N190 ), .A0(P0));
INV \$2I192  (.ZN0(\$2N198 ), .A0(P0));
INV \$2I193  (.ZN0(\$2N106 ), .A0(P1));
INV \$2I194  (.ZN0(\$2N103 ), .A0(P2));
INV \$2I195  (.ZN0(\$2N99 ), .A0(P3));
INV \$2I196  (.ZN0(\$2N94 ), .A0(P4));
AND6 \$2I2  (.Z0(\$2N69 ), .A0(G2), .A1(\$2N43 ), .A2(\$2N38 ), 
	.A3(\$2N32 ), .A4(\$2N25 ), .A5(\$2N16 ));
INV \$2I213  (.ZN0(\$2N138 ), .A0(P1));
INV \$2I214  (.ZN0(\$2N140 ), .A0(P0));
AND5 \$2I3  (.Z0(\$2N75 ), .A0(G3), .A1(\$2N38 ), .A2(\$2N32 ), 
	.A3(\$2N25 ), .A4(\$2N16 ));
AND2 \$2I4  (.Z0(\$2N77 ), .A0(G6), .A1(\$2N16 ));
AND3 \$2I5  (.Z0(\$2N79 ), .A0(G5), .A1(\$2N25 ), .A2(\$2N16 ));
AND4 \$2I6  (.Z0(\$2N73 ), .A0(G4), .A1(\$2N32 ), .A2(\$2N25 ), 
	.A3(\$2N16 ));
OR4 \$2I64  (.Z0(\$2N84 ), .A0(\$2N71 ), .A1(\$2N67 ), .A2(\$2N65 ), 
	.A3(\$2N69 ));
OR2 \$2I81  (.Z0(BO), .A0(\$2N84 ), .A1(\$2N82 ));
AND6 \$2I89  (.Z0(\$2N119 ), .A0(BI), .A1(\$2N198 ), .A2(\$2N106 ), 
	.A3(\$2N103 ), .A4(\$2N99 ), .A5(\$2N94 ));
AND5 \$2I90  (.Z0(\$2N117 ), .A0(G0), .A1(\$2N106 ), .A2(\$2N103 ), 
	.A3(\$2N99 ), .A4(\$2N94 ));
AND4 \$2I91  (.Z0(\$2N115 ), .A0(G1), .A1(\$2N103 ), .A2(\$2N99 ), 
	.A3(\$2N94 ));
AND3 \$2I92  (.Z0(\$2N121 ), .A0(G2), .A1(\$2N99 ), .A2(\$2N94 ));
AND2 \$2I93  (.Z0(\$2N123 ), .A0(G3), .A1(\$2N94 ));
AND2 \$3I102  (.Z0(\$3N68 ), .A0(BI), .A1(\$3N13 ));
OR2 \$3I103  (.Z0(\$3N63 ), .A0(\$3N68 ), .A1(G0));
INV \$3I108  (.ZN0(\$3N28 ), .A0(P6));
INV \$3I112  (.ZN0(\$3N26 ), .A0(P5));
INV \$3I113  (.ZN0(\$3N23 ), .A0(P4));
INV \$3I114  (.ZN0(\$3N21 ), .A0(P3));
INV \$3I115  (.ZN0(\$3N20 ), .A0(P2));
INV \$3I116  (.ZN0(\$3N140 ), .A0(P1));
INV \$3I129  (.ZN0(\$3N13 ), .A0(P0));
OR2 \$3I32  (.Z0(\$3N54 ), .A0(\$3N34 ), .A1(\$3N33 ));
LXOR2 \$3I4  (.Z0(Z1), .A0(\$3N63 ), .A1(P1));
XOR2 \$3I72  (.Z0(Z0), .A0(BI), .A1(P0));
AND2 \$3I87  (.Z0(\$3N53 ), .A0(G5), .A1(\$3N28 ));
AND3 \$3I88  (.Z0(\$3N50 ), .A0(G4), .A1(\$3N26 ), .A2(\$3N28 ));
AND4 \$3I89  (.Z0(\$3N51 ), .A0(G3), .A1(\$3N23 ), .A2(\$3N26 ), 
	.A3(\$3N28 ));
AND5 \$3I90  (.Z0(\$3N48 ), .A0(G2), .A1(\$3N21 ), .A2(\$3N23 ), 
	.A3(\$3N26 ), .A4(\$3N28 ));
AND6 \$3I91  (.Z0(\$3N46 ), .A0(G1), .A1(\$3N20 ), .A2(\$3N21 ), 
	.A3(\$3N23 ), .A4(\$3N26 ), .A5(\$3N28 ));
AND7 \$3I92  (.Z0(\$3N47 ), .A0(G0), .A1(\$3N140 ), .A2(\$3N20 ), 
	.A3(\$3N21 ), .A4(\$3N23 ), .A5(\$3N26 ), .A6(\$3N28 ));
AND8 \$3I93  (.Z0(\$3N49 ), .A0(BI), .A1(\$3N13 ), .A2(\$3N140 ), 
	.A3(\$3N20 ), .A4(\$3N21 ), .A5(\$3N23 ), .A6(\$3N26 ), 
	.A7(\$3N28 ));
OR5 \$3I94  (.Z0(\$3N34 ), .A0(\$3N49 ), .A1(\$3N47 ), .A2(\$3N46 ), 
	.A3(\$3N48 ), .A4(\$3N51 ));
OR3 \$3I96  (.Z0(\$3N33 ), .A0(\$3N50 ), .A1(\$3N53 ), .A2(G6));
LXOR2 \$3I98  (.Z0(Z7), .A0(\$3N54 ), .A1(P7));
AND2 \$4I105  (.Z0(\$4N65 ), .A0(G2), .A1(\$4N7 ));
AND3 \$4I106  (.Z0(\$4N64 ), .A0(G1), .A1(\$4N9 ), .A2(\$4N7 ));
AND4 \$4I107  (.Z0(\$4N67 ), .A0(G0), .A1(\$4N11 ), .A2(\$4N9 ), 
	.A3(\$4N7 ));
AND5 \$4I108  (.Z0(\$4N68 ), .A0(BI), .A1(\$4N182 ), .A2(\$4N11 ), 
	.A3(\$4N9 ), .A4(\$4N7 ));
OR5 \$4I109  (.Z0(\$4N63 ), .A0(\$4N68 ), .A1(\$4N67 ), .A2(\$4N64 ), 
	.A3(\$4N65 ), .A4(G3));
LXOR2 \$4I117  (.Z0(Z3), .A0(\$4N115 ), .A1(P3));
AND2 \$4I136  (.Z0(\$4N140 ), .A0(G1), .A1(\$4N132 ));
AND3 \$4I137  (.Z0(\$4N120 ), .A0(G0), .A1(\$4N130 ), .A2(\$4N132 ));
AND4 \$4I138  (.Z0(\$4N119 ), .A0(BI), .A1(\$4N194 ), .A2(\$4N130 ), 
	.A3(\$4N132 ));
OR4 \$4I139  (.Z0(\$4N115 ), .A0(\$4N119 ), .A1(\$4N120 ), .A2(\$4N140 ), 
	.A3(G2));
INV \$4I144  (.ZN0(\$4N26 ), .A0(P5));
INV \$4I145  (.ZN0(\$4N23 ), .A0(P4));
INV \$4I146  (.ZN0(\$4N21 ), .A0(P3));
INV \$4I147  (.ZN0(\$4N20 ), .A0(P2));
INV \$4I148  (.ZN0(\$4N18 ), .A0(P1));
INV \$4I149  (.ZN0(\$4N166 ), .A0(P0));
INV \$4I168  (.ZN0(\$4N7 ), .A0(P3));
INV \$4I169  (.ZN0(\$4N9 ), .A0(P2));
INV \$4I170  (.ZN0(\$4N11 ), .A0(P1));
INV \$4I171  (.ZN0(\$4N182 ), .A0(P0));
INV \$4I184  (.ZN0(\$4N132 ), .A0(P2));
INV \$4I185  (.ZN0(\$4N130 ), .A0(P1));
INV \$4I186  (.ZN0(\$4N194 ), .A0(P0));
OR2 \$4I32  (.Z0(\$4N99 ), .A0(\$4N34 ), .A1(\$4N33 ));
OR4 \$4I37  (.Z0(\$4N34 ), .A0(\$4N49 ), .A1(\$4N47 ), .A2(\$4N46 ), 
	.A3(\$4N48 ));
LXOR2 \$4I4  (.Z0(Z4), .A0(\$4N63 ), .A1(P4));
AND2 \$4I88  (.Z0(\$4N50 ), .A0(G4), .A1(\$4N26 ));
AND3 \$4I91  (.Z0(\$4N51 ), .A0(G3), .A1(\$4N23 ), .A2(\$4N26 ));
AND4 \$4I92  (.Z0(\$4N48 ), .A0(G2), .A1(\$4N21 ), .A2(\$4N23 ), 
	.A3(\$4N26 ));
AND5 \$4I93  (.Z0(\$4N46 ), .A0(G1), .A1(\$4N20 ), .A2(\$4N21 ), 
	.A3(\$4N23 ), .A4(\$4N26 ));
AND6 \$4I94  (.Z0(\$4N47 ), .A0(G0), .A1(\$4N18 ), .A2(\$4N20 ), 
	.A3(\$4N21 ), .A4(\$4N23 ), .A5(\$4N26 ));
AND7 \$4I95  (.Z0(\$4N49 ), .A0(BI), .A1(\$4N166 ), .A2(\$4N18 ), 
	.A3(\$4N20 ), .A4(\$4N21 ), .A5(\$4N23 ), .A6(\$4N26 ));
OR3 \$4I96  (.Z0(\$4N33 ), .A0(\$4N51 ), .A1(\$4N50 ), .A2(G5));
LXOR2 \$4I98  (.Z0(Z6), .A0(\$4N99 ), .A1(P6));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:14:19 1994
`timescale 10 ps / 10 ps 
module SUBF8A(
	Z0, Z1, Z2, Z3, 
	Z4, Z5, Z6, Z7, 
	BO, A0, A1, A2, 
	A3, A4, A5, A6, 
	A7, B0, B1, B2, 
	B3, B4, B5, B6, 
	B7, BI);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	output BO;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input B0;
	input B1;
	input B2;
	input B3;
	input B4;
	input B5;
	input B6;
	input B7;
	input BI;

PG1 \$1I430  (.PGO1(\$1N411 ), .GI1(G012), .PI1(P012), .PGI1(BI));
PG2 \$1I435  (.PGO2(\$1N421 ), .GI2(G345), .PI2(P345), .GI1(G012), 
	.PI1(P012), .PGI1(BI));
F3SUB \$1I438  (.Z0(Z0), .Z1(Z1), .Z2(Z2), .G012(G012), 
	.P012(P012), .A0(A0), .A1(A1), .A2(A2), 
	.B0(B0), .B1(B1), .B2(B2), .BI(BI));
F3SUB \$1I439  (.Z0(Z3), .Z1(Z4), .Z2(Z5), .G012(G345), 
	.P012(P345), .A0(A3), .A1(A4), .A2(A5), 
	.B0(B3), .B1(B4), .B2(B5), .BI(\$1N411 ));
SUBF2 \$1I441  (.Z0(Z6), .Z1(Z7), .BO(BO), .A0(A6), 
	.A1(A7), .B0(B6), .B1(B7), .BI(\$1N421 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:14:21 1994
`timescale 10 ps / 10 ps 
module SUBH1(
	Z0, BO, A0, B0);

	output Z0;
	output BO;
	input A0;
	input B0;

AND2 \$1I12  (.Z0(\$1N22 ), .A0(\$1N56 ), .A1(B0));
AND2 \$1I13  (.Z0(\$1N26 ), .A0(\$1N42 ), .A1(A0));
AND2 \$1I14  (.Z0(BO), .A0(B0), .A1(\$1N56 ));
OR2 \$1I25  (.Z0(Z0), .A0(\$1N22 ), .A1(\$1N26 ));
INV \$1I41  (.ZN0(\$1N42 ), .A0(B0));
INV \$1I45  (.ZN0(\$1N56 ), .A0(A0));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:14:36 1994
`timescale 10 ps / 10 ps 
module SUBH16A(
	BO, Z0, Z1, Z10, 
	Z11, Z12, Z13, Z14, 
	Z15, Z2, Z3, Z4, 
	Z5, Z6, Z7, Z8, 
	Z9, A0, A1, A10, 
	A11, A12, A13, A14, 
	A15, A2, A3, A4, 
	A5, A6, A7, A8, 
	A9, B0, B1, B10, 
	B11, B12, B13, B14, 
	B15, B2, B3, B4, 
	B5, B6, B7, B8, 
	B9);

	output BO;
	output Z0;
	output Z1;
	output Z10;
	output Z11;
	output Z12;
	output Z13;
	output Z14;
	output Z15;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	output Z8;
	output Z9;
	input A0;
	input A1;
	input A10;
	input A11;
	input A12;
	input A13;
	input A14;
	input A15;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input A8;
	input A9;
	input B0;
	input B1;
	input B10;
	input B11;
	input B12;
	input B13;
	input B14;
	input B15;
	input B2;
	input B3;
	input B4;
	input B5;
	input B6;
	input B7;
	input B8;
	input B9;

PG1 \$1I680  (.PGO1(\$1N445 ), .GI1(G345), .PI1(P345), .PGI1(G012));
PG2 \$1I682  (.PGO2(\$1N510 ), .GI2(\$1N696 ), .PI2(P678), .GI1(G345), 
	.PI1(P345), .PGI1(G012));
PG3 \$1I683  (.PGO3(\$1N515 ), .GI3(G911), .PI3(P911), .GI2(\$1N696 ), 
	.PI2(P678), .GI1(G345), .PI1(P345), .PGI1(G012));
PG4 \$1I684  (.PGO4(\$1N652 ), .GI4(G1214), .PI4(P1214), .GI3(G911), 
	.PI3(P911), .GI2(\$1N696 ), .PI2(P678), .GI1(G345), 
	.PI1(P345), .PGI1(G012));
F3SUB \$1I690  (.Z0(Z3), .Z1(Z4), .Z2(Z5), .G012(G345), 
	.P012(P345), .A0(A3), .A1(A4), .A2(A5), 
	.B0(B3), .B1(B4), .B2(B5), .BI(G012));
F3SUB \$1I691  (.Z0(Z6), .Z1(Z7), .Z2(Z8), .G012(\$1N696 ), 
	.P012(P678), .A0(A6), .A1(A7), .A2(A8), 
	.B0(B6), .B1(B7), .B2(B8), .BI(\$1N445 ));
F3SUB \$1I692  (.Z0(Z9), .Z1(Z10), .Z2(Z11), .G012(G911), 
	.P012(P911), .A0(A9), .A1(A10), .A2(A11), 
	.B0(B9), .B1(B10), .B2(B11), .BI(\$1N510 ));
F3SUB \$1I693  (.Z0(Z12), .Z1(Z13), .Z2(Z14), .G012(G1214), 
	.P012(P1214), .A0(A12), .A1(A13), .A2(A14), 
	.B0(B12), .B1(B13), .B2(B14), .BI(\$1N515 ));
SUBH3 \$1I700  (.Z0(Z0), .Z1(Z1), .Z2(Z2), .BO(G012), 
	.A0(A0), .A1(A1), .A2(A2), .B0(B0), 
	.B1(B1), .B2(B2));
SUBF1 \$1I702  (.Z0(Z15), .BO(BO), .A0(A15), .B0(B15), 
	.BI(\$1N652 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:14:39 1994
`timescale 10 ps / 10 ps 
module SUBH2(
	Z0, Z1, BO, A0, 
	A1, B0, B1);

	output Z0;
	output Z1;
	output BO;
	input A0;
	input A1;
	input B0;
	input B1;

AND2 \$1I321  (.Z0(\$1N328 ), .A0(\~A0 ), .A1(B0));
AND2 \$1I322  (.Z0(\$1N327 ), .A0(A0), .A1(\~B0 ));
AND3 \$1I343  (.Z0(\$1N376 ), .A0(\~A1 ), .A1(\~A0 ), .A2(B0));
AND3 \$1I344  (.Z0(\$1N402 ), .A0(\~A0 ), .A1(B1), .A2(B0));
AND2 \$1I345  (.Z0(\$1N378 ), .A0(\~A1 ), .A1(B1));
OR3 \$1I401  (.Z0(BO), .A0(\$1N376 ), .A1(\$1N402 ), .A2(\$1N378 ));
OR2 \$1I517  (.Z0(Z0), .A0(\$1N328 ), .A1(\$1N327 ));
INV \$1I526  (.ZN0(\~B0 ), .A0(B0));
INV \$1I528  (.ZN0(\~B1 ), .A0(B1));
OR6 \$1I548  (.Z0(Z1), .A0(\$1N441 ), .A1(\$1N564 ), .A2(\$1N451 ), 
	.A3(\$1N577 ), .A4(\$1N579 ), .A5(\$1N581 ));
AND3 \$1I550  (.Z0(\$1N441 ), .A0(\~A1 ), .A1(B1), .A2(A0));
AND3 \$1I551  (.Z0(\$1N564 ), .A0(\~A1 ), .A1(B1), .A2(\~B0 ));
AND3 \$1I560  (.Z0(\$1N451 ), .A0(A1), .A1(\~B1 ), .A2(A0));
AND3 \$1I563  (.Z0(\$1N577 ), .A0(A1), .A1(\~B1 ), .A2(\~B0 ));
AND4 \$1I568  (.Z0(\$1N579 ), .A0(\~A1 ), .A1(\~B1 ), .A2(\~A0 ), 
	.A3(B0));
AND4 \$1I569  (.Z0(\$1N581 ), .A0(A1), .A1(B1), .A2(\~A0 ), 
	.A3(B0));
INV \$1I611  (.ZN0(\~A0 ), .A0(A0));
INV \$1I614  (.ZN0(\~A1 ), .A0(A1));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:14:43 1994
`timescale 10 ps / 10 ps 
module SUBH3(
	Z0, Z1, Z2, BO, 
	A0, A1, A2, B0, 
	B1, B2);

	output Z0;
	output Z1;
	output Z2;
	output BO;
	input A0;
	input A1;
	input A2;
	input B0;
	input B1;
	input B2;

INV \$1I486  (.ZN0(\~B1 ), .A0(B1));
INV \$1I495  (.ZN0(\~A0 ), .A0(A0));
LXOR2 \$1I581  (.Z0(Z1), .A0(A1), .A1(\$1N580 ));
AND3 \$1I582  (.Z0(\$1N576 ), .A0(\~A0 ), .A1(B0), .A2(\~B1 ));
AND4 \$1I601  (.Z0(\$1N639 ), .A0(\~A0 ), .A1(B0), .A2(B1), 
	.A3(B2));
AND3 \$1I606  (.Z0(\$1N637 ), .A0(\~A1 ), .A1(B1), .A2(B2));
AND4 \$1I610  (.Z0(\$1N635 ), .A0(\~A0 ), .A1(\~A2 ), .A2(B0), 
	.A3(B1));
AND2 \$1I615  (.Z0(\$1N633 ), .A0(\~A2 ), .A1(B2));
AND4 \$1I618  (.Z0(\$1N641 ), .A0(\~A0 ), .A1(\~A1 ), .A2(\~A2 ), 
	.A3(B0));
AND3 \$1I623  (.Z0(\$1N643 ), .A0(\~A1 ), .A1(\~A2 ), .A2(B1));
AND4 \$1I627  (.Z0(\$1N645 ), .A0(\~A0 ), .A1(\~A1 ), .A2(B0), 
	.A3(B2));
OR7 \$1I632  (.Z0(BO), .A0(\$1N639 ), .A1(\$1N637 ), .A2(\$1N635 ), 
	.A3(\$1N633 ), .A4(\$1N641 ), .A5(\$1N643 ), .A6(\$1N645 ));
INV \$1I668  (.ZN0(\~B0 ), .A0(B0));
INV \$1I672  (.ZN0(\~A1 ), .A0(A1));
AND2 \$1I677  (.Z0(\$1N575 ), .A0(A0), .A1(B1));
AND2 \$1I678  (.Z0(\$1N574 ), .A0(\~B0 ), .A1(B1));
OR3 \$1I681  (.Z0(\$1N580 ), .A0(\$1N575 ), .A1(\$1N574 ), .A2(\$1N576 ));
INV \$1I710  (.ZN0(\~B2 ), .A0(B2));
XOR2 \$1I723  (.Z0(Z0), .A0(A0), .A1(B0));
INV \$1I786  (.ZN0(\~A2 ), .A0(A2));
LXOR2 \$2I453  (.Z0(Z2), .A0(A2), .A1(\$2N694 ));
AND4 \$2I636  (.Z0(\$2N678 ), .A0(\~A0 ), .A1(B0), .A2(B1), 
	.A3(\~B2 ));
AND3 \$2I641  (.Z0(\$2N676 ), .A0(A1), .A1(\~B1 ), .A2(B2));
AND4 \$2I648  (.Z0(\$2N674 ), .A0(\~A0 ), .A1(\~A1 ), .A2(B0), 
	.A3(\~B2 ));
AND3 \$2I658  (.Z0(\$2N670 ), .A0(\~B0 ), .A1(\~B1 ), .A2(B2));
AND3 \$2I700  (.Z0(\$2N710 ), .A0(A0), .A1(A1), .A2(B2));
AND3 \$2I701  (.Z0(\$2N708 ), .A0(A1), .A1(\~B0 ), .A2(B2));
AND3 \$2I702  (.Z0(\$2N706 ), .A0(\~A1 ), .A1(B1), .A2(\~B2 ));
AND3 \$2I703  (.Z0(\$2N704 ), .A0(A0), .A1(\~B1 ), .A2(B2));
OR8 \$2I712  (.Z0(\$2N694 ), .A0(\$2N710 ), .A1(\$2N708 ), .A2(\$2N706 ), 
	.A3(\$2N704 ), .A4(\$2N678 ), .A5(\$2N676 ), .A6(\$2N674 ), 
	.A7(\$2N670 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:14:47 1994
`timescale 10 ps / 10 ps 
module SUBH4(
	Z0, Z1, Z2, Z3, 
	BO, A0, A1, A2, 
	A3, B0, B1, B2, 
	B3);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output BO;
	input A0;
	input A1;
	input A2;
	input A3;
	input B0;
	input B1;
	input B2;
	input B3;

SUBH2 \$1I1  (.Z0(Z0), .Z1(Z1), .BO(\$1N4 ), .A0(A0), 
	.A1(A1), .B0(B0), .B1(B1));
SUBF2 \$1I2  (.Z0(Z2), .Z1(Z3), .BO(BO), .A0(A2), 
	.A1(A3), .B0(B2), .B1(B3), .BI(\$1N4 ));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:14:54 1994
`timescale 10 ps / 10 ps 
module SUBH8(
	Z0, Z1, Z2, Z3, 
	Z4, Z5, Z6, Z7, 
	BO, A0, A1, A2, 
	A3, A4, A5, A6, 
	A7, B0, B1, B2, 
	B3, B4, B5, B6, 
	B7);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	output BO;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input B0;
	input B1;
	input B2;
	input B3;
	input B4;
	input B5;
	input B6;
	input B7;

XOR2 \$1I164  (.Z0(P7), .A0(A7), .A1(B7));
XOR2 \$1I165  (.Z0(P6), .A0(A6), .A1(B6));
XOR2 \$1I166  (.Z0(P5), .A0(A5), .A1(B5));
XOR2 \$1I167  (.Z0(P4), .A0(A4), .A1(B4));
XOR2 \$1I168  (.Z0(P3), .A0(A3), .A1(B3));
XOR2 \$1I169  (.Z0(P2), .A0(A2), .A1(B2));
XOR2 \$1I170  (.Z0(P1), .A0(A1), .A1(B1));
XOR2 \$1I171  (.Z0(Z0), .A0(A0), .A1(B0));
AND2 \$1I172  (.Z0(G7), .A0(\$1N334 ), .A1(B7));
AND2 \$1I173  (.Z0(G6), .A0(\$1N332 ), .A1(B6));
AND2 \$1I174  (.Z0(G5), .A0(\$1N326 ), .A1(B5));
AND2 \$1I175  (.Z0(G4), .A0(\$1N324 ), .A1(B4));
AND2 \$1I176  (.Z0(G3), .A0(\$1N322 ), .A1(B3));
AND2 \$1I177  (.Z0(G2), .A0(\$1N320 ), .A1(B2));
AND2 \$1I178  (.Z0(G1), .A0(\$1N318 ), .A1(B1));
AND2 \$1I179  (.Z0(\$1N291 ), .A0(\$1N316 ), .A1(B0));
INV \$1I303  (.ZN0(\$1N316 ), .A0(A0));
INV \$1I306  (.ZN0(\$1N318 ), .A0(A1));
INV \$1I307  (.ZN0(\$1N320 ), .A0(A2));
INV \$1I308  (.ZN0(\$1N322 ), .A0(A3));
INV \$1I309  (.ZN0(\$1N324 ), .A0(A4));
INV \$1I310  (.ZN0(\$1N326 ), .A0(A5));
INV \$1I328  (.ZN0(\$1N332 ), .A0(A6));
INV \$1I329  (.ZN0(\$1N334 ), .A0(A7));
LXOR2 \$1I337  (.Z0(Z1), .A0(P1), .A1(\$1N291 ));
AND9 \$2I1  (.Z0(\$2N67 ), .A0(\$2N211 ), .A1(B0), .A2(\$2N209 ), 
	.A3(\$2N47 ), .A4(\$2N43 ), .A5(\$2N38 ), .A6(\$2N32 ), 
	.A7(\$2N25 ), .A8(\$2N16 ));
OR5 \$2I114  (.Z0(\$2N128 ), .A0(\$2N117 ), .A1(\$2N115 ), .A2(\$2N121 ), 
	.A3(\$2N123 ), .A4(G4));
LXOR2 \$2I126  (.Z0(Z5), .A0(\$2N128 ), .A1(P5));
AND7 \$2I13  (.Z0(\$2N65 ), .A0(G1), .A1(\$2N47 ), .A2(\$2N43 ), 
	.A3(\$2N38 ), .A4(\$2N32 ), .A5(\$2N25 ), .A6(\$2N16 ));
OR4 \$2I14  (.Z0(\$2N82 ), .A0(\$2N73 ), .A1(\$2N79 ), .A2(\$2N77 ), 
	.A3(G7));
AND3 \$2I144  (.Z0(\$2N162 ), .A0(\$2N215 ), .A1(B0), .A2(\$2N220 ));
OR2 \$2I146  (.Z0(\$2N153 ), .A0(\$2N162 ), .A1(G1));
LXOR2 \$2I152  (.Z0(Z2), .A0(\$2N153 ), .A1(P2));
OR4 \$2I159  (.Z0(\$2N84 ), .A0(\$2N67 ), .A1(\$2N65 ), .A2(\$2N69 ), 
	.A3(\$2N75 ));
OR3 \$2I168  (.Z0(\$2N172 ), .A0(\$2N179 ), .A1(\$2N166 ), .A2(G2));
AND2 \$2I169  (.Z0(\$2N166 ), .A0(G1), .A1(\$2N174 ));
LXOR2 \$2I170  (.Z0(Z3), .A0(\$2N172 ), .A1(P3));
AND4 \$2I178  (.Z0(\$2N179 ), .A0(\$2N248 ), .A1(B0), .A2(\$2N250 ), 
	.A3(\$2N174 ));
INV \$2I181  (.ZN0(\$2N16 ), .A0(P7));
INV \$2I182  (.ZN0(\$2N25 ), .A0(P6));
INV \$2I183  (.ZN0(\$2N32 ), .A0(P5));
INV \$2I184  (.ZN0(\$2N38 ), .A0(P4));
INV \$2I185  (.ZN0(\$2N43 ), .A0(P3));
INV \$2I186  (.ZN0(\$2N47 ), .A0(P2));
AND6 \$2I2  (.Z0(\$2N69 ), .A0(G2), .A1(\$2N43 ), .A2(\$2N38 ), 
	.A3(\$2N32 ), .A4(\$2N25 ), .A5(\$2N16 ));
INV \$2I202  (.ZN0(\$2N209 ), .A0(P1));
INV \$2I203  (.ZN0(\$2N211 ), .A0(A0));
INV \$2I213  (.ZN0(\$2N215 ), .A0(A0));
INV \$2I218  (.ZN0(\$2N220 ), .A0(P1));
INV \$2I221  (.ZN0(\$2N94 ), .A0(P4));
INV \$2I222  (.ZN0(\$2N99 ), .A0(P3));
INV \$2I223  (.ZN0(\$2N103 ), .A0(P2));
INV \$2I224  (.ZN0(\$2N236 ), .A0(P1));
INV \$2I225  (.ZN0(\$2N234 ), .A0(A0));
INV \$2I241  (.ZN0(\$2N174 ), .A0(P2));
INV \$2I242  (.ZN0(\$2N250 ), .A0(P1));
INV \$2I243  (.ZN0(\$2N248 ), .A0(A0));
AND5 \$2I3  (.Z0(\$2N75 ), .A0(G3), .A1(\$2N38 ), .A2(\$2N32 ), 
	.A3(\$2N25 ), .A4(\$2N16 ));
AND2 \$2I4  (.Z0(\$2N77 ), .A0(G6), .A1(\$2N16 ));
AND3 \$2I5  (.Z0(\$2N79 ), .A0(G5), .A1(\$2N25 ), .A2(\$2N16 ));
AND4 \$2I6  (.Z0(\$2N73 ), .A0(G4), .A1(\$2N32 ), .A2(\$2N25 ), 
	.A3(\$2N16 ));
OR2 \$2I81  (.Z0(BO), .A0(\$2N84 ), .A1(\$2N82 ));
AND6 \$2I90  (.Z0(\$2N117 ), .A0(\$2N234 ), .A1(B0), .A2(\$2N236 ), 
	.A3(\$2N103 ), .A4(\$2N99 ), .A5(\$2N94 ));
AND4 \$2I91  (.Z0(\$2N115 ), .A0(G1), .A1(\$2N103 ), .A2(\$2N99 ), 
	.A3(\$2N94 ));
AND3 \$2I92  (.Z0(\$2N121 ), .A0(G2), .A1(\$2N99 ), .A2(\$2N94 ));
AND2 \$2I93  (.Z0(\$2N123 ), .A0(G3), .A1(\$2N94 ));
AND3 \$3I113  (.Z0(\$3N117 ), .A0(G3), .A1(\$3N132 ), .A2(\$3N134 ));
AND4 \$3I114  (.Z0(\$3N120 ), .A0(G2), .A1(\$3N130 ), .A2(\$3N132 ), 
	.A3(\$3N134 ));
AND5 \$3I115  (.Z0(\$3N111 ), .A0(G1), .A1(\$3N128 ), .A2(\$3N130 ), 
	.A3(\$3N132 ), .A4(\$3N134 ));
AND2 \$3I116  (.Z0(\$3N112 ), .A0(G4), .A1(\$3N134 ));
OR3 \$3I118  (.Z0(\$3N121 ), .A0(\$3N117 ), .A1(\$3N112 ), .A2(G5));
OR3 \$3I119  (.Z0(\$3N122 ), .A0(\$3N137 ), .A1(\$3N111 ), .A2(\$3N120 ));
OR2 \$3I123  (.Z0(\$3N110 ), .A0(\$3N122 ), .A1(\$3N121 ));
LXOR2 \$3I124  (.Z0(Z6), .A0(\$3N110 ), .A1(P6));
AND7 \$3I138  (.Z0(\$3N137 ), .A0(\$3N212 ), .A1(B0), .A2(\$3N210 ), 
	.A3(\$3N128 ), .A4(\$3N130 ), .A5(\$3N132 ), .A6(\$3N134 ));
AND5 \$3I142  (.Z0(\$3N159 ), .A0(\$3N224 ), .A1(B0), .A2(\$3N226 ), 
	.A3(\$3N156 ), .A4(\$3N154 ));
AND3 \$3I145  (.Z0(\$3N143 ), .A0(G1), .A1(\$3N156 ), .A2(\$3N154 ));
AND2 \$3I147  (.Z0(\$3N146 ), .A0(G2), .A1(\$3N154 ));
OR4 \$3I148  (.Z0(\$3N151 ), .A0(\$3N159 ), .A1(\$3N143 ), .A2(\$3N146 ), 
	.A3(G3));
LXOR2 \$3I149  (.Z0(Z4), .A0(\$3N151 ), .A1(P4));
INV \$3I161  (.ZN0(\$3N28 ), .A0(P6));
INV \$3I162  (.ZN0(\$3N26 ), .A0(P5));
INV \$3I163  (.ZN0(\$3N23 ), .A0(P4));
INV \$3I164  (.ZN0(\$3N21 ), .A0(P3));
INV \$3I165  (.ZN0(\$3N185 ), .A0(P1));
INV \$3I166  (.ZN0(\$3N187 ), .A0(A0));
INV \$3I167  (.ZN0(\$3N20 ), .A0(P2));
INV \$3I189  (.ZN0(\$3N128 ), .A0(P2));
INV \$3I190  (.ZN0(\$3N210 ), .A0(P1));
INV \$3I191  (.ZN0(\$3N212 ), .A0(A0));
INV \$3I192  (.ZN0(\$3N130 ), .A0(P3));
INV \$3I193  (.ZN0(\$3N132 ), .A0(P4));
INV \$3I194  (.ZN0(\$3N134 ), .A0(P5));
INV \$3I214  (.ZN0(\$3N156 ), .A0(P2));
INV \$3I215  (.ZN0(\$3N154 ), .A0(P3));
INV \$3I216  (.ZN0(\$3N226 ), .A0(P1));
INV \$3I217  (.ZN0(\$3N224 ), .A0(A0));
OR2 \$3I32  (.Z0(\$3N54 ), .A0(\$3N34 ), .A1(\$3N33 ));
AND2 \$3I87  (.Z0(\$3N53 ), .A0(G5), .A1(\$3N28 ));
AND3 \$3I88  (.Z0(\$3N50 ), .A0(G4), .A1(\$3N26 ), .A2(\$3N28 ));
AND4 \$3I89  (.Z0(\$3N51 ), .A0(G3), .A1(\$3N23 ), .A2(\$3N26 ), 
	.A3(\$3N28 ));
AND5 \$3I90  (.Z0(\$3N48 ), .A0(G2), .A1(\$3N21 ), .A2(\$3N23 ), 
	.A3(\$3N26 ), .A4(\$3N28 ));
AND6 \$3I91  (.Z0(\$3N46 ), .A0(G1), .A1(\$3N20 ), .A2(\$3N21 ), 
	.A3(\$3N23 ), .A4(\$3N26 ), .A5(\$3N28 ));
AND8 \$3I92  (.Z0(\$3N47 ), .A0(\$3N187 ), .A1(B0), .A2(\$3N185 ), 
	.A3(\$3N20 ), .A4(\$3N21 ), .A5(\$3N23 ), .A6(\$3N26 ), 
	.A7(\$3N28 ));
OR4 \$3I94  (.Z0(\$3N34 ), .A0(\$3N47 ), .A1(\$3N46 ), .A2(\$3N48 ), 
	.A3(\$3N51 ));
OR3 \$3I96  (.Z0(\$3N33 ), .A0(\$3N50 ), .A1(\$3N53 ), .A2(G6));
LXOR2 \$3I98  (.Z0(Z7), .A0(\$3N54 ), .A1(P7));
endmodule
// Verilog Netlist created  by a program 
// All Rights reserved.
// Program Author: YLR
// date     : Tue Mar 15 16:15:06 1994
`timescale 10 ps / 10 ps 
module SUBH8A(
	Z0, Z1, Z2, Z3, 
	Z4, Z5, Z6, Z7, 
	BO, A0, A1, A2, 
	A3, A4, A5, A6, 
	A7, B0, B1, B2, 
	B3, B4, B5, B6, 
	B7);

	output Z0;
	output Z1;
	output Z2;
	output Z3;
	output Z4;
	output Z5;
	output Z6;
	output Z7;
	output BO;
	input A0;
	input A1;
	input A2;
	input A3;
	input A4;
	input A5;
	input A6;
	input A7;
	input B0;
	input B1;
	input B2;
	input B3;
	input B4;
	input B5;
	input B6;
	input B7;

PG1 \$1I431  (.PGO1(\$1N421 ), .GI1(G345), .PI1(P345), .PGI1(G012));
F3SUB \$1I440  (.Z0(Z3), .Z1(Z4), .Z2(Z5), .G012(G345), 
	.P012(P345), .A0(A3), .A1(A4), .A2(A5), 
	.B0(B3), .B1(B4), .B2(B5), .BI(G012));
SUBH3 \$1I443  (.Z0(Z0), .Z1(Z1), .Z2(Z2), .BO(G012), 
	.A0(A0), .A1(A1), .A2(A2), .B0(B0), 
	.B1(B1), .B2(B2));
SUBF2 \$1I444  (.Z0(Z6), .Z1(Z7), .BO(BO), .A0(A6), 
	.A1(A7), .B0(B6), .B1(B7), .BI(\$1N421 ));
endmodule
`timescale 10 ps / 10 ps
module TCVRDC(
	A, B, ENA, ENB);


	inout A;
	inout B;
	input ENA;
	input ENB;



IT11 \$1I2  (.O0 (A), .A0 (B), .OE (ENB));
IT11 \$1I1  (.O0 (B), .A0 (A), .OE (ENA));
endmodule
`timescale 10 ps / 10 ps
module TCVRSC(
	A, B, EN);


	inout A;
	inout B;
	input EN;



INV \$1I14  (.ZN0 (\$1N16 ), .A0 (EN));
IT11 \$1I1  (.O0 (B), .A0 (A), .OE (EN));
IT11 \$1I2  (.O0 (A), .A0 (B), .OE (\$1N16 ));
endmodule

`timescale 10 ps / 10 ps

primitive TFF_FD1 (Q, T, CP, R);

  output Q;
  reg    Q;
  input  T, CP, R;

  table
  //  T    CP     R    :    Qt    :    Qt+1
      0   (01)    0    :    ?     :     -;  // clocked data
      1   (01)    0    :    1     :     0;
      1   (01)    0    :    0     :     1;

      1   (01)    x    :    1     :     0;  // pessimism
      0     ?     x    :    0     :     0;  // pessimism

      1     0     x    :    0     :     0;  // pessimism
      1     x   (?x)   :    0     :     0;  // pessimism
      1     1   (?x)   :    0     :     0;  // pessimism

      x     0     x    :    0     :     0;  // pessimism
      x     x   (?x)   :    0     :     0;  // pessimism
      x     1   (?x)   :    0     :     0;  // pessimism

      0   (x1)    0    :    1     :     1;  // reducing pessimism
      0   (x1)    0    :    0     :     0;
      0   (0x)    0    :    1     :     1;
      0   (0x)    0    :    0     :     0;

      ?     ?     1    :    ?     :     0;  // asynchronous clear

      ?   (?0)    ?    :    ?     :     -;  // ignore falling clock
      ?   (1x)    ?    :    ?     :     -;  // ignore falling clock
      *     ?     ?    :    ?     :     -;  // ignore the edges on data
      ?     ?   (?0)   :    ?     :     -;  // ignore the edges on clear
  endtable
endprimitive


`timescale 10 ps / 10 ps

primitive TFF_FD1E (Q, T, CP, EN, R);

  output Q;
  reg    Q;
  input  T, CP, EN, R;

  table
  //  T    CP    EN     R     :    Qt    :    Qt+1
      0   (01)    ?     0     :    ?     :     -;  // clocked data
      1   (01)    1     0     :    1     :     0;
      1   (01)    1     0     :    0     :     1;
      ?     ?     0     0     :    ?     :     -;  // disable

      1   (01)    1     x     :    1     :     0;  // pessimism
      0     ?     ?     x     :    0     :     0;  // pessimism

      1     0     ?     x     :    0     :     0;  // pessimism
      1     x     ?   (?x)    :    0     :     0;  // pessimism
      1     1     ?   (?x)    :    0     :     0;  // pessimism
                              
      x     0     ?     x     :    0     :     0;  // pessimism
      x     x     ?   (?x)    :    0     :     0;  // pessimism
      x     1     ?   (?x)    :    0     :     0;  // pessimism

      0   (x1)    ?     0     :    1     :     1;  // reducing pessimism
      0   (x1)    ?     0     :    0     :     0;
      0   (0x)    ?     0     :    1     :     1;
      0   (0x)    ?     0     :    0     :     0;

      ?     ?     ?     1     :    ?     :     0;  // asynchronous clear

      ?   (?0)    ?     ?     :    ?     :     -;  // ignore falling clock
      ?   (1x)    ?     ?     :    ?     :     -;  // ignore falling clock
      *     ?     ?     ?     :    ?     :     -;  // ignore the edges on data
      ?     ?     ?   (?0)    :    ?     :     -;  // ignore the edges on clear
      ?     ?     *     ?     :    ?     :     -;  // ignore the edges on enable
  endtable
endprimitive


`timescale 10 ps / 10 ps

primitive TFF_FD3 (Q, T, CP, S);

  output Q;
  reg    Q;
  input  T, CP, S;

  table
  //  T    CP     S    :    Qt    :    Qt+1
      0   (01)    0    :    ?     :     -;  // clocked data
      1   (01)    0    :    1     :     0;
      1   (01)    0    :    0     :     1;

      1   (01)    x    :    0     :     1;  // pessimism
      0     ?     x    :    1     :     1;  // pessimism

      1     0     x    :    1     :     1;  // pessimism
      1     x   (?x)   :    1     :     1;  // pessimism
      1     1   (?x)   :    1     :     1;  // pessimism

      x     0     x    :    1     :     1;  // pessimism
      x     x   (?x)   :    1     :     1;  // pessimism
      x     1   (?x)   :    1     :     1;  // pessimism

      0   (x1)    0    :    1     :     1;  // reducing pessimism
      0   (x1)    0    :    0     :     0;
      0   (0x)    0    :    1     :     1;
      0   (0x)    0    :    0     :     0;

      ?     ?     1    :    ?     :     1;  // asynchronous set

      ?   (?0)    ?    :    ?     :     -;  // ignore falling clock
      ?   (1x)    ?    :    ?     :     -;  // ignore falling clock
      *     ?     ?    :    ?     :     -;  // ignore the edges on data
      ?     ?   (?0)   :    ?     :     -;  // ignore the edges on clear
  endtable
endprimitive


`timescale 10 ps / 10 ps

primitive TFF_FD3E (Q, T, CP, EN, S);

  output Q;
  reg    Q;
  input  T, CP, EN, S;

  table
  //  T    CP    EN     S    :    Qt    :    Qt+1
      0   (01)    ?     0    :    ?     :     -;  // clocked data
      1   (01)    1     0    :    1     :     0;
      1   (01)    1     0    :    0     :     1;  
      ?     ?     0     0    :    ?     :     -;  // disable

      1   (01)    1     x    :    0     :     1;  // pessimism
      0     ?     ?     x    :    1     :     1;  // pessimism

      1     0     ?     x    :    1     :     1;  // pessimism
      1     x     ?   (?x)   :    1     :     1;  // pessimism
      1     1     ?   (?x)   :    1     :     1;  // pessimism

      x     0     ?     x    :    1     :     1;  // pessimism
      x     x     ?   (?x)   :    1     :     1;  // pessimism
      x     1     ?   (?x)   :    1     :     1;  // pessimism

      0   (x1)    ?     0    :    1     :     1;  // reducing pessimism
      0   (x1)    ?     0    :    0     :     0;
      0   (0x)    ?     0    :    1     :     1;
      0   (0x)    ?     0    :    0     :     0;

      ?     ?     ?     1    :    ?     :     1;  // asynchronous set

      ?   (?0)    ?     ?    :    ?     :     -;  // ignore falling clock
      ?   (1x)    ?     ?    :    ?     :     -;  // ignore falling clock
      *     ?     ?     ?    :    ?     :     -;  // ignore the edges on data
      ?     ?     ?   (?0)   :    ?     :     -;  // ignore the edges on clear
      ?     ?     *     ?    :    ?     :     -;  // ignore the edges on enable

  endtable

endprimitive

`timescale 10 ps / 10 ps

primitive TFF_FD4 (Q, T, CP, R, S);

  output Q;
  reg    Q;
  input  T, CP, R, S;

  table
  //  T    CP     R     S    :    Qt    :    Qt+1
      0   (01)    0     0    :    ?     :     -;  // clocked data
      1   (01)    0     0    :    1     :     0;
      1   (01)    0     0    :    0     :     1;

      1   (01)    x     0    :    1     :     0;  // pessimism
      0     ?     x     0    :    0     :     0;  // pessimism
      1   (01)    0     x    :    0     :     1;  // pessimism
      0     ?     0     x    :    1     :     1;  // pessimism

      1     0     x     0    :    0     :     0;  // pessimism
      1     x   (?x)    0    :    0     :     0;  // pessimism
      1     1   (?x)    0    :    0     :     0;  // pessimism
      1     0     0     x    :    1     :     1;  // pessimism
      1     x     0   (?x)   :    1     :     1;  // pessimism
      1     1     0   (?x)   :    1     :     1;  // pessimism

      x     0     x     0    :    0     :     0;  // pessimism
      x     x   (?x)    0    :    0     :     0;  // pessimism
      x     1   (?x)    0    :    0     :     0;  // pessimism
      x     0     0     x    :    1     :     1;  // pessimism
      x     x     0   (?x)   :    1     :     1;  // pessimism
      x     1     0   (?x)   :    1     :     1;  // pessimism

      0   (x1)    0     0    :    1     :     1;  // reducing pessimism
      0   (x1)    0     0    :    0     :     0;
      0   (0x)    0     0    :    1     :     1;
      0   (0x)    0     0    :    0     :     0;

      ?     ?     1     ?    :    ?     :     0;  // asynchronous clear cd over set 
      ?     ?     0     1    :    ?     :     1;  // asynchronous set

      ?   (?0)    ?     ?    :    ?     :     -;  // ignore falling clock
      ?   (1x)    ?     ?    :    ?     :     -;  // ignore falling clock
      *     ?     ?     ?    :    ?     :     -;  // ignore the edges on data
      ?     ?   (?0)    ?    :    ?     :     -;  // ignore the edges on clear
      ?     ?     ?   (?0)   :    ?     :     -;  // ignore the edges on set
  endtable
endprimitive


`timescale 10 ps / 10 ps

primitive TFF_FD4E (Q, T, CP, EN, R, S);

  output Q;
  reg    Q;
  input  T, CP, EN, R, S;

  table
  //  T    CP    EN     R     S    :    Qt    :    Qt+1
      0   (01)    ?     0     0    :    ?     :     -;  // clocked data
      1   (01)    1     0     0    :    1     :     0;
      1   (01)    1     0     0    :    0     :     1;
      ?     ?     0     0     0    :    ?     :     -;  // disable

      1   (01)    1     x     0    :    1     :     0;  // pessimism
      0     ?     ?     x     0    :    0     :     0;  // pessimism
      1   (01)    1     0     x    :    0     :     1;  // pessimism
      0     ?     ?     0     x    :    1     :     1;  // pessimism

      1     0     ?     x     0    :    0     :     0;  // pessimism
      1     x     ?   (?x)    0    :    0     :     0;  // pessimism
      1     1     ?   (?x)    0    :    0     :     0;  // pessimism
      1     0     ?     0     x    :    1     :     1;  // pessimism
      1     x     ?     0   (?x)   :    1     :     1;  // pessimism
      1     1     ?     0   (?x)   :    1     :     1;  // pessimism

      x     0     ?     x     0    :    0     :     0;  // pessimism
      x     x     ?   (?x)    0    :    0     :     0;  // pessimism
      x     1     ?   (?x)    0    :    0     :     0;  // pessimism
      x     0     ?     0     x    :    1     :     1;  // pessimism
      x     x     ?     0   (?x)   :    1     :     1;  // pessimism
      x     1     ?     0   (?x)   :    1     :     1;  // pessimism

      0   (x1)    ?     0     0    :    1     :     1;  // reducing pessimism
      0   (x1)    ?     0     0    :    0     :     0;
      0   (0x)    ?     0     0    :    1     :     1;
      0   (0x)    ?     0     0    :    0     :     0;

      ?     ?     ?     1     ?    :    ?     :     0;  // asynchronous clear over set
      ?     ?     ?     0     1    :    ?     :     1;  // asynchronous set

      ?   (?0)    ?     ?     ?    :    ?     :     -;  // ignore falling clock
      ?   (1x)    ?     ?     ?    :    ?     :     -;  // ignore falling clock
      *     ?     ?     ?     ?    :    ?     :     -;  // ignore the edges on data
      ?     ?     ?   (?0)    ?    :    ?     :     -;  // ignore the edges on clear
      ?     ?     ?     ?   (?0)   :    ?     :     -;  // ignore the edges on set
      ?     ?     *     ?     ?    :    ?     :     -;  // ignore the edges on enable
  endtable
endprimitive

/*
* Translated from EDIF description XBIDI1                                     *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 15 0   *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  XBIDI1 lib :  XBIDI1                        *
*/
/*
* Library XBIDI1                                                              *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell XBIDI1"                                                               *
*/
`timescale 10 ps / 10 ps
module XBIDI1 (Z0, XB0, A0, OE);

    input  A0;
    input  OE;

    output  Z0;

    inout  XB0;


    bufif1
        I1  (XB0, A0, OE );
    buf
        I18  (Z0, XB0);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,OE *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule

/**************
*     XDFF1   *
***************/

`timescale 10 ps / 10 ps
module XDFF1 (Q0, D0,CLK);

  input   D0, CLK;
  output  Q0;
  supply1 reset;

 
 DFF_IO U1 (Q0, D0, CLK, reset);



    
endmodule

/**************
*    XDFF1E   *
***************/

`timescale 10 ps / 10 ps
module XDFF1E (Q0, D0, CLK, EN);

  input   D0, CLK, EN;
  output  Q0;
  supply1 reset;

 
 DFF_IO1E U1 (Q0, D0, CLK, EN, reset);



    
endmodule

/**************
*     XDFF2   *
***************/

`timescale 10 ps / 10 ps
module XDFF2 (Q0, D0, CLK, CD);

  input   D0, CLK, CD;
  output  Q0;
  supply1 reset;

 not U0 (t1, CD);  
 and U1 (t2, reset, t1);
 DFF_IO U2 (Q0, D0, CLK, t2);



    
endmodule

/**************
*    XDFF2E   *
***************/

`timescale 10 ps / 10 ps
module XDFF2E (Q0, D0, CLK, EN, CD);

  input   D0, CLK, EN, CD;
  output  Q0;
  supply1 reset;

 not U0 (t1, CD);
 and U1 (t2, reset, t1);
 DFF_IO1E U2 (Q0, D0, CLK, EN, t2);



    
endmodule

/**************
*     XDFF3   *
***************/

`timescale 10 ps / 10 ps
module XDFF3 (Q0, D0, CLK, SD);

  input   D0, CLK, SD;
  output  Q0;
  supply1 reset;

 not U0 (t1, SD);
 and U1 (t2, reset, t1);
 DFF_IO3 U2 (Q0, D0, CLK, t2);



    
endmodule

/**************
*    XDFF3E   *
***************/

`timescale 10 ps / 10 ps
module XDFF3E (Q0, D0, CLK, EN, SD);

  input   D0, CLK, EN, SD;
  output  Q0;
  supply1 reset;

 not U0 (t1, SD);
 and U1 (t2, reset, t1);
 DFF_IO3E U2 (Q0, D0, CLK, EN, t2);



    
endmodule

/**************
*     XDFF4   *
***************/

`timescale 10 ps / 10 ps
module XDFF4 (Q0, D0, CLK, CD, SD);

  input   D0, CLK, CD, SD;
  output  Q0;
  /*************
  supply1 reset;
  *************/

 not U0 (t1, CD);
 not U1 (t2, SD);

 DFF_IO4 U2 (Q0, D0, CLK, t1, t2);



    
endmodule

/**************


*    XDFF4E   *


***************/

`timescale 10 ps / 10 ps

module XDFF4E (Q0, D0, CLK, EN, CD, SD);

  input   D0, CLK, EN, CD, SD;
  output  Q0;

  /*************


  supply1 reset;


  *************/

 not U0 (t1,CD);
 not U1 (t2,SD);
 DFF_IO4E U2 (Q0, D0, CLK, EN, t1, t2);

endmodule

/**************
*     XDL1    *
***************/


`timescale 10 ps / 10 ps
module XDL1 (Q0, D0, G);

  input  D0, G;
  output  Q0;
  supply1 reset;

  D_LATCH  blk1 (Q0, D0, G, reset);


    
endmodule

/**************
*     XDL2    *
***************/


`timescale 10 ps / 10 ps
module XDL2 (Q0, D0, G, CD);

  input  D0, G, CD;
  output  Q0;
  supply1 reset;

  not blk0(t1, CD);
  and blk1(t2, reset, t1);
  D_LATCH  blk2(Q0, D0, G, t2);


    
endmodule

/**************
*     XDL3    *
***************/


`timescale 10 ps / 10 ps
module XDL3 (Q0, D0, G, SD);

  input  D0, G, SD;
  output  Q0;
  supply1 reset;
 
  not blk0(t1, SD);
  and blk1(t2, reset, t1);
  D_LATCH3  blk2(Q0, D0, G, t2);


    
endmodule

/**************
*     XDL4    *
***************/


`timescale 10 ps / 10 ps
module XDL4 (Q0, D0, G, CD, SD);

  input  D0, G, CD, SD;
  output  Q0;
  /*
  supply1 reset;
  */
  not blk0 (t1, CD);
  not blk1 (t2, SD);
  D_LATCH4  blk2(Q0, D0, G, t1, t2);


    
endmodule
/*
* Translated from EDIF description XINPUT                                     *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 15 0   *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  XINPUT lib :  XINPUT                        *
*/
/*
* Library XINPUT                                                              *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell XINPUT"                                                               *
*/
`timescale 10 ps / 10 ps
module XINPUT (Z0, XI0);

    input  XI0;

    output  Z0;



    buf
        I42  (Z0, XI0);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (XI0 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description XINV                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 15 0   *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  XINV lib :  XINV                            *
*/
/*
* Library XINV                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell XINV"                                                                 *
*/
`timescale 10 ps / 10 ps
module XINV (ZN0, A0);

    input  A0;

    output  ZN0;



    not
        I1  (ZN0, A0);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description XNOR2                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 45  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  XNOR2 lib :  XNOR2                          *
*/
/*
* Library XNOR2                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell XNOR2"                                                                *
*/
`timescale 10 ps / 10 ps
module XNOR2 (ZN0, A0, A1);

    input  A0;
    input  A1;

    output  ZN0;



    xnor
        \$1I1  (ZN0, A0, A1);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description XNOR3                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 45  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  XNOR3 lib :  XNOR3                          *
*/
/*
* Library XNOR3                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell XNOR3"                                                                *
*/
`timescale 10 ps / 10 ps
module XNOR3 (ZN0, A0, A1, A2);

    input  A0;
    input  A1;
    input  A2;

    output  ZN0;



    xnor
        \$1I1  (ZN0, A0, A1, A2);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description XNOR4                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 45  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  XNOR4 lib :  XNOR4                          *
*/
/*
* Library XNOR4                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell XNOR4"                                                                *
*/
`timescale 10 ps / 10 ps
module XNOR4 (ZN0, A0, A1, A2, A3);

    input  A0;
    input  A1;
    input  A2;
    input  A3;

    output  ZN0;



    xnor
        \$1I1  (ZN0, A0, A1, A2, A3);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description XNOR7                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 45  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  XNOR7 lib :  XNOR7                          *
*/
/*
* Library XNOR7                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell XNOR7"                                                                *
*/
`timescale 10 ps / 10 ps
module XNOR7 (ZN0, A0, A1, A2, A3, A4, A5, A6);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;

    output  ZN0;



    xor
        \$1I15  (\$1N2 , A0, A1, A2, A3);
    xnor
        \$1I16  (ZN0, \$1N2 , A4, A5, A6);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description XNOR8                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 45  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  XNOR8 lib :  XNOR8                          *
*/
/*
* Library XNOR8                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell XNOR8"                                                                *
*/
`timescale 10 ps / 10 ps
module XNOR8 (ZN0, A0, A1, A2, A3, A4, A5, A6, A7);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;

    output  ZN0;



    xnor
        \$1I1  (ZN0, A0, A1, A2, A3, A4, A5, A6, A7);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description XNOR9                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 45  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  XNOR9 lib :  XNOR9                          *
*/
/*
* Library XNOR9                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell XNOR9"                                                                *
*/
`timescale 10 ps / 10 ps
module XNOR9 (ZN0, A0, A1, A2, A3, A4, A5, A6, A7, A8);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;

    output  ZN0;



    XOR8
        \$1I1  (\$1N2 , A0, A1, A2, A3, A4, A5, A6, A7);
    XNOR2
        \$1I3  (ZN0, \$1N2 , A8);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8 *> 
    ZN0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description XOR2                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 45  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  XOR2 lib :  XOR2                            *
*/
/*
* Library XOR2                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell XOR2"                                                                 *
*/
`timescale 10 ps / 10 ps
module XOR2 (Z0, A0, A1);

    input  A0;
    input  A1;

    output  Z0;



    xor
        \$1I1  (Z0, A0, A1);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description XOR3                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 45  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  XOR3 lib :  XOR3                            *
*/
/*
* Library XOR3                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell XOR3"                                                                 *
*/
`timescale 10 ps / 10 ps
module XOR3 (Z0, A0, A1, A2);

    input  A0;
    input  A1;
    input  A2;

    output  Z0;



    xor
        \$1I1  (Z0, A0, A1, A2);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description XOR4                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 45  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  XOR4 lib :  XOR4                            *
*/
/*
* Library XOR4                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell XOR4"                                                                 *
*/
`timescale 10 ps / 10 ps
module XOR4 (Z0, A0, A1, A2, A3);

    input  A0;
    input  A1;
    input  A2;
    input  A3;

    output  Z0;



    xor
        \$1I1  (Z0, A0, A1, A2, A3);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description XOR8                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 45  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  XOR8 lib :  XOR8                            *
*/
/*
* Library XOR8                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell XOR8"                                                                 *
*/
`timescale 10 ps / 10 ps
module XOR8 (Z0, A0, A1, A2, A3, A4, A5, A6, A7);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;

    output  Z0;



    xor
        \$1I1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description XOR9                                       *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 11 45  *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  XOR9 lib :  XOR9                            *
*/
/*
* Library XOR9                                                                *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell XOR9"                                                                 *
*/
`timescale 10 ps / 10 ps
module XOR9 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;

    output  Z0;



    XOR8
        \$1I1  (\$1N2 , A0, A1, A2, A3, A4, A5, A6, A7);
    XOR2
        \$1I3  (Z0, \$1N2 , A8);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,A1,A2,A3,A4,A5,A6,A7,A8 *> 
    Z0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description XOUTPUT                                    *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 15 0   *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  XOUTPUT lib :  XOUTPUT                      *
*/
/*
* Library XOUTPUT                                                             *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell XOUTPUT"                                                              *
*/
`timescale 10 ps / 10 ps
module XOUTPUT (XO0, A0);

    input  A0;

    output  XO0;



    buf
        I42  (XO0, A0);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0 *> 
    XO0)
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
/*
* Translated from EDIF description XTRI1                                      *
* EDIF version 2 0 0                                                          *
* EDIF level 0                                                                *
* EDIF  source  last  modified on (yy mm dd hour min sec) :  1993 6 28 15 0   *
* EDIF description generated by program : VIEWlogic's edifnet                 *
* Top level design : ROOT cell :  XTRI1 lib :  XTRI1                          *
*/
/*
* Library XTRI1                                                               *
* EDIF level 0                                                                *
* EDIF capacitance unit set to 1.000000e-06  capacitance units                *
* EDIF capacitance values scaled by 1.000000e-06.                             *
*/
/*
* "Cell XTRI1"                                                                *
*/
`timescale 10 ps / 10 ps
module XTRI1 (XO0, A0, OE);

    input  A0;
    input  OE;


    output  XO0;


    bufif1
        I1  (XO0, A0, OE);


`ifdef LOGIC_DELAY
specify
    //module path declarations
    (A0,OE *> 
    )
= (1:1:1,   /* min:nom:max Low to High */
   1:1:1);   /* min:nom:max High to Low */
endspecify
`endif
endmodule
