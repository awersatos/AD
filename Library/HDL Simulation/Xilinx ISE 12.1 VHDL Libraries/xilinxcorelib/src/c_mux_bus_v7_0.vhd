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

-- $Id: c_mux_bus_v7_0.vhd,v 1.13 2008/09/08 20:06:15 akennedy Exp $
--
-- Filename - c_mux_bus_v7_0.vhd
-- Author - Xilinx
-- Creation - 4 Feb 1999
--
-- Description - This file contains the behavior for the baseblocks C_MUX_BUS_V7_0 module

library IEEE;
use IEEE.std_logic_1164.all;

library XilinxCoreLib;
use XilinxCoreLib.prims_utils_v7_0.all;
use XilinxCoreLib.prims_constants_v7_0.all;
use XilinxCoreLib.c_reg_fd_v7_0_comp.all;

-- n*m to 1*m mux

entity C_MUX_BUS_V7_0 is
   generic(
      C_WIDTH         : integer := 16;
      C_INPUTS        : integer := 2;
      C_MUX_TYPE      : integer := c_lut_based;
      C_SEL_WIDTH     : integer := 1;
      C_AINIT_VAL     : string  := "";
      C_SINIT_VAL     : string  := "";
      C_SYNC_PRIORITY : integer := c_clear;
      C_SYNC_ENABLE   : integer := c_override;
      C_LATENCY       : integer := 1;
      C_HEIGHT        : integer := 0;
      C_HAS_O         : integer := 0;
      C_HAS_Q         : integer := 1;
      C_HAS_CE        : integer := 1;
      C_HAS_EN        : integer := 1;
      C_HAS_ACLR      : integer := 0;
      C_HAS_ASET      : integer := 0;
      C_HAS_AINIT     : integer := 0;
      C_HAS_SCLR      : integer := 0;
      C_HAS_SSET      : integer := 0;
      C_HAS_SINIT     : integer := 0;
      C_ENABLE_RLOCS  : integer := 1
      ); 

   port (MA    : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MB    : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MC    : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MD    : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         ME    : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MF    : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MG    : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MH    : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MAA   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MAB   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MAC   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MAD   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MAE   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MAF   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MAG   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MAH   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MBA   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MBB   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MBC   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MBD   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MBE   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MBF   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MBG   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MBH   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MCA   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MCB   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MCC   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MCD   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MCE   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MCF   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MCG   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         MCH   : in  std_logic_vector(C_WIDTH-1 downto 0)     := (others => '0');  -- Input vector
         S     : in  std_logic_vector(C_SEL_WIDTH-1 downto 0) := (others => '0');  -- Select pin
         CLK   : in  std_logic                                := '0';  -- Optional clock
         CE    : in  std_logic                                := '1';  -- Optional Clock enable
         EN    : in  std_logic                                := '0';  -- Optional BUFT enable
         ASET  : in  std_logic                                := '0';  -- optional asynch set to '1'
         ACLR  : in  std_logic                                := '0';  -- Asynch init.
         AINIT : in  std_logic                                := '0';  -- optional asynch reset to init_val
         SSET  : in  std_logic                                := '0';  -- optional synch set to '1'
         SCLR  : in  std_logic                                := '0';  -- Synch init.
         SINIT : in  std_logic                                := '0';  -- Optional synch reset to init_val
         O     : out std_logic_vector(C_WIDTH-1 downto 0);   -- Output value
         Q     : out std_logic_vector(C_WIDTH-1 downto 0));  -- Registered output value

end C_MUX_BUS_V7_0;

architecture behavioral of C_MUX_BUS_V7_0 is

   constant timeunit : time := 1 ns;

   signal   intO  : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');
   signal   intQ  : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');
   constant n_sel : integer                              := C_SEL_WIDTH;
   -- signals for optional pins...
   signal   intEN : std_logic;

   signal Pipe1In, Pipe1Out : std_logic_vector(C_WIDTH-1 downto 0);
   signal opreg_in          : std_logic_vector(C_WIDTH-1 downto 0);

   signal intMA, intMB, intMC, intMD, intME, intMF, intMG, intMH         : std_logic_vector(C_WIDTH-1 downto 0);
   signal intMAA, intMAB, intMAC, intMAD, intMAE, intMAF, intMAG, intMAH : std_logic_vector(C_WIDTH-1 downto 0);
   signal intMBA, intMBB, intMBC, intMBD, intMBE, intMBF, intMBG, intMBH : std_logic_vector(C_WIDTH-1 downto 0);
   signal intMCA, intMCB, intMCC, intMCD, intMCE, intMCF, intMCG, intMCH : std_logic_vector(C_WIDTH-1 downto 0);
begin

   ci32 : if C_INPUTS = 32 generate
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
   end generate;

   ci31 : if C_INPUTS = 31 generate
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
      intMCH <= (others => 'X');
   end generate;

   ci30 : if C_INPUTS = 30 generate
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
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;

   ci29 : if C_INPUTS = 29 generate
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
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;

   ci28 : if C_INPUTS = 28 generate
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
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;

   ci27 : if C_INPUTS = 27 generate
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
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;

   ci26 : if C_INPUTS = 26 generate
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
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;

   ci25 : if C_INPUTS = 25 generate
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
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;

   ci24 : if C_INPUTS = 24 generate
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
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;

   ci23 : if C_INPUTS = 23 generate
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
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;

   ci22 : if C_INPUTS = 22 generate
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
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci21 : if C_INPUTS = 21 generate
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
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci20 : if C_INPUTS = 20 generate
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
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci19 : if C_INPUTS = 19 generate
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
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci18 : if C_INPUTS = 18 generate
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
      intMBC <= (others => 'X');
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci17 : if C_INPUTS = 17 generate
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
      intMBB <= (others => 'X');
      intMBC <= (others => 'X');
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci16 : if C_INPUTS = 16 generate
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
      intMBA <= (others => 'X');
      intMBB <= (others => 'X');
      intMBC <= (others => 'X');
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;


   ci15 : if C_INPUTS = 15 generate
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
      intMAH <= (others => 'X');
      intMBA <= (others => 'X');
      intMBB <= (others => 'X');
      intMBC <= (others => 'X');
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci14 : if C_INPUTS = 14 generate
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
      intMAG <= (others => 'X');
      intMAH <= (others => 'X');
      intMBA <= (others => 'X');
      intMBB <= (others => 'X');
      intMBC <= (others => 'X');
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci13 : if C_INPUTS = 13 generate
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
      intMAF <= (others => 'X');
      intMAG <= (others => 'X');
      intMAH <= (others => 'X');
      intMBA <= (others => 'X');
      intMBB <= (others => 'X');
      intMBC <= (others => 'X');
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci12 : if C_INPUTS = 12 generate
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
      intMAE <= (others => 'X');
      intMAF <= (others => 'X');
      intMAG <= (others => 'X');
      intMAH <= (others => 'X');
      intMBA <= (others => 'X');
      intMBB <= (others => 'X');
      intMBC <= (others => 'X');
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci11 : if C_INPUTS = 11 generate
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
      intMAD <= (others => 'X');
      intMAE <= (others => 'X');
      intMAF <= (others => 'X');
      intMAG <= (others => 'X');
      intMAH <= (others => 'X');
      intMBA <= (others => 'X');
      intMBB <= (others => 'X');
      intMBC <= (others => 'X');
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci10 : if C_INPUTS = 10 generate
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
      intMAC <= (others => 'X');
      intMAD <= (others => 'X');
      intMAE <= (others => 'X');
      intMAF <= (others => 'X');
      intMAG <= (others => 'X');
      intMAH <= (others => 'X');
      intMBA <= (others => 'X');
      intMBB <= (others => 'X');
      intMBC <= (others => 'X');
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci9 : if C_INPUTS = 9 generate
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= MAA;
      intMAB <= (others => 'X');
      intMAC <= (others => 'X');
      intMAD <= (others => 'X');
      intMAE <= (others => 'X');
      intMAF <= (others => 'X');
      intMAG <= (others => 'X');
      intMAH <= (others => 'X');
      intMBA <= (others => 'X');
      intMBB <= (others => 'X');
      intMBC <= (others => 'X');
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;

   -- Deal with optional pins...
   ci8 : if C_INPUTS = 8 generate
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= MH;
      intMAA <= (others => 'X');
      intMAB <= (others => 'X');
      intMAC <= (others => 'X');
      intMAD <= (others => 'X');
      intMAE <= (others => 'X');
      intMAF <= (others => 'X');
      intMAG <= (others => 'X');
      intMAH <= (others => 'X');
      intMBA <= (others => 'X');
      intMBB <= (others => 'X');
      intMBC <= (others => 'X');
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci7 : if C_INPUTS = 7 generate
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= MG;
      intMH  <= (others => 'X');
      intMAA <= (others => 'X');
      intMAB <= (others => 'X');
      intMAC <= (others => 'X');
      intMAD <= (others => 'X');
      intMAE <= (others => 'X');
      intMAF <= (others => 'X');
      intMAG <= (others => 'X');
      intMAH <= (others => 'X');
      intMBA <= (others => 'X');
      intMBB <= (others => 'X');
      intMBC <= (others => 'X');
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci6 : if C_INPUTS = 6 generate
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= MF;
      intMG  <= (others => 'X');
      intMH  <= (others => 'X');
      intMAA <= (others => 'X');
      intMAB <= (others => 'X');
      intMAC <= (others => 'X');
      intMAD <= (others => 'X');
      intMAE <= (others => 'X');
      intMAF <= (others => 'X');
      intMAG <= (others => 'X');
      intMAH <= (others => 'X');
      intMBA <= (others => 'X');
      intMBB <= (others => 'X');
      intMBC <= (others => 'X');
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci5 : if C_INPUTS = 5 generate
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= ME;
      intMF  <= (others => 'X');
      intMG  <= (others => 'X');
      intMH  <= (others => 'X');
      intMAA <= (others => 'X');
      intMAB <= (others => 'X');
      intMAC <= (others => 'X');
      intMAD <= (others => 'X');
      intMAE <= (others => 'X');
      intMAF <= (others => 'X');
      intMAG <= (others => 'X');
      intMAH <= (others => 'X');
      intMBA <= (others => 'X');
      intMBB <= (others => 'X');
      intMBC <= (others => 'X');
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci4 : if C_INPUTS = 4 generate
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= MD;
      intME  <= (others => 'X');
      intMF  <= (others => 'X');
      intMG  <= (others => 'X');
      intMH  <= (others => 'X');
      intMAA <= (others => 'X');
      intMAB <= (others => 'X');
      intMAC <= (others => 'X');
      intMAD <= (others => 'X');
      intMAE <= (others => 'X');
      intMAF <= (others => 'X');
      intMAG <= (others => 'X');
      intMAH <= (others => 'X');
      intMBA <= (others => 'X');
      intMBB <= (others => 'X');
      intMBC <= (others => 'X');
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci3 : if C_INPUTS = 3 generate
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= MC;
      intMD  <= (others => 'X');
      intME  <= (others => 'X');
      intMF  <= (others => 'X');
      intMG  <= (others => 'X');
      intMH  <= (others => 'X');
      intMAA <= (others => 'X');
      intMAB <= (others => 'X');
      intMAC <= (others => 'X');
      intMAD <= (others => 'X');
      intMAE <= (others => 'X');
      intMAF <= (others => 'X');
      intMAG <= (others => 'X');
      intMAH <= (others => 'X');
      intMBA <= (others => 'X');
      intMBB <= (others => 'X');
      intMBC <= (others => 'X');
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;
   ci2 : if C_INPUTS = 2 generate
      intMA  <= MA;
      intMB  <= MB;
      intMC  <= (others => 'X');
      intMD  <= (others => 'X');
      intME  <= (others => 'X');
      intMF  <= (others => 'X');
      intMG  <= (others => 'X');
      intMH  <= (others => 'X');
      intMAA <= (others => 'X');
      intMAB <= (others => 'X');
      intMAC <= (others => 'X');
      intMAD <= (others => 'X');
      intMAE <= (others => 'X');
      intMAF <= (others => 'X');
      intMAG <= (others => 'X');
      intMAH <= (others => 'X');
      intMBA <= (others => 'X');
      intMBB <= (others => 'X');
      intMBC <= (others => 'X');
      intMBD <= (others => 'X');
      intMBE <= (others => 'X');
      intMBF <= (others => 'X');
      intMBG <= (others => 'X');
      intMBH <= (others => 'X');
      intMCA <= (others => 'X');
      intMCB <= (others => 'X');
      intMCC <= (others => 'X');
      intMCD <= (others => 'X');
      intMCE <= (others => 'X');
      intMCF <= (others => 'X');
      intMCG <= (others => 'X');
      intMCH <= (others => 'X');
   end generate;

   en1 : if C_HAS_EN = 1 generate
      intEN <= EN;
   end generate;
   en0 : if not (C_HAS_EN = 1) generate
      intEN <= '1';
   end generate;
   
   
   p1 : process(intMA, intMB, intMC, intMD, intME, intMF, intMG, intMH,
                intMAA, intMAB, intMAC, intMAD, intMAE, intMAF, intMAG, intMAH,
                intMBA, intMBB, intMBC, intMBD, intMBE, intMBF, intMBG, intMBH,
                intMCA, intMCB, intMCC, intMCD, intMCE, intMCF, intMCG, intMCH,
                intEN, S)
      variable k : integer := 1;
      variable j : integer := 1;
   begin
      k := 1;
      j := 1;

      for i in 0 to n_sel-1 loop
         if(S(i) = '1') then
            k := k + j;
         end if;

         j := j * 2;
      end loop;

      -- Check that this is a valid sel value and enable is not active!!
      if intEN = '0' then
         intO <= (others => 'Z') after timeunit;
      elsif intEN = 'X' then
         intO <= (others => 'X') after timeunit;
      elsif k > C_INPUTS then
         intO <= (others => 'X') after timeunit;
      elsif is_X(S) then
         intO <= (others => 'X') after timeunit;
      else
         -- Select the k'th input word for output
         if k = 1 then
            intO <= intMA after timeunit;
         elsif k = 2 then
            intO <= intMB after timeunit;
         elsif k = 3 then
            intO <= intMC after timeunit;
         elsif k = 4 then
            intO <= intMD after timeunit;
         elsif k = 5 then
            intO <= intME after timeunit;
         elsif k = 6 then
            intO <= intMF after timeunit;
         elsif k = 7 then
            intO <= intMG after timeunit;
         elsif k = 8 then
            intO <= intMH after timeunit;
         elsif k = 9 then
            intO <= intMAA after timeunit;
         elsif k = 10 then
            intO <= intMAB after timeunit;
         elsif k = 11 then
            intO <= intMAC after timeunit;
         elsif k = 12 then
            intO <= intMAD after timeunit;
         elsif k = 13 then
            intO <= intMAE after timeunit;
         elsif k = 14 then
            intO <= intMAF after timeunit;
         elsif k = 15 then
            intO <= intMAG after timeunit;
         elsif k = 16 then
            intO <= intMAH after timeunit;
         elsif k = 17 then
            intO <= intMBA after timeunit;
         elsif k = 18 then
            intO <= intMBB after timeunit;
         elsif k = 19 then
            intO <= intMBC after timeunit;
         elsif k = 20 then
            intO <= intMBD after timeunit;
         elsif k = 21 then
            intO <= intMBE after timeunit;
         elsif k = 22 then
            intO <= intMBF after timeunit;
         elsif k = 23 then
            intO <= intMBG after timeunit;
         elsif k = 24 then
            intO <= intMBH after timeunit;
         elsif k = 25 then
            intO <= intMCA after timeunit;
         elsif k = 26 then
            intO <= intMCB after timeunit;
         elsif k = 27 then
            intO <= intMCC after timeunit;
         elsif k = 28 then
            intO <= intMCD after timeunit;
         elsif k = 29 then
            intO <= intMCE after timeunit;
         elsif k = 30 then
            intO <= intMCF after timeunit;
         elsif k = 31 then
            intO <= intMCG after timeunit;
         elsif k = 32 then
            intO <= intMCH after timeunit;
         else                           -- Invalid sel value!
            intO <= (others => 'X') after timeunit;
         end if;
      end if;
      
   end process;


   q1 : if (C_HAS_Q = 1) and (C_LATENCY = 1) generate
      Q        <= intQ;
      opreg_in <= intO;
   end generate;


   q2 : if (C_HAS_Q = 1) and (C_LATENCY = 2) generate
      Q        <= intQ;
      opreg_in <= Pipe1Out;
      Pipe1In  <= intO;
   end generate;


   q0 : if not (C_HAS_Q = 1) generate
      Q <= (others => 'X');
   end generate;


   o0 : if not (C_HAS_O = 1) generate
      O <= (others => 'X');
   end generate;


   o1 : if C_HAS_O = 1 generate
      O <= intO;
   end generate;


   g1 : if (C_HAS_Q = 1) generate       -- Need a register on the output

      opreg : c_reg_fd_v7_0 generic map(C_WIDTH         => C_WIDTH,
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
         port map(D     => opreg_in,
                  CLK   => CLK,
                  CE    => CE,
                  ACLR  => ACLR,
                  SCLR  => SCLR,
                  ASET  => ASET,
                  SSET  => SSET,
                  AINIT => AINIT,
                  SINIT => SINIT,
                  Q     => intQ);

   end generate;


   g2 : if (C_LATENCY = 2) generate     -- Need a register on the output


       Pipe1 : c_reg_fd_v7_0 generic map(C_WIDTH          => C_WIDTH,
                                          C_AINIT_VAL     => C_AINIT_VAL,
                                          C_SINIT_VAL     => C_SINIT_VAL,
                                          C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                                          C_SYNC_ENABLE   => C_SYNC_ENABLE,
                                          C_HAS_CE        => C_HAS_CE,
                                          C_HAS_ACLR      => 0,
                                          C_HAS_ASET      => 0,
                                          C_HAS_AINIT     => 0,
                                          C_HAS_SCLR      => C_HAS_SCLR,
                                          C_HAS_SSET      => 0,
                                          C_HAS_SINIT     => 0,
                                          C_ENABLE_RLOCS  => C_ENABLE_RLOCS)
          port map(D     => Pipe1In,
                   CLK   => CLK,
                   CE    => CE,
                   ACLR  => ACLR,
                   SCLR  => SCLR,
                   ASET  => ASET,
                   SSET  => SSET,
                   AINIT => AINIT,
                   SINIT => SINIT,
                   Q     => Pipe1Out);


--      Pipe1 : c_reg_fd_v7_0 generic map(C_WIDTH         => C_WIDTH,
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

      

   end generate;

end behavioral;
