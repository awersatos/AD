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
//                     U.S.A 
// 
//                     TEL: 1-800-Lattice (USA and Canada) 
//                          408-826-6000 (other locations) 
// 
//                     web: http://www.latticesemi.com/ 
//                     email: techsupport@latticesemi.com 
// 
// -------------------------------------------------------------------- 
// 
// Simulation Library File for GDX2 
// 
//$Header: R:/src/mod_kits/Mach/verilog/rcs/gdx2.v 1.35 2004/03/04 19:12:44Z jli Exp $ 
// 1.2 Added default timing to work around the zero time loop
// 1.3 Default propagation delay time is changed to zero
// 1.4 Change default pulse width and period to 1ns
`timescale 1ns / 1ps // TIMESCALE FOR THE LIBRARY
`define PUC


`celldefine

module MUX2 (O,I0,I1,S0); 
input I0,I1,S0; 
output O; 
supply0 GND; 
supply1 VCC; 
 
not INS1 (S_inv, S0); 
and INS2 (out_1, I0, S_inv); 
and INS3 (out_2, I1, S0); 
or  INS4 (O, out_1, out_2); 
 
specify 
 
(S0 => O) =  0:0:0, 0:0:0; 
(I0 => O) =  0:0:0, 0:0:0;  
(I1 => O) =  0:0:0, 0:0:0;  
 
endspecify 
 
 
endmodule 

`endcelldefine

`celldefine

module MUX4 (O,I0,I1,I2,I3,S0,S1); 
input I0,I1,I2,I3,S0,S1; 
output O; 
supply0 GND; 
supply1 VCC; 
 
 
not INS1 (S0_inv, S0); 
not INS9 (S1_inv, S1); 
and INS3 (out_1, I0, S0_inv, S1_inv); 
and INS4 (out_2, I1, S0, S1_inv); 
and INS5 (out_3, I2, S0_inv, S1); 
and INS6 (out_4, I3, S0, S1); 
or  INS7 (O, out_1, out_2, out_3, out_4); 
 
specify 
 
(S0 => O) =  0:0:0, 0:0:0;  
(S1 => O) =  0:0:0, 0:0:0; 
(I0 => O) =  0:0:0, 0:0:0;  
(I1 => O) =  0:0:0, 0:0:0;  
(I2 => O) =  0:0:0, 0:0:0;  
(I3 => O) =  0:0:0, 0:0:0;  
 
endspecify 
 
 
endmodule 

`endcelldefine

`timescale 10 ps / 10 ps
`celldefine 
`timescale 10 ps / 10 ps
 
module SPLL (CLK_OUT,CLK_IN); 
parameter in_freq = "100.00";
parameter clk_out_to_pin = "off";
parameter wake_on_lock = "off";
input CLK_IN; 
output CLK_OUT; 
supply0 GND; 
supply1 VCC; 
buf INS1 (CLK_OUT, CLK_IN); 
 
specify 
 
(CLK_IN => CLK_OUT) =  0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 


`timescale  10 ps / 10 ps
`celldefine 

`timescale  10 ps / 10 ps


module STDPLL (CLK_IN, CLK_OUT, PLL_LOCK);

parameter   in_freq  = "100.00";
parameter   clk_out_to_pin = "off";
parameter   wake_on_lock = "off";
parameter   div      = "1";
parameter   post     = "1";
parameter   mult     = "1";
parameter   pll_dly  = "0.00";
parameter   secdiv   = "2";
parameter   lock_cyc   = 2;
real clockboost;

input  CLK_IN;
output CLK_OUT, PLL_LOCK;
wire    CLK_OUT, PLL_LOCK;
wire    CLK_OUT_node, PLL_LOCK_node;

wire   clkin_in;

time   new_delay;
time   clklock_last_rising_edge;
time   clklock_last_falling_edge;
time   clklock_half_period1;
time   clklock_half_period0;
time   clklock_half_period;
time   clklock_half_period_minus_dly1;
time   clklock_half_period_minus_dly0;

reg [15:0] mult_r;
integer mult_i;
initial mult_r = mult;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = div;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [15:0] post_r;
integer post_i;
initial post_r = post;
initial post_i = 10 * convert_int(post_r[15:8]) + convert_int(post_r[7:0]);

reg [39:0] pll_dly_r;
real pll_delay, pll_dly_re, pll_dly_step;
real pll_dly_re_temp, pll_dly_re_temp_abs, pll_dly_step_temp;
initial pll_dly_r = pll_dly;

initial 
  begin
    if(pll_dly_r[23:16] == 8'b00101110)
      begin
      pll_dly_re_temp = convert_real(pll_dly_r[39:32]) * (convert_real(pll_dly_r[31:24]) + 0.1 * convert_real(pll_dly_r[15:8]) + 0.01 * convert_real(pll_dly_r[7:0]));
      pll_dly_re_temp_abs = convert_real(pll_dly_r[31:24]) + 0.1 * convert_real(pll_dly_r[15:8]) + 0.01 * convert_real(pll_dly_r[7:0]);
      end
    else if (pll_dly_r[15:8] == 8'b00101110)
      begin
      pll_dly_re_temp = convert_real(pll_dly_r[31:24]) * (convert_real(pll_dly_r[23:16]) + 0.1 * convert_real(pll_dly_r[7:0])); 
      pll_dly_re_temp_abs = convert_real(pll_dly_r[23:16]) + 0.1 * convert_real(pll_dly_r[7:0]); 
      end
  end

initial  pll_dly_step_temp = convert_int(pll_dly_r[15:8]) * convert_int(pll_dly_r[7:0]) *0.25;

initial
      if(pll_dly_re_temp >= 0)
       pll_dly_re = pll_dly_re_temp_abs;
      else
       pll_dly_re = pll_dly_re_temp;

initial
      if(pll_dly_step_temp >= 0)
       pll_dly_step = 0.25 * convert_real(pll_dly_r[7:0]);
      else
       pll_dly_step = pll_dly_step_temp; 

reg real_or_step;
initial real_or_step = 1'b0;  // real

initial
  begin
      if (pll_dly_r[39:16] == 24'h000000)
        begin
            begin
              real_or_step = 1'b1;
              pll_delay = pll_dly_step;
            end
        end
      else  
         begin
              real_or_step = 1'b0;
              pll_delay = pll_dly_re;
         end
  end                                                    


initial begin
  clklock_half_period1 = 0;
  clklock_half_period0 = 0;
  clklock_half_period = 0;
  clklock_half_period_minus_dly1 = 0;
  clklock_half_period_minus_dly0 = 0;
  clockboost     = mult_i/div_i;
  new_delay      = (real_or_step == 1'b0) ? (pll_dly_re_temp_abs * 100.0) : (0.25 * convert_int(pll_dly_r[7:0]) * 100.0);
end


integer   cnt_m_div;
reg       clk_out_m_div;


buf buf_clkin (clkin_in, CLK_IN);

integer clklock_rising_edge_count;
integer clklock_falling_edge_count;

initial
begin
	cnt_m_div = -1;
	clk_out_m_div = 0;
        clklock_rising_edge_count = 0;
        clklock_falling_edge_count = 0;
end

always @(posedge clkin_in) 
begin
    clklock_rising_edge_count = clklock_rising_edge_count + 1;
    clklock_last_rising_edge = $time;
end

always @(negedge clkin_in)
begin
    clklock_falling_edge_count = clklock_falling_edge_count + 1;
    clklock_last_falling_edge = $time;
end

always @(posedge clkin_in)
begin
    if (clklock_falling_edge_count == 2)
       clklock_half_period0 = ($time - clklock_last_falling_edge)*div_i/mult_i;
       clklock_half_period_minus_dly0 = ($time - clklock_last_falling_edge) + 100.0 * pll_delay;
end

always @(negedge clkin_in) 
begin
    if (clklock_rising_edge_count == 1)
       clklock_half_period1 = ($time - clklock_last_rising_edge)*div_i/mult_i;
       clklock_half_period_minus_dly1 = ($time - clklock_last_rising_edge) + 100.0 * pll_delay; 
end

always @(negedge clkin_in) 
begin
clklock_half_period = (clklock_half_period0 + clklock_half_period1)/2.0; 
end

integer   i, n, clock_count, clock_count_falling;
reg       clock_out_sig;

initial
begin
	clock_out_sig = 1'b0;
	clock_count = -1;
	clock_count_falling = -1;
end
always @(clklock_rising_edge_count)
begin
    if (clklock_rising_edge_count > lock_cyc + 1)
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count = clock_count + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count = clock_count + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count = 0;
end

always @(clklock_falling_edge_count)
begin
    if (clklock_falling_edge_count > lock_cyc + 1)
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count_falling = clock_count_falling + 1;
              #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count_falling = clock_count_falling + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count_falling = 0;
end

reg PLL_LOCK_plus,PLL_LOCK_minus;
reg CLK_OUT_sig_d_start;

initial
begin
	PLL_LOCK_plus  = 1'b0;
	PLL_LOCK_minus = 1'b0;
	CLK_OUT_sig_d_start = 1'b0;
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    CLK_OUT_sig_d_start = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    PLL_LOCK_plus = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 3)
    PLL_LOCK_minus = 1'b1;
end

reg CLK_OUT_sig_d_not;
initial
begin
    CLK_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #clklock_half_period1 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
         #clklock_half_period0 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
      end
end

wire CLK_OUT_sig_d = ~CLK_OUT_sig_d_not && CLK_OUT_sig_d_start;


reg CLK_OUT_sig_3d;
wire CLK_OUT_plus_delay;

reg start_CLK_OUT;

initial 
begin
CLK_OUT_sig_3d = 1'b0; start_CLK_OUT = 1'b0;
end

always @(clock_count_falling)
begin
  if (clock_count_falling == 1)
  begin
    #clklock_half_period_minus_dly0 CLK_OUT_sig_3d = 1'b1; start_CLK_OUT = 1'b1;
  end
end

always @(start_CLK_OUT)
begin
 while (start_CLK_OUT) 
      begin
         #clklock_half_period1 
         CLK_OUT_sig_3d = ~ CLK_OUT_sig_3d;
         #clklock_half_period0 
         CLK_OUT_sig_3d = ~ CLK_OUT_sig_3d;
      end
end


assign #new_delay CLK_OUT_plus_delay = CLK_OUT_sig_d;


assign PLL_LOCK_node = PLL_LOCK_plus && (pll_delay>=0) || PLL_LOCK_minus && (pll_delay<0) ;
assign CLK_OUT_node = (CLK_OUT_plus_delay && (pll_delay >=0) || CLK_OUT_sig_3d && (pll_delay<0));
buf INSXQ1 (PLL_LOCK,PLL_LOCK_node);
buf INSXQ2 (CLK_OUT,CLK_OUT_node);

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else if (int_str == "-")
      convert_int = -1;
    else
      convert_int = 0;

  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction
specify
      (CLK_IN => CLK_OUT)  =  0:0:0, 0:0:0;
      (CLK_IN => PLL_LOCK) =  0:0:0, 0:0:0;
endspecify
endmodule


`endcelldefine 



`timescale  10 ps / 10 ps
`celldefine 
`timescale 10 ps / 10 ps

module STDPLLX (CLK_IN, PLL_FBK, PLL_RST,CLK_OUT, PLL_LOCK, SEC_OUT);

parameter   in_freq    = "100.0";
parameter   clk_out_to_pin = "off";
parameter   wake_on_lock = "off";
parameter   div        = "1";
parameter   post       = "1";
parameter   mult       = "1";
parameter   pll_dly    = "0.00";
parameter   secdiv     = "2";
parameter   lock_cyc   = 2;
integer     clockboost;

input  CLK_IN, PLL_FBK, PLL_RST;
output CLK_OUT, PLL_LOCK, SEC_OUT;
wire   CLK_OUT, PLL_LOCK;
wire   CLK_OUT_node, PLL_LOCK_node, SEC_OUT_node;
wire   clkin_in;

time   new_delay;
time   secd_delay1;
time   secd_delay0;
time   secd_delay;
time   secd_delay_minus1;
time   secd_delay_minus0;

time   clklock_last_rising_edge;
time   clklock_last_falling_edge;
time   clklock_half_period1;
time   clklock_half_period0;
time   clklock_half_period;
time   clklock_half_period_minus_dly1;
time   clklock_half_period_minus_dly0;

reg [15:0] mult_r;
integer mult_i;
initial mult_r = mult;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = div;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [15:0] secdiv_r;
integer secdiv_i;
initial secdiv_r = secdiv;
initial secdiv_i = 10 * convert_int(secdiv_r[15:8]) + convert_int(secdiv_r[7:0]);

reg [15:0] post_r;
integer post_i;
initial post_r = post;
initial post_i = 10 * convert_int(post_r[15:8]) + convert_int(post_r[7:0]);

reg [39:0] pll_dly_r;
real pll_delay, pll_dly_re, pll_dly_step;
real pll_dly_re_temp, pll_dly_re_temp_abs, pll_dly_step_temp;
initial pll_dly_r = pll_dly;

initial 
  begin
    if(pll_dly_r[23:16] == 8'b00101110)
      begin
      pll_dly_re_temp = convert_real(pll_dly_r[39:32]) * (convert_real(pll_dly_r[31:24]) + 0.1 * convert_real(pll_dly_r[15:8]) + 0.01 * convert_real(pll_dly_r[7:0]));
      pll_dly_re_temp_abs = convert_real(pll_dly_r[31:24]) + 0.1 * convert_real(pll_dly_r[15:8]) + 0.01 * convert_real(pll_dly_r[7:0]);
      end
    else if (pll_dly_r[15:8] == 8'b00101110)
      begin
      pll_dly_re_temp = convert_real(pll_dly_r[31:24]) * (convert_real(pll_dly_r[23:16]) + 0.1 * convert_real(pll_dly_r[7:0])); 
      pll_dly_re_temp_abs = convert_real(pll_dly_r[23:16]) + 0.1 * convert_real(pll_dly_r[7:0]); 
      end
  end

initial  pll_dly_step_temp = convert_int(pll_dly_r[15:8]) * convert_int(pll_dly_r[7:0]) *0.25;

initial
      if(pll_dly_re_temp >= 0)
       pll_dly_re = pll_dly_re_temp_abs;
      else
       pll_dly_re = pll_dly_re_temp;

initial
      if(pll_dly_step_temp >= 0)
       pll_dly_step = 0.25 * convert_real(pll_dly_r[7:0]);
      else
       pll_dly_step = pll_dly_step_temp; 

reg real_or_step;
initial real_or_step = 1'b0;  // real

initial
  begin
      if (pll_dly_r[39:16] == 24'h000000)
        begin
            begin
              real_or_step = 1'b1;
              pll_delay = pll_dly_step;
            end
        end
      else  
         begin
              real_or_step = 1'b0;
              pll_delay = pll_dly_re;
         end
  end                                           

initial begin
  clklock_half_period1 = 0;
  clklock_half_period0 = 0;
  clklock_half_period = 0;
  clklock_half_period_minus_dly1 = 0;
  clklock_half_period_minus_dly0 = 0;
  clockboost     = mult_i/div_i;
  new_delay      = (real_or_step == 1'b0) ? (pll_dly_re_temp_abs * 100.0) : (0.25 * convert_int(pll_dly_r[7:0]) * 100.0);
end


integer   cnt_m_div;
wire      clkin_m_div;
reg       clk_out_m_div;


buf buf_clkin (clkin_in, CLK_IN);

integer clklock_rising_edge_count;
integer clklock_falling_edge_count;

initial
begin
	cnt_m_div = -1;
	clk_out_m_div = 0;
        clklock_rising_edge_count = 0;
        clklock_falling_edge_count = 0;
end

always @(posedge clkin_in) 
begin
    casez(PLL_FBK)
        1'bX : $display("Error : PLL feedback unknown.");
    endcase
end

always @(posedge clkin_in) 
begin
    clklock_rising_edge_count = clklock_rising_edge_count + 1;
    clklock_last_rising_edge = $time;
end

always @(negedge clkin_in)
begin
    clklock_falling_edge_count = clklock_falling_edge_count + 1;
    clklock_last_falling_edge = $time;
end

always @(posedge clkin_in)
begin
    if (clklock_falling_edge_count == 2)
       clklock_half_period0 = ($time - clklock_last_falling_edge)*div_i/mult_i;
       clklock_half_period_minus_dly0 = ($time - clklock_last_falling_edge) + 100.0 * pll_delay; 
       secd_delay0 = clklock_half_period0 * secdiv_i;
       secd_delay_minus0 = clklock_half_period0 * secdiv_i + 100.0 * pll_delay; 
end

always @(negedge clkin_in) 
begin
    if (clklock_rising_edge_count == 1)
       clklock_half_period1 = ($time - clklock_last_rising_edge)*div_i/mult_i;
       clklock_half_period_minus_dly1 = ($time - clklock_last_rising_edge) + 100.0 * pll_delay; 
       secd_delay1 = clklock_half_period1 * secdiv_i;
       secd_delay_minus1 = clklock_half_period1 * secdiv_i + 100.0 * pll_delay; 
end

integer   i, n, clock_count, clock_count_falling;
reg       clock_out_sig;

initial
begin
	clock_out_sig = 1'b0;
	clock_count = -1;
	clock_count_falling = -1;
end
always @(clklock_rising_edge_count)
begin
    if (clklock_rising_edge_count > lock_cyc + 1 && !PLL_RST)
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count = clock_count + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count = clock_count + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count = 0;
end

always @(clklock_falling_edge_count)
begin
    if (clklock_falling_edge_count > lock_cyc + 1 && !PLL_RST)
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
              clock_count_falling = clock_count_falling + 1;
              #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count_falling = clock_count_falling + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count_falling = 0;
end

reg PLL_LOCK_plus,PLL_LOCK_minus;
reg CLK_OUT_sig_d_start;
reg SEC_OUT_sig_d_start;

initial
begin
	PLL_LOCK_plus  = 1'b0;
	PLL_LOCK_minus = 1'b0;
	CLK_OUT_sig_d_start = 1'b0;
	SEC_OUT_sig_d_start = 1'b0;
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    PLL_LOCK_plus = 1'b1;
    CLK_OUT_sig_d_start = 1'b1;
    SEC_OUT_sig_d_start = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 3)
    PLL_LOCK_minus = 1'b1;
end

reg CLK_OUT_sig_d_not;
initial
begin
    CLK_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #clklock_half_period1 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
         #clklock_half_period0 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
      end
end

wire CLK_OUT_sig_d = ~CLK_OUT_sig_d_not && CLK_OUT_sig_d_start;

reg CLK_OUT_sig_3d;
wire CLK_OUT_plus_delay;

reg SEC_OUT_sig_3d;

reg start_CLK_OUT;

initial 
begin
CLK_OUT_sig_3d = 1'b0; start_CLK_OUT = 1'b0;
end

always @(clock_count_falling)
begin
  if (clock_count_falling == 1)
  begin
    #clklock_half_period_minus_dly0 CLK_OUT_sig_3d = 1'b1; start_CLK_OUT = 1'b1;
  end
end

always @(start_CLK_OUT)
begin
 while (start_CLK_OUT) 
      begin
         #clklock_half_period1 
         CLK_OUT_sig_3d = ~ CLK_OUT_sig_3d;
         #clklock_half_period0 
         CLK_OUT_sig_3d = ~ CLK_OUT_sig_3d;
      end
end

reg start_SEC_OUT;

initial 
begin
SEC_OUT_sig_3d = 1'b0; start_SEC_OUT = 1'b0;
end

always @(clock_count_falling)
begin
  if (clock_count_falling == 1)
  begin
    #clklock_half_period_minus_dly0 SEC_OUT_sig_3d = 1'b1; start_SEC_OUT = 1'b1;
  end
end

always @(start_SEC_OUT)
begin
      while (start_SEC_OUT) 
      begin
         #secd_delay1 
         SEC_OUT_sig_3d = ~ SEC_OUT_sig_3d;
         #secd_delay0 
         SEC_OUT_sig_3d = ~ SEC_OUT_sig_3d;
      end
end


assign #new_delay CLK_OUT_plus_delay = CLK_OUT_sig_d;

assign PLL_LOCK_node = !PLL_RST && (PLL_LOCK_plus && (pll_delay>=0) || PLL_LOCK_minus && (pll_delay<0));
assign CLK_OUT_node = !PLL_RST && (CLK_OUT_plus_delay && (pll_delay >=0) || CLK_OUT_sig_3d && (pll_delay<0));
buf INSXQ1 (PLL_LOCK,PLL_LOCK_node);
buf INSXQ2 (CLK_OUT,CLK_OUT_node);


reg SEC_OUT_sig_d_not;
initial
begin
    SEC_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #secd_delay1 
         SEC_OUT_sig_d_not = ~ SEC_OUT_sig_d_not;
         #secd_delay0 
         SEC_OUT_sig_d_not = ~ SEC_OUT_sig_d_not;
      end
end

wire SEC_OUT_sig_d = ~SEC_OUT_sig_d_not && SEC_OUT_sig_d_start;

wire SEC_OUT_plus_delay;

assign #new_delay SEC_OUT_plus_delay = SEC_OUT_sig_d;

assign SEC_OUT_node = !PLL_RST &&  (SEC_OUT_plus_delay && (pll_delay >=0) || SEC_OUT_sig_3d && (pll_delay<0));
buf INSXQ3 (SEC_OUT,SEC_OUT_node);
function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else if (int_str == "-")
      convert_int = -1;
    else
      convert_int = 0;

  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction

specify 
 
(PLL_RST => PLL_LOCK) =  0:0:0, 0:0:0;
(CLK_IN => CLK_OUT)   =   0:0:0, 0:0:0;
(CLK_IN => PLL_LOCK)  =   0:0:0, 0:0:0;
(CLK_IN => SEC_OUT)   =   0:0:0, 0:0:0;
 
endspecify 

endmodule

`endcelldefine 



`celldefine 
 
module AND2 (O,I0,I1); 
input I0,I1; 
output O; 
supply0 GND; 
supply1 VCC; 
and INS1 (O, I0, I1); 
 
specify 
 
(I0 => O) =  0:0:0, 0:0:0; 
(I1 => O) =  0:0:0, 0:0:0; 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module AND3 (O,I0,I1,I2); 
input I0,I1,I2; 
output O; 
supply0 GND; 
supply1 VCC; 
and INS1 (O, I0, I1, I2); 
 
specify 
 
(I0 => O) =  0:0:0, 0:0:0;
(I1 => O) =  0:0:0, 0:0:0;
(I2 => O) =  0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module AND4 (O,I0,I1,I2,I3); 
input I0,I1,I2,I3; 
output O; 
supply0 GND; 
supply1 VCC; 
and INS1 (O, I0, I1, I2, I3); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module AND5 (O,I0,I1,I2,I3,I4); 
input I0,I1,I2,I3,I4; 
output O; 
supply0 GND; 
supply1 VCC; 
and INS1 (O, I0, I1, I2, I3, I4); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
(I4 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module AND6 (O,I0,I1,I2,I3,I4,I5); 
input I0,I1,I2,I3,I4,I5; 
output O; 
supply0 GND; 
supply1 VCC; 
and INS1 (O, I0, I1, I2, I3, I4, I5); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
(I4 => O) = 0:0:0, 0:0:0;
(I5 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module AND7 (O,I0,I1,I2,I3,I4,I5,I6); 
input I0,I1,I2,I3,I4,I5,I6; 
output O; 
supply0 GND; 
supply1 VCC; 
and INS1 (O, I0, I1, I2, I3, I4, I5, I6); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
(I4 => O) = 0:0:0, 0:0:0;
(I5 => O) = 0:0:0, 0:0:0;
(I6 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module AND8 (O,I0,I1,I2,I3,I4,I5,I6,I7); 
input I0,I1,I2,I3,I4,I5,I6,I7; 
output O; 
supply0 GND; 
supply1 VCC; 
and INS1 (O, I0, I1, I2, I3, I4, I5, I6, I7); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
(I4 => O) = 0:0:0, 0:0:0;
(I5 => O) = 0:0:0, 0:0:0;
(I6 => O) = 0:0:0, 0:0:0;
(I7 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module BI_DIR (O,I0,IO,OE); 
input I0,OE; 
inout IO; 
output O; 
 
supply0 GND; 
supply1 VCC; 

reg IO0, O0;
wire IO1;

parameter PULL = "Off";
parameter OUTOPEN = "Off";

buf INSXQ1 (O,O0);
//assign IO = IO0;
bufif1 INSXQ2 (IO,IO0,OE);
//assign IO1 = IO;
buf INSXQ3 (IO1,IO);
always @(IO1)
begin
 if (PULL == "Off")
        case(IO1)
           1'b0: O0 = 1'b0;
           1'b1: O0 = 1'b1;
           1'bz: O0 = 1'bx;
           1'bx: O0 = 1'bx;
        endcase
 else if (PULL == "Up")
        case(IO1)
           1'b0: O0 = 1'b0;
           1'b1: O0 = 1'b1;
           1'bz: O0 = 1'b1;
        endcase
 else if (PULL == "Down")
        case(IO1)
           1'b0: O0 = 1'b0;
           1'b1: O0 = 1'b1;
           1'bz: O0 = 1'b0;
        endcase
 else if (PULL == "Hold")
        case(IO1)
           1'b0: O0 = 1'b0;
           1'b1: O0 = 1'b1;
           1'bz: O0 = O0;
        endcase
end


always @(OE or I0)
  begin
     if (OE == 1'b0)
         IO0 = 1'bz;
     else if (OE == 1'b1)
            if (OUTOPEN == "Off")
               case(I0)
                 1'b0: IO0 = 1'b0;
                 1'b1: IO0 = 1'b1;
                 1'bz: IO0 = 1'bx;
                 1'bx: IO0 = 1'bx;
               endcase
            else if (OUTOPEN == "Drain" || OUTOPEN == "Collect")
               begin
                 if (I0 == 1'b0)
                    IO0 = 1'b0;
                 else if (I0 == 1'b1)
                    IO0 = 1'bz;
                 else
                    IO0 = 1'bx;
          end
  end       

 
specify 
 
(I0 => IO) = 0:0:0, 0:0:0;
(OE => IO) = 0:0:0, 0:0:0;
(IO => O) =  0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module BUFF (O,I0); 
input I0; 
output O; 
supply0 GND; 
supply1 VCC; 
buf INS1 (O, I0); 
 
specify 
 
(I0 => O) =  0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
`celldefine 
 
module BUFTH (O,I0,OE); 
input I0,OE; 
output O; 
supply0 GND; 
supply1 VCC; 
wire I0_i,OE_i;
reg o0;

parameter OUTOPEN = "Off";

buf INSXQ1 (I0_i,I0);  
buf INSXQ2 (OE_i,OE);  
bufif1 INSXQ3 (O,o0,OE_i);  

always @(OE_i or I0_i)
  begin
     if (OE_i == 1'b0)
         o0 = 1'bz;
     else if (OE_i == 1'b1)
            if (OUTOPEN == "Off")
               case(I0_i)
                 1'b0: o0 = 1'b0;
                 1'b1: o0 = 1'b1;
                 1'bz: o0 = 1'bx;
                 1'bx: o0 = 1'bx;
               endcase
            else if (OUTOPEN == "Drain" || OUTOPEN == "Collect")
               begin
                 if (I0_i == 1'b0)
                    o0 = 1'b0;
                 else if (I0_i == 1'b1)
                    o0 = 1'bz;
                 else
                    o0 = 1'bx;
          end
  end       
 
specify 
 
(I0 => O) =  0:0:0, 0:0:0;
(OE => O) =  0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module BUFTI (O,I0,OE); 
input I0,OE; 
output O; 
supply0 GND; 
supply1 VCC; 
bufif1 INS1 (O, I0, OE); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(OE => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
`celldefine 
 
module BUFTL (O,I0,OE); 
input I0,OE; 
output O; 
supply0 GND; 
supply1 VCC;
wire I0_i,OE_i;
reg o0;

parameter OUTOPEN = "Off";

buf INSXQ1 (I0_i,I0);  
buf INSXQ2 (OE_i,OE);  
bufif0 INSXQ3 (O,o0,OE_i);  

always @(OE_i or I0_i)
  begin
     if (OE_i == 1'b1)
         o0 = 1'bz;
     else if (OE_i == 1'b0)
            if (OUTOPEN == "Off")
               case(I0_i)
                 1'b0: o0 = 1'b0;
                 1'b1: o0 = 1'b1;
                 1'bz: o0 = 1'bx;
                 1'bx: o0 = 1'bx;
               endcase
            else if (OUTOPEN == "Drain" || OUTOPEN == "Collect")
               begin
                 if (I0_i == 1'b0)
                    o0 = 1'b0;
                 else if (I0_i == 1'b1)
                    o0 = 1'bz;
                 else
                    o0 = 1'bx;
          end
  end     
 
specify 
 
(I0 => O) =  0:0:0, 0:0:0;
(OE => O) =  0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
`celldefine 
  
module CLKI(O,PAD); 
input PAD; 
output O; 
supply0 GND; 
supply1 VCC; 
buf INS1 (O, PAD); 
  
specify 
  
(PAD => O) =  0:0:0, 0:0:0;
  
endspecify 
  
  
endmodule 
`endcelldefine 
 
`celldefine 
 
module DFF (Q,D,CLK); 
input D,CLK; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
 
`ifdef xmodel 
MACH_DFF_X INS1 (Q_int, D, CLK, VCC, VCC, notifier); 
`else 
MACH_DFF INS4 (Q_int, D, CLK, VCC, VCC, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
buf INS2 (Q, Q_reg); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0);  
$setuphold(posedge CLK, D , 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK, 1:1:1, 0, notifier); 
$period(posedge CLK, 1:1:1, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DFFC (Q,D,CLK,CE); 
input D,CLK,CE; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_DFF_CE_X INS1 (Q_int, D, CLK, VCC, VCC, CE, notifier); 
`else 
MACH_DFF_CE INS4 (Q_int, D, CLK, VCC, VCC, CE, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0); 
$setuphold(posedge CLK &&& (CE == 1), D , 0.1:0.1:0.1, 0:0:0, notifier); 
$setuphold(posedge CLK , posedge CE , 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& (CE == 1), 1:1:1, 0, notifier); 
$period(posedge CLK &&& (CE == 1), 1:1:1, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DFFCR (Q,D,CLK,CE,R); 
input D,CLK,CE,R; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_DFF_CE_X INS1 (Q_int, D, CLK, R, VCC, CE, notifier); 
`else 
MACH_DFF_CE INS5 (Q_int, D, CLK, R, VCC, CE, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
and INS4 (CE_R, CE, R); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0); 
(R => Q) = ( 0:0:0, 0:0:0); 
$width(negedge R, 1:1:1, 0, notifier); 
$setuphold(posedge CLK &&& (CE_R), D , 0.1:0.1:0.1, 0:0:0, notifier); 
$setuphold(posedge CLK &&& (R == 1), posedge CE , 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& (CE_R), 1:1:1, 0, notifier); 
$period(posedge CLK &&& (CE_R), 1:1:1, notifier); 
$recovery(posedge R , posedge CLK &&& (CE == 1), 0.1:0.1:0.1, notifier); 
$hold(posedge CLK &&& (CE == 1), posedge R , 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DFFCRH (Q,D,CLK,CE,R); 
input D,CLK,CE,R; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_DFF_CE_X INS1 (Q_int, D, CLK, R1, VCC, CE, notifier); 
`else 
MACH_DFF_CE INS7 (Q_int, D, CLK, R1, VCC, CE, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
not INS4 (R1, R); 
not INS5 (R2, R); 
and INS6 (CE_NR, CE, R2); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0); 
(R => Q) = ( 0:0:0, 0:0:0); 
$width(posedge R, 1:1:1, 0, notifier);  
$setuphold(posedge CLK &&& (CE_NR), D , 0.1:0.1:0.1, 0:0:0, notifier);  
$setuphold(posedge CLK &&& (R == 0), posedge CE , 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& (CE_NR), 1:1:1, 0, notifier); 
$period(posedge CLK &&& (CE_NR), 1:1:1, notifier); 
$recovery(negedge R , posedge CLK &&& (CE == 1), 0.1:0.1:0.1, notifier); 
$hold(posedge CLK &&& (CE == 1), negedge R , 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DFFCRS (Q,D,CLK,CE,R,S); 
input D,CLK,CE,R,S; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
 
`ifdef xmodel 
MACH_DFF_CE_X INS1 (Q_int, D, CLK, R, S, CE, notifier); 
`else 
MACH_DFF_CE INS7 (Q_int, D, CLK, R, S, CE, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
and INS4 (CE_R_S, CE, R, S); 
and INS5 (CE_R, CE, R); 
and INS6 (CE_S, CE, S); 
and INS8 (R_S, R, S);
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0); 
(R => Q) = ( 0:0:0, 0:0:0);
(S => Q) = ( 0:0:0, 0:0:0);
$width(negedge R, 1:1:1, 0, notifier); 
$width(negedge S, 1:1:1, 0, notifier);  
$setuphold(posedge CLK &&& (CE_R_S), D , 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& (CE_R_S), 1:1:1, 0, notifier); 
$period(posedge CLK &&& (CE_R_S), 1:1:1, notifier); 
$recovery(posedge R , posedge CLK &&& (CE_S), 0.1:0.1:0.1, notifier); 
$hold(posedge CLK &&& (CE_S), posedge R , 0:0:0, notifier); 
$recovery(posedge S , posedge CLK &&& (CE_R), 0.1:0.1:0.1, notifier); 
$hold(posedge CLK &&& (CE_R), posedge S , 0:0:0, notifier); 

$setuphold(posedge CLK &&& (R_S), posedge CE , 0.1:0.1:0.1, 0:0:0, notifier); 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DFFCRSH (Q,D,CLK,CE,R,S); 
input D,CLK,CE,R,S; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
 
`ifdef xmodel 
MACH_DFF_CE_X INS1 (Q_int, D, CLK, R1,S1, CE, notifier); 
`else 
MACH_DFF_CE INS11 (Q_int, D, CLK, R1, S1, CE, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
not INS4 (S1, S); 
not INS5 (R1, R); 
and INS8 (CE_NR_NS, CE, R1, S1); 
and INS9 (CE_NR, CE, R1); 
and INS10 (CE_NS, CE, S1); 
and INS12 (NR_NS, R1, S1);
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0);
(R => Q) = ( 0:0:0, 0:0:0);
(S => Q) = ( 0:0:0, 0:0:0);
$width(posedge R, 1:1:1, 0, notifier); 
$width(posedge S, 1:1:1, 0, notifier);  
$setuphold(posedge CLK &&& (CE_NR_NS), D , 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& (CE_NR_NS), 1:1:1, 0, notifier); 
$period(posedge CLK &&& (CE_NR_NS), 1:1:1, notifier); 
$recovery(negedge R , posedge CLK &&& (CE_NS), 0.1:0.1:0.1, notifier); 
$hold(posedge CLK &&& (CE_NS), negedge R , 0:0:0, notifier); 
$recovery(negedge S , posedge CLK &&& (CE_NR), 0.1:0.1:0.1, notifier); 
$hold(posedge CLK &&& (CE_NR), negedge S , 0:0:0, notifier); 
$setuphold(posedge CLK &&& (NR_NS), posedge CE , 0.1:0.1:0.1, 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DFFCS (Q,D,CLK,CE,S); 
input D,CLK,CE,S; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_DFF_CE_X INS1 (Q_int, D, CLK, VCC, S, CE, notifier); 
`else 
MACH_DFF_CE INS5 (Q_int, D, CLK, VCC, S, CE, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
and INS4 (CE_S, CE, S); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0);
(S => Q) = ( 0:0:0, 0:0:0);
$width(negedge S, 1:1:1, 0, notifier); 
$setuphold(posedge CLK &&& (CE_S), D , 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& (CE_S), 1:1:1, 0, notifier); 
$period(posedge CLK &&& (CE_S), 1:1:1, notifier); 
$recovery(posedge S , posedge CLK &&& (CE == 1), 0.1:0.1:0.1, notifier); 
$hold(posedge CLK &&& (CE == 1), posedge S , 0:0:0, notifier); 
$setuphold(posedge CLK &&& (S == 1), posedge CE , 0.1:0.1:0.1, 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DFFCSH (Q,D,CLK,CE,S); 
input D,CLK,CE,S; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_DFF_CE_X INS1 (Q_int, D, CLK, VCC, S1, CE, notifier); 
`else 
MACH_DFF_CE INS7 (Q_int, D, CLK, VCC, S1, CE, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
not INS4 (S1, S); 
not INS5 (S2, S); 
and INS6 (CE_NS, CE, S2); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0);
(S => Q) = ( 0:0:0, 0:0:0);
$width(posedge S, 1:1:1, 0, notifier);  
$setuphold(posedge CLK &&& (CE_NS), D , 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& (CE_NS), 1:1:1, 0, notifier); 
$period(posedge CLK &&& (CE_NS), 1:1:1, notifier); 
$recovery(negedge S , posedge CLK &&& (CE == 1), 0.1:0.1:0.1, notifier); 
$hold(posedge CLK &&& (CE == 1), negedge S , 0:0:0, notifier); 
$setuphold(posedge CLK &&& (S == 0),posedge  CE , 0.1:0.1:0.1, 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DFFR (Q,D,CLK,R); 
input D,CLK,R; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_DFF_X INS1 (Q_int, D, CLK, R, VCC, notifier); 
`else 
MACH_DFF INS4 (Q_int, D, CLK, R, VCC, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0);
(R => Q) = ( 0:0:0, 0:0:0);

$width(negedge R, 1:1:1, 0, notifier); 
$setuphold(posedge CLK &&& R, D , 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& R, 1:1:1, 0, notifier); 
$period(posedge CLK &&& R, 1:1:1, notifier); 
$recovery(posedge R, posedge CLK, 0.1:0.1:0.1, notifier); 
$hold(posedge CLK, posedge R , 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DFFRH (Q,D,CLK,R); 
input D,CLK,R; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_DFF_X INS1 (Q_int, D, CLK, R1, VCC, notifier); 
`else 
MACH_DFF INS1 (Q_int, D, CLK, R1, VCC, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
not INS4 (R1, R); 
not INS5 (R2, R); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0);
(R => Q) = ( 0:0:0, 0:0:0);
$width(posedge  R, 1:1:1, 0, notifier); 
$setuphold(posedge CLK &&& R2, D , 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& R2, 1:1:1, 0, notifier); 
$period(posedge CLK &&& R2, 1:1:1, notifier); 
$recovery(negedge R, posedge CLK, 0.1:0.1:0.1, notifier); 
$hold(posedge CLK, negedge R , 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DFFRS (Q,D,CLK,R,S); 
input D,CLK,R,S; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
 
`ifdef xmodel 
MACH_DFF_X INS1 (Q_int, D, CLK, R, S, notifier); 
`else 
MACH_DFF INS5 (Q_int, D, CLK, R, S, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
and INS4 (R_S, R, S); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0);
(R => Q) = ( 0:0:0, 0:0:0);
(S => Q) = ( 0:0:0, 0:0:0);
$width(negedge S, 1:1:1, 0, notifier); 
$width(negedge R, 1:1:1, 0, notifier); 
$setuphold(posedge CLK &&& (R_S), D , 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& (R_S), 1:1:1, 0, notifier); 
$period(posedge CLK &&& (R_S), 1:1:1, notifier); 
$recovery(posedge R &&& (S), posedge CLK, 0.1:0.1:0.1, notifier); 
$hold(posedge CLK &&& (S), posedge R , 0:0:0, notifier); 
$recovery(posedge S &&& (R), posedge CLK, 0.1:0.1:0.1, notifier); 
$hold(posedge CLK &&& (R), posedge S , 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DFFRSH (Q,D,CLK,R,S); 
input D,CLK,R,S; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
 
`ifdef xmodel 
MACH_DFF_X INS1 (Q_int, D, CLK, R1, S1, notifier); 
`else 
MACH_DFF INS7 (Q_int, D, CLK, R1, S1, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
not INS4 (R1, R); 
not INS5 (S1, S); 
and INS6 (NR_NS, R1, S1); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0);
(R => Q) = ( 0:0:0, 0:0:0);
(S => Q) = ( 0:0:0, 0:0:0);
$width(posedge S, 1:1:1, 0, notifier); 
$width(posedge R, 1:1:1, 0, notifier); 
$setuphold(posedge CLK &&& (NR_NS), D , 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& (NR_NS), 1:1:1, 0, notifier); 
$period(posedge CLK &&& (NR_NS), 1:1:1, notifier); 
$recovery(negedge R &&& (S1), posedge CLK, 0.1:0.1:0.1, notifier); 
$hold(posedge CLK &&& (S1), negedge R , 0:0:0, notifier); 
$recovery(negedge S &&& (R1), posedge CLK, 0.1:0.1:0.1, notifier); 
$hold(posedge CLK &&& (R1), negedge S , 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DFFS (Q,D,CLK,S); 
input D,CLK,S; 
output Q;
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_DFF_X INS7 (Q_int, D, CLK, VCC, S, notifier); 
`else 
MACH_DFF INS4 (Q_int, D, CLK, VCC, S, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0);
(S => Q) = ( 0:0:0, 0:0:0);
$width(negedge S, 1:1:1, 0, notifier); 
$setuphold(posedge CLK &&& (S), D , 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& (S), 1:1:1, 0, notifier); 
$period(posedge CLK &&& (S), 1:1:1, notifier); 
$recovery(posedge S, posedge CLK, 0.1:0.1:0.1, notifier); 
$hold(posedge CLK, posedge S , 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DFFSH (Q,D,CLK,S); 
input D,CLK,S; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_DFF_X INS1 (Q_int, D, CLK, VCC, S1, notifier); 
`else 
MACH_DFF INS5 (Q_int, D, CLK, VCC, S1, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
not INS4 (S1, S); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0);
(S => Q) = ( 0:0:0, 0:0:0);
$width(posedge S, 1:1:1, 0, notifier); 
$setuphold(posedge CLK &&& (S1), D , 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& (S1), 1:1:1, 0, notifier); 
$period(posedge CLK &&& (S1), 1:1:1, notifier); 
$recovery(negedge S, posedge CLK, 0.1:0.1:0.1, notifier); 
$hold(posedge CLK, negedge S , 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DLAT (Q,D,LAT); 
input D,LAT; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_LATCH_X INS1 (Q_int, D, LAT, VCC, VCC, notifier); 
`else 
MACH_LATCH INS4 (Q_int, D, LAT, VCC, VCC, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
 
specify 
 
(LAT => Q) = ( 0:0:0, 0:0:0);
(D => Q) = ( 0:0:0, 0:0:0);
$setuphold(negedge LAT, D , 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge LAT, 1:1:1, 0, notifier); 
$period(posedge LAT, 1:1:1, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
`celldefine 
 
module DLATR (Q,D,LAT,R); 
input D,LAT,R; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_LATCH_X INS1 (Q_int, D, LAT, R, VCC, notifier); 
`else 
MACH_LATCH INS4 (Q_int, D, LAT, R, VCC, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
 
specify 
 
(LAT => Q) = ( 0:0:0, 0:0:0);
(D => Q) = ( 0:0:0, 0:0:0);
(R => Q) = ( 0:0:0, 0:0:0);
$width(negedge R, 1:1:1, 0, notifier);  
$setuphold(negedge LAT &&& R, D , 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge LAT &&& R, 1:1:1, 0, notifier); 
$period(posedge LAT &&& R, 1:1:1, notifier); 
$recovery(posedge R, negedge LAT, 0.1:0.1:0.1, notifier); 
$hold(negedge LAT, posedge R , 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DLATRH (Q,D,LAT,R); 
input D,LAT,R; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_LATCH_X INS1 (Q_int, D, LAT, R1, VCC, notifier); 
`else 
MACH_LATCH INS5 (Q_int, D, LAT, R1, VCC, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
not INS4 (R1, R); 
 
specify 
 
(LAT => Q) = ( 0:0:0, 0:0:0);
(D => Q) = ( 0:0:0, 0:0:0);
(R => Q) = ( 0:0:0, 0:0:0);
$width(posedge R, 1:1:1, 0, notifier);  
$setuphold(negedge LAT, D &&& R1, 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge LAT &&& R1, 1:1:1, 0, notifier); 
$period(posedge LAT &&& R1, 1:1:1, notifier); 
$recovery(negedge R, negedge LAT, 0.1:0.1:0.1, notifier); 
$hold(negedge LAT, negedge R , 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
  
 
`celldefine 
 
module DLATRS (Q,D,LAT,R,S); 
input D,LAT,R,S; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
not INS8 (NOT_S, S); 
or INS9 (D_in, NOT_S, D); 
 
`ifdef xmodel 
MACH_LATCH_X INS1 (Q_int, D, LAT, R, S, notifier); 
`else 
MACH_LATCH INS5 (Q_int, D, LAT, R, S, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
and INS6 (R_S, R, S); 
specify 
 
(LAT => Q) = ( 0:0:0, 0:0:0);
(D => Q) = ( 0:0:0, 0:0:0);
(S => Q) = ( 0:0:0, 0:0:0);
(R => Q) = ( 0:0:0, 0:0:0);
$width(negedge R, 1:1:1, 0, notifier); 
$width(negedge S, 1:1:1, 0, notifier);  
$setuphold(negedge LAT, D &&& R_S, 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge LAT &&& R_S, 1:1:1, 0, notifier); 
$period(posedge LAT &&& R_S, 1:1:1, notifier); 
$recovery(posedge R &&& (S == 1), negedge LAT, 0.1:0.1:0.1, notifier); 
$recovery(posedge S &&& (R == 1), negedge LAT, 0.1:0.1:0.1, notifier); 
$hold(negedge LAT &&& (S == 1), posedge R , 0:0:0, notifier); 
$hold(negedge LAT &&& (R == 1), posedge S , 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DLATRSH (Q,D,LAT,R,S); 
input D,LAT,R,S; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
or INS20 (D_in, S, D); 
 
`ifdef xmodel 
MACH_LATCH_X INS1 (Q_int, D, LAT, R1, S1, notifier); 
`else 
MACH_LATCH INS7 (Q_int, D, LAT, R1, S1, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
not INS4 (S1, S); 
not INS5 (R1, R); 
and INS6 (NR_NS , R1, S1); 
specify 
 
(LAT => Q) = ( 0:0:0, 0:0:0);
(D => Q) = ( 0:0:0, 0:0:0);
(S => Q) = ( 0:0:0, 0:0:0);
(R => Q) = ( 0:0:0, 0:0:0);
$width(posedge R, 1:1:1, 0, notifier); 
$width(posedge S, 1:1:1, 0, notifier); 
$setuphold(negedge LAT, D &&& NR_NS, 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge LAT &&& NR_NS, 1:1:1, 0, notifier); 
$period(posedge LAT &&& NR_NS, 1:1:1, notifier); 
$recovery(negedge R &&& (S == 0), negedge LAT, 0.1:0.1:0.1, notifier); 
$hold(negedge LAT, negedge R  &&& (S == 0), 1:1:1, notifier); 
$recovery(negedge S &&& (R == 0), negedge LAT, 0.1:0.1:0.1, notifier); 
$hold(negedge LAT, negedge S  &&& (R == 0), 1:1:1, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DLATS (Q,D,LAT,S); 
input D,LAT,S; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_LATCH_X INS1 (Q_int, D, LAT, VCC, S, notifier); 
`else 
MACH_LATCH INS4 (Q_int, D, LAT, VCC, S, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
 
specify 
 
(LAT => Q) = ( 0:0:0, 0:0:0);
(D => Q) = ( 0:0:0, 0:0:0);
(S => Q) = ( 0:0:0, 0:0:0);
$width(negedge S, 1:1:1, 0, notifier);  
$setuphold(negedge LAT, D &&& S, 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge LAT &&& S, 1:1:1, 0, notifier); 
$period(posedge LAT &&& S, 1:1:1, notifier); 
$recovery(posedge S, negedge LAT, 0.1:0.1:0.1, notifier); 
$hold(negedge LAT, posedge S , 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module DLATSH (Q,D,LAT,S); 
input D,LAT,S; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_LATCH_X INS1 (Q_int, D, LAT, VCC, S1, notifier); 
`else 
MACH_LATCH INS5 (Q_int, D, LAT, VCC, S1, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
not INS4 (S1, S); 
 
specify 
 
(LAT => Q) = ( 0:0:0, 0:0:0);
(D => Q) = ( 0:0:0, 0:0:0);
(S => Q) = ( 0:0:0, 0:0:0);
$width(posedge S, 1:1:1, 0, notifier); 
$setuphold(negedge LAT, D &&& S1, 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge LAT &&& S1, 1:1:1, 0, notifier); 
$period(posedge LAT &&& S1, 1:1:1, notifier); 
$recovery(negedge S, negedge LAT, 0.1:0.1:0.1, notifier); 
$hold(negedge LAT, negedge S , 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
`celldefine 
 
module VCC (X); 
output X; 
 
supply0 GND; 
supply1 VCC; 
 
assign X = VCC; 
 
specify 
 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module GND (X); 
output X; 
 
supply0 GND; 
supply1 VCC; 
 
assign X = GND; 
 
specify 
 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
  
  
`celldefine 
  
module GSRBUF (O,SRI); 
input SRI; 
output O; 
supply0 GND; 
supply1 VCC; 
buf INS1 (O, SRI); 
  
specify 
  
(SRI => O) =  0:0:0, 0:0:0;
  
endspecify 
  
  
endmodule 
`endcelldefine 
 
`celldefine 
 
module IBUF (O,I0); 
input I0; 
output O; 
supply0 GND; 
supply1 VCC; 

reg o0;

parameter PULL = "Off";

 
buf INS1 (O, o0); 

always @(I0)
begin
 if (PULL == "Off")
    o0 = I0;
 else if (PULL == "Up")
        case(I0)
           1'b0: o0 = 1'b0;
           1'b1: o0 = 1'b1;
           1'bz: o0 = 1'b1;
        endcase
 else if (PULL == "Down")
        case(I0)
           1'b0: o0 = 1'b0;
           1'b1: o0 = 1'b1;
           1'bz: o0 = 1'b0;
        endcase
 else if (PULL == "Hold")
        case(I0)
           1'b0: o0 = 1'b0;
           1'b1: o0 = 1'b1;
           1'bz: o0 = o0;
        endcase
end
             
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
 
endspecify 

endmodule
`endcelldefine 
  
`celldefine 
 
module INV (O,I0); 
input I0; 
output O; 
supply0 GND; 
supply1 VCC; 
not INS1 (O, I0); 
 
specify 
 
(I0 => O) =  0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module INVTH (O,I0,OE); 
input I0,OE; 
output O; 
supply0 GND; 
supply1 VCC; 

reg O2;

parameter OUTOPEN = "Off";

not INS2 (O1,I0);

bufif1 INSXQ (O,O2,OE);  

always @(OE or O1)
  begin
     if (OE == 1'b0)
         O2 = 1'bz;
     else if (OE == 1'b1)
            if (OUTOPEN == "Off")
                 O2 = O1;
            else if (OUTOPEN == "Drain" || OUTOPEN == "Collect")
               begin
                 if (O1 == 1'b0)
                    O2 = 1'b0;
                 else if (O1 == 1'b1)
                    O2 = 1'bz;
                 else
                    O2 = 1'bx;
          end
  end     
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(OE => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 


`celldefine

module LVDSIN (O,P_IN,N_IN); 
input P_IN,N_IN; 
output O; 
 
buf INS1 (O, P_IN); 
 
specify 
 
(P_IN => O) =  0:0:0, 0:0:0; 
(N_IN => O) =  0:0:0, 0:0:0; 
 
endspecify 
endmodule 

`endcelldefine

`celldefine

module LVDSOUT (P_OUT,N_OUT,I); 
input I; 
output P_OUT,N_OUT; 

not INS1 (N_OUT, I); 
buf INS2 (P_OUT, I); 
 
specify 
 
(I => P_OUT) =  0:0:0, 0:0:0; 
(I => N_OUT) =  0:0:0, 0:0:0; 
 
endspecify 
endmodule 

`endcelldefine
 
 
`celldefine 
 
module LVDSTRI (N_OUT,P_OUT,I,OE); 
input I,OE; 
output N_OUT, P_OUT; 
supply0 GND; 
supply1 VCC; 

bufif1 INS1 (P_OUT, I, OE); 
notif1 INS2 (N_OUT, I, OE); 
specify 
 
(I => P_OUT) =  0:0:0, 0:0:0;
(I => N_OUT) =  0:0:0, 0:0:0;
(OE => P_OUT) =  0:0:0, 0:0:0;
(OE => N_OUT) =  0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 

`celldefine 
 
module LVDSIO (O,I,P_IO,N_IO,OE); 
input I,OE; 
inout P_IO,N_IO; 
output O; 
supply0 GND; 
supply1 VCC; 
 
buf INS1 (O, P_IO); 
bufif1 INS2 (P_IO, I, OE); 
notif1 INS3 (N_IO, I, OE);
 
specify 
 
(I => P_IO) = 0:0:0, 0:0:0;
(I => N_IO) = 0:0:0, 0:0:0;
(OE => P_IO) = 0:0:0, 0:0:0;
(OE => N_IO) = 0:0:0, 0:0:0;
(P_IO => O) =  0:0:0, 0:0:0;
(N_IO => O) =  0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 

`celldefine

module LVPECLIN (O,P_IN,N_IN); 
input P_IN,N_IN; 
output O; 
 
buf INS1 (O, P_IN); 
 
specify 
 
(P_IN => O) =  0:0:0, 0:0:0; 
(N_IN => O) =  0:0:0, 0:0:0; 
 
endspecify 
endmodule 

`endcelldefine

`celldefine

module LVPECLOUT (P_OUT,N_OUT,I); 
input I; 
output P_OUT,N_OUT; 
 
buf INS1 (P_OUT, I); 
not INS2 (N_OUT, I);
 
specify 
 
(I => P_OUT) =  0:0:0, 0:0:0; 
(I => N_OUT) =  0:0:0, 0:0:0; 
 
endspecify 
endmodule 

`endcelldefine
 
 
`celldefine 
 
module LVPECLTRI (N_OUT,P_OUT,I,OE); 
input I,OE; 
output N_OUT, P_OUT; 
supply0 GND; 
supply1 VCC; 
bufif1 INS1 (P_OUT, I, OE); 
notif1 INS2 (N_OUT, I, OE); 
specify 
 
(I => P_OUT) =  0:0:0, 0:0:0;
(I => N_OUT) =  0:0:0, 0:0:0;
(OE => P_OUT) =  0:0:0, 0:0:0;
(OE => N_OUT) =  0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 

 
`celldefine

module BLVDSIN (O,P_IN,N_IN); 
input P_IN,N_IN; 
output O; 
 
buf INS1 (O, P_IN); 
 
specify 
 
(P_IN => O) =  0:0:0, 0:0:0; 
(N_IN => O) =  0:0:0, 0:0:0; 
 
endspecify 
endmodule 

`endcelldefine

`celldefine

module BLVDSOUT (P_OUT,N_OUT,I); 
input I; 
output P_OUT,N_OUT; 
 
buf INS1 (P_OUT, I); 
not INS2 (N_OUT, I);
 
specify 
 
(I => P_OUT) =  0:0:0, 0:0:0; 
(I => N_OUT) =  0:0:0, 0:0:0; 
 
endspecify 
endmodule 

`endcelldefine
 
 
`celldefine 
 
module BLVDSTRI (N_OUT,P_OUT,I,OE); 
input I,OE; 
output N_OUT, P_OUT; 
supply0 GND; 
supply1 VCC; 
bufif1 INS1 (P_OUT, I, OE); 
notif1 INS2 (N_OUT, I, OE); 
specify 
 
(I => P_OUT) =  0:0:0, 0:0:0;
(I => N_OUT) =  0:0:0, 0:0:0;
(OE => P_OUT) =  0:0:0, 0:0:0;
(OE => N_OUT) =  0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 

`celldefine 
 
module BLVDSIO (O,I,P_IO,N_IO,OE); 
input I,OE; 
inout P_IO,N_IO; 
output O; 
 
supply0 GND; 
supply1 VCC; 
 
buf INS1 (O, P_IO); 
bufif1 INS2 (P_IO, I, OE); 
notif1 INS3 (N_IO, I, OE);
 
specify 
 
(I => P_IO) = 0:0:0, 0:0:0;
(I => N_IO) = 0:0:0, 0:0:0;
(OE => P_IO) = 0:0:0, 0:0:0;
(OE => N_IO) = 0:0:0, 0:0:0;
(P_IO => O) =  0:0:0, 0:0:0;
(N_IO => O) =  0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
`celldefine 
 
module INVTL (O,I0,OE); 
input I0,OE; 
output O; 
supply0 GND; 
supply1 VCC; 

reg O2;

parameter OUTOPEN = "Off";

not INS2 (O1,I0);

bufif0 INSXQ (O,O2,OE);  

always @(OE or O1)
  begin
     if (OE == 1'b1)
         O2 = 1'bz;
     else if (OE == 1'b0)
            if (OUTOPEN == "Off")
                 O2 = O1;
            else if (OUTOPEN == "Drain" || OUTOPEN == "Collect")
               begin
                 if (O1 == 1'b0)
                    O2 = 1'b0;
                 else if (O1 == 1'b1)
                    O2 = 1'bz;
                 else
                    O2 = 1'bx;
          end
  end     
 
specify 
 
(I0 => O) =  0:0:0, 0:0:0;
(OE => O) =  0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module NAN2 (O,I0,I1); 
input I0,I1; 
output O; 
supply0 GND; 
supply1 VCC; 
nand INS1 (O, I0, I1); 
 
specify 
 
(I0 => O) =  0:0:0, 0:0:0;
(I1 => O) =  0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module NAN3 (O,I0,I1,I2); 
input I0,I1,I2; 
output O; 
supply0 GND; 
supply1 VCC; 
nand INS1 (O, I0, I1, I2); 
 
specify 
 
(I0 => O) =  0:0:0, 0:0:0;
(I1 => O) =  0:0:0, 0:0:0;
(I2 => O) =  0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module NAN4 (O,I0,I1,I2,I3); 
input I0,I1,I2,I3; 
output O; 
supply0 GND; 
supply1 VCC; 
nand INS1 (O, I0, I1, I2, I3); 
 
specify 
 
(I0 => O) =  0:0:0, 0:0:0;
(I1 => O) =  0:0:0, 0:0:0;
(I2 => O) =  0:0:0, 0:0:0;
(I3 => O) =  0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module NAN5 (O,I0,I1,I2,I3,I4); 
input I0,I1,I2,I3,I4; 
output O; 
supply0 GND; 
supply1 VCC; 
nand INS1 (O, I0, I1, I2, I3, I4); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
(I4 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module NAN6 (O,I0,I1,I2,I3,I4,I5); 
input I0,I1,I2,I3,I4,I5; 
output O; 
supply0 GND; 
supply1 VCC; 
nand INS1 (O, I0, I1, I2, I3, I4, I5); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
(I4 => O) = 0:0:0, 0:0:0;
(I5 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module NAN7 (O,I0,I1,I2,I3,I4,I5,I6); 
input I0,I1,I2,I3,I4,I5,I6; 
output O; 
supply0 GND; 
supply1 VCC; 
nand INS1 (O, I0, I1, I2, I3, I4, I5, I6); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
(I4 => O) = 0:0:0, 0:0:0;
(I5 => O) = 0:0:0, 0:0:0;
(I6 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module NAN8 (O,I0,I1,I2,I3,I4,I5,I6,I7); 
input I0,I1,I2,I3,I4,I5,I6,I7; 
output O; 
supply0 GND; 
supply1 VCC; 
nand INS1 (O, I0, I1, I2, I3, I4, I5, I6, I7); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
(I4 => O) = 0:0:0, 0:0:0;
(I5 => O) = 0:0:0, 0:0:0;
(I6 => O) = 0:0:0, 0:0:0;
(I7 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
`celldefine 
 
module NOR2 (O,I0,I1); 
input I0,I1; 
output O; 
supply0 GND; 
supply1 VCC; 
nor INS1 (O, I0, I1); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module NOR3 (O,I0,I1,I2); 
input I0,I1,I2; 
output O; 
supply0 GND; 
supply1 VCC; 
nor INS1 (O, I0, I1, I2); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module NOR4 (O,I0,I1,I2,I3); 
input I0,I1,I2,I3; 
output O; 
supply0 GND; 
supply1 VCC; 
nor INS1 (O, I0, I1, I2, I3); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module NOR5 (O,I0,I1,I2,I3,I4); 
input I0,I1,I2,I3,I4; 
output O; 
supply0 GND; 
supply1 VCC; 
nor INS1 (O, I0, I1, I2, I3, I4); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
(I4 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module NOR6 (O,I0,I1,I2,I3,I4,I5); 
input I0,I1,I2,I3,I4,I5; 
output O; 
supply0 GND; 
supply1 VCC; 
nor INS1 (O, I0, I1, I2, I3, I4, I5); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
(I4 => O) = 0:0:0, 0:0:0;
(I5 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module NOR7 (O,I0,I1,I2,I3,I4,I5,I6); 
input I0,I1,I2,I3,I4,I5,I6; 
output O; 
supply0 GND; 
supply1 VCC; 
nor INS1 (O, I0, I1, I2, I3, I4, I5, I6); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
(I4 => O) = 0:0:0, 0:0:0;
(I5 => O) = 0:0:0, 0:0:0;
(I6 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module NOR8 (O,I0,I1,I2,I3,I4,I5,I6,I7); 
input I0,I1,I2,I3,I4,I5,I6,I7; 
output O; 
supply0 GND; 
supply1 VCC; 
nor INS1 (O, I0, I1, I2, I3, I4, I5, I6, I7); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
(I4 => O) = 0:0:0, 0:0:0;
(I5 => O) = 0:0:0, 0:0:0;
(I6 => O) = 0:0:0, 0:0:0;
(I7 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 

`celldefine 
 
module OBUF (O,I0); 
input I0; 
output O; 
supply0 GND; 
supply1 VCC;

reg o0;

parameter OUTOPEN = "Off";

buf INSXQ (O,o0);

always @(I0)
 begin
   if (OUTOPEN == "Off")
      o0 = I0;
   else if (OUTOPEN == "Drain" || OUTOPEN == "Collect")
          begin
            if (I0 == 1'b0)
               o0 = 1'b0;
            else if (I0 == 1'b1)
               o0 = 1'bz;
            else
               o0 = 1'bx;
          end
 end
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
`celldefine 
 
module OR2 (O,I0,I1); 
input I0,I1; 
output O; 
supply0 GND; 
supply1 VCC; 
or INS1 (O, I0, I1); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module OR3 (O,I0,I1,I2); 
input I0,I1,I2; 
output O; 
supply0 GND; 
supply1 VCC; 
or INS1 (O, I0, I1, I2); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module OR4 (O,I0,I1,I2,I3); 
input I0,I1,I2,I3; 
output O; 
supply0 GND; 
supply1 VCC; 
or INS1 (O, I0, I1, I2, I3); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module OR5 (O,I0,I1,I2,I3,I4); 
input I0,I1,I2,I3,I4; 
output O; 
supply0 GND; 
supply1 VCC; 
or INS1 (O, I0, I1, I2, I3, I4); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
(I4 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module OR6 (O,I0,I1,I2,I3,I4,I5); 
input I0,I1,I2,I3,I4,I5; 
output O; 
supply0 GND; 
supply1 VCC; 
or INS1 (O, I0, I1, I2, I3, I4, I5); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
(I4 => O) = 0:0:0, 0:0:0;
(I5 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module OR7 (O,I0,I1,I2,I3,I4,I5,I6); 
input I0,I1,I2,I3,I4,I5,I6; 
output O; 
supply0 GND; 
supply1 VCC; 
or INS1 (O, I0, I1, I2, I3, I4, I5, I6); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
(I4 => O) = 0:0:0, 0:0:0;
(I5 => O) = 0:0:0, 0:0:0;
(I6 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
 
`celldefine 
 
module OR8 (O,I0,I1,I2,I3,I4,I5,I6,I7); 
input I0,I1,I2,I3,I4,I5,I6,I7; 
output O; 
supply0 GND; 
supply1 VCC; 
or INS1 (O, I0, I1, I2, I3, I4, I5, I6, I7); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
(I2 => O) = 0:0:0, 0:0:0;
(I3 => O) = 0:0:0, 0:0:0;
(I4 => O) = 0:0:0, 0:0:0;
(I5 => O) = 0:0:0, 0:0:0;
(I6 => O) = 0:0:0, 0:0:0;
(I7 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module TFF (Q,T,CLK); 
input T,CLK; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_DFF_X INS1 (Q_int, T_int,CLK, VCC, VCC, notifier); 
`else 
MACH_DFF INS4 (Q_int, T_int,CLK, VCC, VCC, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
xor INS2 (T_int,Q_reg,T);
buf INS3 (Q, Q_reg); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0);
$setuphold(posedge CLK, T , 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK, 1:1:1, 0, notifier); 
$period(posedge CLK, 1:1:1, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module TFFR (Q,T,CLK,R); 
input T,CLK,R; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_TFF_X INS1 (Q_int, CLK, T, VCC, R, notifier); 
`else 
MACH_TFF INS4 (Q_int, CLK, T, VCC, R, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0);
(R => Q) = ( 0:0:0, 0:0:0);
$width(negedge R, 1:1:1, 0, notifier);  
$setuphold(posedge CLK, T  &&& (R), 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& (R), 1:1:1, 0, notifier); 
$period(posedge CLK &&& (R), 1:1:1, notifier); 
$recovery(posedge R, posedge CLK, 0.1:0.1:0.1, notifier); 
$hold(posedge CLK, posedge R , 0:0:0, notifier ); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module TFFRH (Q,T,CLK,R); 
input T,CLK,R; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_TFF_X INS1 (Q_int, CLK, T, VCC, R1, notifier); 
`else 
MACH_TFF INS5 (Q_int, CLK, T, VCC, R1, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
not INS4 (R1, R); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0);
(R => Q) = ( 0:0:0, 0:0:0);
$width(posedge R, 1:1:1, 0, notifier); 
$setuphold(posedge CLK, T  &&& (R == 0), 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& (R == 0), 1:1:1, 0, notifier); 
$period(posedge CLK &&& (R == 0), 1:1:1, notifier); 
$recovery(negedge R, posedge CLK, 0.1:0.1:0.1, notifier); 
$hold(posedge CLK, negedge R , 0:0:0, notifier ); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module TFFRS (Q,T,CLK,R,S); 
input T,CLK,R,S; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_TFF_X INS1 (Q_int, CLK, T, S, R, notifier); 
`else 
MACH_TFF INS4 (Q_int, CLK, T, S, R, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
and INS5 (S_R, S, R); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0);
(R => Q) = ( 0:0:0, 0:0:0);
(S => Q) = ( 0:0:0, 0:0:0);
$width(negedge R, 1:1:1, 0, notifier); 
$width(negedge S, 1:1:1, 0, notifier); 
$setuphold(posedge CLK, T  &&& (S_R), 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& (S_R), 1:1:1, 0, notifier); 
$period(posedge CLK &&& (S_R), 1:1:1, notifier); 
$recovery(posedge R &&& (S), posedge CLK, 0.1:0.1:0.1, notifier); 
$hold(posedge CLK, posedge R  &&& (S), 0:0:0, notifier); 
$recovery(posedge S &&& (R), posedge CLK, 0.1:0.1:0.1, notifier); 
$hold(posedge CLK, posedge S  &&& (R), 0:0:0, notifier); 
 
endspecify 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module TFFRSH (Q,T,CLK,R,S); 
input T,CLK,R,S; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_TFF_X INS1 (Q_int, CLK, T, S1, R1, notifier); 
`else 
MACH_TFF INS2 (Q_int, CLK, T, S1, R1, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS3 (Q, Q_reg); 
not INS5 (R1, R); 
not INS6 (S1, S); 
and INS7 (S_R, S1, R1); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0);
(R => Q) = ( 0:0:0, 0:0:0);
(S => Q) = ( 0:0:0, 0:0:0);
$width(posedge R, 1:1:1, 0, notifier); 
$width(posedge S, 1:1:1, 0, notifier);  
$setuphold(posedge CLK, T  &&& (S_R), 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& (S_R), 1:1:1, 0, notifier); 
$period(posedge CLK &&& (S_R), 1:1:1, notifier); 
$recovery(negedge R &&& (S1), posedge CLK, 0.1:0.1:0.1, notifier); 
$hold(posedge CLK, negedge R  &&& (S1), 0:0:0, notifier); 
$recovery(negedge S &&& (R1), posedge CLK, 0.1:0.1:0.1, notifier); 
$hold(posedge CLK, negedge S  &&& (R1), 0:0:0, notifier); 
 
endspecify 
 
endmodule 
`endcelldefine 
 
`celldefine 
 
module TFFS (Q,T,CLK,S); 
input T,CLK,S; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_TFF_X INS1 (Q_int, CLK, T, S, VCC, notifier); 
`else 
MACH_TFF INS4 (Q_int, CLK, T, S, VCC, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0);
(S => Q) = ( 0:0:0, 0:0:0);
$width(negedge S, 1:1:1, 0, notifier); 
$setuphold(posedge CLK, T  &&& (S), 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& (S), 1:1:1, 0, notifier); 
$period(posedge CLK &&& (S), 1:1:1, notifier); 
$recovery(posedge S, posedge CLK, 0.1:0.1:0.1, notifier); 
$hold(posedge CLK, posedge S , 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module TFFSH (Q,T,CLK,S); 
input T,CLK,S; 
output Q; 
reg notifier; 
reg Q_reg; 
 
supply0 GND; 
supply1 VCC; 
 
`ifdef xmodel 
MACH_TFF_X INS1 (Q_int, CLK, T, S1, VCC, notifier); 
`else 
MACH_TFF INS5 (Q_int, CLK, T, S1, VCC, notifier); 
`endif 
 
`ifdef PUC 
        initial Q_reg = 0; 
`endif 
 
        always @(Q_int) Q_reg = Q_int; 
 
 
buf INS2 (Q, Q_reg); 
not INS4 (S1, S); 
 
specify 
 
(CLK => Q) = ( 0:0:0, 0:0:0);
(S => Q) = ( 0:0:0, 0:0:0);
$width(posedge S, 1:1:1, 0, notifier); 
$setuphold(posedge CLK, T  &&& (S == 0), 0.1:0.1:0.1, 0:0:0, notifier); 
$width(posedge CLK &&& (S == 0), 1:1:1, 0, notifier); 
$period(posedge CLK &&& (S == 0), 1:1:1, notifier); 
$recovery(negedge S, posedge CLK, 0.1:0.1:0.1, notifier); 
$hold(posedge CLK, negedge S , 0:0:0, notifier); 
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
`celldefine 
 
module XOR2 (O,I0,I1); 
input I0,I1; 
output O; 
supply0 GND; 
supply1 VCC; 
xor INS1 (O, I0, I1); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 
 
 
`celldefine 
 
module XORSOFT (O,I0,I1); 
input I0,I1; 
output O; 
supply0 GND; 
supply1 VCC; 
xor INS1 (O, I0, I1); 
 
specify 
 
(I0 => O) = 0:0:0, 0:0:0;
(I1 => O) = 0:0:0, 0:0:0;
 
endspecify 
 
 
endmodule 
`endcelldefine 

`celldefine 
`timescale 10 ps / 1 fs

module CDRX_10B12B (SIN, REFCLK, CDRRST, RXD0, RXD1, RXD2, RXD3, RXD4, RXD5, RXD6, RXD7, RXD8, RXD9, RECCLK, CSLOCK, SYDT);

parameter   in_freq    = "100.0";
parameter   div        = "1";
parameter   mult       = "12";
parameter   pll_dly    = "0";
//parameter   sympat     = "00000011111111111111";
parameter   sympat     = "111111000000";
parameter   lock_cyc   = 2;

parameter   IN_FREQ    = "";
parameter   DIV        = "";
parameter   MULT       = "";
parameter   PLL_DLY    = "";
parameter   SYMPAT     = "";

//###########################
//#digital filter parameters#
//###########################

parameter   F_LKDBW    = 8'h0f;
parameter   F_LKTBW    = 8'h3f;
parameter   F_TKDBW    = 8'h1f;
parameter   F_TKTBW    = 8'h7f;
parameter   F_LOCK     = 3'b011;

integer     clockboost;

input  SIN;
input  REFCLK,CDRRST;
output RECCLK,CSLOCK;
output RXD0,RXD1,RXD2,RXD3,RXD4,RXD5,RXD6,RXD7,RXD8,RXD9;
output SYDT;


wire   RXD0;
wire   RXD1;
wire   RXD2;
wire   RXD3;
wire   RXD4;
wire   RXD5;
wire   RXD6;
wire   RXD7;
wire   RXD8;
wire   RXD9;

reg    CDRLOCK;

reg    RECCLK_reg;
wire   CSLOCK;
wire[15:0] inthsrecclk;
reg    intrecclk;

wire   clkin_in;

reg    align;
reg    SYDT;

reg    [15:0]  store_buffer;
reg    [15:0]  shift_buffer;
reg    aclk, sclk;

reg [95:0] symstr_r;
reg [11:0] sympat_r;
initial symstr_r = (SYMPAT == "") ? sympat : SYMPAT;
initial sympat_r[11] = convert_binary(symstr_r[7:0]); 
initial sympat_r[10] = convert_binary(symstr_r[15:8]); 
initial sympat_r[9] = convert_binary(symstr_r[23:16]); 
initial sympat_r[8] = convert_binary(symstr_r[31:24]); 
initial sympat_r[7] = convert_binary(symstr_r[39:32]); 
initial sympat_r[6] = convert_binary(symstr_r[47:40]); 
initial sympat_r[5] = convert_binary(symstr_r[55:48]); 
initial sympat_r[4] = convert_binary(symstr_r[63:56]); 
initial sympat_r[3] = convert_binary(symstr_r[71:64]); 
initial sympat_r[2] = convert_binary(symstr_r[79:72]); 
initial sympat_r[1] = convert_binary(symstr_r[87:80]); 
initial sympat_r[0] = convert_binary(symstr_r[95:88]); 

//#########
//## PLL ##
//#########
time   new_delay;
time   clklock_last_rising_edge;
time   clklock_last_falling_edge;
time   clklock_half_period1;
time   clklock_half_period0;
time   clklock_half_period;
time   clklock_half_period_minus_dly1;
time   clklock_half_period_minus_dly0;

reg [15:0] mult_r;
integer mult_i;
initial mult_r = (MULT == "") ? mult : MULT;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = (DIV == "") ? div : DIV;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [15:0] pll_dly_r;
real pll_dly_re, pll_dly_re_temp;
initial pll_dly_r = (PLL_DLY == "") ? pll_dly : PLL_DLY;
initial 
      pll_dly_re_temp = convert_int(pll_dly_r[15:8]) * convert_int(pll_dly_r[7:0]) *0.25;

initial
      if(pll_dly_re_temp >= 0)
         pll_dly_re = 0.25 * convert_int(pll_dly_r[7:0]);
      else
         pll_dly_re = pll_dly_re_temp;


initial begin
  clklock_half_period1 = 0;
  clklock_half_period0 = 0;
  clklock_half_period_minus_dly1 = 0;
  clklock_half_period_minus_dly0 = 0;
  clockboost     = mult_i/div_i;
  new_delay      = 0.25 * convert_int(pll_dly_r[7:0]) * 100.0;
end


integer   cnt_m_div;
reg       clk_out_m_div;


buf buf_clkin (clkin_in, REFCLK);

integer clklock_rising_edge_count;
integer clklock_falling_edge_count;

initial
begin
	cnt_m_div = -1;
	clk_out_m_div = 0;
        clklock_rising_edge_count = 0;
        clklock_falling_edge_count = 0;
end

always @(posedge clkin_in) 
begin
    clklock_rising_edge_count = clklock_rising_edge_count + 1;
    clklock_last_rising_edge = $time;
end

always @(negedge clkin_in)
begin
    clklock_falling_edge_count = clklock_falling_edge_count + 1;
    clklock_last_falling_edge = $time;
end

always @(posedge clkin_in)
begin
    if (clklock_falling_edge_count == 2)
       clklock_half_period0 = ($time - clklock_last_falling_edge)*div_i/mult_i;
       clklock_half_period_minus_dly0 = ($time - clklock_last_falling_edge) + 100.0 * pll_dly_re; 
end

always @(negedge clkin_in) 
begin
    if (clklock_rising_edge_count == 1)
       clklock_half_period1 = ($time - clklock_last_rising_edge)*div_i/mult_i;
       clklock_half_period_minus_dly1 = ($time - clklock_last_rising_edge) + 100.0 * pll_dly_re; 
end

always @(negedge clkin_in) 
begin
clklock_half_period = (clklock_half_period0 + clklock_half_period1)/2.0; 
end

integer   i, j, n, clock_count, clock_count_falling;
reg       clock_out_sig;

initial
begin
	clock_out_sig = 1'b0;
	clock_count = -1;
	clock_count_falling = -1;
end
always @(clklock_rising_edge_count)
begin
    if (clklock_rising_edge_count > lock_cyc + 1)
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count = clock_count + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count = clock_count + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count = 0;
end

always @(clklock_falling_edge_count)
begin
    if (clklock_falling_edge_count > lock_cyc + 1)
    begin
      if (clockboost > 1)
       begin
	for (j = 1; j <= 2* clockboost ; j = j +1)
           begin
                clock_count_falling = clock_count_falling + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count_falling = clock_count_falling + 1;
                #clklock_half_period   n = 0;
           end
    end
    else
      clock_count_falling = 0;
end

reg PLL_LOCK_plus,PLL_LOCK_minus;
reg CLK_OUT_sig_d_start;

initial
begin
	PLL_LOCK_plus  = 1'b0;
	PLL_LOCK_minus = 1'b0;
	CLK_OUT_sig_d_start = 1'b0;
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    CLK_OUT_sig_d_start = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    PLL_LOCK_plus = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 3)
    PLL_LOCK_minus = 1'b1;
end

reg CLK_OUT_sig_d_not;
initial
begin
    CLK_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
      end
end

wire CLK_OUT_sig_d = ~CLK_OUT_sig_d_not && CLK_OUT_sig_d_start;

reg CLK_OUT_sig_3d;
wire CLK_OUT_plus_delay;

reg start_CLK_OUT;

initial 
begin
CLK_OUT_sig_3d = 1'b0; start_CLK_OUT = 1'b0;
end

always @(clock_count_falling)
begin
  if (clock_count_falling == 1)
  begin
    #clklock_half_period_minus_dly0 CLK_OUT_sig_3d = 1'b1; start_CLK_OUT = 1'b1;
  end
end

always @(start_CLK_OUT)
begin
 while (start_CLK_OUT) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_3d = ~ CLK_OUT_sig_3d;
         #clklock_half_period 
         CLK_OUT_sig_3d = ~ CLK_OUT_sig_3d;
      end
end

assign #new_delay CLK_OUT_plus_delay = CLK_OUT_sig_d;

assign CSLOCK = (PLL_LOCK_plus && (pll_dly_re>=0) || PLL_LOCK_minus && (pll_dly_re<0));

//#################
//#16-phase clocks#
//#################

assign inthsrecclk[0] = CLK_OUT_plus_delay && (pll_dly_re >=0) || CLK_OUT_sig_3d && (pll_dly_re<0);

assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[1] = inthsrecclk[0]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[2] = inthsrecclk[1]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[3] = inthsrecclk[2]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[4] = inthsrecclk[3]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[5] = inthsrecclk[4]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[6] = inthsrecclk[5]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[7] = inthsrecclk[6]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[8] = inthsrecclk[7]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[9] = inthsrecclk[8]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[10] = inthsrecclk[9]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[11] = inthsrecclk[10]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[12] = inthsrecclk[11]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[13] = inthsrecclk[12]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[14] = inthsrecclk[13]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[15] = inthsrecclk[14]; 

//#################
//#digitial filter#
//#################

reg data_ins;
reg data_ina;
always @(posedge sclk)
   data_ins <= SIN;

time time_data;
time time_clock;
time time_delta;

always @(SIN)
   time_data = $time;

always @(posedge aclk)
   time_clock = $time;

always @(time_data or time_clock)
   if (time_data >= time_clock)
       time_delta = time_data - time_clock;
   else
       time_delta = time_clock- time_data;

reg data_inaa;
always @(posedge aclk)
  data_inaa <= SIN;

always @(aclk or time_delta or data_inaa)
if (aclk)
   begin
   if (time_delta < 10)
      data_ina <= 1'bx;
   else
      data_ina <= data_inaa;
   end

wire transition = data_ins ^ data_ina;

reg dn_ss;
always @(sclk or transition)
if (sclk)
    dn_ss <= transition;

reg dn_s;
always @(posedge sclk)
    dn_s <= dn_ss;

reg up_s;
always @(posedge sclk)
    up_s <= transition;

wire dn_clk = dn_s && aclk;
wire up_clk = up_s && aclk;

wire cntrst;
wire pcntrst;

reg[7:0] dn_cnt0;
always @(posedge dn_clk or posedge cntrst)
if (cntrst)
    dn_cnt0 <= 8'h00;
else
    dn_cnt0 <= dn_cnt0 + 1'b1;
    
reg[7:0] up_cnt0;
always @(posedge up_clk or posedge cntrst)
if (cntrst)
    up_cnt0 <= 8'h00;
else
    up_cnt0 <= up_cnt0 + 1'b1;
    
reg[7:0] dn_cnt, up_cnt;
always @(posedge aclk)
begin
   dn_cnt <= dn_cnt0;
   up_cnt <= up_cnt0;
end

reg[8:0] sub_cnt;
always @(posedge aclk or posedge cntrst)
if (cntrst)
   sub_cnt <= 9'h000;
else
   sub_cnt <= dn_cnt - up_cnt;

reg[7:0] add_cnt;
always @(posedge aclk or posedge cntrst)
if (cntrst)
   add_cnt <= 8'h00;
else
   add_cnt <= dn_cnt + up_cnt;

wire[7:0] lkdbw = F_LKDBW;
wire[7:0] lktbw = F_LKTBW;
wire[7:0] tkdbw = F_TKDBW;
wire[7:0] tktbw = F_TKTBW;

wire[7:0] dbw = CDRLOCK? tkdbw: lkdbw;
wire[7:0] tbw = CDRLOCK? tktbw: lktbw;

reg[7:0] diff_cnt;
always @(sub_cnt)
if (sub_cnt[8])
    diff_cnt <= ~(sub_cnt[7:0]);
else
    diff_cnt <= sub_cnt[7:0];

reg diffcmp;
always @(posedge aclk or posedge cntrst)
if (cntrst)
    diffcmp <= 1'b0;
else
    if (diff_cnt >= dbw)
        diffcmp <= 1'b1;
    else
        diffcmp <= 1'b0;

reg totce;
always @(add_cnt or tbw)
if (add_cnt[7:1] == tbw[7:1])
    totce <= 1'b1;
else
    totce <= 1'b0;

reg totcmp;
always @(posedge aclk or posedge CDRRST)
if (CDRRST)
    totcmp <= 1'b0;
else
    totcmp <= totce;

reg totcmp_d;
always @(posedge aclk or posedge CDRRST)
if (CDRRST)
    totcmp_d <= 1'b0;
else
    totcmp_d <= totcmp;

assign cntrst = CDRRST || totcmp;
assign pcntrst = CDRRST || totcmp_d;

reg pre_pull, pre_push;
always @(posedge aclk or posedge pcntrst)
if (pcntrst)
    begin
       pre_push <= 1'b0;
       pre_pull <= 1'b0;
    end
else
    begin
       if (totce)
           begin
               pre_push <= diffcmp && (~sub_cnt[8]);
               pre_pull <= diffcmp && sub_cnt[8];
           end
    end

reg push, pull;
always @(posedge aclk or posedge CDRRST)
if (CDRRST)
    begin
       push <= 1'b0;
       pull <= 1'b0;
    end
else
    begin
       push <= pre_push;
       pull <= pre_pull;
    end

//########################
//#phase shift and select#
//########################

reg[15:0] sclksel;
always @(posedge aclk or posedge CDRRST)
if (CDRRST)
    sclksel <= 16'h0100;
else
    if (pull)
        sclksel <= {sclksel[0], sclksel[15:1]};
    else if (push)
        sclksel <= {sclksel[14:0], sclksel[15]};

always @(sclksel or inthsrecclk)
case (sclksel)
16'h0001: begin
             aclk <= inthsrecclk[8]; 
             sclk <= inthsrecclk[0]; 
          end
16'h0002: begin
             aclk <= inthsrecclk[9]; 
             sclk <= inthsrecclk[1]; 
          end
16'h0004: begin
             aclk <= inthsrecclk[10]; 
             sclk <= inthsrecclk[2]; 
          end
16'h0008: begin
             aclk <= inthsrecclk[11]; 
             sclk <= inthsrecclk[3]; 
          end
16'h0010: begin
             aclk <= inthsrecclk[12]; 
             sclk <= inthsrecclk[4]; 
          end
16'h0020: begin
             aclk <= inthsrecclk[13]; 
             sclk <= inthsrecclk[5]; 
          end
16'h0040: begin
             aclk <= inthsrecclk[14]; 
             sclk <= inthsrecclk[6]; 
          end
16'h0080: begin
             aclk <= inthsrecclk[15]; 
             sclk <= inthsrecclk[7]; 
          end
16'h0100: begin
             aclk <= inthsrecclk[0]; 
             sclk <= inthsrecclk[8]; 
          end
16'h0200: begin
             aclk <= inthsrecclk[1]; 
             sclk <= inthsrecclk[9]; 
          end
16'h0400: begin
             aclk <= inthsrecclk[2]; 
             sclk <= inthsrecclk[10]; 
          end
16'h0800: begin
             aclk <= inthsrecclk[3]; 
             sclk <= inthsrecclk[11]; 
          end
16'h1000: begin
             aclk <= inthsrecclk[4]; 
             sclk <= inthsrecclk[12]; 
          end
16'h2000: begin
             aclk <= inthsrecclk[5]; 
             sclk <= inthsrecclk[13]; 
          end
16'h4000: begin
             aclk <= inthsrecclk[6]; 
             sclk <= inthsrecclk[14]; 
          end
16'h8000: begin
             aclk <= inthsrecclk[7]; 
             sclk <= inthsrecclk[15]; 
          end
default:  begin
             aclk <= inthsrecclk[0]; 
             sclk <= inthsrecclk[8]; 
          end
endcase

//#############
//#LOCK detect#
//#############

wire lock_rst = CDRRST || pull || push;

reg[2:0] lock_cnt;
always @(posedge totcmp or posedge lock_rst)
if (lock_rst)
    lock_cnt <= 3'b000;
else
    lock_cnt <= lock_cnt + 1'b1;

wire lockcmp = (lock_cnt == F_LOCK);

reg lockcmp_d1, lockcmp_d2;
always @(posedge aclk or posedge CDRRST)
if (CDRRST)
    begin
      lockcmp_d1 <= 1'b0;
      lockcmp_d2 <= 1'b0;
    end
else
    begin
      lockcmp_d1 <= lockcmp;
      lockcmp_d2 <= lockcmp_d1;
    end

wire lock_pulse = lockcmp_d1 && ~lockcmp_d2;

reg lock_int;
always @(CDRRST or lock_pulse)
if (CDRRST)
    lock_int <= 1'b0;
else
    if (lock_pulse)
        lock_int <= 1'b1;

reg lock0, lock1;
always @(posedge sclk or posedge CDRRST)
if (CDRRST)
    begin
       lock0 <= 1'b0;
       lock1 <= 1'b1;
    end
else
    begin
       lock0 <= lock_int;
       lock1 <= lock0;
    end

wire #(10) lock2 = lock1;

always @(posedge RECCLK_reg or posedge CDRRST)
if (CDRRST)
    CDRLOCK <= 1'b0;
else
    CDRLOCK <= lock2;

//######################################
//#SYNC detect & recover data and clock#
//######################################

always@(posedge sclk)
begin
     shift_buffer[15]   <= data_ins;
     shift_buffer[14:0] <= shift_buffer[15:1];
end

reg pre_align;
always@(posedge sclk or posedge CDRRST)
if (CDRRST)
        pre_align <= 1'b0;
else
        pre_align <= (shift_buffer[15:4] == sympat_r[11:0]);

reg rsypt0, rsypt1;
always@(posedge sclk or posedge CDRRST)
if (CDRRST)
    begin
        align <= 1'b0;
        rsypt0 <= 1'b0;
    end
else
    begin
        align <= pre_align; 
        rsypt0 <= pre_align; 
    end

always @(posedge sclk or posedge CDRRST)
if(CDRRST)
    rsypt1 <= 1'b0;
else
    rsypt1 <= rsypt0;

wire #(10) rsypt2 = rsypt1;

reg[2:0] divcnt;
wire intrecclk1 = !(divcnt == 3'b010);
always @(posedge sclk or align)
if (align)
    divcnt <= 3'b111;
else
    if (divcnt == 3'b010)
        divcnt <= 3'b111;
    else
        divcnt <= divcnt - 1'b1;
    
reg intrecclk2;
always @(posedge sclk)
    intrecclk2 <= intrecclk1;

always @(posedge intrecclk2 or posedge align)
if (align)
    intrecclk <= 1'b0;
else
    intrecclk <= ~intrecclk;

always @(posedge sclk)
    RECCLK_reg <= intrecclk;

always @(posedge RECCLK_reg or posedge CDRRST)
if (CDRRST)
    SYDT <= 1'b0;
else
    SYDT <= rsypt2;

wire[15:0] #(10) shift_buffer_d = shift_buffer;

always @(posedge RECCLK_reg)
    store_buffer <= shift_buffer_d;

assign RXD0 = store_buffer[2];
assign RXD1 = store_buffer[3];
assign RXD2 = store_buffer[4];
assign RXD3 = store_buffer[5];
assign RXD4 = store_buffer[6];
assign RXD5 = store_buffer[7];
assign RXD6 = store_buffer[8];
assign RXD7 = store_buffer[9];
assign RXD8 = store_buffer[10];
assign RXD9 = store_buffer[11];

assign RECCLK = RECCLK_reg;

//##############
//## function ##
//##############

function convert_binary;
input [7:0] sym_str;
  begin

    if (sym_str == "1")
      convert_binary = 1'b1;
    else if (sym_str == "0")
      convert_binary = 1'b0;
    else 
      convert_binary = 1'b0;
  end
endfunction

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else
      convert_int = 0;
  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction

specify 
 
(REFCLK => RECCLK)   =   0:0:0, 0:0:0;
(REFCLK => CSLOCK)    =   0:0:0, 0:0:0;
 
endspecify 

endmodule

`endcelldefine 

`celldefine 
`timescale 100 fs / 1 fs

module CDRX_8B10B (SIN, REFCLK, CDRRST, RXD0, RXD1, RXD2, RXD3, RXD4, RXD5, RXD6, RXD7, RXD8, RXD9, RECCLK, CSLOCK, SYDT);

parameter   in_freq    = "100.0";
parameter   div        = "1";
parameter   mult       = "10";
parameter   pll_dly    = "0";
//parameter   sympat     = "01011111001010000011";
parameter   sympat     = "11000001010011111010";
parameter   lock_cyc   = 2;

parameter   IN_FREQ    = "";
parameter   DIV        = "";
parameter   MULT       = "";
parameter   PLL_DLY    = "";
parameter   SYMPAT     = "";

//###########################
//#digital filter parameters#
//###########################

parameter   F_LKDBW    = 8'h19;
parameter   F_LKTBW    = 8'h7f;
parameter   F_TKDBW    = 8'h19;
parameter   F_TKTBW    = 8'h7f;
parameter   F_LOCK     = 3'b011;

integer     clockboost;

input  SIN;
input  REFCLK,CDRRST;
output RECCLK,CSLOCK;
output RXD0,RXD1,RXD2,RXD3,RXD4,RXD5,RXD6,RXD7,RXD8,RXD9;
output SYDT;

wire   RXD0;
wire   RXD1;
wire   RXD2;
wire   RXD3;
wire   RXD4;
wire   RXD5;
wire   RXD6;
wire   RXD7;
wire   RXD8;
wire   RXD9;

reg    CDRLOCK;

reg    RECCLK_reg;
wire   CSLOCK;
wire[15:0] inthsrecclk;
reg    intrecclk;

wire   clkin_in;

reg    align;
reg    SYDT;

reg    [15:0]  store_buffer;
reg    [15:0]  shift_buffer;
reg    aclk, sclk;

reg [159:0] symstr_r;
reg [19:0] sympat_r;
initial symstr_r = (SYMPAT == "") ? sympat : SYMPAT;
initial sympat_r[19] = convert_binary(symstr_r[7:0]); 
initial sympat_r[18] = convert_binary(symstr_r[15:8]); 
initial sympat_r[17] = convert_binary(symstr_r[23:16]); 
initial sympat_r[16] = convert_binary(symstr_r[31:24]); 
initial sympat_r[15] = convert_binary(symstr_r[39:32]); 
initial sympat_r[14] = convert_binary(symstr_r[47:40]); 
initial sympat_r[13] = convert_binary(symstr_r[55:48]); 
initial sympat_r[12] = convert_binary(symstr_r[63:56]); 
initial sympat_r[11] = convert_binary(symstr_r[71:64]); 
initial sympat_r[10] = convert_binary(symstr_r[79:72]); 
initial sympat_r[9]  = convert_binary(symstr_r[87:80]); 
initial sympat_r[8]  = convert_binary(symstr_r[95:88]); 
initial sympat_r[7]  = convert_binary(symstr_r[103:96]); 
initial sympat_r[6]  = convert_binary(symstr_r[111:104]); 
initial sympat_r[5]  = convert_binary(symstr_r[119:112]); 
initial sympat_r[4]  = convert_binary(symstr_r[127:120]); 
initial sympat_r[3]  = convert_binary(symstr_r[135:128]); 
initial sympat_r[2]  = convert_binary(symstr_r[143:136]); 
initial sympat_r[1]  = convert_binary(symstr_r[151:144]); 
initial sympat_r[0]  = convert_binary(symstr_r[159:152]); 

//#########
//## PLL ##
//#########

time   new_delay;
time   clklock_last_rising_edge;
time   clklock_last_falling_edge;
time   clklock_half_period1;
time   clklock_half_period0;
time   clklock_half_period;
time   clklock_half_period_minus_dly1;
time   clklock_half_period_minus_dly0;

reg [15:0] mult_r;
integer mult_i;
initial mult_r = (MULT == "") ? mult : MULT;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = (DIV == "") ? div :DIV;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [15:0] pll_dly_r;
real pll_dly_re, pll_dly_re_temp;
initial pll_dly_r = (PLL_DLY == "") ? pll_dly : PLL_DLY;
initial 
      pll_dly_re_temp = convert_int(pll_dly_r[15:8]) * convert_int(pll_dly_r[7:0]) *0.25;

initial
      if(pll_dly_re_temp >= 0)
         pll_dly_re = 0.25 * convert_int(pll_dly_r[7:0]);
      else
         pll_dly_re = pll_dly_re_temp;


initial begin
  clklock_half_period1 = 0;
  clklock_half_period0 = 0;
  clklock_half_period_minus_dly1 = 0;
  clklock_half_period_minus_dly0 = 0;
  clockboost     = mult_i/div_i;
  new_delay      = 0.25 * convert_int(pll_dly_r[7:0]) * 100.0;
end


integer   cnt_m_div;
reg       clk_out_m_div;


buf buf_clkin (clkin_in, REFCLK);

integer clklock_rising_edge_count;
integer clklock_falling_edge_count;

initial
begin
	cnt_m_div = -1;
	clk_out_m_div = 0;
        clklock_rising_edge_count = 0;
        clklock_falling_edge_count = 0;
end

always @(posedge clkin_in) 
begin
    clklock_rising_edge_count = clklock_rising_edge_count + 1;
    clklock_last_rising_edge = $time;
end

always @(negedge clkin_in)
begin
    clklock_falling_edge_count = clklock_falling_edge_count + 1;
    clklock_last_falling_edge = $time;
end

always @(posedge clkin_in)
begin
    if (clklock_falling_edge_count == 2)
       clklock_half_period0 = ($time - clklock_last_falling_edge)*div_i/mult_i;
       clklock_half_period_minus_dly0 = ($time - clklock_last_falling_edge) + 100.0 * pll_dly_re; 
end

always @(negedge clkin_in) 
begin
    if (clklock_rising_edge_count == 1)
       clklock_half_period1 = ($time - clklock_last_rising_edge)*div_i/mult_i;
       clklock_half_period_minus_dly1 = ($time - clklock_last_rising_edge) + 100.0 * pll_dly_re; 
end

always @(negedge clkin_in) 
begin
clklock_half_period = (clklock_half_period0 + clklock_half_period1)/2.0; 
end

integer   i, j, n, clock_count, clock_count_falling;
reg       clock_out_sig;

initial
begin
	clock_out_sig = 1'b0;
	clock_count = -1;
	clock_count_falling = -1;
end
always @(clklock_rising_edge_count)
begin
    if (clklock_rising_edge_count > lock_cyc + 1)
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count = clock_count + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count = clock_count + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count = 0;
end

always @(clklock_falling_edge_count)
begin
    if (clklock_falling_edge_count > lock_cyc + 1)
    begin
      if (clockboost > 1)
       begin
	for (j = 1; j <= 2* clockboost ; j = j +1)
           begin
                clock_count_falling = clock_count_falling + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count_falling = clock_count_falling + 1;
                #clklock_half_period   n = 0;
           end
    end
    else
      clock_count_falling = 0;
end

reg PLL_LOCK_plus,PLL_LOCK_minus;
reg CLK_OUT_sig_d_start;

initial
begin
	PLL_LOCK_plus  = 1'b0;
	PLL_LOCK_minus = 1'b0;
	CLK_OUT_sig_d_start = 1'b0;
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    CLK_OUT_sig_d_start = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    PLL_LOCK_plus = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 3)
    PLL_LOCK_minus = 1'b1;
end

reg CLK_OUT_sig_d_not;
initial
begin
    CLK_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
      end
end

wire CLK_OUT_sig_d = ~CLK_OUT_sig_d_not && CLK_OUT_sig_d_start;

reg CLK_OUT_sig_3d;
wire CLK_OUT_plus_delay;

reg start_CLK_OUT;

initial 
begin
CLK_OUT_sig_3d = 1'b0; start_CLK_OUT = 1'b0;
end

always @(clock_count_falling)
begin
  if (clock_count_falling == 1)
  begin
    #clklock_half_period_minus_dly0 CLK_OUT_sig_3d = 1'b1; start_CLK_OUT = 1'b1;
  end
end

always @(start_CLK_OUT)
begin
 while (start_CLK_OUT) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_3d = ~ CLK_OUT_sig_3d;
         #clklock_half_period 
         CLK_OUT_sig_3d = ~ CLK_OUT_sig_3d;
      end
end

assign #new_delay CLK_OUT_plus_delay = CLK_OUT_sig_d;

assign CSLOCK = (PLL_LOCK_plus && (pll_dly_re>=0) || PLL_LOCK_minus && (pll_dly_re<0));

//#################
//#16-phase clocks#
//#################

assign inthsrecclk[0] = CLK_OUT_plus_delay && (pll_dly_re >=0) || CLK_OUT_sig_3d && (pll_dly_re<0);
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[1] = inthsrecclk[0]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[2] = inthsrecclk[1]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[3] = inthsrecclk[2]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[4] = inthsrecclk[3]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[5] = inthsrecclk[4]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[6] = inthsrecclk[5]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[7] = inthsrecclk[6]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[8] = inthsrecclk[7]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[9] = inthsrecclk[8]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[10] = inthsrecclk[9]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[11] = inthsrecclk[10]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[12] = inthsrecclk[11]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[13] = inthsrecclk[12]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[14] = inthsrecclk[13]; 
assign #(clklock_half_period*2*div_i/mult_i) inthsrecclk[15] = inthsrecclk[14]; 

//#################
//#digitial filter#
//#################

reg data_ins;
reg data_ina;
always @(posedge sclk)
   data_ins <= SIN;

time time_data;
time time_clock;
time time_delta;

always @(SIN)
   time_data = $time;

always @(posedge aclk)
   time_clock = $time;

always @(time_data or time_clock)
   if (time_data >= time_clock)
       time_delta = time_data - time_clock;
   else
       time_delta = time_clock- time_data;

reg data_inaa;
always @(posedge aclk)
  data_inaa <= SIN;

always @(aclk or time_delta or data_inaa)
if (aclk)
   begin
   if (time_delta < 1000)
      data_ina <= 1'bx;
   else 
      data_ina <= data_inaa;
   end

wire transition = data_ins ^ data_ina;

reg dn_ss;
always @(sclk or transition)
if (sclk)
    dn_ss <= transition;

reg dn_s;
always @(posedge sclk)
    dn_s <= dn_ss;

reg up_s;
always @(posedge sclk)
    up_s <= transition;

wire dn_clk = dn_s && aclk;
wire up_clk = up_s && aclk;

wire cntrst;
wire pcntrst;

reg[7:0] dn_cnt0;
always @(posedge dn_clk or posedge cntrst)
if (cntrst)
    dn_cnt0 <= 8'h00;
else
    dn_cnt0 <= dn_cnt0 + 1'b1;
    
reg[7:0] up_cnt0;
always @(posedge up_clk or posedge cntrst)
if (cntrst)
    up_cnt0 <= 8'h00;
else
    up_cnt0 <= up_cnt0 + 1'b1;
    
reg[7:0] dn_cnt, up_cnt;
always @(posedge aclk)
begin
   dn_cnt <= dn_cnt0;
   up_cnt <= up_cnt0;
end

reg[8:0] sub_cnt;
always @(posedge aclk or posedge cntrst)
if (cntrst)
   sub_cnt <= 9'h000;
else
   sub_cnt <= dn_cnt - up_cnt;

reg[7:0] add_cnt;
always @(posedge aclk or posedge cntrst)
if (cntrst)
   add_cnt <= 8'h00;
else
   add_cnt <= dn_cnt + up_cnt;

wire[7:0] lkdbw = F_LKDBW;
wire[7:0] lktbw = F_LKTBW;
wire[7:0] tkdbw = F_TKDBW;
wire[7:0] tktbw = F_TKTBW;

wire[7:0] dbw = CDRLOCK? tkdbw: lkdbw;
wire[7:0] tbw = CDRLOCK? tktbw: lktbw;

reg[7:0] diff_cnt;
always @(sub_cnt)
if (sub_cnt[8])
    diff_cnt <= ~(sub_cnt[7:0]);
else
    diff_cnt <= sub_cnt[7:0];

reg diffcmp;
always @(posedge aclk or posedge cntrst)
if (cntrst)
    diffcmp <= 1'b0;
else
    if (diff_cnt >= dbw)
        diffcmp <= 1'b1;
    else
        diffcmp <= 1'b0;

reg totce;
always @(add_cnt or tbw)
if (add_cnt[7:1] == tbw[7:1])
    totce <= 1'b1;
else
    totce <= 1'b0;

reg totcmp;
always @(posedge aclk or posedge CDRRST)
if (CDRRST)
    totcmp <= 1'b0;
else
    totcmp <= totce;

reg totcmp_d;
always @(posedge aclk or posedge CDRRST)
if (CDRRST)
    totcmp_d <= 1'b0;
else
    totcmp_d <= totcmp;

assign cntrst = CDRRST || totcmp;
assign pcntrst = CDRRST || totcmp_d;

reg pre_pull, pre_push;
always @(posedge aclk or posedge pcntrst)
if (pcntrst)
    begin
       pre_push <= 1'b0;
       pre_pull <= 1'b0;
    end
else
    begin
       if (totce)
           begin
               pre_push <= diffcmp && (~sub_cnt[8]);
               pre_pull <= diffcmp && sub_cnt[8];
           end
    end

reg push, pull;
always @(posedge aclk or posedge CDRRST)
if (CDRRST)
    begin
       push <= 1'b0;
       pull <= 1'b0;
    end
else
    begin
       push <= pre_push;
       pull <= pre_pull;
    end

//########################
//#phase shift and select#
//########################

reg[15:0] sclksel;
always @(posedge aclk or posedge CDRRST)
if (CDRRST)
    sclksel <= 16'h0100;
else
    if (pull)
        sclksel <= {sclksel[0], sclksel[15:1]};
    else if (push)
        sclksel <= {sclksel[14:0], sclksel[15]};

always @(sclksel or inthsrecclk)
case (sclksel)
16'h0001: begin
             aclk <= inthsrecclk[8]; 
             sclk <= inthsrecclk[0]; 
          end
16'h0002: begin
             aclk <= inthsrecclk[9]; 
             sclk <= inthsrecclk[1]; 
          end
16'h0004: begin
             aclk <= inthsrecclk[10]; 
             sclk <= inthsrecclk[2]; 
          end
16'h0008: begin
             aclk <= inthsrecclk[11]; 
             sclk <= inthsrecclk[3]; 
          end
16'h0010: begin
             aclk <= inthsrecclk[12]; 
             sclk <= inthsrecclk[4]; 
          end
16'h0020: begin
             aclk <= inthsrecclk[13]; 
             sclk <= inthsrecclk[5]; 
          end
16'h0040: begin
             aclk <= inthsrecclk[14]; 
             sclk <= inthsrecclk[6]; 
          end
16'h0080: begin
             aclk <= inthsrecclk[15]; 
             sclk <= inthsrecclk[7]; 
          end
16'h0100: begin
             aclk <= inthsrecclk[0]; 
             sclk <= inthsrecclk[8]; 
          end
16'h0200: begin
             aclk <= inthsrecclk[1]; 
             sclk <= inthsrecclk[9]; 
          end
16'h0400: begin
             aclk <= inthsrecclk[2]; 
             sclk <= inthsrecclk[10]; 
          end
16'h0800: begin
             aclk <= inthsrecclk[3]; 
             sclk <= inthsrecclk[11]; 
          end
16'h1000: begin
             aclk <= inthsrecclk[4]; 
             sclk <= inthsrecclk[12]; 
          end
16'h2000: begin
             aclk <= inthsrecclk[5]; 
             sclk <= inthsrecclk[13]; 
          end
16'h4000: begin
             aclk <= inthsrecclk[6]; 
             sclk <= inthsrecclk[14]; 
          end
16'h8000: begin
             aclk <= inthsrecclk[7]; 
             sclk <= inthsrecclk[15]; 
          end
default:  begin
             aclk <= inthsrecclk[0]; 
             sclk <= inthsrecclk[8]; 
          end
endcase

//#############
//#LOCK detect#
//#############

wire lock_rst = CDRRST || pull || push;

reg[2:0] lock_cnt;
always @(posedge totcmp or posedge lock_rst)
if (lock_rst)
    lock_cnt <= 3'b000;
else
    lock_cnt <= lock_cnt + 1'b1;

wire lockcmp = (lock_cnt == F_LOCK);

reg lockcmp_d1, lockcmp_d2;
always @(posedge aclk or posedge CDRRST)
if (CDRRST)
    begin
      lockcmp_d1 <= 1'b0;
      lockcmp_d2 <= 1'b0;
    end
else
    begin
      lockcmp_d1 <= lockcmp;
      lockcmp_d2 <= lockcmp_d1;
    end

wire lock_pulse = lockcmp_d1 && ~lockcmp_d2;

reg lock_int;
always @(CDRRST or lock_pulse)
if (CDRRST)
    lock_int <= 1'b0;
else
    if (lock_pulse)
        lock_int <= 1'b1;

reg lock0, lock1;
always @(posedge sclk or posedge CDRRST)
if (CDRRST)
    begin
       lock0 <= 1'b0;
       lock1 <= 1'b1;
    end
else
    begin
       lock0 <= lock_int;
       lock1 <= lock0;
    end

wire #(100) lock2 = lock1;

always @(posedge RECCLK_reg or posedge CDRRST)
if (CDRRST)
    CDRLOCK <= 1'b0;
else
    CDRLOCK <= lock2;

//######################################
//#SYNC detect & recover data and clock#
//######################################

always@(posedge sclk)
begin
     shift_buffer[15]   <= data_ins;
     shift_buffer[14:0] <= shift_buffer[15:1];
end

reg pre_align1, pre_align2;
always@(posedge sclk or posedge CDRRST)
if (CDRRST)
    begin
        pre_align1 <= 1'b0;
        pre_align2 <= 1'b0;
    end
else
    begin
        pre_align1 <= (shift_buffer[15:6] == sympat_r[9:0]);
        pre_align2 <= (shift_buffer[15:6] == sympat_r[19:10]);
    end

reg rsypt0, rsypt1;
always@(posedge sclk or negedge CDRRST)
if (CDRRST)
    begin
        align <= 1'b0;
        rsypt0 <= 1'b0;
    end
else
    begin
        align <= pre_align1 || pre_align2; 
        rsypt0 <= pre_align1 || pre_align2; 
    end

always @(posedge sclk or posedge CDRRST)
if(CDRRST)
    rsypt1 <= 1'b0;
else
    rsypt1 <= rsypt0;

wire #(100) rsypt2 = rsypt1;

reg[2:0] divcnt;
wire intrecclk1 = !(divcnt == 3'b011);
always @(posedge sclk or align)
if (align)
    divcnt <= 3'b111;
else
    if (divcnt == 3'b011)
        divcnt <= 3'b111;
    else
        divcnt <= divcnt - 1'b1;
    
reg intrecclk2;
always @(posedge sclk)
    intrecclk2 <= intrecclk1;

always @(posedge intrecclk2 or posedge align)
if (align)
    intrecclk <= 1'b0;
else
    intrecclk <= ~intrecclk;

always @(posedge sclk)
    RECCLK_reg <= intrecclk;

always @(posedge RECCLK_reg or posedge CDRRST)
if (CDRRST)
    SYDT <= 1'b0;
else
    SYDT <= rsypt2;

wire[15:0] #(100) shift_buffer_d = shift_buffer;

always @(posedge RECCLK_reg)
    store_buffer <= shift_buffer_d;

assign RXD0 = store_buffer[3];
assign RXD1 = store_buffer[4];
assign RXD2 = store_buffer[5];
assign RXD3 = store_buffer[6];
assign RXD4 = store_buffer[7];
assign RXD5 = store_buffer[8];
assign RXD6 = store_buffer[9];
assign RXD7 = store_buffer[10];
assign RXD8 = store_buffer[11];
assign RXD9 = store_buffer[12];

assign RECCLK = RECCLK_reg;

//##############
//## function ##
//##############

function convert_binary;
input [7:0] sym_str;
  begin

    if (sym_str == "1")
      convert_binary = 1'b1;
    else if (sym_str == "0")
      convert_binary = 1'b0;
    else 
      convert_binary = 1'b0;
  end
endfunction

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else
      convert_int = 0;
  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction

specify 
 
(REFCLK => RECCLK)   =   0:0:0, 0:0:0;
(REFCLK => CSLOCK)    =   0:0:0, 0:0:0;
 
endspecify 

endmodule

`endcelldefine 


`celldefine 
`timescale 100 fs / 1 fs

module CDRX_SS_4(CAL,SIN, SS_CLKIN, RXD0, RXD1, RXD2, RXD3, RECCLK, CSLOCK, SYDT);

parameter   in_freq    = "100.0";
parameter   div        = "1";
parameter   mult       = "4";
parameter   pll_dly    = "0.0";
parameter   sympat     = "110011001100";
parameter   lock_cyc   = 2;

//###########################
//#digital filter parameters#
//###########################

parameter   F_LKDBW    = 8'h0f;
parameter   F_LKTBW    = 8'h3f;
parameter   F_TKDBW    = 8'h1f;
parameter   F_TKTBW    = 8'h7f;
parameter   F_LOCK     = 3'b011;

integer     clockboost;

input  CAL;
input  SIN;
input  SS_CLKIN;
output RECCLK,CSLOCK;
output RXD0,RXD1,RXD2,RXD3;
output SYDT;

wire   RXD0;
wire   RXD1;
wire   RXD2;
wire   RXD3;

reg    CDRLOCK;
reg    RECCLK_reg;
wire   CSLOCK;
wire[15:0] inthsrecclk;
reg    intrecclk;

wire   clkin_in;

reg    align;
reg    SYDT;

reg    [15:0]  store_buffer;
reg    [15:0]  shift_buffer;
reg    aclk, sclk;

time   new_delay;

time   clklock_last_rising_edge;
time   clklock_half_period;
time   clklock_half_period_minus_dly;

reg [95:0] symstr_r;
reg [11:0] sympat_r;
initial symstr_r = sympat;
initial sympat_r[0] = convert_binary(symstr_r[7:0]); 
initial sympat_r[1] = convert_binary(symstr_r[15:8]); 
initial sympat_r[2] = convert_binary(symstr_r[23:16]); 
initial sympat_r[3] = convert_binary(symstr_r[31:24]); 
initial sympat_r[4] = convert_binary(symstr_r[39:32]); 
initial sympat_r[5] = convert_binary(symstr_r[47:40]); 
initial sympat_r[6] = convert_binary(symstr_r[55:48]); 
initial sympat_r[7] = convert_binary(symstr_r[63:56]); 
initial sympat_r[8] = convert_binary(symstr_r[71:64]); 
initial sympat_r[9] = convert_binary(symstr_r[79:72]); 
initial sympat_r[10] = convert_binary(symstr_r[87:80]); 
initial sympat_r[11] = convert_binary(symstr_r[95:88]); 

//#########
//## PLL ##
//#########

reg [15:0] mult_r;
integer mult_i;
initial mult_r = mult;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = div;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [31:0] pll_dly_r;
real pll_dly_re;
initial pll_dly_r = pll_dly;
initial pll_dly_re = convert_real(pll_dly_r[31:24]) * (convert_real(pll_dly_r[23:16]) + 0.1 * convert_real(pll_dly_r[7:0]));

initial begin
  clklock_half_period = 0;
  clockboost     = 10 * mult_i/div_i;
  new_delay      = pll_dly_re * 10.0;
end


buf buf_clkin (clkin_in, SS_CLKIN);

integer clklock_rising_edge_count;

initial
begin
        clklock_rising_edge_count = 0;
end

always @(posedge clkin_in) begin
    clklock_rising_edge_count = clklock_rising_edge_count + 1;
    clklock_last_rising_edge = $time;
end

always @(negedge clkin_in) begin
    if (clklock_rising_edge_count == 1)
       clklock_half_period = ($time - clklock_last_rising_edge)*div_i/mult_i;
       clklock_half_period_minus_dly = clklock_half_period + 10.0 * pll_dly_re; 
end

integer   i, n, clock_count;
reg       clock_out_sig;

initial
begin
	clock_out_sig = 1'b0;
	clock_count = -1;
end
always @(clklock_rising_edge_count)
begin
    if (clklock_rising_edge_count >2 )
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count = clock_count + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count = clock_count + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count = 0;
end

reg PLL_LOCK_plus,PLL_LOCK_minus;
reg CLK_OUT_sig_d_start;

initial
begin
	PLL_LOCK_plus  = 1'b0;
	PLL_LOCK_minus = 1'b0;
	CLK_OUT_sig_d_start = 1'b0;
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    PLL_LOCK_plus = 1'b1;
    CLK_OUT_sig_d_start = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 3)
    PLL_LOCK_minus = 1'b1;
end

reg CLK_OUT_sig_d_not;
initial
begin
    CLK_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
      end
end

wire CLK_OUT_sig_d = ~CLK_OUT_sig_d_not && CLK_OUT_sig_d_start;

wire CLK_OUT_sig_2d;
wire CLK_OUT_sig_3d;
wire CLK_OUT_sig_dly;
wire CLK_OUT_plus_delay;

assign #clklock_half_period CLK_OUT_sig_2d = CLK_OUT_sig_d;
assign #clklock_half_period_minus_dly CLK_OUT_sig_3d = CLK_OUT_sig_2d;
assign #new_delay CLK_OUT_plus_delay = CLK_OUT_sig_d;

assign CSLOCK = (PLL_LOCK_plus && (pll_dly_re>=0) || PLL_LOCK_minus && (pll_dly_re<0));

//#################
//#16-phase clocks#
//#################

assign inthsrecclk[0] = !CSLOCK && clock_out_sig || CSLOCK && (CLK_OUT_plus_delay && (pll_dly_re >=0) || CLK_OUT_sig_3d && (pll_dly_re<0));
assign #(clklock_half_period/8) inthsrecclk[1] = inthsrecclk[0]; 
assign #(clklock_half_period/8) inthsrecclk[2] = inthsrecclk[1]; 
assign #(clklock_half_period/8) inthsrecclk[3] = inthsrecclk[2]; 
assign #(clklock_half_period/8) inthsrecclk[4] = inthsrecclk[3]; 
assign #(clklock_half_period/8) inthsrecclk[5] = inthsrecclk[4]; 
assign #(clklock_half_period/8) inthsrecclk[6] = inthsrecclk[5]; 
assign #(clklock_half_period/8) inthsrecclk[7] = inthsrecclk[6]; 
assign #(clklock_half_period/8) inthsrecclk[8] = inthsrecclk[7]; 
assign #(clklock_half_period/8) inthsrecclk[9] = inthsrecclk[8]; 
assign #(clklock_half_period/8) inthsrecclk[10] = inthsrecclk[9]; 
assign #(clklock_half_period/8) inthsrecclk[11] = inthsrecclk[10]; 
assign #(clklock_half_period/8) inthsrecclk[12] = inthsrecclk[11]; 
assign #(clklock_half_period/8) inthsrecclk[13] = inthsrecclk[12]; 
assign #(clklock_half_period/8) inthsrecclk[14] = inthsrecclk[13]; 
assign #(clklock_half_period/8) inthsrecclk[15] = inthsrecclk[14]; 

//#################
//#digitial filter#
//#################

reg cal_d1, cal_d2;
wire calrst = cal_d1 && ~cal_d2;

always @(posedge aclk)
begin
    cal_d1 <= CAL;
    cal_d2 <= cal_d1;
end

reg data_ins;
reg data_ina;
always @(posedge sclk)
   data_ins <= SIN;

time time_data;
time time_clock;
time time_delta;

always @(SIN)
   time_data = $time;

always @(posedge aclk)
   time_clock = $time;

always @(time_data or time_clock)
   if (time_data >= time_clock)
       time_delta = time_data - time_clock;
   else
       time_delta = time_clock- time_data;

reg data_inaa;
always @(posedge aclk)
  data_inaa <= SIN;

always @(aclk or time_delta or data_inaa)
if (aclk)
   begin
   if (time_delta < 100)
      data_ina <= 1'bx;
   else
      data_ina <= data_inaa;
   end

wire transition = data_ins ^ data_ina;

reg dn_ss;
always @(sclk or transition)
if (sclk)
    dn_ss <= transition;

reg dn_s;
always @(posedge sclk)
    dn_s <= dn_ss;

reg up_s;
always @(posedge sclk)
    up_s <= transition;

wire dn_clk = dn_s && aclk;
wire up_clk = up_s && aclk;

wire cntrst;
wire pcntrst;

reg[7:0] dn_cnt0;
initial
dn_cnt0 <= 8'h00;
always @(posedge dn_clk or posedge cntrst)
if (cntrst)
    dn_cnt0 <= 8'h00;
else
    dn_cnt0 <= dn_cnt0 + 1'b1;
    
reg[7:0] up_cnt0;
initial
up_cnt0 <= 8'h00;
always @(posedge up_clk or posedge cntrst)
if (cntrst)
    up_cnt0 <= 8'h00;
else
    up_cnt0 <= up_cnt0 + 1'b1;
    
reg[7:0] dn_cnt, up_cnt;
always @(posedge aclk)
begin
   dn_cnt <= dn_cnt0;
   up_cnt <= up_cnt0;
end

reg[8:0] sub_cnt;
always @(posedge aclk or posedge cntrst)
if (cntrst)
   sub_cnt <= 9'h000;
else
   sub_cnt <= dn_cnt - up_cnt;

reg[7:0] add_cnt;
always @(posedge aclk or posedge cntrst)
if (cntrst)
   add_cnt <= 8'h00;
else
   add_cnt <= dn_cnt + up_cnt;

wire[7:0] lkdbw = F_LKDBW;
wire[7:0] lktbw = F_LKTBW;
wire[7:0] tkdbw = F_TKDBW;
wire[7:0] tktbw = F_TKTBW;

wire[7:0] dbw = CDRLOCK? tkdbw: lkdbw;
wire[7:0] tbw = CDRLOCK? tktbw: lktbw;

reg[7:0] diff_cnt;
always @(sub_cnt)
if (sub_cnt[8])
    diff_cnt <= ~(sub_cnt[7:0]);
else
    diff_cnt <= sub_cnt[7:0];

reg diffcmp;
always @(posedge aclk or posedge cntrst)
if (cntrst)
    diffcmp <= 1'b0;
else
    if (diff_cnt >= dbw)
        diffcmp <= 1'b1;
    else
        diffcmp <= 1'b0;

reg totce;
always @(add_cnt or tbw)
if (add_cnt[7:1] == tbw[7:1])
    totce <= 1'b1;
else
    totce <= 1'b0;

reg totcmp;
always @(posedge aclk)
totcmp <= totce;

reg totcmp_d;
always @(posedge aclk)
totcmp_d <= totcmp;

assign cntrst = totcmp;
assign pcntrst = totcmp_d;

reg pre_pull, pre_push;
initial
begin
  pre_push <= 1'b0;
  pre_pull <= 1'b0;
end
always @(posedge aclk or posedge pcntrst)
if (pcntrst)
    begin
       pre_push <= 1'b0;
       pre_pull <= 1'b0;
    end
else
    begin
       if (totce)
           begin
               pre_push <= diffcmp && (~sub_cnt[8]);
               pre_pull <= diffcmp && sub_cnt[8];
           end
    end

reg push, pull;
always @(posedge aclk)
if (CAL)
    begin
       push <= pre_push;
       pull <= pre_pull;
    end
else
    begin
       push <= 1'b0;
       pull <= 1'b0;
    end

//########################
//#phase shift and select#
//########################

reg[15:0] sclksel;
always @(posedge aclk or posedge calrst)
if (calrst)
    sclksel <= 16'h0100;
else
    if (pull)
        sclksel <= {sclksel[0], sclksel[15:1]};
    else if (push)
        sclksel <= {sclksel[14:0], sclksel[15]};

always @(sclksel or inthsrecclk)
case (sclksel)
16'h0001: begin
             aclk <= inthsrecclk[8]; 
             sclk <= inthsrecclk[0]; 
          end
16'h0002: begin
             aclk <= inthsrecclk[9]; 
             sclk <= inthsrecclk[1]; 
          end
16'h0004: begin
             aclk <= inthsrecclk[10]; 
             sclk <= inthsrecclk[2]; 
          end
16'h0008: begin
             aclk <= inthsrecclk[11]; 
             sclk <= inthsrecclk[3]; 
          end
16'h0010: begin
             aclk <= inthsrecclk[12]; 
             sclk <= inthsrecclk[4]; 
          end
16'h0020: begin
             aclk <= inthsrecclk[13]; 
             sclk <= inthsrecclk[5]; 
          end
16'h0040: begin
             aclk <= inthsrecclk[14]; 
             sclk <= inthsrecclk[6]; 
          end
16'h0080: begin
             aclk <= inthsrecclk[15]; 
             sclk <= inthsrecclk[7]; 
          end
16'h0100: begin
             aclk <= inthsrecclk[0]; 
             sclk <= inthsrecclk[8]; 
          end
16'h0200: begin
             aclk <= inthsrecclk[1]; 
             sclk <= inthsrecclk[9]; 
          end
16'h0400: begin
             aclk <= inthsrecclk[2]; 
             sclk <= inthsrecclk[10]; 
          end
16'h0800: begin
             aclk <= inthsrecclk[3]; 
             sclk <= inthsrecclk[11]; 
          end
16'h1000: begin
             aclk <= inthsrecclk[4]; 
             sclk <= inthsrecclk[12]; 
          end
16'h2000: begin
             aclk <= inthsrecclk[5]; 
             sclk <= inthsrecclk[13]; 
          end
16'h4000: begin
             aclk <= inthsrecclk[6]; 
             sclk <= inthsrecclk[14]; 
          end
16'h8000: begin
             aclk <= inthsrecclk[7]; 
             sclk <= inthsrecclk[15]; 
          end
default:  begin
             aclk <= inthsrecclk[0]; 
             sclk <= inthsrecclk[8]; 
          end
endcase
//#############
//#LOCK detect#
//#############

wire lock_rst = calrst || pull || push;

reg[2:0] lock_cnt;
always @(posedge totcmp or posedge lock_rst)
if (lock_rst)
    lock_cnt <= 3'b000;
else
    lock_cnt <= lock_cnt + 1'b1;

wire lockcmp = (lock_cnt == F_LOCK);

reg lockcmp_d1, lockcmp_d2;
always @(posedge aclk or posedge calrst)
if (calrst)
    begin
      lockcmp_d1 <= 1'b0;
      lockcmp_d2 <= 1'b0;
    end
else
    begin
      lockcmp_d1 <= lockcmp;
      lockcmp_d2 <= lockcmp_d1;
    end

wire lock_pulse = lockcmp_d1 && ~lockcmp_d2;

reg lock_int;
always @(calrst or lock_pulse)
if (calrst)
    lock_int <= 1'b0;
else
    if (lock_pulse)
        lock_int <= 1'b1;

reg lock0, lock1;
always @(posedge sclk)
begin
   lock0 <= lock_int;
   lock1 <= lock0;
end

wire #(100) lock2 = lock1;

always @(posedge RECCLK_reg)
    CDRLOCK <= lock2;

//######################################
//#SYNC detect & recover data and clock#
//######################################

always@(posedge sclk)
begin
     shift_buffer[15]   <= data_ins;
     shift_buffer[14:0] <= shift_buffer[15:1];
end

reg pre_align;
always@(posedge sclk)
pre_align <= (shift_buffer[15:4] == sympat_r[11:0]);

reg rsypt0, rsypt1;
always@(posedge sclk)
rsypt0 <= pre_align; 

wire align_rst = ~lock1;
always@(posedge sclk)
if (~align_rst)
    align <= 1'b0;
else
    align <= pre_align; 

always @(posedge sclk)
rsypt1 <= rsypt0;

wire #(100) rsypt2 = rsypt1;

reg[2:0] divcnt;

initial
    divcnt <= 3'b111;

wire intrecclk1 = !(divcnt == 3'b110);
always @(posedge sclk or align)
if (align)
    divcnt <= 3'b111;
else
    if (divcnt == 3'b110)
        divcnt <= 3'b111;
    else
        divcnt <= divcnt - 1'b1;

reg intrecclk2;
always @(posedge sclk)
    intrecclk2 <= intrecclk1;

always @(posedge intrecclk2 or posedge align)
if (align)
    intrecclk <= 1'b0;
else
    intrecclk <= ~intrecclk;

always @(posedge sclk)
    RECCLK_reg <= intrecclk;

always @(posedge RECCLK_reg)
SYDT <= rsypt2;

wire[15:0] #(100) shift_buffer_d = shift_buffer;

always @(posedge RECCLK_reg)
    store_buffer <= shift_buffer_d;

assign RXD0 = store_buffer[9];
assign RXD1 = store_buffer[10];
assign RXD2 = store_buffer[11];
assign RXD3 = store_buffer[12];


assign RECCLK = RECCLK_reg;

//##############
//## function ##
//##############

function convert_binary;
input [7:0] sym_str;
  begin

    if (sym_str == "1")
      convert_binary = 1'b1;
    else if (sym_str == "0")
      convert_binary = 1'b0;
    else 
      convert_binary = 1'b0;
  end
endfunction

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else
      convert_int = 0;
  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction


specify 
 
(SS_CLKIN => RECCLK)   =   0:0:0, 0:0:0;
(SS_CLKIN => CSLOCK)    =   0:0:0, 0:0:0;
 
endspecify 

endmodule

`endcelldefine 

`celldefine 
`timescale 100 fs / 1 fs

module CDRX_SS_6(CAL,SIN, SS_CLKIN, RXD0, RXD1, RXD2, RXD3, RXD4, RXD5, RECCLK, CSLOCK, SYDT);

parameter   in_freq    = "100.0";
parameter   div        = "1";
parameter   mult       = "6";
parameter   pll_dly    = "0.0";
parameter   sympat     = "111000111000";
parameter   lock_cyc   = 2;

//###########################
//#digital filter parameters#
//###########################

parameter   F_LKDBW    = 8'h0f;
parameter   F_LKTBW    = 8'h3f;
parameter   F_TKDBW    = 8'h1f;
parameter   F_TKTBW    = 8'h7f;
parameter   F_LOCK     = 3'b011;

integer     clockboost;

input  CAL;
input  SIN;
input  SS_CLKIN;
output RECCLK,CSLOCK;
output RXD0,RXD1,RXD2,RXD3,RXD4,RXD5;
output SYDT;

wire   RXD0;
wire   RXD1;
wire   RXD2;
wire   RXD3;
wire   RXD4;
wire   RXD5;

reg    CDRLOCK;
reg    RECCLK_reg;
wire   CSLOCK;
wire[15:0] inthsrecclk;
reg    intrecclk;

wire   clkin_in;

reg    align;
reg    SYDT;

reg    [15:0]  store_buffer;
reg    [15:0]  shift_buffer;
reg    aclk, sclk;

time   new_delay;

time   clklock_last_rising_edge;
time   clklock_half_period;
time   clklock_half_period_minus_dly;

reg [95:0] symstr_r;
reg [11:0] sympat_r;
initial symstr_r = sympat;
initial sympat_r[0] = convert_binary(symstr_r[7:0]); 
initial sympat_r[1] = convert_binary(symstr_r[15:8]); 
initial sympat_r[2] = convert_binary(symstr_r[23:16]); 
initial sympat_r[3] = convert_binary(symstr_r[31:24]); 
initial sympat_r[4] = convert_binary(symstr_r[39:32]); 
initial sympat_r[5] = convert_binary(symstr_r[47:40]); 
initial sympat_r[6] = convert_binary(symstr_r[55:48]); 
initial sympat_r[7] = convert_binary(symstr_r[63:56]); 
initial sympat_r[8] = convert_binary(symstr_r[71:64]); 
initial sympat_r[9] = convert_binary(symstr_r[79:72]); 
initial sympat_r[10] = convert_binary(symstr_r[87:80]); 
initial sympat_r[11] = convert_binary(symstr_r[95:88]); 

//#########
//## PLL ##
//#########

reg [15:0] mult_r;
integer mult_i;
initial mult_r = mult;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = div;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [31:0] pll_dly_r;
real pll_dly_re;
initial pll_dly_r = pll_dly;
initial pll_dly_re = convert_real(pll_dly_r[31:24]) * (convert_real(pll_dly_r[23:16]) + 0.1 * convert_real(pll_dly_r[7:0]));

initial begin
  clklock_half_period = 0;
  clockboost     = 10 * mult_i/div_i;
  new_delay      = pll_dly_re * 10.0;
end


buf buf_clkin (clkin_in, SS_CLKIN);

integer clklock_rising_edge_count;

initial
begin
        clklock_rising_edge_count = 0;
end

always @(posedge clkin_in) begin
    clklock_rising_edge_count = clklock_rising_edge_count + 1;
    clklock_last_rising_edge = $time;
end

always @(negedge clkin_in) begin
    if (clklock_rising_edge_count == 1)
       clklock_half_period = ($time - clklock_last_rising_edge)*div_i/mult_i;
       clklock_half_period_minus_dly = clklock_half_period + 10.0 * pll_dly_re; 
end

integer   i, n, clock_count;
reg       clock_out_sig;

initial
begin
	clock_out_sig = 1'b0;
	clock_count = -1;
end
always @(clklock_rising_edge_count)
begin
    if (clklock_rising_edge_count >2 )
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count = clock_count + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count = clock_count + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count = 0;
end

reg PLL_LOCK_plus,PLL_LOCK_minus;
reg CLK_OUT_sig_d_start;

initial
begin
	PLL_LOCK_plus  = 1'b0;
	PLL_LOCK_minus = 1'b0;
	CLK_OUT_sig_d_start = 1'b0;
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    PLL_LOCK_plus = 1'b1;
    CLK_OUT_sig_d_start = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 3)
    PLL_LOCK_minus = 1'b1;
end

reg CLK_OUT_sig_d_not;
initial
begin
    CLK_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
      end
end

wire CLK_OUT_sig_d = ~CLK_OUT_sig_d_not && CLK_OUT_sig_d_start;

wire CLK_OUT_sig_2d;
wire CLK_OUT_sig_3d;
wire CLK_OUT_sig_dly;
wire CLK_OUT_plus_delay;

assign #clklock_half_period CLK_OUT_sig_2d = CLK_OUT_sig_d;
assign #clklock_half_period_minus_dly CLK_OUT_sig_3d = CLK_OUT_sig_2d;
assign #new_delay CLK_OUT_plus_delay = CLK_OUT_sig_d;

assign CSLOCK = (PLL_LOCK_plus && (pll_dly_re>=0) || PLL_LOCK_minus && (pll_dly_re<0));

//#################
//#16-phase clocks#
//#################

assign inthsrecclk[0] = !CSLOCK && clock_out_sig || CSLOCK && (CLK_OUT_plus_delay && (pll_dly_re >=0) || CLK_OUT_sig_3d && (pll_dly_re<0));
assign #(clklock_half_period/8) inthsrecclk[1] = inthsrecclk[0]; 
assign #(clklock_half_period/8) inthsrecclk[2] = inthsrecclk[1]; 
assign #(clklock_half_period/8) inthsrecclk[3] = inthsrecclk[2]; 
assign #(clklock_half_period/8) inthsrecclk[4] = inthsrecclk[3]; 
assign #(clklock_half_period/8) inthsrecclk[5] = inthsrecclk[4]; 
assign #(clklock_half_period/8) inthsrecclk[6] = inthsrecclk[5]; 
assign #(clklock_half_period/8) inthsrecclk[7] = inthsrecclk[6]; 
assign #(clklock_half_period/8) inthsrecclk[8] = inthsrecclk[7]; 
assign #(clklock_half_period/8) inthsrecclk[9] = inthsrecclk[8]; 
assign #(clklock_half_period/8) inthsrecclk[10] = inthsrecclk[9]; 
assign #(clklock_half_period/8) inthsrecclk[11] = inthsrecclk[10]; 
assign #(clklock_half_period/8) inthsrecclk[12] = inthsrecclk[11]; 
assign #(clklock_half_period/8) inthsrecclk[13] = inthsrecclk[12]; 
assign #(clklock_half_period/8) inthsrecclk[14] = inthsrecclk[13]; 
assign #(clklock_half_period/8) inthsrecclk[15] = inthsrecclk[14]; 

//#################
//#digitial filter#
//#################

reg cal_d1, cal_d2;
wire calrst = cal_d1 && ~cal_d2;

always @(posedge aclk)
begin
    cal_d1 <= CAL;
    cal_d2 <= cal_d1;
end

reg data_ins;
reg data_ina;
always @(posedge sclk)
   data_ins <= SIN;

time time_data;
time time_clock;
time time_delta;

always @(SIN)
   time_data = $time;

always @(posedge aclk)
   time_clock = $time;

always @(time_data or time_clock)
   if (time_data >= time_clock)
       time_delta = time_data - time_clock;
   else
       time_delta = time_clock- time_data;

reg data_inaa;
always @(posedge aclk)
  data_inaa <= SIN;

always @(aclk or time_delta or data_inaa)
if (aclk)
   begin
   if (time_delta < 100)
      data_ina <= 1'bx;
   else
      data_ina <= data_inaa;
   end

wire transition = data_ins ^ data_ina;

reg dn_ss;
always @(sclk or transition)
if (sclk)
    dn_ss <= transition;

reg dn_s;
always @(posedge sclk)
    dn_s <= dn_ss;

reg up_s;
always @(posedge sclk)
    up_s <= transition;

wire dn_clk = dn_s && aclk;
wire up_clk = up_s && aclk;

wire cntrst;
wire pcntrst;

reg[7:0] dn_cnt0;
initial
    dn_cnt0 <= 8'h00;

always @(posedge dn_clk or posedge cntrst)
if (cntrst)
    dn_cnt0 <= 8'h00;
else
    dn_cnt0 <= dn_cnt0 + 1'b1;
    
reg[7:0] up_cnt0;
initial
    up_cnt0 <= 8'h00;
always @(posedge up_clk or posedge cntrst)
if (cntrst)
    up_cnt0 <= 8'h00;
else
    up_cnt0 <= up_cnt0 + 1'b1;
    
reg[7:0] dn_cnt, up_cnt;
always @(posedge aclk)
begin
   dn_cnt <= dn_cnt0;
   up_cnt <= up_cnt0;
end

reg[8:0] sub_cnt;
always @(posedge aclk or posedge cntrst)
if (cntrst)
   sub_cnt <= 9'h000;
else
   sub_cnt <= dn_cnt - up_cnt;

reg[7:0] add_cnt;
always @(posedge aclk or posedge cntrst)
if (cntrst)
   add_cnt <= 8'h00;
else
   add_cnt <= dn_cnt + up_cnt;

wire[7:0] lkdbw = F_LKDBW;
wire[7:0] lktbw = F_LKTBW;
wire[7:0] tkdbw = F_TKDBW;
wire[7:0] tktbw = F_TKTBW;

wire[7:0] dbw = CDRLOCK? tkdbw: lkdbw;
wire[7:0] tbw = CDRLOCK? tktbw: lktbw;

reg[7:0] diff_cnt;
always @(sub_cnt)
if (sub_cnt[8])
    diff_cnt <= ~(sub_cnt[7:0]);
else
    diff_cnt <= sub_cnt[7:0];

reg diffcmp;
always @(posedge aclk or posedge cntrst)
if (cntrst)
    diffcmp <= 1'b0;
else
    if (diff_cnt >= dbw)
        diffcmp <= 1'b1;
    else
        diffcmp <= 1'b0;

reg totce;
always @(add_cnt or tbw)
if (add_cnt[7:1] == tbw[7:1])
    totce <= 1'b1;
else
    totce <= 1'b0;

reg totcmp;
always @(posedge aclk)
totcmp <= totce;

reg totcmp_d;
always @(posedge aclk)
totcmp_d <= totcmp;

assign cntrst = totcmp;
assign pcntrst = totcmp_d;

reg pre_pull, pre_push;
initial
begin
  pre_push <= 1'b0;
  pre_pull <= 1'b0;
end
always @(posedge aclk or posedge pcntrst)
if (pcntrst)
    begin
       pre_push <= 1'b0;
       pre_pull <= 1'b0;
    end
else
    begin
       if (totce)
           begin
               pre_push <= diffcmp && (~sub_cnt[8]);
               pre_pull <= diffcmp && sub_cnt[8];
           end
    end

reg push, pull;
always @(posedge aclk)
if (CAL)
    begin
       push <= pre_push;
       pull <= pre_pull;
    end
else
    begin
       push <= 1'b0;
       pull <= 1'b0;
    end

//########################
//#phase shift and select#
//########################

reg[15:0] sclksel;
always @(posedge aclk or posedge calrst)
if (calrst)
    sclksel <= 16'h0100;
else
    if (pull)
        sclksel <= {sclksel[0], sclksel[15:1]};
    else if (push)
        sclksel <= {sclksel[14:0], sclksel[15]};

always @(sclksel or inthsrecclk)
case (sclksel)
16'h0001: begin
             aclk <= inthsrecclk[8]; 
             sclk <= inthsrecclk[0]; 
          end
16'h0002: begin
             aclk <= inthsrecclk[9]; 
             sclk <= inthsrecclk[1]; 
          end
16'h0004: begin
             aclk <= inthsrecclk[10]; 
             sclk <= inthsrecclk[2]; 
          end
16'h0008: begin
             aclk <= inthsrecclk[11]; 
             sclk <= inthsrecclk[3]; 
          end
16'h0010: begin
             aclk <= inthsrecclk[12]; 
             sclk <= inthsrecclk[4]; 
          end
16'h0020: begin
             aclk <= inthsrecclk[13]; 
             sclk <= inthsrecclk[5]; 
          end
16'h0040: begin
             aclk <= inthsrecclk[14]; 
             sclk <= inthsrecclk[6]; 
          end
16'h0080: begin
             aclk <= inthsrecclk[15]; 
             sclk <= inthsrecclk[7]; 
          end
16'h0100: begin
             aclk <= inthsrecclk[0]; 
             sclk <= inthsrecclk[8]; 
          end
16'h0200: begin
             aclk <= inthsrecclk[1]; 
             sclk <= inthsrecclk[9]; 
          end
16'h0400: begin
             aclk <= inthsrecclk[2]; 
             sclk <= inthsrecclk[10]; 
          end
16'h0800: begin
             aclk <= inthsrecclk[3]; 
             sclk <= inthsrecclk[11]; 
          end
16'h1000: begin
             aclk <= inthsrecclk[4]; 
             sclk <= inthsrecclk[12]; 
          end
16'h2000: begin
             aclk <= inthsrecclk[5]; 
             sclk <= inthsrecclk[13]; 
          end
16'h4000: begin
             aclk <= inthsrecclk[6]; 
             sclk <= inthsrecclk[14]; 
          end
16'h8000: begin
             aclk <= inthsrecclk[7]; 
             sclk <= inthsrecclk[15]; 
          end
default:  begin
             aclk <= inthsrecclk[0]; 
             sclk <= inthsrecclk[8]; 
          end
endcase

//#############
//#LOCK detect#
//#############

wire lock_rst = calrst || pull || push;

reg[2:0] lock_cnt;
always @(posedge totcmp or posedge lock_rst)
if (lock_rst)
    lock_cnt <= 3'b000;
else
    lock_cnt <= lock_cnt + 1'b1;

wire lockcmp = (lock_cnt == F_LOCK);

reg lockcmp_d1, lockcmp_d2;
always @(posedge aclk or posedge calrst)
if (calrst)
    begin
      lockcmp_d1 <= 1'b0;
      lockcmp_d2 <= 1'b0;
    end
else
    begin
      lockcmp_d1 <= lockcmp;
      lockcmp_d2 <= lockcmp_d1;
    end

wire lock_pulse = lockcmp_d1 && ~lockcmp_d2;

reg lock_int;
always @(calrst or lock_pulse)
if (calrst)
    lock_int <= 1'b0;
else
    if (lock_pulse)
        lock_int <= 1'b1;

reg lock0, lock1;
always @(posedge sclk)
begin
   lock0 <= lock_int;
   lock1 <= lock0;
end

wire #(100) lock2 = lock1;

always @(posedge RECCLK_reg)
    CDRLOCK <= lock2;

//######################################
//#SYNC detect & recover data and clock#
//######################################

always@(posedge sclk)
begin
     shift_buffer[15]   <= data_ins;
     shift_buffer[14:0] <= shift_buffer[15:1];
end

reg pre_align;
always@(posedge sclk)
pre_align <= (shift_buffer[15:4] == sympat_r[11:0]);

reg rsypt0, rsypt1;
always@(posedge sclk)
rsypt0 <= pre_align; 

wire align_rst = ~lock1;
always@(posedge sclk)
if (~align_rst)
    align <= 1'b0;
else
    align <= pre_align; 

always @(posedge sclk)
rsypt1 <= rsypt0;

wire #(100) rsypt2 = rsypt1;

reg[2:0] divcnt;
wire intrecclk1 = !(divcnt == 3'b101);

initial 
    divcnt <= 3'b111;
   
always @(posedge sclk or align)
if (align)
    divcnt <= 3'b111;
else
    if (divcnt == 3'b101)
        divcnt <= 3'b111;
    else
        divcnt <= divcnt - 1'b1;
    
reg intrecclk2;
always @(posedge sclk)
    intrecclk2 <= intrecclk1;

initial 
intrecclk <= 1'b0;
always @(posedge intrecclk2 or posedge align)
if (align)
    intrecclk <= 1'b0;
else
    intrecclk <= ~intrecclk;

always @(posedge sclk)
    RECCLK_reg <= intrecclk;

always @(posedge RECCLK_reg)
SYDT <= rsypt2;

wire[15:0] #(100) shift_buffer_d = shift_buffer;

always @(posedge RECCLK_reg)
    store_buffer <= shift_buffer_d;

assign RXD0 = store_buffer[7];
assign RXD1 = store_buffer[8];
assign RXD2 = store_buffer[9];
assign RXD3 = store_buffer[10];
assign RXD4 = store_buffer[11];
assign RXD5 = store_buffer[12];

assign RECCLK = RECCLK_reg;
//##############
//## function ##
//##############

function convert_binary;
input [7:0] sym_str;
  begin

    if (sym_str == "1")
      convert_binary = 1'b1;
    else if (sym_str == "0")
      convert_binary = 1'b0;
    else 
      convert_binary = 1'b0;
  end
endfunction

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else
      convert_int = 0;
  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction


specify 
 
(SS_CLKIN => RECCLK)   =   0:0:0, 0:0:0;
(SS_CLKIN => CSLOCK)    =   0:0:0, 0:0:0;
 
endspecify 

endmodule

`endcelldefine 

`celldefine 
`timescale 100 fs / 1 fs

module CDRX_SS_8(CAL,SIN, SS_CLKIN, RXD0, RXD1, RXD2, RXD3, RXD4, RXD5, RXD6, RXD7, RECCLK, CSLOCK, SYDT);

parameter   in_freq    = "100.0";
parameter   div        = "1";
parameter   mult       = "8";
parameter   pll_dly    = "0.0";
parameter   sympat     = "000011110000";
parameter   lock_cyc   = 2;

//###########################
//#digital filter parameters#
//###########################

parameter   F_LKDBW    = 8'h0f;
parameter   F_LKTBW    = 8'h3f;
parameter   F_TKDBW    = 8'h1f;
parameter   F_TKTBW    = 8'h7f;
parameter   F_LOCK     = 3'b011;

integer     clockboost;

input  CAL;
input  SIN;
input  SS_CLKIN;
output RECCLK,CSLOCK;
output RXD0,RXD1,RXD2,RXD3,RXD4,RXD5,RXD6,RXD7;
output SYDT;

wire   RXD0;
wire   RXD1;
wire   RXD2;
wire   RXD3;
wire   RXD4;
wire   RXD5;
wire   RXD6;
wire   RXD7;

reg    CDRLOCK;
reg    RECCLK_reg;
wire   CSLOCK;
wire[15:0] inthsrecclk;
reg    intrecclk;

wire   clkin_in;

reg    align;
reg    SYDT;

reg    [15:0]  store_buffer;
reg    [15:0]  shift_buffer;
reg    aclk, sclk;

time   new_delay;

time   clklock_last_rising_edge;
time   clklock_half_period;
time   clklock_half_period_minus_dly;

reg [95:0] symstr_r;
reg [11:0] sympat_r;
initial symstr_r = sympat;
initial sympat_r[0] = convert_binary(symstr_r[7:0]); 
initial sympat_r[1] = convert_binary(symstr_r[15:8]); 
initial sympat_r[2] = convert_binary(symstr_r[23:16]); 
initial sympat_r[3] = convert_binary(symstr_r[31:24]); 
initial sympat_r[4] = convert_binary(symstr_r[39:32]); 
initial sympat_r[5] = convert_binary(symstr_r[47:40]); 
initial sympat_r[6] = convert_binary(symstr_r[55:48]); 
initial sympat_r[7] = convert_binary(symstr_r[63:56]); 
initial sympat_r[8] = convert_binary(symstr_r[71:64]); 
initial sympat_r[9] = convert_binary(symstr_r[79:72]); 
initial sympat_r[10] = convert_binary(symstr_r[87:80]); 
initial sympat_r[11] = convert_binary(symstr_r[95:88]); 

//#########
//## PLL ##
//#########

reg [15:0] mult_r;
integer mult_i;
initial mult_r = mult;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = div;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [31:0] pll_dly_r;
real pll_dly_re;
initial pll_dly_r = pll_dly;
initial pll_dly_re = convert_real(pll_dly_r[31:24]) * (convert_real(pll_dly_r[23:16]) + 0.1 * convert_real(pll_dly_r[7:0]));

initial begin
  clklock_half_period = 0;
  clockboost     = 10 * mult_i/div_i;
  new_delay      = pll_dly_re * 10.0;
end


buf buf_clkin (clkin_in, SS_CLKIN);

integer clklock_rising_edge_count;

initial
begin
        clklock_rising_edge_count = 0;
end

always @(posedge clkin_in) begin
    clklock_rising_edge_count = clklock_rising_edge_count + 1;
    clklock_last_rising_edge = $time;
end

always @(negedge clkin_in) begin
    if (clklock_rising_edge_count == 1)
       clklock_half_period = ($time - clklock_last_rising_edge)*div_i/mult_i;
       clklock_half_period_minus_dly = clklock_half_period + 10.0 * pll_dly_re; 
end

integer   i, n, clock_count;
reg       clock_out_sig;

initial
begin
	clock_out_sig = 1'b0;
	clock_count = -1;
end
always @(clklock_rising_edge_count)
begin
    if (clklock_rising_edge_count >2 )
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count = clock_count + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count = clock_count + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count = 0;
end

reg PLL_LOCK_plus,PLL_LOCK_minus;
reg CLK_OUT_sig_d_start;

initial
begin
	PLL_LOCK_plus  = 1'b0;
	PLL_LOCK_minus = 1'b0;
	CLK_OUT_sig_d_start = 1'b0;
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    PLL_LOCK_plus = 1'b1;
    CLK_OUT_sig_d_start = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 3)
    PLL_LOCK_minus = 1'b1;
end

reg CLK_OUT_sig_d_not;
initial
begin
    CLK_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
      end
end

wire CLK_OUT_sig_d = ~CLK_OUT_sig_d_not && CLK_OUT_sig_d_start;

wire CLK_OUT_sig_2d;
wire CLK_OUT_sig_3d;
wire CLK_OUT_sig_dly;
wire CLK_OUT_plus_delay;

assign #clklock_half_period CLK_OUT_sig_2d = CLK_OUT_sig_d;
assign #clklock_half_period_minus_dly CLK_OUT_sig_3d = CLK_OUT_sig_2d;
assign #new_delay CLK_OUT_plus_delay = CLK_OUT_sig_d;

assign CSLOCK = (PLL_LOCK_plus && (pll_dly_re>=0) || PLL_LOCK_minus && (pll_dly_re<0));

//#################
//#16-phase clocks#
//#################

assign inthsrecclk[0] = !CSLOCK && clock_out_sig || CSLOCK && (CLK_OUT_plus_delay && (pll_dly_re >=0) || CLK_OUT_sig_3d && (pll_dly_re<0));
assign #(clklock_half_period/8) inthsrecclk[1] = inthsrecclk[0]; 
assign #(clklock_half_period/8) inthsrecclk[2] = inthsrecclk[1]; 
assign #(clklock_half_period/8) inthsrecclk[3] = inthsrecclk[2]; 
assign #(clklock_half_period/8) inthsrecclk[4] = inthsrecclk[3]; 
assign #(clklock_half_period/8) inthsrecclk[5] = inthsrecclk[4]; 
assign #(clklock_half_period/8) inthsrecclk[6] = inthsrecclk[5]; 
assign #(clklock_half_period/8) inthsrecclk[7] = inthsrecclk[6]; 
assign #(clklock_half_period/8) inthsrecclk[8] = inthsrecclk[7]; 
assign #(clklock_half_period/8) inthsrecclk[9] = inthsrecclk[8]; 
assign #(clklock_half_period/8) inthsrecclk[10] = inthsrecclk[9]; 
assign #(clklock_half_period/8) inthsrecclk[11] = inthsrecclk[10]; 
assign #(clklock_half_period/8) inthsrecclk[12] = inthsrecclk[11]; 
assign #(clklock_half_period/8) inthsrecclk[13] = inthsrecclk[12]; 
assign #(clklock_half_period/8) inthsrecclk[14] = inthsrecclk[13]; 
assign #(clklock_half_period/8) inthsrecclk[15] = inthsrecclk[14]; 

//#################
//#digitial filter#
//#################

reg cal_d1, cal_d2;
wire calrst = cal_d1 && ~cal_d2;

always @(posedge aclk)
begin
    cal_d1 <= CAL;
    cal_d2 <= cal_d1;
end

reg data_ins;
reg data_ina;
always @(posedge sclk)
   data_ins <= SIN;

time time_data;
time time_clock;
time time_delta;

always @(SIN)
   time_data = $time;

always @(posedge aclk)
   time_clock = $time;

always @(time_data or time_clock)
   if (time_data >= time_clock)
       time_delta = time_data - time_clock;
   else
       time_delta = time_clock- time_data;

reg data_inaa;
always @(posedge aclk)
  data_inaa <= SIN;

always @(aclk or time_delta or data_inaa)
if (aclk)
   begin
   if (time_delta < 100)
      data_ina <= 1'bx;
   else
      data_ina <= data_inaa;
   end

wire transition = data_ins ^ data_ina;

reg dn_ss;
always @(sclk or transition)
if (sclk)
    dn_ss <= transition;

reg dn_s;
always @(posedge sclk)
    dn_s <= dn_ss;

reg up_s;
always @(posedge sclk)
    up_s <= transition;

wire dn_clk = dn_s && aclk;
wire up_clk = up_s && aclk;

wire cntrst;
wire pcntrst;

reg[7:0] dn_cnt0;

initial
    dn_cnt0 <= 8'h00;

always @(posedge dn_clk or posedge cntrst)
if (cntrst)
    dn_cnt0 <= 8'h00;
else
    dn_cnt0 <= dn_cnt0 + 1'b1;
    
reg[7:0] up_cnt0;

initial
    up_cnt0 <= 8'h00;

always @(posedge up_clk or posedge cntrst)
if (cntrst)
    up_cnt0 <= 8'h00;
else
    up_cnt0 <= up_cnt0 + 1'b1;
    
reg[7:0] dn_cnt, up_cnt;
always @(posedge aclk)
begin
   dn_cnt <= dn_cnt0;
   up_cnt <= up_cnt0;
end

reg[8:0] sub_cnt;
always @(posedge aclk or posedge cntrst)
if (cntrst)
   sub_cnt <= 9'h000;
else
   sub_cnt <= dn_cnt - up_cnt;

reg[7:0] add_cnt;
always @(posedge aclk or posedge cntrst)
if (cntrst)
   add_cnt <= 8'h00;
else
   add_cnt <= dn_cnt + up_cnt;

wire[7:0] lkdbw = F_LKDBW;
wire[7:0] lktbw = F_LKTBW;
wire[7:0] tkdbw = F_TKDBW;
wire[7:0] tktbw = F_TKTBW;

wire[7:0] dbw = CDRLOCK? tkdbw: lkdbw;
wire[7:0] tbw = CDRLOCK? tktbw: lktbw;

reg[7:0] diff_cnt;
always @(sub_cnt)
if (sub_cnt[8])
    diff_cnt <= ~(sub_cnt[7:0]);
else
    diff_cnt <= sub_cnt[7:0];

reg diffcmp;
always @(posedge aclk or posedge cntrst)
if (cntrst)
    diffcmp <= 1'b0;
else
    if (diff_cnt >= dbw)
        diffcmp <= 1'b1;
    else
        diffcmp <= 1'b0;

reg totce;
always @(add_cnt or tbw)
if (add_cnt[7:1] == tbw[7:1])
    totce <= 1'b1;
else
    totce <= 1'b0;

reg totcmp;
always @(posedge aclk)
totcmp <= totce;

reg totcmp_d;
always @(posedge aclk)
totcmp_d <= totcmp;

assign cntrst = totcmp;
assign pcntrst = totcmp_d;

reg pre_pull, pre_push;
initial
begin
  pre_push <= 1'b0;
  pre_pull <= 1'b0;
end
always @(posedge aclk or posedge pcntrst)
if (pcntrst)
    begin
       pre_push <= 1'b0;
       pre_pull <= 1'b0;
    end
else
    begin
       if (totce)
           begin
               pre_push <= diffcmp && (~sub_cnt[8]);
               pre_pull <= diffcmp && sub_cnt[8];
           end
    end

reg push, pull;
always @(posedge aclk)
if (CAL)
    begin
       push <= pre_push;
       pull <= pre_pull;
    end
else
    begin
       push <= 1'b0;
       pull <= 1'b0;
    end

//########################
//#phase shift and select#
//########################

reg[15:0] sclksel;
always @(posedge aclk or posedge calrst)
if (calrst)
    sclksel <= 16'h0100;
else
    if (pull)
        sclksel <= {sclksel[0], sclksel[15:1]};
    else if (push)
        sclksel <= {sclksel[14:0], sclksel[15]};

always @(sclksel or inthsrecclk)
case (sclksel)
16'h0001: begin
             aclk <= inthsrecclk[8]; 
             sclk <= inthsrecclk[0]; 
          end
16'h0002: begin
             aclk <= inthsrecclk[9]; 
             sclk <= inthsrecclk[1]; 
          end
16'h0004: begin
             aclk <= inthsrecclk[10]; 
             sclk <= inthsrecclk[2]; 
          end
16'h0008: begin
             aclk <= inthsrecclk[11]; 
             sclk <= inthsrecclk[3]; 
          end
16'h0010: begin
             aclk <= inthsrecclk[12]; 
             sclk <= inthsrecclk[4]; 
          end
16'h0020: begin
             aclk <= inthsrecclk[13]; 
             sclk <= inthsrecclk[5]; 
          end
16'h0040: begin
             aclk <= inthsrecclk[14]; 
             sclk <= inthsrecclk[6]; 
          end
16'h0080: begin
             aclk <= inthsrecclk[15]; 
             sclk <= inthsrecclk[7]; 
          end
16'h0100: begin
             aclk <= inthsrecclk[0]; 
             sclk <= inthsrecclk[8]; 
          end
16'h0200: begin
             aclk <= inthsrecclk[1]; 
             sclk <= inthsrecclk[9]; 
          end
16'h0400: begin
             aclk <= inthsrecclk[2]; 
             sclk <= inthsrecclk[10]; 
          end
16'h0800: begin
             aclk <= inthsrecclk[3]; 
             sclk <= inthsrecclk[11]; 
          end
16'h1000: begin
             aclk <= inthsrecclk[4]; 
             sclk <= inthsrecclk[12]; 
          end
16'h2000: begin
             aclk <= inthsrecclk[5]; 
             sclk <= inthsrecclk[13]; 
          end
16'h4000: begin
             aclk <= inthsrecclk[6]; 
             sclk <= inthsrecclk[14]; 
          end
16'h8000: begin
             aclk <= inthsrecclk[7]; 
             sclk <= inthsrecclk[15]; 
          end
default:  begin
             aclk <= inthsrecclk[0]; 
             sclk <= inthsrecclk[8]; 
          end
endcase

//#############
//#LOCK detect#
//#############

wire lock_rst = calrst || pull || push;

reg[2:0] lock_cnt;
always @(posedge totcmp or posedge lock_rst)
if (lock_rst)
    lock_cnt <= 3'b000;
else
    lock_cnt <= lock_cnt + 1'b1;

wire lockcmp = (lock_cnt == F_LOCK);

reg lockcmp_d1, lockcmp_d2;
always @(posedge aclk or posedge calrst)
if (calrst)
    begin
      lockcmp_d1 <= 1'b0;
      lockcmp_d2 <= 1'b0;
    end
else
    begin
      lockcmp_d1 <= lockcmp;
      lockcmp_d2 <= lockcmp_d1;
    end

wire lock_pulse = lockcmp_d1 && ~lockcmp_d2;

reg lock_int;
always @(calrst or lock_pulse)
if (calrst)
    lock_int <= 1'b0;
else
    if (lock_pulse)
        lock_int <= 1'b1;

reg lock0, lock1;
always @(posedge sclk)
begin
   lock0 <= lock_int;
   lock1 <= lock0;
end

wire #(100) lock2 = lock1;

always @(posedge RECCLK_reg)
    CDRLOCK <= lock2;

//######################################
//#SYNC detect & recover data and clock#
//######################################

always@(posedge sclk)
begin
     shift_buffer[15]   <= data_ins;
     shift_buffer[14:0] <= shift_buffer[15:1];
end

reg pre_align;
always@(posedge sclk)
pre_align <= (shift_buffer[15:4] == sympat_r[11:0]);

reg rsypt0, rsypt1;
always@(posedge sclk)
rsypt0 <= pre_align; 

wire align_rst = ~lock1;
always@(posedge sclk)
if (~align_rst)
    align <= 1'b0;
else
    align <= pre_align; 

always @(posedge sclk)
rsypt1 <= rsypt0;

wire #(100) rsypt2 = rsypt1;

reg[2:0] divcnt;

initial
    divcnt <= 3'b111;

wire intrecclk1 = !(divcnt == 3'b100);
always @(posedge sclk or align)
if (align)
    divcnt <= 3'b111;
else
    if (divcnt == 3'b100)
        divcnt <= 3'b111;
    else
        divcnt <= divcnt - 1'b1;
    
reg intrecclk2;
always @(posedge sclk)
    intrecclk2 <= intrecclk1;

always @(posedge intrecclk2 or posedge align)
if (align)
    intrecclk <= 1'b0;
else
    intrecclk <= ~intrecclk;

always @(posedge sclk)
    RECCLK_reg <= intrecclk;

always @(posedge RECCLK_reg)
SYDT <= rsypt2;

wire[15:0] #(100) shift_buffer_d = shift_buffer;

always @(posedge RECCLK_reg)
    store_buffer <= shift_buffer_d;

assign RXD0 = store_buffer[5];
assign RXD1 = store_buffer[6];
assign RXD2 = store_buffer[7];
assign RXD3 = store_buffer[8];
assign RXD4 = store_buffer[9];
assign RXD5 = store_buffer[10];
assign RXD6 = store_buffer[11];
assign RXD7 = store_buffer[12];

assign RECCLK = RECCLK_reg;
//##############
//## function ##
//##############

function convert_binary;
input [7:0] sym_str;
  begin

    if (sym_str == "1")
      convert_binary = 1'b1;
    else if (sym_str == "0")
      convert_binary = 1'b0;
    else 
      convert_binary = 1'b0;
  end
endfunction

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else
      convert_int = 0;
  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction


specify 
 
(SS_CLKIN => RECCLK)   =   0:0:0, 0:0:0;
(SS_CLKIN => CSLOCK)    =   0:0:0, 0:0:0;
 
endspecify 

endmodule

`endcelldefine 

`celldefine 
`timescale 100 fs / 1 fs

module CDRX_SS_10(CAL,SIN, SS_CLKIN, RXD0, RXD1, RXD2, RXD3, RXD4, RXD5, RXD6, RXD7, RXD8, RXD9, RECCLK, CSLOCK, SYDT);

parameter   in_freq    = "100.0";
parameter   div        = "1";
parameter   mult       = "10";
parameter   pll_dly    = "0.0";
parameter   sympat     = "00000111110000011111";
parameter   lock_cyc   = 2;

//###########################
//#digital filter parameters#
//###########################

parameter   F_LKDBW    = 8'h0f;
parameter   F_LKTBW    = 8'h3f;
parameter   F_TKDBW    = 8'h1f;
parameter   F_TKTBW    = 8'h7f;
parameter   F_LOCK     = 3'b011;

integer     clockboost;

input  CAL;
input  SIN;
input  SS_CLKIN;
output RECCLK,CSLOCK;
output RXD0,RXD1,RXD2,RXD3,RXD4,RXD5,RXD6,RXD7,RXD8,RXD9;
output SYDT;

wire   RXD0;
wire   RXD1;
wire   RXD2;
wire   RXD3;
wire   RXD4;
wire   RXD5;
wire   RXD6;
wire   RXD7;
wire   RXD8;
wire   RXD9;

reg    CDRLOCK;
reg    RECCLK_reg;
wire   CSLOCK;
wire[15:0] inthsrecclk;
reg    intrecclk;

wire   clkin_in;

reg    align;
reg    SYDT;

reg    [15:0]  store_buffer;
reg    [15:0]  shift_buffer;
reg    aclk, sclk;

time   new_delay;

time   clklock_last_rising_edge;
time   clklock_half_period;
time   clklock_half_period_minus_dly;

reg [159:0] symstr_r;
reg [19:0] sympat_r;
initial symstr_r = sympat;
initial sympat_r[0] = convert_binary(symstr_r[7:0]); 
initial sympat_r[1] = convert_binary(symstr_r[15:8]); 
initial sympat_r[2] = convert_binary(symstr_r[23:16]); 
initial sympat_r[3] = convert_binary(symstr_r[31:24]); 
initial sympat_r[4] = convert_binary(symstr_r[39:32]); 
initial sympat_r[5] = convert_binary(symstr_r[47:40]); 
initial sympat_r[6] = convert_binary(symstr_r[55:48]); 
initial sympat_r[7] = convert_binary(symstr_r[63:56]); 
initial sympat_r[8] = convert_binary(symstr_r[71:64]); 
initial sympat_r[9] = convert_binary(symstr_r[79:72]); 
initial sympat_r[10] = convert_binary(symstr_r[87:80]); 
initial sympat_r[11] = convert_binary(symstr_r[95:88]); 
initial sympat_r[12] = convert_binary(symstr_r[103:96]); 
initial sympat_r[13] = convert_binary(symstr_r[111:104]); 
initial sympat_r[14] = convert_binary(symstr_r[119:112]); 
initial sympat_r[15] = convert_binary(symstr_r[127:120]); 
initial sympat_r[16] = convert_binary(symstr_r[135:128]); 
initial sympat_r[17] = convert_binary(symstr_r[143:136]); 
initial sympat_r[18] = convert_binary(symstr_r[151:144]); 
initial sympat_r[19] = convert_binary(symstr_r[159:152]); 

//#########
//## PLL ##
//#########

reg [15:0] mult_r;
integer mult_i;
initial mult_r = mult;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = div;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [31:0] pll_dly_r;
real pll_dly_re;
initial pll_dly_r = pll_dly;
initial pll_dly_re = convert_real(pll_dly_r[31:24]) * (convert_real(pll_dly_r[23:16]) + 0.1 * convert_real(pll_dly_r[7:0]));

initial begin
  clklock_half_period = 0;
  clockboost     = 10 * mult_i/div_i;
  new_delay      = pll_dly_re * 10.0;
end


buf buf_clkin (clkin_in, SS_CLKIN);

integer clklock_rising_edge_count;

initial
begin
        clklock_rising_edge_count = 0;
end

always @(posedge clkin_in) begin
    clklock_rising_edge_count = clklock_rising_edge_count + 1;
    clklock_last_rising_edge = $time;
end

always @(negedge clkin_in) begin
    if (clklock_rising_edge_count == 1)
       clklock_half_period = ($time - clklock_last_rising_edge)*div_i/mult_i;
       clklock_half_period_minus_dly = clklock_half_period + 10.0 * pll_dly_re; 
end

integer   i, n, clock_count;
reg       clock_out_sig;

initial
begin
	clock_out_sig = 1'b0;
	clock_count = -1;
end
always @(clklock_rising_edge_count)
begin
    if (clklock_rising_edge_count >2 )
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count = clock_count + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count = clock_count + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count = 0;
end

reg PLL_LOCK_plus,PLL_LOCK_minus;
reg CLK_OUT_sig_d_start;

initial
begin
	PLL_LOCK_plus  = 1'b0;
	PLL_LOCK_minus = 1'b0;
	CLK_OUT_sig_d_start = 1'b0;
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    PLL_LOCK_plus = 1'b1;
    CLK_OUT_sig_d_start = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 3)
    PLL_LOCK_minus = 1'b1;
end

reg CLK_OUT_sig_d_not;
initial
begin
    CLK_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
      end
end

wire CLK_OUT_sig_d = ~CLK_OUT_sig_d_not && CLK_OUT_sig_d_start;

wire CLK_OUT_sig_2d;
wire CLK_OUT_sig_3d;
wire CLK_OUT_sig_dly;
wire CLK_OUT_plus_delay;

assign #clklock_half_period CLK_OUT_sig_2d = CLK_OUT_sig_d;
assign #clklock_half_period_minus_dly CLK_OUT_sig_3d = CLK_OUT_sig_2d;
assign #new_delay CLK_OUT_plus_delay = CLK_OUT_sig_d;

assign CSLOCK = (PLL_LOCK_plus && (pll_dly_re>=0) || PLL_LOCK_minus && (pll_dly_re<0));

//#################
//#16-phase clocks#
//#################

assign inthsrecclk[0] = !CSLOCK && clock_out_sig || CSLOCK && (CLK_OUT_plus_delay && (pll_dly_re >=0) || CLK_OUT_sig_3d && (pll_dly_re<0));
assign #(clklock_half_period/8) inthsrecclk[1] = inthsrecclk[0]; 
assign #(clklock_half_period/8) inthsrecclk[2] = inthsrecclk[1]; 
assign #(clklock_half_period/8) inthsrecclk[3] = inthsrecclk[2]; 
assign #(clklock_half_period/8) inthsrecclk[4] = inthsrecclk[3]; 
assign #(clklock_half_period/8) inthsrecclk[5] = inthsrecclk[4]; 
assign #(clklock_half_period/8) inthsrecclk[6] = inthsrecclk[5]; 
assign #(clklock_half_period/8) inthsrecclk[7] = inthsrecclk[6]; 
assign #(clklock_half_period/8) inthsrecclk[8] = inthsrecclk[7]; 
assign #(clklock_half_period/8) inthsrecclk[9] = inthsrecclk[8]; 
assign #(clklock_half_period/8) inthsrecclk[10] = inthsrecclk[9]; 
assign #(clklock_half_period/8) inthsrecclk[11] = inthsrecclk[10]; 
assign #(clklock_half_period/8) inthsrecclk[12] = inthsrecclk[11]; 
assign #(clklock_half_period/8) inthsrecclk[13] = inthsrecclk[12]; 
assign #(clklock_half_period/8) inthsrecclk[14] = inthsrecclk[13]; 
assign #(clklock_half_period/8) inthsrecclk[15] = inthsrecclk[14]; 

//#################
//#digitial filter#
//#################

reg cal_d1, cal_d2;
wire calrst = cal_d1 && ~cal_d2;

always @(posedge aclk)
begin
    cal_d1 <= CAL;
    cal_d2 <= cal_d1;
end

reg data_ins;
reg data_ina;
always @(posedge sclk)
   data_ins <= SIN;

time time_data;
time time_clock;
time time_delta;

always @(SIN)
   time_data = $time;

always @(posedge aclk)
   time_clock = $time;

always @(time_data or time_clock)
   if (time_data >= time_clock)
       time_delta = time_data - time_clock;
   else
       time_delta = time_clock- time_data;

reg data_inaa;
always @(posedge aclk)
  data_inaa <= SIN;

always @(aclk or time_delta or data_inaa)
if (aclk)
   begin
   if (time_delta < 100)
      data_ina <= 1'bx;
   else
      data_ina <= data_inaa;
   end

wire transition = data_ins ^ data_ina;

reg dn_ss;
always @(sclk or transition)
if (sclk)
    dn_ss <= transition;

reg dn_s;
always @(posedge sclk)
    dn_s <= dn_ss;

reg up_s;
always @(posedge sclk)
    up_s <= transition;

wire dn_clk = dn_s && aclk;
wire up_clk = up_s && aclk;

wire cntrst;
wire pcntrst;

reg[7:0] dn_cnt0;

initial
    dn_cnt0 <= 8'h00;

always @(posedge dn_clk or posedge cntrst)
if (cntrst)
    dn_cnt0 <= 8'h00;
else
    dn_cnt0 <= dn_cnt0 + 1'b1;
    
reg[7:0] up_cnt0;

initial
    up_cnt0 <= 8'h00;

always @(posedge up_clk or posedge cntrst)
if (cntrst)
    up_cnt0 <= 8'h00;
else
    up_cnt0 <= up_cnt0 + 1'b1;
    
reg[7:0] dn_cnt, up_cnt;
always @(posedge aclk)
begin
   dn_cnt <= dn_cnt0;
   up_cnt <= up_cnt0;
end

reg[8:0] sub_cnt;
always @(posedge aclk or posedge cntrst)
if (cntrst)
   sub_cnt <= 9'h000;
else
   sub_cnt <= dn_cnt - up_cnt;

reg[7:0] add_cnt;
always @(posedge aclk or posedge cntrst)
if (cntrst)
   add_cnt <= 8'h00;
else
   add_cnt <= dn_cnt + up_cnt;

wire[7:0] lkdbw = F_LKDBW;
wire[7:0] lktbw = F_LKTBW;
wire[7:0] tkdbw = F_TKDBW;
wire[7:0] tktbw = F_TKTBW;

wire[7:0] dbw = CDRLOCK? tkdbw: lkdbw;
wire[7:0] tbw = CDRLOCK? tktbw: lktbw;

reg[7:0] diff_cnt;
always @(sub_cnt)
if (sub_cnt[8])
    diff_cnt <= ~(sub_cnt[7:0]);
else
    diff_cnt <= sub_cnt[7:0];

reg diffcmp;
always @(posedge aclk or posedge cntrst)
if (cntrst)
    diffcmp <= 1'b0;
else
    if (diff_cnt >= dbw)
        diffcmp <= 1'b1;
    else
        diffcmp <= 1'b0;

reg totce;
always @(add_cnt or tbw)
if (add_cnt[7:1] == tbw[7:1])
    totce <= 1'b1;
else
    totce <= 1'b0;

reg totcmp;
always @(posedge aclk)
totcmp <= totce;

reg totcmp_d;
always @(posedge aclk)
totcmp_d <= totcmp;

assign cntrst = totcmp;
assign pcntrst = totcmp_d;

reg pre_pull, pre_push;
initial
begin
  pre_push <= 1'b0;
  pre_pull <= 1'b0;
end
always @(posedge aclk or posedge pcntrst)
if (pcntrst)
    begin
       pre_push <= 1'b0;
       pre_pull <= 1'b0;
    end
else
    begin
       if (totce)
           begin
               pre_push <= diffcmp && (~sub_cnt[8]);
               pre_pull <= diffcmp && sub_cnt[8];
           end
    end

reg push, pull;
always @(posedge aclk)
if (CAL)
    begin
       push <= pre_push;
       pull <= pre_pull;
    end
else
    begin
       push <= 1'b0;
       pull <= 1'b0;
    end

//########################
//#phase shift and select#
//########################

reg[15:0] sclksel;
always @(posedge aclk or posedge calrst)
if (calrst)
    sclksel <= 16'h0100;
else
    if (pull)
        sclksel <= {sclksel[0], sclksel[15:1]};
    else if (push)
        sclksel <= {sclksel[14:0], sclksel[15]};

always @(sclksel or inthsrecclk)
case (sclksel)
16'h0001: begin
             aclk <= inthsrecclk[8]; 
             sclk <= inthsrecclk[0]; 
          end
16'h0002: begin
             aclk <= inthsrecclk[9]; 
             sclk <= inthsrecclk[1]; 
          end
16'h0004: begin
             aclk <= inthsrecclk[10]; 
             sclk <= inthsrecclk[2]; 
          end
16'h0008: begin
             aclk <= inthsrecclk[11]; 
             sclk <= inthsrecclk[3]; 
          end
16'h0010: begin
             aclk <= inthsrecclk[12]; 
             sclk <= inthsrecclk[4]; 
          end
16'h0020: begin
             aclk <= inthsrecclk[13]; 
             sclk <= inthsrecclk[5]; 
          end
16'h0040: begin
             aclk <= inthsrecclk[14]; 
             sclk <= inthsrecclk[6]; 
          end
16'h0080: begin
             aclk <= inthsrecclk[15]; 
             sclk <= inthsrecclk[7]; 
          end
16'h0100: begin
             aclk <= inthsrecclk[0]; 
             sclk <= inthsrecclk[8]; 
          end
16'h0200: begin
             aclk <= inthsrecclk[1]; 
             sclk <= inthsrecclk[9]; 
          end
16'h0400: begin
             aclk <= inthsrecclk[2]; 
             sclk <= inthsrecclk[10]; 
          end
16'h0800: begin
             aclk <= inthsrecclk[3]; 
             sclk <= inthsrecclk[11]; 
          end
16'h1000: begin
             aclk <= inthsrecclk[4]; 
             sclk <= inthsrecclk[12]; 
          end
16'h2000: begin
             aclk <= inthsrecclk[5]; 
             sclk <= inthsrecclk[13]; 
          end
16'h4000: begin
             aclk <= inthsrecclk[6]; 
             sclk <= inthsrecclk[14]; 
          end
16'h8000: begin
             aclk <= inthsrecclk[7]; 
             sclk <= inthsrecclk[15]; 
          end
default:  begin
             aclk <= inthsrecclk[0]; 
             sclk <= inthsrecclk[8]; 
          end
endcase

//#############
//#LOCK detect#
//#############

wire lock_rst = calrst || pull || push;

reg[2:0] lock_cnt;
always @(posedge totcmp or posedge lock_rst)
if (lock_rst)
    lock_cnt <= 3'b000;
else
    lock_cnt <= lock_cnt + 1'b1;

wire lockcmp = (lock_cnt == F_LOCK);

reg lockcmp_d1, lockcmp_d2;
always @(posedge aclk or posedge calrst)
if (calrst)
    begin
      lockcmp_d1 <= 1'b0;
      lockcmp_d2 <= 1'b0;
    end
else
    begin
      lockcmp_d1 <= lockcmp;
      lockcmp_d2 <= lockcmp_d1;
    end

wire lock_pulse = lockcmp_d1 && ~lockcmp_d2;

reg lock_int;
always @(calrst or lock_pulse)
if (calrst)
    lock_int <= 1'b0;
else
    if (lock_pulse)
        lock_int <= 1'b1;

reg lock0, lock1;
always @(posedge sclk)
begin
   lock0 <= lock_int;
   lock1 <= lock0;
end

wire #(100) lock2 = lock1;

always @(posedge RECCLK_reg)
    CDRLOCK <= lock2;

//######################################
//#SYNC detect & recover data and clock#
//######################################

always@(posedge sclk)
begin
     shift_buffer[15]   <= data_ins;
     shift_buffer[14:0] <= shift_buffer[15:1];
end

reg pre_align;
always@(posedge sclk)
pre_align <= (shift_buffer[15:4] == sympat_r[19:8]);

reg rsypt0, rsypt1;
always@(posedge sclk)
rsypt0 <= pre_align; 

wire align_rst = ~lock1;
always@(posedge sclk)
if (~align_rst)
    align <= 1'b0;
else
    align <= pre_align; 

always @(posedge sclk)
rsypt1 <= rsypt0;

wire #(100) rsypt2 = rsypt1;

reg[2:0] divcnt;

initial
    divcnt <= 3'b111;

wire intrecclk1 = !(divcnt == 3'b011);
always @(posedge sclk or align)
if (align)
    divcnt <= 3'b111;
else
    if (divcnt == 3'b011)
        divcnt <= 3'b111;
    else
        divcnt <= divcnt - 1'b1;
    
reg intrecclk2;
always @(posedge sclk)
    intrecclk2 <= intrecclk1;

always @(posedge intrecclk2 or posedge align)
if (align)
    intrecclk <= 1'b0;
else
    intrecclk <= ~intrecclk;

always @(posedge sclk)
    RECCLK_reg <= intrecclk;

always @(posedge RECCLK_reg)
SYDT <= rsypt2;

wire[15:0] #(100) shift_buffer_d = shift_buffer;

always @(posedge RECCLK_reg)
    store_buffer <= shift_buffer_d;

assign RXD0 = store_buffer[2];
assign RXD1 = store_buffer[3];
assign RXD2 = store_buffer[4];
assign RXD3 = store_buffer[5];
assign RXD4 = store_buffer[6];
assign RXD5 = store_buffer[7];
assign RXD6 = store_buffer[8];
assign RXD7 = store_buffer[9];
assign RXD8 = store_buffer[11];
assign RXD9 = store_buffer[12];

assign RECCLK = RECCLK_reg;
//##############
//## function ##
//##############

function convert_binary;
input [7:0] sym_str;
  begin

    if (sym_str == "1")
      convert_binary = 1'b1;
    else if (sym_str == "0")
      convert_binary = 1'b0;
    else 
      convert_binary = 1'b0;
  end
endfunction

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else
      convert_int = 0;
  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction


specify 
 
(SS_CLKIN => RECCLK)   =   0:0:0, 0:0:0;
(SS_CLKIN => CSLOCK)    =   0:0:0, 0:0:0;
 
endspecify 

endmodule

`endcelldefine 

 
`celldefine 
`timescale 10 ps / 10 ps

module HSLB_10B12B (REFCLK,CDRRST,TXD0,TXD1,TXD2,TXD3,TXD4,TXD5,TXD6,TXD7,TXD8,TXD9,RXD0,RXD1,RXD2,RXD3,RXD4,RXD5,RXD6,RXD7,RXD8,RXD9,RECCLK,CSLOCK);

parameter   in_freq    = "100.0";
parameter   div        = "1";
parameter   mult       = "1";

input  REFCLK,CDRRST;
input TXD0,TXD1,TXD2,TXD3,TXD4,TXD5,TXD6,TXD7,TXD8,TXD9;
output RECCLK,CSLOCK;
output RXD0,RXD1,RXD2,RXD3,RXD4,RXD5,RXD6,RXD7,RXD8,RXD9;

wire   RXD0;
wire   RXD1;
wire   RXD2;
wire   RXD3;
wire   RXD4;
wire   RXD5;
wire   RXD6;
wire   RXD7;
wire   RXD8;
wire   RXD9;

reg [15:0] mult_r;
integer mult_i;
initial mult_r = mult;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = div;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

integer   cnt_m_div;
wire      clkin_m_div;
reg       clk_out_m_div;


buf buf_clkin (clkin_in, REFCLK);

assign RXD0 = TXD0;
assign RXD1 = TXD1;
assign RXD2 = TXD2;
assign RXD3 = TXD3;
assign RXD4 = TXD4;
assign RXD5 = TXD5;
assign RXD6 = TXD6;
assign RXD7 = TXD7;
assign RXD8 = TXD8;
assign RXD9 = TXD9;

assign RECCLK = REFCLK;
assign CSLOCK = 1'b1;

function convert_binary;
input [7:0] sym_str;
  begin

    if (sym_str == "1")
      convert_binary = 1'b1;
    else if (sym_str == "0")
      convert_binary = 1'b0;
    else 
      convert_binary = 1'b0;
  end
endfunction

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else
      convert_int = 0;
  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction

specify 
 
(REFCLK => RECCLK)   =   0:0:0, 0:0:0;
(REFCLK => CSLOCK)    =   0:0:0, 0:0:0;
 
endspecify 

endmodule

`endcelldefine 
`celldefine 
`timescale 10 ps / 10 ps

module HSLB_8B10B (REFCLK,CDRRST,TXD0,TXD1,TXD2,TXD3,TXD4,TXD5,TXD6,TXD7,TXD8,TXD9,RXD0,RXD1,RXD2,RXD3,RXD4,RXD5,RXD6,RXD7,RXD8,RXD9,RECCLK,CSLOCK);

parameter   in_freq    = "100.0";
parameter   div        = "1";
parameter   mult       = "1";

input  REFCLK,CDRRST;
input TXD0,TXD1,TXD2,TXD3,TXD4,TXD5,TXD6,TXD7,TXD8,TXD9;
output RECCLK,CSLOCK;
output RXD0,RXD1,RXD2,RXD3,RXD4,RXD5,RXD6,RXD7,RXD8,RXD9;

wire   RXD0;
wire   RXD1;
wire   RXD2;
wire   RXD3;
wire   RXD4;
wire   RXD5;
wire   RXD6;
wire   RXD7;
wire   RXD8;
wire   RXD9;

reg [15:0] mult_r;
integer mult_i;
initial mult_r = mult;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = div;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

integer   cnt_m_div;
wire      clkin_m_div;
reg       clk_out_m_div;


buf buf_clkin (clkin_in, REFCLK);

assign RXD0 = TXD0;
assign RXD1 = TXD1;
assign RXD2 = TXD2;
assign RXD3 = TXD3;
assign RXD4 = TXD4;
assign RXD5 = TXD5;
assign RXD6 = TXD6;
assign RXD7 = TXD7;
assign RXD8 = TXD8;
assign RXD9 = TXD9;

assign RECCLK = REFCLK;
assign CSLOCK = 1'b1;

function convert_binary;
input [7:0] sym_str;
  begin

    if (sym_str == "1")
      convert_binary = 1'b1;
    else if (sym_str == "0")
      convert_binary = 1'b0;
    else 
      convert_binary = 1'b0;
  end
endfunction

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else
      convert_int = 0;
  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction

specify 
 
(REFCLK => RECCLK)   =   0:0:0, 0:0:0;
(REFCLK => CSLOCK)    =   0:0:0, 0:0:0;
 
endspecify 

endmodule

`endcelldefine 
`celldefine 
`timescale 100 fs / 1 fs

module RX_SS_4(SIN, SS_CLKIN, RXD0, RXD1, RXD2, RXD3, RECCLK,CSLOCK);

parameter   in_freq    = "100.0";
parameter   div        = "1";
parameter   mult       = "4";
parameter   phase_adj    = "1000";
parameter   pll_dly    = "0.0";
parameter   lock_cyc   = 2;

integer     clockboost;

input  SIN;
input  SS_CLKIN;
output RECCLK,CSLOCK;
output RXD0,RXD1,RXD2,RXD3;

wire   RXD0;
wire   RXD1;
wire   RXD2;
wire   RXD3;

wire   CSLOCK;
wire[15:0] inthsrecclk;
reg    intrecclk;
reg RECCLK_reg;

wire   clkin_in;

reg    [19:0] symstr_buffer;
reg    [15:0]  store_buffer;
reg    [15:0]  shift_buffer;
reg    sclk;

time   new_delay;

time   clklock_last_rising_edge;
time   clklock_half_period;
time   clklock_half_period_minus_dly;

reg [31:0] phaseadj_str;
reg [3:0] phaseadj;
initial phaseadj_str = phase_adj;
initial phaseadj[0] = convert_binary(phaseadj_str[7:0]); 
initial phaseadj[1] = convert_binary(phaseadj_str[15:8]); 
initial phaseadj[2] = convert_binary(phaseadj_str[23:16]); 
initial phaseadj[3] = convert_binary(phaseadj_str[31:24]); 

//#########
//## PLL ##
//#########

reg [15:0] mult_r;
integer mult_i;
initial mult_r = mult;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = div;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [31:0] pll_dly_r;
real pll_dly_re;
initial pll_dly_r = pll_dly;
initial pll_dly_re = convert_real(pll_dly_r[31:24]) * (convert_real(pll_dly_r[23:16]) + 0.1 * convert_real(pll_dly_r[7:0]));

initial begin
  clklock_half_period = 0;
  clockboost     = 10 * mult_i/div_i;
  new_delay      = pll_dly_re * 10.0;
end


buf buf_clkin (clkin_in, SS_CLKIN);

integer clklock_rising_edge_count;

initial
begin
        clklock_rising_edge_count = 0;
end

always @(posedge clkin_in) begin
    clklock_rising_edge_count = clklock_rising_edge_count + 1;
    clklock_last_rising_edge = $time;
end

always @(negedge clkin_in) begin
    if (clklock_rising_edge_count == 1)
       clklock_half_period = ($time - clklock_last_rising_edge)*div_i/mult_i;
       clklock_half_period_minus_dly = clklock_half_period + 10.0 * pll_dly_re; 
end

integer   i, n, clock_count;
reg       clock_out_sig;

initial
begin
	clock_out_sig = 1'b0;
	clock_count = -1;
end
always @(clklock_rising_edge_count)
begin
    if (clklock_rising_edge_count >2 )
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count = clock_count + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count = clock_count + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count = 0;
end

reg PLL_LOCK_plus,PLL_LOCK_minus;
reg CLK_OUT_sig_d_start;

initial
begin
	PLL_LOCK_plus  = 1'b0;
	PLL_LOCK_minus = 1'b0;
	CLK_OUT_sig_d_start = 1'b0;
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    PLL_LOCK_plus = 1'b1;
    CLK_OUT_sig_d_start = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 3)
    PLL_LOCK_minus = 1'b1;
end

reg CLK_OUT_sig_d_not;
initial
begin
    CLK_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
      end
end

wire CLK_OUT_sig_d = ~CLK_OUT_sig_d_not && CLK_OUT_sig_d_start;

wire CLK_OUT_sig_2d;
wire CLK_OUT_sig_3d;
wire CLK_OUT_sig_dly;
wire CLK_OUT_plus_delay;

assign #clklock_half_period CLK_OUT_sig_2d = CLK_OUT_sig_d;
assign #clklock_half_period_minus_dly CLK_OUT_sig_3d = CLK_OUT_sig_2d;
assign #new_delay CLK_OUT_plus_delay = CLK_OUT_sig_d;

assign CSLOCK = (PLL_LOCK_plus && (pll_dly_re>=0) || PLL_LOCK_minus && (pll_dly_re<0));

//#################
//#16-phase clocks#
//#################

assign inthsrecclk[0] = !CSLOCK && clock_out_sig || CSLOCK && (CLK_OUT_plus_delay && (pll_dly_re >=0) || CLK_OUT_sig_3d && (pll_dly_re<0));
assign #(clklock_half_period/8) inthsrecclk[1] = inthsrecclk[0]; 
assign #(clklock_half_period/8) inthsrecclk[2] = inthsrecclk[1]; 
assign #(clklock_half_period/8) inthsrecclk[3] = inthsrecclk[2]; 
assign #(clklock_half_period/8) inthsrecclk[4] = inthsrecclk[3]; 
assign #(clklock_half_period/8) inthsrecclk[5] = inthsrecclk[4]; 
assign #(clklock_half_period/8) inthsrecclk[6] = inthsrecclk[5]; 
assign #(clklock_half_period/8) inthsrecclk[7] = inthsrecclk[6]; 
assign #(clklock_half_period/8) inthsrecclk[8] = inthsrecclk[7]; 
assign #(clklock_half_period/8) inthsrecclk[9] = inthsrecclk[8]; 
assign #(clklock_half_period/8) inthsrecclk[10] = inthsrecclk[9]; 
assign #(clklock_half_period/8) inthsrecclk[11] = inthsrecclk[10]; 
assign #(clklock_half_period/8) inthsrecclk[12] = inthsrecclk[11]; 
assign #(clklock_half_period/8) inthsrecclk[13] = inthsrecclk[12]; 
assign #(clklock_half_period/8) inthsrecclk[14] = inthsrecclk[13]; 
assign #(clklock_half_period/8) inthsrecclk[15] = inthsrecclk[14]; 


always @(phaseadj or inthsrecclk)
case (phaseadj)
4'b0000: sclk <= inthsrecclk[0]; 
4'b0001: sclk <= inthsrecclk[1]; 
4'b0010: sclk <= inthsrecclk[2]; 
4'b0011: sclk <= inthsrecclk[3]; 
4'b0100: sclk <= inthsrecclk[4]; 
4'b0101: sclk <= inthsrecclk[5]; 
4'b0110: sclk <= inthsrecclk[6]; 
4'b0111: sclk <= inthsrecclk[7]; 
4'b1000: sclk <= inthsrecclk[8]; 
4'b1001: sclk <= inthsrecclk[9]; 
4'b1010: sclk <= inthsrecclk[10]; 
4'b1011: sclk <= inthsrecclk[11]; 
4'b1100: sclk <= inthsrecclk[12]; 
4'b1101: sclk <= inthsrecclk[13]; 
4'b1110: sclk <= inthsrecclk[14]; 
4'b1111: sclk <= inthsrecclk[15]; 
default:  sclk <= inthsrecclk[8]; 
endcase

//########################
//#recover data and clock#
//########################

reg data_ins;
always @(posedge sclk)
   data_ins <= SIN;

always@(posedge sclk)
begin
     shift_buffer[15]   <= data_ins;
     shift_buffer[14:0] <= shift_buffer[15:1];
end

reg intrecclk1;
reg intrecclk2;
always @(posedge sclk)
begin
    intrecclk1 <= clkin_in;
    intrecclk2 <= intrecclk1;
    intrecclk  <= intrecclk2;
    RECCLK_reg     <= intrecclk;
end

wire[15:0] #(100) shift_buffer_d = shift_buffer;

always @(posedge RECCLK_reg)
    store_buffer <= shift_buffer_d;

assign RXD0 = store_buffer[12];
assign RXD1 = store_buffer[13];
assign RXD2 = store_buffer[14];
assign RXD3 = store_buffer[15];

assign RECCLK = RECCLK_reg;
//##############
//## function ##
//##############

function convert_binary;
input [7:0] sym_str;
  begin

    if (sym_str == "1")
      convert_binary = 1'b1;
    else if (sym_str == "0")
      convert_binary = 1'b0;
    else 
      convert_binary = 1'b0;
  end
endfunction

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else
      convert_int = 0;
  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction


specify 
 
(SS_CLKIN => RECCLK)   =   0:0:0, 0:0:0;
(SS_CLKIN => CSLOCK)    =   0:0:0, 0:0:0;
 
endspecify 

endmodule

`endcelldefine 
`celldefine 
`timescale 100 fs / 1 fs

module RX_SS_6(SIN, SS_CLKIN, RXD0, RXD1, RXD2, RXD3, RXD4, RXD5, RECCLK, CSLOCK);

parameter   in_freq    = "100.0";
parameter   div        = "1";
parameter   mult       = "6";
parameter   phase_adj    = "1000";
parameter   pll_dly    = "0.0";
parameter   lock_cyc   = 2;

integer     clockboost;

input  SIN;
input  SS_CLKIN;
output RECCLK,CSLOCK;
output RXD0,RXD1,RXD2,RXD3,RXD4,RXD5;

wire   RXD0;
wire   RXD1;
wire   RXD2;
wire   RXD3;
wire   RXD4;
wire   RXD5;

wire   CSLOCK;
wire[15:0] inthsrecclk;
reg    intrecclk;
reg RECCLK_reg;

wire   clkin_in;

reg    [19:0] symstr_buffer;
reg    [15:0]  store_buffer;
reg    [15:0]  shift_buffer;
reg    sclk;

time   new_delay;

time   clklock_last_rising_edge;
time   clklock_half_period;
time   clklock_half_period_minus_dly;

reg [31:0] phaseadj_str;
reg [3:0] phaseadj;
initial phaseadj_str = phase_adj;
initial phaseadj[0] = convert_binary(phaseadj_str[7:0]); 
initial phaseadj[1] = convert_binary(phaseadj_str[15:8]); 
initial phaseadj[2] = convert_binary(phaseadj_str[23:16]); 
initial phaseadj[3] = convert_binary(phaseadj_str[31:24]); 

//#########
//## PLL ##
//#########

reg [15:0] mult_r;
integer mult_i;
initial mult_r = mult;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = div;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [31:0] pll_dly_r;
real pll_dly_re;
initial pll_dly_r = pll_dly;
initial pll_dly_re = convert_real(pll_dly_r[31:24]) * (convert_real(pll_dly_r[23:16]) + 0.1 * convert_real(pll_dly_r[7:0]));

initial begin
  clklock_half_period = 0;
  clockboost     = 10 * mult_i/div_i;
  new_delay      = pll_dly_re * 10.0;
end


buf buf_clkin (clkin_in, SS_CLKIN);

integer clklock_rising_edge_count;

initial
begin
        clklock_rising_edge_count = 0;
end

always @(posedge clkin_in) begin
    clklock_rising_edge_count = clklock_rising_edge_count + 1;
    clklock_last_rising_edge = $time;
end

always @(negedge clkin_in) begin
    if (clklock_rising_edge_count == 1)
       clklock_half_period = ($time - clklock_last_rising_edge)*div_i/mult_i;
       clklock_half_period_minus_dly = clklock_half_period + 10.0 * pll_dly_re; 
end

integer   i, n, clock_count;
reg       clock_out_sig;

initial
begin
	clock_out_sig = 1'b0;
	clock_count = -1;
end
always @(clklock_rising_edge_count)
begin
    if (clklock_rising_edge_count >2 )
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count = clock_count + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count = clock_count + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count = 0;
end

reg PLL_LOCK_plus,PLL_LOCK_minus;
reg CLK_OUT_sig_d_start;

initial
begin
	PLL_LOCK_plus  = 1'b0;
	PLL_LOCK_minus = 1'b0;
	CLK_OUT_sig_d_start = 1'b0;
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    PLL_LOCK_plus = 1'b1;
    CLK_OUT_sig_d_start = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 3)
    PLL_LOCK_minus = 1'b1;
end

reg CLK_OUT_sig_d_not;
initial
begin
    CLK_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
      end
end

wire CLK_OUT_sig_d = ~CLK_OUT_sig_d_not && CLK_OUT_sig_d_start;

wire CLK_OUT_sig_2d;
wire CLK_OUT_sig_3d;
wire CLK_OUT_sig_dly;
wire CLK_OUT_plus_delay;

assign #clklock_half_period CLK_OUT_sig_2d = CLK_OUT_sig_d;
assign #clklock_half_period_minus_dly CLK_OUT_sig_3d = CLK_OUT_sig_2d;
assign #new_delay CLK_OUT_plus_delay = CLK_OUT_sig_d;

assign CSLOCK = (PLL_LOCK_plus && (pll_dly_re>=0) || PLL_LOCK_minus && (pll_dly_re<0));

//#################
//#16-phase clocks#
//#################

assign inthsrecclk[0] = !CSLOCK && clock_out_sig || CSLOCK && (CLK_OUT_plus_delay && (pll_dly_re >=0) || CLK_OUT_sig_3d && (pll_dly_re<0));
assign #(clklock_half_period/8) inthsrecclk[1] = inthsrecclk[0]; 
assign #(clklock_half_period/8) inthsrecclk[2] = inthsrecclk[1]; 
assign #(clklock_half_period/8) inthsrecclk[3] = inthsrecclk[2]; 
assign #(clklock_half_period/8) inthsrecclk[4] = inthsrecclk[3]; 
assign #(clklock_half_period/8) inthsrecclk[5] = inthsrecclk[4]; 
assign #(clklock_half_period/8) inthsrecclk[6] = inthsrecclk[5]; 
assign #(clklock_half_period/8) inthsrecclk[7] = inthsrecclk[6]; 
assign #(clklock_half_period/8) inthsrecclk[8] = inthsrecclk[7]; 
assign #(clklock_half_period/8) inthsrecclk[9] = inthsrecclk[8]; 
assign #(clklock_half_period/8) inthsrecclk[10] = inthsrecclk[9]; 
assign #(clklock_half_period/8) inthsrecclk[11] = inthsrecclk[10]; 
assign #(clklock_half_period/8) inthsrecclk[12] = inthsrecclk[11]; 
assign #(clklock_half_period/8) inthsrecclk[13] = inthsrecclk[12]; 
assign #(clklock_half_period/8) inthsrecclk[14] = inthsrecclk[13]; 
assign #(clklock_half_period/8) inthsrecclk[15] = inthsrecclk[14]; 


always @(phaseadj or inthsrecclk)
case (phaseadj)
4'b0000: sclk <= inthsrecclk[0]; 
4'b0001: sclk <= inthsrecclk[1]; 
4'b0010: sclk <= inthsrecclk[2]; 
4'b0011: sclk <= inthsrecclk[3]; 
4'b0100: sclk <= inthsrecclk[4]; 
4'b0101: sclk <= inthsrecclk[5]; 
4'b0110: sclk <= inthsrecclk[6]; 
4'b0111: sclk <= inthsrecclk[7]; 
4'b1000: sclk <= inthsrecclk[8]; 
4'b1001: sclk <= inthsrecclk[9]; 
4'b1010: sclk <= inthsrecclk[10]; 
4'b1011: sclk <= inthsrecclk[11]; 
4'b1100: sclk <= inthsrecclk[12]; 
4'b1101: sclk <= inthsrecclk[13]; 
4'b1110: sclk <= inthsrecclk[14]; 
4'b1111: sclk <= inthsrecclk[15]; 
default:  sclk <= inthsrecclk[8]; 
endcase

//########################
//#recover data and clock#
//########################

reg data_ins;
always @(posedge sclk)
   data_ins <= SIN;

always@(posedge sclk)
begin
     shift_buffer[15]   <= data_ins;
     shift_buffer[14:0] <= shift_buffer[15:1];
end

reg intrecclk1;
reg intrecclk2;
always @(posedge sclk)
begin
    intrecclk1 <= clkin_in;
    intrecclk2 <= intrecclk1;
    intrecclk  <= intrecclk2;
    RECCLK_reg     <= intrecclk;
end

wire[15:0] #(100) shift_buffer_d = shift_buffer;

always @(posedge RECCLK_reg)
    store_buffer <= shift_buffer_d;

assign RXD0 = store_buffer[10];
assign RXD1 = store_buffer[11];
assign RXD2 = store_buffer[12];
assign RXD3 = store_buffer[13];
assign RXD4 = store_buffer[14];
assign RXD5 = store_buffer[15];

assign RECCLK = RECCLK_reg;
//##############
//## function ##
//##############

function convert_binary;
input [7:0] sym_str;
  begin

    if (sym_str == "1")
      convert_binary = 1'b1;
    else if (sym_str == "0")
      convert_binary = 1'b0;
    else 
      convert_binary = 1'b0;
  end
endfunction

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else
      convert_int = 0;
  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction


specify 
 
(SS_CLKIN => RECCLK)   =   0:0:0, 0:0:0;
(SS_CLKIN => CSLOCK)    =   0:0:0, 0:0:0;
 
endspecify 

endmodule

`endcelldefine 
`celldefine 
`timescale 100fs / 1fs

module RX_SS_8(SIN, SS_CLKIN, RXD0, RXD1, RXD2, RXD3, RXD4, RXD5, RXD6, RXD7, RECCLK,CSLOCK);

parameter   in_freq    = "100.0";
parameter   div        = "1";
parameter   mult       = "8";
parameter   phase_adj    = "1000";
parameter   pll_dly    = "0.0";
parameter   lock_cyc   = 2;

integer     clockboost;

input  SIN;
input  SS_CLKIN;
output RECCLK,CSLOCK;
output RXD0,RXD1,RXD2,RXD3,RXD4,RXD5,RXD6,RXD7;

wire   RXD0;
wire   RXD1;
wire   RXD2;
wire   RXD3;
wire   RXD4;
wire   RXD5;
wire   RXD6;
wire   RXD7;

wire   CSLOCK;
wire[15:0] inthsrecclk;
reg    intrecclk;
reg RECCLK_reg;

wire   clkin_in;

reg    [19:0] symstr_buffer;
reg    [15:0]  store_buffer;
reg    [15:0]  shift_buffer;
reg    sclk;

time   new_delay;

time   clklock_last_rising_edge;
time   clklock_half_period;
time   clklock_half_period_minus_dly;

reg [31:0] phaseadj_str;
reg [3:0] phaseadj;
initial phaseadj_str = phase_adj;
initial phaseadj[0] = convert_binary(phaseadj_str[7:0]); 
initial phaseadj[1] = convert_binary(phaseadj_str[15:8]); 
initial phaseadj[2] = convert_binary(phaseadj_str[23:16]); 
initial phaseadj[3] = convert_binary(phaseadj_str[31:24]); 

//#########
//## PLL ##
//#########

reg [15:0] mult_r;
integer mult_i;
initial mult_r = mult;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = div;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [31:0] pll_dly_r;
real pll_dly_re;
initial pll_dly_r = pll_dly;
initial pll_dly_re = convert_real(pll_dly_r[31:24]) * (convert_real(pll_dly_r[23:16]) + 0.1 * convert_real(pll_dly_r[7:0]));

initial begin
  clklock_half_period = 0;
  clockboost     = 10 * mult_i/div_i;
  new_delay      = pll_dly_re * 10.0;
end


buf buf_clkin (clkin_in, SS_CLKIN);

integer clklock_rising_edge_count;

initial
begin
        clklock_rising_edge_count = 0;
end

always @(posedge clkin_in) begin
    clklock_rising_edge_count = clklock_rising_edge_count + 1;
    clklock_last_rising_edge = $time;
end

always @(negedge clkin_in) begin
    if (clklock_rising_edge_count == 1)
       clklock_half_period = ($time - clklock_last_rising_edge)*div_i/mult_i;
       clklock_half_period_minus_dly = clklock_half_period + 10.0 * pll_dly_re; 
end

integer   i, n, clock_count;
reg       clock_out_sig;

initial
begin
	clock_out_sig = 1'b0;
	clock_count = -1;
end
always @(clklock_rising_edge_count)
begin
    if (clklock_rising_edge_count >2 )
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count = clock_count + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count = clock_count + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count = 0;
end

reg PLL_LOCK_plus,PLL_LOCK_minus;
reg CLK_OUT_sig_d_start;

initial
begin
	PLL_LOCK_plus  = 1'b0;
	PLL_LOCK_minus = 1'b0;
	CLK_OUT_sig_d_start = 1'b0;
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    PLL_LOCK_plus = 1'b1;
    CLK_OUT_sig_d_start = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 3)
    PLL_LOCK_minus = 1'b1;
end

reg CLK_OUT_sig_d_not;
initial
begin
    CLK_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
      end
end

wire CLK_OUT_sig_d = ~CLK_OUT_sig_d_not && CLK_OUT_sig_d_start;

wire CLK_OUT_sig_2d;
wire CLK_OUT_sig_3d;
wire CLK_OUT_sig_dly;
wire CLK_OUT_plus_delay;

assign #clklock_half_period CLK_OUT_sig_2d = CLK_OUT_sig_d;
assign #clklock_half_period_minus_dly CLK_OUT_sig_3d = CLK_OUT_sig_2d;
assign #new_delay CLK_OUT_plus_delay = CLK_OUT_sig_d;

assign CSLOCK = (PLL_LOCK_plus && (pll_dly_re>=0) || PLL_LOCK_minus && (pll_dly_re<0));

//#################
//#16-phase clocks#
//#################

assign inthsrecclk[0] = !CSLOCK && clock_out_sig || CSLOCK && (CLK_OUT_plus_delay && (pll_dly_re >=0) || CLK_OUT_sig_3d && (pll_dly_re<0));
assign #(clklock_half_period/8) inthsrecclk[1] = inthsrecclk[0]; 
assign #(clklock_half_period/8) inthsrecclk[2] = inthsrecclk[1]; 
assign #(clklock_half_period/8) inthsrecclk[3] = inthsrecclk[2]; 
assign #(clklock_half_period/8) inthsrecclk[4] = inthsrecclk[3]; 
assign #(clklock_half_period/8) inthsrecclk[5] = inthsrecclk[4]; 
assign #(clklock_half_period/8) inthsrecclk[6] = inthsrecclk[5]; 
assign #(clklock_half_period/8) inthsrecclk[7] = inthsrecclk[6]; 
assign #(clklock_half_period/8) inthsrecclk[8] = inthsrecclk[7]; 
assign #(clklock_half_period/8) inthsrecclk[9] = inthsrecclk[8]; 
assign #(clklock_half_period/8) inthsrecclk[10] = inthsrecclk[9]; 
assign #(clklock_half_period/8) inthsrecclk[11] = inthsrecclk[10]; 
assign #(clklock_half_period/8) inthsrecclk[12] = inthsrecclk[11]; 
assign #(clklock_half_period/8) inthsrecclk[13] = inthsrecclk[12]; 
assign #(clklock_half_period/8) inthsrecclk[14] = inthsrecclk[13]; 
assign #(clklock_half_period/8) inthsrecclk[15] = inthsrecclk[14]; 


always @(phaseadj or inthsrecclk)
case (phaseadj)
4'b0000: sclk <= inthsrecclk[0]; 
4'b0001: sclk <= inthsrecclk[1]; 
4'b0010: sclk <= inthsrecclk[2]; 
4'b0011: sclk <= inthsrecclk[3]; 
4'b0100: sclk <= inthsrecclk[4]; 
4'b0101: sclk <= inthsrecclk[5]; 
4'b0110: sclk <= inthsrecclk[6]; 
4'b0111: sclk <= inthsrecclk[7]; 
4'b1000: sclk <= inthsrecclk[8]; 
4'b1001: sclk <= inthsrecclk[9]; 
4'b1010: sclk <= inthsrecclk[10]; 
4'b1011: sclk <= inthsrecclk[11]; 
4'b1100: sclk <= inthsrecclk[12]; 
4'b1101: sclk <= inthsrecclk[13]; 
4'b1110: sclk <= inthsrecclk[14]; 
4'b1111: sclk <= inthsrecclk[15]; 
default:  sclk <= inthsrecclk[8]; 
endcase

//########################
//#recover data and clock#
//########################

reg data_ins;
always @(posedge sclk)
   data_ins <= SIN;

always@(posedge sclk)
begin
     shift_buffer[15]   <= data_ins;
     shift_buffer[14:0] <= shift_buffer[15:1];
end

reg intrecclk1;
reg intrecclk2;
always @(posedge sclk)
begin
    intrecclk1 <= clkin_in;
    intrecclk2 <= intrecclk1;
    intrecclk  <= intrecclk2;
    RECCLK_reg     <= intrecclk;
end

wire[15:0] #(100) shift_buffer_d = shift_buffer;

always @(posedge RECCLK_reg)
    store_buffer <= shift_buffer_d;

assign RXD0 = store_buffer[8];
assign RXD1 = store_buffer[9];
assign RXD2 = store_buffer[10];
assign RXD3 = store_buffer[11];
assign RXD4 = store_buffer[12];
assign RXD5 = store_buffer[13];
assign RXD6 = store_buffer[14];
assign RXD7 = store_buffer[15];

assign RECCLK = RECCLK_reg;
//##############
//## function ##
//##############

function convert_binary;
input [7:0] sym_str;
  begin

    if (sym_str == "1")
      convert_binary = 1'b1;
    else if (sym_str == "0")
      convert_binary = 1'b0;
    else 
      convert_binary = 1'b0;
  end
endfunction

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else
      convert_int = 0;
  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction


specify 
 
(SS_CLKIN => RECCLK)   =   0:0:0, 0:0:0;
(SS_CLKIN => CSLOCK)    =   0:0:0, 0:0:0;
 
endspecify 

endmodule

`endcelldefine 

`celldefine 
`timescale 10 ps / 10 ps

module TX_10B12B (TXD0,TXD1,TXD2,TXD3,TXD4,TXD5,TXD6,TXD7,TXD8,TXD9,REFCLK,CSLOCK,SOUT);

parameter   in_freq    = "100.0";
parameter   div        = "1";
parameter   mult       = "12";
parameter   pll_dly    = "0";
parameter   lock_cyc   = 2;

integer     clockboost;

parameter   IN_FREQ    = "";
parameter   DIV        = "";
parameter   MULT       = "";
parameter   PLL_DLY    = "";

input  TXD0,TXD1,TXD2,TXD3,TXD4,TXD5,TXD6,TXD7,TXD8,TXD9;
input  REFCLK;
output SOUT, CSLOCK;
reg   SOUT_int;

wire   CSLOCK;

wire   clkin_in;

reg    [11:0] shift_buffer;

wire   inthsrecclk;
wire   intrecclk;

//#########
//## PLL ##
//#########

time   new_delay;
time   clklock_last_rising_edge;
time   clklock_last_falling_edge;
time   clklock_half_period1;
time   clklock_half_period0;
time   clklock_half_period;
time   refclk_half_period1;
time   refclk_half_period0;
time   refclk_half_period;
time   clklock_half_period_minus_dly1;
time   clklock_half_period_minus_dly0;

reg [15:0] mult_r;
integer mult_i;
initial mult_r = (MULT == "") ? mult : MULT;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = (DIV == "") ? div : DIV;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [15:0] pll_dly_r;
real pll_dly_re, pll_dly_re_temp;
initial pll_dly_r = (PLL_DLY == "") ? pll_dly : PLL_DLY;
initial 
      pll_dly_re_temp = convert_int(pll_dly_r[15:8]) * convert_int(pll_dly_r[7:0]) *0.25;

initial
      if(pll_dly_re_temp >= 0)
         pll_dly_re = 0.25 * convert_int(pll_dly_r[7:0]);
      else
         pll_dly_re = pll_dly_re_temp;


initial begin
  clklock_half_period1 = 0;
  clklock_half_period0 = 0;
  clklock_half_period_minus_dly1 = 0;
  clklock_half_period_minus_dly0 = 0;
  clockboost     = mult_i/div_i;
  new_delay      = 0.25 * convert_int(pll_dly_r[7:0]) * 100.0;
end


integer   cnt_m_div;
reg       clk_out_m_div;


buf buf_clkin (clkin_in, REFCLK);

integer clklock_rising_edge_count;
integer clklock_falling_edge_count;

initial
begin
	cnt_m_div = -1;
	clk_out_m_div = 0;
        clklock_rising_edge_count = 0;
        clklock_falling_edge_count = 0;
end

always @(posedge clkin_in) 
begin
    clklock_rising_edge_count = clklock_rising_edge_count + 1;
    clklock_last_rising_edge = $time;
end

always @(negedge clkin_in)
begin
    clklock_falling_edge_count = clklock_falling_edge_count + 1;
    clklock_last_falling_edge = $time;
end

always @(posedge clkin_in)
begin
    if (clklock_falling_edge_count == 2)
       refclk_half_period0 = ($time - clklock_last_falling_edge);
       clklock_half_period0 = ($time - clklock_last_falling_edge)*div_i/mult_i;
       clklock_half_period_minus_dly0 = ($time - clklock_last_falling_edge) + 100.0 * pll_dly_re; 
end

always @(negedge clkin_in) 
begin
    if (clklock_rising_edge_count == 1)
       refclk_half_period1 = ($time - clklock_last_rising_edge);
       clklock_half_period1 = ($time - clklock_last_rising_edge)*div_i/mult_i; 
       clklock_half_period_minus_dly1 = ($time - clklock_last_rising_edge) + 100.0 * pll_dly_re; 
end

always @(negedge clkin_in) 
begin
clklock_half_period = (clklock_half_period0 + clklock_half_period1)/2.0; 
refclk_half_period = (refclk_half_period0 + refclk_half_period1)/2.0; 
end

integer   i, j, n, clock_count, clock_count_falling;
reg       clock_out_sig;

initial
begin
	clock_out_sig = 1'b0;
	clock_count = -1;
	clock_count_falling = -1;
end
always @(clklock_rising_edge_count)
begin
    if (clklock_rising_edge_count > lock_cyc + 1)
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count = clock_count + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count = clock_count + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count = 0;
end

always @(clklock_falling_edge_count)
begin
    if (clklock_falling_edge_count > lock_cyc + 1)
    begin
      if (clockboost > 1)
       begin
	for (j = 1; j <= 2* clockboost ; j = j +1)
           begin
                clock_count_falling = clock_count_falling + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count_falling = clock_count_falling + 1;
                #clklock_half_period   n = 0;
           end
    end
    else
      clock_count_falling = 0;
end

reg PLL_LOCK_plus,PLL_LOCK_minus;
reg CLK_OUT_sig_d_start;

initial
begin
	PLL_LOCK_plus  = 1'b0;
	PLL_LOCK_minus = 1'b0;
	CLK_OUT_sig_d_start = 1'b0;
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    CLK_OUT_sig_d_start = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    PLL_LOCK_plus = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 3)
    PLL_LOCK_minus = 1'b1;
end

reg CLK_OUT_sig_d_not;
initial
begin
    CLK_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
      end
end

wire CLK_OUT_sig_d = ~CLK_OUT_sig_d_not && CLK_OUT_sig_d_start;

reg CLK_OUT_sig_3d;
wire CLK_OUT_plus_delay;

reg start_CLK_OUT;

initial 
begin
CLK_OUT_sig_3d = 1'b0; start_CLK_OUT = 1'b0;
end

always @(clock_count_falling)
begin
  if (clock_count_falling == 1)
  begin
    #clklock_half_period_minus_dly0 CLK_OUT_sig_3d = 1'b1; start_CLK_OUT = 1'b1;
  end
end

always @(start_CLK_OUT)
begin
 while (start_CLK_OUT) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_3d = ~ CLK_OUT_sig_3d;
         #clklock_half_period 
         CLK_OUT_sig_3d = ~ CLK_OUT_sig_3d;
      end
end

assign #new_delay CLK_OUT_plus_delay = CLK_OUT_sig_d;


assign CSLOCK = (PLL_LOCK_plus && (pll_dly_re>=0) || PLL_LOCK_minus && (pll_dly_re<0));
assign inthsrecclk = CLK_OUT_plus_delay;

//########
//## TX ##
//########

assign intrecclk = REFCLK;

reg [3:0] cnt;
wire [11:0] data_out;

initial 
begin
  cnt = 4'b0000;
  shift_buffer = 12'b000000000000;
end

always @(posedge inthsrecclk)
begin
   if (cnt == 4'b1100)
        cnt = 4'b0001;
   else
        cnt = cnt + 1;
end

assign data_out[0] = (cnt == 4'b1100) ? 1'b1 : shift_buffer[1]; 
assign data_out[1] = (cnt == 4'b1100) ? TXD0 : shift_buffer[2]; 
assign data_out[2] = (cnt == 4'b1100) ? TXD1 : shift_buffer[3]; 
assign data_out[3] = (cnt == 4'b1100) ? TXD2 : shift_buffer[4]; 
assign data_out[4] = (cnt == 4'b1100) ? TXD3 : shift_buffer[5]; 
assign data_out[5] = (cnt == 4'b1100) ? TXD4 : shift_buffer[6]; 
assign data_out[6] = (cnt == 4'b1100) ? TXD5 : shift_buffer[7]; 
assign data_out[7] = (cnt == 4'b1100) ? TXD6 : shift_buffer[8]; 
assign data_out[8] = (cnt == 4'b1100) ? TXD7 : shift_buffer[9]; 
assign data_out[9] = (cnt == 4'b1100) ? TXD8 : shift_buffer[10]; 
assign data_out[10] = (cnt == 4'b1100) ? TXD9 : shift_buffer[11]; 
assign data_out[11] = (cnt == 4'b1100) ? 1'b0 : shift_buffer[0]; 

always @(posedge inthsrecclk)
begin
     SOUT_int = data_out[0];
     shift_buffer[1] = data_out[1];
     shift_buffer[2] = data_out[2];
     shift_buffer[3] = data_out[3];
     shift_buffer[4] = data_out[4];
     shift_buffer[5] = data_out[5];
     shift_buffer[6] = data_out[6];
     shift_buffer[7] = data_out[7];
     shift_buffer[8] = data_out[8];
     shift_buffer[9] = data_out[9];
     shift_buffer[10] = data_out[10];
     shift_buffer[11] = data_out[11];
end


assign  #(refclk_half_period*2*div_i/mult_i) SOUT = SOUT_int;



//##############
//## function ##
//##############

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else
      convert_int = 0;

  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction

specify 

	$setuphold  (posedge REFCLK, TXD0, 1, 0);
	$setuphold  (posedge REFCLK, TXD1, 1, 0);
	$setuphold  (posedge REFCLK, TXD2, 1, 0);
	$setuphold  (posedge REFCLK, TXD3, 1, 0);
	$setuphold  (posedge REFCLK, TXD4, 1, 0);
	$setuphold  (posedge REFCLK, TXD5, 1, 0);
	$setuphold  (posedge REFCLK, TXD6, 1, 0);
	$setuphold  (posedge REFCLK, TXD7, 1, 0);
	$setuphold  (posedge REFCLK, TXD8, 1, 0);
	$setuphold  (posedge REFCLK, TXD9, 1, 0);
 
        (REFCLK => CSLOCK)    =   0:0:0, 0:0:0;
        (REFCLK => SOUT)      =   0:0:0, 0:0:0;
 
endspecify 

endmodule

`endcelldefine 

`celldefine 
`timescale 10 ps / 10 ps

module TX_8B10B (TXD0,TXD1,TXD2,TXD3,TXD4,TXD5,TXD6,TXD7,TXD8,TXD9,REFCLK,CSLOCK,SOUT);

parameter   in_freq    = "100.0";
parameter   div        = "1";
parameter   mult       = "10";
parameter   pll_dly    = "0";
parameter   lock_cyc   = 2;

integer     clockboost;

parameter   IN_FREQ    = "";
parameter   DIV        = "";
parameter   MULT       = "";
parameter   PLL_DLY    = "";

input  TXD0,TXD1,TXD2,TXD3,TXD4,TXD5,TXD6,TXD7,TXD8,TXD9;
input  REFCLK;
output SOUT, CSLOCK;

reg   SOUT_int;
wire  SOUT_int1, SOUT;
wire   CSLOCK;

wire   clkin_in;

reg    [9:0] shift_buffer;

wire   inthsrecclk;
wire   intrecclk;

//#########
//## PLL ##
//#########

time   new_delay;
time   clklock_last_rising_edge;
time   clklock_last_falling_edge;
time   clklock_half_period1;
time   clklock_half_period0;
time   clklock_half_period;
time   refclk_half_period1;
time   refclk_half_period0;
time   refclk_half_period;
time   clklock_half_period_minus_dly1;
time   clklock_half_period_minus_dly0;

reg [15:0] mult_r;
integer mult_i;
initial mult_r = (MULT == "") ? mult : MULT;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = (DIV == "") ? div : DIV;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [15:0] pll_dly_r;
real pll_dly_re, pll_dly_re_temp;
initial pll_dly_r = (PLL_DLY == "") ? pll_dly : PLL_DLY;
initial 
      pll_dly_re_temp = convert_int(pll_dly_r[15:8]) * convert_int(pll_dly_r[7:0]) *0.25;

initial
      if(pll_dly_re_temp >= 0)
         pll_dly_re = 0.25 * convert_int(pll_dly_r[7:0]);
      else
         pll_dly_re = pll_dly_re_temp;


initial begin
  clklock_half_period1 = 0;
  clklock_half_period0 = 0;
  clklock_half_period_minus_dly1 = 0;
  clklock_half_period_minus_dly0 = 0;
  clockboost     = mult_i/div_i;
  new_delay      = 0.25 * convert_int(pll_dly_r[7:0]) * 100.0;
end


integer   cnt_m_div;
reg       clk_out_m_div;


buf buf_clkin (clkin_in, REFCLK);

integer clklock_rising_edge_count;
integer clklock_falling_edge_count;

initial
begin
	cnt_m_div = -1;
	clk_out_m_div = 0;
        clklock_rising_edge_count = 0;
        clklock_falling_edge_count = 0;
end

always @(posedge clkin_in) 
begin
    clklock_rising_edge_count = clklock_rising_edge_count + 1;
    clklock_last_rising_edge = $time;
end

always @(negedge clkin_in)
begin
    clklock_falling_edge_count = clklock_falling_edge_count + 1;
    clklock_last_falling_edge = $time;
end

always @(posedge clkin_in)
begin
    if (clklock_falling_edge_count == 2)
       refclk_half_period0 = ($time - clklock_last_falling_edge);
       clklock_half_period0 = ($time - clklock_last_falling_edge)*div_i/mult_i;
       clklock_half_period_minus_dly0 = ($time - clklock_last_falling_edge) + 100.0 * pll_dly_re; 
end

always @(negedge clkin_in) 
begin
    if (clklock_rising_edge_count == 1)
       refclk_half_period1 = ($time - clklock_last_rising_edge);
       clklock_half_period1 = ($time - clklock_last_rising_edge)*div_i/mult_i;
       clklock_half_period_minus_dly1 = ($time - clklock_last_rising_edge) + 100.0 * pll_dly_re; 
end

always @(negedge clkin_in) 
begin
clklock_half_period = (clklock_half_period0 + clklock_half_period1)/2.0; 
refclk_half_period = (refclk_half_period0 + refclk_half_period1)/2.0; 
end

integer   i, j, n, clock_count, clock_count_falling;
reg       clock_out_sig;

initial
begin
	clock_out_sig = 1'b0;
	clock_count = -1;
	clock_count_falling = -1;
end
always @(clklock_rising_edge_count)
begin
    if (clklock_rising_edge_count > lock_cyc + 1)
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count = clock_count + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count = clock_count + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count = 0;
end

always @(clklock_falling_edge_count)
begin
    if (clklock_falling_edge_count > lock_cyc + 1)
    begin
      if (clockboost > 1)
       begin
	for (j = 1; j <= 2* clockboost ; j = j +1)
           begin
                clock_count_falling = clock_count_falling + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count_falling = clock_count_falling + 1;
                #clklock_half_period   n = 0;
           end
    end
    else
      clock_count_falling = 0;
end

reg PLL_LOCK_plus,PLL_LOCK_minus;
reg CLK_OUT_sig_d_start;

initial
begin
	PLL_LOCK_plus  = 1'b0;
	PLL_LOCK_minus = 1'b0;
	CLK_OUT_sig_d_start = 1'b0;
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    CLK_OUT_sig_d_start = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    PLL_LOCK_plus = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 3)
    PLL_LOCK_minus = 1'b1;
end

reg CLK_OUT_sig_d_not;
initial
begin
    CLK_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
      end
end

wire CLK_OUT_sig_d = ~CLK_OUT_sig_d_not && CLK_OUT_sig_d_start;

reg CLK_OUT_sig_3d;
wire CLK_OUT_plus_delay;

reg start_CLK_OUT;

initial 
begin
CLK_OUT_sig_3d = 1'b0; start_CLK_OUT = 1'b0;
end

always @(clock_count_falling)
begin
  if (clock_count_falling == 1)
  begin
    #clklock_half_period_minus_dly0 CLK_OUT_sig_3d = 1'b1; start_CLK_OUT = 1'b1;
  end
end

always @(start_CLK_OUT)
begin
 while (start_CLK_OUT) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_3d = ~ CLK_OUT_sig_3d;
         #clklock_half_period 
         CLK_OUT_sig_3d = ~ CLK_OUT_sig_3d;
      end
end

assign #new_delay CLK_OUT_plus_delay = CLK_OUT_sig_d;

assign CSLOCK = (PLL_LOCK_plus && (pll_dly_re>=0) || PLL_LOCK_minus && (pll_dly_re<0));
assign inthsrecclk = CLK_OUT_plus_delay;

assign intrecclk = REFCLK;

//########
//## TX ##
//########

reg [3:0] cnt;
wire [9:0] data_out;

initial 
begin
  cnt = 4'b0000;
  shift_buffer = 10'b0000000000;
end

always @(posedge inthsrecclk)
begin
   if (cnt == 4'b1010)
        cnt = 4'b0001;
   else
        cnt = cnt + 1;
end

assign data_out[0] = (cnt == 4'b1010) ? TXD0 : shift_buffer[1]; 
assign data_out[1] = (cnt == 4'b1010) ? TXD1 : shift_buffer[2]; 
assign data_out[2] = (cnt == 4'b1010) ? TXD2 : shift_buffer[3]; 
assign data_out[3] = (cnt == 4'b1010) ? TXD3 : shift_buffer[4]; 
assign data_out[4] = (cnt == 4'b1010) ? TXD4 : shift_buffer[5]; 
assign data_out[5] = (cnt == 4'b1010) ? TXD5 : shift_buffer[6]; 
assign data_out[6] = (cnt == 4'b1010) ? TXD6 : shift_buffer[7]; 
assign data_out[7] = (cnt == 4'b1010) ? TXD7 : shift_buffer[8]; 
assign data_out[8] = (cnt == 4'b1010) ? TXD8 : shift_buffer[9]; 
assign data_out[9] = (cnt == 4'b1010) ? TXD9 : shift_buffer[0]; 

always @(posedge inthsrecclk)
begin
     SOUT_int = data_out[0];
     shift_buffer[1] = data_out[1];
     shift_buffer[2] = data_out[2];
     shift_buffer[3] = data_out[3];
     shift_buffer[4] = data_out[4];
     shift_buffer[5] = data_out[5];
     shift_buffer[6] = data_out[6];
     shift_buffer[7] = data_out[7];
     shift_buffer[8] = data_out[8];
     shift_buffer[9] = data_out[9];
end

assign  #(refclk_half_period*2*div_i/mult_i) SOUT_int1 = SOUT_int;
assign  #(refclk_half_period*2*div_i/mult_i) SOUT = SOUT_int1;

//##############
//## function ##
//##############

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else
      convert_int = 0;

  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction

specify 

	$setuphold  (posedge REFCLK, TXD0, 1, 0);
	$setuphold  (posedge REFCLK, TXD1, 1, 0);
	$setuphold  (posedge REFCLK, TXD2, 1, 0);
	$setuphold  (posedge REFCLK, TXD3, 1, 0);
	$setuphold  (posedge REFCLK, TXD4, 1, 0);
	$setuphold  (posedge REFCLK, TXD5, 1, 0);
	$setuphold  (posedge REFCLK, TXD6, 1, 0);
	$setuphold  (posedge REFCLK, TXD7, 1, 0);
	$setuphold  (posedge REFCLK, TXD8, 1, 0);
	$setuphold  (posedge REFCLK, TXD9, 1, 0);
 
        (REFCLK => CSLOCK)    =   0:0:0, 0:0:0;
        (REFCLK => SOUT)      =   0:0:0, 0:0:0;
 
endspecify 

endmodule

`endcelldefine 


`celldefine 
`timescale 100 fs / 1 fs

module TX_SS_4 (TXD0,TXD1,TXD2,TXD3,REFCLK,CSLOCK,SS_CLKOUT,SOUT);

parameter   in_freq    = "100.0";
parameter   div        = "1";
parameter   mult       = "4";
parameter   pll_dly    = "0.0";
parameter   lock_cyc   = 2;

integer     clockboost;

input  TXD0,TXD1,TXD2,TXD3;
input  REFCLK;
output SS_CLKOUT, SOUT, CSLOCK;
wire   SS_CLKOUT, SOUT;

wire   RECCLK, CSLOCK;

wire   clkin_in;

reg    [9:0] store_buffer;
reg    [11:0] shift_buffer;

wire   inthsrecclk;
wire   hstxclk;
wire   intrecclk;

time   new_delay;
time   clklock_last_rising_edge;
time   clklock_half_period;
time   clklock_half_period_minus_dly;

//#########
//## PLL ##
//#########

reg [15:0] mult_r;
integer mult_i;
initial mult_r = mult;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = div;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [31:0] pll_dly_r;
real pll_dly_re;
initial pll_dly_r = pll_dly;
initial pll_dly_re = convert_real(pll_dly_r[31:24]) * (convert_real(pll_dly_r[23:16]) + 0.1 * convert_real(pll_dly_r[7:0]));

initial begin
  clklock_half_period = 0;
  clockboost     = mult_i/div_i;
  new_delay      = pll_dly_re * 10.0;
end

buf buf_clkin (clkin_in, REFCLK);

integer clklock_rising_edge_count;

initial
begin
        clklock_rising_edge_count = 0;
end

always @(posedge clkin_in) begin
    clklock_rising_edge_count = clklock_rising_edge_count + 1;
    clklock_last_rising_edge = $time;
end

always @(negedge clkin_in) begin
    if (clklock_rising_edge_count == 1)
       clklock_half_period = ($time - clklock_last_rising_edge)*div_i/mult_i;
       clklock_half_period_minus_dly = clklock_half_period + 10.0 * pll_dly_re; 
end

integer   i, n, clock_count;
reg       clock_out_sig;

initial
begin
	clock_out_sig = 1'b0;
	clock_count = -1;
end
always @(clklock_rising_edge_count)
begin
    if (clklock_rising_edge_count >2 )
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count = clock_count + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count = clock_count + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count = 0;
end

reg PLL_LOCK_plus,PLL_LOCK_minus;
reg CLK_OUT_sig_d_start;

initial
begin
	PLL_LOCK_plus  = 1'b0;
	PLL_LOCK_minus = 1'b0;
	CLK_OUT_sig_d_start = 1'b0;
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    PLL_LOCK_plus = 1'b1;
    CLK_OUT_sig_d_start = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 3)
    PLL_LOCK_minus = 1'b1;
end

reg CLK_OUT_sig_d_not;
initial
begin
    CLK_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
      end
end

wire CLK_OUT_sig_d = ~CLK_OUT_sig_d_not && CLK_OUT_sig_d_start;

wire CLK_OUT_sig_2d;
wire CLK_OUT_sig_3d;
wire CLK_OUT_sig_dly;
wire CLK_OUT_plus_delay;

assign #clklock_half_period CLK_OUT_sig_2d = CLK_OUT_sig_d;
assign #clklock_half_period_minus_dly CLK_OUT_sig_3d = CLK_OUT_sig_2d;
assign #new_delay CLK_OUT_plus_delay = CLK_OUT_sig_d;


assign CSLOCK = (PLL_LOCK_plus && (pll_dly_re>=0) || PLL_LOCK_minus && (pll_dly_re<0));
assign inthsrecclk = !CSLOCK && clock_out_sig || CSLOCK && (CLK_OUT_plus_delay && (pll_dly_re >=0) || CLK_OUT_sig_3d && (pll_dly_re<0));
assign hstxclk = ~inthsrecclk;

//########
//## TX ##
//########

assign intrecclk = REFCLK;
assign SS_CLKOUT = intrecclk;

wire sload;
reg  intrecclk_d;
reg  intrecclk_2d;
reg  intrecclk_3d;
assign sload = intrecclk_2d && ~intrecclk_3d;

always @(negedge hstxclk)
begin
     intrecclk_d <= intrecclk;
     intrecclk_2d <= intrecclk_d;
     intrecclk_3d <= intrecclk_2d;
end

always @(posedge intrecclk)
begin
    store_buffer[0] <= TXD0;
    store_buffer[1] <= TXD1;
    store_buffer[2] <= TXD2;
    store_buffer[3] <= TXD3;
end

reg[9:0] store_buffer_d;
always @(negedge hstxclk)
    store_buffer_d <= store_buffer;

assign SOUT = shift_buffer[0];

always @(negedge hstxclk)
if (sload)
    shift_buffer <= {1'b1, 1'b0, store_buffer_d};
else
    shift_buffer <= {1'b0, shift_buffer[11:1]};

//##############
//## function ##
//##############

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else
      convert_int = 0;

  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction


specify 

	$setuphold  (posedge REFCLK, TXD0, 1, 0);
	$setuphold  (posedge REFCLK, TXD1, 1, 0);
	$setuphold  (posedge REFCLK, TXD2, 1, 0);
	$setuphold  (posedge REFCLK, TXD3, 1, 0);
 
	(REFCLK => CSLOCK)    =   0:0:0, 0:0:0;
	(REFCLK => SOUT)      =   0:0:0, 0:0:0;
 
endspecify 


endmodule

`endcelldefine 
`celldefine 
`timescale 100 fs / 1 fs

module TX_SS_6 (TXD0,TXD1,TXD2,TXD3,TXD4,TXD5,REFCLK,CSLOCK,SS_CLKOUT,SOUT);

parameter   in_freq    = "100.0";
parameter   div        = "1";
parameter   mult       = "6";
parameter   pll_dly    = "0.0";
parameter   lock_cyc   = 2;

integer     clockboost;

input  TXD0,TXD1,TXD2,TXD3,TXD4,TXD5;
input  REFCLK;
output SS_CLKOUT, SOUT, CSLOCK;
wire   SS_CLKOUT, SOUT;

wire   RECCLK, CSLOCK;

wire   clkin_in;

reg    [9:0] store_buffer;
reg    [11:0] shift_buffer;

wire   inthsrecclk;
wire   hstxclk;
wire   intrecclk;

time   new_delay;
time   clklock_last_rising_edge;
time   clklock_half_period;
time   clklock_half_period_minus_dly;

//#########
//## PLL ##
//#########

reg [15:0] mult_r;
integer mult_i;
initial mult_r = mult;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = div;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [31:0] pll_dly_r;
real pll_dly_re;
initial pll_dly_r = pll_dly;
initial pll_dly_re = convert_real(pll_dly_r[31:24]) * (convert_real(pll_dly_r[23:16]) + 0.1 * convert_real(pll_dly_r[7:0]));

initial begin
  clklock_half_period = 0;
  clockboost     = mult_i/div_i;
  new_delay      = pll_dly_re * 10.0;
end

buf buf_clkin (clkin_in, REFCLK);

integer clklock_rising_edge_count;

initial
begin
        clklock_rising_edge_count = 0;
end

always @(posedge clkin_in) begin
    clklock_rising_edge_count = clklock_rising_edge_count + 1;
    clklock_last_rising_edge = $time;
end

always @(negedge clkin_in) begin
    if (clklock_rising_edge_count == 1)
       clklock_half_period = ($time - clklock_last_rising_edge)*div_i/mult_i;
       clklock_half_period_minus_dly = clklock_half_period + 10.0 * pll_dly_re; 
end

integer   i, n, clock_count;
reg       clock_out_sig;

initial
begin
	clock_out_sig = 1'b0;
	clock_count = -1;
end
always @(clklock_rising_edge_count)
begin
    if (clklock_rising_edge_count >2 )
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count = clock_count + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count = clock_count + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count = 0;
end

reg PLL_LOCK_plus,PLL_LOCK_minus;
reg CLK_OUT_sig_d_start;

initial
begin
	PLL_LOCK_plus  = 1'b0;
	PLL_LOCK_minus = 1'b0;
	CLK_OUT_sig_d_start = 1'b0;
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    PLL_LOCK_plus = 1'b1;
    CLK_OUT_sig_d_start = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 3)
    PLL_LOCK_minus = 1'b1;
end

reg CLK_OUT_sig_d_not;
initial
begin
    CLK_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
      end
end

wire CLK_OUT_sig_d = ~CLK_OUT_sig_d_not && CLK_OUT_sig_d_start;

wire CLK_OUT_sig_2d;
wire CLK_OUT_sig_3d;
wire CLK_OUT_sig_dly;
wire CLK_OUT_plus_delay;

assign #clklock_half_period CLK_OUT_sig_2d = CLK_OUT_sig_d;
assign #clklock_half_period_minus_dly CLK_OUT_sig_3d = CLK_OUT_sig_2d;
assign #new_delay CLK_OUT_plus_delay = CLK_OUT_sig_d;


assign CSLOCK = (PLL_LOCK_plus && (pll_dly_re>=0) || PLL_LOCK_minus && (pll_dly_re<0));
assign inthsrecclk = !CSLOCK && clock_out_sig || CSLOCK && (CLK_OUT_plus_delay && (pll_dly_re >=0) || CLK_OUT_sig_3d && (pll_dly_re<0));
assign hstxclk = ~inthsrecclk;

//########
//## TX ##
//########

assign intrecclk = REFCLK;
assign SS_CLKOUT = intrecclk;

wire sload;
reg  intrecclk_d;
reg  intrecclk_2d;
reg  intrecclk_3d;
assign sload = intrecclk_2d && ~intrecclk_3d;

always @(negedge hstxclk)
begin
     intrecclk_d <= intrecclk;
     intrecclk_2d <= intrecclk_d;
     intrecclk_3d <= intrecclk_2d;
end

always @(posedge intrecclk)
begin
    store_buffer[0] <= TXD0;
    store_buffer[1] <= TXD1;
    store_buffer[2] <= TXD2;
    store_buffer[3] <= TXD3;
    store_buffer[4] <= TXD4;
    store_buffer[5] <= TXD5;
end

reg[9:0] store_buffer_d;
always @(negedge hstxclk)
    store_buffer_d <= store_buffer;

assign SOUT = shift_buffer[0];

always @(negedge hstxclk)
if (sload)
    shift_buffer <= {1'b1, 1'b0, store_buffer_d};
else
    shift_buffer <= {1'b0, shift_buffer[11:1]};

//##############
//## function ##
//##############

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else
      convert_int = 0;

  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction


specify 

	$setuphold  (posedge REFCLK, TXD0, 1, 0);
	$setuphold  (posedge REFCLK, TXD1, 1, 0);
	$setuphold  (posedge REFCLK, TXD2, 1, 0);
	$setuphold  (posedge REFCLK, TXD3, 1, 0);
	$setuphold  (posedge REFCLK, TXD4, 1, 0);
	$setuphold  (posedge REFCLK, TXD5, 1, 0);

	(REFCLK => CSLOCK)    =   0:0:0, 0:0:0;
	(REFCLK => SOUT)      =   0:0:0, 0:0:0;
 
endspecify 


endmodule

`endcelldefine 
`celldefine 
`timescale 100 fs / 1 fs

module TX_SS_8 (TXD0,TXD1,TXD2,TXD3,TXD4,TXD5,TXD6,TXD7,REFCLK,CSLOCK,SS_CLKOUT,SOUT);

parameter   in_freq    = "100.0";
parameter   div        = "1";
parameter   mult       = "8";
parameter   pll_dly    = "0.0";
parameter   lock_cyc   = 2;

integer     clockboost;

input  TXD0,TXD1,TXD2,TXD3,TXD4,TXD5,TXD6,TXD7;
input  REFCLK;
output SS_CLKOUT, SOUT, CSLOCK;
wire   SS_CLKOUT, SOUT;

wire   RECCLK, CSLOCK;

wire   clkin_in;

reg    [9:0] store_buffer;
reg    [11:0] shift_buffer;

wire   inthsrecclk;
wire   hstxclk;
wire   intrecclk;

time   new_delay;
time   clklock_last_rising_edge;
time   clklock_half_period;
time   clklock_half_period_minus_dly;

//#########
//## PLL ##
//#########

reg [15:0] mult_r;
integer mult_i;
initial mult_r = mult;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = div;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [31:0] pll_dly_r;
real pll_dly_re;
initial pll_dly_r = pll_dly;
initial pll_dly_re = convert_real(pll_dly_r[31:24]) * (convert_real(pll_dly_r[23:16]) + 0.1 * convert_real(pll_dly_r[7:0]));

initial begin
  clklock_half_period = 0;
  clockboost     = mult_i/div_i;
  new_delay      = pll_dly_re * 10.0;
end

buf buf_clkin (clkin_in, REFCLK);

integer clklock_rising_edge_count;

initial
begin
        clklock_rising_edge_count = 0;
end

always @(posedge clkin_in) begin
    clklock_rising_edge_count = clklock_rising_edge_count + 1;
    clklock_last_rising_edge = $time;
end

always @(negedge clkin_in) begin
    if (clklock_rising_edge_count == 1)
       clklock_half_period = ($time - clklock_last_rising_edge)*div_i/mult_i;
       clklock_half_period_minus_dly = clklock_half_period + 10.0 * pll_dly_re; 
end

integer   i, n, clock_count;
reg       clock_out_sig;

initial
begin
	clock_out_sig = 1'b0;
	clock_count = -1;
end
always @(clklock_rising_edge_count)
begin
    if (clklock_rising_edge_count >2 )
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count = clock_count + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count = clock_count + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count = 0;
end

reg PLL_LOCK_plus,PLL_LOCK_minus;
reg CLK_OUT_sig_d_start;

initial
begin
	PLL_LOCK_plus  = 1'b0;
	PLL_LOCK_minus = 1'b0;
	CLK_OUT_sig_d_start = 1'b0;
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    PLL_LOCK_plus = 1'b1;
    CLK_OUT_sig_d_start = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 3)
    PLL_LOCK_minus = 1'b1;
end

reg CLK_OUT_sig_d_not;
initial
begin
    CLK_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
      end
end

wire CLK_OUT_sig_d = ~CLK_OUT_sig_d_not && CLK_OUT_sig_d_start;

wire CLK_OUT_sig_2d;
wire CLK_OUT_sig_3d;
wire CLK_OUT_sig_dly;
wire CLK_OUT_plus_delay;

assign #clklock_half_period CLK_OUT_sig_2d = CLK_OUT_sig_d;
assign #clklock_half_period_minus_dly CLK_OUT_sig_3d = CLK_OUT_sig_2d;
assign #new_delay CLK_OUT_plus_delay = CLK_OUT_sig_d;


assign CSLOCK = (PLL_LOCK_plus && (pll_dly_re>=0) || PLL_LOCK_minus && (pll_dly_re<0));
assign inthsrecclk = !CSLOCK && clock_out_sig || CSLOCK && (CLK_OUT_plus_delay && (pll_dly_re >=0) || CLK_OUT_sig_3d && (pll_dly_re<0));
assign hstxclk = ~inthsrecclk;

//########
//## TX ##
//########

assign intrecclk = REFCLK;
assign SS_CLKOUT = intrecclk;

wire sload;
reg  intrecclk_d;
reg  intrecclk_2d;
reg  intrecclk_3d;

assign sload = intrecclk_2d && ~intrecclk_3d;

always @(negedge hstxclk)
begin
     intrecclk_d <= intrecclk;
     intrecclk_2d <= intrecclk_d;
     intrecclk_3d <= intrecclk_2d;
end

always @(posedge intrecclk)
begin
    store_buffer[0] <= TXD0;
    store_buffer[1] <= TXD1;
    store_buffer[2] <= TXD2;
    store_buffer[3] <= TXD3;
    store_buffer[4] <= TXD4;
    store_buffer[5] <= TXD5;
    store_buffer[6] <= TXD6;
    store_buffer[7] <= TXD7;
end

reg[9:0] store_buffer_d;
always @(negedge hstxclk)
    store_buffer_d <= store_buffer;

assign SOUT = shift_buffer[0];

always @(negedge hstxclk)
if (sload)
    shift_buffer <= {1'b1, 1'b0, store_buffer_d};
else
    shift_buffer <= {1'b0, shift_buffer[11:1]};

//##############
//## function ##
//##############

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else
      convert_int = 0;

  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
	    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction


specify 

	$setuphold  (posedge REFCLK, TXD0, 1, 0);
	$setuphold  (posedge REFCLK, TXD1, 1, 0);
	$setuphold  (posedge REFCLK, TXD2, 1, 0);
	$setuphold  (posedge REFCLK, TXD3, 1, 0);
	$setuphold  (posedge REFCLK, TXD4, 1, 0);
	$setuphold  (posedge REFCLK, TXD5, 1, 0);
	$setuphold  (posedge REFCLK, TXD6, 1, 0);
	$setuphold  (posedge REFCLK, TXD7, 1, 0);

	(REFCLK => CSLOCK)    =   0:0:0, 0:0:0;
	(REFCLK => SOUT)      =   0:0:0, 0:0:0;
 
endspecify 


endmodule

`endcelldefine 

`celldefine 
`timescale 100 fs / 1 fs

module TX_SS_10 (TXD0,TXD1,TXD2,TXD3,TXD4,TXD5,TXD6,TXD7,TXD8,TXD9,REFCLK,CSLOCK,SS_CLKOUT,SOUT);

parameter   in_freq    = "100.0";
parameter   div        = "1";
parameter   mult       = "10";
parameter   pll_dly    = "0.0";
parameter   lock_cyc   = 2;

integer     clockboost;

input  TXD0,TXD1,TXD2,TXD3,TXD4,TXD5,TXD6,TXD7,TXD8,TXD9;
input  REFCLK;
output SS_CLKOUT, SOUT, CSLOCK;
wire   SS_CLKOUT, SOUT;

wire   RECCLK, CSLOCK;

wire   clkin_in;

reg    [9:0] store_buffer;
reg    [11:0] shift_buffer;

wire   inthsrecclk;
wire   hstxclk;
wire   intrecclk;

time   new_delay;
time   clklock_last_rising_edge;
time   clklock_half_period;
time   clklock_half_period_minus_dly;

//#########
//## PLL ##
//#########

reg [15:0] mult_r;
integer mult_i;
initial mult_r = mult;
initial mult_i = 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [15:0] div_r;
integer div_i;
initial div_r = div;
initial div_i = 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [31:0] pll_dly_r;
real pll_dly_re;
initial pll_dly_r = pll_dly;
initial pll_dly_re = convert_real(pll_dly_r[31:24]) * (convert_real(pll_dly_r[23:16]) + 0.1 * convert_real(pll_dly_r[7:0]));

initial begin
  clklock_half_period = 0;
  clockboost     = mult_i/div_i;
  new_delay      = pll_dly_re * 10.0;
end

buf buf_clkin (clkin_in, REFCLK);

integer clklock_rising_edge_count;

initial
begin
        clklock_rising_edge_count = 0;
end

always @(posedge clkin_in) begin
    clklock_rising_edge_count = clklock_rising_edge_count + 1;
    clklock_last_rising_edge = $time;
end

always @(negedge clkin_in) begin
    if (clklock_rising_edge_count == 1)
       clklock_half_period = ($time - clklock_last_rising_edge)*div_i/mult_i;
       clklock_half_period_minus_dly = clklock_half_period + 10.0 * pll_dly_re; 
end

integer   i, n, clock_count;
reg       clock_out_sig;

initial
begin
	clock_out_sig = 1'b0;
	clock_count = -1;
end
always @(clklock_rising_edge_count)
begin
    if (clklock_rising_edge_count >2 )
    begin
      if (clockboost > 1)
       begin
	for (i = 1; i <= 2* clockboost ; i = i +1)
           begin
                clock_count = clock_count + 1;
                #clklock_half_period   n = 0;
           end
       end
      else
           begin
              clock_count = clock_count + 1;
              #clklock_half_period   n = 0;
           end
    end
    else
      clock_count = 0;
end

reg PLL_LOCK_plus,PLL_LOCK_minus;
reg CLK_OUT_sig_d_start;

initial
begin
	PLL_LOCK_plus  = 1'b0;
	PLL_LOCK_minus = 1'b0;
	CLK_OUT_sig_d_start = 1'b0;
end

always @(clock_count)
begin
  if (clock_count == 1)
  begin
    PLL_LOCK_plus = 1'b1;
    CLK_OUT_sig_d_start = 1'b1;
  end
end

always @(clock_count)
begin
  if (clock_count == 3)
    PLL_LOCK_minus = 1'b1;
end

reg CLK_OUT_sig_d_not;
initial
begin
    CLK_OUT_sig_d_not = 1'b0;
end

always @(clock_count)
begin
      while (clock_count>0) 
      begin
         #clklock_half_period 
         CLK_OUT_sig_d_not = ~ CLK_OUT_sig_d_not;
      end
end

wire CLK_OUT_sig_d = ~CLK_OUT_sig_d_not && CLK_OUT_sig_d_start;

wire CLK_OUT_sig_2d;
wire CLK_OUT_sig_3d;
wire CLK_OUT_sig_dly;
wire CLK_OUT_plus_delay;

assign #clklock_half_period CLK_OUT_sig_2d = CLK_OUT_sig_d;
assign #clklock_half_period_minus_dly CLK_OUT_sig_3d = CLK_OUT_sig_2d;
assign #new_delay CLK_OUT_plus_delay = CLK_OUT_sig_d;


assign CSLOCK = (PLL_LOCK_plus && (pll_dly_re>=0) || PLL_LOCK_minus && (pll_dly_re<0));
assign inthsrecclk = !CSLOCK && clock_out_sig || CSLOCK && (CLK_OUT_plus_delay && (pll_dly_re >=0) || CLK_OUT_sig_3d && (pll_dly_re<0));
assign hstxclk = ~inthsrecclk;

//########
//## TX ##
//########

assign intrecclk = REFCLK;
assign SS_CLKOUT = intrecclk;

wire sload;
reg  intrecclk_d;
reg  intrecclk_2d;
reg  intrecclk_3d;

assign sload = intrecclk_2d && ~intrecclk_3d;

always @(negedge hstxclk)
begin
     intrecclk_d <= intrecclk;
     intrecclk_2d <= intrecclk_d;
     intrecclk_3d <= intrecclk_2d;
end

always @(posedge intrecclk)
begin
    store_buffer[0] <= TXD0;
    store_buffer[1] <= TXD1;
    store_buffer[2] <= TXD2;
    store_buffer[3] <= TXD3;
    store_buffer[4] <= TXD4;
    store_buffer[5] <= TXD5;
    store_buffer[6] <= TXD6;
    store_buffer[7] <= TXD7;
    store_buffer[8] <= TXD8;
    store_buffer[9] <= TXD9;
end

reg[9:0] store_buffer_d;
always @(negedge hstxclk)
    store_buffer_d <= store_buffer;

assign SOUT = shift_buffer[0];

always @(negedge hstxclk)
if (sload)
    shift_buffer <= {1'b1, 1'b0, store_buffer_d};
else
    shift_buffer <= {1'b0, shift_buffer[11:1]};

//##############
//## function ##
//##############

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else
      convert_int = 0;

  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0; 

  end
endfunction


specify 

	$setuphold  (posedge REFCLK, TXD0, 1, 0);
	$setuphold  (posedge REFCLK, TXD1, 1, 0);
	$setuphold  (posedge REFCLK, TXD2, 1, 0);
	$setuphold  (posedge REFCLK, TXD3, 1, 0);
	$setuphold  (posedge REFCLK, TXD4, 1, 0);
	$setuphold  (posedge REFCLK, TXD5, 1, 0);
	$setuphold  (posedge REFCLK, TXD6, 1, 0);
	$setuphold  (posedge REFCLK, TXD7, 1, 0);
	$setuphold  (posedge REFCLK, TXD8, 1, 0);
	$setuphold  (posedge REFCLK, TXD9, 1, 0);
 
        (REFCLK => CSLOCK)    =   0:0:0, 0:0:0;
        (REFCLK => SOUT)      =   0:0:0, 0:0:0;
 
endspecify 


endmodule

`endcelldefine 

`timescale 1ns / 100ps
module SC_BRAM_16K (WEA,REA,WEB,REB,WADA,WDA,RADA,RDA,WADB,WDB,RADB,RDB);

	parameter  DEVICE_FAMILY = "SuperCool";
	parameter  MEM_INIT_FLAG = "";
	parameter  MEM_INIT_FILE = 0;
//	parameter  ADDR_WIDTH = 13; // 8K
//	parameter  DATA_WIDTH = 2;  // 2 bits

	parameter  WADDR_WIDTH_A = 14;
	parameter  RADDR_WIDTH_A = 12;
        parameter  WADDR_WIDTH_B = 14;
        parameter  RADDR_WIDTH_B = 12;
        parameter  WDATA_WIDTH_A = 1;
        parameter  RDATA_WIDTH_A = 4;
        parameter  WDATA_WIDTH_B = 1;
        parameter  RDATA_WIDTH_B = 4;
        parameter  ARRAY_SIZE = 16384;

	input WEA,REA,WEB,REB;
	input [WADDR_WIDTH_A -1:0] WADA;
	input [WDATA_WIDTH_A -1:0] WDA ;
	input [RADDR_WIDTH_A -1:0] RADA;
	output [RDATA_WIDTH_A -1:0] RDA ;
	input [WADDR_WIDTH_B -1:0] WADB;
	input [WDATA_WIDTH_B -1:0] WDB ;
	input [RADDR_WIDTH_B -1:0] RADB;
	output [RDATA_WIDTH_B -1:0] RDB ;

	wire WEA_node,REA_node,WEB_node,REB_node;
	wire [WADDR_WIDTH_A -1:0] WADA_node;
	wire [WDATA_WIDTH_A -1:0] WDA_node;
	wire [RADDR_WIDTH_A -1:0] RADA_node;
	reg  [RDATA_WIDTH_A -1:0] RDA_node;

	wire [WADDR_WIDTH_B -1:0] WADB_node;
	wire [WDATA_WIDTH_B -1:0] WDB_node;
	wire [RADDR_WIDTH_B -1:0] RADB_node;
	reg  [RDATA_WIDTH_B -1:0] RDB_node;

	assign  WADA_node = WADA;
	assign  WEA_node  = WEA;
	assign  WDA_node  = WDA;
	assign  RADA_node = RADA;
	assign  REA_node  = REA;
	assign  RDA       = RDA_node;
	 
	assign  WADB_node = WADB;
	assign  WEB_node  = WEB;
	assign  WDB_node  = WDB;
	assign  RADB_node = RADB;
	assign  REB_node  = REB;
	assign  RDB       = RDB_node;

	integer v_MEM[ARRAY_SIZE - 1:0];
	integer v_WADDR_A,v_RADDR_A,v_WADDR_B,v_RADDR_B;
	integer i,flag,flag1[3:0],j;
	integer bitval;
	reg [WDATA_WIDTH_A-1:0] VMEMTEMP[0:ARRAY_SIZE/WDATA_WIDTH_A-1];
	

	initial	begin
		for ( i = 0; i < RDATA_WIDTH_A ;i=i+1 )
			RDA_node[i] = 'bx;
		for ( i = 0; i < RDATA_WIDTH_B ;i=i+1 )
			RDB_node[i] = 'bx;
		for ( i = 0;i < ARRAY_SIZE ; i=i+1 )
			v_MEM[i] = 0;

		if( MEM_INIT_FLAG == 1 )
		begin
			for ( i = 0 ; i < ARRAY_SIZE/WDATA_WIDTH_A; i = i + 1)
				VMEMTEMP[i] = 'b0;

			$readmemb(MEM_INIT_FILE,VMEMTEMP,0,ARRAY_SIZE/WDATA_WIDTH_A-1);
			for ( i = 0; i < ARRAY_SIZE/WDATA_WIDTH_A; i = i + 1)
				for ( j = 0; j < WDATA_WIDTH_A; j = j + 1)
				begin
					bitval = (1'b1 << j);			
					v_MEM[i*WDATA_WIDTH_A+j] = (VMEMTEMP[i] & bitval)>>j;
				end
		end
	end
		
	always @(WADA_node or WEA_node or WDA_node or RADA_node or REA_node or WADB_node or WEB_node or WDB_node or RADB_node or REB_node)
	begin
		v_WADDR_A = WADA_node;
		v_WADDR_B = WADB_node;	
		v_RADDR_A = RADA_node;	
		v_RADDR_B = RADB_node;	

		flag = 0;

		if(v_WADDR_A * WDATA_WIDTH_A <= v_WADDR_B * WDATA_WIDTH_B &&
			(v_WADDR_A+1) * WDATA_WIDTH_A >= (v_WADDR_B+1) * WDATA_WIDTH_B)
			flag = 1;
		else if (v_WADDR_B * WDATA_WIDTH_B <= v_WADDR_A * WDATA_WIDTH_A &&
			(v_WADDR_B+1) * WDATA_WIDTH_B >= (v_WADDR_A+1) * WDATA_WIDTH_A)
			flag = 2;
		else if (v_WADDR_A * WDATA_WIDTH_A <= v_WADDR_B * WDATA_WIDTH_B &&
			(v_WADDR_B+1) * WDATA_WIDTH_B >= (v_WADDR_A+1) * WDATA_WIDTH_A &&
			(v_WADDR_A+1) * WDATA_WIDTH_A >= v_WADDR_B * WDATA_WIDTH_B)
			flag = 3;
		else if (v_WADDR_B * WDATA_WIDTH_B <= v_WADDR_A * WDATA_WIDTH_A &&
			(v_WADDR_A+1) * WDATA_WIDTH_A >= (v_WADDR_B+1) * WDATA_WIDTH_B &&
			(v_WADDR_B+1) * WDATA_WIDTH_B >= v_WADDR_A * WDATA_WIDTH_A)
			flag = 4;
			

		if (flag != 0 && WEA_node == 1 && WEB_node == 1)
		   begin
			$display ("\nsimulation time: ",$time);
			$display ("Write collision. Writing in the cross memory location using Port A and Port B will cause the memory content invalid.");
			$stop;
		   end

		for ( i = 0; i < 4 ; i = i + 1 )
			flag1[i] = 0;
		
		if (^WADA_node === 1'bx ) // if there is 'x' or 'z' in the bit of the bus.
			begin
//				$display ("\nsimulation time: ",$time);
//				$display ("Write address of port A is invalid.");
				flag1[0] = 1;
			end
		if (^WADB_node === 1'bx )
			begin
//				$display ("\nsimulation time: ",$time);
//				$display ("Write address of port B is invalid.");
				flag1[1] = 2;
			end
		if (^RADA_node === 1'bx )
			begin
				if (REA_node != 1)
					for ( i = 0; i < RDATA_WIDTH_A; i=i+1 )
						RDA_node[i] = 'bx;	
//				$display ("\nRead address of port A is invalid.");
				flag1[2] = 3;
			end
		if (^RADB_node === 1'bx )
			begin
				if (REB_node != 1)
					for ( i = 0; i < RDATA_WIDTH_B; i=i+1 )
						RDB_node[i] = 'bx;	
//				$display ("\nRead address of port B is invalid.");
				flag1[3] = 4;
			end


		if (WEA_node == 1)
			begin: signal1
				if(flag1[0] == 1)
					disable signal1;
`ifdef debug
				$display ("\nsimulation time: ",$time);
				$display ("Write to port A...");
				$display ("Writing address from %d -- %d",v_WADDR_A*WDATA_WIDTH_A,(v_WADDR_A+1)*WDATA_WIDTH_A-1);
`endif
				if (v_WADDR_A*WDATA_WIDTH_A > ARRAY_SIZE - WDATA_WIDTH_A)
					begin
						$display ("Fatal Error. Write address A exceeds the array boundary ");
						$stop;
					end

				for ( i = 0; i < WDATA_WIDTH_A; i=i+1 )
					begin
						v_MEM[v_WADDR_A*WDATA_WIDTH_A+i] = WDA_node[i];
`ifdef debug
						$display ("Write address is  %d",v_WADDR_A*WDATA_WIDTH_A+i);
						$display ("WDA_node[%d] = %b",i,WDA_node[i]);
`endif
					end
			end
`ifdef debug
		else
			begin
				$display ("\nsimulation time: ",$time);
				$display ("Write port A disabled");
			end
`endif

		if (WEB_node == 1)
			begin: signal2
				if(flag1[1] == 2)
					disable signal2;
`ifdef debug
				$display ("\nsimulation time: ",$time);
				$display ("Write to port B...");
				$display ("Writing address from %d -- %d",v_WADDR_B*WDATA_WIDTH_B,(v_WADDR_B+1)*WDATA_WIDTH_B-1);
`endif
				if (v_WADDR_B*WDATA_WIDTH_B > ARRAY_SIZE - WDATA_WIDTH_B)
					begin
						$display ("Fatal Error. Write address B exceeds the array boundary ");
						$stop;
					end

				for ( i = 0; i < WDATA_WIDTH_B; i=i+1 )
					begin
						v_MEM[v_WADDR_B*WDATA_WIDTH_B+i] = WDB_node[i];
`ifdef debug
						$display ("Write address is  %d",v_WADDR_B*WDATA_WIDTH_B+i);
						$display ("WDB_node[%d] = %b",i,WDB_node[i]);
`endif
					end
		end
`ifdef debug
		else
			begin
				$display ("\nsimulation time: ",$time);
				$display ("Write port B disabled");
			end
`endif

		if (REA_node == 1)
			begin: signal3
				if(flag1[2] == 3)
					disable signal3;
`ifdef debug
				$display ("\nsimulation time: ",$time);
				$display ("Read port A...");
				$display ("Reading address from %d -- %d",v_RADDR_A*RDATA_WIDTH_A,(v_RADDR_A+1)*RDATA_WIDTH_A-1);
`endif
				for ( i = 0; i < RDATA_WIDTH_A; i=i+1 )
					begin
						RDA_node[i] = v_MEM[v_RADDR_A*RDATA_WIDTH_A+i];		
`ifdef debug
						$display ("Read address is %d",v_RADDR_A*RDATA_WIDTH_A+i);
						$display ("RDA_node[%d] = %b",i,RDA_node[i]);
`endif
					end
			end
		else
			begin
`ifdef debug
				$display ("\nsimulation time: ",$time);
				$display ("Read Port A disabled.");
				$display ("Reading address from %d -- %d",v_RADDR_B*RDATA_WIDTH_B,(v_RADDR_B+1)*RDATA_WIDTH_B-1);
`endif
		//		for ( i = 0; i < RDATA_WIDTH_A; i=i+1 )
		//			RDA_node[i] = 'bx;	
			end


		if (REB_node == 1)
			begin: signal4
				if(flag1[3] == 4)
					disable signal4;
`ifdef debug
				$display ("\nsimulation time: ",$time);
				$display ("Read port B...");
`endif
				if (v_RADDR_A*RDATA_WIDTH_A > ARRAY_SIZE - WDATA_WIDTH_A)
					begin
						$display ("Fatal Error. Read address A exceeds the array boundary ");
						$stop;
					end

				for ( i = 0; i < RDATA_WIDTH_B; i=i+1 )
					begin
					RDB_node[i] = v_MEM[v_RADDR_B*RDATA_WIDTH_B+i];		
`ifdef debug
						$display ("Read address is %d",v_RADDR_B*RDATA_WIDTH_B+i);
						$display ("RDB_node[%d] = %b",i,RDB_node[i]);
`endif
					end
			end
		else
			begin
`ifdef debug
				$display ("\nsimulation time: ",$time);
				$display ("Read Port B disabled.");
`endif
				if (v_RADDR_B*RDATA_WIDTH_B > ARRAY_SIZE - WDATA_WIDTH_B)
					begin
						$display ("Fatal Error. Read address A exceeds the array boundary ");
						$stop;
					end

	//			for ( i = 0; i < RDATA_WIDTH_B; i=i+1 )
	//				RDB_node[i] = 'bx;
			end
						
	end

endmodule

`timescale 1ns / 100ps
module READ_POINTER_CTRL (GLOBAL_RST,RESET_RP,READ_EN,READ_CLK,EMPTY_FLAG,READ_POINTER,TERMINAL_COUNT); // 071102

	parameter RPOINTER_WIDTH = 9;

        input GLOBAL_RST;
        input RESET_RP;
        input READ_EN;
        input READ_CLK;
        input EMPTY_FLAG;
	input [RPOINTER_WIDTH -1:0] TERMINAL_COUNT;	// 071102
        output [RPOINTER_WIDTH -1:0] READ_POINTER;

	reg [RPOINTER_WIDTH -1:0] s_READ_POINTER;
	reg [RPOINTER_WIDTH -1:0] s_READ_POINTER_temp;	// 071102
	integer i;
	
	assign READ_POINTER = s_READ_POINTER;


	initial	begin
		s_READ_POINTER = TERMINAL_COUNT;
	end
	
	always @(GLOBAL_RST or RESET_RP)
	begin
		if (GLOBAL_RST == 1 || RESET_RP == 1)
//			assign s_READ_POINTER = 'b0;		// 071102
			assign s_READ_POINTER = TERMINAL_COUNT;	// 071102
		else
			deassign s_READ_POINTER;
	end
	
	always @(posedge READ_CLK)
	begin

		if (READ_EN == 1 && EMPTY_FLAG != 0)
			s_READ_POINTER = s_READ_POINTER + 1;

		s_READ_POINTER_temp = TERMINAL_COUNT + 1;	// 071102
		if (s_READ_POINTER == s_READ_POINTER_temp)	// 071102
		   s_READ_POINTER = 'b0;			// 071102
	end

endmodule
`timescale 1ns / 100ps
module WRITE_POINTER_CTRL (GLOBAL_RST,WRITE_EN,WRITE_CLK,FULL_FLAG,WRITE_POINTER,TERMINAL_COUNT); // 071102

	parameter WPOINTER_WIDTH = 9;
	parameter WDATA_WIDTH = 32;

	input GLOBAL_RST;
	input WRITE_EN;
	input WRITE_CLK;
	input FULL_FLAG;
	input [WPOINTER_WIDTH -1:0] TERMINAL_COUNT; // 071102
	output [WPOINTER_WIDTH -1:0] WRITE_POINTER;

	reg [WPOINTER_WIDTH -1:0] s_WRITE_POINTER;
	reg [WPOINTER_WIDTH -1:0] s_WRITE_POINTER_temp; // 071102


	assign WRITE_POINTER = s_WRITE_POINTER;

	initial	begin
		s_WRITE_POINTER = TERMINAL_COUNT;
	end
	
	always @(GLOBAL_RST)
	begin
		if (GLOBAL_RST == 1)
//			assign s_WRITE_POINTER = 0;		// 071102
			assign s_WRITE_POINTER = TERMINAL_COUNT; // 071102
		else
			deassign s_WRITE_POINTER;
	end

	always @(posedge WRITE_CLK)
	begin
		if (WRITE_EN == 1 && FULL_FLAG != 1)
			s_WRITE_POINTER = s_WRITE_POINTER + 1;

		s_WRITE_POINTER_temp = 	TERMINAL_COUNT + 1; // 071102
		if(s_WRITE_POINTER == s_WRITE_POINTER_temp) // 071102
			s_WRITE_POINTER = 'b0; // 071102
	end

endmodule
`timescale 1ns / 100ps
//module FLAG_LOGIC (R_POINTER,W_POINTER,GLOBAL_RST,READ_EN,READ_CLK,WRITE_EN,WRITE_CLK,FULL_D,EMPTY_D,AMFULL_D,AMEMPTY_D);
module FLAG_LOGIC (R_POINTER,W_POINTER,FULL_D,EMPTY_D,AMFULL_D,AMEMPTY_D,TERMINAL_COUNT); // 071102
	parameter POINTER_WIDTH = 9;
	parameter DATA_WIDTH = 32;
	parameter AMFULL_X = 1;
	parameter AMEMPTY_Y = 1;

	input	[POINTER_WIDTH -1:0] R_POINTER;
	input	[POINTER_WIDTH -1:0] W_POINTER;
	input   [POINTER_WIDTH -1:0] TERMINAL_COUNT; // 071102
/*
	input	GLOBAL_RST;
        input	READ_EN;
        input  	READ_CLK;
        input   WRITE_EN;
        input	WRITE_CLK; 
*/
        output  FULL_D;
	output  EMPTY_D;
        output  AMFULL_D;
	output  AMEMPTY_D;
	
        reg   FULL_D;
	reg   EMPTY_D;
        reg   AMFULL_D;
	reg   AMEMPTY_D;

	reg	[POINTER_WIDTH -1:0] R_POINTER_temp;
	reg	[POINTER_WIDTH -1:0] R_POINTER_temp1;
	reg	[POINTER_WIDTH -1:0] W_POINTER_temp;
	reg	[POINTER_WIDTH -1:0] W_POINTER_temp1;

	reg	[POINTER_WIDTH -1:0] TERMINAL_OFFSET; // 071102
/*
	always @(GLOBAL_RST)
	begin
		if (GLOBAL_RST == 1)
			begin
				assign FULL_D = 0;
				assign AMFULL_D = 0;
				assign EMPTY_D = 0;
				assign AMEMPTY_D = 0;
			end
		else
			begin
				deassign FULL_D;
				deassign AMFULL_D;
				deassign EMPTY_D;
				deassign AMEMPTY_D;
			end
	end
*/
	
	initial begin
//			TERMINAL_OFFSET = ~TERMINAL_COUNT; // 	Modufy for TERMINAL_COUNT != 111111111 // 071102
			FULL_D = 0;
			AMFULL_D = 0;
			EMPTY_D = 0;
			AMEMPTY_D = 0;
//			RAdder = 0;
//			WAdder = 0;
	end
	
	always @(R_POINTER or W_POINTER)
	begin
		

		TERMINAL_OFFSET = ~TERMINAL_COUNT;
		R_POINTER_temp = R_POINTER;
		R_POINTER_temp1 = R_POINTER + AMEMPTY_Y;
		W_POINTER_temp = W_POINTER + 1;
		W_POINTER_temp1 = W_POINTER + AMFULL_X + 1;

/********************************************************************************************************************
		Modufy for TERMINAL_COUNT != 111111111 // 071102
********************************************************************************************************************/
		if(R_POINTER_temp > TERMINAL_COUNT) // 071102
			R_POINTER_temp = R_POINTER_temp + TERMINAL_OFFSET; // 071102

		if(R_POINTER_temp1 > TERMINAL_COUNT) // 071102
			R_POINTER_temp1 = R_POINTER_temp1 + TERMINAL_OFFSET; // 071102

		if(W_POINTER_temp > TERMINAL_COUNT) // 071102
			W_POINTER_temp = W_POINTER_temp + TERMINAL_OFFSET; // 071102
		
		if(W_POINTER_temp1 > TERMINAL_COUNT) // 071102
			W_POINTER_temp1 = W_POINTER_temp1 + TERMINAL_OFFSET; // 071102
		

		if (R_POINTER == W_POINTER_temp)
			FULL_D = 1;
		else
			FULL_D = 0;

		if (W_POINTER_temp1 >= R_POINTER && W_POINTER < R_POINTER)
			AMFULL_D = 1;
		else if(W_POINTER_temp1 < W_POINTER && W_POINTER < R_POINTER) // xfei
			AMFULL_D = 1;
		else if(W_POINTER > R_POINTER && W_POINTER_temp1 >= R_POINTER && W_POINTER_temp1 < W_POINTER)
			AMFULL_D = 1;
		else
			AMFULL_D = 0; 	

		

		if (R_POINTER_temp  == W_POINTER)
			EMPTY_D = 0;
		else
			EMPTY_D = 1;

		if (R_POINTER_temp1 >= W_POINTER && R_POINTER < W_POINTER)
			AMEMPTY_D = 0;
		else if(R_POINTER_temp1 < R_POINTER && R_POINTER < W_POINTER) // xfei
			AMEMPTY_D = 0;
		else if(R_POINTER > W_POINTER && R_POINTER_temp1 >= W_POINTER && R_POINTER_temp1 < R_POINTER)
			AMEMPTY_D = 0;
		else if(R_POINTER == W_POINTER)
			AMEMPTY_D = 0;
		else
			AMEMPTY_D = 1;
	end
endmodule
`timescale 1ns / 100ps
module SC_FIFO_16K (WE,WCLK,RST,RPRST,RE,RCLK,FULLIN,EMPTYIN,DI,FULL,EMPTY,AMFULL,AMEMPTY,DO);
	parameter DEVICE_FAMILY = "SuperCool";
	parameter TERMINAL_COUNT = 511; // 071102
	parameter ADDR_WIDTH = 9;
	parameter DATA_WIDTH = 32;
	parameter ALMOST_FULL_X = 1;
	parameter ALMOST_EMPTY_Y = 1;

	input WE;
	input WCLK;
	input RST;
	input RPRST;
	input RE;
	input RCLK;
	input FULLIN;
	input EMPTYIN;
	input [DATA_WIDTH -1:0] DI;

	output FULL;
	output EMPTY;
	output AMFULL;
	output AMEMPTY;
	output [DATA_WIDTH -1:0] DO;

	wire WE_node;
	wire WCLK_node;
	wire RST_node;
	wire RPRST_node;
	wire RE_node;
	wire RCLK_node;
	wire FULLIN_node;
	wire EMPTYIN_node;
	wire [DATA_WIDTH -1:0] DI_node;

	reg  [DATA_WIDTH -1:0] DI_reg;
	reg  FULLIN_reg;
	reg  EMPTYIN_reg;

	wire FULL_node;
	wire EMPTY_node;
	wire AMFULL_node;
	wire AMEMPTY_node;
	wire [DATA_WIDTH -1:0] DO_node;

	reg  FULL_reg;
	reg  EMPTY_reg;
	reg  AMFULL_reg;
	reg  AMEMPTY_reg;
	reg  WE_reg;	// 071102
	reg  RE_reg;	// 071102
	reg  [ADDR_WIDTH - 1 : 0] TC_node; // 071102

	wire [ADDR_WIDTH -1:0] RP_node;
	wire [ADDR_WIDTH -1:0] WP_node;
	
	assign WE_node = WE;
	assign WCLK_node = WCLK;
	assign RST_node = RST;
	assign RPRST_node = RPRST;
	assign RE_node = RE;
	assign RCLK_node = RCLK;
	assign FULLIN_node = FULLIN;
	assign EMPTYIN_node = EMPTYIN;
	assign DI_node = DI;

	assign FULL = FULL_reg;
	assign AMFULL = AMFULL_reg;
	assign EMPTY = EMPTY_reg;
	assign AMEMPTY = AMEMPTY_reg;
	  
	assign DO = DO_node;    


	initial begin 
		TC_node = TERMINAL_COUNT;  // 071102
	end
	
	always @(RST_node)
	begin
		if (RST_node == 1)
			begin
				assign DI_reg = 'b0;
				assign FULLIN_reg = 1'b0;
				assign EMPTYIN_reg = 1'b0;
				assign FULL_reg = 'b0;
				assign AMFULL_reg = 'b0;
				assign EMPTY_reg = 'b0;
				assign AMEMPTY_reg = 'b0;
				assign WE_reg = 'b0; // 071102
				assign RE_reg = 'b0; // 071102
			end
		else
			begin
				deassign DI_reg;
				deassign FULLIN_reg;
				deassign EMPTYIN_reg;
				deassign FULL_reg;
				deassign AMFULL_reg;
				deassign EMPTY_reg;
				deassign AMEMPTY_reg;
				deassign WE_reg; // 071102
				deassign RE_reg; // 071102
			end
	end
		
	always @(posedge WCLK_node)
	begin
		DI_reg = DI_node;
		FULLIN_reg = FULLIN_node;
		FULL_reg = FULL_node;
		AMFULL_reg = AMFULL_node;
		WE_reg = WE_node; // 071102
	end

	always @(posedge RCLK_node)
	begin
		EMPTYIN_reg = EMPTYIN_node;
		EMPTY_reg = EMPTY_node;
		AMEMPTY_reg = AMEMPTY_node;
		RE_reg = RE_node; // 071102
	end

	READ_POINTER_CTRL FIFO_RPC_INST(.GLOBAL_RST(RST_node),.RESET_RP(RPRST_node),
	.READ_EN(RE_node),.READ_CLK(RCLK_node),.EMPTY_FLAG(EMPTY_node),.READ_POINTER(RP_node),.TERMINAL_COUNT(TC_node)); // 071102
	defparam FIFO_RPC_INST.RPOINTER_WIDTH = ADDR_WIDTH;

	WRITE_POINTER_CTRL FIFO_WPC_INST(.GLOBAL_RST(RST_node),.WRITE_EN(WE_node),
	.WRITE_CLK(WCLK_node),.FULL_FLAG(FULL_node),.WRITE_POINTER(WP_node),.TERMINAL_COUNT(TC_node)); // 071102
	defparam FIFO_WPC_INST.WPOINTER_WIDTH = ADDR_WIDTH;
	defparam FIFO_WPC_INST.WDATA_WIDTH = DATA_WIDTH;

/*
	FLAG_LOGIC FIFO_FL_INST(.R_POINTER(RP_node),.W_POINTER(WP_node),.GLOBAL_RST(RST_node),
	.READ_EN(RE_node),.READ_CLK(RCLK_node),.WRITE_EN(WE_node),.WRITE_CLK(WCLK_node),
	.FULL_D(FULL_reg),.EMPTY_D(EMPTY_reg),.AMFULL_D(AMFULL_reg),.AMEMPTY_D(AMEMPTY_reg));
*/
	FLAG_LOGIC FIFO_FL_INST(.R_POINTER(RP_node),.W_POINTER(WP_node),
	.FULL_D(FULL_node),.EMPTY_D(EMPTY_node),.AMFULL_D(AMFULL_node),.AMEMPTY_D(AMEMPTY_node),.TERMINAL_COUNT(TC_node)); // 071102

	defparam FIFO_FL_INST.POINTER_WIDTH = ADDR_WIDTH;
	defparam FIFO_FL_INST.DATA_WIDTH = DATA_WIDTH;
	defparam FIFO_FL_INST.AMFULL_X = ALMOST_FULL_X;
	defparam FIFO_FL_INST.AMEMPTY_Y = ALMOST_EMPTY_Y;

	SC_BRAM_16K FIFO_BRAM_INST(.WADA(WP_node),.WEA(WE_reg),.WDA(DI_reg),.RADA(RP_node),.REA(RE_reg), // 071102
	.RDA(DO_node),.WADB(WP_node),.WEB(1'b0),.WDB(DI_reg),.RADB(RP_node),.REB(1'b0),.RDB()); 
	defparam FIFO_BRAM_INST.WADDR_WIDTH_A  = ADDR_WIDTH;
	defparam FIFO_BRAM_INST.RADDR_WIDTH_A  = ADDR_WIDTH;
	defparam FIFO_BRAM_INST.WADDR_WIDTH_B  = ADDR_WIDTH;
	defparam FIFO_BRAM_INST.RADDR_WIDTH_B  = ADDR_WIDTH;
	defparam FIFO_BRAM_INST.WDATA_WIDTH_A  = DATA_WIDTH;
	defparam FIFO_BRAM_INST.RDATA_WIDTH_A  = DATA_WIDTH;
	defparam FIFO_BRAM_INST.WDATA_WIDTH_B  = DATA_WIDTH;
	defparam FIFO_BRAM_INST.RDATA_WIDTH_B  = DATA_WIDTH;
	defparam FIFO_BRAM_INST.MEM_INIT_FILE = "";
	defparam FIFO_BRAM_INST.MEM_INIT_FLAG = 0;

endmodule`celldefine
module FIFO15X10A(WE,WCLK,RE,RCLK,RST,
                  DI0,DI1,DI2,DI3,DI4,DI5,DI6,DI7,DI8,DI9,
                  DO0,DO1,DO2,DO3,DO4,DO5,DO6,DO7,DO8,DO9,
                  FULL,EMPTY,START_RD
);

parameter FIFO_FULL_FLAG = 15;
parameter FIFO_AMFULL_FLAG = 6;

input  WE,WCLK,RE,RCLK,RST;
input  DI0,DI1,DI2,DI3,DI4,DI5,DI6,DI7,DI8,DI9;
output DO0,DO1,DO2,DO3,DO4,DO5,DO6,DO7,DO8,DO9;
output FULL,EMPTY,START_RD;

wire [9:0] di;
wire [9:0] do;

wire FULL_sig, EMPTY_sig, START_RD_sig, WCLK_sig, AMFULL, RST_sig;
wire RPRST, FULLIN, EMPTYIN;

reg notifier;

assign START_RD_sig = ~AMFULL;
assign RST_sig = RST;
assign WCLK_sig = ~WCLK;
assign RPRST = 0;
assign FULLIN = 0;
assign EMPTYIN = 0;

buf INSXQ10 (FULL,FULL_sig);
buf INSXQ11 (EMPTY,EMPTY_sig);
buf INSXQ12 (START_RD,START_RD_sig);
assign di = {DI9,DI8,DI7,DI6,DI5,DI4,DI3,DI2,DI1,DI0};
//assign {DO9,DO8,DO7,DO6,DO5,DO4,DO3,DO2,DO1,DO0} = do;
buf INSXQ0 (DO0,do[0]);
buf INSXQ1 (DO1,do[1]);
buf INSXQ2 (DO2,do[2]);
buf INSXQ3 (DO3,do[3]);
buf INSXQ4 (DO4,do[4]);
buf INSXQ5 (DO5,do[5]);
buf INSXQ6 (DO6,do[6]);
buf INSXQ7 (DO7,do[7]);
buf INSXQ8 (DO8,do[8]);
buf INSXQ9 (DO9,do[9]);
defparam FIFO_U0.ADDR_WIDTH = 4;
defparam FIFO_U0.DATA_WIDTH = 10;
defparam FIFO_U0.TERMINAL_COUNT = FIFO_FULL_FLAG;
defparam FIFO_U0.ALMOST_FULL_X = FIFO_AMFULL_FLAG;

SC_FIFO_16K FIFO_U0(
		.WE(WE),
		.WCLK(WCLK_sig),
		.RST(RST_sig),
		.RPRST(RPRST),
		.RE(RE),
		.RCLK(RCLK),
		.FULLIN(FULLIN),
		.EMPTYIN(EMPTYIN),
		.DI(di),
		.FULL(FULL_sig),
		.EMPTY(EMPTY_sig),
		.AMFULL(AMFULL),
		.AMEMPTY(NC),
		.DO(do));

specify
	$width (posedge WCLK, 1, 0, notifier);
	$width (posedge RCLK, 1, 0, notifier);

	$width (posedge RST, 1, 0, notifier);

	$setuphold  (posedge WCLK, DI0, 1, 0);
	$setuphold  (posedge WCLK, DI1, 1, 0);
	$setuphold  (posedge WCLK, DI2, 1, 0);
	$setuphold  (posedge WCLK, DI3, 1, 0);
	$setuphold  (posedge WCLK, DI4, 1, 0);
	$setuphold  (posedge WCLK, DI5, 1, 0);
	$setuphold  (posedge WCLK, DI6, 1, 0);
	$setuphold  (posedge WCLK, DI7, 1, 0);
	$setuphold  (posedge WCLK, DI8, 1, 0);
	$setuphold  (posedge WCLK, DI9, 1, 0);

	$setuphold  (posedge WCLK, WE, 1, 0);
	$setuphold  (posedge RCLK, RE, 1, 0);

        $recovery(posedge RST, posedge RCLK, 1); 

	(RCLK => DO0)    = (0:0:0, 0:0:0);
	(RCLK => DO1)    = (0:0:0, 0:0:0);
	(RCLK => DO2)    = (0:0:0, 0:0:0);
	(RCLK => DO3)    = (0:0:0, 0:0:0);
	(RCLK => DO4)    = (0:0:0, 0:0:0);
	(RCLK => DO5)    = (0:0:0, 0:0:0);
	(RCLK => DO6)    = (0:0:0, 0:0:0);
	(RCLK => DO7)    = (0:0:0, 0:0:0);
	(RCLK => DO8)    = (0:0:0, 0:0:0);
	(RCLK => DO9)    = (0:0:0, 0:0:0);

	(WCLK => FULL)   = (0:0:0, 0:0:0);
	(WCLK => START_RD) = (0:0:0, 0:0:0);

	(RCLK => EMPTY)   = (0:0:0, 0:0:0);

	(RST  => DO0)    = (0:0:0, 0:0:0);
	(RST  => DO1)    = (0:0:0, 0:0:0);
	(RST  => DO2)    = (0:0:0, 0:0:0);
	(RST  => DO3)    = (0:0:0, 0:0:0);
	(RST  => DO4)    = (0:0:0, 0:0:0);
	(RST  => DO5)    = (0:0:0, 0:0:0);
	(RST  => DO6)    = (0:0:0, 0:0:0);
	(RST  => DO7)    = (0:0:0, 0:0:0);
	(RST  => DO8)    = (0:0:0, 0:0:0);
	(RST  => DO9)    = (0:0:0, 0:0:0);

	(RST => FULL)    = (0:0:0, 0:0:0);
	(RST => EMPTY)   = (0:0:0, 0:0:0);
	(RST => START_RD)   = (0:0:0, 0:0:0);

        (DI0 => DO0) = (0:0:0, 0:0:0);
        (DI1 => DO0) = (0:0:0, 0:0:0);
        (DI2 => DO0) = (0:0:0, 0:0:0);
        (DI3 => DO0) = (0:0:0, 0:0:0);
        (DI4 => DO0) = (0:0:0, 0:0:0);
        (DI5 => DO0) = (0:0:0, 0:0:0);
        (DI6 => DO0) = (0:0:0, 0:0:0);
        (DI7 => DO0) = (0:0:0, 0:0:0);
        (DI8 => DO0) = (0:0:0, 0:0:0);
        (DI9 => DO0) = (0:0:0, 0:0:0);

        (DI0 => DO1) = (0:0:0, 0:0:0);
        (DI1 => DO1) = (0:0:0, 0:0:0);
        (DI2 => DO1) = (0:0:0, 0:0:0);
        (DI3 => DO1) = (0:0:0, 0:0:0);
        (DI4 => DO1) = (0:0:0, 0:0:0);
        (DI5 => DO1) = (0:0:0, 0:0:0);
        (DI6 => DO1) = (0:0:0, 0:0:0);
        (DI7 => DO1) = (0:0:0, 0:0:0);
        (DI8 => DO1) = (0:0:0, 0:0:0);
        (DI9 => DO1) = (0:0:0, 0:0:0);

        (DI0 => DO2) = (0:0:0, 0:0:0);
        (DI1 => DO2) = (0:0:0, 0:0:0);
        (DI2 => DO2) = (0:0:0, 0:0:0);
        (DI3 => DO2) = (0:0:0, 0:0:0);
        (DI4 => DO2) = (0:0:0, 0:0:0);
        (DI5 => DO2) = (0:0:0, 0:0:0);
        (DI6 => DO2) = (0:0:0, 0:0:0);
        (DI7 => DO2) = (0:0:0, 0:0:0);
        (DI8 => DO2) = (0:0:0, 0:0:0);
        (DI9 => DO2) = (0:0:0, 0:0:0);

        (DI0 => DO3) = (0:0:0, 0:0:0);
        (DI1 => DO3) = (0:0:0, 0:0:0);
        (DI2 => DO3) = (0:0:0, 0:0:0);
        (DI3 => DO3) = (0:0:0, 0:0:0);
        (DI4 => DO3) = (0:0:0, 0:0:0);
        (DI5 => DO3) = (0:0:0, 0:0:0);
        (DI6 => DO3) = (0:0:0, 0:0:0);
        (DI7 => DO3) = (0:0:0, 0:0:0);
        (DI8 => DO3) = (0:0:0, 0:0:0);
        (DI9 => DO3) = (0:0:0, 0:0:0);

        (DI0 => DO4) = (0:0:0, 0:0:0);
        (DI1 => DO4) = (0:0:0, 0:0:0);
        (DI2 => DO4) = (0:0:0, 0:0:0);
        (DI3 => DO4) = (0:0:0, 0:0:0);
        (DI4 => DO4) = (0:0:0, 0:0:0);
        (DI5 => DO4) = (0:0:0, 0:0:0);
        (DI6 => DO4) = (0:0:0, 0:0:0);
        (DI7 => DO4) = (0:0:0, 0:0:0);
        (DI8 => DO4) = (0:0:0, 0:0:0);
        (DI9 => DO4) = (0:0:0, 0:0:0);

        (DI0 => DO5) = (0:0:0, 0:0:0);
        (DI1 => DO5) = (0:0:0, 0:0:0);
        (DI2 => DO5) = (0:0:0, 0:0:0);
        (DI3 => DO5) = (0:0:0, 0:0:0);
        (DI4 => DO5) = (0:0:0, 0:0:0);
        (DI5 => DO5) = (0:0:0, 0:0:0);
        (DI6 => DO5) = (0:0:0, 0:0:0);
        (DI7 => DO5) = (0:0:0, 0:0:0);
        (DI8 => DO5) = (0:0:0, 0:0:0);
        (DI9 => DO5) = (0:0:0, 0:0:0);

        (DI0 => DO6) = (0:0:0, 0:0:0);
        (DI1 => DO6) = (0:0:0, 0:0:0);
        (DI2 => DO6) = (0:0:0, 0:0:0);
        (DI3 => DO6) = (0:0:0, 0:0:0);
        (DI4 => DO6) = (0:0:0, 0:0:0);
        (DI5 => DO6) = (0:0:0, 0:0:0);
        (DI6 => DO6) = (0:0:0, 0:0:0);
        (DI7 => DO6) = (0:0:0, 0:0:0);
        (DI8 => DO6) = (0:0:0, 0:0:0);
        (DI9 => DO6) = (0:0:0, 0:0:0);

        (DI0 => DO7) = (0:0:0, 0:0:0);
        (DI1 => DO7) = (0:0:0, 0:0:0);
        (DI2 => DO7) = (0:0:0, 0:0:0);
        (DI3 => DO7) = (0:0:0, 0:0:0);
        (DI4 => DO7) = (0:0:0, 0:0:0);
        (DI5 => DO7) = (0:0:0, 0:0:0);
        (DI6 => DO7) = (0:0:0, 0:0:0);
        (DI7 => DO7) = (0:0:0, 0:0:0);
        (DI8 => DO7) = (0:0:0, 0:0:0);
        (DI9 => DO7) = (0:0:0, 0:0:0);

        (DI0 => DO8) = (0:0:0, 0:0:0);
        (DI1 => DO8) = (0:0:0, 0:0:0);
        (DI2 => DO8) = (0:0:0, 0:0:0);
        (DI3 => DO8) = (0:0:0, 0:0:0);
        (DI4 => DO8) = (0:0:0, 0:0:0);
        (DI5 => DO8) = (0:0:0, 0:0:0);
        (DI6 => DO8) = (0:0:0, 0:0:0);
        (DI7 => DO8) = (0:0:0, 0:0:0);
        (DI8 => DO8) = (0:0:0, 0:0:0);
        (DI9 => DO8) = (0:0:0, 0:0:0);

        (DI0 => DO9) = (0:0:0, 0:0:0);
        (DI1 => DO9) = (0:0:0, 0:0:0);
        (DI2 => DO9) = (0:0:0, 0:0:0);
        (DI3 => DO9) = (0:0:0, 0:0:0);
        (DI4 => DO9) = (0:0:0, 0:0:0);
        (DI5 => DO9) = (0:0:0, 0:0:0);
        (DI6 => DO9) = (0:0:0, 0:0:0);
        (DI7 => DO9) = (0:0:0, 0:0:0);
        (DI8 => DO9) = (0:0:0, 0:0:0);
        (DI9 => DO9) = (0:0:0, 0:0:0);

endspecify
endmodule
`endcelldefine

 
primitive  MACH_DFF(Q,D,CLK,R,S,NOTIFIER);
output Q;
reg Q;
input CLK,
      D,
      R,S,
      NOTIFIER;

// FUNCTION : POSITIVE EDGE TRIGGERED D-FLIP FLOP WITH ACTIVE LOW 
//              ASYNCHRONOUS SET AND CLEAR
 table
//D      CLK     R   S   NOTIFIER      Q(t)    Q(t+1)
       
  1      (01)    1   ?      ?       :   ?   :   1;  // clocked data
  0      (01)    ?   1      ?       :   ?   :   0;  // clocked data

  1       ?      1   *      ?       :   1   :   1;  // pessimism
  ?       0      1   *      ?       :   1   :   1;  // pessimism
  ?       1      1   *      ?       :   1   :   1;  // pessimism
  1       ?      0   (10)      ?       :   0   :   x;  // pessimism
  ?       0      0   (10)      ?       :   0   :   x;  // pessimism
  ?       1      0   (10)      ?       :   0   :   x;  // pessimism

  0       ?      *   1      ?       :   0   :   0;  // pessimism
  ?       0      *   1      ?       :   0   :   0;  // pessimism
  ?       1      *   1      ?       :   0   :   0;  // pessimism
  0       ?      (10)   0      ?       :   1   :   x;  // pessimism
  ?       0      (10)   0      ?       :   1   :   x;  // pessimism
  ?       1      (10)   0      ?       :   1   :   x;  // pessimism

  1       p      1   1      ?       :   1   :   1;  // reducing pessimism
  0       p      1   1      ?       :   0   :   0;
 
  ?       ?      0   1      ?       :   ?   :   0;  // asynchronous clear
  ?       ?      1   0      ?       :   ?   :   1;  // asynchronous set

  ?      (?0)    ?   ?      ?       :   ?   :   -;  // ignore falling clock
  0      (?x)    ?   ?      ?       :   0   :   -;  // retain state when D == Qt
  1      (?x)    ?   ?      ?       :   1   :   -;  // retain state when D == Qt
  *       1      ?   ?      ?       :   ?   :   -;  // ignore data edges
  *       0      ?   ?      ?       :   ?   :   -;  // ignore data edges
  ?       ?      ?   ?      *       :   ?   :   -;
 
endtable
endprimitive
primitive  MACH_DFF_CE(Q,D,CLK,R,S,CE,NOTIFIER);
output Q;
reg Q;
input CLK,
      D,
      R,S,
      CE,  //clock enable active high
      NOTIFIER;

// FUNCTION : POSITIVE EDGE TRIGGERED D-FLIP FLOP WITH ACTIVE HIGH CLOCK ENABLE 
//              AND ACTIVE LOW ASYNCHRONOUS SET AND RESET

 table
//D      CLK     R   S   CE   NOTIFIER      Q(t)    Q(t+1)
       
  1      (01)    1   ?   1       ?       :   ?   :   1;  // clocked data
  0      (01)    ?   1   1       ?       :   ?   :   0;  // clocked data

  1       ?      1   *   1       ?       :   1   :   1;  // pessimism
  ?       0      1   *   1       ?       :   1   :   1;  // pessimism
  ?       1      1   *   1       ?       :   1   :   1;  // pessimism

  0       ?      *   1   1       ?       :   0   :   0;  // pessimism
  ?       0      *   1   1       ?       :   0   :   0;  // pessimism
  ?       1      *   1   1       ?       :   0   :   0;  // pessimism

  1       p      1   1   1       ?       :   1   :   1;  // reducing pessimism
  0       p      1   1   1       ?       :   0   :   0;
 
  ?       ?      0   1   ?       ?       :   ?   :   0;  // asynchronous clear
  ?       ?      1   0   ?       ?       :   ?   :   1;  // asynchronous set

//  ?      (?0)    ?   ?   1       ?       :   ?   :   -;  // ignore falling clock
//  0      (?x)    ?   ?   1       ?       :   0   :   -;  // retain state when D == Qt
//  1      (?x)    ?   ?   1       ?       :   1   :   -;  // retain state when D == Qt
//  *       1      ?   ?   1       ?       :   ?   :   -;  // ignore data edges
//  *       0      ?   ?   1       ?       :   ?   :   -;  // ignore data edges

  ?      (?0)    ?   ?   ?       ?       :   ?   :   -;  // ignore falling clock
  0      (?x)    ?   ?   ?       ?       :   0   :   -;  // retain state when D == Qt
  1      (?x)    ?   ?   ?       ?       :   1   :   -;  // retain state when D == Qt
  *       1      ?   ?   ?       ?       :   ?   :   -;  // ignore data edges
  *       0      ?   ?   ?       ?       :   ?   :   -;  // ignore data edges

  ?       ?      1   1   0       ?       :   ?   :   -;
  ?	  ?      ?   ?   ?       *       :   ?   :   -;
  ?       ?      1   1   *       ?       :   ?   :   -; 
endtable
endprimitive
primitive  MACH_DFF_CE_X(Q,D,CLK,R,S,CE,NOTIFIER);
output Q;
reg Q;
input CLK, D, R,S, CE, NOTIFIER;  //clock enable active high

// FUNCTION : POSITIVE EDGE TRIGGERED D-FLIP FLOP WITH ACTIVE HIGH CLOCK ENABLE 
//              AND ACTIVE LOW ASYNCHRONOUS SET AND RESET

 table
//D      CLK     R   S   CE   NOTIFIER Q(t)    Q(t+1)
       
  1      (01)    1   ?   1      ?:   ?   :   1;  // clocked data
  0      (01)    ?   1   1      ?:   ?   :   0;  // clocked data

  1       ?      1   *   1      ?:   1   :   1;  // pessimism
  ?       0      1   *   1      ?:   1   :   1;  // pessimism
  ?       1      1   *   1      ?:   1   :   1;  // pessimism

  
  0       ?      *   1   1      ?:   0   :   0;  // pessimism
  ?       0      *   1   1      ?:   0   :   0;  // pessimism
  ?       1      *   1   1      ?:   0   :   0;  // pessimism

  1       p      1   1   1      ?:   1   :   1;  // reducing pessimism
  0       p      1   1   1      ?:   0   :   0;
 
  ?       ?      0   1   ?      ?:   ?   :   0;  // asynchronous clear
  ?       ?      1   0   ?      ?:   ?   :   1;  // asynchronous set

//  ?      (?0)    ?   ?   1      ?:   ?   :   -;  // ignore falling clock
//  0      (?x)    ?   ?   1      ?:   0   :   -;  // retain state when D == Qt
//  1      (?x)    ?   ?   1      ?:   1   :   -;  // retain state when D == Qt
//  *       1      ?   ?   1      ?:   ?   :   -;  // ignore data edges
//  *       0      ?   ?   1      ?:   ?   :   -;  // ignore data edges

  ?      (?0)    ?   ?   ?       ?       :   ?   :   -;  // ignore falling clock
  0      (?x)    ?   ?   ?       ?       :   0   :   -;  // retain state when D == Qt
  1      (?x)    ?   ?   ?       ?       :   1   :   -;  // retain state when D == Qt
  *       1      ?   ?   ?       ?       :   ?   :   -;  // ignore data edges
  *       0      ?   ?   ?       ?       :   ?   :   -;  // ignore data edges

  ?       ?      1   1   0      ?:   ?   :   -;
  ?       ?      ?   ?   ?      *:   ?   :   x;
  ?       ?      1   1   *      ?:   ?   :   -; 
 
endtable
endprimitive
primitive  MACH_DFF_X (Q,D,CLK,R,S,NOTIFIER);
output Q;
reg Q;
input D, CLK, R,S, NOTIFIER;

// FUNCTION : POSITIVE EDGE TRIGGERED D-FLIP FLOP WITH ACTIVE LOW 
//              ASYNCHRONOUS SET AND CLEAR
 table
//D      CLK     R   S   NOTIFIER      Q(t)    Q(t+1)
       
  1      (01)    1   ?      ?       :   ?   :   1;  // clocked data
  0      (01)    ?   1      ?       :   ?   :   0;  // clocked data

  1       ?      1   *      ?       :   1   :   1;  // pessimism
  ?       0      1   *      ?       :   1   :   1;  // pessimism
  ?       1      1   *      ?       :   1   :   1;  // pessimism
  1       ?      0   *      ?       :   0   :   0;  // pessimism
  ?       0      0   *      ?       :   0   :   0;  // pessimism
  ?       1      0   *      ?       :   0   :   0;  // pessimism

  0       ?      *   1      ?       :   0   :   0;  // pessimism
  ?       0      *   1      ?       :   0   :   0;  // pessimism
  ?       1      *   1      ?       :   0   :   0;  // pessimism
  0       ?      *   0      ?       :   1   :   1;  // pessimism
  ?       0      *   0      ?       :   1   :   1;  // pessimism
  ?       1      *   0      ?       :   1   :   1;  // pessimism

  1       p      1   1      ?       :   1   :   1;  // reducing pessimism
  0       p      1   1      ?       :   0   :   0;
 
  ?       ?      0   1      ?       :   ?   :   0;  // asynchronous clear
  ?       ?      1   0      ?       :   ?   :   1;  // asynchronous set

  ?      (?0)    ?   ?      ?       :   ?   :   -;  // ignore falling clock
  0      (?x)    ?   ?      ?       :   0   :   -;  // retain state when D == Qt
  1      (?x)    ?   ?      ?       :   1   :   -;  // retain state when D == Qt
  *       1      ?   ?      ?       :   ?   :   -;  // ignore data edges
  *       0      ?   ?      ?       :   ?   :   -;  // ignore data edges
  ?       ?      ?   ?      *       :   ?   :   x;
 
endtable
endprimitive
primitive MACH_JKFF(Q,CLK,J,K,S,R,NOTIFIER);
output Q;
reg Q;
input CLK,  //clock input
      J,K,  // FF inputs
      S,R,  // Reset,Set inputs
      NOTIFIER;

 //POSITIVE EDGE TRIGGERED JK-FLIP FLOP WITH ACTIVE LOW ASYNCHRONOUS SET AND CLEAR

table

// CLK  J   K   S   R  NOTIFIER   Q(t)   Q(t+1) 
    ?   ?   ?   0   1     ?       : ? :    1;
    ?   ?   ?   *   1     ?       : 1 :    1; // Reset logic
    ?   ?   ?   1   0     ?       : ? :    0;
    ?   ?   ?   1   *     ?       : 0 :    0;
                                       // normal clocking cases
    r   0   0   1   1     ?       : ? :    -;
    r   0   1   1   1     ?       : ? :    0;
    r   1   0   1   1     ?       : ? :    1;
    r   1   1   1   1     ?       : 1 :    0;
    r   1   1   1   1     ?       : 0 :    1;
    f   ?   ?   ?   ?     ?       : ? :    - ;   
                                   // J K transition cases
    b   *   ?   ?   ?     ?       : ? :    -;
    b   ?   *   ?   ?     ?       : ? :    -;
                                    // cases reducing pessimism
    p   0   0   1   1     ?       : ? :    -;
    p   0   ?   1   ?     ?       : 0 :    -;
    p   ?   0   ?   1     ?       : 1 :    -;
   (x0) ?   ?   ?   ?     ?       : ? :    -;
   (1x) 0   0   1   1     ?       : ? :    -;
   (1x) 0   ?   1   ?     ?       : 0 :    -;
   (1x) ?   0   ?   1     ?       : 1 :    -;
     x  *   0   ?   1     ?       : 1 :    -;
     x  0   *   1   ?     ?       : 0 :    -;
     ?  ?   ?   ?   ?     *       : ? :    -;

endtable
endprimitive 
   
primitive MACH_JKFF_X(Q,CLK,J,K,S,R,NOTIFIER);
output Q;
reg Q;
input CLK,  //clock input
      J,K,  // FF inputs
      S,R,  // Reset,Set inputs
      NOTIFIER;

 //POSITIVE EDGE TRIGGERED JK-FLIP FLOP WITH ACTIVE LOW ASYNCHRONOUS SET AND CLEAR

table

// CLK  J   K   S   R  NOTIFIER   Q(t)   Q(t+1) 
    ?   ?   ?   0   1     ?       : ? :    1;
    ?   ?   ?   *   1     ?       : 1 :    1; // Reset logic
    ?   ?   ?   1   0     ?       : ? :    0;
    ?   ?   ?   1   *     ?       : 0 :    0;
                                       // normal clocking cases
    r   0   0   1   1     ?       : ? :    -;
    r   0   1   1   1     ?       : ? :    0;
    r   1   0   1   1     ?       : ? :    1;
    r   1   1   1   1     ?       : 1 :    0;
    r   1   1   1   1     ?       : 0 :    1;
    f   ?   ?   ?   ?     ?       : ? :    - ;   
                                   // J K transition cases
    b   *   ?   ?   ?     ?       : ? :    -;
    b   ?   *   ?   ?     ?       : ? :    -;
                                    // cases reducing pessimism
    p   0   0   1   1     ?       : ? :    -;
    p   0   ?   1   ?     ?       : 0 :    -;
    p   ?   0   ?   1     ?       : 1 :    -;
   (x0) ?   ?   ?   ?     ?       : ? :    -;
   (1x) 0   0   1   1     ?       : ? :    -;
   (1x) 0   ?   1   ?     ?       : 0 :    -;
   (1x) ?   0   ?   1     ?       : 1 :    -;
     x  *   0   ?   1     ?       : 1 :    -;
     x  0   *   1   ?     ?       : 0 :    -;
     ?  ?   ?   ?   ?     *       : ? :    x;  
endtable
endprimitive 
   
primitive MACH_LATCH(Q,D,LAT,R,S,NOTIFIER);
output Q;
reg Q;
input D,                                     // D input
      LAT,                                   //  Clock input
      R,S,                                   //   Active Low RESET and SET
      NOTIFIER;

// FUNCTION : POSITIVE LEVEL SENSITIVE D-TYPE LATCH WITH ACTIVE LOW ASYNCHRONOUS
//            RESET AND SET. (Q OUTPUT UDP)
table
//  D  LAT   R   S    NOTIFIER  :Q(t) :  Q(t+1)
    *   0    1   1      ?       :  ?  :  -  ;
    ?   ?    0   1      ?       :  ?  :  0  ;
    ?   ?    1   0      ?       :  ?  :  1  ;
    ?  (?0)  1   1      ?       :  ?  :  -  ;
    ?  (1x)  1   1      ?       :  ?  :  -  ;
    0  (x1)  ?   1      ?       :  ?  :  0  ;
    1  (x1)  1   ?      ?       :  ?  :  1  ;
    0  (0x)  1   1      ?       :  0  :  0  ;
    1  (0x)  1   1      ?       :  1  :  1  ;
  (?0)  1    ?   1      ?       :  ?  :  0  ;
  (?1)  1    1   ?      ?       :  ?  :  1  ;
    0  (01)  ?   1      ?       :  ?  :  0  ;
    1  (01)  1   ?      ?       :  ?  :  1  ;
    ?   0    1  (?1)    ?       :  ?  :  -  ; // ignore edge on SE
    ?   0   (?1) 1      ?       :  ?  :  -  ; // ignore edge on RE
    0   1    ?  (?1)    ?       :  ?  :  0  ;
    1   1   (?1) ?      ?       :  ?  :  1  ;
    1   1    1  (?1)    ?       :  ?  :  1  ;
    0   1   (?1) 1      ?       :  ?  :  0  ;
   (?1) x    1   ?      ?       :  1  :  1  ;
   (?0) x    ?   1      ?       :  0  :  0  ;
    ?   ?    ?   ?      *       :  ?  :  -  ;

endtable
 
endprimitive
primitive MACH_LATCH_X(Q,D,LAT,R,S,NOTIFIER);
output Q;
reg Q;
input D,                                     // D input
      LAT,                                   //  Clock input
      R,S,                                   //   Active Low RESET and SET
      NOTIFIER;

// FUNCTION : POSITIVE LEVEL SENSITIVE D-TYPE LATCH WITH ACTIVE LOW ASYNCHRONOUS
//            RESET AND SET. (Q OUTPUT UDP)
table
//  D  LAT   R   S    NOTIFIER  :Q(t) :  Q(t+1)
    *   0    1   1      ?       :  ?  :  -  ;
    ?   ?    0   1      ?       :  ?  :  0  ;
    ?   ?    1   0      ?       :  ?  :  1  ;
    ?  (?0)  1   1      ?       :  ?  :  -  ;
    ?  (1x)  1   1      ?       :  ?  :  -  ;
    0  (x1)  ?   1      ?       :  ?  :  0  ;
    1  (x1)  1   ?      ?       :  ?  :  1  ;
    0  (0x)  1   1      ?       :  0  :  0  ;
    1  (0x)  1   1      ?       :  1  :  1  ;
  (?0)  1    ?   1      ?       :  ?  :  0  ;
  (?1)  1    1   ?      ?       :  ?  :  1  ;
    0  (01)  ?   1      ?       :  ?  :  0  ;
    1  (01)  1   ?      ?       :  ?  :  1  ;
    ?   0    1  (?1)    ?       :  ?  :  -  ; // ignore edge on SE
    ?   0   (?1) 1      ?       :  ?  :  -  ; // ignore edge on RE
    0   1    ?  (?1)    ?       :  ?  :  0  ;
    1   1   (?1) ?      ?       :  ?  :  1  ;
    1   1    1  (?1)    ?       :  ?  :  1  ;
    0   1   (?1) 1      ?       :  ?  :  0  ;
   (?1) x    1   ?      ?       :  1  :  1  ;
   (?0) x    ?   1      ?       :  0  :  0  ;
    ?   ?    ?   ?      *       :  ?  :  x  ;
endtable
 
endprimitive
primitive MACH_RSFF(Q,CLK,RE,SE,S,R,NOTIFIER);
output Q;
reg Q;
input CLK,  //clock input
      RE,SE,  // FF inputs
      S,R,  // Reset,Set inputs
      NOTIFIER;

 //POSITIVE EDGE TRIGGERED SR-FLIP FLOP WITH ACTIVE LOW ASYNCHRONOUS SET AND CLEAR

table

// CLK  RE  SE  S   R  NOTIFIER   Q(t)   Q(t+1) 
                                         // Set logic
    ?   ?   ?   0   1     ?       : ? :    1;
    ?   ?   ?   *   1     ?       : 1 :    1;
                                        // Reset logic
    ?   ?   ?   1   0     ?       : ? :    0;
    ?   ?   ?   1   *     ?       : 0 :    0;
                                       // normal clocking cases
    r   0   0   1   1     ?       : ? :    -;
    r   0   1   1   1     ?       : ? :    1;
    r   1   0   1   1     ?       : ? :    0;
    f   ?   ?   ?   ?     ?       : ? :    - ;   
                                   // S R transition cases

                                    // cases reducing pessimism
    p   0   0   1   1     ?       : ? :    -;
    p   1   1   1   ?     ?       : 0 :    x;
//  p   ?   1   ?   1     ?       : 1 :    x;
   (x0) ?   ?   ?   ?     ?       : ? :    -;
   (1x) 0   0   1   1     ?       : ? :    -;
   (1x) 0   ?   1   ?     ?       : 0 :    -;
   (1x) ?   0   ?   1     ?       : 1 :    -;
     x  *   0   ?   1     ?       : 1 :    -;
     x  0   *   1   ?     ?       : 0 :    -;
     ?  ?   ?   ?   ?     *	  : ? :    -;
     ?  *   ?   1   1     ?       : ? :    -;
     ?  ?   *   1   1     ?       : ? :    -;

endtable
endprimitive 
primitive MACH_RSFF_X(Q,CLK,RE,SE,S,R,NOTIFIER);
output Q;
reg Q;
input CLK,  //clock input
      RE,SE,  // FF inputs
      S,R,  // Reset,Set inputs
      NOTIFIER;

 //POSITIVE EDGE TRIGGERED SR-FLIP FLOP WITH ACTIVE LOW ASYNCHRONOUS SET AND CLEAR

table

// CLK  RE  SE  S   R  NOTIFIER   Q(t)   Q(t+1) 
                                         // Set logic
    ?   ?   ?   0   1     ?       : ? :    1;
//  ?   ?   ? (?1)   1     ?      : ? :    -;
    ?   1   1 (?1)   1     ?      : ? :    x;
//  ?   ?   ?   *   1     ?       : 1 :    1;
                                        // Reset logic
    ?   ?   ?   1   0     ?       : ? :    0;
//  ?   ?   ?   1   *     ?       : 0 :    0;
//  ?   ?   ?   1 (?1)    ?       : ? :    -;
    ?   1   1   1 (?1)    ?       : ? :    x;
                                       // normal clocking cases
    r   0   0   1   1     ?       : ? :    -;
    r   0   1   1   1     ?       : ? :    1;
    r   1   0   1   1     ?       : ? :    0;
    f   ?   ?   ?   ?     ?       : ? :    - ;   
                                   // S R transition cases
                                    // cases reducing pessimism
    p   0   0   1   1     ?       : ? :    -;
    p   1   1   1   ?     ?       : 0 :    x;
//  p   ?   1   ?   1     ?       : 1 :    -;
   (x0) ?   ?   ?   ?     ?       : ? :    -;
   (1x) 0   0   1   1     ?       : ? :    -;
   (1x) 0   ?   1   ?     ?       : 0 :    -;
   (1x) ?   0   ?   1     ?       : 1 :    -;
     x  *   0   ?   1     ?       : 1 :    -;
     x  0   *   1   ?     ?       : 0 :    -;
     ?  ?   ?   ?   ?     *       : ? :    x;
     ?  *   ?   1   1     ?       : ? :    -;
     ?  ?   *   1   1     ?       : ? :    -;
endtable
endprimitive 
primitive MACH_TFF(Q,CLK,T,S,R,NOTIFIER);
output Q;
reg Q;
input CLK,  //clock input
      T,  // FF inputs
      S,R,  // Reset,Set inputs
      NOTIFIER;


table

// CLK  T      S   R  NOTIFIER   Q(t)   Q(t+1) 
                                         // Set logic
    ?   ?      0   1     ?       : ? :    1;
    ?   ?      *   1     ?       : 1 :    1;
                                        // Reset logic
    ?   ?      1   0     ?       : ? :    0;
    ?   ?      1   *     ?       : 0 :    0;
                                       // normal clocking cases
    r   0      1   1     ?       : ? :    -;
    r   1      1   1     ?       : 1 :    0;
    r   1      1   1     ?       : 0 :    1;
    f   ?      ?   ?     ?       : ? :    - ;   
                                   // T  transition cases
    b   *      ?   ?     ?       : ? :    -;
                                    // cases reducing pessimism
    p   0      1   1     ?       : ? :    -;
    p   0      1   ?     ?       : 0 :    -;
    p   0      ?   1     ?       : 1 :    -;
   (x0) ?      ?   ?     ?       : ? :    -;
   (1x) 0      1   1     ?       : ? :    -;
   (1x) ?      ?   1     ?       : 1 :    -;
     x  0      1   ?     ?       : 0 :    -;
     ?  ?      ?   ?     *       : ? :    -;

endtable
endprimitive 
primitive MACH_TFF_X(Q,CLK,T,S,R,NOTIFIER);
output Q;
reg Q;
input CLK,  //clock input
      T,  // FF inputs
      S,R,  // Reset,Set inputs
      NOTIFIER;


table

// CLK  T      S   R  NOTIFIER   Q(t)   Q(t+1) 
                                         // Set logic
    ?   ?      0   1     ?       : ? :    1;
    ?   ?      *   1     ?       : 1 :    1;
                                        // Reset logic
    ?   ?      1   0     ?       : ? :    0;
    ?   ?      1   *     ?       : 0 :    0;
                                       // normal clocking cases
    r   0      1   1     ?       : ? :    -;
    r   1      1   1     ?       : 1 :    0;
    r   1      1   1     ?       : 0 :    1;
    f   ?      ?   ?     ?       : ? :    - ;   
                                   // T  transition cases
    b   *      ?   ?     ?       : ? :    -;
                                    // cases reducing pessimism
    p   0      1   1     ?       : ? :    -;
    p   0      1   ?     ?       : 0 :    -;
    p   0      ?   1     ?       : 1 :    -;
   (x0) ?      ?   ?     ?       : ? :    -;
   (1x) 0      1   1     ?       : ? :    -;
   (1x) ?      ?   1     ?       : 1 :    -;
     x  0      1   ?     ?       : 0 :    -;
     ?  ?      ?   ?     *       : ? :    x;
endtable
endprimitive 
