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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/UDFDL7_UDP_X.v,v 1.3 2005/05/19 19:07:04 pradeep Exp $ 
//
// User Defined Primitive for 
// Positive-Edge Triggered Flipflop w/Positive-Asynchronous Preset
// & clock enable

`resetall
`timescale 1 ns / 1 ps
primitive UDFDL6E_UDP_X (Q, D, CK, CE, PRE, notifier);
input D, CK, CE, PRE, notifier;
output Q ;
reg Q ;
initial Q=1'b1;
	table
	//                P    N :     :     
	//      C    C    R    O :  P  :  N  
	// D    K    E    E    T :  S  :  S  

	   ?    ?    ?    ?    * :  ?  :  x  ; // Notifier changes

	   ?    *    0    0    ? :  ?  :  -  ; // pre=0 & ce=0 => q is same

	   0    1    1    0    ? :  ?  :  0  ; // active edge
	   1    1    1    0    ? :  ?  :  1  ;

	   ?    (?0) ?    0    ? :  ?  :  -  ; // pre=0: any possible falling clk edge
	   ?    (1x) ?    0    ? :  ?  :  -  ; // => q is same

	   0    (x1) ?    0    ? :  0  :  -  ; // D & Q are equal
	   1    (x1) ?    0    ? :  1  :  -  ; // on (0->x or x->1) clk edge
	   0    (0x) ?    0    ? :  0  :  -  ; // => q is same,
	   1    (0x) ?    0    ? :  1  :  -  ; // otherwise: q=x (if ce != 0)

	   0    (01) x    0    ? :  0  :  -  ; // ce=x & D & Q are equal
	   1    (01) x    0    ? :  1  :  -  ; // on active edge => q is same

	   *    ?    ?    0    ? :  ?  :  -  ; // data changing, clock stable
	   ?    ?    *    0    ? :  ?  :  -  ; // ce changing, clock stable

	   ?    ?    ?    1    ? :  ?  :  1  ; // aserting preset

	   ?    ?    ?    (?0) ? :  ?  :  -  ; // removing preset

	   1    *    ?    x    ? :  1  :  -  ; // pre=x: D & Q are 1 or
	   ?    *    0    x    ? :  1  :  -  ; // ce=0 & q=1 on any clk edge => same q

	   1    1    1    x    ? :  ?  :  1  ; // D=1 on active edge => Q=1

	   ?    (?0) ?    x    ? :  1  :  -  ; // Q=1 on any possible falling clk edge
	   ?    (1x) ?    x    ? :  1  :  -  ; // or
	   *    ?    ?    x    ? :  1  :  -  ; // with stable clk
	   ?    ?    *    x    ? :  1  :  -  ; // => Q=1 (same)
	   ?    ?    ?    (?x) ? :  1  :  -  ; // 

	// else the latch goes unknown
	endtable
endprimitive
