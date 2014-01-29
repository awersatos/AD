-- $RCSfile: c_gate_bit_v9_1.vhd,v $ $Revision: 1.7 $ $Date: 2008/09/08 19:36:46 $
-- Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under license
-- from Xilinx, Inc., and may be used, copied and/or
-- disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc. Xilinx hereby grants you
-- a license to use this text/file solely for design, simulation,
-- implementation and creation of design files limited
-- to Xilinx devices or technologies. Use with non-Xilinx
-- devices or technologies is expressly prohibited and
-- immediately terminates your license unless covered by
-- a separate agreement.
--
-- Xilinx is providing this design, code, or information
-- "as is" solely for use in developing programs and
-- solutions for Xilinx devices. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard, Xilinx is making no
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for
-- obtaining any rights you may require for your implementation.
-- Xilinx expressly disclaims any warranty whatsoever with
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied
-- warranties of merchantability or fitness for a particular
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications are
-- expressly prohibited.
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc.
-- All rights reserved.

--
-- Filename - c_gate_bit_v9_1.vhd
-- Author - Xilinx
-- Creation - 7 Jan 1999
--
-- Description - This file contains the behavior for the 
--                               the c_gate_bit_v9_1 core

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.prims_constants_v9_1.ALL;
USE XilinxCoreLib.prims_utils_v9_1.ALL;
USE XilinxCoreLib.pkg_baseblox_v9_1.ALL;
USE XilinxCoreLib.c_reg_fd_v9_1_comp.ALL;

-- (A)synchronous multi-input gate
--

ENTITY c_gate_bit_v9_1 IS
  GENERIC(
    c_gate_type      : INTEGER := c_and;
    c_inputs         : INTEGER := 2;
    c_input_inv_mask : STRING  := "";
    c_pipe_stages    : INTEGER := 1;
    c_ainit_val      : STRING  := "0";
    c_sinit_val      : STRING  := "0";
    c_sync_priority  : INTEGER := c_clear;
    c_sync_enable    : INTEGER := c_override;
    c_has_o          : INTEGER := 0;
    c_has_q          : INTEGER := 1;
    c_has_ce         : INTEGER := 0;
    c_has_aclr       : INTEGER := 0;
    c_has_aset       : INTEGER := 0;
    c_has_ainit      : INTEGER := 0;
    c_has_sclr       : INTEGER := 0;
    c_has_sset       : INTEGER := 0;
    c_has_sinit      : INTEGER := 0;
    c_enable_rlocs   : INTEGER := 0
    );

  PORT (
    i     : IN  STD_LOGIC_VECTOR(c_inputs-1 DOWNTO 0) := (OTHERS => '0');  -- input vector
    clk   : IN  STD_LOGIC                             := '0';  -- clock
    ce    : IN  STD_LOGIC                             := '1';  -- clock enable
    aclr  : IN  STD_LOGIC                             := '0';  -- asynch init.
    aset  : IN  STD_LOGIC                             := '0';  -- asynch set.
    ainit : IN  STD_LOGIC                             := '0';  -- asynch init.
    sclr  : IN  STD_LOGIC                             := '0';  -- synch init.
    sset  : IN  STD_LOGIC                             := '0';  -- synch set.             
    sinit : IN  STD_LOGIC                             := '0';  -- synch init.
    o     : OUT STD_LOGIC;              -- asynch output
    q     : OUT STD_LOGIC;              -- registered output value
    t     : IN  STD_LOGIC                             := '0';  -- tri-state input for buft
    en    : IN  STD_LOGIC                             := '0'  -- enable input for bufe
    );          
END c_gate_bit_v9_1;


ARCHITECTURE behavioral OF c_gate_bit_v9_1 IS

  CONSTANT max_width  : INTEGER := 256;
  
  FUNCTION fn_check_generics (
    width                         : INTEGER;
    gate_type                     : INTEGER;
    pipe_levs                     : INTEGER;
    input_inv_mask                : STRING;
    ainit_val, sinit_val          : STRING;
    has_aclr, has_aset, has_ainit : INTEGER;
    has_sclr, has_sset, has_sinit : INTEGER;
    has_q, has_o                  : INTEGER;
    rlocs                         : INTEGER;
    sync_priority                 : INTEGER;
    sync_enable                   : INTEGER )
    RETURN INTEGER IS
  BEGIN
    ASSERT has_aclr = 0 OR has_aclr = 1 REPORT "c_has_aclr  must be 0 or 1" SEVERITY FAILURE;
    ASSERT has_aset = 0 OR has_aset = 1 REPORT "c_has_aset  must be 0 or 1" SEVERITY FAILURE;
    ASSERT has_ainit = 0 OR has_ainit = 1 REPORT "c_has_ainit must be 0 or 1" SEVERITY FAILURE;
    ASSERT has_sclr = 0 OR has_sclr = 1 REPORT "c_has_sclr  must be 0 or 1" SEVERITY FAILURE;
    ASSERT has_sset = 0 OR has_sset = 1 REPORT "c_has_sset  must be 0 or 1" SEVERITY FAILURE;
    ASSERT has_sinit = 0 OR has_sinit = 1 REPORT "c_has_sinit must be 0 or 1" SEVERITY FAILURE;
    ASSERT has_o = 0 OR has_o = 1 REPORT "c_has_o must be 0 or 1" SEVERITY FAILURE;
    ASSERT has_q = 0 OR has_q = 1 REPORT "c_has_q must be 0 or 1" SEVERITY FAILURE;
    ASSERT has_o = 1 OR has_q = 1 REPORT "Module must have c_has_o = 1 or c_has_q = 1" SEVERITY FAILURE;
    ASSERT gate_type >= 0 AND gate_type <= 6 REPORT "gate type value out of range 0 to 6" SEVERITY FAILURE;
    ASSERT pipe_levs >= 0 AND pipe_levs <= 3 REPORT "gate type value out of range 0 to 6" SEVERITY FAILURE;
    ASSERT rlocs = 0
      REPORT "Location constraints are not supported"
      SEVERITY WARNING;
    ASSERT NOT(width < 2 OR width > max_width)
      REPORT "Width must be in the range 2 to 256"
      SEVERITY FAILURE;
    ASSERT has_ainit = 0 OR (has_aclr = 0 AND has_aset = 0)
      REPORT "ainit is mutually exclusive with aclr or aset"
      SEVERITY FAILURE;
    ASSERT has_sinit = 0 OR (has_sclr = 0 AND has_sset = 0)
      REPORT "sinit is mutually exclusive with sclr or sset"
      SEVERITY FAILURE;
    ASSERT NOT((has_aclr /= 0 OR has_aset /= 0 OR has_ainit /= 0) AND (has_sclr /= 0 OR has_sset /= 0 OR has_sinit /= 0))
      REPORT "Bit_gate: Including both asynchronous (aclr, aset or ainit) and synchronous (sclr, sset, sinit) controls will add a layer of logic and impact performance"
      SEVERITY WARNING;
    ASSERT has_ainit = 0 OR (has_ainit = 1 AND ainit_val'LENGTH = width)
      REPORT "ainit_val will be padded with 0's or truncated to match c_inputs"
      SEVERITY WARNING;
    ASSERT has_sinit = 0 OR (has_sinit = 1 AND sinit_val'LENGTH = width)
      REPORT "sinit_val will be padded with 0's or truncated to match c_inputs"
      SEVERITY WARNING;
    ASSERT NOT ((has_q = 0 AND c_pipe_stages = 0) AND (has_aset /= 0 OR has_aclr /= 0 OR has_ainit /= 0))
      REPORT "Asynchronous controls only apply to registered outputs"
      SEVERITY FAILURE;
    ASSERT NOT ((has_q = 0 AND c_pipe_stages = 0) AND (has_sset /= 0 OR has_sclr /= 0 OR has_sinit /= 0))
      REPORT "Synchronous controls only apply to registered outputs"
      SEVERITY FAILURE;
    
    RETURN 0;
  END fn_check_generics;

  CONSTANT check_gen : INTEGER := fn_check_generics(
    c_inputs, c_gate_type, c_pipe_stages,
    c_input_inv_mask, c_ainit_val, c_sinit_val,
    c_has_aclr, c_has_aset, c_has_ainit,
    c_has_sclr, c_has_sset, c_has_sinit,
    c_has_q, c_has_o,
    c_enable_rlocs, c_sync_priority, c_sync_enable);

  FUNCTION fn_has_actrl(has_actrl : INTEGER;
                        has_sclr  : INTEGER;
                        has_sset  : INTEGER;
                        has_sinit : INTEGER)
    RETURN INTEGER IS
    VARIABLE ret_val : INTEGER := 0;
  BEGIN
    ret_val := has_actrl;
    IF has_sclr /= 0 OR has_sset /= 0 OR has_sinit /= 0 THEN
      ret_val := 0;
    END IF;
    RETURN ret_val;
  END;

  FUNCTION fn_pipe_init_val (
    init_val  : CHARACTER;
    width     : INTEGER)
    RETURN STRING IS
    variable ret_val : STRING(width DOWNTO 1);
  BEGIN
    for i IN 1 TO width loop
      ret_val(i) := init_val;
    END loop;
    RETURN ret_val;
  END;

  CONSTANT pipe_has_aclr  : INTEGER := fn_has_actrl(c_has_aclr, c_has_sclr, c_has_sset, c_has_sinit);
  CONSTANT pipe_has_aset  : INTEGER := fn_has_actrl(c_has_aset, c_has_sclr, c_has_sset, c_has_sinit);
  CONSTANT pipe_has_ainit : INTEGER := fn_has_actrl(c_has_ainit, c_has_sclr, c_has_sset, c_has_sinit);

  CONSTANT input_mask : STD_LOGIC_VECTOR(c_inputs-1 DOWNTO 0) := str_to_bound_slv_0(c_input_inv_mask, c_inputs);
  CONSTANT timeunit   : TIME                                := 100 ps;

  CONSTANT ainit_val : STD_LOGIC_VECTOR(1 DOWNTO 1) := str_to_bound_slv_0(c_ainit_val, 1);
  CONSTANT sinit_val : STD_LOGIC_VECTOR(1 DOWNTO 1) := str_to_bound_slv_0(c_sinit_val, 1);

  CONSTANT por_val : std_logic_vector(0 DOWNTO 0) := fn_get_por_value(
    c_has_aclr, c_has_aset, c_has_ainit,
    c_has_sclr, c_has_sset, c_has_sinit,
    ainit_val, sinit_val, 1);

  CONSTANT pipe_ainit_val : STRING(c_pipe_stages DOWNTO 1) := fn_pipe_init_val(
    c_ainit_val(1), c_pipe_stages);
  CONSTANT pipe_sinit_val : STRING(c_pipe_stages DOWNTO 1) := fn_pipe_init_val(
    c_sinit_val(1), c_pipe_stages);

  
  -- signals for optional pins...
  SIGNAL intO        : STD_LOGIC := por_val(0);
  SIGNAL intQpipeend : STD_LOGIC;
  SIGNAL intQ        : STD_LOGIC := por_val(0);
  SIGNAL intQpipe    : STD_LOGIC_VECTOR(C_PIPE_STAGES+2 DOWNTO 0) := (OTHERS => por_val(0));
  SIGNAL intCE       : STD_LOGIC;

  SIGNAL intT  : STD_LOGIC;
  SIGNAL intEN : STD_LOGIC;
  
BEGIN
  
  ce1 : IF C_HAS_CE = 1 GENERATE
    intCE <= CE;
  END GENERATE;
  ce0 : IF NOT (C_HAS_CE = 1) GENERATE
    intCE <= '1';
  END GENERATE;

  t0 : IF C_GATE_TYPE = 8 GENERATE
    intT <= T;
  END GENERATE;

  en0 : IF C_GATE_TYPE = 9 GENERATE
    intEN <= EN;
  END GENERATE;

  p1 : PROCESS (I, T, EN)
    VARIABLE tmpres : STD_LOGIC := '1';  -- partial result
    
  BEGIN
    
    IF is_X(I) THEN  -- There are X's in the input vector - needs special checking
      IF C_GATE_TYPE = 0 OR C_GATE_TYPE = 1 THEN
        tmpres := '1';                  -- AND or NAND gate
      ELSE
        tmpres := '0';                  -- Other sort of gate
      END IF;
      l1 : FOR j IN C_INPUTS - 1 DOWNTO 0 LOOP
--        IF input_mask(C_INPUTS-j) = '1' THEN  -- INV_MASK will be (1 to something)
        IF input_mask(j) = '1' THEN  -- INV_MASK will be (1 to something)
          IF C_GATE_TYPE = 0 THEN       -- AND gate
            IF I(j) /= 'X' THEN
              tmpres := tmpres AND NOT I(j);
            ELSIF tmpres = '1' THEN  -- Only make tmpres = 'X' if not already = '0'
              tmpres := 'X';
            END IF;
          ELSIF C_GATE_TYPE = 1 THEN    -- NAND gate
            IF I(j) /= 'X' THEN
              tmpres := tmpres AND NOT I(j);
            ELSIF tmpres = '1' THEN
              tmpres := 'X';
            END IF;
          ELSIF C_GATE_TYPE = 2 THEN    -- OR gate
            IF I(j) /= 'X' THEN
              tmpres := tmpres OR NOT I(j);
            ELSIF tmpres = '0' THEN  -- Only make tmpres = 'X' if not already = '1'
              tmpres := 'X';
            END IF;
          ELSIF C_GATE_TYPE = 3 THEN    -- NOR gate
            IF I(j) /= 'X' THEN
              tmpres := tmpres OR NOT I(j);
            ELSIF tmpres = '0' THEN  -- Only make tmpres = 'X' if not already = '1'
              tmpres := 'X';
            END IF;
          ELSIF C_GATE_TYPE = 4 THEN    -- XOR gate
            tmpres := tmpres XOR NOT I(j);
          ELSIF C_GATE_TYPE = 5 THEN    -- XNOR gate
            tmpres := tmpres XOR NOT I(j);
          ELSE                          -- gate is either Invertor or Buffer.
            tmpres := 'X';
          END IF;
        ELSE                            -- no invert on input bit
          IF C_GATE_TYPE = 0 THEN       -- AND gate
            IF I(j) /= 'X' THEN
              tmpres := tmpres AND I(j);
            ELSIF tmpres = '1' THEN  -- Only make tmpres = 'X' if not already = '0'
              tmpres := 'X';
            END IF;
          ELSIF C_GATE_TYPE = 1 THEN    -- NAND gate
            IF I(j) /= 'X' THEN
              tmpres := tmpres AND I(j);
            ELSIF tmpres = '1' THEN  -- Only make tmpres = 'X' if not already = '0'
              tmpres := 'X';
            END IF;
          ELSIF C_GATE_TYPE = 2 THEN    -- OR gate
            IF I(j) /= 'X' THEN
              tmpres := tmpres OR I(j);
            ELSIF tmpres = '0' THEN  -- Only make tmpres = 'X' if not already = '1'
              tmpres := 'X';
            END IF;
          ELSIF C_GATE_TYPE = 3 THEN    -- NOR gate
            IF I(j) /= 'X' THEN
              tmpres := tmpres OR I(j);
            ELSIF tmpres = '0' THEN  -- Only make tmpres = 'X' if not already = '1'
              tmpres := 'X';
            END IF;
          ELSIF C_GATE_TYPE = 4 THEN    -- XOR gate
            tmpres := tmpres XOR I(j);
          ELSIF C_GATE_TYPE = 5 THEN    -- XNOR gate
            tmpres := tmpres XOR I(j);
          ELSE
            tmpres := 'X';
          END IF;
        END IF;
      END LOOP;  -- l1
    ELSE                                -- No 'X's on input vector
      IF C_GATE_TYPE = 0 OR C_GATE_TYPE = 1 THEN
        tmpres := '1';                  -- AND or NAND gate
      ELSE
        tmpres := '0';                  -- Other sort of gate
      END IF;
      l2 : FOR j IN C_INPUTS - 1 DOWNTO 0 LOOP
--        IF input_mask(C_INPUTS-j) = '1' THEN  -- INV_MASK will be (1 to something)
        IF input_mask(j) = '1' THEN  -- INV_MASK will be (1 to something)        
          IF C_GATE_TYPE = 0 THEN       -- AND gate
            tmpres := tmpres AND NOT I(j);
          ELSIF C_GATE_TYPE = 1 THEN    -- NAND gate
            tmpres := tmpres AND NOT I(j);
          ELSIF C_GATE_TYPE = 2 THEN    -- OR gate
            tmpres := tmpres OR NOT I(j);
          ELSIF C_GATE_TYPE = 3 THEN    -- NOR gate
            tmpres := tmpres OR NOT I(j);
          ELSIF C_GATE_TYPE = 4 THEN    -- XOR gate
            tmpres := tmpres XOR NOT I(j);
          ELSIF C_GATE_TYPE = 5 THEN    -- XNOR gate
            tmpres := tmpres XOR NOT I(j);
          ELSIF (C_GATE_TYPE = 7 ) THEN       -- BUF gate
            tmpres := NOT I(j);
          ELSIF (C_GATE_TYPE = 8) THEN  -- BUFT
            IF T = '0' THEN
              tmpres := NOT I(j);
            ELSE
              tmpres := '1';
            END IF;
          ELSIF (C_GATE_TYPE = 9) THEN  -- BUFE
            IF EN = '0' THEN
              tmpres := NOT I(j);
            ELSE
              tmpres := '1';
            END IF;
          ELSE                          -- INV gate
            tmpres := NOT I(j);
          END IF;
        ELSE                            -- no invert on input bit
          IF C_GATE_TYPE = 0 THEN       -- AND gate
            tmpres := tmpres AND I(j);
          ELSIF C_GATE_TYPE = 1 THEN    -- NAND gate
            tmpres := tmpres AND I(j);
          ELSIF C_GATE_TYPE = 2 THEN    -- OR gate
            tmpres := tmpres OR I(j);
          ELSIF C_GATE_TYPE = 3 THEN    -- NOR gate
            tmpres := tmpres OR I(j);
          ELSIF C_GATE_TYPE = 4 THEN    -- XOR gate
            tmpres := tmpres XOR I(j);
          ELSIF C_GATE_TYPE = 5 THEN    -- XNOR gate
            tmpres := tmpres XOR I(j);
          ELSIF (C_GATE_TYPE = 7 ) THEN       -- BUF gate
            tmpres := I(j);
          ELSIF (C_GATE_TYPE = 8) THEN  -- BUFT
            IF T = '0' THEN
              tmpres := I(j);
            ELSE
              tmpres := '1';
            END IF;
          ELSIF (C_GATE_TYPE = 9) THEN  -- BUFE
            IF EN = '0' THEN
              tmpres := I(j);
            ELSE
              tmpres := '1';
            END IF;
          ELSE                          -- INV gate
            tmpres := I(j);
          END IF;
        END IF;
      END LOOP;  -- l2
      
    END IF;

    --CR204755
    IF C_GATE_TYPE = 1 OR C_GATE_TYPE = 3 OR C_GATE_TYPE = 5 OR C_GATE_TYPE = 6 THEN
      tmpres := NOT tmpres;
    END IF;
    intO <= tmpres;-- AFTER timeunit;
    
  END PROCESS;  -- p1

  o1 : IF C_HAS_O = 1 GENERATE
    O <= intQpipeend;
  END GENERATE o1;
  o0 : IF NOT (C_HAS_O = 1) GENERATE
    O <= 'X';
  END GENERATE;

  qreg1 : IF (C_HAS_Q = 1) GENERATE
    reg1 : c_reg_fd_v9_1
      GENERIC MAP (
        C_WIDTH         => 1,
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
        C_ENABLE_RLOCS  => C_ENABLE_RLOCS
        )
      PORT MAP(
        D(0)  => intQpipeend,
        CLK   => CLK,
        CE    => CE,
        ACLR  => ACLR,
        SCLR  => SCLR,
        ASET  => ASET,
        SSET  => SSET,
        AINIT => AINIT,
        SINIT => SINIT,
        Q(0)  => intQ
        );
  END GENERATE;

  --the next line works even for no pipe
  intQpipe(C_PIPE_STAGES) <= intO;

  --only instantiate regs if there's a pipe delay.
  qpipereg1 : IF (C_PIPE_STAGES > 0) GENERATE
    reg1 : c_reg_fd_v9_1
      GENERIC MAP (
        C_WIDTH         => C_PIPE_STAGES,
        C_AINIT_VAL     => pipe_ainit_val,
        C_SINIT_VAL     => pipe_sinit_val,
        C_SYNC_PRIORITY => C_SYNC_PRIORITY,
        C_SYNC_ENABLE   => C_SYNC_ENABLE,
        C_HAS_CE        => C_HAS_CE,
        C_HAS_ACLR      => pipe_has_aclr,
        C_HAS_ASET      => pipe_has_aset,
        C_HAS_AINIT     => pipe_has_ainit,
        C_HAS_SCLR      => C_HAS_SCLR,
        C_HAS_SSET      => C_HAS_SSET,
        C_HAS_SINIT     => C_HAS_SINIT,
        C_ENABLE_RLOCS  => C_ENABLE_RLOCS
        )
      PORT MAP(
        D     => intQpipe(C_PIPE_STAGES DOWNTO 1),
        CLK   => CLK,
        CE    => CE,
        ACLR  => ACLR,
        SCLR  => SCLR,
        ASET  => ASET,
        SSET  => SSET,
        AINIT => AINIT,
        SINIT => SINIT,
        Q     => intQpipe(C_PIPE_STAGES-1 DOWNTO 0)
        );
  END GENERATE;


  --CR204755
--  inv_func : IF C_GATE_TYPE = 1 OR C_GATE_TYPE = 3 OR C_GATE_TYPE = 5 OR C_GATE_TYPE = 6 GENERATE
--    intQpipeend <= NOT intQpipe(0);
--  END GENERATE;
--  rect_func : IF NOT(C_GATE_TYPE = 1 OR C_GATE_TYPE = 3 OR C_GATE_TYPE = 5 OR C_GATE_TYPE = 6) GENERATE
--    intQpipeend <= intQpipe(0);
--  END GENERATE;
intQpipeend <= intQpipe(0);

  q1 : IF C_HAS_Q = 1 GENERATE
    Q <= intQ AFTER timeunit;
  END GENERATE;
  q0 : IF NOT (C_HAS_Q = 1) GENERATE
    Q <= 'X';
  END GENERATE;
  
END behavioral;

