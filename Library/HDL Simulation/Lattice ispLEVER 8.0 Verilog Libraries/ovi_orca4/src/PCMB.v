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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/PCMB.v,v 1.4 2005/05/19 19:02:08 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

module PCMB (CLKIN, FB, WE, RE, A2, A1, A0, 
	     DI7, DI6, DI5, DI4, DI3, DI2, DI1, DI0, 
	     DO7, DO6, DO5, DO4, DO3, DO2, DO1, DO0, 
	     ECLK, SCLK, LOCK
	     );

   parameter PCM="PCMBUF", FREQUENCY=10.0, DUTY=50.0,
	     PDELAY=16, DIV0=0, DIV1=0, DIV2=0, DISABLED_GSR=0, 
	     DISABLED_DONE=1, PWRON=1, FBDELAY=0.0;
   
   output    DO7, DO6, DO5, DO4, DO3, DO2, DO1, DO0;
   output    ECLK, SCLK, LOCK;

   input     CLKIN, FB, WE, RE, A2, A1, A0;
   input     DI7, DI6, DI5, DI4, DI3, DI2, DI1, DI0;

   wire      CLKIN, FB, WE, RE, A2, A1, A0;
   wire      DI7, DI6, DI5, DI4, DI3, DI2, DI1, DI0;
   wire      DO7, DO6, DO5, DO4, DO3, DO2, DO1, DO0;
   wire      ECLK, SCLK, LOCK;

   wire [7:0] DIbus, DObus;
   wire [2:0] Abus;
   wire DO0b, DO1b, DO2b, DO3b, DO4b, DO5b, DO6b, DO7b;

   assign     DIbus = {DI7, DI6, DI5, DI4, DI3, DI2, DI1, DI0};
   assign     Abus  = {A2, A1, A0};
   assign     DO0b   = DObus[0];
   assign     DO1b   = DObus[1];
   assign     DO2b   = DObus[2];
   assign     DO3b   = DObus[3];
   assign     DO4b   = DObus[4];
   assign     DO5b   = DObus[5];
   assign     DO6b   = DObus[6];
   assign     DO7b   = DObus[7];

  buf (DO0, DO0b);
  buf (DO1, DO1b);
  buf (DO2, DO2b);
  buf (DO3, DO3b);
  buf (DO4, DO4b);
  buf (DO5, DO5b);
  buf (DO6, DO6b);
  buf (DO7, DO7b);

  tri1 GSR = GSR_INST.GSRNET;
  tri1 PUR = PUR_INST.PURNET;

   PCM U1 (.CLKIN(CLKIN), .FB(FB), .WE(WE), .RE(RE), .A(Abus),
	   .GSR(GSR), .PUR(PUR),
           .DI(DIbus), .DO(DObus),
	   .ECLK(ECLK), .SCLK(SCLK), .LOCK(LOCK)
	   );
   defparam  U1.PCM=PCM;
   defparam  U1.FREQUENCY=FREQUENCY;
   defparam  U1.DUTY=DUTY;
   defparam  U1.PDELAY=PDELAY;
   defparam  U1.DIV0=DIV0;
   defparam  U1.DIV1=DIV1;
   defparam  U1.DIV2=DIV2;
   defparam  U1.DISABLED_GSR=DISABLED_GSR;
   defparam  U1.DISABLED_DONE=DISABLED_DONE;
   defparam  U1.PWRON=PWRON;
   defparam  U1.FBDELAY=FBDELAY;


endmodule
