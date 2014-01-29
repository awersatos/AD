-- $RCSfile: c_shift_fd_v8_0.vhd,v $ $Revision: 1.10 $ $Date: 2008/09/08 16:50:55 $
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
USE XilinxCoreLib.c_reg_fd_v8_0_comp.ALL;
USE XilinxCoreLib.c_mux_bit_v8_0_comp.ALL;

ENTITY c_shift_fd_v8_0 IS
  GENERIC (
    c_width         : INTEGER := 16;
    c_shift_type    : INTEGER := 0;
    c_fill_data     : INTEGER := 5;
    c_ainit_val     : STRING  := "0000000000000000";
    c_sinit_val     : STRING  := "0000000000000000";
    c_sync_priority : INTEGER := 1;
    c_sync_enable   : INTEGER := 0;
    c_has_lsb_2_msb : INTEGER := 0;
    c_has_sdin      : INTEGER := 1;
    c_has_d         : INTEGER := 0;
    c_has_sdout     : INTEGER := 0;
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
    lsb_2_msb : IN  STD_LOGIC                            := '0';
    sdin      : IN  STD_LOGIC                            := '0';
    d         : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := (OTHERS => '0');
    p_load    : IN  STD_LOGIC                            := '0';
    clk       : IN  STD_LOGIC                            := '0';
    ce        : IN  STD_LOGIC                            := '1';
    aclr      : IN  STD_LOGIC                            := '0';
    aset      : IN  STD_LOGIC                            := '0';
    ainit     : IN  STD_LOGIC                            := '0';
    sclr      : IN  STD_LOGIC                            := '0';
    sset      : IN  STD_LOGIC                            := '0';
    sinit     : IN  STD_LOGIC                            := '0';
    sdout     : OUT STD_LOGIC;
    q         : OUT STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)
    ); 
END c_shift_fd_v8_0;

ARCHITECTURE behavioral OF c_shift_fd_v8_0 IS

  SIGNAL regsin  : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
  SIGNAL regsout : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
  SIGNAL MSBmuxi : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL muxc    : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL LSBmuxi : STD_LOGIC_VECTOR(3 DOWNTO 0);

  TYPE   shmuxinputs IS ARRAY (C_WIDTH DOWNTO 1) OF STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL shmuxi : shmuxinputs;

  SIGNAL intLSB_2_MSB : STD_LOGIC                              := '0';
  SIGNAL intSDIN      : STD_LOGIC                              := '0';
  SIGNAL intD         : STD_LOGIC_VECTOR(C_WIDTH - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL intP_LOAD    : STD_LOGIC                              := '0';
  SIGNAL intSDOUT     : STD_LOGIC                              := 'X';
  SIGNAL intQ         : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0)   := (OTHERS => 'X');

  -- check_generic function to verify the combination of generics is valid for the core
  FUNCTION check_generics (c_width                             : INTEGER;
                           c_has_aclr, c_has_aset, c_has_ainit : INTEGER;
                           c_has_sclr, c_has_sset, c_has_sinit : INTEGER;
                           c_shift_type                        : INTEGER;
                           c_fill_data                         : INTEGER) RETURN INTEGER IS
  BEGIN

    ASSERT (c_width >= 2 AND c_width <= 64)
      REPORT "ERROR: c_shift_fd_v8 - Invalid register width - c_width should be in the range 2 to 64 inclusive"
      SEVERITY failure;
    
    ASSERT c_has_sdout /= 0 OR c_has_q /= 0
      REPORT "ERROR: c_shift_fd_v8 - Shift register must have at least one output"
      SEVERITY failure;

    IF c_has_sdin = 0 AND c_has_d = 0 THEN
      ASSERT c_has_ainit /= 0 OR c_has_aclr /= 0 OR c_has_aset /= 0 OR c_has_sinit /= 0 OR c_has_sclr /= 0 OR c_has_sset /= 0
        REPORT "WARNING: c_shift_fd_v8 - Shift register can never be user-initialised due to lack of input pins"
        SEVERITY warning;
    END IF;

    ASSERT c_has_ainit = 0 OR (c_has_aclr = 0 AND c_has_aset = 0)
      REPORT "ERROR: c_shift_fd_v8 - Ainit not allowed in conjunction with aclr or aset"
      SEVERITY failure;
    
    ASSERT c_has_sinit = 0 OR (c_has_sclr = 0 AND c_has_sset = 0)
      REPORT "ERROR: c_shift_fd_v8 - Sinit not allowed in conjunction with sclr or sset"
      SEVERITY failure;
    
    IF c_shift_type = c_bidirectional THEN
      ASSERT c_has_lsb_2_msb /= 0
        REPORT "ERROR: c_shift_fd_v8 - Bidirectional shift register must have lsb_2_msb pin"
        SEVERITY failure;
    ELSIF c_shift_type /= c_bidirectional THEN
      ASSERT c_has_lsb_2_msb = 0
        REPORT "ERROR: c_shift_fd_v8 - lsb_2_msb pin not required when not using bidirectional shifting"
        SEVERITY failure;
    END IF;

    IF c_has_sdin /= 0 THEN
      ASSERT c_fill_data = c_sdin
        REPORT "ERROR: c_shift_fd_v8 - Only 'fill from pin' option possible when using serial input"
        SEVERITY failure;
    ELSIF c_has_sdin = 0 THEN
      ASSERT c_fill_data /= c_sdin
        REPORT "ERROR: c_shift_fd_v8 - 'Fill from pin' not available without serial input"
        SEVERITY failure;
    END IF;

    IF c_shift_type /= c_bidirectional THEN
      ASSERT c_fill_data /= c_wrap
        REPORT "ERROR: c_shift_fd_v8 - 'Wrap dynamic' only available when using bidirectional shifting"
        SEVERITY failure;
    END IF;

    RETURN 0;
  END check_generics;
  
  CONSTANT verify_generics : INTEGER RANGE 0 TO 0 := check_generics(c_width,
                                                                    c_has_aclr, c_has_aset, c_has_ainit,
                                                                    c_has_sclr, c_has_sset, c_has_sinit,
                                                                    c_shift_type, c_fill_data
                                                                    );
BEGIN

  -- Sort out the optional pins..
  bidi1 : IF(C_SHIFT_TYPE = c_bidirectional) GENERATE
    l2m2 : IF ((C_HAS_LSB_2_MSB = 1) AND (C_WIDTH = 1)) GENERATE
      intLSB_2_MSB <= '1';
    END GENERATE;
    l2m1 : IF((C_HAS_LSB_2_MSB = 1) AND (C_WIDTH > 1)) GENERATE
      intLSB_2_MSB <= LSB_2_MSB;
    END GENERATE;
    l2m0 : IF NOT(C_HAS_LSB_2_MSB = 1) GENERATE
      intLSB_2_MSB <= 'X';              -- Problem!!!
    END GENERATE;
  END GENERATE;  -- bidi1
  l2m1 : IF((C_SHIFT_TYPE = c_lsb_to_msb) OR ((C_SHIFT_TYPE = c_msb_to_lsb) AND (C_WIDTH = 1))) GENERATE
    intLSB_2_MSB <= '1';
  END GENERATE;
  m2l1 : IF((C_SHIFT_TYPE = c_msb_to_lsb) AND (C_WIDTH > 1)) GENERATE
    intLSB_2_MSB <= '0';
  END GENERATE;

  sdinproc : PROCESS(SDIN, regsout, intLSB_2_MSB)
  BEGIN
    IF(C_HAS_SDIN = 1) THEN
      intSDIN <= SDIN;                  -- C_FILL_DATA must be c_sdin!!!
    ELSE
      IF(C_FILL_DATA = c_zeros) THEN
        intSDIN <= '0';
      END IF;
      IF(C_FILL_DATA = c_ones) THEN
        intSDIN <= '1';
      END IF;
      IF(C_FILL_DATA = c_lsb) THEN
        intSDIN <= regsout(0);
      END IF;
      IF(C_FILL_DATA = c_msb) THEN
        intSDIN <= regsout(C_WIDTH-1);
      END IF;
      IF(C_FILL_DATA = c_wrap) THEN
        IF(intLSB_2_MSB = '0') THEN
          intSDIN <= regsout(0);
        ELSIF(intLSB_2_MSB = '1') THEN
          intSDIN <= regsout(C_WIDTH-1);
        ELSIF(regsout(0) /= regsout(C_WIDTH-1)) THEN  -- direction is unknown, values are different
          intSDIN <= 'X';
        ELSE
          intSDIN <= regsout(0);
        END IF;
      END IF;
    END IF;
  END PROCESS;

  d1 : IF(C_HAS_D = 1) GENERATE
    intD      <= D;
    intP_LOAD <= P_LOAD;
  END GENERATE;
  d0 : IF NOT(C_HAS_D = 1) GENERATE
    intD      <= (OTHERS => 'X');
    intP_LOAD <= '0';
  END GENERATE;

  -- Start off with the registers which will make up the SR

  shreg : C_REG_FD_V8_0
    GENERIC MAP
    (C_WIDTH         => C_WIDTH,
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
    PORT MAP
    (D     => regsin,
     CLK   => CLK,
     CE    => CE,
     ACLR  => ACLR,
     ASET  => ASET,
     AINIT => AINIT,
     SCLR  => SCLR,
     SSET  => SSET,
     SINIT => SINIT,
     Q     => regsout);

  -- Now the muxes which steer the data

  -- First the muxes which are needed at the ends of the SR:
  muxwgt1 : IF (C_WIDTH > 1) GENERATE
    MSBmux : C_MUX_BIT_V8_0 GENERIC MAP(C_INPUTS    => 4,
                                        C_SEL_WIDTH => 2,
                                        C_HAS_Q     => 0,
                                        C_HAS_O     => 1,
                                        C_LATENCY   => 0)
      PORT MAP(M => MSBmuxi,
               S => muxc,
               O => regsin(C_WIDTH-1));
  END GENERATE;
  
  LSBmux : C_MUX_BIT_V8_0 GENERIC MAP(C_INPUTS    => 4,
                                      C_SEL_WIDTH => 2,
                                      C_HAS_Q     => 0,
                                      C_HAS_O     => 1,
                                      C_LATENCY   => 0)
    PORT MAP(M => LSBmuxi,
             S => muxc,
             O => regsin(0));

  -- Now the rest of the muxes which are identical:
  muxwgt2 : IF (C_WIDTH > 2) GENERATE
    muxloop : FOR i IN C_WIDTH-2 DOWNTO 1 GENERATE
      shmux : C_MUX_BIT_V8_0 GENERIC MAP(C_INPUTS    => 4,
                                         C_SEL_WIDTH => 2,
                                         C_HAS_Q     => 0,
                                         C_HAS_O     => 1,
                                         C_LATENCY   => 0)
        PORT MAP(M => shmuxi(i),
                 S => muxc,
                 O => regsin(i));

    END GENERATE;  -- muxloop
  END GENERATE;

  -- Now connect up the wires to the mux and reg inputs and outputs 
  lsbw1 : IF (C_WIDTH = 1) GENERATE
    LSBmuxi(0) <= regsout(0);
  END GENERATE;
  lsbwgt1 : IF (C_WIDTH > 1) GENERATE
    LSBmuxi(0) <= regsout(1);
  END GENERATE;
  LSBmuxi(1) <= intSDIN;
  LSBmuxi(2) <= intD(0);
  LSBmuxi(3) <= intD(0);

  MSBmuxi(0) <= intSDIN;
  msbw1 : IF(C_WIDTH = 1) GENERATE
    MSBmuxi(1) <= 'X';
  END GENERATE;
  msbwgt1 : IF(C_WIDTH > 1) GENERATE
    MSBmuxi(1) <= regsout(C_WIDTH-2);
  END GENERATE;
  MSBmuxi(2) <= intD(C_WIDTH-1);
  MSBmuxi(3) <= intD(C_WIDTH-1);

  mlwgt2 : IF (C_WIDTH > 2) GENERATE
    muxloop2 : FOR i IN C_WIDTH-2 DOWNTO 1 GENERATE
      shmuxi(i)(0) <= regsout(i+1);
      shmuxi(i)(1) <= regsout(i-1);
      shmuxi(i)(2) <= intD(i);
      shmuxi(i)(3) <= intD(i);
    END GENERATE;
  END GENERATE;

  -- Next the control connections to the muxes
  muxc(1) <= intP_LOAD;  -- Both MSBs of mux inputs are connected to the parallel D in.
  muxc(0) <= intLSB_2_MSB;  -- The LSB of the mux inputs are connected to shift from MSB to LSB

  -- Finally the connections to the outputs
  q1 : IF (C_HAS_Q = 1) GENERATE
    intQ <= regsout;
  END GENERATE;
  q0 : IF NOT(C_HAS_Q = 1) GENERATE
    intQ <= (OTHERS => 'X');
  END GENERATE;

  sdout1 : IF(C_HAS_SDOUT = 1) GENERATE
    sdoutmsb : IF(C_SHIFT_TYPE = c_lsb_to_msb OR C_SHIFT_TYPE = c_bidirectional) GENERATE
      intSDOUT <= regsout(C_WIDTH-1);
    END GENERATE;
    sdoutlsb : IF(C_SHIFT_TYPE = c_msb_to_lsb) GENERATE
      intSDOUT <= regsout(0);
    END GENERATE;
  END GENERATE;

  sdout0 : IF NOT(C_HAS_SDOUT = 1) GENERATE
    intSDOUT <= 'X';
  END GENERATE;

  SDOUT <= intSDOUT;

  Q <= intQ;
  
  
END behavioral;












