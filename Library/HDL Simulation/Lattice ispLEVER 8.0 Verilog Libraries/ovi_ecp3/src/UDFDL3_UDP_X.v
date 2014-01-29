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
// Simulation Library File for SC/EC/XP/ECP/XO/ECP2
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/UDFDL3_UDP_X.v,v 1.3 2005/05/19 19:07:03 pradeep Exp $ 
//
// User Defined Primitive for 
// Positive-Level Sense Latch w/Positive-Asynchronous Preset

`resetall
`timescale 1 ns / 1 ps
primitive UDFDL3_UDP_X ( Q, PRE, PD, PE, notifier); 
input PRE, PD, PE, notifier; 
output Q ;
reg Q ;

initial Q = 1'b1;

	table
	// P               N :     :
	// R    P    P     O :   P   :   N   
	// E    D    E     T :   S   :   S   

	   0    (?0) 1     ? :   ?   :   0  ; // changing data, latch open 
	   0    (?1) 1     ? :   ?   :   1  ; 

	   0    *    0     ? :   ?   :   -  ; // changing data, latch closed 
	   ?    *    0     ? :   1   :   -  ; 

	   0    ?    (?0)  ? :   ?   :   -  ; // closing latch 

	   0    0    (?1)  ? :   ?   :   0  ; // opening latch 
	   0    1    (?1)  ? :   ?   :   1  ; 

	   (?1) ?    ?     ? :   ?   :   1  ; // asserting preset 
           1    *    ?     ? :   ?   :   1  ; 
           1    ?    *     ? :   ?   :   1  ; 

	   (?0) 1    1     ? :   ?   :   1  ; // relinquishing preset 
	   (?0) 0    1     ? :   ?   :   0  ; 
	   (?0) ?    0     ? :   ?   :   -  ; 
//	   (10) 1    x     ? :   1   :   1  ; 

	   0    1    *     ? :   1   :   1  ; // reducing pessimism 
	   *    1    ?     ? :   1   :   1  ; 
	   *    ?    0     ? :   1   :   1  ; 
           0    0    *     ? :   0   :   0  ; 

           (1x) ?    ?     ? :   1   :   1  ; // added to match viewsim UDFDL 
           x    *    ?     ? :   1   :   -  ; 
           x    ?    *     ? :   1   :   -  ; 
           x    *    ?     ? :   x   :   -  ; 
           x    ?    *     ? :   x   :   -  ; 
	// else the latch goes unknown
           ?    ?    ?     * :   ?   :   x  ; 
	endtable
endprimitive
