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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/FL1S1D.v,v 1.10 2005/05/19 18:30:03 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module FL1S1D (D0, D1, CK, SD, CD, Q, QN);
  parameter DISABLED_GSR = 0;
  input  D0, D1, CK, SD, CD;
  output Q, QN;
  reg SRN;
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

  always @ (GSR or PUR ) begin
    if (DISABLED_GSR == 0) begin
      SRN = GSR & PUR ;
    end
    else if (DISABLED_GSR == 1)
      SRN = PUR;
  end

  not (SR1, SRN);
  or INST1 (SR, CDI, SR1);
  not(QN,Q);
  buf INST997 (CDI, CD);
  or INST34 (I31, I38, I40);
  and INST35 (I38, D0I, I43);
  buf INST981 (D0I, D0);
  and INST36 (I40, SDI, D1I);
  buf INST980 (SDI, SD);
  buf INST982 (D1I, D1);
  not INST37 (I43, SDI);

  UDFDL1_UDP_X INST6 (Q, SR, I31, CK, notifier);


endmodule

`endcelldefine
