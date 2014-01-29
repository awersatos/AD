-- Copyright(C) 2003 by Xilinx, Inc. All rights reserved.
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
-- of this text at all times. (c) Copyright 1995-2003 Xilinx, Inc.
-- All rights reserved.

-- $Id: c_compare_v7_0.vhd,v 1.13 2008/09/08 20:06:14 akennedy Exp $
--
-- Filename - c_compare_v7_0.vhd
-- Author - Xilinx
-- Creation - 29 Dec 1998
--
-- Description - This file contains the behavior for
--                               the C_COMPARE_V7_0 core

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library XilinxCoreLib;
use XilinxCoreLib.prims_constants_v7_0.all;
use XilinxCoreLib.prims_utils_v7_0.all;
use XilinxCoreLib.c_reg_fd_v7_0_comp.all;

-- (A)Synchronous Comparator
--

entity C_COMPARE_V7_0 is
  generic (C_WIDTH         : integer := 16;
           C_AINIT_VAL     : string  := "";
           C_DATA_TYPE     : integer := c_unsigned;
           C_B_CONSTANT    : integer := 0;
           C_B_VALUE       : string  := "";                         
           C_SYNC_ENABLE   : integer := c_override;
           C_SYNC_PRIORITY : integer := c_clear;
           C_PIPE_STAGES   : integer := 1;
           C_HAS_A_EQ_B    : integer := 1;
           C_HAS_A_NE_B    : integer := 0;
           C_HAS_A_LT_B    : integer := 0;
           C_HAS_A_GT_B    : integer := 0;
           C_HAS_A_LE_B    : integer := 0;
           C_HAS_A_GE_B    : integer := 0;
           C_HAS_QA_EQ_B   : integer := 0;
           C_HAS_QA_NE_B   : integer := 0;
           C_HAS_QA_LT_B   : integer := 0;
           C_HAS_QA_GT_B   : integer := 0;
           C_HAS_QA_LE_B   : integer := 0;
           C_HAS_QA_GE_B   : integer := 0;
           C_HAS_CE        : integer := 0;
           C_HAS_ACLR      : integer := 0;
           C_HAS_ASET      : integer := 0;
           C_HAS_SCLR      : integer := 0;
           C_HAS_SSET      : integer := 0;
           C_ENABLE_RLOCS  : integer := 1
           ); 

  port (A       : in  std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');  -- Input value
        B       : in  std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');  -- Input value
        CLK     : in  std_logic                            := '0';  -- Clock
        CE      : in  std_logic                            := '1';  -- Clock Enable
        ACLR    : in  std_logic                            := '0';  -- Asynch init.
        ASET    : in  std_logic                            := '0';  -- Asynch set.
        SCLR    : in  std_logic                            := '0';  -- Synch init.
        SSET    : in  std_logic                            := '0';  -- Synch set.
        A_EQ_B  : out std_logic;
        A_NE_B  : out std_logic;
        A_LT_B  : out std_logic;
        A_GT_B  : out std_logic;
        A_LE_B  : out std_logic;
        A_GE_B  : out std_logic;
        QA_EQ_B : out std_logic;
        QA_NE_B : out std_logic;
        QA_LT_B : out std_logic;
        QA_GT_B : out std_logic;
        QA_LE_B : out std_logic;
        QA_GE_B : out std_logic
        ); 
end C_COMPARE_V7_0;

architecture behavioral of C_COMPARE_V7_0 is

  constant timeunit : time := 1 ns;

  -- signals for optional pins...
  signal intA_EQ_B  : std_logic                            := 'X';
  signal intA_NE_B  : std_logic                            := 'X';
  signal intA_LT_B  : std_logic                            := 'X';
  signal intA_GT_B  : std_logic                            := 'X';
  signal intA_LE_B  : std_logic                            := 'X';
  signal intA_GE_B  : std_logic                            := 'X';
  signal intQA_EQ_B : std_logic                            := 'X';
  signal intQA_NE_B : std_logic                            := 'X';
  signal intQA_LT_B : std_logic                            := 'X';
  signal intQA_GT_B : std_logic                            := 'X';
  signal intQA_LE_B : std_logic                            := 'X';
  signal intQA_GE_B : std_logic                            := 'X';
  signal intB       : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');

  signal zero  : std_logic := '0';
  signal one   : std_logic := '1';
  signal intCE : std_logic;


  -- pipelining signals
  signal intQA_EQ_Bpipeend : std_logic;
  signal intQA_NE_Bpipeend : std_logic;
  signal intQA_LT_Bpipeend : std_logic;
  signal intQA_GT_Bpipeend : std_logic;
  signal intQA_LE_Bpipeend : std_logic;
  signal intQA_GE_Bpipeend : std_logic;
  signal intQA_EQ_Bpipe    : std_logic_vector(C_PIPE_STAGES+2 downto 0) := (others => '0');
  signal intQA_NE_Bpipe    : std_logic_vector(C_PIPE_STAGES+2 downto 0) := (others => '0');
  signal intQA_LT_Bpipe    : std_logic_vector(C_PIPE_STAGES+2 downto 0) := (others => '0');
  signal intQA_GT_Bpipe    : std_logic_vector(C_PIPE_STAGES+2 downto 0) := (others => '0');
  signal intQA_LE_Bpipe    : std_logic_vector(C_PIPE_STAGES+2 downto 0) := (others => '0');
  signal intQA_GE_Bpipe    : std_logic_vector(C_PIPE_STAGES+2 downto 0) := (others => '0');
begin
  
  ce1 : if C_HAS_CE = 1 generate
    intCE <= CE;
  end generate;
  ce0 : if not (C_HAS_CE = 1) generate
    intCE <= '1';
  end generate;

  b1 : if C_B_CONSTANT = 1 generate
    intB <= str_to_slv_0(C_B_VALUE, C_WIDTH);
  end generate;
  b0 : if not (C_B_CONSTANT = 1) generate
    intB <= B;
  end generate;

  p1 : process(A, intB)
    variable aeqb, aneb, altb, agtb, aleb, ageb : std_logic                            := 'X';
    variable notdone                            : integer                              := 1;
    variable a_low, a_high, b_low, b_high       : std_logic_vector(C_WIDTH-1 downto 0);
    variable allXs                              : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');
    variable allUs                              : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'U');
    variable all1s                              : std_logic_vector(C_WIDTH-1 downto 0) := (others => '1');
    variable all0s                              : std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');
  begin
    aeqb := '0';
    aneb := '0';
    altb := '0';
    agtb := '0';
    aleb := '0';
    ageb := '0';
    if is_X(A) or is_X(intB) then
      -- We need to be a bit smarter than simply setting all outputs to 'X'...
      notdone := 1;
      if ((is_X(A) and (A = allXs or A = allUs)) and (is_X(intB) and (intB = allXs or intB = allUs))) then
        aeqb    := 'X';
        aneb    := 'X';
        altb    := 'X';
        agtb    := 'X';
        aleb    := 'X';
        ageb    := 'X';
        notdone := 0;
        
      elsif C_DATA_TYPE = c_signed then
--                              if is_X(A(C_WIDTH-1)) and is_X(intB(C_WIDTH-1)) then
        -- Don't know the sign of EITHER data => ALL X's
--                                      aeqb := 'X';
--                                      aneb := 'X';
--                                      altb := 'X';
--                                      agtb := 'X';
--                                      aleb := 'X';
--                                      ageb := 'X';
--                                      notdone := 0;
--                              elsif (not is_X(A(C_WIDTH-1))) and (not is_X(intB(C_WIDTH-1))) then 
        if (not is_X(A(C_WIDTH-1))) and (not is_X(intB(C_WIDTH-1))) then
          -- The sign bits are both known
          if A(C_WIDTH-1) /= intB(C_WIDTH-1) then
                                        -- different signs!
            if A(C_WIDTH-1) = '1' then
                                        -- A is negative and B is positive
              aeqb    := '0';
              aneb    := '1';
              altb    := '1';
              agtb    := '0';
              aleb    := '1';
              ageb    := '0';
              notdone := 0;
            else                        -- A is +ve and B is -ve
              aeqb    := '0';
              aneb    := '1';
              altb    := '0';
              agtb    := '1';
              aleb    := '0';
              ageb    := '1';
              notdone := 0;
            end if;
          end if;
        end if;
      end if;
      if notdone = 1 then               -- check further                      
        -- Make copies of A and B with all X's substituted with 0's and 1's
        a_low  := A;
        a_high := A;
        b_low  := intB;
        b_high := intB;
        for i in C_WIDTH-2 downto 0 loop
          if is_X(a_low(i)) then
            a_low(i)  := '0';
            a_high(i) := '1';
          end if;
          if is_X(b_low(i)) then
            b_low(i)  := '0';
            b_high(i) := '1';
          end if;
        end loop;
        -- we now (almost - need to check possible sign bits) have worst-case values which must agree on the comparison result 
        -- if that result is not to be unknown...
        if C_DATA_TYPE = c_signed then
          if is_X(a_low(C_WIDTH-1)) then
            a_low(C_WIDTH-1)  := '1';
            a_high(C_WIDTH-1) := '0';
          end if;
          if is_X(b_low(C_WIDTH-1)) then
            b_low(C_WIDTH-1)  := '1';
            b_high(C_WIDTH-1) := '0';
          end if;
          if signed(a_high) < signed(b_low) then
                                        -- A is definitely < than B
            aeqb := '0';
            aneb := '1';
            altb := '1';
            agtb := '0';
            aleb := '1';
            ageb := '0';
          elsif signed(a_low) > signed(b_high) then
                                        -- A is definitely > than B     
            aeqb := '0';
            aneb := '1';
            altb := '0';
            agtb := '1';
            aleb := '0';
            ageb := '1';
          elsif signed(a_high) = signed(b_low) then
                                        -- A is <= B
            aeqb := 'X';
            aneb := 'X';
            altb := 'X';
            agtb := '0';
            aleb := '1';
            ageb := 'X';
          elsif signed(a_low) = signed(b_high) then
                                        -- A is >= B
            aeqb := 'X';
            aneb := 'X';
            altb := '0';
            agtb := 'X';
            aleb := 'X';
            ageb := '1';
          elsif signed(a_low) /= signed(b_low) and signed(a_low) /= signed(b_high) and
            signed(a_high) /= signed(b_low) and signed(a_high) /= signed(b_high) and not((intB = allXs) or (A = allXs) or (intB = allUs) or (A = allUs)) then
                                        -- A /= B
            aeqb := '0';
            aneb := '1';
            altb := 'X';
            agtb := 'X';
            aleb := 'X';
            ageb := 'X';
          else  -- There is > 1 overlap between the ranges so all X's
            aeqb := 'X';
            aneb := 'X';
            altb := 'X';
            agtb := 'X';
            aleb := 'X';
            ageb := 'X';
          end if;
        else                            -- unsigned data
          if is_X(a_low(C_WIDTH-1)) then
            a_low(C_WIDTH-1)  := '0';
            a_high(C_WIDTH-1) := '1';
          end if;
          if is_X(b_low(C_WIDTH-1)) then
            b_low(C_WIDTH-1)  := '0';
            b_high(C_WIDTH-1) := '1';
          end if;
          if unsigned(a_high) < unsigned(b_low) then
                                        -- A is definitely < than B
            aeqb := '0';
            aneb := '1';
            altb := '1';
            agtb := '0';
            aleb := '1';
            ageb := '0';
          elsif unsigned(a_low) > unsigned(b_high) then
                                        -- A is definitely > than B     
            aeqb := '0';
            aneb := '1';
            altb := '0';
            agtb := '1';
            aleb := '0';
            ageb := '1';
          elsif unsigned(a_high) = unsigned(b_low) then
                                        -- A is <= B
            aeqb := 'X';
            aneb := 'X';
            altb := 'X';
            agtb := '0';
            aleb := '1';
            ageb := 'X';
          elsif unsigned(a_low) = unsigned(b_high) then
                                        -- A is >= B
            aeqb := 'X';
            aneb := 'X';
            altb := '0';
            agtb := 'X';
            aleb := 'X';
            ageb := '1';
          elsif unsigned(a_low) /= unsigned(b_low) and unsigned(a_low) /= unsigned(b_high) and
            unsigned(a_high) /= unsigned(b_low) and unsigned(a_high) /= unsigned(b_high) and not((intB = allXs) or (A = allXs) or (intB = allUs) or (A = allUs)) then
                                        -- A /= B
            aeqb := '0';
            aneb := '1';
            altb := 'X';
            agtb := 'X';
            aleb := 'X';
            ageb := 'X';
          else  -- There is > 1 overlap between the ranges so all X's
            aeqb := 'X';
            aneb := 'X';
            altb := 'X';
            agtb := 'X';
            aleb := 'X';
            ageb := 'X';
          end if;
        end if;
      end if;
    elsif C_DATA_TYPE = c_signed then
      if signed(A) = signed(intB) then
        aeqb := '1';
        aneb := '0';
        altb := '0';
        agtb := '0';
      end if;
      if signed(A) < signed(intB) then
        aeqb := '0';
        aneb := '1';
        altb := '1';
        agtb := '0';
      end if;
      if signed(A) > signed(intB) then
        aeqb := '0';
        aneb := '1';
        altb := '0';
        agtb := '1';
      end if;
      if aeqb = '1' or altb = '1' then
        aleb := '1';
      end if;
      if aeqb = '1' or agtb = '1' then
        ageb := '1';
      end if;
    else                                -- unsigned data
      if unsigned(A) = unsigned(intB) then
        aeqb := '1';
        aneb := '0';
        altb := '0';
        agtb := '0';
      end if;
      if unsigned(A) < unsigned(intB) then
        aeqb := '0';
        aneb := '1';
        altb := '1';
        agtb := '0';
      end if;
      if unsigned(A) > unsigned(intB) then
        aeqb := '0';
        aneb := '1';
        altb := '0';
        agtb := '1';
      end if;
      if aeqb = '1' or altb = '1' then
        aleb := '1';
      end if;
      if aeqb = '1' or agtb = '1' then
        ageb := '1';
      end if;
    end if;

    intA_EQ_B <= aeqb after timeunit;
    intA_NE_B <= aneb after timeunit;
    intA_LT_B <= altb after timeunit;
    intA_GT_B <= agtb after timeunit;
    intA_LE_B <= aleb after timeunit;
    intA_GE_B <= ageb after timeunit;
    
  end process;

  aeqb0 : if not (C_HAS_A_EQ_B = 1) generate
    A_EQ_B <= 'X';
  end generate;
  aeqb1 : if C_HAS_A_EQ_B = 1 generate
    A_EQ_B <= intA_EQ_B;
  end generate;

  aneb0 : if not (C_HAS_A_NE_B = 1) generate
    A_NE_B <= 'X';
  end generate;
  aneb1 : if C_HAS_A_NE_B = 1 generate
    A_NE_B <= intA_NE_B;
  end generate;

  altb0 : if not (C_HAS_A_LT_B = 1) generate
    A_LT_B <= 'X';
  end generate;
  altb1 : if C_HAS_A_LT_B = 1 generate
    A_LT_B <= intA_LT_B;
  end generate;

  agtb0 : if not (C_HAS_A_GT_B = 1) generate
    A_GT_B <= 'X';
  end generate;
  agtb1 : if C_HAS_A_GT_B = 1 generate
    A_GT_B <= intA_GT_B;
  end generate;

  aleb0 : if not (C_HAS_A_LE_B = 1) generate
    A_LE_B <= 'X';
  end generate;
  aleb1 : if C_HAS_A_LE_B = 1 generate
    A_LE_B <= intA_LE_B;
  end generate;

  ageb0 : if not (C_HAS_A_GE_B = 1) generate
    A_GE_B <= 'X';
  end generate;
  ageb1 : if C_HAS_A_GE_B = 1 generate
    A_GE_B <= intA_GE_B;
  end generate;

  aeqbr1 : if C_HAS_QA_EQ_B = 1 generate
    aeqbreg : c_reg_fd_v7_0 generic map (C_WIDTH         => 1,
                                         C_AINIT_VAL     => C_AINIT_VAL,
                                         C_SINIT_VAL     => "0",
                                         C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                                         C_SYNC_ENABLE   => C_SYNC_ENABLE,
                                         C_HAS_CE        => C_HAS_CE,
                                         C_HAS_ACLR      => C_HAS_ACLR,
                                         C_HAS_ASET      => C_HAS_ASET,
                                         C_HAS_AINIT     => 0,
                                         C_HAS_SCLR      => C_HAS_SCLR,
                                         C_HAS_SSET      => C_HAS_SSET,
                                         C_HAS_SINIT     => 0,
                                         C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
      port map(D(0) => intQA_EQ_Bpipeend,
               CLK  => CLK,
               CE   => CE,
               ACLR => ACLR,
               SCLR => SCLR,
               ASET => ASET,
               SSET => SSET,
               Q(0) => intQA_EQ_B);
  end generate;

  pipeeq : process (CLK)
  begin
    
    if intCE = '1' and CLK = '1' and CLK'last_value /= 'X' and C_PIPE_STAGES > 1 then
      pipeloop : for p in 2 to C_PIPE_STAGES-1 loop
        intQA_EQ_Bpipe(p) <= intQA_EQ_Bpipe(p+1);
      end loop;  -- pipeloop
      intQA_EQ_Bpipe(C_PIPE_STAGES) <= intA_EQ_B;
    elsif (intCE = 'X' or (CLK = 'X' and CLK'last_value = '0') or (CLK = '1' and CLK'last_value = 'X')) and C_PIPE_STAGES > 1 then
      pipeloopx : for p in 2 to C_PIPE_STAGES-1 loop
        if intQA_EQ_Bpipe(p) /= intQA_EQ_Bpipe(p+1) then
          intQA_EQ_Bpipe(p) <= 'X';
        end if;
      end loop;  -- pipeloop
      if intQA_EQ_Bpipe(C_PIPE_STAGES) /= intA_EQ_B then
        intQA_EQ_Bpipe(C_PIPE_STAGES) <= 'X';
      end if;
    end if;
    
  end process;  -- pipeq

  ps1 : if C_PIPE_STAGES < 2 generate
    intQA_EQ_Bpipeend <= intA_EQ_B;
  end generate;
  ps1b : if C_PIPE_STAGES > 1 generate
    intQA_EQ_Bpipeend <= intQA_EQ_Bpipe(2);
  end generate;

  qeq1 : if C_HAS_QA_EQ_B = 1 generate
    QA_EQ_B <= intQA_EQ_B;
  end generate;
  qeq0 : if not (C_HAS_QA_EQ_B = 1) generate
    QA_EQ_B <= 'X';
  end generate;

  anebr1 : if C_HAS_QA_NE_B = 1 generate
    anebreg : c_reg_fd_v7_0 generic map (C_WIDTH         => 1,
                                         C_AINIT_VAL     => C_AINIT_VAL,
                                         C_SINIT_VAL     => "0",
                                         C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                                         C_SYNC_ENABLE   => C_SYNC_ENABLE,
                                         C_HAS_CE        => C_HAS_CE,
                                         C_HAS_ACLR      => C_HAS_ACLR,
                                         C_HAS_ASET      => C_HAS_ASET,
                                         C_HAS_AINIT     => 0,
                                         C_HAS_SCLR      => C_HAS_SCLR,
                                         C_HAS_SSET      => C_HAS_SSET,
                                         C_HAS_SINIT     => 0,
                                         C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
      port map(D(0) => intQA_NE_Bpipeend,
               CLK  => CLK,
               CE   => CE,
               ACLR => ACLR,
               SCLR => SCLR,
               ASET => ASET,
               SSET => SSET,
               Q(0) => intQA_NE_B);
  end generate;

  pipene : process (CLK)
  begin
    
    if intCE = '1' and CLK = '1' and CLK'last_value /= 'X' and C_PIPE_STAGES > 1 then
      pipeloop : for p in 2 to C_PIPE_STAGES-1 loop
        intQA_NE_Bpipe(p) <= intQA_NE_Bpipe(p+1);
      end loop;  -- pipeloop
      intQA_NE_Bpipe(C_PIPE_STAGES) <= intA_NE_B;
    elsif (intCE = 'X' or (CLK = 'X' and CLK'last_value = '0') or (CLK = '1' and CLK'last_value = 'X')) and C_PIPE_STAGES > 1 then
      pipeloopx : for p in 2 to C_PIPE_STAGES-1 loop
        if intQA_NE_Bpipe(p) /= intQA_NE_Bpipe(p+1) then
          intQA_NE_Bpipe(p) <= 'X';
        end if;
      end loop;  -- pipeloop
      if intQA_NE_Bpipe(C_PIPE_STAGES) /= intA_NE_B then
        intQA_NE_Bpipe(C_PIPE_STAGES) <= 'X';
      end if;
    end if;

  end process;  -- pipeq

  ps2 : if C_PIPE_STAGES < 2 generate
    intQA_NE_Bpipeend <= intA_NE_B;
  end generate;
  ps2b : if C_PIPE_STAGES > 1 generate
    intQA_NE_Bpipeend <= intQA_NE_Bpipe(2);
  end generate;

  qne1 : if C_HAS_QA_NE_B = 1 generate
    QA_NE_B <= intQA_NE_B;
  end generate;
  qne0 : if not (C_HAS_QA_NE_B = 1) generate
    QA_NE_B <= 'X';
  end generate;

  altbr1 : if C_HAS_QA_LT_B = 1 generate
    altbreg : c_reg_fd_v7_0 generic map (C_WIDTH         => 1,
                                         C_AINIT_VAL     => C_AINIT_VAL,
                                         C_SINIT_VAL     => "0",
                                         C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                                         C_SYNC_ENABLE   => C_SYNC_ENABLE,
                                         C_HAS_CE        => C_HAS_CE,
                                         C_HAS_ACLR      => C_HAS_ACLR,
                                         C_HAS_ASET      => C_HAS_ASET,
                                         C_HAS_AINIT     => 0,
                                         C_HAS_SCLR      => C_HAS_SCLR,
                                         C_HAS_SSET      => C_HAS_SSET,
                                         C_HAS_SINIT     => 0,
                                         C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
      port map(D(0) => intQA_LT_Bpipeend,
               CLK  => CLK,
               CE   => CE,
               ACLR => ACLR,
               SCLR => SCLR,
               ASET => ASET,
               SSET => SSET,
               Q(0) => intQA_LT_B);
  end generate;

  pipelt : process (CLK)
  begin
    
    if intCE = '1' and CLK = '1' and CLK'last_value /= 'X' and C_PIPE_STAGES > 1 then
      pipeloop : for p in 2 to C_PIPE_STAGES-1 loop
        intQA_LT_Bpipe(p) <= intQA_LT_Bpipe(p+1);
      end loop;  -- pipeloop
      intQA_LT_Bpipe(C_PIPE_STAGES) <= intA_LT_B;
    elsif (intCE = 'X' or (CLK = 'X' and CLK'last_value = '0') or (CLK = '1' and CLK'last_value = 'X')) and C_PIPE_STAGES > 1 then
      pipeloopx : for p in 2 to C_PIPE_STAGES-1 loop
        if intQA_LT_Bpipe(p) /= intQA_LT_Bpipe(p+1) then
          intQA_LT_Bpipe(p) <= 'X';
        end if;
      end loop;  -- pipeloop
      if intQA_LT_Bpipe(C_PIPE_STAGES) /= intA_LT_B then
        intQA_LT_Bpipe(C_PIPE_STAGES) <= 'X';
      end if;
    end if;
    
  end process;  -- pipeq

  ps3 : if C_PIPE_STAGES < 2 generate
    intQA_LT_Bpipeend <= intA_LT_B;
  end generate;
  ps3b : if C_PIPE_STAGES > 1 generate
    intQA_LT_Bpipeend <= intQA_LT_Bpipe(2);
  end generate;

  qlt1 : if C_HAS_QA_LT_B = 1 generate
    QA_LT_B <= intQA_LT_B;
  end generate;
  qlt0 : if not (C_HAS_QA_LT_B = 1) generate
    QA_LT_B <= 'X';
  end generate;

  agtbr1 : if C_HAS_QA_GT_B = 1 generate
    agtbreg : c_reg_fd_v7_0 generic map (C_WIDTH         => 1,
                                         C_AINIT_VAL     => C_AINIT_VAL,
                                         C_SINIT_VAL     => "0",
                                         C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                                         C_SYNC_ENABLE   => C_SYNC_ENABLE,
                                         C_HAS_CE        => C_HAS_CE,
                                         C_HAS_ACLR      => C_HAS_ACLR,
                                         C_HAS_ASET      => C_HAS_ASET,
                                         C_HAS_AINIT     => 0,
                                         C_HAS_SCLR      => C_HAS_SCLR,
                                         C_HAS_SSET      => C_HAS_SSET,
                                         C_HAS_SINIT     => 0,
                                         C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
      port map(D(0) => intQA_GT_Bpipeend,
               CLK  => CLK,
               CE   => CE,
               ACLR => ACLR,
               SCLR => SCLR,
               ASET => ASET,
               SSET => SSET,
               Q(0) => intQA_GT_B);
  end generate;

  pipegt : process (CLK)
  begin
    
    if intCE = '1' and CLK = '1' and CLK'last_value /= 'X' and C_PIPE_STAGES > 1 then
      pipeloop : for p in 2 to C_PIPE_STAGES-1 loop
        intQA_GT_Bpipe(p) <= intQA_GT_Bpipe(p+1);
      end loop;  -- pipeloop
      intQA_GT_Bpipe(C_PIPE_STAGES) <= intA_GT_B;
    elsif (intCE = 'X' or (CLK = 'X' and CLK'last_value = '0') or (CLK = '1' and CLK'last_value = 'X')) and C_PIPE_STAGES > 1 then
      pipeloopx : for p in 2 to C_PIPE_STAGES-1 loop
        if intQA_GT_Bpipe(p) /= intQA_GT_Bpipe(p+1) then
          intQA_GT_Bpipe(p) <= 'X';
        end if;
      end loop;  -- pipeloop
      if intQA_GT_Bpipe(C_PIPE_STAGES) /= intA_GT_B then
        intQA_GT_Bpipe(C_PIPE_STAGES) <= 'X';
      end if;
    end if;
    
  end process;  -- pipeq

  ps4 : if C_PIPE_STAGES < 2 generate
    intQA_GT_Bpipeend <= intA_GT_B;
  end generate;
  ps4b : if C_PIPE_STAGES > 1 generate
    intQA_GT_Bpipeend <= intQA_GT_Bpipe(2);
  end generate;

  qgt1 : if C_HAS_QA_GT_B = 1 generate
    QA_GT_B <= intQA_GT_B;
  end generate;
  qgt0 : if not (C_HAS_QA_GT_B = 1) generate
    QA_GT_B <= 'X';
  end generate;

  alebr1 : if C_HAS_QA_LE_B = 1 generate
    alebreg : c_reg_fd_v7_0 generic map (C_WIDTH         => 1,
                                         C_AINIT_VAL     => C_AINIT_VAL,
                                         C_SINIT_VAL     => "0",
                                         C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                                         C_SYNC_ENABLE   => C_SYNC_ENABLE,
                                         C_HAS_CE        => C_HAS_CE,
                                         C_HAS_ACLR      => C_HAS_ACLR,
                                         C_HAS_ASET      => C_HAS_ASET,
                                         C_HAS_AINIT     => 0,
                                         C_HAS_SCLR      => C_HAS_SCLR,
                                         C_HAS_SSET      => C_HAS_SSET,
                                         C_HAS_SINIT     => 0,
                                         C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
      port map(D(0) => intQA_LE_Bpipeend,
               CLK  => CLK,
               CE   => CE,
               ACLR => ACLR,
               SCLR => SCLR,
               ASET => ASET,
               SSET => SSET,
               Q(0) => intQA_LE_B);
  end generate;

  pipele : process (CLK)
  begin
    
    if intCE = '1' and CLK = '1' and CLK'last_value /= 'X' and C_PIPE_STAGES > 1 then
      pipeloop : for p in 2 to C_PIPE_STAGES-1 loop
        intQA_LE_Bpipe(p) <= intQA_LE_Bpipe(p+1);
      end loop;  -- pipeloop
      intQA_LE_Bpipe(C_PIPE_STAGES) <= intA_LE_B;
    elsif (intCE = 'X' or (CLK = 'X' and CLK'last_value = '0') or (CLK = '1' and CLK'last_value = 'X')) and C_PIPE_STAGES > 1 then
      pipeloopx : for p in 2 to C_PIPE_STAGES-1 loop
        if intQA_LE_Bpipe(p) /= intQA_LE_Bpipe(p+1) then
          intQA_LE_Bpipe(p) <= 'X';
        end if;
      end loop;  -- pipeloop
      if intQA_LE_Bpipe(C_PIPE_STAGES) /= intA_LE_B then
        intQA_LE_Bpipe(C_PIPE_STAGES) <= 'X';
      end if;
    end if;
    
  end process;  -- pipeq

  ps5 : if C_PIPE_STAGES < 2 generate
    intQA_LE_Bpipeend <= intA_LE_B;
  end generate;
  ps5b : if C_PIPE_STAGES > 1 generate
    intQA_LE_Bpipeend <= intQA_LE_Bpipe(2);
  end generate;

  qle1 : if C_HAS_QA_LE_B = 1 generate
    QA_LE_B <= intQA_LE_B;
  end generate;
  qle0 : if not (C_HAS_QA_LE_B = 1) generate
    QA_LE_B <= 'X';
  end generate;

  agebr1 : if C_HAS_QA_GE_B = 1 generate
    agebreg : c_reg_fd_v7_0 generic map (C_WIDTH         => 1,
                                         C_AINIT_VAL     => C_AINIT_VAL,
                                         C_SINIT_VAL     => "0",
                                         C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                                         C_SYNC_ENABLE   => C_SYNC_ENABLE,
                                         C_HAS_CE        => C_HAS_CE,
                                         C_HAS_ACLR      => C_HAS_ACLR,
                                         C_HAS_ASET      => C_HAS_ASET,
                                         C_HAS_AINIT     => 0,
                                         C_HAS_SCLR      => C_HAS_SCLR,
                                         C_HAS_SSET      => C_HAS_SSET,
                                         C_HAS_SINIT     => 0,
                                         C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
      port map(D(0) => intQA_GE_Bpipeend,
               CLK  => CLK,
               CE   => CE,
               ACLR => ACLR,
               SCLR => SCLR,
               ASET => ASET,
               SSET => SSET,
               Q(0) => intQA_GE_B);
  end generate;

  pipege : process (CLK)
  begin
    
    if intCE = '1' and CLK = '1' and CLK'last_value /= 'X' and C_PIPE_STAGES > 1 then
      pipeloop : for p in 2 to C_PIPE_STAGES-1 loop
        intQA_GE_Bpipe(p) <= intQA_GE_Bpipe(p+1);
      end loop;  -- pipeloop
      intQA_GE_Bpipe(C_PIPE_STAGES) <= intA_GE_B;
    elsif (intCE = 'X' or (CLK = 'X' and CLK'last_value = '0') or (CLK = '1' and CLK'last_value = 'X')) and C_PIPE_STAGES > 1 then
      pipeloopx : for p in 2 to C_PIPE_STAGES-1 loop
        if intQA_GE_Bpipe(p) /= intQA_GE_Bpipe(p+1) then
          intQA_GE_Bpipe(p) <= 'X';
        end if;
      end loop;  -- pipeloop
      if intQA_GE_Bpipe(C_PIPE_STAGES) /= intA_GE_B then
        intQA_GE_Bpipe(C_PIPE_STAGES) <= 'X';
      end if;
    end if;
    
  end process;  -- pipeq

  ps6 : if C_PIPE_STAGES < 2 generate
    intQA_GE_Bpipeend <= intA_GE_B;
  end generate;
  ps6b : if C_PIPE_STAGES > 1 generate
    intQA_GE_Bpipeend <= intQA_GE_Bpipe(2);
  end generate;

  qge1 : if C_HAS_QA_GE_B = 1 generate
    QA_GE_B <= intQA_GE_B;
  end generate;
  qge0 : if not (C_HAS_QA_GE_B = 1) generate
    QA_GE_B <= 'X';
  end generate;
  
  
end behavioral;


