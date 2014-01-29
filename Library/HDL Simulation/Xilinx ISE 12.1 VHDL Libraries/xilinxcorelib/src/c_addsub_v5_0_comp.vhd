-- $Id: c_addsub_v5_0_comp.vhd,v 1.17 2008/09/08 20:05:57 akennedy Exp $
--
-- Filename - c_addsub_v5_0_comp.vhd
-- Author - Xilinx
-- Creation - 2 Feb 1999
--
-- Description - This file contains the component declaration for
--                               the C_ADDSUB_V5_0 core

library IEEE;
use IEEE.std_logic_1164.all;

library XilinxCoreLib;
use XilinxCoreLib.prims_constants_v5_0.all;

package c_addsub_v5_0_comp is


----- Component C_ADDSUB_V5_0 -----
-- Short Description
--
-- (A)Synchronous Adder/Subtractor
--

   component C_ADDSUB_V5_0
      generic (C_A_WIDTH       : integer := 16;
               C_B_WIDTH       : integer := 16;
               C_OUT_WIDTH     : integer := 16;
               C_LOW_BIT       : integer := 0;
               C_HIGH_BIT      : integer := 15;
               C_ADD_MODE      : integer := c_add;
               C_A_TYPE        : integer := c_unsigned;
               C_B_TYPE        : integer := c_unsigned;
               C_B_CONSTANT    : integer := 0;
               C_B_VALUE       : string  := ""; 
               C_AINIT_VAL     : string  := ""; 
               C_SINIT_VAL     : string  := ""; 
               C_BYPASS_ENABLE : integer := c_override;
               C_BYPASS_LOW    : integer := 0;
               C_SYNC_ENABLE   : integer := c_override;
               C_SYNC_PRIORITY : integer := c_clear;
               C_PIPE_STAGES   : integer := 0;
               C_LATENCY       : integer := 1;
               C_HAS_S         : integer := 0;
               C_HAS_Q         : integer := 1;
               C_HAS_C_IN      : integer := 1;
               C_HAS_C_OUT     : integer := 0;
               C_HAS_Q_C_OUT   : integer := 0;
               C_HAS_B_IN      : integer := 1;
               C_HAS_B_OUT     : integer := 0;          
               C_HAS_Q_B_OUT   : integer := 0;
               C_HAS_OVFL      : integer := 0;
               C_HAS_Q_OVFL    : integer := 0;
               C_HAS_CE        : integer := 0;
               C_HAS_ADD       : integer := 0;
               C_HAS_BYPASS    : integer := 0;
               C_HAS_A_SIGNED  : integer := 0;
               C_HAS_B_SIGNED  : integer := 0;
               C_HAS_ACLR      : integer := 0;
               C_HAS_ASET      : integer := 0;
               C_HAS_AINIT     : integer := 0;
               C_HAS_SCLR      : integer := 0;
               C_HAS_SSET      : integer := 0;
               C_HAS_SINIT     : integer := 0;
               C_ENABLE_RLOCS  : integer := 1;
               C_HAS_BYPASS_WITH_CIN : integer := 0
               ); 

      port (A        : in  std_logic_vector(C_A_WIDTH-1 downto 0) := (others => '0');  -- Input value
            B        : in  std_logic_vector(C_B_WIDTH-1 downto 0) := (others => '0');  -- Input value
            CLK      : in  std_logic                              := '0';  -- Clock
            ADD      : in  std_logic                              := '1';  -- Valid when addsub mode selected. 1 = add, 0 = subtract
            C_IN     : in  std_logic                              := '0';  -- Carry in
            B_IN     : in  std_logic                              := '0';  -- Borrow in
            CE       : in  std_logic                              := '1';  -- Clock Enable
            BYPASS   : in  std_logic                              := '0';  -- Sync load of B into reg
            ACLR     : in  std_logic                              := '0';  -- Asynch init.
            ASET     : in  std_logic                              := '0';  -- Asynch set.
            AINIT    : in  std_logic                              := '0';  -- Asynch init.
            SCLR     : in  std_logic                              := '0';  -- Synch init.
            SSET     : in  std_logic                              := '0';  -- Synch set.
            SINIT    : in  std_logic                              := '0';  -- Synch init.
            A_SIGNED : in  std_logic                              := '0';  -- '0' = unsigned, '1' = signed.
            B_SIGNED : in  std_logic                              := '0';  -- '0' = unsigned, '1' = signed.
            OVFL     : out std_logic;
            C_OUT    : out std_logic;
            B_OUT    : out std_logic;   -- Borrow out
            Q_OVFL   : out std_logic;
            Q_C_OUT  : out std_logic;
            Q_B_OUT  : out std_logic;
            S        : out std_logic_vector(C_HIGH_BIT downto C_LOW_BIT);  -- Asynch Output value
            Q        : out std_logic_vector(C_HIGH_BIT downto C_LOW_BIT)  -- Synch Output value
            );
   end component;

end c_addsub_v5_0_comp;
