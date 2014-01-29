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
// Simulation Library File for XO
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mj/RCS/OBW.v,v 1.4 2005/05/19 20:01:22 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module OBW (I, T, O);
  input  I, T;
  output O;

  reg O_TMP;

  tri0 TSALL = TSALL_INST.TSALLNET;

  not INST1 (TSALL_N, TSALL);
  not INST0 (TO, T);
  and INST2 (T_AND, TO, TSALL_N);
  bufif1 INST5 (O, I, T_AND);

  buf (weak1, weak0) OUT1 (O, O_TMP);

  always @(O)
  begin
     begin
        if (O == 1'b1)
           O_TMP = 1;
        else if (O == 1'b0)
           O_TMP = 0;
     end
  end
 

endmodule 

`endcelldefine
