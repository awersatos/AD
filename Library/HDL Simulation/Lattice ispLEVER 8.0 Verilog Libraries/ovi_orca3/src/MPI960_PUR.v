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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/MPI960_PUR.v,v 1.13 2005/05/19 18:30:32 pradeep Exp $ 
//

//***************************************************************************
// Copyright (c) 1998 - Lucent Technologies Inc.
//                    - Shan Tang
//                    - FPGA CAE Group,
//                    - July, 1998.
//***************************************************************************
//
// Title:               MicroProcessor Interface for ORCA3
//
// File:                MPI960.v
// Revision:            9.35
// Created:             Mon Aug 20 16:49:22 EDT 1997
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

module MPI960_PUR (CLK, CS0N, CS1, WRRDN, ADSN, ALE, ADIN7, ADIN6, ADIN5, 
                   ADIN4, ADIN3, ADIN2, ADIN1, ADIN0, BE1N, BE0N, RRCVNIN,
                   UEND, UIRQN, UDOUT7, UDOUT6, UDOUT5, UDOUT4, UDOUT3, 
                   UDOUT2, UDOUT1, UDOUT0, PUR, 
                   DDRVCTL, IRQN, RDYRCVN, 
                   DOUT7, DOUT6, DOUT5, DOUT4, DOUT3, DOUT2, DOUT1, DOUT0,
                   MPGSR, URDWRN, USTART, UA3, UA2, UA1, UA0, UDIN7, UDIN6, 
                   UDIN5, UDIN4, UDIN3, UDIN2, UDIN1, UDIN0, RDRCVTS);

input CLK, CS0N, CS1, WRRDN, ADSN, ALE, BE1N, BE0N, RRCVNIN, UEND, UIRQN, PUR;
input ADIN7, ADIN6, ADIN5, ADIN4, ADIN3, ADIN2, ADIN1, ADIN0;
input UDOUT7, UDOUT6, UDOUT5, UDOUT4, UDOUT3, UDOUT2, UDOUT1, UDOUT0;
output DDRVCTL, IRQN, RDYRCVN, MPGSR, URDWRN, USTART, RDRCVTS;
output DOUT7, DOUT6, DOUT5, DOUT4, DOUT3, DOUT2, DOUT1, DOUT0;
output UA3, UA2, UA1, UA0;
output UDIN7, UDIN6, UDIN5, UDIN4, UDIN3, UDIN2, UDIN1, UDIN0;

reg rdwrn_ipd, valid_acc, set_acc, cs_cyc2, cs_cyc1, cs_cyc0;
reg rdrcv_hold, rdrcv_ts_tmp;
reg [4:0]a_ipd;
wire clk_ipd, cs0n_ipd, cs1_ipd, wrrdn_ipd, adsn_ipd, ale_ipd; 
wire uend_ipd, uirqn_ipd, rrcvnin_ipd, PUR;
wire [1:0]ben_ipd;
wire [7:0]adin_ipd;
wire [7:0]udout_ipd;
wire ddrvctl_tmp, irqn_tmp, rdyrcvn_tmp, mpgsr_tmp, urdwrn_tmp, ustart_tmp;
wire [7:0]dout_tmp;
wire [3:0]ua_tmp;
wire [7:0]udin_tmp;

assign clk_ipd = CLK;
assign cs0n_ipd = CS0N;
assign cs1_ipd = CS1;
assign wrrdn_ipd = WRRDN;
assign adsn_ipd = ADSN;  
assign ale_ipd = ALE; 
assign adin_ipd[7] = ADIN7;
assign adin_ipd[6] = ADIN6;
assign adin_ipd[5] = ADIN5;
assign adin_ipd[4] = ADIN4;
assign adin_ipd[3] = ADIN3;
assign adin_ipd[2] = ADIN2;
assign adin_ipd[1] = ADIN1;
assign adin_ipd[0] = ADIN0;
assign ben_ipd[1] = BE1N;
assign ben_ipd[0] = BE0N;
assign rrcvnin_ipd = RRCVNIN;
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

assign DDRVCTL = ddrvctl_tmp;
assign IRQN = irqn_tmp;
assign RDYRCVN = rdyrcvn_tmp;
assign DOUT7 = dout_tmp[7];
assign DOUT6 = dout_tmp[6];
assign DOUT5 = dout_tmp[5];
assign DOUT4 = dout_tmp[4];
assign DOUT3 = dout_tmp[3];
assign DOUT2 = dout_tmp[2];
assign DOUT1 = dout_tmp[1];
assign DOUT0 = dout_tmp[0];
assign RDRCVTS = rdrcv_ts_tmp;
assign MPGSR = mpgsr_tmp;
assign URDWRN = urdwrn_tmp;
assign USTART = ustart_tmp;
assign UA3 = ua_tmp[3];
assign UA2 = ua_tmp[2];
assign UA1 = ua_tmp[1];
assign UA0 = ua_tmp[0];
assign UDIN7 = udin_tmp[7];  
assign UDIN6 = udin_tmp[6];  
assign UDIN5 = udin_tmp[5];  
assign UDIN4 = udin_tmp[4];  
assign UDIN3 = udin_tmp[3];  
assign UDIN2 = udin_tmp[2];  
assign UDIN1 = udin_tmp[1];  
assign UDIN0 = udin_tmp[0];  


initial
  begin
    set_acc = 1'b0;
  end

always @ (wrrdn_ipd) begin
  rdwrn_ipd = ~(wrrdn_ipd);
end //end of always loop

//latch_addr:
always @ (ale_ipd or adin_ipd[7:0] or ben_ipd[1:0] or PUR) begin
  if (PUR === 1'b0)
      a_ipd[4:0] = 5'b00000;
  else if (ale_ipd === 1'b1)
       begin
           a_ipd[4:2] = adin_ipd[4:2];
           a_ipd[1:0] = ben_ipd[1:0];
       end
end //end of always loop 

//chk_acc:
always @ (adsn_ipd or ale_ipd or PUR) begin
  if (PUR === 1'b0)
   begin
      valid_acc <= 0;
      set_acc   <= 0;
      cs_cyc2   <= 0;
      cs_cyc1   <= 0;
      cs_cyc0   <= 0;
   end
end //end of always loop

always @ (posedge CLK) begin
  if (PUR !== 1'b0) begin
    if (rrcvnin_ipd === 1'b0)
     begin
        cs_cyc2 <= 0;
        cs_cyc1 <= 0;
        cs_cyc0 <= 0;
        set_acc <= 0;
     end
    else
     begin
        cs_cyc2 <= cs_cyc1;
        cs_cyc1 <= cs_cyc0;
     end
//check for beginning of address cycle
        if (adsn_ipd === 1'b0)
            cs_cyc0 = 1;
        else
         begin
            cs_cyc0 = 0;
            valid_acc = set_acc;
         end
//check for clock cycles, starting with address phase (ADSN = '0')
        if ((cs_cyc0 === 1'b1) || (cs_cyc1 === 1'b1) || (~adsn_ipd === 1'b1)) begin
           if ((cs0n_ipd === 1'b0) && (cs1_ipd === 1'b1)) begin
                set_acc = 1;
           end
        end 
  end 
end //end of always loop

//rdrcv_contl:
always @ (negedge CLK) begin
  rdrcv_hold <= rdyrcvn_tmp;
end //end of always loop

always @ (rdrcv_hold or rdyrcvn_tmp) begin
  rdrcv_ts_tmp <= rdrcv_hold & rdyrcvn_tmp;
end //end of always loop

MPI_CORE MPICORE0 (.valid_acc(valid_acc), .clk(clk_ipd), .rdwrn(rdwrn_ipd),
                   .addr(a_ipd[4:0]), .din(adin_ipd[7:0]), .uend(uend_ipd),
                   .uirqn(uirqn_ipd), .udout(udout_ipd[7:0]), .reset_acc(reset_acc),
                   .ddrvctl(ddrvctl_tmp), .irqn(irqn_tmp), .ackn(rdyrcvn_tmp),
                   .dout(dout_tmp[7:0]), .mpgsr(mpgsr_tmp), .urdwrn(urdwrn_tmp),
                   .ustart(ustart_tmp), .uaddr(ua_tmp[3:0]), .udin(udin_tmp[7:0]));


endmodule

`endcelldefine
