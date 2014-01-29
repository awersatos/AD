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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/UJKFF2.v,v 1.2 2005/05/19 18:06:37 pradeep Exp $ 
//
`timescale 1 ns / 100 ps
macromodule UJKFF2 ( J, K, CK, PRE, Q, QN );
input J, K, CK, PRE;
output Q, QN ;
  buf #0.1 (J_,J);
  buf #0.1 (K_,K);
  buf #0.1 (CK_,CK);
  buf #0.1 (PRE_,PRE);
  UJKFF2_UDP (Q_,J_,K_,CK_,PRE_);
  buf (Q, Q_);
  not (QN, Q_);
endmodule
