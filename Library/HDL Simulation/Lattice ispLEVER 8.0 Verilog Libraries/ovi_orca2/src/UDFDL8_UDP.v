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
// Simulation Library File for ORCA2
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/UDFDL8_UDP.v,v 1.2 2005/05/19 18:06:36 pradeep Exp $ 
//
// User Defined Primitive for 
// Negative-Edge Triggered Flipflop w/Positive-Asynchronous Preset

`resetall
`timescale 1 ns / 100 ps
primitive UDFDL8_UDP ( Q, D, CK, PRE);
input D, CK, PRE;
output Q ;
reg Q ;
	table
	//           P    :     :     
	//      C    R    :  P  :  N  
	// D    K    E    :  S  :  S  

	   0    (10) 0    :  ?  :  0  ; // active edge
	   1    (10) 0    :  ?  :  1  ;

	   ?    (?1) 0    :  ?  :  -  ; // clock unknown
	   0    (x0) 0    :  0  :  0  ;
	   1    (x0) 0    :  1  :  1  ;
	   ?    (0x) 0    :  ?  :  -  ;
	   0    (1x) 0    :  1  :  x  ;
	   1    (1x) 0    :  0  :  x  ;
	   1    (1x) 0    :  1  :  1  ;
	   0    (1x) 0    :  0  :  0  ;

	   *    ?    0    :  ?  :  -  ; // data changing, clock stable

	   ?    ?    1    :  ?  :  1  ; // aserting preset

	   ?    ?    (?0) :  ?  :  -  ; // removing preset

	   ?    ?    (?x) :  1  :  1  ; // preset unknown
	   ?    ?    (?x) :  0  :  x  ;
	   *    ?    x    :  1  :  1  ;
	   ?    *    x    :  1  :  1  ;
	   *    ?    x    :  0  :  x  ;
	   ?    *    x    :  0  :  x  ;

	// else the latch goes unknown
	endtable
endprimitive
