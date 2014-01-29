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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/UDFDL5_UDP_X.v,v 1.2 2005/05/19 19:02:19 pradeep Exp $ 
//
// User Defined Primitive for 
// Positive-Edge Triggered Flipflop w/Positive-Asynchronous Global Clear

`resetall
`timescale 1 ns / 100 ps
primitive UDFDL5_UDP_X ( Q, D, CK, CLR, notifier);
input D, CK, CLR, notifier;
output Q ;
reg Q ;
initial Q=1'b0;
	table
	//           C    N :     :     
	//      C    L    O :  P  :  N  
	// D    K    R    T :  S  :  S  

	   ?    ?    ?    * :  ?  :  x  ;
	   0    (01) 0    ? :  ?  :  0  ; // active edge
	   1    (01) 0    ? :  ?  :  1  ;

	   ?    (?0) 0    ? :  ?  :  -  ; // clock unknown
	   0    (x1) 0    ? :  0  :  0  ;
	   1    (x1) 0    ? :  1  :  1  ;
	   ?    (1x) 0    ? :  ?  :  -  ;
	   0    (0x) 0    ? :  1  :  x  ;
	   1    (0x) 0    ? :  0  :  x  ;
	   1    (0x) 0    ? :  1  :  1  ;
	   0    (0x) 0    ? :  0  :  0  ;

	   *    ?    0    ? :  ?  :  -  ; // data changing, clock stable

	   ?    ?    1    ? :  ?  :  0  ; // aserting clear

	   ?    ?    (?0) ? :  ?  :  -  ; // removing clear

	   ?    ?    (?x) ? :  0  :  0  ; // clear unknown
	   ?    ?    (?x) ? :  1  :  x  ;
	   *    ?    x    ? :  0  :  0  ;
	   ?    *    x    ? :  0  :  0  ;
	   *    ?    x    ? :  1  :  x  ;
	   ?    *    x    ? :  1  :  x  ;

	// else the latch goes unknown
	endtable
endprimitive
