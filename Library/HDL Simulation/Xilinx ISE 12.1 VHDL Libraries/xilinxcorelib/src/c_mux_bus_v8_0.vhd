-- $RCSfile: c_mux_bus_v8_0.vhd,v $ $Revision: 1.10 $ $Date: 2008/09/08 16:50:54 $
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

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.prims_constants_v8_0.ALL;
USE XilinxCoreLib.prims_utils_v8_0.ALL;
USE XilinxCoreLib.c_reg_fd_v8_0_comp.ALL;

-- n*m to 1*m mux

ENTITY c_mux_bus_v8_0 IS
  GENERIC(
    c_width         : INTEGER := 16;
    c_inputs        : INTEGER := 2;
    c_mux_type      : INTEGER := 0;
    c_sel_width     : INTEGER := 1;
    c_ainit_val     : STRING  := "0000000000000000";
    c_sinit_val     : STRING  := "0000000000000000";
    c_sync_priority : INTEGER := 1;
    c_sync_enable   : INTEGER := 0;
    c_latency       : INTEGER := 1;
    c_height        : INTEGER := 0;
    c_has_o         : INTEGER := 0;
    c_has_q         : INTEGER := 1;
    c_has_ce        : INTEGER := 0;
    c_has_en        : INTEGER := 0;
    c_has_aclr      : INTEGER := 0;
    c_has_aset      : INTEGER := 0;
    c_has_ainit     : INTEGER := 0;
    c_has_sclr      : INTEGER := 0;
    c_has_sset      : INTEGER := 0;
    c_has_sinit     : INTEGER := 0;
    c_enable_rlocs  : INTEGER := 0
    ); 

  PORT (
    ma    : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mb    : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mc    : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    md    : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    me    : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mf    : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mg    : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mh    : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    maa   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mab   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mac   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mad   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mae   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    maf   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mag   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mah   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mba   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mbb   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mbc   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mbd   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mbe   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mbf   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mbg   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mbh   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mca   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mcb   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mcc   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mcd   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mce   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mcf   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mcg   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    mch   : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)     := (OTHERS => '0');  -- input vector
    s     : IN  STD_LOGIC_VECTOR(c_sel_width-1 DOWNTO 0) := (OTHERS => '0');  -- select pin
    clk   : IN  STD_LOGIC                                := '0';  -- optional clock
    ce    : IN  STD_LOGIC                                := '1';  -- optional clock enable
    en    : IN  STD_LOGIC                                := '0';  -- optional buft enable
    aset  : IN  STD_LOGIC                                := '0';  -- optional asynch set to '1'
    aclr  : IN  STD_LOGIC                                := '0';  -- asynch init.
    ainit : IN  STD_LOGIC                                := '0';  -- optional asynch reset to init_val
    sset  : IN  STD_LOGIC                                := '0';  -- optional synch set to '1'
    sclr  : IN  STD_LOGIC                                := '0';  -- synch init.
    sinit : IN  STD_LOGIC                                := '0';  -- optional synch reset to init_val
    o     : OUT STD_LOGIC_VECTOR(c_width-1 DOWNTO 0);  -- output value
    q     : OUT STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)  -- registered output value
    );
END c_mux_bus_v8_0;

ARCHITECTURE behavioral OF C_MUX_BUS_V8_0 IS

  CONSTANT timeunit : TIME := 1 ns;

  SIGNAL   intO  : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => 'X');
  SIGNAL   intQ  : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => 'X');
  CONSTANT n_sel : INTEGER                              := C_SEL_WIDTH;
  -- signals for optional pins...
  SIGNAL   intEN : STD_LOGIC;

  SIGNAL Pipe1In, Pipe1Out : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
  SIGNAL opreg_in          : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);

  SIGNAL intMA, intMB, intMC, intMD, intME, intMF, intMG, intMH         : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
  SIGNAL intMAA, intMAB, intMAC, intMAD, intMAE, intMAF, intMAG, intMAH : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
  SIGNAL intMBA, intMBB, intMBC, intMBD, intMBE, intMBF, intMBG, intMBH : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
  SIGNAL intMCA, intMCB, intMCC, intMCD, intMCE, intMCF, intMCG, intMCH : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);

  -- purpose: Checks for valid combinations of generics
  FUNCTION check_generics RETURN INTEGER IS
  BEGIN  -- FUNCTION check_generics

    ASSERT c_inputs > 1 AND c_inputs < 33
      REPORT "ERROR: c_mux_bus_v8_0: Number of buses to be multiplexed must be in the range 2 to 32"
      SEVERITY failure;

    ASSERT c_width > 0 AND c_width < 257
      REPORT "ERROR: c_mux_bus_v8_0: Input bus widths must be in the range 1 to 256"
      SEVERITY failure;
    
    ASSERT c_sel_width > 0 AND c_sel_width < 6
      REPORT "ERROR: c_mux_bus_v8_0: Select bus width must be in the range 1 to 5"
      SEVERITY failure;
    
    CASE c_inputs IS
      WHEN 2 => ASSERT c_sel_width = 1
                  REPORT "ERROR: c_mux_bus_v8_0: c_sel_width generic value should be 1 for this input width"
                  SEVERITY failure;
      WHEN 3 TO 4 => ASSERT c_sel_width = 2
                       REPORT "ERROR: c_mux_bus_v8_0: c_sel_width generic value should be 2 for this input width"
                       SEVERITY failure;
      WHEN 5 TO 8 => ASSERT c_sel_width = 3
                       REPORT "ERROR: c_mux_bus_v8_0: c_sel_width generic value should be 3 for this input width"
                       SEVERITY failure;
      WHEN 9 TO 16 => ASSERT c_sel_width = 4
                        REPORT "ERROR: c_mux_bus_v8_0: c_sel_width generic value should be 4 for this input width"
                        SEVERITY failure;
      WHEN 17 TO 32 => ASSERT c_sel_width = 5
                         REPORT "ERROR: c_mux_bus_v8_0: c_sel_width generic value should be 5 for this input width"
                         SEVERITY failure;
      WHEN OTHERS => ASSERT false
                       REPORT "ERROR: c_mux_bus_v8_0: Invalid c_inputs value detected"
                       SEVERITY failure;
    END CASE;

    ASSERT c_height = 0
      REPORT "WARNING: c_mux_bus_v8_0: c_height generic is not supported in this version"
      SEVERITY warning;
    
    IF c_mux_type = c_lut_based THEN

      IF c_has_o = 0 AND c_has_q = 0 THEN  -- no outputs!
        ASSERT false
          REPORT "ERROR: c_mux_bus_v8_0: c_mux_bus must have at least one output bus - set c_has_o and/or c_has_q to 1"
          SEVERITY failure;
      ELSIF c_has_o /= 0 AND c_has_q /= 0 THEN
        ASSERT c_latency = 1
          REPORT "ERROR: c_mux_bus_v8_0: Latency can only be 1 when both registered and non-registered outputs are used"
          SEVERITY failure;
      ELSIF c_has_o /= 0 AND c_has_q = 0 THEN
        ASSERT c_latency = 0
          REPORT "ERROR: c_mux_bus_v8_0: Latency must be zero when no registered output is used"
          SEVERITY failure;
      ELSIF c_has_o = 0 AND c_has_q /= 0 THEN
        ASSERT c_latency > 0 AND c_latency < 3
          REPORT "ERROR: c_mux_bus_v8_0: c_latency generic value must be 1 or 2 for a registered output only"
          SEVERITY failure;
        -- Check for valid latency values depending on # inputs
        IF c_inputs < 9 THEN
          ASSERT c_latency = 1
            REPORT "ERROR: c_mux_bus_v8_0: Mux pipelining is not possible for a mux size smaller than 9:1"
            SEVERITY failure;
        ELSIF c_inputs > 8 AND c_inputs < 33 THEN
          ASSERT c_latency = 1 OR c_latency = 2
            REPORT "ERROR: c_mux_bus_v8_0: Latency values of 1 or 2 (pipelined) only are allowed for mux sizes between 9:1 and 32:1"
            SEVERITY failure;
        END IF;
        -- Indicate to the user that pipelining is being implemented
        IF c_latency = 2 AND c_inputs > 8 AND c_inputs < 33 THEN
          ASSERT false
            REPORT "NOTE: c_mux_bus_v8_0: Pipelining the multiplexer"
            SEVERITY note;
        END IF;
      END IF;

      IF c_has_ainit /= 0 THEN
        ASSERT c_has_aset = 0 AND c_has_aclr = 0
          REPORT "ERROR: c_mux_bus_v8_0: ASET and/or ACLR cannot exist in conjunction with AINIT"
          SEVERITY failure;
      END IF;

      IF c_has_sinit /= 0 THEN
        ASSERT c_has_sset = 0 AND c_has_sclr = 0
          REPORT "ERROR: c_mux_bus_v8_0: SSET and/or SCLR cannot exist in conjunction with SINIT"
          SEVERITY failure;
      END IF;

      IF c_has_aclr /= 0 OR c_has_aset /= 0 THEN
        ASSERT c_has_ainit = 0
          REPORT "ERROR: c_mux_bus_v8_0: AINIT cannot exist in conjunction with ACLR and/or ASET"
          SEVERITY failure;
      END IF;

      IF c_has_sclr /= 0 OR c_has_sset /= 0 THEN
        ASSERT c_has_sinit = 0
          REPORT "ERROR: c_mux_bus_v8_0: SINIT cannot exist in conjunction with SCLR and/or SSET"
          SEVERITY failure;
      END IF;

      IF (c_has_aclr /= 0 OR c_has_aset /= 0 OR c_has_ainit /= 0) AND (c_has_sclr /= 0 OR c_has_sset /= 0 OR c_has_sinit /= 0) THEN
        ASSERT false
          REPORT "WARNING: c_mux_bus_v8_0: Including both asynchronous (ACLR, ASET, AINIT) AND synchronous controls" &
          "(SCLR, SSET, SINIT) will add a layer of logic and impact performance"
          SEVERITY warning;
      END IF;

      ASSERT c_has_en = 0
        REPORT "WARNING: c_mux_bus_v8_0: Output enable pin is only used with the BUFT-based multiplexer"
        SEVERITY warning;
      
    ELSE                                -- mux type is BUFT-based

--      ASSERT device_family /= VIRTEX4 AND device_family /= SPARTAN3
--        REPORT "ERROR: c_mux_bus_v8_0: BUFT-based multiplexers cannot be implemented in Spartan3 or Virtex4 devices"
--        SEVERITY failure;
      
      ASSERT c_has_q = 0
        REPORT "ERROR: c_mux_bus_v8_0: Registered output is not allowed with a BUFT-based multiplexer"
        SEVERITY failure;

      ASSERT c_has_o /= 0
        REPORT "ERROR: c_mux_bus_v8_0: BUFT-based multiplexer must have an asynchronous output - c_has_o generic set to 0 at present"
        SEVERITY failure;
      
      ASSERT c_latency = 0
        REPORT "WARNING: c_mux_bus_v8_0: Latencies greater than 0 are not possible in the BUFT-based multiplexer"
        SEVERITY warning;
      
    END IF;

    RETURN 0;
  END FUNCTION check_generics;

  -- Verify the generics are valid
  CONSTANT verify_generics : INTEGER := check_generics;  
  
BEGIN

  lut_based : IF c_mux_type = c_lut_based GENERATE

    ci32 : IF C_INPUTS = 32 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= MCA;
      intMCB <= MCB;
      intMCC <= MCC;
      intMCD <= MCD;
      intMCE <= MCE;
      intMCF <= MCF;
      intMCG <= MCG;
      intMCH <= MCH;
    END GENERATE;

    ci31 : IF C_INPUTS = 31 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= MCA;
      intMCB <= MCB;
      intMCC <= MCC;
      intMCD <= MCD;
      intMCE <= MCE;
      intMCF <= MCF;
      intMCG <= MCG;
      intMCH <= (OTHERS => 'X');
    END GENERATE;

    ci30 : IF C_INPUTS = 30 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= MCA;
      intMCB <= MCB;
      intMCC <= MCC;
      intMCD <= MCD;
      intMCE <= MCE;
      intMCF <= MCF;
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;

    ci29 : IF C_INPUTS = 29 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= MCA;
      intMCB <= MCB;
      intMCC <= MCC;
      intMCD <= MCD;
      intMCE <= MCE;
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;

    ci28 : IF C_INPUTS = 28 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= MCA;
      intMCB <= MCB;
      intMCC <= MCC;
      intMCD <= MCD;
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;

    ci27 : IF C_INPUTS = 27 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= MCA;
      intMCB <= MCB;
      intMCC <= MCC;
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;

    ci26 : IF C_INPUTS = 26 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= MCA;
      intMCB <= MCB;
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;

    ci25 : IF C_INPUTS = 25 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= MCA;
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;

    ci24 : IF C_INPUTS = 24 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;

    ci23 : IF C_INPUTS = 23 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;

    ci22 : IF C_INPUTS = 22 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci21 : IF C_INPUTS = 21 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci20 : IF C_INPUTS = 20 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci19 : IF C_INPUTS = 19 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci18 : IF C_INPUTS = 18 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= (OTHERS => 'X');
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci17 : IF C_INPUTS = 17 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= (OTHERS => 'X');
      intMBC <= (OTHERS => 'X');
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci16 : IF C_INPUTS = 16 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= (OTHERS => 'X');
      intMBB <= (OTHERS => 'X');
      intMBC <= (OTHERS => 'X');
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;


    ci15 : IF C_INPUTS = 15 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= (OTHERS => 'X');
      intMBA <= (OTHERS => 'X');
      intMBB <= (OTHERS => 'X');
      intMBC <= (OTHERS => 'X');
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci14 : IF C_INPUTS = 14 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= (OTHERS => 'X');
      intMAH <= (OTHERS => 'X');
      intMBA <= (OTHERS => 'X');
      intMBB <= (OTHERS => 'X');
      intMBC <= (OTHERS => 'X');
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci13 : IF C_INPUTS = 13 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= (OTHERS => 'X');
      intMAG <= (OTHERS => 'X');
      intMAH <= (OTHERS => 'X');
      intMBA <= (OTHERS => 'X');
      intMBB <= (OTHERS => 'X');
      intMBC <= (OTHERS => 'X');
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci12 : IF C_INPUTS = 12 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= (OTHERS => 'X');
      intMAF <= (OTHERS => 'X');
      intMAG <= (OTHERS => 'X');
      intMAH <= (OTHERS => 'X');
      intMBA <= (OTHERS => 'X');
      intMBB <= (OTHERS => 'X');
      intMBC <= (OTHERS => 'X');
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci11 : IF C_INPUTS = 11 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= (OTHERS => 'X');
      intMAE <= (OTHERS => 'X');
      intMAF <= (OTHERS => 'X');
      intMAG <= (OTHERS => 'X');
      intMAH <= (OTHERS => 'X');
      intMBA <= (OTHERS => 'X');
      intMBB <= (OTHERS => 'X');
      intMBC <= (OTHERS => 'X');
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci10 : IF C_INPUTS = 10 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= (OTHERS => 'X');
      intMAD <= (OTHERS => 'X');
      intMAE <= (OTHERS => 'X');
      intMAF <= (OTHERS => 'X');
      intMAG <= (OTHERS => 'X');
      intMAH <= (OTHERS => 'X');
      intMBA <= (OTHERS => 'X');
      intMBB <= (OTHERS => 'X');
      intMBC <= (OTHERS => 'X');
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci9 : IF C_INPUTS = 9 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= (OTHERS => 'X');
      intMAC <= (OTHERS => 'X');
      intMAD <= (OTHERS => 'X');
      intMAE <= (OTHERS => 'X');
      intMAF <= (OTHERS => 'X');
      intMAG <= (OTHERS => 'X');
      intMAH <= (OTHERS => 'X');
      intMBA <= (OTHERS => 'X');
      intMBB <= (OTHERS => 'X');
      intMBC <= (OTHERS => 'X');
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;

    -- Deal with optional pins...
    ci8 : IF C_INPUTS = 8 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= (OTHERS => 'X');
      intMAB <= (OTHERS => 'X');
      intMAC <= (OTHERS => 'X');
      intMAD <= (OTHERS => 'X');
      intMAE <= (OTHERS => 'X');
      intMAF <= (OTHERS => 'X');
      intMAG <= (OTHERS => 'X');
      intMAH <= (OTHERS => 'X');
      intMBA <= (OTHERS => 'X');
      intMBB <= (OTHERS => 'X');
      intMBC <= (OTHERS => 'X');
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci7 : IF C_INPUTS = 7 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= (OTHERS => 'X');
      intMAA <= (OTHERS => 'X');
      intMAB <= (OTHERS => 'X');
      intMAC <= (OTHERS => 'X');
      intMAD <= (OTHERS => 'X');
      intMAE <= (OTHERS => 'X');
      intMAF <= (OTHERS => 'X');
      intMAG <= (OTHERS => 'X');
      intMAH <= (OTHERS => 'X');
      intMBA <= (OTHERS => 'X');
      intMBB <= (OTHERS => 'X');
      intMBC <= (OTHERS => 'X');
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci6 : IF C_INPUTS = 6 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= (OTHERS => 'X');
      intMH  <= (OTHERS => 'X');
      intMAA <= (OTHERS => 'X');
      intMAB <= (OTHERS => 'X');
      intMAC <= (OTHERS => 'X');
      intMAD <= (OTHERS => 'X');
      intMAE <= (OTHERS => 'X');
      intMAF <= (OTHERS => 'X');
      intMAG <= (OTHERS => 'X');
      intMAH <= (OTHERS => 'X');
      intMBA <= (OTHERS => 'X');
      intMBB <= (OTHERS => 'X');
      intMBC <= (OTHERS => 'X');
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci5 : IF C_INPUTS = 5 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= (OTHERS => 'X');
      intMG  <= (OTHERS => 'X');
      intMH  <= (OTHERS => 'X');
      intMAA <= (OTHERS => 'X');
      intMAB <= (OTHERS => 'X');
      intMAC <= (OTHERS => 'X');
      intMAD <= (OTHERS => 'X');
      intMAE <= (OTHERS => 'X');
      intMAF <= (OTHERS => 'X');
      intMAG <= (OTHERS => 'X');
      intMAH <= (OTHERS => 'X');
      intMBA <= (OTHERS => 'X');
      intMBB <= (OTHERS => 'X');
      intMBC <= (OTHERS => 'X');
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci4 : IF C_INPUTS = 4 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= (OTHERS => 'X');
      intMF  <= (OTHERS => 'X');
      intMG  <= (OTHERS => 'X');
      intMH  <= (OTHERS => 'X');
      intMAA <= (OTHERS => 'X');
      intMAB <= (OTHERS => 'X');
      intMAC <= (OTHERS => 'X');
      intMAD <= (OTHERS => 'X');
      intMAE <= (OTHERS => 'X');
      intMAF <= (OTHERS => 'X');
      intMAG <= (OTHERS => 'X');
      intMAH <= (OTHERS => 'X');
      intMBA <= (OTHERS => 'X');
      intMBB <= (OTHERS => 'X');
      intMBC <= (OTHERS => 'X');
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci3 : IF C_INPUTS = 3 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= (OTHERS => 'X');
      intME  <= (OTHERS => 'X');
      intMF  <= (OTHERS => 'X');
      intMG  <= (OTHERS => 'X');
      intMH  <= (OTHERS => 'X');
      intMAA <= (OTHERS => 'X');
      intMAB <= (OTHERS => 'X');
      intMAC <= (OTHERS => 'X');
      intMAD <= (OTHERS => 'X');
      intMAE <= (OTHERS => 'X');
      intMAF <= (OTHERS => 'X');
      intMAG <= (OTHERS => 'X');
      intMAH <= (OTHERS => 'X');
      intMBA <= (OTHERS => 'X');
      intMBB <= (OTHERS => 'X');
      intMBC <= (OTHERS => 'X');
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    ci2 : IF C_INPUTS = 2 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= (OTHERS => 'X');
      intMD  <= (OTHERS => 'X');
      intME  <= (OTHERS => 'X');
      intMF  <= (OTHERS => 'X');
      intMG  <= (OTHERS => 'X');
      intMH  <= (OTHERS => 'X');
      intMAA <= (OTHERS => 'X');
      intMAB <= (OTHERS => 'X');
      intMAC <= (OTHERS => 'X');
      intMAD <= (OTHERS => 'X');
      intMAE <= (OTHERS => 'X');
      intMAF <= (OTHERS => 'X');
      intMAG <= (OTHERS => 'X');
      intMAH <= (OTHERS => 'X');
      intMBA <= (OTHERS => 'X');
      intMBB <= (OTHERS => 'X');
      intMBC <= (OTHERS => 'X');
      intMBD <= (OTHERS => 'X');
      intMBE <= (OTHERS => 'X');
      intMBF <= (OTHERS => 'X');
      intMBG <= (OTHERS => 'X');
      intMBH <= (OTHERS => 'X');
      intMCA <= (OTHERS => 'X');
      intMCB <= (OTHERS => 'X');
      intMCC <= (OTHERS => 'X');
      intMCD <= (OTHERS => 'X');
      intMCE <= (OTHERS => 'X');
      intMCF <= (OTHERS => 'X');
      intMCG <= (OTHERS => 'X');
      intMCH <= (OTHERS => 'X');
    END GENERATE;
    
  END GENERATE lut_based;

  buft_based : IF c_mux_type = c_buft_based GENERATE

    ci32 : IF C_INPUTS = 32 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= MCA;
      intMCB <= MCB;
      intMCC <= MCC;
      intMCD <= MCD;
      intMCE <= MCE;
      intMCF <= MCF;
      intMCG <= MCG;
      intMCH <= MCH;
    END GENERATE;

    ci31 : IF C_INPUTS = 31 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= MCA;
      intMCB <= MCB;
      intMCC <= MCC;
      intMCD <= MCD;
      intMCE <= MCE;
      intMCF <= MCF;
      intMCG <= MCG;
      intMCH <= (OTHERS => 'Z');
    END GENERATE;

    ci30 : IF C_INPUTS = 30 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= MCA;
      intMCB <= MCB;
      intMCC <= MCC;
      intMCD <= MCD;
      intMCE <= MCE;
      intMCF <= MCF;
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;

    ci29 : IF C_INPUTS = 29 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= MCA;
      intMCB <= MCB;
      intMCC <= MCC;
      intMCD <= MCD;
      intMCE <= MCE;
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;

    ci28 : IF C_INPUTS = 28 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= MCA;
      intMCB <= MCB;
      intMCC <= MCC;
      intMCD <= MCD;
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;

    ci27 : IF C_INPUTS = 27 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= MCA;
      intMCB <= MCB;
      intMCC <= MCC;
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;

    ci26 : IF C_INPUTS = 26 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= MCA;
      intMCB <= MCB;
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;

    ci25 : IF C_INPUTS = 25 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= MCA;
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;

    ci24 : IF C_INPUTS = 24 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= MBH;
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;

    ci23 : IF C_INPUTS = 23 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= MBG;
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;

    ci22 : IF C_INPUTS = 22 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= MBF;
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci21 : IF C_INPUTS = 21 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= MBE;
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci20 : IF C_INPUTS = 20 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= MBD;
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci19 : IF C_INPUTS = 19 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= MBC;
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci18 : IF C_INPUTS = 18 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= MBB;
      intMBC <= (OTHERS => 'Z');
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci17 : IF C_INPUTS = 17 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= MBA;
      intMBB <= (OTHERS => 'Z');
      intMBC <= (OTHERS => 'Z');
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci16 : IF C_INPUTS = 16 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= MAH;
      intMBA <= (OTHERS => 'Z');
      intMBB <= (OTHERS => 'Z');
      intMBC <= (OTHERS => 'Z');
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;


    ci15 : IF C_INPUTS = 15 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= MAG;
      intMAH <= (OTHERS => 'Z');
      intMBA <= (OTHERS => 'Z');
      intMBB <= (OTHERS => 'Z');
      intMBC <= (OTHERS => 'Z');
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci14 : IF C_INPUTS = 14 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= MAF;
      intMAG <= (OTHERS => 'Z');
      intMAH <= (OTHERS => 'Z');
      intMBA <= (OTHERS => 'Z');
      intMBB <= (OTHERS => 'Z');
      intMBC <= (OTHERS => 'Z');
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci13 : IF C_INPUTS = 13 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= MAE;
      intMAF <= (OTHERS => 'Z');
      intMAG <= (OTHERS => 'Z');
      intMAH <= (OTHERS => 'Z');
      intMBA <= (OTHERS => 'Z');
      intMBB <= (OTHERS => 'Z');
      intMBC <= (OTHERS => 'Z');
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci12 : IF C_INPUTS = 12 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= MAD;
      intMAE <= (OTHERS => 'Z');
      intMAF <= (OTHERS => 'Z');
      intMAG <= (OTHERS => 'Z');
      intMAH <= (OTHERS => 'Z');
      intMBA <= (OTHERS => 'Z');
      intMBB <= (OTHERS => 'Z');
      intMBC <= (OTHERS => 'Z');
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci11 : IF C_INPUTS = 11 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= MAC;
      intMAD <= (OTHERS => 'Z');
      intMAE <= (OTHERS => 'Z');
      intMAF <= (OTHERS => 'Z');
      intMAG <= (OTHERS => 'Z');
      intMAH <= (OTHERS => 'Z');
      intMBA <= (OTHERS => 'Z');
      intMBB <= (OTHERS => 'Z');
      intMBC <= (OTHERS => 'Z');
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci10 : IF C_INPUTS = 10 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= MAB;
      intMAC <= (OTHERS => 'Z');
      intMAD <= (OTHERS => 'Z');
      intMAE <= (OTHERS => 'Z');
      intMAF <= (OTHERS => 'Z');
      intMAG <= (OTHERS => 'Z');
      intMAH <= (OTHERS => 'Z');
      intMBA <= (OTHERS => 'Z');
      intMBB <= (OTHERS => 'Z');
      intMBC <= (OTHERS => 'Z');
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci9 : IF C_INPUTS = 9 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= (OTHERS => 'Z');
      intMAC <= (OTHERS => 'Z');
      intMAD <= (OTHERS => 'Z');
      intMAE <= (OTHERS => 'Z');
      intMAF <= (OTHERS => 'Z');
      intMAG <= (OTHERS => 'Z');
      intMAH <= (OTHERS => 'Z');
      intMBA <= (OTHERS => 'Z');
      intMBB <= (OTHERS => 'Z');
      intMBC <= (OTHERS => 'Z');
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;

    -- Deal with optional pins...
    ci8 : IF C_INPUTS = 8 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= (OTHERS => 'Z');
      intMAB <= (OTHERS => 'Z');
      intMAC <= (OTHERS => 'Z');
      intMAD <= (OTHERS => 'Z');
      intMAE <= (OTHERS => 'Z');
      intMAF <= (OTHERS => 'Z');
      intMAG <= (OTHERS => 'Z');
      intMAH <= (OTHERS => 'Z');
      intMBA <= (OTHERS => 'Z');
      intMBB <= (OTHERS => 'Z');
      intMBC <= (OTHERS => 'Z');
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci7 : IF C_INPUTS = 7 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= (OTHERS => 'Z');
      intMAA <= (OTHERS => 'Z');
      intMAB <= (OTHERS => 'Z');
      intMAC <= (OTHERS => 'Z');
      intMAD <= (OTHERS => 'Z');
      intMAE <= (OTHERS => 'Z');
      intMAF <= (OTHERS => 'Z');
      intMAG <= (OTHERS => 'Z');
      intMAH <= (OTHERS => 'Z');
      intMBA <= (OTHERS => 'Z');
      intMBB <= (OTHERS => 'Z');
      intMBC <= (OTHERS => 'Z');
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci6 : IF C_INPUTS = 6 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= (OTHERS => 'Z');
      intMH  <= (OTHERS => 'Z');
      intMAA <= (OTHERS => 'Z');
      intMAB <= (OTHERS => 'Z');
      intMAC <= (OTHERS => 'Z');
      intMAD <= (OTHERS => 'Z');
      intMAE <= (OTHERS => 'Z');
      intMAF <= (OTHERS => 'Z');
      intMAG <= (OTHERS => 'Z');
      intMAH <= (OTHERS => 'Z');
      intMBA <= (OTHERS => 'Z');
      intMBB <= (OTHERS => 'Z');
      intMBC <= (OTHERS => 'Z');
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci5 : IF C_INPUTS = 5 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= (OTHERS => 'Z');
      intMG  <= (OTHERS => 'Z');
      intMH  <= (OTHERS => 'Z');
      intMAA <= (OTHERS => 'Z');
      intMAB <= (OTHERS => 'Z');
      intMAC <= (OTHERS => 'Z');
      intMAD <= (OTHERS => 'Z');
      intMAE <= (OTHERS => 'Z');
      intMAF <= (OTHERS => 'Z');
      intMAG <= (OTHERS => 'Z');
      intMAH <= (OTHERS => 'Z');
      intMBA <= (OTHERS => 'Z');
      intMBB <= (OTHERS => 'Z');
      intMBC <= (OTHERS => 'Z');
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci4 : IF C_INPUTS = 4 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= (OTHERS => 'Z');
      intMF  <= (OTHERS => 'Z');
      intMG  <= (OTHERS => 'Z');
      intMH  <= (OTHERS => 'Z');
      intMAA <= (OTHERS => 'Z');
      intMAB <= (OTHERS => 'Z');
      intMAC <= (OTHERS => 'Z');
      intMAD <= (OTHERS => 'Z');
      intMAE <= (OTHERS => 'Z');
      intMAF <= (OTHERS => 'Z');
      intMAG <= (OTHERS => 'Z');
      intMAH <= (OTHERS => 'Z');
      intMBA <= (OTHERS => 'Z');
      intMBB <= (OTHERS => 'Z');
      intMBC <= (OTHERS => 'Z');
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci3 : IF C_INPUTS = 3 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= (OTHERS => 'Z');
      intME  <= (OTHERS => 'Z');
      intMF  <= (OTHERS => 'Z');
      intMG  <= (OTHERS => 'Z');
      intMH  <= (OTHERS => 'Z');
      intMAA <= (OTHERS => 'Z');
      intMAB <= (OTHERS => 'Z');
      intMAC <= (OTHERS => 'Z');
      intMAD <= (OTHERS => 'Z');
      intMAE <= (OTHERS => 'Z');
      intMAF <= (OTHERS => 'Z');
      intMAG <= (OTHERS => 'Z');
      intMAH <= (OTHERS => 'Z');
      intMBA <= (OTHERS => 'Z');
      intMBB <= (OTHERS => 'Z');
      intMBC <= (OTHERS => 'Z');
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    ci2 : IF C_INPUTS = 2 GENERATE
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= (OTHERS => 'Z');
      intMD  <= (OTHERS => 'Z');
      intME  <= (OTHERS => 'Z');
      intMF  <= (OTHERS => 'Z');
      intMG  <= (OTHERS => 'Z');
      intMH  <= (OTHERS => 'Z');
      intMAA <= (OTHERS => 'Z');
      intMAB <= (OTHERS => 'Z');
      intMAC <= (OTHERS => 'Z');
      intMAD <= (OTHERS => 'Z');
      intMAE <= (OTHERS => 'Z');
      intMAF <= (OTHERS => 'Z');
      intMAG <= (OTHERS => 'Z');
      intMAH <= (OTHERS => 'Z');
      intMBA <= (OTHERS => 'Z');
      intMBB <= (OTHERS => 'Z');
      intMBC <= (OTHERS => 'Z');
      intMBD <= (OTHERS => 'Z');
      intMBE <= (OTHERS => 'Z');
      intMBF <= (OTHERS => 'Z');
      intMBG <= (OTHERS => 'Z');
      intMBH <= (OTHERS => 'Z');
      intMCA <= (OTHERS => 'Z');
      intMCB <= (OTHERS => 'Z');
      intMCC <= (OTHERS => 'Z');
      intMCD <= (OTHERS => 'Z');
      intMCE <= (OTHERS => 'Z');
      intMCF <= (OTHERS => 'Z');
      intMCG <= (OTHERS => 'Z');
      intMCH <= (OTHERS => 'Z');
    END GENERATE;
    
  END GENERATE buft_based;



  en1 : IF C_HAS_EN = 1 GENERATE
    intEN <= EN;
  END GENERATE;
  en0 : IF NOT (C_HAS_EN = 1) GENERATE
    intEN <= '1';
  END GENERATE;
  
  
  p1 : PROCESS(intMA, intMB, intMC, intMD, intME, intMF, intMG, intMH,
               intMAA, intMAB, intMAC, intMAD, intMAE, intMAF, intMAG, intMAH,
               intMBA, intMBB, intMBC, intMBD, intMBE, intMBF, intMBG, intMBH,
               intMCA, intMCB, intMCC, intMCD, intMCE, intMCF, intMCG, intMCH,
               intEN, S)
    VARIABLE k : INTEGER := 1;
    VARIABLE j : INTEGER := 1;
  BEGIN
    k := 1;
    j := 1;

    FOR i IN 0 TO n_sel-1 LOOP
      IF(S(i) = '1') THEN
        k := k + j;
      END IF;

      j := j * 2;
    END LOOP;

    -- Check that this is a valid sel value and enable is not active!!
    IF intEN = '0' THEN
      intO <= (OTHERS => 'Z') AFTER timeunit;
    ELSIF intEN = 'X' THEN
      intO <= (OTHERS => 'X') AFTER timeunit;
    ELSIF k > C_INPUTS AND c_mux_type = c_lut_based THEN
      intO <= (OTHERS => '0') AFTER timeunit;  -- changed from X to match RTL model
    ELSIF k > C_INPUTS AND c_mux_type = c_buft_based THEN
      intO <= (OTHERS => 'Z') AFTER timeunit;
    ELSIF is_X(S) THEN
      intO <= (OTHERS => 'X') AFTER timeunit;
    ELSE
      -- Select the k'th input word for output
      IF k = 1 THEN
        intO <= intMA AFTER timeunit;
      ELSIF k = 2 THEN
        intO <= intMB AFTER timeunit;
      ELSIF k = 3 THEN
        intO <= intMC AFTER timeunit;
      ELSIF k = 4 THEN
        intO <= intMD AFTER timeunit;
      ELSIF k = 5 THEN
        intO <= intME AFTER timeunit;
      ELSIF k = 6 THEN
        intO <= intMF AFTER timeunit;
      ELSIF k = 7 THEN
        intO <= intMG AFTER timeunit;
      ELSIF k = 8 THEN
        intO <= intMH AFTER timeunit;
      ELSIF k = 9 THEN
        intO <= intMAA AFTER timeunit;
      ELSIF k = 10 THEN
        intO <= intMAB AFTER timeunit;
      ELSIF k = 11 THEN
        intO <= intMAC AFTER timeunit;
      ELSIF k = 12 THEN
        intO <= intMAD AFTER timeunit;
      ELSIF k = 13 THEN
        intO <= intMAE AFTER timeunit;
      ELSIF k = 14 THEN
        intO <= intMAF AFTER timeunit;
      ELSIF k = 15 THEN
        intO <= intMAG AFTER timeunit;
      ELSIF k = 16 THEN
        intO <= intMAH AFTER timeunit;
      ELSIF k = 17 THEN
        intO <= intMBA AFTER timeunit;
      ELSIF k = 18 THEN
        intO <= intMBB AFTER timeunit;
      ELSIF k = 19 THEN
        intO <= intMBC AFTER timeunit;
      ELSIF k = 20 THEN
        intO <= intMBD AFTER timeunit;
      ELSIF k = 21 THEN
        intO <= intMBE AFTER timeunit;
      ELSIF k = 22 THEN
        intO <= intMBF AFTER timeunit;
      ELSIF k = 23 THEN
        intO <= intMBG AFTER timeunit;
      ELSIF k = 24 THEN
        intO <= intMBH AFTER timeunit;
      ELSIF k = 25 THEN
        intO <= intMCA AFTER timeunit;
      ELSIF k = 26 THEN
        intO <= intMCB AFTER timeunit;
      ELSIF k = 27 THEN
        intO <= intMCC AFTER timeunit;
      ELSIF k = 28 THEN
        intO <= intMCD AFTER timeunit;
      ELSIF k = 29 THEN
        intO <= intMCE AFTER timeunit;
      ELSIF k = 30 THEN
        intO <= intMCF AFTER timeunit;
      ELSIF k = 31 THEN
        intO <= intMCG AFTER timeunit;
      ELSIF k = 32 THEN
        intO <= intMCH AFTER timeunit;
      ELSE                              -- Invalid sel value!
        IF c_mux_type = c_lut_based THEN
          intO <= (OTHERS => 'X') AFTER timeunit;
        ELSE                            -- c_buft_based
          intO <= (OTHERS => 'Z') AFTER timeunit;
        END IF;
      END IF;
    END IF;
    
  END PROCESS;


  q1 : IF (C_HAS_Q = 1) AND (C_LATENCY = 1) GENERATE
    Q        <= intQ;
    opreg_in <= intO;
  END GENERATE;


  q2 : IF (C_HAS_Q = 1) AND (C_LATENCY = 2) GENERATE
    Q        <= intQ;
    opreg_in <= Pipe1Out;
    Pipe1In  <= intO;
  END GENERATE;


  q0 : IF NOT (C_HAS_Q = 1) GENERATE
    Q <= (OTHERS => 'X');
  END GENERATE;


  o0 : IF NOT (C_HAS_O = 1) GENERATE
    O <= (OTHERS => 'X');
  END GENERATE;


  o1 : IF C_HAS_O = 1 GENERATE
    O <= intO;
  END GENERATE;


  g1 : IF (C_HAS_Q = 1) GENERATE        -- Need a register on the output

    opreg : c_reg_fd_v8_0 GENERIC MAP(C_WIDTH         => C_WIDTH,
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
      PORT MAP(D     => opreg_in,
               CLK   => CLK,
               CE    => CE,
               ACLR  => ACLR,
               SCLR  => SCLR,
               ASET  => ASET,
               SSET  => SSET,
               AINIT => AINIT,
               SINIT => SINIT,
               Q     => intQ);

  END GENERATE;


  g2 : IF (C_LATENCY = 2) GENERATE      -- Need a register on the output

    -- Modified pipeline register code to account for the fact that the new mux
    -- bit core allows async controls on the pipeline registers unless sync
    -- controls are present, in which case only the sync controls are implemented
    gen_no_async : IF c_has_sclr /= 0 OR c_has_sset /= 0 OR c_has_sinit /= 0 GENERATE
      Pipe1 : c_reg_fd_v8_0 GENERIC MAP(C_WIDTH         => C_WIDTH,
                                        C_AINIT_VAL     => C_AINIT_VAL,
                                        C_SINIT_VAL     => C_SINIT_VAL,
                                        C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                                        C_SYNC_ENABLE   => C_SYNC_ENABLE,
                                        C_HAS_CE        => C_HAS_CE,
                                        C_HAS_ACLR      => 0,
                                        C_HAS_ASET      => 0,
                                        C_HAS_AINIT     => 0,
                                        C_HAS_SCLR      => C_HAS_SCLR,
                                        C_HAS_SSET      => c_has_sset,
                                        C_HAS_SINIT     => c_has_sinit,
                                        C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
        PORT MAP(D     => Pipe1In,
                 CLK   => CLK,
                 CE    => CE,
                 ACLR  => '0',
                 SCLR  => SCLR,
                 ASET  => '0',
                 SSET  => SSET,
                 AINIT => '0',
                 SINIT => sinit,
                 Q     => Pipe1Out);  
    END GENERATE gen_no_async;

    gen_with_async : IF c_has_sclr = 0 AND c_has_sset = 0 AND c_has_sinit = 0 GENERATE
      Pipe1 : c_reg_fd_v8_0 GENERIC MAP(C_WIDTH         => C_WIDTH,
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
        PORT MAP(D     => Pipe1In,
                 CLK   => CLK,
                 CE    => CE,
                 ACLR  => ACLR,
                 SCLR  => '0',
                 ASET  => ASET,
                 SSET  => '0',
                 AINIT => AINIT,
                 SINIT => '0',
                 Q     => Pipe1Out);  
    END GENERATE gen_with_async;

--       Pipe1 : c_reg_fd_v8_0 generic map(C_WIDTH          => C_WIDTH,
--                                          C_AINIT_VAL     => C_AINIT_VAL,
--                                          C_SINIT_VAL     => C_SINIT_VAL,
--                                          C_SYNC_PRIORITY => C_SYNC_PRIORITY,
--                                          C_SYNC_ENABLE   => C_SYNC_ENABLE,
--                                          C_HAS_CE        => C_HAS_CE,
--                                          C_HAS_ACLR      => 0,
--                                          C_HAS_ASET      => 0,
--                                          C_HAS_AINIT     => 0,
--                                          C_HAS_SCLR      => C_HAS_SCLR,
--                                          C_HAS_SSET      => 0,
--                                          C_HAS_SINIT     => 0,
--                                          C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
--          port map(D     => Pipe1In,
--                   CLK   => CLK,
--                   CE    => CE,
--                   ACLR  => ACLR,
--                   SCLR  => SCLR,
--                   ASET  => ASET,
--                   SSET  => SSET,
--                   AINIT => AINIT,
--                   SINIT => SINIT,
--                   Q     => Pipe1Out);


--      Pipe1 : c_reg_fd_v8_0 generic map(C_WIDTH         => C_WIDTH,
--                                        C_AINIT_VAL     => C_AINIT_VAL,
--                                        C_SINIT_VAL     => C_SINIT_VAL,
--                                        C_SYNC_PRIORITY => C_SYNC_PRIORITY,
--                                        C_SYNC_ENABLE   => C_SYNC_ENABLE,
--                                        C_HAS_CE        => C_HAS_CE,
--                                        C_HAS_ACLR      => C_HAS_ACLR,
--                                        C_HAS_ASET      => C_HAS_ASET,
--                                        C_HAS_AINIT     => C_HAS_AINIT,
--                                        C_HAS_SCLR      => C_HAS_SCLR,
--                                        C_HAS_SSET      => C_HAS_SSET,
--                                        C_HAS_SINIT     => C_HAS_SINIT,
--                                        C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
--
--         port map(D     => Pipe1In,
--                  CLK   => CLK,
--                  CE    => CE,
--                  ACLR  => ACLR,
--                  SCLR  => SCLR,
--                  ASET  => ASET,
--                  SSET  => SSET,
--                  AINIT => AINIT,
--                  SINIT => SINIT,
--                  Q     => Pipe1Out);

    

  END GENERATE;

END behavioral;
