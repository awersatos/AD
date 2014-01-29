-- $Id: c_mux_bit_v11_0_pkg.vhd,v 1.3 2009/09/08 15:11:46 akennedy Exp $
--------------------------------------------------------------------------------
--  (c) Copyright 1995-2005 Xilinx, Inc. All rights reserved.
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
--
-- package for constants, functions and utils specific to the mux_bit BaseBlock
--
---------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY xilinxcorelib;
USE xilinxcorelib.bip_utils_pkg_v2_0.ALL;

PACKAGE c_mux_bit_v11_0_pkg IS

  -------------------------------------------------------------------------------
  -- Component declarations for sub-muxes
  -------------------------------------------------------------------------------
  
  COMPONENT c_mux_bit_4to1 IS
    GENERIC (
      pipelined_sub_mux : BOOLEAN := false;  -- specifies if the mux feeds into a pipeline register
      c_sync_priority   : INTEGER := 1;
      c_sync_enable     : INTEGER := 0;
      c_has_aclr        : INTEGER := 0;
      c_has_aset        : INTEGER := 0;
      c_has_sclr        : INTEGER := 0;
      c_has_sset        : INTEGER := 0);
    PORT (
      data : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
      sel  : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
      sclr : IN  STD_LOGIC;
      sset : IN  STD_LOGIC;
      o    : OUT STD_LOGIC);
  END COMPONENT c_mux_bit_4to1;

  COMPONENT c_mux_bit_8to1 IS
    GENERIC (
      pipelined_sub_mux : BOOLEAN := false;  -- specifies if the mux feeds into a pipeline register
      c_sync_priority   : INTEGER := 1;
      c_sync_enable     : INTEGER := 0;
      c_has_aclr        : INTEGER := 0;
      c_has_aset        : INTEGER := 0;
      c_has_sclr        : INTEGER := 0;
      c_has_sset        : INTEGER := 0);
    PORT (
      data : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
      sel  : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
      sclr : IN  STD_LOGIC;
      sset : IN  STD_LOGIC;
      o    : OUT STD_LOGIC);
  END COMPONENT c_mux_bit_8to1;

  COMPONENT c_mux_bit_16to1 IS
    GENERIC (
      pipelined_sub_mux : BOOLEAN         := false;  -- specifies if the mux feeds into a pipeline register
      c_xdevicefamily   : string          := "no_family";
      c_sync_priority   : INTEGER         := 1;
      c_sync_enable     : INTEGER         := 0;
      c_has_aclr        : INTEGER         := 0;
      c_has_aset        : INTEGER         := 0;
      c_has_sclr        : INTEGER         := 0;
      c_has_sset        : INTEGER         := 0);
    PORT (
      data : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
      sel  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
      sclr : IN  STD_LOGIC;
      sset : IN  STD_LOGIC;
      o    : OUT STD_LOGIC);
  END COMPONENT c_mux_bit_16to1;

  COMPONENT c_mux_bit_32to1 IS
    GENERIC (
      c_xdevicefamily   : string          := "no_family";
      c_sync_priority : INTEGER         := 1;
      c_sync_enable   : INTEGER         := 0;
      c_has_aclr      : INTEGER         := 0;
      c_has_aset      : INTEGER         := 0;
      c_has_sclr      : INTEGER         := 0;
      c_has_sset      : INTEGER         := 0);
    PORT (
      data : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      sel  : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
      sclr : IN  STD_LOGIC;
      sset : IN  STD_LOGIC;
      o    : OUT STD_LOGIC);
  END COMPONENT c_mux_bit_32to1;

  COMPONENT c_mux_bit_pipereg IS
    GENERIC (
      c_mux_inputs         : INTEGER := 1;  -- number of inputs to the mux to determine o/p reg style
      c_use_reg_sync_ctrls : BOOLEAN := true;  -- allows use of component for the o/p reg too
      c_pipe_width         : INTEGER := 1;  -- width of the pipeline register (or o/p register)
      c_ainit_val          : STRING  := "0";
      c_sinit_val          : STRING  := "0";
      c_sync_enable        : INTEGER := 0;
      c_sync_priority      : INTEGER := 0;
      c_has_ce             : INTEGER := 0;
      c_has_aclr           : INTEGER := 0;
      c_has_aset           : INTEGER := 0;
      c_has_sclr           : INTEGER := 0;
      c_has_sset           : INTEGER := 0);
    PORT (
      d    : IN  STD_LOGIC_VECTOR(c_pipe_width-1 DOWNTO 0);
      clk  : IN  STD_LOGIC;
      ce   : IN  STD_LOGIC;
      aclr : IN  STD_LOGIC;
      aset : IN  STD_LOGIC;
      sclr : IN  STD_LOGIC;
      sset : IN  STD_LOGIC;
      q    : OUT STD_LOGIC_VECTOR(c_pipe_width-1 DOWNTO 0));
  END COMPONENT;

  -------------------------------------------------------------------------------
  -- End of component declarations
  -------------------------------------------------------------------------------

  FUNCTION fn_stretch_string (p_char : STRING; p_len : INTEGER) RETURN STRING;

  function check_generics(
    p_xdevicefamily : string;
    p_inputs        : integer;
    p_sel_width     : integer;
    p_height        : integer;
    p_latency       : integer;
    p_pipe_stages   : integer; 
    p_has_o         : integer;
    p_has_q         : integer; 
    p_has_aclr      : integer;
    p_has_aset      : integer;
    p_has_sclr      : integer;
    p_has_sset      : integer;
    p_has_ainit     : integer;
    p_has_sinit     : integer
    ) return integer;

END c_mux_bit_v11_0_pkg;

PACKAGE BODY c_mux_bit_v11_0_pkg IS

  -- add any function bodies here

  -- purpose: Checks for valid combinations of generics
  function check_generics(
    p_xdevicefamily : string;
    p_inputs        : integer;
    p_sel_width     : integer;
    p_height        : integer;
    p_latency       : integer;
    p_pipe_stages   : integer; 
    p_has_o         : integer;
    p_has_q         : integer; 
    p_has_aclr      : integer;
    p_has_aset      : integer;
    p_has_sclr      : integer;
    p_has_sset      : integer;
    p_has_ainit     : integer;
    p_has_sinit     : integer
    ) return integer is
  begin  -- FUNCTION check_generics

    assert p_inputs > 1 and p_inputs < 257
      report "ERROR: c_mux_bit_v11_0_xst: Multiplexer input width must be between 2 bits and 256 bits inclusive"
      severity failure;

    assert p_sel_width > 0 and p_sel_width < 9
      report "ERROR: c_mux_bit_v11_0_xst: Select input bus width must be between 1 and 8 bits wide"
      severity failure;

    case p_inputs is
      when 2 => assert p_sel_width = 1
                  report "ERROR: c_mux_bit_v11_0_xst: c_sel_width generic value should be 1 for this input width"
                  severity failure;
      when 3 to 4 => assert p_sel_width = 2
                       report "ERROR: c_mux_bit_v11_0_xst: c_sel_width generic value should be 2 for this input width"
                       severity failure;
      when 5 to 8 => assert p_sel_width = 3
                       report "ERROR: c_mux_bit_v11_0_xst: c_sel_width generic value should be 3 for this input width"
                       severity failure;
      when 9 to 16 => assert p_sel_width = 4
                        report "ERROR: c_mux_bit_v11_0_xst: c_sel_width generic value should be 4 for this input width"
                        severity failure;
      when 17 to 32 => assert p_sel_width = 5
                         report "ERROR: c_mux_bit_v11_0_xst: c_sel_width generic value should be 5 for this input width"
                         severity failure;
      when 33 to 64 => assert p_sel_width = 6
                         report "ERROR: c_mux_bit_v11_0_xst: c_sel_width generic value should be 6 for this input width"
                         severity failure;
      when 65 to 128 => assert p_sel_width = 7
                          report "ERROR: c_mux_bit_v11_0_xst: c_sel_width generic value should be 7 for this input width"
                          severity failure;
      when 129 to 256 => assert p_sel_width = 8
                           report "ERROR: c_mux_bit_v11_0_xst: c_sel_width generic value should be 8 for this input width"
                           severity failure;
      when others => assert false
                       report "ERROR: c_mux_bit_v11_0_xst: Invalid c_inputs value detected"
                       severity failure;
    end case;

    assert not(has_LUT6(p_xdevicefamily) and (p_has_aclr /= 0 or p_has_aset /= 0))
      report "ERROR: c_mux_bit_v11_0_xst: aclr and aset are not supported for LUT6 families"
      severity error;

    assert p_height = 0
      report "WARNING: c_mux_bit_v11_0_xst: c_height generic is redundant in this BaseBlock"
      severity warning;

    if p_latency = 0 then
      assert p_pipe_stages = 0
        report "ERROR: c_mux_bit_v11_0_xst: c_pipe_stages must be 0 when latency is zero"
        severity failure;
    elsif p_latency = 1 then
      assert p_pipe_stages = 0 or p_pipe_stages = 1
        report "ERROR: c_mux_bit_v11_0_xst: c_pipe_stages must be either 0 (no pipelining) or 1 (pipelined with async output)"
        severity failure;
    elsif p_latency = 2 then
      assert p_pipe_stages = 1
        report "ERROR: c_mux_bit_v11_0_xst: c_pipe_stages must be 1 for a latency of 2 (pipelined mux)"
        severity failure;
    elsif p_latency = 3 then
      assert p_pipe_stages = 2
        report "ERROR: c_mux_bit_v11_0_xst: c_pipe_stages must be 2 for a latency of 3 (pipelined mux)"
        severity failure;
    end if;

    if p_has_o = 0 and p_has_q = 0 then  -- no outputs!
      
      assert false
        report "ERROR: c_mux_bit_v11_0_xst: c_mux_bit must have at least one output - set c_has_o and/or c_has_q to 1"
        severity failure;
      
    elsif p_has_o /= 0 and p_has_q /= 0 then
      
      assert p_latency = 1
        report "ERROR: c_mux_bit_v11_0_xst: Latency can only be 1 when both registered and non-registered outputs are used"
        severity failure;
      
    elsif p_has_o /= 0 and p_has_q = 0 and p_pipe_stages = 0 then
      
      assert p_latency = 0
        report "ERROR: c_mux_bit_v11_0_xst: Latency must be zero when no registered output is used"
        severity failure;
      assert p_has_aclr = 0 and p_has_aset = 0 and p_has_sclr = 0 and p_has_sset = 0
        report "ERROR: c_mux_bit_v11_0_xst: Register control generics must be set to zero when only using an asynchronous output"
        severity failure;
      
    elsif p_has_o /= 0 and p_has_q = 0 and p_pipe_stages = 1 then  -- non-registered output - special case for bus mux
      
      assert p_has_aclr = 0 and p_has_aset = 0 and p_has_sclr = 0 and p_has_sset = 0
        report "ERROR: c_mux_bit_v11_0_xst: Register control generics must be set to zero when only using an asynchronous output"
        severity failure;
      
    elsif p_has_o = 0 and p_has_q /= 0 then

      -- Check latency generic is in valid range
      assert p_latency > 0 and p_latency < 4
        report "ERROR: c_mux_bit_v11_0_xst: c_latency generic value must be in the range 1 to 3 inclusive for a registered output"
        severity failure;

      -- Check for valid latency values depending on # inputs
      if p_inputs < 9 then
        assert p_latency = 1
          report "ERROR: c_mux_bit_v11_0_xst: A latency value greater than 1 is not possible for a mux size smaller than 9:1"
          severity failure;
      elsif p_inputs > 8 and p_inputs < 65 then
        assert p_latency = 1 or p_latency = 2
          report "ERROR: c_mux_bit_v11_0_xst: Latency values of 1 or 2 (pipelined) only are allowed for this number of mux inputs"
          severity failure;
      end if;

      -- Indicate that pipelining will be implemented
      if p_latency = 2 or p_latency = 3 then
        assert false report "NOTE: c_mux_bit_v11_0_xst: Pipelining the multiplexer" severity note;
      end if;
      
    end if;

    assert p_has_ainit = 0
      report "WARNING: c_mux_bit_v11_0_xst: AINIT pin is not supported in this core version - no AINIT functionality will be implemented"
      severity warning;

    assert p_has_sinit = 0
      report "WARNING: c_mux_bit_v11_0_xst: SINIT pin is not supported in this core version - no SINIT functionality will be implemented"
      severity warning;

    if (p_has_aclr /= 0 or p_has_aset /= 0) and (p_has_sclr /= 0 or p_has_sset /= 0) then
      if p_has_o /= 0 and p_has_q /= 0 then
        -- In most other cases where there is only the q output, if both
        -- controls are requested, the sync controls will be implemented in the LUTs,
        -- so performance will not be degraded as another layer of logic will not be added
        assert false
          report "WARNING: c_mux_bit_v11_0_xst: Including both asynchronous (aclr, aset) AND synchronous controls" &
          "(sclr, sset) can add a layer of logic and impact on performance"
          severity warning;
      end if;
      if p_latency > 1 then
        assert false report "WARNING: c_mux_bit_v11_0_xst: Only synchronous controls will be passed to the pipeline registers." & CR &
          "Both asynchronous and synchronous controls will be implemented on the final output register"
          severity warning;
      end if;
    end if;

    return 0;
  end function check_generics;
  
  FUNCTION fn_stretch_string(p_char : STRING; p_len : INTEGER) RETURN STRING IS
    VARIABLE ret_val : STRING(1 TO p_len);
  BEGIN
    FOR i IN 1 TO p_len LOOP
      ret_val(i) := p_char(1);
    END LOOP;
    RETURN ret_val;
  END fn_stretch_string;
  
END c_mux_bit_v11_0_pkg;
