-- $RCSfile: c_mux_bit_v11_0.vhd,v $ $Revision: 1.3 $ $Date: 2009/09/08 15:11:46 $
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

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.bip_utils_pkg_v2_0.ALL;
USE XilinxCoreLib.c_reg_fd_v11_0_comp.ALL;
use xilinxcorelib.c_mux_bit_v11_0_pkg.all;

-- n to 1 mux

ENTITY c_mux_bit_v11_0 IS
  GENERIC (
    c_family        : string  := "virtex2";
    c_xdevicefamily : string  := "virtex2";
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
END c_mux_bit_v11_0;

ARCHITECTURE behavioral OF c_mux_bit_v11_0 IS

  CONSTANT timeunit : TIME := 100 ps;

  SIGNAL intO : STD_LOGIC := 'X';
  SIGNAL intQ : STD_LOGIC := 'X';

  SIGNAL opreg_in          : STD_LOGIC := 'X';
  SIGNAL Pipe1In, Pipe1Out : STD_LOGIC := 'X';
  SIGNAL Pipe2In, Pipe2Out : STD_LOGIC := 'X';

  -- Test that the generics are valid and get the device family first of all
  constant check_gens : integer range 0 to 0 := check_generics(
    p_xdevicefamily => c_xdevicefamily,
    p_inputs        => c_inputs,
    p_sel_width     => c_sel_width,
    p_height        => c_height,
    p_latency       => c_latency,
    p_pipe_stages   => c_pipe_stages,
    p_has_o         => c_has_o,
    p_has_q         => c_has_q,
    p_has_aclr      => c_has_aclr,
    p_has_aset      => c_has_aset,
    p_has_sclr      => c_has_sclr,
    p_has_sset      => c_has_sset,
    p_has_ainit     => c_has_ainit,
    p_has_sinit     => c_has_sinit
    );

BEGIN
  
  p1 : PROCESS(M, S)
  BEGIN

    -- Use the selection value on the S std_logic_vector
    -- as an index, to pick the chosen value from M.

    -- also, check that S will choose a value present
    -- in M.  If it is too big, set intO to 'X'.
    -- Also, if S is an 'X', set intO to 'X'
    
    IF is_X(S) THEN
      intO <= 'X';-- AFTER timeunit;
    ELSIF (to_integer(UNSIGNED(S))) > C_INPUTS - 1 THEN
      intO <= 'X';-- AFTER timeunit;
    ELSE
      intO <= M(to_integer(UNSIGNED(S)));-- AFTER timeunit;
    END IF;
    
  END PROCESS;


  -- Connect together the mux, and any registers used.

  q1 : IF (C_HAS_Q = 1) AND (C_LATENCY = 1) GENERATE
    Q        <= intQ AFTER timeunit;
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

    opreg : c_reg_fd_v11_0
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
      pipereg1 : c_reg_fd_v11_0
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
      pipereg1 : c_reg_fd_v11_0
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
      pipereg2 : c_reg_fd_v11_0
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
      pipereg2 : c_reg_fd_v11_0
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
