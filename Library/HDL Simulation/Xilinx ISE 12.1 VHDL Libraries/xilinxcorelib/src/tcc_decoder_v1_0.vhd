-------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------
-- $Header: /devl/xcs/repo/env/Databases/ip/src/com/xilinx/ip/tcc_decoder_v1_0/simulation/tcc_decoder_unobf_v1_0.vhd,v 1.13 2008/09/08 20:10:08 akennedy Exp $
--
-- Description: Turbo Convolutional Decoder Behavioral model.
--				Basically Dummy file to keep ROMS tests happy.
--				There must be a behavioral modfel for ROMS testing.
--
-- Author: David  Lawrie
-- April 2003
--
--------------------------------------------------------------------------------

LIBRARY IEEE;USE IEEE.STD_LOGIC_1164.ALL;PACKAGE TCC_DECODER_BEHV_PKG_V1_0 IS CONSTANT II1IOOO1II0l1lOl00I1O001I00O0IIIII:INTEGER:=20736
;CONSTANT IO1lll0I0l0l1ll1O01Ol0III011IOIIII:INTEGER:=4;CONSTANT IOO0111OO0lOOl10l1l000l0OlI0IIIIII:INTEGER:=4;FUNCTION
 IIlO1lIIlOlOOO0l10OI1ll0I0O10IIIII(IOOOlI0llOIl11IO01100OI1llOIIOIIII:INTEGER)RETURN INTEGER;END;PACKAGE BODY TCC_DECODER_BEHV_PKG_V1_0 IS FUNCTION
 IIlO1lIIlOlOOO0l10OI1ll0I0O10IIIII(IOOOlI0llOIl11IO01100OI1llOIIOIIII:INTEGER)RETURN INTEGER IS VARIABLE IO1IOOl1111OI1OOII1IOl0lIIIIOIIIII:NATURAL:=1;BEGIN FOR II1001IO0010Oll1I01lOI0I0IlIOIIIII IN 30 DOWNTO 0
 LOOP IF IOOOlI0llOIl11IO01100OI1llOIIOIIII>=2**II1001IO0010Oll1I01lOI0I0IlIOIIIII THEN IO1IOOl1111OI1OOII1IOl0lIIIIOIIIII:=II1001IO0010Oll1I01lOI0I0IlIOIIIII+1;EXIT;END IF;END LOOP;RETURN IO1IOOl1111OI1OOII1IOl0lIIIIOIIIII;END;END;LIBRARY IEEE;USE IEEE.STD_LOGIC_1164
.ALL;LIBRARY XILINXCORELIB;USE XILINXCORELIB.TCC_DECODER_BEHV_PKG_V1_0.ALL;ENTITY TCC_DECODER_V1_0 IS GENERIC(C_FAMILY:STRING:=
"virtex2";C_MEM_INIT_PREFIX:STRING;C_INPUT_INT_BITS:INTEGER;C_INPUT_FRAC_BITS:INTEGER;C_METRIC_INT_BITS:INTEGER;C_METRIC_FRAC_BITS:
INTEGER;C_WINDOW_SIZE:INTEGER;C_ALGORITHM_TYPE:INTEGER;C_MAX_BLOCK_SIZE:INTEGER:=II1IOOO1II0l1lOl00I1O001I00O0IIIII;
C_NUM_SIMULTANEOUS_BLOCKS:INTEGER;C_MEM_UNIT:INTEGER;C_PING_PONG:INTEGER;C_EXTERNAL_RAM:INTEGER;C_MEMSTYLE:INTEGER;C_ENABLE_RLOCS:
INTEGER;C_HAS_CE:INTEGER;C_HAS_ND:INTEGER;C_HAS_RD_RAM:INTEGER;C_HAS_IT_RDY:INTEGER;C_HAS_RDY:INTEGER;C_HAS_RFD:INTEGER;C_HAS_RFFD:
INTEGER;C_HAS_SCLR:INTEGER;C_HAS_ACLR:INTEGER);PORT(BLOCK_SIZE_SEL:IN STD_LOGIC_VECTOR(IO1lll0I0l0l1ll1O01Ol0III011IOIIII-1 DOWNTO 0);CLK
:IN STD_LOGIC;D_IN:IN STD_LOGIC_VECTOR(5*(C_INPUT_INT_BITS+C_INPUT_FRAC_BITS)-1 DOWNTO 0);FD:IN STD_LOGIC:='0';ITERATIONS:IN
 STD_LOGIC_VECTOR(IOO0111OO0lOOl10l1l000l0OlI0IIIIII-1 DOWNTO 0);ACLR:IN STD_LOGIC:='0';CE:IN STD_LOGIC:='0';ND:IN STD_LOGIC:='0';
RD_D_IN:IN STD_LOGIC_VECTOR(5*(C_INPUT_INT_BITS+C_INPUT_FRAC_BITS)-1 DOWNTO 0):=(OTHERS=>'0');SCLR:IN STD_LOGIC:='0';D_OUT:OUT
 STD_LOGIC;P_ADDR:OUT STD_LOGIC_VECTOR(IIlO1lIIlOlOOO0l10OI1ll0I0O10IIIII(C_MAX_BLOCK_SIZE*C_NUM_SIMULTANEOUS_BLOCKS-1)-1 DOWNTO 0);
S_ADDR:OUT STD_LOGIC_VECTOR(IIlO1lIIlOlOOO0l10OI1ll0I0O10IIIII(C_MAX_BLOCK_SIZE*C_NUM_SIMULTANEOUS_BLOCKS-1)-1 DOWNTO 0);IT_RDY:OUT
 STD_LOGIC;RDY:OUT STD_LOGIC;RFD:OUT STD_LOGIC;RFFD:OUT STD_LOGIC;WE:OUT STD_LOGIC;WR_D_OUT:OUT STD_LOGIC_VECTOR(5*(C_INPUT_INT_BITS
+C_INPUT_FRAC_BITS)-1 DOWNTO 0));END;ARCHITECTURE BEHAVIORAL OF TCC_DECODER_V1_0 IS BEGIN END;
