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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/CFD1P3BX.v,v 1.3 2005/05/19 19:00:59 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 10 ps

`celldefine

module CFD1P3BX (D, SP, CK, PD, Q);
  parameter DISABLED_GSR = 0;
  defparam g.DISABLED_GSR = DISABLED_GSR;
  input  D, SP, CK ,PD;
  output Q;

  reg notifier; 

  tri1 GSR = GSR_INST.GSRNET;
  tri1 PUR = PUR_INST.PURNET;

  CFD1P3BX_GSR  g (.D(D), .SP(SP), .CK(CK), .PD(PD), .GSR(GSR), .PUR(PUR), .Q(Q)); 

  not(QN,Q);

endmodule

`endcelldefine
