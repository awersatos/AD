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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/IFS1S1J.v,v 1.5 2005/05/19 19:01:35 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module IFS1S1J (D, SCLK, PD, Q);
  parameter DISABLED_GSR = 0;
  input  D, SCLK, PD;
  output Q;
  reg SRN, QR;
  reg notifier; 
  wire QB;

  tri1 GSR = GSR_INST.GSRNET;
  tri1 PUR = PUR_INST.PURNET;

  always @ (GSR or PUR ) begin
    if (DISABLED_GSR == 0) begin
      SRN = GSR & PUR ;
    end
    else if (DISABLED_GSR == 1)
      SRN = PUR;
  end

  not (SR, SRN);
  or INST67 (I70, D, PD);
  not(QN,QB);

  UDFDL3_UDP_X INST6 (QB, SR, I70, SCLK, notifier);

  always @ QB
  begin
      QR <= QB;
  end

  buf (Q, QR);

endmodule
