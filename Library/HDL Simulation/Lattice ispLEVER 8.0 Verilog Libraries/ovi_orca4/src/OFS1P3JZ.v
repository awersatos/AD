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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/OFS1P3JZ.v,v 1.5 2005/05/19 19:02:03 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module OFS1P3JZ (D, SP, SCLK, PD, Q);
  parameter DISABLED_GSR = 0;
  input  D, SP, SCLK, PD;
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
  or INST33 (I50, I36, I73);
  and INST34 (I36, QB, I54);
  and INST35 (I73, SP, I68);
  not INST52 (I54, SP);
  not(QN,Q);
  or INST67 (I68, D, PD);

  UDFDL7_UDP_X INST6 (QB, I50, SCLK, SR, notifier);

  always @ QB
  begin
      QR <= QB;
  end

  buf (Q, QR);

endmodule

`endcelldefine
