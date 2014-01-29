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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/CIMDLLA.v,v 1.10 2005/06/06 20:21:04 pradeep Exp $
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module CIMDLLA (CLKI, CLKFB, RSTN, ALUHOLD, UDDCNTL, SMIADDR9, SMIADDR8, SMIADDR7, SMIADDR6,
               SMIADDR5, SMIADDR4, SMIADDR3, SMIADDR2, SMIADDR1, SMIADDR0, SMIRD, SMIWR,
               SMICLK, SMIWDATA, SMIRSTN,
               CLKOP, CLKOS, LOCK, DCNTL0, DCNTL1, DCNTL2, DCNTL3, DCNTL4, DCNTL5, DCNTL6,
               DCNTL7, DCNTL8, SMIRDATA);
input CLKI, CLKFB, RSTN, ALUHOLD, UDDCNTL, SMIADDR9, SMIADDR8, SMIADDR7, SMIADDR6;
input SMIADDR5, SMIADDR4, SMIADDR3, SMIADDR2, SMIADDR1, SMIADDR0, SMIRD, SMIWR;
input SMICLK, SMIWDATA, SMIRSTN;
output CLKOP, CLKOS, LOCK, DCNTL0, DCNTL1, DCNTL2, DCNTL3, DCNTL4, DCNTL5, DCNTL6;
output DCNTL7, DCNTL8, SMIRDATA;

parameter CLKOS_FPHASE = 0;
parameter CLKOS_DIV = 1;
parameter GSR = "DISABLED";
parameter ALU_LOCK_CNT = 3;
parameter ALU_UNLOCK_CNT = 3;
parameter GLITCH_TOLERANCE = 0;
parameter DCNTL_ADJVAL = 0;
parameter SMI_OFFSET= 12'h410;
parameter SMI_ADDR_DIS=10'b0000000000;
parameter LOCK_DELAY=100;
parameter CLKOS_FDEL_ADJ = "DISABLED";

wire CLKIB, CLKFBB, RSTNB;
reg g_reset, clock_valid, lock_valid, real_lock, false_clk, CLKOP_reg, CLKOS_reg;
wire resetn;
reg  set_resetn;
reg false_clk_first_time, fb_first_time, clkop_first_time, clkos_first_time;
realtime first_int_edge, first_fb_edge, next_clki_edge, next_fb_edge;
realtime total_fb_delay;
realtime next_clock_edge, last_clock_edge;
realtime t_180, t_90, t_270, t_360, t_45 , t_22, t_11;
realtime t_in_clk, t_in_clk1, t_in_clk2, lock_delay_reg;
reg clock_p, clock_s, clock_s_del, clock_s_del_d2, clock_s_del_d4, clock_s_final;
integer cntl_ratio;
wire [8:0] cntl_reg, cntl_reg_final;
reg  [8:0] cntl_reg_update;
realtime delta;

supply0 VSS;
buf (SMIRDATA , VSS);
buf U1 (CLKIB, CLKI);
buf U2 (CLKFBB, CLKFB);
buf U3 (RSTNB, RSTN);
buf U13 (UDDCNTLB, UDDCNTL);
buf U4 (DCNTL0, cntl_reg_final[0]);
buf U5 (DCNTL1, cntl_reg_final[1]);
buf U6 (DCNTL2, cntl_reg_final[2]);
buf U7 (DCNTL3, cntl_reg_final[3]);
buf U8 (DCNTL4, cntl_reg_final[4]);
buf U9 (DCNTL5, cntl_reg_final[5]);
buf U10 (DCNTL6, cntl_reg_final[6]);
buf U11 (DCNTL7, cntl_reg_final[7]);
buf U12 (DCNTL8, cntl_reg_final[8]);

  tri1 GSR_sig = GSR_INST.GSRNET;
  tri1 PUR_sig = PUR_INST.PURNET;

// `ifdef GSR_SIGNAL
//  wire GSR = `GSR_SIGNAL;
// `else
//  pullup (weak1) (GSR);
//  `endif

// `ifdef PUR_SIGNAL
//  wire PUR = `PUR_SIGNAL;
// `else
//  pullup (weak1) (PUR);
// `endif

  always @ (GSR_sig or PUR_sig ) begin
    if (GSR == "ENABLED") begin
      g_reset = GSR_sig & PUR_sig ;
    end
    else if (GSR == "DISABLED")
      g_reset = PUR_sig;
  end

  assign resetn = g_reset & RSTNB;

always @(posedge CLKIB or negedge resetn)
begin
   if (resetn == 1'b0)
      set_resetn <= resetn;
   else
      set_resetn <= resetn;
end

initial
begin
   lock_delay_reg = 1.0;
   cntl_reg_update = 9'b000000000;
   cntl_ratio = 0;
   delta = 0.02;
   clock_p = 1'b0;
   clock_valid = 1'b0;
   clock_s = 1'b0;
   clock_s_del = 1'b0;
   clock_s_del_d2 = 1'b0;
   clock_s_del_d4 = 1'b0;
end

  initial begin
   false_clk = 1'b0;
   forever #5 false_clk = ~false_clk;
  end

  initial
   begin
   clkop_first_time = 1'b1;
   clkos_first_time = 1'b1;
   #15
   clkop_first_time = 1'b0;
   clkos_first_time = 1'b0;
  end

  initial
   begin
   first_int_edge = 0.0;
   first_fb_edge = 0.0;
   false_clk_first_time = 1'b0;
   fb_first_time = 1'b0;
   #1;
   false_clk_first_time = 1'b1;
   fb_first_time = 1'b1;
   end

always @(posedge false_clk)
begin
  if (false_clk_first_time == 1)
  begin
     first_int_edge=$realtime;
     false_clk_first_time <= 1'b0;
  end
end

always @(posedge CLKIB)
begin
   next_clki_edge = $realtime;
end

always @(posedge CLKFBB)
  begin
     if (fb_first_time == 1)
     begin
        first_fb_edge=$realtime;
        total_fb_delay = first_fb_edge - first_int_edge;
        fb_first_time <= 1'b0;
     end
     else 
     begin
        next_fb_edge = $realtime;
        total_fb_delay = next_fb_edge - next_clki_edge;
     end
     
     if (total_fb_delay > 0)
     begin
        cntl_ratio = (total_fb_delay / delta);
     end
  end

  assign cntl_reg = cntl_ratio;

  always @(cntl_reg or UDDCNTLB)
  begin
     if (UDDCNTLB == 1'b1)
        cntl_reg_update <= cntl_reg;
  end

  assign cntl_reg_final = cntl_reg_update;

  always @(posedge CLKIB)
   begin
   last_clock_edge=next_clock_edge;
   next_clock_edge=$realtime;

    if (last_clock_edge > 0)
        begin
        t_in_clk <= next_clock_edge - last_clock_edge;
        t_in_clk1 <= t_in_clk;
        end

    if (t_in_clk > 0)
        begin
           if ( ((t_in_clk - t_in_clk1) < 0.0001) && ((t_in_clk - t_in_clk1) > -0.0001))
//         if (t_in_clk == t_in_clk1)
            clock_valid = 1;
         else
            clock_valid = 0;
        end

    if (t_in_clk > 0)
        begin
        t_180 = (t_in_clk / 2);
        t_90 = (t_in_clk / 4 );
        t_270 = ((t_in_clk * 3) / 4 );
        t_360 = t_in_clk ;
        t_45 = (t_in_clk / 8 );
        t_22 = (t_in_clk / 16 );
        t_11 = (t_in_clk / 32 );
        end
   end

  always @(CLKIB or lock_valid)
  begin
     if (lock_valid == 1'b1)
     begin
        clock_p <= CLKIB;
        clock_s <= CLKIB;
     end
  end

  always @(CLKIB or clock_s)
  begin
     if (CLKOS_FPHASE == 0)
        clock_s_del <= clock_s;
     else if (CLKOS_FPHASE == 11)
        clock_s_del <= #t_11 clock_s;
     else if (CLKOS_FPHASE == 22)
        clock_s_del <= #t_22 clock_s;
     else if (CLKOS_FPHASE == 45)
        clock_s_del <= #t_45 clock_s;
  end

  always @(posedge clock_s_del)
  begin
     clock_s_del_d2 = ~clock_s_del_d2;
  end

  always @(posedge clock_s_del_d2)
  begin
     clock_s_del_d4 = ~clock_s_del_d4;
  end

  always @(clock_s_del or clock_s_del_d2 or clock_s_del_d4)
  begin
     if (CLKOS_DIV == 1)
        clock_s_final <= clock_s_del;
     else if (CLKOS_DIV == 2)
        clock_s_final <= clock_s_del_d2;
     else if (CLKOS_DIV == 4)
        clock_s_final <= clock_s_del_d4;
  end

  always @(clock_p or lock_valid or false_clk or set_resetn)
  begin
     if (clkop_first_time == 1'b1)
     begin
        CLKOP_reg = false_clk;
     end
     else if (set_resetn == 1'b0)
     begin
        CLKOP_reg = 1'b0;
        clkop_first_time = 1'b0;
     end
     else if (lock_valid == 1'b1)
     begin
        CLKOP_reg = clock_p;
        clkop_first_time = 1'b0;
     end
  end

  always @(clock_s_final or lock_valid or false_clk or set_resetn)
  begin
     if (clkos_first_time == 1'b1)
     begin
        CLKOS_reg = false_clk;
     end
     else if (set_resetn == 1'b0)
     begin
        CLKOS_reg = 1'b0;
        clkos_first_time = 1'b0;
     end
     else if (lock_valid == 1'b1)
     begin
        CLKOS_reg = clock_s_final;
        clkos_first_time = 1'b0;
     end
  end

  always @(clock_valid or set_resetn)
  begin
     if (set_resetn == 1'b0)
        lock_valid <= 1'b0;
     else
        lock_valid <= clock_valid;
  end

  always @(clock_valid or set_resetn)
  begin
     if (set_resetn == 1'b0)
        real_lock <= 1'b0;
     else if (clock_valid == 1'b0)
        real_lock <= 1'b0;
     else if (clock_valid == 1'b1)
        real_lock <= #(LOCK_DELAY * lock_delay_reg) clock_valid;
  end

  buf (CLKOS, CLKOS_reg);
  buf (CLKOP, CLKOP_reg);
  buf (LOCK, real_lock);

endmodule

`endcelldefine

