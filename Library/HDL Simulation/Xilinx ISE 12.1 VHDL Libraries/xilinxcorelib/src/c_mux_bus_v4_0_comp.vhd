-- $Id: c_mux_bus_v4_0_comp.vhd,v 1.10 2008/09/08 20:05:48 akennedy Exp $
--
-- Filename - c_mux_bus_v4_0_comp.vhd
-- Author - Xilinx
-- Creation - 3 Mar 1999
--
-- Description - This file contains the component declaration for
--				 the C_MUX_BUS_V4_0 core

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v4_0.all;

package c_mux_bus_v4_0_comp is

----- Component C_MUX_BUS_V4_0 -----
-- Short Description
--
-- (A)Synchronous N*M-to-M Mux
--
component C_MUX_BUS_V4_0
	generic(
			 C_WIDTH 	: integer := 16;
			 C_INPUTS 	: integer := 2;
			 C_MUX_TYPE	: integer := c_lut_based;
			 C_SEL_WIDTH 	: integer := 1;
			 C_AINIT_VAL 	: string  := "";
			 C_SINIT_VAL 	: string  := "";
			 C_SYNC_PRIORITY: integer := c_clear;
			 C_SYNC_ENABLE 	: integer := c_override;
                         C_LATENCY      : integer := 1;
			 C_HAS_O 	: integer := 0;
			 C_HAS_Q 	: integer := 1;
			 C_HAS_CE 	: integer := 1;
			 C_HAS_EN 	: integer := 1;
			 C_HAS_ACLR 	: integer := 0;
			 C_HAS_ASET 	: integer := 0;
			 C_HAS_AINIT 	: integer := 0;
			 C_HAS_SCLR 	: integer := 0;
			 C_HAS_SSET 	: integer := 0;
			 C_HAS_SINIT 	: integer := 0;
			 C_ENABLE_RLOCS : integer := 1
			 ); 
			 
    port (MA 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MB 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MC 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MD 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  ME 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MF 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MG 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MH	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
                  MAA 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MAB 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MAC 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MAD 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MAE 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MAF 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MAG 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MAH	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
                  MBA 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MBB 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MBC 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MBD 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MBE 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MBF 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MBG 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MBH	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
                  MCA 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MCB 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MCC 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MCD 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MCE 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MCF 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MCG 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  MCH	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  S 	: in std_logic_vector(C_SEL_WIDTH-1 downto 0) := (others => '0'); -- Select pin
		  CLK 	: in std_logic := '0'; -- Optional clock
		  CE 	: in std_logic := '1';  -- Optional Clock enable
		  EN 	: in std_logic := '0';  -- Optional BUFT enable
		  ASET 	: in std_logic := '0'; -- optional asynch set to '1'
		  ACLR 	: in std_logic := '0'; -- Asynch init.
		  AINIT : in std_logic := '0'; -- optional asynch reset to init_val
		  SSET 	: in std_logic := '0'; -- optional synch set to '1'
		  SCLR 	: in std_logic := '0'; -- Synch init.
		  SINIT : in std_logic := '0'; -- Optional synch reset to init_val
		  O 	: out std_logic_vector(C_WIDTH-1 downto 0); -- Output value
		  Q 	: out std_logic_vector(C_WIDTH-1 downto 0) -- Registered output value
		  );
end component;


end c_mux_bus_v4_0_comp;
