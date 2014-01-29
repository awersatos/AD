-------------------------------------------------------------------------------
--
--  (c) Copyright 2004, 2009 Xilinx, Inc. All rights reserved.
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
-- $Header: /devl/xcs/repo/env/Databases/ip/src2/L/addr_gen_802_16e_v3_0/simulation/addr_gen_802_16e_v3_0_xst_comp.vhd,v 1.3 2009/09/08 15:07:58 akennedy Exp $
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

package  addr_gen_802_16e_v3_0_xst_comp is

  component addr_gen_802_16e_v3_0_xst is
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
  end component; -- addr_gen_802_16e_v3_0_xst

end package  addr_gen_802_16e_v3_0_xst_comp;
