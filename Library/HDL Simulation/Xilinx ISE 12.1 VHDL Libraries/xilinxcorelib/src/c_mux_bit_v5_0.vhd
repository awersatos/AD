-- $Id: c_mux_bit_v5_0.vhd,v 1.17 2008/09/08 20:05:57 akennedy Exp $
--
-- Filename - c_mux_bit_v5_0.vhd
-- Author - Xilinx
-- Creation - 9 Oct 1998
--
-- Description - This file contains the behavior for the baseblocks C_MUX_BIT_V5_0 module

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_utils_v5_0.all;
use XilinxCoreLib.prims_constants_v5_0.all;
Use XilinxCoreLib.c_reg_fd_v5_0_comp.all;

-- n to 1 mux

entity C_MUX_BIT_V5_0 is
	        generic (C_INPUTS 	: integer := 2;
			 C_SEL_WIDTH 	: integer := 1;
                         C_PIPE_STAGES  : integer := 0;
			 C_LATENCY 	: integer := 1;
			 C_AINIT_VAL 	: string  := "";
			 C_SINIT_VAL 	: string  := "";
			 C_SYNC_ENABLE 	: integer := c_override;
			 C_SYNC_PRIORITY: integer := c_clear;
			 C_HAS_O 	: integer := 0;
			 C_HAS_Q 	: integer := 1;
			 C_HAS_CE 	: integer := 0;
			 C_HAS_ACLR 	: integer := 0;
			 C_HAS_ASET 	: integer := 0;
			 C_HAS_AINIT 	: integer := 0;
			 C_HAS_SCLR 	: integer := 0;
			 C_HAS_SSET 	: integer := 0;
			 C_HAS_SINIT 	: integer := 0;
			 C_ENABLE_RLOCS : integer := 1
			); 

            port (M 	: in std_logic_vector(C_INPUTS-1 downto 0) := (others => '0'); -- Input vector
		  S 	: in std_logic_vector(C_SEL_WIDTH-1 downto 0) := (others => '0'); -- Select pin
		  CLK 	: in std_logic := '0'; -- Optional clock
		  CE 	: in std_logic := '1';  -- Optional Clock enable
		  AINIT : in std_logic := '0'; -- optional asynch reset to init_val
		  ASET 	: in std_logic := '0'; -- optional asynch set to '1'
		  ACLR 	: in std_logic := '0'; -- optional asynch clear to '0'
		  SINIT : in std_logic := '0'; -- Optional synch reset to init_val
		  SSET 	: in std_logic := '0'; -- optional synch set to '1'
		  SCLR 	: in std_logic := '0'; -- optional synch set to '0'
		  O 	: out std_logic; -- Output value
		  Q 	: out std_logic); -- Registered output value

end C_MUX_BIT_V5_0;

architecture behavioral of C_MUX_BIT_V5_0 is

	constant timeunit : time := 1 ns;

	signal intO : std_logic := 'X';
	signal intQ : std_logic := 'X';

        signal opreg_in : std_logic := 'X';
        signal Pipe1In, Pipe1Out : std_logic := 'X'; 
        signal Pipe2In, Pipe2Out : std_logic := 'X';

begin
		
	p1 : process(M,S)
	begin
        	
           -- Use the selection value on the S std_logic_vector
           -- as an index, to pick the chosen value from M.

           -- also, check that S will choose a value present
           -- in M.  If it is too big, set intO to 'X'.
           -- Also, if S is an 'X', set intO to 'X'
                      
           if is_X(S) then
	      intO <= 'X' after timeunit;
           elsif (to_integer(unsigned(S))) > C_INPUTS - 1 then
	      intO <= 'X' after timeunit;
           else		
              intO <= M(to_integer(unsigned(S))) after timeunit;
           end if;		
		
	end process;


        -- Connect together the mux, and any registers used.
	
	q1 : if (C_HAS_Q = 1) and (C_LATENCY = 1) generate
		Q <= intQ;
                opreg_in <= intO;
	end generate;

        q2 : if (C_HAS_Q = 1) and (C_LATENCY = 2) generate
		Q <= intQ;
                opreg_in <= Pipe1Out;
                Pipe1In <= intO;
	end generate;

        q3 : if (C_HAS_Q = 1) and (C_LATENCY = 3) generate
                Q <= intQ;
                opreg_in <= Pipe2Out;
                Pipe2In <= Pipe1Out;
                Pipe1In <= intO;
        end generate;



        -- set the outputs according to the parameters
        -- C_HAS_Q and C_HAS_O

	q0 : if not (C_HAS_Q = 1) generate
		Q <= 'X';
	end generate;
		
	o0: if not (C_HAS_O = 1) generate
		O <= 'X';
	end generate;
	o1: if C_HAS_O = 1 generate
		O <= intO;
	end generate;

	

	g1: if (C_HAS_Q = 1)  generate
        -- if an output register is required
        -- create a reg_fd, with full control available.

		opreg : c_reg_fd_v5_0 generic map(C_WIDTH => 1,
						  C_AINIT_VAL => C_AINIT_VAL,
						  C_SINIT_VAL => C_SINIT_VAL,
						  C_SYNC_PRIORITY => C_SYNC_PRIORITY,
					          C_SYNC_ENABLE => C_SYNC_ENABLE,
			                          C_HAS_CE => C_HAS_CE,
					          C_HAS_ACLR => C_HAS_ACLR,
						  C_HAS_ASET => C_HAS_ASET,
						  C_HAS_AINIT => C_HAS_AINIT,
						  C_HAS_SCLR => C_HAS_SCLR,
						  C_HAS_SSET => C_HAS_SSET,
					          C_HAS_SINIT => C_HAS_SINIT,
						  C_ENABLE_RLOCS => C_ENABLE_RLOCS)
					 port map(D(0) => opreg_in,
						  CLK => CLK,
						  CE => CE,
						  ACLR => ACLR,
						  SCLR => SCLR,
						  ASET => ASET,
					          SSET => SSET,
					          AINIT => AINIT,
						  SINIT => SINIT,
						  Q(0) => intQ);
									 
	end generate;

        g2: if (C_HAS_Q = 1) and (C_LATENCY > 1) generate
           --if the latency value, is greater than 1, then a pipelined
           --mux is needed.  Therefore, create a pipelining register,
           --with all synchronous and asynchronous controls removed:
           --with the exception of the optional clock enable, and 
           --synchronous clear.  This will allow the pipeline to be
           --controlled.        

           pipereg1 : c_reg_fd_v5_0 generic map(C_WIDTH => 1,
                                             C_AINIT_VAL => C_AINIT_VAL,
                                             C_SINIT_VAL => C_SINIT_VAL,
                                             C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                                             C_SYNC_ENABLE => C_SYNC_ENABLE,
                                             C_HAS_CE => C_HAS_CE,
                                             C_HAS_ACLR => 0,
                                             C_HAS_ASET => 0,
                                             C_HAS_AINIT => 0,
                                             C_HAS_SCLR => C_HAS_SCLR,
                                             C_HAS_SSET => 0,
                                             C_HAS_SINIT => 0,
                                             C_ENABLE_RLOCS => C_ENABLE_RLOCS)
                                    port map(D(0) => Pipe1In,
                                             CLK => CLK,
                                             CE => CE,
				             ACLR => ACLR,
				             SCLR => SCLR,
				             ASET => ASET,
					     SSET => SSET,
					     AINIT => AINIT,
					     SINIT => SINIT,
					     Q(0) => Pipe1Out);

        end generate;

        g3: if (C_HAS_Q = 1) and (C_LATENCY > 2) generate
           --if the latency value, is greater than 1, then a pipelined
           --mux is needed.  Therefore, create a pipelining register,
           --with all synchronous and asynchronous controls removed:
           --with the exception of the optional clock enable, and 
           --synchronous clear.  This will allow the pipeline to be
           --controlled.

           pipereg2 : c_reg_fd_v5_0 generic map(C_WIDTH => 1,
                                             C_AINIT_VAL => C_AINIT_VAL,
                                             C_SINIT_VAL => C_SINIT_VAL,
                                             C_SYNC_PRIORITY => C_SYNC_PRIORITY,
                                             C_SYNC_ENABLE => C_SYNC_ENABLE,
                                             C_HAS_CE => C_HAS_CE,
                                             C_HAS_ACLR => 0,
                                             C_HAS_ASET => 0,
                                             C_HAS_AINIT => 0,
                                             C_HAS_SCLR => C_HAS_SCLR,
                                             C_HAS_SSET => 0,
                                             C_HAS_SINIT => 0,
                                             C_ENABLE_RLOCS => C_ENABLE_RLOCS)
                                    port map(D(0) => Pipe2In,
                                             CLK => CLK,
                                             CE => CE,
				             ACLR => ACLR,
				             SCLR => SCLR,
				             ASET => ASET,
					     SSET => SSET,
					     AINIT => AINIT,
					     SINIT => SINIT,
					     Q(0) => Pipe2Out);

        end generate;
	
end behavioral;
