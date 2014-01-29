-- $Header
--
--  Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc.
--  All rights reserved.
--  
---------------------------------------------------------------
-- Synthesizable model
---------------------------------------------------------------
-- Raison d'etre
--

library ieee;
use ieee.std_logic_1164.all;

LIBRARY xilinxcorelib;
USE xilinxcorelib.prims_constants_v9_1.ALL;  --for poor man's enumerated types
USE xilinxcorelib.prims_utils_v9_1.ALL;  --for poor man's enumerated types
USE xilinxcorelib.pkg_baseblox_v9_1.ALL;  --for readable enumerated types
USE xilinxcorelib.c_reg_fd_v9_1_xst_comp.all;

entity dds_compiler_v2_1_reg is
  generic(
    C_LATENCY     : integer := 1;
    C_HAS_CE      : integer := 0;
    C_SYNC_ENABLE : integer := 0;
    C_HAS_SCLR    : integer := 0;
    C_HAS_SINIT   : integer := 0;
    C_POR_MODE    : integer := 0;
    C_SINIT_VAL   : string  := "0";
    C_AINIT_VAL   : string  := "0";
    C_WIDTH       : integer := 1
    );
  port (
    CLK   : in  std_logic := '0';
    CE    : in  std_logic := '0';
    SCLR  : in  std_logic := '0';
    SINIT : in  std_logic := '0';
    D     : in  std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');
    Q     : out std_logic_vector(C_WIDTH-1 downto 0) := (others => '0')
    );
end dds_compiler_v2_1_reg;

architecture synth of dds_compiler_v2_1_reg is

  CONSTANT sinit_val : STD_LOGIC_VECTOR(c_width DOWNTO 1) := str_to_bound_slv_0(c_sinit_val, c_width);
  CONSTANT ainit_val : STD_LOGIC_VECTOR(c_width DOWNTO 1) := str_to_bound_slv_0(c_ainit_val, c_width);
  function fn_get_por (
    p_has_sclr  : integer;
    p_has_sinit : integer;
    p_por_mode  : integer;
    p_sinit_val : STD_LOGIC_VECTOR(c_width DOWNTO 1);
    p_ainit_val : STD_LOGIC_VECTOR(c_width DOWNTO 1)
    )
    return std_logic_vector is
      variable ret_val : std_logic_vector(C_WIDTH-1 downto 0);
      variable ret_x : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');
  begin  -- fn_get_por
    ret_val := p_ainit_val;
    if p_por_mode = 1 then
      return p_sinit_val;
    elsif p_has_sinit = 1 then
      return ret_x;
    elsif p_has_sclr = 1 then
      for i in C_WIDTH-1 downto 0 loop
        ret_val(i) := '0';
      end loop;
    end if;
    return ret_val;
  end fn_get_por;
  constant c_por : std_logic_vector(C_WIDTH-1 downto 0) := fn_get_por(C_HAS_SCLR,
                                                                      C_HAS_SINIT,
                                                                      C_POR_MODE,
                                                                      SINIT_VAL,
                                                                      AINIT_VAL
                                                                      );
--  constant c_por : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');

  type t_pipe is array (0 to C_LATENCY)  of std_logic_vector(C_WIDTH-1 downto 0);
  function fn_pipe_clean (
    p_por : std_logic_vector(C_WIDTH-1 downto 0)
    )
    return t_pipe is
    variable ret_val : t_pipe;
  begin  -- fn_pipe_clean
    for i in 0 to C_LATENCY loop
      ret_val(i) := p_por;
    end loop;
    return ret_val;
  end fn_pipe_clean;
  constant c_pipe_init : t_pipe := fn_pipe_clean(c_por);
  signal pipe  : t_pipe := c_pipe_init;

begin
  --there are only three numbers in the universe: 0, 1 and many.
  --0 gets a simple wirethrough
  --1 gets a single register
  --2 gets a for-next loop of registers.
  --in this case, only 0 and many count!

  opt_no_reg: if C_LATENCY = 0 generate
    Q <= D;
  end generate opt_no_reg;
  
--  opt_has_reg: if C_LATENCY = 1 generate
--    i_reg : c_reg_fd_v9_1_XST
--      generic map (
--        C_WIDTH       => C_WIDTH,
--        C_HAS_CE      => C_HAS_CE,
--        C_HAS_SCLR    => C_HAS_SCLR,
--        C_HAS_SINIT   => C_HAS_SINIT,
--        C_SINIT_VAL   => c_sinit_x_val,
----        C_HAS_AINIT   => C_HAS_AINIT,
--        C_AINIT_VAL   => C_AINIT_VAL,
--        C_SYNC_ENABLE => C_SYNC_ENABLE
----        C_HAS_ACLR    => C_HAS_ACLR
--        )
--      port map (
--        CLK  => CLK,
--        CE   => CE,
--        SCLR => SCLR,
----        ACLR => ACLR,
--        SINIT => SINIT,
----        AINIT => AINIT,
--        D    => D,
--        Q    => Q
--        );
--  end generate opt_has_reg;
  
  opt_has_pipe: if C_LATENCY > 0 generate

    pipe(0) <= d;

-------------------------------------------------------------------------------
-- IMPORTANT - C_SYNC_ENABLE NOT HANDLED. IT IS REQUIRED THAT A HIGHER LEVEL PASS
               --APPROPRIATELY MODIFIED CE AND SCLR
-------------------------------------------------------------------------------
    
    i_pipe : for stage in 1 to C_LATENCY generate
      reg : process(clk)
      BEGIN  -- PROCESS reg
        IF rising_edge(clk) THEN
          IF C_HAS_SCLR = 1 and sclr = '1' THEN
            pipe(stage) <= (OTHERS => '0');
          ELSIF C_HAS_SINIT = 1 and sinit = '1' THEN
            pipe(stage) <= (others => 'X');
          ELSIF ce = '1' THEN
            pipe(stage) <= pipe(stage-1);
          END IF;
        END IF;
      END PROCESS reg;
    end generate i_pipe;

    q <= pipe(C_LATENCY);

  end generate opt_has_pipe;


end synth;

