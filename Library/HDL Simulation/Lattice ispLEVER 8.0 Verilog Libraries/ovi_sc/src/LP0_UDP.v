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
// Simulation Library File for SC
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/LP0_UDP.v,v 1.3 2005/05/19 19:06:46 pradeep Exp $ 
//
// User Defined Primitive for 
// Positive-Level Sense Latch 
`resetall
`timescale 1 ns / 1 ps
primitive LP0_UDP ( Q, D, CK, VT );
    input D, CK, VT;
    output Q;
    reg Q ;
	table
	//      C    V  :  P  :  N  
	// D    K    T  :  S  :  S  
	//-------------------------
	  (?0)  1    ?  :  ?  :  0  ; // changing data, latch open
	  (?1)  1    ?  :  ?  :  1  ;

	   *    0    ?  :  ?  :  -  ; // changing data, latch closed

	   0   (?1)  ?  :  ?  :  0  ; // opening latch
	   1   (?1)  ?  :  ?  :  1  ;

	   ?   (?0)  ?  :  ?  :  -  ; // closing latch

	   ?    1    *  :  ?  :  -  ; // ignoring timing violation

	   1    *    ?  :  1  :  1  ; // reducing pessimism
	   0    *    ?  :  0  :  0  ; 
	// else the latch goes unknown
	endtable
endprimitive
