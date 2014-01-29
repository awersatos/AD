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
// Simulation Library File for EC/XP
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mg/RCS/lut_mux4.v,v 1.2 2005/05/19 20:09:06 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

primitive lut_mux4 (o, i3, i2, i1, i0, s1, s0);

output o;
input i3, i2, i1, i0;
input s1, s0;

table

//   i3  i2  i1  i0  s1  s0 : o;

     ?   ?   ?   1   0   0  : 1;
     ?   ?   ?   0   0   0  : 0;
     ?   ?   1   ?   0   1  : 1;
     ?   ?   0   ?   0   1  : 0;
     ?   1   ?   ?   1   0  : 1;
     ?   0   ?   ?   1   0  : 0;
     1   ?   ?   ?   1   1  : 1;
     0   ?   ?   ?   1   1  : 0;

     ?   ?   0   0   0   x  : 0;
     ?   ?   1   1   0   x  : 1;
     0   0   ?   ?   1   x  : 0;
     1   1   ?   ?   1   x  : 1;

     ?   0   ?   0   x   0  : 0;
     ?   1   ?   1   x   0  : 1;
     0   ?   0   ?   x   1  : 0;
     1   ?   1   ?   x   1  : 1;

     0   0   0   0   x   x  : 0;
     1   1   1   1   x   x  : 1;

endtable

endprimitive
