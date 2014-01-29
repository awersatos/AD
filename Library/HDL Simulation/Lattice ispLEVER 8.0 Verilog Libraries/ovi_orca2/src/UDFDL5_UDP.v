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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/UDFDL5_UDP.v,v 1.3 2005/05/19 18:06:34 pradeep Exp $ 
//
// User Defined Primitive for 
// Positive-Edge Triggered Flipflop w/Positive-Asynchronous Clear

`resetall
`timescale 1 ns / 100 ps
primitive UDFDL5_UDP ( Q, D, CK, CLR);
input D, CK, CLR;
output Q ;
reg Q ;
initial Q=1'b0;
	table
	//           C    :     :     
	//      C    L    :  P  :  N  
	// D    K    R    :  S  :  S  

	   0    (01) 0    :  ?  :  0  ; // active edge
	   1    (01) 0    :  ?  :  1  ;

	   ?    (?0) 0    :  ?  :  -  ; // clock unknown
	   0    (x1) 0    :  0  :  0  ;
	   1    (x1) 0    :  1  :  1  ;
	   ?    (1x) 0    :  ?  :  -  ;
	   0    (0x) 0    :  1  :  x  ;
	   1    (0x) 0    :  0  :  x  ;
	   1    (0x) 0    :  1  :  1  ;
	   0    (0x) 0    :  0  :  0  ;

	   *    ?    0    :  ?  :  -  ; // data changing, clock stable

	   ?    ?    1    :  ?  :  0  ; // aserting clear

	   ?    ?    (?0) :  ?  :  -  ; // removing clear

	   ?    ?    (?x) :  0  :  0  ; // clear unknown
	   ?    ?    (?x) :  1  :  x  ;
	   *    ?    x    :  0  :  0  ;
	   ?    *    x    :  0  :  0  ;
	   *    ?    x    :  1  :  x  ;
	   ?    *    x    :  1  :  x  ;

	// else the latch goes unknown
	endtable
endprimitive
