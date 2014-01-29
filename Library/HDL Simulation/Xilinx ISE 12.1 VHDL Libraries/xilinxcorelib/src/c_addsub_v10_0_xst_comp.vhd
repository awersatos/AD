-- $RCSfile: c_addsub_v10_0_xst_comp.vhd,v $ $Revision: 1.2 $ $Date: 2008/09/09 20:22:57 $
--------------------------------------------------------------------------------
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
--  of this text at all times. (c) Copyright 1995-2008 Xilinx, Inc.
--  All rights reserved.
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

package c_addsub_v10_0_xst_comp is

----------------------------------------------------------
-- Insert component declaration of top level xst file here
----------------------------------------------------------
  --core_if on component c_addsub_v10_0_xst
  component c_addsub_v10_0_xst
    GENERIC (
      C_VERBOSITY           : integer := 0;
      C_XDEVICEFAMILY       : string  := "no_family";
      C_IMPLEMENTATION      : integer := 0;
      C_A_WIDTH             : integer := 15;
      C_B_WIDTH             : integer := 15;
      C_OUT_WIDTH           : integer := 16;
      C_CE_OVERRIDES_SCLR   : integer := 0;            -- replaces c_sync_enable
      C_A_TYPE              : integer := 0;
      C_B_TYPE              : integer := 0;
      C_LATENCY             : integer := 1;
      C_ADD_MODE            : integer := 0;
      C_B_CONSTANT          : integer := 0;
      C_B_VALUE             : string  := "";
      C_AINIT_VAL           : string  := "";
      C_SINIT_VAL           : string  := "";
      C_CE_OVERRIDES_BYPASS : integer := 0;            -- replaces c_bypass_enable
      C_BYPASS_LOW          : integer := 0;
      C_SCLR_OVERRIDES_SSET : integer := 0;            -- replaces c_sync_priority
      C_HAS_C_IN            : integer := 0;
      C_HAS_C_OUT           : integer := 0;            -- may be registered in step with c_latency
      C_BORROW_LOW          : integer := 1;            -- only applies to implementation = 1
--      C_HAS_OVFL            : integer := 0;            -- may be registered in step with c_latency
      C_HAS_CE              : integer := 0;
      C_HAS_BYPASS          : integer := 0;
      C_HAS_SCLR            : integer := 0;
      C_HAS_SSET            : integer := 0;
      C_HAS_SINIT           : integer := 0
      );
    PORT (
      A      : in  std_logic_vector(C_A_WIDTH-1 downto 0)     := (others => '0');
      B      : in  std_logic_vector(C_B_WIDTH-1 downto 0)     := (others => '0');
      CLK    : in  std_logic                                  := '0';
      ADD    : in  std_logic                                  := '0';
      C_IN   : in  std_logic                                  := '0';
      CE     : in  std_logic                                  := '1';
      BYPASS : in  std_logic                                  := '0';
      SCLR   : in  std_logic                                  := '0';
      SSET   : in  std_logic                                  := '0';
      SINIT  : in  std_logic                                  := '0';
--      OVFL   : out std_logic                                  := '0';
      C_OUT  : out std_logic                                  := '0';
      S      : out std_logic_vector(C_OUT_WIDTH - 1 downto 0) := (others => '0')
      );
    --core_if off
  end component;

end c_addsub_v10_0_xst_comp;

