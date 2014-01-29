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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/OFS1P3DX.v,v 1.3 2005/05/19 19:02:02 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module OFS1P3DX (D, SP, SCLK, CD, Q);
  parameter DISABLED_GSR = 0;
  defparam g.DISABLED_GSR = DISABLED_GSR;
  input  D, SP, SCLK, CD;
  output Q;
  wire QB;
  reg  QR;

  reg notifier; 

  tri1 GSR = GSR_INST.GSRNET;
  tri1 PUR = PUR_INST.PURNET;

  OFS1P3DX_GSR  g (.D(D), .SP(SP), .SCLK(SCLK), .CD(CD), .GSR(GSR), .PUR(PUR), .Q(QB)); 

  not(QN,Q);

  always @ QB
  begin
      QR <= QB;
  end

  buf (Q, QR);

endmodule

`endcelldefine
