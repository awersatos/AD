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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/UJKFF2_UDP.v,v 1.2 2005/05/19 18:06:37 pradeep Exp $ 
//
// User Defined Primitive for 
// Positive-Level Sense Latch w/Positive-Asynchronous Clear

`resetall
`timescale 1 ns / 100 ps
primitive UJKFF2_UDP ( Q, J, K, CK, PRE);
input J, K, CK, PRE;
output Q ;
reg Q ;
	table
	//                 P    :     :     
	//           C     R    :  P  :  N  
	// J    K    K     E    :  S  :  S  
 
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

	   ?    ?    ?     1    :  ?  :  1  ; // preset

	   ?    ?    ?     (?0) :  ?  :  -  ; // lift preset

	   ?    ?    ?     (?x) :  1  :  1  ; // unknown preset
	   ?    ?    ?     (?x) :  0  :  x  ;
	   *    ?    ?     x    :  1  :  1  ;
	   ?    *    ?     x    :  1  :  1  ;
	   ?    ?    *     x    :  1  :  1  ;
	   *    ?    ?     x    :  0  :  x  ;
	   ?    *    ?     x    :  0  :  x  ;
	   ?    ?    *     x    :  0  :  x  ;

	// else the latch goes unknown
	endtable
endprimitive
