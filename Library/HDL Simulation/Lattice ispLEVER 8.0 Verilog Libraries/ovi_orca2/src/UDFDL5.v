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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/UDFDL5.v,v 1.3 2005/05/19 18:06:34 pradeep Exp $ 
//
`timescale 1 ns / 100 ps
macromodule UDFDL5 ( D, CK, CLR, Q, QN );
input D, CK, CLR;
output Q, QN ;
  buf  (CLR_,CLR);
  buf  (D_,D);
  buf  (CK_,CK);
  UDFDL5_UDP (Q,D_,CK_,CLR_);
  not (QN, Q);
endmodule
