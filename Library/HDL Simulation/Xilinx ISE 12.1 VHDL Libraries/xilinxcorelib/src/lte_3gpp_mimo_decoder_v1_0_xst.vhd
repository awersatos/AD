-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 1.0
--  \   \        Filename: $RCSfile: lte_3gpp_mimo_decoder_v1_0_xst.vhd,v $
--  /   /        Date Last Modified: $Date: 2009/12/02 13:25:12 $
-- /___/   /\    Date Created: 2009
-- \   \  /  \
--  \___\/\___\
--
-- Device  : All
-- Library : example_v1_0
-- Purpose : Wrapper for behavioral model
-------------------------------------------------------------------------------
--  (c) Copyright 2009 Xilinx, Inc. All rights reserved.
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
-------------------------------------------------------------------------------

  
library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.lte_3gpp_mimo_decoder_v1_0_comp.all;

--core_if on entity lte_3gpp_mimo_decoder_v1_0_xst
entity lte_3gpp_mimo_decoder_v1_0_xst is
  generic (
    c_elaboration_dir :   string  := "./";
    c_xdevicefamily :     string  := "virtex6";
    Ntmax           :     integer := 2;
    Wmatrix         :     integer := 1;
    widthx          :     integer := 16
    );
  port (
    Singular_thresh : in  std_logic_vector(3 downto 0);
    H_SIZE          : in  std_logic_vector(2 downto 0);
    H_SIZE_LOAD     : in  std_logic;
    SIGMA_DATA      : in  std_logic_vector(widthx - 1 downto 0);
    SIGMA_LOAD      : in  std_logic;
    Y_I_DATA        : in  std_logic_vector(widthx - 1 downto 0);
    Y_Q_DATA        : in  std_logic_vector(widthx - 1 downto 0);
    Y_VALID         : in  std_logic;
    Y_START         : in  std_logic;
    Hx1_I_DATA      : in  std_logic_vector(widthx - 1 downto 0);
    Hx1_Q_DATA      : in  std_logic_vector(widthx - 1 downto 0);
    Hx2_I_DATA      : in  std_logic_vector(widthx - 1 downto 0);
    Hx2_Q_DATA      : in  std_logic_vector(widthx - 1 downto 0);
    Hx_VALID        : in  std_logic;
    Hx_START        : in  std_logic;
    Xest_READY      : in  std_logic;
    Wx_READY        : in  std_logic := '1';
    RESET           : in  std_logic;
    CE              : in  std_logic;
    CLK             : in  std_logic;
    H_SIZE_READY    : out std_logic;
    SIGMA_READY     : out std_logic;
    Y_READY         : out std_logic;
    Hx_READY        : out std_logic;
    Singular_flag   : out std_logic;
    Xest_overflow   : out std_logic;
    Xest_SIZE       : out std_logic_vector(1 downto 0);
    Xest_I_DATA     : out std_logic_vector(widthx + 8 downto 0);
    Xest_Q_DATA     : out std_logic_vector(widthx + 8 downto 0);
    Xest_VALID      : out std_logic;
    Xest_START      : out std_logic;
    W_overflow      : out std_logic := '0';
    W_SIZE          : out std_logic_vector(2 downto 0) := (others => '0');
    Wx1_I_DATA      : out std_logic_vector(widthx + 8 downto 0) := (others => '0');
    Wx1_Q_DATA      : out std_logic_vector(widthx + 8 downto 0) := (others => '0');
    Wx2_I_DATA      : out std_logic_vector(widthx + 8 downto 0) := (others => '0');
    Wx2_Q_DATA      : out std_logic_vector(widthx + 8 downto 0) := (others => '0');
    Wx_VALID        : out std_logic := '0';
    Wx_START        : out std_logic := '0'
    );          
--core_if off
end lte_3gpp_mimo_decoder_v1_0_xst;


architecture behavioral of lte_3gpp_mimo_decoder_v1_0_xst is

begin
  --core_if on instance i_behv lte_3gpp_mimo_decoder_v1_0
  i_behv : lte_3gpp_mimo_decoder_v1_0
    generic map (
      c_elaboration_dir => c_elaboration_dir,
      c_xdevicefamily => c_xdevicefamily,
      Ntmax           => Ntmax,
      Wmatrix         => Wmatrix,
      widthx          => widthx
      )
    port map (
      Singular_thresh => Singular_thresh,
      H_SIZE          => H_SIZE,
      H_SIZE_LOAD     => H_SIZE_LOAD,
      SIGMA_DATA      => SIGMA_DATA,
      SIGMA_LOAD      => SIGMA_LOAD,
      Y_I_DATA        => Y_I_DATA,
      Y_Q_DATA        => Y_Q_DATA,
      Y_VALID         => Y_VALID,
      Y_START         => Y_START,
      Hx1_I_DATA      => Hx1_I_DATA,
      Hx1_Q_DATA      => Hx1_Q_DATA,
      Hx2_I_DATA      => Hx2_I_DATA,
      Hx2_Q_DATA      => Hx2_Q_DATA,
      Hx_VALID        => Hx_VALID,
      Hx_START        => Hx_START,
      Xest_READY      => Xest_READY,
      Wx_READY        => Wx_READY,
      RESET           => RESET,
      CE              => CE,
      CLK             => CLK,
      H_SIZE_READY    => H_SIZE_READY,
      SIGMA_READY     => SIGMA_READY,
      Y_READY         => Y_READY,
      Hx_READY        => Hx_READY,
      Singular_flag   => Singular_flag,
      Xest_overflow   => Xest_overflow,
      Xest_SIZE       => Xest_SIZE,
      Xest_I_DATA     => Xest_I_DATA,
      Xest_Q_DATA     => Xest_Q_DATA,
      Xest_VALID      => Xest_VALID,
      Xest_START      => Xest_START,
      W_overflow      => W_overflow,
      W_SIZE          => W_SIZE,
      Wx1_I_DATA      => Wx1_I_DATA,
      Wx1_Q_DATA      => Wx1_Q_DATA,
      Wx2_I_DATA      => Wx2_I_DATA,
      Wx2_Q_DATA      => Wx2_Q_DATA,
      Wx_VALID        => Wx_VALID,
      Wx_START        => Wx_START
      );
  --core_if off
  
end behavioral;

