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
// Simulation Library File for ORCA3
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/MPI_CORE.v,v 1.2 2005/05/19 18:30:32 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module MPI_CORE (valid_acc, clk, rdwrn, addr, din, uend, uirqn, 
                 udout, reset_acc, ddrvctl, irqn, ackn, dout,
                 mpgsr, urdwrn, ustart, uaddr, udin);

input valid_acc, clk, rdwrn, uend, uirqn;
input [4:0]addr;
input [7:0]din;
input [7:0]udout;
output reset_acc, ddrvctl, irqn, ackn, mpgsr, urdwrn, ustart;
output [7:0]dout;
output [3:0]uaddr;
output [7:0]udin;


 `ifdef PUR_SIGNAL
  wire PUR = `PUR_SIGNAL;
 `else
  pullup (weak1) (PUR);
 `endif

MPI_CORE_PUR  c (.PUR(PUR), .valid_acc(valid_acc), .clk(clk), 
                 .rdwrn(rdwrn), .addr(addr), .din(din), .uend(uend),
                 .uirqn(uirqn), .udout(udout), .reset_acc(reset_acc), 
                 .ddrvctl(ddrvctl), .irqn(irqn), .ackn(ackn), .dout(dout),
                 .mpgsr(mpgsr), .urdwrn(urdwrn), .ustart(ustart), 
                 .uaddr(uaddr), .udin(udin));

endmodule

`endcelldefine
