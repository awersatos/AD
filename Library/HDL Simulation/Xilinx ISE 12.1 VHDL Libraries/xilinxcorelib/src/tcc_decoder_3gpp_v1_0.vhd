-------------------------------------------------------------------------------
-- Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
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
-------------------------------------------------------------------------------
-- $Header: /devl/xcs/repo/env/Databases/ip/src/com/xilinx/ip/tcc_decoder_3gpp_v1_0/simulation/tcc_decoder_3gpp_unobf_v1_0.vhd,v 1.11 2008/09/08 20:10:02 akennedy Exp $
--
-- Description: Turbo Convolutional Decoder Behavioral model.
--				Basically Dummy file to keep ROMS tests happy.
--				There must be a behavioral modfel for ROMS testing.
--
-- Original Author: David Lawrie
-- April 2003
-- Modified for 3GPP : Stephen Creaney
-- June 2004
--
--------------------------------------------------------------------------------

LIBRARY IEEE;USE IEEE.STD_LOGIC_1164.ALL;PACKAGE TCC_DECODER_3GPP_BEHV_PKG_V1_0 IS CONSTANT II1IOOO1II0l1lOl00I1O001I00O0IIIII:INTEGER:=5114;CONSTANT
 IO1lll0I0l0l1ll1O01Ol0III011IOIIII:INTEGER:=6;CONSTANT IOO0111OO0lOOl10l1l000l0OlI0IIIIII:INTEGER:=13;CONSTANT IIlO1lIIlOlOOO0l10OI1ll0I0O10IIIII:
INTEGER:=4;CONSTANT IOOOlI0llOIl11IO01100OI1llOIIOIIII:INTEGER:=3;CONSTANT IO1IOOl1111OI1OOII1IOl0lIIIIOIIIII:INTEGER:=0;CONSTANT II1001IO0010Oll1I01lOI0I0IlIOIIIII:INTEGER:=1;
CONSTANT IO110I1O0010OIOlIO00l1IIOl0llIIIII:INTEGER:=2;CONSTANT IIIOOIO01011011IOIIlllIIOO0l1IIIII:INTEGER:=1;FUNCTION II1IOOO00I0OI0O01I000O100llOOIIIII(II00OI0110lI1II101lO1OO00I10OIIIII:
INTEGER)RETURN INTEGER;END;PACKAGE BODY TCC_DECODER_3GPP_BEHV_PKG_V1_0 IS FUNCTION II1IOOO00I0OI0O01I000O100llOOIIIII(II00OI0110lI1II101lO1OO00I10OIIIII:INTEGER
)RETURN INTEGER IS VARIABLE II00OIlIlO101I0IIOO0O1I0ll0OIIIIII:NATURAL:=1;BEGIN FOR IOOI1l1OO01O111lO010OlO1O0l0IIIIII IN 30 DOWNTO 0 LOOP IF II00OI0110lI1II101lO1OO00I10OIIIII>=2**IOOI1l1OO01O111lO010OlO1O0l0IIIIII THEN II00OIlIlO101I0IIOO0O1I0ll0OIIIIII:=IOOI1l1OO01O111lO010OlO1O0l0IIIIII+1;EXIT;END
 IF;END LOOP;RETURN II00OIlIlO101I0IIOO0O1I0ll0OIIIIII;END;END;LIBRARY IEEE;USE IEEE.STD_LOGIC_1164.ALL;LIBRARY WORK;USE WORK.
TCC_DECODER_3GPP_BEHV_PKG_V1_0.ALL;ENTITY TCC_DECODER_3GPP_V1_0 IS GENERIC(C_ALGORITHM_TYPE:INTEGER;C_EXTERNAL_RAM:INTEGER;
C_ENABLE_RLOCS:INTEGER;C_EXT_INTERLEAVER:INTEGER;C_FAMILY:STRING:="virtex2";C_HAS_ACLR:INTEGER;C_HAS_CE:INTEGER;C_HAS_EXTRINSIC_OP:
INTEGER:=0;C_HAS_FAST_TERM:INTEGER;C_HAS_IT_RDY:INTEGER;C_HAS_ND:INTEGER;C_HAS_RDY:INTEGER:=1;C_HAS_RFD:INTEGER;C_HAS_RFFD:INTEGER
:=1;C_HAS_SCLR:INTEGER;C_HAS_SISO_COUNT:INTEGER:=0;C_HAS_SISO_RDY:INTEGER:=0;C_INPUT_FRAC_BITS:INTEGER;C_INPUT_INT_BITS:INTEGER;
C_INTLV_LATENCY:INTEGER;C_MAX_BLOCK_SIZE:INTEGER:=II1IOOO1II0l1lOl00I1O001I00O0IIIII;C_MEM_INIT_PREFIX:STRING:="tccd3gpp";C_MEM_UNIT:INTEGER;
C_MEMSTYLE:INTEGER:=II1001IO0010Oll1I01lOI0I0IlIOIIIII;C_METRIC_FRAC_BITS:INTEGER;C_METRIC_INT_BITS:INTEGER;C_NUM_SIMULTANEOUS_BLOCKS:INTEGER:=1;
C_OPTIMIZATION:INTEGER;C_PARITY_PER_RSC:INTEGER;C_RAM_LATENCY:INTEGER:=1;C_WINDOW_SIZE:INTEGER);PORT(CLK:IN STD_LOGIC;FD:IN
 STD_LOGIC;BLOCK_SIZE:IN STD_LOGIC_VECTOR(II1IOOO00I0OI0O01I000O100llOOIIIII(C_MAX_BLOCK_SIZE)-1 DOWNTO 0);ITERATIONS:IN
 STD_LOGIC_VECTOR(IIlO1lIIlOlOOO0l10OI1ll0I0O10IIIII-1 DOWNTO 0);ACLR:IN STD_LOGIC:='0';SCLR:IN STD_LOGIC:='0';CE:IN STD_LOGIC:='0'
;ND:IN STD_LOGIC:='0';D_IN:IN STD_LOGIC_VECTOR((2*C_PARITY_PER_RSC+1)*(C_INPUT_INT_BITS+C_INPUT_FRAC_BITS)-1 DOWNTO 0):=(OTHERS=>'0'
);INTLV_ADDR:IN STD_LOGIC_VECTOR(II1IOOO00I0OI0O01I000O100llOOIIIII(C_MAX_BLOCK_SIZE+IO1lll0I0l0l1ll1O01Ol0III011IOIIII-1)-1 DOWNTO 0):=(OTHERS
=>'0');RD_D_IN:IN STD_LOGIC_VECTOR((2*C_PARITY_PER_RSC+1)*(C_INPUT_INT_BITS+C_INPUT_FRAC_BITS)-1 DOWNTO 0):=(OTHERS=>'0');FT_THRESH
:IN STD_LOGIC_VECTOR(IOOOlI0llOIl11IO01100OI1llOIIOIIII-1 DOWNTO 0):=(OTHERS=>'0');D_OUT:OUT STD_LOGIC;INTLV_FD:OUT STD_LOGIC;INTLV_CE:OUT
 STD_LOGIC;RFD:OUT STD_LOGIC;RFFD:OUT STD_LOGIC;RDY:OUT STD_LOGIC;IT_RDY:OUT STD_LOGIC;SISO_RDY:OUT STD_LOGIC;FT_ACTIVE:OUT
 STD_LOGIC;SISO_COUNT:OUT STD_LOGIC_VECTOR(IIlO1lIIlOlOOO0l10OI1ll0I0O10IIIII DOWNTO 0);EXTRINSIC_OUT:OUT STD_LOGIC_VECTOR(
C_METRIC_INT_BITS+C_METRIC_FRAC_BITS-2 DOWNTO 0);EXTRINSIC_ADDR:OUT STD_LOGIC_VECTOR(II1IOOO00I0OI0O01I000O100llOOIIIII(
C_MAX_BLOCK_SIZE+IO1lll0I0l0l1ll1O01Ol0III011IOIIII-1)-1 DOWNTO 0);EXTRINSIC_WE:OUT STD_LOGIC;P_ADDR:OUT STD_LOGIC_VECTOR(
II1IOOO00I0OI0O01I000O100llOOIIIII((C_MAX_BLOCK_SIZE+IO1lll0I0l0l1ll1O01Ol0III011IOIIII)*C_NUM_SIMULTANEOUS_BLOCKS-1)-1 DOWNTO 0);S_ADDR:OUT
 STD_LOGIC_VECTOR(II1IOOO00I0OI0O01I000O100llOOIIIII((C_MAX_BLOCK_SIZE+IO1lll0I0l0l1ll1O01Ol0III011IOIIII)*C_NUM_SIMULTANEOUS_BLOCKS-1)-1
 DOWNTO 0);BLOCK_SELECT:OUT STD_LOGIC;WE:OUT STD_LOGIC;WR_D_OUT:OUT STD_LOGIC_VECTOR((2*C_PARITY_PER_RSC+1)*(C_INPUT_INT_BITS+
C_INPUT_FRAC_BITS)-1 DOWNTO 0));END;ARCHITECTURE BEHAVIORAL OF TCC_DECODER_3GPP_V1_0 IS BEGIN END;
