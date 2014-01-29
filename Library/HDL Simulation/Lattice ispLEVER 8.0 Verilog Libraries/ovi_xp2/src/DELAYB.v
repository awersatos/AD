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
// $Header: /home/rel01/env5_1b.6/verilog/pkg/versclibs/data/ecp2/RCS/DELAYB.v,v 1.1 2005/07/07 20:24:59 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps
`celldefine
module DELAYB (A, DEL0, DEL1, DEL2, DEL3, Z);
  input A, DEL0, DEL1, DEL2, DEL3;
  output Z;
  

wire [3:0] cntl_reg;
wire A_INT;
integer cntl_reg_int;
realtime delta, cntl_delay;
reg Zb;

initial 
begin
   delta = 0.05;
   cntl_reg_int = 0;
   cntl_delay = 0;
end

  // add buf to handle routing delay in simulation.
  buf U3 (A_INT, A);

  buf U4 (cntl_reg[0], DEL0);
  buf U5 (cntl_reg[1], DEL1);
  buf U6 (cntl_reg[2], DEL2);
  buf U7 (cntl_reg[3], DEL3);

  always @(cntl_reg)
  begin
     cntl_reg_int = cntl_reg;
  end

  always @(cntl_reg_int)
  begin
        cntl_delay = cntl_reg_int * delta;
  end

  always @(A_INT)
  begin
     Zb <= #cntl_delay A_INT;
  end

  buf (Z, Zb);

endmodule
`endcelldefine
