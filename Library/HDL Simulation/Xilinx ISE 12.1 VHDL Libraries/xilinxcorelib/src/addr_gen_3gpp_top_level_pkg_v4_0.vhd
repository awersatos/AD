--------------------------------------------------------------------------
-- Copyright(C) 2005 by Xilinx, Inc. All rights reserved. 
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
-- of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc. 
-- All rights reserved. 
--------------------------------------------------------------------------
-- $Header: /devl/xcs/repo/env/Databases/ip/src2/I/addr_gen_3gpp_v4_0/simulation/addr_gen_3gpp_top_level_pkg_v4_0.vhd,v 1.8 2008/09/08 19:36:25 akennedy Exp $
--
--  Title: tcc_encoder_top_level_pkg_v2_0.vhd
--  Author: Jeffrey Graham
--  Date  : Jun 2005
--  Description: Top Level 3gpp2 turbo encoder 
--                
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-------------------------------------------------------------------------------
PACKAGE addr_gen_3gpp_top_level_pkg_v4_0 IS

  CONSTANT ADDR_GEN_3GPP_TOP_LEVEL_PKG_c_family_default               : STRING  :="virtex2";
  CONSTANT ADDR_GEN_3GPP_TOP_LEVEL_PKG_c_elaboration_dir_default      : STRING  :="";
  CONSTANT ADDR_GEN_3GPP_TOP_LEVEL_PKG_c_component_name_default		  : STRING  :="addr_gen_3gpp_v4_0";
  CONSTANT ADDR_GEN_3GPP_TOP_LEVEL_PKG_c_mem_init_prefix_default      : STRING  :="addr_gen_3gpp_v4_0";
  CONSTANT ADDR_GEN_3GPP_TOP_LEVEL_PKG_c_has_ce_default               : INTEGER :=0;
  CONSTANT ADDR_GEN_3GPP_TOP_LEVEL_PKG_c_has_sclr_default             : INTEGER :=0;
  CONSTANT ADDR_GEN_3GPP_TOP_LEVEL_PKG_c_has_aclr_default             : INTEGER :=0;
  
END addr_gen_3gpp_top_level_pkg_v4_0;



