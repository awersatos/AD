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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/MPI_CORE_PUR.v,v 1.4 2005/05/19 18:30:32 pradeep Exp $ 
//

//***************************************************************************
// Copyright (c) 1998 - Lucent Technologies Inc.
//                    - Shan Tang
//                    - FPGA CAE Group,
//                    - September, 1998.
//***************************************************************************
//
// Title:               MicroProcessor Interface CORE for ORCA3
//
// File:                MPI_CORE.v
// Revision:            9.35
// Created:             Mon Aug 20 16:49:22 EDT 1998
// Author:              Shan Tang <swtang@lucent.com>
// Keywords:
//
// Objective:           VERILOG 9.35 LIBRARY for ORCA FPGA designs.
//
// Time Scale:          0.1 ns
//
// Notes:
//                      Copyright 1998, Lucent Technologies Proprietary Data
//
// Usage:
//
// Algorithm:
// (None)
//
// References:          ORCA Macro Library Reference Manual
//                      Field-Programmable Gate Arrays Data Book
//                      Sept. 1998.
//                      Verilog-XL User Guide
//
// Result:
//
// History:
//
// Comments:

`resetall
`timescale 1 ns / 100 ps

`celldefine
module MPI_CORE_PUR (PUR, valid_acc, clk, rdwrn, addr, din, uend, uirqn,
                     udout, reset_acc, ddrvctl, irqn, ackn, dout,
                     mpgsr, urdwrn, ustart, uaddr, udin);

input PUR, valid_acc, clk, rdwrn, uend, uirqn; 
input [4:0]addr;
input [7:0]din;
input [7:0]udout;
output reset_acc, ddrvctl, irqn, ackn, mpgsr, urdwrn, ustart; 
output [7:0]dout; 
output [3:0]uaddr; 
output [7:0]udin;

reg [7:0]ctrl_reg1; 
reg [7:0]ctrl_reg2; 
reg [7:0]scra_reg; 
reg [7:0]stat_reg;
reg [7:0]sdout;
reg [1:0]mpi_state;
reg urdwrn, ackn, mpgsr, ackn_int, ustart, ddrvctl; 
reg reset_acc, irq_enbl, irq_pend, irqn; 
reg [3:0]uaddr;
reg [7:0]udin;
reg [7:0]dout;
wire pur, valid_acc, clk, rdwrn, uend, uirqn;
wire [4:0]addr;
wire [7:0]udout;
wire [7:0]din;

assign pur = PUR;

parameter idle = 2'b00, sys_rdwr = 2'b01, ack = 2'b10, user = 2'b11;
       
initial
  begin
     ctrl_reg1 = 8'b1x1xxxx0;
     ctrl_reg2 = 8'bxx000000;
     scra_reg  = 8'bxxxxxxxx;
     stat_reg  = 8'bxxxxxxxx;
     sdout     = 8'bxxxxxxxx;
     irq_enbl = 1'b0;
  end

always @ (rdwrn or addr[4:0] or din or ackn_int or ctrl_reg1[0] or sdout[7:0] or udout[7:0]) begin
  begin
     urdwrn = rdwrn;
     uaddr[3:0] = addr[3:0];
     udin[7:0] =  din[7:0];
     ackn = ackn_int;
     mpgsr = ctrl_reg1[0];
  end
  if (addr[4] === 1'b0) 
     dout[7:0] = sdout[7:0];
  else
     dout[7:0] = udout[7:0];
end //end of always

//main:
always @ (pur or valid_acc) begin
  if (pur === 1'b0)
    begin
      ctrl_reg1 <= 8'b10100000;
      ctrl_reg2 <= 8'b00000000;
      scra_reg  <= 8'b00000000;
      stat_reg  <= 8'b00000000;
      mpi_state <= idle;
      ackn_int  <= 1;
      ustart    <= 0;
      ddrvctl   <= 1;
      sdout     <= 8'b00000000;
      irq_pend  <= 1'b0;      
    end 
  else if (valid_acc === 1'b0) begin
     begin
      mpi_state <= idle;
      ackn_int  <= 1;
      ustart    <= 0;
      ddrvctl   <= 1;
     end
  end
end //end of always loop

always @ (posedge clk) begin
//  if ((pur !== 1'b0) && (valid_acc !== 1'b0)) begin 
    if ((pur === 1'b1) && (valid_acc === 1'b1)) begin 

// case ({mpi_state[1], mpi_state[0]})
//  idle: begin
 if (mpi_state === idle) begin
         begin
            ddrvctl  = 1;
            ackn_int = 1;
         end
       if (addr[4] === 1'b0)
           mpi_state = sys_rdwr;
       else
           mpi_state = user;
     end

//  sys_rdwr: begin
  else if (mpi_state === sys_rdwr) begin
         mpi_state = ack;

         case ({addr[3], addr[2], addr[1], addr[0]}) 
     4'b0000: begin
//        CCRI:  //Configuration Control Register I
// read bit 0 MPGSR
// globle set reset driven from the control register          
            if (rdwrn === 1'b1) 
                sdout[7:0] = ctrl_reg1[7:0];
            else       
                ctrl_reg1[7:0] = din[7:0];
            end
     4'b0001: begin
//        CCRII:  //Configuration Control Register II
// read bit 2 ENIRQ
            if (rdwrn === 1'b1)
                sdout[7:0] = ctrl_reg2[7:0];
            else 
                ctrl_reg2[7:0] = din[7:0];
            end
     4'b0010: begin
//        CTSR: //Configuration Test/Scrach Register
            if (rdwrn === 1'b1) 
                sdout[7:0] = scra_reg[7:0];
            else 
                scra_reg[7:0] = din[7:0];
            end
     4'b0011: begin
//        CTSR: //Configuration Status
            if (rdwrn === 1'b1)
            begin 
                sdout[7:0] = stat_reg[7:0];
                irq_pend = 0;
            end
            end

      default $display("Access to unsupported register!");
          endcase
          if (rdwrn === 1'b1) 
              ddrvctl = 0;
          else
              ddrvctl = 1;
     end

//ack: begin
  else if (mpi_state === ack) begin
      mpi_state = idle;
      ackn_int  = 0;
      ustart = 0;
  end 

//user: begin
  else if (mpi_state === user) begin
      ustart = 1;
      if (rdwrn === 1'b1) 
          ddrvctl = 0;
      else
          ddrvctl = 1;

      if (uend === 1'b1)
          mpi_state = ack;
      else
          mpi_state = user;
   end 
//endcase
 end
end //end of always loop

//irq_set:
 always @ (pur or uirqn) begin
   if (pur === 1'b0)
       stat_reg = 8'b00000000;
   else if (uirqn === 1'b0) begin
        if ((mpi_state !== sys_rdwr) || (addr !== 5'b00011) || (rdwrn !== 1'b1)) begin
             stat_reg[2] = 1;
        end
        else
          if ((mpi_state === sys_rdwr) && (addr === 5'b00011) && (rdwrn === 1'b1)) begin
               stat_reg[2] = irq_pend;
          end
   end
 end //end of always loop

//rst_acc:
always @ (clk) begin
 if (clk === 1'b1) begin
  if (ackn_int === 1'b0) 
     reset_acc = 1;
  else
     reset_acc = 0;
 end 
end // end of always loop

 always @ (ctrl_reg2[2]) begin
   irq_enbl = ctrl_reg2[2];
 end //end of always loop
     
//irq:
 always @ (uirqn or irq_enbl or pur) begin
   if (pur === 1'b0)
       irqn = 1;
   else if (irq_enbl === 1'b1)
            irqn = uirqn;
 end // end of always loop
      
endmodule

`endcelldefine
