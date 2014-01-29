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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/UDFDL4_UDP.v,v 1.2 2005/05/19 18:06:34 pradeep Exp $ 
//
// User Defined Primitive for 
// Negative-Level Sense Latch w/Positive-Asynchronous Preset

`resetall
`timescale 1 ns / 100 ps
primitive UDFDL4_UDP ( Q, PRE, PD, PE);
input PRE, PD, PE;
output Q ;
reg Q ;
	table
	// P              :     :
	// R    P    P    :  P  :  N  
	// E    D    E    :  S  :  S  

	   0    (?0) 0    :  ?  :  0  ; // changing data, latch open
	   0    (?1) 0    :  ?  :  1  ;

	   0    *    1    :  ?  :  -  ; // changing data, latch closed
	   ?    *    1    :  1  :  -  ;

	   0    ?    (?1) :  ?  :  -  ; // closing latch

	   0    0    (?0) :  ?  :  0  ; // opening latch
	   0    1    (?0) :  ?  :  1  ;

	   (?1) ?    ?    :  ?  :  1  ; // asserting preset
           1    *    ?    :  ?  :  1  ;
           1    ?    *    :  ?  :  1  ;

	   (?0) 1    0    :  ?  :  1  ; // relinquishing preset
	   (?0) 0    0    :  ?  :  0  ;
	   (?0) ?    1    :  ?  :  -  ;
	   (10) 1    x    :  1  :  1  ;

	   0    1    *    :  1  :  1  ; // reducing pessimism
	   *    1    ?    :  1  :  1  ;
	   *    ?    1    :  1  :  1  ;
           0    0    *    :  0  :  0  ;

           (1x) ?    ?    :  1  :  1  ; // added to match viewsim UDFDL
           x    *    ?    :  1  :  -  ;
           x    ?    *    :  1  :  -  ;
           x    *    ?    :  x  :  -  ;
           x    ?    *    :  x  :  -  ;
	// else the latch goes unknown
	endtable
endprimitive
