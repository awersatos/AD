-- $Id: xbip_multadd_v1_0.vhd,v 1.5 2008/09/10 09:50:48 akennedy Exp $
-------------------------------------------------------------------------------
--  Copyright(C) 2008 by Xilinx, Inc. All rights reserved.
--  This text/file contains proprietary, confidential
--  information of Xilinx, Inc., is distributed under license
--  from Xilinx, Inc., and may be used, copied and/or
--  disclosed only pursuant to the terms of a valid license
--  agreement with Xilinx, Inc.  Xilinx hereby grants you
--  a license to use this text/file solely for design, simulation,
--  implementation and creation of design files limited
--  to Xilinx devices or technologies. Use with non-Xilinx
--  devices or technologies is expressly prohibited and
--  immediately terminates your license unless covered by
--  a separate agreement.
--
--  Xilinx is providing this design, code, or information
--  "as is" solely for use in developing programs and
--  solutions for Xilinx devices.  By providing this design,
--  code, or information as one possible implementation of
--  this feature, application or standard, Xilinx is making no
--  representation that this implementation is free from any
--  claims of infringement.  You are responsible for
--  obtaining any rights you may require for your implementation.
--  Xilinx expressly disclaims any warranty whatsoever with
--  respect to the adequacy of the implementation, including
--  but not limited to any warranties or representations that this
--  implementation is free from claims of infringement, implied
--  warranties of merchantability or fitness for a particular
--  purpose.
--
--  Xilinx products are not intended for use in life support
--  appliances, devices, or systems. Use in such applications are
--  expressly prohibited.
--
--  This copyright and support notice must be retained as part
--  of this text at all times. (c) Copyright 2008 Xilinx, Inc.
--  All rights reserved.
---------------------------------------------------------------
-- This is the Behavioural model (aka 'pure RTL')
-- This model is not intended to be synthesized.
-- Its purpose is to verify the functionality of the other model(s)
-- It should be bit and cycle accurate.
-- The workings of this model need not take account of Xilinx primitives,
-- other than to match the behaviour of the other models. E.g
-- if the DSP48 and fabric variants of a core behave identically, the
-- behavioral model needs only one architecture and the C_USE_DSP48 generic
-- can be ignored.
---------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v1_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v1_0.all;
use xilinxcorelib.xbip_pipe_v1_0_comp.all;
use xilinxcorelib.xbip_multadd_pkg_v1_0.all;

entity xbip_multadd_v1_0 is
  generic (
    C_VERBOSITY         : integer := 0;
    C_XDEVICEFAMILY     : string  := "NO_FAMILY";
    C_A_WIDTH           : integer := 16;
    C_B_WIDTH           : integer := 16;
    C_C_WIDTH           : integer := 32;
    C_DATA_TYPE         : integer := 0;
    C_CE_OVERRIDES_SCLR : integer := 0;
    C_AB_LATENCY        : integer := -1;
    C_C_LATENCY         : integer := -1;
    C_OUT_HIGH          : integer := 32;
    C_OUT_LOW           : integer := 0;
    C_USE_PCIN          : integer := 0
    );
  port (
    CLK      : in  std_logic                                     := '0';
    CE       : in  std_logic                                     := '0';
    SCLR     : in  std_logic                                     := '0';
    A        : in  std_logic_vector(C_A_WIDTH-1 downto 0)        := (others => '0');
    B        : in  std_logic_vector(C_B_WIDTH-1 downto 0)        := (others => '0');
    C        : in  std_logic_vector(C_C_WIDTH-1 downto 0)        := (others => '0');
    PCIN     : in  std_logic_vector(ci_dsp48_c_width-1 downto 0) := (others => '0');
    SUBTRACT : in  std_logic                                     := '0';
    P        : out std_logic_vector(C_OUT_HIGH downto C_OUT_LOW) := (others => '0');
    PCOUT    : out  std_logic_vector(ci_dsp48_c_width-1 downto 0):= (others => '0')
    ); 
end xbip_multadd_v1_0;

architecture behavioral of xbip_multadd_v1_0 is

  constant MAX_PRODUCT_WIDTH : integer := 107;  -- 53x53 is max. multiplier size

  -- TEMPORARY
  constant MA_LATENCY : LATENCY_REC := calc_multadd_latencies(c_a_width,c_b_width,c_c_width,c_data_type,c_ab_latency,c_c_latency,c_use_pcin,c_xdevicefamily);
  constant AB_LATENCY : integer := MA_LATENCY.ab_latency;
  constant C_LATENCY : integer := MA_LATENCY.c_latency;

  constant dsp48_multadd_use : integer := resolve_dsp48_multadd_use(c_a_width,c_b_width,c_c_width,c_data_type,c_xdevicefamily);

  function resolve_use_pcin(dsp48_multadd_use,use_pcin : integer) return integer is
  begin
    if dsp48_multadd_use > 1 then
      return 0;
    else
      return use_pcin;
    end if;
  end function resolve_use_pcin;
  constant r_use_pcin : integer := resolve_use_pcin(dsp48_multadd_use,c_use_pcin);

  function calc_i_p_latency(r_use_pcin,c_latency : integer) return integer is
  begin
    if (c_latency = 0) then
      return 0;
    elsif (r_use_pcin = 1) then
      return c_latency;
    else
      return c_latency-1;
    end if;
  end function calc_i_p_latency;
  constant i_p_latency : integer := calc_i_p_latency(r_use_pcin,c_latency);
  constant pm_latency : integer := ab_latency-i_p_latency;
   

  signal ai : std_logic_vector(A'high+1 downto A'low) := (others => '0');
  signal bi : std_logic_vector(B'high+1 downto B'low) := (others => '0');
  signal ci : std_logic_vector(C'high+1 downto C'low) := (others => '0');
--  signal carryin_i : std_logic                               := '0';

  signal c_i : std_logic_vector(MAX_PRODUCT_WIDTH-1 downto 0) := (others => '0');
  signal c_i_a : std_logic_vector(MAX_PRODUCT_WIDTH-1 downto 0) := (others => '0');
  signal pm  : std_logic_vector(MAX_PRODUCT_WIDTH-1 downto 0) := (others => '0');
  signal pm_i  : std_logic_vector(MAX_PRODUCT_WIDTH-1 downto 0) := (others => '0');
  signal sub_c_a  : std_logic_vector(MAX_PRODUCT_WIDTH downto 0) := (others => '0');
  signal sub_c  : std_logic_vector(MAX_PRODUCT_WIDTH downto 0) := (others => '0');

  signal multadd : std_logic_vector(MAX_PRODUCT_WIDTH downto 0) := (others => '0');
  signal p_i     : std_logic_vector(multadd'range)              := (others => '0');
  signal subtract_i : std_logic := '0';
  signal sclr_i : std_logic := '0';
  
begin  -- architecture behavioral

  ce_overrides_sclr : if C_CE_OVERRIDES_SCLR = 1 generate
    sclr_i <= ce and sclr;
  end generate ce_overrides_sclr;
  sclr_overrides_ce : if C_CE_OVERRIDES_SCLR = 0 generate
    sclr_i <= sclr;
  end generate sclr_overrides_ce;


  -- adjust operands for signed/unsigned
  ab_signed : if C_DATA_TYPE = 0 generate
    ai <= A(A'high) & A;
    bi <= B(B'high) & B;
    ci <= C(C'high) & C;
  end generate ab_signed;
  ab_unsigned : if C_DATA_TYPE = 1 generate
    ai <= "0" & A;
    bi <= "0" & B;
    ci <= "0" & C;
  end generate ab_unsigned;

  -- do the multiply and expand the product to the full allowed width
  signed_multiply : if C_DATA_TYPE = 0 generate
    pm  <= std_logic_vector(resize(signed(ieee.std_logic_signed."*"(ai, bi)), MAX_PRODUCT_WIDTH));
    dont_use_pcin : if R_USE_PCIN = 0 generate
      c_i <= std_logic_vector(resize(signed(ci), MAX_PRODUCT_WIDTH));
    end generate dont_use_pcin;
    use_pcin : if R_USE_PCIN = 1 generate
      c_i <= std_logic_vector(resize(signed(pcin), MAX_PRODUCT_WIDTH));
    end generate use_pcin;
  end generate signed_multiply;
  unsigned_multiply : if C_DATA_TYPE = 1 generate
    pm  <= std_logic_vector(resize(unsigned(ieee.std_logic_unsigned."*"(ai, bi)), MAX_PRODUCT_WIDTH));
    dont_use_pcin : if R_USE_PCIN = 0 generate
      c_i <= std_logic_vector(resize(unsigned(ci), MAX_PRODUCT_WIDTH));
    end generate dont_use_pcin;
    use_pcin : if R_USE_PCIN = 1 generate
      c_i <= std_logic_vector(resize(unsigned(pcin), MAX_PRODUCT_WIDTH));
    end generate use_pcin;
  end generate unsigned_multiply;


  pipelined: if ab_latency > 0 and c_latency > 0 generate
    sub_c <= subtract&c_i;
    i_sub_c : xbip_pipe_v1_0
      generic map(
        C_LATENCY  => 1,
        C_HAS_CE   => 1,
        C_HAS_SCLR => 1,
        C_WIDTH    => sub_c'length
        )
      port map(
        CLK  => CLK,
        CE   => CE,
        SCLR => SCLR_i,
        D    => sub_c,
        Q    => sub_c_a
        );

    subtract_i <= sub_c_a(sub_c_a'length-1);
    dont_use_pcin: if r_use_pcin = 0 generate
      c_i_a <= sub_c_a(sub_c_a'length-2 downto 0);
    end generate dont_use_pcin;
    use_pcin: if r_use_pcin = 1 generate
      c_i_a <= c_i;
    end generate use_pcin;
  end generate pipelined;
  nonpipelined: if NOT(ab_latency > 0 and c_latency > 0) generate
    subtract_i <= subtract;
    c_i_a <= c_i;
  end generate nonpipelined;

  i_pm : xbip_pipe_v1_0
    generic map(
      C_LATENCY  => pm_latency,
      C_HAS_CE   => 1,
      C_HAS_SCLR => 1,
      C_WIDTH    => pm'length
      )
    port map(
      CLK  => CLK,
      CE   => CE,
      SCLR => SCLR_i,
      D    => pm,
      Q    => pm_i
      );

  
  signed_add: if C_DATA_TYPE = 0 generate
  -- nice obscure way of phrasing the add/sub behaviour...
  -- Note that this is doing (C +/- (A*B)), which is what the DSP48/A/E performs
  multadd <= std_logic_vector(resize(ieee.numeric_std."+"(signed(c_i_a), signed(pm_i)),multadd'length))
             when subtract_i = '0' else std_logic_vector(resize(ieee.numeric_std."-"(signed(c_i_a), signed(pm_i)),multadd'length));     
  end generate signed_add;
  unsigned_add: if C_DATA_TYPE = 1 generate
  -- nice obscure way of phrasing the add/sub behaviour...
  -- Note that this is doing (C +/- (A*B)), which is what the DSP48/A/E performs
  multadd <= std_logic_vector(resize(ieee.numeric_std."+"(unsigned(c_i_a), unsigned(pm_i)),multadd'length))
             when subtract_i = '0' else std_logic_vector(resize(ieee.numeric_std."-"(unsigned(c_i_a), unsigned(pm_i)),multadd'length));    
  end generate unsigned_add;
  
  
  i_p : xbip_pipe_v1_0
    generic map(
      C_LATENCY  => i_p_LATENCY,
      C_HAS_CE   => 1,
      C_HAS_SCLR => 1,
      C_WIDTH    => multadd'length
      )
    port map(
      CLK  => CLK,
      CE   => CE,
      SCLR => SCLR_i,
      D    => multadd,
      Q    => p_i
      );

  P <= p_i(C_OUT_HIGH downto C_OUT_LOW);

  --PCOUT <= p_i(C_OUT_HIGH downto C_OUT_LOW);
  drive_pcout: if dsp48_multadd_use < 2 generate
    PCOUT <= p_i(ci_dsp48_c_width-1 downto 0);
  end generate drive_pcout;
  nodrive_pcout: if dsp48_multadd_use > 1 generate
    PCOUT <= (OTHERS => '0');
  end generate nodrive_pcout;
  
end architecture behavioral;
