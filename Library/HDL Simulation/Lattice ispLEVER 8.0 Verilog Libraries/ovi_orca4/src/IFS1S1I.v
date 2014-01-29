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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/IFS1S1I.v,v 1.5 2005/05/19 19:01:34 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module IFS1S1I (D, SCLK, CD, Q);
  parameter DISABLED_GSR = 0;
  input  D, SCLK, CD;
  output Q;
  reg SRN, QR;
  reg notifier; 
  wire QB;

  tri1 GSR = GSR_INST.GSRNET;
  tri1 PUR = PUR_INST.PURNET;


  not(QN,QB);

  always @ (GSR or PUR ) begin
    if (DISABLED_GSR == 0) begin
      SRN = GSR & PUR ;
    end
    else if (DISABLED_GSR == 1)
      SRN = PUR;
  end

  not (SR, SRN);
  not INST60 (I53, CD);
  and INST55 (I54, D, I53);

  UDFDL1_UDP_X INST6 (QB, SR, I54, SCLK, notifier);

  always @ QB
  begin
      QR <= QB;
  end

  buf (Q, QR);

endmodule
