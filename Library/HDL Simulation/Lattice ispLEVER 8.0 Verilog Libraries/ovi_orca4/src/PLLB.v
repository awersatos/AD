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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/PLLB.v,v 1.4 2005/05/19 19:02:10 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module PLLB (CLKIN, FB, ECLK, SCLK, LOCK);
   parameter DIV0 = 1, DIV1 = 1, DIV2 = 1, 
	     FBDELAY = 0.0, DISABLED_GSR=0;

   input     CLKIN, FB;
   output    ECLK, SCLK, LOCK;

   wire      CLKIN, FB;
   wire      ECLK, SCLK, LOCK;

  tri1 GSR = GSR_INST.GSRNET;
  tri1 PUR = PUR_INST.PURNET;

   PLL   U1  (.CLKIN(CLKIN), .FB(FB),
	      .GSR(GSR), .PUR(PUR),
	      .ECLK(ECLK), .SCLK(SCLK), .LOCK(LOCK) );
   // The DIV values that determine the frequency of the ouptuts
   // are passed to the PLL as div values.
   defparam  U1.DIV0=DIV0;
   defparam  U1.DIV1=DIV1;
   defparam  U1.DIV2=DIV2;
   defparam  U1.FBDELAY=FBDELAY;
   defparam  U1.DISABLED_GSR=DISABLED_GSR;
   

endmodule

`endcelldefine
