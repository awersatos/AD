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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/UDFDL1_UDP.v,v 1.3 2005/05/19 18:06:32 pradeep Exp $ 
//
// User Defined Primitive for 
// Positive-Level Sense Latch w/Positive-Asynchronous Clear

`resetall
`timescale 1 ns / 100 ps
primitive UDFDL1_UDP ( Q, CLR, PD, PE);
input CLR, PD, PE;
output Q ;
reg Q ;
initial Q=1'b0;
	table
	// C              :     :
	// L    P    P    :  P  :  N  
	// R    D    E    :  S  :  S  

	   0    (?0) 1    :  ?  :  0  ; // changing data, latch open
	   0    (?1) 1    :  ?  :  1  ;

	   0    *    0    :  ?  :  -  ; // changing data, latch closed
	   ?    *    0    :  0  :  -  ;

	   0    ?    (?0) :  ?  :  -  ; // closing latch

	   0    0    (?1) :  ?  :  0  ; // opening latch
	   0    1    (?1) :  ?  :  1  ;

	   (?1) ?    ?    :  ?  :  0  ; // asserting clear
           1    *    ?    :  ?  :  0  ;
           1    ?    *    :  ?  :  0  ;

	   (?0) 1    1    :  ?  :  1  ; // relinquishing clear
	   (?0) 0    1    :  ?  :  0  ;
	   (?0) ?    0    :  ?  :  -  ;
	   (10) 0    x    :  0  :  0  ;

	   0    1    *    :  1  :  1  ; // reducing pessimism
	   *    0    ?    :  0  :  0  ;
	   *    ?    0    :  0  :  0  ;
           0    0    *    :  0  :  0  ;

           (1x) ?    ?    :  0  :  0  ; // added to match viewsim UDFDL
           x    *    ?    :  0  :  -  ;
           x    ?    *    :  0  :  -  ;
           x    *    ?    :  x  :  -  ;
           x    ?    *    :  x  :  -  ;
	// else the latch goes unknown
	endtable
endprimitive
