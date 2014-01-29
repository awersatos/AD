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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/FL1P3IZ.v,v 1.5 2005/05/19 19:01:22 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module FL1P3IZ (D0, D1, SP, CK, SD, CD, Q, QN);
  parameter DISABLED_GSR = 0;
  input  D0, D1, SP, CK, SD, CD;
  output Q, QN;
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
  not(QN,QR);
  or INST25 (DATAIN, I39, I40);
  and INST23 (I39, D0, I43);
  and INST24 (I40, SD, D1);
  not INST22 (I43, SD);
  or INST33 (I50, I36, I38);
  and INST34 (I36, QB, I54);
  and INST35 (I38, SP, I65, DATAIN);
  not INST52 (I54, SP);
  not INST57 (I65, CD);

  UDFDL5_UDP_X INST6 (QB, I50, CK, SR, notifier);

  always @ QB
  begin
      QR <= QB;
  end

  buf (Q, QR);

endmodule

`endcelldefine
