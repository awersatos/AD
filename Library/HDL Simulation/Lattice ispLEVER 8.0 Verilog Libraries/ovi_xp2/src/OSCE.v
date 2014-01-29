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
// Simulation Library File for XP2
//
// $Header:  
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module OSCE (OSC);
  output OSC;
  parameter  NOM_FREQ = "2.5";

  reg OSCb;
  realtime half_clk;

  initial
  begin
     OSCb = 1'b0;

     if (NOM_FREQ == "2.5")
        half_clk = 200.0;
     else if (NOM_FREQ == "3.1")
        half_clk = 161.29;
     else if (NOM_FREQ == "4.3")
        half_clk = 116.28;
     else if (NOM_FREQ == "5.4")
        half_clk = 92.59;
     else if (NOM_FREQ == "6.9")
        half_clk = 72.46;
     else if (NOM_FREQ == "8.1")
        half_clk = 61.73;
     else if (NOM_FREQ == "9.2")
        half_clk = 54.35;
     else if (NOM_FREQ == "10.0")
        half_clk = 50.0;
     else if (NOM_FREQ == "13.0")
        half_clk = 38.462;
     else if (NOM_FREQ == "15.0")
        half_clk = 33.333;
     else if (NOM_FREQ == "20.0")
        half_clk = 25.0;
     else if (NOM_FREQ == "26.0")
        half_clk = 19.231;
     else if (NOM_FREQ == "32.0")
        half_clk = 15.625;
     else if (NOM_FREQ == "40.0")
        half_clk = 12.5;
     else if (NOM_FREQ == "54.0")
        half_clk = 9.259;
     else if (NOM_FREQ == "80.0")
        half_clk = 6.25;
     else if (NOM_FREQ == "163.0")
        half_clk = 3.067;
     else
     begin
        half_clk = 200.0;
        $display ("Warning! Wrong oscillator frequency; default to 2.5 MHz.");
     end

     forever begin
        #half_clk OSCb = ~OSCb;
     end
  end

  buf (OSC, OSCb);

endmodule 

`endcelldefine
