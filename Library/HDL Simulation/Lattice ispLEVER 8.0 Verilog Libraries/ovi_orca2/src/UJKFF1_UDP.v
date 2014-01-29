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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/UJKFF1_UDP.v,v 1.2 2005/05/19 18:06:37 pradeep Exp $ 
//
// User Defined Primitive for 
// Positive-Level Sense Latch w/Positive-Asynchronous Clear

`resetall
`timescale 1 ns / 100 ps
primitive UJKFF1_UDP ( Q, J, K, CK, CLR);
input J, K, CK, CLR;
output Q ;
reg Q ;
	table
	//                 C    :     :     
	//           C     L    :  P  :  N  
	// J    K    K     R    :  S  :  S  
 
	   0    0    (01)  0    :  ?  :  -  ; // active edge
	   0    1    (01)  0    :  ?  :  0  ;
	   1    0    (01)  0    :  ?  :  1  ;
	   ?    1    (01)  0    :  1  :  0  ;
	   1    ?    (01)  0    :  0  :  1  ;
	   0    x    (01)  0    :  1  :  0  ;
	   x    0    (01)  0    :  1  :  1  ;

	   ?    ?    (?0)  0    :  ?  :  -  ; // clock unknown
	   ?    ?    (1x)  0    :  ?  :  -  ;
	   0    0    (x1)  0    :  ?  :  -  ;
	   0    1    (x1)  0    :  0  :  0  ;
	   1    0    (x1)  0    :  1  :  1  ;
	   0    0    (0x)  0    :  ?  :  -  ;
	   0    ?    (0x)  0    :  0  :  0  ;
	   ?    0    (0x)  0    :  1  :  1  ;

	   *    ?    ?     0    :  ?  :  -  ; // clock stable, data changing
	   ?    *    ?     0    :  ?  :  -  ;

	   ?    ?    ?     1    :  ?  :  0  ; // clear

	   ?    ?    ?     (?0) :  ?  :  -  ; // lift clear

	   ?    ?    ?     (?x) :  0  :  0  ; // unknown clear
	   ?    ?    ?     (?x) :  1  :  x  ;
	   *    ?    ?     x    :  0  :  0  ;
	   ?    *    ?     x    :  0  :  0  ;
	   ?    ?    *     x    :  0  :  0  ;
	   *    ?    ?     x    :  1  :  x  ;
	   ?    *    ?     x    :  1  :  x  ;
	   ?    ?    *     x    :  1  :  x  ;

	// else the latch goes unknown
	endtable
endprimitive
