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
// Simulation Library File for ispMACH5000VG
// Revision History:
//$Header: R:/src/mod_kits/Mach/verilog/rcs/lc5kvg.v 1.14 2004/03/04 19:12:11Z jli Exp $ 

// 1.2 Added default timing to work around the zero time loop
// 1.3 Default propagation delay time is changed to zero
// 1.4 Change default pulse width and period to 1ns

`timescale 1ns / 1ps // TIMESCALE FOR THE LIBRARY
`define PUC

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


`timescale 10 ps / 10 ps
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



`timescale 10 ps / 10 ps
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
LC5KVG_DFF_X INS1 (Q_int, D, CLK, VCC, VCC, notifier); 
`else 
LC5KVG_DFF INS4 (Q_int, D, CLK, VCC, VCC, notifier); 
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
LC5KVG_DFF_CE_X INS1 (Q_int, D, CLK, VCC, VCC, CE, notifier); 
`else 
LC5KVG_DFF_CE INS4 (Q_int, D, CLK, VCC, VCC, CE, notifier); 
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
LC5KVG_DFF_CE_X INS1 (Q_int, D, CLK, R, VCC, CE, notifier); 
`else 
LC5KVG_DFF_CE INS5 (Q_int, D, CLK, R, VCC, CE, notifier); 
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
LC5KVG_DFF_CE_X INS1 (Q_int, D, CLK, R1, VCC, CE, notifier); 
`else 
LC5KVG_DFF_CE INS7 (Q_int, D, CLK, R1, VCC, CE, notifier); 
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
LC5KVG_DFF_CE_X INS1 (Q_int, D, CLK, R, S, CE, notifier); 
`else 
LC5KVG_DFF_CE INS7 (Q_int, D, CLK, R, S, CE, notifier); 
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
LC5KVG_DFF_CE_X INS1 (Q_int, D, CLK, R1,S1, CE, notifier); 
`else 
LC5KVG_DFF_CE INS11 (Q_int, D, CLK, R1, S1, CE, notifier); 
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
LC5KVG_DFF_CE_X INS1 (Q_int, D, CLK, VCC, S, CE, notifier); 
`else 
LC5KVG_DFF_CE INS5 (Q_int, D, CLK, VCC, S, CE, notifier); 
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
LC5KVG_DFF_CE_X INS1 (Q_int, D, CLK, VCC, S1, CE, notifier); 
`else 
LC5KVG_DFF_CE INS7 (Q_int, D, CLK, VCC, S1, CE, notifier); 
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
LC5KVG_DFF_X INS1 (Q_int, D, CLK, R, VCC, notifier); 
`else 
LC5KVG_DFF INS4 (Q_int, D, CLK, R, VCC, notifier); 
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
LC5KVG_DFF_X INS1 (Q_int, D, CLK, R1, VCC, notifier); 
`else 
LC5KVG_DFF INS1 (Q_int, D, CLK, R1, VCC, notifier); 
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
LC5KVG_DFF_X INS1 (Q_int, D, CLK, R, S, notifier); 
`else 
LC5KVG_DFF INS5 (Q_int, D, CLK, R, S, notifier); 
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
LC5KVG_DFF_X INS1 (Q_int, D, CLK, R1, S1, notifier); 
`else 
LC5KVG_DFF INS7 (Q_int, D, CLK, R1, S1, notifier); 
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
LC5KVG_DFF_X INS7 (Q_int, D, CLK, VCC, S, notifier); 
`else 
LC5KVG_DFF INS4 (Q_int, D, CLK, VCC, S, notifier); 
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
LC5KVG_DFF_X INS1 (Q_int, D, CLK, VCC, S1, notifier); 
`else 
LC5KVG_DFF INS5 (Q_int, D, CLK, VCC, S1, notifier); 
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
LC5KVG_LATCH_X INS1 (Q_int, D, LAT, VCC, VCC, notifier); 
`else 
LC5KVG_LATCH INS4 (Q_int, D, LAT, VCC, VCC, notifier); 
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
LC5KVG_LATCH_X INS1 (Q_int, D, LAT, R, VCC, notifier); 
`else 
LC5KVG_LATCH INS4 (Q_int, D, LAT, R, VCC, notifier); 
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
LC5KVG_LATCH_X INS1 (Q_int, D, LAT, R1, VCC, notifier); 
`else 
LC5KVG_LATCH INS5 (Q_int, D, LAT, R1, VCC, notifier); 
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
LC5KVG_LATCH_X INS1 (Q_int, D, LAT, R, S, notifier); 
`else 
LC5KVG_LATCH INS5 (Q_int, D, LAT, R, S, notifier); 
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
LC5KVG_LATCH_X INS1 (Q_int, D, LAT, R1, S1, notifier); 
`else 
LC5KVG_LATCH INS7 (Q_int, D, LAT, R1, S1, notifier); 
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
LC5KVG_LATCH_X INS1 (Q_int, D, LAT, VCC, S, notifier); 
`else 
LC5KVG_LATCH INS4 (Q_int, D, LAT, VCC, S, notifier); 
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
LC5KVG_LATCH_X INS1 (Q_int, D, LAT, VCC, S1, notifier); 
`else 
LC5KVG_LATCH INS5 (Q_int, D, LAT, VCC, S1, notifier); 
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

module LVDSIN (O,PIN,NIN); 
input PIN,NIN; 
output O; 
 
buf INS1 (O, PIN); 
 
specify 
 
(PIN => O) =  0:0:0, 0:0:0; 
 
endspecify 
endmodule 

`endcelldefine

`celldefine

module LVDSOUT (POUT,NOUT,I); 
input I; 
output POUT,NOUT; 
 
buf INS1 (POUT, I); 
not INS2 (NOUT, I);
 
specify 
 
(I => POUT) =  0:0:0, 0:0:0; 
 
endspecify 
endmodule 

`endcelldefine
 
 
`celldefine 
 
module LVDSTRI (NOUT,POUT,I,OE); 
input I,OE; 
output NOUT, POUT; 

supply0 GND; 
supply1 VCC; 

bufif1 INS1 (POUT, I, OE); 
notif1 INS2 (NOUT, I, OE);
 
specify 
 
(I => POUT) =  0:0:0, 0:0:0;
(OE => POUT) =  0:0:0, 0:0:0;
 
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
LC5KVG_DFF_X INS1 (Q_int, T_int,CLK, VCC, VCC, notifier); 
`else 
LC5KVG_DFF INS4 (Q_int, T_int,CLK, VCC, VCC, notifier); 
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
LC5KVG_TFF_X INS1 (Q_int, CLK, T, VCC, R, notifier); 
`else 
LC5KVG_TFF INS4 (Q_int, CLK, T, VCC, R, notifier); 
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
LC5KVG_TFF_X INS1 (Q_int, CLK, T, VCC, R1, notifier); 
`else 
LC5KVG_TFF INS5 (Q_int, CLK, T, VCC, R1, notifier); 
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
LC5KVG_TFF_X INS1 (Q_int, CLK, T, S, R, notifier); 
`else 
LC5KVG_TFF INS4 (Q_int, CLK, T, S, R, notifier); 
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
LC5KVG_TFF_X INS1 (Q_int, CLK, T, S1, R1, notifier); 
`else 
LC5KVG_TFF INS2 (Q_int, CLK, T, S1, R1, notifier); 
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
LC5KVG_TFF_X INS1 (Q_int, CLK, T, S, VCC, notifier); 
`else 
LC5KVG_TFF INS4 (Q_int, CLK, T, S, VCC, notifier); 
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
LC5KVG_TFF_X INS1 (Q_int, CLK, T, S1, VCC, notifier); 
`else 
LC5KVG_TFF INS5 (Q_int, CLK, T, S1, VCC, notifier); 
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
 
primitive  LC5KVG_DFF(Q,D,CLK,R,S,NOTIFIER);
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
primitive  LC5KVG_DFF_CE(Q,D,CLK,R,S,CE,NOTIFIER);
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
primitive  LC5KVG_DFF_CE_X(Q,D,CLK,R,S,CE,NOTIFIER);
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

  ?      (?0)    ?   ?   ?      ?:   ?   :   -;  // ignore falling clock
  0      (?x)    ?   ?   ?      ?:   0   :   -;  // retain state when D == Qt
  1      (?x)    ?   ?   ?      ?:   1   :   -;  // retain state when D == Qt
  *       1      ?   ?   ?      ?:   ?   :   -;  // ignore data edges
  *       0      ?   ?   ?      ?:   ?   :   -;  // ignore data edges

  ?       ?      1   1   0      ?:   ?   :   -;
  ?       ?      ?   ?   ?      *:   ?   :   x;
  ?       ?      1   1   *      ?:   ?   :   -; 
 
endtable
endprimitive
primitive  LC5KVG_DFF_X (Q,D,CLK,R,S,NOTIFIER);
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
primitive LC5KVG_JKFF(Q,CLK,J,K,S,R,NOTIFIER);
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
   
primitive LC5KVG_JKFF_X(Q,CLK,J,K,S,R,NOTIFIER);
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
   
primitive LC5KVG_LATCH(Q,D,LAT,R,S,NOTIFIER);
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
primitive LC5KVG_LATCH_X(Q,D,LAT,R,S,NOTIFIER);
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
primitive LC5KVG_RSFF(Q,CLK,RE,SE,S,R,NOTIFIER);
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
primitive LC5KVG_RSFF_X(Q,CLK,RE,SE,S,R,NOTIFIER);
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
primitive LC5KVG_TFF(Q,CLK,T,S,R,NOTIFIER);
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
primitive LC5KVG_TFF_X(Q,CLK,T,S,R,NOTIFIER);
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
