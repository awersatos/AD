-- $RCSfile: c_twos_comp_v8_0.vhd,v $ $Revision: 1.10 $ $Date: 2008/09/08 16:50:56 $
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
-- of this text at all times. (c) Copyright 1995-2004 Xilinx, Inc.
-- All rights reserved.
--
-- Filename - c_twos_comp_v8_0.vhd
-- Author - Xilinx
-- Creation - 2 Feb 1999
--
-- Description - This file contains the behavior for
--                               the C_TWOS_COMP_V8_0 core

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.prims_constants_v8_0.ALL;
USE XilinxCoreLib.prims_utils_v8_0.ALL;
use XilinxCoreLib.pkg_baseblox_v8_0.all;
USE XilinxCoreLib.c_reg_fd_v8_0_comp.ALL;

-- (A)synchronous 2's complimenter
--

ENTITY c_twos_comp_v8_0 IS
  GENERIC(
    c_width         : INTEGER := 16;
    c_ainit_val     : STRING  := "";                
    c_sinit_val     : STRING  := "";                
    c_bypass_enable : INTEGER := c_override;
    c_bypass_low    : INTEGER := 0;
    c_sync_priority : INTEGER := c_clear;
    c_sync_enable   : INTEGER := c_override;
    c_pipe_stages   : INTEGER := 0;
    c_has_bypass    : INTEGER := 0;
    c_has_ce        : INTEGER := 0;
    c_has_aclr      : INTEGER := 0;
    c_has_aset      : INTEGER := 0;
    c_has_ainit     : INTEGER := 0;
    c_has_sclr      : INTEGER := 0;
    c_has_sset      : INTEGER := 0;
    c_has_sinit     : INTEGER := 0;
    c_has_s         : INTEGER := 0;
    c_has_q         : INTEGER := 1;
    c_enable_rlocs  : INTEGER := 1
    );

  PORT (
    a      : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := (OTHERS => '0');  -- signed input value!
    bypass : IN  STD_LOGIC                            := '0';  -- control of negation : '0' = negate input
    clk    : IN  STD_LOGIC                            := '0';  -- clock
    ce     : IN  STD_LOGIC                            := '1';  -- clock enable
    aclr   : IN  STD_LOGIC                            := '0';  -- asynch init.
    aset   : IN  STD_LOGIC                            := '0';  -- asynch set.
    ainit  : IN  STD_LOGIC                            := '0';  -- asynch init.
    sclr   : IN  STD_LOGIC                            := '0';  -- synch init.
    sset   : IN  STD_LOGIC                            := '0';  -- synch set.             
    sinit  : IN  STD_LOGIC                            := '0';  -- synch init.
    s      : OUT STD_LOGIC_VECTOR(c_width DOWNTO 0);           -- asynch output
    q      : OUT STD_LOGIC_VECTOR(c_width DOWNTO 0)  -- registered output value
    );
END c_twos_comp_v8_0;

ARCHITECTURE behavioral OF c_twos_comp_v8_0 IS

  FUNCTION check_generics (width                         : INTEGER;
                           ainit_val, sinit_val          : STRING;
                           has_aclr, has_aset, has_ainit : INTEGER;
                           has_sclr, has_sset, has_sinit : INTEGER;
                           has_q, has_s                  : INTEGER;
                           has_bypass                    : INTEGER;
                           rlocs                         : INTEGER;
                           bypass_enable                 : T_BYPASS_ENABLE;
                           sync_priority                 : T_REG_PRIORITY;
                           sync_enable                   : T_SYNC_ENABLE)
    RETURN INTEGER IS
  BEGIN
    ASSERT rlocs = 0 REPORT "Location constraints are not supported" SEVERITY WARNING;
    ASSERT NOT(width < 2 OR width > 256) REPORT "Width must be in the range 2 to 256" SEVERITY FAILURE;
    ASSERT has_ainit = 0 OR (has_aclr = 0 AND has_aset = 0) REPORT "ainit is mutually exclusive with aclr or aset" SEVERITY FAILURE;
    ASSERT has_sinit = 0 OR (has_sclr = 0 AND has_sset = 0) REPORT "sinit is mutually exclusive with sclr or sset" SEVERITY FAILURE;
    ASSERT NOT((c_has_aclr /= 0 OR c_has_aset /= 0 OR c_has_ainit /= 0) AND (c_has_sclr /= 0 OR c_has_sset /= 0 OR c_has_sinit /= 0))
      REPORT "Twos Complementer: Including both asynchronous (aclr, aset or ainit) and synchronous (sclr, sset, sinit) controls will add a layer of logic and impact performance"
      SEVERITY WARNING;
    ASSERT has_ainit = 0 OR (has_ainit = 1 AND ainit_val'LENGTH = width) REPORT "ainit_val will be padded with 0's or truncated to match c_width" SEVERITY WARNING;
    ASSERT has_sinit = 0 OR (has_sinit = 1 AND sinit_val'LENGTH = width) REPORT "sinit_val will be padded with 0's or truncated to match c_width" SEVERITY WARNING;
    ASSERT NOT (has_q = 0 AND (has_aset /= 0 OR has_aclr /= 0 OR has_ainit /= 0)) REPORT "Asynchronous controls only apply to registered outputs" SEVERITY FAILURE;
    ASSERT NOT (has_q = 0 AND (has_sset /= 0 OR has_sclr /= 0 OR has_sinit /= 0)) REPORT "Synchronous controls only apply to registered outputs" SEVERITY FAILURE;

    RETURN 0;
  END check_generics;

  CONSTANT ci_bypass_enable : T_BYPASS_ENABLE := fn_select_bypass_enable(c_bypass_enable);  -- priority of CE over SCLR/SSET/SINIT 
  CONSTANT ci_sync_enable   : T_SYNC_ENABLE   := fn_select_sync_enable(c_sync_enable);  -- priority of CE over SCLR/SSET/SINIT 
  CONSTANT ci_sync_priority : T_REG_PRIORITY  := fn_select_sync_priority(c_sync_priority);  -- priority of CE over SCLR/SSET/SINIT 
  CONSTANT check_gens : INTEGER := check_generics(
    width         => c_width,
    ainit_val     => c_ainit_val,
    sinit_val     => c_sinit_val,
    has_aclr      => c_has_aclr,
    has_aset      => c_has_aset,
    has_ainit     => c_has_ainit,
    has_sclr      => c_has_sclr,
    has_sset      => c_has_sset,
    has_sinit     => c_has_sinit,
    has_q         => c_has_q,
    has_s         => c_has_s,
    has_bypass    => c_has_bypass,
    rlocs         => c_enable_rlocs,
    bypass_enable => ci_bypass_enable,
    sync_priority => ci_sync_priority,
    sync_enable   => ci_sync_enable
    );

  CONSTANT timeunit : TIME := 1 NS;

  -- signals for optional pins...
  SIGNAL intBYPASS : STD_LOGIC;
  SIGNAL intCE     : STD_LOGIC;
  SIGNAL intQCE    : STD_LOGIC;
  SIGNAL intS      : STD_LOGIC_VECTOR(C_WIDTH DOWNTO 0);
  SIGNAL intQ      : STD_LOGIC_VECTOR(C_WIDTH DOWNTO 0);

  -- pipelining signal
  SIGNAL intQpipeend : STD_LOGIC_VECTOR(C_WIDTH DOWNTO 0);
  TYPE   pipetype IS ARRAY (C_PIPE_STAGES+2 DOWNTO 0) OF STD_LOGIC_VECTOR(C_WIDTH DOWNTO 0);
  SIGNAL intQpipe    : pipetype := (OTHERS => (OTHERS => '0'));

BEGIN

  ce1 : IF C_HAS_CE = 1 GENERATE
    intCE <= CE;
  END GENERATE;
  ce0 : IF NOT (C_HAS_CE = 1) GENERATE
    intCE <= '1';
  END GENERATE;

  bypass1 : IF C_HAS_BYPASS = 1 GENERATE
    byp0 : IF C_BYPASS_LOW = 1 GENERATE
      intBYPASS <= NOT BYPASS;
    END GENERATE;
    byp1 : IF C_BYPASS_LOW = 0 GENERATE
      intBYPASS <= BYPASS;
    END GENERATE;
  END GENERATE;
  bypass0 : IF NOT (C_HAS_BYPASS = 1) GENERATE
    intBYPASS <= '0';
  END GENERATE;

  qce1 : IF C_HAS_CE = 1 GENERATE
    byp1 : IF C_HAS_BYPASS = 1 GENERATE
      bypov0 : IF C_BYPASS_ENABLE = c_override GENERATE
        intQCE <= CE OR intBYPASS;
      END GENERATE;
      bypov1 : IF C_BYPASS_ENABLE = c_no_override GENERATE
        intQCE <= CE;
      END GENERATE;
    END GENERATE;
    byp0 : IF C_HAS_BYPASS = 0 GENERATE
      intQCE <= CE;
    END GENERATE;
  END GENERATE;
  qce0 : IF C_HAS_CE = 0 GENERATE
    intQCE <= '1';
  END GENERATE;

  p1 : PROCESS
    VARIABLE tmpS : UNSIGNED(C_WIDTH DOWNTO 0);
    VARIABLE Aone : UNSIGNED(C_WIDTH DOWNTO 0) := (OTHERS => '0');
  BEGIN
    Aone(0) := '1';
    IF intBYPASS = '1' THEN
      intS(C_WIDTH-1 DOWNTO 0) <= A            AFTER timeunit;
      intS(C_WIDTH)            <= A(C_WIDTH-1) AFTER timeunit;
    ELSIF intBYPASS = 'X' OR is_X(A) THEN
      intS <= (OTHERS => 'X') AFTER timeunit;
    ELSE                                -- intBYPASS = 0
      tmpS := UNSIGNED(NOT(A(C_WIDTH-1) & A)) + Aone;
      intS <= STD_LOGIC_VECTOR(tmpS) AFTER timeunit;
    END IF;

    WAIT ON A, intBYPASS;
  END PROCESS;

  s1 : IF C_HAS_S = 1 GENERATE
    S <= intS;
  END GENERATE;
  s0 : IF NOT (C_HAS_S = 1) GENERATE
    S <= (OTHERS => 'X');
  END GENERATE;

  qreg1 : IF C_HAS_Q = 1 GENERATE
    reg1 : c_reg_fd_v8_0 GENERIC MAP (C_WIDTH         => C_WIDTH+1,
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
      PORT MAP(D     => intQpipeend,
               CLK   => CLK,
               CE    => intQCE,
               ACLR  => ACLR,
               SCLR  => SCLR,
               ASET  => ASET,
               SSET  => SSET,
               AINIT => AINIT,
               SINIT => SINIT,
               Q     => intQ);
  END GENERATE;

  pipeq : PROCESS (CLK)
  BEGIN
    
    IF intCE = '1' AND CLK = '1' AND CLK'LAST_VALUE /= 'X' AND C_PIPE_STAGES > 1 THEN
      pipeloop : FOR p IN 2 TO C_PIPE_STAGES-1 LOOP
        intQpipe(p) <= intQpipe(p+1);
      END LOOP;  -- pipeloop
      intQpipe(C_PIPE_STAGES) <= intS;
    ELSIF (intCE = 'X' OR (CLK = 'X' AND CLK'LAST_VALUE = '0') OR (CLK = '1' AND CLK'LAST_VALUE = 'X')) AND C_PIPE_STAGES > 1 THEN
      pipeloopx : FOR p IN 2 TO C_PIPE_STAGES-1 LOOP
        pipeloopxinner : FOR p1 IN 0 TO C_WIDTH-1 LOOP
          IF intQpipe(p)(p1) /= intQpipe(p+1)(p1) THEN
            intQpipe(p)(p1) <= 'X';
          END IF;
        END LOOP;  -- pipeloopxinner
      END LOOP;  -- pipeloopx
      pipeloopxlast : FOR p1 IN 0 TO C_WIDTH-1 LOOP
        IF intQpipe(C_PIPE_STAGES)(p1) /= intS(p1) THEN
          intQpipe(C_PIPE_STAGES)(p1) <= 'X';
        END IF;
      END LOOP;  -- pipeloopxlast
    END IF;
    
  END PROCESS;  -- pipeq

  ps1 : IF C_PIPE_STAGES < 2 GENERATE
    intQpipeend <= intS;
  END GENERATE;
  ps1b : IF C_PIPE_STAGES > 1 GENERATE
    intQpipeend <= intQpipe(2);
  END GENERATE;

  q1 : IF C_HAS_Q = 1 GENERATE
    Q <= intQ;
  END GENERATE;
  q0 : IF NOT (C_HAS_Q = 1) GENERATE
    Q <= (OTHERS => 'X');
  END GENERATE;
  
END behavioral;
