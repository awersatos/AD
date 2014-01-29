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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/JTAGA.v,v 1.5 2005/05/19 19:06:40 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module JTAGA (TCK, TMS, TDI, PSROUT1, PSROUT2, PSROUT3, JTDO1, JTDO2, JTDO3, JTDO4, JTDO5,
              JTDO6, JTDO7, JTDO8, TDO,
              TRESET, PSRSFTN, PSRCAP, PSRENABLE1, PSRENABLE2, PSRENABLE3,
              SCANENABLE1, SCANENABLE2, SCANENABLE3, SCANENABLE4, SCANENABLE5,
              SCANENABLE6, SCANENABLE7, SCANENABLE8, SCANI, 
              JTCK, JTDI, JSHIFT, JUPDATE, JRSTN,
              JCE1, JCE2, JCE3, JCE4, JCE5, JCE6, JCE7, JCE8,
              JRTI1, JRTI2, JRTI3, JRTI4, JRTI5, JRTI6, JRTI7, JRTI8); 

 input   TCK, TMS, TDI, PSROUT1, PSROUT2, PSROUT3, JTDO1, JTDO2, JTDO3;
 input   JTDO4, JTDO5, JTDO6, JTDO7, JTDO8;

 output  TDO, TRESET, PSRSFTN, PSRCAP, PSRENABLE1, PSRENABLE2, PSRENABLE3;
 output  SCANENABLE1, SCANENABLE2, SCANENABLE3, SCANENABLE4, SCANENABLE5;
 output  SCANENABLE6, SCANENABLE7, SCANENABLE8, SCANI;
 output  JTCK, JTDI, JSHIFT, JUPDATE, JRSTN;
 output  JCE1, JCE2, JCE3, JCE4, JCE5, JCE6, JCE7, JCE8;
 output  JRTI1, JRTI2, JRTI3, JRTI4, JRTI5, JRTI6, JRTI7, JRTI8;

 parameter JTAG_FLASH_PRGRM = "ENABLED";

 initial
    $display ("Warning! Empty model is being used for block \"JTAGA\", for the full functional model please use either the encrypted or the pre-compiled models.");

 supply0 GND;
 buf (TDO, GND);
 buf (TRESET, GND);
 buf (PSRSFTN, GND);
 buf (PSRCAP, GND);
 buf (PSRENABLE1, GND);
 buf (PSRENABLE2, GND);
 buf (PSRENABLE3, GND);
 buf (SCANENABLE1, GND);
 buf (SCANENABLE2, GND);
 buf (SCANENABLE3, GND);
 buf (SCANENABLE4, GND);
 buf (SCANENABLE5, GND);
 buf (SCANENABLE6, GND);
 buf (SCANENABLE7, GND);
 buf (SCANENABLE8, GND);
 buf (SCANI, GND);
 buf (JTCK, GND);
 buf (JTDI, GND);
 buf (JSHIFT, GND);
 buf (JUPDATE, GND);
 buf (JRSTN, GND);
 buf (JCE1, GND);
 buf (JCE2, GND);
 buf (JCE3, GND);
 buf (JCE4, GND);
 buf (JCE5, GND);
 buf (JCE6, GND);
 buf (JCE7, GND);
 buf (JCE8, GND);
 buf (JRTI1, GND);
 buf (JRTI2, GND);
 buf (JRTI3, GND);
 buf (JRTI4, GND);
 buf (JRTI5, GND);
 buf (JRTI6, GND);
 buf (JRTI7, GND);
 buf (JRTI8, GND);

endmodule

`endcelldefine
