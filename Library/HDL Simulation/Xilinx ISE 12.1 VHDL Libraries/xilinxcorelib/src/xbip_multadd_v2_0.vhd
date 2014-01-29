-- $RCSfile: xbip_multadd_v2_0.vhd,v $ $Date: 2009/12/04 11:46:44 $ $Revision: 1.4 $
--
--  (c) Copyright 2008-2009 Xilinx, Inc. All rights reserved.
--
--  This file contains confidential and proprietary information
--  of Xilinx, Inc. and is protected under U.S. and
--  international copyright and other intellectual property
--  laws.
--
--  DISCLAIMER
--  This disclaimer is not a license and does not grant any
--  rights to the materials distributed herewith. Except as
--  otherwise provided in a valid license issued to you by
--  Xilinx, and to the maximum extent permitted by applicable
--  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
--  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
--  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
--  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
--  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
--  (2) Xilinx shall not be liable (whether in contract or tort,
--  including negligence, or under any other theory of
--  liability) for any loss or damage of any kind or nature
--  related to, arising under or in connection with these
--  materials, including for any direct, or any indirect,
--  special, incidental, or consequential loss or damage
--  (including loss of data, profits, goodwill, or any type of
--  loss or damage suffered as a result of any action brought
--  by a third party) even if such damage or loss was
--  reasonably foreseeable or Xilinx had been advised of the
--  possibility of the same.
--
--  CRITICAL APPLICATIONS
--  Xilinx products are not designed or intended to be fail-
--  safe, or for use in any application requiring fail-safe
--  performance, such as life-support or safety devices or
--  systems, Class III medical devices, nuclear facilities,
--  applications related to the deployment of airbags, or any
--  other applications that could lead to death, personal
--  injury, or severe property or environmental damage
--  (individually and collectively, "Critical
--  Applications"). Customer assumes the sole risk and
--  liability of any use of Xilinx products in Critical
--  Applications, subject only to applicable laws and
--  regulations governing limitations on product liability.
--
--  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
--  PART OF THIS FILE AT ALL TIMES. 
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
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all;
use xilinxcorelib.xbip_pipe_v2_0_comp.all;
use xilinxcorelib.xbip_multadd_pkg_v2_0.all;

--core_if on entity xbip_multadd_v2_0
  entity xbip_multadd_v2_0 is
    generic (
      C_VERBOSITY         : integer := 0;
      C_XDEVICEFAMILY     : string  := "";
      C_A_WIDTH           : integer := 20;
      C_B_WIDTH           : integer := 20;
      C_C_WIDTH           : integer := 32;
      C_A_TYPE            : integer := 0;   -- 0:signed, 1:unsigned
      C_B_TYPE            : integer := 0;   -- 0:signed, 1:unsigned
      C_C_TYPE            : integer := 0;   -- 0:signed, 1:unsigned
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
      PCOUT    : out std_logic_vector(ci_dsp48_c_width-1 downto 0) := (others => '0')
      );
--core_if off
end xbip_multadd_v2_0;

architecture behavioral of xbip_multadd_v2_0 is

  constant MAX_PRODUCT_WIDTH : integer := 107;  -- 53x53 is max. multiplier size

  -- TEMPORARY
  constant MA_LATENCY : LATENCY_REC := calc_multadd_latencies(c_a_width,c_b_width,c_c_width,c_a_type,c_b_type,c_c_type,c_ab_latency,c_c_latency,c_use_pcin,c_xdevicefamily);
  constant AB_LATENCY : integer := MA_LATENCY.ab_latency;
  constant C_LATENCY : integer := MA_LATENCY.c_latency;

  constant dsp48_multadd_use : integer := resolve_dsp48_multadd_use(c_a_width,c_b_width,c_c_width,c_a_type,c_b_type,c_c_type,c_xdevicefamily);

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
  a_signed : if C_A_TYPE = 0 generate
    ai <= A(A'high) & A;
  end generate a_signed;
  a_unsigned : if C_A_TYPE = 1 generate
    ai <= "0" & A;
  end generate a_unsigned;
  b_signed : if C_B_TYPE = 0 generate
    bi <= B(B'high) & B;
  end generate b_signed;
  b_unsigned : if C_B_TYPE = 1 generate
    bi <= "0" & B;
  end generate b_unsigned;
  c_signed : if C_C_TYPE = 0 generate
    ci <= C(C'high) & C;
  end generate c_signed;
  c_unsigned : if C_C_TYPE = 1 generate
    ci <= "0" & C;
  end generate c_unsigned;

  -- do the multiply and expand the product to the full allowed width
  -- the operation is signed as the sign is taken care of above
  pm <= std_logic_vector(resize(signed(ai*bi), MAX_PRODUCT_WIDTH));
  -- resize of ci can be signed as the type is taken care of above.
  -- pcin will always be signed as it comes from a previous DSP
  dont_use_pcin : if R_USE_PCIN = 0 generate
    c_i <= std_logic_vector(resize(signed(ci), MAX_PRODUCT_WIDTH));
  end generate dont_use_pcin;
  use_pcin : if R_USE_PCIN = 1 generate
    c_i <= std_logic_vector(resize(signed(pcin), MAX_PRODUCT_WIDTH));
  end generate use_pcin;

--  signed_multiply : if C_DATA_TYPE = 0 generate
--    pm  <= std_logic_vector(resize(signed(ieee.std_logic_signed."*"(ai, bi)), MAX_PRODUCT_WIDTH));
--    dont_use_pcin : if R_USE_PCIN = 0 generate
--      c_i <= std_logic_vector(resize(signed(ci), MAX_PRODUCT_WIDTH));
--    end generate dont_use_pcin;
--    use_pcin : if R_USE_PCIN = 1 generate
--      c_i <= std_logic_vector(resize(signed(pcin), MAX_PRODUCT_WIDTH));
--    end generate use_pcin;
--  end generate signed_multiply;
--  unsigned_multiply : if C_DATA_TYPE = 1 generate
--    pm  <= std_logic_vector(resize(unsigned(ieee.std_logic_unsigned."*"(ai, bi)), MAX_PRODUCT_WIDTH));
--    dont_use_pcin : if R_USE_PCIN = 0 generate
--      c_i <= std_logic_vector(resize(unsigned(ci), MAX_PRODUCT_WIDTH));
--    end generate dont_use_pcin;
--    use_pcin : if R_USE_PCIN = 1 generate
--      c_i <= std_logic_vector(resize(unsigned(pcin), MAX_PRODUCT_WIDTH));
--    end generate use_pcin;
--  end generate unsigned_multiply;


  pipelined: if ab_latency > 0 and c_latency > 0 generate
    sub_c <= subtract&c_i;
    i_sub_c : xbip_pipe_v2_0
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

  i_pm : xbip_pipe_v2_0
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



  -- add operation is signed, the type of the operands has already been accounted for.
  -- Note that this is doing (C +/- (A*B)), which is what the DSP48/A/E performs
  multadd <= std_logic_vector(resize(signed(c_i_a+pm_i),multadd'length))
             when subtract_i = '0' else std_logic_vector(resize(signed(c_i_a-pm_i),multadd'length));     

--  signed_add: if C_DATA_TYPE = 0 generate
--  -- nice obscure way of phrasing the add/sub behaviour...
--  -- Note that this is doing (C +/- (A*B)), which is what the DSP48/A/E performs
--  multadd <= std_logic_vector(resize(ieee.numeric_std."+"(signed(c_i_a), signed(pm_i)),multadd'length))
--             when subtract_i = '0' else std_logic_vector(resize(ieee.numeric_std."-"(signed(c_i_a), signed(pm_i)),multadd'length));     
--  end generate signed_add;
--  unsigned_add: if C_DATA_TYPE = 1 generate
--  -- nice obscure way of phrasing the add/sub behaviour...
--  -- Note that this is doing (C +/- (A*B)), which is what the DSP48/A/E performs
--  multadd <= std_logic_vector(resize(ieee.numeric_std."+"(unsigned(c_i_a), unsigned(pm_i)),multadd'length))
--             when subtract_i = '0' else std_logic_vector(resize(ieee.numeric_std."-"(unsigned(c_i_a), unsigned(pm_i)),multadd'length));    
--  end generate unsigned_add;
  
  
  i_p : xbip_pipe_v2_0
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
