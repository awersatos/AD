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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/BMW6.v,v 1.5 2005/05/19 19:00:45 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module BMW6 (I, T, O, B);
  input  I, T;
  output O;
  inout  B;

  reg B_TMP;

  tri1 TSALL = TSALL_INST.TSALLNET;

  not INST0 (TN, T);
  and INST1 (ENH, TN, TSALL);

  buf INST10 (O, B);
  bufif1 INST14 (B, I, ENH);

  buf (weak1, weak0) OUT1 (B, B_TMP);

  always @(B)
  begin
     begin
        if (B == 1'b1)
           B_TMP = 1;
        else if (B == 1'b0)
           B_TMP = 0;
     end
  end



endmodule 

`endcelldefine
