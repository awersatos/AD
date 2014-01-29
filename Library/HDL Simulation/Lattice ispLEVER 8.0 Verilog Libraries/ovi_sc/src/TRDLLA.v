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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/TRDLLA.v,v 1.10 2005/05/19 19:07:02 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module TRDLLA (CLKI, RSTN, ALUHOLD, UDDCNTL, SMIADDR9, SMIADDR8, SMIADDR7, SMIADDR6,
               SMIADDR5, SMIADDR4, SMIADDR3, SMIADDR2, SMIADDR1, SMIADDR0, SMIRD, SMIWR,
               SMICLK, SMIWDATA, SMIRSTN,
               CLKOP, CLKOS, LOCK, DCNTL0, DCNTL1, DCNTL2, DCNTL3, DCNTL4, DCNTL5, DCNTL6,
               DCNTL7, DCNTL8, SMIRDATA);
input CLKI, RSTN, ALUHOLD, UDDCNTL, SMIADDR9, SMIADDR8, SMIADDR7, SMIADDR6;
input SMIADDR5, SMIADDR4, SMIADDR3, SMIADDR2, SMIADDR1, SMIADDR0, SMIRD, SMIWR;
input SMICLK, SMIWDATA, SMIRSTN;
output CLKOP, CLKOS, LOCK, DCNTL0, DCNTL1, DCNTL2, DCNTL3, DCNTL4, DCNTL5, DCNTL6;
output DCNTL7, DCNTL8, SMIRDATA;

parameter CLKOP_PHASE = 0;
parameter CLKOS_PHASE = 0;
parameter CLKOS_FPHASE = 0;
parameter CLKOP_DUTY50 = "DISABLED";
parameter CLKOS_DUTY50 = "DISABLED";
parameter CLKOS_DIV = 1;
parameter GSR = "DISABLED";
parameter CLKOS_FDEL_ADJ = "DISABLED";
parameter CLKOS_FPHASE_ADJVAL = 0;
parameter ALU_LOCK_CNT = 3;
parameter ALU_UNLOCK_CNT = 3;
parameter GLITCH_TOLERANCE = 0;
parameter DCNTL_ADJVAL = 0;
parameter SMI_OFFSET= 12'h410;
parameter SMI_ADDR_DIS=10'b0000000000;
parameter LOCK_DELAY=100;

wire CLKIB, RSTNB, UDDCNTLB;
reg g_reset, clock_valid, lock_valid, real_lock;
wire resetn;
reg  set_resetn, CLKOP_reg, CLKOS_reg;
integer cntl_ratio, cntl_int;
wire [8:0] cntl_reg;
reg  [8:0] cntl_reg_final;
reg  [8:0] cntl_reg_update;
realtime next_clock_edge, last_clock_edge;
realtime t_in_clk, t_in_clk1, t_in_clk2, lock_delay_reg;
realtime t_180, t_90, t_270, t_360, t_45 , t_22, t_11;
realtime delta, cntl_delay;
reg cntl_valid, clock_p, clock_s, clock_s_del, clock_s_del_d2, clock_s_del_d4, clock_s_final;

initial
begin
   lock_delay_reg = 1.0;
   cntl_reg_update = 9'b000000000;
   cntl_ratio = 0;
   delta = 0.02;
   cntl_valid = 1'b1;
   clock_p = 1'b0;
   clock_valid = 1'b0;
   clock_s = 1'b0;
   clock_s_del = 1'b0;
   clock_s_del_d2 = 1'b0;
   clock_s_del_d4 = 1'b0;
end

supply0 VSS;
buf (SMIRDATA , VSS);
buf U1 (CLKIB, CLKI);
buf U2 (UDDCNTLB, UDDCNTL);
buf U3 (RSTNB, RSTN);
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

     if (t_90 > 0)
        begin
           cntl_ratio = (t_90 / delta);
        end
   end

  assign cntl_reg = cntl_ratio;

  always @(cntl_reg or UDDCNTLB or clock_valid)
  begin
     if (clock_valid == 1'b1)
     begin
        if (UDDCNTLB == 1'b1)
        begin
           cntl_reg_update <= cntl_reg;
        end
     end
  end

  always @(set_resetn or cntl_reg_update)
  begin
     if (set_resetn == 1'b0)
        cntl_reg_final <= 9'b000000000;
     else
        cntl_reg_final <= cntl_reg_update;
  end
//  assign cntl_reg_final = cntl_reg_update;

  always @(cntl_reg)
  begin
     cntl_int = cntl_reg;
  end
  always @(cntl_int)
  begin
     cntl_delay = cntl_int * delta;
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

  always @(CLKIB or lock_valid)
  begin
     if (CLKOP_PHASE == 0)
     begin
        if (lock_valid == 1'b1)
           clock_p <= CLKIB;
        else if (lock_valid == 1'b0)
           clock_p <= 1'b0;
     end
     else if (CLKOP_PHASE == 90)
     begin
        if (lock_valid == 1'b1)
           clock_p <= #t_90 CLKIB;
        else if (lock_valid == 1'b0)
           clock_p <= 1'b0;
     end
     else if (CLKOP_PHASE == 180)
     begin
        if (lock_valid == 1'b1)
           clock_p <= #t_180 CLKIB;
        else if (lock_valid == 1'b0)
           clock_p <= 1'b0;
     end
     else if (CLKOP_PHASE == 270)
     begin
        if (lock_valid == 1'b1)
           clock_p <= #t_270 CLKIB;
        else if (lock_valid == 1'b0)
           clock_p <= 1'b0;
     end
     else if (CLKOP_PHASE == 360)
     begin
        if (lock_valid == 1'b1)
           clock_p <= #t_360 CLKIB;
        else if (lock_valid == 1'b0)
           clock_p <= 1'b0;
     end
  end 

  always @(CLKIB or lock_valid)
  begin
     if (CLKOS_PHASE == 0)
     begin
        if (lock_valid == 1'b1)
           clock_s <= CLKIB;
        else if (lock_valid == 1'b0)
           clock_s <= 1'b0;
     end
     else if (CLKOS_PHASE == 90)
     begin
        if (lock_valid == 1'b1)
           clock_s <= #t_90 CLKIB;
        else if (lock_valid == 1'b0)
           clock_s <= 1'b0;
     end
     else if (CLKOS_PHASE == 180)
     begin
        if (lock_valid == 1'b1)
           clock_s <= #t_180 CLKIB;
        else if (lock_valid == 1'b0)
           clock_s <= 1'b0;
     end
     else if (CLKOS_PHASE == 270)
     begin
        if (lock_valid == 1'b1)
           clock_s <= #t_270 CLKIB;
        else if (lock_valid == 1'b0)
           clock_s <= 1'b0;
     end
     else if (CLKOS_PHASE == 360)
     begin
        if (lock_valid == 1'b1)
           clock_s <= #t_360 CLKIB;
        else if (lock_valid == 1'b0)
           clock_s <= 1'b0;
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

  always @(clock_s_final or lock_valid or set_resetn)
  begin
     if (set_resetn == 1'b0)
     begin
        CLKOS_reg = 1'b0;
     end
     else if (lock_valid == 1'b1)
     begin
        CLKOS_reg = clock_s_final;
     end
  end

  always @(clock_p or lock_valid or set_resetn)
  begin
     if (set_resetn == 1'b0)
     begin
        CLKOP_reg = 1'b0;
     end
     else if (lock_valid == 1'b1)
     begin
        CLKOP_reg = clock_p;
     end
  end

  buf (CLKOS, CLKOS_reg);
  buf (CLKOP, CLKOP_reg);
  buf (LOCK, real_lock);

endmodule

`endcelldefine

