-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 4.1
--  \   \        Filename: $RCSfile: floating_point_v5_0_xst_comp.vhd,v $           
--  /   /        Date Last Modified: $Date: 2009/12/04 11:46:54 $ 
-- /___/   /\    Date Created: Dec 2005
-- \   \  /  \
--  \___\/\___\
-- 
--Device  : All
--Library : xilinxcorelib
--Purpose : Floating-point operator component declaration for XST
--
--------------------------------------------------------------------------------    
--  (c) Copyright 2005-2009 Xilinx, Inc. All rights reserved.
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
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.floating_point_v5_0_consts.all;

package floating_point_v5_0_xst_comp is

  component floating_point_v5_0_xst is
    generic (
      C_XDEVICEFAMILY         : string  := C_XDEVICEFAMILY_DEFAULT;
      C_HAS_ADD               : integer := C_HAS_ADD_DEFAULT;
      C_HAS_SUBTRACT          : integer := C_HAS_SUBTRACT_DEFAULT;
      C_HAS_MULTIPLY          : integer := C_HAS_MULTIPLY_DEFAULT;
      C_HAS_DIVIDE            : integer := C_HAS_DIVIDE_DEFAULT;
      C_HAS_SQRT              : integer := C_HAS_SQRT_DEFAULT;
      C_HAS_COMPARE           : integer := C_HAS_COMPARE_DEFAULT;
      C_HAS_FIX_TO_FLT        : integer := C_HAS_FIX_TO_FLT_DEFAULT;
      C_HAS_FLT_TO_FIX        : integer := C_HAS_FLT_TO_FIX_DEFAULT;
      C_HAS_FLT_TO_FLT        : integer := C_HAS_FLT_TO_FLT_DEFAULT; 
      C_A_WIDTH               : integer := C_A_WIDTH_DEFAULT;
      C_A_FRACTION_WIDTH      : integer := C_A_FRACTION_WIDTH_DEFAULT;
      C_B_WIDTH               : integer := C_B_WIDTH_DEFAULT;
      C_B_FRACTION_WIDTH      : integer := C_B_FRACTION_WIDTH_DEFAULT;
      C_RESULT_WIDTH          : integer := C_RESULT_WIDTH_DEFAULT;
      C_RESULT_FRACTION_WIDTH : integer := C_RESULT_FRACTION_WIDTH_DEFAULT;
      C_COMPARE_OPERATION     : integer := C_COMPARE_OPERATION_DEFAULT;   
      C_LATENCY               : integer := C_LATENCY_DEFAULT;
      C_OPTIMIZATION          : integer := C_OPTIMIZATION_DEFAULT;
      C_MULT_USAGE            : integer := C_MULT_USAGE_DEFAULT;
      C_RATE                  : integer := C_RATE_DEFAULT;
      C_HAS_ACLR              : integer := C_HAS_ACLR_DEFAULT;
      C_HAS_CE                : integer := C_HAS_CE_DEFAULT;
      C_HAS_SCLR              : integer := C_HAS_SCLR_DEFAULT;
      C_HAS_A_NEGATE          : integer := C_HAS_A_NEGATE_DEFAULT;
      C_HAS_B_NEGATE          : integer := C_HAS_B_NEGATE_DEFAULT;   
      C_HAS_A_ND              : integer := C_HAS_A_ND_DEFAULT;
      C_HAS_A_RFD             : integer := C_HAS_A_RFD_DEFAULT;
      C_HAS_B_ND              : integer := C_HAS_B_ND_DEFAULT;
      C_HAS_B_RFD             : integer := C_HAS_B_RFD_DEFAULT;          
      C_HAS_OPERATION_ND      : integer := C_HAS_OPERATION_ND_DEFAULT;
      C_HAS_OPERATION_RFD     : integer := C_HAS_OPERATION_RFD_DEFAULT; 
      C_HAS_RDY               : integer := C_HAS_RDY_DEFAULT;
      C_HAS_CTS               : integer := C_HAS_CTS_DEFAULT;
      C_HAS_UNDERFLOW         : integer := C_HAS_UNDERFLOW_DEFAULT;
      C_HAS_OVERFLOW          : integer := C_HAS_OVERFLOW_DEFAULT;
      C_HAS_INVALID_OP        : integer := C_HAS_INVALID_OP_DEFAULT;
      C_HAS_INEXACT           : integer := C_HAS_INEXACT_DEFAULT;
      C_HAS_DIVIDE_BY_ZERO    : integer := C_HAS_DIVIDE_BY_ZERO_DEFAULT;
      C_HAS_STATUS            : integer := C_HAS_STATUS_DEFAULT;
      C_HAS_EXCEPTION         : integer := C_HAS_EXCEPTION_DEFAULT;
      C_STATUS_EARLY          : integer := C_STATUS_EARLY_DEFAULT;
      C_SPEED                 : integer := C_SPEED_DEFAULT;
      C_ROUNDING_MODE         : integer := FLT_PT_RND_TO_NEAREST_EVEN
    );
    port (
      A                       : in std_logic_vector(C_A_WIDTH-1 downto 0);
      B                       : in std_logic_vector(C_B_WIDTH-1 downto 0):=(others=>'0');
      A_NEGATE                : in std_logic:='0';
      B_NEGATE                : in std_logic:='0';
      OPERATION               : in std_logic_vector(FLT_PT_OPERATION_WIDTH-1 downto 0):=(others=>'0');
      A_ND                    : in std_logic:='1';
      A_RFD                   : out std_logic;
      B_ND                    : in std_logic:='1';
      B_RFD                   : out std_logic;
      OPERATION_ND            : in std_logic:='1';
      OPERATION_RFD           : out std_logic;
      CLK                     : in std_logic:='0';
      SCLR                    : in std_logic:='0';
      ACLR                    : in std_logic:='0';
      CE                      : in std_logic:='1';
      RESULT                  : out std_logic_vector(C_RESULT_WIDTH-1 downto 0);
      STATUS                  : out std_logic_vector(FLT_PT_STATUS_WIDTH-1 downto 0);
      EXCEPTION               : out std_logic;
      UNDERFLOW               : out std_logic;
      OVERFLOW                : out std_logic;
      INVALID_OP              : out std_logic;
      INEXACT                 : out std_logic;
      DIVIDE_BY_ZERO          : out std_logic;
      RDY                     : out std_logic;
      CTS                     : in std_logic:='1'
      );
  
  end component;
end floating_point_v5_0_xst_comp;





