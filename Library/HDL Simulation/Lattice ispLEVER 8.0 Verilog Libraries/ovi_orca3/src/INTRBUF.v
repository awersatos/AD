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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/INTRBUF.v,v 1.4 2005/05/19 18:30:19 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module INTRBUF (ASBI, TOASB, TOASBM1, TOASBM2, TOASBM3, 
                FRASB, ASBO, ASBM1O, ASBM2O, ASBM3O);
  input  ASBI, TOASB, TOASBM1, TOASBM2, TOASBM3;
  output FRASB, ASBO, ASBM1O, ASBM2O, ASBM3O;

  buf INST1 (FRASB, ASBI);
  buf INST2 (ASBO, TOASB);
  buf INST3 (ASBM1O, TOASBM1);
  buf INST4 (ASBM2O, TOASBM2);
  buf INST5 (ASBM3O, TOASBM3);


endmodule

`endcelldefine
