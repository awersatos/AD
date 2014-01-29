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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/CFD1P3IZ.v,v 1.6 2005/05/19 18:29:27 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module CFD1P3IZ (D, SP, CK, CD, Q);
  parameter DISABLED_GSR = 0;
  defparam g.DISABLED_GSR = DISABLED_GSR;
  input  D, SP, CK, CD;
  output Q;

  reg notifier; 

  `ifdef GSR_SIGNAL
  wire GSR = `GSR_SIGNAL;
  `else
  pullup (weak1) (GSR);
  `endif

 `ifdef PUR_SIGNAL
  wire PUR = `PUR_SIGNAL;
 `else
  pullup (weak1) (PUR);
 `endif

  CFD1P3IZ_GSR  g (.D(D), .SP(SP), .CK(CK), .CD(CD), .GSR(GSR), .PUR(PUR), .Q(Q)); 

  not(QN,Q);

endmodule

`endcelldefine
