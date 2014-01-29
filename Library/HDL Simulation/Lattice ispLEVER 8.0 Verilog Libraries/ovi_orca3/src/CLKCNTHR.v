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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/CLKCNTHR.v,v 1.6 2005/05/19 18:29:29 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module CLKCNTHR (CLKIN, SHUTOFF, CLKOUT);
  input  CLKIN, SHUTOFF;
  output CLKOUT;

 `ifdef PUR_SIGNAL
  wire PUR = `PUR_SIGNAL;
 `else
  pullup (weak1) (PUR);
 `endif

CLKCNTHR_PUR  g (.CLKIN(CLKINb), .SHUTOFF(SHUTOFFb), .PUR(PUR), .CLKOUT(CLKOUTb)); 

   buf  (CLKINb, CLKIN);
   buf  (SHUTOFFb, SHUTOFF);
   buf  (CLKOUT, CLKOUTb);


endmodule
