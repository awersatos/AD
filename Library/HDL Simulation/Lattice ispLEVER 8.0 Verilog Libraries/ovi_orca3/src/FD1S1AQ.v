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
// Simulation Library File for ORCA3
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/FD1S1AQ.v,v 1.4 2005/05/19 18:29:47 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module FD1S1AQ (D, CK, Q);
  input D, CK;
  output Q;
  reg VT;
	// core logic
	LP0_UDP	 U	(QUDP, D, CK, VT);
	buf		(Q, QUDP);
 
endmodule

`endcelldefine
