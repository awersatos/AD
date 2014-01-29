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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/UDFDL6.v,v 1.2 2005/05/19 18:06:35 pradeep Exp $ 
//
`timescale 1 ns / 100 ps
macromodule UDFDL6 ( D, CK, CLR, Q, QN );
input D, CK, CLR;
output Q, QN ;
  buf #0.1 (CLR_,CLR);
  buf #0.1 (D_,D);
  buf #0.1 (CK_,CK);
  UDFDL6_UDP (Q_,D_,CK_,CLR_);
  buf (Q, Q_);
  not (QN, Q_);
endmodule
