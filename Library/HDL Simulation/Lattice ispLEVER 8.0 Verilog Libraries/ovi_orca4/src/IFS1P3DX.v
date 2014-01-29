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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/IFS1P3DX.v,v 1.5 2005/05/19 19:01:33 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module IFS1P3DX (D, SP, SCLK, CD, Q);
  parameter DISABLED_GSR = 0;
  defparam g.DISABLED_GSR = DISABLED_GSR;
  input  D, SP, SCLK, CD;
  output Q;
  reg SRN;
  wire QB;
  reg  QR;

  reg notifier; 

  tri1 GSR = GSR_INST.GSRNET;
  tri1 PUR = PUR_INST.PURNET;

  IFS1P3DX_GSR  g (.D(D), .SP(SP), .SCLK(SCLK), .CD(CD), .GSR(GSR), .PUR(PUR), .Q(QB)); 

  not(QN,Q);

  always @ (GSR or PUR ) begin
    if (DISABLED_GSR == 0) begin
      SRN = GSR & PUR ;
    end
    else if (DISABLED_GSR == 1)
      SRN = PUR;
  end

  not (SR1, SRN);
  or INST1 (SR, CD, SR1);

  always @ QB
  begin
      QR <= QB;
  end

  buf (Q, QR);

endmodule

`endcelldefine
