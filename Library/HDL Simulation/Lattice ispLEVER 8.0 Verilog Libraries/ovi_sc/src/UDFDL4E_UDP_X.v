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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/UDFDL5_UDP_X.v,v 1.3 2005/05/19 19:07:03 pradeep Exp $ 
//
// User Defined Primitive for 
// Positive-Edge Triggered Flipflop w/Positive-Asynchronous Clear
// & clock enable

`resetall
`timescale 1 ns / 1 ps
primitive UDFDL4E_UDP_X (Q, D, CK, CE, CLR, notifier);
input D, CK, CE, CLR, notifier;
output Q ;
reg Q ;
initial Q=1'b0;
	table
	//                C    N :     :     
	//      C    C    L    O :  P  :  N  
	// D    K    E    R    T :  S  :  S  

	   ?    ?    ?    ?    * :  ?  :  x  ; // Notifier changes

	   ?    *    0    0    ? :  ?  :  -  ; // clr=0 & ce=0 => q is same

	   0    1    1    0    ? :  ?  :  0  ; // active edge
	   1    1    1    0    ? :  ?  :  1  ;

	   ?    (?0) ?    0    ? :  ?  :  -  ; // clr=0: any possible falling clk edge
	   ?    (1x) ?    0    ? :  ?  :  -  ; // => q is same

	   0    (x1) ?    0    ? :  0  :  -  ; // D & Q are equal
	   1    (x1) ?    0    ? :  1  :  -  ; // on (0->x or x->1) clk edge
	   0    (0x) ?    0    ? :  0  :  -  ; // => q is same,
	   1    (0x) ?    0    ? :  1  :  -  ; // otherwise: q=x (if ce != 0)

	   0    (01) x    0    ? :  0  :  -  ; // ce=x & D & Q are equal
	   1    (01) x    0    ? :  1  :  -  ; // on active edge => q is same

	   *    ?    ?    0    ? :  ?  :  -  ; // data changing, clock stable
	   ?    ?    *    0    ? :  ?  :  -  ; // ce changing, clock stable

	   ?    ?    ?    1    ? :  ?  :  0  ; // aserting clear

	   ?    ?    ?    (?0) ? :  ?  :  -  ; // removing clear

	   0    *    ?    x    ? :  0  :  -  ; // clr=x: D & Q are 0 or
	   ?    *    0    x    ? :  0  :  -  ; // ce=0 & q=0 on any clk edge => same q

	   0    1    1    x    ? :  ?  :  0  ; // D=0 on active edge => Q=0

	   ?    (?0) ?    x    ? :  0  :  -  ; // Q=0 on any possible falling clk edge
	   ?    (1x) ?    x    ? :  0  :  -  ; // or
	   *    ?    ?    x    ? :  0  :  -  ; // with stable clk
	   ?    ?    *    x    ? :  0  :  -  ; // => Q=0 (same)
	   ?    ?    ?    (?x) ? :  0  :  -  ; // 

	// else the latch goes unknown
	endtable
endprimitive
