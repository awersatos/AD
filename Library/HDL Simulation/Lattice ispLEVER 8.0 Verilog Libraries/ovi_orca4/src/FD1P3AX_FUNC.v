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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/FD1P3AX_FUNC.v,v 1.3 2005/05/19 19:01:11 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module FD1P3AX_FUNC ( D, SP, CK, SR, Q);
input D, SP, CK, SR;
output Q;
reg notifier;
  buf  (CLR_,I29);
  buf  (D_,I50);
  buf  (CK_,CK);
  buf (Q, Q_);
  not (QN, Q_);

or INST33 (I50, I36, I38);
and INST34 (I36, Q, I54);
and INST35 (I38, SP, D);
not INST52 (I54, SP);
not INST58 (I29, SR);
UDFDL5_UDP_X (Q_,D_,CK_,CLR_,notifier);


endmodule

`endcelldefine
