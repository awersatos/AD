-- $Id: c_dist_mem_v5_0.vhd,v 1.18 2008/09/08 20:06:48 akennedy Exp $
-- ************************************************************************
--  Copyright 1998 - Xilinx, Inc.
--  All rights reserved.
-- ************************************************************************
--
--  Description:
--   Distributed RAM Simulation Model
--   VHDL-87 compatable version
--   Also compatable with VHDL-93
--   User cannot generate a Memory Initialization file from the memory
--   contents, unless xilinxcorelib.mem_init_file pack is compiled from
--   either mem_init_file_pack_87.vhd or mem_init_file_pack_93.vhd.
--   Default compilation was mem_init_file_pack.vhd
--   However, this will not be available with Emerald IP, so we shall
--   utilise the mem_init_file_pack_v3_1, which was released with the
--   last version of the sp block memory.  The content of the new package
--   is unchanged, all that has changed is the addition of a version number to
--   the package name.
--

--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;
--  
LIBRARY xilinxcorelib;
USE xilinxcorelib.ul_utils.ALL;
USE xilinxcorelib.mem_init_file_pack_v5_0.all;
USE xilinxcorelib.prims_constants_V4_0.all;
USE xilinxcorelib.prims_utils_V4_0.all;
USE xilinxcorelib.c_reg_fd_V4_0_comp.all;
--

ENTITY C_DIST_MEM_V5_0 IS
  GENERIC (
            C_ADDR_WIDTH     : integer := 6;
            C_DEFAULT_DATA   : string  := "0";
	    C_DEFAULT_DATA_RADIX : integer := 1;
            C_DEPTH          : integer := 64;
            C_ENABLE_RLOCS   : integer := 1;   -- Unused by the behavioural model
            C_GENERATE_MIF   : integer := 0;   -- Unused by the behavioural model
            C_HAS_CLK        : integer := 1;
            C_HAS_D          : integer := 1;
            C_HAS_DPO        : integer := 0;
            C_HAS_DPRA       : integer := 0;
            C_HAS_I_CE       : integer := 0;
            C_HAS_QDPO       : integer := 0;
            C_HAS_QDPO_CE    : integer := 0;
            C_HAS_QDPO_CLK   : integer := 0;
            C_HAS_QDPO_RST   : integer := 0;    -- RSTB
	    C_HAS_QDPO_SRST	: integer := 0;
            C_HAS_QSPO       : integer := 0;
            C_HAS_QSPO_CE    : integer := 0;
            C_HAS_QSPO_RST   : integer := 0;    --RSTA
	    C_HAS_QSPO_SRST	: integer := 0;
            C_HAS_RD_EN      : integer := 0;
            C_HAS_SPO        : integer := 1;
            C_HAS_SPRA       : integer := 0;
            C_HAS_WE         : integer := 1;
            C_LATENCY    : integer := 0;
            C_MEM_INIT_FILE  : string  := "null.mif";
            C_MEM_TYPE       : integer := c_sp_ram;
            C_MUX_TYPE       : integer := c_lut_based;
            C_QUALIFY_WE     : integer := 0;
            C_QCE_JOINED     : integer := 0;
            C_READ_MIF       : integer := 0;
            C_REG_A_D_INPUTS : integer := 0;
            C_REG_DPRA_INPUT : integer := 0;
            C_SYNC_ENABLE    : integer := 0;
            C_WIDTH          : integer := 16;
	    C_RAM32_FIX      : integer := 0	-- should not be passed in to simulation model
  );
  
  PORT (A        : in  std_logic_vector(C_ADDR_WIDTH-1-(4*C_HAS_SPRA*boolean'pos(C_ADDR_WIDTH>4)) downto 0) := (OTHERS => '0');
        D        : in  std_logic_vector(C_WIDTH-1 downto 0) := (OTHERS => '0');
        DPRA     : in  std_logic_vector(C_ADDR_WIDTH-1 downto 0) := (OTHERS => '0');
        SPRA     : in  std_logic_vector(C_ADDR_WIDTH-1 downto 0) := (OTHERS => '0');
        CLK      : in  std_logic := '0';
        WE       : in  std_logic := '0';
        I_CE     : in  std_logic := '1';
        RD_EN    : in  std_logic := '0';
        QSPO_CE  : in  std_logic := '1';
        QDPO_CE  : in  std_logic := '1';
        QDPO_CLK : in  std_logic := '0';
        QSPO_RST : in std_logic := '0';
        QDPO_RST : in std_logic := '0';
	QSPO_SRST : in std_logic := '0';
	QDPO_SRST : in std_logic := '0';
        SPO      : out std_logic_vector(C_WIDTH-1 downto 0);
        DPO      : out std_logic_vector(C_WIDTH-1 downto 0);
        QSPO     : out std_logic_vector(C_WIDTH-1 downto 0);
        QDPO     : out std_logic_vector(C_WIDTH-1 downto 0)); 
        
END C_DIST_MEM_V5_0;
--
-- behavior describing a parameterized distributed memory
--
ARCHITECTURE behavioral OF C_DIST_MEM_V5_0 IS
--
 -- Address signal connected to memory
 SIGNAL a_int        : STD_LOGIC_VECTOR(C_ADDR_WIDTH-1 DOWNTO 0);
 -- Read Address signal connected to srl16-based memory
 SIGNAL spra_int        : STD_LOGIC_VECTOR(C_ADDR_WIDTH-1 DOWNTO 0);
 -- DP port address signal connected to memory
 SIGNAL dpra_int     : STD_LOGIC_VECTOR(C_ADDR_WIDTH-1 DOWNTO 0);
 -- Input data signal connected to memory
 SIGNAL d_int        : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => 'X');
 -- DP output register clock
 SIGNAL doclk        : STD_LOGIC := '0';
 -- Input data/address/WE register Clock Enable
 SIGNAL ice          : STD_LOGIC := '1';
 -- Special address register Clock Enable for ROMs
 SIGNAL a_reg_ice    : STD_LOGIC := '1';
 -- DP read address port register clock enable
-- SIGNAL dpra_ce      : STD_LOGIC := '1';
 -- WE signal connected to memory
 SIGNAL we_int       : STD_LOGIC := '1';
 -- Clock enable for the WE register
 SIGNAL wece         : STD_LOGIC := '1';
 -- Read Enable signal connected to BUFT-type output mux
 SIGNAL re_int       : STD_LOGIC := '1';
 -- unregistered version of qspo_ce
 SIGNAL qspo_ce_int  : STD_LOGIC := '1'; 
 -- possibly registered version of qspo_ce
 SIGNAL qspo_ce_reg  : STD_LOGIC := '1'; 
 -- unregistered version of qdpo_ce
 SIGNAL qdpo_ce_int  : STD_LOGIC := '1'; 
 -- possibly registered version of qdpo_ce
 SIGNAL qdpo_ce_reg  : STD_LOGIC := '1'; 
 -- possibly single port registered output reset
 SIGNAL qspo_rst_int : STD_LOGIC := '1';
 -- possibly dual port registered output reset
 SIGNAL qdpo_rst_int : STD_LOGIC := '1';
 -- possibly single port registered output sync reset
 SIGNAL qspo_srst_int : STD_LOGIC := '1';
 -- possibly dual port registered output sync reset
 SIGNAL qdpo_srst_int : STD_LOGIC := '1';
 -- Direct SP output from memory
 SIGNAL spo_async    : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
 -- Direct DP output from memory
 SIGNAL dpo_async    : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
 -- Possibly pipelined SP output from memory
 SIGNAL spo_reg      : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
 -- Possibly pipelined DP output from memory
 SIGNAL dpo_reg      : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
--
 SIGNAL spo_buft     : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
 SIGNAL dpo_buft     : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0) := (OTHERS => '0');

 FUNCTION getRadix(C_DEFAULT_DATA_RADIX, C_MEM_INIT_RADIX : INTEGER) RETURN INTEGER IS
 BEGIN
    IF (C_DEFAULT_DATA_RADIX = 1) THEN
        RETURN C_MEM_INIT_RADIX;
    ELSE
        RETURN C_DEFAULT_DATA_RADIX;
    END IF;
 END getRadix;
--
 
 CONSTANT radix : INTEGER := C_DEFAULT_DATA_RADIX;
 CONSTANT pipe_stages : INTEGER := C_LATENCY-C_REG_A_D_INPUTS;
 CONSTANT dpo_pipe_stages : INTEGER := pipe_stages+C_HAS_QDPO-C_HAS_QSPO;
 -- Pipeline signals
 type ST_PIPE_SIGNAL is array (0 to pipe_stages+1) of STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
 type DT_PIPE_SIGNAL is array (0 to dpo_pipe_stages+1) of STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
 SIGNAL spo_pipe 	 : ST_PIPE_SIGNAL := (others => (others => '0'));
 SIGNAL dpo_pipe 	 : DT_PIPE_SIGNAL := (others => (others => '0'));
--
BEGIN
--
 -- Optional I_CE signal
 ice1 : IF (C_HAS_I_CE = 1) GENERATE
   ice <= I_CE;
 END GENERATE;
 ice0 : IF (C_HAS_I_CE = 0) GENERATE
   ice <= '1';
 END GENERATE;
 
 -- Different address clock enable for ROM as for other mems
 aregice1 : IF (C_MEM_TYPE = c_rom) GENERATE
   a_reg_ice <= qspo_ce_int;
 END GENERATE;
 aregice0 : IF (C_MEM_TYPE /= c_rom) GENERATE
   a_reg_ice <= ice;
 END GENERATE;
 
 -- Option CE for optional WE register
 wece1 : IF (C_HAS_WE = 1 AND C_REG_A_D_INPUTS = 1 AND C_QUALIFY_WE = 1) GENERATE
   wece <= ice;
 END GENERATE;
 wece0 : IF (C_HAS_WE = 1 AND C_REG_A_D_INPUTS = 1 AND C_QUALIFY_WE = 0) GENERATE
   wece <= '1';
 END GENERATE;
 
 -- Optional separate DP-CLK
 qdpoclk1: IF (C_HAS_QDPO_CLK = 1) GENERATE
   doclk <= QDPO_CLK;
 END GENERATE;
 -- Otherwise use common clock
 qdpoclk0: IF (C_HAS_QDPO_CLK = 0) GENERATE
   doclk <= CLK;
 END GENERATE;

 -- Optional CE signals
 qspoce1 : IF (C_HAS_QSPO_CE = 1) GENERATE
   qspo_ce_int <= QSPO_CE;
 END GENERATE;
 qspoce0 : IF (C_HAS_QSPO_CE = 0) GENERATE
   qspo_ce_int <= '1';
 END GENERATE;

 qdpoce1 : IF (C_HAS_QDPO_CE = 1 AND C_QCE_JOINED = 0) GENERATE
   qdpo_ce_int <= QDPO_CE;
 END GENERATE;
 qdpoce01 : IF (C_HAS_QSPO_CE = 1 AND C_QCE_JOINED = 1) GENERATE
   qdpo_ce_int <= qspo_ce_int;
 END GENERATE;
 qdpoce0 : IF (C_HAS_QDPO_CE = 0 AND C_HAS_QSPO_CE = 1 AND C_MEM_TYPE = c_srl16) GENERATE
   qdpo_ce_int <= qspo_ce_int;
 END GENERATE;
 qdpoce00 : IF (C_HAS_QDPO_CE = 0 AND NOT (C_HAS_QSPO_CE = 1 AND C_MEM_TYPE = c_srl16)) GENERATE
   qdpo_ce_int <= '1';
 END GENERATE;
 
 -- Optional registered output reset signals
 qsporst1 : IF (C_HAS_QSPO = 1 AND C_HAS_QSPO_RST = 1) GENERATE
    qspo_rst_int <= QSPO_RST;
 END GENERATE;
 qsporst0 : IF (NOT(C_HAS_QSPO = 1 AND C_HAS_QSPO_RST = 1)) GENERATE
    qspo_rst_int <= '0';
 END GENERATE;
 
 qdporst1 : IF (C_HAS_QDPO = 1 AND C_HAS_QDPO_RST = 1) GENERATE
    qdpo_rst_int <= QDPO_RST;
 END GENERATE;
 qdporst0 : IF (NOT(C_HAS_QDPO = 1 AND C_HAS_QDPO_RST = 1)) GENERATE
    qdpo_rst_int <= '0';
 END GENERATE;
 
 qsposrst1 : IF (C_HAS_QSPO = 1 AND C_HAS_QSPO_SRST = 1) GENERATE
    qspo_srst_int <= QSPO_SRST;
 END GENERATE;
 qsposrst0 : IF (NOT(C_HAS_QSPO = 1 AND C_HAS_QSPO_SRST = 1)) GENERATE
    qspo_srst_int <= '0';
 END GENERATE;
 
 qdposrst1 : IF (C_HAS_QDPO = 1 AND C_HAS_QDPO_SRST = 1) GENERATE
    qdpo_srst_int <= QDPO_SRST;
 END GENERATE;
 qdposrst0 : IF (NOT(C_HAS_QDPO = 1 AND C_HAS_QDPO_SRST = 1)) GENERATE
    qdpo_srst_int <= '0';
 END GENERATE;
 
 -- Optional registers on SP address and on optional data/we/qspo_ce signals

 -- No Registers! 
 a_d_reg0: IF (C_REG_A_D_INPUTS = 0) GENERATE

   qspo1 : IF (C_HAS_QSPO_CE = 1) GENERATE
     qspo_ce_reg <= qspo_ce_int;
   END GENERATE;
   qspo0 : IF (C_HAS_QSPO_CE = 0) GENERATE
     qspo_ce_reg <= '1';
   END GENERATE;

   mem1 : IF (C_MEM_TYPE /= c_srl16) GENERATE
     a_int <= A;
	 spra_int <= A;
   END GENERATE;
   mem2 : IF (C_MEM_TYPE = c_srl16) GENERATE
	   awgt4 : IF(C_ADDR_WIDTH > 4) GENERATE
	   	 a_int(C_ADDR_WIDTH-1 downto 4) <= A(C_ADDR_WIDTH-5 downto 0);
	   END GENERATE;
   	   a_int(3 downto 0) <= (others => '0');
	   
	   spra0 : IF (C_HAS_SPRA = 0) GENERATE
	   -- This is NOT possible!!
	     spra_int <= (others => 'X');
	   END GENERATE;
	   spra1 : IF (C_HAS_SPRA = 1) GENERATE
	     spra_int <= SPRA;
	   END GENERATE;	   
   END GENERATE;

   we1 : IF (C_HAS_WE = 1) GENERATE
     we_int <= we;
   END GENERATE;
   we0 : IF (C_HAS_WE = 0) GENERATE
     we_int <= '1';
   END GENERATE;

   re1 : IF (C_HAS_RD_EN = 1) GENERATE
     re_int <= RD_EN;
   END GENERATE;
   re0 : IF (C_HAS_RD_EN = 0) GENERATE
     re_int <= '1';
   END GENERATE;

   d1 : IF (C_HAS_D = 1) GENERATE
     d_int <= D;
   END GENERATE;
   d0 : IF (C_HAS_D = 0) GENERATE
     d_int <= (others => 'X');
   END GENERATE;        

 END GENERATE;
 
 -- There ARE Registers!
 a_d_reg1: IF (C_REG_A_D_INPUTS = 1) GENERATE

   qspo1 : IF (C_HAS_QSPO_CE = 1) GENERATE
     qspo1_reg : C_REG_FD_V4_0 generic map(C_WIDTH => 1,
    							  		   C_HAS_CE => 0)
    					   port map(D(0) => qspo_ce_int,
    								CLK => CLK,
    								Q(0) => qspo_ce_reg);
   END GENERATE;
   qspo0 : IF (C_HAS_QSPO_CE = 0) GENERATE
     qspo_ce_reg <= '1';
   END GENERATE;

   mem1 : IF (C_MEM_TYPE /= c_srl16) GENERATE
     a_reg : 	 C_REG_FD_V4_0 generic map(C_WIDTH => C_ADDR_WIDTH,
     									   C_HAS_CE => 1)
								port map(D => A,
										 CLK => CLK,
										 CE => a_reg_ice,
										 Q => a_int);
	 spra_int <= a_int;
   END GENERATE;
   mem2 : IF (C_MEM_TYPE = c_srl16) GENERATE
     awgt4 : IF (C_ADDR_WIDTH > 4) GENERATE
     	a_reg : 	 C_REG_FD_V4_0 generic map(C_WIDTH => C_ADDR_WIDTH-4,
     										   C_HAS_CE => 1)
								port map(D => A(C_ADDR_WIDTH-5 downto 0),
										 CLK => CLK,
										 CE => a_reg_ice,
										 Q => a_int(C_ADDR_WIDTH-1 downto 4));
	 END GENERATE;
--     spra0 : IF (C_HAS_SPRA = 0) GENERATE
   	   a_int(3 downto 0) <= (others => '0');
--	 END GENERATE;
	 spra1 : IF (C_HAS_SPRA = 1) GENERATE
       spra_reg : C_REG_FD_V4_0 generic map(C_WIDTH => C_ADDR_WIDTH,
     									    C_HAS_CE => 1)
								port map(D => SPRA,
										 CLK => CLK,
										 CE => qspo_ce_int,
										 Q => spra_int);
	 END GENERATE;
   END GENERATE;
						
   we1 : IF (C_HAS_WE = 1) GENERATE
     we_reg : C_REG_FD_V4_0 generic map(C_WIDTH => 1,
   									    C_HAS_CE => 1)
								port map(D(0) => WE,
										 CLK => CLK,
										 CE => wece,
										 Q(0) => we_int);
   END GENERATE;
   we0 : IF (C_HAS_WE = 0) GENERATE
     we_int <= '1';
   END GENERATE;

   re1 : IF (C_HAS_RD_EN = 1) GENERATE
     re_reg : C_REG_FD_V4_0 generic map(C_WIDTH => 1,
   									    C_HAS_CE => 0)
								port map(D(0) => RD_EN,
										 CLK => CLK,
--										 CE => qspo_ce_int,
										 Q(0) => re_int);
   END GENERATE;
   re0 : IF (C_HAS_RD_EN = 0) GENERATE
     re_int <= '1';
   END GENERATE;                                              

   d1 : IF (C_HAS_D = 1) GENERATE
     d_reg : 	 C_REG_FD_V4_0 generic map(C_WIDTH => C_WIDTH,
     									   C_HAS_CE => 1)
								port map(D => D,
										 CLK => CLK,
										 CE => ice,
										 Q => d_int);
   END GENERATE;
   d0 : IF (C_HAS_D = 0) GENERATE
     d_int <= (OTHERS => 'X');
   END GENERATE;
						
 END GENERATE;

 -- Optional DP Read Address and QDPO_CE registers
 
 -- No Registers!
 dpra_reg0: IF (C_REG_DPRA_INPUT = 0) GENERATE

   dpra1 : IF (C_HAS_DPRA = 1) GENERATE
     dpra_int <= DPRA;
   END GENERATE;
   dpra0 : IF (C_HAS_DPRA = 0) GENERATE
     dpra_int <= (OTHERS => 'X');
   END GENERATE;

   qdpo1 : IF (C_HAS_QDPO_CE = 1) GENERATE
     qdpo_ce_reg <= qdpo_ce_int;
   END GENERATE;
   qdpo0 : IF (C_HAS_QDPO_CE = 0 AND C_QCE_JOINED = 1) GENERATE
     qdpo_ce_reg <= qdpo_ce_int;
   END GENERATE;
   qdpo00 : IF (C_HAS_QDPO_CE = 0 AND C_QCE_JOINED = 0) GENERATE
     qdpo_ce_reg <= '1';
   END GENERATE;
   
 END GENERATE;

 -- There ARE Registers!
 dpra_reg1: IF (C_REG_DPRA_INPUT = 1) GENERATE

   dpra1 : IF (C_HAS_DPRA = 1) GENERATE
      dpra_reg : C_REG_FD_V4_0 generic map(C_WIDTH => C_ADDR_WIDTH,
    							  		   C_HAS_CE => 1)
    					   port map(D => DPRA,
    								CLK => doclk,
									CE => qdpo_ce_int,
    								Q => dpra_int);

   END GENERATE;
   dpra0 : IF (C_HAS_DPRA = 0) GENERATE
     dpra_int <= (OTHERS => 'X');
   END GENERATE;

   qdpo1 : IF (C_HAS_QDPO_CE = 1 or (C_QCE_JOINED = 1 AND C_REG_A_D_INPUTS = 0)) GENERATE
     qdpo1_reg : C_REG_FD_V4_0 generic map(C_WIDTH => 1,
    							  		   C_HAS_CE => 0)
    					   port map(D(0) => qdpo_ce_int,
    								CLK => doclk,
    								Q(0) => qdpo_ce_reg);

   END GENERATE;
   qdpo0 : IF (C_HAS_QDPO_CE = 0 AND C_REG_A_D_INPUTS = 1 AND C_HAS_QSPO_CE = 1 AND (C_MEM_TYPE = c_srl16 OR C_QCE_JOINED = 1)) GENERATE
     qdpo_ce_reg <= qspo_ce_reg;
   END GENERATE;
   qdpo00 : IF (C_HAS_QDPO_CE = 0 AND not(C_HAS_QSPO_CE = 1 AND (C_MEM_TYPE = c_srl16 OR C_QCE_JOINED = 1))) GENERATE
     qdpo_ce_reg <= '1';
   END GENERATE;
   
 END GENERATE;
 
 -- Optional Async Single Port Output
 soexc: IF (C_HAS_SPO = 0) GENERATE
   SPO <= (OTHERS => 'X');
 END GENERATE;
 soinc: IF (C_HAS_SPO = 1 AND C_MUX_TYPE = c_lut_based) GENERATE
   SPO <= spo_async;
 END GENERATE;
 soinc_buft : IF (C_HAS_SPO = 1 AND C_MUX_TYPE /= c_lut_based) GENERATE
   SPO <= spo_reg;
 END GENERATE;
 
 -- Optional Async Dual Port Output
 -- Only allowed for Dual port modules with lut based mux
 doexc: IF (C_HAS_DPO = 0 OR 
            C_MEM_TYPE /= c_dp_ram) GENERATE
   DPO <= (OTHERS => 'X');
 END GENERATE;
 doinc: IF (C_HAS_DPO = 1 AND
            C_MEM_TYPE = c_dp_ram AND C_MUX_TYPE = c_lut_based) GENERATE
   DPO <= dpo_async;
 END GENERATE;
 doinc_buft : IF (C_HAS_DPO = 1 AND C_MEM_TYPE = c_dp_ram AND C_MUX_TYPE /= c_lut_based) GENERATE
   DPO <= dpo_reg;
 END GENERATE;

 -- Optional registered outputs
 qspoexc: IF (C_HAS_QSPO = 0) GENERATE
   QSPO <= (OTHERS => 'X');
 END GENERATE;
 qdpoexc: IF (C_HAS_QDPO = 0) GENERATE
   QDPO <= (OTHERS => 'X');
 END GENERATE;
 
 -- Optional Pipe stages
 sporeg0: IF(pipe_stages < 2 AND C_MUX_TYPE = c_lut_based) GENERATE
 	spo_reg <= spo_async;
 END GENERATE;
 sporeg1: IF(pipe_stages > 1 AND C_MUX_TYPE = c_lut_based) GENERATE
   qspoinc: IF (C_HAS_QSPO = 1) GENERATE
     spo_pipe(0) <= spo_async; -- Input to pipeline
	 spo_reg <= spo_pipe(pipe_stages-1); -- Output from pipeline
     pipe_s: FOR i in 0 to pipe_stages - 2 GENERATE
	   pipe_s_reg : C_REG_FD_V4_0
             GENERIC MAP ( C_WIDTH => C_WIDTH,
                           C_HAS_CE => 1) 
             PORT MAP ( D => spo_pipe(i),
                        CLK => CLK,
                        CE => qspo_ce_reg,
                        Q => spo_pipe(i+1));
	 END GENERATE;
   END GENERATE;
 END GENERATE;
 sporeg2 : IF (pipe_stages = 0 AND C_MUX_TYPE /= c_lut_based) GENERATE
    spo_reg <= spo_buft;
 END GENERATE;
 sporeg3 : IF (pipe_stages = 1 AND C_MUX_TYPE /= c_lut_based) GENERATE
    pipe_s_reg : C_REG_FD_V4_0
         GENERIC MAP ( C_WIDTH => C_WIDTH,
                       C_HAS_CE => 0) 
         PORT MAP ( D => spo_buft,
                    CLK => CLK,
                    Q => spo_reg);
 END GENERATE;
 sporeg4 : IF (C_MUX_TYPE /= c_lut_based) GENERATE
    spo_buft <= spo_async after 1 ns;
 END GENERATE;

 dporeg0: IF(dpo_pipe_stages < 2 AND C_MUX_TYPE = c_lut_based) GENERATE
 	dpo_reg <= dpo_async;
 END GENERATE;
 dporeg1: IF(dpo_pipe_stages > 1 AND C_MUX_TYPE = c_lut_based) GENERATE
   qdpoinc: IF (C_HAS_QDPO = 1) GENERATE
     dpo_pipe(0) <= dpo_async; -- Input to pipeline
	 dpo_reg <= dpo_pipe(dpo_pipe_stages-1); -- Output from pipeline
     pipe_d: FOR i in 0 to dpo_pipe_stages - 2 GENERATE
	   pipe_d_reg : C_REG_FD_V4_0
             GENERIC MAP ( C_WIDTH => C_WIDTH,
                           C_HAS_CE => 1) 
             PORT MAP ( D => dpo_pipe(i),
                        CLK => doclk,
                        CE => qdpo_ce_reg,
                        Q => dpo_pipe(i+1));
     END GENERATE;
   END GENERATE;
 END GENERATE;
 dporeg2 : IF (pipe_stages = 0 AND C_MUX_TYPE /= c_lut_based) GENERATE
    dpo_reg <= dpo_buft;
 END GENERATE;
 dporeg3 : IF (pipe_stages = 1 AND C_MUX_TYPE /= c_lut_based) GENERATE
    pipe_d_reg : C_REG_FD_V4_0
         GENERIC MAP ( C_WIDTH => C_WIDTH,
                       C_HAS_CE => 0) 
         PORT MAP ( D => dpo_buft,
                    CLK => doclk,
                    Q => dpo_reg);
 END GENERATE;
 dporeg4 : IF (C_MUX_TYPE /= c_lut_based) GENERATE
    dpo_buft <= dpo_async after 1 ns;
 END GENERATE;
 	
 
 -- Optional Output register
 oreginc: IF (pipe_stages >= 0 OR dpo_pipe_stages >= 0) GENERATE
   qspoinc: IF (C_HAS_QSPO = 1) GENERATE
     pipe_s: C_REG_FD_V4_0
             GENERIC MAP ( C_WIDTH => C_WIDTH,
                           C_HAS_ACLR => C_HAS_QSPO_RST,
                           C_HAS_SCLR => C_HAS_QSPO_SRST,
                           C_HAS_CE => 1,
                           C_SYNC_ENABLE => C_SYNC_ENABLE) 
             PORT MAP ( D => spo_reg,
                        CLK => CLK,
                        CE => qspo_ce_reg,
                        ACLR => QSPO_RST_INT,
			SCLR => QSPO_SRST_INT,
                        Q => QSPO);
   END GENERATE;
   --Dual Port
   dp: IF (C_MEM_TYPE = c_dp_ram) GENERATE
     qdpoinc: IF (C_HAS_QDPO = 1) GENERATE
       pipe_d: C_REG_FD_V4_0
               GENERIC MAP ( C_WIDTH => C_WIDTH,
                           C_HAS_ACLR => C_HAS_QDPO_RST,
                           C_HAS_SCLR => C_HAS_QDPO_SRST,
                             C_HAS_CE => 1,
                             C_SYNC_ENABLE => C_SYNC_ENABLE) 
               PORT MAP ( D => dpo_reg,
                          CLK => doclk,
                          CE => qdpo_ce_reg,
                        ACLR => QDPO_RST_INT,
			SCLR => QDPO_SRST_INT,
                          Q => QDPO);
     END GENERATE;
   END GENERATE;
 END GENERATE;
 
-- Core Memory process
 PROCESS (CLK, a_int, we_int, spra_int, dpra_int, d_int, re_int)
--   
   CONSTANT mem_bits   : INTEGER := C_DEPTH * C_WIDTH;
   VARIABLE memdvect   : STD_LOGIC_VECTOR(mem_bits-1 DOWNTO 0);
   VARIABLE bits_good  : BOOLEAN;
   VARIABLE lineno     : INTEGER := 0;
   VARIABLE offset     : INTEGER := 0;
   VARIABLE def_data   : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
   VARIABLE startup    : BOOLEAN := TRUE;
   VARIABLE spo_tmp    : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
   VARIABLE dpo_tmp    : STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);
   VARIABLE srl_start  : INTEGER := 0;
   VARIABLE srl_end    : INTEGER := 0;
--		

   FUNCTION add_std_logic_vec( arg1, arg2 : STD_LOGIC_VECTOR; size : INTEGER ) RETURN STD_LOGIC_VECTOR IS
     VARIABLE S   : STD_LOGIC_VECTOR(size-1 DOWNTO 0) := (OTHERS=>'0');
     VARIABLE C   : STD_LOGIC_VECTOR(size-1 DOWNTO 0) := (OTHERS=>'0');
     VARIABLE A   : STD_LOGIC;
     VARIABLE B   : STD_LOGIC;
   BEGIN
   	 FOR i IN 0 TO size-2 LOOP
       IF( i < arg1'LENGTH ) THEN
         A := arg1(i);
       ELSE
         A := '0';
       END IF;
       IF( i < arg2'LENGTH ) THEN
         B := arg2(i);
       ELSE
         B := '0';
       END IF;
       S(i)   := A XOR B;
       C(i+1) := (A AND B) OR (S(i) AND C(i));
       S(i)   := S(i) XOR C(i);
     END LOOP;
     RETURN S;
   END add_std_logic_vec;
-- 
   FUNCTION mul_std_logic_vec( arg1, arg2 : STD_LOGIC_VECTOR; size : INTEGER ) RETURN STD_LOGIC_VECTOR IS
     VARIABLE M   : STD_LOGIC_VECTOR(size-1 DOWNTO 0) := (OTHERS=>'0');
     VARIABLE A   : STD_LOGIC_VECTOR(size-1 DOWNTO 0);
   BEGIN
     FOR i IN 0 TO arg2'LENGTH-1 LOOP
       IF arg2(i) = '1' THEN
         A := (OTHERS=>'0');
         FOR j IN 0 TO arg1'LENGTH-1 LOOP
           IF( i+j < size ) THEN
             A(i+j) := arg1(j);
           END IF;
         END LOOP;
         M := add_std_logic_vec( M, A, size );
       END IF;
     END LOOP;
     RETURN M;
   END mul_std_logic_vec;
--
   FUNCTION decstr_to_std_logic_vec( arg1 : STRING; size : INTEGER ) RETURN STD_LOGIC_VECTOR IS
     VARIABLE RESULT : STD_LOGIC_VECTOR(size-1 DOWNTO 0):= (OTHERS=>'0');
     VARIABLE BIN    : STD_LOGIC_VECTOR(3 DOWNTO 0);
     CONSTANT TEN    : STD_LOGIC_VECTOR(3 DOWNTO 0) := (3=>'1', 1=>'1', OTHERS=>'0');
     VARIABLE MULT10 : STD_LOGIC_VECTOR(size-1 DOWNTO 0) := std_logic_vector(to_unsigned(1, size));
     VARIABLE MULT   : STD_LOGIC_VECTOR(size-1 DOWNTO 0);
   BEGIN 
     FOR i IN arg1'REVERSE_RANGE LOOP
       CASE arg1(i) IS
         WHEN '0' => BIN := (OTHERS=>'0');
         WHEN '1' => BIN := (0=>'1', OTHERS=>'0');
         WHEN '2' => BIN := (1=>'1', OTHERS=>'0');
         WHEN '3' => BIN := (0=>'1', 1=>'1', OTHERS=>'0');
         WHEN '4' => BIN := (2=>'1', OTHERS=>'0');
         WHEN '5' => BIN := (0=>'1', 2=>'1', OTHERS=>'0');
         WHEN '6' => BIN := (1=>'1', 2=>'1', OTHERS=>'0');
         WHEN '7' => BIN := (3=>'0', OTHERS=>'1');
         WHEN '8' => BIN := (3=>'1', OTHERS=>'0');
         WHEN '9' => BIN := (0=>'1', 3=>'1', OTHERS=>'0');
         WHEN OTHERS =>
           ASSERT FALSE 
             REPORT "NOT A DECIMAL CHARACTER" SEVERITY ERROR;
           RESULT := (OTHERS=>'X');
           RETURN RESULT;
       END CASE;
       MULT := mul_std_logic_vec( MULT10, BIN, size);
       RESULT := add_std_logic_vec( RESULT, MULT, size);
       MULT10 := mul_std_logic_vec( MULT10, TEN, size ); 
     END LOOP;
     RETURN RESULT;
   END decstr_to_std_logic_vec;
--
   FUNCTION binstr_to_std_logic_vec( arg1 : STRING; size : INTEGER ) RETURN STD_LOGIC_VECTOR IS
     VARIABLE RESULT : STD_LOGIC_VECTOR(size-1 DOWNTO 0):= (OTHERS=>'0');
     VARIABLE INDEX : INTEGER := 0;
   BEGIN
     FOR i IN arg1'REVERSE_RANGE LOOP
       CASE arg1(i) IS
         WHEN '0' => RESULT(INDEX) := '0';
         WHEN '1' => RESULT(INDEX) := '1';
         WHEN OTHERS =>
           ASSERT FALSE
             REPORT "NOT A BINARY CHARACTER" SEVERITY ERROR;
           RESULT(INDEX) := 'X';
       END CASE;
       INDEX := INDEX + 1;
     END LOOP;
     RETURN RESULT;
   END binstr_to_std_logic_vec; 
--
   FUNCTION hexstr_to_std_logic_vec( arg1 : STRING; size : INTEGER ) RETURN STD_LOGIC_VECTOR IS
     VARIABLE RESULT : STD_LOGIC_VECTOR(size-1 DOWNTO 0):= (OTHERS=> '0');
     VARIABLE BIN : STD_LOGIC_VECTOR(3 DOWNTO 0);
     VARIABLE INDEX : INTEGER := 0;
   BEGIN
     FOR i IN arg1'REVERSE_RANGE LOOP
       CASE arg1(i) IS
         WHEN '0' => BIN := (OTHERS=>'0');
         WHEN '1' => BIN := (0=>'1', OTHERS=>'0');
         WHEN '2' => BIN := (1=>'1', OTHERS=>'0');
         WHEN '3' => BIN := (0=>'1', 1=>'1', OTHERS=>'0');
         WHEN '4' => BIN := (2=>'1', OTHERS=>'0');
         WHEN '5' => BIN := (0=>'1', 2=>'1', OTHERS=>'0');
         WHEN '6' => BIN := (1=>'1', 2=>'1', OTHERS=>'0');
         WHEN '7' => BIN := (3=>'0', OTHERS=>'1');
         WHEN '8' => BIN := (3=>'1', OTHERS=>'0');
         WHEN '9' => BIN := (0=>'1', 3=>'1', OTHERS=>'0');
         WHEN 'A' => BIN := (0=>'0', 2=>'0', OTHERS=>'1');
         WHEN 'a' => BIN := (0=>'0', 2=>'0', OTHERS=>'1');
         WHEN 'B' => BIN := (2=>'0', OTHERS=>'1');
         WHEN 'b' => BIN := (2=>'0', OTHERS=>'1');
         WHEN 'C' => BIN := (0=>'0', 1=>'0', OTHERS=>'1');
         WHEN 'c' => BIN := (0=>'0', 1=>'0', OTHERS=>'1');
         WHEN 'D' => BIN := (1=>'0', OTHERS=>'1');
         WHEN 'd' => BIN := (1=>'0', OTHERS=>'1');
         WHEN 'E' => BIN := (0=>'0', OTHERS=>'1');
         WHEN 'e' => BIN := (0=>'0', OTHERS=>'1');
         WHEN 'F' => BIN := (OTHERS=>'1');
         WHEN 'f' => BIN := (OTHERS=>'1');
         WHEN OTHERS =>
           ASSERT FALSE
             REPORT "NOT A HEX CHARACTER" SEVERITY ERROR;
           FOR j IN 0 TO 3 LOOP
               BIN(j) := 'X';
           END LOOP;
       END CASE;
       FOR j IN 0 TO 3 LOOP
         IF (INDEX*4)+j < size THEN
           RESULT((INDEX*4)+j) := BIN(j);
         END IF;
       END LOOP;
       INDEX := INDEX + 1;
     END LOOP;
     RETURN RESULT;	
   END hexstr_to_std_logic_vec;
--
 BEGIN
 
 -- Startup section reads and/or writes mif file if necessary.
 
   IF (startup) THEN
     def_data(C_WIDTH-1 DOWNTO 0) := (OTHERS=>'0');
     CASE radix IS
       WHEN	 3 =>
         def_data := decstr_to_std_logic_vec(C_DEFAULT_DATA, C_WIDTH);
       WHEN      2 => 
         def_data := binstr_to_std_logic_vec(C_DEFAULT_DATA, C_WIDTH);
       WHEN      1 => 
         def_data := hexstr_to_std_logic_vec(C_DEFAULT_DATA, C_WIDTH);
       WHEN OTHERS =>  
         ASSERT FALSE
           REPORT "BAD DATA RADIX" SEVERITY ERROR;
     END CASE;

     IF( C_READ_MIF = 1 ) THEN
       read_meminit_file(C_MEM_INIT_FILE, C_DEPTH, C_WIDTH, memdvect, lineno);
     END IF;
     offset := lineno*C_WIDTH;
     WHILE (lineno < C_DEPTH) LOOP
       FOR i IN 0 TO C_WIDTH-1 LOOP
         memdvect(offset+i) := def_data(i);
       END LOOP;
       lineno := lineno+1;
       offset := offset+C_WIDTH;
     END LOOP;
     spo_tmp := (OTHERS => '0');
     dpo_tmp := (OTHERS => '0');
	 
     IF (C_GENERATE_MIF = 1) THEN 
       write_meminit_file(C_MEM_INIT_FILE, C_DEPTH, C_WIDTH, memdvect, 0);
     END IF;
	 
     startup := FALSE;
   ELSE -- Normal operation 
   
	 -- Deal with good rising CLK edge...
	IF(((CLK'event AND rat(CLK) = '1' AND rat(CLK'LAST_VALUE) = '0') OR C_HAS_CLK = 0) 
		 AND C_MEM_TYPE /= c_rom) THEN

     IF (anyX(a_int) OR std_logic_vector_2_posint(a_int) < C_DEPTH) THEN
       IF (rat(we_int) = 'X') THEN
         ASSERT FALSE
           REPORT "Memory Hazard: Write enable is not defined at the active clock edge."
           SEVERITY WARNING;      
         IF (anyX(a_int)) THEN
           memdvect := (OTHERS => 'X');
         ELSE
           offset := std_logic_vector_2_posint(a_int)*C_WIDTH;
           IF (C_MEM_TYPE = c_srl16) THEN -- Shift the 'X' data into the SRL16s
		     IF (C_ADDR_WIDTH > 4) THEN
		       srl_start := std_logic_vector_2_posint(a_int);
			 ELSE 
			   srl_start := 0;
			 END IF;
			 srl_end := srl_start + 16;
			 IF srl_end > C_DEPTH THEN
			 	srl_end := C_DEPTH;
			 END IF;
             FOR i IN (srl_end*C_WIDTH)-1 DOWNTO ((srl_start+1)*C_WIDTH) LOOP
               	IF memdvect(i) /= memdvect(i-C_WIDTH) THEN
			   		memdvect(i) := 'X';
			 	END IF;
             END LOOP;
			 FOR i in ((srl_start+1)*C_WIDTH)-1 DOWNTO (srl_start*C_WIDTH) LOOP
			 	IF memdvect(i) /= d_int(i-(srl_start*C_WIDTH)) THEN
					memdvect(i) := 'X';
			 	END IF;
			 END LOOP;
			 
		   ELSE -- Non SRL16-based
	         FOR i IN offset TO (offset+C_WIDTH-1) LOOP
			 	IF memdvect(i) /= d_int(i-offset) THEN
					memdvect(i) := 'X';
			 	END IF;
   		     END LOOP;
           END IF;
         END IF;
       ELSIF (rat(we_int) = '1') THEN
         IF (anyX(a_int)) THEN
           ASSERT FALSE
             REPORT "Memory Hazard: Writing in a location when address is not defined."
             SEVERITY WARNING;      
           memdvect := (OTHERS => 'X');
         ELSE
           offset := std_logic_vector_2_posint(a_int)*C_WIDTH;
           IF (C_MEM_TYPE = c_srl16) THEN -- Shift the 'X' data into the SRL16s
		     IF (C_ADDR_WIDTH > 4) THEN
		       srl_start := std_logic_vector_2_posint(a_int(C_ADDR_WIDTH-1 downto 4) & "0000");
			 ELSE 
			   srl_start := 0;
			 END IF;
			 srl_end := srl_start + 16;
			 IF srl_end > C_DEPTH THEN
			 	srl_end := C_DEPTH;
			 END IF;
			 
             FOR i IN (srl_end*C_WIDTH)-1 DOWNTO ((srl_start+1)*C_WIDTH) LOOP
				memdvect(i) := memdvect(i-C_WIDTH);
             END LOOP;

			 memdvect(((srl_start+1)*C_WIDTH)-1 DOWNTO (srl_start*C_WIDTH)) := d_int;
			 
		   ELSE -- Non SRL16-based
	         --IF (C_MEM_TYPE = c_dp_ram AND a_int = dpra_int AND rat(we_int) = '1' AND qspo_ce_int = '1') THEN
             --   ASSERT FALSE
             --       REPORT "Memory Hazard: Reading and Writing to same dual port address!"
             --       SEVERITY WARNING;
             --END IF;
             FOR i IN offset TO (offset+C_WIDTH-1) LOOP
	             memdvect(i) := d_int(i-offset);
   		     END LOOP;
           END IF;
         END IF;
       END IF;
     ELSIF (std_logic_vector_2_posint(a_int) >= C_DEPTH) THEN
	 	assert FALSE
			report "Writing to out-of-range address!!"
			severity WARNING;
	 END IF;
   END IF;
	 -- Deal with POSSIBLE rising CLK edge...
	IF(((CLK'event AND 
	   ((rat(CLK) = '1' AND rat(CLK'LAST_VALUE) = 'X') OR
	   (rat(CLK) = 'X' AND rat(CLK'LAST_VALUE) = '0')))) 
		 AND C_MEM_TYPE /= c_rom) THEN

     IF (anyX(a_int) OR std_logic_vector_2_posint(a_int) < C_DEPTH) THEN
       IF (rat(we_int) = 'X') THEN
         ASSERT FALSE
           REPORT "Memory Hazard: Write enable is not defined at the active clock edge."
           SEVERITY WARNING;      
         IF (anyX(a_int)) THEN
           memdvect := (OTHERS => 'X');
         ELSE
           offset := std_logic_vector_2_posint(a_int)*C_WIDTH;

           IF (C_MEM_TYPE = c_srl16) THEN -- Shift the 'X' data into the SRL16s
		     IF (C_ADDR_WIDTH > 4) THEN
		       srl_start := std_logic_vector_2_posint(a_int(C_ADDR_WIDTH-1 downto 4) & "0000");
			 ELSE 
			   srl_start := 0;
			 END IF;
			 srl_end := srl_start + 16;
			 IF srl_end > C_DEPTH THEN
			 	srl_end := C_DEPTH;
			 END IF;
			 
             FOR i IN (srl_end*C_WIDTH)-1 DOWNTO ((srl_start+1)*C_WIDTH) LOOP
               	IF memdvect(i) /= memdvect(i-C_WIDTH) THEN
			   		memdvect(i) := 'X';
			 	END IF;
             END LOOP;
			 FOR i in ((srl_start+1)*C_WIDTH)-1 DOWNTO (srl_start*C_WIDTH) LOOP
			 	IF memdvect(i) /= d_int(i-(srl_start*C_WIDTH)) THEN
					memdvect(i) := 'X';
			 	END IF;
			 END LOOP;
			 
		   ELSE -- Non SRL16-based
	         --IF (C_MEM_TYPE = c_dp_ram AND a_int = dpra_int AND rat(we_int) = '1' AND qspo_ce_int = '1') THEN
             --   ASSERT FALSE
             --       REPORT "Memory Hazard: Reading and Writing to same dual port address!"
             --       SEVERITY WARNING;
             --END IF;
             FOR i IN offset TO (offset+C_WIDTH-1) LOOP
			 	IF memdvect(i) /= d_int(i-offset) THEN
					memdvect(i) := 'X';
			 	END IF;
   		     END LOOP;
           END IF;

         END IF;
       ELSIF (rat(we_int) = '1') THEN
         IF (anyX(a_int)) THEN
           ASSERT FALSE
             REPORT "Memory Hazard: Writing in a location when address is not defined."
             SEVERITY WARNING;      
           memdvect := (OTHERS => 'X');
         ELSE
           offset := std_logic_vector_2_posint(a_int)*C_WIDTH;

           IF (C_MEM_TYPE = c_srl16) THEN -- Shift the 'X' data into the SRL16s
		     IF (C_ADDR_WIDTH > 4) THEN
		       srl_start := std_logic_vector_2_posint(a_int(C_ADDR_WIDTH-1 downto 4) & "0000");
			 ELSE 
			   srl_start := 0;
			 END IF;
			 srl_end := srl_start + 16;
			 IF srl_end > C_DEPTH THEN
			 	srl_end := C_DEPTH;
			 END IF;
			 
             FOR i IN (srl_end*C_WIDTH)-1 DOWNTO ((srl_start+1)*C_WIDTH) LOOP
               	IF memdvect(i) /= memdvect(i-C_WIDTH) THEN
			   		memdvect(i) := 'X';
			 	END IF;
             END LOOP;
			 FOR i in ((srl_start+1)*C_WIDTH)-1 DOWNTO (srl_start*C_WIDTH) LOOP
			 	IF memdvect(i) /= d_int(i-(srl_start*C_WIDTH)) THEN
					memdvect(i) := 'X';
			 	END IF;
			 END LOOP;
				
		   ELSE -- Non SRL16-based
	         --IF (C_MEM_TYPE = c_dp_ram AND a_int = dpra_int AND rat(we_int) = '1' AND qspo_ce_int = '1') THEN
             --   ASSERT FALSE
             --       REPORT "Memory Hazard: Reading and Writing to same dual port address!"
             --       SEVERITY WARNING;
             --END IF;
             FOR i IN offset TO (offset+C_WIDTH-1) LOOP
			 	IF memdvect(i) /= d_int(i-offset) THEN
					memdvect(i) := 'X';
			 	END IF;
   		     END LOOP;
           END IF;

         END IF;
       END IF;
     ELSIF (std_logic_vector_2_posint(a_int) >= C_DEPTH) THEN
	 	assert FALSE
			report "Writing to out-of-range address!!"
			severity WARNING;
	 END IF;

   END IF;
     -- Bad read enable signal
     IF (rat(re_int) = 'X') THEN
       spo_tmp := (OTHERS => 'X');
       dpo_tmp := (OTHERS => 'X');
	 
	 -- Good read enable signal  
     ELSIF (rat(re_int) = '1') THEN
	 
	   -- Bad address
       IF (anyX(spra_int)) THEN
         spo_tmp := (OTHERS => 'X');
		 
	   -- Good address
       ELSE
         offset := std_logic_vector_2_posint(spra_int);
         IF (offset < C_DEPTH) THEN
           offset := offset*C_WIDTH;
           FOR i IN 0 TO C_WIDTH-1 LOOP
             spo_tmp(i) := memdvect(offset+i);
           END LOOP;
         ELSIF (C_MUX_TYPE = c_buft_based) THEN
		   assert FALSE
		   		report "Reading from out-of-range address!"
				severity warning;
           spo_tmp := (OTHERS => 'H');
         ELSE
		   assert FALSE
		   		report "Reading from out-of-range address!"
				severity warning;
           spo_tmp := (OTHERS => '0');
         END IF;
       END IF;
	   -- Bad address
       IF (anyX(dpra_int)) THEN
         dpo_tmp := (OTHERS => 'X');

	   -- Good address
       ELSE
         offset := std_logic_vector_2_posint(dpra_int);
         IF (offset < C_DEPTH) THEN
           offset := offset*C_WIDTH;
           FOR i IN 0 TO C_WIDTH-1 LOOP
             dpo_tmp(i) := memdvect(offset+i);
           END LOOP;
         ELSIF (C_MUX_TYPE = c_buft_based) THEN
		    assert FALSE
	  		report "Reading from out-of-range address!"
			severity warning;
           dpo_tmp := (OTHERS => 'H');
         ELSE
		     assert FALSE
		   		report "Reading from out-of-range address!"
				severity warning;
           dpo_tmp := (OTHERS => '0');
         END IF;
       END IF;
    ELSE
       spo_tmp := (OTHERS => 'H');
        dpo_tmp := (OTHERS => 'H');
    END IF;

     spo_async <= spo_tmp;
     dpo_async <= dpo_tmp;
 END IF;
   
--
 END PROCESS;
--
END behavioral;
