--------------------------------------------------------------------------------
-- $RCSfile: tcc_enc_802_16e_v3_0_xst_comp.vhd,v $
--------------------------------------------------------------------------------
--  (c) Copyright 2004-2006, 2009 Xilinx, Inc. All rights reserved.
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

package tcc_enc_802_16e_v3_0_xst_comp is

  component tcc_enc_802_16e_v3_0_xst is
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
    end component; -- tcc_enc_802_16e_v3_0_xst

end package tcc_enc_802_16e_v3_0_xst_comp;

