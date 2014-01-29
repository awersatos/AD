-- $RCSfile: c_accum_v11_0_xst.vhd,v $  $Revision: 1.4 $  $Date: 2009/12/04 11:46:40 $
--
--  (c) Copyright 1995-2009 Xilinx, Inc. All rights reserved.
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
-- Wrapper for behavioral model
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

library XilinxCoreLib;
use Xilinxcorelib.c_accum_v11_0_comp.all;

--
--core_if on entity c_accum_v11_0_xst
entity c_accum_v11_0_xst is
  generic (
    C_XDEVICEFAMILY     : string  := "no_family";
    C_IMPLEMENTATION    : integer := 0;
    C_VERBOSITY         : integer := 0;
    C_B_WIDTH           : integer := 16;
    C_OUT_WIDTH         : integer := 16;
    C_B_TYPE            : integer := 1;  -- 0=signed, 1=unsigned;
    C_CE_OVERRIDES_SCLR : integer := 0;  -- 0=SYNC over CE, 1 = CE over SYNC
    C_ADD_MODE          : integer := 0;  -- 0=add, 1=sub, 2=addsub;
    C_HAS_C_IN          : integer := 1;
    C_HAS_CE            : integer := 0;
    C_HAS_BYPASS        : integer := 0;
    C_HAS_SCLR          : integer := 0;
    C_LATENCY           : integer := 1;

    C_SCALE               :     integer                                  := 0;
    C_AINIT_VAL           :     string                                   := "0";
    C_SINIT_VAL           :     string                                   := "0";
    C_BYPASS_LOW          :     integer                                  := 0;
    C_SCLR_OVERRIDES_SSET :     integer                                  := 1;  -- 0=set wins, 1=clear wins
    C_HAS_SSET            :     integer                                  := 0;
    C_HAS_SINIT           :     integer                                  := 0
    );
  port (
    B                     : in  std_logic_vector(C_B_WIDTH-1 downto 0)   := (others => '0');  -- input value
    CLK                   : in  std_logic                                := '0';  -- clock
    ADD                   : in  std_logic                                := '1';
    C_IN                  : in  std_logic                                := '0';  -- carry in
    CE                    : in  std_logic                                := '1';  -- clock enable
    BYPASS                : in  std_logic                                := '0';  -- sync load of b into reg
    SCLR                  : in  std_logic                                := '0';  -- synch init.
    SSET                  : in  std_logic                                := '0';  -- synch set.
    SINIT                 : in  std_logic                                := '0';  -- synch init.
    Q                     : out std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0')  -- synch output value
    );
--core_if off
end c_accum_v11_0_xst;


architecture behavioral of c_accum_v11_0_xst is

begin
  --core_if on instance i_behv c_accum_v11_0
  i_behv : c_accum_v11_0
    generic map (
      C_XDEVICEFAMILY     => C_XDEVICEFAMILY,
      C_IMPLEMENTATION    => C_IMPLEMENTATION,
      C_VERBOSITY         => C_VERBOSITY,
      C_B_WIDTH           => C_B_WIDTH,
      C_OUT_WIDTH         => C_OUT_WIDTH,
      C_B_TYPE            => C_B_TYPE,
      C_CE_OVERRIDES_SCLR => C_CE_OVERRIDES_SCLR,
      C_ADD_MODE          => C_ADD_MODE,
      C_HAS_C_IN          => C_HAS_C_IN,
      C_HAS_CE            => C_HAS_CE,
      C_HAS_BYPASS        => C_HAS_BYPASS,
      C_HAS_SCLR          => C_HAS_SCLR,
      C_LATENCY           => C_LATENCY,

      C_SCALE               => C_SCALE,
      C_AINIT_VAL           => C_AINIT_VAL,
      C_SINIT_VAL           => C_SINIT_VAL,
      C_BYPASS_LOW          => C_BYPASS_LOW,
      C_SCLR_OVERRIDES_SSET => C_SCLR_OVERRIDES_SSET,
      C_HAS_SSET            => C_HAS_SSET,
      C_HAS_SINIT           => C_HAS_SINIT
      )
    port map (
      B                     => B,
      CLK                   => CLK,
      ADD                   => ADD,
      C_IN                  => C_IN,
      CE                    => CE,
      BYPASS                => BYPASS,
      SCLR                  => SCLR,
      SSET                  => SSET,
      SINIT                 => SINIT,
      Q                     => Q
      );

  --core_if off

END behavioral;

