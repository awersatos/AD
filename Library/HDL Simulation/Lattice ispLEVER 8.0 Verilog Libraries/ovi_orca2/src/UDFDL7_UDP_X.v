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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/UDFDL7_UDP_X.v,v 1.3 2005/05/19 18:06:36 pradeep Exp $ 
//
// User Defined Primitive for 
// Positive-Edge Triggered Flipflop w/Positive-Asynchronous Preset

`resetall
`timescale 1 ns / 100 ps
primitive UDFDL7_UDP_X ( Q, D, CK, PRE, notifier); 
input D, CK, PRE, notifier; 
output Q ;
reg Q ;
initial Q=1'b1;
	table
	//           P     ? :       :       
	//      C    R     ? :   P   :   N   
	// D    K    E     ? :   S   :   S   

	   0    (01) 0     ? :   ?   :   0  ; // active edge 
	   1    (01) 0     ? :   ?   :   1  ; 

	   ?    (?0) 0     ? :   ?   :   -  ; // clock unknown 
	   0    (x1) 0     ? :   0   :   0  ; 
	   1    (x1) 0     ? :   1   :   1  ; 
	   ?    (1x) 0     ? :   ?   :   -  ; 
	   0    (0x) 0     ? :   1   :   x  ; 
	   1    (0x) 0     ? :   0   :   x  ; 
	   1    (0x) 0     ? :   1   :   1  ; 
	   0    (0x) 0     ? :   0   :   0  ; 

	   *    ?    0     ? :   ?   :   -  ; // data changing, clock stable 

	   ?    ?    1     ? :   ?   :   1  ; // aserting preset 

	   ?    ?    (?0)  ? :   ?   :   -  ; // removing preset 

	   ?    ?    (?x)  ? :   1   :   1  ; // preset unknown 
	   ?    ?    (?x)  ? :   0   :   x  ; 
	   *    ?    x     ? :   1   :   1  ; 
	   ?    *    x     ? :   1   :   1  ; 
	   *    ?    x     ? :   0   :   x  ; 
	   ?    *    x     ? :   0   :   x  ; 
	// else the latch goes unknown
	   ?    ?    ?     * :   ?   :   x  ; // Notifier changes
	endtable
endprimitive
