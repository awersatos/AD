--------------------------------------------------------------------------------
-- $RCSfile: tcc_enc_802_16e_v2_1_xst_comp.vhd,v $
--------------------------------------------------------------------------------
-- Copyright (c) 2004-2006 Xilinx, Inc.
-- All Rights Reserved
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 2.1
--  \   \        Filename: tcc_enc_802_16_v2_1_xst_comp.vhd
--  /   /        Date Last Modified: 
-- /___/   /\    Date Created: 09/May/2005
-- \   \  /  \
--  \___\/\___\
-- 
--Device: Xilinx
--Library: none
--Purpose: Component declaration package
--Revision History:
--    Rev 1.1 : Package creation
--------------------------------------------------------------------------------
-- 
-- This text contains proprietary, confidential information of Xilinx, Inc.,
-- is distributed under license from Xilinx, Inc., and may be used, copied
-- and/or disclosed only pursuant to the terms of a valid license agreement
-- with Xilinx, Inc.
-- This copyright notice must be retained as part of this text at all times.
--
-------------------------------------------------------------------------------
-- Authors : Richard Geddes
-------------------------------------------------------------------------------
-- Description:
-- 
-- XST component package file
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package tcc_enc_802_16e_v2_1_xst_comp is

  component tcc_enc_802_16e_v2_1_xst is
  generic (
	C_FAMILY          : string :="virtex2";
    C_HAS_ACLR        : integer := 1;
    C_HAS_CE          : integer := 1;
    C_HAS_SCLR        : integer := 1
    );
  port (
    -- System
    CLK               : in  std_logic;
    ACLR              : in  std_logic;
    SCLR              : in  std_logic;
    CE                : in  std_logic;
    -- Control
    FD_IN                : in  std_logic;
    BLK_SIZE          : in  std_logic_vector(9 downto 0);
    -- Data
    DATA_IN_A         : in  std_logic;
    DATA_IN_B         : in  std_logic;
    -- Status
    RFFD              : out std_logic;
    RDY               : out std_logic;
    BLK_START         : out std_logic;
    BLK_END           : out std_logic;
    -- Data
    SYST_A       : out std_logic;
    SYST_B       : out std_logic;
    PAR_Y1       : out std_logic;
    PAR_W1       : out std_logic;
    PAR_Y2       : out std_logic;
    PAR_W2       : out std_logic
    );
    end component; -- tcc_enc_802_16e_v2_1_xst

end package tcc_enc_802_16e_v2_1_xst_comp;

