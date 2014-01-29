-- $Header: /devl/xcs/repo/env/Databases/ip/src2/L/xbip_pipe_v2_0/simulation/xbip_pipe_v2_0_xst.vhd,v 1.3 2009/09/08 16:46:37 akennedy Exp $
-------------------------------------------------------------------------------
--  (c) Copyright 2008 Xilinx, Inc. All rights reserved.
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

library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.xbip_pipe_v2_0_comp.all;

entity xbip_pipe_v2_0_xst is
  generic (
    C_LATENCY             : integer := 0;
    C_HAS_CE              : integer := 0;
    C_CE_OVERRIDES_SYNC   : integer := 0;
    C_SSET_OVERRIDES_SCLR : integer := 0;
    C_HAS_SCLR            : integer := 0;
    C_HAS_SSET            : integer := 0;
    C_HAS_SINIT           : integer := 0;
    C_SINIT_VAL           : string  := "0";
    C_AINIT_VAL           : string  := "0";
    C_WIDTH               : integer := 1;
    C_FAST_IP             : integer := 1
    );
  port (
    CLK   : in  std_logic                            := '0';
    CE    : in  std_logic                            := '0';
    SCLR  : in  std_logic                            := '0';
    SSET  : in  std_logic                            := '0';
    SINIT : in  std_logic                            := '0';
    D     : in  std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');
    Q     : out std_logic_vector(C_WIDTH-1 downto 0) := (others => '0')
    );
end xbip_pipe_v2_0_xst;

architecture behavioral of xbip_pipe_v2_0_xst is
begin

  i_behv : xbip_pipe_v2_0
    generic map(
      C_LATENCY             => C_LATENCY,
      C_HAS_CE              => C_HAS_CE,
      C_CE_OVERRIDES_SYNC   => C_CE_OVERRIDES_SYNC,
      C_SSET_OVERRIDES_SCLR => C_SSET_OVERRIDES_SCLR,
      C_HAS_SCLR            => C_HAS_SCLR,
      C_HAS_SSET            => C_HAS_SSET,
      C_HAS_SINIT           => C_HAS_SINIT,
      C_SINIT_VAL           => C_SINIT_VAL,
      C_AINIT_VAL           => C_AINIT_VAL,
      C_WIDTH               => C_WIDTH,
      C_FAST_IP             => C_FAST_IP
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      SSET  => SSET,
      SINIT => SINIT,
      D     => D,
      Q     => Q
      );

end behavioral;
