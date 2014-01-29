-------------------------------------------------------------------------------
--
-- Copyright(C) 2004 Xilinx, Inc. All rights reserved.
--
-- This text contains proprietary, confidential information of Xilinx, Inc.,
-- is distributed under license from Xilinx, Inc., and may be used, copied
-- and/or disclosed only pursuant to the terms of a valid license agreement
-- with Xilinx, Inc.
--
-- This copyright notice must be retained as part of this text at all times.
--
-- $Header: /devl/xcs/repo/env/Databases/ip/src2/J/addr_gen_802_16e_v2_1/simulation/addr_gen_802_16e_v2_1_xst_comp.vhd,v 1.7 2008/09/09 19:55:31 akennedy Exp $
--
-------------------------------------------------------------------------------
-- Unit     :
-- Function :
-- Author   : Stephen Creaney
-------------------------------------------------------------------------------
-- Description - This file contains the component declaration for
--               the top level XST file. This package allows the core
--               to be instantiated by higher level XST cores.
--               This is the simulation version of this file. it must be kept
--               identical to the version in the hdl directory, except for the
--               use of xilinxcorelib.
-------------------------------------------------------------------------------

library std;
use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;

--library xilinxcorelib;
--use xilinxcorelib.addr_gen_802_16e_intlv_pkg.all;

package  addr_gen_802_16e_v2_1_xst_comp is

  component addr_gen_802_16e_v2_1_xst is
    generic (
      C_ADDR_WIDTH    : integer := 12;
      C_HAS_ACLR      : integer := 0;
      C_HAS_CE        : integer := 0;
      C_HAS_OP_NEXT   : integer := 1;
      C_HAS_SCLR      : integer := 1;
      C_HAS_START_ENC : integer := 1;
      C_MODE          : integer := 0;
      C_USE_BASEBLOX  : integer := 0
      );
    port (
      -- System CLK, ACLR, SCLR and CE
      CLK             : in  std_logic;
      ACLR            : in  std_logic;
      SCLR            : in  std_logic;
      CE              : in  std_logic;
      -- Input
      START           : in  std_logic;
      BLK_SEL         : in  std_logic_vector(4 downto 0);
      -- Output
      OP_NEXT         : out std_logic;
      START_ENC       : out std_logic;
      ADDR            : out std_logic_vector(c_addr_width-1 downto 0)
      );
  end component; -- addr_gen_802_16e_v2_1_xst

end package  addr_gen_802_16e_v2_1_xst_comp;
