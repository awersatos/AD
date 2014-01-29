-- $Header
--
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

-------------------------------------------------------------------------------
-- Component statement for behavioral model
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

PACKAGE c_accum_v10_0_comp IS

  --core_if on component c_accum_v10_0
  component c_accum_v10_0
    GENERIC (
      C_XDEVICEFAMILY       : STRING  := "no_family";
      C_IMPLEMENTATION      : INTEGER := 0;
      C_VERBOSITY           : integer := 0;
      C_B_WIDTH             : INTEGER := 16;
      C_OUT_WIDTH           : INTEGER := 16;
      C_B_TYPE         : INTEGER := 1;            -- 0=signed, 1=unsigned;
      C_CE_OVERRIDES_SCLR   : INTEGER := 0;            -- 0=SYNC over CE, 1 = CE over SYNC
      C_ADD_MODE            : integer := 0;            -- 0=add, 1=sub, 2=addsub;
      C_HAS_C_IN            : integer := 1;
      C_HAS_CE              : integer := 0;
      C_HAS_BYPASS          : integer := 0;
      C_HAS_SCLR            : integer := 0;
      C_LATENCY             : integer := 1;

      C_SCALE               : integer := 0;
      C_AINIT_VAL           : string  := "0";
      C_SINIT_VAL           : string  := "0";
      C_BYPASS_LOW          : integer := 0;
      C_SCLR_OVERRIDES_SSET : integer := 1;            -- 0=set wins, 1=clear wins
      C_HAS_SSET            : integer := 0;
      C_HAS_SINIT           : integer := 0
      );
    PORT (
      B      : in  std_logic_vector(C_B_WIDTH-1 downto 0)   := (others => '0');  -- input value
      CLK    : in  std_logic                                := '0';              -- clock
      ADD    : in  std_logic                                := '1';
      C_IN   : in  std_logic                                := '0';              -- carry in
      CE     : in  std_logic                                := '1';              -- clock enable
      BYPASS : in  std_logic                                := '0';              -- sync load of b into reg
      SCLR   : in  std_logic                                := '0';              -- synch init.
      SSET   : in  std_logic                                := '0';              -- synch set.
      SINIT  : in  std_logic                                := '0';              -- synch init.
      Q      : out std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0')   -- synch output value
      );
  --core_if off
  END COMPONENT;
  -- The following tells XST that c_accum_v10_0 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF c_accum_v10_0 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF c_accum_v10_0 : COMPONENT IS
    "generatecore com.xilinx.ip.c_accum_v10_0.c_accum_v10_0";
  -- xcc include

END c_accum_v10_0_comp;
