// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2005-2007 by Lattice Semiconductor Corporation
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
// Simulation Library File for ECP2
//
// $Header:  
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module JTAGC (TCK, TMS, TDI, ITCK, ITMS, ITDI, IJTAGEN, JTDO1, JTDO2, 
              TDO, ITDO, JTCK, JTDI, JSHIFT, JUPDATE, JRSTN,
              JCE1, JCE2, JRTI1, JRTI2);

 input   TCK, TMS, TDI, ITCK, ITMS, ITDI, IJTAGEN, JTDO1, JTDO2;

 output  TDO, ITDO, JTCK, JTDI, JSHIFT, JUPDATE, JRSTN;
 output  JCE1, JCE2, JRTI1, JRTI2;

 parameter ER1 = "ENABLED";
 parameter ER2 = "ENABLED";

 initial
    $display ("Warning! Empty model is being used for block \"JTAGC\", for the full functional model please use either the encrypted or the pre-compiled models.");

 supply0 GND;
 buf (TDO, GND);
 buf (JTCK, GND);
 buf (JTDI, GND);
 buf (JSHIFT, GND);
 buf (JUPDATE, GND);
 buf (JRSTN, GND);
 buf (JCE1, GND);
 buf (JCE2, GND);
 buf (JRTI1, GND);
 buf (JRTI2, GND);
 buf (ITDO, GND);

endmodule

`endcelldefine
