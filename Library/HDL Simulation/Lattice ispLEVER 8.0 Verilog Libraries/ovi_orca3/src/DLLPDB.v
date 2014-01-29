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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/DLLPDB.v,v 1.14 2005/05/19 18:29:37 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module DLLPDB (CLKIN, ECLK, SCLK, LOCK);

   // The delay tap number PDELAY is passed as an integer.  The value must 
   // be less than or equal to 30.  The DIV0 and DIV2 values are also integers
   // that must be less than or equal to 8.  The frequency of SCLK is equal to the
   // frequency of CLKIN divided by DIV0. There is a phase shift with respect to 
   // CLKIN based on the value of PDELAY/32nds of the divided cycle.  The frequency
   // of ECLK is SCLK divided by DIV2.

   parameter PDELAY=1, DIV0=1, DIV2=1, DISABLED_GSR=0;

   input     CLKIN;
   output    ECLK, SCLK, LOCK;

   wire      CLKIN;
   wire      ECLK, SCLK, LOCK;

   `ifdef GSR_SIGNAL
   wire       GSR = `GSR_SIGNAL; // continuous assignment
   `else
   pullup (weak1) (GSR);
   `endif

   `ifdef PUR_SIGNAL
   wire       PUR = `PUR_SIGNAL; // continuous assignment
   `else
   pullup (weak1) (PUR);
   `endif

   DLLPD  U1  (.CLKIN(CLKIN), .ECLK(ECLK), .SCLK(SCLK),
	       .GSR(GSR), .PUR(PUR),
	       .LOCK(LOCK) );
   // The delay pin and div2 are passed to the DLLPD.
   defparam  U1.PDELAY=PDELAY;
   defparam  U1.DIV0=DIV0;
   defparam  U1.DIV2=DIV2;
   defparam  U1.DISABLED_GSR=DISABLED_GSR;


endmodule

`endcelldefine
