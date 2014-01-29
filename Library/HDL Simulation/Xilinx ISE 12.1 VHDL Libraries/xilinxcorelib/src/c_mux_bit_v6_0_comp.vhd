-- Copyright(C) 2002 by Xilinx, Inc. All rights reserved.              
-- This text contains proprietary, confidential                        
-- information of Xilinx, Inc., is distributed                         
-- under license from Xilinx, Inc., and may be used,                   
-- copied and/or disclosed only pursuant to the terms                  
-- of a valid license agreement with Xilinx, Inc. This copyright       
-- notice must be retained as part of this text at all times.          

-- $Id: c_mux_bit_v6_0_comp.vhd,v 1.16 2008/09/08 20:06:06 akennedy Exp $
--
-- Filename - c_mux_bit_v6_0_comp.vhd
-- Author - Xilinx
-- Creation - 3 Mar 1999
--
-- Description - This file contains the component declaration for
--                               the C_MUX_BIT_V6_0 core

library IEEE;
use IEEE.std_logic_1164.all;

library XilinxCoreLib;
use XilinxCoreLib.prims_constants_v6_0.all;

package c_mux_bit_v6_0_comp is


----- Component C_MUX_BIT_V6_0 -----
-- Short Description
--
-- (A)Synchronous N-to-1 Mux
--

   component C_MUX_BIT_V6_0
      generic (C_INPUTS        : integer := 2;
               C_SEL_WIDTH     : integer := 1;
               C_PIPE_STAGES   : integer := 0;
               C_LATENCY       : integer := 1;
               C_HEIGHT          : integer := 0;
               C_AINIT_VAL     : string  := "";
               C_SINIT_VAL     : string  := "";
               C_SYNC_ENABLE   : integer := c_override;
               C_SYNC_PRIORITY : integer := c_clear;
               C_HAS_O         : integer := 0;
               C_HAS_Q         : integer := 1;
               C_HAS_CE        : integer := 0;
               C_HAS_ACLR      : integer := 0;
               C_HAS_ASET      : integer := 0;
               C_HAS_AINIT     : integer := 0;
               C_HAS_SCLR      : integer := 0;
               C_HAS_SSET      : integer := 0;
               C_HAS_SINIT     : integer := 0;
               C_ENABLE_RLOCS  : integer := 1
               ); 

      port (M     : in  std_logic_vector(C_INPUTS-1 downto 0)    := (others => '0');  -- Input vector
            S     : in  std_logic_vector(C_SEL_WIDTH-1 downto 0) := (others => '0');  -- Select pin
            CLK   : in  std_logic                                := '0';  -- Optional clock
            CE    : in  std_logic                                := '1';  -- Optional Clock enable
            AINIT : in  std_logic                                := '0';  -- optional asynch reset to init_val
            ASET  : in  std_logic                                := '0';  -- optional asynch set to '1'
            ACLR  : in  std_logic                                := '0';  -- optional asynch clear to '0'
            SINIT : in  std_logic                                := '0';  -- Optional synch reset to init_val
            SSET  : in  std_logic                                := '0';  -- optional synch set to '1'
            SCLR  : in  std_logic                                := '0';  -- optional synch set to '0'
            O     : out std_logic;      -- Output value
            Q     : out std_logic);     -- Registered output value
   end component;


end c_mux_bit_v6_0_comp;
