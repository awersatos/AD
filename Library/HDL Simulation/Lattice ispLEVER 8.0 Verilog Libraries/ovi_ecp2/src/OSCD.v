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
// Simulation Library File for ECP2
//
// $Header:  
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module OSCD (CFGCLK);
  output CFGCLK;
  parameter  NOM_FREQ = "2.5";

  reg CFGCLKb;
  realtime half_clk;

  initial
  begin
     CFGCLKb = 1'b0;

     if (NOM_FREQ == "2.5")
        half_clk = 200.0;
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
     else if (NOM_FREQ == "30.0")
        half_clk = 16.667;
     else if (NOM_FREQ == "34.0")
        half_clk = 14.706;
     else if (NOM_FREQ == "41.0")
        half_clk = 12.195;
     else if (NOM_FREQ == "45.0")
        half_clk = 11.111;
     else if (NOM_FREQ == "55.0")
        half_clk = 9.091;
     else if (NOM_FREQ == "60.0")
        half_clk = 8.333;
     else if (NOM_FREQ == "130.0")
        half_clk = 3.846;
     else
     begin
        half_clk = 200.0;
        $display ("Warning! Wrong oscillator frequency; default to 2.5 MHz.");
     end

     forever begin
        #half_clk CFGCLKb = ~CFGCLKb;
     end
  end

  buf (CFGCLK, CFGCLKb);

endmodule 

`endcelldefine
