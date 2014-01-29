-- $RCSfile: c_reg_fd_v11_0.vhd,v $ $Revision: 1.3 $ $Date: 2009/09/08 15:24:14 $
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

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.bip_utils_pkg_v2_0.ALL;


ENTITY c_reg_fd_v11_0 IS
  GENERIC (
    c_width         : INTEGER := 16;
    c_ainit_val     : STRING  := "";
    c_sinit_val     : STRING  := "";
    c_sync_priority : INTEGER := c_clear;
    c_sync_enable   : INTEGER := c_override;
    c_has_ce        : INTEGER := 0;
    c_has_aclr      : INTEGER := 0;
    c_has_aset      : INTEGER := 0;
    c_has_ainit     : INTEGER := 0;
    c_has_sclr      : INTEGER := 0;
    c_has_sset      : INTEGER := 0;
    c_has_sinit     : INTEGER := 0;
    c_enable_rlocs  : INTEGER := 1
    ); 

  PORT (
    d     : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := (OTHERS => '0');  -- input value
    clk   : IN  STD_LOGIC                            := '0';  -- clock
    ce    : IN  STD_LOGIC                            := '1';  -- clock enable
    aclr  : IN  STD_LOGIC                            := '0';  -- asynch clear.
    aset  : IN  STD_LOGIC                            := '0';  -- asynch set.
    ainit : IN  STD_LOGIC                            := '0';  -- asynch init.
    sclr  : IN  STD_LOGIC                            := '0';  -- synch clear.
    sset  : IN  STD_LOGIC                            := '0';  -- synch set.
    sinit : IN  STD_LOGIC                            := '0';  -- synch init.
    q     : OUT STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)          -- output value
    );
END c_reg_fd_v11_0;

ARCHITECTURE behavioral OF c_reg_fd_v11_0 IS

  FUNCTION check_generics (width                         : INTEGER;
                           ainit_val, sinit_val          : STRING;
                           has_aclr, has_aset, has_ainit : INTEGER;
                           has_sclr, has_sset, has_sinit : INTEGER;
                           rlocs                         : INTEGER;
                           reg_type                      : INTEGER;
                           sync_priority                 : T_REG_PRIORITY;
                           sync_enable                   : T_SYNC_ENABLE)
    RETURN INTEGER IS
  BEGIN
    ASSERT rlocs = 0 REPORT "WARNING - reg: Location constraints are not supported" SEVERITY WARNING;
    ASSERT reg_type = 1 REPORT "ERROR - reg: Only fd type registers are currently supported" SEVERITY FAILURE;
    ASSERT NOT(width < 1 OR width > 258) REPORT "ERROR - reg: Width must be in the range 1 to 258" SEVERITY FAILURE;--
    --CR206157
    ASSERT has_ainit = 0 OR (has_aclr = 0 AND has_aset = 0) REPORT "ERROR - reg: ainit is mutually exclusive with aclr or aset" SEVERITY FAILURE;
    ASSERT has_sinit = 0 OR (has_sclr = 0 AND has_sset = 0) REPORT "ERROR - reg: sinit is mutually exclusive with sclr or sset" SEVERITY FAILURE;
    ASSERT has_ainit = 0 OR (has_ainit = 1 AND ainit_val'LENGTH = width) REPORT "WARNING - reg: ainit_val will be padded with 0's or truncated to match c_width" SEVERITY WARNING;
    ASSERT has_sinit = 0 OR (has_sinit = 1 AND sinit_val'LENGTH = width) REPORT "WARNING - reg: sinit_val will be padded with 0's or truncated to match c_width" SEVERITY WARNING;
    RETURN 0;
  END check_generics;

  -- purpose: to create a compound constant to determine which primitive is required
  CONSTANT c_type           : INTEGER        := 1;
  CONSTANT ci_sync_enable   : T_SYNC_ENABLE  := fn_select_sync_enable(c_sync_enable);  -- priority of CE over SCLR/SSET/SINIT 
  CONSTANT ci_sync_priority : T_REG_PRIORITY := fn_select_sync_priority(c_sync_priority);  -- priority of CE over SCLR/SSET/SINIT 
  CONSTANT check_gens : INTEGER := check_generics(c_width, c_ainit_val, c_sinit_val,
                                                  c_has_aclr, c_has_aset, c_has_ainit,
                                                  c_has_sclr, c_has_sset, c_has_sinit,
                                                  c_enable_rlocs, c_type,
                                                  ci_sync_priority, ci_sync_enable
                                                  );

  CONSTANT timeunit : TIME := 100 ps;

  SIGNAL intQ     : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => 'X');
  -- signals for optional pins...
  SIGNAL intCE    : STD_LOGIC;
  SIGNAL intACLR  : STD_LOGIC;
  SIGNAL intASET  : STD_LOGIC;
  SIGNAL intAINIT : STD_LOGIC;
  SIGNAL intSCLR  : STD_LOGIC;
  SIGNAL intSSET  : STD_LOGIC;
  SIGNAL intSINIT : STD_LOGIC;
  SIGNAL AIV      : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := str_to_bound_slv_0(C_AINIT_VAL, C_WIDTH);
  SIGNAL SIV      : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := str_to_bound_slv_0(C_SINIT_VAL, C_WIDTH);

  CONSTANT all0s : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
  CONSTANT all1s : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => '1');
  CONSTANT allXs : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => 'X');
BEGIN

  -- Deal with optional pins...
  ce1 : IF C_HAS_CE = 1 GENERATE

    --legacy synth code had a different structure 
--    ce1_1 : IF ((((C_HAS_ACLR = 1) OR (C_HAS_ASET = 1) OR (C_HAS_AINIT = 1))
--                 AND ((C_HAS_SCLR = 1) OR (C_HAS_SSET = 1) OR (C_HAS_SINIT = 1)))
--                OR ((C_HAS_SCLR = 1) AND (C_HAS_SSET = 1) AND (C_SYNC_PRIORITY = c_set)))
--               AND (C_HAS_CE = 1) AND (C_SYNC_ENABLE = c_override) GENERATE
--      intCE <= CE OR intSCLR OR intSSET OR intSINIT;
--    END GENERATE;
--    ce1simple : IF (C_HAS_CE = 1) AND NOT(((((C_HAS_ACLR = 1) OR (C_HAS_ASET = 1) OR (C_HAS_AINIT = 1))
--                                            AND ((C_HAS_SCLR = 1) OR (C_HAS_SSET = 1) OR (C_HAS_SINIT = 1)))
--                                           OR ((C_HAS_SCLR = 1) AND (C_HAS_SSET = 1) AND (C_SYNC_PRIORITY = c_set)))
--                                          AND (C_SYNC_ENABLE = c_override)) GENERATE
--      intCE <= CE;
--    END GENERATE;


    ce1_1 : IF ((((C_HAS_ACLR = 1) OR (C_HAS_ASET = 1) OR (C_HAS_AINIT = 1))
                 AND ((C_HAS_SCLR = 1) OR (C_HAS_SSET = 1) OR (C_HAS_SINIT = 1)) AND (C_SYNC_ENABLE = 0))) GENERATE
      intCE <= CE OR intSCLR OR intSSET OR intSINIT;
    END GENERATE;
    ce1simple : IF NOT((((C_HAS_ACLR = 1) OR (C_HAS_ASET = 1) OR (C_HAS_AINIT = 1))
                 AND ((C_HAS_SCLR = 1) OR (C_HAS_SSET = 1) OR (C_HAS_SINIT = 1)) AND (C_SYNC_ENABLE = 0))) GENERATE
      intCE <= CE;
    END GENERATE;
  END GENERATE;
  ce0 : IF NOT (C_HAS_CE = 1) GENERATE
    intCE <= '1';
  END GENERATE;

  aclr1 : IF C_HAS_ACLR = 1 GENERATE
    intACLR <= ACLR;
  END GENERATE;
  aclr0 : IF NOT (C_HAS_ACLR = 1) GENERATE
    intACLR <= '0';
  END GENERATE;

  aset1 : IF C_HAS_ASET = 1 GENERATE
    intASET <= ASET;
  END GENERATE;
  aset0 : IF NOT (C_HAS_ASET = 1) GENERATE
    intASET <= '0';
  END GENERATE;

  ainit1 : IF C_HAS_AINIT = 1 GENERATE
    intAINIT <= AINIT;
  END GENERATE;
  ainit0 : IF NOT (C_HAS_AINIT = 1) GENERATE
    intAINIT <= '0';
  END GENERATE;

  sclr1 : IF C_HAS_SCLR = 1 GENERATE
    intSCLR <= SCLR;
  END GENERATE;
  sclr0 : IF NOT (C_HAS_SCLR = 1) GENERATE
    intSCLR <= '0';
  END GENERATE;

  sset1 : IF C_HAS_SSET = 1 GENERATE
    intSSET <= SSET;
  END GENERATE;
  sset0 : IF NOT (C_HAS_SSET = 1) GENERATE
    intSSET <= '0';
  END GENERATE;

  sinit1 : IF C_HAS_SINIT = 1 GENERATE
    intSINIT <= SINIT;
  END GENERATE;
  sinit0 : IF NOT (C_HAS_SINIT = 1) GENERATE
    intSINIT <= '0';
  END GENERATE;


  p1 : PROCESS(CLK, intCE, intACLR, intASET, intAINIT, intSCLR, intSSET, intSINIT)
    VARIABLE FIRST      : BOOLEAN   := TRUE;
    VARIABLE ASYNC_CTRL : BOOLEAN   := FALSE;
    VARIABLE ACTIVE_CLK : STD_LOGIC;
    VARIABLE SET_OR_CLR : STD_LOGIC := '0';
    VARIABLE intQtmp    : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
  BEGIN
    
    IF FIRST THEN
      -- Define power-up value
      IF C_HAS_ACLR = 1 THEN
        intQ <= (OTHERS => '0');
      ELSIF C_HAS_ASET = 1 THEN
        intQ <= (OTHERS => '1');
      ELSIF C_HAS_AINIT = 1 THEN
        intQ <= AIV;
      ELSIF (C_HAS_SCLR = 1) THEN
        intQ <= (OTHERS => '0');
      ELSIF (C_HAS_SSET = 1) THEN
        intQ <= (OTHERS => '1');
      ELSIF (C_HAS_SINIT = 1) THEN
        intQ <= SIV;
      ELSE
        intQ <= AIV;
      END IF;

      IF C_SYNC_PRIORITY = 0 THEN
        SET_OR_CLR := '0';              -- use SSET
      ELSE                              -- c_clear
        SET_OR_CLR := '1';              -- use SCLR
      END IF;


      ACTIVE_CLK := '1';

      FIRST := FALSE;
      
    ELSE                                -- Not FIRST
      
      intQtmp := intQ;

--                      for i in 0 to C_WIDTH-1 loop

      IF intACLR = '1' THEN             -- asynch clear
        intQtmp := all0s;

      ELSIF intACLR = '0' AND intASET = '1' THEN  -- asynch set
        intQtmp := all1s;

      ELSIF intAINIT = '1' THEN         -- Asynch init, aclr and aset = 0
        intQtmp := AIV;
        
      ELSIF intACLR = 'X' AND intASET /= '0' THEN  -- Undefined!
        intQtmp := allXs;
        
      ELSIF intACLR'EVENT AND intASET'EVENT AND intACLR'LAST_VALUE = '1'
        AND intASET'LAST_VALUE = '1' AND intACLR = '0' AND intASET = '0' THEN  -- RACE!
        intQtmp := allXs;

      ELSE
        ASYNC_CTRL := FALSE;

        IF (CLK'EVENT AND CLK'LAST_VALUE = '0' AND CLK = '1') THEN  -- rising edge!
          IF ((intCE /= '0' OR C_SYNC_ENABLE = 0) AND (SET_OR_CLR = '0' AND intSSET = 'X' AND intSCLR /= '0')) THEN
            intQtmp    := allXs;
            ASYNC_CTRL := TRUE;
          END IF;
          IF ((intCE /= '0' OR C_SYNC_ENABLE = 0) AND (SET_OR_CLR = '1' AND intSSET /= '0' AND intSCLR = 'X')) THEN
            intQtmp    := allXs;
            ASYNC_CTRL := TRUE;
          END IF;

          IF (intCE = '1' AND intSCLR /= '1' AND intSSET /= '1' AND intSINIT /= '1' AND ASYNC_CTRL = FALSE) THEN  -- Enabled
            intQtmp := D;
          ELSIF (intCE = 'X' AND intSCLR /= '1' AND intSSET /= '1' AND intSINIT /= '1' AND ASYNC_CTRL = FALSE) THEN  -- possibly enabled
            intQtmp := NOT((NOT(intQtmp XOR D) OR allXs) XOR intQtmp);
          END IF;
          IF (intSINIT = '1' AND (intCE = '1' OR C_SYNC_ENABLE = 0) AND ASYNC_CTRL = FALSE) THEN  -- SINIT
            intQtmp := SIV;
          ELSIF (intSINIT = '1' AND (intCE = 'X' AND C_SYNC_ENABLE = 1)) THEN  -- possible init
            intQtmp := NOT((NOT(intQtmp XOR SIV) OR allXs) XOR intQtmp);
          ELSIF (intSINIT = 'X' AND (intCE /= '0' OR C_SYNC_ENABLE = 0)) THEN  -- possible init
            intQtmp := NOT((NOT(intQtmp XOR SIV) OR allXs) XOR intQtmp);
          END IF;
          IF (intSCLR = '1' AND (intCE = '1' OR C_SYNC_ENABLE = 0) AND (SET_OR_CLR = '1' OR intSSET = '0') AND ASYNC_CTRL = FALSE) THEN  -- SCLR
            intQtmp := all0s;
          ELSIF (intSCLR = '1' AND (intCE = 'X' AND C_SYNC_ENABLE = 1) AND (SET_OR_CLR = '1' OR intSSET = '0')) THEN  -- possible init
            intQtmp := intQtmp AND allXs;
          ELSIF (intSCLR = 'X' AND (intCE /= '0' OR C_SYNC_ENABLE = 0) AND (SET_OR_CLR = '1' OR intSSET = '0')) THEN  -- possible init
            intQtmp := intQtmp AND allXs;
          END IF;
          IF (intSSET = '1' AND (intCE = '1' OR C_SYNC_ENABLE = 0) AND (SET_OR_CLR = '0' OR intSCLR = '0') AND ASYNC_CTRL = FALSE) THEN  -- SSET
            intQtmp := all1s;
          ELSIF (intSSET = '1' AND (intCE = 'X' AND C_SYNC_ENABLE = 1) AND (SET_OR_CLR = '0' OR intSCLR = '0')) THEN  -- possible init
            intQtmp := intQtmp OR allXs;
          ELSIF (intSSET = 'X' AND (intCE /= '0' OR C_SYNC_ENABLE = 0) AND (SET_OR_CLR = '0' OR intSCLR = '0')) THEN  -- possible init
            intQtmp := intQtmp OR allXs;
          END IF;
        ELSIF(CLK'EVENT AND ((CLK'LAST_VALUE = '0' AND CLK = 'X') OR (CLK'LAST_VALUE = 'X' AND CLK = '1'))) THEN  -- possible rising edge
          IF ((intCE /= '0' OR C_SYNC_ENABLE = 0) AND (SET_OR_CLR = '0' AND intSSET = 'X' AND intSCLR /= '0')) THEN
            intQtmp := allXs;
          END IF;
          IF ((intCE /= '0' OR C_SYNC_ENABLE = 0) AND (SET_OR_CLR = '1' AND intSSET /= '0' AND intSCLR = 'X')) THEN
            intQtmp := allXs;
          END IF;

          IF (intCE /= '0' AND intSCLR /= '1' AND intSSET /= '1' AND intSINIT /= '1') THEN  -- Enabled
            intQtmp := NOT((NOT(intQtmp XOR D) OR allXs) XOR intQtmp);
          END IF;
          IF (intSINIT /= '0' AND (intCE /= '0' OR C_SYNC_ENABLE = 0)) THEN  -- SINIT
            intQtmp := NOT((NOT(intQtmp XOR SIV) OR allXs) XOR intQtmp);
          END IF;
          IF (intSCLR /= '0' AND (intCE /= '0' OR C_SYNC_ENABLE = 0) AND (SET_OR_CLR = '1' OR intSSET = '0')) THEN  -- SCLR
            intQtmp := intQtmp AND allXs;
          END IF;
          IF (intSSET /= '0' AND (intCE /= '0' OR C_SYNC_ENABLE = 0) AND (SET_OR_CLR = '0' OR intSCLR = '0')) THEN  -- SSET
            intQtmp := intQtmp OR allXs;
          END IF;
        END IF;

        IF intACLR = '0' AND intASET = 'X' THEN  -- MAYBE asynch set
--                                              if intQtmp(i) /= '1' then
--                                                      intQtmp(i) := 'X';
--                                                      ASYNC_CTRL := TRUE;
--                                              end if;
          intQtmp := intQtmp OR allXs;
          
        ELSIF intACLR = 'X' AND intASET = '0' THEN  -- MAYBE async clr
--                                              if intQtmp(i) /= '0' then
--                                                      intQtmp(i) := 'X';
--                                                      ASYNC_CTRL := TRUE;
--                                              end if;
          intQtmp := intQtmp AND allXs;

        ELSIF intAINIT = 'X' THEN       -- MAYBE async init
--                                              if intQtmp(i) /= AIV(i) then
--                                                      intQtmp(i) := 'X';
--                                                      ASYNC_CTRL := TRUE;
--                                              end if;
          intQtmp := NOT((NOT(intQtmp XOR AIV) OR allXs) XOR intQtmp);
        END IF;
        
      END IF;
--                      end loop;
      intQ <= intQtmp;
    END IF;  -- FIRST
    
    
  END PROCESS;

  Q <= intQ AFTER timeunit;
  
END behavioral;
