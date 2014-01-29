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
// $Header: /home/rlp/Orfdry/env_rcs/verilog/pkg/versclibs/data/orca5/RCS/EHXPLLA.v,v 1.14 2005/09/14 19:47:13 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 10 fs


`celldefine

module EHXPLLA (SMIADDR9, SMIADDR8, SMIADDR7, SMIADDR6, SMIADDR5, SMIADDR4, 
             SMIADDR3, SMIADDR2, SMIADDR1, SMIADDR0,
             SMIRD, SMIWR, SMICLK, SMIWDATA, SMIRDATA, SMIRSTN, CLKI, CLKFB, RSTN,
             CLKOS, CLKOP, LOCK, CLKINTFB);

input SMIADDR9, SMIADDR8, SMIADDR7, SMIADDR6, SMIADDR5, SMIADDR4; 
input SMIADDR3, SMIADDR2, SMIADDR1, SMIADDR0;
input SMIRD, SMIWR, SMICLK, SMIWDATA, SMIRSTN, CLKI, CLKFB, RSTN;

output CLKOS, CLKOP, LOCK, CLKINTFB, SMIRDATA;

parameter CLKI_DIV = 1;    // 1 to 64
parameter CLKFB_DIV = 1; 
parameter CLKOP_DIV = 1; 
parameter CLKOS_DIV = 1; 
parameter CLKI_FDEL = 0;   //0, 100, 200, ....700 ps 
parameter CLKFB_FDEL = 0;   //0, 100, 200, ....700 ps 
parameter CLKOS_FDEL = 0;   //0, 100, 200, ....700 ps 
parameter CLKOP_MODE = "BYPASS";   //"BYPASS", "FDEL0", "VCO", "DIV" 
parameter CLKOS_MODE = "BYPASS";   //"BYPASS", "FDEL", "VCO", "DIV" 
parameter PHASEADJ = 0;   //0, 45, 90, 135, 180, 225, 270, 315 
parameter GSR = "ENABLED";
parameter SMI_OFFSET= 12'h410;
parameter SMI_ADDR_DIS=10'b0000000000;
parameter LOCK_DELAY = 100;
parameter CLKOS_VCODEL = 0; // 0, 1, 2, ... 31  0 => disabled

wire CLKINB, FBB, CLKOS, CLKOP, LOCK, CLKINTFB;
wire SMIRDB, SMIWRB, SMICLKB, SMIWDATAB, SMIRSTNB;

reg CLKOSREG, CLKOPREG, LOCKREG, CLKINTFBREG;

reg first_time2, first_time3; 
reg first_time5, first_time6, first_time7;
reg false_clk_first_time, fb_first_time;

reg false_clk, false_clkos, false_clkop; 

reg clock_valid, clock_invalid, g_reset, out_clk_valid;
wire set_resetn;


reg vir_sclk, vir_pclk, vir_lock, vir_intfb;
reg final_sclk, final_pclk, final_lock, final_intfb;

reg clkfb_per_valid, intfb_out, lock_all, lock_all1, lock_all2; 

realtime next_clock_edge, last_clock_edge;
realtime next_clock_edge1, last_clock_edge1;
realtime t_in_clk, t_in_clk1, t_in_clk2, t_in_clk3;
realtime t_vco, ha_vco;
realtime t_fb_clk, t_intfb_clock, ha_intfb_clk;
realtime false_t_int, false_t1_int, mclock_delay, mnclock_duty;
realtime first_int_edge, first_fb_edge;
realtime total_fb_delay, virtual_delay1;
realtime real_delay, real_delay1, real_delay2, lock_delay_reg;

real ext_divider, net_divide;

integer fb_count, index_clkos, index_clkop, index1, index2, ratio1;

integer    CLKOS_VCODEL_REG;
integer    CLKI_DIV_REG;
integer    CLKFB_DIV_REG;
integer    CLKOS_DIV_REG;
integer    CLKOP_DIV_REG;
integer    PHASEADJ_REG;
integer    CLKI_FDEL_REG;
integer    CLKFB_FDEL_REG;
integer    CLKOS_FDEL_REG;
integer    DISABLED_GSR_REG;
integer    smi_id_int;
integer    lock_count;
reg [5:0]  smi_id_reg;
reg [9:0]  addr_dis_reg;
reg        valid_pll;
reg        memchg;
reg        lockout;
reg        WEN;
reg [1:0]  STATE;
reg [2:0]  COUNT;
reg [3:0]  BYTE_SEL;
reg [7:0]  D;
reg [127:0]  MEM;
wire [9:0] pll_addr;
wire [9:0] ipll_addr;
wire       CLKINB_DEL, FBB_DEL;
wire       false_clkos_int;
reg  clkop_first_time, clkos_first_time;

//following variables are added to compensate vco rounding error
integer ha_vco_xprec;
realtime ha_vco_sim, round_err;
real index=0.0;
integer small_div;

tri1 GSR_sig = GSR_INST.GSRNET;
tri1 PUR_sig = PUR_INST.PURNET;

buf U1 (CLKOS, CLKOSREG);
buf U2 (CLKOP, CLKOPREG);
buf U3 (LOCK, LOCKREG);
buf U4 ( CLKINTFB, CLKINTFBREG);
buf U5 (CLKINB, CLKI);
buf U6 (FBB, CLKFB);
buf U7 (RSTNB, RSTN);

  always @ (GSR_sig or PUR_sig or DISABLED_GSR_REG) begin
    if (DISABLED_GSR_REG == 0) begin
      g_reset = GSR_sig & PUR_sig ;
    end
    else if (DISABLED_GSR_REG == 1)
      g_reset = PUR_sig;
  end

  assign set_resetn = g_reset & RSTNB;

// INITIALIZE all the internal signals to 0 at the start
// of the simulation cycle.
  initial
   begin
   clkop_first_time = 1'b1;
   clkos_first_time = 1'b1;
//   #15
//   clkop_first_time = 1'b0;
//   clkos_first_time = 1'b0;
  end

initial begin
MEM[127:0] = 0;
MEM[7:2] = (CLKI_DIV - 1);
MEM[15:10] = (CLKFB_DIV - 1);
MEM[23:18] = (CLKOS_DIV - 1);
MEM[31:26] = (CLKOP_DIV - 1);
MEM[34:32] = (CLKI_FDEL / 100);
MEM[37:35] = (CLKFB_FDEL / 100);
MEM[42:40] = (CLKOS_FDEL / 100);
MEM[45:43] = (PHASEADJ / 45);

  if (GSR == "DISABLED")
     MEM[94] = 1;
  else if (GSR == "ENABLED")
     MEM[94] = 0;

  if (CLKOS_MODE == "DIV")
     MEM[17:16] = 3;
  else if (CLKOS_MODE == "VCO")
     MEM[17:16] = 2;
  else if (CLKOS_MODE == "FDEL")
     MEM[17:16] = 1;
  else if (CLKOS_MODE == "BYPASS")
     MEM[17:16] = 0;

  if (CLKOP_MODE == "DIV")
     MEM[25:24] = 3;
  else if (CLKOP_MODE == "VCO")
     MEM[25:24] = 2;
  else if (CLKOP_MODE == "FDEL0")
     MEM[25:24] = 1;
  else if (CLKOP_MODE == "BYPASS")
     MEM[25:24] = 0;

CLKOS_VCODEL_REG = CLKOS_VCODEL;
fb_count = 0;
lock_count = 0;
lockout = 0;
first_time7 = 1;
first_time2 = 1;
ratio1 = 0;
out_clk_valid = 0;
lock_all = 0;
lock_all1 = 0;
vir_lock = 0;
clock_valid = 0;
clock_invalid = 1;
final_lock = 0;
final_sclk = 0;
final_pclk = 0;
vir_sclk = 0;
vir_pclk = 0;
vir_lock = 0;
vir_intfb = 0;
clkfb_per_valid = 0;
intfb_out = 0;
false_clk = 0;
false_clkos = 0;
false_clkop = 0;
CLKOSREG = 0;
CLKOPREG = 0;
CLKINTFBREG = 0;
LOCKREG = 0;
smi_id_int = ((SMI_OFFSET - 1024) / 16);
smi_id_reg = smi_id_int;
addr_dis_reg = SMI_ADDR_DIS;
memchg = 1'b0;
#1
memchg = 1'b1;
end

always @(MEM or memchg)
begin
   CLKI_DIV_REG = MEM[7:2] + 1; 
   CLKFB_DIV_REG = MEM[15:10] + 1; 
   CLKOS_DIV_REG = MEM[23:18] + 1; 
   CLKOP_DIV_REG = MEM[31:26] + 1; 
   CLKI_FDEL_REG = MEM[34:32];
   CLKFB_FDEL_REG = MEM[37:35];
   CLKOS_FDEL_REG = MEM[42:40];
   PHASEADJ_REG = MEM[45:43];
   DISABLED_GSR_REG = MEM[94];
   if (CLKOP_DIV_REG <= CLKOS_DIV_REG)
      small_div = CLKOP_DIV_REG;
   else
      small_div = CLKOS_DIV_REG; 
end

// SMI part of the model

buf (pll_addr[9], SMIADDR9);
buf (pll_addr[8], SMIADDR8);
buf (pll_addr[7], SMIADDR7);
buf (pll_addr[6], SMIADDR6);
buf (pll_addr[5], SMIADDR5);
buf (pll_addr[4], SMIADDR4);
buf (pll_addr[3], SMIADDR3);
buf (pll_addr[2], SMIADDR2);
buf (pll_addr[1], SMIADDR1);
buf (pll_addr[0], SMIADDR0);

assign ipll_addr = pll_addr & ~addr_dis_reg;

always @(ipll_addr)
begin
   if (ipll_addr[9:4] == smi_id_reg)
      valid_pll = 1'b1;
   else
      valid_pll = 1'b0;
end

buf (SMIWRB, SMIWR);
buf (SMIRDB, SMIRD);
buf (SMICLKB, SMICLK);
buf (SMIRSTNB, SMIRSTN);
buf (SMIWDATAB, SMIWDATA);

always @(posedge SMICLKB or negedge SMIRSTNB) begin
   if (!SMIRSTNB) begin
      STATE <= 0;
      COUNT <= 0;
   end
   else begin
      case (STATE)  
         2'b01 : begin  // read
                    if (& COUNT) STATE <= 2'b00;
                 end
         2'b10 : begin  // write
                    if (& COUNT) STATE <= 2'b11;
                 end
         default: begin  // 00 = idle while 11 = write enable
                    case ({SMIWRB, SMIRDB, valid_pll})  // synopsys full_case parallel_case
                       3'b011 : begin  // read begin
                                   STATE <= 2'b01;
                                end
                       3'b101 : begin  // write begin
                                   STATE <= 2'b10;
                                end
                       default: begin
                                   STATE <= 2'b00;
                                end
                    endcase
                 end
      endcase

      if (^ STATE | valid_pll & ^{SMIRDB, SMIWRB}) COUNT <= COUNT + 1;  // count for shifting
      else COUNT <= 0;  
   end
end

always @(posedge SMICLKB) begin
   if (~^ STATE & SMIRDB & valid_pll)  // read enable
      case (ipll_addr[3:0])  // synopsys full_case parallel_case
         4'b0000 : D <= MEM[7:0];
         4'b0001 : D <= MEM[15:8];
         4'b0010 : D <= MEM[23:16];
         4'b0011 : D <= MEM[31:24];
         4'b0100 : D <= MEM[39:32];
         4'b0101 : D <= MEM[47:40];
         4'b0110 : D <= MEM[55:48];
         4'b0111 : D <= MEM[63:56];
         4'b1000 : D <= MEM[71:64];
         4'b1001 : D <= MEM[79:72];
         4'b1010 : D <= MEM[87:80];
         4'b1011 : D <= MEM[95:88];
         4'b1100 : D <= MEM[103:96];
         4'b1101 : D <= MEM[111:104];
         4'b1110 : D <= MEM[119:112];
         4'b1111 : D <= MEM[127:120];
      endcase
   else D <= {SMIWDATAB, D[7:1]};  // right shifting

   if (~^ STATE & valid_pll & SMIWRB) BYTE_SEL <= ipll_addr[3:0];
end

always @(negedge SMICLKB or negedge SMIRSTNB)
   if (!SMIRSTNB) WEN <= 0;
   else WEN <= & STATE;  // write high for one cycle

  buf #0.01 (SMIRDATA, D[0]);

always @(WEN or STATE or BYTE_SEL) begin
   if (& STATE & !WEN)  // half cycle high on BYTE_WEN
      case (BYTE_SEL)  // synopsys full_case parallel_case
         4'b0000 : MEM[7:0] = D;
         4'b0001 : MEM[15:8] = D;
         4'b0010 : MEM[23:16] = D;
         4'b0011 : MEM[31:24] = D;
         4'b0100 : MEM[39:32] = D;
         4'b0101 : MEM[47:40] = D;
         4'b0110 : MEM[55:48] = D;
         4'b0111 : MEM[63:56] = D;
         4'b1000 : MEM[71:64] = D;
         4'b1001 : MEM[79:72] = D;
         4'b1010 : MEM[87:80] = D;
         4'b1011 : MEM[95:88] = D;
         4'b1100 : MEM[103:96] = D;
         4'b1101 : MEM[111:104] = D;
         4'b1110 : MEM[119:112] = D;
         4'b1111 : MEM[127:120] = D;
      endcase
end

// Generate False Clocks
initial begin
 false_clk = 1'b0;
 forever #5 false_clk = ~false_clk;
end

// Measure input clock period

  initial begin
   lock_delay_reg = 1.0;
   last_clock_edge = 0.0;
   next_clock_edge = 0.0;
   t_in_clk = 0.0;
   t_in_clk1 = 0.0;
   t_in_clk2 = 0.0;
   t_in_clk3 = 0.0;

  end

  assign #(CLKI_FDEL_REG * 0.1) CLKINB_DEL = CLKINB;
  assign #(CLKFB_FDEL_REG * 0.1) FBB_DEL = FBB;
  assign #(CLKOS_FDEL_REG * 0.1) false_clkos_int = false_clk;

// Generate false clkos and false clkop

  initial
   begin
    first_time2 = 1'b0;
    #1;
    first_time2 = 1'b1;
    index_clkos = 1'b0;
   end

  always @(false_clkos_int)
   begin
    if (first_time2 == 1 && false_clkos_int == 1)
      begin
      false_clkos = 1;
      first_time2 = 0;
      index_clkos = 0;
      end
    else
    index_clkos = index_clkos + 1;
    if (index_clkos == CLKOS_DIV_REG)
      begin
      false_clkos = ~false_clkos;
      index_clkos = 0;
      end
   end
// P3

  initial
   begin
    first_time3 = 1'b0;
    #1;
    first_time3 = 1'b1;
    index_clkop = 1'b0;
   end

  always @(false_clk)
   begin
    if (first_time3 == 1 && false_clk == 1)
      begin
      false_clkop = 1;
      first_time3 = 0;
      index_clkop=0;
      end
    else
    index_clkop = index_clkop + 1;
    if (index_clkop == CLKOP_DIV_REG)
      begin
      false_clkop = ~false_clkop;
      index_clkop = 0;
      end
   end

  always @(posedge FBB_DEL)
  begin
     fb_count = fb_count + 1;
     if (fb_count == 3)
        clkop_first_time = 1'b0;   
  end

  always @(posedge CLKINB_DEL)
   begin
   last_clock_edge=next_clock_edge;
   next_clock_edge=$realtime;

    if (last_clock_edge > 0) 
	begin
        t_in_clk <= next_clock_edge - last_clock_edge;
        t_in_clk1 <= t_in_clk;
        t_in_clk2 <= t_in_clk1;
        t_in_clk3 <= t_in_clk2;
	end


    if (t_in_clk > 0) 
        begin
         if ( ((t_in_clk - t_in_clk1) < 0.0001) && ((t_in_clk - t_in_clk1) > -0.0001) && ((t_in_clk1 - t_in_clk2) < 0.0001) && ((t_in_clk1 - t_in_clk2) > -0.0001) && ((t_in_clk2 - t_in_clk3) < 0.0001) && ((t_in_clk2 - t_in_clk3) > -0.0001))
//	 if (t_in_clk == t_in_clk3)
           clock_valid <= 1;
         else
           clock_valid <= 0;
        end

    if (t_in_clk > 0) 
        begin
         if ( ((t_in_clk - t_in_clk1) < 0.0001) && ((t_in_clk - t_in_clk1) > -0.0001))
//	 if (t_in_clk == t_in_clk1)
           clock_invalid <= 0;
         else
           clock_invalid <= 1;
        end

    if (t_in_clk > 0) 
        begin
           net_divide = (CLKFB_DIV_REG * ext_divider);
           t_vco = ((t_in_clk * CLKI_DIV_REG) / net_divide);
           ha_vco = (t_vco / 2 );
           ha_vco_xprec = ha_vco * 100000; //convert to time precision (multiply by 1ns/10fs), take integer value
           ha_vco_sim = ha_vco_xprec / 100000.0; //time as it appears in simulation (with precision error)
           round_err = ((t_in_clk - ((ha_vco_sim * 2 * net_divide) / CLKI_DIV_REG)) / 2);
           real_delay2 = ((t_vco * PHASEADJ_REG) / 8);
           real_delay = real_delay1 + real_delay2;
        end
   end

  always @(CLKINB_DEL)
  begin
     if (t_in_clk > 0)
     begin
        lockout <= #(8 * t_in_clk) CLKINB_DEL;
     end
  end 

  always @(posedge lockout)
  begin
     if (CLKINB_DEL == 1'b0)
        lock_count <= lock_count + 1;
     else
        lock_count <= 0;
  end
     
// Measure Feedback Clock Period

  initial begin
   last_clock_edge1 = 0.0;
   next_clock_edge1 = 0.0;
   false_t1_int = 5.0;
   first_time5 = 1'b1;
   //#1;
   //first_time5 = 1'b1;
  end

  always @(posedge FBB_DEL)
   begin
    last_clock_edge1=next_clock_edge1;
    next_clock_edge1=$realtime;

     if (last_clock_edge1 > 0) 
      begin
       if (first_time5 == 1)
       t_fb_clk = next_clock_edge1 - last_clock_edge1;
       first_time5 = 0;
      end

     if (t_fb_clk > 0)
     begin
        ext_divider = t_fb_clk / 10 ;
     end

     if (last_clock_edge1 > 0) 
      begin
       clkfb_per_valid=1;
      end

   end


// Measure the feedback delay value

  initial
   begin
   first_int_edge = 0.0;
   first_fb_edge = 0.0;
   virtual_delay1 = 0.0;
    false_clk_first_time = 1'b0;
    fb_first_time = 1'b0;
    #1;
    false_clk_first_time = 1'b1;
    fb_first_time = 1'b1;
   end

always @(posedge false_clk)
  begin
  if (false_clk_first_time == 1)
  first_int_edge=$realtime;
  false_clk_first_time = 1'b0; 
  end

always @(posedge FBB_DEL)
  begin
  if (fb_first_time == 1)
  first_fb_edge=$realtime;
  fb_first_time = 1'b0;
  end

always @(FBB_DEL or CLKINB_DEL)
  begin
  total_fb_delay = first_fb_edge - first_int_edge;

if ( (total_fb_delay > 0) && (t_in_clk > 0) )
   begin
      ratio1 = total_fb_delay / t_in_clk;
      virtual_delay1 = total_fb_delay - (t_in_clk * ratio1);
      real_delay1 = t_in_clk - virtual_delay1;
   end
end

  always @(posedge CLKINB_DEL or negedge set_resetn)
  begin
     if (set_resetn == 1'b0)
        out_clk_valid <= 1'b0;
     else
        if (fb_count >= 3)
        begin
           out_clk_valid <= clock_valid;
        end
  end


// Generate all CLOCKs in DELAY MODE
// P8  oscillator clock

  always @(out_clk_valid or intfb_out)
  begin
     if (out_clk_valid == 1'b0)
     begin
        intfb_out <= 1'b0;
        first_time7 <= 1'b1;
        index = 0.0;
     end
     else
     begin
        if (first_time7 == 1'b1)
        begin
           intfb_out <= 1'b1;
           first_time7 <= 1'b0;
           index = 0.0;
        end
        else
        begin
            index = index + 1.0;
            if (index == net_divide/(net_divide/small_div))
            begin
               intfb_out <= #(ha_vco + (round_err/(net_divide/small_div))) ~intfb_out;
               index = 0.0;
            end
            else
               intfb_out <= #ha_vco ~intfb_out;
        end
     end
  end


// P11 internal feedback clockout

  always @(intfb_out)
  begin
     vir_intfb <= #real_delay1 intfb_out;
  end

  always @(intfb_out)
  begin
     if (out_clk_valid == 1'b0)
        vir_lock <= 1'b0;
     else if (out_clk_valid == 1'b1)
        vir_lock <= 1'b1;
  end

// P9
  initial begin
   first_time6 = 1'b1;
   index1 = 1'b0;
   index2 = 1'b0;
  end

  always @(vir_intfb) 
   begin
    if (first_time6 == 1)
     begin
       if (vir_intfb == 1)
  	begin
  	vir_sclk <= 1;
  	vir_pclk <= 1;
//  	vir_lock <= 1;
  	first_time6 = 0;
  	index1 = 0;
  	index2 = 0;  
  	end //vir_intfb
     end
    else
     begin
     index1 = index1+1;
     index2 = index2+1;
       if (index1 == CLKOS_DIV_REG)
        begin
        vir_sclk <= ~vir_sclk;
        index1 = 0;
        end

     if (index2 == CLKOP_DIV_REG)
       begin
       vir_pclk <= ~vir_pclk;
       index2 = 0;
       end

     end
   end


// Generate LOCK signal

  always @(set_resetn or vir_lock or clock_invalid or out_clk_valid or lock_count)
   begin
    if ((set_resetn == 1'b0) || (clock_invalid == 1'b1) || (lock_count == 8))
     lock_all1 <= 1'b0;
    else 
    begin
       if (out_clk_valid == 1'b1)
          lock_all1 <= vir_lock;
    end
   end

  always @(lock_all1)
  begin
     if (lock_all1 == 1'b0)
        lock_all2 <= 1'b0;
     else if (lock_all1 == 1'b1)
        lock_all2 <= #(LOCK_DELAY * lock_delay_reg) lock_all1;
  end      

  always @(lock_all2)
  begin
     lock_all <= lock_all2;
  end     

// Select clocks with appropriate modes

//CLKOP Mode
  always @(CLKINB or set_resetn or vir_pclk or vir_intfb or lock_all)
  begin
     if (CLKOP_MODE == "BYPASS")
     begin
        final_pclk <= CLKINB;
        final_lock <= 1;
     end
     else if (set_resetn == 1'b0)
     begin
        final_pclk <= 0;
        final_intfb <= 0;
        final_lock <= 0;
     end
     else if (CLKOP_MODE == "FDEL0")
     begin
        final_pclk <= vir_intfb;
        final_intfb <= vir_intfb;
        final_lock <= lock_all;
     end
     else if (CLKOP_MODE == "VCO")
     begin
        final_pclk <= vir_intfb;
        final_intfb <= vir_intfb;
        final_lock <= lock_all;
     end
     else if (CLKOP_MODE == "DIV")
     begin
        final_pclk <=  vir_pclk;
        final_intfb <= vir_intfb;
        final_lock <= lock_all;
     end
  end

//CLKOS Mode
  always @(CLKINB or set_resetn or vir_sclk or vir_intfb)
  begin
     if (CLKOS_MODE == "BYPASS")
     begin
        final_sclk <= CLKINB;
     end
     else if (set_resetn == 1'b0)
     begin
        final_sclk <= 0;
     end
     else if (CLKOS_MODE == "FDEL")
     begin
        final_sclk <= #(real_delay2 + (CLKOS_FDEL_REG * 0.1)) vir_intfb;
     end
     else if (CLKOS_MODE == "VCO")
     begin
        final_sclk <= #real_delay2 vir_intfb;
     end
     else if (CLKOS_MODE == "DIV")
     begin
        final_sclk <= #((CLKOS_VCODEL_REG * t_vco) + real_delay2 + (CLKOS_FDEL_REG * 0.1)) vir_sclk;
     end
  end

// Functionality Section

  always @ (out_clk_valid or final_sclk or false_clk or false_clkos or set_resetn or clkos_first_time)
  begin
     if (clkop_first_time == 1'b1)
     begin
        if ((CLKOS_MODE == "DIV") | (CLKOS_MODE == "FDEL"))
           CLKOSREG = false_clkos;
        else
           CLKOSREG = false_clk;
     end
     else if (set_resetn == 1'b0)
     begin
        CLKOSREG = 1'b0;
//        clkos_first_time = 1'b0;
     end
     else if (out_clk_valid == 1'b1)
     begin
        CLKOSREG = final_sclk;
//        clkos_first_time = 1'b0;
     end
  end

  always @ (out_clk_valid or final_pclk or false_clk or set_resetn or false_clkop or final_lock or final_intfb or clkop_first_time)
  begin
     if (clkop_first_time == 1'b1)
     begin
        CLKOPREG = false_clkop;
        CLKINTFBREG <= false_clk;
        LOCKREG <= 0;
     end
     else if (set_resetn == 1'b0)
     begin
        CLKOPREG = 1'b0;
        CLKINTFBREG <= 1'b0;
        LOCKREG <= 1'b0;
//      clkop_first_time = 1'b0;
     end
     else if (out_clk_valid == 1'b1)
     begin
        CLKOPREG = final_pclk;
        CLKINTFBREG <= final_intfb;
        LOCKREG <= final_lock;
//      clkop_first_time = 1'b0;
     end
  end

endmodule

`endcelldefine

