-- $RCSfile $ $Date: 2009/12/04 11:46:47 $ $Revision: 1.4 $
--
-- (c) Copyright 2006 - 2008 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES

-------------------------------------------------------------------------------
-- Component statement for wrapper of behavioural model
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package cordic_v4_0_xst_comp is

----------------------------------------------------------
-- insert component declaration of top level xst file here
----------------------------------------------------------
  --core_if on component cordic_v4_0_xst
  component cordic_v4_0_xst
    generic (
    c_architecture	: integer := 1;--cordic_pack_wser_arch; 
      c_cordic_function : integer := 0;--cordic_pack_f_rotate;
      c_coarse_rotate : integer := 1;
      c_data_format : integer := 0;
      c_family : string  := "virtex4";
      c_xdevicefamily : string := "virtex4";
      c_has_ce : integer := 0;
      c_has_clk : integer := 1;
      c_has_nd : integer := 1;
      c_has_phase_in : integer := 0;
      c_has_phase_out : integer := 0;
      c_has_rdy : integer := 0;
      c_has_rfd : integer := 0;
      c_has_sclr : integer := 0;
      c_has_x_in : integer := 0;
      c_has_x_out : integer := 0;
      c_has_y_in : integer := 0;
      c_has_y_out : integer := 0;
      c_input_width : integer := 32;
      c_iterations : integer := 32;
      c_output_width : integer := 32;
      c_phase_format : integer := 0;--cordic_pack_format_rad;
      c_pipeline_mode : integer := -2;--cordic_pack_pipe_max;
      c_precision : integer := 0;
      c_reg_inputs : integer := 1;
      c_reg_outputs : integer := 1;
      c_round_mode : integer := 2;--cordic_pack_round_pos_neg_inf;
      c_scale_comp : integer := 0--cordic_pack_scale_none
  );
  port (
    X_IN        : in std_logic_vector(c_input_width-1 downto 0) := (others => '0');
    Y_IN        : in std_logic_vector(c_input_width-1 downto 0) := (others => '0');
    PHASE_IN    : in std_logic_vector(c_input_width-1 downto 0) := (others => '0');
    ND          : in std_logic := '0';
    X_OUT       : out std_logic_vector(c_output_width-1 downto 0);
    Y_OUT       : out std_logic_vector(c_output_width-1 downto 0);
    PHASE_OUT   : out std_logic_vector(c_output_width-1 downto 0);
    RDY         : out std_logic;
    RFD         : out std_logic;
    CLK         : in std_logic := '0';
    CE          : in std_logic := '1';
    SCLR        : in std_logic := '0'
  );
  --core_if off
  end component;


end cordic_v4_0_xst_comp;

