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
// Simulation Library File for ECP3
//
// $Header:  
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module AMBOOTA (CSI, AUTOREBOOTI, A7, A6, A5, A4, A3, A2, A1, A0,
                CSO, O7, O6, O5, O4, O3, O2, O1, O0);
  input CSI, AUTOREBOOTI, A7, A6, A5, A4, A3, A2, A1, A0;
  output CSO, O7, O6, O5, O4, O3, O2, O1, O0;

parameter CS_SS = "STATIC";
parameter AUTOREBOOT = "OFF";
parameter CS_SS_VAL = "CHIP1";
parameter SECTOR_ADDRESS = "0x00";

supply0 GND;
buf (CSO, GND);
buf (O0, GND);
buf (O1, GND);
buf (O2, GND);
buf (O3, GND);
buf (O4, GND);
buf (O5, GND);
buf (O6, GND);
buf (O7, GND);

endmodule 

`endcelldefine
