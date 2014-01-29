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
// $Header: /home/rel01/env5_1b.6/verilog/pkg/versclibs/data/ecp2/RCS/DLLDELA.v,v 1.1 2005/07/07 20:25:01 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps
`celldefine
module DLLDELA (CLKI, DCNTL0, DCNTL1, DCNTL2, DCNTL3, DCNTL4, DCNTL5, DCNTL6, DCNTL7, DCNTL8, CLKO);
  input CLKI, DCNTL0, DCNTL1, DCNTL2, DCNTL3, DCNTL4, DCNTL5, DCNTL6, DCNTL7, DCNTL8;
  output CLKO;
  

wire [8:0] cntl_reg;
wire CLKIB;
integer cntl_reg_int;
realtime delta, cntl_delay;
reg CLKOB;

initial 
begin
   delta = 0.02;
   cntl_reg_int = 0;
   cntl_delay = 0;
end
  // add buf to handle routing delay in simulation.
  buf U3 (CLKIB, CLKI);

  buf U4 (cntl_reg[0], DCNTL0);
  buf U5 (cntl_reg[1], DCNTL1);
  buf U6 (cntl_reg[2], DCNTL2);
  buf U7 (cntl_reg[3], DCNTL3);
  buf U8 (cntl_reg[4], DCNTL4);
  buf U9 (cntl_reg[5], DCNTL5);
  buf U10 (cntl_reg[6], DCNTL6);
  buf U11 (cntl_reg[7], DCNTL7);
  buf U12 (cntl_reg[8], DCNTL8);

  always @(cntl_reg)
  begin
     cntl_reg_int = cntl_reg;
  end

  always @(cntl_reg_int)
  begin
        cntl_delay = cntl_reg_int * delta;
  end

  always @(CLKIB)
  begin
     CLKOB <= #cntl_delay CLKIB;
  end

  buf (CLKO, CLKOB);

endmodule
`endcelldefine
