-- $RCSfile: c_mux_bit_v8_0.vhd,v $ $Revision: 1.10 $ $Date: 2008/09/08 16:50:53 $
--------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.prims_constants_v8_0.ALL;
USE XilinxCoreLib.prims_utils_v8_0.ALL;
USE XilinxCoreLib.c_reg_fd_v8_0_comp.ALL;

-- n to 1 mux

ENTITY c_mux_bit_v8_0 IS
  GENERIC (
    c_inputs        : INTEGER := 2;
    c_sel_width     : INTEGER := 1;
    c_pipe_stages   : INTEGER := 0;
    c_latency       : INTEGER := 1;
    c_height        : INTEGER := 0;
    c_ainit_val     : STRING  := "0";
    c_sinit_val     : STRING  := "0";
    c_sync_enable   : INTEGER := c_override;
    c_sync_priority : INTEGER := c_clear;
    c_has_o         : INTEGER := 0;
    c_has_q         : INTEGER := 1;
    c_has_ce        : INTEGER := 0;
    c_has_aclr      : INTEGER := 0;
    c_has_aset      : INTEGER := 0;
    c_has_ainit     : INTEGER := 0;
    c_has_sclr      : INTEGER := 0;
    c_has_sset      : INTEGER := 0;
    c_has_sinit     : INTEGER := 0;
    c_enable_rlocs  : INTEGER := 0
    ); 

  PORT (
    m     : IN  STD_LOGIC_VECTOR(c_inputs-1 DOWNTO 0)    := (OTHERS => '0');  -- input vector
    s     : IN  STD_LOGIC_VECTOR(c_sel_width-1 DOWNTO 0) := (OTHERS => '0');  -- select pin
    clk   : IN  STD_LOGIC                                := '0';  -- optional clock
    ce    : IN  STD_LOGIC                                := '1';  -- optional clock enable
    ainit : IN  STD_LOGIC                                := '0';  -- optional asynch reset to init_val
    aset  : IN  STD_LOGIC                                := '0';  -- optional asynch set to '1'
    aclr  : IN  STD_LOGIC                                := '0';  -- optional asynch clear to '0'
    sinit : IN  STD_LOGIC                                := '0';  -- optional synch reset to init_val
    sset  : IN  STD_LOGIC                                := '0';  -- optional synch set to '1'
    sclr  : IN  STD_LOGIC                                := '0';  -- optional synch set to '0'
    o     : OUT STD_LOGIC;              -- output value
    q     : OUT STD_LOGIC               -- registered output value
    );
END c_mux_bit_v8_0;

ARCHITECTURE behavioral OF C_MUX_BIT_V8_0 IS

  CONSTANT timeunit : TIME := 1 ns;

  SIGNAL intO : STD_LOGIC := 'X';
  SIGNAL intQ : STD_LOGIC := 'X';

  SIGNAL opreg_in          : STD_LOGIC := 'X';
  SIGNAL Pipe1In, Pipe1Out : STD_LOGIC := 'X';
  SIGNAL Pipe2In, Pipe2Out : STD_LOGIC := 'X';

  -- purpose: Checks for valid combinations of generics
  FUNCTION check_generics(c_inputs, c_sel_width, c_height, c_latency, c_pipe_stages,
                          c_has_o, c_has_q,
                          c_has_aclr, c_has_aset, c_has_sclr, c_has_sset,
                          c_has_ainit, c_has_sinit : INTEGER) RETURN INTEGER IS
  BEGIN  -- FUNCTION check_generics

    ASSERT c_inputs > 1 AND c_inputs < 257
      REPORT "ERROR: c_mux_bit_v8_0: Multiplexer input width must be between 2 bits and 256 bits inclusive"
      SEVERITY failure;

    ASSERT c_sel_width > 0 AND c_sel_width < 9
      REPORT "ERROR: c_mux_bit_v8_0: Select input bus width must be between 1 and 8 bits wide"
      SEVERITY failure;

    CASE c_inputs IS
      WHEN 2 => ASSERT c_sel_width = 1
                  REPORT "ERROR: c_mux_bit_v8_0: c_sel_width generic value should be 1 for this input width"
                  SEVERITY failure;
      WHEN 3 TO 4 => ASSERT c_sel_width = 2
                       REPORT "ERROR: c_mux_bit_v8_0: c_sel_width generic value should be 2 for this input width"
                       SEVERITY failure;
      WHEN 5 TO 8 => ASSERT c_sel_width = 3
                       REPORT "ERROR: c_mux_bit_v8_0: c_sel_width generic value should be 3 for this input width"
                       SEVERITY failure;
      WHEN 9 TO 16 => ASSERT c_sel_width = 4
                        REPORT "ERROR: c_mux_bit_v8_0: c_sel_width generic value should be 4 for this input width"
                        SEVERITY failure;
      WHEN 17 TO 32 => ASSERT c_sel_width = 5
                         REPORT "ERROR: c_mux_bit_v8_0: c_sel_width generic value should be 5 for this input width"
                         SEVERITY failure;
      WHEN 33 TO 64 => ASSERT c_sel_width = 6
                         REPORT "ERROR: c_mux_bit_v8_0: c_sel_width generic value should be 6 for this input width"
                         SEVERITY failure;
      WHEN 65 TO 128 => ASSERT c_sel_width = 7
                          REPORT "ERROR: c_mux_bit_v8_0: c_sel_width generic value should be 7 for this input width"
                          SEVERITY failure;
      WHEN 129 TO 256 => ASSERT c_sel_width = 8
                           REPORT "ERROR: c_mux_bit_v8_0: c_sel_width generic value should be 8 for this input width"
                           SEVERITY failure;
      WHEN OTHERS => ASSERT false
                       REPORT "ERROR: c_mux_bit_v8_0: Invalid c_inputs value detected"
                       SEVERITY failure;
    END CASE;

    ASSERT c_height = 0
      REPORT "WARNING: c_mux_bit_v8_0: c_height generic is redundant in this BaseBlock"
      SEVERITY warning;

    IF c_latency = 0 THEN
      ASSERT c_pipe_stages = 0
        REPORT "ERROR: c_mux_bit_v8_0: c_pipe_stages must be 0 when latency is zero"
        SEVERITY failure;
    ELSIF c_latency = 1 THEN
      ASSERT c_pipe_stages = 0 OR c_pipe_stages = 1
        REPORT "ERROR: c_mux_bit_v8_0: c_pipe_stages must be either 0 (no pipelining) or 1 (pipelined with async output)"
        SEVERITY failure;
    ELSIF c_latency = 2 THEN
      ASSERT c_pipe_stages = 1
        REPORT "ERROR: c_mux_bit_v8_0: c_pipe_stages must be 1 for a latency of 2 (pipelined mux)"
        SEVERITY failure;
    ELSIF c_latency = 3 THEN
      ASSERT c_pipe_stages = 2
        REPORT "ERROR: c_mux_bit_v8_0: c_pipe_stages must be 2 for a latency of 3 (pipelined mux)"
        SEVERITY failure;
    END IF;

    IF c_has_o = 0 AND c_has_q = 0 THEN  -- no outputs!
      
      ASSERT false
        REPORT "ERROR: c_mux_bit_v8_0: c_mux_bit must have at least one output - set c_has_o and/or c_has_q to 1"
        SEVERITY failure;
      
    ELSIF c_has_o /= 0 AND c_has_q /= 0 THEN
      
      ASSERT c_latency = 1
        REPORT "ERROR: c_mux_bit_v8_0: Latency can only be 1 when both registered and non-registered outputs are used"
        SEVERITY failure;
      
    ELSIF c_has_o /= 0 AND c_has_q = 0 AND c_pipe_stages = 0 THEN
      
      ASSERT c_latency = 0
        REPORT "ERROR: c_mux_bit_v8_0: Latency must be zero when no registered output is used"
        SEVERITY failure;
      ASSERT c_has_aclr = 0 AND c_has_aset = 0 AND c_has_sclr = 0 AND c_has_sset = 0
        REPORT "ERROR: c_mux_bit_v8_0: Register control generics must be set to zero when only using an asynchronous output"
        SEVERITY failure;
      
    ELSIF c_has_o /= 0 AND c_has_q = 0 AND c_pipe_stages = 1 THEN  -- non-registered output - special case for bus mux
      
      ASSERT c_has_aclr = 0 AND c_has_aset = 0 AND c_has_sclr = 0 AND c_has_sset = 0
        REPORT "ERROR: c_mux_bit_v8_0: Register control generics must be set to zero when only using an asynchronous output"
        SEVERITY failure;
      
    ELSIF c_has_o = 0 AND c_has_q /= 0 THEN

      -- Check latency generic is in valid range
      ASSERT c_latency > 0 AND c_latency < 4
        REPORT "ERROR: c_mux_bit_v8_0: c_latency generic value must be in the range 1 to 3 inclusive for a registered output"
        SEVERITY failure;

      -- Check for valid latency values depending on # inputs
      IF c_inputs < 9 THEN
        ASSERT c_latency = 1
          REPORT "ERROR: c_mux_bit_v8_0: A latency value greater than 1 is not possible for a mux size smaller than 9:1"
          SEVERITY failure;
      ELSIF c_inputs > 8 AND c_inputs < 65 THEN
        ASSERT c_latency = 1 OR c_latency = 2
          REPORT "ERROR: c_mux_bit_v8_0: Latency values of 1 or 2 (pipelined) only are allowed for this number of mux inputs"
          SEVERITY failure;
      END IF;

      -- Indicate that pipelining will be implemented
      IF c_latency = 2 OR c_latency = 3 THEN
        ASSERT false REPORT "NOTE: c_mux_bit_v8_0: Pipelining the multiplexer" SEVERITY note;
      END IF;
      
    END IF;

    ASSERT c_has_ainit = 0
      REPORT "WARNING: c_mux_bit_v8_0: AINIT pin is not supported in this core version - no AINIT functionality will be implemented"
      SEVERITY warning;

    ASSERT c_has_sinit = 0
      REPORT "WARNING: c_mux_bit_v8_0: SINIT pin is not supported in this core version - no SINIT functionality will be implemented"
      SEVERITY warning;

    IF (c_has_aclr /= 0 OR c_has_aset /= 0) AND (c_has_sclr /= 0 OR c_has_sset /= 0) THEN
      IF c_has_o /= 0 AND c_has_q /= 0 THEN
        -- In most other cases where there is only the q output, if both
        -- controls are requested, the sync controls will be implemented in the LUTs,
        -- so performance will not be degraded as another layer of logic will not be added
        ASSERT false
          REPORT "WARNING: c_mux_bit_v8_0: Including both asynchronous (aclr, aset) AND synchronous controls" &
          "(sclr, sset) can add a layer of logic and impact on performance"
          SEVERITY warning;
      END IF;
      IF c_latency > 1 THEN
        ASSERT false REPORT "WARNING: c_mux_bit_v8_0: Only synchronous controls will be passed to the pipeline registers." & CR &
          "Both asynchronous and synchronous controls will be implemented on the final output register"
          SEVERITY warning;
      END IF;
    END IF;

    RETURN 0;
  END FUNCTION check_generics;

  -- Test that the generics are valid
  CONSTANT check_gens : INTEGER RANGE 0 TO 0 := check_generics(c_inputs, c_sel_width, c_height, c_latency, c_pipe_stages,
                                                               c_has_o, c_has_q,
                                                               c_has_aclr, c_has_aset, c_has_sclr, c_has_sset,
                                                               c_has_ainit, c_has_sinit);

BEGIN
  
  p1 : PROCESS(M, S)
  BEGIN

    -- Use the selection value on the S std_logic_vector
    -- as an index, to pick the chosen value from M.

    -- also, check that S will choose a value present
    -- in M.  If it is too big, set intO to 'X'.
    -- Also, if S is an 'X', set intO to 'X'
    
    IF is_X(S) THEN
      intO <= 'X' AFTER timeunit;
    ELSIF (to_integer(UNSIGNED(S))) > C_INPUTS - 1 THEN
      intO <= 'X' AFTER timeunit;
    ELSE
      intO <= M(to_integer(UNSIGNED(S))) AFTER timeunit;
    END IF;
    
  END PROCESS;


  -- Connect together the mux, and any registers used.

  q1 : IF (C_HAS_Q = 1) AND (C_LATENCY = 1) GENERATE
    Q        <= intQ;
    opreg_in <= intO;
  END GENERATE;

  o1_lat1 : IF (C_HAS_O = 1) AND (C_LATENCY = 1) AND (c_has_q = 0) GENERATE
    O        <= intQ;
    opreg_in <= intO;
  END GENERATE;

  q2 : IF (C_HAS_Q = 1) AND (C_LATENCY = 2) GENERATE
    Q        <= intQ;
    opreg_in <= Pipe1Out;
    Pipe1In  <= intO;
  END GENERATE;

  q3 : IF (C_HAS_Q = 1) AND (C_LATENCY = 3) GENERATE
    Q        <= intQ;
    opreg_in <= Pipe2Out;
    Pipe2In  <= Pipe1Out;
    Pipe1In  <= intO;
  END GENERATE;



  -- set the outputs according to the parameters
  -- C_HAS_Q and C_HAS_O

  q0 : IF NOT (C_HAS_Q = 1) GENERATE
    Q <= 'X';
  END GENERATE;

  o0 : IF NOT (C_HAS_O = 1) GENERATE
    O <= 'X';
  END GENERATE;
  o1 : IF (C_HAS_O = 1 AND c_latency = 1 AND c_has_q = 1) OR (c_has_o = 1 AND c_latency /= 1) GENERATE
    O <= intO;
  END GENERATE;



  g1 : IF (C_HAS_Q = 1) OR (c_has_o = 1 AND c_latency = 1) GENERATE
    -- if an output register is required
    -- create a reg_fd, with full control available.

    opreg : c_reg_fd_v8_0
      GENERIC MAP(C_WIDTH         => 1,
                  C_AINIT_VAL     => C_AINIT_VAL,
                  C_SINIT_VAL     => C_SINIT_VAL,
                  C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                  C_SYNC_ENABLE   => C_SYNC_ENABLE,
                  C_HAS_CE        => C_HAS_CE,
                  C_HAS_ACLR      => C_HAS_ACLR,
                  C_HAS_ASET      => C_HAS_ASET,
                  C_HAS_AINIT     => C_HAS_AINIT,
                  C_HAS_SCLR      => C_HAS_SCLR,
                  C_HAS_SSET      => C_HAS_SSET,
                  C_HAS_SINIT     => C_HAS_SINIT,
                  C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
      PORT MAP(D(0)  => opreg_in,
               CLK   => CLK,
               CE    => CE,
               ACLR  => ACLR,
               SCLR  => SCLR,
               ASET  => ASET,
               SSET  => SSET,
               AINIT => AINIT,
               SINIT => SINIT,
               Q(0)  => intQ);

  END GENERATE;

  g2 : IF (C_HAS_Q = 1) AND (C_LATENCY > 1) GENERATE
    --if the latency value, is greater than 1, then a pipelined
    --mux is needed.  Therefore, create a pipelining register,
    --with all synchronous and asynchronous controls removed:
    --with the exception of the optional clock enable, and 
    --synchronous clear.  This will allow the pipeline to be
    --controlled.        

    gen_sync_only : IF (c_has_sclr /= 0 OR c_has_sset /= 0) GENERATE
      pipereg1 : c_reg_fd_v8_0
        GENERIC MAP(C_WIDTH         => 1,
                    C_AINIT_VAL     => C_AINIT_VAL,
                    C_SINIT_VAL     => C_SINIT_VAL,
                    C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                    C_SYNC_ENABLE   => C_SYNC_ENABLE,
                    C_HAS_CE        => C_HAS_CE,
                    C_HAS_ACLR      => 0,
                    C_HAS_ASET      => 0,
                    C_HAS_AINIT     => 0,
                    C_HAS_SCLR      => C_HAS_SCLR,
                    C_HAS_SSET      => C_HAS_SSET,
                    C_HAS_SINIT     => c_has_sinit,
                    C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
        PORT MAP(D(0)  => Pipe1In,
                 CLK   => CLK,
                 CE    => CE,
                 ACLR  => '0',
                 SCLR  => SCLR,
                 ASET  => '0',
                 SSET  => SSET,
                 AINIT => '0',
                 SINIT => SINIT,
                 Q(0)  => Pipe1Out);  
    END GENERATE gen_sync_only;

    gen_async : IF (c_has_sclr = 0 AND c_has_sset = 0) GENERATE
      pipereg1 : c_reg_fd_v8_0
        GENERIC MAP(C_WIDTH         => 1,
                    C_AINIT_VAL     => C_AINIT_VAL,
                    C_SINIT_VAL     => C_SINIT_VAL,
                    C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                    C_SYNC_ENABLE   => C_SYNC_ENABLE,
                    C_HAS_CE        => C_HAS_CE,
                    C_HAS_ACLR      => c_has_aclr,
                    C_HAS_ASET      => c_has_aset,
                    C_HAS_AINIT     => c_has_ainit,
                    C_HAS_SCLR      => 0,
                    C_HAS_SSET      => 0,
                    C_HAS_SINIT     => 0,
                    C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
        PORT MAP(D(0)  => Pipe1In,
                 CLK   => CLK,
                 CE    => CE,
                 ACLR  => ACLR,
                 SCLR  => '0',
                 ASET  => ASET,
                 SSET  => '0',
                 AINIT => AINIT,
                 SINIT => '0',
                 Q(0)  => Pipe1Out);  
    END GENERATE gen_async;

  END GENERATE;

  g3 : IF (C_HAS_Q = 1) AND (C_LATENCY > 2) GENERATE
    --if the latency value, is greater than 1, then a pipelined
    --mux is needed.  Therefore, create a pipelining register,
    --with all synchronous and asynchronous controls removed:
    --with the exception of the optional clock enable, and 
    --synchronous clear.  This will allow the pipeline to be
    --controlled.

    gen_sync_only : IF (c_has_sclr /= 0 OR c_has_sset /= 0) GENERATE
      pipereg2 : c_reg_fd_v8_0
        GENERIC MAP(C_WIDTH         => 1,
                    C_AINIT_VAL     => C_AINIT_VAL,
                    C_SINIT_VAL     => C_SINIT_VAL,
                    C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                    C_SYNC_ENABLE   => C_SYNC_ENABLE,
                    C_HAS_CE        => C_HAS_CE,
                    C_HAS_ACLR      => 0,
                    C_HAS_ASET      => 0,
                    C_HAS_AINIT     => 0,
                    C_HAS_SCLR      => C_HAS_SCLR,
                    C_HAS_SSET      => C_HAS_SSET,
                    C_HAS_SINIT     => c_has_sinit,
                    C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
        PORT MAP(D(0)  => Pipe2In,
                 CLK   => CLK,
                 CE    => CE,
                 ACLR  => '0',
                 SCLR  => SCLR,
                 ASET  => '0',
                 SSET  => SSET,
                 AINIT => '0',
                 SINIT => sinit,
                 Q(0)  => Pipe2Out);  
    END GENERATE gen_sync_only;

    gen_async : IF (c_has_sclr = 0 AND c_has_sset = 0) GENERATE
      pipereg2 : c_reg_fd_v8_0
        GENERIC MAP(C_WIDTH         => 1,
                    C_AINIT_VAL     => C_AINIT_VAL,
                    C_SINIT_VAL     => C_SINIT_VAL,
                    C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                    C_SYNC_ENABLE   => C_SYNC_ENABLE,
                    C_HAS_CE        => C_HAS_CE,
                    C_HAS_ACLR      => c_has_aclr,
                    C_HAS_ASET      => c_has_aset,
                    C_HAS_AINIT     => c_has_ainit,
                    C_HAS_SCLR      => 0,
                    C_HAS_SSET      => 0,
                    C_HAS_SINIT     => 0,
                    C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
        PORT MAP(D(0)  => Pipe2In,
                 CLK   => CLK,
                 CE    => CE,
                 ACLR  => ACLR,
                 SCLR  => '0',
                 ASET  => ASET,
                 SSET  => '0',
                 AINIT => AINIT,
                 SINIT => '0',
                 Q(0)  => Pipe2Out);  
    END GENERATE gen_async;

  END GENERATE;
  
END behavioral;
