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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/MPIPPC_PUR.v,v 1.13 2005/05/19 18:30:32 pradeep Exp $ 
//

//***************************************************************************
// Copyright (c) 1998 - Lucent Technologies Inc.
//                    - Shan Tang
//                    - FPGA CAE Group,
//                    - January, 1998.
//***************************************************************************
//
// Title:               MicroProcessor Interface for ORCA3
//
// File:                MPIPPC.v
// Revision:            9.35
// Created:             Mon Aug 20 16:49:22 EDT 1997
// Author:              Shan Tang <swtang@aluxpo.lucent.com>
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
//                      January 1998.
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
module MPIPPC_PUR (CLK, CS0N, CS1, RDWRN, TSN, A27, A28, A29, A30, A31, DIN7, 
              DIN6, DIN5, DIN4, DIN3, DIN2, DIN1, DIN0, UEND, UIRQN, UDOUT7, 
              UDOUT6, UDOUT5, UDOUT4, UDOUT3, UDOUT2, UDOUT1, UDOUT0, PUR,
              TANTS, BIN, DDRVCTL, IRQN, TAN,
              DOUT7, DOUT6, DOUT5, DOUT4, DOUT3, DOUT2, DOUT1, DOUT0, 
              MPGSR, URDWRN, USTART, UA3, UA2, UA1, UA0, UDIN7, UDIN6,
              UDIN5, UDIN4, UDIN3, UDIN2, UDIN1, UDIN0); 

input CLK, CS0N, CS1, RDWRN, TSN, UEND, UIRQN, PUR;
input A27, A28, A29, A30, A31;
input DIN7, DIN6, DIN5, DIN4, DIN3, DIN2, DIN1, DIN0;
input UDOUT7, UDOUT6, UDOUT5, UDOUT4, UDOUT3, UDOUT2, UDOUT1, UDOUT0;
output TANTS, BIN, DDRVCTL, IRQN, TAN, MPGSR, URDWRN, USTART;
output DOUT7, DOUT6, DOUT5, DOUT4, DOUT3, DOUT2, DOUT1, DOUT0;
output UA3, UA2, UA1, UA0;
output UDIN7, UDIN6, UDIN5, UDIN4, UDIN3, UDIN2, UDIN1, UDIN0;

reg valid_acc, set_acc, bin_tmp, tan_hold, tan_ts_tmp;
wire ddrvctl, irqn_tmp, tan_tmp, urdwrn_tmp, ustart_tmp, mpgsr_tmp;
wire [7:0]udin_tmp;
wire [7:0]dout_tmp;
wire [3:0]ua_tmp;  
wire clk_ipd, cs0n_ipd, cs1_ipd, rdwrn_ipd, tsn_ipd, reset_acc, pur; 
wire [27:31]a_ipd;
wire [7:0]din_ipd;
wire [7:0]din_tmp;
wire uend_ipd, uirqn_ipd; 
wire [7:0]udout_ipd;

assign pur = PUR;
assign clk_ipd = CLK;
assign cs0n_ipd = CS0N;
assign cs1_ipd = CS1;
assign rdwrn_ipd = RDWRN;
assign tsn_ipd = TSN;
assign a_ipd[27] = A27;
assign a_ipd[28] = A28;
assign a_ipd[29] = A29;
assign a_ipd[30] = A30;
assign a_ipd[31] = A31;
assign din_ipd[7] = DIN7;
assign din_ipd[6] = DIN6;
assign din_ipd[5] = DIN5;
assign din_ipd[4] = DIN4;
assign din_ipd[3] = DIN3;
assign din_ipd[2] = DIN2;
assign din_ipd[1] = DIN1;
assign din_ipd[0] = DIN0;
assign uend_ipd = UEND;
assign uirqn_ipd = UIRQN;
assign udout_ipd[7] = UDOUT7;
assign udout_ipd[6] = UDOUT6;
assign udout_ipd[5] = UDOUT5;
assign udout_ipd[4] = UDOUT4;
assign udout_ipd[3] = UDOUT3;
assign udout_ipd[2] = UDOUT2;
assign udout_ipd[1] = UDOUT1;
assign udout_ipd[0] = UDOUT0;

assign TANTS = tan_ts_tmp;
assign BIN = bin_tmp;
//assign DDRVCTL = ddrvctl_tmp;
assign DDRVCTL = ddrvctl;
assign IRQN = irqn_tmp;
assign TAN = tan_tmp;
assign MPGSR = mpgsr_tmp;
assign URDWRN = urdwrn_tmp;
assign USTART = ustart_tmp;
assign UDIN7 = udin_tmp[7];
assign UDIN6 = udin_tmp[6];
assign UDIN5 = udin_tmp[5];
assign UDIN4 = udin_tmp[4];
assign UDIN3 = udin_tmp[3];
assign UDIN2 = udin_tmp[2];
assign UDIN1 = udin_tmp[1];
assign UDIN0 = udin_tmp[0];
assign DOUT7 = dout_tmp[7];
assign DOUT6 = dout_tmp[6];
assign DOUT5 = dout_tmp[5];
assign DOUT4 = dout_tmp[4];
assign DOUT3 = dout_tmp[3];
assign DOUT2 = dout_tmp[2];
assign DOUT1 = dout_tmp[1];
assign DOUT0 = dout_tmp[0];
assign UA3 = ua_tmp[3];
assign UA2 = ua_tmp[2];
assign UA1 = ua_tmp[1];
assign UA0 = ua_tmp[0];
 
initial
  begin
   set_acc = 1'b0;
  end

always @ (tan_tmp) begin
  bin_tmp = tan_tmp;
end //end of always loop

//chk_acc:
always @ (cs0n_ipd or cs1_ipd or tsn_ipd or reset_acc or pur or set_acc) begin
  if ((pur === 1'b0) || (reset_acc === 1'b1) ||
      (cs0n_ipd !== 1'b0) || (cs1_ipd !== 1'b1))
       begin
       valid_acc <= 0;
       set_acc <= 0;
       end
  else if (tsn_ipd === 1'b0) 
           set_acc <= 1;
       else
           valid_acc <= set_acc;
end //end of always loop

//tri_contl:
always @ (negedge clk_ipd) begin
    tan_hold <= tan_tmp;
end // end of always loop

always @ (tan_hold or tan_tmp) begin 
    tan_ts_tmp = tan_hold & tan_tmp;
end //end of always loop

MPI_CORE MPICORE0 (.valid_acc(valid_acc), .clk(clk_ipd), .rdwrn(rdwrn_ipd), 
                   .addr(a_ipd[27:31]), .din(din_ipd[7:0]), .uend(uend_ipd),
                   .uirqn(uirqn_ipd), .udout(udout_ipd[7:0]), .reset_acc(reset_acc), 
                   .ddrvctl(ddrvctl), .irqn(irqn_tmp), .ackn(tan_tmp), 
                   .dout(dout_tmp[7:0]), .mpgsr(mpgsr_tmp), .urdwrn(urdwrn_tmp), 
                   .ustart(ustart_tmp), .uaddr(ua_tmp[3:0]), .udin(udin_tmp[7:0]));
 

endmodule

`endcelldefine
