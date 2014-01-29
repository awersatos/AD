-- $Id: c_twos_comp_v5_0_comp.vhd,v 1.17 2008/09/08 20:05:58 akennedy Exp $
--
-- Filename - c_twos_comp_v5_0_comp.vhd
-- Author - Xilinx
-- Creation - 4 Mar 1999
--
-- Description - This file contains the component declaration for
--				 the C_TWOS_COMP_V5_0 core

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v5_0.all;

package c_twos_comp_v5_0_comp is

	
----- Component C_TWOS_COMP_V5_0 -----
-- Short Description
--
-- (A)synchronous 2's complimenter
--

component C_TWOS_COMP_V5_0 
	generic(
			 C_WIDTH 		: integer := 16;
			 C_AINIT_VAL 	: string  := ""; 		
			 C_SINIT_VAL 	: string  := ""; 		
			 C_BYPASS_ENABLE: integer := c_override;
			 C_BYPASS_LOW	: integer := 0;
			 C_SYNC_PRIORITY: integer := c_clear; 	
			 C_SYNC_ENABLE 	: integer := c_override;
			 C_PIPE_STAGES	: integer := 0;
			 C_HAS_BYPASS	: integer := 0;
			 C_HAS_CE 		: integer := 0;
			 C_HAS_ACLR 	: integer := 0;
			 C_HAS_ASET 	: integer := 0;
			 C_HAS_AINIT 	: integer := 0;
			 C_HAS_SCLR 	: integer := 0;
			 C_HAS_SSET 	: integer := 0;
			 C_HAS_SINIT 	: integer := 0;
			 C_HAS_S 		: integer := 0;
			 C_HAS_Q 		: integer := 1;
			 C_ENABLE_RLOCS : integer := 1
			);

    port (A : in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- SIGNED input value!
		  BYPASS : in std_logic := '0'; -- Control of negation : '0' = Negate input
		  CLK : in std_logic := '0'; -- Clock
		  CE : in std_logic := '1'; -- Clock Enable
		  ACLR : in std_logic := '0'; -- Asynch init.
		  ASET : in std_logic := '0'; -- Asynch set.
		  AINIT : in std_logic := '0'; -- Asynch init.
		  SCLR : in std_logic := '0'; -- Synch init.
		  SSET : in std_logic := '0'; -- Synch set.		  
		  SINIT : in std_logic := '0'; -- Synch init.
		  S : out std_logic_vector(C_WIDTH downto 0); -- Asynch output
		  Q : out std_logic_vector(C_WIDTH downto 0) -- Registered output value
		  );
		  	
end component;


end c_twos_comp_v5_0_comp;
