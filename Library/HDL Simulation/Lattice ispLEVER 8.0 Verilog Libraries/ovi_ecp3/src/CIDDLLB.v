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

module CIDDLLB (CLKI, CLKFB, RSTN, ALUHOLD, INCI,
                GRAYI5, GRAYI4, GRAYI3, GRAYI2, GRAYI1, GRAYI0,
                CLKOP, CLKOS, LOCK);

input CLKI, CLKFB, RSTN, ALUHOLD, INCI;
input GRAYI5, GRAYI4, GRAYI3, GRAYI2, GRAYI1, GRAYI0;
output CLKOP, CLKOS, LOCK;

parameter CLKOP_PHASE = 0;
parameter CLKOS_PHASE = 0;
parameter CLKOS_FPHASE = 101;
parameter CLKI_DIV = 1;
parameter CLKOS_DIV = 1;
parameter GSR = "DISABLED";
parameter ALU_LOCK_CNT = 3;
parameter ALU_UNLOCK_CNT = 3;
parameter GLITCH_TOLERANCE = 2;
parameter ALU_INIT_CNTVAL = 0;
parameter LOCK_DELAY=100;
parameter CLKOP_DUTY50 = "DISABLED";
parameter CLKOS_DUTY50 = "DISABLED";
parameter DEL0_GRAY = "DISABLED";
parameter DEL1_GRAY = "DISABLED";
parameter DEL2_GRAY = "DISABLED";
parameter DEL3_GRAY = "DISABLED";
parameter DEL4_GRAY = "DISABLED";

wire CLKIB, CLKFBB, RSTNB;
reg g_reset, clock_valid, lock_valid, real_lock, false_clk, CLKOP_reg, CLKOS_reg, CLK90_reg;
reg false_clk_first_time, fb_first_time, clkop_first_time, clk90_first_time, clkos_first_time;
wire resetn;
reg  set_resetn;
realtime total_fb_delay, virtual_delay1;
realtime next_clock_edge, last_clock_edge;
realtime first_int_edge, first_fb_edge;
realtime t_in_clk, t_in_clk1, t_in_clk2;
realtime t_90, t_180, t_270, t_360;
realtime t_11, t_22, t_33, t_45, t_56, t_67, t_78;
realtime t_101, t_112, t_123, t_135;
realtime real_delay1, lock_delay_reg;
reg clock_p, clock_90, clock_s, clock_s_del, clock_s_del_d2, clock_s_del_d4, clock_s_final;
integer ratio1;

initial
begin
   lock_delay_reg = 1.0;
   clock_p = 1'b0;
//   clock_90 = 1'b0;
   clock_valid = 1'b0;
   clock_s = 1'b0;
   clock_s_del = 1'b0;
   clock_s_del_d2 = 1'b0;
   clock_s_del_d4 = 1'b0;
end

buf U1 (CLKIB, CLKI);
buf U2 (CLKFBB, CLKFB);
buf U3 (RSTNB, RSTN);

  tri1 GSR_sig = GSR_INST.GSRNET;
  tri1 PUR_sig = PUR_INST.PURNET;

  always @ (GSR_sig or PUR_sig ) begin
    if (GSR == "ENABLED") begin
      g_reset = GSR_sig & PUR_sig ;
    end
    else if (GSR == "DISABLED")
      g_reset = PUR_sig;
  end

  initial begin
   false_clk = 1'b0;
   forever #5 false_clk = ~false_clk;
  end

  assign resetn = g_reset & RSTNB;

  initial
   begin
   clkop_first_time = 1'b1;
   clkos_first_time = 1'b1;
//   clk90_first_time = 1'b1;
   #15
   clkop_first_time = 1'b0;
   clkos_first_time = 1'b0;
//   clk90_first_time = 1'b0;
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
always @(posedge CLKIB or negedge resetn)
begin
   if (resetn == 1'b0)
      set_resetn <= resetn;
   else
      set_resetn <= resetn;
end

always @(posedge false_clk)
  begin
  if (false_clk_first_time == 1)
  first_int_edge=$realtime;
  false_clk_first_time = 1'b0;
  end

always @(posedge CLKFBB)
  begin
  if (fb_first_time == 1)
  first_fb_edge=$realtime;
  fb_first_time = 1'b0;
  end

always @(CLKFBB or CLKIB)
  begin
  total_fb_delay = first_fb_edge - first_int_edge;

  if ( (total_fb_delay > 0) && (t_in_clk > 0) )
     begin
     ratio1 = total_fb_delay / t_in_clk;
     virtual_delay1 = total_fb_delay - (t_in_clk * ratio1);
     real_delay1 = t_in_clk - virtual_delay1 ;
     end
  end

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
        t_11 = (t_in_clk / 32 );
        t_22 = (t_in_clk / 16 );
        t_33 = ((t_in_clk * 3) / 32 );
        t_45 = (t_in_clk / 8 );
        t_56 = ((t_in_clk * 5) / 32 );
        t_67 = ((t_in_clk * 3) / 16 );
        t_78 = ((t_in_clk * 7) / 32 );
        t_90 = (t_in_clk / 4 );
        t_101 = ((t_in_clk * 9) / 32 );
        t_112 = ((t_in_clk * 5) / 16 );
        t_123 = ((t_in_clk * 11) / 32 );
        t_135 = ((t_in_clk * 3) / 8 );
        t_180 = (t_in_clk / 2);
        t_270 = ((t_in_clk * 3) / 4 );
        t_360 = t_in_clk;
    end
   end

  always @(CLKIB or lock_valid)
  begin
        if (lock_valid == 1'b1)
           clock_p <= #real_delay1 CLKIB;
//           clock_90 <= #real_delay1 CLKIB;
//           clock_s <= #real_delay1 CLKIB;
  end 

  always @(CLKIB or clock_p)
  begin
     if (CLKOS_FPHASE == 0)
        clock_s_del <= clock_p;
     else if (CLKOS_FPHASE == 11)
        clock_s_del <= #t_11 clock_p;
     else if (CLKOS_FPHASE == 22)
        clock_s_del <= #t_22 clock_p;
     else if (CLKOS_FPHASE == 33)
        clock_s_del <= #t_33 clock_p;
     else if (CLKOS_FPHASE == 45)
        clock_s_del <= #t_45 clock_p;
     else if (CLKOS_FPHASE == 56)
        clock_s_del <= #t_56 clock_p;
     else if (CLKOS_FPHASE == 67)
        clock_s_del <= #t_67 clock_p;
     else if (CLKOS_FPHASE == 78)
        clock_s_del <= #t_78 clock_p;
     else if (CLKOS_FPHASE == 90)
        clock_s_del <= #t_90 clock_p;
     else if (CLKOS_FPHASE == 101)
        clock_s_del <= #t_101 clock_p;
     else if (CLKOS_FPHASE == 112)
        clock_s_del <= #t_112 clock_p;
     else if (CLKOS_FPHASE == 123)
        clock_s_del <= #t_123 clock_p;
     else if (CLKOS_FPHASE == 135)
        clock_s_del <= #t_135 clock_p;
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
/*
  always @(clock_90 or lock_valid or false_clk or set_resetn)
  begin
     if (clk90_first_time == 1'b1)
     begin
        CLK90_reg = false_clk;
     end
     else if (set_resetn == 1'b0)
     begin
        CLK90_reg = 1'b0;
        clk90_first_time = 1'b0;
     end
     else if (lock_valid == 1'b1)
     begin
        CLK90_reg = clock_90;
        clk90_first_time = 1'b0;
     end  
  end
*/
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
//  buf (CLK90, CLK90_reg);
  buf (LOCK, real_lock);

endmodule

`endcelldefine

