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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/FL1P3JZ_FUNC.v,v 1.3 2005/05/19 19:01:23 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module FL1P3JZ_FUNC (D0, D1, SP, CK, SD, PD, SR, notifier, Q);
input  D0, D1, SP, CK, SD, PD, SR, notifier;
output Q;

or INST25 (DATAIN, I38, I40);
and INST23 (I38, D0, I43);
and INST24 (I40, SD, D1);
not INST26 (I43, SD);
or INST33 (I50, I36, I73);
and INST34 (I36, Q, I54);
and INST35 (I73, SP, I68);
not INST52 (I54, SP);
UDFDL7_UDP_X INST6 (Q, I50, CK, I29, notifier);
or INST67 (I68, DATAIN, PD);
not INST76 (I29, SR);

//xor (D_XOR_Q, D, Q);
//not (BPD,PD);
//not (BD,D);
//and (GSR_BPD_SP,GSR,BPD,SP);
//and (GSR_BD_SP,GSR,BD);
//and (GSR_D_XOR_Q,GSR,D_XOR_Q);


endmodule

`endcelldefine
