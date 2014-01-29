------------------------------------------------------------------------------------------------------------------------
-- $Header: /devl/xcs/repo/env/Databases/ip/src2/L/tcc_decoder_3gpplte_v2_0/simulation/tcc_decoder_3gpplte_v2_0_comp.vhd,v 1.3 2009/09/08 16:13:40 akennedy Exp $
------------------------------------------------------------------------------------------------------------------------
--
--  (c) Copyright 2009 Xilinx, Inc. All rights reserved.
--
--  This file contains confidential and proprietary information
--  of Xilinx, Inc. and is protected under U.S. and
--  international copyright and other intellectual property
--  laws.
--
--  DISCLAIMER
--  This disclaimer is not a license and does not grant any
--  rights to the materials distributed herewith. Except as
--  otherwise provided in a valid license issued to you by
--  Xilinx, and to the maximum extent permitted by applicable
--  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
--  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
--  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
--  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
--  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
--  (2) Xilinx shall not be liable (whether in contract or tort,
--  including negligence, or under any other theory of
--  liability) for any loss or damage of any kind or nature
--  related to, arising under or in connection with these
--  materials, including for any direct, or any indirect,
--  special, incidental, or consequential loss or damage
--  (including loss of data, profits, goodwill, or any type of
--  loss or damage suffered as a result of any action brought
--  by a third party) even if such damage or loss was
--  reasonably foreseeable or Xilinx had been advised of the
--  possibility of the same.
--
--  CRITICAL APPLICATIONS
--  Xilinx products are not designed or intended to be fail-
--  safe, or for use in any application requiring fail-safe
--  performance, such as life-support or safety devices or
--  systems, Class III medical devices, nuclear facilities,
--  applications related to the deployment of airbags, or any
--  other applications that could lead to death, personal
--  injury, or severe property or environmental damage
--  (individually and collectively, "Critical
--  Applications"). Customer assumes the sole risk and
--  liability of any use of Xilinx products in Critical
--  Applications, subject only to applicable laws and
--  regulations governing limitations on product liability.
--
--  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
--  PART OF THIS FILE AT ALL TIMES.
--
-------------------------------------------------------------------------------
-- Component statement for behavioral model
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package tcc_decoder_3gpplte_v2_0_comp is

function GLB_max(a, b: integer) return integer;

--core_if on component tcc_decoder_3gpplte_v2_0
component tcc_decoder_3gpplte_v2_0
	generic (
		C_ELABORATION_DIR:      string:="./";                       --
		C_FAMILY:               string:="virtex5";                  --
		C_XDEVICEFAMILY:        string:="virtex5";                  --the family specific part
		C_COMPONENT_NAME:       string:="tcc_decoder_3gpplte_v2_0"; --
		C_NUM_DU:               integer:=8;                         --Number of decoding units (1, 2, 4 or 8)
		C_INPUT_FIFO_DEPTH:     integer:=8192;                      --Input FIFO depth in words (8192)
		C_TAG_WIDTH:            integer:=8;                         --Block tag width (0-32)
		C_ALGORITHM_TYPE:       integer:=1;                         --Algorithm (0->MAX 1->MAX-Scale 2->MAX*)
		C_STATE_INT_WIDTH:      integer:=9;                         --State metric integer bits (9)
		C_STATE_FRAC_WIDTH:     integer:=3;                         --State metric fractional bits (3)
		C_SOFT_INT_WIDTH:       integer:=5;                         --Soft bit integer bits (5)
		C_SOFT_FRAC_WIDTH:      integer:=3;                         --Soft bit fractional bits (3)
		C_NUM_DSP:              integer:=0;                         --Maximum number of DSPs to use (0-500)
		C_OPT_GOAL:             integer:=0;                         --Optimisation gola (0->balanced 1->speed)
		C_HAS_EXTRINSIC_INPUT:  integer:=0;                         --Has extrinsic input select (0->no 1->yes)
		C_HAS_EXTRINSIC_OUTPUT: integer:=0;                         --Has extrinsic output select (0->no 1->yes)
		C_NUM_PAR_INPUT_WORDS:  integer:=1;                         --Number of parallel input words (1 or 2)
		C_NUM_PAR_HD_WORDS:     integer:=1;                         --Number of parallel hard data output words (1, 8 or 32)
		C_NUM_PAR_EXT_WORDS:    integer:=1                          --Number of parallel extrinsic output words (1 or 4)
	);
	port (
		aclk:               in  std_logic:='0';
		areset:             in  std_logic:='0';

		mstat_wvalid:       out std_logic:='0';
		mstat_wdata:        out std_logic_vector(32-1 downto 0):=(others=>'0');
		mstat_wready:       in  std_logic:='0';

		sbin_wvalid:        in  std_logic:='0';
		sbin_wtag:          in  std_logic_vector(GLB_max(C_TAG_WIDTH-1,0) downto 0):=(others=>'0');
		sbin_wsize:         in  std_logic_vector(13-1 downto 0):=(others=>'0');
		sbin_witer:         in  std_logic_vector(4-1 downto 0):=(others=>'0');
		sbin_wflush:        in  std_logic:='0';
		sbin_whdreq:        in  std_logic:='0';
		sbin_wextreq:       in  std_logic:='0';
		sbin_wready:        out std_logic:='0';

		sdin_wvalid:        in  std_logic:='0';
		sdin_wlast:         in  std_logic:='0';
		sdin_wsys0:         in  std_logic_vector(C_SOFT_INT_WIDTH+C_SOFT_FRAC_WIDTH-1 downto 0):=(others=>'0');
		sdin_wp0:           in  std_logic_vector(C_SOFT_INT_WIDTH+C_SOFT_FRAC_WIDTH-1 downto 0):=(others=>'0');
		sdin_wpint0:        in  std_logic_vector(C_SOFT_INT_WIDTH+C_SOFT_FRAC_WIDTH-1 downto 0):=(others=>'0');
		sdin_wext0:         in  std_logic_vector(C_SOFT_INT_WIDTH+C_SOFT_FRAC_WIDTH-1 downto 0):=(others=>'0');
		sdin_wsys1:         in  std_logic_vector(C_SOFT_INT_WIDTH+C_SOFT_FRAC_WIDTH-1 downto 0):=(others=>'0');
		sdin_wp1:           in  std_logic_vector(C_SOFT_INT_WIDTH+C_SOFT_FRAC_WIDTH-1 downto 0):=(others=>'0');
		sdin_wpint1:        in  std_logic_vector(C_SOFT_INT_WIDTH+C_SOFT_FRAC_WIDTH-1 downto 0):=(others=>'0');
		sdin_wext1:         in  std_logic_vector(C_SOFT_INT_WIDTH+C_SOFT_FRAC_WIDTH-1 downto 0):=(others=>'0');
		sdin_wready:        out std_logic:='0';

		mhd_bout_wvalid:    out std_logic:='0';
		mhd_bout_wtag:      out std_logic_vector(GLB_max(C_TAG_WIDTH-1,0) downto 0):=(others=>'0');
		mhd_bout_wsize:     out std_logic_vector(13-1 downto 0):=(others=>'0');
		mhd_bout_wready:    in  std_logic:='0';

		mhd_dout_wvalid:    out std_logic:='0';
		mhd_dout_wlast:     out std_logic:='0';
		mhd_dout_wdata:     out std_logic_vector(C_NUM_PAR_HD_WORDS-1 downto 0):=(others=>'0');
		mhd_dout_wready:    in  std_logic:='0';

		mext_bout_wvalid:   out std_logic:='0';
		mext_bout_wtag:     out std_logic_vector(GLB_max(C_TAG_WIDTH-1,0) downto 0):=(others=>'0');
		mext_bout_wsize:    out std_logic_vector(13-1 downto 0):=(others=>'0');
		mext_bout_wready:   in  std_logic:='0';

		mext_dout_wvalid:   out std_logic:='0';
		mext_dout_wlast:    out std_logic:='0';
		mext_dout_wdata:    out std_logic_vector(C_NUM_PAR_EXT_WORDS*(C_SOFT_INT_WIDTH+C_SOFT_FRAC_WIDTH)-1 downto 0):=(others=>'0');
		mext_dout_wready:   in  std_logic:='0'
	);
  --core_if off
  end component;
  -- the following tells xst that tcc_decoder_3gpplte_v2_0 is a black box which
  -- should be generated command given by the value of this attribute
  -- Note the fully qualified SIM (JAVA class) name that forms the
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF tcc_decoder_3gpplte_v2_0 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF tcc_decoder_3gpplte_v2_0 : COMPONENT IS
    "generatecore com.xilinx.ip.tcc_decoder_3gpplte_v2_0.tcc_decoder_3gpplte_v2_0";
  -- xcc include

END tcc_decoder_3gpplte_v2_0_comp;

package body tcc_decoder_3gpplte_v2_0_comp is

  function GLB_max(a, b: integer) return integer is
  begin
    if (a>b) then return a; else return b; end if;
  end function;

end package body tcc_decoder_3gpplte_v2_0_comp;
